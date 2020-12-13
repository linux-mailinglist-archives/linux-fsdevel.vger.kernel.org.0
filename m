Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0372D9051
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 21:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbgLMUHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 15:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbgLMUHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 15:07:25 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61652C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 12:06:45 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id g1so13930672ilk.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 12:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pi2fcVCqcUFQQYSrnFsWBqF7pr8porn7D+qfGhtFQRo=;
        b=daXSNb8HWwoWdF2eCXrVn6nFT+Xk99HYG1snGu067/SbxHLH6g2WhFBfUoqagCx3Gb
         +5utvK97kpFH4wYhyb70+BQRRRLiQomrw6tH2AcKWt5ecwbHLUFmG7sayp8ON4s3DNDq
         tYrVi5l8Ixgr2b35p7Y577mTiNvwnkq+YUdfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pi2fcVCqcUFQQYSrnFsWBqF7pr8porn7D+qfGhtFQRo=;
        b=OrjD9W7MIHtZfd7KBze4PjLclahWSgm8zlG2f4nJv0saTsQ72oHHuoWRFUHfBdPItX
         wXmYWJl6zpuDN8LUIrJZ5BuxGJWhssZ/7ZpLR4UhHUV5u6BRQYAtEkh+Ng2Vhw/80kMP
         pE/MeUfPZup9fVm6DauaKC4H69MfbEv9l1KXx1h/G+uIWidhH0SSAzwqVG8wcwe7RYhD
         KSLYPCg/uruLCivZEoXWfXjE2icpfB100jVb0C7t6KSqeg2/gkwVSCwVz3iZkKyEOyyJ
         E3JpfX/OH630pmwq9Bb0sBMVsx4lc1/c61CoU7r4W6ZaNssxLxioIcUR5ZsnKc956Scr
         IHgg==
X-Gm-Message-State: AOAM531KiJWbI5xczHvW9sqHjkz1OPSICOMhRirvHBlSvaVXjmxLE/ir
        DTlpfuDTXEpQSBNqtU4gF3m1Sw==
X-Google-Smtp-Source: ABdhPJzidN/pSVIKTGs7cgoxNTakG4hkVJ9yAVpIVbLjGf5Jp1dIA6tvA+cCvEDPJSpco+pJpBGd4g==
X-Received: by 2002:a05:6e02:1ba3:: with SMTP id n3mr555071ili.10.1607890004543;
        Sun, 13 Dec 2020 12:06:44 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id a15sm9757194ilh.10.2020.12.13.12.06.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Dec 2020 12:06:44 -0800 (PST)
Date:   Sun, 13 Dec 2020 20:06:42 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/3] Check errors on sync for volatile overlayfs mounts
Message-ID: <20201213200642.GB8562@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201211235002.4195-1-sargun@sargun.me>
 <7779e2ed97080009d894f3442bfad31972494542.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7779e2ed97080009d894f3442bfad31972494542.camel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 12, 2020 at 06:21:37AM -0500, Jeff Layton wrote:
> On Fri, 2020-12-11 at 15:49 -0800, Sargun Dhillon wrote:
> > The semantics of errseq and syncfs are such that it is impossible to track
> > if any errors have occurred between the time the first error occurred, and
> > the user checks for the error (calls syncfs, and subsequently
> > errseq_check_and_advance.
> > 
> > Overlayfs has a volatile feature which short-circuits syncfs. This, in turn
> > makes it so that the user can have silent data corruption and not know
> > about it. The third patch in the series introduces behaviour that makes it
> > so that we can track errors, and bubble up whether the user has put
> > themselves in bad situation.
> > 
> > This required some gymanstics in errseq, and adding a wrapper around it
> > called "errseq_counter" (errseq + counter). The data structure uses an
> > atomic to track overflow errors. This approach, rather than moving to an
> > atomic64 / u64 is so we can avoid bloating every person that subscribes to
> > an errseq, and only add the subscriber behaviour to those who care (at the
> > expense of space.
> > 
> > The datastructure is write-optimized, and rightfully so, as the users
> > of the counter feature are just overlayfs, and it's called in fsync
> > checking, which is a rather seldom operation, and not really on
> > any hotpaths.
> > 
> > [1]: https://lore.kernel.org/linux-fsdevel/20201202092720.41522-1-sargun@sargun.me/
> > 
> > Sargun Dhillon (3):
> >   errseq: Add errseq_counter to allow for all errors to be observed
> >   errseq: Add mechanism to snapshot errseq_counter and check snapshot
> >   overlay: Implement volatile-specific fsync error behaviour
> > 
> >  Documentation/filesystems/overlayfs.rst |   8 ++
> >  fs/buffer.c                             |   2 +-
> >  fs/overlayfs/file.c                     |   5 +-
> >  fs/overlayfs/overlayfs.h                |   1 +
> >  fs/overlayfs/ovl_entry.h                |   3 +
> >  fs/overlayfs/readdir.c                  |   5 +-
> >  fs/overlayfs/super.c                    |  26 +++--
> >  fs/overlayfs/util.c                     |  28 +++++
> >  fs/super.c                              |   1 +
> >  fs/sync.c                               |   3 +-
> >  include/linux/errseq.h                  |  18 ++++
> >  include/linux/fs.h                      |   6 +-
> >  include/linux/pagemap.h                 |   2 +-
> >  lib/errseq.c                            | 129 ++++++++++++++++++++----
> >  14 files changed, 202 insertions(+), 35 deletions(-)
> > 
> 
> It would hel if you could more clearly lay out the semantics you're
> looking for. If I understand correctly:
> 
> You basically want to be able to sample the sb->s_wb_err of the upper
> layer at mount time and then always return an error if any new errors
> were recorded since that point.
> 
There's two things we want to achieve:

1. If an error occurs on the upperidr after mount time, we want to tell the user 
  on every syncfs  they try to do on the overlayfs volume that it occurred, and
  that the volume is in an inconsistent state.
2. We want to be able to checkpoint some information to disk, and if an overlayfs
   mount was unmounted, and remounted, while in volatile mode, we want to make sure
   no error occurred while we were way.

> If that's correct, then I'm not sure I get need for all of this extra
> counter machinery. Why not just sample it at mount time without
> recording it as 0 if the seen flag isn't set. Then just do an
> errseq_check against the upper superblock (without advancing) in the
> overlayfs ->sync_fs routine and just errseq_set that error into the
> overlayfs superblock? The syncfs syscall wrapper should then always
> report the latest error.
I considered the following options:
1. Make errseq_t a u64: Downside: Bloats all errseq_ts to u64 / 8-byte aligned
2. Make errseq_counter_t an atomic64 / u64 giving us 52 error checking bits vs.
   just 20: Downside: We would have to do an cmpxchg64 on every error, which
   seemed like it could be costly on platforms that don't naturally support it.
3. Have an overflow counter: This doesn't introduce extra CPU overhead for any
   other user of errseq, nor does it introduce much memory overhead. Downside:
   complexity.

> 
> Or (even better) rework all of the sync_fs/syncfs mess to be more sane,
> so that overlayfs has more control over what errors get returned to
> userland. ISTM that the main problem you have is that the
> errseq_check_and_advance is done in the syscall wrapper, and that's
> probably not appropriate for your use-case.
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
