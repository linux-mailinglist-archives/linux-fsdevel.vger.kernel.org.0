Return-Path: <linux-fsdevel+bounces-76776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM24N9Z8imk4LAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:33:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E41115A65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E3673041787
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F81C8603;
	Tue, 10 Feb 2026 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFeEKRsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC3201004
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683512; cv=none; b=JnkaVc+hDv0MW5w5orV6tSLsCKJyFKDI4NydTs/e+d4m7L4gJE/YtIYFucEO1sRmCp/2gb+D0ulylGkStJVVyi9bD62bTXs2mk17fqRZyivmoD7SrgTfhsMnkAYCPWXSiWwlHq4fQpt/1meNDsLgwadDrMLTnQ6FBrShfwlL3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683512; c=relaxed/simple;
	bh=eq06KuJFJFg69zeD/OZr8KWHPmlXtPm8rHzCi6xxkcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUoJvp+a3Fp8aqkpSNCP+eorH+MWBg7u7TWvtoCZDe8QYPZBYtno+7dMd3J+BJnN5neeIDkYlMQaG9Oy7dry0tet5ai/9Q+DM+2Gdko57eziv8ISb9V2v0GUBoTaoMM5U+0WUoGNiXbC2kAoLSFvb0/L+nwF3Th/dR8Kdgb9AI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFeEKRsl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaecf9c325so9947945ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683510; x=1771288310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T4xdTB3u+Aop4OPvF2fi6twPxYT6ywCdILb0AkVKoE=;
        b=mFeEKRslLT8QX7YzjJl3zwsjMdBABdJeIei5hrr1SWo89xDLV8x0MsVuthvmYNaYm3
         eP2EnPbhqk23VSIrTT7Bw+VBCHOQ3LXymWci9UrqWFKPuyRDLDaSkwx31hkNB9ZXMb6T
         t7ugJyFqTNsw2DypsVwScYC05+Wb8Ti3QtsjiSI81lw1+AWRh9YVCjT27INr8ajvH5pE
         DS4JRN5xrJIQUA2gWuLpcLRAtXou9Bv4+ClnZIOVQVXAWA6Sfkjg1Fe6+eflYYiMTRRL
         HcAZ3sAli8azH6pX0zgSulRVMHRmdusH7e6237/Xntj55HgCfC7A3nn6P2J84hAhjrEw
         5Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683510; x=1771288310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/T4xdTB3u+Aop4OPvF2fi6twPxYT6ywCdILb0AkVKoE=;
        b=HWA55R7ye9CYVAjhi78rSfDq9CGl9m88SxI9vHXN4NC3nx42WBtKEyJiiyofslYh/v
         aRX9bhhUm3AMOPS74qUEwGAA51+Jd843TP5il8vmcv0cjWg352U/yvkC2tKKW530phBz
         sbOSbNY+Q1NO+Ldzp91ESqMzr69X/cZLcG1As2UdUGjCTs3jQAECqecZKOvvXCBBqTCS
         vSZAaDtu6ddf75iq+d2yOVHQ9UoveUF5bcQ/NxCiFR7QkQHfEz+tazQ9QU1SpkptFan6
         K6LLghVHduTVEcGIpD6MrnljcZXam7wPtrgUBxPOHZ1yLe0qpb2vgJBIwLnDgMSk6+wK
         2NTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrgZzU0iZE9aQKjESMsNPu+NVaEKJ2G/IGjxzsW3SZqzSaAkAvpjT1iK7gyBzvtIQtp7lbFSl4gUf27BBa@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHdtOsisFSWdzBE8vS93TaYkl+aOUDVcE1548XgT3j7fhK4AH
	65NTvahAmOAKDXATkNNK0Es2YCP60Y61NTZhMZ4s6xCJeQSJe+hQMM3B
X-Gm-Gg: AZuq6aJD3V5FJxbLZMnCFcgwnJ5GtRr0oQNqMNVmKf9GWzcKAkE7VzTy/cyCUG/8zxu
	CAOuUBU1MedLpI2xL7XSgWQdawYqioT23sdjhk97gSALTe5yhbPNOjS0OQ4x//TZ6UxeAAeOj9D
	JKvq4Wdvw91Oh7l1EeMdwO5L7pY3S45rXrvl35gkw+EWshqrKThV6OqwVYZ0//JeyMDFMqB/inx
	PrD2NFDqUkfCzwAp2NaCBgUTOBeQS6yKB7B6BJKtKB5H9sxdnQ7TV8B7MqoNOfz3xnPZIDUHVQp
	aztCYru4qZf6MFYiERjkQ4ROz9yA/3M4SK0TXFQDj/XLsplrE4sRwEbuvOhBL4eV2TFYUlL03+f
	Zs7iwR3PDlw6jnlSBkzhZDTa3HhqqElovghwBVzh+QzUZq64zc4a+i+9LVkJwLmz4VlPngj7Ojx
	232xKqdaGtsxVvK8eNlg==
X-Received: by 2002:a17:902:f606:b0:2aa:f43d:7c4c with SMTP id d9443c01a7336-2ab1007c0f3mr5040065ad.9.1770683510318;
        Mon, 09 Feb 2026 16:31:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff:23::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab0b392cb5sm7659925ad.70.2026.02.09.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:31:50 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	io-uring@vger.kernel.org
Cc: csander@purestorage.com,
	krisman@suse.de,
	bernd@bsbernd.com,
	hch@infradead.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 07/11] io_uring/kbuf: add recycling for kernel managed buffer rings
Date: Mon,  9 Feb 2026 16:28:48 -0800
Message-ID: <20260210002852.1394504-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210002852.1394504-1-joannelkoong@gmail.com>
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76776-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68E41115A65
X-Rspamd-Action: no action

Add an interface for buffers to be recycled back into a kernel-managed
buffer ring.

This is a preparatory patch for fuse over io-uring.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 11 +++++++++
 io_uring/kbuf.c              | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 702b1903e6ee..a488e945f883 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -88,6 +88,10 @@ int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group,
 			  unsigned issue_flags, struct io_buffer_list **bl);
 int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
 			    unsigned issue_flags);
+
+int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
+			   u64 addr, unsigned int len, unsigned int bid,
+			   unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -143,6 +147,13 @@ static inline int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd,
+					 unsigned int buf_group, u64 addr,
+					 unsigned int len, unsigned int bid,
+					 unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index dee1764ed19f..17b6178be4ce 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -102,6 +102,50 @@ void io_kbuf_drop_legacy(struct io_kiocb *req)
 	req->kbuf = NULL;
 }
 
+int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
+			   u64 addr, unsigned int len, unsigned int bid,
+			   unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_uring_buf_ring *br;
+	struct io_uring_buf *buf;
+	struct io_buffer_list *bl;
+	int ret = -EINVAL;
+
+	if (WARN_ON_ONCE(req->flags & REQ_F_BUFFERS_COMMIT))
+		return ret;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+
+	if (!bl || WARN_ON_ONCE(!(bl->flags & IOBL_BUF_RING)) ||
+	    WARN_ON_ONCE(!(bl->flags & IOBL_KERNEL_MANAGED)))
+		goto done;
+
+	br = bl->buf_ring;
+
+	if (WARN_ON_ONCE((br->tail - bl->head) >= bl->nr_entries))
+		goto done;
+
+	buf = &br->bufs[(br->tail) & bl->mask];
+
+	buf->addr = addr;
+	buf->len = len;
+	buf->bid = bid;
+
+	req->flags &= ~REQ_F_BUFFER_RING;
+
+	br->tail++;
+	ret = 0;
+
+done:
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_kmbuf_recycle);
+
 bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-- 
2.47.3


