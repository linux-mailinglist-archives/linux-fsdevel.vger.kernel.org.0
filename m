Return-Path: <linux-fsdevel+bounces-66939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD7C30EB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61AA18C3E88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3F2F5A1E;
	Tue,  4 Nov 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEM7yhgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696532F547F;
	Tue,  4 Nov 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258369; cv=none; b=trGJb4prOmkMWmkIFM9jhC+X0y1gPQFx9iaQ4SLDk7BoznQqw3wvNvRzObvTAWnE2LshVk5XU8oWbRq336y9O2rbGr/KXrC86HZF8pB78HCz0AaNc9SWNRUahevcxCQkS06hex7JLWqn2FY9V4TE/EbGa2LNAg8IxbeXfK75NA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258369; c=relaxed/simple;
	bh=Tq1Jbn4RgD106bv6jZeZgPUyGBozrcffIRSjvdoEX2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auZN/ZvSBEtWtvlDC/qPK9Bx8iPe2l4rgH9HFMgAUrV+3SOz+q66zxxinJ6JIgpfT5epjMd/kKWj1n4ZxIhJ71G8pIlQSNcuUmzP8zkZjAD2CzO/Ds30ObK4GwCya7QvqnYkckcd68bUfXdWvwKI4jbPcISeR8LIt4wphoQWvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEM7yhgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7756C116B1;
	Tue,  4 Nov 2025 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258369;
	bh=Tq1Jbn4RgD106bv6jZeZgPUyGBozrcffIRSjvdoEX2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JEM7yhgmnsQiy/zilQ2gQkjzDLWyKd1el5zu8kMzknpBidpYRyVhK3HgJx/AKhPZ6
	 m7lZkiyRA4nlH8mmArgwKPqw3r+6KFClWXF/ua6n7am/nCorP0bgOq5op9nxsmMXnl
	 wuAZv+k33PjCIr93jvpt6V71+LPiHdmtNKAzr2cI4b54UHN9MO/I4oXwD3lGCV3NiK
	 51j9KOVs4KSyPgBDKYMIMcrhZzsrGiLAotfwgkkibNkUWw/rH/0h2jVWk85wqoDwa6
	 nAFztP19gEzPyql07QqjqZp7HWypjzwlQv0KIR1jXnhRyg+M8oUWsHt1HAQTKpFxxF
	 LqOlGVKsL4VFw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:34 +0100
Subject: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Tq1Jbn4RgD106bv6jZeZgPUyGBozrcffIRSjvdoEX2U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt2SePLW3FWfj7q3t0zp+eVcvennuzTZz8fXTXZla
 3x2pb5LsaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAim7Yw/E/rcH/59uUZBn/R
 v+zXErvi/0uZb/kw9TPDfzHtfTzi7o2MDEsD/vo3XPxqIHgwyO/YUp/3jT8+r77NqWQfdiZap2i
 zCh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/mmp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index ab1ff51302fb..6f57c181ff77 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
 
 static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
 {
-	int err;
-
 	/*
 	 * We protect against freezing so that we don't create dirty buffers
 	 * on frozen filesystem.
 	 */
-	sb_start_write(sb);
-	err = write_mmp_block_thawed(sb, bh);
-	sb_end_write(sb);
-	return err;
+	scoped_guard(super_write, sb)
+		return write_mmp_block_thawed(sb, bh);
 }
 
 /*

-- 
2.47.3


