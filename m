Return-Path: <linux-fsdevel+bounces-52834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50824AE7400
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 02:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA489175830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1748635C;
	Wed, 25 Jun 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WurVgxZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE81C69D;
	Wed, 25 Jun 2025 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813077; cv=none; b=BwCOwV4p94s7VzQwYwQSqlpuVgXT9/RXYuWn6YL0xKMGlazK6DCpGP36hpDH+QkgxMnQrffytrDI/5Ayvl6aAzSPQ1Y69I/npCH8qS/IUxr34P3ZErOSxT2y2jqCgWK4RSuXnzMZMhBlvv/7689Glz66qPS+rmNLorlvQIUpwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813077; c=relaxed/simple;
	bh=3sxog9KarjUra1bsPTIgTp68dHv6ihs9IGtnMgPj24I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaTyZSTA9ozvfR2Qc8F151beNYFvnb052oiILzC1RzQZ1BGWsQ8ImhEI3dHwUMU+kXXJN1wJLK6CsLQabYwPaOFUVl6FZ73Ov3bhP2CaK0er2RcEGJYnQ8VLmTv1UpEUvBlnpq9HSD4W7+uh7g20Fx8u1MwbIaepH+GCKjZEb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WurVgxZE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=atVojG7bUTPZmKUSvlctp8HQyu35rHIBOIdL8quSxiE=; b=WurVgxZEUVqMBFhFWx3cZF0/IF
	v2qTI11x5HFTbgEzDZJDkXsgxvs/wMo7Hs1IFqnwwGbO8HCVzjcLMXwob66ce15LcDd5FHuV8qnUP
	OqGfLCtPZO28RIqf32+PYYpcxRXuN8fRaZWkMcCPo9zrvZamgr+mHvtw8H+8vqgutOOdS+Vphb7Uv
	cpgz4qDfZFNjLG3O1YWHudbaJBFSGok3eR6nPd83uzr8+OBmp15BxOVyq+OlwUHQx2DqfyhKr8E9b
	6q66Rwz/Ng4klFSV1Z925YaDkD0FJsdXtiCNRZ/tXo3DzrtWXCkA7gbnTpy568dzm8LoYmT/77w/n
	hd/YEP8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUESW-00000006N6e-2vN2;
	Wed, 25 Jun 2025 00:57:52 +0000
Date: Wed, 25 Jun 2025 01:57:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] selinuxfs_fill_super(): don't bother with
 selinuxfs_info_free() on failures
Message-ID: <20250625005752.GP1880847@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615020154.GE1880847@ZenIV>
 <CAHC9VhR6BAOqHuBf+DdWQC-D+Lfd2C9WLTEpFjy1XQkqH1syig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR6BAOqHuBf+DdWQC-D+Lfd2C9WLTEpFjy1XQkqH1syig@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 24, 2025 at 07:44:23PM -0400, Paul Moore wrote:
> On Sat, Jun 14, 2025 at 10:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > [don't really care which tree that goes through; right now it's
> > in viro/vfs.git #work.misc, but if somebody prefers to grab it
> > through a different tree, just say so]
> >
> > Failures in there will be followed by sel_kill_sb(), which will call
> > selinuxfs_info_free() anyway.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  security/selinux/selinuxfs.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Thanks Al.  I went ahead and merged this into the selinux/dev branch
> to help avoid any merge issues, but if you've changed your mind and
> feel strongly about taking it via your tree let me know.

Dropped from #work.misc and #for-next

