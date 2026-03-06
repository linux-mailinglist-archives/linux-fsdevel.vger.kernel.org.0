Return-Path: <linux-fsdevel+bounces-79558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIpyCwkhqmn2LgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:34:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F9219DBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D19B3083392
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F232E2C3254;
	Fri,  6 Mar 2026 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9oVmiFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F32D9EC4
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757204; cv=none; b=XtmxrkD2oGvcOLhBz4oy+Y/4os8RLqfnggDGuJbBhwpZg+1lKL4Hoql3KZ7kacCb/425B02cXoxZQ5LrfKDEHyBHP0+srMuDJxO+8mNbmcL3wUyaX2EPFcBV6sJC0V1J/Qj2ajCu5ZJe3c+JyxdLoFIVHEiYpgCuWXcA1t5B4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757204; c=relaxed/simple;
	bh=YOKLjYb3aosVgKUH+3EKnfo2DuR5P/YMNSMFB5BVVSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww4wYYkGQSV8c3I49CyJs286+gxjNUi3Jxjqj1WJuQk0BFGC81HlS2db4zM2BRUD2PRNwFxCzkPDSvkwfWajWRExOpe/jRtXu7yqn+2l5AuyX9MlwJdy00G3R9RfLQ5kj9DdY2c47e8DMcWDn2azN1sWWMew86w71mKE6rlbYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9oVmiFG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829759ca646so1304470b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757200; x=1773362000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35rUcLF1fMo1V5tT79EtOKmiA1OjiL0xPdfdOliHziY=;
        b=Y9oVmiFGxV0ymT/VSsB/VMim8vuXVh+od0ZzwQS44jZaiJwV/tEuRnoy2rVAPmHzzX
         Jf/274p3dqEOLxtdUARzgL58qSpEQuuFGZRC166EOsRT0mF9m9kc9ZSUqTtWeXexquEE
         84IAuXjmlUVSzK18VNMPKjDqnksaGOJsTjz9n8UjQ2ke/vskk3R2kzNi/qwuDFGxmrcP
         hhMAP8Th3jt/lSFssJ6N8LgTMkHJgA4Z3IKFsayt3f291PzaKqE5xlqTklCaSReF2ToX
         3lztRyWSSn3B80KJ9nDQwkT9dkJs97eK3WkXYGiuiXkrlgE5GigeKR11q/+81OG6yqEj
         aQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757200; x=1773362000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=35rUcLF1fMo1V5tT79EtOKmiA1OjiL0xPdfdOliHziY=;
        b=O7/HsDP7Xs0r/pcPnZysTs5NzfRpbbsa4u58LsjVdBVhYWVkGu55uPkDStkqe3+nWF
         6fO2jtJ6MxLg6kcxWXd3L1ckQhvz1zJb2qHXgwMb25zrh/gf1neNB7C0wjiaeiNEEQ41
         JY6ejiIt8GBAZMubO7uA5iNrjaArHLUq17pGmkZ6WlefY62eLwHLfesSIlxSFA7aBnlJ
         rR9Gya5t2OMQGmNwdu6CBubak6heAR128GrVTOM9Cxju0i6JBJ00VbxaH6VPK2N4/qtI
         jmIPKtK58jRC3jwXrS7pGQMuRQN89u00+o4ewlv3tyS//3nHZ2f3ulCUoBEp0YthJqab
         6SNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmK7IZzbjRkalxtL+pIRS5hw8a3WTIZrQyyLRNFmITV9eXdM6X8nedF05wHwl2hNdiwXnRDNd9BQ1cjMhp@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyT3bVMIOBWwCfJHFOB6CkC7Jd2g7PshesUqWptA7SDWGbtv8
	QXz4n5JtEdZttC0WbO3DmUG5Qhk3rHIONIwkXpu1q7Uxxebg+1cmoRqQ
X-Gm-Gg: ATEYQzzFwuTIDtSIu3k95j6nMN0lKGz/tmv2B00TQYuN4Bk2NhJvBGiosa3F5EhbaL/
	R0UcqhqKaB2/ljW84Z3uqrXuhpUxwAKj8Sjhk2KrMDJoTqxpjCLZYR+ABvmNN48WOlWymB/Alr3
	06yVgeTXbmB7TsG0L1YMVo0U6W34sfkS2bvNn4kGE4mCwbif4L3X6h5q+BppCMjPHuJ2dSUzA+x
	p9I6/Jyhh+NYSNsGaFOSh8GlkHffVuCve4Eg5U95NDt3C6wSJdEPaTetjH3SQzeMMgk6RtGcQct
	AbBYF5nKRJwXIwzVYAyINQbPj6i1Ri623dxprYRz3VQgMKk3OJJiZ1wPJ/RrQ7HTZytjvFy6JuR
	2kh6iNNnkvVbmfQPVJ3UKM+WVLe7D1B1ZQq2SC8ixRKqWOmDrc2HQDs3WFkvnIvBBRH4/mkW4Y4
	Cc02jwfM87TNtQsr6wfQ==
X-Received: by 2002:a05:6300:670e:b0:394:f972:43cc with SMTP id adf61e73a8af0-398590d65d4mr358716637.71.1772757200514;
        Thu, 05 Mar 2026 16:33:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7377062904sm5600331a12.30.2026.03.05.16.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:20 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 8/8] io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
Date: Thu,  5 Mar 2026 16:32:24 -0800
Message-ID: <20260306003224.3620942-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306003224.3620942-1-joannelkoong@gmail.com>
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 859F9219DBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79558-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,bsbernd.com,purestorage.com,suse.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When uring_cmd operations select a buffer, the completion queue entry
should indicate which buffer was selected.

Set IORING_CQE_F_BUFFER on the completed entry and encode the buffer
index if a buffer was selected.

This change is needed in order to relay to userspace which selected
buffer contains the data.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/uring_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index ee7b49f47cb5..6d38df1a812d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -151,6 +151,7 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 		       unsigned issue_flags, bool is_cqe32)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	u32 cflags = 0;
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
@@ -160,7 +161,10 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 	if (ret < 0)
 		req_set_fail(req);
 
-	io_req_set_res(req, ret, 0);
+	if (req->flags & (REQ_F_BUFFER_SELECTED | REQ_F_BUFFER_RING))
+		cflags |= IORING_CQE_F_BUFFER |
+			(req->buf_index << IORING_CQE_BUFFER_SHIFT);
+	io_req_set_res(req, ret, cflags);
 	if (is_cqe32) {
 		if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
 			req->cqe.flags |= IORING_CQE_F_32;
-- 
2.47.3


