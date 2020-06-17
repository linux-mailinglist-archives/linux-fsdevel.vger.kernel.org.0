Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082AD1FC7FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFQH5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgFQH5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:57:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42812C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 00:57:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so1564371yby.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G/fPjNKj6PNXBhhglcGDXFh+C2RJTmo0o/rYX7Lpb+0=;
        b=TluV8U8p4btHvRnG6E6rAe71kNH+BvrrGlEUayjO0HSPyFC+sXTxG1hYdqjhQRPKUY
         YDfNaP8YEbdwvHiu0XmRd3SNZSVbMyEDvebwv262dL8uHXfSd2dHrP2ZMHzf8smMGyf8
         aZSebf2M/SqHt4cF4SJ2tKEQvOlqkH606abeCiH0hh2KPEqZG0VysoQXAisisVGnR9hy
         CcDI6rzrx6tGcujgcyBKLSyDzqFCaSEA7l41SnukYRgykKsAYwIMcZDIQe5M8U1Mej2F
         vIl2mlIUiX9vxJe0t0YzmIQiOqjs+8O58+gZVqrIu/vEFjVjpOI9UWCeLB1Jn4CMO8zf
         luQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G/fPjNKj6PNXBhhglcGDXFh+C2RJTmo0o/rYX7Lpb+0=;
        b=mi3180rhZnz85XwviFzUFPlSqBubvRKHAtl58C4Eei6qcEWOmdQ/wWATxcqoYjVwVU
         EF5C6E2mc0uVFPmta4FIuhM6XjEH1eP5pc0li74mkOATLkpBIP6x8cTrFB2egQIJUeNk
         ztvDBoJo3wfDnWouIKagAjeBOn9auue+RbqyDQxwG37qA1oJjL8jvYMqh1++u4IaF56d
         MH581XZYxJ2k9EuD93dCWpnVN49t6IC9czhHEx3TNa9n5SFQQQQ2FZIWZ0Uy1Qykup4X
         lCGtIN0nueJBeGSV2qcSkc3m15ABN16F97tIsX6K0AmELA3U2wNGhnHeqfwGmBnH7gaT
         AerQ==
X-Gm-Message-State: AOAM530r2Fn0lpBkx1KoReLZz+zhVLpwlZbLqdR7/rv0LCgfhe9L/1Mc
        c4AfsPdH91aWoByYwG3C9hRkYuJ0Tac=
X-Google-Smtp-Source: ABdhPJywj8c0Uv6bj9+yC8+EAxU6RuQUxCW39QAO7pvXRpbIsrAXbcARnKWZPdo9CiZyYjT2VpEZFOaFlOA=
X-Received: by 2002:a25:2f4b:: with SMTP id v72mr10935088ybv.232.1592380658499;
 Wed, 17 Jun 2020 00:57:38 -0700 (PDT)
Date:   Wed, 17 Jun 2020 07:57:29 +0000
In-Reply-To: <20200617075732.213198-1-satyat@google.com>
Message-Id: <20200617075732.213198-2-satyat@google.com>
Mime-Version: 1.0
References: <20200617075732.213198-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 1/4] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption. This flag maps to the
'-o inlinecrypt' mount option which multiple filesystems will implement,
and code in fs/crypto/ needs to be able to check for this mount option
in a filesystem-independent way.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/proc_namespace.c | 1 +
 include/linux/fs.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 3059a9394c2d..e0ff1f6ac8f1 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_opts *fs_infop;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c4ab4dc1cd7..abef6aa95524 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1380,6 +1380,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.27.0.290.gba653c62da-goog

