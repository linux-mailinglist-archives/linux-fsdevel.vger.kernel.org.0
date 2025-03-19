Return-Path: <linux-fsdevel+bounces-44387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFAA68134
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D78883523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8B17A2E8;
	Wed, 19 Mar 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LNZH3qR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFE3596B
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343343; cv=none; b=pF7glOieeFYiXVHELwTDMO7pPuay71V0jbtpNrtV5Ud49j5yG1mL9kWbhnMY+VyJrQBEjpkkLrH6GBjD8oI1f6d6xgBmsWHojZTA0jhSLMXsCFsm1uqOEGZzFktJLDWvUcVi34gbrthnvDbcgs4rr73t7DoWt1YnwnmDMQIfDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343343; c=relaxed/simple;
	bh=4XmeV+SwsUckbKoljf1imPQeQxED4NvPOSxU0C/rldo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxKEcTmv4l1Fr9av2Zxaoub///X9xmZ0GX2lXrfELny+vZgxlFs5yKb2A3O7XyeMd1JBxk0in/zy3Bape0n1yCmYuiggEKyNZhWwFoiuVRSckYBU7+IMa91csLRhTw4wPF5KwCq5qcHPV/PneGW+m87T06vmlPJ4bmkRbbowfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LNZH3qR1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22580c9ee0aso108908435ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343341; x=1742948141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js3UD04AvSWxrN9RHcwFb61ujoiYEshPhpsTiZDgHgM=;
        b=LNZH3qR1uWFDzF9bQC0jRqVCxBj0XhnnQKxLQt53RWWbP9Ddo4X5mxjbDYeRlz2b8g
         x92shF+UhIOeahYVFcSmf9FaeuocEomstZDZHCQEL0sYgMlcbxhXxMb5QxYWnWuET5MM
         xadfXaJoHP5VER3ZT3b4hxYUwe7HeFijMPl14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343341; x=1742948141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js3UD04AvSWxrN9RHcwFb61ujoiYEshPhpsTiZDgHgM=;
        b=Dvz50UTEGCFVSAABF3d5C8PTC6J2sbP1hcF8QFBUvu9AsGNRJhhjKRWcueydH7NcI3
         W9b5NIUDjuG8Jz7Pf/LNDuAr5yDJeCTohQkehEpD3YstnXxKvgHZQrvzVGKI5uLkN6JE
         HoZEwuWGu/pmxN000/uXNGKqYD0gIUAAZDV+8RUub5C5Sp23843SegUuXQu1CmnVNUr1
         4SsFw4x3mma6TQfz0hOpA8iIhR4TIJSbKuj9J5T/Tuxh5oYDYYt+lwqdiVeAsu6Lmlhi
         zOg4FkoU6AGQT7uKFKNwBKM0YN0qIATnja7i0T6FFrCK8GOrayfz4VOtEhMGZGLr4FFM
         rwTA==
X-Forwarded-Encrypted: i=1; AJvYcCXzb7zt9L+zAEal8yowue4UsrV3mQcftAYpWIJnJbdAm6YG5oXNahP3L+IvcILnAo7OyPeDOvAB1h0awFtR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pGEb7j6uq9f2HuD7dYX/SzDXmb2OJtTbUGXKvbVoY8xgukSD
	EBjPDywEmEOiQxKlOWJxqF6CluojwsMAQzFy+zsD/zgew7gzipjdK3B27hgoMV4=
X-Gm-Gg: ASbGnctkt2fgPC9DKiXzgv+2gjtwy/0oNHMDroMky7cI9xHC+/mVeOZhHPWepz6XVFZ
	belPcdUhMeHgpge4f83HfnE6QnBGkemTEdNUap8+JtKIMGYtsK0kCXig0aoeVST8PGczhDRbaEV
	MPdo0YTSl8H2VuanBttBaU3fw98xcjdq5o0PLtNx7IMKmVzj65x/yAOIRwLt9hwhVhXPmkOwdPk
	Vje7kmyPhfrzMGgRP4VYZ6Jf2kBZfIxZR4YlFPPqDyoi0gBu6ctRKep3SVlfZ9z82Pz/Ju0G8Yg
	V/YKFI6LP9MxRccXLa4IhaE7IJuooV1hrBV9nSCnv5bayDk2MpWEMzd+G6DbiJ4=
X-Google-Smtp-Source: AGHT+IH7oXUPwBlv8OzKX6l4S7tFotTPIWvWoF6rpoUJjb85+9JTpVERsJIAUNLcb6oCGgVeRTkFdg==
X-Received: by 2002:a17:902:ea07:b0:220:fb23:48df with SMTP id d9443c01a7336-22649caa9ebmr8193745ad.36.1742343341302;
        Tue, 18 Mar 2025 17:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
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
Subject: [RFC -next 03/10] splice: Factor splice_socket into a helper
Date: Wed, 19 Mar 2025 00:15:14 +0000
Message-ID: <20250319001521.53249-4-jdamato@fastly.com>
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

splice_socket becomes a wrapper around splice_socket_generic which takes
a ubuf pointer to prepare for zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9575074a1296..1f27ce6d1c34 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -37,6 +37,8 @@
 #include <linux/socket.h>
 #include <linux/sched/signal.h>
 
+#include <net/sock.h>
+
 #include "internal.h"
 
 /*
@@ -783,21 +785,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 EXPORT_SYMBOL(iter_file_splice_write);
 
 #ifdef CONFIG_NET
-/**
- * splice_to_socket - splice data from a pipe to a socket
- * @pipe:	pipe to splice from
- * @out:	socket to write to
- * @ppos:	position in @out
- * @len:	number of bytes to splice
- * @flags:	splice modifier flags
- *
- * Description:
- *    Will send @len bytes from the pipe to a network socket. No data copying
- *    is involved.
- *
- */
-ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-			 loff_t *ppos, size_t len, unsigned int flags)
+static ssize_t splice_socket_generic(struct pipe_inode_info *pipe,
+				     struct file *out, loff_t *ppos,
+				     size_t len, unsigned int flags,
+				     struct ubuf_info *ubuf_info)
 {
 	struct socket *sock = sock_from_file(out);
 	struct bio_vec bvec[16];
@@ -920,6 +911,25 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 		wakeup_pipe_writers(pipe);
 	return spliced ?: ret;
 }
+
+/**
+ * splice_to_socket - splice data from a pipe to a socket
+ * @pipe:	pipe to splice from
+ * @out:	socket to write to
+ * @ppos:	position in @out
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    Will send @len bytes from the pipe to a network socket. No data copying
+ *    is involved.
+ *
+ */
+ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
+			 loff_t *ppos, size_t len, unsigned int flags)
+{
+	return splice_socket_generic(pipe, out, ppos, len, flags, NULL);
+}
 #endif
 
 static int warn_unsupported(struct file *file, const char *op)
-- 
2.43.0


