Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461EB3F0F77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhHSA2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhHSA1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:27:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7E3C0613D9;
        Wed, 18 Aug 2021 17:27:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x7so8287001ljn.10;
        Wed, 18 Aug 2021 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOuni2n/29LbC0ytAK0Fi8GuUBVC6c+VlqLmnjT4LqI=;
        b=emAMHPR2eshcvqE3HBYuyFC4p3XBf3LMqQL/Mb5s/G07siv0KIi1+8HtbTEGrqkRT+
         /01tH6FRvnoM85cxpHdL72VrHIs+tQlYdD09YEiuJBBqj6aSqQ8tixp9CSBT68mcnq7f
         y2We3CorfLz/6ciy99TVZF00BjpC3BOZhvUgp+HUsktQ9EvLPn1w6fg1ZFT6OS/3Xb90
         ADtjbb/dHJ/vEkLpbfFNPWZ40bjS1Sx8loX+SjCEFnNpfCoRBnd7WxsHKjLYr0WSDKxk
         DBYeg2hFfJox56SAAsk6qYyzDCamx4L92zHgN03xTGGc30xar+lVlndErPkfHm0/u2M9
         b1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOuni2n/29LbC0ytAK0Fi8GuUBVC6c+VlqLmnjT4LqI=;
        b=c71afJhpIlVflAeGWpOTw2MSmT4rxyAQHS6Ts1h+EUf2KXwv1NXClqKQU9Z6flhslF
         mqPGzAKF+ie57en2KJjrc5nTpsMEIZenLvqdd3caCZtCvH+BTQjsRxMIler1cOS9HnQY
         pLcx1o/Hy9zHlo9hSD3ipzbueD6xwrvMtJLJKFVA6V02adU9kzR7Blk5E1o5DwCy5cQP
         TTd/WRvWmTsa4E64PPV1CjeTFP2l+1youZuCldAO21oy3Nai9zKzeqoW3Br61FL8/8rI
         xmIH77l9derB0maYE/KYkN3dEJSDM7wFEteAgLuw2g+I2VBaI80pOH6PyPH4tuvH2zay
         RYwg==
X-Gm-Message-State: AOAM530vhN9W4D1p8LXKQ9KuCR0DxhzEFXylv/yD/v/v175StUDZNoeC
        gf0mSH4pKdBRqIiVg/i+jNo=
X-Google-Smtp-Source: ABdhPJxCrzU2oaf6pHPW39AB8R+VNEta0gb/FOqjgHsyTDV/Qrr39Yg42+D8rgutlUtM2FVm7GWacg==
X-Received: by 2002:a2e:3914:: with SMTP id g20mr9926594lja.88.1629332835912;
        Wed, 18 Aug 2021 17:27:15 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l14sm125907lji.106.2021.08.18.17.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:27:15 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 5/6] fs/ntfs3: Add iocharset= mount option as alias for nls=
Date:   Thu, 19 Aug 2021 03:26:32 +0300
Message-Id: <20210819002633.689831-6-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819002633.689831-1-kari.argillander@gmail.com>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other fs drivers are using iocharset= mount option for specifying charset.
So add it also for ntfs3 and mark old nls= mount option as deprecated.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 Documentation/filesystems/ntfs3.rst |  4 ++--
 fs/ntfs3/super.c                    | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index af7158de6fde..ded706474825 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -32,12 +32,12 @@ generic ones.
 
 ===============================================================================
 
-nls=name		This option informs the driver how to interpret path
+iocharset=name		This option informs the driver how to interpret path
 			strings and translate them to Unicode and back. If
 			this option is not set, the default codepage will be
 			used (CONFIG_NLS_DEFAULT).
 			Examples:
-				'nls=utf8'
+				'iocharset=utf8'
 
 uid=
 gid=
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8e86e1956486..c3c07c181f15 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -240,7 +240,7 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_nls,
+	Opt_iocharset,
 	Opt_prealloc,
 	Opt_no_acs_rules,
 	Opt_err,
@@ -259,9 +259,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("hidden",		Opt_nohidden),
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
-	fsparam_string("nls",			Opt_nls),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
 	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
+	fsparam_string("iocharset",		Opt_iocharset),
+
+	__fsparam(fs_param_is_string,
+		  "nls", Opt_iocharset,
+		  fs_param_deprecated, NULL),
 	{}
 };
 
@@ -332,7 +336,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_showmeta:
 		opts->showmeta = result.negated ? 0 : 1;
 		break;
-	case Opt_nls:
+	case Opt_iocharset:
 		opts->nls_name = param->string;
 		param->string = NULL;
 		break;
@@ -519,7 +523,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 	if (opts->dmask)
 		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
 	if (opts->nls_name)
-		seq_printf(m, ",nls=%s", opts->nls_name);
+		seq_printf(m, ",iocharset=%s", opts->nls_name);
 	if (opts->sys_immutable)
 		seq_puts(m, ",sys_immutable");
 	if (opts->discard)
-- 
2.25.1

