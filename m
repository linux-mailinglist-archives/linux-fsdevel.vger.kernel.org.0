Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211F370FABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjEXPtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjEXPtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:49:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD24119;
        Wed, 24 May 2023 08:48:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30789a4c537so748349f8f.0;
        Wed, 24 May 2023 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684943312; x=1687535312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aImk2uu1cCysgQ8U53t2GJVGevPaRL+0/lCsb4kPA7A=;
        b=ea+MZZMqRmQfIWlvg9nR3KldDPydXVHLvjiEp5qgPd0drWpv+v8XqRQznGtk0puZwz
         aFjFyy0Se3r+Ag5/H4X4c9DoRgb+N/2DhoflP13Y4uz2IET7laYGgIaHmcFHuoPbnR+6
         pGCth22T4qrvQFelXGg1UjWMVgCTwpCjzwxIRwjVVdG47d93Huylo/rlMWp+OVdC3H12
         sHrEJ3bfFkgTbpCYDhqK9Sd3+/2SU9+NzD08Zg2QwK4hCRgO+o2Pz/8FAVdMcZGaq7ut
         exI+oQkaZcfXztZ+gTFMp7ZAKCWkfXjNhsVvc3nIavTu4h0va2fx7wqAzbCu0uC5AKzA
         84Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684943312; x=1687535312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aImk2uu1cCysgQ8U53t2GJVGevPaRL+0/lCsb4kPA7A=;
        b=eWFs+gIjNKN9pFsRViwkPw05v0cwKWbzsAKRAb0FCyvjp3GI/xVO+nf/4739HQjfCM
         q/2vS8zJFO7eUjwc+evEvR7spFMrrA1U2HT6ffpkPI45kmiisEUKNGv0SuY1ZEjdRtNY
         anes+oNWgATMv7iuUOh0apAyCn4/6R+6vsoKvvf8BOzZ84/FpyspBcbJ16C9i5F8bXLJ
         fLimXzYlTqRfgsz8gj6WpZa9n1CdoSbQtrvtBsyz3fK/n9Zo4sddVcZGov5g8LYRhKqh
         3OFFM5Q6a2kw9m5j9tjDrnSD0QpB6QzH+xHnI8RTA7LVCV2JSXe3W/95cxQodykNZwM6
         yNAA==
X-Gm-Message-State: AC+VfDyJXJL+DkRthYDXKVkPTfVaazC9QDgDkHvS+FLf7nAFH+L0VHYT
        eoZt5d/znQ7KsHBnUAW2GIJ2R0ruMiU=
X-Google-Smtp-Source: ACHHUZ6OIp9n0axGNymT78Gev/UL9Ol3dUkAptq2tNVHDclMDfDXc+lmWy+y68j+pyBBmPZAR/2yAQ==
X-Received: by 2002:a5d:4b88:0:b0:309:2b6:5c83 with SMTP id b8-20020a5d4b88000000b0030902b65c83mr219110wrt.1.1684943311859;
        Wed, 24 May 2023 08:48:31 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b003f605814850sm2718687wmj.37.2023.05.24.08.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:48:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] exportfs: check for error return value from exportfs_encode_*()
Date:   Wed, 24 May 2023 18:48:25 +0300
Message-Id: <20230524154825.881414-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The exportfs_encode_*() helpers call the filesystem ->encode_fh()
method which returns a signed int.

All the in-tree implementations of ->encode_fh() return a positive
integer and FILEID_INVALID (255) for error.

Fortify the callers for possible future ->encode_fh() implementation
that will return a negative error value.

name_to_handle_at() would propagate the returned error to the users
if filesystem ->encode_fh() method returns an error.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-fsdevel/ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This patch is on top of the patches you have queued on fsnotify branch.

I am not sure about the handling of negative value in nfsfh.c.

Jeff/Chuck,

Could you please take a look.

I've test this patch with fanotify LTP tests, xfstest -g exportfs tests
and some sanity xfstest nfs tests, but I did not try to inject errors
in encode_fh().

Please let me know what you think.

Thanks,
Amir.



 fs/fhandle.c                  | 5 +++--
 fs/nfsd/nfsfh.c               | 4 +++-
 fs/notify/fanotify/fanotify.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 4a635cf787fc..fd0d6a3b3699 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -57,18 +57,19 @@ static long do_sys_name_to_handle(const struct path *path,
 	handle_bytes = handle_dwords * sizeof(u32);
 	handle->handle_bytes = handle_bytes;
 	if ((handle->handle_bytes > f_handle.handle_bytes) ||
-	    (retval == FILEID_INVALID) || (retval == -ENOSPC)) {
+	    (retval == FILEID_INVALID) || (retval < 0)) {
 		/* As per old exportfs_encode_fh documentation
 		 * we could return ENOSPC to indicate overflow
 		 * But file system returned 255 always. So handle
 		 * both the values
 		 */
+		if (retval == FILEID_INVALID || retval == -ENOSPC)
+			retval = -EOVERFLOW;
 		/*
 		 * set the handle size to zero so we copy only
 		 * non variable part of the file_handle
 		 */
 		handle_bytes = 0;
-		retval = -EOVERFLOW;
 	} else
 		retval = 0;
 	/* copy the mount id */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 31e4505c0df3..0f5eacae5f43 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -416,9 +416,11 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		int maxsize = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
 		int fh_flags = (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
 				EXPORT_FH_CONNECTABLE;
+		int fileid_type =
+			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
 
 		fhp->fh_handle.fh_fileid_type =
-			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
+			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index d2bbf1445a9e..9dac7f6e72d2 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -445,7 +445,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	dwords = fh_len >> 2;
 	type = exportfs_encode_fid(inode, buf, &dwords);
 	err = -EINVAL;
-	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
+	if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
 
 	fh->type = type;
-- 
2.34.1

