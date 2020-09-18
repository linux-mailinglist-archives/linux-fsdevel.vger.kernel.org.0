Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367BA26FA29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIRKMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 06:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgIRKM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:12:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7EBC06174A;
        Fri, 18 Sep 2020 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2l+gXFpnZHzuk7NSeFYdJJ/yNRYkbW64rAwKN3DxjKA=; b=jUzYMtaK5+GrJ9HNVahLDOhK/8
        Rrp7tSho8cuH9+dL3+KG/BYAl3UEvh6zbmhgpfWUWJqgMoLZdCejGZMhcaWVEkgCzQy52+tQpgF+0
        HAd7wLoDUcxYCh+l6m0pKFFbXd4jL8vfddR20nDQUYsM3e2wA0rj3ryFrcO3jvLbMg0/VTEprwSIh
        hJGsxZvM6rQStB8BJjTVWtlUc1GCADL1m7F5dhpn89M2DZ+oMQLCfl0RXq9uPu8dPwT0c1bLv+cs4
        NAmRB8kMfsQO6U80S19CDuzvl+Baa9GL2prfUPen9nU76dGRwFurDanmpGwyHQJvnE7V41r4Pk4Tq
        QSCX+uhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJDNL-0004Cy-Ki; Fri, 18 Sep 2020 10:12:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C846303A02;
        Fri, 18 Sep 2020 12:12:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD69620D4DC9F; Fri, 18 Sep 2020 12:12:16 +0200 (CEST)
Date:   Fri, 18 Sep 2020 12:12:16 +0200
From:   peterz@infradead.org
To:     Jan Kara <jack@suse.cz>
Cc:     Oleg Nesterov <oleg@redhat.com>, Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918101216.GL35926@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
 <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:01:12PM +0200, peterz@infradead.org wrote:
> +	u64 sum = per_cpu_sum(*(u64 *)sem->read_count);

Moo, that doesn't work, we have to do two separate sums. I shouldn't try
to be clever on a Friday I suppose :-(
