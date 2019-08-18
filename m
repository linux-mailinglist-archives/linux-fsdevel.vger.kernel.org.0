Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193CC91835
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfHRRAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34149 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfHRQ7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so5747431pfp.1;
        Sun, 18 Aug 2019 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HGJ0SLLZ/8OiPn6gk75MHhbU4//pD3TrNh/zboW2EHI=;
        b=msrzD0Y9xNpt458A4zyO9I98iFYcvBfMe8wPmB4FuYb3QQzBzYSqAhtBY/qrcW87AA
         SQOgbWAt8qWQgvjbDY4qNud6q5rh553E4XHK6sf1AcRzUfvlYZz5i/CT7VilNmYgzdLI
         HrmeF8L99G+ZkbT4IZg8w5PYn83VtO9LOL7aDKodtY5eqe3nPow7+cVDOtlI3raF7pxJ
         gGO1eBjOG1FKJM/AGZWTPRXUVV1fFwvh/Ak2irv3b7+p1wwiKDUmImv3hGowvt0/eFDj
         F38j2DvADFJ8dC/gYf/tJjtzgYgAEFhZ26p7QrQ9jvKjUr4T7STs/hPEbFdZFxbOpXy3
         ufTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HGJ0SLLZ/8OiPn6gk75MHhbU4//pD3TrNh/zboW2EHI=;
        b=ZTa14xzgdNHTTFnURDEmvVRu+E/1CvCpKyVaLpGysxKxH+mibTzlcMoriO2Hd8g920
         WY+iFZlsEZJLunVOwYuH12dfARtvkY683UWj76zMLuApSuvZ7EdsWXqwIBHGMQtV1bKa
         CsVOW32motx1CFb/WZauCFLW/bV90oBWTEWpIfKgHAGTjhYfxWe0v51B5fG1ZgTivUju
         xjjbf4Hna/hZAOb8XFVSAqXD5INOJf3yjswKgykUaqVr1r2n6pa7mKfXxvKRrhsKtYBc
         yJ1eVOIpJLivZzVYZfgFLmQUKKtUHx/cdiHECQwPVRjnuqdmZMmcw7JvNy1Wi3E6vM+7
         Drrw==
X-Gm-Message-State: APjAAAWzVlmQMBEXz+fa8bZlcQ3pSOE22ANspA7r+NSjPEXTzMih/CNT
        KpLq2aLIpI6HLuy4N7CS6us=
X-Google-Smtp-Source: APXvYqzxqwkDUvkPJOOZEtUbgNwAcxhbG0Q3MVR+Ce1pxVGHbDA3DuIuRfR52BAYtZsFDlhHQI1Azg==
X-Received: by 2002:a17:90a:e38e:: with SMTP id b14mr16763092pjz.125.1566147594799;
        Sun, 18 Aug 2019 09:59:54 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:54 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH v8 10/20] fs: nfs: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:07 -0700
Message-Id: <20190818165817.32634-11-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

The time formats for various verious is detailed in the
RFCs as below:

https://tools.ietf.org/html/rfc7862(time metadata)
https://tools.ietf.org/html/rfc7530:

nfstime4

   struct nfstime4 {
           int64_t         seconds;
           uint32_t        nseconds;
   };

https://tools.ietf.org/html/rfc1094

          struct timeval {
              unsigned int seconds;
              unsigned int useconds;
          };

https://tools.ietf.org/html/rfc1813

struct nfstime3 {
         uint32   seconds;
         uint32   nseconds;
      };

Use the limits as per the RFC.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: trond.myklebust@hammerspace.com
Cc: anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
---
 fs/nfs/super.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 703f595dce90..19a76cfa8b1f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2382,6 +2382,15 @@ void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
 		sb->s_flags |= SB_POSIXACL;
 		sb->s_time_gran = 1;
 		sb->s_export_op = &nfs_export_ops;
+	} else
+		sb->s_time_gran = 1000;
+
+	if (server->nfs_client->rpc_ops->version != 4) {
+		sb->s_time_min = 0;
+		sb->s_time_max = U32_MAX;
+	} else {
+		sb->s_time_min = S64_MIN;
+		sb->s_time_max = S64_MAX;
 	}
 
  	nfs_initialise_sb(sb);
@@ -2402,7 +2411,6 @@ static void nfs_clone_super(struct super_block *sb,
 	sb->s_maxbytes = old_sb->s_maxbytes;
 	sb->s_xattr = old_sb->s_xattr;
 	sb->s_op = old_sb->s_op;
-	sb->s_time_gran = 1;
 	sb->s_export_op = old_sb->s_export_op;
 
 	if (server->nfs_client->rpc_ops->version != 2) {
@@ -2410,6 +2418,16 @@ static void nfs_clone_super(struct super_block *sb,
 		 * so ourselves when necessary.
 		 */
 		sb->s_flags |= SB_POSIXACL;
+		sb->s_time_gran = 1;
+	} else
+		sb->s_time_gran = 1000;
+
+	if (server->nfs_client->rpc_ops->version != 4) {
+		sb->s_time_min = 0;
+		sb->s_time_max = U32_MAX;
+	} else {
+		sb->s_time_min = S64_MIN;
+		sb->s_time_max = S64_MAX;
 	}
 
  	nfs_initialise_sb(sb);
-- 
2.17.1

