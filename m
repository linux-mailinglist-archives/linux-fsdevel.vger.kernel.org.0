Return-Path: <linux-fsdevel+bounces-66956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6DC319F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 15:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2311882AE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B232548F;
	Tue,  4 Nov 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHsN1zg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67C747F;
	Tue,  4 Nov 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267611; cv=none; b=XoC8dAHva1lQOsIUsd2UsfxxNayKgqZCizEynM15aVpVIGngmfUU8xZTT565UoLWpG2CPAJZBXNn8/YYuvCOgw47phUAXD/ocb3FTJOQL4cpiVoXS86hteh2Bo2Frt14mtvUZXeMk1NF73c0e8Hp7ijWdE1w0dPhM+B1u/8p2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267611; c=relaxed/simple;
	bh=bJGe3M67F1PW1S1kCIgK6SJOEj1QYHf3IIGt43ypE60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qBt+jnkitrEnc2pq6AwDkguQRRv4qPXZWDgR33+no8PgVb871KKwio8JT6B03EnpAe+SNelOu8z05zNApw9fMf3TKwOxVZRWkT4x34DkbFeW219f1YS/vOBUJd7iYsJW+PNhVxjLbUHbkWPDSaosh2eSsY94Suj2SF+SkdsiNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHsN1zg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C334C16AAE;
	Tue,  4 Nov 2025 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267610;
	bh=bJGe3M67F1PW1S1kCIgK6SJOEj1QYHf3IIGt43ypE60=;
	h=From:Subject:Date:To:Cc:From;
	b=gHsN1zg0zkSQuFC9OMcLIEX2rNKxpTROMiWec6Y5lq0qoXD2SZqxNu+jz+z5tn9+v
	 +ReTOuEgs1oOY7SD8CBP+oco4KxBfOaOUa3JgXAWRJBQtwZhglnSSh7KG5/umIbufi
	 GIc9UQ5nRmshSrUhfbvwTNcoPRFp7d855x7TxtliyAMsImeld1VD9RWZn3/EO945fi
	 yL+sdx+fbG7i6VepLVMWr8Yd3ZdsTzbGoZGq4wUtFU12JPcLDptKzeSLjbJXHz4jKA
	 Ku3YEeF7QibepXy7BkJP4+4IBfaPpzE1L3LFaRjG4wkZ0hxx8wA1pNhb1k2SDohVKZ
	 UkkEFY6tTygFg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] fs: start to split up fs.h
Date: Tue, 04 Nov 2025 15:46:31 +0100
Message-Id: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcRCmkC/x3MwQ6CMAyA4VchPVuyAiLxVYyHMjq3GIdpDZIQ3
 p3p8Tv8/wYmmsTgWm2gsiRLcy6gUwU+cn4IpqkYGteciVyH31mfGAyj8CSK1IfL4LhryROU6K0
 S0vof3u7FI5vgqJx9/G1ebB/ReulrGlB9C/t+AKge8d6DAAAA
X-Change-ID: 20251104-work-fs-header-16f780a431c1
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bJGe3M67F1PW1S1kCIgK6SJOEj1QYHf3IIGt43ypE60=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyCd7ovVj6LVi/9cPGW3q+PKYp+pqbTv8x0TnobaFSc
 JF/0p2gjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImEmDAy7NTfeW+pxPXK4vZG
 HuHvayZPCLbbuc1kacPdK3JlG8r2LWRkaEjQWb5hS+hGRZZUwReWJtpbb4TPNDp2WytA6gjzumI
 7LgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Take first steps to split up fs.h. Add fs_super_types.h and fs_super.h
headers that contain the types and functions associated with super
blocks respectively.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      fs: rename fs_types.h to fs_dirent.h
      fs: add fs_super_types header
      fs: add fs_super.h header

 fs/Makefile                               |   2 +-
 fs/{fs_types.c => fs_dirent.c}            |   2 +-
 include/linux/fs.h                        | 526 +-----------------------------
 include/linux/{fs_types.h => fs_dirent.h} |  11 +-
 include/linux/fs_super.h                  | 233 +++++++++++++
 include/linux/fs_super_types.h            | 335 +++++++++++++++++++
 6 files changed, 578 insertions(+), 531 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251104-work-fs-header-16f780a431c1


