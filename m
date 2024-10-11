Return-Path: <linux-fsdevel+bounces-31706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66C99A42E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F600B2267B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60FD21858E;
	Fri, 11 Oct 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FzoYcd5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578521791B
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650843; cv=none; b=AO8F9tuwktWfp5Rl+nCR6hEnAdiYuYhv6vyJavxSFRkv5ezl4nQGZk+nZcobj5QwNz3YQRI6YocBWzCYf2MLHKys+d2YPlb6rmdKdQX5nOnJvngICsfom7NM6+K/slZ82Lh7vwtZOIMziakA4N1UnTM8ShjfJAOhx6hopeP3fVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650843; c=relaxed/simple;
	bh=Ssj50jhLa6QTaxxQAPUc0/csO1mGN9hS2lCU62Fjl34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si6+h85BhDx+RVAtoloHyUEEkK0cPEjKFeo/x/59BQH8zRXWScBFQba9oUoYlV4QV5+zzAy95Fl2QzlM213S7jpbJLUWY7AIOSosd4ENPTS6LZiP112wi2j6YOHd9QY19vfJNR5edq+UePm7k1fxNIvWT+sPCO5ee5/YSSM3C84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FzoYcd5l; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ5xL1Zn9zmd6;
	Fri, 11 Oct 2024 14:47:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728650838;
	bh=mUqoHhS7jRHHrLnQ2C+m0/2kYey48fPAy6v5oOk7vrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzoYcd5lONxYRZH38zsyGdlP6o2g+tIeo9OaCQPGSPNtSo6aBOrNYhwXqVs8Z4C/G
	 3UmZ93Lj8H8V947n/8+ZgXmpQ/fi1Zvr505F7cLp2rTv8+nWGmGxAg0tHzOEyetzem
	 TuCagL29HYvAbWFeeg862LwYBgR4v4QswK2UTI9o=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ5xK4v5hzkK3;
	Fri, 11 Oct 2024 14:47:17 +0200 (CEST)
Date: Fri, 11 Oct 2024 14:47:14 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.ieghie3Aiye4@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwkaVLOFElypvSDX@infradead.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 05:30:12AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 05:26:41PM +0200, Mickaël Salaün wrote:
> > When a filesystem manages its own inode numbers, like NFS's fileid shown
> > to user space with getattr(), other part of the kernel may still expose
> > the private inode->ino through kernel logs and audit.
> > 
> > Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> > whereas the user space's view of an inode number can still be 64 bits.
> > 
> > Add a new inode_get_ino() helper calling the new struct
> > inode_operations' get_ino() when set, to get the user space's view of an
> > inode number.  inode_get_ino() is called by generic_fillattr().
> > 
> > Implement get_ino() for NFS.
> 
> The proper interface for that is ->getattr, and you should use that for
> all file systems (through the proper vfs wrappers).

How to get the inode number with ->getattr and only a struct inode?

> 
> And yes, it's really time to move to a 64-bit i_ino, but that's a
> separate discussion.

