Return-Path: <linux-fsdevel+bounces-32596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C00D9AB5AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3743428246D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32821C2441;
	Tue, 22 Oct 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJV104Kz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572513B58A;
	Tue, 22 Oct 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620102; cv=none; b=WNjqxdk1/Ga7MEfxJBYr3v65ExP42rVJe/YJsA4r/qhJ1smjhl8svIOfnu4Iw5NhJx6oI49FYTHLSya2d5Or8gyle2nUS3z87k6+ICys/wBoNFcmdjoOUSTB8sFr1+vUBw5L9QTzR32Rrq1zESRsM7s/N6Qwv4KOCwsHUP8sF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620102; c=relaxed/simple;
	bh=tyHsvaiiX1gOmmyq9/0nzpwSlEYIaTQXrkD8mzX0mLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=US1DNM6ZJJiRQ/LzyA51wPDBjjtCPwVVAcdlg0RRzUqsqoRl6vp4I3dYIUHupS6QsCCr3EmlBQpGWHLNOyoaHzQ493plV6atcw0k8pyMLV4w2iv7G95Qw71Q+gCKpXnHweAil7PneCrQfdiEkFvlvQu87jwg+4+wsX+jvhcNmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJV104Kz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe76e802so6830992e87.1;
        Tue, 22 Oct 2024 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729620099; x=1730224899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuf72DWWMpZGasVdhPaddkSBAdQr8zMJ93ItMRBFORs=;
        b=fJV104KzjSHy9+W2BSxGsnCNr65m0DrgH7ti6KR+D2bdkKUVk5LobHBGZOKoPDMRNL
         cS67as7Pp4cGUvVmp/A22u6zr5vgD4kRu9ZcqQY+gSrwPGwdjpK1NhzNzEto4pMtwvFW
         3f4HclQ7/YxTuhr/yIYUtVrnU2ys+4YUfflSz4aw5h5KSumV/3FpRVLqrfS2c/h4bqwa
         pUMFRuapiZdcF8sux7xg8pDzMm3Wi/87od7vYFNDPX8MSafXDM7YX9pVJ+Oas0NrCIS+
         D6qR0QMr0ZDs8nHdowfWG8+CGLRft37w58Tt93YC3ZBn94X64+vwGt4UsJO9TxBRMdRq
         AuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620099; x=1730224899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuf72DWWMpZGasVdhPaddkSBAdQr8zMJ93ItMRBFORs=;
        b=mIwpAcS6+cpokTrQustADrkJF/fxBOh31dz5Y2yRXckzgilh3iBgS6s1aQvibkQYSw
         EYKB0yDniiki5oCDfWYQASNE+u8t1DjDUapKvKWRmjK7KzuFNz03Xahi0mpa+1iANsXO
         t/zk30kN3Sqc5/Ai7PAE7LeWNog3RQANs+CnRRDimDu8v/ArSpQ1vb+i+PqlFMPVi2P3
         O6pKVdWnRw10D6MFAWAMjw7wKnJxfdnyXFATyqtII06DvhatTvyHvLoOO/2Toz2giDGY
         +z1Gil8QriYScNJnY7ZoTXqMJeZktrl27nFQdA5lb2xxil9W9FQBeFYmdlq+Ipdyt9x0
         lV4g==
X-Forwarded-Encrypted: i=1; AJvYcCUiQww73tHJPywjmjulJT/fRW3weUWUcDgtTkXVDl//1ZW7o1bdYFBY6vkXtGxHELRTerKlvVdEvD7xj2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKZ5VyQ/J4CP72R3ahnYexyElivTYYZZ0Aka3a0aSv7N1wwnx
	QMcSuRVSK+AiI0S7Rs+XXzDNBD1/3B6DGCKsOu+u9FAMG5UfuQpJ9ItEEcl99rw=
X-Google-Smtp-Source: AGHT+IFIZ858NH+vPbozF3bg2tGl8fwekzp1tdWuXvZ9cQ/T6Tn27daJ12ikD3u5oB8Xk2zP3HLIgw==
X-Received: by 2002:a05:6512:23a8:b0:52e:9b2f:c313 with SMTP id 2adb3069b0e04-53b19206811mr242987e87.22.1729620098280;
        Tue, 22 Oct 2024 11:01:38 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:850c:5867:abe5:b8c9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b18csm3355638a12.62.2024.10.22.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:01:37 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: brauner@kernel.org,
	josef@toxicpanda.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Gianfranco Trad <gianf.trad@gmail.com>,
	syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com
Subject: [PATCH] hfs: zero-allocate ptr and handle null root tree to mitigate KMSAN bug
Date: Tue, 22 Oct 2024 19:56:25 +0200
Message-ID: <20241022175624.1561349-2-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports a KMSAN uninit-value bug in __hfs_cache_extent [1].

Crash report is as such:

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121

Which comes from ptr not being zero-initialized before assigning it
to fd->search_key. Hence, use kzalloc in hfs_find_init().

However, this is not enough as by re-running reproducer the following
crash report is produced:

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
 __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
[...]
Local variable fd.i created at:
hfs_ext_read_extent fs/hfs/extent.c:193 [inline]
hfs_get_block+0x295/0xf50 fs/hfs/extent.c:366
__block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121

This condition is triggered by a non-handled escape path in
bdinf.c:__hfs_brec_find() which do not initialize the remaining fields in fd:

hfs_ext_read_extent -> __hfs_ext_read_extent() -> hfs_brec_find().

In hfs_brec_find():  !ndix branch -> -ENOENT returned 
without initializing the remaining fd fields in the 
subsequent __hfs_brec_find() helper call.

Once returning to __hfs_ext_read_extent() ensure that this escape path is
handled to mitigate use of uninit fd fields causing the KMSAN bug.

Reproducer does not trigger KMSAN bug anymore [2], but rather a 
kernel BUG at fs/hfs/inode.c:444:

default:
			BUG();
			return -EIO;

which seems unrelated to the initial KMSAN bug reported, rather to
subsequent write operations tried by the reproducer with other faulty options,
immediately raising macro BUG() instead of just returning -EIO.

[1] https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
[2] https://syzkaller.appspot.com/x/report.txt?x=12922640580000

Reported-by: syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---

 fs/hfs/bfind.c  | 2 +-
 fs/hfs/extent.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..69f93200366d 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 4a0ce131e233..14fd0a7bca14 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -160,6 +160,8 @@ static inline int __hfs_ext_read_extent(struct hfs_find_data *fd, struct hfs_ext
 	if (fd->key->ext.FNum != fd->search_key->ext.FNum ||
 	    fd->key->ext.FkType != fd->search_key->ext.FkType)
 		return -ENOENT;
+	if (!fd->tree->root && res == -ENOENT)
+		return -ENOENT;
 	if (fd->entrylength != sizeof(hfs_extent_rec))
 		return -EIO;
 	hfs_bnode_read(fd->bnode, extent, fd->entryoffset, sizeof(hfs_extent_rec));
-- 
2.43.0


