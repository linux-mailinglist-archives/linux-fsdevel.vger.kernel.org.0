Return-Path: <linux-fsdevel+bounces-29506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCDA97A3C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5AFB29E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAFE158A00;
	Mon, 16 Sep 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="QPrZ5t4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C57156F36;
	Mon, 16 Sep 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495497; cv=none; b=DCdB+oCE+TlW1D8sUYNSzP1qyB7QFZSMvs3vERQm6kIuJ8J69VCYauc0fiBInFYOmMu/yKG5dn0HEyVGfzSCeIsH2UeyjTRDVZJ+n488GQbuRxIwghJ/mStlJJFtzNG/5DLAfH16OLyz24Jo2bjX83+ZWq2RT5HA21SszIZt1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495497; c=relaxed/simple;
	bh=82Pe3spVi8IHf0iaRSv2lTfetUa49rokuqEYMW7OxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv3ojCjheY0l4m7WnHuPabLSx2CITaU7dVjQYcAPBzPK1MsvMkA6aqB/glP8qlFKp+DyicRlKJRM0lOadggCQAjpGfH7A6Fo0BCxRQdyUbMClOZTb16p9alOA7MCZtjXiAzA9HxZbOhXEeNO8ZkE5CLLrh9NAIna+rlkxeNhgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=QPrZ5t4h; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFBD969960;
	Mon, 16 Sep 2024 09:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494959; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	b=QPrZ5t4her/8AqCU4Iaw76WzB/tVPUXjSJhli+A3tTxISQP/t20LUrFmoq2j2c7foKM7W1
	yeMmsFJg84bfucAURCoKi5pL/ENBe6x2RWV8+Sj/IKKhZsAP6xHPMsxp7swp2XZ1njlF7z
	fsg+jQJjB0DCkPGguMjNbbURnPoFcB+0Ig0ZOX2H1y4vzAyMwwIOewohYrOhWU7bf5h5fq
	JVKLji3Jsz6hk0fJFjSDzpv7vCczn8KCoKk93/TZ03jb2TfK5N+eYwQoXN0t2BvBNojFhE
	liZpXCNMlx7kNFvP6nzDKXa8Mfbq/p55GtVXvRloNzfWZEp4KGYBoQZTr+ZkpQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 01/24] erofs: lift up erofs_fill_inode to global
Date: Mon, 16 Sep 2024 21:55:18 +0800
Message-ID: <20240916135541.98096-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135541.98096-1-toolmanp@tlmp.cc>
References: <20240916135541.98096-1-toolmanp@tlmp.cc>
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


