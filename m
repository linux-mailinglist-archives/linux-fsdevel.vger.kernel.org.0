Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DD3151539
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 06:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgBDFGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 00:06:12 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:32996 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbgBDFGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:06:12 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01456AId025870
        for <linux-fsdevel@vger.kernel.org>; Tue, 4 Feb 2020 00:06:10 -0500
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 014565Th019703
        for <linux-fsdevel@vger.kernel.org>; Tue, 4 Feb 2020 00:06:10 -0500
Received: by mail-qv1-f70.google.com with SMTP id z9so10964076qvo.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 21:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=pz98ZlR3bR56pQ1i3ZQP3uFsFMXbwH6n0r2XfZ1ia0I=;
        b=YemlfoE7maKnpva86e9sv23AjpMLu/qEsxSObK1RS6Rf2XC33rrx6f6rqnuVuWZ0xF
         XVlT4Xep5naxVNAnsviWIUd8vSt3CWEfT0Jhw0fU/k1zZblQuegui2bmn1zYjPFJeSYs
         P89QKvgSA5UJvGYs0ystyF7LbAwleGoPcT33s9T73/J2o91iF0nksoJLTasSGxdM/DYO
         QweC5Pz3qzaKbfsijlxbcwTWOvWR5o/TcFw6Mj0GNbP4t0P2Vq2OJ7gLV/ez2VOUL1Jp
         ADF2BTEC/5eGFGKU1nZXn8+vOBY7CzK1mDZeo2c/usyKFVWqCp1prgPEFJSvKknpi/iV
         G/TQ==
X-Gm-Message-State: APjAAAU9HT8L/Jgb+gxAlsUKOyzE37ibbHT1wZBmheHH9lSu2O6A0u56
        RlWNwc1sD5pkgAHGHh6inDalk9NW4dAuWmjK+TNDCLC2PriQSRTpgJKYTR5U67aiL40iP13/8md
        XccdO5yb01XZPBIy3y0NwVO/fU6wa2e6qf1T8
X-Received: by 2002:ac8:4e43:: with SMTP id e3mr27432114qtw.129.1580792765274;
        Mon, 03 Feb 2020 21:06:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVWoIMwNoBeStRaw+j6XUPYd1HIGxOIIrMq0t70HtTsVrjAec0Q+NTOrEhNh1FQevpnMDynA==
X-Received: by 2002:ac8:4e43:: with SMTP id e3mr27432090qtw.129.1580792764954;
        Mon, 03 Feb 2020 21:06:04 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id z11sm10600747qkj.91.2020.02.03.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 21:06:03 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <linkinjeon@gmail.com>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de, namjae.jeon@samsung.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2] exfat: update file system parameter handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 04 Feb 2020 00:06:02 -0500
Message-ID: <328657.1580792762@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro recently reworked the way file system parameters are handled
Update super.c to work with it in linux-next 20200203.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
Changes in v2: make patch work with -p1 rather than -p0.

--- a/fs/exfat/super.c.orig	2020-02-03 21:11:02.562305585 -0500
+++ b/fs/exfat/super.c	2020-02-03 22:17:21.699045311 -0500
@@ -214,7 +214,14 @@ enum {
 	Opt_time_offset,
 };
 
-static const struct fs_parameter_spec exfat_param_specs[] = {
+static const struct constant_table exfat_param_enums[] = {
+	{ "continue",		EXFAT_ERRORS_CONT },
+	{ "panic",		EXFAT_ERRORS_PANIC },
+	{ "remount-ro",		EXFAT_ERRORS_RO },
+	{}
+};
+
+static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_u32("uid",			Opt_uid),
 	fsparam_u32("gid",			Opt_gid),
 	fsparam_u32oct("umask",			Opt_umask),
@@ -222,25 +229,12 @@ static const struct fs_parameter_spec ex
 	fsparam_u32oct("fmask",			Opt_fmask),
 	fsparam_u32oct("allow_utime",		Opt_allow_utime),
 	fsparam_string("iocharset",		Opt_charset),
-	fsparam_enum("errors",			Opt_errors),
+	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	{}
 };
 
-static const struct fs_parameter_enum exfat_param_enums[] = {
-	{ Opt_errors,	"continue",		EXFAT_ERRORS_CONT },
-	{ Opt_errors,	"panic",		EXFAT_ERRORS_PANIC },
-	{ Opt_errors,	"remount-ro",		EXFAT_ERRORS_RO },
-	{}
-};
-
-static const struct fs_parameter_description exfat_parameters = {
-	.name		= "exfat",
-	.specs		= exfat_param_specs,
-	.enums		= exfat_param_enums,
-};
-
 static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct exfat_sb_info *sbi = fc->s_fs_info;
@@ -248,7 +242,7 @@ static int exfat_parse_param(struct fs_c
 	struct fs_parse_result result;
 	int opt;
 
-	opt = fs_parse(fc, &exfat_parameters, param, &result);
+	opt = fs_parse(fc, exfat_parameters, param, &result);
 	if (opt < 0)
 		return opt;
 
@@ -665,7 +659,7 @@ static struct file_system_type exfat_fs_
 	.owner			= THIS_MODULE,
 	.name			= "exfat",
 	.init_fs_context	= exfat_init_fs_context,
-	.parameters		= &exfat_parameters,
+	.parameters		= exfat_parameters,
 	.kill_sb		= kill_block_super,
 	.fs_flags		= FS_REQUIRES_DEV,
 };

