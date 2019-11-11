Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFAFF80ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKKURR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:17 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfKKURK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:10 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mate1-1ht0Yh12Ed-00cNxc; Mon, 11 Nov 2019 21:16:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 18/19] nfsd: use ktime_get_real_seconds() in nfs4_verifier
Date:   Mon, 11 Nov 2019 21:16:38 +0100
Message-Id: <20191111201639.2240623-19-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3MZ/g5jxoKowkWLqlAfuJN7w4g+Y5UGMW9ve+71EABUtr76lYR3
 6Aay31QafEpf1haodQTU7BXFpmYpzicHHH9yi4z7JPgP9ViZds/DpxNh5frARpPdRQqm+0R
 uktE0QcKl8CDcOeJWR27whgguX5Bw1UmVC4KfMw63AZdZMR9XkwlMcxMafA6QE28cAdQ32o
 s8VXRovcg4h4RrRCsiSxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z0WOA+1LHJI=:5SchLrpliskcZbSi2buxVb
 lagvOeB0sNZIRBE0oR0YRFXsSzh+M15xiFTdplHM7hJNqWffA4CiwxDahtpYjI1Cu4zvwJBh5
 s3TEaHVY8I0BOC/LrzvFmOBR0AkQbYWT+VQmCzPHE4f2cx6ZmZwEwl2SpPpoW7W+qdA802jPA
 xBgX3qoLC5ORVM4cV4AIvbH0uxobO/xbris+BxQYjLtsIKucEfo628TurEeKTXc8Aw3SPq5I7
 5aGa0C9ZP/oVAixGYOD1tk6Rrjy5ACuaYCvoXm08x6k9u6BvtiSXyAv0DAWyDwATt+eDXFdAF
 kWhvy0HOdxsKY592R5ZOgf1qMgW2PXrfRlI0PKEM5rO5tLpuP2Ibtst7IqJJOSuXgDUftc7+N
 R7Rpl5LjZaMdj7p1ZLK4NtzLLqbfPAmdD2O5tul8BvSI5JMtqu3JxCjEirGYPKrKj/8nJ3mqd
 LuNMzhM8gMIN2VFYXZBVGkXUabcolx3XriQh9GrTBoqCqR+8YF0Le0L5sj32DkUyDKCEYUSPL
 R8V2kJoq0UDrY3rAKCckZ+3DwpIEw9IEeCTTfdVcDXcWxRYs96aX/aivEzlBSA11M68ieMoOg
 U4kQtBQfHaBb1tpafDDBD5Ci3Xgqy9eK05C6Amr6689o+2WNdmGDZdXJW9HOGcD2x9xe2FSoD
 LTaRkXo1Q7b8498ijT6YhTvWh9rDBLFYCvK4UqBhGPLZBVhy0gLKaRjHKeAbqoLDGWM80r5So
 8ljr6kfb6W8AS9FMXTQ/2vcLpn5vVqeztV/Jab1Xo0DSbZTR5zFV3p+w0w/ljKXhKxFGCA/c6
 /p2f5wL7A0IxlZhHS8JUTCkqnJcjqqfef7ybbRnkloDRAHNcmSIudCh1NLRqs0cz+KVXf41NS
 IHAZvSYCDqlyofiEiSNQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

gen_confirm() generates a unique identifier based on the current
time. This overflows in year 2038, but that is harmless since it
generally does not lead to duplicates, as long as the time has
been initialized by a real-time clock or NTP.

Using ktime_get_boottime_seconds() or ktime_get_seconds() would
avoid the overflow, but it would be more likely to result in
non-unique numbers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 885a09b3a2c0..cb416b9f6536 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2215,7 +2215,7 @@ static void gen_confirm(struct nfs4_client *clp, struct nfsd_net *nn)
 	 * This is opaque to client, so no need to byte-swap. Use
 	 * __force to keep sparse happy
 	 */
-	verf[0] = (__force __be32)get_seconds();
+	verf[0] = (__force __be32)(u32)ktime_get_real_seconds();
 	verf[1] = (__force __be32)nn->clverifier_counter++;
 	memcpy(clp->cl_confirm.data, verf, sizeof(clp->cl_confirm.data));
 }
-- 
2.20.0

