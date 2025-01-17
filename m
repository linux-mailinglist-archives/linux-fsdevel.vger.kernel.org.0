Return-Path: <linux-fsdevel+bounces-39553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC8A1587D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 21:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6757A435D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8F1AA78D;
	Fri, 17 Jan 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivx4PVLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37654187550;
	Fri, 17 Jan 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737145273; cv=none; b=VakgUhN7MQUE7GdTYQuYvLA7FtE6NUc+ctm+kJw54TtPEQTYx4FJfuzyD8sVmYP+zZG1L47XUpQd6owDZKtz+PqcaI8stfKKMfSb0SFnyUr/e00DNgqxaCUVCSRKG2JMew0Me5W4w9+X9CQGFOWgJ4vwE0IWT9NTpQlLrXT+1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737145273; c=relaxed/simple;
	bh=ROGQL94JJBV0KRhHzTN8QBzxRtcA0Nf5b5bj344qzLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP7/3DdwyK+WbdryLg1Im3i0H+4NB4CJhvcHUZTBTi+4qOgwISmwW2iH+qX1slS8xYfxb4dwsDVDZkdRnrkdQUBjkuV3Mo+DpLe81E2V8RCU+o1bSN+yNoZvwcoh44rUrmB65SFscRcaYT07BAmUkDdzxYPwd7ro+OZZoLPZMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivx4PVLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973A9C4CEDD;
	Fri, 17 Jan 2025 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737145272;
	bh=ROGQL94JJBV0KRhHzTN8QBzxRtcA0Nf5b5bj344qzLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ivx4PVLh7h2Q0UqMKxmRkBm5loPXAEio0SvK/FSvHIFEwDQDZVHE5oyFqnCA/ol8h
	 cKcsEqjC7Vre1XXhoAdngnm22VpcKyd9jvjo84ty00DNJYtoniCGVJvUVPjUnh/TeT
	 aNT5XpGCq3VMn2M1vYJRsjDZn8I8l6BautNG6utwYxNpcP6dVleekQiEEUwvWhyXqE
	 C1L/XAzjJ8c7d0SoVXaoR0ZY2EUepbMghiNh8M9erao17PBEsinYMobyKjw39w/g1g
	 yVp15TbpDb7xUhaobrksTMTmkDM/GK34jvHOuWSpe8PpBFKBRjBMo+y7oxVXVmwdSt
	 3ZIXXeAZZ+XTA==
Date: Fri, 17 Jan 2025 12:21:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250117202112.GH3561231@frogsfrogsfrogs>
References: <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs>
 <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>

On Fri, Jan 17, 2025 at 07:46:30PM +0100, Amir Goldstein wrote:
> > > Looking at the FILE_ATTRIBUTE_* flags defined in SMB protocol
> > >  (fs/smb/common/smb2pdu.h) I wonder how many of them will be
> > > needed for applications beyond the obvious ones that were listed.
> >
> > Well they only asked for seven of them. ;)
> >
> > I chatted with Ted about this yesterday, and ... some of the attributes
> > (like read only) imply that you'd want the linux server to enforce no
> > writing to the file; some like archive seem a little superfluous since
> > on linux you can compare cmtime from the backup against what's in the
> > file now; and still others (like hidden/system) might just be some dorky
> > thing that could be hidden in some xattr because a unix filesystem won't
> > care.
> >
> > And then there are other attrs like "integrity stream" where someone
> > with more experience with windows would have to tell me if fsverity
> > provides sufficient behaviors or not.
> >
> > But maybe we should start by plumbing one of those bits in?  I guess the
> > gross part is that implies an ondisk inode format change or (gross)
> > xattr lookups in the open path.
> >
> 
> I may be wrong, but I think there is a confusion in this thread.
> I don't think that Pali was looking for filesystems to implement
> storing those attributes. I read his email as a request to standardize
> a user API to get/set those attributes for the filesystems that
> already support them and possibly for vfs to enforce some of them
> (e.g. READONLY) in generic code.
> 
> Nevertheless, I understand the confusion because I know there
> is also demand for storing those attributes by file servers in a
> standard way and for vfs to respect those attributes on the host.
> 
> Full disclosure - I have an out of tree xfs patch that implements
> ioctls XFS_IOC_[GS]ETDOSATTRAT and stashes these
> attributes in the unused di_dmevmask space.

[cc linux-xfs]

Urrrrk, please don't fork the xfs ondisk format!

--D

> Compared to the smb server alternative of storing those attributes
> as xattrs on the server, this saves a *lot* of IO in an SMB file browsing
> workload, where most of the inodes have large (ACL) xattrs that do
> not fit into the inode, because SMB protocol needs to return
> those attributes in a response to READDIR(PLUSPLUS), so
> it needs to read all the external xattr blocks.
> 
> So yeh, I would love to have proper support in xfs...
> 
> Thanks,
> Amir.
> 

