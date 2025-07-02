Return-Path: <linux-fsdevel+bounces-53641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7C1AF15E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A927AAECF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B852749E7;
	Wed,  2 Jul 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBasmfAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1EE271449;
	Wed,  2 Jul 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751460025; cv=none; b=JhNK//WMO9jvdwvDGLyBozqkXWtuKZqIl11skCkYvzdxBYnKY+vWT+2CEM/04m6Jp7/J74iF7I87jPSiEFvppWp/J4vzvEVUiFblIz8UdCbAZIXqkraNsJ70FV8rujY+Xu8U+YOZs3oQF2LY9Fifc0I7zR7Ia9a3gLye3DLkJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751460025; c=relaxed/simple;
	bh=PZV1Mjm8WRt0BTVC+LtJNn6scged36v1d0AnwXcvL8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6zbut5CK7gpufKaEblooIDyeU7LdIo/vgMGXkuASdvIAvvtKCHUeA4GNmQQyhzNkoNxCXR6devzBr9UfukxLMI6Lt2mAeM49Te2YkUnzlDE+3vga/hS59RWQRa7JtbBomwPauQmn8zM52hCOKodWJiT16ptsxmRrNU9ZtxFogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBasmfAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDF5C4CEF0;
	Wed,  2 Jul 2025 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751460024;
	bh=PZV1Mjm8WRt0BTVC+LtJNn6scged36v1d0AnwXcvL8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBasmfAg4ZR2h68mT47lufx94gDB+Hsf6CVYKKtn5CI+M+wjJ29rLJB4wE98OjHoE
	 iR8Nkc+0laghIBqOVV3hX1cPkmDLADa8zGLr6UMS+TBAsCsaHkyjbb+yeVzmPZsVVA
	 KmtiKIsI0p1lyKA1/XY7EVdgiMlis3LUehPD67HdcomfR9EDD+IsXV/FoBKujEpX/y
	 ez07gBaPGj7M6Ok28o29jixwxfPb5dEh4/EiJ5Cgp5/0G9T7DXLF8xtPi4UxPud90z
	 h0/0OVfMJvrPZtn+fm7Ye22jQGBu8+rf0wPbRoLE62vzms5FYI5SlPitq4XnfxuMbE
	 Z8zkoZ+NKdjLg==
Date: Wed, 2 Jul 2025 14:40:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250702-stagnation-dackel-294bb4cd9f3d@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250701184317.GQ10009@frogsfrogsfrogs>

> Er... "fsx_fileattr" is the struct that the system call uses?
> 
> That's a little confusing considering that xfs already has a
> xfs_fill_fsxattr function that actually fills a struct fileattr.
> That could be renamed xfs_fill_fileattr.
> 
> I dunno.  There's a part of me that would really rather that the
> file_getattr and file_setattr syscalls operate on a struct file_attr.

Agreed, I'm pretty sure I suggested this during an earlier review. Fits
in line with struct mount_attr and others. Fwiw, struct fileattr (the
kernel internal thing) should've really been struct file_kattr or struct
kernel_file_attr. This is a common pattern now:

struct mount_attr vs struct mount_kattr

struct clone_args vs struct kernel_clone_kargs

etc.

> 
> More whining/bikeshedding to come.
> 
> <snip stuff that looks ok to me>
> 
> <<well, I still dislike the CLASS(fd, fd)(fd) syntax...>>

Noted, and duly ignored...

> 
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 0098b0ce8ccb..0784f2033ba4 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -148,6 +148,24 @@ struct fsxattr {
> >  	unsigned char	fsx_pad[8];
> >  };
> >  
> > +/*
> > + * Variable size structure for file_[sg]et_attr().
> > + *
> > + * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
> > + * As this structure is passed to/from userspace with its size, this can
> > + * be versioned based on the size.
> > + */
> > +struct fsx_fileattr {
> > +	__u32	fsx_xflags;	/* xflags field value (get/set) */
> 
> Should this to be __u64 from the start?  Seeing as (a) this struct is

Agreed. I changed that.

