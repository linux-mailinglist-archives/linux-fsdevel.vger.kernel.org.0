Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB26094C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJWQlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJWQlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:41:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4BB13E81;
        Sun, 23 Oct 2022 09:41:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so1454277pjc.3;
        Sun, 23 Oct 2022 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Cu3DNts+pCDfLLsa4Q9GpOR28OVBmv+G8giTYg/EU=;
        b=RO5/jO1i2hC/VigegQdljK2K8JMj1QVRgMeVA4XppWM9E0aeFrN1PzhhTAxMPf0U1F
         GQ2E8oXQh5E7E2dpFDcJ/rdeNr0jt3tGFbkjTnX2I8QdoedkGw+U9z62ck8eWJrNmI5V
         KH1Z+CS6kpP6XMZtfb//JXpkvtrLbxAMJVw2GHPw4h4w9k4/dSzMISIdXIz4sN3ct/uy
         87/HQgL3vcoDkTHeoaSsgEPa90ClpIsOrj4nnVv+2bACVCahuxf7tBPr8Ngt0NrPdr7t
         8pOgOXXq0a2k9gfiWT6+E+8avdw9wPqZX2Iwb5/47S7QNvJPn/FDMb3WpMJmyAcpvpMg
         PO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1Cu3DNts+pCDfLLsa4Q9GpOR28OVBmv+G8giTYg/EU=;
        b=sGclB9WkFs+8CcAABOEFQG2I3tWtPBA0NswV4X56bf0XtJViHfCVKtWFSOj+KMU5Th
         Lw7HzsxQ3cxcjNfsggnX5MLNDRcqpFYOFeHHcwxZep+h6LJByWLYDJxi8jWxg6D4T5/G
         kWnVwQo9VNvq3MWBjF0KQKKbaC5doxxKptotB5ZVLCl+E9bt9+gIhnL6kXQ0Ka7EWYhx
         Qh55LOZdd4QV+K8PZIIdTT+/QP79qeuBESUQ/dg7pKm2uO4leTQhbUpkJhcFbjpcun49
         glbsggwYaNYeMd0+gdPgS6DQyU17icB0MzvMYDjBVQDvnDSpCYOVZejkXbDw1jcj14CB
         Lh0A==
X-Gm-Message-State: ACrzQf0MW1ugD1JIu4YGom1imIw2pwafMno6XZKxPBxOtoJQ3AXpf07x
        8zRZyeBx20MpL1G58K0KwtaY9E3KTceGguJtPps=
X-Google-Smtp-Source: AMsMyM5b9uLKDgvKeqOL6QRiWjFfI+W3L+9H/bOOcjuUrY5OrLVFjNSUX12EDlenDf538ZZxmDgdOQ==
X-Received: by 2002:a17:90a:d14a:b0:203:7b4b:6010 with SMTP id t10-20020a17090ad14a00b002037b4b6010mr69783916pjw.237.1666543274908;
        Sun, 23 Oct 2022 09:41:14 -0700 (PDT)
Received: from localhost ([223.104.41.250])
        by smtp.gmail.com with ESMTPSA id d4-20020a631d04000000b00460d89df1f1sm16148170pgd.57.2022.10.23.09.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 09:41:14 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH -next 1/5] smb3: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 00:39:43 +0800
Message-Id: <20221023163945.39920-2-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221023163945.39920-1-yin31149@gmail.com>
References: <20221023163945.39920-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to commit "vfs: parse: deal with zero length string value",
kernel will set the param->string to null pointer in vfs_parse_fs_string()
if fs string has zero length.

Yet the problem is that, smb3_fs_context_parse_param() will dereferences
the param->string, without checking whether it is a null pointer, which
may trigger a null-ptr-deref bug.

This patch solves it by adding sanity check on param->string
in smb3_fs_context_parse_param().

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/cifs/fs_context.c | 58 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 45119597c765..7832e5d6bbb0 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -858,7 +858,8 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	 * fs_parse can not handle string options with an empty value so
 	 * we will need special handling of them.
 	 */
-	if (param->type == fs_value_is_string && param->string[0] == 0) {
+	if ((param->type == fs_value_is_string && param->string[0] == 0) ||
+	    param->type == fs_value_is_empty) {
 		if (!strcmp("pass", param->key) || !strcmp("password", param->key)) {
 			skip_parsing = true;
 			opt = Opt_pass;
@@ -1124,6 +1125,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	case Opt_source:
 		kfree(ctx->UNC);
 		ctx->UNC = NULL;
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		switch (smb3_parse_devname(param->string, ctx)) {
 		case 0:
 			break;
@@ -1181,6 +1187,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		}
 		break;
 	case Opt_ip:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		if (strlen(param->string) == 0) {
 			ctx->got_ip = false;
 			break;
@@ -1194,6 +1205,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->got_ip = true;
 		break;
 	case Opt_domain:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		if (strnlen(param->string, CIFS_MAX_DOMAINNAME_LEN)
 				== CIFS_MAX_DOMAINNAME_LEN) {
 			pr_warn("domain name too long\n");
@@ -1209,6 +1225,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		cifs_dbg(FYI, "Domain name set\n");
 		break;
 	case Opt_srcaddr:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		if (!cifs_convert_address(
 				(struct sockaddr *)&ctx->srcaddr,
 				param->string, strlen(param->string))) {
@@ -1218,6 +1239,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		}
 		break;
 	case Opt_iocharset:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		if (strnlen(param->string, 1024) >= 65) {
 			pr_warn("iocharset name too long\n");
 			goto cifs_parse_mount_err;
@@ -1237,6 +1263,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		cifs_dbg(FYI, "iocharset set to %s\n", ctx->iocharset);
 		break;
 	case Opt_netbiosname:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		memset(ctx->source_rfc1001_name, 0x20,
 			RFC1001_NAME_LEN);
 		/*
@@ -1257,6 +1288,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			pr_warn("netbiosname longer than 15 truncated\n");
 		break;
 	case Opt_servern:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		/* last byte, type, is 0x20 for servr type */
 		memset(ctx->target_rfc1001_name, 0x20,
 			RFC1001_NAME_LEN_WITH_NULL);
@@ -1277,6 +1313,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			pr_warn("server netbiosname longer than 15 truncated\n");
 		break;
 	case Opt_ver:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		/* version of mount userspace tools, not dialect */
 		/* If interface changes in mount.cifs bump to new ver */
 		if (strncasecmp(param->string, "1", 1) == 0) {
@@ -1292,16 +1333,31 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		pr_warn("Invalid mount helper version specified\n");
 		goto cifs_parse_mount_err;
 	case Opt_vers:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		/* protocol version (dialect) */
 		if (cifs_parse_smb_version(fc, param->string, ctx, is_smb3) != 0)
 			goto cifs_parse_mount_err;
 		ctx->got_version = true;
 		break;
 	case Opt_sec:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		if (cifs_parse_security_flavors(fc, param->string, ctx) != 0)
 			goto cifs_parse_mount_err;
 		break;
 	case Opt_cache:
+		if (!param->string) {
+			cifs_errorf(fc, "Bad value '(null)' for mount option '%s'\n",
+				    param->key);
+			goto cifs_parse_mount_err;
+		}
 		if (cifs_parse_cache_flavor(fc, param->string, ctx) != 0)
 			goto cifs_parse_mount_err;
 		break;
-- 
2.25.1

