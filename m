Return-Path: <linux-fsdevel+bounces-59992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1412B40745
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389355E4B13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC161314B6C;
	Tue,  2 Sep 2025 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfbi+/Kb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC133148CD
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824119; cv=none; b=Ot9I4pgjvB2beVFoM4d55pDQUy3UMd1Z0etEGQWqzubiqHCsE5zlR2G+7fzmRGYejX14jOkWdEdqfIkcx342mQBb/tPBGMNp75TGU00VTCdVKHZt0GeLu5MpMfocylGW02BFMY+eRtxF/aASBRm9gkGikbG0kiBHNxESxhPhLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824119; c=relaxed/simple;
	bh=pwLQX00L77Aor/eYlMO8X8wTnlF84qtUkCUBVG7sMp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaCE2JY2Jzh2JPIxfSRrqxTghZ7NsQMHq5onXiE70iUavF8k62K987Q4u0k7cp8/5JOAIX4yMw3o1u7NrJrq0CK1Cwc6XzuX9iwxUnGtKkYbgFhkmiyEjn//XZEgl/+QanoI6w/26UtPG5XZzt//0LbQPojUxUR7p/duU0ea2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cfbi+/Kb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756824116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpM5d7Rb+nJlXIsD1X0ZTutNvkJ1dRmdVej9ueGyLvM=;
	b=Cfbi+/KbyeC0e8cmo5b/pEfLxV/GDCOLzZBcA+/tD0DmfCYZ/c0DwleAzT0JZ6P9EQyuEE
	6g4btzQSb4FlaARc9PBDEjU+H08duQRf6ikxvKzJ/GZe4ol8A5N+RC8sNlio8QYAF1VZx+
	GkNtnu2I72wnCrNzEHVTbmnraJpLZV4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-9UM043QRPvW_lCGwgYVLxg-1; Tue, 02 Sep 2025 10:41:53 -0400
X-MC-Unique: 9UM043QRPvW_lCGwgYVLxg-1
X-Mimecast-MFC-AGG-ID: 9UM043QRPvW_lCGwgYVLxg_1756824112
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-61e1636aff1so3291866a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 07:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824112; x=1757428912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpM5d7Rb+nJlXIsD1X0ZTutNvkJ1dRmdVej9ueGyLvM=;
        b=uUcqjTiS3JIpVRDPTmmudoX/chMSNHIL7qJ6LobXuxTDpxSa3HNNcZfE166z7fBpy2
         jvb+x+dp9bQN8cLhgB5TAuzjatFJvA2uVBYaS5RKafyU0eq3B/k0E+YvA0HpWbBEvrFx
         ZdxCBvhUFB8EJYe8Zy/QHiqqDpWoaXjwhyxeUWYPEflIwaoXSz+VJhqhz+0kUuCI1DwY
         sp9hPLV5iIp0F6TmN/QEisXQCxHkBJyGipRd3Sl4GKofbM4HCQfld7Ie8GnJ+xGA9Wx3
         CXJwdCYxjFYsFbtmU7hGanbPo44YpdRS+dwrkok34ejvQjB0yLmvjLD/ic+KHSTWshrE
         euZA==
X-Gm-Message-State: AOJu0Ywg7hvM6YAu2dfA1IH3JSMYXDeY9al6sTb2AgyBb/UdZ4aDVFCc
	lEuVB9oxh9bNSThyQH0STb6CptbvY+BQ80SqZb9WpenWUJstJ4ZBLxrewjcAbqiAeQU/nzvHxVt
	7/tUQ2HJpdI9GfFdMin/wfAvDzlCjpvEDrYUEQ0rR9GNnh+7C+L5IxSMf2rA5g6ZJyJtaoCz7CN
	tcTYK4PnEXm7hP7Tub4Cf0KXfgtbuTkTQoGbn7A6zEltfM8ooiJ5+Eyw==
X-Gm-Gg: ASbGnctMBF6+Ql+hGtF8xxup6XhGt9j8/AzTunW4OCeLMFfmOhmJbmRU5pjnE5Ses0J
	QrRHleothWsCUbuiDvDFDsVw2Ehi3fbikXUsrtZfUgY7NXerAAkxZ0mGaFRW4FHu9BrpWpnSLou
	o8i5Dlj4dxWoZatNIpgcpJyQW8dXGY+zRJ7IxG5IopGoYQo0YbrFkFCSMS+SMCN92C7r0XpywDe
	C59SBgp8MXt8WILKcwH5MzvXfIYI0PB8Rw0IYmWc0KZmFnXQA1PNv8D+azeduAk6ewdkeD8UsNE
	Q2+Is1+3/hkSGYn2IYwc/JQSYa1I9wmA/a/Exapv60Jq7DwKI+OIGojFVI+M90g2oKA04xCUfzP
	r12pomAoegKu9YhEWr4+UlNk=
X-Received: by 2002:a05:6402:278d:b0:61c:8c63:a91e with SMTP id 4fb4d7f45d1cf-61d26d80542mr9812965a12.25.1756824111764;
        Tue, 02 Sep 2025 07:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJEfE4IqFSpQsEWUa2BhIuPOCotu8IEXRnUXs06sfTgZoBOhHCO52JOK+FM0SIL2WGdEy+Jg==
X-Received: by 2002:a05:6402:278d:b0:61c:8c63:a91e with SMTP id 4fb4d7f45d1cf-61d26d80542mr9812938a12.25.1756824111225;
        Tue, 02 Sep 2025 07:41:51 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-155-210.pool.digikabel.hu. [188.142.155.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77f9sm9704514a12.8.2025.09.02.07.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jim Harris <jiharris@nvidia.com>
Subject: [PATCH 3/4] fuse: remove redundant calls to fuse_copy_finish() in fuse_notify()
Date: Tue,  2 Sep 2025 16:41:45 +0200
Message-ID: <20250902144148.716383-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902144148.716383-1-mszeredi@redhat.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove tail calls of fuse_copy_finish(), since it's now done from
fuse_dev_do_write().

No functional change.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c | 79 +++++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 56 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 85d05a5e40e9..1258acee9704 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1622,35 +1622,31 @@ static int fuse_notify_poll(struct fuse_conn *fc, unsigned int size,
 			    struct fuse_copy_state *cs)
 {
 	struct fuse_notify_poll_wakeup_out outarg;
-	int err = -EINVAL;
+	int err;
 
 	if (size != sizeof(outarg))
-		goto err;
+		return -EINVAL;
 
 	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
-		goto err;
+		return err;
 
 	fuse_copy_finish(cs);
 	return fuse_notify_poll_wakeup(fc, &outarg);
-
-err:
-	fuse_copy_finish(cs);
-	return err;
 }
 
 static int fuse_notify_inval_inode(struct fuse_conn *fc, unsigned int size,
 				   struct fuse_copy_state *cs)
 {
 	struct fuse_notify_inval_inode_out outarg;
-	int err = -EINVAL;
+	int err;
 
 	if (size != sizeof(outarg))
-		goto err;
+		return -EINVAL;
 
 	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
-		goto err;
+		return err;
 	fuse_copy_finish(cs);
 
 	down_read(&fc->killsb);
@@ -1658,10 +1654,6 @@ static int fuse_notify_inval_inode(struct fuse_conn *fc, unsigned int size,
 				       outarg.off, outarg.len);
 	up_read(&fc->killsb);
 	return err;
-
-err:
-	fuse_copy_finish(cs);
-	return err;
 }
 
 static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
@@ -1669,29 +1661,26 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 {
 	struct fuse_notify_inval_entry_out outarg;
 	int err;
-	char *buf = NULL;
+	char *buf;
 	struct qstr name;
 
-	err = -EINVAL;
 	if (size < sizeof(outarg))
-		goto err;
+		return -EINVAL;
 
 	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
-		goto err;
+		return err;
 
-	err = -ENAMETOOLONG;
 	if (outarg.namelen > fc->name_max)
-		goto err;
+		return -ENAMETOOLONG;
 
 	err = -EINVAL;
 	if (size != sizeof(outarg) + outarg.namelen + 1)
-		goto err;
+		return -EINVAL;
 
-	err = -ENOMEM;
 	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
 	if (!buf)
-		goto err;
+		return -ENOMEM;
 
 	name.name = buf;
 	name.len = outarg.namelen;
@@ -1704,12 +1693,8 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 	down_read(&fc->killsb);
 	err = fuse_reverse_inval_entry(fc, outarg.parent, 0, &name, outarg.flags);
 	up_read(&fc->killsb);
-	kfree(buf);
-	return err;
-
 err:
 	kfree(buf);
-	fuse_copy_finish(cs);
 	return err;
 }
 
@@ -1718,29 +1703,25 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 {
 	struct fuse_notify_delete_out outarg;
 	int err;
-	char *buf = NULL;
+	char *buf;
 	struct qstr name;
 
-	err = -EINVAL;
 	if (size < sizeof(outarg))
-		goto err;
+		return -EINVAL;
 
 	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
-		goto err;
+		return err;
 
-	err = -ENAMETOOLONG;
 	if (outarg.namelen > fc->name_max)
-		goto err;
+		return -ENAMETOOLONG;
 
-	err = -EINVAL;
 	if (size != sizeof(outarg) + outarg.namelen + 1)
-		goto err;
+		return -EINVAL;
 
-	err = -ENOMEM;
 	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
 	if (!buf)
-		goto err;
+		return -ENOMEM;
 
 	name.name = buf;
 	name.len = outarg.namelen;
@@ -1753,12 +1734,8 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 	down_read(&fc->killsb);
 	err = fuse_reverse_inval_entry(fc, outarg.parent, outarg.child, &name, 0);
 	up_read(&fc->killsb);
-	kfree(buf);
-	return err;
-
 err:
 	kfree(buf);
-	fuse_copy_finish(cs);
 	return err;
 }
 
@@ -1776,17 +1753,15 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	loff_t file_size;
 	loff_t end;
 
-	err = -EINVAL;
 	if (size < sizeof(outarg))
-		goto out_finish;
+		return -EINVAL;
 
 	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
-		goto out_finish;
+		return err;
 
-	err = -EINVAL;
 	if (size - sizeof(outarg) != outarg.size)
-		goto out_finish;
+		return -EINVAL;
 
 	nodeid = outarg.nodeid;
 
@@ -1846,8 +1821,6 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	iput(inode);
 out_up_killsb:
 	up_read(&fc->killsb);
-out_finish:
-	fuse_copy_finish(cs);
 	return err;
 }
 
@@ -1962,13 +1935,12 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 	u64 nodeid;
 	int err;
 
-	err = -EINVAL;
 	if (size != sizeof(outarg))
-		goto copy_finish;
+		return -EINVAL;
 
 	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
-		goto copy_finish;
+		return err;
 
 	fuse_copy_finish(cs);
 
@@ -1984,10 +1956,6 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 	up_read(&fc->killsb);
 
 	return err;
-
-copy_finish:
-	fuse_copy_finish(cs);
-	return err;
 }
 
 /*
@@ -2098,7 +2066,6 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		return fuse_notify_inc_epoch(fc);
 
 	default:
-		fuse_copy_finish(cs);
 		return -EINVAL;
 	}
 }
-- 
2.49.0


