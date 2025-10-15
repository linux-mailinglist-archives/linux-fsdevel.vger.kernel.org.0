Return-Path: <linux-fsdevel+bounces-64171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6029BDBDAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 02:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597923C18C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AB1BC5C;
	Wed, 15 Oct 2025 00:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eNvsGT62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DB17BA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486541; cv=none; b=FP4D4op4TEalAcFARJBSCas4R8EssYRPOxVQHwA8LACUsFP7zl6vsqS1iNop/nGp8OZqaU1shm/EdlsOKzrwYB27QEbEgpQ/+uN7l457u2GbZ6AbWQZK7lfpI/OFRgFhwMggFrGwKR3K9gaYSW79Szz/mmv/FhmNRIiAXAQFZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486541; c=relaxed/simple;
	bh=GJVi7Uls4ieWZ3bCIzyejkrCVwWN+vWqRyC0z9mQwkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+Zg5sMdHeRKtYZjJ0GuR67/Qjf/JcbXqbAQXyhXGlTdrluntOs7F9f3mzAcGbCnwlEOSq+muYgFdJq+mnU7mSAUC7ToURZk8XxYKikjQklnDC0qiR+y+YHrin8hYzUbA8978pBE9ynCjY0jJzJ5lHAQSGaAmalDUJF7vQjJpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eNvsGT62; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so5091928a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760486538; x=1761091338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5lWnsuwkzpeApWk2ViOA5FQ8lFTBV0LeMgWGpahdtj0=;
        b=eNvsGT620FsuqNk3mQttW1M9Tz0dvDGYG3obDZzkYv76UULuvqq6pmbJt41Exq1ftT
         OFaJ2uVM7FVyVg/XqTniQzbXxRyiSGtWfLzLvnpgJ0+srLasKhRVGALb/ADwS9h1kgQC
         Y+wk4C3rPvUA+Fhgzj72jmz8koRmj8xyWnsLYx0bJFJo34+TM5vLziRE7748uIW6KHZh
         pCyiGYaLAgeICDO1ta5v/ivQz5jQbhjmJlSitGwuqfzqpY2ZtXuf8SJlPv8pzehu4pSq
         R9MU4LtWzZGPAajjEYeGZjgYLN9a1yKiExVYHPTj3FJ8ph06LZ6s7DOQEnuFLZv2ThzF
         p3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486538; x=1761091338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lWnsuwkzpeApWk2ViOA5FQ8lFTBV0LeMgWGpahdtj0=;
        b=X62H2tYGjnh6So85HmPkFK9Cg87vvtZkDrZFxiN/Kv407ymTPckXq6mqYGNbSHVz7O
         H5a3eaAJH9VYIiYh1ZE6elRjoQJjcUCrA06izCnWX15wu2dDrnj0CqThniplmzrFdxYu
         DOVQzFvY8AdBdKDjLV0jXKOP4GXC/adRoOBQuhxVV7WJxPCDchQluQiAEAqhPD9tMcje
         lkFh48YzqqY7azQu4aPwQU2h4Zp8VCJeEpno/GSnMcLtqeX6Fi76cqkN3RE6OfViWVn6
         o733UP0mGeHkAy6RQ8yjXHTQd6WFzu0WBvNGEFlcG8euMfNnNxEB5rFeridz1aLQhhqJ
         WYGw==
X-Forwarded-Encrypted: i=1; AJvYcCUmTpaW+1U2aKwfu2NexDoa3XLnWSRGr38/JFmCZoVIGzB9ybYmuwO7yjqIBFAKKK6a/EMmyP9jn7HWnV8v@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhZrT2u9lFAdDo/MhhRxuXP9qrMrInkjpBw9Hl9I+MYAo1yWR
	bG1wKXB7D6qWaKEbeHExAxQvQcAEVJRPWRmtgiwyJtcKqTzJBLj+cYu2WfJixJWl9/o=
X-Gm-Gg: ASbGncvHomZ65fgsEB+CSrfs8MozJ8U2AVvphE8+BIeg3/bEzNxl+nj8k3ERdGg0X0p
	/E9MP/IUF9mhLHOJSZy1gZSdu4zybVWDtLmDpKFuM7X/mfUSCi3o1+pNdJmMtfR1abGpuM+UyPJ
	9jIB+R73rlkSfQLDLV8L2rGJOMAWzOSfeXsO/fFoVzWQYT1XFdpRLLLjYT5pwXfDkrSftNJb2UE
	TMAl8lREPefS/Zz44tF/MDiD86QPq22P/jyUqq4AAYzWWHgPJdpICfh4DLCEEETE+I2AZ42sKzj
	W8aHx2Vq1kDZgkIu1drjwf6KZHEZno0XPQGVtn8CHJkz0Fh89c4mP6F2l6gzHtV4KOvudR2HzvO
	G7d2EA3Y/PPQBdHocrWYO/gWWFBWW/W7nLdnZj4TmZXBT7VfrKVxb1LcKEFuhatj4Ks0dMYInDM
	OhuZ23BI4CwduBZhJe
X-Google-Smtp-Source: AGHT+IGoMUjacqS/V8o1WNbZPsHJJvFetdCeeZRacPCwQ/XYo2nNnoscuKOLgAnWu1qaNz9uyKQLiQ==
X-Received: by 2002:a17:90b:4a84:b0:32e:a10b:ce48 with SMTP id 98e67ed59e1d1-33b51114f9emr38707009a91.12.1760486538088;
        Tue, 14 Oct 2025 17:02:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b11ca9sm17310305a91.24.2025.10.14.17.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 17:02:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8oy6-0000000EvuK-45Dp;
	Wed, 15 Oct 2025 11:02:14 +1100
Date: Wed, 15 Oct 2025 11:02:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 13/14] xfs: use the new ->i_state accessors
Message-ID: <aO7khoBHdfPlEBAE@dread.disaster.area>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-14-mjguzik@gmail.com>
 <ua3koqbakm6e4dpbzfmhei2evc566c5p2t65nsvmlab5yyibxu@u6zp4pwex5s7>
 <CAGudoHGckJHiWN9yCngP1JMGNa1PPNvnpSuriCxSM1mwWhpBUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGckJHiWN9yCngP1JMGNa1PPNvnpSuriCxSM1mwWhpBUQ@mail.gmail.com>

On Fri, Oct 10, 2025 at 05:40:49PM +0200, Mateusz Guzik wrote:
> On Fri, Oct 10, 2025 at 4:41 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 09-10-25 09:59:27, Mateusz Guzik wrote:
> > > Change generated with coccinelle and fixed up by hand as appropriate.
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> >
> > ...
> >
> > > @@ -2111,7 +2111,7 @@ xfs_rename_alloc_whiteout(
> > >        */
> > >       xfs_setup_iops(tmpfile);
> > >       xfs_finish_inode_setup(tmpfile);
> > > -     VFS_I(tmpfile)->i_state |= I_LINKABLE;
> > > +     inode_state_set_raw(VFS_I(tmpfile), I_LINKABLE);
> > >
> > >       *wip = tmpfile;
> > >       return 0;
> > > @@ -2330,7 +2330,7 @@ xfs_rename(
> > >                * flag from the inode so it doesn't accidentally get misused in
> > >                * future.
> > >                */
> > > -             VFS_I(du_wip.ip)->i_state &= ~I_LINKABLE;
> > > +             inode_state_clear_raw(VFS_I(du_wip.ip), I_LINKABLE);
> > >       }
> > >
> > >  out_commit:
> >
> > These two accesses look fishy (not your fault but when we are doing this
> > i_state exercise better make sure all the places are correct before
> > papering over bugs with _raw function variant). How come they cannot race
> > with other i_state modifications and thus corrupt i_state?
> >
> 
> I asked about this here:
> https://lore.kernel.org/linux-xfs/CAGudoHEi05JGkTQ9PbM20D98S9fv0hTqpWRd5fWjEwkExSiVSw@mail.gmail.com/

Yes, as I said, we can add locking here if necessary, but locking
isn't necessary at this point in time because nothing else can
change the state of the newly allocated whiteout inode until we
unlock it.

Keep in mind the reason why we need I_LINKABLE here - it's not
needed for correctness - it's needed to avoid a warning embedded
in inc_nlink() because filesystems aren't trusted to implement
link counts correctly anymore.

Now we're being told that "it is too dangerous to let filesystems
manage inode state themselves" and so we have to add extra overhead
to code that we were forced to add to avoid VFS warnings added
because the VFS doesn't trust filesystems to maintain some other
important inode state....

So, if you want to get rid of XFS using I_LINKABLE here, please fix
the nlink VFS api to allow us to call inc_nlink_<something>() on a
zero link inode without I_LINKABLE needing to be set. We do actually
know what we are doing here, and as such needing I_LINKABLE here is
nothing but a hacky workaround for inflexible, trustless VFS APIs...

> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index caff0125faea..ad94fbf55014 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -1420,7 +1420,7 @@ xfs_setup_inode(
> > >       bool                    is_meta = xfs_is_internal_inode(ip);
> > >
> > >       inode->i_ino = ip->i_ino;
> > > -     inode->i_state |= I_NEW;
> > > +     inode_state_set_raw(inode, I_NEW);

"set" is wrong and will introduce a regression. This must be an
"add" operation as inode->i_state may have already been modified
by the time we get here. From 2021:

commit f38a032b165d812b0ba8378a5cd237c0888ff65f
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Aug 24 19:13:04 2021 -0700

    xfs: fix I_DONTCACHE

    Yup, the VFS hoist broke it, and nobody noticed. Bulkstat workloads
    make it clear that it doesn't work as it should.

    Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")
    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    Reviewed-by: Darrick J. Wong <djwong@kernel.org>
    Signed-off-by: Darrick J. Wong <djwong@kernel.org>

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index a3fe4c5307d3..f2210d927481 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -84,8 +84,9 @@ xfs_inode_alloc(
                return NULL;
        }

-       /* VFS doesn't initialise i_mode! */
+       /* VFS doesn't initialise i_mode or i_state! */
        VFS_I(ip)->i_mode = 0;
+       VFS_I(ip)->i_state = 0;

        XFS_STATS_INC(mp, vn_active);
        ASSERT(atomic_read(&ip->i_pincount) == 0);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 0ff0cca94092..a607d6aca5c4 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1344,7 +1344,7 @@ xfs_setup_inode(
        gfp_t                   gfp_mask;

        inode->i_ino = ip->i_ino;
-       inode->i_state = I_NEW;
+       inode->i_state |= I_NEW;

        inode_sb_list_add(inode);
        /* make the inode look hashed for the writeback code */

-Dave.
-- 
Dave Chinner
david@fromorbit.com

