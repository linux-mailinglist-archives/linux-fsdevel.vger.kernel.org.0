Return-Path: <linux-fsdevel+bounces-63285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD84EBB3F35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA651C8117
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF8311597;
	Thu,  2 Oct 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evqvnusg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F583112B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409763; cv=none; b=mO1J79Y8Eud/ujFCUsAHbm+b7SgzncS0bEhorVynUpOk3iMFuGcSWWXw4YlZUu2pWgxKXi3s4mUN2+nVHAgQSG7iwf3JnQ3jE6owP3zCb7iBLm8JaRihRKJgvjxMPoZZrBG8hAFwwcAYP3R+YJQpw0ygSDAm+oW8ZNcSSvVwf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409763; c=relaxed/simple;
	bh=9r8D1Ia+7T65S7+gLRLQvq/94isctKWxfIk9igEoCMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ik30sxgMpKO8kv6dCmuts15R1BD3TMPwXfZIYqc2EK6flHYFe4aE1TW4laeMHJGO3ofgkctzDt9iildJeUCwyP+L5p7DYB3DmKIKflBJYFF9tONZ67SxqTb0poAjkbWkrCi1Sp3HV6MmNiP1xsOiYs+Tlye/8LIXnK66/tGiQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evqvnusg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781db5068b8so903003b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409761; x=1760014561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liFJfORZ6KCp7kHXPgYfVbACM9rdKFMKa0FUPuD6JWs=;
        b=EvqvnusgR0nTPCF7ZmAGR8jYDvrQJ0Dw3Z+HXcocKpjadKXpnxiqv3qK5muKphC64e
         vYLcMY9M4hdANeRSUq157QVktE07yegqPg6DYAKFRGqcL7GNHLxFPHPDaIDPFUrD8+cG
         tMgYzKwaZHGPX1G8C3tuYqEBi03m9S5/kLe3kqE2As3WdR25wGWkQxUx4MGmq1naMjI6
         hHYgVKb2OhtUITw3YueFZS7sGP89yWmFfE7pPz+FIREDhOyF+3i1nymUxF/Ed4mq0vab
         Xlq04osm5tbCzbtI8amLEjTgKgDKgMyjhJtfEDJopeJwqqtI65X1hVNbit5+6GZ07vV0
         0srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409761; x=1760014561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liFJfORZ6KCp7kHXPgYfVbACM9rdKFMKa0FUPuD6JWs=;
        b=jmicRcCJVq/tXkCDDdrniVmg+Tk61gqzgrEZLFp1z/+yQT5/WLOXuPDxChJFPWrWTO
         Z/uwAObVcaUKLM/FR6CQBTugVlkkboL/BoEPKm4qhtvEafkaRrW8UOQRBWKgM47c5RP4
         V8g19y3enphWBI5hT0OtbhL+RBtZq5nSqgcw8CJywPHV17vvqGxiQY3JJRt82TIYDius
         b1v3lN5ZVb6axGwhDAS5N/GbwUSWKP/7DcV3xzEzaj8qFGh1es4aKT6WjTdj7USgMe4q
         iQM9paw5NryrSOy/c8eSmNaAn2slrybuOO4YHIk7TRWm8L07XleNjuCichKSNrHbOZyi
         L+BA==
X-Gm-Message-State: AOJu0YxEnKSqN5Pqhn/hqAz1kmMQNXBN8ABFZnLydujN+NcHuRQHou0/
	4YTkBfudIEGtlP7ylNpTjTIOw4GqM9PHHFauJV9OUFM8yCqNp7EZDqTV
X-Gm-Gg: ASbGnctOUg2s9NnozKiDCNsBquqS/XJqP7127GMPzu9xZvYGtQD5seymOFQlZEfMf3z
	IU7foabY97EGcYxJB9N42kbKb7xhVNsCUnYBAXXmUsN2t4dshNw43XSHWMohkgMyDBvrbYJaw0V
	IBf2YTKs8gGfbDqilO2XnhinUFWEiXUqMxXHvXOjDlBvQhChwXWpLG6hArAGIW+6aY7VcAJIikC
	wJ3h7DHdO/jtZIQ4Yb8jYgsSGrBjD5YB02QEk+KKMAeORvaTvTTUXT4l8T0tTZMj3Br+deeU4Av
	iOtV0lUFS6w9z59EQe+1eyopbZ95sNWZHXKA6vyOczhZ1rxQke1G1OC7LMjOInyZ3JHLmlEyV3o
	Lxee3TS1L3CGm54WwPp5avTvOVDkyDAdWEZOb9cSU3Idk/y8=
X-Google-Smtp-Source: AGHT+IFxEVIjGgE2WbwvMRK3nIzpxLLtzOxwcwYUTWec+ETiVhQHUCufkeqn8RIupSVgwQPmrDcW+A==
X-Received: by 2002:a05:6a00:2447:b0:77f:1ef8:8acb with SMTP id d2e1a72fcca58-78af4156ba3mr8365667b3a.13.1759409760877;
        Thu, 02 Oct 2025 05:56:00 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:9e5c:2c74:b73f:890a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a2b9sm2165556b3a.19.2025.10.02.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:56:00 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 4/4] fs/stat: export mnt_ns_id through statx
Date: Thu,  2 Oct 2025 18:18:40 +0530
Message-ID: <20251002125422.203598-5-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125422.203598-1-b.sachdev1904@gmail.com>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, we have no good way to get mount info for the mount a given
file descriptor is on. statx only provides it's mnt_id but we would have to
call statmount with every single mnt_ns_id in order to get mount info
since we have no way of knowing the mount namespace this mnt_id belongs
to.

This patch modifies statx to also export mnt_ns_id, allowing userspace
to easily get mount info for the mount a file descriptor is on by using
a combination of statx + statmount.

```
statx(fd, “”, AT_EMPTY_PATH,
	STATX_MNT_ID_UNIQUE | STATX_MNT_NS_ID, &stat);
struct mnt_id_req req = {
	.mnt_id = stat.stx_mnt_id,
	.mnt_ns_id = stat.stx_mnt_ns_id
};
statmount(&req, &statmount_buf, buf_size, 0);
```

Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 fs/stat.c                       | 15 +++++++++++++--
 include/linux/stat.h            |  1 +
 include/uapi/linux/stat.h       |  4 +++-
 tools/include/uapi/linux/stat.h |  4 +++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index f95c1dc3eaa4..1cc29946c0c3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -296,18 +296,28 @@ static int statx_lookup_flags(int flags)
 static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
+	struct mount *real_mnt;
 	int error = vfs_getattr(path, stat, request_mask, flags);
 	if (error)
 		return error;
 
+	real_mnt = real_mount(path->mnt);
+
 	if (request_mask & STATX_MNT_ID_UNIQUE) {
-		stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
+		stat->mnt_id = real_mnt->mnt_id_unique;
 		stat->result_mask |= STATX_MNT_ID_UNIQUE;
 	} else {
-		stat->mnt_id = real_mount(path->mnt)->mnt_id;
+		stat->mnt_id = real_mnt->mnt_id;
 		stat->result_mask |= STATX_MNT_ID;
 	}
 
+	if (request_mask & STATX_MNT_NS_ID) {
+		if (!real_mnt->mnt_ns)
+			/* returning EINVAL for now */
+			return -EINVAL;
+		stat->mnt_ns_id = real_mnt->mnt_ns->seq;
+	}
+
 	if (path_mounted(path))
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
@@ -745,6 +755,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
 	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
+	tmp.stx_mnt_ns_id = stat->mnt_ns_id;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index e3d00e7bb26d..c62b70ce30d9 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -59,6 +59,7 @@ struct kstat {
 	u32		atomic_write_unit_max;
 	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
+	u64		mnt_ns_id;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1686861aae20..1071f5097d26 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -187,7 +187,8 @@ struct statx {
 	__u32	__spare2[1];
 
 	/* 0xc0 */
-	__u64	__spare3[8];	/* Spare space for future expansion */
+	__u64   stx_mnt_ns_id;
+	__u64	__spare3[7];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
@@ -219,6 +220,7 @@ struct statx {
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_MNT_NS_ID		0x00040000U	/* Want/got stx_mnt_ns_id */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 1686861aae20..1071f5097d26 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -187,7 +187,8 @@ struct statx {
 	__u32	__spare2[1];
 
 	/* 0xc0 */
-	__u64	__spare3[8];	/* Spare space for future expansion */
+	__u64   stx_mnt_ns_id;
+	__u64	__spare3[7];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
@@ -219,6 +220,7 @@ struct statx {
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_MNT_NS_ID		0x00040000U	/* Want/got stx_mnt_ns_id */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.51.0


