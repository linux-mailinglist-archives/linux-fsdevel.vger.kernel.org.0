Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A92F8119
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKKUWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:22:00 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:34829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfKKUWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:22:00 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mw9Hm-1heMNx137E-00s7xT; Mon, 11 Nov 2019 21:16:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 09/19] nfsd: print 64-bit timestamps in client_info_show
Date:   Mon, 11 Nov 2019 21:16:29 +0100
Message-Id: <20191111201639.2240623-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:seMJ42v1081bEPvwevwNuzbDoR7i4rBfE32rXv/gDtp4js7XnsP
 3mzBJKVOUnKQzd/TGe/g65oEGys9jaUxG0wIzDBcSa+JTTscwYceqlTvZUCW+8c4PrwGNvV
 CdeUvJniXZuKdka9Ghw1sJqdwNPM9MM6rEo3zek+pKcuyxqshdiOXcVNYhowEWAWp7ReExJ
 BJBq5/czH5wa1umRKjtQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K1X4+M5ldbg=:eF0eHB+aTr06giF3z8cGgN
 84/NB54bm3WbUg9w+tbttFcqp+6u0p859BIRQYodo/PbBtjm0ALNVgTft7nIEcmQnSpVvl2Oa
 urm78C7A5dVRl2ykLyxoFaKSwmG7vYFiHeioxVIFwZpduF830CAC9ddzCzClpLCP9H+b7KUoN
 9BR3HTN2ddA5hPwcuzU1fTNgU0zI0RNtEP+VKaplIrh6o6PC1A8qm0qIpQqoM8gj56/qz4zeW
 DhhG0fiSpc47p4ca3LOjRI85/OjvA+VuRcR+4IxAHzxo90TuTG/QpGhgi80uhQDOaU8GChksw
 J1+KbaIQOw4JbA6GuhKtwJEcD6Xve9dcUcPyBfhvTPNwuxyay0Oyd+fS7K82oBhzR0J93uX9W
 H3ZjGuFA6VsnCPOeHRfCQ2JEou/IMvZeQUWeIP1VKASfYm/pylNTzxZwv2IobYj7jx1R33v0C
 wApZ3sF4ub3LhOD9i1LNq6RzdUwWryOkXLUFKUgL6zflcBNLTq4kkHcRUfZU+qQm1JyeJ/Lh5
 Ouf0LvGvtZh0xwCSrBcMwPeXaBS2uJGMjk6H68HiC+nQrRVP51AhOj8fY/EIwcwhV1HZIfnhF
 J6pz3Eb9StxeSOYUgKHBHuSmi4wjFkI5sTqLe5m0dAKrsrlgkGcffD0LLXkZs4+ZRxWWf3ZgW
 eY+yZ0K8rGTFp4sMdHxns6YG1G+cYk+sQR37/sbotvq6Y9JfbA2ZOwQ7p9BBIwnYjtemIlmbD
 9FfP2pk2Ml+HEY4IUzGGE9izUggir7KspodBvNZWol1V1Z8Iwo+aai9TGojjaCIZxvaFlxrUp
 /m7adYvW9mQS8xbITdpN+cH38UFRMQK2O644oT4upRfXcRM8r4FR5DA4uJK6Nh5EwekCwg22J
 zSUwzSRZPyzeVhMzJdQQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nii_time field gets truncated to 'time_t' on 32-bit architectures
before printing.

Remove the use of 'struct timespec' to product the correct output
beyond 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 5 ++---
 fs/nfsd/state.h     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20795b5053c..2333924d7c6b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2292,7 +2292,7 @@ static int client_info_show(struct seq_file *m, void *v)
 					clp->cl_nii_domain.len);
 		seq_printf(m, "\nImplementation name: ");
 		seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
-		seq_printf(m, "\nImplementation time: [%ld, %ld]\n",
+		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
 	}
 	drop_client(clp);
@@ -2946,8 +2946,7 @@ static __be32 copy_impl_id(struct nfs4_client *clp,
 	xdr_netobj_dup(&clp->cl_nii_name, &exid->nii_name, GFP_KERNEL);
 	if (!clp->cl_nii_name.data)
 		return nfserr_jukebox;
-	clp->cl_nii_time.tv_sec = exid->nii_time.tv_sec;
-	clp->cl_nii_time.tv_nsec = exid->nii_time.tv_nsec;
+	clp->cl_nii_time = exid->nii_time;
 	return 0;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 46f56afb6cb8..ce32ba445343 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -320,7 +320,7 @@ struct nfs4_client {
 	/* NFSv4.1 client implementation id: */
 	struct xdr_netobj	cl_nii_domain;
 	struct xdr_netobj	cl_nii_name;
-	struct timespec		cl_nii_time;
+	struct timespec64	cl_nii_time;
 
 	/* for v4.0 and v4.1 callbacks: */
 	struct nfs4_cb_conn	cl_cb_conn;
-- 
2.20.0

