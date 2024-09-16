Return-Path: <linux-fsdevel+bounces-29481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6197A356
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66E62864D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DA155359;
	Mon, 16 Sep 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="b/wTow6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B5156F57;
	Mon, 16 Sep 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495002; cv=none; b=tn0hSgVFUKf8dyEvfZ9tDTTCTM8ys2VskwNMIOguUcpCQxePOqnzuxZUYZ/l92ELUUxKnG40dNOz1PITOvdM1h/ZNKrYY6g23wPA+8f1eAoZkHGcZSp5A55QIFEFDfpqMZ0vU/MSOS0lrwF9Op7k6+dPaBYFCoWE+V9SrgjQNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495002; c=relaxed/simple;
	bh=82Pe3spVi8IHf0iaRSv2lTfetUa49rokuqEYMW7OxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I61giSfErZgswwK8kh2ff25Gb26Xxwvg4PHL1tZpP5Momy4fe9KlA1F+TIKzBtfIDNxRC5+E/73qu5J8OCG+SPv6ABFXVHvtB57MiM6cppW4lqrEVHJt5BIqEy8ThP8U0W37DVGhTiRjTORDSQ1o4rdDT+Fp6UEMZDIvaFXwAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=b/wTow6m; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B2F069839;
	Mon, 16 Sep 2024 09:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495000; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	b=b/wTow6mW0pOJ3SLs4zdqnSvHOdwRM0/wdgLDvfxyE4lsB8GyguL7sAgA+xYYDLNTmQihH
	7ygxxN4fyFCXoJ+tUXTs4fVSdbyr0AqIv60ObsXlONL5RpEblVyzOlurHAcuGYpXMIPBnF
	XO/4Gk/f1Ptz3jGeS+dkc0aoqHc1RGiNYM6z5Tesui+jAGQLiGFs3Y+EHQCBSnq88FHD4c
	oOxVuvXQwUMfkOK3DTv4FbdHv+Cxmzv+c/7abQbrqbHDAbqRSglrwuRcUJwWO/Gi5S6GFT
	wzL8ysO2z7HjFBxJOG4sRxcCPECdkMxop4zKibbhekbjBeCxhuqNcLH9oGGRNw==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 01/24] erofs: lift up erofs_fill_inode to global
Date: Mon, 16 Sep 2024 21:56:11 +0800
Message-ID: <20240916135634.98554-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135634.98554-1-toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Lift up erofs_fill_inode as a global symbol so that
rust_helpers can use it for better compatibility.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c    | 2 +-
 fs/erofs/internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index db29190656eb..d2fd51fcebd2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -196,7 +196,7 @@ static int erofs_read_inode(struct inode *inode)
 	return err;
 }
 
-static int erofs_fill_inode(struct inode *inode)
+int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	int err;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..8674a4cb9d39 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -416,6 +416,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 void erofs_onlinefolio_init(struct folio *folio);
 void erofs_onlinefolio_split(struct folio *folio);
 void erofs_onlinefolio_end(struct folio *folio, int err);
+int erofs_fill_inode(struct inode *inode);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
-- 
2.46.0


