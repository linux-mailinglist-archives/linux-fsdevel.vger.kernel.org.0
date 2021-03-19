Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32113342774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 22:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCSVM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSVMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:12:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5AC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 14:12:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso5445367pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLNry3ZXHQ9tHu+On0bkjiCkpapr1pSIrFsTvvsflEc=;
        b=1n0mkAQFvc10rNMQoLM9YVKLE+ZBv2SCxreZVqm0WfGygljeO+ZRmjcTdUMMLhNjB4
         Gi9g41nDX8BOK97qf6iUs0zF3ZCAQXoRtNyPkL1qM36LklJ1WM0Lo7JCyIPHXj5eF0u1
         JojeCjZc7pbP/XHtf0DO9W+UdwEqN9n8x/jNAd5xP2cFriIInfigeo1h3/1T8FkHIFw+
         X6YXB3TaCZbo3iV0IwmBxTbBYKTtwOJasCsj08Ivlz5gDE7HAkj6mxpnwCETT7sJsW9Z
         ygkepDZ9z1WkRAMbZVQBMNnARQyEockssNtkAwOk1gAJIyRF849x5PNPl3DMM3foMGkT
         WTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLNry3ZXHQ9tHu+On0bkjiCkpapr1pSIrFsTvvsflEc=;
        b=N/lCPFgIcPnQOIuzvXqI2Z1ztXtvMQ1GwAKYzUA5u5S3p6LhSD/gzj7v06RpU/tQ8e
         /evYXJ45yCTjT1vQv7TX1dYk6mv9NKkQPME5omXFWiUPfbfbnjolmtbef25AJzqrD//C
         glNhv6+Hs8D/pQ8BtxVM3E8dbsSTNvclog9OY/ZbTdJRB/OGWZzRXg8UvtSLgj1QCtn7
         FGqYSWwIW8UCLsoEcAriXctkCn/rG30zco+WzQnoYJ6PZLQjUVGKfpm0B12msdThuMF/
         8dYSOwtv8DOmjrQFi7DOiKb5Bj2tvKkDRpvmRrw8nuDQ3qzcKxDaeULdN6pG0vicfjm/
         xSdA==
X-Gm-Message-State: AOAM531M+F3zYd7F9pUQynZUqSZiKIb33PVd2HMeug69eahP5zTiPNOs
        U2W7YsdHB8IyElexe5i4YDXvpg==
X-Google-Smtp-Source: ABdhPJxX0o7uVOSoY7PrQ1YTqR+hEYKRyX9j2fhPjFZHpCBlCJQOqbd4pTvH/e1v2Ab7pYPtnWSwyw==
X-Received: by 2002:a17:90a:8505:: with SMTP id l5mr437793pjn.100.1616188321497;
        Fri, 19 Mar 2021 14:12:01 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9ec6])
        by smtp.gmail.com with ESMTPSA id c128sm6280833pfc.76.2021.03.19.14.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:11:59 -0700 (PDT)
Date:   Fri, 19 Mar 2021 14:11:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
Message-ID: <YFUTnDaCdjWHHht5@relinquished.localdomain>
References: <cover.1615922644.git.osandov@fb.com>
 <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain>
 <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 01:55:18PM -0700, Linus Torvalds wrote:
> On Fri, Mar 19, 2021 at 1:27 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > For RWF_ENCODED, iov[0] is always used as the entirety of the struct. I
> > made the helper more generic to support other use cases, but if that's
> > the main objection I can easily make it specifically use iov[0].
> 
> Honestly, with new interfaces, I'd prefer to always start off as
> limited as possible.
> 
> And read/write is not very limited (but O_ALLOW_ENCODED and
> RWF_ENCODED at least helps with the "fool suid program to do it"). But
> at least we could make sure that the structure then has to be as
> strict as humanly possible.
> 
> So it's not so much a "main objection" as more about trying to make
> the rules stricter in the hope that that at least makes only one very
> particular way of doing things valid. I'd hate for user space to start
> 'streaming" struct data.

After spending a few minutes trying to simplify copy_struct_from_iter(),
it's honestly easier to just use the iterate_all_kinds() craziness than
open coding it to only operate on iov[0]. But that's an implementation
detail, and we can trivially make the interface stricter:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 395ca89e5d9b..41b6b0325d18 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -969,9 +969,9 @@ EXPORT_SYMBOL(copy_page_from_iter);
  * On success, the iterator is advanced @usize bytes. On error, the iterator is
  * not advanced.
  */
-int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
-			  size_t usize)
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i)
 {
+	size_t usize = iov_iter_single_seg_count(i);
 	if (usize <= ksize) {
 		if (!copy_from_iter_full(dst, usize, i))
 			return -EFAULT;

I.e., the size of the userspace structure is always the remaining size
of the current segment. Maybe we can even throw in a check that we're
either at the beginning of the current segment or the very beginning of
the whole iter, what do you think?

(Again, this is what RWF_ENCODED already does, it was just easier to
write copy_struct_from_iter() more generically).

> > > Also I see references to the man-page, but honestly, that's not how
> > > the kernel UAPI should be defined ("just read the man-page"), plus I
> > > refuse to live in the 70's, and consider troff to be an atrocious
> > > format.
> >
> > No disagreement here, troff is horrible to read.
> >
> > > So make the UAPI explanation for this horror be in a legible format
> > > that is actually part of the kernel so that I can read what the intent
> > > is, instead of having to decode hieroglypics.
> >
> > I didn't want to document the UAPI in two places that would need to be
> > kept in sync
> 
> Honestly, I would suggest that nobody ever write troff format stuff.
> I don't think it supports UTF-8 properly, for example, which means
> that you can't even give credit to people properly etc.
> 
> RST isn't perfect, but at least it's human-legible, and it's obviously
> what we're encouraging for kernel use. You can use rst2man to convert
> to bad formats (and yes, you might lose something in the translation,
> eg proper names etc).

It looks like there's precedent for man pages being generated from the
kernel documentation [1], so I'll try that.

1: https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=53666f6c30451cde022f65d35a8d448f5a7132ba

> Almost anything else(*) is better than troff. But at least I can read
> the formatted version.
> 
>           Linus
> 
> (*) With the possible exception of "info" files. Now *there* is a
> truly pointless format maximally designed to make it inconvenient for
> users.
