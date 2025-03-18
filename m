Return-Path: <linux-fsdevel+bounces-44352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3220DA67D38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716C0189E669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B31E7C12;
	Tue, 18 Mar 2025 19:41:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7B1DF240;
	Tue, 18 Mar 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326890; cv=none; b=ScGKH/K1H3V/V7qQ5h/QYhKOkP/A0nIkqJ+ofjr5jA0SM8w1lyljbazZVZN9quZcn9JU/CsSSFcXnSoyo7JOyKKxHklLngBy7Cueocm6rkC7JO1X4jUqV2ykONyfqzHs91AuDXaBuGTbXBYI5k7Pt4jaUloP9yK0+DTvE9zi9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326890; c=relaxed/simple;
	bh=FfPNy/lJNwkJg17dcThJ/7LOd/2Fn57IyUib+XP2Fkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tws/oqfZGkEwkZMjREXhka0WC/LFWdg6LK2o6i4qWOt0Vu3AX8CZuHGb+1tImIsFy9CDfLhyNRRgKZ8Y0OeWtjkQP8DV0cDC8pmnklSz/Qbx6vOyjFvh3jYM3WQf1+keJyZMzOmPLhRQEfIIJ+EiiVvaTCf+mUj+UnmmXUskmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 0B46E1C0024;
	Tue, 18 Mar 2025 15:41:27 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 0/3] create simple libfs directory iterator and make efivarfs use it
Date: Tue, 18 Mar 2025 15:41:08 -0400
Message-ID: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Note this is built on top of the previous patch to populate path.mnt]

This turned out to be much simpler than I feared.  The first patch
breaks out the core of the current dcache_readdir() into an internal
function with a callback (there should be no functional change).  The
second adds a new API, simple_iterate_call(), which loops over the
dentries in the next level and executes a callback for each one and
the third which removes all the efivarfs superblock and mnt crud and
replaces it with this simple callback interface.  I think the
diffstats of the third patch demonstrate how much nicer it is for us:

 1 file changed, 7 insertions(+), 96 deletions(-)

Regards,

James

---

James Bottomley (3):
  libfs: rework dcache_readdir to use an internal function with callback
  libfs: add simple directory iteration function with callback
  efivarfs: replace iterate_dir with libfs function simple_iterate_call

 fs/efivarfs/super.c | 103 +++-----------------------------------------
 fs/libfs.c          |  74 +++++++++++++++++++++++++------
 include/linux/fs.h  |   2 +
 3 files changed, 71 insertions(+), 108 deletions(-)

-- 
2.43.0


