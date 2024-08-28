Return-Path: <linux-fsdevel+bounces-27549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD31962553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907BB1F23CF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134416C42C;
	Wed, 28 Aug 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFdDRb5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D08168C26
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842623; cv=none; b=MrfQljnOPCZIGHLyVRwt0/MX1mDvg8bQ7IGn2LjSiUCLhCfhTtJwWOg3Ns5FkGUWoTJBnsI7baF+9rrTyHpbys+TYPgOT7/A+395kM/EIt1y4Zll3JPULWyfFY/hHQjqPGgYLNWxrwgbOknXKMk0dUFFWPDJRZaeYuTD0ILi87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842623; c=relaxed/simple;
	bh=30jtxC8VQgZtD1NmPoRfx+NWuzYQzJ6T6yXQfSWpXBU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oxHftQOp/fq4hW7+pa4XP9nHbP7uMEB2QIhgTeisvCmQGnctg+vfx5yyTcu2KKEKgjuo2PmEYn0hEZAiGRmaxp9O+lskapAJrqXGew++7nP77HGeyB6GOVpnZXJpaXt7BTdAJVhpQIfxoeGaNwX2FO5eX/mKApmYUAyAmBAGdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFdDRb5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE589C4CAB7;
	Wed, 28 Aug 2024 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724842623;
	bh=30jtxC8VQgZtD1NmPoRfx+NWuzYQzJ6T6yXQfSWpXBU=;
	h=From:Subject:Date:To:Cc:From;
	b=KFdDRb5pWNd/hkQ7AKhObZGrGAiG6B7hGfZ08Z1+an4myKbwfFcWUfgGaD8LcMcyC
	 BAVx9b2Ffrupl1ogCReHSgf7F9CeQIX6JANi9bPBf0eIKRZ9IXWJBz1QKp3tVuRfd+
	 cr+sWrDqRhwzdCaHDTXus7ohAjy3b5S0N5B+4Nbo6XoIV3i4P3CCZlr4tPvC3oIGFZ
	 lmOJZIGssx+D+RrOVmxHeX3wdAJZ8va+SJXXay2WBMc+bdBkbTvupd2VRA8TsAcvPN
	 qgOBewD82hGSFUlHTp7UcecLq/cOXW+xPenOcenaXZ8C/h/3kZADZCtKzd8FWXeZCc
	 1DdEwwcukIeCA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/3] fs,mm: add kmem_cache_create_rcu()
Date: Wed, 28 Aug 2024 12:56:22 +0200
Message-Id: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYCz2YC/22OzWrDMBCEXyXo3A2q0vgnp7xHCEVej2OhWgqrW
 G0JfvfKgUAOve3AfPPtXSWIQ1KHzV0JsksuhhJ2bxvFow0XkOtLVkabD92Ymr6jePITpk+2PIK
 EZxraGrt9pTVzpQp5FQzu57F6Opfc2QTqxAYe1608pO3kEq/V0aVblN+HP7+vwFNVUfR+vjoIA
 oXi6hF8OfumsVyZGm3HxzI6B4haLdm84v9/mg1pqjtuudX9HhiOHhLwtY1yUedlWf4Anb3YMhE
 BAAA=
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2197; i=brauner@kernel.org;
 h=from:subject:message-id; bh=30jtxC8VQgZtD1NmPoRfx+NWuzYQzJ6T6yXQfSWpXBU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdZ6rRf3l7kRRTmk10TUNq0+Yv/4T2LjtxUk/2ewL7d
 03NKd/PdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk72tGhhOXw78Jqno5zDgq
 +d725b+fsZVHWk+v2HyPsdwsSimoNIeR4cKri99jb/G77J1YpRQTY9yhUb8uk+tv3ayFeneeTvt
 VxgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
must be located outside of the object because we don't know what part of
the memory can safely be overwritten as it may be needed to prevent
object recycling.

That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
new cacheline. This is the case for .e.g, struct file. After having it
shrunk down by 40 bytes and having it fit in three cachelines we still
have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
accomodate the free pointer and is hardware cacheline aligned.

I tried to find ways to rectify this as struct file is pretty much
everywhere and having it use less memory is a good thing.

Before this series cat /proc/slabinfo:

filp                1198   1248    256   32    2 : tunables    0    0    0 : slabdata     39     39      0
                                   ^^^

After this series cat /proc/slabinfo:

filp                1323   1323    192   21    1 : tunables    0    0    0 : slabdata     63     63      0
                                   ^^^
I was hoping to get something to this effect into v6.12.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Check for alignment of freeptr.
- Minor documentation fixes.
- Fix freeptr validation.
- Link to v2: https://lore.kernel.org/r/20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org

Changes in v2:
- Export freeptr_t.
- Remove boolean.
- Various other fixes
- Link to v1: https://lore.kernel.org/r/20240826-okkupieren-nachdenken-d88ac627e9bc@brauner

---
Christian Brauner (3):
      mm: remove unused root_cache argument
      mm: add kmem_cache_create_rcu()
      fs: use kmem_cache_create_rcu()

 fs/file_table.c      |   6 +--
 include/linux/fs.h   |   2 +
 include/linux/slab.h |   9 ++++
 mm/slab.h            |   2 +
 mm/slab_common.c     | 139 ++++++++++++++++++++++++++++++++++++---------------
 mm/slub.c            |  20 +++++---
 6 files changed, 127 insertions(+), 51 deletions(-)
---
base-commit: 766508e7e2c5075eb744cb29b8cef6fa835b0344
change-id: 20240827-work-kmem_cache-rcu-f97e35600cc6


