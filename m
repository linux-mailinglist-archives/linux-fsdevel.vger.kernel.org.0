Return-Path: <linux-fsdevel+bounces-52204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DFEAE02F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37E717EA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B8A224B1A;
	Thu, 19 Jun 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGX1cz9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBF1224B0F;
	Thu, 19 Jun 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330289; cv=none; b=kNspqiegj3oedouFuytIfFsMa4mOFZHLG33zeeZ8M2Z4AndsLJenzCWBB+3x6svwsYuUufMREkaz0HeVDf4F1Xb/op5vxIpbLZk1x7Xmudr3RCU70Yw2/yDXrmfUu0jCZzgYae3zD/dqM0Pu17twPrtdS3yVKyBTLXixO0W5oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330289; c=relaxed/simple;
	bh=4VXuHApw2+bp/Zbwl5YkpBixSKtEkJWx1To/faloX00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjXs4i87+wyFssKsnFp/ZU3hanlrFhTxYAQPOVHEp7S205x2bV/1xnojbgfFef+LuCDPrbxLQ4eacosul77M4h+z7YE/HdbTgEh9p1DHacgS63IQ2mMQ5byomPQinSUQtA9KJ7UxZSUbkTUVcDMgNWWpZpEcLVhbRe8URvrY8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGX1cz9V; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso489853b3a.0;
        Thu, 19 Jun 2025 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750330287; x=1750935087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9riDQ4MV/aBbF2LtVJNoirZDNIciiDkcFSxIGvDyL6w=;
        b=nGX1cz9VhatuxSxIQk5GSRpGtXV0/sguovm4Zz2UZEqSApZ+6Pf6IbzZcuY+I1RCZg
         shc9yPe7XRgCZYmeXzksnngWDJxxZ818RIdA+D0b3LRy8OnEsbntmofjZTr7bRB+wZR+
         4m4gIf01Yy3+15Go5epSefl39ZDtpFnzrv5mWNjMrw6tD8Q7ln+iMQ1hnYrS5FUYRXpV
         0TlgZrEQNRm9OX7wWIw/V+OaetrmKmsKA+ie5pLvjedp7B7ivPLWtei734f4KJZY3Kq8
         ca8Mk0kD5epQS/xOJ2lcrYm3f4NSchN+jlQhcb5MiZjENCLCbb5fuyNwD4dI7ABNphqh
         pOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750330287; x=1750935087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9riDQ4MV/aBbF2LtVJNoirZDNIciiDkcFSxIGvDyL6w=;
        b=CrQf2HKTkxHrM1vbZfYSrIsAp/j6Q5tfoYl7yZNNWhEvQE0gXrMa/lW2GIw/bQckfc
         fphJCIrAR7cNAuNK9t16iPfntQGG673AUS6dgfKFYIP9jAmAnGPsrpASCqCUx19kXlk/
         nZ/X8P/eEK+fLoLILOvBsxM3CGqvEFD4AsblG9HuU1JdNSNSt5GfVJQKzHV6UGH5/zbj
         E2DoTJFSVmmw+Xkj91+PIM5JtTIR/X3eB7Nchf3rC15+a3Q+mBU+fYZLPbGC6msXMn/j
         n3tTZkCz0pivuNyaozh2bnmNK90e1RnO7dBiw4vxjF/bXmQFTVztVHLsrrNS+wPGh3PC
         54Og==
X-Forwarded-Encrypted: i=1; AJvYcCX3sdzxX1cf0A1m+raY6GIEq8OE9A4nch/okuyjEB+38jCN/81QbyIiDnHR41Z8peXVsuNmcblGiycTCLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5O3oP1SLeXq7T245ouKjmLPoXAUlBv9xeWxP3Zd08nX2My7+9
	9F+RA4PCTqeif1WytwS2YiEhU9jFJB4CvBiZeT34HqmmVwaxCi2FNUCptPOgphkF
X-Gm-Gg: ASbGncuiu7d7QDFQwCzTtlhrhFC5ezQ1adQ4oN1yfmRnfzxzAN7U7Xu0z3S9PPOzZ6B
	j6L8ge+ZrlTmxWxvQ/rfu3pDrF8XD+mb3h1GNYBznIZmWM1ESh/umJxzeWg4KFAlOXsw2pNsMUy
	IS4x/wNUPzFmyc6aoo+L+g4a8CPUDB6RLNCuQoFVEoLzVKMuZLacL3HkZGwwG7Ff0k3oCLfiP+m
	TlhI4wIvM6RpfBGOsHpmFh9+SAhyZVlQM2mMCebnNkSxHG23bpMRKkMjoirBbqwcP72FMdkJ3iO
	LYBf88MvmjzcCX1josDHYrfALypzi5/fFtloxvdbvcA/GFxaCDq2RfN2UFhsTkT3VbVAU6vQw4R
	W/WhoH5Lz20z4qe5RbFd/
X-Google-Smtp-Source: AGHT+IGt/wxXnvrubQ6eDMjjHuplNq3CB1wm5mPIB+P2oXu/dJkBl70YEmloVDAg1inrkypvoh4Bqg==
X-Received: by 2002:a05:6a00:418d:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-748e9e4de0emr7889139b3a.1.1750330286867;
        Thu, 19 Jun 2025 03:51:26 -0700 (PDT)
Received: from avinash-INBOOK-Y2-PLUS.. ([2401:4900:88e2:4433:750f:1851:bea4:26db])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecfc5sm13309390b3a.13.2025.06.19.03.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 03:51:26 -0700 (PDT)
From: avinashlalotra <abinashlalotra@gmail.com>
X-Google-Original-From: avinashlalotra <abinashsinghlalotra@gmail.com>
To: jack@suse.cz,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avinashlalotra <abinashsinghlalotra@gmail.com>,
	syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
Subject: [PATCH v2] fsnotify: initialize destroy_next to avoid KMSAN uninit-value warning
Date: Thu, 19 Jun 2025 16:21:17 +0530
Message-ID: <20250619105117.106907-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninitialized value use in
fsnotify_connector_destroy_workfn(), specifically when accessing
`conn->destroy_next`:

    BUG: KMSAN: uninit-value in fsnotify_connector_destroy_workfn+0x108/0x160
    Uninit was created at:
     slab_alloc_node mm/slub.c:4197 [inline]
     kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4204
     fsnotify_attach_connector_to_object fs/notify/mark.c:663

The struct fsnotify_mark_connector was allocated using
kmem_cache_alloc(), but the `destroy_next` field was never initialized,
leading to a use of uninitialized memory when the work function later
traversed the destroy list.

Fix this by explicitly initializing `destroy_next` to NULL immediately
after allocation.

Reported-by: syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
Signed-off-by: abinashlalotra <abinashsinghlalotra@gmail.com>

---
v2: Corrected the syzbot Reported-by email address.
---
 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d7..28013046f732 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -665,6 +665,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	conn->destroy_next = NULL;
 	conn->flags = 0;
 	conn->prio = 0;
 	conn->type = obj_type;
-- 
2.43.0


