Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6274D7A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGJNct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjGJNcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:32:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD1E4E;
        Mon, 10 Jul 2023 06:32:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso50256825e9.0;
        Mon, 10 Jul 2023 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688995933; x=1691587933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IR/SjE3dnPHVw8ShE8Nrh5c0DK3TvPTsEq2pK74lhTU=;
        b=jJ08xw6Sd75S+VY6zBE37HsFMCDDufSujSy1vAgE4Xl6A210EoV0z/b4RGILd95a/n
         e1Jh+2CLNG5q524XO4llB0SYlsP7fHoR/iQy0ivw5Av8NT02qcnxCDnB6Gssw54kcL2c
         QWGuXOLbTFy0d2oCrzqCMLUDzhErP+2elSNtE0ynl8CJOlOGGy7R0tLUBZ6gXfG1BIdj
         nqeFbLPDCJ/3v+lFq0bfm1b2Ri8YDFmX7qbDYKoceXaNKuwq0umwq4/OzpJJlgA17mDh
         OM2qWJDUDkSkT2C0j5B7z7/VKcLo3L/UZijFbBi9R337Zyq6nSd+ZG5C3jWbFSLS5Nmq
         uwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995933; x=1691587933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IR/SjE3dnPHVw8ShE8Nrh5c0DK3TvPTsEq2pK74lhTU=;
        b=SYgVpvei9efTmnP6K1CkmSqz5bd9Pc3rTEE24dKf+UbbnTzUgGu8QHsL/ywkVNTpDH
         7Mpdh/Y23hQZTQs64KtBLyCC+NxqXOym5YuiTpo4N1vSPAz/Wf/ycNrxot75KCrrDXBd
         Ia2u7mda3C7ZifIhXYJHrtZ5WaqaNDtMhiX00qyCwHZrU2U1uojqmFwzCZF0rPgu4jF6
         2JaiHta7iJVkwVRtBrmNI0ewoDnclyh6uwWUfC1BBITyDsnJ1hwxkXzPFSCv8Fue8RwV
         8NLJ+yY9LFhLe6V8UhF5VS5ZQzy0wwMsQ/7U07kUSc6vaaKBcbsVTDc4Ho4IQlswsOsN
         vq5w==
X-Gm-Message-State: ABy/qLZARwv4cRs/YiERdDT2GIG31nXGq/07PXNrz60DIN/YytqHGmZZ
        v47fSbINwdSW8AU6vbfHF38=
X-Google-Smtp-Source: APBJJlHp/reV1NQnpTUVodd0zvT0GImMygco6EqeJKUKBWA9rOC6Zjr37LIBaNF+LSKmjhoasRPUDA==
X-Received: by 2002:a1c:cc0d:0:b0:3fb:b1fd:4183 with SMTP id h13-20020a1ccc0d000000b003fbb1fd4183mr12526041wmb.12.1688995932642;
        Mon, 10 Jul 2023 06:32:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d67c7000000b0030ae3a6be4asm11789263wrw.72.2023.07.10.06.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:32:12 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15] fanotify: disallow mount/sb marks on kernel internal pseudo fs
Date:   Mon, 10 Jul 2023 16:32:05 +0300
Message-Id: <20230710133205.1154168-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 69562eb0bd3e6bb8e522a7b254334e0fb30dff0c upstream.

Hopefully, nobody is trying to abuse mount/sb marks for watching all
anonymous pipes/inodes.

I cannot think of a good reason to allow this - it looks like an
oversight that dated back to the original fanotify API.

Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczxv2pm@quack3/
Fixes: 0ff21db9fcc3 ("fanotify: hooks the fanotify_mark syscall to the vfsmount code")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230629042044.25723-1-amir73il@gmail.com>
[backport to 5.x.y]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Greg,

This 5.15 backport should cleanly apply to all 5.x.y LTS kernels.
It will NOT apply to 4.x.y kernels.

The original upstream commit should apply cleanly to 6.x.y stable
kernels.

Thanks,
Amir.

 fs/notify/fanotify/fanotify_user.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 84ec851211d9..0e2a0eb7cb9e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1337,8 +1337,11 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 	return 0;
 }
 
-static int fanotify_events_supported(struct path *path, __u64 mask)
+static int fanotify_events_supported(struct path *path, __u64 mask,
+				     unsigned int flags)
 {
+	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1350,6 +1353,21 @@ static int fanotify_events_supported(struct path *path, __u64 mask)
 	if (mask & FANOTIFY_PERM_EVENTS &&
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
+
+	/*
+	 * mount and sb marks are not allowed on kernel internal pseudo fs,
+	 * like pipe_mnt, because that would subscribe to events on all the
+	 * anonynous pipes in the system.
+	 *
+	 * SB_NOUSER covers all of the internal pseudo fs whose objects are not
+	 * exposed to user's mount namespace, but there are other SB_KERNMOUNT
+	 * fs, like nsfs, debugfs, for which the value of allowing sb and mount
+	 * mark is questionable. For now we leave them alone.
+	 */
+	if (mark_type != FAN_MARK_INODE &&
+	    path->mnt->mnt_sb->s_flags & SB_NOUSER)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1476,7 +1494,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	if (flags & FAN_MARK_ADD) {
-		ret = fanotify_events_supported(&path, mask);
+		ret = fanotify_events_supported(&path, mask, flags);
 		if (ret)
 			goto path_put_and_out;
 	}
-- 
2.16.5
