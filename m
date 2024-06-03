Return-Path: <linux-fsdevel+bounces-20854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20C8D8825
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 19:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDAB1C210DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EAF13793E;
	Mon,  3 Jun 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxlPArW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26637135A6F;
	Mon,  3 Jun 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436581; cv=none; b=sl/b50+Y/CE2Vgm61B/BZZYWWYaVitxG85AQJmljxGEH2PjvLZnC4xk0O8PLAxZ40AofdzcX+hiu6PfzfKhK4tfolvruZLBv+O2f3S3MwGYv6/EesgxR1C0+uU4YGIKTgNWOJvQ9s37jUurHjKG2z+YPd/7mhaKo4mxUZUKjTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436581; c=relaxed/simple;
	bh=hIxy2bx8fNNBpnTyJJOZ7XbXCWF96L9ofSKPAz0+bnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZiiVPAdHHgZuxyNYKaproh7RLkI+BsEef9j8AeD8OpqHDAwUFJpputydu/8A5mcN1IrnfFf+1+sF4/0oVqWMheT1Wh6EuuhBpoR5BVX1YgxtFrclgtIn7KzNKpBqjLMKKBLcumCtpJXSvEhELeg65OUY01nTQbGB3hvESp6USo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxlPArW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993F4C2BD10;
	Mon,  3 Jun 2024 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717436580;
	bh=hIxy2bx8fNNBpnTyJJOZ7XbXCWF96L9ofSKPAz0+bnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxlPArW37HDa9ni/ok/nGOJRcgl2jwdzw/QG5RmciGMtoyeoD/Z8Bnfm2wjkRN6cs
	 0PGPh7DaFQAzu5T5eEiRKmeJdoqAkQ5qMF9fzTTzQFSZo6lfMx7vlCjTeuHTAjZmot
	 yJdr0igDIZIklJmr8OaGR2/wS3DKsuriMO4/clmjfvX18jDwVGyPjij+vXLii5m1sF
	 GNIXFL+IabzFEbhOn/rzgdFnKDSJ+cKOy+Xdk2uWwhq8W92vUb4FBY11RXjKqBJMEc
	 /XKR8SFB3Z3KbNvgpaxIoWNM0pPghkS+/Iq2uXypRxWn1MQ2VaF6m8Lla9TonQREex
	 mbfCaqaKLo0Ug==
Date: Mon, 3 Jun 2024 10:42:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240603174259.GB52987@frogsfrogsfrogs>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3>
 <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>

On Mon, Jun 03, 2024 at 06:28:47PM +0200, Andrey Albershteyn wrote:
> On 2024-06-03 12:42:59, Jan Kara wrote:
> > On Fri 31-05-24 07:52:04, Darrick J. Wong wrote:
> > > On Fri, May 24, 2024 at 06:11:01PM +0200, Jan Kara wrote:
> > > > On Thu 23-05-24 13:16:48, Andrey Albershteyn wrote:
> > > > > On 2024-05-23 09:48:28, Jan Kara wrote:
> > > > > > Hi!
> > > > > > 
> > > > > > On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > > > > > > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > > > > > > Hello!
> > > > > > > > 
> > > > > > > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > > > > > > XFS has project quotas which could be attached to a directory. All
> > > > > > > > > new inodes in these directories inherit project ID set on parent
> > > > > > > > > directory.
> > > > > > > > > 
> > > > > > > > > The project is created from userspace by opening and calling
> > > > > > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > > > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > > > > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > > > > > > ID. Those inodes then are not shown in the quota accounting but
> > > > > > > > > still exist in the directory.
> > > > > > > > > 
> > > > > > > > > This patch adds two new ioctls which allows userspace, such as
> > > > > > > > > xfs_quota, to set project ID on special files by using parent
> > > > > > > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > > > > > > inodes and also reset it when project is removed. Also, as
> > > > > > > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > > > > > > forbid any other attributes except projid and nextents (symlink can
> > > > > > > > > have one).
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > > > > 
> > > > > > > > I'd like to understand one thing. Is it practically useful to set project
> > > > > > > > IDs for special inodes? There is no significant disk space usage associated
> > > > > > > > with them so wrt quotas we are speaking only about the inode itself. So is
> > > > > > > > the concern that user could escape inode project quota accounting and
> > > > > > > > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > > > > > > > for something that seems as a small corner case to me?
> > > > > > > 
> > > > > > > So there's few things:
> > > > > > > - Quota accounting is missing only some special files. Special files
> > > > > > >   created after quota project is setup inherit ID from the project
> > > > > > >   directory.
> > > > > > > - For special files created after the project is setup there's no
> > > > > > >   way to make them project-less. Therefore, creating a new project
> > > > > > >   over those will fail due to project ID miss match.
> > > > > > > - It wasn't possible to hardlink/rename project-less special files
> > > > > > >   inside a project due to ID miss match. The linking is fixed, and
> > > > > > >   renaming is worked around in first patch.
> > > > > > > 
> > > > > > > The initial report I got was about second and last point, an
> > > > > > > application was failing to create a new project after "restart" and
> > > > > > > wasn't able to link special files created beforehand.
> > > > > > 
> > > > > > I see. OK, but wouldn't it then be an easier fix to make sure we *never*
> > > > > > inherit project id for special inodes? And make sure inodes with unset
> > > > > > project ID don't fail to be linked, renamed, etc...
> > > > > 
> > > > > But then, in set up project, you can cross-link between projects and
> > > > > escape quota this way. During linking/renaming if source inode has
> > > > > ID but target one doesn't, we won't be able to tell that this link
> > > > > is within the project.
> > > > 
> > > > Well, I didn't want to charge these special inodes to project quota at all
> > > > so "escaping quota" was pretty much what I suggested to do. But my point
> > > > was that since the only thing that's really charged for these inodes is the
> > > > inodes itself then does this small inaccuracy really matter in practice?
> > > > Are we afraid the user is going to fill the filesystem with symlinks?
> > > 
> > > I thought the worry here is that you can't fully reassign the project
> > > id for a directory tree unless you have an *at() version of the ioctl
> > > to handle the special files that you can't open directly?
> > > 
> > > So you start with a directory tree that's (say) 2% symlinks and project
> > > id 5.  Later you want to set project id 7 on that subtree, but after the
> > > incomplete change, projid 7 is charged for 98% of the tree, and 2% are
> > > still stuck on projid 5.  This is a mess, and if enforcement is enabled
> > > you've just broken it in a way that can't be fixed aside from recreating
> > > those files.
> > 
> > So the idea I'm trying to propose (and apparently I'm failing to explain it
> > properly) is:
> > 
> > When creating special inode, set i_projid = 0 regardless of directory
> > settings.
> > 
> > When creating hardlink or doing rename, if i_projid of dentry is 0, we
> > allow the operation.
> > 
> > Teach fsck to set i_projid to 0 when inode is special.
> > 
> > As a result, AFAICT no problem with hardlinks, renames or similar. No need
> > for special new ioctl or syscall. The downside is special inodes escape
> > project quota accounting. Do we care?
> 
> I see. But is it fine to allow fill filesystem with special inodes?
> Don't know if it can be used somehow but this is exception from
> isoft/ihard limits then.
> 
> I don't see issues with this approach also, if others don't have
> other points or other uses for those new syscalls, I can go with
> this approach.

I do -- allowing unpriviledged users to create symlinks that consume
icount (and possibly bcount) in the root project breaks the entire
enforcement mechanism.  That's not the way that project quota has worked
on xfs and it would be quite rude to nullify the PROJINHERIT flag bit
only for these special cases.

--D

> -- 
> - Andrey
> 
> 

