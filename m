Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C59BAF811B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfKKUWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:22:31 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:45651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfKKUWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:22:00 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N5mSj-1hoaiJ1FJj-017Gmq; Mon, 11 Nov 2019 21:16:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/19] nfs: remove timespec from xdr_encode_nfstime
Date:   Mon, 11 Nov 2019 21:16:26 +0100
Message-Id: <20191111201639.2240623-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ulASBF1+CypKgZmdr6vqqtC9sCzj5wAM7ZBT75ycuyRcFZxDp04
 /y7j6iTDtCT5FVA0XpdkisAIwMRr+P6BqY97mKbHKceiGRMlZOUT5cmroSnuPqoyMBgmxvr
 +S8shOyk/fEUiXb+v721FKElnQXwtuPK++YwwtdoGuyKpOEsQ2Mnczt75989eM7HtLCsYXp
 GlC1a//CTD/vBd63J7thg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dpvDW4n6B/4=:YETI2cfdvFQ4xu3uLthOma
 RBzBrLw2HtpGAfMpjBV8DcKbFcyfkSImvkN77jooiPBUaLNmSu62YWqg8i1tkI1jITJ4nWf7w
 t+1Y6saqriu7gQ8OHyKfO4tO8xRcpZaT7EOazvPEF0KdCEMBp5fXbf5/dAiHJj84nDmWaQxHQ
 S2zoGTVGLFO1G8E+aUxX2Jy7splEvJZcTCjD8Kmwghrn6fflZKsBDJaoFjDbV/SlfbhtPI0+z
 FfwFssNeXXfyO7nLcY4OY6eVkcncTbXywqPY4R2DqtoNiMpZvDrNF2I63W8AjPERp5SY+o8vU
 8n871FVoO2fFmbvk95wynoxqeoC6HvYd+fRGlaW11Er/x/4YJxofySBc5OygYufW0CtTzx0tH
 GWdaZc7O94Q+E572DdFA4euZzVw2IB3NqtHBD+Il2NWyqNK2GWIO9euDaeXV73F/21GU9SQWP
 JtZlYEDFppWs+A43vX9atqBsMElGDamJ3StMz8w2SCRWlxXuBM75eCxUaAiU+lqIRqLRwvKRy
 hBCw6oKwjGanafA/KSugVm7JWps4izDpCn60e4GRyhxrpEaUYlipua2URgr82rzQMrh5mrOY2
 H5GxzrycciatLyQP3CxqcrFXwPqPlgS0xhJD0kzzeVT6G2BhELbXqykAHQiWqQgulzD3HK8Hp
 xDfsfJt5ozqdYRm+DjAsMajLQLSK/RY7cUd3WB84XQk97FEUZyExG31li9loFBo84qR3CDYPs
 iTlF5KTi2f4hovimeexveq/1m3Qm+AGp+OPFP7yKBshksBWmWgG1RUmJGiJbnUw7uEtSF0xLJ
 Kiv27Q7b5guyXjhw3/fvvwEaQHObozSLWNdVOuazmN2lAct+Y7aoqaXFsh8MkMb064Z4vTOo/
 gvp7vjUPeOGqms10vsZA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For NFSv2 and NFSv3, timestamps are stored using 32-bit entities
and overflow in y2038. For historic reasons we truncate the
64-bit timestamps by converting from a timespec64 to a timespec
first.

Remove this unnecessary conversion step and do the truncation
in the final functions that take a timestamp.

This is transparent to users, but avoids one of the last uses
of 'timespec' and lets us remove it later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfs/nfs2xdr.c        | 31 +++++++++++++------------------
 fs/nfs/nfs3xdr.c        | 12 ++++--------
 include/linux/nfs_xdr.h |  2 +-
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index d4e144712034..0b8399fee8f7 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -209,9 +209,9 @@ static int decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
  *		unsigned int useconds;
  *	};
  */
-static __be32 *xdr_encode_time(__be32 *p, const struct timespec *timep)
+static __be32 *xdr_encode_time(__be32 *p, const struct timespec64 *timep)
 {
-	*p++ = cpu_to_be32(timep->tv_sec);
+	*p++ = cpu_to_be32((u32)timep->tv_sec);
 	if (timep->tv_nsec != 0)
 		*p++ = cpu_to_be32(timep->tv_nsec / NSEC_PER_USEC);
 	else
@@ -227,7 +227,7 @@ static __be32 *xdr_encode_time(__be32 *p, const struct timespec *timep)
  * Illustrated" by Brent Callaghan, Addison-Wesley, ISBN 0-201-32750-5.
  */
 static __be32 *xdr_encode_current_server_time(__be32 *p,
-					      const struct timespec *timep)
+					      const struct timespec64 *timep)
 {
 	*p++ = cpu_to_be32(timep->tv_sec);
 	*p++ = cpu_to_be32(1000000);
@@ -339,7 +339,6 @@ static __be32 *xdr_time_not_set(__be32 *p)
 static void encode_sattr(struct xdr_stream *xdr, const struct iattr *attr,
 		struct user_namespace *userns)
 {
-	struct timespec ts;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS_sattr_sz << 2);
@@ -361,21 +360,17 @@ static void encode_sattr(struct xdr_stream *xdr, const struct iattr *attr,
 	else
 		*p++ = cpu_to_be32(NFS2_SATTR_NOT_SET);
 
-	if (attr->ia_valid & ATTR_ATIME_SET) {
-		ts = timespec64_to_timespec(attr->ia_atime);
-		p = xdr_encode_time(p, &ts);
-	} else if (attr->ia_valid & ATTR_ATIME) {
-		ts = timespec64_to_timespec(attr->ia_atime);
-		p = xdr_encode_current_server_time(p, &ts);
-	} else
+	if (attr->ia_valid & ATTR_ATIME_SET)
+		p = xdr_encode_time(p, &attr->ia_atime);
+	else if (attr->ia_valid & ATTR_ATIME)
+		p = xdr_encode_current_server_time(p, &attr->ia_atime);
+	else
 		p = xdr_time_not_set(p);
-	if (attr->ia_valid & ATTR_MTIME_SET) {
-		ts = timespec64_to_timespec(attr->ia_atime);
-		xdr_encode_time(p, &ts);
-	} else if (attr->ia_valid & ATTR_MTIME) {
-		ts = timespec64_to_timespec(attr->ia_mtime);
-		xdr_encode_current_server_time(p, &ts);
-	} else
+	if (attr->ia_valid & ATTR_MTIME_SET)
+		xdr_encode_time(p, &attr->ia_atime);
+	else if (attr->ia_valid & ATTR_MTIME)
+		xdr_encode_current_server_time(p, &attr->ia_mtime);
+	else
 		xdr_time_not_set(p);
 }
 
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 2a16bbda3937..927eb680f161 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -456,9 +456,9 @@ static void zero_nfs_fh3(struct nfs_fh *fh)
  *		uint32	nseconds;
  *	};
  */
-static __be32 *xdr_encode_nfstime3(__be32 *p, const struct timespec *timep)
+static __be32 *xdr_encode_nfstime3(__be32 *p, const struct timespec64 *timep)
 {
-	*p++ = cpu_to_be32(timep->tv_sec);
+	*p++ = cpu_to_be32((u32)timep->tv_sec);
 	*p++ = cpu_to_be32(timep->tv_nsec);
 	return p;
 }
@@ -533,7 +533,6 @@ static __be32 *xdr_decode_nfstime3(__be32 *p, struct timespec64 *timep)
 static void encode_sattr3(struct xdr_stream *xdr, const struct iattr *attr,
 		struct user_namespace *userns)
 {
-	struct timespec ts;
 	u32 nbytes;
 	__be32 *p;
 
@@ -583,10 +582,8 @@ static void encode_sattr3(struct xdr_stream *xdr, const struct iattr *attr,
 		*p++ = xdr_zero;
 
 	if (attr->ia_valid & ATTR_ATIME_SET) {
-		struct timespec ts;
 		*p++ = xdr_two;
-		ts = timespec64_to_timespec(attr->ia_atime);
-		p = xdr_encode_nfstime3(p, &ts);
+		p = xdr_encode_nfstime3(p, &attr->ia_atime);
 	} else if (attr->ia_valid & ATTR_ATIME) {
 		*p++ = xdr_one;
 	} else
@@ -594,8 +591,7 @@ static void encode_sattr3(struct xdr_stream *xdr, const struct iattr *attr,
 
 	if (attr->ia_valid & ATTR_MTIME_SET) {
 		*p++ = xdr_two;
-		ts = timespec64_to_timespec(attr->ia_mtime);
-		xdr_encode_nfstime3(p, &ts);
+		xdr_encode_nfstime3(p, &attr->ia_mtime);
 	} else if (attr->ia_valid & ATTR_MTIME) {
 		*p = xdr_one;
 	} else
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index db5c01001937..22bc6613474e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -869,7 +869,7 @@ struct nfs3_sattrargs {
 	struct nfs_fh *		fh;
 	struct iattr *		sattr;
 	unsigned int		guard;
-	struct timespec		guardtime;
+	struct timespec64	guardtime;
 };
 
 struct nfs3_diropargs {
-- 
2.20.0

