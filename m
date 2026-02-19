Return-Path: <linux-fsdevel+bounces-77746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLfjC2OKl2m60AIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:10:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 864291630A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8BDA303D304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5532ABCD;
	Thu, 19 Feb 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK/Vvi2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3B2673AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539030; cv=none; b=aOZP2VgBr0LrnEI2C70Tu7NIN0ZX0tJcOZIE8MVS1yiHor8hlmlbtWM1KUMLyVvG7/2rfyndxZHmGjiLf6tYCm/T/B9fGnj7MX8A5iHDkA6oLSacqAH3Cb1CY93QQG0S26Li44JMI6Qhm88aeltoMbcaVZ5fZkofEek5l93C50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539030; c=relaxed/simple;
	bh=hUW9m+r47rZ6vHviD7NNPFmBgbzY8tzfEH7senHJ5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/rSprD5JxPK+CLFLOjqhz5MP7pwKRtbXCCkRJQo3rhNYKl0EZ0u5p+1wzyKNmcYS+544eZaFwrvocU94NzYSXAg37VB7p7AfBvItFKqGAeUlXdF32x7UgbDJl9JDGDJtPgD0BfQmG9wDm0zN2RBdF89QhiMBG/StdLItmVSrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK/Vvi2/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-794fe16d032so13225507b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 14:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771539027; x=1772143827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o802JVQtq+NP8/p4O20P5wd73rV8MTWnZYjcAz5Bn64=;
        b=DK/Vvi2/95Vf0foIq9adn+3DuAb7LiOS4K/Oxkv9bsamk7/zs8quzPvyI6SpneC1AD
         v+wy34bU7uHvk1kBuXLK/7mXci4iTrYxU1j72CKNuFSmgciXC/BSwU3DzMrar7v/tJ5M
         RWXKpLsMD4GlatEmX+ub5F73TwduJ/rHwqz13fny70D5BpZC/u/WXOosMFwAyGEcYr9U
         HbU6aLMBCPerJT40tvXRgTy6TtYd9L2LUKyjpadBzE2LXwlxtiWwawKEsB5XxklS1sGa
         QrUw9CiqYRLyDI2TBj96+K1Na69bNpx7y69l+O8y0QfadeDk/rfEkCtlSWDbY2DzDeA+
         Wm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771539027; x=1772143827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o802JVQtq+NP8/p4O20P5wd73rV8MTWnZYjcAz5Bn64=;
        b=XIao60EuNC5IrCX1KNGJIQRfejcZpKUYYpepgc2qAi4gH4G4WWVW8+b3grYLPPrDRC
         7y23NUfsNLffrMv3DRdZz0db3hWSFzxL6xj3tQZWKlxMl684uHvsn6Dhrg1J0/RKdI8r
         H1BxZLlrxNPT3yiYvXrHzeY66F8ZtSBWmk8XSheUd1ZANDRuw5eCM08N/jS8mn3o2Bg3
         z3ZK64nadcCLvSVazrAg4bOg4Mq09QQdoFP4ZyPSouGi12NrKq0wVlQesQbEMPGwYPUR
         MX8Bt5h8lJGHhZJRzjTTzdCvX/tJ1+dqYIySUbh8v8sjzaDfxbx2JFI2tDWItfkUqOQX
         pr/w==
X-Forwarded-Encrypted: i=1; AJvYcCVRUr2q250qH7QFj4CYrf8hjhCFTEJmk7bYVzejl6EhCN15LJMT1ldDIOIrwH+PMVXhbJeFy/f+hNXkWt5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3X6Y4PlxTDEfnaklGwSsXUOlOW3W4zqHGrjaUP3T3E8ovID//
	McQEBj80swuhgz+uekbYGaIG2LYvWY6OI6+42hUE8Q7S+OnltmnqA4E2
X-Gm-Gg: AZuq6aIm/VL7iI9/8nVk2wA2C4JlBLrZE8UHzg3gJLYCtwwxc8fvCbyIBvFuv1BTJFi
	/cTCEJ0+99BQ+bZh71CF+Rret8Zo8PRtHIWmtnPyGB+Ve7H8WE6sdq/xunYjZdGCA5HLhy4uTQJ
	tuH0NMgLGmwW3PiWSJ+pKc2TAhdZU1jTe7Cu22w2dLw8NRDgvwrDiaySnql6QEc/Ir0Hg8aT0xp
	vZoG9Kt7dqlpR+CMXfCKR4lxH0hCmwJ9uHQQVY+ULiiQyFi0NE993Dlem/olR1OmcPUNGLa6jHm
	/suCsl4VcbGlCR/JKrkJV4FRN/bshSWMElPHWtJWigamtiAzHilthzqgPXA3tHWjDC2QpG8SgJJ
	uc5y47MO3DNGN1ZRwlLFo2gRz3Lcbtou7VvamN/cSmpmiIHhNS9V3OudPs3OUqmYWLWeKP3x/fL
	y7A7SrFPjEmWgrhX8dhiwRE0mW4+giSM3Epshce9rju185WijUeh9DgtRTP599xSJF4df0qAid5
	xXopEbBO/1xWx0joz+JlONo9iQGX1DHYNv3JsaSx3te0s1YVTRZxQ==
X-Received: by 2002:a05:690c:d96:b0:787:f755:5ae5 with SMTP id 00721157ae682-797f734c502mr47511417b3.40.1771539027618;
        Thu, 19 Feb 2026 14:10:27 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18a935sm132936067b3.12.2026.02.19.14.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 14:10:27 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	neil@brown.name,
	bvanassche@acm.org,
	superman.xpt@gmail.com,
	tglx@kernel.org,
	oleg@redhat.com,
	mingo@kernel.org,
	ebiederm@xmission.com,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] proc: Fix pointer error dereference
Date: Thu, 19 Feb 2026 16:10:01 -0600
Message-ID: <20260219221001.1117135-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,acm.org,gmail.com,redhat.com,xmission.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-77746-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 864291630A1
X-Rspamd-Action: no action

The function try_lookup_noperm() can return an error pointer. Add check
for error pointer.

Detected by Smatch:
fs/proc/base.c:2148 proc_fill_cache() error:
'child' dereferencing possible ERR_PTR()

Fixes: 61a28784028e6 ("proc: Remove the hard coded inode numbers")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/proc/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4eec684baca9..4c863d17dfb4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2128,6 +2128,9 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	ino_t ino = 1;
 
 	child = try_lookup_noperm(&qname, dir);
+	if (IS_ERR(child))
+		goto end_instantiate;
+
 	if (!child) {
 		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 		child = d_alloc_parallel(dir, &qname, &wq);
-- 
2.53.0


