Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06A6C76E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXFPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCXFPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:15:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1A5BA9;
        Thu, 23 Mar 2023 22:15:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o11so881464ple.1;
        Thu, 23 Mar 2023 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679634934; x=1682226934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQGPf/wxZw5dZB9k3t/6PRKbx/yttZTmKCb/1ksWzl0=;
        b=c5ALrxiUW19AUSWFhy12QVwNPfxgfp8tHt/7gDna438Nsj9opnzfctw30uwzhjvd2G
         Iq7yn5RShlnSHmQDqcAxBIw8iYOkm3+OMrKCymekH772QpgGziPeHEvx7Zl5y5xwCpX3
         2csWFv2pqly7INK3AbIEyVHFKylRIdn4dMP5yRdrhOUeNk/TiZZjGtSJqVj1ekIxM0Un
         iAK7nzSgKkTZqTUA9fbiaYYdeTv4xm6gn5Joby6IhEGEaG5vZ3BXfc/ViWcPaXp16Pzb
         gNce5Mo8A/0AnglGFxba9AHv157QUdbGKHVmwnnNGLdDJWyjDJtrwe9C0LPFJ00nqA6E
         KyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679634934; x=1682226934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQGPf/wxZw5dZB9k3t/6PRKbx/yttZTmKCb/1ksWzl0=;
        b=D9U0JhWCa/5qlv0YlwOTonDmAxMbw1JGNurxeRvfa4pGY7LXqiARD+IN9DuhRYJSPN
         iia90dwMXsBGlTQZk8cjw9FKNkE3oRZZMwP0ddNDfIoac9DdRap2My9SR3c5eZOpcSpn
         qncPj49YZdawzYgbNksCjdBEImSWxhBXBymVTnltoLDtBFasx7sT1IuRCUw99ezoFjPY
         7I0ejdjUHcnjJKZggTLvmN2ReKN62+svp7SxoJpe+AXpyaHt/C8ahMHf2hGg7mkTTf7q
         WiTa+cuFhZ89hDIDFJC3qP0olMn2T4IBCd+7R/HVqd+eMQuG4sYv+DKnenhP05k8X4+6
         KS0Q==
X-Gm-Message-State: AAQBX9dNUn7cvvVVSOThvjoAjIMNshhiqb9sAxxtm0rfM4TotzF0W5Pt
        Pkdpzgd57jQ4fnWavgCmYrk=
X-Google-Smtp-Source: AKy350ZXtSxWObX8liqRFVuiuc1w50Vmku/WKG9OPIwZW+yXNhtc3gua7IPkNXC7kEeowMwG1QUfKg==
X-Received: by 2002:a17:902:9682:b0:1a2:1a52:14b5 with SMTP id n2-20020a170902968200b001a21a5214b5mr463332plp.3.1679634933693;
        Thu, 23 Mar 2023 22:15:33 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b0019b9a075f1fsm13246133plb.80.2023.03.23.22.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:15:33 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC v3 2/3] file: allow callers to free the old file descriptor after dup2
Date:   Fri, 24 Mar 2023 05:15:25 +0000
Message-Id: <20230324051526.963702-2-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324051526.963702-1-aloktiagi@gmail.com>
References: <20230324051526.963702-1-aloktiagi@gmail.com>
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
Changes in v2:
  - Make the commit message more clearer.
  - Address review comment to make the interface cleaner so that the caller cannot
    forget to initialize the fdfile.
---
 fs/file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4b2346b8a5ee..1716f07103d8 100644
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
@@ -1119,8 +1119,12 @@ __releases(&files->file_lock)
 		__clear_close_on_exec(fd, fdt);
 	spin_unlock(&files->file_lock);
 
-	if (tofree)
-		filp_close(tofree, files);
+	if (fdfile) {
+		*fdfile = tofree;
+	} else {
+		if (tofree)
+			filp_close(tofree, files);
+	}
 
 	return fd;
 
@@ -1132,6 +1136,7 @@ __releases(&files->file_lock)
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
 	int err;
+	struct file *fdfile = NULL;
 	struct files_struct *files = current->files;
 
 	if (!file)
@@ -1144,7 +1149,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
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
@@ -1237,7 +1245,7 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 			goto Ebadf;
 		goto out_unlock;
 	}
-	return do_dup2(files, file, newfd, flags);
+	return do_dup2(files, file, newfd, NULL, flags);
 
 Ebadf:
 	err = -EBADF;
-- 
2.34.1

