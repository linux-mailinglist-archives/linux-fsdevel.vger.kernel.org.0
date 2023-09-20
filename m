Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1EB7A8C88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjITTPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjITTPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:25 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83CDD;
        Wed, 20 Sep 2023 12:14:53 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68fdcc37827so877793b3a.0;
        Wed, 20 Sep 2023 12:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237293; x=1695842093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgjfA+NFbyOFJy7VI1AAXxPugeWclnjTAzkFxQOWY48=;
        b=WwCSkjFv5tRTj6IJGoHwKcs/5/p0ZTpjF008jIjD9UGKysdAoIQawEKUTuVKDguCDS
         b7gKLQLpn67K0BukRTK/ZFB3M3EqY70riqwjiEM/oew+d8Y3JSDS36yopN4hGLQc01DN
         6Xxro+oskWc4Pyx7tfw4pYX2BoiOLxbPFgGYCLvYemdprzulOiaNeJTAzpKdcZgLACOV
         oMPXz3iBaTtAacL/v+GoUQ0ygZPGLp/HBtDC7rS4qzrirV3lZngRk/sYansgiwvEFcn3
         T9a5X13fPuVHKLMkCKaQFTw1V3le73AMCgZDmZ67wnSFpGaQSItR/lmg9jDwMpFUdMog
         dzWQ==
X-Gm-Message-State: AOJu0YwRiII79sl8SLTCLvZjfWJSRs+DU+HFqfBR5FMbux8rcs0NJVB3
        7X2EbM+GR/94j4KeuvsigSAuQDe1jXs=
X-Google-Smtp-Source: AGHT+IEwSUN6YpTGWAKfPHwR8Rl/USX8Aye0jemdGclQ2Nh+Tz738zlB6D4H+6RdgiXus+f1lTCueg==
X-Received: by 2002:a17:90b:4f8b:b0:276:696b:1dd9 with SMTP id qe11-20020a17090b4f8b00b00276696b1dd9mr8659049pjb.15.1695237292721;
        Wed, 20 Sep 2023 12:14:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:14:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 02/13] fs: Restore support for F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT
Date:   Wed, 20 Sep 2023 12:14:27 -0700
Message-ID: <20230920191442.3701673-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Restore support for F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT by
reverting commit 7b12e49669c9 ("fs: remove fs.f_write_hint").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c         | 18 ++++++++++++++++++
 fs/open.c          |  1 +
 include/linux/fs.h |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index e871009f6c88..acaa49fb1a35 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -292,6 +292,22 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 	u64 h;
 
 	switch (cmd) {
+	case F_GET_FILE_RW_HINT:
+		h = file_write_hint(file);
+		if (copy_to_user(argp, &h, sizeof(*argp)))
+			return -EFAULT;
+		return 0;
+	case F_SET_FILE_RW_HINT:
+		if (copy_from_user(&h, argp, sizeof(h)))
+			return -EFAULT;
+		hint = (enum rw_hint) h;
+		if (!rw_hint_valid(hint))
+			return -EINVAL;
+
+		spin_lock(&file->f_lock);
+		file->f_write_hint = hint;
+		spin_unlock(&file->f_lock);
+		return 0;
 	case F_GET_RW_HINT:
 		h = inode->i_write_hint;
 		if (copy_to_user(argp, &h, sizeof(*argp)))
@@ -417,6 +433,8 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_GET_RW_HINT:
 	case F_SET_RW_HINT:
+	case F_GET_FILE_RW_HINT:
+	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
 	default:
diff --git a/fs/open.c b/fs/open.c
index 98f6601fbac6..9e31b8c50cc4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -942,6 +942,7 @@ static int do_dentry_open(struct file *f,
 	if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
 		f->f_mode |= FMODE_CAN_ODIRECT;
 
+	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 	f->f_iocb_flags = iocb_flags(f);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa11927..ba2c5c90af6d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1001,6 +1001,7 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
+	enum rw_hint		f_write_hint;
 	fmode_t			f_mode;
 	atomic_long_t		f_count;
 	struct mutex		f_pos_lock;
@@ -2134,6 +2135,14 @@ static inline bool HAS_UNMAPPED_ID(struct mnt_idmap *idmap,
 	       !vfsgid_valid(i_gid_into_vfsgid(idmap, inode));
 }
 
+static inline enum rw_hint file_write_hint(struct file *file)
+{
+	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
+		return file->f_write_hint;
+
+	return file_inode(file)->i_write_hint;
+}
+
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
