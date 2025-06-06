Return-Path: <linux-fsdevel+bounces-50831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DADAD002B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0D41892D49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D12874F8;
	Fri,  6 Jun 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOYV3ygE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1348286883;
	Fri,  6 Jun 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204662; cv=none; b=TdN1wmiMIe2hztKBhZ/O2WTTK5BNShUNL4IOufTgR3PF/7oY33EemnuUZoM70OfS8ObH6tL4I/LG+aVrOChGRHpmyyiuxDhCExbiu4CgR8uJFXV1rgLyCSciWSb6SqWYomKNLRJJ2bzNmCaoB1h0N1vq81PpjSqOVWJoE/oARaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204662; c=relaxed/simple;
	bh=QpA/JuCnAP/vFa+RSbOkJBcKz4J+tC4XXGlQAhLxjiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4UfznYGbivLKvkQheM+E4iC4I+Xp+tqYbBjlC0cJTFOyuTmk13PfFAOY/eHwtE3XsCjiZyZRI05m9FQfpYHGXQ6uUfhmfa+OsMdVRgyG2S+zmk9ZGPJ8UURPJTrq+SVVpUcBIL9GN/qzuG687sdzk9xOgUW6xA6hR5omb0/rDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOYV3ygE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D32C4CEEB;
	Fri,  6 Jun 2025 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749204662;
	bh=QpA/JuCnAP/vFa+RSbOkJBcKz4J+tC4XXGlQAhLxjiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOYV3ygE1WUo2ThdlO7485Uw/rj45w0Z+n/6w5WbgFyUCXIjsyKtxqHf2YHZO0Hv8
	 WbPKtRgW3k55PDtqmLWOUmorRkt/FVHsXcRPlM5ZyYNCebTbP+Q4uCa7zdoWaOn2O1
	 WbPE3oVUkM6WgXPuJMOlqd5WvzgdONu1RXVFeFzL0nqWRUOi3mG4dHgnrBzE/83Mqn
	 FyKKPmY4pvB6Z7tMVxcKOpNcAeK0soEHiZtQYZhuh00iKPvG3IhxtaXWR/Hhmik34O
	 gCbYNzdXNCtYHoXL9fEAWqLDFlVb1+xzr5QSZaqBb4CM/pdq0K28lxwY0NR1kAf91W
	 W7kAAiZVNcUhQ==
Date: Fri, 6 Jun 2025 12:10:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/28] vfs: allow mkdir to wait for delegation
 break on parent
Message-ID: <20250606-zuzahlen-vervielfachen-8831c5ca8f69@brauner>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
 <20250602-dir-deleg-v2-4-a7919700de86@kernel.org>
 <wqp4ruxfzv47xwz2fca5trvpwg7rxufvd3nlfiu5kfsasqzsih@lutnvxe4ri62>
 <eeefb45bc67182971ae7d3c455a4ecfdec53d640.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eeefb45bc67182971ae7d3c455a4ecfdec53d640.camel@kernel.org>

On Thu, Jun 05, 2025 at 07:25:38AM -0400, Jeff Layton wrote:
> On Thu, 2025-06-05 at 13:19 +0200, Jan Kara wrote:
> > On Mon 02-06-25 10:01:47, Jeff Layton wrote:
> > > In order to add directory delegation support, we need to break
> > > delegations on the parent whenever there is going to be a change in the
> > > directory.
> > > 
> > > Rename the existing vfs_mkdir to __vfs_mkdir, make it static and add a
> > > new delegated_inode parameter. Add a new exported vfs_mkdir wrapper
> > > around it that passes a NULL pointer for delegated_inode.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > FWIW I went through the changes adding breaking of delegations to VFS
> > directory functions and they look ok to me. Just I dislike the addition of
> > __vfs_mkdir() (and similar) helpers because over longer term the helpers
> > tend to pile up and the maze of functions (already hard to follow in VFS)
> > gets unwieldy. Either I'd try to give it a proper name or (if exposing the
> > functionality to the external world is fine - which seems it is) you could
> > just add the argument to vfs_mkdir() and change all the callers? I've
> > checked and for each of the modified functions there's less than 10 callers
> > so the churn shouldn't be that big. What do others think?

If it's just a few callers we should just add the argument.

