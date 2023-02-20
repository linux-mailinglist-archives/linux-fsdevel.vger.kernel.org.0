Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7869D435
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjBTTi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjBTTil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802220063
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:28 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88A7B3F326
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921906;
        bh=UkUQubY1Bu38XsxKMjNY5NMQGaX63HQlYUrmxOQ8bow=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=WMwuniJ3/8IZMBAy9GRWU/oJefa83TEo9KgHBerGAbWbKtvXcKEFHZ4MWjuiA/arG
         m3MXgdFskOSG6bZj3jtFeUUb+0ZRHF/Kq3pR5c+R5CImkq/2D5Y0TP+vIZcFIJDUa/
         8/LNvsSMtJtGaOhb84yFWxMpvA/FZyB+sjhYok1QkK5tLVdfHhDpyPq03B64n4tc0G
         wI9t+vjtYHi9btAV4muN4HVAdK2MhJiywziT1wMEoCSzrGs/CHIvjvWe6a60ioXaKL
         2btBZfnn/FWDOC1EsQVeb6q7zHrD2rliM/e86dq7BMrfFfbJmicyzYDBUX0BPTvko8
         jOSf7SCTDYzkQ==
Received: by mail-ed1-f70.google.com with SMTP id er17-20020a056402449100b004ad793116d5so1065152edb.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkUQubY1Bu38XsxKMjNY5NMQGaX63HQlYUrmxOQ8bow=;
        b=bN7eQ9FMJ3J7mmX8kOwtKnKCvevJY3oKYb1fadU9D9I/saA6H81XdIFa7+oE71fIeb
         E7BSQ8SuVn6J6kDDc/vuSPz2x66sPQGQUnD61zwmFb5grK8fQbfvLccbmhnlgNWLyzBT
         sLipNL5PWgrl4g+jI1/LPJLNQ9C8XY0aln08IIWj9lnNG0l0VRm6Xus8tw0E+PAvIJb0
         C8p115uAxyFCs02Tpccnk/EsvoI8QFOBeeJPQjUAW1c+kEUGe7cKG5n9amijdVAO+h4n
         3lqLdQ75WhkrRcwJxKZaRwEkzaehu5BSOoG52da0bHFE00iw5GbaBPoph9aGqm7zWoxY
         bALg==
X-Gm-Message-State: AO0yUKUk04TPPhwzJ1cEfTCy8EHy+G52gSjdO+lczBYiZUGxovGzRlLC
        k/XvQI+6JpLIWbnDCDVSlVB4zZ0iGnXOOsbnU37EYJDQtBBlD9p6zkL5Anj3wNzA35pXSabyOpb
        biiUMALQ/vL+qYKD6mElf/5ejXpsqc/3gvyookaiPQnc=
X-Received: by 2002:a17:907:212d:b0:882:2027:c8e2 with SMTP id qo13-20020a170907212d00b008822027c8e2mr8368290ejb.56.1676921906406;
        Mon, 20 Feb 2023 11:38:26 -0800 (PST)
X-Google-Smtp-Source: AK7set96fcCzs+lPytOCWj2qNo6Mdct532xPl3ASVj3hsJmH6TzKtAV3cPadITrlTBOH7//xQsOeig==
X-Received: by 2002:a17:907:212d:b0:882:2027:c8e2 with SMTP id qo13-20020a170907212d00b008822027c8e2mr8368281ejb.56.1676921906261;
        Mon, 20 Feb 2023 11:38:26 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:25 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 9/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_BM_REVAL)
Date:   Mon, 20 Feb 2023 20:37:54 +0100
Message-Id: <20230220193754.470330-10-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This ioctl allows to revalidate all the existing fuse bindmounts
by performing relookup of all root dentries and resetting them.

Useful if it's needed to make fuse bindmounts work without
remounting them after fuse connection reinitialization.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dev.c             | 29 ++++++++++++++++++++++++++++-
 include/uapi/linux/fuse.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0f53ffd63957..ae301cb8486b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -13,6 +13,7 @@
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
+#include <linux/mnt_namespace.h>
 #include <linux/miscdevice.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2293,6 +2294,27 @@ static int fuse_reinit_conn(struct fuse_conn *fc)
 	return 0;
 }
 
+static ssize_t fuse_revalidate_bindmounts(struct fuse_conn *fc)
+{
+	int ret = 0;
+
+	down_read(&fc->killsb);
+	if (!list_empty(&fc->mounts)) {
+		struct fuse_mount *fm;
+
+		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
+		if (!fm->sb) {
+			up_read(&fc->killsb);
+			return -EINVAL;
+		}
+
+		ret = sb_revalidate_bindmounts(fm->sb);
+	}
+	up_read(&fc->killsb);
+
+	return ret;
+}
+
 void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
@@ -2389,6 +2411,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		}
 		break;
 	case FUSE_DEV_IOC_REINIT:
+	case FUSE_DEV_IOC_BM_REVAL:
 		struct fuse_conn *fc;
 
 		if (!checkpoint_restore_ns_capable(file->f_cred->user_ns))
@@ -2409,7 +2432,11 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&fuse_mutex);
 
 			if (fc) {
-				res = fuse_reinit_conn(fc);
+				if (cmd == FUSE_DEV_IOC_REINIT)
+					res = fuse_reinit_conn(fc);
+				else if (cmd == FUSE_DEV_IOC_BM_REVAL)
+					res = fuse_revalidate_bindmounts(fc);
+
 				fuse_conn_put(fc);
 			}
 		}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 3dac67b25eae..14f7fe4a99cf 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -990,6 +990,7 @@ struct fuse_notify_retrieve_in {
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_REINIT		_IO(FUSE_DEV_IOC_MAGIC, 0)
+#define FUSE_DEV_IOC_BM_REVAL		_IO(FUSE_DEV_IOC_MAGIC, 1)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1

