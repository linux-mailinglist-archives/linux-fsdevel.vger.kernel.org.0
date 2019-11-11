Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE34F80F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKKURZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:25 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfKKURF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:05 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3lkT-1iUXEP10T5-000qDU; Mon, 11 Nov 2019 21:16:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/19] nfsd: make 'boot_time' 64-bit wide
Date:   Mon, 11 Nov 2019 21:16:32 +0100
Message-Id: <20191111201639.2240623-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PNkdbjcRtbrbVMRUiZLzF1eXOvEElAym2CbUzxCHUKM+UeD/ENv
 tZVtNhCjbb2R4CVQ+tuX82riybqvHgcczH+XNNeLunytNXK/EbG2xqn3kK0fUKr8EeW5kpF
 dy1F8JS4y9BaNphHp0AymV3uTXSjvQj9jeAyN/k7nF71NOFb9DUUCkD16P6ZDapfzJ23GDB
 7HqaAcq95pfqVAiyM1bQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/yjMXGGT/RU=:VwPh1w9NN0xV/iIK32b7vP
 YC1VtjUpL+gsfAzSWXfi3kOOL3eJkV98x3H8KJ8xA+kY70mP1UxFewtvs2K1Y9G2nqjVpzwlV
 sRUxWMYkJiHylw0/DXcGJ44sffRgVCwNk5Zfh7+MR4e5y2TSfqpM1UfeSo2kP9UbvJRJbFr75
 jOxglXbZhAKAQcm9W4E31RtjYRNSUuU3AUKb6XKaVR28FPUmxClGTeFcLxdTkSAXFUY9Xom8D
 ja8hBN9eVxwxdH/db4oZMLvc/j9wNNxy03Yq1jX7gJOFux2RZgxV5Nhj22jQ9xvz2gIobB3di
 k2sxZkc7iMHoLeDb8t+nMbfX1ZEYgAgxFAZ56BTFPwC9KF9O5MoYCOaNcSKfprqTMVZD3Mil8
 TFe2GPPdtrCPUdMtcKGkujS9HjMDBrxKf1Kq/6J9lH9Sm8Q5FcZJIFYbOGn5lPiMsyLTh9MnH
 RnoUOVHy68exfFtErzN35HEFWjipQqOlSlIy/fOQqKxLi6xuXTphG67dmS50BEEaMh8jeFgss
 h5xYWQJNcYlqXxwYr7MOKPqoyVqCbvTy5zYJJ2+gp/sIPhAkMTXpHMec3wzJC7I/6Jbxc4tf2
 rT9+NbY3QAvPGgyHCHFeLrKT7SkM5xbSs6MxYeFenzk46GmpCWK+BOQDWsst/YFpGzdk2oM0l
 6qZWf10BRKsbNw1DbwrFkIYFiA5ebcFfreeuJih9KRWmoPMKaKuQm1CzExVyrJq5apwD2piix
 ktLmIHFJGEgnZtzdPbz7R77YHMWLz9NcQWxFuEli6y0abS31jteaU43ZdzepPzuUAWOIlVKG4
 Ao5oFJSexKHAQyf5WXtov7Scq8usGfR/L2QU3KJZkoPl/JRoK+D6iIoGGsdnj1pB4ThpOmm7N
 Hbln6rq6npnm1K29b5pw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The local boot time variable gets truncated to time_t at the moment,
which can lead to slightly odd behavior on 32-bit architectures.

Use ktime_get_real_seconds() instead of get_seconds() to always
get a 64-bit result, and keep it that way wherever possible.

It still gets truncated in a few places:

- When assigning to cl_clientid.cl_boot, this is already documented
  and is only used as a unique identifier.

- In clients_still_reclaiming(), the truncation is to 'unsigned long'
  in order to use the 'time_before() helper.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/netns.h       |  2 +-
 fs/nfsd/nfs4recover.c |  8 ++++----
 fs/nfsd/nfs4state.c   | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9a4ef815fb8c..29bbe28eda53 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -40,7 +40,7 @@ struct nfsd_net {
 
 	struct lock_manager nfsd4_manager;
 	bool grace_ended;
-	time_t boot_time;
+	time64_t boot_time;
 
 	/* internal mount of the "nfsd" pseudofilesystem: */
 	struct vfsmount *nfsd_mnt;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index cdc75ad4438b..d51334f38e3b 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1445,7 +1445,7 @@ nfsd4_cld_grace_done_v0(struct nfsd_net *nn)
 	}
 
 	cup->cu_u.cu_msg.cm_cmd = Cld_GraceDone;
-	cup->cu_u.cu_msg.cm_u.cm_gracetime = (int64_t)nn->boot_time;
+	cup->cu_u.cu_msg.cm_u.cm_gracetime = nn->boot_time;
 	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret)
 		ret = cup->cu_u.cu_msg.cm_status;
@@ -1780,7 +1780,7 @@ nfsd4_cltrack_client_has_session(struct nfs4_client *clp)
 }
 
 static char *
-nfsd4_cltrack_grace_start(time_t grace_start)
+nfsd4_cltrack_grace_start(time64_t grace_start)
 {
 	int copied;
 	size_t len;
@@ -1793,7 +1793,7 @@ nfsd4_cltrack_grace_start(time_t grace_start)
 	if (!result)
 		return result;
 
-	copied = snprintf(result, len, GRACE_START_ENV_PREFIX "%ld",
+	copied = snprintf(result, len, GRACE_START_ENV_PREFIX "%lld",
 				grace_start);
 	if (copied >= len) {
 		/* just return nothing if output was truncated */
@@ -2007,7 +2007,7 @@ nfsd4_umh_cltrack_grace_done(struct nfsd_net *nn)
 	char *legacy;
 	char timestr[22]; /* FIXME: better way to determine max size? */
 
-	sprintf(timestr, "%ld", nn->boot_time);
+	sprintf(timestr, "%lld", nn->boot_time);
 	legacy = nfsd4_cltrack_legacy_topdir();
 	nfsd4_umh_cltrack_upcall("gracedone", timestr, legacy, NULL);
 	kfree(legacy);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2333924d7c6b..70a953b03be4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -753,7 +753,7 @@ int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
 	if (new_id < 0)
 		return 0;
 	copy->cp_stateid.si_opaque.so_id = new_id;
-	copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
+	copy->cp_stateid.si_opaque.so_clid.cl_boot = (u32)nn->boot_time;
 	copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
 	return 1;
 }
@@ -1862,7 +1862,7 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
 	 */
 	if (clid->cl_boot == (u32)nn->boot_time)
 		return 0;
-	dprintk("NFSD stale clientid (%08x/%08x) boot_time %08lx\n",
+	dprintk("NFSD stale clientid (%08x/%08x) boot_time %08llx\n",
 		clid->cl_boot, clid->cl_id, nn->boot_time);
 	return 1;
 }
@@ -2222,7 +2222,7 @@ static void gen_confirm(struct nfs4_client *clp, struct nfsd_net *nn)
 
 static void gen_clid(struct nfs4_client *clp, struct nfsd_net *nn)
 {
-	clp->cl_clientid.cl_boot = nn->boot_time;
+	clp->cl_clientid.cl_boot = (u32)nn->boot_time;
 	clp->cl_clientid.cl_id = nn->clientid_counter++;
 	gen_confirm(clp, nn);
 }
@@ -5178,9 +5178,9 @@ nfsd4_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	unsigned long now = get_seconds();
-	unsigned long double_grace_period_end = nn->boot_time +
-						2 * nn->nfsd4_lease;
+	unsigned long now = (unsigned long) ktime_get_real_seconds();
+	unsigned long double_grace_period_end = (unsigned long)nn->boot_time +
+					   2 * (unsigned long)nn->nfsd4_lease;
 
 	if (nn->track_reclaim_completes &&
 			atomic_read(&nn->nr_reclaim_complete) ==
@@ -7635,7 +7635,7 @@ static int nfs4_state_create_net(struct net *net)
 		INIT_LIST_HEAD(&nn->sessionid_hashtbl[i]);
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
-	nn->boot_time = get_seconds();
+	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
-- 
2.20.0

