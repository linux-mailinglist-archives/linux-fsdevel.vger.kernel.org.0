Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5E5B001
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF3NzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43606 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfF3NzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:02 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so22674304ios.10;
        Sun, 30 Jun 2019 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feoPaWtt7UdbnADxwonjCbCAQHX1b4eGxbNGsjo8sBs=;
        b=kF+XcvefmXIz7s8hOvV1wOPHgJi6FvbmY70TkiO2qIaTtNwFoJ6Ybsw9LdBe1io0V/
         2+ZiUNrKg/hKyJlYrXuIbMS7IA5EnVwVVyitx7nM7fF/sYH6YfTX4pM12ICM7wcKiGI/
         zIqaddO2u46Q3aHq8l1jgwy7V7y/kU+ywXIQXXmQv65v4kpfWXpkbEMrZQi39arsKrCx
         By/SGBh+ZsokL4oKMOmNSpr/udP4RFH0qAzqYWURYhhEDYrhM7E6/WNPRTEpBKfHbe+F
         oSvGThqaxjsYkdxTV4Vm7lafjSL1VXThPkkuDaku0cUTRK5Ez5r6gimssrgqq6BKsFpd
         Vdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feoPaWtt7UdbnADxwonjCbCAQHX1b4eGxbNGsjo8sBs=;
        b=s84Gi8wwvtkTbHxfIXC8daj5fPThRRiZB2ZJAjI+Vvb36M9NFFJmgVis0r7LgC6Yll
         Uk27S3nEcHAK9gYOgBU6uktlGkaD2XhKhEo9mwFsNjbmLNkbsFKON8H/AvMcZDy43hrQ
         A5hFoVQ1mvjJcnJbEYIdElhJyCXl5KLJlVA7IbpGH+RYbZjJfuSw7R5g/0lvWo6cYmB9
         b0odOvdifjM51kYhKgP34UYUG/7LKfdPahJmw9/+AT3TYd3H8djJngQvVNpvJNlNv7fo
         c+un59dp0jWLfoPN+1IQye7Rkq/07WQXsiPgijWa8OuECuEJIRvxKHoz6IN+gnwZPgpx
         MZzw==
X-Gm-Message-State: APjAAAXl03EHuQm3RDijFj4aU8SBpodzi3Dl7+YUcEIWppYUWvXB8J1y
        ngoeoVAaxenYGR8gw4CYfQ==
X-Google-Smtp-Source: APXvYqz4+uJ8g6WCOtwyhPFpq1f76a8hzYePAq0HD1OGToOHdkF+X/CJuTMcvtItzXyHkB9auwHp2Q==
X-Received: by 2002:a02:9a0f:: with SMTP id b15mr23432594jal.32.1561902901449;
        Sun, 30 Jun 2019 06:55:01 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:00 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/16] nfsd: hook nfsd_commit up to the nfsd_file cache
Date:   Sun, 30 Jun 2019 09:52:32 -0400
Message-Id: <20190630135240.7490-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-8-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
 <20190630135240.7490-7-trond.myklebust@hammerspace.com>
 <20190630135240.7490-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Use cached filps if possible instead of opening a new one every time.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d8ee0730fade..f26c364bdbb9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1133,9 +1133,9 @@ __be32
 nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
                loff_t offset, unsigned long count)
 {
-	struct file	*file;
-	loff_t		end = LLONG_MAX;
-	__be32		err = nfserr_inval;
+	struct nfsd_file	*nf;
+	loff_t			end = LLONG_MAX;
+	__be32			err = nfserr_inval;
 
 	if (offset < 0)
 		goto out;
@@ -1145,12 +1145,12 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 	}
 
-	err = nfsd_open(rqstp, fhp, S_IFREG,
-			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &file);
+	err = nfsd_file_acquire(rqstp, fhp,
+			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
 	if (err)
 		goto out;
 	if (EX_ISSYNC(fhp->fh_export)) {
-		int err2 = vfs_fsync_range(file, offset, end, 0);
+		int err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
 
 		if (err2 != -EINVAL)
 			err = nfserrno(err2);
@@ -1158,7 +1158,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			err = nfserr_notsupp;
 	}
 
-	fput(file);
+	nfsd_file_put(nf);
 out:
 	return err;
 }
-- 
2.21.0

