Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1360E21B457
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGJL6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 07:58:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726840AbgGJL6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594382293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peCjidKRwR+RBlxI7zYOYscaYD5oe5qhntPw14M0mLg=;
        b=iDMx2h81Y24Uxlqc+RmOcpegGMQF488fI6wyUVTg+l8/HRBLA1p8PA3DEwFLBN+TjeOCP/
        tFbdTGYqnJtnJmQ5iZfiNpIOchhYQutXFUZpN3reFKutEB05q3eNsNT7cxVZdeWbvOstl8
        ej8fij4NJpEhQrHdeKw9lwt3WoiA8qE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-vM4nzDw_Pq-D9tQzAUrvcw-1; Fri, 10 Jul 2020 07:58:11 -0400
X-MC-Unique: vM4nzDw_Pq-D9tQzAUrvcw-1
Received: by mail-ej1-f70.google.com with SMTP id q11so6214408eja.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 04:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peCjidKRwR+RBlxI7zYOYscaYD5oe5qhntPw14M0mLg=;
        b=V/NiafQJwrRVugSSKK/0GXAZMyvnMRCKZwfgDVPznWOO/6KIrYsARuWbp8/6UeE03B
         Sr1QZ3j3tFqqLdHJMFXf1ASaXzajGy6qRWgdSLB8WBHwYoCfPnfIcRh/2vg01kmUXXt0
         mnWBKl1JyzW9jr7VA9Pn/irJQNE8lvHFgXh35oqcICaSHkH7USzLeGFzAv5VT7uU6ps4
         ls0XtTIVFxNYX3a9d0c92FLKBXtRLNnTNPcWx/+5VXarMyN4F57TCGqG8IT6DzMm0QxZ
         2mjmKPIhdWdtxQMb/2oqhU/WvmdQsBXpy716JWO2wv5CN1Rb2rjf20KJxmNf93xxUQr3
         dwTQ==
X-Gm-Message-State: AOAM533XbT3C9BexAzbVfEd480fY5PvVqH+3bUM2w6GC14HDae80tjvc
        rdVCUKPcXAjiWrghVYCl6DWxrsSBNE09MxegLa1IAgqTotoBCtULy0LJaEdRPC6hGURA0DaKXpu
        9LV9Sw5IMcsZk4WRwkWHMrMP8qg==
X-Received: by 2002:a50:d6dd:: with SMTP id l29mr77839834edj.345.1594382290242;
        Fri, 10 Jul 2020 04:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ1J1yGVzGiuAdROXz1nlPHbiIBzF9V3HelXSpltKIzf0uZeSzcg1mia0QOdMf27khar+V2g==
X-Received: by 2002:a50:d6dd:: with SMTP id l29mr77839817edj.345.1594382290050;
        Fri, 10 Jul 2020 04:58:10 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id a8sm3536951ejp.51.2020.07.10.04.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:58:09 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Stefan Priebe <s.priebe@profihost.ag>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 3/3] fuse: reject options on reconfigure via fsconfig(2)
Date:   Fri, 10 Jul 2020 13:58:05 +0200
Message-Id: <20200710115805.4478-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200710115805.4478-1-mszeredi@redhat.com>
References: <20200710115805.4478-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previous patch changed handling of remount/reconfigure to ignore all
options, including those that are unknown to the fuse kernel fs.  This was
done for backward compatibility, but this likely only affects the old
mount(2) API.

The new fsconfig(2) based reconfiguration could possibly be improved.  This
would make the new API less of a drop in replacement for the old, OTOH this
is a good chance to get rid of some weirdnesses in the old API.

Several other behaviors might make sense:

 1) unknown options are rejected, known options are ignored

 2) unknown options are rejected, known options are rejected if the value
 is changed, allowed otherwise

 3) all options are rejected

Prior to the backward compatibility fix to ignore all options all known
options were accepted (1), even if they change the value of a mount
parameter; fuse_reconfigure() does not look at the config values set by
fuse_parse_param().

To fix that we'd need to verify that the value provided is the same as set
in the initial configuration (2).  The major drawback is that this is much
more complex than just rejecting all attempts at changing options (3);
i.e. all options signify initial configuration values and don't make sense
on reconfigure.

This patch opts for (3) with the rationale that no mount options are
reconfigurable in fuse.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c            | 16 ++++++++++------
 fs/namespace.c             |  1 +
 include/linux/fs_context.h |  1 +
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ba201bf5ffad..bba747520e9b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -477,12 +477,16 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fuse_fs_context *ctx = fc->fs_private;
 	int opt;
 
-	/*
-	 * Ignore options coming from mount(MS_REMOUNT) for backward
-	 * compatibility.
-	 */
-	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
-		return 0;
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		/*
+		 * Ignore options coming from mount(MS_REMOUNT) for backward
+		 * compatibility.
+		 */
+		if (fc->oldapi)
+			return 0;
+
+		return invalfc(fc, "No changes allowed in reconfigure");
+	}
 
 	opt = fs_parse(fc, fuse_fs_parameters, param, &result);
 	if (opt < 0)
diff --git a/fs/namespace.c b/fs/namespace.c
index f30ed401cc6d..4a0f600a3328 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2603,6 +2603,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	fc->oldapi = true;
 	err = parse_monolithic_mount_data(fc, data);
 	if (!err) {
 		down_write(&sb->s_umount);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 5f24fcbfbfb4..37e1e8f7f08d 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -109,6 +109,7 @@ struct fs_context {
 	enum fs_context_phase	phase:8;	/* The phase the context is in */
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
+	bool			oldapi:1;	/* Coming from mount(2) */
 };
 
 struct fs_context_operations {
-- 
2.21.1

