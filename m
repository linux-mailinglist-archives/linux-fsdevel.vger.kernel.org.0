Return-Path: <linux-fsdevel+bounces-19038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2AD8BF840
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BF8283AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B07C446C8;
	Wed,  8 May 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjdvZsSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98024502A;
	Wed,  8 May 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156100; cv=none; b=Uv7ClyXaG4gUROL24F3v2up6ycEl5abOz0SxTvJ33N/jSyXbKoNUybyuRtpZqQFRks5CR3uh/A4AGE8CKoNzKF9DfPuMpsOHUen9zMKyiM7y4O7sGEr5ZKwt3ZjaFIiZners9XT5hpApESuKVJaVK9yzw0t21ggP1GZZwyh7bW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156100; c=relaxed/simple;
	bh=lGZ43BLAjq7zd/fsmMu7JBwCQg2TGtkHhkMNyb0g4dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+t69/fhYUfk0r50OH3lh3kGGmX3MFDaamoBUAOcARFtOPZdqlY9mVNxUOUIBGjXxi4ssY3zkRWS+fwv/GExQLCxRPtXr8JxnQGVB5V5UI9slyMtWFlO2WclU6ornyWL9xcTUiE81PZ684GJ9tJmrOImtKkuOQCoxGqh/Q3Yvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjdvZsSX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4702457ccbso1060847566b.3;
        Wed, 08 May 2024 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715156096; x=1715760896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxjVgqQ8RzjwngaiN/l2Vqbmt62iFzpTBxTJvkY2rMg=;
        b=KjdvZsSXGUMKlIFuyMIXjASgQeNM09Tf4CtigxJbJbOsbyHPR4fdSQUvlAFtS+lXq7
         n5GX2kvuLOTxFzIBdLcaG5JQ1Ryvq/7lzOKPOtLXymoW3qtp9gItyAH3RdfNsllbdd7A
         V6Y+ycCpWJ7sWRsSfMEtkwOVwZLGPNvdHZvdZoEHjMeZybrWzuHDfD5kNjEYTGtGmVKU
         Do1llcdQl3ZaA5r+j7vXMGiTBCh33DP5PtPGyRxQt32dTzkbvX7LJUWL/Hbu2T0SmrMo
         ALfOt+SGbcMlttYY0eIRkD0sbhocOug0p8xm1Nka2frfLQwgHrMOgazv6640M9cAZ8Su
         n1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156096; x=1715760896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxjVgqQ8RzjwngaiN/l2Vqbmt62iFzpTBxTJvkY2rMg=;
        b=h/OYY7LF7ipJS1ZRWRGA4vpWkCuFpkGpTNLQ3hQuuAd4MxPFZGLeMfcjTTN8RcIIqi
         yRBKmqM/N502kevn6S+AiNoI8Fz9e06q7pmWU89C58q9vHpHfgsqYA+WTb67+f/tDj+5
         ZPwW7IWwQDSTOz2O6+UMklSdmlgDwFuZeStA3YkbXFm2MOfXOvrv9vrgjghQ851rAEhG
         iaPPAWii4gmp7a8NMHvzOqt1B/0V26gmRhpyKWcp0eO+FVg2kEDTqGjvzEYeAeDQY6bd
         vZa4o48t2W/00jQSUy3HzhISX5xAGgq3kI0kIfpEP6alJgYdkthExuAH5IDpxBoMC3gX
         pnlA==
X-Forwarded-Encrypted: i=1; AJvYcCVhjd4yRHzbms/sLeDA1Eo7CDUfYo4S4DNE0YmO4BuN1IGZX2mNYovU3CFpwUftKkccNr+SjrDWZ4rAw1o6Efeqp7i7cZKpkv5WHhTH0e18AIe6+euUUjC8nybnNnqDTb8g4gW99KDBI1FuGhpIIeYiGTbgR7TC+RweW2LbKWJX9R8QKkah9MouWPE=
X-Gm-Message-State: AOJu0YzQRlclCx9U/342cq9rGaIxYSmPRhrQ+hN6csASAx6lDmxV01mP
	tS7pjturRqevVWKqyZrXtNJGj/elFY4CEmeAC2ALAAjDJ4gpS1df
X-Google-Smtp-Source: AGHT+IGnFUooBbakpfrg5iOFqgOgrCXPDzfgHvZfxhfFrMhgLRcEHfnWTA5EM1tmh6auEv0eg8pPEA==
X-Received: by 2002:a17:906:ce26:b0:a59:9b75:b84 with SMTP id a640c23a62f3a-a59fb95d551mr116933466b.35.1715156095580;
        Wed, 08 May 2024 01:14:55 -0700 (PDT)
Received: from f.. (cst-prg-20-30.cust.vodafone.cz. [46.135.20.30])
        by smtp.gmail.com with ESMTPSA id mf1-20020a170906cb8100b00a55778c1af7sm7505684ejb.11.2024.05.08.01.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:14:55 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: ebiggers@kernel.org
Cc: tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fscrypt: try to avoid refing parent dentry in fscrypt_file_open
Date: Wed,  8 May 2024 10:14:00 +0200
Message-ID: <20240508081400.422212-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merely checking if the directory is encrypted happens for every open
when using ext4, at the moment refing and unrefing the parent, costing 2
atomics and serializing opens of different files.

The most common case of encryption not being used can be checked for
with RCU instead.

Sample result from open1_processes -t 20 ("Separate file open/close")
from will-it-scale on Sapphire Rapids (ops/s):
before:	12539898
after:	25575494 (+103%)

v2:
- add a comment justifying rcu usage, submitted by Eric Biggers
- whack spurious IS_ENCRYPTED check from the refed case

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/crypto/hooks.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 104771c3d3f6..d8d5049b8fe1 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -30,21 +30,41 @@
 int fscrypt_file_open(struct inode *inode, struct file *filp)
 {
 	int err;
-	struct dentry *dir;
+	struct dentry *dentry, *dentry_parent;
+	struct inode *inode_parent;
 
 	err = fscrypt_require_key(inode);
 	if (err)
 		return err;
 
-	dir = dget_parent(file_dentry(filp));
-	if (IS_ENCRYPTED(d_inode(dir)) &&
-	    !fscrypt_has_permitted_context(d_inode(dir), inode)) {
+	dentry = file_dentry(filp);
+
+	/*
+	 * Getting a reference to the parent dentry is needed for the actual
+	 * encryption policy comparison, but it's expensive on multi-core
+	 * systems.  Since this function runs on unencrypted files too, start
+	 * with a lightweight RCU-mode check for the parent directory being
+	 * unencrypted (in which case it's fine for the child to be either
+	 * unencrypted, or encrypted with any policy).  Only continue on to the
+	 * full policy check if the parent directory is actually encrypted.
+	 */
+	rcu_read_lock();
+	dentry_parent = READ_ONCE(dentry->d_parent);
+	inode_parent = d_inode_rcu(dentry_parent);
+	if (inode_parent != NULL && !IS_ENCRYPTED(inode_parent)) {
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+
+	dentry_parent = dget_parent(dentry);
+	if (!fscrypt_has_permitted_context(d_inode(dentry_parent), inode)) {
 		fscrypt_warn(inode,
 			     "Inconsistent encryption context (parent directory: %lu)",
-			     d_inode(dir)->i_ino);
+			     d_inode(dentry_parent)->i_ino);
 		err = -EPERM;
 	}
-	dput(dir);
+	dput(dentry_parent);
 	return err;
 }
 EXPORT_SYMBOL_GPL(fscrypt_file_open);
-- 
2.39.2


