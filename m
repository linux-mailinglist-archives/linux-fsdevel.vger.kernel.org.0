Return-Path: <linux-fsdevel+bounces-57350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6DBB20A68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B0F18832DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8E2DFA2F;
	Mon, 11 Aug 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QanpJ1FF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C07205E02;
	Mon, 11 Aug 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919330; cv=none; b=DnCyGRIGRRISCIgJHoosP5VbNjOHvGUQy2MImj/Z21DYQvdCBOlGvsa6BCGotNusJ9q7BS30A7deY/AUtCxEzQVegr67t+6eGAts7RTK1fIwwJSsHvzogtkrirbv80Zka1+BwmkCBUWWpw0eUPRRPdrD97RHCi2/9my2oesVZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919330; c=relaxed/simple;
	bh=JU+C8jrRoBvIHpuTBFOVPaJSBYeLJuKp6ZRbyTV8tUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH8DHpuV4GlG2ICbOWrIg/pTxWcaxAhVd16Nt87Hq+/KMhgtAPCHa0HGVCds/01FvyOyg3Rhv8YIv6zERQfuamXIJ5izU8XO3UcfpUqCxinuoOu3uEXRACoqCyhXQxOJ5t0QqLHV2YlpGtYYCFgLN7RLjeJ35Q1uAyDrtxaDS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QanpJ1FF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E39DC4CEED;
	Mon, 11 Aug 2025 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754919329;
	bh=JU+C8jrRoBvIHpuTBFOVPaJSBYeLJuKp6ZRbyTV8tUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QanpJ1FFAEOTenI/ZExSMKMWz/vWwwP0RGPtT6qjmkKBX4nap9yqO0U3SmhN0mft7
	 0XEsDyKzmiQ3MPArUXx7Xibr1PndFK+QUTgL3JK9LaIVUhTreuZbdIBreTgk2CfMxQ
	 Gm8/UGW+xYIDrCTnXv0I60EocErHUvb+5Kqq7DSDZ/mQ7zNKRfJUzcxUkMhzug1uD1
	 8bh6XQagbanat13424yqY1iXeT3fLg0pvOpA0uXXnszQuwLw3dGXGt6BbyRF22ekUs
	 JmUCratJjiyWB9323y6oClHqu5I+dElILQ4KxZ59JBn8QQ28Rbay5gQFZ4RXLQSWSB
	 iV0FOE4Xqmf/Q==
Date: Mon, 11 Aug 2025 15:35:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct
 inode
Message-ID: <20250811-weismachen-anhieb-987a766c8e6e@brauner>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <aJixkUfWPo5t8Ron@infradead.org>
 <20250810170311.GA16624@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250810170311.GA16624@sol>

> The fs-specific field solution from this patchset is much more efficient
> than the rhashtable: efficient enough that we don't really have to worry
> about it, regardless of fscrypt or fsverity.  So I think it's a good
> middle ground, and I'd like to just do it this way.

I agree.

