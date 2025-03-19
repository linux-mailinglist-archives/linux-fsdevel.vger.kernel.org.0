Return-Path: <linux-fsdevel+bounces-44392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B54A6815C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD347884B14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9B1C0DED;
	Wed, 19 Mar 2025 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Fgfu4GvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317F1BE251
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343352; cv=none; b=Kz9wJfM/aL1OkwfRlIK17IXR+b+aBeQhyoLxMcKELQQUiqCtT/dcEuz3PkOzbFwfIOr6aoKvSBU1YICp0XTiW4IeTzbaUltkYX34UDbK0ln8/fYLDE+bqP7disoiJFf9rpK7OJq2kyp9dK9Cf+bHv31Jt9P2nvzju8W3FWnj4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343352; c=relaxed/simple;
	bh=vfmaI48yQu2LzbBRsfUKYj71ya/2pybugWom3+MlAb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moERBfz5N+JGJb26OoqKZXgEkmdqKM6K4fyWV3hYULs3KiT9G7IcmoWb5/rXBWCOUzNPQhBeTZuvqhU0bDqZ6EQbO/s2aSaVkjg8/dB5AmEP4YiQTbvmYRFunyR+eMYOjausdlNfSbdLpowl+uGwfyV15SZy4SbvJ5kbHuq0L0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Fgfu4GvO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22622ddcc35so7154465ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343350; x=1742948150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2h8ahGEK8NaWNEbWiVu/ZrnscNwqcwDayJj5C9lFzM=;
        b=Fgfu4GvOW7stKhQu5e7z9IC/Nv0oQmJEqDAVI/BLiHzM8QdXiSjIqaUlpvskDPWngk
         M4Hhz1GrWXmXi+HYbhJImPSMiUnprJifoEwOxFpvOZAdYtnHrcj830d1SNiEyFw5h2uP
         z0OEH0Ld/35wCgYMxFW3HKiDEMZ3tg9kH47Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343350; x=1742948150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2h8ahGEK8NaWNEbWiVu/ZrnscNwqcwDayJj5C9lFzM=;
        b=OmUKGkg7yatY0PWYRI+aLIpWyQQIjaDnIpkPHG5vgR5adeXJ+wPayQp/LGMdfyhRAR
         BMUEv8tpoubm8zbbb8TfqTMsOiRS69vmpluNQH8vN3oiB+4c5KD3RYjItYFm3WGhE3y9
         h6hY5+MlG0Via8BKe2RmA7vS+K1gsuFyg629tFD1p4Pne+cqC9R1dDwpvKpqPQ7YT7l4
         7DllZ9nMSzEJ76Xp9eGMNdkU3h2MEnIkTdzIBEaThzvGFlZswf3cRdyCNZitj8wKbHpz
         P3dyiWt9gm0MBbVAaVl4r7IKRpSz8RgVma3r6TferVwtA8IeBY7s6XVHoZ4h/OgA4/bE
         a3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa87CDFmZ0RzhAjwaZyKFESI7paqChm66B8AOJQLjY4M9P2ajD/TNaIJRTFgAQJ9YF5gB+Myz5lKnHyyQJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Sdp3O3VPi12LxafOIUffjNbOBBolYfR4OubOLa0CNHxkIvUz
	vVCp06bWRKP3x+w4DI0ZKs/BkQqTtqNPNxIsiZjOs+MbPB0NyvUQG5alvrL3/l4=
X-Gm-Gg: ASbGncu0TKakqSrTNhSZjZAFxUwNbEV/aZMlNWTzerzy2b0mj68dHm89CZ17PfLW5DM
	Y050Q4TKn2ZVzR6/a+LrMBxuzPXPwRK5RrQco4CKwQEIiyRLyvK0+fXOaGTEuWmmMgXiuoeKRkS
	lx0ym6WFR3yPIda2u9OSRmBquwDeHhVBBFlt8U7oL3SKiCvDEd+u97IKbFzuvhq23EljY3LbF4d
	yy3gsm0RsllZjDpypKHyU6Jx6sFRdukNz8bpGvjrP9eujikLpCtQywb5lS2jlx919dvMNIVcWdg
	xatOPdbeedlri4gU09pUn8X6enXG2k62R7i5SFGJsYPTisE9HlOT
X-Google-Smtp-Source: AGHT+IGTEGf1f8q+q48T1ikUY+fDbR7xEVmvuzHJIMrxwMpGrnPzwUvPjVZv+TsZZ6BX0OHQ1CwSDw==
X-Received: by 2002:a17:903:22c4:b0:220:faa2:c911 with SMTP id d9443c01a7336-2264992ff63mr9690915ad.14.1742343349888;
        Tue, 18 Mar 2025 17:15:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:49 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 08/10] fs: Add sendfile flags for sendfile2
Date: Wed, 19 Mar 2025 00:15:19 +0000
Message-ID: <20250319001521.53249-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a default flag (SENDFILE_DEFAULT) and a flag for requesting zerocopy
notifications (SENDFILE_ZC). do_sendfile is updated to pass through the
corresponding splice flag to enable zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c          |  5 +++++
 include/linux/sendfile.h | 10 ++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 include/linux/sendfile.h

diff --git a/fs/read_write.c b/fs/read_write.c
index 057e5f37645d..e3929fd0f605 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
+#include <linux/sendfile.h>
 #include <linux/splice.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
@@ -1360,6 +1361,10 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		retval = rw_verify_area(WRITE, fd_file(out), &out_pos, count);
 		if (retval < 0)
 			return retval;
+
+		if (flags & SENDFILE_ZC)
+			fl |= SPLICE_F_ZC;
+
 		retval = do_splice_direct(fd_file(in), &pos, fd_file(out), &out_pos,
 					  count, fl);
 	} else {
diff --git a/include/linux/sendfile.h b/include/linux/sendfile.h
new file mode 100644
index 000000000000..0bd3c76ea6f2
--- /dev/null
+++ b/include/linux/sendfile.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef SENDFILE_H
+#define SENDFILE_H
+
+#define SENDFILE_DEFAULT (0x1)  /* normal sendfile */
+#define SENDFILE_ZC (0x2)       /* sendfile which generates ZC notifications */
+
+#define SENDFILE_ALL (SENDFILE_DEFAULT|SENDFILE_ZC)
+
+#endif
-- 
2.43.0


