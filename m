Return-Path: <linux-fsdevel+bounces-20733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4518D755E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 14:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE510B20AB3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 12:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B93AC1F;
	Sun,  2 Jun 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0q06Qgj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BE1BF3F;
	Sun,  2 Jun 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331852; cv=none; b=gw2f7a5b26cRK2I4dcxsiNdFgmLxCv+ZFr1lPaQN9G51wJmXiVqnfzLT8BWzAEgly7M3IyLrLieqt4vprYIiLWwORUpNeGAlyTcih41smRyzjQnm9ia3ebXYx3a7itauvF610Pjxto/0VWCFHQUQv0r2YPHXr/AL3YcOn0rs6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331852; c=relaxed/simple;
	bh=t3lhITYihlyBuINvTQDldM9iS91lFh6g6ieokskjtOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYsjjN/C3io4aev8Auao43qWEmAldW9kXWmay9z+XYmWGhF9/nO5WaZ8BpA2cnmy+qmCNt/oUI+sZwsmdkoddZv+RqUdMIj+H1ycnPNco9FfDVbzhsxR/blQHP8Ch/OKTgYjw+XJcjTyfj9+iaJzUzAMSBBSKND/+0kzQyLxRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0q06Qgj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6302bdb54aso440553366b.0;
        Sun, 02 Jun 2024 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717331849; x=1717936649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMVpBdm/RCzwpbeUfndCQVwoxC4l89U2dNUnW0vsaEI=;
        b=T0q06Qgj+rwuEfVvNBlS/B0EYcJDFcgV0NKACv2XGRN6slp1HS6unix1++qgCgz79X
         QF0VjKPe9cXIfOfhZCDamGMsk4VcZ1HatCS11nME+42kj6gZGaflWYSAHPegVB5f1Ti1
         K0kdm8hU9GpRGfWj0YUsjir0mYc+GDGWdDvlLbtBKvYBQWH0EknvQXYotAnSsACW4/74
         84NVm/LLHTSyS2MWqGXDsAjzJUNlDnmMXZ5En0o6OK6SbcGUwCM1aAlvHVvQpoXZxqsV
         prbpf196/GWwwSDm0h2bRd9FURKWiX94XEwy792MhqKCNso2Ibsg5msnrI5X0szTIjLr
         XIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717331849; x=1717936649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMVpBdm/RCzwpbeUfndCQVwoxC4l89U2dNUnW0vsaEI=;
        b=Z1tGn1mlojkUA8JQ7Y6MBMEx+POCmRJNC0eOUn1lndLvORQNibSPH3yxXENgv+Ta4U
         ZLxaWnnHEjxL+UcdxJyAVKivmhbhjX855mCRBTDucqCFINNHYWm5PMfIgweaEM9KVx3W
         M9nzosrxmuMJZVup9Ini6oQYi5N2WC3ox1C6lil+uZGec59ZeHziCLJag53ttRyWh3XG
         52IkfW+N2UuKtsBVaPcqIz/HsBVu6039av+Bstq7qBY1xLrdOxSRmBhYhi7BNMeunWJP
         Py+BHq6NJzwao9lXCL2tAUkpdA8Yg2YcyOsc6zAKV5krxhS9KwBVnQaHO+uCFBAheXuR
         bEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+0yDoMHr0WCMHIwlgv9ruHfu0pomyQO/u9JjMMBcizHraQsjvt23/8MyMNUxEgVLhW+OMsxPQIHyTwAwrPprLwCFYUT9BRc5vGHuVmXldtcC4jeVwcT65g8hkrIa6Ix7K1GIBJhBKYvXsFw==
X-Gm-Message-State: AOJu0YyR3ct5pCZdVYHMYcilJhSLMzbk9fuS4/ZbcFbG8M1NFF9zmgho
	T0uV0vKF7s5ZnZswvuBQzRweB2IdpglrS6hnw6mVevNe6fm5SUKA
X-Google-Smtp-Source: AGHT+IFBYda+EUVs1nNvxJdlmbUYexuFTELjIhX7PaURRmveeMK0U2gjH/Qf5Muphj02LlJr078s7A==
X-Received: by 2002:a17:906:fa90:b0:a68:4804:1eab with SMTP id a640c23a62f3a-a6848042247mr383998866b.69.1717331849130;
        Sun, 02 Jun 2024 05:37:29 -0700 (PDT)
Received: from f.. (cst-prg-8-232.cust.vodafone.cz. [46.135.8.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a1dc4e8csm230644466b.225.2024.06.02.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 05:37:28 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: replace WARN(down_read_trylock, ...) abuse with proper asserts
Date: Sun,  2 Jun 2024 14:37:19 +0200
Message-ID: <20240602123720.775702-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note the macro used here works regardless of LOCKDEP.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c      | 2 +-
 fs/quota/dquot.c | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..a0a944fd3a1c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1548,7 +1548,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
 {
 	struct dentry *dentry;
 
-	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
+	rwsem_assert_held_write(&sb->s_umount);
 
 	dentry = sb->s_root;
 	sb->s_root = NULL;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 627eb2f72ef3..a2b256dac36e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2246,9 +2246,7 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 	int cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
 
-	/* s_umount should be held in exclusive mode */
-	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
-		up_read(&sb->s_umount);
+	rwsem_assert_held_write(&sb->s_umount);
 
 	/* Cannot turn off usage accounting without turning off limits, or
 	 * suspend quotas and simultaneously turn quotas off. */
@@ -2510,9 +2508,7 @@ int dquot_resume(struct super_block *sb, int type)
 	int ret = 0, cnt;
 	unsigned int flags;
 
-	/* s_umount should be held in exclusive mode */
-	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
-		up_read(&sb->s_umount);
+	rwsem_assert_held_write(&sb->s_umount);
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (type != -1 && cnt != type)
-- 
2.39.2


