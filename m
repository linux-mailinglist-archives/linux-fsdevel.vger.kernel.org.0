Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA11B401083
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhIEPTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhIEPTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 11:19:17 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC8C061575
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Sep 2021 08:18:13 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:38f0:cc4f:6a1e:c4ed])
        by laurent.telenet-ops.be with bizsmtp
        id qFJ8250043XDlWk01FJ8ws; Sun, 05 Sep 2021 17:18:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mMtuJ-00271J-If; Sun, 05 Sep 2021 17:18:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mMoTz-001yQL-DX; Sun, 05 Sep 2021 11:30:35 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        noreply@ellerman.id.au
Subject: [PATCH] binfmt: a.out: Fix bogus semicolon
Date:   Sun,  5 Sep 2021 11:30:34 +0200
Message-Id: <20210905093034.470554-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    fs/binfmt_aout.c: In function ‘load_aout_library’:
    fs/binfmt_aout.c:311:27: error: expected ‘)’ before ‘;’ token
      311 |    MAP_FIXED | MAP_PRIVATE;
	  |                           ^
    fs/binfmt_aout.c:309:10: error: too few arguments to function ‘vm_mmap’
      309 |  error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
	  |          ^~~~~~~
    In file included from fs/binfmt_aout.c:12:
    include/linux/mm.h:2626:35: note: declared here
     2626 | extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
	  |                                   ^~~~~~~

Fix this by reverting the accidental replacement of a comma by a
semicolon.

Fixes: 42be8b42535183f8 ("binfmt: don't use MAP_DENYWRITE when loading shared libraries via uselib()")
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/binfmt_aout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index a47496d0f123355c..0dcfc691e7e218bc 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -308,7 +308,7 @@ static int load_aout_library(struct file *file)
 	/* Now use mmap to map the library into memory. */
 	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE;
+			MAP_FIXED | MAP_PRIVATE,
 			N_TXTOFF(ex));
 	retval = error;
 	if (error != start_addr)
-- 
2.25.1

