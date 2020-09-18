Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8F26FDD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIRNJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 09:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgIRNJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600434564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5B00TpLV9MuFHIh5wpo0AG7OxXn8VMiQgbyCHmPoFsw=;
        b=QeadkUPdUmPvgugb2j6XYZf/W5Q+fUvfXUaBSFjDHm+ar7vqmwHzsY+t49zGvhJxo//j0t
        m7Gzmp4PbdUDfi2vpPpvqZpc6HPRz63BpMW4L6NdpOOYhNsR4Fe1VphiaS76cUEeP/ejte
        oTsQzEZ/RikdIOivhoEGxbvYeuK2qTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-mTl8sP_ZO4CBKw9EoTdE-A-1; Fri, 18 Sep 2020 09:09:20 -0400
X-MC-Unique: mTl8sP_ZO4CBKw9EoTdE-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8859E57052;
        Fri, 18 Sep 2020 13:09:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with SMTP id D37D273660;
        Fri, 18 Sep 2020 13:09:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 18 Sep 2020 15:09:18 +0200 (CEST)
Date:   Fri, 18 Sep 2020 15:09:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     peterz@infradead.org
Cc:     Jan Kara <jack@suse.cz>, Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918130914.GA26777@redhat.com>
References: <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
 <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
 <20200918101216.GL35926@hirez.programming.kicks-ass.net>
 <20200918104824.GA23469@redhat.com>
 <20200918110310.GO1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918110310.GO1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/18, Peter Zijlstra wrote:
>
> On Fri, Sep 18, 2020 at 12:48:24PM +0200, Oleg Nesterov wrote:
>
> > Of course, this assumes that atomic_t->counter underflows "correctly", just
> > like "unsigned int".
>
> We're documented that we do. Lots of code relies on that.
>
> See Documentation/atomic_t.txt TYPES

Aha, thanks!

> > But again, do we really want this?
>
> I like the two counters better, avoids atomics entirely, some archs
> hare horridly expensive atomics (*cough* power *cough*).

I meant... do we really want to introduce percpu_up_read_irqsafe() ?

Perhaps we can live with the fix from Hou? At least until we find a
"real" performance regression.

Oleg.

