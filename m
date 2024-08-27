Return-Path: <linux-fsdevel+bounces-27386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5996112A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D33B26E30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475D1C6F51;
	Tue, 27 Aug 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aJFeOypR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E71C93B7;
	Tue, 27 Aug 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771796; cv=none; b=bEo52CrxZC9oiQCYcv0j7jyNRdUJU+3xCdxYgTu2hZ+a8g4YFs2ldTWHY5vyYKkAnmq3s8UfrNTTUWczh1+buxFS5E03o00LdhMGZ804X5bMd00kLHTVneHKGkJPQTLzipVDfFkY1IQz10QPUcFw6IHkHP7UayYMuxzm4j0KVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771796; c=relaxed/simple;
	bh=UYNhqfSuAWIP7b0GclDAdbpRsOfVoKJ3u1PHAOmQtvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3AXnM800uRHkZ/xrVcVZrcrdUlVP27wD3N4zgQjpowTadD8PmCOlBwBTWL3sCEvDqCTOD0nkSAwjhFqcVSV6kol3oBM2MbOvFYHKvLInvR392hHLhdc2ghp12yYOFf4knPC4UI8k2GVirYkiFmmvPKGm506ALAnL53unifnUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aJFeOypR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E22C4DE18;
	Tue, 27 Aug 2024 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771796;
	bh=UYNhqfSuAWIP7b0GclDAdbpRsOfVoKJ3u1PHAOmQtvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJFeOypR3ePFORlWp+nVy/JH6gixPMIzRXXlTtONWP7B1E7dCQNiExoLiw/mRbJKf
	 9dn2a4SB39f9p3UTTmHbmsjbALYhyC3wqpxF8c7KQhoKzrOkKDhC6QR2q5qC2WBRfx
	 p8NJRUi4gDOBCDy3GCBBzc0SpjYqrIVlsYS+q0WI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 023/321] fs/netfs/fscache_cookie: add missing "n_accesses" check
Date: Tue, 27 Aug 2024 16:35:31 +0200
Message-ID: <20240827143839.094187208@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max.kellermann@ionos.com>

commit f71aa06398aabc2e3eaac25acdf3d62e0094ba70 upstream.

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
FSCACHE_COOKIE_STATE_LRU_DISCARDING ("case
FSCACHE_COOKIE_STATE_ACTIVE").

This patch adds the missing check.  With a non-zero access counter,
the function returns and the next fscache_end_cookie_access() call
will queue another fscache_cookie_state_machine() call to handle the
still-pending FSCACHE_COOKIE_DO_LRU_DISCARD.

Fixes: 12bb21a29c19 ("fscache: Implement cookie user counting and resource pinning")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240729162002.3436763-2-dhowells@redhat.com
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fscache/cookie.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -741,6 +741,10 @@ again_locked:
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



