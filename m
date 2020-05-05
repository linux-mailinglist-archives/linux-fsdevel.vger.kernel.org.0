Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4611C5254
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgEEJ7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46845 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728677AbgEEJ7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhO62iEx0RtPui3S7bt/c3x2oJ0CRUlaneBlgdbqa+w=;
        b=MfN088Jas97slXBZL11DIxSR06qP1N8x/Zy4pwszXxyybqh4px0tu6222kfa2IVMLRG7zE
        ev7B85aFCUrw23BMmqhoZ0xmbUZNAkvXO8jk03HJ2i0rgZc51rFUO/+OFJS1ZQKFXYDmon
        3YO6A9XMyWkjZSMWXA8+x0fOWBpUVi8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-5pFueuBxP8mbKAquHmPZCg-1; Tue, 05 May 2020 05:59:28 -0400
X-MC-Unique: 5pFueuBxP8mbKAquHmPZCg-1
Received: by mail-wr1-f72.google.com with SMTP id a12so974852wrv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhO62iEx0RtPui3S7bt/c3x2oJ0CRUlaneBlgdbqa+w=;
        b=nOYZakjj48/8/mLOLhL+gdRg8ScALuBDjawRjeoLeSebzJPuscsQC+TiwO9781Ubq+
         qsuzhRmvtGjSBe63DvfrOYeLbjdGrZcE/2Iu80zPpnEjdiukiqggBnxpdJObL4fuNKba
         35mi2WRWRZNCnKIX/3+/ZjkcCjnbsZCH+AnXcASWympLhhjUNHR5XAkltFB2Ag3f6gdx
         F/y6aXDb3RcJoatQN+WS6Y6R17H02kum0fbIc+pVl7uwRlZrrafLHpalSZnbrPIavp/i
         +rDe19AMoxOVPdlsS0pZd41Em9FUCnOgwfM5D3+brrwp0SMY1vqXBMTy5fD/fNzBjHW/
         HZPw==
X-Gm-Message-State: AGi0Pua7CZKKtZJq0z2iSW6YrS0v5R64I8Yvtoy9Ayi9Vr0B0rlSfdKh
        sHutvH+GGW4XX1nwIcoGgl8qoMZ8W0V5QPgOaJf8ZcnUxo0UEMjJpDC6xwZCnr+RZ2bDWBnLirQ
        Qzk3RryFAq4R5JHXykR8c5RqZFA==
X-Received: by 2002:adf:e985:: with SMTP id h5mr2733968wrm.336.1588672767027;
        Tue, 05 May 2020 02:59:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypLrT7sEfnjSimPZVsnMfEeml5xIsz7yiBkGKGB/DF+v8ccxjkqwtTKT+FEh29Jau6GUwe05Wg==
X-Received: by 2002:adf:e985:: with SMTP id h5mr2733954wrm.336.1588672766813;
        Tue, 05 May 2020 02:59:26 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:26 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] statx: add mount ID
Date:   Tue,  5 May 2020 11:59:11 +0200
Message-Id: <20200505095915.11275-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Systemd is hacking around to get it and it's trivial to add to statx, so...

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/stat.c                 | 4 ++++
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index f7f07d1b73cb..3d88c99f7743 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -22,6 +22,7 @@
 #include <asm/unistd.h>
 
 #include "internal.h"
+#include "mount.h"
 
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
@@ -199,6 +200,8 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	stat->mnt_id = real_mount(path.mnt)->mnt_id;
+	stat->result_mask |= STATX_MNT_ID;
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -563,6 +566,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_rdev_minor = MINOR(stat->rdev);
 	tmp.stx_dev_major = MAJOR(stat->dev);
 	tmp.stx_dev_minor = MINOR(stat->dev);
+	tmp.stx_mnt_id = stat->mnt_id;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 528c4baad091..56614af83d4a 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -47,6 +47,7 @@ struct kstat {
 	struct timespec64 ctime;
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
+	u64		mnt_id;
 };
 
 #endif
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index d1192783139a..d81456247f10 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -123,7 +123,10 @@ struct statx {
 	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
 	__u32	stx_dev_minor;
 	/* 0x90 */
-	__u64	__spare2[14];	/* Spare space for future expansion */
+	__u64	stx_mnt_id;
+	__u64	__spare2;
+	/* 0xa0 */
+	__u64	__spare3[12];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -148,6 +151,7 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.21.1

