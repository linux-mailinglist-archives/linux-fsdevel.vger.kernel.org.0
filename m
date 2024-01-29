Return-Path: <linux-fsdevel+bounces-9424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723284117B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E58F1F250B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB56F06D;
	Mon, 29 Jan 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vkjmQazW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935493F9CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551241; cv=none; b=m7JClWUJig2EaCzVfxBVg6fmAtRUzqgg9iocCSgF7oFkZihlnI55cUxxXoKVSX+YyXkCYqmkEfdK551II3N9tAW4vtQw2R7vW84Sr65zR2WpfaYpMmHphcsGDFaSC2imd+ilKupia7+mrJ3yvNaotijtrVeooYP3MkAHg4GJoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551241; c=relaxed/simple;
	bh=8dnqni1i0A26L48rcT03UdEc1rRuCmcmNOl+uBBBp6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KSBzh21PkZ5aiWFzcZ37iTwn+I7ZlARfkt9oGK3t4yiD0dL84/wwxxcIUVnM1thmdvneTTL7nTnd3T/kbpRYcu1E3Maxsv/KHF891aV1gq5SeA5uGeD57whnhhz4OTKJ0I17sOGhSIGihFy0ZQA2RHeXglN/y8Ol7XB7f1R1LCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vkjmQazW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCD933FD96
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706551234;
	bh=8ZF26zqFi961N4xCf2xSg7p646IkBT56MWEZW1L3RH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=vkjmQazWWUJYggLxKHbM+XdlRtX0ednAjiEoklZTYzFafamXJyWDxaDOe02oAjnQV
	 8+MoGv3k1lWSbl+RlANJxx/LRhXbFgAgNIOsEwMmHGzIQoNxTlCoE8vC2GKmPcOASX
	 79JFKCn4IFyZ4RGMtE+orKlNusdno04NBVWEDUL9ZsGEGnZTzw3AzgYpjgqwM9UJGR
	 uNKg+krc11Q3U3Yj5yqb9oIzDZ6y+smwhgi4oq62Sdf734mcExiyKX6iDsgDM56sww
	 eJbNPC11gONMgLWTxRJqcnlDOtr4tzA8DPhOjbdBN3CJQmY6MYUOfEOafGBuUXQE+c
	 ksg0Qm3vtcRrw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3158fbb375so154929066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 10:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551233; x=1707156033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZF26zqFi961N4xCf2xSg7p646IkBT56MWEZW1L3RH8=;
        b=cyGMdRRF+GFchF6t6aW4RR3iPpeDBez14ovyuopazv2veh0Q7U6tIxA5rClRzydX1a
         LroDxDXlmZa3dZghUnBDl5B0LhBesi6YlqUiyk5KfFFKKO5M2jX2DP85xuwwqg+3kibC
         02o7yBL1ZW5Du7X2js6ubOcgZlYXb840vOEPEbss3rCFhhqXTZLodEF3IgjzFUdzDkDG
         3eUMhb/mzUaB7bAfveQBeBCA/XnaB4HUkfP8tAhCeGKwxUM6bmJG0TxwdUGvf+kO1MHA
         nfq5dCCwxuGjyBQPDbTDb4VnJPedN34xXWwL+mCEZ7+kcb6GZYy1RCAC5Xywg6A1DOAq
         gN3A==
X-Gm-Message-State: AOJu0YztgfzYjtVq0w+9ubWboRalG37Gtt3+W11zYd0C83AIv23FM0JN
	OV7CG8qqCfP+w8nQIMOfeIKk1NQy3Uhq5o8VZlsADZkvCSZFrBOmxLyrFhznlq8QifeJzXCEAgh
	qXGhgGsK6OP7KtmmzzjfC7neMGe5YsYdmIcygPmf3AI/S8hRX3NZ/fHvxhix7xP+okVdyE2wo6g
	GAllFn43XrftU=
X-Received: by 2002:a17:906:560e:b0:a35:3ce3:c48c with SMTP id f14-20020a170906560e00b00a353ce3c48cmr4621179ejq.23.1706551233346;
        Mon, 29 Jan 2024 10:00:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6WK2Tup3/s17NUfjas7PhWpttkvWLK15SZRHVDXcx0AkLhE1oarw2KV1uiJddN93c+MQByw==
X-Received: by 2002:a17:906:560e:b0:a35:3ce3:c48c with SMTP id f14-20020a170906560e00b00a353ce3c48cmr4621173ejq.23.1706551233104;
        Mon, 29 Jan 2024 10:00:33 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a2fb9c0337esm4147500ejc.112.2024.01.29.10.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:32 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ntfs3: use file_mnt_idmap helper
Date: Mon, 29 Jan 2024 19:00:23 +0100
Message-Id: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use file_mnt_idmap() as we do that across the tree.

No functional impact.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: <ntfs3@lists.linux.dev>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ee3093be5170..144aa80cca43 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -419,7 +419,7 @@ static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	 * fnd contains tree's path to insert to.
 	 * If fnd is not NULL then dir is locked.
 	 */
-	inode = ntfs_create_inode(mnt_idmap(file->f_path.mnt), dir, dentry, uni,
+	inode = ntfs_create_inode(file_mnt_idmap(file), dir, dentry, uni,
 				  mode, 0, NULL, 0, fnd);
 	err = IS_ERR(inode) ? PTR_ERR(inode) :
 			      finish_open(file, dentry, ntfs_file_open);
-- 
2.34.1


