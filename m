Return-Path: <linux-fsdevel+bounces-54946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A73B0590C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC73A6B85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBAF2D949D;
	Tue, 15 Jul 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZRO1XpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A192F2D;
	Tue, 15 Jul 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579666; cv=none; b=u+Q1C7hN4xsvvdpbz9Jwh+/S/UmNWmUUPbvn/tuuKbeFZ2UHRgyx8h+9cd5meBdIAPOOHd2D2godz/+WaTwPLZDcapKtUHtkEq0NXDODFVqacVXE3m82v2yesfjSSceuMH8VWdC+b8V5VHjuyZzlmn/geqXdS1nPEUS+O5BPgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579666; c=relaxed/simple;
	bh=d/zXpWCmDJBuYxB5Sq07QsJCqtYmuGrasATKrTs8fI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9gmRREvRMr9oDAcUp91Di+U8iUKFc0xD15JP65f1Vq8RhZlwwWFFrW0RSwUKnv4L4D8bCs1O0jren/EyQfk3ctnVC9Ct1OwmQjbg36fKR6bwBm0vASPn1MPG2kF1oXTuKcWCUn9s+906oC4uZsDNMchka30GeY3IYim5s/eUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZRO1XpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C897C4CEE3;
	Tue, 15 Jul 2025 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752579665;
	bh=d/zXpWCmDJBuYxB5Sq07QsJCqtYmuGrasATKrTs8fI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZRO1XpWhh57n2nYZVGcT0ZSXM5pmU9NzDM9FLw9VxRN3W2B82aSvam/fv7xuFO61
	 Zq2rFpTYU4hN6EFvFB7DM4k+elbUIzqzhc0qn1fHVgmkgv1+bznxgW3E/BBP54G70h
	 bx35O6upsK/wn9YPCa+rVAN1l/tzrE2J1ASbiHgTLJlY+X0yUVQiBCbzW4rUb5um4K
	 VyX+ySQjSJVjJxEKYOA6+Dk6REaaEqjkkEFKPTp8rWsQ2UO5BvvzwLvDtYpKTu7ktE
	 +tNnJGo29O1xLGV5iTvej7qV+ZaOyaqWLK2R3JsXfEv60DSDNmiDzTn0iTBKlxTAN8
	 197sDouZRjbvg==
From: Christian Brauner <brauner@kernel.org>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: (subset) [PATCH v5 1/6] fs: add a new remove_bdev() callback
Date: Tue, 15 Jul 2025 13:40:58 +0200
Message-ID: <20250715-ehebett-eigelb-f99ccbebf252@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <09909fcff7f2763cc037fec97ac2482bdc0a12cb.1752470276.git.wqu@suse.com>
References: <09909fcff7f2763cc037fec97ac2482bdc0a12cb.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=brauner@kernel.org; h=from:subject:message-id; bh=d/zXpWCmDJBuYxB5Sq07QsJCqtYmuGrasATKrTs8fI8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSU2fkKRq5ZUahqf+FJgdIVl+7GWNaVfnz/P1QHnwl+s UYjJGh/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERcjRgZJhzSe1Wr1Wc6P/a0 jWuT7SWDhxYGe74ttvKSarX+OEFuPiND64Ovb3665JtsmLomu7hoEuPTR/tF5/x+KafI6VjkMu0 MLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 14 Jul 2025 14:55:57 +0930, Qu Wenruo wrote:
> Currently all filesystems which implement super_operations::shutdown()
> can not afford losing a device.
> 
> Thus fs_bdev_mark_dead() will just call the ->shutdown() callback for the
> involved filesystem.
> 
> But it will no longer be the case, as multi-device filesystems like
> btrfs and bcachefs can handle certain device loss without the need to
> shutdown the whole filesystem.
> 
> [...]

Applied to the vfs-6.17.super branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.super

[1/6] fs: add a new remove_bdev() callback
      https://git.kernel.org/vfs/vfs/c/d9c37a4904ec

