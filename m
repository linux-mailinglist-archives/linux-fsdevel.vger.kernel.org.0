Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A29F80F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKKURD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:03 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:46059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfKKURD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLi0U-1iCajy2JKi-00HggB; Mon, 11 Nov 2019 21:16:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/19] nfsd: pass a 64-bit guardtime to nfsd_setattr()
Date:   Mon, 11 Nov 2019 21:16:33 +0100
Message-Id: <20191111201639.2240623-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kLySL1mN/IbrXNjESYmaI6C+j074UjXObT3NY8Zh8ekkuS+uGiG
 Kj8dvAktcB3tOiZo3og8i056LSHUdn0D7km2lUWgZIbBftxuoem47Z+BdkW/wHX2D6zpO98
 youZi5pEJlJpXniJjrlfuCqmhm4l9u20ZN3aKE6hpoF13SwsDvkB1/hsa6WrYAdWhmxFzeM
 4f8NrugPR+cKJd/cvcVVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PceNcs0aF4Q=:xgF0+4N3RzcxQHQGv6CGQ+
 SPx11DLoRJ/NQ+jeEo68iyeTHz7RBI4rYODKJWvqJYXMKI2aMsBbbpht+jKiEnDXwV+o6kkSy
 eFwXUT5vSCJaxsWCZdrdW3+8B7y/KgZkGdl0LIXfuTLl1TnZgB6Ye9KOW730jDWPcM0KU3U6Z
 z0j9MdnrnGZCVtqEW0V6wHhazGRNjIvZ1h8pmoV3/+4Ip/wm0bBjFXGlU1tga1O+QCFmFRgJp
 xSHqNx1XrJ8zRvzDArnk+t1343QntBwxX6XTbHVgYtziom20hh6Co+mn/6QHp5q2xZxACI1XF
 QD2LYsL1Y9l+y01gWk7UaCCiqiXb+k9zDtRitcJXJ7gmD+unyCxXtT3YM5w/rvPC+JYBtJBpX
 zSgWYZ1OJa6TYwprQOLU5Qo6v33yYqJ6yPySYkEbuCPjHAI4Of92khqSmtkGIiVu9ePVjOKWZ
 9iFBBtqFc8Y4X5Oh2/DV+V2DUQzLTrzNYWYTgOZ3YkV0er8UcoBNs5g6u7gnzHpBDdJDBddw1
 UyM471VCUdTtrScbJ/H+sOjXYCQ7Z3+tnzkGcWDNZK7GhrBy1pWhxO9gC5JzlYOQ9oLB1/hjS
 Mqa4YYTXfEsUhwxE+Ls+D+ZD0ArkQhPLeACjqaiBrTXqVWgtASu6ix5Z52OG71g01HDmoEsLW
 46tsLMM8sTxFcdaIh6PIX8kvNAniNhdW/ks3UVgjrzB3pa1DUsCVZJbapgEk2h3sL28CfqYNF
 tZMPFLF2gF3yDOthI5wg29rruQy6lDRnNh6YO6rgSvcmb/+ud/4fat4v0efS1DmHaJts+gN9F
 37aPm0iR4wwkH74mfZOkcZzSq9bM+jQ9KERB2DRbEUPjtRENqLCvwWbCC0jBERFxqdbiN3S0R
 b3gF5nLUJcQ5Yu2vDLqQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Guardtime handling in nfs3 differs between 32-bit and 64-bit
architectures, and uses the deprecated time_t type.

Change it to using time64_t, which behaves the same way on
64-bit and 32-bit architectures, treating the number as an
unsigned 32-bit entity with a range of year 1970 to 2106
consistently, and avoiding the y2038 overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4proc.c  | 2 +-
 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/nfsproc.c   | 4 ++--
 fs/nfsd/vfs.c       | 4 ++--
 fs/nfsd/vfs.h       | 2 +-
 fs/nfsd/xdr3.h      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4e3e77b76411..b595f6d6d0d9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -975,7 +975,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
-				0, (time_t)0);
+				0, (time64_t)0);
 out:
 	fh_drop_write(&cstate->current_fh);
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 70a953b03be4..1ea7a40f8d4e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4666,7 +4666,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-	return nfsd_setattr(rqstp, fh, &iattr, 0, (time_t)0);
+	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
 }
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index c83ddac22f38..aa013b736073 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -113,7 +113,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	nfserr = nfsd_setattr(rqstp, fhp, iap, 0, (time_t)0);
+	nfserr = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
 done:
 	return nfsd_return_attrs(nfserr, resp);
 }
@@ -380,7 +380,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			nfserr = nfsd_setattr(rqstp, newfhp, attr, 0, (time_t)0);
+			nfserr = nfsd_setattr(rqstp, newfhp, attr, 0, (time64_t)0);
 	}
 
 out_unlock:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bd0a385df3fc..c0d8fdfd3b90 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -358,7 +358,7 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
-	     int check_guard, time_t guardtime)
+	     int check_guard, time64_t guardtime)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
@@ -1117,7 +1117,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *resfhp,
 	if (!uid_eq(current_fsuid(), GLOBAL_ROOT_UID))
 		iap->ia_valid &= ~(ATTR_UID|ATTR_GID);
 	if (iap->ia_valid)
-		return nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
+		return nfsd_setattr(rqstp, resfhp, iap, 0, (time64_t)0);
 	/* Callers expect file metadata to be committed here */
 	return nfserrno(commit_metadata(resfhp));
 }
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index a13fd9d7e1f5..07e612b90757 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -48,7 +48,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int,
 				struct svc_export **, struct dentry **);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
-				struct iattr *, int, time_t);
+				struct iattr *, int, time64_t);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);
 #ifdef CONFIG_NFSD_V4
 __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 99ff9f403ff1..0fa12988fb6a 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -14,7 +14,7 @@ struct nfsd3_sattrargs {
 	struct svc_fh		fh;
 	struct iattr		attrs;
 	int			check_guard;
-	time_t			guardtime;
+	time64_t		guardtime;
 };
 
 struct nfsd3_diropargs {
-- 
2.20.0

