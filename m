Return-Path: <linux-fsdevel+bounces-69081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F03CC6E2F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0AEFC2DBFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514D350A3A;
	Wed, 19 Nov 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwz1YNfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED32349AED;
	Wed, 19 Nov 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551043; cv=none; b=pfy0DVLgVi0Afq0KjwGk0V56XXU2bs9p24VOaXoG/qIpXSLRlew9JNt3zzQmnp+0j3IQ63CUzs475e8H4rdrlOzdb0HC0Q57HieGNYwXNYew8kVq2DMhjx1KX72AbdmRAy4Oeou+nTtDnWDjdT8aCBZM8Uf6pHK++O65fM8fk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551043; c=relaxed/simple;
	bh=pk9rgV2ZQ4vMCcC6Ti9olRKhrnZYsGP2u2dEgNr2T4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sH7df3FjK83gHGkqTFjWFZ6spkFLkaADEwgwkw8VLun99PQ509iPVGxFN0fXJpeOEjzSKHMBWoo/At9MjDaNWQOux0/l4gQL4FK65IUleSFLEtcn+Qte5s8+VnCQVsubhvff4KWZ3n9zb7VS9hISJ2hfM29VuLr9FkMLx4T1qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwz1YNfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319BCC19423;
	Wed, 19 Nov 2025 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763551041;
	bh=pk9rgV2ZQ4vMCcC6Ti9olRKhrnZYsGP2u2dEgNr2T4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwz1YNfIV7FwSjb00S4LAeIB57uROXh0SFXE8ICulV0q2umgqSa34CHsjeDXguTlP
	 efcAVnEm+JZcOV50uVGUa/kJu5pFskMk1nV2mUZDVLvEJSHtV8cI/8kUUxMc9rW/mn
	 /cnOhN2SmBf8s7kCB1sOfIC7Rdpanzg9Udpmy7lsMr2YTJXIAAirL0mZyG4PPHsAX5
	 fQMBoi+/g72pjJqYMjc5GCUpGVJcMJ6lrSJ0sYMHUXmqiYxmJmg3oaxdru5IKI1d5n
	 V36mYgBixDcvBG1ZcWxO8S9504XTm5Cmxjc1oABqBbsiy+d/i+p7OH+BuDWbqYQCOE
	 ite7DnLHhPKrA==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watch_queue: Use local kmap in post_one_notification()
Date: Wed, 19 Nov 2025 11:11:30 +0100
Message-ID: <20251119-zeichen-dompteur-0f7c7be290cc@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118210706.1816303-1-dave@stgolabs.net>
References: <20251118210706.1816303-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=brauner@kernel.org; h=from:subject:message-id; bh=pk9rgV2ZQ4vMCcC6Ti9olRKhrnZYsGP2u2dEgNr2T4Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKLrf2/s/84Oz8HKfmV03+uhsF4q3LcuY+sVf/WGRae TK58fC2jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl828jI8FrP5MbHORlKKVJ/ 5mpp//c+Y5tbwup6t1eYYYHwnrBd3xgZTlwI2nz0nvVzYVHHf975Tye5vmpds0hgQcTeecfXPt3 eyAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 13:07:06 -0800, Davidlohr Bueso wrote:
> Replace the now deprecated kmap_atomic() with kmap_local_page().
> 
> Optimize for the non-highmem cases and avoid disabling preemption and
> pagefaults, the caller's context is atomic anyway, but that is irrelevant
> to kmap. The memcpy itself does not require any such semantics and the
> mapping would hold valid across context switches anyway. Further, highmem
> is planned to to be removed[1].
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] watch_queue: Use local kmap in post_one_notification()
      https://git.kernel.org/vfs/vfs/c/79cba9d67db3

