Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0926E94B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 01:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIQXN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 19:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgIQXN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 19:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600384437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IZMOFHDfDgqgBMZv+C4q9OSWQXJrKtdRyzz00lZbe4=;
        b=YG3UrHPvwY3xaqS0HB38l8IdM0VyuDAMtmEecDk9NaNBxbi6glWHBMKBVFBy//i7fZkRiY
        Dk7ihrKVdVpMzPJYma6IFqTu2A9lAcMjN0FupalQ2mKt622X/vYPSALrLVkDGRz/feSSp6
        TuW5r3RlFK53uo+v3Zuwav1ScSGxxrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-M4VA2YllOCWBMzXqqOnuOQ-1; Thu, 17 Sep 2020 19:13:52 -0400
X-MC-Unique: M4VA2YllOCWBMzXqqOnuOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3885864085;
        Thu, 17 Sep 2020 23:13:51 +0000 (UTC)
Received: from T590 (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F0D160BEC;
        Thu, 17 Sep 2020 23:13:39 +0000 (UTC)
Date:   Fri, 18 Sep 2020 07:13:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        minlei@redhat.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200917231335.GB1139137@T590>
References: <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
 <20200825004203.GJ12131@dread.disaster.area>
 <20200825144917.GA321765@bfoster>
 <20200916001242.GE7955@magnolia>
 <20200916084510.GA30815@infradead.org>
 <20200916130714.GA1681377@bfoster>
 <20200917080455.GY26262@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917080455.GY26262@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:04:55AM +0100, Christoph Hellwig wrote:
> On Wed, Sep 16, 2020 at 09:07:14AM -0400, Brian Foster wrote:
> > Dave described the main purpose earlier in this thread [1]. The initial
> > motivation is that we've had downstream reports of soft lockup problems
> > in writeback bio completion down in the bio -> bvec loop of
> > iomap_finish_ioend() that has to finish writeback on each individual
> > page of insanely large bios and/or chains. We've also had an upstream
> > reports of a similar problem on linux-xfs [2].
> > 
> > The magic number itself was just pulled out of a hat. I picked it
> > because it seemed conservative enough to still allow large contiguous
> > bios (1GB w/ 4k pages) while hopefully preventing I/O completion
> > problems, but was hoping for some feedback on that bit if the general
> > approach was acceptable. I was also waiting for some feedback on either
> > of the two users who reported the problem but I don't think I've heard
> > back on that yet...
> 
> I think the saner answer is to always run large completions in the
> workqueue, and add a bunch of cond_resched() calls, rather than
> arbitrarily breaking up the I/O size.

Completion all ioend pages in single bio->end_bio() may pin too many pages
unnecessary long, and adding cond_resched() can make the issue worse.


thanks,
Ming

