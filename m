Return-Path: <linux-fsdevel+bounces-4622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53C880167D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A016D28113F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF453F8C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tWUm+ixJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3110D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:02 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d3ffa1ea24so14608657b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468722; x=1702073522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9dqjoMSn+7T+gtB15gD5H7naTL8GFoazbK/o6+nI2Y=;
        b=tWUm+ixJzR31GeEU6o3MB6vjOMV5yqYTM5BwV2mExjnjC5LufAugRG31qEFuYh6sWB
         nP6X2m1/LWKcpN3mPoen8dZRYSBjMPdmEhBUQ9NK6p5o7PGogvbjx0dseO7ikkpteoh+
         h6vcqeC21ZaAsmvdd7gzDLmwAJOevGlac7kDazpQm/roemyOWsoIZTuv/04BtN469ePW
         cFp4yx0hlTLm1Uk57Cb9yCnFvAZ6vnNZp2CxZ5T+Y80eHqO29Yuz6CTsU8aY7m2mmtOX
         +a6t4ZaJFnuIKm9bGQZ3Vf4XxzzK/pXz+f3LncEG+CInoAsToeR7lbRgSOZwSIaul34o
         wiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468722; x=1702073522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9dqjoMSn+7T+gtB15gD5H7naTL8GFoazbK/o6+nI2Y=;
        b=L5cSD9EircExohha2wAtL9hdCcndUIDhdrC/eGvlk2jDdVKWC649h5kv6HLnY6ymrh
         QXzqbSuWx071OJOp9vmFgJVOwIENQYpQoRbBfe8CKMkR6FZi2fh7QZ84f6MJYxdtkcav
         rzW+2oPWDnoqrpkktHIGA9U5mMi0nWTr73ZsTJKg49CWbRCWSlhA3QYbJ5efzPN6SRgZ
         fn3PNU0kUoVxV8E+nOWarCiEENm+mGnE4+qo2pM6MqI0bJt3F0A5SZ3/auIZK221O5j3
         5W9zDb12MVIOJGiKS2nEmGX5Xa2YMVPRnbPK2hqJWxJ8c98Rq1tpNGmDJ4xISr4renSt
         9cPw==
X-Gm-Message-State: AOJu0YyzgUfU6NZzCguCll7c5ro7M1ZwMDrZOYs6ClQQ/1Xe2cGOwz/4
	ZnMS+zkTbYnf2nlZw4lSoN41VA==
X-Google-Smtp-Source: AGHT+IGIFd5zXUDquyZwsbeCwiMuEZ5On3tjMOHUai6QDKOsufIrQo2vGp86UI1c5VSB+ddOD4hfIg==
X-Received: by 2002:a81:ac56:0:b0:5d3:464d:18d9 with SMTP id z22-20020a81ac56000000b005d3464d18d9mr243622ywj.21.1701468722170;
        Fri, 01 Dec 2023 14:12:02 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x191-20020a0dd5c8000000b005ca99793930sm1027998ywd.20.2023.12.01.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:01 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 04/46] fscrypt: conditionally don't wipe mk secret until the last active user is done
Date: Fri,  1 Dec 2023 17:11:01 -0500
Message-ID: <e91b4068225dd17d5fe88320fab27b494aebb3d0.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously we were wiping the master key secret when we do
FS_IOC_REMOVE_ENCRYPTION_KEY, and then using the fact that it was
cleared as the mechanism from keeping new users from being setup.  This
works with inode based encryption, as the per-inode key is derived at
setup time, so the secret disappearing doesn't affect any currently open
files from being able to continue working.

However for extent based encryption we do our key derivation at page
writeout and readpage time, which means we need the master key secret to
be available while we still have our file open.

Since the master key lifetime is controlled by a flag, move the clearing
of the secret to the mk_active_users cleanup stage if we have extent
based encryption enabled on this super block.  This counter represents
the actively open files that still exist on the file system, and thus
should still be able to operate normally.  Once the last user is closed
we can clear the secret.  Until then no new users are allowed, and this
allows currently open files to continue to operate until they're closed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/keyring.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index f34a9b0b9e92..acf5e7b3196d 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -105,6 +105,14 @@ void fscrypt_put_master_key_activeref(struct super_block *sb,
 	WARN_ON_ONCE(mk->mk_present);
 	WARN_ON_ONCE(!list_empty(&mk->mk_decrypted_inodes));
 
+	/* We can't wipe the master key secret until the last activeref is
+	 * dropped on the master key with per-extent encryption since the key
+	 * derivation continues to happen as long as there are active refs.
+	 * Wipe it here now that we're done using it.
+	 */
+	if (sb->s_cop->has_per_extent_encryption)
+		wipe_master_key_secret(&mk->mk_secret);
+
 	for (i = 0; i <= FSCRYPT_MODE_MAX; i++) {
 		fscrypt_destroy_prepared_key(
 				sb, &mk->mk_direct_keys[i]);
@@ -129,7 +137,15 @@ static void fscrypt_initiate_key_removal(struct super_block *sb,
 					 struct fscrypt_master_key *mk)
 {
 	WRITE_ONCE(mk->mk_present, false);
-	wipe_master_key_secret(&mk->mk_secret);
+
+	/*
+	 * Per-extent encryption requires the master key to stick around until
+	 * writeout has completed as we derive the per-extent keys at writeout
+	 * time.  Once the activeref drops to 0 we'll wipe the master secret
+	 * key.
+	 */
+	if (!sb->s_cop->has_per_extent_encryption)
+		wipe_master_key_secret(&mk->mk_secret);
 	fscrypt_put_master_key_activeref(sb, mk);
 }
 
-- 
2.41.0


