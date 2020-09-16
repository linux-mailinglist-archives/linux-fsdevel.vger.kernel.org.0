Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33526C893
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgIPSxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgIPSIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:08:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D9C0A8891;
        Wed, 16 Sep 2020 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PHSmocSTx2CTgXVGt4QCFFureAzLtVyh1W7SKpBbobA=; b=BiaPO8fQHpw/cGxYNRW32uFx0K
        9j9zojyZYlXl8zpf5oejBkBrIgv5P9JhWY47qIEW3H81J1eL+Iz6b/KyyLexJJrnNqDy7g1xdK+9H
        jNnX7L1YurAwHCue5yjJ/KuU9J7wEtKMLGp4iKkAHcc+PZKbD85IA+ueQammgVoDp0Js7/np1jPv8
        ImM7adAAN6qC0w2rBKJH1XF3CVrbxH1CrhsgBunH8DDlLdijpOtO++hQp6ikm6HbVN/ZPQLZHmTbh
        TAED4Jy+z00+li1QAWjioVcEeXL32/XVItvk+hMDiI+SQCD6aqnKAEc1hyidsppVQ315oVKxWAC3n
        LHCSZllA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIWu9-0001Pv-GS; Wed, 16 Sep 2020 12:51:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C815F3012C3;
        Wed, 16 Sep 2020 14:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DE1C2B9285C9; Wed, 16 Sep 2020 14:51:17 +0200 (CEST)
Date:   Wed, 16 Sep 2020 14:51:17 +0200
From:   peterz@infradead.org
To:     Hou Tao <houtao1@huawei.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200916125117.GQ2674@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 08:32:20PM +0800, Hou Tao wrote:

> I have simply test the performance impact on both x86 and aarch64.
> 
> There is no degradation under x86 (2 sockets, 18 core per sockets, 2 threads per core)

Yeah, x86 is magical here, it's the same single instruction for both ;-)
But it is, afaik, unique in this position, no other arch can pull that
off.

> However the performance degradation is huge under aarch64 (4 sockets, 24 core per sockets): nearly 60% lost.
> 
> v4.19.111
> no writer, reader cn                               | 24        | 48        | 72        | 96
> the rate of down_read/up_read per second           | 166129572 | 166064100 | 165963448 | 165203565
> the rate of down_read/up_read per second (patched) |  63863506 |  63842132 |  63757267 |  63514920

Teh hurt :/
