Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798DC3F0F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhHSA1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhHSA1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:27:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B6C061764;
        Wed, 18 Aug 2021 17:27:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h9so8322777ljq.8;
        Wed, 18 Aug 2021 17:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TB/XZBGPIVAOC56VciYkS4c+U53Iayfs//+43Dxn0UY=;
        b=LzrA6rYIvTj3n8pdQAsAtgJ26pLhb6CIHBT0zfuKWYz3M5oEf/rKazkStEBmaZKhaq
         jjgGUIjPnR0krSB++yEzGXPrRq+eHagwKpBNmNLwH61B/au0MPR2WIVvzZI45qLkJ3B8
         oQGIAbmjeWFvvfNax/zRDyTX5piaDcON3AMQkFsYdr9hHziRSk7s5lyGpAVx3udacUbl
         yxSiuitBivds4xf0IvZuHprFrtTWmuaZRXe9kNtlqz56gbDmRPeWktZht8kDKBMR4qJl
         yuLUzAH+FWNsD5Z9C57/Nf57+P3O8n/yqG1kuzaNZe13NhBJirugRhA1Ny9z7YCvsslC
         J8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TB/XZBGPIVAOC56VciYkS4c+U53Iayfs//+43Dxn0UY=;
        b=S4edgrUr+3OnFjtdEJbdhSs5EkZvtuYOnj4tPy1XYxloNx+oAUkz9zF65PUyWKnQey
         XPlG9Ma/kcbunSMMjhhoTfijKA53mCAOjmqplicpxRMB94gnq3vymdNIjadHZeqFlXuy
         gl7j+zLHQcDOj8vVnf4St+j/+NSABt70RZFtW6Xa5tfvZC47PHF7dSMa/oHW8lzdHCCW
         VtUOOWV7GZFwcp0xj7nPL01M8pwQQc088YFDgr0PQbRko2AU1pXUw/ZrL+DgcFZmVdaE
         02jN4bxtKDhJo2fajabS4rALF0jzBzchsVYhO7SSzIpx/c16DO60seZiiyLNdwEUz+KD
         dXyg==
X-Gm-Message-State: AOAM531fGoInVS4LR3FAzddlRowesLU2yyturrgD9p2IDeWV9PjIQLZu
        HHqTzCmvu2q7DoL5p3QUQLE=
X-Google-Smtp-Source: ABdhPJzWqGuZZycph73+9DAemhgxOKuVLuXMF7rsHuW033/8wK/igrGFIRakj3K1MUO4C+JNb39mjQ==
X-Received: by 2002:a05:651c:30d:: with SMTP id a13mr9420182ljp.393.1629332834048;
        Wed, 18 Aug 2021 17:27:14 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l14sm125907lji.106.2021.08.18.17.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:27:13 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 4/6] fs/ntfs3: Make mount option nohidden more universal
Date:   Thu, 19 Aug 2021 03:26:31 +0300
Message-Id: <20210819002633.689831-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819002633.689831-1-kari.argillander@gmail.com>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we call Opt_nohidden with just keyword hidden, then we can use
hidden/nohidden when mounting. We already use this method for almoust
all other parameters so it is just logical that this will use same
method.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 39936a4ce831..8e86e1956486 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -256,7 +256,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("discard",		Opt_discard),
 	fsparam_flag_no("force",		Opt_force),
 	fsparam_flag_no("sparse",		Opt_sparse),
-	fsparam_flag("nohidden",		Opt_nohidden),
+	fsparam_flag_no("hidden",		Opt_nohidden),
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_string("nls",			Opt_nls),
@@ -317,7 +317,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		opts->sparse = result.negated ? 0 : 1;
 		break;
 	case Opt_nohidden:
-		opts->nohidden = 1;
+		opts->nohidden = result.negated ? 1 : 0;
 		break;
 	case Opt_acl:
 		if (!result.negated)
-- 
2.25.1

