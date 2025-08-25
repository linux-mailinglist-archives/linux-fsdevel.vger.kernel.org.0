Return-Path: <linux-fsdevel+bounces-59043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26AEB33FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B4D3A594D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A411E6DC5;
	Mon, 25 Aug 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN+H2JLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE720220F37
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126147; cv=none; b=OlECFH5fo94SdEhu7KWsRYzC8RnN0lfzzkuaPr0g5O7zpRwPpQpVtg44vrUjiG5stk/SkH8qon7ZPfaIQg2YZ/We8zCeAs+IhV3HxBaUmhvOWJGmX6YM+sUd9AbkwxuhI3cch/6At0vAX8JgYxN6ApvyZUrb21ccoTZqFOJSdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126147; c=relaxed/simple;
	bh=lxMCmr5lgyO38Cw8CuwjBabPCmE6iKUZyQBtfwyAswQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbAuLGlEDRxSk13wMmF3XZwF56+T0bD3kFbs/0g0iFg9XkhbUpVkc5xumaU6G4UHqM2IbQgoD6uvFKDFZj35tmH+RgVsA8hOFwcotwM26x71jE54jrWXLkCNz2OlI30vUFcg9X2MaO3Bo3HmEhm3aB2K9at8hdb/D5IBXpgmwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN+H2JLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD740C113D0;
	Mon, 25 Aug 2025 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126147;
	bh=lxMCmr5lgyO38Cw8CuwjBabPCmE6iKUZyQBtfwyAswQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN+H2JLVYlatVUIqk7wi/LII8zD/RbLA1xXxEz3ygeutjpxsWbTS2nEL8OLvm0pju
	 86p5lhHbSj8RfeNIj7iAKBfNeD/2DxN5tC8J+OblRmhW1i+v2y94PCrSSBrkbCzb4f
	 /LlKulNiS6yLZvT7+aGNcLwWILGYKRuheN10uVnQr0J7Qa6b0t//FJFsJ3wbUNPjsS
	 zEkGIJXxG1F2g61orY5Uz1UD85r4XWAEZMZd5dMJ96tdQpfydo7VQx81GlntuCaVcB
	 /DvSHlHa/zhN9yN4dRBLOniRvPqFWlH5njGFiyLDLXD5yQ9xqq0WQBarp5++uYRVHB
	 Akqb3DdM2j9Ug==
Date: Mon, 25 Aug 2025 14:49:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 12/52] propagate_mnt(): use
 scoped_guard(mount_locked_reader) for mnt_set_mountpoint()
Message-ID: <20250825-gefrieren-zerreden-b1fd001d540f@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-12-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-12-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:15AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

