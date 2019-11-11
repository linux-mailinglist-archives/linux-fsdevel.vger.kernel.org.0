Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4CF8116
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKKUWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:22:24 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:42093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfKKUWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:22:01 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MWRe1-1iNvX02Mbz-00Xvy8; Mon, 11 Nov 2019 21:16:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/19] nfsd: handle nfs3 timestamps as unsigned
Date:   Mon, 11 Nov 2019 21:16:30 +0100
Message-Id: <20191111201639.2240623-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rPopYro8ot3vLlYHqs08jMA1iOzd8VcnAKyD2rY2jki6oPrgMuC
 NMGPjcrqJPo4F7Hv4mWpkXL7P7rZ0uqLZqthPPFHrqkaJCPF4kUxwpgsd0Q90ggeVevdXQ0
 Qu4IxpZiHxBnIELSSTw4S9YFddZrgmJte3CIth/TX06xSZuEZvB80mQTjUBfIQHX+bIH0b4
 FmP6G4mdZrSkaB2LDS/Fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eh3FrkVqo3Y=:1LVmj81qB3Y4wqPvxpklk1
 L/pfT10ZZt30XKSVX63ABfJ99hxhIrRa/nBLh/2yvzZBOuQPzLBsY4uRVZ5/KkPOOj3sgVpgW
 ReVeLk1YeDguLJIZLf1HTds0zbIqLz4a7Lqq6PgNKZlymipsDS6TNRAtqtqdiAwM8j/4BDaO4
 qLitjwO1/pnuY2qY21fwSvkEQAiBQen1bSfCeM8nDhK0R0XAogya6RrCzf0L+VfhUcoPT5f6+
 jI2gPjVDKDcDGex1Hq2xlIEtQDiIew1+mcbw938FihpHfB5w0ZAUvHSZ/WDcz8RZeKwmWxGWi
 W19Ai7s47/FRuwTzwaBwpmS9p01jNRSOt0a+Y4idT+HFi2jEHOT+GZyqefAlwxIFk5uSP8SAN
 VUw9/mMmFTub4ijxyxt5Xf8Cg3T+ESfC+FrA1ME79guspX4TwnfbzJvWGH1hfbw84nc3Ao00K
 Hq97kdktbmiLmJFj+01RcEWRgVmyC/FXJRLmR4He6gymExyQM4f4Z5EBGYuZROt85gSnfrklz
 Yj8gH6bc9uYnI+KRvv+R7K83zuQm6Xy3S47ihJR+LjJi+eJMiVeoOMkHHR5aSqPwFFnrJHo1e
 tYrTDGgpW6PzfdZgrPEb1EZqM10yNixAZJrBoQen25mTbFIEqkWHJVXKS3XO/KHik36/dbUeG
 T9Zz832RLTeNft4G3v8uhi0s2Fk+zKKmx+yRZnjKec4B7YobktNLiU+mqStfLXvrUqbGdOZgr
 PFrjdwqU/B2Z9vA77eOzpdARrHb3FlkgtruZTKWqRBAt3EJG22H8uCgeFE4m1HvyxIlX+S7yd
 fYkndMsUQJASnkzX03cGns6BHc9Zzr9ZVr7YJtptAmMQw6TU6ivKkR1SyXyHZUubu05VaYW7b
 ERkM881HLqzHq4S9EZ7Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The decode_time3 function behaves differently on 32-bit
and 64-bit architectures: on the former, a 32-bit timestamp
gets converted into an signed number and then into a timestamp
between 1902 and 2038, while on the latter it is interpreted
as unsigned in the range 1970-2106.

Change all the remaining 'timespec' in nfsd to 'timespec64'
to make the behavior the same, and use the current interpretation
of the dominant 64-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs3xdr.c | 20 ++++++++------------
 fs/nfsd/nfsfh.h   |  4 ++--
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 86e5658651f1..0ace5ae0775c 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -32,14 +32,14 @@ static u32	nfs3_ftypes[] = {
  * XDR functions for basic NFS types
  */
 static __be32 *
-encode_time3(__be32 *p, struct timespec *time)
+encode_time3(__be32 *p, struct timespec64 *time)
 {
 	*p++ = htonl((u32) time->tv_sec); *p++ = htonl(time->tv_nsec);
 	return p;
 }
 
 static __be32 *
-decode_time3(__be32 *p, struct timespec *time)
+decode_time3(__be32 *p, struct timespec64 *time)
 {
 	time->tv_sec = ntohl(*p++);
 	time->tv_nsec = ntohl(*p++);
@@ -167,7 +167,6 @@ encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	      struct kstat *stat)
 {
 	struct user_namespace *userns = nfsd_user_namespace(rqstp);
-	struct timespec ts;
 	*p++ = htonl(nfs3_ftypes[(stat->mode & S_IFMT) >> 12]);
 	*p++ = htonl((u32) (stat->mode & S_IALLUGO));
 	*p++ = htonl((u32) stat->nlink);
@@ -183,12 +182,9 @@ encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	*p++ = htonl((u32) MINOR(stat->rdev));
 	p = encode_fsid(p, fhp);
 	p = xdr_encode_hyper(p, stat->ino);
-	ts = timespec64_to_timespec(stat->atime);
-	p = encode_time3(p, &ts);
-	ts = timespec64_to_timespec(stat->mtime);
-	p = encode_time3(p, &ts);
-	ts = timespec64_to_timespec(stat->ctime);
-	p = encode_time3(p, &ts);
+	p = encode_time3(p, &stat->atime);
+	p = encode_time3(p, &stat->mtime);
+	p = encode_time3(p, &stat->ctime);
 
 	return p;
 }
@@ -277,8 +273,8 @@ void fill_pre_wcc(struct svc_fh *fhp)
 		stat.size  = inode->i_size;
 	}
 
-	fhp->fh_pre_mtime = timespec64_to_timespec(stat.mtime);
-	fhp->fh_pre_ctime = timespec64_to_timespec(stat.ctime);
+	fhp->fh_pre_mtime = stat.mtime;
+	fhp->fh_pre_ctime = stat.ctime;
 	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 	fhp->fh_pre_saved = true;
@@ -330,7 +326,7 @@ nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
 
 	if ((args->check_guard = ntohl(*p++)) != 0) { 
-		struct timespec time; 
+		struct timespec64 time;
 		p = decode_time3(p, &time);
 		args->guardtime = time.tv_sec;
 	}
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 755e256a9103..495540a248a1 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -42,8 +42,8 @@ typedef struct svc_fh {
 
 	/* Pre-op attributes saved during fh_lock */
 	__u64			fh_pre_size;	/* size before operation */
-	struct timespec		fh_pre_mtime;	/* mtime before oper */
-	struct timespec		fh_pre_ctime;	/* ctime before oper */
+	struct timespec64	fh_pre_mtime;	/* mtime before oper */
+	struct timespec64	fh_pre_ctime;	/* ctime before oper */
 	/*
 	 * pre-op nfsv4 change attr: note must check IS_I_VERSION(inode)
 	 *  to find out if it is valid.
-- 
2.20.0

