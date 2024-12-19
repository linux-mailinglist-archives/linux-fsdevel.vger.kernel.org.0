Return-Path: <linux-fsdevel+bounces-37788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2329F7ABD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF3A7A1C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B330223C6F;
	Thu, 19 Dec 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsHkoOpn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A6223338;
	Thu, 19 Dec 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609190; cv=none; b=TqjvEwkisU50A6zbbbxFGMzLj8bkaCOjqi+d0Ro0QGbHrC2dfh2nJhOJla/4zohZ14nMWbxTRTRfRO7D1Sp7+USenZJIkUsb1z0cpathHzIsWDloZKQnDJR9HpGJMJYlQpCGGYoRfbggp1VH41Dvp2rAuX5BJpwIL/Ot8hGbUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609190; c=relaxed/simple;
	bh=nmH3qKxbHENsWJ2pSUwVnZXaBzkAwZF7ABWbwrcfYmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H1vgflGHfrJ9q50EOJsV/4Y2sFgDkjy4HjQPvk6lya1Fne4ev0Bq67llk39oM1etXVT+tShgLS6eGxzjIyFeBrJtGDNMqteSxIL4cE8ikS6csK8gTUdrbp9ftrqFIHi4FDNBCw40RerPO0oZrVJKiAFWRqDugUJTqpe2o26F4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsHkoOpn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362f61757fso6767025e9.2;
        Thu, 19 Dec 2024 03:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734609187; x=1735213987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44b6EHAiBFp6Uge0mHxDfmjYj7QiuuhtCt1tUX4mbC0=;
        b=RsHkoOpnW6MWu7DMQCu8/VNnwsfwspLtY/qeNhKQlLlBLrX91sCUGgCiNwa5kAr0bV
         uW1SAiskwkNtVsqagoObnXubj5mTVOWLng++z5cDeI2dhFtiv86nBu6LIeljB49L5XqE
         6bCkCoNPGxLFEM4m7hczRclWe/1OSgdKMTQ6YAQsAK0dsn0re2eZ9tTB3ki6GZBoymU6
         5RbYikB2FUSH5DkM1JWTd2jGpuvbcsCBHXfbG36RXvK+mcI8ji5clgmWzIiHmBt3gUCt
         SrkLL7xPLOkUXCS6T9aLAwk0YggGKwDHueoCaZx9DfvX2oaBPBaApiZE5tE0DZetc7Q8
         HvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734609187; x=1735213987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44b6EHAiBFp6Uge0mHxDfmjYj7QiuuhtCt1tUX4mbC0=;
        b=VPqcK/uI58dWCKcYdFvcenpqyHhX6qtVH6Chd3UOtepwIdc2i1raILdLBMQUtnj95z
         X6XER+5+uZJSSqlxD5lhSOurDI24qfV42QOsajk3skUXCJBiSiE0KOi9c4FwU9wLnlmu
         f8YDpNg5gMqHSPqlNNQfcxx58nxEkQ8q8lINyJXztl0MaVYFV0UD3IyLJpeahdp8oSsZ
         WX/g2fM0aiCOee3bPpll6khKRMLB7SqcCt5I01293eHJcBAg6W5zu+zPA6bSVVhezfgK
         nWRuJkBxAjLEmI0pXYXNKfumWFWLYMu6zljKHQ8S8l7F+Z/xXoBHJ+soy+eOOm2rtS55
         455g==
X-Forwarded-Encrypted: i=1; AJvYcCU19ib/Bh/c6JMv+3MVfJ5mcFD4HffdnSi49aNyGjuWe/+DscuChzQBsjDYNGQq5Pjakda3TdTuXDs1+klL@vger.kernel.org, AJvYcCVFt474R/Y7FzOfQeImD6YUiI1ml/84dNDgOFS1Hl2l7PzS28r6SurmBEwHx3h24tDTLg0dnQpf@vger.kernel.org, AJvYcCXTzQMFdy9ggOSHSV8w3m6Zik/yU/IdENbJ6W1kgbop0HNq60gqKzmXmCJYjO7HaKghy+kjucL3RAlCVMhA8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFRMkh3wjJW/C8I1CKkACRkP322YOrIFF7ROhHjYwOKzjO1PD
	smEtvdnIQG7SnH+xvlXrL2Q+/N1dMhYNiyP+9i3+ojw5q9ng9U/1iNS9ZQHY
X-Gm-Gg: ASbGnctBe+pHZzbgd/hUDDsaDqXEPaIo62COGhX0VzyDg/LFZRgLdPHbYGh83B5Ntu+
	i1cWBSRjKbQNIQxDnIBxwZlObAQ8IvtM2jcbrVvVgIfdpNLOMtWrdNvKsC6CDK7kAtc3sg9+TLO
	MyEJ3JLP5CBP3WKKI76AueciZk5cW+fFg/AIvbQ1akBw5CQ1+WE+npOdbKa52Wgb21vHtdPQeJn
	bEBKx+IzOFiqaoGshldci+COwe8RvQqQJp0Oapl7Slz+ucdibTBmXxmB9lHcapMyZvHHiS3ocHc
	tREgJ1QAjfzuGM3sMfQ/5II+4zYUaY/pAIhT1wvegwHsbgGw3ig2Xw==
X-Google-Smtp-Source: AGHT+IEv4XFW+0E88FlMGVxRFcce1Bznj2PpGYJTpRzOiXGTruJLGXbBtndDvJh6+Gz0tul9cy3BBA==
X-Received: by 2002:a05:600c:5122:b0:434:fe62:28c1 with SMTP id 5b1f17b1804b1-43655368694mr58243035e9.18.1734609186733;
        Thu, 19 Dec 2024 03:53:06 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b295sm51534095e9.33.2024.12.19.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:53:06 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Edward Adam Davis <eadavis@qq.com>,
	Dmitry Safonov <dima@arista.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] fs: relax assertions on failure to encode file handles
Date: Thu, 19 Dec 2024 12:53:01 +0100
Message-Id: <20241219115301.465396-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Encoding file handles is usually performed by a filesystem >encode_fh()
method that may fail for various reasons.

The legacy users of exportfs_encode_fh(), namely, nfsd and
name_to_handle_at(2) syscall are ready to cope with the possibility
of failure to encode a file handle.

There are a few other users of exportfs_encode_{fh,fid}() that
currently have a WARN_ON() assertion when ->encode_fh() fails.
Relax those assertions because they are wrong.

The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
encoding non-decodable file handles") in v6.6 as the regressing commit,
but this is not accurate.

The aforementioned commit only increases the chances of the assertion
and allows triggering the assertion with the reproducer using overlayfs,
inotify and drop_caches.

Triggering this assertion was always possible with other filesystems and
other reasons of ->encode_fh() failures and more particularly, it was
also possible with the exact same reproducer using overlayfs that is
mounted with options index=on,nfs_export=on also on kernels < v6.6.
Therefore, I am not listing the aforementioned commit as a Fixes commit.

Backport hint: this patch will have a trivial conflict applying to
v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.

Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
Reported-by: Dmitry Safonov <dima@arista.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

I could have sumbitted two independant patches to relax the assertion
in fsnotify and overlayfs via fsnotify and overlayfs trees, but the
nature of the problem is the same and in both cases, the problem became
worse with the introduction of non-decodable file handles support,
so decided to fix them together and ask you to take the fix via the
vfs tree.

Please let you if you think it should be done differently.

Thanks,
Amir.

 fs/notify/fdinfo.c     | 4 +---
 fs/overlayfs/copy_up.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index dec553034027e..e933f9c65d904 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -47,10 +47,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	size = f->handle_bytes >> 2;
 
 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
-	if ((ret == FILEID_INVALID) || (ret < 0)) {
-		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
+	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
-	}
 
 	f->handle_type = ret;
 	f->handle_bytes = size * sizeof(u32);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 3601ddfeddc2e..56eee9f23ea9a 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -442,9 +442,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	buflen = (dwords << 2);
 
 	err = -EIO;
-	if (WARN_ON(fh_type < 0) ||
-	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
-	    WARN_ON(fh_type == FILEID_INVALID))
+	if (fh_type < 0 || fh_type == FILEID_INVALID ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ))
 		goto out_err;
 
 	fh->fb.version = OVL_FH_VERSION;
-- 
2.34.1


