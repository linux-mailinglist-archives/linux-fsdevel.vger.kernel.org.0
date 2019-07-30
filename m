Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63A379E36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfG3Bud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34282 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfG3Bub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so22944806pgc.1;
        Mon, 29 Jul 2019 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZeqJE/MeTBzAZVLgzu+nTLWbc1OyHy2shL2/lZCsj/E=;
        b=djXDCvKRCKQsZILkMke8YNvphRWUO1wNt9BAw2+CBnHgcyKzB2yFR6k6Jv35GAcuzL
         RxYURBvb2zV0WlSfCjgyLKb1rJDT5okkB3kgMyfyDpxTotIqoHoxkKK2HxyPHVJ6lo5B
         lylJZT43F5e5Gb70J/ZTV3A27aX/xtR+Oa4dDnOKoh2jLXHYvbaO0QwIQsLSqu5f+4K6
         Koy36WBtfApZ3uNXCUqeBmOuUOsAxfQiVFZyF7o/VBsdaTKcvBChhHnEcPtjfPwnMJzg
         e0UHTVnp3ezEdMsSQRC5pMzcE1VEHXvOg0QTXo3MfwD7jjo94qhmeV0cUYCyWS6bHcLD
         Chwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZeqJE/MeTBzAZVLgzu+nTLWbc1OyHy2shL2/lZCsj/E=;
        b=BIxWUgmYsw/t8wn04v0LJlzm1PEGYKrxFlQlMyXe7mQqzAoGEbE0XCUP5xwvyHtuic
         GCGrRbpFRd5ilsAen6pcHHX1RC0OlU8drzn8LN/ykkmbvNLjfhmZkHgd2WyLwKqtNaAh
         +jx+BXKENlKRF9aUnP/Zv5gQd4ZuQJTJeEeLLjU57hXwlVgopepGNRJ+lLnn9XKDGfyR
         GqVAHX40UP38Ll9lg9nioXLxjx+qpdMSCh5CqryX6mK2SnM/fhLUIas+CRCSxht5umqx
         CAerzQmo/N+Ptwt4uHVTzZUL+i+1BjcJBbzSgRDuA3rjwg/lvxFVvewgJz58W6qC6dzJ
         8Haw==
X-Gm-Message-State: APjAAAUUICZojTQo9EpYEfJ15MlkBOrHVOWXmLdkvlJeB1Aq0D6vtNun
        COj//ATKIu3AIc01bpq0FEU=
X-Google-Smtp-Source: APXvYqwVHu5Iqz3b+zxf1ms9RX+F7inyknOw3X8ckD8V2vhhe1paXQwvZmmShsmA+JtzpJbt3hgH+w==
X-Received: by 2002:a62:750c:: with SMTP id q12mr40608921pfc.59.1564451431014;
        Mon, 29 Jul 2019 18:50:31 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:30 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH 10/20] fs: nfs: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:14 -0700
Message-Id: <20190730014924.2193-11-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
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
index f88ddac2dcdf..54eb5a47f180 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2360,6 +2360,15 @@ void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
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
@@ -2380,7 +2389,6 @@ static void nfs_clone_super(struct super_block *sb,
 	sb->s_maxbytes = old_sb->s_maxbytes;
 	sb->s_xattr = old_sb->s_xattr;
 	sb->s_op = old_sb->s_op;
-	sb->s_time_gran = 1;
 	sb->s_export_op = old_sb->s_export_op;
 
 	if (server->nfs_client->rpc_ops->version != 2) {
@@ -2388,6 +2396,16 @@ static void nfs_clone_super(struct super_block *sb,
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

