Return-Path: <linux-fsdevel+bounces-45087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64858A71829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DF317222D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776741F1510;
	Wed, 26 Mar 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="czkLKIsj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D31EEA59
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998372; cv=none; b=U6qbAf6yQBXLJhOTk+1FL0MotD48+OOuk2WNGr+67VA4fDk/JwY+He7dAbp+MqGyFcA8FEWm/rr67quuklr+jDZYwXNa/Hq6pMUkG9zhQm6VhuQ+ba/94c6WtoMk//gfpWzPI+ro26XKHlEU3YL3V8RPNwejZPoapOclrBTuT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998372; c=relaxed/simple;
	bh=51mRzuEQCE385LV1Na85+dU/o4P8ykaGsvA7RaQ5bvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6Jy/u4bO2Rk6OTJIDMlFHawRHq4Y2SOt4sxzWmM2ZSo2ySXBIWPDAPw2iXn0kCL7oiHuO5DX3gj3UCayI9CMtBowdiz/Vq+BKQnN74iZdWbIOhmdo2Mb8WR/QSn1YnFWr6m2PXPJn0y//QasD3gCUYac3vOmndsCULjg5N/TyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=czkLKIsj; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Mar 2025 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742998367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s7Z4oJSARPv0B7zdpMmeQFMh9VQkOtH2iYeuikkNnHQ=;
	b=czkLKIsjYmOVuyhIpiMVteu0OYrR9jwyE0t8brSAV4Tj9ht8F0LGL4w1Pgo2upJw8Wb0G+
	JI4q+H5u0yGt5RkhVu4prvy1eA+8F/go/saIHaNaNd0HsPa3eyUDHXgoXT1GCYf2M8tf6r
	pZ+YTpENJYyvnBQ5oM7fIIFwytHtLuM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Li Wang <liwang@redhat.com>, 
	Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
Message-ID: <7ry7netcdqchal5pyoa5qdiris5klyxg6pqnz3qj6toodfgyuw@zder35svbr7v>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
 <20250326134749.GA45449@pevik>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326134749.GA45449@pevik>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 26, 2025 at 02:47:49PM +0100, Petr Vorel wrote:
> Hi all,
> 
> [ Cc Kent and other filesystem folks to be sure we don't hide a bug ]

I'm missing context here, and the original thread doesn't seem to be on
lore?

> 
> > From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> > Make sure that capabilities requirements are satisfied when accessing
> > immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> > following error due to missing capabilities:
> 
> > tst_test.c:1833: TINFO: === Testing on bcachefs ===
> > ..
> > ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> > ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> > ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> > ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)
> 
> > Introduce CAP_LINUX_IMMUTABLE capability to make sure that test won't
> > fail on other systems as well.
> 
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > index 6a9d270d9fb56f3a263f0aed976f62c4576e6a5f..6716423d9c96d9fc1d433f28e0ae1511b912ae2c 100644
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > @@ -122,5 +122,9 @@ static struct tst_test test = {
> >  	.bufs = (struct tst_buffers []) {
> >  		{&clone_range, .size = sizeof(struct file_clone_range)},
> >  		{},
> > -	}
> > +	},
> > +	.caps = (struct tst_cap []) {
> > +		TST_CAP(TST_CAP_REQ, CAP_LINUX_IMMUTABLE),
> > +		{}
> > +	},
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> LGTM, obviously it is CAP_LINUX_IMMUTABLE related.
> 
> This looks like fs/bcachefs/fs-ioctl.c
> 
> static int bch2_inode_flags_set(struct btree_trans *trans,
> 				struct bch_inode_info *inode,
> 				struct bch_inode_unpacked *bi,
> 				void *p)
> {
> 	...
> 	if (((newflags ^ oldflags) & (BCH_INODE_append|BCH_INODE_immutable)) &&
> 	    !capable(CAP_LINUX_IMMUTABLE))
> 		return -EPERM;
> 
> 
> We don't test on vfat and exfat. If I try to do it fail the same way (bcachefs,
> fat, exfat and ocfs2 use custom handler for FAT_IOCTL_SET_ATTRIBUTES).
> 
> I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:
> 
> /*
>  * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
>  * any invalid configurations.
>  *
>  * Note: must be called with inode lock held.
>  */
> static int fileattr_set_prepare(struct inode *inode,
> 			      const struct fileattr *old_ma,
> 			      struct fileattr *fa)
> {
> 	int err;
> 
> 	/*
> 	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> 	 * the relevant capability.
> 	 */
> 	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> 	    !capable(CAP_LINUX_IMMUTABLE))
> 		return -EPERM;
> 
> 
> Kind regards,
> Petr
> 
> >  };
> 
> > ---
> > base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
> > change-id: 20250326-fix_ioctl_ficlone03_32bit_bcachefs-2ec15bd6c0c6
> 
> > Best regards,

