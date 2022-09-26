Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C85EB570
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIZXTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIZXSu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC5AFAE8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j3-20020a256e03000000b006bc0294164dso1476537ybc.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=TF2Lb28qNReadK/OQ4BAXWajo89COftQw/9tSIfn/eU=;
        b=INqRGjxluJCEHpR4cpkLlv7qXEZrde/PnoBtUl6J3263rtZp+b99vij0eD9O++AfZe
         yaeuNtSzj9tiYEm7BGlQjTTUA35Y8y+pSnFiQ/EeoSmePdm7wHCllG/GQXsvyxzCfyvH
         5w7W7DuEZQikbZE0JYV3lKzms6pAuIXd+xbQNQMxQ/GCWqzfdiYMl06klE0JDGtD1Lnb
         cFJtGXlypHrzIg4rTWTpS1xiC7fqCq/sUj5SUGWOVxxsHmkz3CORbjifSTFYDqqRAT2b
         kHr9pqDU8LDjky4ysJnFqZYi6SGYV4gyN8gB0spq6ig+4XACwK4SzgfvAuTvmc8wkWFJ
         rbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=TF2Lb28qNReadK/OQ4BAXWajo89COftQw/9tSIfn/eU=;
        b=ct5n5tz3Rrr6c5Ca3sOqMycOa219XClnEm/Eaw5DaWjXia9usdjukC8Cjn2jNjT1Za
         sWk3fiYjyoEPBnFmVGz4UpOeDtmcddQG2tRFXXI28IBoqYZ1nuro/Y0CDnC8YNjlaStG
         BwAmQQxQ4YejDv6fLqBWvJpGZphYWk7IkTpOgBvZ4ZEpwQDArf3HrHfcVn4PDqL1Jo6R
         HyOSauDk/xUnyJgUYNHBEJZHvIx0gHfB/nM1BM1tz7H/oApsEMclqONL53mNkWcncQgd
         DnkP+C8yBeFrPh/xdlw2/qR8Rd93T9/SbqWNHvI4Hfohr7y5j8VsOj2fDMU2IF25Q76f
         vHgw==
X-Gm-Message-State: ACrzQf1CdeMDv5UO8j0LQBR/cJluflSac7nfW3zcueFMTp2H1aps3eRR
        lbiMZt4djO4FJRJoLPCLXcBaMx/wW+A=
X-Google-Smtp-Source: AMsMyM46i9O/h1LHmEtMQzG9TJDg2bvjwGOZaIR6AZsNPBZITSBa59AG5BGA+VJSjWXBXO+ydGDerQBIRmk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a5b:548:0:b0:6af:20d4:d2c1 with SMTP id
 r8-20020a5b0548000000b006af20d4d2c1mr22156635ybp.63.1664234322499; Mon, 26
 Sep 2022 16:18:42 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:01 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-6-drosen@google.com>
Subject: [PATCH 05/26] fs: Generic function to convert iocb to rw flags
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com, Alessio Balsini <balsini@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alessio Balsini <balsini@google.com>

OverlayFS implements its own function to translate iocb flags into rw
flags, so that they can be passed into another vfs call.
With commit ce71bfea207b4 ("fs: align IOCB_* flags with RWF_* flags")
Jens created a 1:1 matching between the iocb flags and rw flags,
simplifying the conversion.

Reduce the OverlayFS code by making the flag conversion function generic
and reusable.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/overlayfs/file.c | 23 +++++------------------
 include/linux/fs.h  |  5 +++++
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index daff601b5c41..c9df01577052 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -15,6 +15,8 @@
 #include <linux/fs.h>
 #include "overlayfs.h"
 
+#define OVL_IOCB_MASK (IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
 struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
@@ -240,22 +242,6 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-static rwf_t ovl_iocb_to_rwf(int ifl)
-{
-	rwf_t flags = 0;
-
-	if (ifl & IOCB_NOWAIT)
-		flags |= RWF_NOWAIT;
-	if (ifl & IOCB_HIPRI)
-		flags |= RWF_HIPRI;
-	if (ifl & IOCB_DSYNC)
-		flags |= RWF_DSYNC;
-	if (ifl & IOCB_SYNC)
-		flags |= RWF_SYNC;
-
-	return flags;
-}
-
 static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref)) {
@@ -315,7 +301,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	if (is_sync_kiocb(iocb)) {
 		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
-				    ovl_iocb_to_rwf(iocb->ki_flags));
+				    iocb_to_rw_flags(iocb->ki_flags,
+						     OVL_IOCB_MASK));
 	} else {
 		struct ovl_aio_req *aio_req;
 
@@ -379,7 +366,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (is_sync_kiocb(iocb)) {
 		file_start_write(real.file);
 		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
-				     ovl_iocb_to_rwf(ifl));
+				     iocb_to_rw_flags(ifl, OVL_IOCB_MASK));
 		file_end_write(real.file);
 		/* Update size */
 		ovl_copyattr(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..c1d49675092e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3420,6 +3420,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	return 0;
 }
 
+static inline rwf_t iocb_to_rw_flags(int ifl, int iocb_mask)
+{
+	return ifl & iocb_mask;
+}
+
 static inline ino_t parent_ino(struct dentry *dentry)
 {
 	ino_t res;
-- 
2.37.3.998.g577e59143f-goog

