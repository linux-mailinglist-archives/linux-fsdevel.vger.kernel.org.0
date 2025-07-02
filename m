Return-Path: <linux-fsdevel+bounces-53712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85DAF6168
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97054161451
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FEA2F50BA;
	Wed,  2 Jul 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enuDigA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D442E4992;
	Wed,  2 Jul 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481471; cv=none; b=h5yDM6B8x17TSDAnSGaABQg+eunpKcHZZg+8PkZ6a+oRhNnEPXFJg9ckDsjpsEZwgqfOG+daGlN2agySuaH8C/dFL+66GVv9hYPABSHu4zOHVjFynKWxo0QCplW30PkeZfMgR6o9fGTLHoxUk1BKV6K/HU/5hAsVfV+smJPdy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481471; c=relaxed/simple;
	bh=nW2vHO9QQCcm4Z1QN6Img2usutOZCb4Epl3Ntbf/DTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCx5ondSluWjDfFZ/mzJFoVaVnpPt9LO0wyxVzdBpo8XBOsDa4LrHEFbEhCWLKAzgk0tyPdB/7cffKmTIvGIk7nxMN6qQ4teGky0vXheqt0NoMKtd9oCW/azvpUpMAGM+wRG/5Ega2G4wLT+fm26hD75ipMD8H5B8+f6LHG/soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enuDigA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF803C4CEE7;
	Wed,  2 Jul 2025 18:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481470;
	bh=nW2vHO9QQCcm4Z1QN6Img2usutOZCb4Epl3Ntbf/DTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enuDigA1H4yfVcmL85Sf42DWqCl5EwKedbw4LRHZ2VolbMFgbMQwu9pRDLto8Z7bO
	 7RlZuCrLMrTG0XPISeGGqMgXoO4pBIDABRCkleRvH4yqV08V2RhdceDotEsEsnEYNB
	 JQd/BdAZ406Tol+twzmYxnSwzRUXhYKRpgcT7UFqbkZXO6d/GlGDb90wEfAlTSj0w1
	 GYGmoylrr+EGvB3agTFd8zAESEDEtotgYR+VhoKexOtVbU4e5CMV/mi4qBNsbhiupE
	 abVxV9CyrIlm/czXAZ9RWCt8TZQwTohd2FxZqa8wzAMwpxwqZX3jLLwga8sI3G1S8c
	 XjIWj4oMOzlNw==
Date: Wed, 2 Jul 2025 11:37:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250702183750.GW10009@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250702-stagnation-dackel-294bb4cd9f3d@brauner>
 <CAOQ4uximwjYabeO=-ktMtnzMsx6KXBs=pUsgNno=_qgpQnpHCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uximwjYabeO=-ktMtnzMsx6KXBs=pUsgNno=_qgpQnpHCA@mail.gmail.com>

On Wed, Jul 02, 2025 at 03:43:28PM +0200, Amir Goldstein wrote:
> On Wed, Jul 2, 2025 at 2:40 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > Er... "fsx_fileattr" is the struct that the system call uses?
> > >
> > > That's a little confusing considering that xfs already has a
> > > xfs_fill_fsxattr function that actually fills a struct fileattr.
> > > That could be renamed xfs_fill_fileattr.
> > >
> > > I dunno.  There's a part of me that would really rather that the
> > > file_getattr and file_setattr syscalls operate on a struct file_attr.
> >
> > Agreed, I'm pretty sure I suggested this during an earlier review. Fits
> > in line with struct mount_attr and others. Fwiw, struct fileattr (the
> > kernel internal thing) should've really been struct file_kattr or struct
> > kernel_file_attr. This is a common pattern now:
> >
> > struct mount_attr vs struct mount_kattr
> >
> > struct clone_args vs struct kernel_clone_kargs
> >
> > etc.
> >file_attr
> 
> I can see the allure, but we have a long history here with fsxattr,
> so I think it serves the users better to reference this history with
> fsxattr64.

<shrug> XFS has a long history with 'struct fsxattr' (the structure you
passed to XFS_IOC_FSGETXATTR) but the rest of the kernel needn't be so
fixated upon the historical name.  ext4/f2fs/overlay afaict are just
going along for the ride.

IOWs I like brauner's struct file_attr and struct file_kattr
suggestions.

> That, and also, avoid the churn of s/fileattr/file_kattr/
> If you want to do this renaming, please do it in the same PR
> because I don't like the idea of having both file_attr and fileattr
> in the tree for an unknown period.

But yeah, that ought to be a treewide change done at the same time.

--D

> 
> Thanks,
> Amir.
> 

