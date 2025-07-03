Return-Path: <linux-fsdevel+bounces-53852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A4AF8381
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 00:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4F23AC5F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189512BF3D7;
	Thu,  3 Jul 2025 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeaLb3kn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66709239E6B;
	Thu,  3 Jul 2025 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582150; cv=none; b=otcSxaGVtAQZj+Mfl7zjNLsIqmVBn416EUXTQmlee7EgoTsNvsZfHR96L/zfwBguHq8Yx85SASgF5obdbxs4poTkNGbG7ypfw6zBAfLvktlJyXKLlhhQMfckf3pRvz7Mut4PSTIs8TVwI4WApGyxC1JG/BRdp1iCAQoCt9orj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582150; c=relaxed/simple;
	bh=AlJk2xQunl62/+VSHOBeCHmjXQob70EjT8VDdy6SYyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4aWMsPsuGkDfCwYF3CJHE+O0bbnpyiXRnY0IgKPLP2qfeIcx4vcvD2JtiPnYrFHrzbhew2sdOIVqyu8PGq96PU55U9vmkt7/wPLWVAE3vQKL11cmEMc+J7PqxJshxo9VP4DnUgeLPJjKSHODyY684B+XwJCD+Ye4Q2zhmNmz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeaLb3kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D785C4CEE3;
	Thu,  3 Jul 2025 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751582150;
	bh=AlJk2xQunl62/+VSHOBeCHmjXQob70EjT8VDdy6SYyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeaLb3kn+WHfZRnrdLxOLSD/6uJyDJUkSuZRSJF7uUrUz5MYOOBey3B4sAhmUx8YU
	 FvNvLp8hpODDXoDg2TbNgdW95pg+nerBvKl3JujNgWn/sE4k8xXAjBmLvPeMmEX6cL
	 /vNlU4yKBhkzzsCroEDOH0poaKFGjVDlBSIz36866iQ5UEN/d+Ojgd52WBsgP6EJR0
	 v8/KhooaC1xWsWo1rooyhDokq5+Y4VbZSlZWdpS9lrWnquXLElQp1W9RAhNP5zY7qn
	 wR3sOHGJ8eEfH5yoPRC8YZSUN/rg8LZSSGJ19zLhfASR5X/r7+6ZDR12gzUZcgj4pR
	 XDERRPCfKGoBA==
Date: Thu, 3 Jul 2025 15:35:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250703223549.GA2672029@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250702-stagnation-dackel-294bb4cd9f3d@brauner>
 <CAOQ4uximwjYabeO=-ktMtnzMsx6KXBs=pUsgNno=_qgpQnpHCA@mail.gmail.com>
 <20250702183750.GW10009@frogsfrogsfrogs>
 <20250703-restlaufzeit-baurecht-9ed44552b481@brauner>
 <CAOQ4uxjouOA+RkiVQ8H11nNVcsi24qOujruqKgfajOCKP1SMpQ@mail.gmail.com>
 <20250703-haufen-problemlos-c2569d208bd8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703-haufen-problemlos-c2569d208bd8@brauner>

On Thu, Jul 03, 2025 at 10:46:30AM +0200, Christian Brauner wrote:
> On Thu, Jul 03, 2025 at 10:42:27AM +0200, Amir Goldstein wrote:
> > On Thu, Jul 3, 2025 at 10:28 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Wed, Jul 02, 2025 at 11:37:50AM -0700, Darrick J. Wong wrote:
> > > > On Wed, Jul 02, 2025 at 03:43:28PM +0200, Amir Goldstein wrote:
> > > > > On Wed, Jul 2, 2025 at 2:40 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > >
> > > > > > > Er... "fsx_fileattr" is the struct that the system call uses?
> > > > > > >
> > > > > > > That's a little confusing considering that xfs already has a
> > > > > > > xfs_fill_fsxattr function that actually fills a struct fileattr.
> > > > > > > That could be renamed xfs_fill_fileattr.
> > > > > > >
> > > > > > > I dunno.  There's a part of me that would really rather that the
> > > > > > > file_getattr and file_setattr syscalls operate on a struct file_attr.
> > > > > >
> > > > > > Agreed, I'm pretty sure I suggested this during an earlier review. Fits
> > > > > > in line with struct mount_attr and others. Fwiw, struct fileattr (the
> > > > > > kernel internal thing) should've really been struct file_kattr or struct
> > > > > > kernel_file_attr. This is a common pattern now:
> > > > > >
> > > > > > struct mount_attr vs struct mount_kattr
> > > > > >
> > > > > > struct clone_args vs struct kernel_clone_kargs
> > > > > >
> > > > > > etc.
> > > > > >file_attr
> > > > >
> > > > > I can see the allure, but we have a long history here with fsxattr,
> > > > > so I think it serves the users better to reference this history with
> > > > > fsxattr64.
> > > >
> > > > <shrug> XFS has a long history with 'struct fsxattr' (the structure you
> > > > passed to XFS_IOC_FSGETXATTR) but the rest of the kernel needn't be so
> > > > fixated upon the historical name.  ext4/f2fs/overlay afaict are just
> > > > going along for the ride.
> > > >
> > > > IOWs I like brauner's struct file_attr and struct file_kattr
> > > > suggestions.
> > > >
> > > > > That, and also, avoid the churn of s/fileattr/file_kattr/
> > > > > If you want to do this renaming, please do it in the same PR
> > > > > because I don't like the idea of having both file_attr and fileattr
> > > > > in the tree for an unknown period.
> > > >
> > > > But yeah, that ought to be a treewide change done at the same time.
> > >
> > > Why do you all hate me? ;)
> > > See the appended patch.
> > 
> > This looks obviously fine, but I wonder how much conflicts that would
> > cause in linux-next?
> > It may just be small enough to get by.
> 
> With such changes that's always a possibility but really I'll just
> provide a branch with the resolutions for Linus to pull.

<nod> That looks good to me. :)

At worst you can always ask Linus "Hey I want to do a treewide name
change of $X to $Y, can I stuff that in at the very end of the merge
window?" and IME he'll let you do that.  Even better if someone keeps
him supplied with fresh change patches.

--D

