Return-Path: <linux-fsdevel+bounces-37625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D821B9F4ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA3188970E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 12:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3A1F12F9;
	Tue, 17 Dec 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+9EAvda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155313A3ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438187; cv=none; b=LKADrb2mFGVixaJ5Iu8pc7jXF8uSow2275yqxkATx3hWZ9bfGYqb1xQx3CvIFv0QkCZTrr+3uTrJODrLYaNowcY20G5V3kCgwYyZ3s4G4trliP7RrHVpQaKNnGUPT1qZzd1iwiz9p8LSxzIbdrKDKYLrkWEn3LU8rGTHLZEVcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438187; c=relaxed/simple;
	bh=l7x6BTjUlZNO3RLLrAguo2JtJMP28VrhcgRlw06oFRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKAup2YU4M9PZNqJRePV9KId6/T6WYLzivogiCUEToaQXOexHpu1x1fseiCoznB1T5K49Fut5guTWRcM2CdXawHe8a/CCqfk9YgEWbe8UOCU0aFXBCw/LrqxoJk9I602gA3BnSEo6tn2INA3YHVoJrMOeAUMUaxk6UpnZUJ1sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+9EAvda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C748FC4CED3;
	Tue, 17 Dec 2024 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734438186;
	bh=l7x6BTjUlZNO3RLLrAguo2JtJMP28VrhcgRlw06oFRs=;
	h=From:To:Cc:Subject:Date:From;
	b=b+9EAvda6aap98QptOflsuTS1OaAazAisvuXtov0jvbKzrOF+LAad19u2HURmB05m
	 B12lRh7a85m4wmHl3A9DuM3eyZXNs3uxVz1tEYKdTnUCxS+PaVrKxTjKz7sWexUxlP
	 gTk6rdMZJW0eWlA6oO0o2YB4GGQTk0nH26Lw2DcCW3M37+Hal7YneywYuDY59TvJZF
	 hzAMC1E7ygR0ics2z2j/YrMo4wyh1A6/ZPFojdcXVWqGkoZpMMQXhL4y+5/Th3jV+C
	 0TGO6l6HxThQuqv+LFAoa6ULgIJtaPqo40sP4iv9zYVjgWtM60EcEjzbrJe9UveGtW
	 LHYjlqr3GGNYg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] fs: use xarray for old mount id
Date: Tue, 17 Dec 2024 13:21:55 +0100
Message-ID: <20241217-erhielten-regung-44bb1604ca8f@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798; i=brauner@kernel.org; h=from:subject:message-id; bh=l7x6BTjUlZNO3RLLrAguo2JtJMP28VrhcgRlw06oFRs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQn5jxVZjS4cuRO568CbY+KHS8MgtNuTF+9VmhVmKf7n rfqU9YndZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk4Tsjw1cf27emER1mTC// pP/P+1zzV+Xmlqtt75WfaszhFp68gY/hf9bx5gslOTcOX5B+rni3eteX9EKG27ksXLOvN3m2SXN d5QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

While the ida does use the xarray internally we can use it explicitly
which allows us to increment the unique mount id under the xa lock.
This allows us to remove the atomic as we're now allocating both ids in
one go.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d99a3c2c5e5c..e102aaaa065c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -65,12 +65,12 @@ static int __init set_mphash_entries(char *str)
 __setup("mphash_entries=", set_mphash_entries);
 
 static u64 event;
-static DEFINE_IDA(mnt_id_ida);
+static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
 
 /* Don't allow confusion with old 32bit mount ID */
 #define MNT_UNIQUE_ID_OFFSET (1ULL << 31)
-static atomic64_t mnt_id_ctr = ATOMIC64_INIT(MNT_UNIQUE_ID_OFFSET);
+static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
 
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
@@ -270,18 +270,19 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
 
 static int mnt_alloc_id(struct mount *mnt)
 {
-	int res = ida_alloc(&mnt_id_ida, GFP_KERNEL);
+	int res;
 
-	if (res < 0)
-		return res;
-	mnt->mnt_id = res;
-	mnt->mnt_id_unique = atomic64_inc_return(&mnt_id_ctr);
+	xa_lock(&mnt_id_xa);
+	res = __xa_alloc(&mnt_id_xa, &mnt->mnt_id, mnt, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	if (!res)
+		mnt->mnt_id_unique = ++mnt_id_ctr;
+	xa_unlock(&mnt_id_xa);
 	return 0;
 }
 
 static void mnt_free_id(struct mount *mnt)
 {
-	ida_free(&mnt_id_ida, mnt->mnt_id);
+	xa_erase(&mnt_id_xa, mnt->mnt_id);
 }
 
 /*
-- 
2.45.2


