Return-Path: <linux-fsdevel+bounces-32484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDD9A69E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB031F21A0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448491F427F;
	Mon, 21 Oct 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU5jc++Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E42746A;
	Mon, 21 Oct 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516678; cv=none; b=PxVlHycmRPlJEooEkYSRf4alhQoMQvj8lG0z+3k8vU2mK/ts9ybAwonlqns98M9GywCk/u23FIVvbExIa92a2Un7/ueIRMRB0YrAIyksXr3jCCjm74Z26B9BK2vjhRXdCjhxtLw9QorbrETT9A3+a3RN51ObB8KQWjmxmqVl8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516678; c=relaxed/simple;
	bh=V/7/mzBXU3+EclLs2EGamNhd8+dOPyXvv7Tjz9IRZHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPH+6swAYp9X9C1FaESF6bHl3chsUOXjNzamuNKCjjbBP2YHVYbAQRJ3Ddbf1Js2TK66JcK1eSDyA++mtmrM0kwEHYBGJONTRaIATCuL+GxF0qnR1E6cCvy2oG5x5rbKAJroO3aWbTWdsprMuwEYztSgi9F/Ia/VQOI1G/lMrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU5jc++Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA4BC4CEC3;
	Mon, 21 Oct 2024 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729516678;
	bh=V/7/mzBXU3+EclLs2EGamNhd8+dOPyXvv7Tjz9IRZHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tU5jc++ZTdTw1qQjp9XuKpnLZOYpFazqFs+6twrkMIAI2Tf4uq1OYcQq5xze3tYim
	 r0Kr44wKLAXrQaF9pAc3SLvN0uBnxt9ELqKgKZHPP4yhopn0evExoru5RKKr1Zdyob
	 Zb3MafemslAuMgThDJA0zqMytY41GRz3DhIo2V0RB3yuDiFxeYWUlVeQPFU+dkhITo
	 jYD4nKrWnlIHpCMXT07jas8SJn+EtJdpmjvTL4M5KR+3A6Rv5w8A1+kstW3TMfrqmb
	 iTKqJJYlerjzauVE/SF4HbnXBCFeieswy3BFXmKzYCEOLpykQwZ0fS0Df4Ba7vo9VT
	 jvs0yrzMd2pVg==
Date: Mon, 21 Oct 2024 15:17:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Paul Moore <paul@paul-moore.com>, Trond Myklebust <trondmy@hammerspace.com>, 
	"mic@digikod.net" <mic@digikod.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"anna@kernel.org" <anna@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241021-examen-deshalb-48b371dc7efa@brauner>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <ZxEsX9aAtqN2CbAj@infradead.org>
 <20241017164338.kzl7uotdyvhu5wv5@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017164338.kzl7uotdyvhu5wv5@quack3>

On Thu, Oct 17, 2024 at 06:43:38PM +0200, Jan Kara wrote:
> On Thu 17-10-24 08:25:19, Christoph Hellwig wrote:
> > On Thu, Oct 17, 2024 at 11:15:49AM -0400, Paul Moore wrote:
> > > Also good to know, thanks.  However, at this point the lack of a clear
> > > answer is making me wonder a bit more about inode numbers in the view
> > > of VFS developers; do you folks care about inode numbers?
> > 
> > The VFS itself does not care much about inode numbers.  The Posix API
> > does, although btrfs ignores that and seems to get away with that
> > (mostly because applications put in btrfs-specific hacks).
> 
> Well, btrfs plays tricks with *device* numbers, right? Exactly so that
> st_ino + st_dev actually stay unique for each file. Whether it matters for

Yes.

> audit I don't dare to say :). Bcachefs does not care and returns non-unique
> inode numbers.

Userspace can now easily disambiguate them via STATX_SUBVOL.

