Return-Path: <linux-fsdevel+bounces-79567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPZZAZ4oqmmQMQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:06:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA47521A1B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EBCA301150A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2A82F12D4;
	Fri,  6 Mar 2026 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrKDBOOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E542FFF88
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759188; cv=none; b=dCnnasKwQDy58oqy7ZJMDmNN7LbCXxSTgZqh2KxGf6vW6HJJDo8y0xWwjr5Wu5+LCtp9ys8QiL5R6GlzPtxaKCRG3dazLMEE4wwhVnj63j5UNMvL0/Nn0Yx4dsho6M5iGwCG5p27QdLzTF7nCah/XmITlPvGdYu1K2IoekombkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759188; c=relaxed/simple;
	bh=/26qojFsndtQKlem3htspkRj0kWjf8m+pXWSdZQ65GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVeIxngfiHDk7iN9t9BRN/h4CWjICYi+lF9AmdbAqhqhEJQr+P1presRnRSYV/JzGMfurmntkCZF2GEONV2rMJQ17eruG3VhIWcMUrTquMp1Us8ZPI1mTKnjjJ4AwxK61ikUYmp8CuL8gR7pICCDh2Tr7qXUXXCVH7TLOzKgCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrKDBOOM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82976220e97so1375831b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 17:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759187; x=1773363987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLdhkHHjxh8yLi/F+wYjePsdSBcqBjiFxoJgEjTidsk=;
        b=NrKDBOOMtOBuaC8Go73AorYOX+hHDOjpsBA6Cx6uV4M3njWqK+zQXxWeUQyMV4II8Y
         aAgZ0zhGE4U/rpjaoKEsys+LVbK6g9I2dp2X6J06JSVy/X+d/ETcsUZ0fVGOdXCpr8DC
         JzM4qTdmETVPTUE1fUxNaxVOy3ncuIZ/iE//QyhuHLfGj7FWVnah+NUBKs7ptWwKa7Vd
         qEAd7Y8SyAZxO+rQWp02YHSjg09lg7cY3zotW2WNj30NgcJneLHdvEpqXjbDCHwULX9i
         7/PaKQ0n+DdqyS+S6gpVx8m4p3f/wSmxrsfIi68u/9hXf0y2G/FypaJilJR70TK3HP0B
         VMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759187; x=1773363987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RLdhkHHjxh8yLi/F+wYjePsdSBcqBjiFxoJgEjTidsk=;
        b=rMRLPBdnJ7n5vcjA6KVn1aBzoa3vsUzC/mmQRHqzWOTDXfWZjH2KReRk/irn6pQ6uo
         SgUqWFIJBRF6vtmK8JpfVmgnwDwLgVK6Mu5DGTL+Cn75Gm0fRzfFeJnhrHZ7UJMDsRIt
         lpftTwwopzrcbxmrLuKBiy6ab3DZdG4MVbUcdvvcF9uD55Za+1I2OgqWM3DmqDve8Qmk
         jPVsNEehxCKkLpVBmFA7NgKCbChtrYHIPEO7JYw8GWEovqAdZtMHxay2qhRnI4nf5jwF
         z9/MGjfeUCZbvgGdRn9WeKRvBmlxR8Pk2KXiEeKKmUhYnoFl7kEBGv9WaJhE/aihYD1h
         XS1g==
X-Gm-Message-State: AOJu0YzIMzxbbj4yWsGHwFZuHJRwphuwC72jpkrcuXYfeTcnJZg39/8r
	X77ayX78sZvpQ6TN2t+WmWq3FV/l5uKsU9IOZfSenx0e1OJiF5Q0WB1NVNtLGA==
X-Gm-Gg: ATEYQzzrpBSY6PeIMLI4kz2hvynCaMZ4+Vfr6y/HhdvYCG+Oj/+eA7tbghWjSBZc6jo
	tJq0/Yk7qhcyRAqjyvsJgVWD3hlwna5KdYKZP9c6KbMS+ASlDmsGZKtBaG6HhJ49KaHdNOR1I/g
	oiVGuSmBOxEqdPDTrCTKvbb6hTrfyGsfX8Veql2XMnJkN0/k+w49IJg26Mvt/MJhhhEmFybeWv7
	+o9nmofsMQFL3j26VGXKMPmp4utw4DD+bir0PynFtauOaXX9M/Zp/AY2kLfM7l2vrCx8ZN48oor
	hnC7w5x9vtiv+TfpZNMF6gTC2xAJ/fvjF2y06/EEQqv+vsXXRsv82fX7eVRUaxB/mm440UekfMy
	GCBPByYOy9RIkQLqXtPjhk/IqGEKrghWtPbPhB77Qy2YPoZhaWrcEe2ikn7LooWsihfgw4JptQN
	ALDKplJvNacvIk9ASJKg==
X-Received: by 2002:a05:6a00:8c2:b0:829:803e:6798 with SMTP id d2e1a72fcca58-829a2fa924amr254042b3a.56.1772759186747;
        Thu, 05 Mar 2026 17:06:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8299d065c53sm776490b3a.8.2026.03.05.17.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:06:26 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 4/4] fuse: clean up interrupt reading
Date: Thu,  5 Mar 2026 17:05:25 -0800
Message-ID: <20260306010525.4105958-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306010525.4105958-1-joannelkoong@gmail.com>
References: <20260306010525.4105958-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA47521A1B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79567-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Clean up interrupt reading logic. Remove passing the pointer to the fuse
request as an arg and make the header initializations more readable.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 585677dfc82c..1402843c9068 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1249,23 +1249,22 @@ static int request_pending(struct fuse_iqueue *fiq)
  * Called with fiq->lock held, releases it
  */
 static int fuse_read_interrupt(struct fuse_iqueue *fiq,
-			       struct fuse_copy_state *cs,
-			       struct fuse_req *req)
+			       struct fuse_copy_state *cs)
 __releases(fiq->lock)
 {
-	struct fuse_in_header ih;
-	struct fuse_interrupt_in arg;
-	unsigned reqsize = sizeof(ih) + sizeof(arg);
+	struct fuse_req *req = list_entry(fiq->interrupts.next, struct fuse_req,
+					  intr_entry);
+	struct fuse_interrupt_in arg = {
+		.unique = req->in.h.unique,
+	};
+	struct fuse_in_header ih = {
+		.opcode = FUSE_INTERRUPT,
+		.unique = (req->in.h.unique | FUSE_INT_REQ_BIT),
+		.len = sizeof(ih) + sizeof(arg),
+	};
 	int err;
 
 	list_del_init(&req->intr_entry);
-	memset(&ih, 0, sizeof(ih));
-	memset(&arg, 0, sizeof(arg));
-	ih.len = reqsize;
-	ih.opcode = FUSE_INTERRUPT;
-	ih.unique = (req->in.h.unique | FUSE_INT_REQ_BIT);
-	arg.unique = req->in.h.unique;
-
 	spin_unlock(&fiq->lock);
 
 	err = fuse_copy_one(cs, &ih, sizeof(ih));
@@ -1273,7 +1272,7 @@ __releases(fiq->lock)
 		err = fuse_copy_one(cs, &arg, sizeof(arg));
 	fuse_copy_finish(cs);
 
-	return err ? err : reqsize;
+	return err ? err : ih.len;
 }
 
 static struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
@@ -1442,11 +1441,8 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		return fc->aborted ? -ECONNABORTED : -ENODEV;
 	}
 
-	if (!list_empty(&fiq->interrupts)) {
-		req = list_entry(fiq->interrupts.next, struct fuse_req,
-				 intr_entry);
-		return fuse_read_interrupt(fiq, cs, req);
-	}
+	if (!list_empty(&fiq->interrupts))
+		return fuse_read_interrupt(fiq, cs);
 
 	if (forget_pending(fiq)) {
 		if (list_empty(&fiq->pending) || fiq->forget_batch-- > 0)
-- 
2.47.3


