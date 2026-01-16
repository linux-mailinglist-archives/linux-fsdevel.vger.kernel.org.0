Return-Path: <linux-fsdevel+bounces-74259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F082D38A25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896EF305A8E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC33128AA;
	Fri, 16 Jan 2026 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOt0Y56y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE876264A9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606283; cv=none; b=HHCmgC/6VCYDwn36RtrmmNiXP1/F4xGtfa/K7ZUVsUTEIGf2tzDSs2hsFoTvCBMiPQspKI/EMD+y5rniuebM2X736BLexHLK2CewYJRrCo3ggcSTDX0HCrvc0xOzrSzdskgHRaBbN27qOF30IrTymVobNzluhK2e5Rsk/WVzRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606283; c=relaxed/simple;
	bh=TKymJnPfMIR/G0xXXwk3m5+hMmX8AvFkik33yvt0VJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sL2cfJjnMc6C+ljOTZloaiRI2SWPSx4aGPM8X/I+ccF8Tj7SI+t95VzdwK+0bTEigQuSNv+8NYFB+2A1AA1vkJrMen43JYliyImYShyw5v42cSto+nvulb/VHA1209wZ/UEYlPb0q3WiK28j1pSab0Cmidw+M2WZ49TH8gIH5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOt0Y56y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so2149555b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606281; x=1769211081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9e2WVnVPW0ep3D7NpjEyNSzUNgZ0U1FMNXtsOycPaU=;
        b=gOt0Y56yUBw4cw5pGVvgq9Kv4lXiMI/oX4VFcCBkK1z5XY8XAomtPY1aMuqI9PqA7d
         TLmIXapyo5idmK9X6iCAONchau+titsoCsiu84uNvbF2DLLVL3zi3gnvDHfsIGjMvjk5
         ugJ5xHv6pwJP/u1uwt/F+kl00Nb15fq2fLsc2NDLiDwDpZQjn7q/hRFHYcUILV82H5AI
         mQkL9Gw2fgEfpiYJ145F4Osyo5JbZ+CtJ9LxdRjajb3Yai0Itq4dzI/jJF5sx/mYqaKf
         F2CEhJ5v95RAipjf7yZyxixWOpv8SE/PcKlWoTc2CEb9B7UhRqWg6E/21uS7CjDeEQ2L
         jUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606281; x=1769211081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9e2WVnVPW0ep3D7NpjEyNSzUNgZ0U1FMNXtsOycPaU=;
        b=IyEPPE6d+XAQ53bTmaDZG5A7WJ/oR7ZEScBnXcZNzmNrB7NwGAKymt6XcLz7uwl/e3
         pfLA5h42hEmTCPFP0c3Fvf3lApiULLRhfshzdLipoXGhJYM5s6q7DhB/mBk52zk/JY2M
         5QZM16j5l6n/Nt5y3D2rhPBb7R1dIVcHvt5tz8GIqiT5ahgc4n6gplD8r+Dwy+5ZUoBx
         b4ANWqOHNpZ0bjRWCIN17hKUoSi9JqBlijz7M9WjvSFFdBbOpHGKztLJRMKk4DDDuxJv
         EZZblM+39dzkggHpz5Wb9Tc18Fw5hQA4eS4+JAuag80XRnaPyw42RLp3YkgssBcLdRSp
         4K9A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1YvE91LvVS8B92gzaqXB4zYw0IA8EMIBBNgR44d6PTgj95Pncg9Y6nccm7wKSP6ywuiCcQpK8K4MoaUl@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNpIKdcOCmp3udB1vwtJ6Y7K+jTRzaafMzxrAKZBoximzJ74z
	6O4VzlZU1IJm3alJu62iNF7X6e0zxLCW0pyLKakMXjowTaVG1vBAqS0F
X-Gm-Gg: AY/fxX4iZC3CglFltnkt/ZJoiSSdL476npS4RBfsqw66TzGX1/9uxaYJs5ahKmO1OpR
	WSF/0DLXa76CZmm12wMXcbbGzOGv2uU4Y+9ytHKpx8xKTa8esxXXfgHjWd4cyZu/KytlMk3yo+4
	70VSTYnuuEbir1O2HTFC5ryOQHtK1dMe+COsP1mdEmd/ZcbN370YS/Onp9CneePEKJKJ7UskVtw
	woIphCIordNnfoNHhLWnFZA493yGbfAcLDJrsL7ltD8b4R9Wd8LqNAkDSY0nYnTJGi8oOT3MiY7
	5DuRY774My68F9uTUv76GQIve7hotuujR0vYjUus83f1glwIB9V7cUGrTSceUg883ehVmcE3HSM
	YIUQYQOzAkwd/DNIsc/NM9jyPjWnDTB04iqHf5MPCm+f10NiHbyDQvcydltpw7iD1mTIT/AtvbK
	LZp0fyqg==
X-Received: by 2002:a05:6a00:4aca:b0:81e:a228:f0cb with SMTP id d2e1a72fcca58-81fa1821d3dmr4183164b3a.36.1768606281325;
        Fri, 16 Jan 2026 15:31:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10c19dasm2942467b3a.16.2026.01.16.15.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:21 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 10/25] io_uring/kbuf: export io_ring_buffer_select()
Date: Fri, 16 Jan 2026 15:30:29 -0800
Message-ID: <20260116233044.1532965-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export io_ring_buffer_select() so that it may be used by callers who
pass in a pinned bufring without needing to grab the io_uring mutex.

This is a preparatory patch that will be needed by fuse io-uring, which
will need to select a buffer from a kernel-managed bufring while the
uring mutex may already be held by in-progress commits, and may need to
select a buffer in atomic contexts.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h | 25 +++++++++++++++++++++++++
 io_uring/kbuf.c              |  8 +++++---
 2 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/io_uring/buf.h

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
new file mode 100644
index 000000000000..3f7426ced3eb
--- /dev/null
+++ b/include/linux/io_uring/buf.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_IO_URING_BUF_H
+#define _LINUX_IO_URING_BUF_H
+
+#include <linux/io_uring_types.h>
+
+#if defined(CONFIG_IO_URING)
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags);
+#else
+static inline struct io_br_sel io_ring_buffer_select(struct io_kiocb *req,
+						     size_t *len,
+						     struct io_buffer_list *bl,
+						     unsigned int issue_flags)
+{
+	struct io_br_sel sel = {
+		.val = -EOPNOTSUPP,
+	};
+
+	return sel;
+}
+#endif /* CONFIG_IO_URING */
+
+#endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index d86199ac3377..d2a660ecc7ac 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -9,6 +9,7 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/io_uring/buf.h>
 #include <linux/io_uring/cmd.h>
 
 #include <uapi/linux/io_uring.h>
@@ -226,9 +227,9 @@ static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
 	return false;
 }
 
-static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
-					      struct io_buffer_list *bl,
-					      unsigned int issue_flags)
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags)
 {
 	struct io_uring_buf_ring *br = bl->buf_ring;
 	__u16 tail, head = bl->head;
@@ -261,6 +262,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	}
 	return sel;
 }
+EXPORT_SYMBOL_GPL(io_ring_buffer_select);
 
 struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 				  unsigned buf_group, unsigned int issue_flags)
-- 
2.47.3


