Return-Path: <linux-fsdevel+bounces-60284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E077AB440CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697911CC035B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9C280A5A;
	Thu,  4 Sep 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm1zGC8/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AD27FB34;
	Thu,  4 Sep 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000579; cv=none; b=VQTpR0GXqPlp+Q2Ekj3b7h5HxJPuR9gGJ/oRbf1jop9Bz41hZl5GJZVKUUGZEdDnzT6wCnHPJbVHgdoY5/91mKWpewZGZeRFxJvTA4NRMDZrFqfi2dU9YAsREX9zx2yQ2QlKycu7/QwLyF15up6YQZ+30Ye4gd2YBboAnv79q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000579; c=relaxed/simple;
	bh=gOe0pz0zArHDJpXSJ+UyWuJXMkKo6QQ0sqvBqWGwJFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkYP6sJyLF9bCt1/xHKTOlfiMI96TxbHC7+UaqA52hRAO/ZjtnZwgEfgmKXWfqTbF153bqr6tGyICkTLsaYgnDXjGvxba1+lEqlcoYbx60xSshvA5TfOvXghTT9nbxeIv3jDW5RjlzbH50qh35nDaS2tzdGkYO/5D/saGbJ6neU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xm1zGC8/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0454d63802so201752066b.2;
        Thu, 04 Sep 2025 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757000576; x=1757605376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxtEG0qwiZaZ8oHUoRK4vA/qZBBJzQqqcvVD5IAjpmA=;
        b=Xm1zGC8/bFFGUTHO2nv48AB/FPKuPBRbd+oRpuRweCGLFe2d36f9WiXQ7fqcd4C5V4
         1rES9vNPGIILQTIs5xlszdpmCRM8LMXzWKY6W0cdmWgaEYIwXIEt9yr+WSycUuJbiErD
         mUECAjcP/64CyX5JTmL55U1HgOJ6sMGE0q4Ej7P0NuB1OtM/KscwLyC32WpnWLdsmO8+
         9ScV6lr7ac83MhLfyb6nxyT4DuzmwN0hJB7gJsisOTOTvXIZbChJWB7TfaQYhOd5myqJ
         RE2pzTMalvH1eg67rXJaJe4w1C9KWxD3R9Tc8dZQpc2qJuozyTPKtyMF0hHJIQ3jpnjI
         FZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757000576; x=1757605376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxtEG0qwiZaZ8oHUoRK4vA/qZBBJzQqqcvVD5IAjpmA=;
        b=ApCPh0wtRnfZjo7LKf2umJE2IOFssnaajBgsEuHeLjiyxDHVY2m0Y0q+1Xs27DKDCk
         j81dD7L6SQCIqX2S9K/T+fqhYsrb+8DZlxPC0WdBquIWhOB2aPnl3UJTS1DGlVrK2Wxe
         Ox6yirvl0RRZZOETYPOyiv45nHF94jE258r7I1LQgW+sRAcDrz95oPV8IW11UyT/IaLu
         xhRPjTE9C9l/AwZDcGzuz4gmUf3vHC4mx3PMeisONDIz0oS/wjYRb5MgrAxKXagZiQd8
         iEvFG4fRYNDw1lN5capoAgQTcLZeYMjN+6lm30xKMFX2V7r6WD26K/S6DHhATAhAa6JP
         qGzw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQN43eIUxeTve3F0bUjR40LiqCiKihLtikAuWweuHZOEH38pt8nlwrCThRiTmpHCgsxapOnSMUHR7GbVx@vger.kernel.org, AJvYcCWsD/nzbQF8aLHMGjLYQuZOi/yAzxNinuH8YgVC3dYAfID7WTvSM56ZF9KPbBJ5RI4kB7tVA8PKgOB76hFV@vger.kernel.org
X-Gm-Message-State: AOJu0YwHvLxiRvy8HsBWcZ802K1LzXliaILYIat7sDEIN3CfoyqH+LXl
	WMluMFtsp9MyJYw5D3603NAViAn0MTdIarPpK5UMYC8yLX1/84RgalzA
X-Gm-Gg: ASbGnct6z/MUUtf5O2X1nMtb0BQEjs/VNS/1eVssMyTlSyvethIQ/kGKhs8RRfpElg/
	gSttihLOJlqiIUbbf1Q7xM/CE4ahwdTPPakt6rVZvo+5ZTPjTtJW+Yvsqku+mtGJhI29AZdcdha
	nGdrP+QmNPnAErHrR7HUuIbFi34KNPFsBIrY0vZ99lZ+qz/3h6xoCQVhQgAyoQOoUzl+Pc0QbHP
	u5Cthh6saN8/l/qxeF6hjQFvsmkx3arGPBru7QsIzt7Ol1k1FiI7BxfYxBcb+gte0nCU0BJSwVi
	s4dxnTQEZ/iyYSdv5mobeJzxHkya7kTsCdb2UXU1fbp0lu/sN6tcB4u6Sea+juwWcCrS30kXcqq
	iQDSVmBedP0vK9ojTeaoezMw71TlUIkzAS7/clR/m9RKVh8d780I=
X-Google-Smtp-Source: AGHT+IFM3LxYoMMMqXwQh9SoZAimhtZroBuXTFmNhUUuKzs+mzhruTYm1oUTLuDrc1eRGUlI9Ahz8w==
X-Received: by 2002:a17:907:6e8d:b0:afe:94d7:775e with SMTP id a640c23a62f3a-b01d8a75726mr2093924266b.18.1757000575468;
        Thu, 04 Sep 2025 08:42:55 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5622f0sm14172711a12.51.2025.09.04.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:42:54 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: ocfs2-devel@lists.linux.dev
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	joseph.qi@linux.alibaba.com,
	jlbec@evilplan.org,
	mark@fasheh.com,
	brauner@kernel.org,
	willy@infradead.org,
	david@fromorbit.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
Date: Thu,  4 Sep 2025 17:42:45 +0200
Message-ID: <20250904154245.644875-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This postpones the writeout to ocfs2_evict_inode(), which I'm told is
fine (tm).

The intent is to retire the I_WILL_FREE flag.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

ACHTUNG: only compile-time tested. Need an ocfs2 person to ack it.

btw grep shows comments referencing ocfs2_drop_inode() which are already
stale on the stock kernel, I opted to not touch them.

This ties into an effort to remove the I_WILL_FREE flag, unblocking
other work. If accepted would be probably best taken through vfs
branches with said work, see https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.18.inode.refcount.preliminaries

 fs/ocfs2/inode.c       | 23 ++---------------------
 fs/ocfs2/inode.h       |  1 -
 fs/ocfs2/ocfs2_trace.h |  2 --
 fs/ocfs2/super.c       |  2 +-
 4 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 6c4f78f473fb..5f4a2cbc505d 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode)
 
 void ocfs2_evict_inode(struct inode *inode)
 {
+	write_inode_now(inode, 1);
+
 	if (!inode->i_nlink ||
 	    (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
 		ocfs2_delete_inode(inode);
@@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
 	ocfs2_clear_inode(inode);
 }
 
-/* Called under inode_lock, with no more references on the
- * struct inode, so it's safe here to check the flags field
- * and to manipulate i_nlink without any other locks. */
-int ocfs2_drop_inode(struct inode *inode)
-{
-	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-
-	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
-				inode->i_nlink, oi->ip_flags);
-
-	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
-	spin_unlock(&inode->i_lock);
-	write_inode_now(inode, 1);
-	spin_lock(&inode->i_lock);
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
-
-	return 1;
-}
-
 /*
  * This is called from our getattr.
  */
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index accf03d4765e..07bd838e7843 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
 }
 
 void ocfs2_evict_inode(struct inode *inode);
-int ocfs2_drop_inode(struct inode *inode);
 
 /* Flags for ocfs2_iget() */
 #define OCFS2_FI_FLAG_SYSFILE		0x1
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index 54ed1495de9a..4b32fb5658ad 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
 
 DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
 
-DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
-
 TRACE_EVENT(ocfs2_inode_revalidate,
 	TP_PROTO(void *inode, unsigned long long ino,
 		 unsigned int flags),
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 53daa4482406..e4b0d25f4869 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
 	.statfs		= ocfs2_statfs,
 	.alloc_inode	= ocfs2_alloc_inode,
 	.free_inode	= ocfs2_free_inode,
-	.drop_inode	= ocfs2_drop_inode,
+	.drop_inode	= generic_delete_inode,
 	.evict_inode	= ocfs2_evict_inode,
 	.sync_fs	= ocfs2_sync_fs,
 	.put_super	= ocfs2_put_super,
-- 
2.43.0


