Return-Path: <linux-fsdevel+bounces-69736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F1C8420C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D01214E722F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D722D662F;
	Tue, 25 Nov 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqNsGCPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC51DF273;
	Tue, 25 Nov 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061462; cv=none; b=LUdZwtYnTiiacWzrq9p7E4V2dzChEGaKV/0zEcZFLgigvf8QE9XWjyVuPeEq2a4xYhVOgAs78d7oLcnpOlVvz3jmLzjYAKM330AoOWA9G+PsEyGHeAeYrkO2rJAH20mtJmDZ17WJ4KRq9T+1nMDmVn9yn07OQYcjz90WX6h3fng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061462; c=relaxed/simple;
	bh=Z9Fj8W5kJUP672AEjZXRMns7w65Sdq2WMDVMzvcoOyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s10/r/g+2+mjrwbltW+hFItYQ+FpeAtxZcArRonggnGbBECYzI9AVtoCb3w/ATpuNB9+fFMhAAId8MaKGITzaz9V5NbcDHFeEKMzvxxozMy86FRMUwNQdv+4eIZ1SaonUDrTVS7lE4v8JFFpQ8dHz5829xJ/zLxH74HoVqappfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqNsGCPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67115C4CEF1;
	Tue, 25 Nov 2025 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764061462;
	bh=Z9Fj8W5kJUP672AEjZXRMns7w65Sdq2WMDVMzvcoOyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqNsGCPlXSHQTgHB04wBr4m75rPDLN+RwuCM96TLHWQK7H/P2IFHzBPYbMD1tlixg
	 ohrUjNzE7h4NklgUCIIO4ByUvS8HDmf8Kwd5Xf0d2pfhh9ZZ+4uaoGYvFSET3G93O+
	 d1+VY/mKXEfeSOGpbIr5nGy03sV1S3MZany5Wv9o1gfozWcX/gjm2cxNA+/Jzs1+v8
	 VIh7a6S2x3skqNTJxiK1kEiEKTgaoaZmscsWY0KiEwKnAuVYjvGBxJ85jG7kmtg0qV
	 5Y+xBo3o25lt8k4RqSGLQVXyURSOCPWXJ2RIen0AML5AnbYR2A+RGPiIuXVyknjUyX
	 ushNU6ism2INw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5] fs: add predicts based on nd->depth
Date: Tue, 25 Nov 2025 10:04:11 +0100
Message-ID: <20251125-palladium-edelmut-2e853325c3d9@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119142954.2909394-1-mjguzik@gmail.com>
References: <20251119142954.2909394-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=brauner@kernel.org; h=from:subject:message-id; bh=Z9Fj8W5kJUP672AEjZXRMns7w65Sdq2WMDVMzvcoOyk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqFgqGXdnQ/7v+m8PzPIUtBxOLnFa6lKWsnvt6g9Qkz lLmIheGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImIHmb477nzg+cLnX3eiZwL nKVehT/8vHXWxLms6zYkL201Fp6w4ALD/+rOuDWPWXkWTb9W86rW32hvzRfhJbNSJ8aoFT6OPyE TxgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 15:29:54 +0100, Mateusz Guzik wrote:
> Stats from nd->depth usage during the venerable kernel build collected like so:
> bpftrace -e 'kprobe:terminate_walk,kprobe:walk_component,kprobe:legitimize_links
> { @[probe] = lhist(((struct nameidata *)arg0)->depth, 0, 8, 1); }'
> 
> @[kprobe:legitimize_links]:
> [0, 1)           6554906 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1, 2)              3534 |                                                    |
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

[1/1] fs: add predicts based on nd->depth
      https://git.kernel.org/vfs/vfs/c/7c179096e77e

