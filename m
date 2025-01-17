Return-Path: <linux-fsdevel+bounces-39548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A2A157B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 20:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FE93A2908
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA191A83F5;
	Fri, 17 Jan 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joSh6hxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606651A7264;
	Fri, 17 Jan 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140399; cv=none; b=f7kR2uwrYHoNSCj8vof4POMzNSeyaHhZ8SKZx7Ka6otn+lSrni2rIhi4WTxx9TU9itfgAaK+Dy4J8rXRSJRi+C+iczXWmoVqYphyBA3RA6qxUk4kA7v21RxNLrkJLOeODdlb660+iGlLqc7ttI193bcgXbNy+pOt0tQH2UcNdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140399; c=relaxed/simple;
	bh=IIYH1QtR7cDugeuJHjDQBtGd2ezmKCnzrfSl2UNAs48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njFOVHEiMaaoxRD3CMBGPRZsKUHOpTW/loQa4Lw5JpHSdGuvvOGzYihiRYyL1kuML5Bto56g+xF6X+9NBtk+ZGt6PW7omyErlRsOCgdb3aDHLkGrg4fhBLSes98v2ZwDh6R5SwQ0qpwAD06RQQ2JucAu2pZtT+13ZMOo4eC26AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joSh6hxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6723C4CEDD;
	Fri, 17 Jan 2025 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737140399;
	bh=IIYH1QtR7cDugeuJHjDQBtGd2ezmKCnzrfSl2UNAs48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joSh6hxauuVE4FpYIthWuQv5DdpHci197aOTrXTfzEBCq+bjPjfGIzjY7zYTVtwMU
	 yTlM7A9G92IAuhHTskU2N678XNNbZzLxkLx31n8dgtq1TdtkxkF/j0/2zw6U7ibUt5
	 4qstX46Kj7+ev5Hn1bAAGZvlYC5jZckbrA9BUL5Kyqo5jIVKAoG7nCwsTJJ/ckBY30
	 fOPAqkP6b1+R1xknJ5ktv32Y1iMHPwz2Z8EmGpZUSvJLjKQKgAETIEgK5uiDPwGhJs
	 Bn7wT2h49O3PTA4s9laS1OL1LdmHXtu/Jacx/XhvXbjD/o3IXkn+cxw93AwIkzu/j4
	 DuK0ntuAaltMg==
Received: by pali.im (Postfix)
	id 366737A1; Fri, 17 Jan 2025 19:59:47 +0100 (CET)
Date: Fri, 17 Jan 2025 19:59:47 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250117185947.ylums2dhmo3j6hol@pali>
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
User-Agent: NeoMutt/20180716

On Friday 17 January 2025 19:46:30 Amir Goldstein wrote:
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

Yes, you understood it correctly. I was asking for standardizing API how
to get/set these attributes from userspace. And Chuck wrote that would
like to have also standardized it for kernel consumers like nfsd or
ksmbd. Which makes sense.

> Nevertheless, I understand the confusion because I know there
> is also demand for storing those attributes by file servers in a
> standard way and for vfs to respect those attributes on the host.

Userspace fileserver, like Samba, would just use that standardized
userspace API for get/set attributes. And in-kernel fileservers like
nfsd or ksmbd would like to use that API too.

And there were some proposals how filesystems without native
support for these attributes could store and preserve these attributes.
So this can be a confusion in this email thread discussion.

> Full disclosure - I have an out of tree xfs patch that implements
> ioctls XFS_IOC_[GS]ETDOSATTRAT and stashes these
> attributes in the unused di_dmevmask space.
> 
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

So you would also benefit from standardizing of API for these attributes
as then you could implement that API for xfs.

