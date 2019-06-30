Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546F95B006
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfF3NzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43635 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF3NzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:07 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so22674626ios.10;
        Sun, 30 Jun 2019 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K87fDM8/y72meQszbi80TqLaOGaG74Zl56DNy4VX618=;
        b=JJjGknHaHPWp8u7ZRJTHiLMCeezkf5hr3sqWXgtJdpV5KvFU+tZwZuyrVJ5MYkIabc
         etg1x+6HoEHg7AgDN/X+gLCNnAu4GiwuN1wzf6Zj5nltZNkpeQs2sAcpe0o1iirLh0Vd
         l+Bg/bofmijgM7j3UHMukhxC3zoG+6f0E8RfMCiEAD9rCzluBC/CYVkxc0uosxRI1Hd9
         AZQOht1VzVtomizSjUgaUwctX/fJ4r4SooBYCYSX0FLX3DWE7yH5we0p/eundMrDnWJj
         BjLSpOBEOgJDNCqrZ4C1GEv0lySq14QjQP8HtEAKvxRwZGBMT/vMc7hA+cCstQyrbxvi
         KuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K87fDM8/y72meQszbi80TqLaOGaG74Zl56DNy4VX618=;
        b=gqLgiX94udA1iup8CtDDekqwtlNxBWm0rrtMXDiJw+BO+4ozGX/qmxhvlf6I71YuFq
         YWt4+an97DKYW3ipksBOkoARUtRq6ZwkJ9Qt3JtCjPDb1tiuuwmNDuuCJLUWGnTRmUH5
         ccaJNLZ4S63JvQmGFANO9ffMeGRhE+9RxwJQlu8N3MyXhjZLopZ+KtzBEq6dBEfBGy9I
         05dA6JhhPHtScXC3cEjiuhUCnOZ1uAwN2B/fWVZKUOEpsVyBfmMEeOtKsqHbgYEMmPSP
         OzP4sMi7pciAtxRKsKiEBweH8X6JjOhxtk9QU1bgtEh04vf1HG/azyZ2WOk208Cvf2l6
         uCaw==
X-Gm-Message-State: APjAAAWBJAKwIKAHluPGTAfwsGlcLKsilDgIBtu3s19AB+r7clfvKXVS
        /HrDCB3Cz+LeNTCTdFbfLA==
X-Google-Smtp-Source: APXvYqzgN7y/v72vMOlJ8rrjF4cc230GuEkIf95iRPg9JFBA2zmGefrWcW6wgQWzUqVrj1WeJk6aYw==
X-Received: by 2002:a5d:8845:: with SMTP id t5mr17871154ios.37.1561902906525;
        Sun, 30 Jun 2019 06:55:06 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:06 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/16] nfsd: have nfsd_test_lock use the nfsd_file cache
Date:   Sun, 30 Jun 2019 09:52:36 -0400
Message-Id: <20190630135240.7490-13-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-12-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
 <20190630135240.7490-7-trond.myklebust@hammerspace.com>
 <20190630135240.7490-8-trond.myklebust@hammerspace.com>
 <20190630135240.7490-9-trond.myklebust@hammerspace.com>
 <20190630135240.7490-10-trond.myklebust@hammerspace.com>
 <20190630135240.7490-11-trond.myklebust@hammerspace.com>
 <20190630135240.7490-12-trond.myklebust@hammerspace.com>
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
 fs/nfsd/nfs4state.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index efd63bfbbcd0..1031f767f878 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6210,11 +6210,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  */
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
-	struct file *file;
-	__be32 err = nfsd_open(rqstp, fhp, S_IFREG, NFSD_MAY_READ, &file);
+	struct nfsd_file *nf;
+	__be32 err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (!err) {
-		err = nfserrno(vfs_test_lock(file, lock));
-		fput(file);
+		err = nfserrno(vfs_test_lock(nf->nf_file, lock));
+		nfsd_file_put(nf);
 	}
 	return err;
 }
-- 
2.21.0

