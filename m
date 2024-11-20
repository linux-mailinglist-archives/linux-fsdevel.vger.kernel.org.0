Return-Path: <linux-fsdevel+bounces-35275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2205D9D3576
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93362B215BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652F161310;
	Wed, 20 Nov 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPb5sMik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FF184F;
	Wed, 20 Nov 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091595; cv=none; b=bgtGluTNdH1KzC/M4hBbFI42dTLQMmUpwCmtebYB4Dg4sYZ0cLViff5hgtYoeBH8Rh3b9TO+am4Iqq+MNzrHKCZ+n9JJsXP6M1u8xj1ygZo5KCtiAoSEHURQouhuBeJoEziqDkemLEauP7vQ05GVdciMUOSDtf17GrAkXlvvi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091595; c=relaxed/simple;
	bh=d4u5pzoyizOb+YPm1k72BRclODI6VehGONBF1CRirzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqbiayOOuqmBl9bv6TtkzW5Zz9ySpXL6calNG4+EoUj6iBAU9Cd+XRUvMz+P9Nei7p/1N3EM4ULrQCxmnfsI3C4ZoQXsh4Oeq36P3WYFC2+uFe1iPpX81vNwS+dtTm1OrsB0mz4bVJuQ8t3Fdm/ToVXAyADLK93EegsmpZroX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPb5sMik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F71DC4CECD;
	Wed, 20 Nov 2024 08:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091594;
	bh=d4u5pzoyizOb+YPm1k72BRclODI6VehGONBF1CRirzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPb5sMikD3r3iGyeVMF4g5kC5fcJMDQzck/W7xvhwa6u3prvOtQtOlJCmy8LPb01I
	 3zk9Upzpe4Er28hVhCzOsnnctvGz6neLZy2MRtyAomr7CHzrhuej0lKH+AN2RVM/Xx
	 03Rykkk9cZz0YmnilVLYxr7MqCFkIEqM6JFIdDFX9DqYJAfQMZIxcU3A89BLfv2vBz
	 w7OTgSdN6PtC2JGMwsWuwfEYDwcyyHB6ENzBK25d9P4IXX/85ETC1Il497Ut0M4j8K
	 u1PiDGncxkWJNEbxSGEdIUgEMjClV2jXh79tg2S5ApP7M+eB9xloGoa6AD5gp0acnU
	 vVhHewvbpAtsA==
From: Christian Brauner <brauner@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iomap: zero range flush fixes
Date: Wed, 20 Nov 2024 09:33:01 +0100
Message-ID: <20241120-beklebt-spontan-2cf2d3927c2e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115200155.593665-1-bfoster@redhat.com>
References: <20241115200155.593665-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=brauner@kernel.org; h=from:subject:message-id; bh=d4u5pzoyizOb+YPm1k72BRclODI6VehGONBF1CRirzQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzju87twf5s/Ngdz7dr9i/PRi472DfMd8/kxXOZIV5 /1IJkVOq6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiUiUM/5Ne1P2wSdqreelE 6V4Rh+l9iS16E/gclyglXSyffGfBEWmG/0F1LQGFPxgFXR8dTxY68cR2mtoi+V/fzv368GbxAxV bZgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 Nov 2024 15:01:52 -0500, Brian Foster wrote:
> Here's v4 of the zero range flush improvements. No real major changes
> here, mostly minor whitespace, naming issues, etc.
> 
> Brian
> 
> v4:
> - Whitespace and variable naming fixes.
> - Split off patch 4 to a separate post.
> v3: https://lore.kernel.org/linux-fsdevel/20241108124246.198489-1-bfoster@redhat.com/
> - Added new patch 1 to always reset per-iter state in iomap_iter.
> - Dropped iomap_iter_init() helper.
> - Misc. cleanups.
> - Appended patch 4 to warn on zeroing beyond EOF.
> v2: https://lore.kernel.org/linux-fsdevel/20241031140449.439576-1-bfoster@redhat.com/
> - Added patch 1 to lift zeroed mapping handling code into caller.
> - Split unaligned start range handling at the top level.
> - Retain existing conditional flush behavior (vs. unconditional flush)
>   for the remaining range.
> v1: https://lore.kernel.org/linux-fsdevel/20241023143029.11275-1-bfoster@redhat.com/
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/3] iomap: reset per-iter state on non-error iter advances
      https://git.kernel.org/vfs/vfs/c/cad47157a55d
[2/3] iomap: lift zeroed mapping handling into iomap_zero_range()
      https://git.kernel.org/vfs/vfs/c/46538f0b405b
[3/3] iomap: elide flush from partial eof zero range
      https://git.kernel.org/vfs/vfs/c/c07ba2d5979b

