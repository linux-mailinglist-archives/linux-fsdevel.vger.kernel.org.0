Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A268C5B00F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF3NzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41897 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfF3NzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:03 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so22706295ioc.8;
        Sun, 30 Jun 2019 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mC0aOWiyf39HNfQFHScyPluVHG26yH9hnOHWJSiH0wo=;
        b=L6B6CZlNeJiHmKHQLihduSGYpKjtQsCPGt7VhxiI1rThC3D/FBY7ibrd+JR6eUztkV
         gf+Z6ZoeondthRIypNJw8GTzoeInm2Ucv/OswhSnp9IENPqB3LE81H6HNtp7c1GK/jm5
         YdCMv5SBT8q/gxCpOitSFp/zC5bk818CSO97NWCOF/tNHpP3k9MBJEoVh8f8uE2g52jM
         wG4VbbsN66wlDLHWml087NbWf/X3S7eLmZM+aODBajI1dfPdvqsUuFOxiaVTTTPCSeC5
         /WVqMBH4lgXYa3eIILiYN/A/Z8JW9hB/aYOlifeKoJHm6BM+7avPye9yhhVlDmgwj0Ur
         9dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mC0aOWiyf39HNfQFHScyPluVHG26yH9hnOHWJSiH0wo=;
        b=ZWCxzM2lBK1K8Yp3g0cF6foXuOGss1bOacztAV+ApsdNhCuAnN7sCpZYyf5vOoHox/
         39vIDMmmFiJjYBr1oYjW2PAYulh5BqZUYQxgr6MgUd+f+WCaGRk6deIXEeXRWPSwkZtT
         CyS2E7M0F0fVJWZ+/VolfIRms/Xw31S1rFDlyFZN0jfbDjN+NgFIC09OkUFWp10fdH4A
         wrtrzVd+RYf2qmB37dC+376RKwQ7rCSWSaCD1i8Ujq9BwcGKwFi+pFLFQVqKqDgTaJNC
         grHyS+0clnbW0mU0x7fphxKWxQ+X4yxLuouoG4vOuAcLL7jLUoEHt0wvnmQHqzrhmn3G
         hFUQ==
X-Gm-Message-State: APjAAAUHpaAt2MO/qlJ2ac61oCToxs5EVEJoky4bZ+H+zypmgyUUbL+g
        6NBg34owxz/Q6VMEmY7AgA==
X-Google-Smtp-Source: APXvYqxNXeZ0u8mQhK30/0sjuZph9uM3y4SkittyCHF/qaMVLdk0uZhHsliT1TVjerUH7exZvefjaA==
X-Received: by 2002:a5e:d507:: with SMTP id e7mr5208010iom.284.1561902900371;
        Sun, 30 Jun 2019 06:55:00 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:59 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/16] nfsd: hook up nfsd_read to the nfsd_file cache
Date:   Sun, 30 Jun 2019 09:52:31 -0400
Message-Id: <20190630135240.7490-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-7-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
 <20190630135240.7490-7-trond.myklebust@hammerspace.com>
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
 fs/nfsd/vfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 13550828c3a0..d8ee0730fade 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1071,25 +1071,22 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	loff_t offset, struct kvec *vec, int vlen, unsigned long *count)
 {
+	struct nfsd_file	*nf;
 	struct file *file;
-	struct raparms	*ra;
 	__be32 err;
 
 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
-	err = nfsd_open(rqstp, fhp, S_IFREG, NFSD_MAY_READ, &file);
+	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
 
-	ra = nfsd_init_raparms(file);
-
+	file = nf->nf_file;
 	if (file->f_op->splice_read && test_bit(RQ_SPLICE_OK, &rqstp->rq_flags))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count);
 	else
 		err = nfsd_readv(rqstp, fhp, file, offset, vec, vlen, count);
 
-	if (ra)
-		nfsd_put_raparams(file, ra);
-	fput(file);
+	nfsd_file_put(nf);
 
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
 
-- 
2.21.0

