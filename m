Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7204D5AFFD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfF3NzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37427 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfF3NzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:00 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so22748529iok.4;
        Sun, 30 Jun 2019 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9RRW34zJB7lcgGViIJxmoNYrrHbosLDVygv6GaW6G4=;
        b=bzQkM772D3X7UQ9EBWUqUYsTPZDodkPjXdOyzm95MQzR4F/MLnKpZHqsPE98Ep6m3S
         QCtWjDi2+oVQAdtXgc6yu85C2GAQEv2uHJLRyb0pfBSOnzAVvqG0ygRrqTFOzSCRx2sE
         3Z9NPv6cYRteiKS1O4lv9kQhjgbkc9ZCI8S77rL6v8+MbkL6Srw1GHQXJWOYoHd0U1VX
         bilrwgXCptda1GaEwtMI5KJWZCaqjFxfG16aol7TNxBftkWaY0Nvu/4rFSAdUEiye6rn
         PswVOlkmR0RSCMoubuV0AekopEyf8V7GtvTuet5+pB2ftR4NY/sRsr3F3GMcbKVBFvn1
         SiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9RRW34zJB7lcgGViIJxmoNYrrHbosLDVygv6GaW6G4=;
        b=bqZW6dqNV9B/0eDkNcSKelBeXTyLKw4yqukB+F/XSPu/6nwcEnfna8Xs2itxFYJnly
         +JF7oWIfjUClyIIU8Lb5NPaZsIlGIpz7DF6HxWPQAbD6SHWjFcnpl+o1ZzizUcfW/oDe
         11E3kbGkrfcLtnuXAMnIcsAzz83FUxajWeTFf1tL/WppnZ859/oeu4Xbw/IRxQ983wgd
         LT4+RHxERu5Kc9HiuUG/B4ctWvo/XkmBidJCIXOZZNUFsqwjxVgxLN87u+NLn6pAAYP4
         DVNmMu4pLqfnQL0fF454s5ILbaOrnA5WUf7AzGU0aPUcQzcydXv+Dv3VwYfbEIfHQUHM
         VRRw==
X-Gm-Message-State: APjAAAXQxP3HzO6EEvWmj/5AmjGmSL+KN6j/rQOpL8a/gv/UkKdGATvf
        xOusvF/7lI43rcuVU0xukZB3CqCC7g==
X-Google-Smtp-Source: APXvYqyvEkdYUuVctXQiRhIOXMV8WWmqjRSyo2IM3zYCl0SeOnveuBqSTIXlxj6olKRBOvMTb7RpNg==
X-Received: by 2002:a6b:e61a:: with SMTP id g26mr14678291ioh.300.1561902899033;
        Sun, 30 Jun 2019 06:54:59 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:57 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/16] nfsd: hook up nfsd_write to the new nfsd_file cache
Date:   Sun, 30 Jun 2019 09:52:30 -0400
Message-Id: <20190630135240.7490-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-6-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
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
 fs/nfsd/vfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d12d2de3b444..13550828c3a0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -44,6 +44,7 @@
 
 #include "nfsd.h"
 #include "vfs.h"
+#include "filecache.h"
 #include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
@@ -1104,17 +1105,18 @@ __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	   struct kvec *vec, int vlen, unsigned long *cnt, int stable)
 {
-	struct file *file = NULL;
-	__be32 err = 0;
+	struct nfsd_file *nf;
+	__be32 err;
 
 	trace_nfsd_write_start(rqstp, fhp, offset, *cnt);
 
-	err = nfsd_open(rqstp, fhp, S_IFREG, NFSD_MAY_WRITE, &file);
+	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_WRITE, &nf);
 	if (err)
 		goto out;
 
-	err = nfsd_vfs_write(rqstp, fhp, file, offset, vec, vlen, cnt, stable);
-	fput(file);
+	err = nfsd_vfs_write(rqstp, fhp, nf->nf_file, offset, vec,
+			vlen, cnt, stable);
+	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
 	return err;
-- 
2.21.0

