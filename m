Return-Path: <linux-fsdevel+bounces-47686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1BFAA3FC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 02:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECFF169D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0DCA5E;
	Wed, 30 Apr 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9mINEwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A3746E;
	Wed, 30 Apr 2025 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974127; cv=none; b=MLEuQfuB0nbtyCqu8b7klSx+7+38gO/dj5se5cOthX6q5YOEvKUQPQdy7TICMx8zCIqAtXQbPLq1pHXityL3f5eMpiczLMazrUgcLWD0XXC/WrD9JpFsH1YIdOXMrUvZNlg0ZkwyUiiBk7tSIkagxJiJqkMiM40pr/aklPhO7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974127; c=relaxed/simple;
	bh=p8LoEjX2XoT16Hzndkl9yNf+dNli1V2KfZpukMx7Sjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXSpYs1y9IQAKv+a1o4egEZUm7WYdJKUOT80ygOCGMp9jHGZTr9U3rti3G9GIoKwIWUdzDZzqFOGkwWhqGfdpMSruWkqTdeIjzV+ymEw4hC+iFsUgs77kXAvscSe2XneU2hk6qPmuVO+u2VFDl+bgqW13fImW+XDA1/7XQWZ9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9mINEwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BFFC4CEE3;
	Wed, 30 Apr 2025 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745974126;
	bh=p8LoEjX2XoT16Hzndkl9yNf+dNli1V2KfZpukMx7Sjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9mINEwpJOHzRG51dQHF1ie+HTdjGsvoUSLOg2H5VJSBupK3/jSC1eZfu+CV8YZLN
	 T2EmYBoD/ezNkRLJRHrN7AmQkoUNuAnjRDlMuutcLG76HcHqilYAOfLo1bzVjoIINV
	 riEXQWRrMhplkUE9Y8D8w36beKGElJ2GaKwz6xGj+LCP91yHLY4KVXwlxhvqwGOo0c
	 JSCtDlNrp2GtCF9abM4Rc1uwFveaYV69FQzPT7zAhxOOlUzkzSKhkuHRCA+V0j2WRe
	 9oxhaMkCJ3AiqIAFp4sYY7lLG+XmDZq2pv8zmpyInjlFgyCeCUq7ZShBN8HG8Dyjzf
	 Y4qOnMu9vo9bw==
Date: Tue, 29 Apr 2025 17:48:44 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
	kdevops@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 25/37] fs/buffer: split locking for
 pagecache lookups
Message-ID: <aBFzbF_kRJAawSkE@bombadil.infradead.org>
References: <20250429235122.537321-1-sashal@kernel.org>
 <20250429235122.537321-25-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429235122.537321-25-sashal@kernel.org>

On Tue, Apr 29, 2025 at 07:51:10PM -0400, Sasha Levin wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> [ Upstream commit 7ffe3de53a885dbb5836541c2178bd07d1bad7df ]
> 
> Callers of __find_get_block() may or may not allow for blocking
> semantics, and is currently assumed that it will not. Layout
> two paths based on this. The the private_lock scheme will
> continued to be used for atomic contexts. Otherwise take the
> folio lock instead, which protects the buffers, such as
> vs migration and try_to_free_buffers().
> 
> Per the "hack idea", the latter can alleviate contention on
> the private_lock for bdev mappings. For reasons of determinism
> and avoid making bugs hard to reproduce, the trylocking is not
> attempted.
> 
> No change in semantics. All lookup users still take the spinlock.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Link: https://kdevops.org/ext4/v6.15-rc2.html # [0]
> Link: https://lore.kernel.org/all/aAAEvcrmREWa1SKF@bombadil.infradead.org/ # [1]
> Link: https://lore.kernel.org/20250418015921.132400-2-dave@stgolabs.net
> Tested-by: kdevops@lists.linux.dev
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Same no way. This is pushing it.

  Luis

