Return-Path: <linux-fsdevel+bounces-21007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD58FC0DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ECF1F23552
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C93257B;
	Wed,  5 Jun 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/frZdgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFE17D2;
	Wed,  5 Jun 2024 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547877; cv=none; b=MSpyo0znv34+B+tOMgHNCmmM1ppYanlh4p3pqWwQ/CFtnGLmVeSdZAOz+1mR/eXvb9RR6NI7nOxKvjANSjnAR/IJiSi3EEY1Oww+UZOxUYfteb1VArfYyqOyX42QJwcHOpcu7nd+aGB4tN7HwCnvnbN0vTHiTR3gjQcJU3drELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547877; c=relaxed/simple;
	bh=MsU08HHsxHeQbGD4Wl3i5+Z2PYwo6GFP1KcWDbVKV88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7yRQaxVKvl2imkX+XJgxq8NsVE8ZbWbTAZ+EBqKeZeWDM6W7QywL0LpgdCViIGJnQcdXSBgdfGrWNwGTWOCnwLZNwY6PiT6JgNZU1DYkFXZvGdBtqJCNVXvo89azNiJojpFNPscXtOFZJRc6lXs3p+8yhvCPST3DRh0edhO6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/frZdgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32AFC2BBFC;
	Wed,  5 Jun 2024 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547876;
	bh=MsU08HHsxHeQbGD4Wl3i5+Z2PYwo6GFP1KcWDbVKV88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/frZdgH0L5glNRtkd+VGSbcRoaab/BbN3mnFVTca3Pvog5722ZbMw2o5sEjcdhgr
	 EprBZHpVD65HJFVKeSOJzVtTqylCXynhygqCvXpgmuyxiQouwqHFBzNjifWUPBBx9o
	 btgWevO5quotw1I/TWS/E9HNroTANJ0jGI5oBwKw11RgjTXX/1XROfSks2cSMhtUc2
	 YVo+0CTT2z8j0zynrHFGO9TGjmAkXHfZboKG2AObLdc8YMVECHJorOsXwjHZ7d08MA
	 muIOYB9NukKa4oEmifc3qtqh/gGHscK2L+Zh6iDNvQPptNZ8RcKJU08KZU6Q/pBE2U
	 cqljDPyTywrNQ==
Date: Tue, 4 Jun 2024 17:37:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240605003756.GH52987@frogsfrogsfrogs>
References: <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3>
 <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
 <20240604085843.q6qtmtitgefioj5m@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604085843.q6qtmtitgefioj5m@quack3>

On Tue, Jun 04, 2024 at 10:58:43AM +0200, Jan Kara wrote:
> On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> > On Mon, Jun 03, 2024 at 06:28:47PM +0200, Andrey Albershteyn wrote:
> > > On 2024-06-03 12:42:59, Jan Kara wrote:
> > > > On Fri 31-05-24 07:52:04, Darrick J. Wong wrote:
> > > > > On Fri, May 24, 2024 at 06:11:01PM +0200, Jan Kara wrote:
> > > > > > On Thu 23-05-24 13:16:48, Andrey Albershteyn wrote:
> > > > > > > On 2024-05-23 09:48:28, Jan Kara wrote:
> > > > > > > > Hi!
> > > > > > > > 
> > > > > > > > On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > > > > > > > > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > > > > > > > > Hello!
> > > > > > > > > > 
> > > > > > > > > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > > > > > > > > XFS has project quotas which could be attached to a directory. All
> > > > > > > > > > > new inodes in these directories inherit project ID set on parent
> > > > > > > > > > > directory.
> > > > > > > > > > > 
> > > > > > > > > > > The project is created from userspace by opening and calling
> > > > > > > > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > > > > > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > > > > > > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > > > > > > > > ID. Those inodes then are not shown in the quota accounting but
> > > > > > > > > > > still exist in the directory.
> > > > > > > > > > > 
> > > > > > > > > > > This patch adds two new ioctls which allows userspace, such as
> > > > > > > > > > > xfs_quota, to set project ID on special files by using parent
> > > > > > > > > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > > > > > > > > inodes and also reset it when project is removed. Also, as
> > > > > > > > > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > > > > > > > > forbid any other attributes except projid and nextents (symlink can
> > > > > > > > > > > have one).
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > > > > > > 
> > > > > > > > > > I'd like to understand one thing. Is it practically useful to set project
> > > > > > > > > > IDs for special inodes? There is no significant disk space usage associated
> > > > > > > > > > with them so wrt quotas we are speaking only about the inode itself. So is
> > > > > > > > > > the concern that user could escape inode project quota accounting and
> > > > > > > > > > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > > > > > > > > > for something that seems as a small corner case to me?
> > > > > > > > > 
> > > > > > > > > So there's few things:
> > > > > > > > > - Quota accounting is missing only some special files. Special files
> > > > > > > > >   created after quota project is setup inherit ID from the project
> > > > > > > > >   directory.
> > > > > > > > > - For special files created after the project is setup there's no
> > > > > > > > >   way to make them project-less. Therefore, creating a new project
> > > > > > > > >   over those will fail due to project ID miss match.
> > > > > > > > > - It wasn't possible to hardlink/rename project-less special files
> > > > > > > > >   inside a project due to ID miss match. The linking is fixed, and
> > > > > > > > >   renaming is worked around in first patch.
> > > > > > > > > 
> > > > > > > > > The initial report I got was about second and last point, an
> > > > > > > > > application was failing to create a new project after "restart" and
> > > > > > > > > wasn't able to link special files created beforehand.
> > > > > > > > 
> > > > > > > > I see. OK, but wouldn't it then be an easier fix to make sure we *never*
> > > > > > > > inherit project id for special inodes? And make sure inodes with unset
> > > > > > > > project ID don't fail to be linked, renamed, etc...
> > > > > > > 
> > > > > > > But then, in set up project, you can cross-link between projects and
> > > > > > > escape quota this way. During linking/renaming if source inode has
> > > > > > > ID but target one doesn't, we won't be able to tell that this link
> > > > > > > is within the project.
> > > > > > 
> > > > > > Well, I didn't want to charge these special inodes to project quota at all
> > > > > > so "escaping quota" was pretty much what I suggested to do. But my point
> > > > > > was that since the only thing that's really charged for these inodes is the
> > > > > > inodes itself then does this small inaccuracy really matter in practice?
> > > > > > Are we afraid the user is going to fill the filesystem with symlinks?
> > > > > 
> > > > > I thought the worry here is that you can't fully reassign the project
> > > > > id for a directory tree unless you have an *at() version of the ioctl
> > > > > to handle the special files that you can't open directly?
> > > > > 
> > > > > So you start with a directory tree that's (say) 2% symlinks and project
> > > > > id 5.  Later you want to set project id 7 on that subtree, but after the
> > > > > incomplete change, projid 7 is charged for 98% of the tree, and 2% are
> > > > > still stuck on projid 5.  This is a mess, and if enforcement is enabled
> > > > > you've just broken it in a way that can't be fixed aside from recreating
> > > > > those files.
> > > > 
> > > > So the idea I'm trying to propose (and apparently I'm failing to explain it
> > > > properly) is:
> > > > 
> > > > When creating special inode, set i_projid = 0 regardless of directory
> > > > settings.
> > > > 
> > > > When creating hardlink or doing rename, if i_projid of dentry is 0, we
> > > > allow the operation.
> > > > 
> > > > Teach fsck to set i_projid to 0 when inode is special.
> > > > 
> > > > As a result, AFAICT no problem with hardlinks, renames or similar. No need
> > > > for special new ioctl or syscall. The downside is special inodes escape
> > > > project quota accounting. Do we care?
> > > 
> > > I see. But is it fine to allow fill filesystem with special inodes?
> > > Don't know if it can be used somehow but this is exception from
> > > isoft/ihard limits then.
> > > 
> > > I don't see issues with this approach also, if others don't have
> > > other points or other uses for those new syscalls, I can go with
> > > this approach.
> > 
> > I do -- allowing unpriviledged users to create symlinks that consume
> > icount (and possibly bcount) in the root project breaks the entire
> > enforcement mechanism.  That's not the way that project quota has worked
> > on xfs and it would be quite rude to nullify the PROJINHERIT flag bit
> > only for these special cases.
> 
> OK, fair enough. I though someone will hate this. I'd just like to
> understand one thing: Owner of the inode can change the project ID to 0
> anyway so project quotas are more like a cooperative space tracking scheme
> anyway. If you want to escape it, you can. So what are you exactly worried
> about? Is it the container usecase where from within the user namespace you
> cannot change project IDs?

Yep.

> Anyway I just wanted to have an explicit decision that the simple solution
> is not good enough before we go the more complex route ;).

Also, every now and then someone comes along and half-proposes making it
so that non-root cannot change project ids anymore.  Maybe some day that
will succeed.

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

