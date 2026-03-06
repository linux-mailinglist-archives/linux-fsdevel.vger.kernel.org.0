Return-Path: <linux-fsdevel+bounces-79557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCcII/8gqmn2LgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:34:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A96219DAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A79D3066BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C42D3A7B;
	Fri,  6 Mar 2026 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWH6MH3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78972D876A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757202; cv=none; b=ufMEE+uVuuonZLSQl7ougkmJaFWAYPwjN86vELn6XECdTQwYYFg3yvfQOYa2viWXlb7oNnk/+uU3qiiyYjpQGF07MKqbNrev0kiytkMzhlWepKDs6DZlTtZF52eWYPNnx7lX4HdZC1XjFKn87xPnIgaIdz7YCncLMsD6SQz7rM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757202; c=relaxed/simple;
	bh=Heyu2Q5T5X4A9SKANnsUv6UKZixsvFR59P1h1KCTty8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyQInIu4Knmv4gycuanZAvLPwX5AkjWV3qbF398fdl1uvKetA0nd+MOJrixShu4u69dcZnl/wjTDphmqtvXUgI/ep8x70J6Iib5UZ2RgJNvpTuuLvMmRb1RYSN3+p1q3dS8URY5hrkHTWD2ADhiEhQBBCw1+Xrx/cKLgpud9I80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWH6MH3n; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82989744ee0so1213949b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757199; x=1773361999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y26k+fkCoNaSBSZdLvS8sV0ZMa7T8y/2My/KGsSy7Zo=;
        b=mWH6MH3nzjPy7W8MZ7l4PSa3fbjSnRiPHXLKoP+x7pYyj6b+nmVAipZyUddJL9RoLN
         x4SpdVf7pMvw6YXxziv6IULSltE0XphjKexvkWaFoudZwUtSUcWMGMhqn679PxPGGW0N
         6pSC5SS9D/bOqJH+c4ABzahi+MrbSLfih5gU6Du8c4b0OX2iQl6wkK1KNp+W/9fou/bw
         +hNp8X57xn7AW9BRGNqhOgZRSG11i3lfHLocbLu4Cakcg/lAlppHOncPtIuAFdJN4ms3
         EhSfqK89MYjFD/SKwslq6/j2LoYhLHveR3Fvyq0lKy2jisgyZP1ZiMtol8YVQS62lAvy
         +bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757199; x=1773361999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y26k+fkCoNaSBSZdLvS8sV0ZMa7T8y/2My/KGsSy7Zo=;
        b=gNPe4oDmkEY1XH8C1mZ2O6CVxbE1oBeQlxw2Y42ioiRa0QnKdbtft6r5lMJL2J0qjS
         yqFHn2R1E0He6tTjbnc9q3tlHJXsbClAX1++Mga4wkAx4xAhtW3dF6iOW1Kfgfq8IuLT
         il3KtCjzme1S39fRTpCVQt9AQqbiBzfFhtPThAfPdvm2NFMsBp+AJyjPMAheG1OUwUar
         ICkTraJzPTqxt+8p4ym/cZ3OEh2OgmagYUtJhMV6myrrcLmE8cF3f79a5Lbv3xDtLdhE
         0eT8YU40mTXsJQ628/rcrX4cJQx7eExaVy2x4T6lUvOkgGO/eb/KZ/Zpd6vLDNdoIrTQ
         xx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsL9nsvickffwDrWjLqTpoO99M3nm4S2G/UvaFZSEOnzbYOfMGqKBuO1ctwSZD6jzynbWzficcHGNS4RFn@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZ/ZJLmXgABmn1I4nxN/+A8ykGKGZzzPtqGfu84c8bak+wZjP
	yFry19ChTw8GKfPDy+eXs9D+Bu1EiBt+9aqrjZ7tZuzn0ofO71EpJ4a5
X-Gm-Gg: ATEYQzyworLiWeDOPP9lY++9WjarizzcdB6QnMrnblnYzPnGVp3Px6HdzjKJxVQKf8L
	17MjUKyjtPcRfQ5LMNJOU6IF7v+e2TeWqH7xx49VAsbiQBiomSuadkIt2jqFOzP3tSLDkbv8oce
	3vyw5jIpDe0xH/j9nogEyKFwMmzCC+pKDO19dNUJ4PwfDHh8ylyAXAwhtjOrgJ96JUQMc36/8Ys
	GWgJ59BaxJIQzbwHHKlzYgC+CT4IEayPPgkhoVMmFDqK9khKsxyX8j+iWfu9P2Gb92K2aJJredF
	wkaARZshzOdcFRjM03EjTfa5fLKq1dedi+VRDlG/2lSKLDD/zy2fZKsb4RHCi1cZpHttyjHoJhv
	4bFgi/4KQqvW5k5dx2Wlwjxsu3Fh9XjiYGgHVw0hX2IR4oNtHZkMPDouZV7LJcPqY6DWOvZOUnP
	1M98if6Nn5l8dwVB4OuA==
X-Received: by 2002:a05:6a00:c95:b0:823:edd:20b9 with SMTP id d2e1a72fcca58-829a2fa9676mr175202b3a.61.1772757198859;
        Thu, 05 Mar 2026 16:33:18 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8296c9f83f3sm6015571b3a.0.2026.03.05.16.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:18 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 7/8] io_uring/kbuf: export io_ring_buffer_select()
Date: Thu,  5 Mar 2026 16:32:23 -0800
Message-ID: <20260306003224.3620942-8-joannelkoong@gmail.com>
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
X-Rspamd-Queue-Id: 31A96219DAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79557-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Export io_ring_buffer_select() so that it may be used by callers who
pass in a pinned bufring without needing to grab the io_uring mutex.

This is a preparatory patch that will be needed by fuse io-uring, which
will need to select a buffer from a kernel-managed bufring while the
uring mutex may already be held by in-progress commits, and may need to
select a buffer in atomic contexts.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/kbuf.c              |  7 ++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index b258671099ec..89e1a80d9f5f 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -102,6 +102,10 @@ int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
 
 bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd, unsigned int buf_group,
 			    unsigned int issue_flags);
+
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -170,6 +174,16 @@ static inline bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd,
 {
 	return false;
 }
+static inline struct io_br_sel io_ring_buffer_select(struct io_kiocb *req,
+						     size_t *len,
+						     struct io_buffer_list *bl,
+						     unsigned int issue_flags)
+{
+	struct io_br_sel sel = {
+		.val = -EOPNOTSUPP,
+	};
+	return sel;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index ef9be071ae4e..6b5f033ad8bb 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -230,9 +230,9 @@ static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
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
@@ -266,6 +266,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	}
 	return sel;
 }
+EXPORT_SYMBOL_GPL(io_ring_buffer_select);
 
 struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 				  unsigned buf_group, unsigned int issue_flags)
-- 
2.47.3


