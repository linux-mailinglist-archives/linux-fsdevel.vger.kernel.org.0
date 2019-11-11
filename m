Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF903F811D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKKUWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:22:32 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:39699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKKUV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:21:59 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MtfVx-1hcRe32Xgl-00v9pY; Mon, 11 Nov 2019 21:16:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/19] nfs: encode nfsv4 timestamps as 64-bit
Date:   Mon, 11 Nov 2019 21:16:27 +0100
Message-Id: <20191111201639.2240623-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dtnG94xvD5MjjNlVyWDb5eaSykSgG9mq8dv6e4ANjmnmD4CH84d
 +nhvBnRu5porjpw0HIFP8ug4gFRLEyIZPisAIuOq9ZMj/rNA+1OYaj1HYy7+4eGlc6Pf9qI
 1kNf+O/muQQjPnMZzNDYlMHN4bLVVU2nz/bFzylh1TfhzZyPwf7V+nbOAGjRQj5xXDRrYb+
 Sx4obN97lC+jV8jSmnboQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xb2NUiu3Utc=:xVTipUWlDL+FBIPGUFolAo
 seAacejDCYMT+ZhqgGDEceUE+W57sAZZKPKMykwNARU24vZY8ZC1FsBv4cUi2Is3n8hux0ixs
 odeh1g2FdZbV8pGZdolOF4J0Ca4eDb4gvuqYO7MMVue9dUEYhfQLvcPJohRnhjTKr5r7i7it4
 vpY/saUXnzQpJ8TuILGyE7W3f5JAJQyRAdHErgEys3Ukje4EDUiZcf4Cip1dL6LOP1n/zXSQn
 c3xMNghoxiBhrl4lxLsBYc8019hvCyciYZhNT4QtBP1ZqrKyIl17sVLTA4NO/FzX7j9r50w6n
 8lZvs0ZzOt6kLgyCvKHo1LcHQcxVZ7p+gKg0hcTe960/9Bza+2IPYXdscB0KhSFsJ1JKXShMN
 +n4TPoC7t2+PVUhuI0+FcKHFLGkfoRLUWqZeaSQNceNCgANuQnaTUyAgE2aGJmEJXfGY4NgBM
 rI7ovIAan2TYM0eVPUmdrR/D3g4f1GBZU2LFx8LD2hcyGkYHYJyZLyd3/fFNDEqQdZslDZXRO
 Mj+Vw7jyuGyCWb5SmAWj+w3iVwLdsJB1Mk07JhwHa/3E7MXMh24XHSuBXEY34xXv4gat6oPP9
 QVK4Dk791/MfJX+ibE5RC13IOu15KCd2qd1vEuVrXJUcGUSjworyO8OFTJR7asIJj3mRksWAF
 AQgnbJkm0BeAACUg5/Tkn6db2IS4iWmMax4LqJJ4VIV7Vxgo4USdfFcYSd46Ym3lzhXhewFiW
 W7kxgSPPzKkH67nFMnnlhkhMgyW9c89M5VK/zDzJrS8e9PloSSGfbKUJC0tl0su9pi5AT463L
 N8nz6E+JwS1f9nT9SgPx7wZK2YuGgpriSe9fLj69YZq4f2yL3Xs5H2ltYZfHBK1k2wkwdkXCl
 UTwMF3mE7po1hOkWbAdA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 32-bit architectures, xdr_encode_nfstime4() needlessly
truncates timestamps to a 32-bit value in the range between
year 1902 and 2038.

Change it to use 'struct timespec64' to allow the entire range
of values supported by the server.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfs/nfs4xdr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c917fb24c56f..a5737f0bac4d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1059,9 +1059,9 @@ static void encode_nfs4_verifier(struct xdr_stream *xdr, const nfs4_verifier *ve
 }
 
 static __be32 *
-xdr_encode_nfstime4(__be32 *p, const struct timespec *t)
+xdr_encode_nfstime4(__be32 *p, const struct timespec64 *t)
 {
-	p = xdr_encode_hyper(p, (__s64)t->tv_sec);
+	p = xdr_encode_hyper(p, t->tv_sec);
 	*p++ = cpu_to_be32(t->tv_nsec);
 	return p;
 }
@@ -1072,7 +1072,6 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 				const struct nfs_server *server,
 				const uint32_t attrmask[])
 {
-	struct timespec ts;
 	char owner_name[IDMAP_NAMESZ];
 	char owner_group[IDMAP_NAMESZ];
 	int owner_namelen = 0;
@@ -1161,16 +1160,14 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
 		if (iap->ia_valid & ATTR_ATIME_SET) {
 			*p++ = cpu_to_be32(NFS4_SET_TO_CLIENT_TIME);
-			ts = timespec64_to_timespec(iap->ia_atime);
-			p = xdr_encode_nfstime4(p, &ts);
+			p = xdr_encode_nfstime4(p, &iap->ia_atime);
 		} else
 			*p++ = cpu_to_be32(NFS4_SET_TO_SERVER_TIME);
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
 		if (iap->ia_valid & ATTR_MTIME_SET) {
 			*p++ = cpu_to_be32(NFS4_SET_TO_CLIENT_TIME);
-			ts = timespec64_to_timespec(iap->ia_mtime);
-			p = xdr_encode_nfstime4(p, &ts);
+			p = xdr_encode_nfstime4(p, &iap->ia_mtime);
 		} else
 			*p++ = cpu_to_be32(NFS4_SET_TO_SERVER_TIME);
 	}
-- 
2.20.0

