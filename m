Return-Path: <linux-fsdevel+bounces-4664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D7A801669
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EB2281D14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D0619C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xlYeo6ze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22924D6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:52 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3758fdd2eso23686637b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468771; x=1702073571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G65+p44mGmrcw3g1ylziU5NRee9dMbEGAa4uRdfp8o0=;
        b=xlYeo6zeg6wvHGuyfMi6+kUoUr36OpIiUzbo6jF4dRRUb612Z0GBkiFqCtsLQ9EsLU
         iSlkXZw9+AkieZ4VIcLIemcf+VIQJWo1plVAJ/U5zQJ4SYliLFe+FGqgGmq6W2O/2onf
         KUdMXBTls6kgKsixpPIuGSSF5TwuiksnlyL9tfRIcyh+5AXEho1wwW6cEyoHKT48LeKj
         kwpdx7fqLnKRA6txVhxcHNYNa2iRNMEgF8awX/ZkXsfg0E42EExcaAUwkMZKqoMM9hFm
         oUlgFpOqsIsdZxl9nrZw4ffAnjNMp6blLZu+kX/Ud2yoo3A4jk5OnasBiAgLet8W66ER
         //tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468771; x=1702073571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G65+p44mGmrcw3g1ylziU5NRee9dMbEGAa4uRdfp8o0=;
        b=wUiSxsezSVtVCv2hf0S9VoWzaqPFtHZsW6JZN3WlmZ4S4PqJi5Bzj+xClkKNyf0NFA
         XtVwqsxa1spXGMdWKbqpNT3bq+Iz4drI89OtS1pTDVeaF4gFCnNtyGR0+ycMrZ98z7IM
         p3Vvf0e5uiJjl+/KOONfWLD27J2U/1UY8dBtB0OkHyylkNJg1DtPorThTWusaJb00xwY
         DngocHFyifmG5eMp5o+5WWQBMzb+jhYETMejrh0qeV+yz35gohJaB8k8uAryU93lgrCC
         Tud8xvVsb6+9ZxhN0V88vAz30oGTF0R7xc73C6P27551y1NQPZ8hExWDKVBYU965+5NJ
         ygQg==
X-Gm-Message-State: AOJu0YydiVIn62VyuMMeDoRlYB3a0VggjaC5lOodydSUPsjtf89AUO3O
	CGyUJdapmx32RGH6meGVMmFZ8g==
X-Google-Smtp-Source: AGHT+IGMXu8ydshCa8rJ4v/ERWlHQ7MaV6TkNFrUdf8axRijnNw6x9bzA6o3POz87QqdoN+lC3Ssrw==
X-Received: by 2002:a05:690c:3381:b0:5d7:1941:356d with SMTP id fl1-20020a05690c338100b005d71941356dmr196783ywb.84.1701468771338;
        Fri, 01 Dec 2023 14:12:51 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r20-20020a0de814000000b005d39c874019sm1143201ywe.66.2023.12.01.14.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 44/46] btrfs: deal with encrypted symlinks in send
Date: Fri,  1 Dec 2023 17:11:41 -0500
Message-ID: <4ef9ff7d8238e0ed0995ae4ed65e8de276ebcbd3.1701468306.git.josef@toxicpanda.com>
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

Send needs to send the decrypted value of the symlinks, handle the case
where the inode is encrypted and decrypt the symlink name into a buffer
and copy this buffer into our fs_path struct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3b929f0e8f04..ee5ea16423bb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1732,9 +1732,8 @@ static int find_extent_clone(struct send_ctx *sctx,
 	return ret;
 }
 
-static int read_symlink(struct btrfs_root *root,
-			u64 ino,
-			struct fs_path *dest)
+static int read_symlink_unencrypted(struct btrfs_root *root, u64 ino,
+				    struct fs_path *dest)
 {
 	int ret;
 	struct btrfs_path *path;
@@ -1800,6 +1799,48 @@ static int read_symlink(struct btrfs_root *root,
 	return ret;
 }
 
+static int read_symlink_encrypted(struct btrfs_root *root, u64 ino,
+				  struct fs_path *dest)
+{
+	DEFINE_DELAYED_CALL(done);
+	const char *buf;
+	struct page *page;
+	struct inode *inode;
+	int ret = 0;
+
+	inode = btrfs_iget(root->fs_info->sb, ino, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	page = read_mapping_page(inode->i_mapping, 0, NULL);
+	if (IS_ERR(page)) {
+		ret = PTR_ERR(page);
+		goto out;
+	}
+
+	buf = fscrypt_get_symlink(inode, page_address(page),
+				  BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info),
+				  &done);
+	if (IS_ERR(buf))
+		goto out_page;
+	ret = fs_path_add(dest, buf, strlen(buf));
+out_page:
+	put_page(page);
+	do_delayed_call(&done);
+out:
+	iput(inode);
+	return ret;
+}
+
+
+static int read_symlink(struct btrfs_root *root, u64 ino,
+			struct fs_path *dest)
+{
+	if (btrfs_fs_incompat(root->fs_info, ENCRYPT))
+		return read_symlink_encrypted(root, ino, dest);
+	return read_symlink_unencrypted(root, ino, dest);
+}
+
 /*
  * Helper function to generate a file name that is unique in the root of
  * send_root and parent_root. This is used to generate names for orphan inodes.
-- 
2.41.0


