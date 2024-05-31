Return-Path: <linux-fsdevel+bounces-20638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8728D64E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186D61C25B0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E23768F0;
	Fri, 31 May 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlLNKRne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBB76056;
	Fri, 31 May 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167125; cv=none; b=LSmWbGFEDRAbHQTKutojinbVZb5BU+yeF1VXst0IvDi9RKcl8Z6kg9sOamgfGHLtW0mo4Wx5KsGy/B1vPw8+if/fhfKLcjbmnNStckicYE84Gj6WEIxTKQPMGKxTAmBAgohaH1F087HGvQZDfwRUOudiJ6tpIXi00UMOVlLP9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167125; c=relaxed/simple;
	bh=hzo9KAzzzXmogiiArl5dNeq1whTMmlBGgy2PXnwl1Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGEOngzhNPDLp1pDBzdUPtCCn4VKkv+NhPLeS5tUaZQNb1BXDz135oQYbq0nkNkXAP/ejvuLA3VL49eW2Iatih6WC4eohqECwNIoLdRiOGIaFtn+ep5cie/WqXL4INhNaKs9hnP7+HMF7NUCGWCPyQcPu192d1ybiuxUxqNYv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlLNKRne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA75AC116B1;
	Fri, 31 May 2024 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167124;
	bh=hzo9KAzzzXmogiiArl5dNeq1whTMmlBGgy2PXnwl1Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlLNKRneXjOIFxaxoz4i1wecJfTu6d0fk6gEGRm1chmrFbeOvRygmVe8aFwayzQ4N
	 UHiuqX+YMmuSOvlMjQeCunisAbCQVD5b5z/VsaRsqxCHdnZR411UXfTQQoHmQN9s2C
	 zuCOWL1NsRc34LRvAu8qhZSNXME1zSe47lzgTQ6RSu7qWFTJv2K8RWjYiOPyNXuzPm
	 hULHSctfCHue6ajBNjGuQ+BgT4w68AKNl3J4/wkMVvHVbJmFSaIHdENiDt+75i64rz
	 Y0rmTd7tsM6iWvg2NhKoWuZgmF7/G9Znu4yGsK0YafLvwtH8P/BXgXIa+/9REBs4Y6
	 1G97GswnEu4Mg==
Date: Fri, 31 May 2024 07:52:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240531145204.GJ52987@frogsfrogsfrogs>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3>
 <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524161101.yyqacjob42qjcbnb@quack3>

On Fri, May 24, 2024 at 06:11:01PM +0200, Jan Kara wrote:
> On Thu 23-05-24 13:16:48, Andrey Albershteyn wrote:
> > On 2024-05-23 09:48:28, Jan Kara wrote:
> > > Hi!
> > > 
> > > On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > > > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > > > Hello!
> > > > > 
> > > > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > > > XFS has project quotas which could be attached to a directory. All
> > > > > > new inodes in these directories inherit project ID set on parent
> > > > > > directory.
> > > > > > 
> > > > > > The project is created from userspace by opening and calling
> > > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > > > ID. Those inodes then are not shown in the quota accounting but
> > > > > > still exist in the directory.
> > > > > > 
> > > > > > This patch adds two new ioctls which allows userspace, such as
> > > > > > xfs_quota, to set project ID on special files by using parent
> > > > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > > > inodes and also reset it when project is removed. Also, as
> > > > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > > > forbid any other attributes except projid and nextents (symlink can
> > > > > > have one).
> > > > > > 
> > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > 
> > > > > I'd like to understand one thing. Is it practically useful to set project
> > > > > IDs for special inodes? There is no significant disk space usage associated
> > > > > with them so wrt quotas we are speaking only about the inode itself. So is
> > > > > the concern that user could escape inode project quota accounting and
> > > > > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > > > > for something that seems as a small corner case to me?
> > > > 
> > > > So there's few things:
> > > > - Quota accounting is missing only some special files. Special files
> > > >   created after quota project is setup inherit ID from the project
> > > >   directory.
> > > > - For special files created after the project is setup there's no
> > > >   way to make them project-less. Therefore, creating a new project
> > > >   over those will fail due to project ID miss match.
> > > > - It wasn't possible to hardlink/rename project-less special files
> > > >   inside a project due to ID miss match. The linking is fixed, and
> > > >   renaming is worked around in first patch.
> > > > 
> > > > The initial report I got was about second and last point, an
> > > > application was failing to create a new project after "restart" and
> > > > wasn't able to link special files created beforehand.
> > > 
> > > I see. OK, but wouldn't it then be an easier fix to make sure we *never*
> > > inherit project id for special inodes? And make sure inodes with unset
> > > project ID don't fail to be linked, renamed, etc...
> > 
> > But then, in set up project, you can cross-link between projects and
> > escape quota this way. During linking/renaming if source inode has
> > ID but target one doesn't, we won't be able to tell that this link
> > is within the project.
> 
> Well, I didn't want to charge these special inodes to project quota at all
> so "escaping quota" was pretty much what I suggested to do. But my point
> was that since the only thing that's really charged for these inodes is the
> inodes itself then does this small inaccuracy really matter in practice?
> Are we afraid the user is going to fill the filesystem with symlinks?

I thought the worry here is that you can't fully reassign the project
id for a directory tree unless you have an *at() version of the ioctl
to handle the special files that you can't open directly?

So you start with a directory tree that's (say) 2% symlinks and project
id 5.  Later you want to set project id 7 on that subtree, but after the
incomplete change, projid 7 is charged for 98% of the tree, and 2% are
still stuck on projid 5.  This is a mess, and if enforcement is enabled
you've just broken it in a way that can't be fixed aside from recreating
those files.

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

