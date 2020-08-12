Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B972425AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHLG5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgHLG5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 02:57:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586DC06174A;
        Tue, 11 Aug 2020 23:57:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so1203482qka.3;
        Tue, 11 Aug 2020 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KI7BZp5zTttMFtGMkC+4pvOiWlHe+6AI/MPo+ZZwpas=;
        b=IGAtMYD7zZgYB8LMAhk7w6i22UZ1mKS3toxTCnRgwlZlDNbt2AH5uAmCVCalGs/TuH
         vWGgjRIpKmFYq8rSWP2N/hvMjZHiTNzKKqUUnvic4JwixGz8XMwl+1s6hR9cKjpu4eqM
         h74WI72K8BSmSTVgJfDsDLyorFb8OFYAkBcWRk6vOxY0dD/xAv/bkKQdWt/QXZ66cL0K
         gLPrZsysiCo/G1VsvRrG+wZQaNirU2VXRFtU2bqyHp89G+kHHoSd2ymDHEad3XFoc98W
         2m3ZdMl2Hkix7L0dU3G8OYEhIN7TSH8fetXW19qEjjma/r1/IRTd2Pw1l7USMv7Il0qe
         ce0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KI7BZp5zTttMFtGMkC+4pvOiWlHe+6AI/MPo+ZZwpas=;
        b=e5kJIzp51kiF7+EkrZma1U+uO42b6O5yPjDdq6nIK1lFXFrIQdjR6u5Nmm/n7nq12A
         AimyAgxIW75OIUuiiJHtvUIj23k52A7wSDlFscOxekDMAve10OD1F9wajZW9D38eIXjZ
         aMjXsvPCHXVragWniDpvAZ6tbFDC9oSqEHCYK7stsZcNfIFQRCuMgkaLQRIkmTF+VyxG
         RtrYLZB45krwCgfdyqiAX6UuWsndd7P8r+iohcfZqalbNwPaqZlUHr++ncV8301xleR1
         dUgY0+BxbUBMuWSIlQ7WifUSDxTfa2IbbLbOYw3okA6fnDKRftccm13VPGP+sS8y2qvW
         YZPg==
X-Gm-Message-State: AOAM532HpfU8mz/K5efuaatJBWltqxm2Rs0FE3zU9Jmv/ipY/nkHAamS
        GTkTcNoo+hSkhOIrY5U09A==
X-Google-Smtp-Source: ABdhPJwh3zs4PxkbtUyTGPeIlBrP2afDgGBq7e8XCXAqWc7ixYcdf11t9i33rTTDjzueIPcl95OdKw==
X-Received: by 2002:a37:66d7:: with SMTP id a206mr4637727qkc.495.1597215439437;
        Tue, 11 Aug 2020 23:57:19 -0700 (PDT)
Received: from localhost.localdomain (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id d124sm1263978qkg.65.2020.08.11.23.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 23:57:19 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer dereference in hfs_find_init()
Date:   Wed, 12 Aug 2020 02:55:56 -0400
Message-Id: <20200812065556.869508-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prevent hfs_find_init() from dereferencing `tree` as NULL.

Reported-and-tested-by: syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 fs/hfs/bfind.c     | 3 +++
 fs/hfsplus/bfind.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 4af318fbda77..880b7ea2c0fc 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 {
 	void *ptr;
 
+	if (!tree)
+		return -EINVAL;
+
 	fd->tree = tree;
 	fd->bnode = NULL;
 	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..85bef3e44d7a 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 {
 	void *ptr;
 
+	if (!tree)
+		return -EINVAL;
+
 	fd->tree = tree;
 	fd->bnode = NULL;
 	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
-- 
2.25.1

