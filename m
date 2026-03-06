Return-Path: <linux-fsdevel+bounces-79564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FShF8YoqmmQMQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:07:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C621A1C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42FF93044A76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F362FD1D0;
	Fri,  6 Mar 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH0OlCPV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B82DB790
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759185; cv=none; b=ECg3dCxUoF0JvwKH7GcdYc0UVF9u29mt88nvglNQuKxb/q3p+55fdLr19a1Ojwe4WjMG18WcrNS8jf4WmZo870cWVMgTRWorvOsomq0IgzE+pe/zFp8oipVNlUcWSGI3RHty4IcrFUWVf/cArOBdBwDRdAtFfV8cecZHllyUm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759185; c=relaxed/simple;
	bh=HA5RXCWbyp+QxNcVAj8v5bWScei5KuuzmqXm4gs2vlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv9IzwkkMbaeCwD8HQz/EnrSPWyRYyVNlGHm7BNOy/mOAiQ630vDkVTqFLjdZ+V4F6DaGHIGvRazWYONGaFXXVo9hS8csfbJp8gwzOFgi07OZVvV5WzvVAoC0VCMz/fmngcL8W6NVeV/ypLbQQO/6Odj4Ctk/Tds9ST2QOW3HZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH0OlCPV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab46931cf1so61883285ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 17:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759183; x=1773363983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYdnKfR1ZJ+f6Et0ztTjg4z0YLTtQbz2wSiSSXPEZNc=;
        b=dH0OlCPVacSbfBCb/psaaby3k0aD7UYaqB1H2iOdEXImi490x27yeYzf2f2pqKNabW
         ZNlRU8LgGqYLDXa6a2kS8uYHux+TpVt6IyiGLwykut+Hm6viI7PMmG1H3JPxms5scVk6
         cUNBS6CaKyQSAjpmiBA3CaRRBsUCKdLWvQgPDSNLASxczFPJGPuaUaOg3jePUU99quIb
         9d+M7EWTFC+Ci9OENwZQEkXoR6H4jHdZAaR2sw108apcL7uj7RxYO/diiok544cXklPj
         N8yHnByISj9wdRIcboVFsXt/0Mm05vt4HyurCUrtgmnmYj3o0L4TgEVLWZdco7BNGqI1
         rFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759183; x=1773363983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYdnKfR1ZJ+f6Et0ztTjg4z0YLTtQbz2wSiSSXPEZNc=;
        b=DG2B1HBB23sZEXCukBP69PvhPMs0k3+0t+fy6ZnJgX3Hm2TsE8UjF8hvcZ8XOqS0Ti
         p0mijt4nC/fZmlMzJTpniiw/RyvLAgapQBCxMsJbgjIlAayCoh7DexNG3osUJ4yb4ojN
         I0iCqA10nxZXgblTbtIJ/H+pUYOGbWduvbxMY59+9uBL0wIrP76Y/ynzsj0dnR15KOmp
         5Ga1RZeZTyYnZwE66MFJ9uDRZRMQ0x8xND1AvWnxeQ/feQbF6TQp5RHPtdjqiZgxH+8P
         ZlFmerVLfFozsssQO/dySiAioySYo3Ws14TErZwh5+i1vztL91N8A+PpN9yHn+gG503a
         TwTg==
X-Gm-Message-State: AOJu0YykEuMqqwzl8mXhdmwi/Ljvpy6CrkWT/B4+5YX64cV0fxDW30sI
	GRZkEUjuf51nGOF1HDeIV3h98KFc0U+QK+nCblsegaBs41+OQyVdz54LTn6LNQ==
X-Gm-Gg: ATEYQzwuVJhyUBNYt+StiDDFZkxIMtWeA0cH3UHwxaWaSgBPKG+EQyGC+vjJdy/xG7a
	/mw+k6i4+1SpAlfSnGMiMATjJIkYE678KW47OpYXMS+ho8EqviQBRxiOoK0S3u39QQ/St7jYbkJ
	smGVM0yKj868stLQYzJfwlwZOxd+T2yYbyfwlePy1u+c4C7Lx6caAT8nHSOSQ2IlFHgENi4OSRq
	ltA9pXN0y9hc2osVaiHhAhIiP9ncPiRv30dmT1KviiOHX3I2DQQ+Gj8asWnxU1aJhpYsD7LUYHK
	pQc/kc8008bf0sAOzGTum/zHEioDRon3FBrAL4NWNVdN6MWXpadNyH+y5aG6oyKgnQG8VChuJZ9
	ptMoNS7+vFORL5trhwJ1Tvduessq3YL3wJTl1wabJxrCCbeocO9ZOeM24pdchTRnIe1nLYN7vj+
	G5/m+6ncF7gc6cugIE
X-Received: by 2002:a17:902:ce91:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2ae759b822emr42304505ad.0.1772759181883;
        Thu, 05 Mar 2026 17:06:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm240556745ad.45.2026.03.05.17.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:06:21 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/4] fuse: remove redundant buffer size checks for interrupt and forget requests
Date: Thu,  5 Mar 2026 17:05:22 -0800
Message-ID: <20260306010525.4105958-2-joannelkoong@gmail.com>
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
X-Rspamd-Queue-Id: 013C621A1C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-79564-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In fuse_dev_do_read(), there is already logic that ensures the buffer is
a minimum of at least FUSE_MIN_READ_BUFFER (8k) bytes.

This makes the buffer size checks for interrupt and forget requests
redundant as sizeof(struct fuse_in_header) + sizeof(struct
fuse_interrupt_in) and sizeof(struct fuse_in_header) + sizeof(struct
fuse_forget_in) are both less than FUSE_MIN_READ_BUFFER.

We can get rid of these checks altogether.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2c16b94357d5..e57ede7351b9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1250,7 +1250,7 @@ static int request_pending(struct fuse_iqueue *fiq)
  */
 static int fuse_read_interrupt(struct fuse_iqueue *fiq,
 			       struct fuse_copy_state *cs,
-			       size_t nbytes, struct fuse_req *req)
+			       struct fuse_req *req)
 __releases(fiq->lock)
 {
 	struct fuse_in_header ih;
@@ -1267,8 +1267,6 @@ __releases(fiq->lock)
 	arg.unique = req->in.h.unique;
 
 	spin_unlock(&fiq->lock);
-	if (nbytes < reqsize)
-		return -EINVAL;
 
 	err = fuse_copy_one(cs, &ih, sizeof(ih));
 	if (!err)
@@ -1301,8 +1299,7 @@ static struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
 }
 
 static int fuse_read_single_forget(struct fuse_iqueue *fiq,
-				   struct fuse_copy_state *cs,
-				   size_t nbytes)
+				   struct fuse_copy_state *cs)
 __releases(fiq->lock)
 {
 	int err;
@@ -1319,8 +1316,6 @@ __releases(fiq->lock)
 
 	spin_unlock(&fiq->lock);
 	kfree(forget);
-	if (nbytes < ih.len)
-		return -EINVAL;
 
 	err = fuse_copy_one(cs, &ih, sizeof(ih));
 	if (!err)
@@ -1348,11 +1343,6 @@ __releases(fiq->lock)
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
-	if (nbytes < ih.len) {
-		spin_unlock(&fiq->lock);
-		return -EINVAL;
-	}
-
 	max_forgets = (nbytes - ih.len) / sizeof(struct fuse_forget_one);
 	head = fuse_dequeue_forget(fiq, max_forgets, &count);
 	spin_unlock(&fiq->lock);
@@ -1388,7 +1378,7 @@ static int fuse_read_forget(struct fuse_conn *fc, struct fuse_iqueue *fiq,
 __releases(fiq->lock)
 {
 	if (fc->minor < 16 || fiq->forget_list_head.next->next == NULL)
-		return fuse_read_single_forget(fiq, cs, nbytes);
+		return fuse_read_single_forget(fiq, cs);
 	else
 		return fuse_read_batch_forget(fiq, cs, nbytes);
 }
@@ -1455,7 +1445,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	if (!list_empty(&fiq->interrupts)) {
 		req = list_entry(fiq->interrupts.next, struct fuse_req,
 				 intr_entry);
-		return fuse_read_interrupt(fiq, cs, nbytes, req);
+		return fuse_read_interrupt(fiq, cs, req);
 	}
 
 	if (forget_pending(fiq)) {
-- 
2.47.3


