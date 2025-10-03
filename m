Return-Path: <linux-fsdevel+bounces-63336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ABEBB5D02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 04:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E87CD4EB8AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 02:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47F2DA75C;
	Fri,  3 Oct 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv5sPZHe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25E2D97BF
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759459029; cv=none; b=dt4GeT8RvCJ+Q7IGgNb6AsimqjzojLJeb18nkjR5kv1lfIef+5u1bQf9tr/EJyNPHxqyy58tu3duGVu8Iro+ok61kwMM+NHZIE+L+PYWBH6wcBBvFYNgcrvDNekfSrOjjIxHAmM7Tr/xkXFYnQ0WIVq5IkzAdPmcFJ+g2kUyc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759459029; c=relaxed/simple;
	bh=PMyWwSVypT6YzQkLu9bGNQp85E1aA4w3ZEet4c0nf08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUd2UGHZVt8/U0tbdheFuJGodHbbGm7ZSiTHlIOZFP8aPL3YKnmB/76OFk7Ghfdsn8dwPc+5K0Y/g63Z8CVVh4c0WOaYu9kRVDwzPprC0LyklXXox/ORLtSCqKDVHJ9k9l5mDpiHu8/aUqs9dnUGJxhr9PFfznClRStPWtmtIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv5sPZHe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e5980471eso8025495e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759459019; x=1760063819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kInZH3ybt0N4GUH4VhcSZWifxUtF3rFyE9dacK0tDJw=;
        b=Mv5sPZHeCY5rJA/ojGSySEvJY2VI4m4Msun6yRMJYeoqQAB20M1N5lbaIDOZE5TJpQ
         sAUlUvult5pveWtnLVQXTSArcJmBXXwexMxHsDmDf5Hrk2/OqeBLCaplItpo0MKbTNcU
         fe4/+fNFACwW8rcYdk0OgJpaKgdKogGbiYoVCgiCX6t3w1FNkhdeK7hM6KuryGMHSlFt
         I4xdlesh0+M4vmUf3sJgdrDzqZZBy+viqq55gNQDIiXhRTrcjs8b6BAvgMVQ5YX2dtdg
         HFLk8gUsPVW1DSDqYVPe2x/Im3NQfpud42JDEaQEbD/2vTsztKuO3pM0RrwRM//s3HAB
         VaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759459019; x=1760063819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kInZH3ybt0N4GUH4VhcSZWifxUtF3rFyE9dacK0tDJw=;
        b=QMRN12pvwHc3GdmtEtqu2Waq59n1i6a2kneErfycikXNnD34P7z/nlws6nNc1KjITB
         Yy9axbLIywbS1viBMuq0s38d2hrDQwhNn2h/XQycFeFUcJNTCBRme1+c/hwS7bN9QH9c
         RN9ZbMW3o3Tq+5IO26l6QSoMl7QniztAcUHJBKPLoqj4HKUhgS+WsVMsrSEnPi63PfOI
         r6h/oouDwqhSjF0Af/1o1Ynk2cdZCtoccCHyJuqIWUOWmg2708zUnSAOmBAebB3VJdjq
         M1cSFP3mO1CWeawll5nrKBT4wHt4dSm5Q9tk2F+t+M28wHY2ObmOpYXB8MqRpVLtwKPt
         LIvw==
X-Forwarded-Encrypted: i=1; AJvYcCW33Wa6kDgQR5OlhhKKrA7Vtj1YThqGVPe4kbxN1rQkdfWS2Os/IgNmzPE9V7nb65WuGqpeSYmSKU6vh6rU@vger.kernel.org
X-Gm-Message-State: AOJu0YzueVM5PtuIbWCxOhG8LAZO2e60lOqGeFSVIB5lI2TvbuTP5OzR
	VhYD6btfbQ0a82ftUKtUNG5t1xWfFExN1UFZ0JICJu0BInZhtMksIYL2
X-Gm-Gg: ASbGncvFUvJxMK/nLgFOi6b/SJkCEqwEatBEn6BVpzB0D5hQaBiXTzk2CgFDSgw49Lo
	g+ysqZrynqVIFNqQlOqrnQ9cvNo6SJt1+1BM1cbXUa4t60mPq0pJAIRRLCfeYLV39S57QgIfkfG
	UDhgs7Gduwws9uHGmbwbOElV53iaztZv+iyqR2C7f0mHzDLgeQI6BdfpAJiSGpDSuleWtFC8Hyk
	66SV1chPqhjPabPHJvGEh9v3KgRW0g05tH/nOFUvdUqqeuxbrpia1H2swRADo+NxZ7Q+Xwbl8qE
	SQJPzOnVAMJ73njNwcTzhTfQXxLkylyRRejimKnaopUPkHRcddHFz8msvmccRxKWTib9Lkab8Lj
	AJXxDZfgzUtayfpZgokbb1qsLYUvnrYjmAESMcv3lK+UGNUWsVgJFcH651/rKoDahUDxg/FPo4Z
	mKZuiPgbz2VLj0Av2SpCd5X09cHjgR0Q==
X-Google-Smtp-Source: AGHT+IFnJmy/ISWGEMnszAV7obn8uhvVoBfP0ixq0j6PZ8m6J96bhx4tpgaPl980VA8pVhJ6UOgtKg==
X-Received: by 2002:a05:600c:8b6e:b0:46e:3d50:362a with SMTP id 5b1f17b1804b1-46e710ffff6mr8234125e9.4.1759459019014;
        Thu, 02 Oct 2025 19:36:59 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3ac3sm108743995e9.9.2025.10.02.19.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 19:36:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: ocfs2-devel@lists.linux.dev
Cc: jack@suse.cz,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joseph.qi@linux.alibaba.com,
	brauner@kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
Date: Fri,  3 Oct 2025 04:36:52 +0200
Message-ID: <20251003023652.249775-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- rebase -- generic_delete_inode -> inode_just_drop

The original posting got derailed and then this got lost in the shuffle,
see: https://lore.kernel.org/linux-fsdevel/20250904154245.644875-1-mjguzik@gmail.com/

This is the only filesystem using the flag. The only other spot is in
iput_final().

I have a wip patch to sort out the writeback vs iput situation a little
bit and need this out of the way.

Even if said patch does not go in, this clearly pushes things forward by
removing flag usage.

 fs/ocfs2/inode.c       | 23 ++---------------------
 fs/ocfs2/inode.h       |  1 -
 fs/ocfs2/ocfs2_trace.h |  2 --
 fs/ocfs2/super.c       |  2 +-
 4 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..84115bf8b464 100644
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
index 53daa4482406..2c7ba1480f7a 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
 	.statfs		= ocfs2_statfs,
 	.alloc_inode	= ocfs2_alloc_inode,
 	.free_inode	= ocfs2_free_inode,
-	.drop_inode	= ocfs2_drop_inode,
+	.drop_inode	= inode_just_drop,
 	.evict_inode	= ocfs2_evict_inode,
 	.sync_fs	= ocfs2_sync_fs,
 	.put_super	= ocfs2_put_super,
-- 
2.43.0


