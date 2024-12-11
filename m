Return-Path: <linux-fsdevel+bounces-37043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4749EC9FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3044116364B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE81EC4DF;
	Wed, 11 Dec 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqKK4AkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481A1A8406;
	Wed, 11 Dec 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911830; cv=none; b=VsGf3oa9gpkoBQMj8i/NMV0JhdE6r1CFX6pguSDh9aOsHKxH3XXc7X0b7ONqb6V1zIB0rUSOyo5lGyLgA67AtrPFVsH8N3UheUqu8T9+5ZWUebxCZQJJ3X3EEC7WrEQrQwwJ/neiGv/WHQti5pm/Jf8AKqi4+BmoUJA7w/4XB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911830; c=relaxed/simple;
	bh=yWfcvtwWM1MJH1SMNh2l97QGFripWiifOCzK/Bv4ylY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmHiOOTQqa01qp/GK6lABTZWBWk1uOA3Ii5FCjWQ/blvcR5FZx3Qx0PWIAQB0dBiedcxSIZpsbTdDp/VDZzTNSIUcuHA6M0Xkn+gSpyrgUi6GVcBSUnOrbzoFRzu2IUmktKIVBzhQAgTJVq280/tB7/ahKiQ3zh82A+YN1DqX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqKK4AkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E2CC4CED2;
	Wed, 11 Dec 2024 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733911829;
	bh=yWfcvtwWM1MJH1SMNh2l97QGFripWiifOCzK/Bv4ylY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqKK4AkO6SOD22t831Ps9F7zK+yWO1qFi7mgDHEzfg9VYezeLCaUgfg5WGnPNCpcm
	 54KvTyDGtVgKjwtiKfg4CvOvzdqYwKL0DymsyxdZcSys/tgw9ZXNq5AA61bMxiEyut
	 bU0tSqZKs97k1DlG50fXD0WgpV1a5ZHQr8S962LS3Mlz/wLd1VFjrUCNVcaSQhAGjK
	 AQIVNLFAghVOx5mmK0i6Bo8eI9GUSJe9uqY5l+2KXjr3LUi7EzjBaiisKsbbMcnul9
	 L3xSe9tWlraz9oSDOI4iy5gQV59ayprtNqOdUMA4TNfsFDbshITB9zQwv+EwLLiZaI
	 J4+JuhWX0tqHA==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	cem@kernel.org,
	Long Li <leo.lilong@huawei.com>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: Re: (subset) [PATCH v6 0/3] iomap: fix zero padding data issue in concurrent append writes
Date: Wed, 11 Dec 2024 11:09:50 +0100
Message-ID: <20241211-rausspringen-lunge-c1567b59c8f0@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209114241.3725722-1-leo.lilong@huawei.com>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=brauner@kernel.org; h=from:subject:message-id; bh=yWfcvtwWM1MJH1SMNh2l97QGFripWiifOCzK/Bv4ylY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHpnyydTg6ZyGP94Xgp2Weessd1szfs5pLSnTGwsp3a 5pzzz6/01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARnmKG/7EXIyT6VHyrfW33 vppQM993/od9rvtOb7v/8dg19h9B6ZMYGT7JvNz95ZGn0dzpJ3pm7xJO+y2b7NUVW1ntoLOb9UT oVDYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 09 Dec 2024 19:42:38 +0800, Long Li wrote:
> This patch series fixes zero padding data issues in concurrent append write
> scenarios. A detailed problem description and solution can be found in patch 2.
> Patch 1 is introduced as preparation for the fix in patch 2, eliminating the
> need to resample inode size for io_size trimming and avoiding issues caused
> by inode size changes during concurrent writeback and truncate operations.
> Patch 3 is a minor cleanup.
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

[1/3] iomap: pass byte granular end position to iomap_add_to_ioend
      https://git.kernel.org/vfs/vfs/c/b44679c63e4d
[2/3] iomap: fix zero padding data issue in concurrent append writes
      https://git.kernel.org/vfs/vfs/c/51d20d1dacbe

