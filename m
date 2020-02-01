Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6214F6CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 06:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgBAF7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 00:59:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40497 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgBAF7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 00:59:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so4740791pgt.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 21:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u7jvdW2fuKLsgDs+57d3EfQoMcxdP0/UGeFmBvVw6Wk=;
        b=nZM1RxaDTVov+U6ndPCalWFSVoqiEaXcSrj7A9AdG5jcGoO6iclBflZ4T1/4s8P2Iv
         2Van3+djZNb5ciPp/zi+mYsHzCJvu9cX+iF29PU6AfBpeoEDizrUpbgCMoknYA7s/dYf
         4KJMA0aakcFxO5+GpQr+mTwVXPmzoKgiUa++KvBBOrADphrcUuR0JoS+fiRbA9nAtOXz
         EgwlvzQAmBFKYgoyWPam3Bqwh4oeCfPTPScuQPzE+zhwAACCXOks3b8fMEI5zcg5cx0F
         gxwH1eE04j6XZ1x+V6WstZ/95XYzCmgXDilEuDQcCTCL9g8jXAAPyI/TEdQ3kL85Fb0E
         Oe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u7jvdW2fuKLsgDs+57d3EfQoMcxdP0/UGeFmBvVw6Wk=;
        b=A3tC9TvY9GUSR900KTcBFvvED+eR2iupJAwrwjwcCQKhu0dDQx4/2k24C1V3qtQmcJ
         /pkE7s3tq5OyiCWCDL8oni5q4kAXuUnEdcSWqqdYzutYHotornc1Z61ekSMXNOhD7/fc
         0PBl/1ELJZvJCBOhk2kPJZSFcNiUrPAE+Q2rU4p5fXnx7Gr5htSjGZtXPYaK85zSMcaf
         RSe36tA4UA3OnbRKmZ4zzL3HGqeN3e4/Nz2YLtA0q+2rGJdjAomMiV6so5ee+iwP/5Xr
         s4623rKYAn9rLiDCj10mBNDhFSSsT6mf7qR6oFW53jVspM/h0m2xTNCTO5xnDOGuzAUC
         8XqQ==
X-Gm-Message-State: APjAAAXqQ9rcXvoALPVM+rDNs8d5ategpPP7mx0xIQ1bDxsIxFSdEig7
        KuT9057/lHBMwxQGhtBOgps=
X-Google-Smtp-Source: APXvYqymKYB5+Ffpvrx5KI1PsFaaBT91h90joKrHJSOC1Suunj81iuDNayY+ipRJ6L8XORlxyf1KKg==
X-Received: by 2002:a63:5818:: with SMTP id m24mr14239189pgb.358.1580536785843;
        Fri, 31 Jan 2020 21:59:45 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id y76sm12774490pfc.87.2020.01.31.21.59.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Jan 2020 21:59:45 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] fuse: fix inode rwsem regression
Date:   Sat,  1 Feb 2020 13:49:31 +0800
Message-Id: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Apparently our current rwsem code doesn't like doing the trylock, then
lock for real scheme.  So change our direct write method to just do the
trylock for the RWF_NOWAIT case.
This seems to fix AIM7 regression in some scalable filesystems upto ~25%
in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/fuse/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ce71538..ac16994 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1529,7 +1529,13 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t res;
 
 	/* Don't allow parallel writes to the same file */
-	inode_lock(inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-- 
1.9.1

