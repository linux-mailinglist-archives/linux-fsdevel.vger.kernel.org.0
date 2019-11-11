Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3020CF80F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKKURY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:24 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfKKURF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:05 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mwwm5-1hfl1c2bHv-00yR5A; Mon, 11 Nov 2019 21:16:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 16/19] nfsd: fix jiffies/time_t mixup in LRU list
Date:   Mon, 11 Nov 2019 21:16:36 +0100
Message-Id: <20191111201639.2240623-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AH8i1QyjBnmOgX+Hph5q/HZDFvvmSil4F4O+Bsp1GBARUSPR52L
 oJj8k7tJxTPm8H3PYTDBGT5Kf6ImwYCV/Mbg0OPMDkv9pdGxcDg/0bjWFERI6HLp8xzSX9J
 ixTYcoCBHyaZoFmRJMdqLFk79jkYGlaOW0hPkIPun8C++agV/XpkFXdIHMbwNrryvm4P3ix
 d2L6RsC6qjcI08EKf5UEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sh4EoJu1FJ0=:q2VPo+fnLWnNCS+UeuYzw1
 qXUBzU4zX7fHNjgxQ0AyM0uzAWi4xzEdFhvP0TmDK5iNplav4fmxRGBgqZVrSDvIpwut0QFHt
 5JLrWLuUfdwoikzjVFQfEZupDo0PZjEzaPn5rEmNuvuwK0IJAONBwAqll6mbnkE3Y+QQcRcwP
 XzdggbnvtlViky0kxRMLr0QeofeNoyMivV9W8HGY5ajhutREIDm/KohHoJCIUc4V59uOv7MSU
 Ly3oyeM1PIzngbIgbIJGGc26x2JYmUuL7YhlVh8dKGoowAODJyDcIimuo7ltqhH9eTcuI75Ud
 FhGMdFIA1vQvxKkBaf5SkhAYr+PEIbwylF6aI38HWbEnyFMNrwG9/nWtxQs26Iqfdz3TJfgx5
 DOhO9Bq66P8xC3kiQKg7HkwLp1lepCiDYs1vcBbtpI/yZ/nyOkU3JrvDANePniQk1fKIpuwUs
 768DD/FuK5uhEBtZNTvq624Ec2PccKq/vXXtLT7gMUJ7FM+F1iS/CU3qtJl5KS+q9c9nn5Yu9
 5ZV4p2SXsYb1pAlRWxaURIGOT5JvU2kf378Lzz8EvyEJf+Q/WJa4pgLx/ih9p9xn8NDx/LHN6
 c5DPqSRfybLg9JIU3r52w5+5cM8BeqwCtSF5IK9/VmPk9xpovGNnhuW75FwtKzn+aNarlHCyu
 y9kPmuCagplHhxHTjEVuZJDGj8U+wHmATkc8zLts5Y0GUoWdrsdSWocjUHTioMw3g0cE3aEek
 rYFB4pPXY5VHDixHp5l6f/PLq0AXg2Dq207bhzKvncw7dfWVU1SLTcS+7vyonPUgRYRuqRU4L
 GGBNA4pAOtllJNOZts6xRfnLhSfhNVmLBOEi9/4AHDjj4F5wIHbYMB4s8QOv75LYW+lu3MuqV
 Qo5nh3wRaSrLPB2SDs6w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nfsd4_blocked_lock->nbl_time timestamp is recorded in jiffies,
but then compared to a CLOCK_REALTIME timestamp later on, which makes
no sense.

For consistency with the other timestamps, change this to use a time_t.

This is a change in behavior, which may cause regressions, but the
current code is not sensible. On a system with CONFIG_HZ=1000,
the 'time_after((unsigned long)nbl->nbl_time, (unsigned long)cutoff))'
check is false for roughly the first 18 days of uptime and then true
for the next 49 days.

Fixes: 7919d0a27f1e ("nfsd: add a LRU list for blocked locks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/state.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ea7a40f8d4e..551068f4b836 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6544,7 +6544,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	if (fl_flags & FL_SLEEP) {
-		nbl->nbl_time = jiffies;
+		nbl->nbl_time = get_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ce32ba445343..c1bb6a5ecf57 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -605,7 +605,7 @@ static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
 struct nfsd4_blocked_lock {
 	struct list_head	nbl_list;
 	struct list_head	nbl_lru;
-	unsigned long		nbl_time;
+	time_t			nbl_time;
 	struct file_lock	nbl_lock;
 	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;
-- 
2.20.0

