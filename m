Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC140149D26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 23:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgAZWIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 17:08:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32967 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAZWIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 17:08:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so8740855wrq.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2020 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iN1tMOCvY/M/2qIZsMFoCts2ygS7xKcsRnLqhImeWZY=;
        b=GFNvsL12Gx1jWIOBco9Lhd7pa736+EDxpgWxMvR7xjcUHXQNETio0U8O7tWuc/df+8
         0UkGtu9ahDC2dNnPVn9aG3SPDJ8JVXUIeXDAI7DAISuiqNkBMqpmhCIGX2kcyVnYd0zg
         JZ7uMuWW4YnoTkOd8+d1Ny/uIfL++EwBOnpb9CQiotRts5fmxcF8oMFXguBOKKVGPQGb
         3tmuwik7aY0LkMGdo/E74eY5Ye5Di+UGJJwaRcAFZVSLcEbIu3T4mzQx0TaNx5h7kHEP
         BwhnJPi5Jfa1ooJnhRfPJhXdlSHph+wGuYq940Yxi3JF8r7rYHqFVX50MtqLxkVs7Rz6
         yItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iN1tMOCvY/M/2qIZsMFoCts2ygS7xKcsRnLqhImeWZY=;
        b=pJa2meLPSqtHYnmmeUfg3TkBtDbCdyV09f3mQlT1HSv6b7RnDK2CAAGoNiMb8gCmLu
         E45Wbe2st4YkjRFhAwFFvXrOlHDhWhW/jTtTLjaaqQ47xbT6IxYwnh11+nlSbnfz4EIw
         fs3uCvhQlL+RhzTlqvWs1ega+3lNc0gXh5+zP/Zi1PbxZ/2BsKC5KrVf1AYODZLSmV7A
         KUHnF9MCmBtv6EzGH9bjExWMpVTsDXIEN/vXOS7ZdexM+9alIYEP+f5pUjyDfkwwj5Vl
         KgRwzj1M1aXQUj6Uohuz9X/EACJRXXBCPKd6j+NdNNIT6OARyuBfS3jfD3gpNYx6EY+8
         mt3g==
X-Gm-Message-State: APjAAAVxFDLoUyUod1WFCcPIVTltbJGdaeRDNBISLF1Dpw7UadLfFZHr
        aEf2JZbUNlZD/Sao//nma3A=
X-Google-Smtp-Source: APXvYqzuWVe9U3CPhsC5sWZbas/rcSFqk8ZeFvOdntGuLIveq4EyIScJU67lVRqJlRMQ6Cb9C2mMWg==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr18613383wru.220.1580076488456;
        Sun, 26 Jan 2020 14:08:08 -0800 (PST)
Received: from localhost.localdomain ([141.226.11.142])
        by smtp.gmail.com with ESMTPSA id o187sm18786769wme.36.2020.01.26.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:08:07 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "J . Bruce Fields" <bfields@redhat.com>
Subject: [PATCH] exportfs: fix handling of rename race in reconnect_one()
Date:   Mon, 27 Jan 2020 00:08:00 +0200
Message-Id: <20200126220800.32397-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a disconnected dentry gets looked up and renamed between the
call to exportfs_get_name() and lookup_one_len_unlocked(), and if also
lookup_one_len_unlocked() returns ERR_PTR(-ENOENT), maybe because old
parent was deleted, we return an error, although dentry may be connected.

Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
warning") changes this behavior from always returning success,
regardless if dentry was reconnected by somoe other task, to always
returning a failure.

Change the lookup error handling to match that of exportfs_get_name()
error handling and return success after getting -ENOENT and verifying
that some other task has connected the dentry for us.

Cc: Christoph Hellwig <hch@lst.de>
Cc: J. Bruce Fields <bfields@redhat.com>
Fixes: 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()' warning")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 2dd55b172d57..25a09bacf9c1 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -149,6 +149,8 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	if (IS_ERR(tmp)) {
 		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
 		err = PTR_ERR(tmp);
+		if (err == -ENOENT)
+			goto out_reconnected;
 		goto out_err;
 	}
 	if (tmp != dentry) {
-- 
2.17.1

