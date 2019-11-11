Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9DF8114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfKKUWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:22:16 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:42475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfKKUWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:22:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8XLj-1hqEL53gMD-014Vte; Mon, 11 Nov 2019 21:16:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 14/19] nfsd: use time64_t in nfsd_proc_setattr() check
Date:   Mon, 11 Nov 2019 21:16:34 +0100
Message-Id: <20191111201639.2240623-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bZJ6dABjb/h5bnFGHvp5XdGnpOQ48DZK/y9xvfcHGKpTQoH3/bT
 1UeC7EXkGuZ29jsdi41tFt6HfOuEKjy2GfgdYIX/v+IXZR1U1EcEqzS/o8ilLDIy+b9S6kr
 GcfvrHS9+6QfIMVctOIbx3+o1NRJAZJYtvryMigWubxt8VxFp91emStVv1L6jsg8J2tG1am
 HXOJqCfyLJUodT6uk5vKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dbRhCZ12aTc=:oN8DIUR5xf8YebZvljt4E8
 jPI/c8keSlfSxzvYD/z5yoA72BNX/qGRs04Ak8r5YoeQbEnFdEyxmsWWOFzmMbEhO/5xY+twG
 H/iQpwPjy9TOqbZ2SDar1vulM1B0gwjZ+E/endUeaCpK6XwffIbE2qOcgrGr/uCVWjtlHZutV
 xMlPe4j5UUk3iCbAbFRtBovVfpWc+7x75nnMEygcuZy+DlVpkfeOLcYGKhQW6kjZgGPVu8jag
 9E5OXqI9x7LAzZwMSWnqAI/Exo3vycLihrEZ7wSLEAayyQf8EtnV9tY8w+NIszevrwD10RVOG
 1InLkIUpLSYaVFy0tkT7sT/kIQ5mcdnmF23o+tlySVQEbfrKeJYcSqvtJAR0dfSpMZEDA3A04
 ZNgH01oG2db9GXQ7G3XIlyFZmiBh9Pw/XxlA3BVIthiktvBr7v3Pr5aFfmz9iKPtTZKR6paVW
 LWl+13SSBK37GAXxxt9UVwvGyE+eT0luaWfAHlwoJgf12+98EYTll+eBWZtKcxGouH6UsmArP
 mBFd4I7/fUqeaIr88b+aOTG00jWnVhw4XqksfWo3XoDSMnpqyfF2DSRikjv64nC6LlXllFOiB
 WFPKOzj6XOhVWerSKTVmbXc95MRtN/IyyaLF+2wG3TG57AFtj6b5ZGoJb2d79DY6yqQfQseJJ
 BZQeezjtsxE9vCZZmZbZy9rRjDqouKzKzquMSPfvyiNkoBGQ/BRAzHiixkArQ04qG7yCesSfP
 kqAS4UyDLfdekrxB+Zo61Gz+aoTQmpDLP1u9yqJQQYjCf00YRR39Ie+XNLuN9miN5KGcfqQ37
 Kr+Fm0MMLspmle0KiTpkVRRQe5pYtLPa981QTn50S/BCs5rI5G9hnugAQivEv6Uam6wIY9LKR
 Z/Zx6iJNL0/SMqiwPm3A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change to time64_t and ktime_get_real_seconds() to make the
logic work correctly on 32-bit architectures beyond 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfsproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index aa013b736073..b25c90be29fb 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -94,7 +94,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		 * Solaris, at least, doesn't seem to care what the time
 		 * request is.  We require it be within 30 minutes of now.
 		 */
-		time_t delta = iap->ia_atime.tv_sec - get_seconds();
+		time64_t delta = iap->ia_atime.tv_sec - ktime_get_real_seconds();
 
 		nfserr = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
 		if (nfserr)
-- 
2.20.0

