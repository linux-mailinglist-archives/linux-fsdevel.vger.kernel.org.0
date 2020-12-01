Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C862CA1FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 13:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbgLAL5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 06:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389039AbgLAL5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:57:13 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27485C0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Dec 2020 03:56:33 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r9so1288023ioo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 03:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=z9ULpizLWDQiCJkdcf/66NmmJqFYGorqtuiF70FgIJg=;
        b=aYyYXHVdvVyVPH6ufds7fBBjA5xxE+RIPU0UHwETETBon5X/AxBP3pfU7D6rgLWDxK
         MCPFi3QrsNpvmCT6uMHXOLdMnjdYFbsFK9ztzGqhIRHo5nK6I+1wG60VvNxdgQQB+op+
         wrAG/5RDYf5PphyPYR/ibeHZfeCSXNMaFIKGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9ULpizLWDQiCJkdcf/66NmmJqFYGorqtuiF70FgIJg=;
        b=G7DqGbHViKTLUWViz0vuP3GiLgeTLbruqVQnDB11S1inpeBTrOU6gfdDKxAhD7a1Sx
         zOcKppxSXPPdiOpcwxB1qapJFDbGiqD22Qmw0nKFIKKHp8Yg3CSOZP3wMm6gDIWE6JjZ
         hl+tBgA5Bp009tJlSyfSd5Vyq2IX5rliAiZL0aunNvv1RqLSKjrREcVCWTYhE9iGqtsc
         tduteSM1xpX7Cl7MfMfeQesRI7OVAI25HfJsvx5p4MN2cCo8RXPF/yZ1BCdhCbxd6oGs
         /0+X9YsykrAD6V3RoYY/GK8/v6/q8aeexB7K5D8SR1JZVRFyewgS256z4brMiUdHXDPP
         Ri7Q==
X-Gm-Message-State: AOAM5330iuaSnexCafSBA9mYV+Bddvl9XQrqNZaXv8Q1I5SxRr2E292F
        Zl8ZMmaGCiRPkXlMCNgFBa9oTQ==
X-Google-Smtp-Source: ABdhPJz0GL7O0XGhZu0j9b4iHEHojyC5oy0U6R1upsTmsVSxZyQ7aBqTOJ2GyvVcfx+OvymB9iiU2w==
X-Received: by 2002:a02:2e54:: with SMTP id u20mr2267006jae.142.1606823792462;
        Tue, 01 Dec 2020 03:56:32 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id x23sm697798ioh.28.2020.12.01.03.56.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 03:56:32 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:56:30 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2 4/4] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
Message-ID: <20201201115630.GC24837@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130193342.GD14328@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 02:33:42PM -0500, Vivek Goyal wrote:
> On Fri, Nov 27, 2020 at 01:20:58AM -0800, Sargun Dhillon wrote:
> > Volatile remounts validate the following at the moment:
> >  * Has the module been reloaded / the system rebooted
> >  * Has the workdir been remounted
> > 
> > This adds a new check for errors detected via the superblock's
> > errseq_t. At mount time, the errseq_t is snapshotted to disk,
> > and upon remount it's re-verified. This allows for kernel-level
> > detection of errors without forcing userspace to perform a
> > sync and allows for the hidden detection of writeback errors.
> > 
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/overlayfs/overlayfs.h | 1 +
> >  fs/overlayfs/readdir.c   | 6 ++++++
> >  fs/overlayfs/super.c     | 1 +
> >  3 files changed, 8 insertions(+)
> > 
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index de694ee99d7c..e8a711953b64 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -85,6 +85,7 @@ struct ovl_volatile_info {
> >  	 */
> >  	uuid_t		ovl_boot_id;	/* Must stay first member */
> >  	u64		s_instance_id;
> > +	errseq_t	errseq;	/* Implemented as a u32 */
> >  } __packed;
> >  
> >  /*
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 7b66fbb20261..5795b28bb4cf 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -1117,6 +1117,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
> >  		return -EINVAL;
> >  	}
> >  
> > +	err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
> 
> Might be a stupid question. Will ask anyway.
> 
> But what protects against wrapping of counter. IOW, Say we stored info.errseq
> value as A. It is possible that bunch of errors occurred and at remount
> time ->s_wb_err is back to A and we pass the check. (Despite the fact lots
> of errors have occurred since we sampled).
> 
> Thanks
> Vivek
> 

+Jeff Layton <jlayton@redhat.com>

Nothing. The current errseq API works like this today where if you have 2^20
(1048576) errors, and syncfs (or other calls that mark the errseq as seen), and
the error that occured 1048575 times ago was the same error as you just last
had, and the error on the upperdir has already been marked as seen, the error
will be swallowed up silently.

This exists throughout all of VFS. I think we're potentially making this more
likely by checkpointing to disk. The one aspect which is a little different about
the usecase in the patch is that it relies on this mechanism to determine if
an error has occured after the entire FS was constructed, so it's somewhat
more consequential than the current issue in VFS which will just bubble up
errors in a few files.

On my system syncfs takes about 2 milliseconds, so you have a chance to
experience this every ~30 minutes if the syscalls align in the right way. If
we expanded the errseq_t to u64, we would potentially get a collision
every 4503599627370496 calls, or assuming the 2 millisecond invariant
holds, every 285 years. Now, we probably don't want to make errseq_t into
a u64 because of performance reasons (not all systems have native u64
cmpxchg), and the extra memory it'd take up.

If we really want to avoid this case, I can think of one "simple" solution,
which is something like laying out errseq_t as something like a errseq_t_src
that's 64-bits, and all readers just look at the lower 32-bits. The longer
errseq_t would exist on super_blocks, but files would still get the shorter one.
To potentially avoid the performance penalty of atomic longs, we could also
do something like this:

typedef struct {
    atomic_t overflow;
    u32 errseq;
} errseq_t_big;

And in errseq_set, do:
/* Wraps */
if (new < old)
        atomic_inc(&eseq->overflow);

*shrug*
I don't think that the above scenario is likely though.
