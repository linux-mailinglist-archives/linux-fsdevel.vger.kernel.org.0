Return-Path: <linux-fsdevel+bounces-42187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD63A3E5AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 21:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CE53ABB5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD661E379B;
	Thu, 20 Feb 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4qD1C9j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A401D5160
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082657; cv=none; b=HOq5qzwzvuHOgWhSA2uP/oom8B8T5aCK2r/DvDiYTH/x2nRzDVewyLJzTXdaAZyyk+p0xaiXtE6/07myOVosRPW/fwO+kzA//iBShKvPgiZCgIlTckcVu9tXyy5JrrtHq3jp2r2Kvura4q7kh4bHTEJR4AOjSfn2NCLzGqiZzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082657; c=relaxed/simple;
	bh=0VThpZALlyMjQDgdWjCtYKn8Juo1jeyiTaO4O09F9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqHA0Wvc9p6S4v2osKEcYOs1WQszMLeqbTB+qtkd9Euse4iXQRbYCgwvQVplhjsSohLwHfv9/W0lktLWWXmZIjmgVARFMhcGAdm/Nrn0G1kkdzfz1u23rcg7r9L6Zm9aZAVFQP42wEmoW0qpz9efY8qQl35BwidZT05ybI0ptU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4qD1C9j; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fb9dae0125so12305167b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 12:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740082654; x=1740687454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo7sN+xI/3GYbU3UTKvSuMTSo5phaC4qclblHdxzC8U=;
        b=g4qD1C9jBuUXbRPQpuLBAvCE/osggC0Diq/atIFgnFVzKDHYIZAG5YtVxJRGBHrauW
         JFhwAWcaayggJ/z45UXPW7z4ePC5VHbc2Lspv+q8HbOUM03h3wuroz3jdpp/hpVCviDm
         JO1FRdvRHkbdXRjGJVieYPDJE6WIMUt0HfV/GmybO2mKYDybC6b4SEYxsG5RVE0UbLLU
         CYHnj9egHk2yzpejUgJuWWbpJ3VtLHpVlpAYqU1kBX/LjuKbsPAPVlrp+xyCrB6BbSH+
         sbe6qoLWO3yr4tpOImNuFST4b1E1u5okF0TNj4rBd61QvKZg30M8KFwoB7qjq2SmdDWo
         qNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082654; x=1740687454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yo7sN+xI/3GYbU3UTKvSuMTSo5phaC4qclblHdxzC8U=;
        b=J+ntNO6z/gea+YqsM5xjt6p7r/QigkiwYH/xAQ8RF8QnxDso6CWxg7bBG5yKFVF9mD
         REWdJhqQQ1f0PPdtwuVQwhqudw8i2SEJR9QtPdGhsjQmW1EFECh6jyP7r5BAo7v97tCO
         1PCP7cuyJi4Pd6zthafS0Wj6W297T4LkDE9HvzkwZxjhojVjjzFBr+TGrbIzRaIvs2dn
         JC1EamSpbiMJiiSeQXchSEHkh/tjO5Vn20Kd6xzcrBpXE2+yy59BEalK/+Rf0yGqwuKM
         WZv+jmmvoeTdJ9cHkcU4T6EJlE/VEwIO5FUXlVX2ceh93nkUuqyI8h7ak/I+MVwpdfmm
         YfPQ==
X-Gm-Message-State: AOJu0Yxs3+1CAVSenKJMkGn0IJ2NyIi9M7rPSIbknbbu+P8zqpEwEXrY
	yG3JeKe5/KXONiMYl1RdQNznoynXeUHdIRR0p6yyQS7jMLoBRkZaygd/jg==
X-Gm-Gg: ASbGnctwApGnUm6Xoy3Wuo02DH6ahvdJ3zoSxT69fHOFpZ4QjsuobrZdHovfP8ApJvN
	JnZmbaHHHuJkS90QV1adAK5bkZQ8fp2MVm5AWUpZp9lgD3LSDSKTV3sbBPSypP/juo751LCzERv
	DQ9TfQVsi0QfDPHjJAepKcHUl0LzbgqCMyQnCMx+bizCi6K47EbYwd86+P1Cmd8yxiC8kRN2PkO
	LUnzU+VbQwB+HmCgbRnk6VbJX7TCzbTOm0ooix/bXBjrU+jqaJF2V8KXRoP5kEFv0TlQ3DabKvV
	Iag3N1QgtJ/RBmTLmMhhjA==
X-Google-Smtp-Source: AGHT+IFsRjCJkL/VRg4dGiYPaXYhoJdd2MK7DpaNjAb7GrmOewxZ/WCSHnWsXqSZM/SK1X/GcZDmeA==
X-Received: by 2002:a05:690c:688f:b0:6f9:aecf:ab34 with SMTP id 00721157ae682-6fbcc3a4e78mr3851847b3.38.1740082654285;
        Thu, 20 Feb 2025 12:17:34 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35d58bbasm38034777b3.16.2025.02.20.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:17:34 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/2] fuse: Convert 'write' to a bit-field in struct fuse_copy_state
Date: Thu, 20 Feb 2025 12:16:58 -0800
Message-ID: <20250220201659.4058460-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a bitfield for 'write' in struct fuse_copy_state.
No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_dev_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3b2bfe1248d3..6005919f1020 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -20,7 +20,6 @@ struct fuse_iqueue;
 struct fuse_forget_link;
 
 struct fuse_copy_state {
-	int write;
 	struct fuse_req *req;
 	struct iov_iter *iter;
 	struct pipe_buffer *pipebufs;
@@ -30,6 +29,7 @@ struct fuse_copy_state {
 	struct page *pg;
 	unsigned int len;
 	unsigned int offset;
+	unsigned int write:1;
 	unsigned int move_pages:1;
 	unsigned int is_uring:1;
 	struct {
-- 
2.43.5


