Return-Path: <linux-fsdevel+bounces-43721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D0A5CBD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EB5189627E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A226139C;
	Tue, 11 Mar 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wV2WfSme"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33B184F;
	Tue, 11 Mar 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713340; cv=none; b=AiQQEEwV9qGvQaK3UGQqoJnwOikYS1jTOuMYQkc5FYVV/m7xDr6uMiwTbULpWi1Y7NpO7TVjGX1ULnl1uk1Pb3ryli3771SFhA9wo0JLEDGzh1tmE6Ex42AMPKH9FS/0miRx9YIfRKJg3LZXEf/uYtjFUKOPJ86XdqXUAYPdhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713340; c=relaxed/simple;
	bh=7GwYf8H/UVOUgGvEaGTXe8ehNdJHaeAqqBwpUCWI0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG+PJI628c3puOZ6zIKFUn4D8MuJiKCDCy9gZDor1uslLXhB8bBku+mVM/9dTcoTSftIOJstZw9MllDmNa1oP1Chpqq0Y5hVv62zl7aArWXzQEC/O1u+9qlsVwuGBswdSt3K0U0DGY3ohf0r5L1aFKNPhqqGSEcSPzre2PyTD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wV2WfSme; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Zav/YLsXr1vfKJJ7Fkr452SUDEG7KM2G6lF4jocWYE=; b=wV2WfSmeANrMc+f1qvL1koc03e
	Rfbcr9rgXq6tFmKVXbTcIxLbiAf1U5x7ILvH8AqEj5QDqKd8YOvqe+0yvVH9aGYOZ6NSUshVX0O3v
	wvvj9Bzi42zQgj9wtZPyVL6vDTCi2mz3c8j+IvyFDHVV6xXmc7QowTWf183yUb5BD1lW7PWcippKN
	XgQHPk4NYjhgM7GHPpP9K8bEg+L/7+hykVxzRlcQPgPkxk93oAze/xcN8bbZQ+x8gktZmTV8r9SL9
	mD1e+7S0VC0JgbqQWG4ioOR/bKlwiFaKj2uQYFjY0uuBVkpFKxU8ZuIM3zR+YbNJx2NGazH3qhRNW
	DTFk1uUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ts3CY-00000004vkf-15DV;
	Tue, 11 Mar 2025 17:15:34 +0000
Date: Tue, 11 Mar 2025 17:15:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Ryan Lee <ryan.lee@canonical.com>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	linux-security-module@vger.kernel.org,
	apparmor <apparmor@lists.ubuntu.com>, linux-efi@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	"jk@ozlabs.org" <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org
Subject: Re: apparmor NULL pointer dereference on resume [efivarfs]
Message-ID: <20250311171534.GQ2023217@ZenIV>
References: <e54e6a2f-1178-4980-b771-4d9bafc2aa47@tnxip.de>
 <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
 <465d1d23-3b36-490e-b0dd-74889d17fa4c@tnxip.de>
 <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
 <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
 <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>
 <20250311-visite-rastplatz-d1fdb223dc10@brauner>
 <814a257530ad5e8107ce5f48318ab43a3ef1f783.camel@HansenPartnership.com>
 <20250311-trunk-farben-fe36bebe233a@brauner>
 <78a59e2a5012bfb2d6a653782ab346b44b211102.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a59e2a5012bfb2d6a653782ab346b44b211102.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 11, 2025 at 12:20:05PM -0400, James Bottomley wrote:

> That's the way it's supposed to work, yes.  However, if we move to an
> always persistent superblock and mnt, I was thinking there'd have to be
> an indicator in the sfi about whether the variables were reflected or
> not.

Just have a pointer to superblock set at ->get_tree() and cleared at
the very beginning of ->kill_sb(), then have notifier bugger off if
that thing's NULL or if atomic_inc_not_zero(sb->s_active) fails
(rcu_read_lock() is sufficient for memory safety of that).  And
do deactivate_super() when you are done.

That'll give you exclusion with umount.  As for the rest of that...
fuck it, just have kern_mount()/kern_unmount() inside that.
How hot do you expect that notifier chain to be?

Or screw playing with open/iterate_dir, but that'll need some thinking -
theoretically everything you need is already accessible, but direct
access to ->d_lock/->d_sib in there is almost certainly not the right
level of abstraction.  We already have similar bits and pieces
in autofs and ceph, and it's just a matter of figuring out a good
set of primitives.

