Return-Path: <linux-fsdevel+bounces-10307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BACC849A44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC100282370
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C66208CF;
	Mon,  5 Feb 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7GvskMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60F20B38;
	Mon,  5 Feb 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136243; cv=none; b=Wc2H21fmsS12skJYuqArRP2JBNVw7b1cCgwTdFmXcwYrydoW0EbqwL1Y96dGzJhXU5qPnDWJs0ri2XbKAbBalhSrVlhq9aKHBLwXeqZvsc2ZfLdrqwErA9rN83e64BT8H/ax7R4TvT2Ff8ViHfHW1jxiWlazSHY5Du29Iu24nHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136243; c=relaxed/simple;
	bh=ZFPV/D8yVsoGEWkXbnST0ymrNYzv2wNW8YR8RRV2Bx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UufJ49siZrlI4bxb8p9lPG8Assou7lgLEYNRsmGynByRez2PVbDHdAUaTR5UWuKN1fYOZPINwrX0zkiEVn9q3pSVMH+msQp2+ES5qQu/h3pmqlMtXIrM11bUG3RtN2A3BI9u6eN95UEyjHWRFtaY1ou0Y/ena31p2MOBbJLS+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7GvskMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE440C433F1;
	Mon,  5 Feb 2024 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136242;
	bh=ZFPV/D8yVsoGEWkXbnST0ymrNYzv2wNW8YR8RRV2Bx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7GvskMetlGNn5mKxij07Pe3OuF0lCRuEiFYe5r8BXjLdKiGs0TX0yxux94egd9dx
	 GJ18Rqw3kTGDpuInN8hBxFqYgc9J5/RAcE55O/nT/5IK/b8WfaIQHzOyq0gETQWyP2
	 vDD2v+IR3dhw4+71fafvpHK3czaL8n4/e8Ep5MRvINT+4ScRdCrUFFnmwWQTbcTxP0
	 V1ROkCXLmr6CGXDOuAbJne/xv2P+1F1RLmhP4Rwb+RHdB4TxyQfnYD2OCuJTouEr2T
	 EUuF2iv7/YPzJzq4L37HefOJHlPMWkpz2GM3xI4b28AXuPBocMlgExjbYHLB68k2lI
	 tKfSC3GSDSCsw==
Date: Mon, 5 Feb 2024 13:30:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 09/13] procfs: move dropping pde and pid from
 ->evict_inode() to ->free_inode()
Message-ID: <20240205-flapsig-ruhestand-17e195bf0162@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-9-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:35AM +0000, Al Viro wrote:
> that keeps both around until struct inode is freed, making access
> to them safe from rcu-pathwalk
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

