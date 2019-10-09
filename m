Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE30DD1898
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfJITLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:06 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MCKWI-1iQUqA1iMc-009Tzp; Wed, 09 Oct 2019 21:11:04 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 01/43] fix compat handling of FICLONERANGE, FIDEDUPERANGE and FS_IOC_FIEMAP
Date:   Wed,  9 Oct 2019 21:10:01 +0200
Message-Id: <20191009191044.308087-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2uJzilWeK+WiT0h/pPdN3K/mVdDW9vuZKh5Yov5RjBQWLhEkFap
 up2GIxj8olvwQyD7nR6AsIG1/ngU6zLv+NT0Y0oU00nKWO6ezKQaqr/JnGgm1oSKtbbC3SO
 uYzStCkbpGXYKZlSiTsjT053BoaE5r0D1mmmRBMk5nKa4JV3IMvPXaF55mk6LpR5WrXNxYf
 T2KievGd+GbjOXz6xVSfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NRFYuPKnEzE=:+jRPMK5onbQzyVK1NHGVFD
 OTAzT1XPimm0LNZEtTF71Ls8QCgcHoLMeVDlIFljoRwUflgKvHTB7BMUZHgfa4LV/HXvZR6Wi
 lpCvt26D0MrhZdB7iLnpQyhz/sbkkaDzNPuewSvyG3fk4RyMm3eNlOFGADFygQ7oFf8HlBJrb
 TSG+GrUflecniKNUu3nUj0LQ87hRmJ9r8mAKzf2uya08bvMmeXXbRHWRcHwM5murzvUhmvW9D
 UaAY/nQzTBBYXR17b/hHClU2+65r0MqBxGaM9BzqXX6WI65zZ6C7h/jns+vBBkKJg8yVITWGN
 AlifMCCwgeHZ+7aklSauD6cRN0b55xqXMHAlISjdbfpRMza3GreD/s6r0JbCbuFAaFhpoQuBw
 p58j7/ZRPbqwlgMA/xQw7h4G3dsJdjyB8dTrcy/570F+X43+YHbOTGzI/sML8wd0+gk+cNnGo
 PIGHlQvHlGmAQQ3fRr7utBE9d5mo5rMN6gv+zrAIdWThhXelSn8bfUFDWXHb3nxhN27ulG0dL
 rki5fZl7jLs16uIOe4izdDqhR9a7ZqCe0tvVMZzqaq5O64ksLusQWThq2EJL4qIRjm7QeE29n
 vNw/Kw+6mVZ4PU1uJEVkCnuBLy6JNWV+j+QtaYfx9PSwBMa6oeJFHfaD/ujFHX62XGFRRHWr0
 MUkskSrK4tIckxJIDq+blZCBvl1aqEumKcQ9Y6sS0lIRiA4yeA9tQn0Z3wiWOEq7SwPsMMPh8
 mf920VjPDEVFVfhEAdhAt61uDO9UgQUyIau3EoTCEWuIQPnaO2gUEXX62dN42Ru1t+GSRDNSo
 0vUguuUma6IZR2u4o5ElRna9moSK2Qqi9+IJJ1U67PTE+GhYB7qI1P9SnApsa4ezL2S/FIS1Y
 CromSpYbYmQDcqkn512Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Unlike FICLONE, all of those take a pointer argument; they do need
compat_ptr() applied to arg.

Fixes: d79bdd52d8be ("vfs: wire up compat ioctl for CLONE/CLONE_RANGE")
Fixes: 54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
Fixes: ceac204e1da9 ("fs: make fiemap work from compat_ioctl")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a7ec2d3dff92..e0226b2138d6 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1032,10 +1032,11 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 #endif
 
 	case FICLONE:
+		goto do_ioctl;
 	case FICLONERANGE:
 	case FIDEDUPERANGE:
 	case FS_IOC_FIEMAP:
-		goto do_ioctl;
+		goto found_handler;
 
 	case FIBMAP:
 	case FIGETBSZ:
-- 
2.20.0

