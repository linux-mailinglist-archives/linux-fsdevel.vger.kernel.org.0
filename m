Return-Path: <linux-fsdevel+bounces-45736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F3CA7B924
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885C3173DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F174D1A00F0;
	Fri,  4 Apr 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMFuaLt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B01922DC;
	Fri,  4 Apr 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756348; cv=none; b=HrtoBeyRGXiVtsfnJrsVvkwYhtBkRnIKSfGderIYa/40C/Tjz5f1YUaxCcjFHM4zCfbGfyEQKTPA+fcP1aJPQxwRGwCM0iokFjM9SSkJwXRY40//ruqLdRL4/MFHT7bFWZBzikmoheHeffZLn11tBhuZD9bD5Ubkr/xazG0rZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756348; c=relaxed/simple;
	bh=F/GwSSYE9i6Fp6DJyyRG6z9hqALnwHcoNMy51y/i4hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4SxxMztFF5a02LZw7uAoqUnGitUeivN2xWcMep705NXlS8nU89N6pl4ne/eWv2FQTlNDho7UE0xOPaD6muSo37CVLKUwggfJhyBFxomISIypQhHMhua2vWSVlj4PWTbGkoed7/mgUQnjgr4ugXzFFPgTBtCLQ+STRG9g0gFU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMFuaLt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1077DC4CEDD;
	Fri,  4 Apr 2025 08:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743756347;
	bh=F/GwSSYE9i6Fp6DJyyRG6z9hqALnwHcoNMy51y/i4hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMFuaLt3fUj9x6L8fx8vqPwExuqnK9rfSDsuYyVaLvtqZaL2WpP2WW/iDSUZcr8H3
	 tjMrYp+ejugRVqugJaCXu+HRZnxQXk3trsTr0SXyB5dRWv2gfS6DUhjQm6hwbEle2L
	 jJnVMnbCkGL00nEuUPV1ySulCleQmzUQV2BTGah9DDUcYdi/kxQJcqoPATXSGrqlE6
	 nBiTsL20ynqC++V6qkPrmbq+QfBkK4n4UGMrXM7s5RTH+5DmufawBQP9ftTa3sTo+b
	 H7Y8wYHUlFKZycgv7EoDfp3Ef9nvIJSlL9SbJQ8RB2pnibfyrlSru3dkDxWL4MAsRi
	 LjlHyrxjpWxlQ==
Date: Fri, 4 Apr 2025 10:45:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in
 may_open()
Message-ID: <20250404-kammer-fahrrad-516fe910491e@brauner>
References: <20250403015946.5283-1-superman.xpt@gmail.com>
 <Z--Y_pEL9NAXWloL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z--Y_pEL9NAXWloL@infradead.org>

On Fri, Apr 04, 2025 at 01:31:58AM -0700, Christoph Hellwig wrote:
> Please make sure anon inodes have a valid mode set.  Leaving this
> landmine around where we have inodes without a valid mode is just going
> to create more problems in the future.

We've tried to change it, it immediately leads to userspace tools
regressions as they've started to rely on that behavior because it's been
like that since the dawn of time. We even had to work around that crap
in pidfs because lsof regressed. So now, we can't do this.
> 

