Return-Path: <linux-fsdevel+bounces-63753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925DBCCCC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3DA3A54DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB091217704;
	Fri, 10 Oct 2025 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gikhRvMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CB1494CC;
	Fri, 10 Oct 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096720; cv=none; b=OnyYcdfyskMmNpfALVCURKlqTLNfcd2YpTpmPuClidgcyUn0CmT6GqxjLYfItUEimsI65oqJTiLYgWRuBa372UkPtN0UY8ImHTefcboaapJyt1cDCV471FJr0yjxivdwU2yzIEogJXu2ke9zyhMr36qXAvjGHWHuqEU2cYO1Yfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096720; c=relaxed/simple;
	bh=ziouyjwySw3UWuW8tL6Q6l7Pc4+Kgy16ZCEvsUCbGbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af4dyyr2340V9eaUx5MO3D3xPTZLDgRDCSV+RsDMJuGjQIUufHH1wJecHmJ+wW5zDH7J2HGh2E8Q/myejMmHNfSx1XhIcnAkXbaq5Gw3FbdZWCVBfaeNm31Jqnf8Y0+SOYi9q4WPcw3OUzyGW1Wd0v+pRLy/u1j69TNygdsYFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gikhRvMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C38C4CEF1;
	Fri, 10 Oct 2025 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760096719;
	bh=ziouyjwySw3UWuW8tL6Q6l7Pc4+Kgy16ZCEvsUCbGbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gikhRvMlwqEPykhS9jg3m/YakpwPEgbjbuQnlVW5St6YgVs/a78tSLo36C54z+YDc
	 TmSZE4vCfvYHq5tmQcNjHMt99Q0ym81gtY/MV0S8i60V8Qh/oA0FYmYlT9VMEd32FV
	 p6tjOX8tPn+01Qh9Zjw2lW+R5+VO/HxCc3oCIFxabB4O8lsGAzC9o4zvP2YT9SzlxY
	 FPzgHpERkWSyLdMY/AsZNd27o59eJ0UsmKFHskJz9kiy9569QA4mpNhvS/2FkMUjeV
	 8WdGegJDyk+zmFkuFzxfyUp9FBoCjTuskW+UkOjaccXj7wG2KiLbhbJIxJG0y6V2yR
	 5iNrrjzBy84bQ==
Date: Fri, 10 Oct 2025 13:45:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr
 syscalls
Message-ID: <20251010-schachfiguren-blutkonserven-9707ac22a0e2@brauner>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
 <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
 <20251009172041.GA6174@frogsfrogsfrogs>
 <q6phvrrl2fumjwwd66d5glauch76uca4rr5pkvl2dwaxzx62bm@sjcixwa7r6r5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <q6phvrrl2fumjwwd66d5glauch76uca4rr5pkvl2dwaxzx62bm@sjcixwa7r6r5>

On Fri, Oct 10, 2025 at 12:05:04PM +0200, Andrey Albershteyn wrote:
> On 2025-10-09 10:20:41, Darrick J. Wong wrote:
> > On Wed, Oct 08, 2025 at 02:44:18PM +0200, Andrey Albershteyn wrote:
> > > These syscalls call to vfs_fileattr_get/set functions which return
> > > ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
> > > inode. For syscalls EOPNOTSUPP would be more appropriate return error.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/file_attr.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > > index 460b2dd21a85..5e3e2aba97b5 100644
> > > --- a/fs/file_attr.c
> > > +++ b/fs/file_attr.c
> > > @@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
> > >  	}
> > >  
> > >  	error = vfs_fileattr_get(filepath.dentry, &fa);
> > > +	if (error == -ENOIOCTLCMD)
> > 
> > Hrm.  Back in 6.17, XFS would return ENOTTY if you called ->fileattr_get
> > on a special file:
> > 
> > int
> > xfs_fileattr_get(
> > 	struct dentry		*dentry,
> > 	struct file_kattr	*fa)
> > {
> > 	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
> > 
> > 	if (d_is_special(dentry))
> > 		return -ENOTTY;
> > 	...
> > }
> > 
> > Given that there are other fileattr_[gs]et implementations out there
> > that might return ENOTTY (e.g. fuse servers and other externally
> > maintained filesystems), I think both syscall functions need to check
> > for that as well:
> > 
> > 	if (error == -ENOIOCTLCMD || error == -ENOTTY)
> > 		return -EOPNOTSUPP;
> 
> Make sense (looks like ubifs, jfs and gfs2 also return ENOTTY for
> special files), I haven't found ENOTTY being used for anything else
> there

I'm folding this in.

