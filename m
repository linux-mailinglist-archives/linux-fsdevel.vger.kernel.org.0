Return-Path: <linux-fsdevel+bounces-53780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E9AF6D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB9952449B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FF2D322C;
	Thu,  3 Jul 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsodEsW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B21D63F0;
	Thu,  3 Jul 2025 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532396; cv=none; b=fHCWcdMCufuyVYwnmEJrQSWzYrH85/xoAH5QbjE9MImJAHIbaWlHze0a9axAFpuHd49Wc1LjrN6wMGifAQ4EVQcjvLpJdekioLsU+EbaisN1XSflSiP/e1blB03c+b3fxrifdSsUMs/zOHXHx58bjige3IWBScXf2Qv5Ac+CyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532396; c=relaxed/simple;
	bh=N3F0YfTU14Bdzkrb+Vya0WNvwRnCq7n/y/mLYwUwtdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW6He1+CnXiBfViKdpGGZFXxS4zzVsP2H9sAApFftX+N9Dz++PRSaBH3fhBSU9pmBShcyRbnKeEN0NvB9Bu28QYkcHhzbTTcHF1ZqUyd8DpS4dF12IZ62y9Xlv+GRFLulzhK91abwPXZlmdogA9+iws0mST/RpoFsH4zRGST728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsodEsW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CE6C4CEE3;
	Thu,  3 Jul 2025 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751532396;
	bh=N3F0YfTU14Bdzkrb+Vya0WNvwRnCq7n/y/mLYwUwtdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsodEsW3xvLfHNF3bR4IF6OSGD/uneAvcgddtue0WFyNvYS1C5HVD/4pPkGhizX5N
	 PfwAItZxlAY/p+x5scC8ZhiSxETIdCc/Ft8n126TzIJ0ch1c4/IZYpcv1YPJj8/Yx6
	 V1YIeCDhWWXWbh2qWzGxcohXWGPVnbHNbpIB0M1OC3+HBL01yUZxnJCU+9299VSQ0u
	 UDmR2iAGrOVmZrgIXM6w1j70DDf8odGpKp+8siCiTw3mvJIXFU8swBXvgfLlqJCeB4
	 +VHefz6ZJDVEE27kJN3o3XiXNwaUI5EG4MwKaZlGCw/25rkgc5t9XssyLSrVpVr4iD
	 NdBuAUCno7xeA==
Date: Thu, 3 Jul 2025 10:46:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250703-haufen-problemlos-c2569d208bd8@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250702-stagnation-dackel-294bb4cd9f3d@brauner>
 <CAOQ4uximwjYabeO=-ktMtnzMsx6KXBs=pUsgNno=_qgpQnpHCA@mail.gmail.com>
 <20250702183750.GW10009@frogsfrogsfrogs>
 <20250703-restlaufzeit-baurecht-9ed44552b481@brauner>
 <CAOQ4uxjouOA+RkiVQ8H11nNVcsi24qOujruqKgfajOCKP1SMpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjouOA+RkiVQ8H11nNVcsi24qOujruqKgfajOCKP1SMpQ@mail.gmail.com>

On Thu, Jul 03, 2025 at 10:42:27AM +0200, Amir Goldstein wrote:
> On Thu, Jul 3, 2025 at 10:28 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Jul 02, 2025 at 11:37:50AM -0700, Darrick J. Wong wrote:
> > > On Wed, Jul 02, 2025 at 03:43:28PM +0200, Amir Goldstein wrote:
> > > > On Wed, Jul 2, 2025 at 2:40 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > > Er... "fsx_fileattr" is the struct that the system call uses?
> > > > > >
> > > > > > That's a little confusing considering that xfs already has a
> > > > > > xfs_fill_fsxattr function that actually fills a struct fileattr.
> > > > > > That could be renamed xfs_fill_fileattr.
> > > > > >
> > > > > > I dunno.  There's a part of me that would really rather that the
> > > > > > file_getattr and file_setattr syscalls operate on a struct file_attr.
> > > > >
> > > > > Agreed, I'm pretty sure I suggested this during an earlier review. Fits
> > > > > in line with struct mount_attr and others. Fwiw, struct fileattr (the
> > > > > kernel internal thing) should've really been struct file_kattr or struct
> > > > > kernel_file_attr. This is a common pattern now:
> > > > >
> > > > > struct mount_attr vs struct mount_kattr
> > > > >
> > > > > struct clone_args vs struct kernel_clone_kargs
> > > > >
> > > > > etc.
> > > > >file_attr
> > > >
> > > > I can see the allure, but we have a long history here with fsxattr,
> > > > so I think it serves the users better to reference this history with
> > > > fsxattr64.
> > >
> > > <shrug> XFS has a long history with 'struct fsxattr' (the structure you
> > > passed to XFS_IOC_FSGETXATTR) but the rest of the kernel needn't be so
> > > fixated upon the historical name.  ext4/f2fs/overlay afaict are just
> > > going along for the ride.
> > >
> > > IOWs I like brauner's struct file_attr and struct file_kattr
> > > suggestions.
> > >
> > > > That, and also, avoid the churn of s/fileattr/file_kattr/
> > > > If you want to do this renaming, please do it in the same PR
> > > > because I don't like the idea of having both file_attr and fileattr
> > > > in the tree for an unknown period.
> > >
> > > But yeah, that ought to be a treewide change done at the same time.
> >
> > Why do you all hate me? ;)
> > See the appended patch.
> 
> This looks obviously fine, but I wonder how much conflicts that would
> cause in linux-next?
> It may just be small enough to get by.

With such changes that's always a possibility but really I'll just
provide a branch with the resolutions for Linus to pull.

