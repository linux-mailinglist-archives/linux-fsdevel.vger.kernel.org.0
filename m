Return-Path: <linux-fsdevel+bounces-42668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F5A458A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9A8188B1B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C2258CFF;
	Wed, 26 Feb 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzGn4Qyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B436258CC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559305; cv=none; b=O+OSlAxrZB7eDDngtTzKwOmRTLOec2bFUU6EzPwIjZkO4eQfnFJXH6VUCGPM+yrfaZO/5g27S9duCf37feYANHsGUcyhXt7XL9WG7z6EoBQZnyc1H2p/21XqNeSCPhRXU0FyfwrPlpYaVXPrqYCXXsaETPi6j87cqlDwEpE9aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559305; c=relaxed/simple;
	bh=23rpHUvimApnaIC+SXXk7hjDcdCIyZL6D2uNm0LMjHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQp7FSREotRfJa4vPA3PlJWzE8QzLi62Ui+9vIJNJaC2+mfs0duhDR5I+aUZqUGVcsRBUROcEv1l6CpJ23eVxdB7/Zn8b1RJmNUGCWX8/oztITX1iZ1wPrMQEhmePgNHYW71wUDVEM5N1/XLfn5rk+kEoB+BvvrwzTKK++UEoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzGn4Qyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5804FC4CEE2;
	Wed, 26 Feb 2025 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559304;
	bh=23rpHUvimApnaIC+SXXk7hjDcdCIyZL6D2uNm0LMjHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzGn4QytcF61jOY4zeOhppUtyQLX2B6XTokH71EWwZrv0vdkWcIhrton8Y2d5ZcS1
	 tjXNCUodek6ogH3k9DeFuGUFmcTycb0C2VahO2gODJrRw5GZwAJrX30W1j3jb0cUsm
	 Jb2L8oPur2iuQ+j5XAKAPUmA97H6tTf7C8sRjqap68vVDZuAlICPEj/Fs7epAbetzc
	 tmtzmMOmXh2SC+gi8pUAbVKm4nssg1WyFfLa3P5zw7jRUb8ro5Do+7lnwJiqtyR4K2
	 wFSjRRh0uUIs70RELYAqtD6fh5Sy7j9os0cE44wSU5743mWTZQD3EhxMdyETxKaKwT
	 ICjX41CNNuelw==
Date: Wed, 26 Feb 2025 09:41:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC] dentry->d_flags locking
Message-ID: <20250226-fahnenflucht-fungieren-ced5012b2e8e@brauner>
References: <20250224010624.GT1977892@ZenIV>
 <20250224013844.GU1977892@ZenIV>
 <20250224-attribut-singen-e29c9a49ee56@brauner>
 <20250224141444.GX1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224141444.GX1977892@ZenIV>

On Mon, Feb 24, 2025 at 02:14:44PM +0000, Al Viro wrote:
> On Mon, Feb 24, 2025 at 11:35:47AM +0100, Christian Brauner wrote:
> 
> > I think it would be worthwhile to mark dentries of such filesystems as
> > always unhashed and then add an assert into fs/dcache.c whenever such a
> > dentry should suddenly become hashed.
> > 
> > That would not just make it very easy to see for the reviewer that the
> > dentries of this filesystem are always unhashed it would also make it
> > possible to spot bugs.
> 
> Not sure that's useful, really...  Details are tied into the tree-in-dcache
> rework, and I'll need to finish resurrecting that; should post in a week
> or so.
> 
> For this series, see viro/vfs.git#work.dcache - it's a WIP at the moment,
> and it's going to get reordered (if nothing else, d_alloc_parallel()
> side needs an audit of tree-walkers to prove that it won't get confused
> by seeing DCACHE_PAR_LOOKUP on the stuff that hasn't yet reached in-lookup
> hash chains, and that might add prereqs that would need to go early in
> queue), but that at least fleshes out what I described upthread.
> 
> I'll post individual patches for review in a few hours.

Went through them all. Everything looks good! Thanks!

Christian

