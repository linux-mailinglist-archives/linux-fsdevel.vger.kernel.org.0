Return-Path: <linux-fsdevel+bounces-20852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62258D874F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA16B1C22D7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B413667F;
	Mon,  3 Jun 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHvb0EoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7F136669
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432137; cv=none; b=lYL7GCNmTQVAQLWzCyTG5bvA+jPNHsusXVRjq3Lr5+YtL1Dd78SwcFXUyhMdheGQtiVCCDsAcrbOJKLVsqtEcdHBINsqtBd2pTT/5sO5wcFpKKbuC0jF+JLWpE1HiHb4XkPp1cqVHi8fqeslwu1WVWmoidHFFmLvFab0pdVHf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432137; c=relaxed/simple;
	bh=KuFznChqzOd1gUXmPzJgm+0RIRoEbVhgMV4ie+CXRDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmvMSxoUWHcyip58lmKeLZfkXUEFa1D5/5/lTti9gjAlizXr6f293vzu1p4IIvckXZXItQupYfJEMCo8UOdW9LyKWzSgcRBQEnY57O/wTG4YEjHumF98k67qw4/DN9CiX1181ALgeaPa3GQAbm+f3uja1BazHrNz+InkQFiqQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHvb0EoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717432134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gr69zdD82WTBY2Lr4lSLLRvR4NuQqJ9ZmIp1I94u60E=;
	b=CHvb0EoEYqV4rFd0ub3tvZ0awsaxyjOtfXYytI6zTMS8hGlq0hzWiKH51QAnzPI25MLzrX
	y7ZiNEWr5X2Vm1OrhyNM8bcwB/qUq+eA3jb4CVIb3znWFnfgrX/9bzd/VRu5ZVzSnZ75T7
	acUxLgBf+GHExnknMhOpF5hl62OJ9eQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-OZw_FV-hPg2ZIq5ARx56hQ-1; Mon, 03 Jun 2024 12:28:51 -0400
X-MC-Unique: OZw_FV-hPg2ZIq5ARx56hQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2eaab1d55deso11966031fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 09:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432129; x=1718036929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr69zdD82WTBY2Lr4lSLLRvR4NuQqJ9ZmIp1I94u60E=;
        b=e7Lno9fOvW0U/71yl9RjU6viTCvkA0gr2NQPD22x7tASu1pzLrT+sNcpZaMI1ur3lh
         0webgQp0GYZEUPAvgVXnQ7vdX8b115JauSy0oO5KIkRpCH4WnKWw3P6INBgcfi6Tmjig
         aggUpbbXJHgqmj3WpbJmXPI5KHkmJYpr0kZK2R7EJQ9MBHiBUxhBAbMTByZisfB4kdhf
         7sU+uIoG8H4+yF7sXT4wzlBtiihGZrNsN1v++aPh7JpAilM9gV6b2+0v68rVUDcNI7Ka
         cR8h2K9pa+yd5A4NZiE0bO0WhzJhxeZbOgG1Ono7SmzR3nacJThsdavA0A493288CV46
         /3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVNoQSvscfNDpAlxJS+ZVomBusBCL5HR6a585I4z68YClcXCmRsMk4Phh+rJXK8KNUFA/b4eV67ciZaSn2hIfVrq4D0klTmqqGF2/KRyw==
X-Gm-Message-State: AOJu0YzTXpYLetbGH0p9gH/H0z1mY2vIiSt3XbubfxLu4IsVWLDGfu5x
	2nhXD384xxCuvlfoOWuuWvvbq64WwbWx9sW4T+Db+JtH3IpY4MMdqk1u1ETMBSkr6E5QFw9pNnj
	ZImcBC10Mh51eoOa+o58fL5VI4JxbJvIh+TsU++b2NSfmYEWMWvPI2/h+u9G4PP4ltFBziw==
X-Received: by 2002:a2e:b818:0:b0:2e9:820a:abfe with SMTP id 38308e7fff4ca-2ea950c0482mr63163291fa.4.1717432129459;
        Mon, 03 Jun 2024 09:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9AAn+3csNvZgBBdGUydEYiz3VwZmVYLYrOLbsB8PEiOImAA15s6ck87JSRtgm/RKJJzRffA==
X-Received: by 2002:a2e:b818:0:b0:2e9:820a:abfe with SMTP id 38308e7fff4ca-2ea950c0482mr63163001fa.4.1717432128823;
        Mon, 03 Jun 2024 09:28:48 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d4b6sm5542876a12.74.2024.06.03.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:28:48 -0700 (PDT)
Date: Mon, 3 Jun 2024 18:28:47 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3>
 <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603104259.gii7lfz2fg7lyrcw@quack3>

On 2024-06-03 12:42:59, Jan Kara wrote:
> On Fri 31-05-24 07:52:04, Darrick J. Wong wrote:
> > On Fri, May 24, 2024 at 06:11:01PM +0200, Jan Kara wrote:
> > > On Thu 23-05-24 13:16:48, Andrey Albershteyn wrote:
> > > > On 2024-05-23 09:48:28, Jan Kara wrote:
> > > > > Hi!
> > > > > 
> > > > > On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > > > > > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > > > > > Hello!
> > > > > > > 
> > > > > > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > > > > > XFS has project quotas which could be attached to a directory. All
> > > > > > > > new inodes in these directories inherit project ID set on parent
> > > > > > > > directory.
> > > > > > > > 
> > > > > > > > The project is created from userspace by opening and calling
> > > > > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > > > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > > > > > ID. Those inodes then are not shown in the quota accounting but
> > > > > > > > still exist in the directory.
> > > > > > > > 
> > > > > > > > This patch adds two new ioctls which allows userspace, such as
> > > > > > > > xfs_quota, to set project ID on special files by using parent
> > > > > > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > > > > > inodes and also reset it when project is removed. Also, as
> > > > > > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > > > > > forbid any other attributes except projid and nextents (symlink can
> > > > > > > > have one).
> > > > > > > > 
> > > > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > > > 
> > > > > > > I'd like to understand one thing. Is it practically useful to set project
> > > > > > > IDs for special inodes? There is no significant disk space usage associated
> > > > > > > with them so wrt quotas we are speaking only about the inode itself. So is
> > > > > > > the concern that user could escape inode project quota accounting and
> > > > > > > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > > > > > > for something that seems as a small corner case to me?
> > > > > > 
> > > > > > So there's few things:
> > > > > > - Quota accounting is missing only some special files. Special files
> > > > > >   created after quota project is setup inherit ID from the project
> > > > > >   directory.
> > > > > > - For special files created after the project is setup there's no
> > > > > >   way to make them project-less. Therefore, creating a new project
> > > > > >   over those will fail due to project ID miss match.
> > > > > > - It wasn't possible to hardlink/rename project-less special files
> > > > > >   inside a project due to ID miss match. The linking is fixed, and
> > > > > >   renaming is worked around in first patch.
> > > > > > 
> > > > > > The initial report I got was about second and last point, an
> > > > > > application was failing to create a new project after "restart" and
> > > > > > wasn't able to link special files created beforehand.
> > > > > 
> > > > > I see. OK, but wouldn't it then be an easier fix to make sure we *never*
> > > > > inherit project id for special inodes? And make sure inodes with unset
> > > > > project ID don't fail to be linked, renamed, etc...
> > > > 
> > > > But then, in set up project, you can cross-link between projects and
> > > > escape quota this way. During linking/renaming if source inode has
> > > > ID but target one doesn't, we won't be able to tell that this link
> > > > is within the project.
> > > 
> > > Well, I didn't want to charge these special inodes to project quota at all
> > > so "escaping quota" was pretty much what I suggested to do. But my point
> > > was that since the only thing that's really charged for these inodes is the
> > > inodes itself then does this small inaccuracy really matter in practice?
> > > Are we afraid the user is going to fill the filesystem with symlinks?
> > 
> > I thought the worry here is that you can't fully reassign the project
> > id for a directory tree unless you have an *at() version of the ioctl
> > to handle the special files that you can't open directly?
> > 
> > So you start with a directory tree that's (say) 2% symlinks and project
> > id 5.  Later you want to set project id 7 on that subtree, but after the
> > incomplete change, projid 7 is charged for 98% of the tree, and 2% are
> > still stuck on projid 5.  This is a mess, and if enforcement is enabled
> > you've just broken it in a way that can't be fixed aside from recreating
> > those files.
> 
> So the idea I'm trying to propose (and apparently I'm failing to explain it
> properly) is:
> 
> When creating special inode, set i_projid = 0 regardless of directory
> settings.
> 
> When creating hardlink or doing rename, if i_projid of dentry is 0, we
> allow the operation.
> 
> Teach fsck to set i_projid to 0 when inode is special.
> 
> As a result, AFAICT no problem with hardlinks, renames or similar. No need
> for special new ioctl or syscall. The downside is special inodes escape
> project quota accounting. Do we care?

I see. But is it fine to allow fill filesystem with special inodes?
Don't know if it can be used somehow but this is exception from
isoft/ihard limits then.

I don't see issues with this approach also, if others don't have
other points or other uses for those new syscalls, I can go with
this approach.

-- 
- Andrey


