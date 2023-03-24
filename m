Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2249F6C7801
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 07:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCXGe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCXGez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:34:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426A1ACDD;
        Thu, 23 Mar 2023 23:34:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so704662pjb.0;
        Thu, 23 Mar 2023 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679639669; x=1682231669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUQZ9A3J239SKS0euUYgnsyRhfAE+VwqsZqicbX8r0M=;
        b=EmWfp6OVPaN0hmswipnd7n70pdHKjKZZaDfR30EYNqIOXifyBkx8mwhyiPCMXdoeLz
         tqNfu6kwiwa6xkBxR4z3iEqIcB54opOXLcqZBuigntR5yGs2fF4XX33mFpOBA2C60wQn
         D/UWppyeMfiO8i+xOeK9IHg1sqRvmTnNeykGAJdmkYTB0mpDZ+GryGwAGS6dB+f80p+0
         EFFtbAmkBN5ykMZmlVn4O66A/aJPtNGHCgpGCsXlQyXu2P8fkIBBD0qW2NWkC21cxDck
         hp7VJVjKABWMRvJn67NZzl+CHOTUY7EjRVYIAMRn+Mgy7AgcWTUCYAE0nxh2tDi+delU
         sq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639669; x=1682231669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUQZ9A3J239SKS0euUYgnsyRhfAE+VwqsZqicbX8r0M=;
        b=jxlWb/srpCgUNqdDtZtvl0GIDG8+KeTIHrgmVaDwB9ag+l1UDDDy4u96g+HgRnZ1uB
         yxApY95/JF/MYq0f6uCmYaJ5Y8u8KfFc7hoEdWklbPtRfnNvJBBOBy66hIPuJmwSO1bs
         7o0yZbkF7WJ3oUE91x1DCUMZ92Iy2f/jsVaB6cTv9GXdRUcoUR5zkiYkONgO/0KPzJeM
         /T9IgfePqJyADJx8NYqeQI4MQ44ucHlklQSd6c/7XCfXUiKbq5sopJKCWOXIw/7r3kq/
         M6iVpk2Q92zcu9N9oKCCsTw56s95lN8YH2fbrKDU0vAGPNIUiQswpYCP6/AvGrsfPFVP
         bDSg==
X-Gm-Message-State: AO0yUKVNBLZzQ3GluXshnDe5sJvLbwhEG7QOmMrcRSZOTfVfrbqf69Jl
        euBOCiFhwNM+48gQsE3eb6c=
X-Google-Smtp-Source: AK7set/1POkyTyiJK61hrX/J2XQiiHiwAiu2natNnZzVLMos+vo30I44aKZXldc2T/f6uyG773vTyA==
X-Received: by 2002:a05:6a20:3d0a:b0:d3:a13a:4c06 with SMTP id y10-20020a056a203d0a00b000d3a13a4c06mr3032257pzi.2.1679639669617;
        Thu, 23 Mar 2023 23:34:29 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id i10-20020aa78d8a000000b006281bc04392sm5401231pfr.191.2023.03.23.23.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 23:34:29 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>
Subject: [RFC v4 1/2] file: allow callers to free the old file descriptor after dup2
Date:   Fri, 24 Mar 2023 06:34:21 +0000
Message-Id: <20230324063422.1031181-1-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow callers of do_dup2 to get a reference to the file pointer being dup'ed
over. The callers can then replace the file with the new file in the eventpoll
interface or the file table before freeing it.

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
---
Changes in v4:
  - Address review comment for a cleaner if else block in do_dup2() to free the
    file pointer.

Changes in v2:
  - Make the commit message more clearer.
  - Address review comment to make the interface cleaner so that the caller cannot
    forget to initialize the fdfile.
---
 fs/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4b2346b8a5ee..cbc258504a64 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1086,7 +1086,7 @@ bool get_close_on_exec(unsigned int fd)
 }
 
 static int do_dup2(struct files_struct *files,
-	struct file *file, unsigned fd, unsigned flags)
+	struct file *file, unsigned fd, struct file **fdfile, unsigned flags)
 __releases(&files->file_lock)
 {
 	struct file *tofree;
@@ -1119,7 +1119,9 @@ __releases(&files->file_lock)
 		__clear_close_on_exec(fd, fdt);
 	spin_unlock(&files->file_lock);
 
-	if (tofree)
+	if (fdfile)
+		*fdfile = tofree;
+	else if (tofree)
 		filp_close(tofree, files);
 
 	return fd;
@@ -1132,6 +1134,7 @@ __releases(&files->file_lock)
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
 	int err;
+	struct file *fdfile = NULL;
 	struct files_struct *files = current->files;
 
 	if (!file)
@@ -1144,7 +1147,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	err = expand_files(files, fd);
 	if (unlikely(err < 0))
 		goto out_unlock;
-	return do_dup2(files, file, fd, flags);
+	err = do_dup2(files, file, fd, &fdfile, flags);
+	if (fdfile)
+		filp_close(fdfile, files);
+	return err;
 
 out_unlock:
 	spin_unlock(&files->file_lock);
@@ -1237,7 +1243,7 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 			goto Ebadf;
 		goto out_unlock;
 	}
-	return do_dup2(files, file, newfd, flags);
+	return do_dup2(files, file, newfd, NULL, flags);
 
 Ebadf:
 	err = -EBADF;
-- 
2.34.1

