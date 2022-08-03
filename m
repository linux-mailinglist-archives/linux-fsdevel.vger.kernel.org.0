Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287E588CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiHCNRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiHCNRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC8CA186E1
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659532671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4Z9aouwfoHCK+UXJ85cJIP7XKCWXRmrg/EA//RxyZ5M=;
        b=Wfd2ofKBEQ5ZQWyA8aShVEJaHxDxUZ+pWw61Ek7IutUFDSpQupZoSumVrrUHqq+9MpAzDn
        qO5jaLvp+YgqwxZkw4x6UMt2XhHfxg6LgrAzfaNF0dRf3dt2a4/nUo6k4vX77u4C9njDIn
        hoEwfkXkSKF2wNXMD3A3AJzB8gYy3QE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-HYjfIJC2N8e-Nvd-PatQ9A-1; Wed, 03 Aug 2022 09:17:50 -0400
X-MC-Unique: HYjfIJC2N8e-Nvd-PatQ9A-1
Received: by mail-ej1-f70.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso1584587ejc.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 06:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4Z9aouwfoHCK+UXJ85cJIP7XKCWXRmrg/EA//RxyZ5M=;
        b=jZaPt+22zkGA1etLvyGaUyLvKgZYtf85J0DCJ15AEq/9k1GPCSxWveozqEmR9XbscO
         8VWLbSZchWs9pA2uwaIuCcSjQwfoXaoWpHZEtqkJfg6jtUCRm0q9U6EJ/VxNfetxQKup
         cKr35zkIS4T7GNUVynBdQ3Jq4W4iUJaUqf0GqdswNACXIVleM0xeR069wHJrLg7I0RXh
         u8faJl3gAVQ/r+XrByrE3DHTaBgFO8m2Iv02710nl1STgptwtG+iY/hv2Hcmwx3Bl1Vd
         mpLhQAeABGLEUXyjoXKVzXCyI8YwHCfE+7kVs5/fNFa001ru9p+Mh0I0sqp0nwLNldwU
         G3IA==
X-Gm-Message-State: ACgBeo17Z9sbXZJGaEVr9s/vW4YFSmRcEBFGqKngKfOs+O5Z+ZRis8t3
        IHMxHzXKMR1+gla+JALpZbf5Cw7EUeGQzH3kWpDMjdUXuAVJuRRg5aGGciAw2ihn0QXruQZiJVG
        We0jJU03Ihng154w9qbtFb9ILwQ==
X-Received: by 2002:a05:6402:32a8:b0:43e:5490:295f with SMTP id f40-20020a05640232a800b0043e5490295fmr1820568eda.193.1659532669230;
        Wed, 03 Aug 2022 06:17:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZhGjGK+WKDhaKS0xjTxQ1wYrBHMGjMmwt2PWAFzQsHAfoMzW+8/Yo0ghwBAYUqbafUDaT6A==
X-Received: by 2002:a05:6402:32a8:b0:43e:5490:295f with SMTP id f40-20020a05640232a800b0043e5490295fmr1820554eda.193.1659532669048;
        Wed, 03 Aug 2022 06:17:49 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (fibhost-67-247-20.fibernet.hu. [85.67.247.20])
        by smtp.gmail.com with ESMTPSA id d2-20020a1709067f0200b0072ee0976aa2sm7242538ejr.222.2022.08.03.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:17:48 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
Subject: [PATCH v2] vfs_getxattr_alloc(): don't allocate buf on failure
Date:   Wed,  3 Aug 2022 15:17:47 +0200
Message-Id: <20220803131747.1608409-1-mszeredi@redhat.com>
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

If this was called in a loop (i.e. xattr_value contains an already
allocated buffer), then caller will still need to clean up after an error.

Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
Fixes: 1601fbad2b14 ("xattr: define vfs_getxattr_alloc and vfs_xattr_cmp")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e8dd03e4561e..c03a957902da 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -383,7 +383,10 @@ vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	error = handler->get(handler, dentry, inode, name, value, error);
-	*xattr_value = value;
+	if (error < 0 && *xattr_value == NULL)
+		kfree(value);
+	else
+		*xattr_value = value;
 	return error;
 }
 
-- 
2.35.3

