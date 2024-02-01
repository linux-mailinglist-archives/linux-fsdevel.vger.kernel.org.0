Return-Path: <linux-fsdevel+bounces-9871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E7845921
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9762AB23E30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5C5CDEB;
	Thu,  1 Feb 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLJ43RXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91853371;
	Thu,  1 Feb 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795016; cv=none; b=cdkhBKRO6IbXw4i1fNgdbpVcC3zpFXF0k6Umr8Ory7z/N9pzlIvxkO7JH1MMYN3Y3+kSenrmvxCJ1q35+U+3cr4vYLajYCKFc5sMbqxo2tKrloooLNeZvFJnI83nCTaIomUXJ7cs/yBBMCbz6PazuoJKKWuUwyoKBHlUXQdCuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795016; c=relaxed/simple;
	bh=Wgnso4/LpiD/3Hi1OyMMyAOI8T7cc0RZG91HUuFQGA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNIOr+hOV28qyXOetwZ/z3bnIlCsO01Vd5nrVqLbB5u/HzS5TCq3QYOXjMqjkhXrANc/fivGNpX3O2kisHBgxzTnyRIfaGryOhdu85PtR3I2/DR10dSQOLr6vRUs8l/CZeZLxm/x1/xRUh4wd2NFpY+DSC+vbBlLEoTStJFOr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLJ43RXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E093FC433C7;
	Thu,  1 Feb 2024 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795015;
	bh=Wgnso4/LpiD/3Hi1OyMMyAOI8T7cc0RZG91HUuFQGA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLJ43RXkzT8IflcJVQSPZCz5Vq2rOdPq1+UrjWLHZNqpVbmwRtgDGz78n1jjPEwch
	 lo3KeFZZ4V/LRXGw/DBIXO9NQgzqTkHY4AlGPsVJoj5l3EgMC274tYWSkGWXwNWwTP
	 w7UdQI3UQHNA0bdGG/i+VuB1cNI0SetOLjOz52Vv0r3s9nhdH/Mh4/T/lxGyLHcMHv
	 Dz7arFyHywzTkGKKwAg8hxRiSCR/t28D6EzBhR56oBthRkXHUOXdQX2fq+n0oiEbuj
	 KyPbvVAtz8R3zntSbXnO+r8DrZkMZqhUunjXwOCSCCh97rC0R1yCR/iEYXyctJY8pF
	 HEZcKXipEqcRQ==
From: Christian Brauner <brauner@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] mbcache: Simplify the allocation of slab caches
Date: Thu,  1 Feb 2024 14:43:27 +0100
Message-ID: <20240201-abgrenzen-zahlreich-4a517a1cf1ae@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201093426.207932-1-chentao@kylinos.cn>
References: <20240201093426.207932-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=brauner@kernel.org; h=from:subject:message-id; bh=Wgnso4/LpiD/3Hi1OyMMyAOI8T7cc0RZG91HUuFQGA4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTuXsDwxIF3rqNaiPn6GrYduYWeu79OPFrIsoljqnPXN IWZ0xY96ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIA2aG/95x3tpvz+T6aLVn rDo0eW7z0mci5f77rs81XKHj55tzRYyRYe7nPU5v3J/56tTrBgd7dK9s2qHzcT+3es2GWXI6S7M L+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 01 Feb 2024 17:34:26 +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] mbcache: Simplify the allocation of slab caches
      https://git.kernel.org/vfs/vfs/c/879fe799ad2b

