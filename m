Return-Path: <linux-fsdevel+bounces-65951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49072C16B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 21:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BE91C230BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9C3502B5;
	Tue, 28 Oct 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHPlwxNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD4350285
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681811; cv=none; b=ouJQ9HEjSCcRweflznQvg586Cqp1hUJocHD1m6W1dslUE8g0eNTrMpdjkI6MnGvk+EQHERNkDbAJfqyWMuwiTkcQR8oX1tx2GhtQJ8TE1vtEVCeJBEmbXIZs3YWKQNipONc9ClY2D0q0UrF9Yx9GpRzBuVBL74iwa5uoi/r7bTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681811; c=relaxed/simple;
	bh=BDUaSKODNKtMq7VQYWR0GriGBCfWmxRXz2MCLuAhAaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orve4FJmenVf6d3Vdb1co1kohwwZPrlANGVKbYEy/qOa0co0NFf5ALOwAjjSqJ9ZW04Bis8bgdIWNgT1KkI2MnOgh4TmHzvYZqFSJFals/xp3HEZw+xgEqFsNsNuR8pDvOe7SCCz8ap+DJuKEdyuWmrOUw8Xvqw4FIEvuVQ3p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHPlwxNQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33d896debe5so7131533a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681809; x=1762286609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8joGPkRS7NaA/SU5NP/PHmANMNfQZvGYAt78YOV8B8=;
        b=aHPlwxNQRBRywNPUb4gTzblnuwUeVxq83P+4+yTW27ZPaoxLsWxWTk8Ti5VhBjpE/j
         nJLqo3Rom+yWhjwnzWnewcjoTP4EAQaA+mCfUSu8uF8uxo0eTeaoP5Iqz+PRlEyBVhT6
         qPXPUexdCuK3v/wiCO9nbPWTjAJVdE8rZVLCjZMGIG1BNcsy4pUaJzft+ZyAwuALpwaY
         hwJldOrAz6938WESY/TYTKyrzVeBjiq1gGneTcuXraOax9bCchmwTMOUnCtRiL7igInp
         z5sVHyCOGHeOjjYdM2fZA+MJP3TKV8XVmSVfU+CthlqYfeyxxGNkjwqGOkLbsimvVwxW
         i1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681809; x=1762286609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8joGPkRS7NaA/SU5NP/PHmANMNfQZvGYAt78YOV8B8=;
        b=cdiF9+f90JwSaCk8pEgUBICDOUrQKahIadTFfCSiZfMcaZ9YpqK2pZwCgeMlOQuafi
         rdE44PhP0tkb4dcNL8soRwCws4uKAhLYyLGkeERsvJ+TMYbSCeRsw1rGgREXiD4ZKVst
         vmv4S2ekhEhFHjeHS94MHDC+diSFIzo9h21pwb8zRZRTVQHJz/dH6ctS2fC2VNIQK2W0
         HhXF9h9IbW35MtwbPEl86cYQgC82xapK5oPMFMPNM/4ZCwQgr6XrHWDm6UGTYDXV6g++
         ULzACoaAsqwadNJ6LAgxqlg1FdygWpfs8LeENvAOYR8f7SpQ07ORyuNJ63WQr2VWiRR4
         fhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWra6dbZBbC30ZfUwJNBiSJskd2IWzWbLccW7zsAqJ75f7N72DYIstjyTqRRoS+3EY858caL2wInNQAJvqp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Pf5l0ufSSKjtwYRQwXtG8o/4V3c4lXVquDdVTLEeg1geFsZ/
	9WMyUGtnIY1HsXWkTcmoqkfaZfoKL6GWMdnm6HJ63MDV6FETo0QRK83xdRv3tTHJ
X-Gm-Gg: ASbGnct9gP2njrQJBOzdhAKYR+1SfSJyjuvXZ31o642Pn56TkyoGRisf0ef1uzj0yAm
	/Fy01Q2GQ+zUGray26FlQJhj+Tnv8lca2u1rFuoCjS5NjaLxedXPhOV/T0P/TgpvisM369OgHA2
	qMrUtohQ6ITrxK6SXIOkH8xrojguWvSN9nBXSTeKqPJCR72ANC6BanlqbXodBG+hvH0yWA6XtQF
	aMwaiNy1QdS3ZaMj5qt/LCVfX3u/c+X18cX909W6mWJk8UHS68URjYqvqLN2CCvX1QkKCGM9scn
	IkhxRue9ua2H378viUGEqM8n+R9XVS1kV3j/dW1ayaUT1NtoQSzKNd8NS5q91Gu1bD9pim3wneR
	lPJkmMEsL1S7elDn2Rmk1Ezqco9Ug1fMNquuWH2KAg5jwbeomJNhQ0D5KfEjbmrd41DCTx1lZZA
	kuCXjG60/sQjxymbqcPjD2Nqzofc9+ryH6fQo3jw==
X-Google-Smtp-Source: AGHT+IFax4JLp6peVjA4GRSNGg+x5gUWORdeMvPmm1KtEIj6rMAl9UjikOCZ4H3Vmq+EX50VwOXgvg==
X-Received: by 2002:a17:903:1c2:b0:294:def6:bc1e with SMTP id d9443c01a7336-294def6bd88mr4468365ad.15.1761681808551;
        Tue, 28 Oct 2025 13:03:28 -0700 (PDT)
Received: from brajesh.. ([2401:4900:78f2:772b:141e:4f0f:8f8f:6f84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4254asm128996765ad.82.2025.10.28.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 13:03:28 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: miklos@szeredi.hu,
	stefanha@redhat.com,
	vgoyal@redhat.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	virtio-fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Date: Wed, 29 Oct 2025 01:33:11 +0530
Message-ID: <20251028200311.40372-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation in virtio-fs to ensure the server follows the FUSE
protocol for response headers, addressing the existing TODO for
verifying protocol compliance.

Add checks for fuse_out_header to verify:
 - oh->unique matches req->in.h.unique
 - FUSE_INT_REQ_BIT is not set
 - error codes are valid
 - oh->len does not exceed the expected size

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6bc7c97b017d..52e8338bf436 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 {
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
-	unsigned int len, i, thislen;
+	struct fuse_out_header *oh;
+	unsigned int len, i, thislen, expected_len = 0;
 	struct folio *folio;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
+	oh = &req->out.h;
+
+	if (oh->unique == 0)
+		pr_warn_once("notify through fuse-virtio-fs not supported");
+
+	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
+		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
+				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
+
+	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
+
+	if (oh->error <= -ERESTARTSYS || oh->error > 0)
+		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
+				    oh->error);
+
 	args = req->args;
+
+	for (i = 0; i < args->out_numargs; i++)
+		expected_len += args->out_args[i].size;
+
+	if (oh->len > sizeof(*oh) + expected_len)
+		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
+			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
+
 	copy_args_from_argbuf(args, req);
 
 	if (args->out_pages && args->page_zeroing) {
-- 
2.43.0


