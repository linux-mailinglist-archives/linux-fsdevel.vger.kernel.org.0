Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69A5587E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 16:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiHBOmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiHBOmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11425DF51
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659451361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tAnGm9frat5va83b6+sqvZhB1pBdRLot8yEhexiMclk=;
        b=VgXSQmCgvWtykXwSSzimLTflt+/apva/+Ksv1peViGT1CHOqv3CEFW0ji0O6pCYoyyy8iZ
        0aJF8SJrwGWT9kbctVs6dXrF7rjRQMBvnCUzwkCMPLWYPm56sr5oAmXg/Hco+l5Ak4zuOZ
        BswTufb3ahdziTWrznU3Pok99GBrzDM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-9iwnHpkAPmesBBS_XoZTsw-1; Tue, 02 Aug 2022 10:42:40 -0400
X-MC-Unique: 9iwnHpkAPmesBBS_XoZTsw-1
Received: by mail-ed1-f70.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso9213908edx.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Aug 2022 07:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tAnGm9frat5va83b6+sqvZhB1pBdRLot8yEhexiMclk=;
        b=0jgKziuerk22Wub5/2q1Nmh0eYxsFYNSD7Mb201sO8raSSwV1T4sUT0kimhiQXZp8T
         ZiE7iDDYL9J9cprZMjzNI2p64G57RsCoFZFEW9KcyCsmx4PGJTgeuSa1gS60FHaAYzUL
         Uo396fbkpjjuUlO+T3V//fae0gjto4WAD/InWZ9oSBuLbz2FjWhLF9Xy3SRHJA77I5IO
         myhkb/JxtP2le6z3YCdELCnZBo9+5i90yK1nClhPuuVVCwEBIFW7LIpzaZ/O2Y+VylP6
         6JxLnIjuZ4KP0KHuwOTo/381OdwaZofQ66Jk+6XPnu7aeWSI8b2mmi9mxzfZk4U8Bass
         4raA==
X-Gm-Message-State: AJIora+d2XeE8MoQrXb0Dh+YDaynVhIIEJ1Er6IhER9AP2cCTqIdXrUD
        wXcgJJxjdfMGgRddgQEXGKvWEf9Eh/SClNJRetwu0zCcBCslv9K4nBAckGRCpyPpjOAx/zSnmy2
        QPx1V54mRAHTUkJ3ZHxQFhYvPqg==
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id dz17-20020a0564021d5100b0041fcf6c35a5mr21364779edb.25.1659451358734;
        Tue, 02 Aug 2022 07:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v2PM39YX4ZcCOfZlNjMITmnz/07SfpU2gv6p89ZbKpOdb9OdKfB3lrTutkt2q4bhia81QJ+A==
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id dz17-20020a0564021d5100b0041fcf6c35a5mr21364763edb.25.1659451358503;
        Tue, 02 Aug 2022 07:42:38 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (fibhost-67-247-20.fibernet.hu. [85.67.247.20])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b006fee98045cdsm5337669ejo.10.2022.08.02.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 07:42:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
Subject: [PATCH] vfs_getxattr_alloc(): don't allocate buf on failure
Date:   Tue,  2 Aug 2022 16:42:36 +0200
Message-Id: <20220802144236.1481779-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some callers of vfs_getxattr_alloc() assume that on failure the allocated
buffer does not need to be freed.

Callers could be fixed, but fixing the semantics of vfs_getxattr_alloc() is
simpler and makes sure that this class of bugs does not occur again.

Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
Fixes: 1601fbad2b14 ("xattr: define vfs_getxattr_alloc and vfs_xattr_cmp")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e8dd03e4561e..1800cfa97411 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -383,7 +383,10 @@ vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	error = handler->get(handler, dentry, inode, name, value, error);
-	*xattr_value = value;
+	if (error < 0 && value != *xattr_value)
+		kfree(value);
+	else
+		*xattr_value = value;
 	return error;
 }
 
-- 
2.35.3

