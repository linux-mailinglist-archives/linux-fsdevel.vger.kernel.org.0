Return-Path: <linux-fsdevel+bounces-73095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA66D0C459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 22:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F652301F029
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 21:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF7E325709;
	Fri,  9 Jan 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI4nGXsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BD324B24
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993341; cv=none; b=Ffrr8vU7SpV25Dd5WIev20ktAOuA33y+e1iql40k8WR4jYZHgQqoqPkuHNwdExp3R7LKfvC1WAgcSlmGZXpIDGBuWIliuNmk73t8kJye0t/16y0OAxFZb56ivfmo3+ncKl+h861KFmWYWAh79W39puydq2jgTjHQBa8WR5eI7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993341; c=relaxed/simple;
	bh=wHKb4pjCRv6U2F9o5l5lJ2L9p4OmWDIHYsLXtKoYv+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPvOcd940aNo7NFCmUppkXq8qvrKpWtDxli+Smfw/+BDkT3BLXq4DZYG40+zYx5oVqVHUjqoujBCddf13saor6wjIAnvKLg7GkTZoRPhhkeohmRmNp/vipBAgnZsJou4Ng+y9lt7qwURJcddlPKCQwAol5imi9nd4RWam8w2vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI4nGXsQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7633027cb2so901889666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993338; x=1768598138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDKqXty/phrNreq/1HyNl6WwU2ZP7I08WhpS0Kmj8UE=;
        b=jI4nGXsQdU62AAajse8pJUOOph/XY1BeGcyGCIcE+I2syp2iKxE4wRffWD3d2zFTTE
         fz9N2g42b+ZAft+xl6gwDYkqN1j6sq4V+XY9UTSoyZ/LP76bWWBcdpjPoTZrfAkPhpd+
         daQAwAGudtEeUngOlGiEedeQ43o2gM/kidR2YKX2yTA3+QxGSywtr64d10JLAXyP6uoW
         bobSplIMTJIzfM4MBVWPK51oRwGCmOxeRBD8lIdFtpwy4mXBGhiD1MxjdZ8mSdOZqlB3
         /BksU0OdycVgBnZefQTK1xg5qu3TNTPnRsqGZ48LcmgU2XS+LCKYzOmQGdGlKKlzO2ZN
         7kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993338; x=1768598138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDKqXty/phrNreq/1HyNl6WwU2ZP7I08WhpS0Kmj8UE=;
        b=xEMBCqwkNx18z84vY/7NS1a7Qhvy1Np0Ex+KNqXG1/yo7XgA9cPYKK/CsZxViQdxd3
         inWEPuL/J90kyzu9mPfCQfI713ggQNCnxm0SZwp8GiHBPzNyKs8LcSzGTKmwqv7Tny2r
         mHLEs8jyAIbXtsm5eEW6LCLiz69R2uzs50QRaQbSssEi3+UvbIdLYg9k9o7gCmY286rL
         BFPNgVrdk50D5dcyv0BRrN1k+Z+/KNz6INdNlx3/BzO/SGKQsavhZB4DJ28DKzhIWvVX
         n1eZhdTkw5EMtBrvChxbFXPNWRyeHc6rhqKyDfMGK6nQ08lvPTv2LNlo9rQalY/MpYQ2
         vwwg==
X-Forwarded-Encrypted: i=1; AJvYcCXyO5d5QcXMoAGZr4JIB9GWddKxWKsfBDExh5w73dFqOTLXTKs7WdY2i0d+HK3Mi7XbOCIHLC22tRllaUL7@vger.kernel.org
X-Gm-Message-State: AOJu0YyKRu2U0m4FAJJSG2aA2/zoNzBPo13gPTl12iSp2YYDVbRBj4rX
	VsxYglX1jUMJo5A9jnuX4xB0AHpYJd0q70iSjrHIJoNOQgyNmfRWn8PS
X-Gm-Gg: AY/fxX5KIgvKk4YycTt7b7Kfq+2ObF0Nq6M1vL9js7nMbWge9ruOk+1lm/bqYioSNev
	6GLWe0GFgJra6ou8SD7Cc8JyX6rFbyZUtR0eeR80Twp5N39dQUmsQ1bSoxnTRtP5ngCHcG4qDUB
	HGNNdcyDh8CGNwYt0NXEtb2eAc3p5P1VjRGCWcvR7PGRwvtCtZxNk/qxp91IA3otp9vVf6gspTD
	JA3pGPoO32wPiEcRPIdgEu3EvI3XOPETAP+DttOus+VEDELegu0BJVX8AkRtHAuk+TGtdTOK+G0
	5G0NsRYJwk7lSBBDOYs0k/ofB2ykTn5E2Y4NUVPjFAHZcYzOfZ337fiSYpuRIWlFYyDRzuNiWIR
	/QAbIsvmxaG/EKUTEgfnw/u6DtSVtj3Ym7xR6bXOQCd/4/neiusgL3w8yWNR+LMMxue2biVM6dm
	hB1afCPLDssz2OdLHbcljZkdSw2+Zbpx9cGNvdCdr4UjD18C4pDeUfwEn6bhjmleCBxfhOQf/ra
	S9tf8q9ec2m2Pkl
X-Google-Smtp-Source: AGHT+IE4YeaC+URYAdj7x4tVQG3W27g6uAuDNI5/WYbGlVtlabWBqRmZ5jgR2okzv/YQSyNiKyJguQ==
X-Received: by 2002:a17:907:3d0b:b0:b83:1349:3a7 with SMTP id a640c23a62f3a-b8444c4d0e0mr1054031566b.10.1767993337798;
        Fri, 09 Jan 2026 13:15:37 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-41b5-caeb-2488-6dca.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:41b5:caeb:2488:6dca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2340a2sm1234820466b.5.2026.01.09.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:15:37 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: move initializing f_mode before file_ref_init()
Date: Fri,  9 Jan 2026 22:15:36 +0100
Message-ID: <20260109211536.3565697-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment above file_ref_init() says:
"We're SLAB_TYPESAFE_BY_RCU so initialize f_ref last."
but file_set_fsnotify_mode() was added after file_ref_init().

Move it right after setting f_mode, where it makes more sense.

Fixes: 711f9b8fbe4f4 ("fsnotify: disable pre-content and permission events by default")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index cd4a3db4659ac..34244fccf2edf 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -176,6 +176,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 
 	f->f_flags	= flags;
 	f->f_mode	= OPEN_FMODE(flags);
+	/*
+	 * Disable permission and pre-content events for all files by default.
+	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
+	 */
+	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
 
 	f->f_op		= NULL;
 	f->f_mapping	= NULL;
@@ -197,11 +202,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
 	file_ref_init(&f->f_ref, 1);
-	/*
-	 * Disable permission and pre-content events for all files by default.
-	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
-	 */
-	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
 	return 0;
 }
 
-- 
2.52.0


