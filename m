Return-Path: <linux-fsdevel+bounces-67799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A1EC4BADF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5744734DEDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6132D77E2;
	Tue, 11 Nov 2025 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptR8aU5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A32D6400
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842514; cv=none; b=GZ5ds3NP18NoD9KzFnaXb2X5YR+yuzrYbr9lL1SOcLS06ky6nobKkEXhCBCzGBG5Q76hhs6UAj1qOx07Mno278NiwHDGzsMUt8k11Ol94QMBs8CJAE7fJMuFi7/Gvn9AoLpQHIphPxtlbt3QCiHd3nHyoWqHw00wHSg2rQtTDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842514; c=relaxed/simple;
	bh=fhMrgQz20uh4PXK2nkAxqWB+AOOUbEsG24S6VIqSBO4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eWODoqE9Sn18Y4TtbsJ7CLd3m3V1m3SX7igmMBjNmBVqdeybH2RUx1RaUTeaGfdff0e2jdweqj5myoQ1LUvXueKhc8ZvquWeaWHcIG1CgHhPEn7uu0aV+rG1VPy1IFMwp0He9+D7lxfM6Vx5F0O6lUmxjhlz6BigFlHxr7/2I9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptR8aU5K; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-9489bfaef15so230964039f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762842511; x=1763447311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmSc84hT8MIqkBb125h6Fg0cbHYTnrDRYFuzpYBDlHI=;
        b=ptR8aU5KUGZz38dTRCLRct2KyAGM0JkihTN0FeqBlwdncW4sfsQAWcE47nm2IR60ZP
         5aBNqCBtyaBpv4KuEHwlGmcrSB2ZYhLzkCUHk6bmeNBKlGpiyB/qr0Jj4IGgatSAE12b
         5HSfe0p7C5SXFDszFFVMqQVWhCdrJ6YKcNcnveTSFkutIm2cTjBVCd6QOqlzyFM4VHMq
         yonCmKoDWifr15qvZfcF6pwZ6CPB3bP5RSSV2ZHaoSWf4a1ARE+YTrswPR6kl9CbLCAI
         Bs3hTdBWe+NHDUSyEbY85+qDakPzVieWo9ab6o/AknMkDTVr/KSOiKSKyGhxbuLHRyEY
         AnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762842511; x=1763447311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmSc84hT8MIqkBb125h6Fg0cbHYTnrDRYFuzpYBDlHI=;
        b=xS3VKtBsKmfGC1x7H6N0T9Vbk7JtX4lWdxoSW4cXeoocKYShW/7Mp+qVjQScr6CUaP
         6+wpIQAJTEoa4Ui1L7C2E7yOEcn9iypbNrzMD/Vr0srKjlmZobnnmilHl4tVMc2ai7mt
         /zWe3/FFotyWmF3nWJhYRsIctHYQHkpSjblFDchyMymZwqy0pm42bmBJ4w96K7FuWptl
         0tOE7poJ76j/+paImoPe5Ygslre7feGwj6l271fyQF0MqDcqy3IAQ/pQRG7FC04ASTLu
         gHc8LZOj2HOnmN2n+YUSjqANe1Wj7t4pB3qVqI053/PSYbHxmvpYlHVE5OnM2lAjsOVS
         8fVw==
X-Forwarded-Encrypted: i=1; AJvYcCUW26a6973OUYoYtdJykDY0pvK9DyxDlG1GV1E3IG7avyne/fQls1vkHOR4WjUyX11YdJ+5d1pdTHXFlZuk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9IG7TrkyQaHvVzK7sLU7FldD+z2YB2Ab486qBwDkVYzs9j0k
	nm+jjZNAbBQgY9LNZkoZzN+d+dqYWmyJLUsbT1La5x0J9k0PaBSeG3v9PGLqcU7D4nWUMbepz5r
	LGzvs8w==
X-Google-Smtp-Source: AGHT+IGMml7ghUQoIAeKf967cifI7mzHN8+YTLattppaozkKG2IB6bitZuNO9bVIQ9HY5Gdiy9X8KAFw++Q=
X-Received: from ioge25.prod.google.com ([2002:a6b:f119:0:b0:948:a267:a8a4])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:27cb:b0:948:73c9:c5a0
 with SMTP id ca18e2360f4ac-94895fe55dbmr1315740439f.12.1762842511579; Mon, 10
 Nov 2025 22:28:31 -0800 (PST)
Date: Tue, 11 Nov 2025 06:28:15 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111062815.2546189-1-avagin@google.com>
Subject: [PATCH] fs/namespace: correctly handle errors returned by grab_requested_mnt_ns
From: Andrei Vagin <avagin@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

grab_requested_mnt_ns was changed to return error codes on failure, but
its callers were not updated to check for error pointers, still checking
only for a NULL return value.

This commit updates the callers to use IS_ERR() or IS_ERR_OR_NULL() and
PTR_ERR() to correctly check for and propagate errors.

Fixes: 7b9d14af8777 ("fs: allow mount namespace fd")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/namespace.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..9124465dca55 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -144,8 +144,10 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
 
 static void mnt_ns_release(struct mnt_namespace *ns)
 {
+	if (IS_ERR_OR_NULL(ns))
+		return;
 	/* keep alive for {list,stat}mount() */
-	if (ns && refcount_dec_and_test(&ns->passive)) {
+	if (refcount_dec_and_test(&ns->passive)) {
 		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
@@ -5756,8 +5758,10 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 	if (kreq->mnt_ns_id && kreq->spare)
 		return ERR_PTR(-EINVAL);
 
-	if (kreq->mnt_ns_id)
-		return lookup_mnt_ns(kreq->mnt_ns_id);
+	if (kreq->mnt_ns_id) {
+		mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
+		return mnt_ns ? : ERR_PTR(-ENOENT);
+	}
 
 	if (kreq->spare) {
 		struct ns_common *ns;
@@ -5801,8 +5805,8 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 		return ret;
 
 	ns = grab_requested_mnt_ns(&kreq);
-	if (!ns)
-		return -ENOENT;
+	if (IS_ERR(ns))
+		return PTR_ERR(ns);
 
 	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
@@ -5912,8 +5916,8 @@ static void __free_klistmount_free(const struct klistmount *kls)
 static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *kreq,
 				     size_t nr_mnt_ids)
 {
-
 	u64 last_mnt_id = kreq->param;
+	struct mnt_namespace *ns;
 
 	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
 	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
@@ -5927,9 +5931,10 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
 	if (!kls->kmnt_ids)
 		return -ENOMEM;
 
-	kls->ns = grab_requested_mnt_ns(kreq);
-	if (!kls->ns)
-		return -ENOENT;
+	ns = grab_requested_mnt_ns(kreq);
+	if (IS_ERR(ns))
+		return PTR_ERR(ns);
+	kls->ns = ns;
 
 	kls->mnt_parent_id = kreq->mnt_id;
 	return 0;
-- 
2.51.2.1041.gc1ab5b90ca-goog


