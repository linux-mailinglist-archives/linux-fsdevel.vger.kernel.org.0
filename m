Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6849276A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiARNr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:47:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbiARNr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642513678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pjtxi7RqCOzG980gOImaPYpuRa/0jydsSGVWCWHzEsQ=;
        b=eAiYhzxovnlTT3vzIpt0Tbn/3Ya8/OGNCjS3jxwMj1qOo4N4iOyg/HmuM2MBIM+dChUqE3
        hfj3VpdY/uHY2VgtlwoLMwJH09U4G2rYrZY5oW+wV5u03oWcbKX8uR3OwRab4nGKCNSLPW
        ngEm49vZVsbh1+DbmOUck5+iJTRBzwo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-klbmPmWyNlW5wR5cT3RFgw-1; Tue, 18 Jan 2022 08:47:57 -0500
X-MC-Unique: klbmPmWyNlW5wR5cT3RFgw-1
Received: by mail-qv1-f70.google.com with SMTP id hu4-20020a056214234400b0041ad4e40960so13187902qvb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 05:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pjtxi7RqCOzG980gOImaPYpuRa/0jydsSGVWCWHzEsQ=;
        b=kHPZ7RMQxv4/PZf+xBVEEXbZkBiN1GwQ42QF3OOgawMzaXyVJvhT3hrcPodXEEnXDg
         FtNlOTFxpSJpW9sRduPaPil7N7K9lXDrQXgQMpHLsYrtA//eI/k7+rNgn45jT7hoTvft
         n4QYJaCv5daRQ7jT1ouIMOkFPcxgCvRG0DKPaC6GtjI7JrfdPwPk5QY3nH1mDBqbTP2f
         xElCgMO35ik49k6bQ9fV0XCpjGVY07f1GfwXBvce/D7NjMwrVb5inuWqKafi23wiHFUj
         juf2gnmPkWb5LFCZW+6C1AaozPRaqta2r+Y7ANnQVzDxRcedkNS0LQSyx+qH4iW9Ttge
         ff2w==
X-Gm-Message-State: AOAM531440WY4gciJpNQdDUP1iFCQ2RyzwzoNtufojGKy5YfP4YEo8l2
        ozr9QPrOuM41/DOAAW+PPBE+HnM4VnQPs33vKaUDjEKk2DVU9d64/y1dmLZvjKPitYbLsbcD2YG
        ddK2aPMpxLbpXhnsrqJInNcRU4w==
X-Received: by 2002:a05:620a:4707:: with SMTP id bs7mr10579013qkb.69.1642513676534;
        Tue, 18 Jan 2022 05:47:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv6HnzjHuT5N1t1EC9wxx1PTYBX6bmSt1ApjuQU+Hkt1OpfbXesU08UCU1CJZIzmlhr0LmNA==
X-Received: by 2002:a05:620a:4707:: with SMTP id bs7mr10578995qkb.69.1642513676274;
        Tue, 18 Jan 2022 05:47:56 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id m8sm3842981qkp.93.2022.01.18.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 05:47:55 -0800 (PST)
Date:   Tue, 18 Jan 2022 08:47:53 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YebFCeLcbziyMjbA@bfoster>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
 <YeXIIf6/jChv7JN6@zeniv-ca.linux.org.uk>
 <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 01:32:23AM +0000, Al Viro wrote:
> On Mon, Jan 17, 2022 at 07:48:49PM +0000, Al Viro wrote:
> > > But that critically depends upon the contents not getting mangled.  If it
> > > *can* be screwed by such unlink, we risk successful lookup leading to the
> > > wrong place, with nothing to tell us that it's happening.  We could handle
> > > that by adding a check to fs/namei.c:put_link(), and propagating the error
> > > to callers.  It's not impossible, but it won't be pretty.
> > > 
> > > And that assumes we avoid oopsen on string changing under us in the first
> > > place.  Which might or might not be true - I hadn't finished the audit yet.
> > > Note that it's *NOT* just fs/namei.c + fs/dcache.c + some fs methods -
> > > we need to make sure that e.g. everything called by ->d_hash() instances
> > > is OK with strings changing right under them.  Including utf8_to_utf32(),
> > > crc32_le(), utf8_casefold_hash(), etc.
> > 
> > And AFAICS, ext4, xfs and possibly ubifs (I'm unfamiliar with that one and
> > the call chains there are deep enough for me to miss something) have the
> > "bugger the contents of string returned by RCU ->get_link() if unlink()
> > happens" problem.
> > 
> > I would very much prefer to have them deal with that crap, especially
> > since I don't see why does ext4_evict_inode() need to do that memset() -
> > can't we simply check ->i_op in ext4_can_truncate() and be done with
> > that?
> 
> This reuse-without-delay has another fun side, AFAICS.  Suppose the new use
> for inode comes with the same ->i_op (i.e. it's a symlink again) and it
> happens right after ->get_link() has returned the pointer to body.
> 

Yep, I had reproduced this explicitly when playing around with some
instrumented delays and whatnot in the code. This and the similar
variant of just returning internal/non-string data fork metadata via
->get_link() is why I asked to restore old behavior of returning -ECHILD
for inline symlinks.

> We are already past whatever checks we might add in pick_link().  And the
> pointer is still valid.  So we end up quietly traversing the body of
> completely unrelated symlink that never had been anywhere near any directory
> we might be looking at.  With no indication of anything going wrong - just
> a successful resolution with bogus result.
> 
> Could XFS folks explain what exactly goes wrong if we make actual marking
> inode as ready for reuse RCU-delayed, by shifting just that into
> ->free_inode()?  Why would we need any extra synchronize_rcu() anywhere?
> 

Dave already chimed in on why we probably don't want ->free_inode()
across the board. I don't think there's a functional problem with a more
selective injection of an rcu delay on the INACTIVE -> RECLAIMABLE
transition, based on the reasoning specified earlier (i.e., the iget
side already blocks on INACTIVE, so it's just a matter of a longer
delay).

Most of that long thread I previously linked to was us discussing pretty
much how to do something like that with minimal performance impact. The
experiment I ran to measure performance was use of queue_rcu_work() for
inactive inode processing. That resulted in a performance hit to single
threaded sequential file removal, but could be mitigated by increasing
the queue size (which may or may not have other side effects). Dave
suggested a more async approach to track the current grace period in the
inode and refer to it at lookup/alloc time, but that is notably more
involved and isn't clear if/how much it mitigates rcu delays.

IIUC, your thought here is to introduce an rcu delay on the destroy
side, but after the inactive processing rather than before it (as my
previous experiment did). IOW, basically invoke
xfs_inodegc_set_reclaimable() as an rcu callback via
xfs_inodegc_worker(), yes? If so, that seems like a potentially
reasonable option to me since it pulls the delay out of the inactivation
processing pipeline. I suspect the tradeoff with that is it might be
slightly less efficient than doing it earlier because we've lost any
grace period transitions that have occurred since before the inode was
queued and processed, but OTOH this might isolate the impact of that
delay to the inode reuse path. Maybe there's room for a simple
optimization there in cases where a gp may have expired already since
the inode was first queued. Hmm.. maybe I'll give that a try to see
if/how much impact there may be on an inode alloc/free workload..

Brian

