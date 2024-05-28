Return-Path: <linux-fsdevel+bounces-20354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EBB8D1F26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93C31F23D97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260D916FF5A;
	Tue, 28 May 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Sb9Z29gB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7016FF4D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907502; cv=none; b=sTmFbp+dl5ddEqaed9Ui8lQ3QBlibkQ582HFTTUBKINlO6MzTPVkRKtbCJZACizWfmUBy+VhmjMPpSAPue4tw+SISMJ9pzf39tmhaq1DaFNkTDh3C6dBMB6glmdEdJhrn4Mc+N/Wkr+DM1WWL3NNqRF7JjTlsJSdcDx0CavyCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907502; c=relaxed/simple;
	bh=u5DGMExmMELV1xy8yLiiNHEKToOQqClZz2C5kQWXUNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cYWPhexPfYzBW1eM3NHZnjD/9vCkb/1xIzCnG9EhpeNAMkS71n2bdOQyAXY0Pcuwn38wN2rGp0D+0Esoc1+/kNzQnRgYJDN7CrawGVJ5ZunhfxMgzzUo4GBmfkDfwKYWBy16Tz4hauOh8K9lifnqrcNQIdL5P/B/oz/0HBQeWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Sb9Z29gB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaacaso117179566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1716907499; x=1717512299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG5W+RrKzluwPnH1A1A5fDJr2fjufgKg3mZALw2M2DI=;
        b=Sb9Z29gBBZ7RGKeiwA20b4Mhka0/qQLlA/CeZB0gmndIMDAy1KvAePcvWh7wqXBt05
         4IISI44NyrAjto96wx5YHBGA/h1rHfwQ20dishr5RmR6A3nlNkV1Wv2acU/CJLB155TX
         W1V5Imfh+Z0QPgGYpflG56Vhbg6w03XmliM/lmUJiiMTzNH2Gc6JyH0cdRpsLywoDkxY
         eUo5F3ERMMtosqCFjMXAI0+YtA9ep4uS2B6h9gwdjg974KpHm8YkfoG2mEqCICJxIfoP
         yTLJBRCQ/QePlNHHypun4fgoBbqva4TQClsEcDMZkWxbBucVmsxaSQXH3ZrCjJTYRwmN
         5rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907499; x=1717512299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TG5W+RrKzluwPnH1A1A5fDJr2fjufgKg3mZALw2M2DI=;
        b=lRI7HZmyHqTuWBtirh5VS46Vq+aJoieC5lR2WUNB9l3WOuzhUBWJpb51IkjHJrfUfV
         gWPpkJ2T+s/hlaAsOHQvMXY/V1/g8mRVanZsf1+DCgLOuB/OgOgXvq7LZznIAOgz43uW
         8sfkzFWKZsrafLnYw0+czqT22ioTBHwY5wAbDgAs9kKoGmnr03FE8cw19aGJWORcNQ6R
         OGQeUBrurGn+byMrGND5ju0wFamPreYzMLL+5+aM/7f45AWeDgkL4i6H/CzQUy8CjeNE
         MBnQyOOxogAHRKtszSLUVbW1r+2kZi5mxGO0rDnOmYv6RpglRHGveP0wO/Puh0m2If/Y
         HCGg==
X-Forwarded-Encrypted: i=1; AJvYcCV/blWb/MRq6KdWqNi4MA6dvv6cs63LG/uh/I9hBk1EJbRiCsgP1pzOjM0eVpe8B2DZ83arl2BUK5u1OWLYRtvyWShC46SsL39hZpF9Xw==
X-Gm-Message-State: AOJu0YzlEtfdrnEPv10x7+7uOM9Iige0VvdS9HArAI7w+HJzwSyjHKcX
	oH0kRFGc98tMI+nxU3Y7Fu6rpGxoR/HZILoI1odeRXwis2HjrUXxoJvFrCIl2R8=
X-Google-Smtp-Source: AGHT+IGcfIH5RPh4OnyVqTq4ATc6SBA5sJNh2KrF2k5/BA6AVB02Dz6lBLYJ9g6apMqOwqcdLBUyzg==
X-Received: by 2002:a17:906:4453:b0:a59:9b75:b84 with SMTP id a640c23a62f3a-a62646cd4bfmr828803266b.35.1716907498607;
        Tue, 28 May 2024 07:44:58 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817bffsm623787766b.32.2024.05.28.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:44:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/netfs/fscache_cookie: add missing "n_accesses" check
Date: Tue, 28 May 2024 16:44:45 +0200
Message-Id: <20240528144445.3268304-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a NULL pointer dereference bug due to a data race which
looks like this:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 33 PID: 16573 Comm: kworker/u97:799 Not tainted 6.8.7-cm4all1-hp+ #43
  Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
  Workqueue: events_unbound netfs_rreq_write_to_cache_work
  RIP: 0010:cachefiles_prepare_write+0x30/0xa0
  Code: 57 41 56 45 89 ce 41 55 49 89 cd 41 54 49 89 d4 55 53 48 89 fb 48 83 ec 08 48 8b 47 08 48 83 7f 10 00 48 89 34 24 48 8b 68 20 <48> 8b 45 08 4c 8b 38 74 45 49 8b 7f 50 e8 4e a9 b0 ff 48 8b 73 10
  RSP: 0018:ffffb4e78113bde0 EFLAGS: 00010286
  RAX: ffff976126be6d10 RBX: ffff97615cdb8438 RCX: 0000000000020000
  RDX: ffff97605e6c4c68 RSI: ffff97605e6c4c60 RDI: ffff97615cdb8438
  RBP: 0000000000000000 R08: 0000000000278333 R09: 0000000000000001
  R10: ffff97605e6c4600 R11: 0000000000000001 R12: ffff97605e6c4c68
  R13: 0000000000020000 R14: 0000000000000001 R15: ffff976064fe2c00
  FS:  0000000000000000(0000) GS:ffff9776dfd40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000008 CR3: 000000005942c002 CR4: 00000000001706f0
  Call Trace:
   <TASK>
   ? __die+0x1f/0x70
   ? page_fault_oops+0x15d/0x440
   ? search_module_extables+0xe/0x40
   ? fixup_exception+0x22/0x2f0
   ? exc_page_fault+0x5f/0x100
   ? asm_exc_page_fault+0x22/0x30
   ? cachefiles_prepare_write+0x30/0xa0
   netfs_rreq_write_to_cache_work+0x135/0x2e0
   process_one_work+0x137/0x2c0
   worker_thread+0x2e9/0x400
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xcc/0x100
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
   </TASK>
  Modules linked in:
  CR2: 0000000000000008
  ---[ end trace 0000000000000000 ]---

This happened because fscache_cookie_state_machine() was slow and was
still running while another process invoked fscache_unuse_cookie();
this led to a fscache_cookie_lru_do_one() call, setting the
FSCACHE_COOKIE_DO_LRU_DISCARD flag, which was picked up by
fscache_cookie_state_machine(), withdrawing the cookie via
cachefiles_withdraw_cookie(), clearing cookie->cache_priv.

At the same time, yet another process invoked
cachefiles_prepare_write(), which found a NULL pointer in this code
line:

  struct cachefiles_object *object = cachefiles_cres_object(cres);

The next line crashes, obviously:

  struct cachefiles_cache *cache = object->volume->cache;

During cachefiles_prepare_write(), the "n_accesses" counter is
non-zero (via fscache_begin_operation()).  The cookie must not be
withdrawn until it drops to zero.

The counter is checked by fscache_cookie_state_machine() before
switching to FSCACHE_COOKIE_STATE_RELINQUISHING and
FSCACHE_COOKIE_STATE_WITHDRAWING (in "case
FSCACHE_COOKIE_STATE_FAILED"), but not for
FSCACHE_COOKIES_TATE_LRU_DISCARDING ("case
FSCACHE_COOKIE_STATE_ACTIVE").

This patch adds the missing check.  With a non-zero access counter,
the function returns and the next fscache_end_cookie_access() call
will queue another fscache_cookie_state_machine() call to handle the
still-pending FSCACHE_COOKIE_DO_LRU_DISCARD.

Cc: <stable@vger.kernel.org>
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/fscache_cookie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index bce2492186d0..d4d4b3a8b106 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -741,6 +741,10 @@ static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
 			spin_lock(&cookie->lock);
 		}
 		if (test_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags)) {
+			if (atomic_read(&cookie->n_accesses) != 0)
+				/* still being accessed: postpone it */
+				break;
+
 			__fscache_set_cookie_state(cookie,
 						   FSCACHE_COOKIE_STATE_LRU_DISCARDING);
 			wake = true;
-- 
2.39.2


