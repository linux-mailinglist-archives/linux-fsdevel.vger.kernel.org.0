Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FC5B000
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF3NzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44415 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfF3NzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:04 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so22645602iob.11;
        Sun, 30 Jun 2019 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IlfP8wgIAy/S8RrlxOcQUqBNIUiwkl2Oc8GFr16RCE=;
        b=dQ7ptkl0GqrFBJE+51485L7NWqgiD2Rv23SqQ/a66LaB54KmZOOAOsO4ceMyJLPLHw
         SLqY/HiyRuPN6n7s8v7X71igWQz5ZIP05Ws4LEUmssJGGnZ+SBFE3oKx/JbUU9o6uLRV
         1QznlqGWxg+HUg50kKRAA+5aATpKWNPkxl7JYFRbrO6oziaPLbaWjxe2nLilxYF6RYdV
         IAaFe0RpLYEIvsHhCtK4Xx11xJU3L89QDduaDNGOhEIVkNleL0Hw/VhkC+dLuaUeVrz4
         IIbbk2n4ZIP+pnmOZ5M99nKxEZTlGvRSVfHGFFWzNTBbJBk3OmsRgVskN+e+wUPlZcVK
         Hegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IlfP8wgIAy/S8RrlxOcQUqBNIUiwkl2Oc8GFr16RCE=;
        b=dVLLYodM3/DfRlmjIckM/KQZ9bUMSYWIZjiSTQfIwwTR9nxk4aQay9UuqDBvGY5AX9
         a0+6HyUR7ix54wg7viHd70uBaZT7mrFGXFF0go6uhzhqKxl3Dt8CF5ADF+9HuNgp0l1m
         ijoxZ94xSSeQjSQm2pzQ7MwmL73wR4RU464uZYjxtldnboNsv0SkY2xkJ7/pzBQllzB3
         FMSlmnoeYf/D+Ltf3DJD9+V+5VEbnLv92Ml4TLaQtpRsOG6YbZFhgRO6Ma7cD/ht7GNV
         52NSPWOR9m0m07HWhtiZfDGOgpx9WgRgQ9S55DjpR2Iq+KX+Emb56ZGaftEck57t+bcY
         Bn0Q==
X-Gm-Message-State: APjAAAUSdlKhNVyfs+P4U3LvfdUij9Y3aEcOYl2oZZ4Of4nfQk2Q824f
        JSudkafaVM37G95Rrka/BA==
X-Google-Smtp-Source: APXvYqxs+HTdM7XQrKdxv2p2gi+MNfSEBkSeNN6JZHPOhejA3oW0WDAXKUVJBC57EBOv71gdtMtlOQ==
X-Received: by 2002:a02:bb83:: with SMTP id g3mr22709945jan.139.1561902902829;
        Sun, 30 Jun 2019 06:55:02 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:02 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/16] nfsd: convert nfs4_file->fi_fds array to use nfsd_files
Date:   Sun, 30 Jun 2019 09:52:33 -0400
Message-Id: <20190630135240.7490-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-9-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
 <20190630135240.7490-7-trond.myklebust@hammerspace.com>
 <20190630135240.7490-8-trond.myklebust@hammerspace.com>
 <20190630135240.7490-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4state.c | 23 ++++++++++++-----------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 618e66078ee5..394438e6a72f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -49,6 +49,7 @@
 
 #include "netns.h"
 #include "pnfs.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
@@ -421,7 +422,7 @@ static struct file *
 __nfs4_get_fd(struct nfs4_file *f, int oflag)
 {
 	if (f->fi_fds[oflag])
-		return get_file(f->fi_fds[oflag]);
+		return get_file(f->fi_fds[oflag]->nf_file);
 	return NULL;
 }
 
@@ -578,17 +579,17 @@ static void __nfs4_file_put_access(struct nfs4_file *fp, int oflag)
 	might_lock(&fp->fi_lock);
 
 	if (atomic_dec_and_lock(&fp->fi_access[oflag], &fp->fi_lock)) {
-		struct file *f1 = NULL;
-		struct file *f2 = NULL;
+		struct nfsd_file *f1 = NULL;
+		struct nfsd_file *f2 = NULL;
 
 		swap(f1, fp->fi_fds[oflag]);
 		if (atomic_read(&fp->fi_access[1 - oflag]) == 0)
 			swap(f2, fp->fi_fds[O_RDWR]);
 		spin_unlock(&fp->fi_lock);
 		if (f1)
-			fput(f1);
+			nfsd_file_put(f1);
 		if (f2)
-			fput(f2);
+			nfsd_file_put(f2);
 	}
 }
 
@@ -4255,7 +4256,7 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
 		struct nfsd4_open *open)
 {
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	__be32 status;
 	int oflag = nfs4_access_to_omode(open->op_share_access);
 	int access = nfs4_access_to_access(open->op_share_access);
@@ -4291,18 +4292,18 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 
 	if (!fp->fi_fds[oflag]) {
 		spin_unlock(&fp->fi_lock);
-		status = nfsd_open(rqstp, cur_fh, S_IFREG, access, &filp);
+		status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
 		if (status)
 			goto out_put_access;
 		spin_lock(&fp->fi_lock);
 		if (!fp->fi_fds[oflag]) {
-			fp->fi_fds[oflag] = filp;
-			filp = NULL;
+			fp->fi_fds[oflag] = nf;
+			nf = NULL;
 		}
 	}
 	spin_unlock(&fp->fi_lock);
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 
 	status = nfsd4_truncate(rqstp, cur_fh, open);
 	if (status)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0b74d371ed67..f7616bc1e901 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -497,7 +497,7 @@ struct nfs4_file {
 	};
 	struct list_head	fi_clnt_odstate;
 	/* One each for O_RDONLY, O_WRONLY, O_RDWR: */
-	struct file *		fi_fds[3];
+	struct nfsd_file	*fi_fds[3];
 	/*
 	 * Each open or lock stateid contributes 0-4 to the counts
 	 * below depending on which bits are set in st_access_bitmap:
-- 
2.21.0

