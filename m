Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32F52E3A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfE2Rnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2Rnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so2379619wrb.9;
        Wed, 29 May 2019 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HN28jzdWIDmYfqKHB1OqlcDa2tkQLMvz+g74LeD+kio=;
        b=JUf3gpx4X+xBASgixo3psABkDGhXiKV7Lv6aCmi3cIY5g3UvcqkbbvIo4LEBHHlOcM
         47HvlL4K1Cfr3ZCYRlFlQMk169fxuc4V9OE11x9tSy5YsvifN+2+3lazi2lND22my4/4
         vd26PGS+5Js9jWQid+RCNzQaf/Cxq14XwTGKpzF/Q1Bka7r0NBU4GOkAB1YemhBS82Bd
         Lb9aAjs9AjZ7/j02/iDPiRAipCy9DyKOAKm748nAnJr525j6GQIkn1vJLKJPSxueSVCR
         /PoGsscocZt9StBbSuN5VS082vCWGMzYH/2Eb9v2UTVF6paGYYjXEs0W0yHzHIGdVPtu
         C46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HN28jzdWIDmYfqKHB1OqlcDa2tkQLMvz+g74LeD+kio=;
        b=MS3J53CKNFFz2rSBpksU06XDAGDj5zEwBl97iWik1SdEGEpAu2hHiKo+yeEmArIUdH
         lVEdbH+QoprW0X1IMQcPfUtTLbUfKvZEyepItdQ6QjxR6pUsEu0l0We+CMDP4UeQeOxb
         kTHBgPvlK9+tKT5LA4QixKCRxlZNGa6TjE4ZXh7uVD+wiALxQLko4Dde1GHWKU7lx/vp
         WhMoxl6fMWMFPIveljlgAIdfjq2zvi8GpNgM/V0ksTdqUzcixcWRMogRtSZl0/SOYpPI
         gAf8s+A2QWO4oqNnn/WLPUeXtLXSkF+RtITh+807gT7Pfn16DXb+jUsKAvb1bvl0TlRT
         0bsA==
X-Gm-Message-State: APjAAAVTvoCspflraceM8mhM/vJyv87EVG6nZE5hambx2Ehn6+94HYzl
        B60kVO5j7/HCi8OZDQrjpBk=
X-Google-Smtp-Source: APXvYqy4vphWl+uJOQFfpvp7RUdNvXC3EMyYKCKKMmpEfRH0EaEwUWjRn9WIuethzwglftoWN3AHHA==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr35442527wrv.303.1559151830843;
        Wed, 29 May 2019 10:43:50 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:50 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v3 12/13] nfs: copy_file_range needs to strip setuid bits and update timestamps
Date:   Wed, 29 May 2019 20:43:16 +0300
Message-Id: <20190529174318.22424-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like ->write_iter(), we update mtime and strip setuid of dst file before
copy and like ->read_iter(), we update atime of src file after copy.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfs/nfs42proc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 5196bfa7894d..c37a8e5116c6 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -345,10 +345,13 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 
 	do {
 		inode_lock(file_inode(dst));
-		err = _nfs42_proc_copy(src, src_lock,
-				dst, dst_lock,
-				&args, &res);
+		err = file_modified(dst);
+		if (!err)
+			err = _nfs42_proc_copy(src, src_lock,
+					       dst, dst_lock,
+					       &args, &res);
 		inode_unlock(file_inode(dst));
+		file_accessed(src);
 
 		if (err >= 0)
 			break;
-- 
2.17.1

