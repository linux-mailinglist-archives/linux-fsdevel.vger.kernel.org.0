Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEC402BF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbhIGPhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345453AbhIGPh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EFC0617AE;
        Tue,  7 Sep 2021 08:36:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m28so20332099lfj.6;
        Tue, 07 Sep 2021 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfTZD2BK9OlT42vnGAs2eW6uulsF/+Be/8upspiEcGI=;
        b=nn22WeONuQDWrItj4HpTHAQ7dwAX51UBc43MhAZjGfRsvushjj5dGhl96Tj/djaRXk
         lSawt8oBukDPxxNw+wmfezepiWpSmRJ9LEVm1+XEuzykX1R1d2DeIUH/RdYJnlQW8tk3
         euXuamsehkVBr1qgdoyJVT34kwcv1vEGbuVUSvGlcDfZ9732AgqftgSDzbaijBIR58Ol
         eWWkQZK1TAa0atmDZJMqiHR3mmL9xybJCFFZxKsJQv3LQSOpspKXJy8yWs7ZM0m0pF15
         LWDkz/2cojQ04z5BtTImODXX4nW/eBHDxbyHftO6Z9pVyA1HiIs1zSYgMlGBTFIo0BQb
         L4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfTZD2BK9OlT42vnGAs2eW6uulsF/+Be/8upspiEcGI=;
        b=XBCK0vgVGesesczAdn0QQtEZgrS7fzoySzKApFpGk3TxJwjH35SiXQLwiEyt1253ZR
         dYzmlsUQ3gJOhLt/+GFgsNxu6SBkfd/ckKTluMetxwxDw5hmjCBwuBfGhcSf4a+30Pc1
         XZ3impqcijyf6/Vd5tzHrQRfomxbodImLySm6kTp13sjLUyeQL8+VkiMj8yjMmu8T0Zj
         IfWGcmEsnh7H3Oc6VJE5IB7OBhB1tCDO5E3s/d4/4zhih1Fy73P5+0jMAMQ1BFxYBKRB
         i7pxD23VQ/N4DRnaeG5yUMH/VAA9pUkT1h24TDEHs8ZRu823ce/jgi6JumxhNZ0GkG6T
         abbA==
X-Gm-Message-State: AOAM53014HwjkNAb7d16vj+HJANOjjVXFotGU4mD9gu1Uu1BT4ot2HEt
        +q+RBJUjCgsXYqZF0HH7x1A=
X-Google-Smtp-Source: ABdhPJy3n1OhoIgD3JgIRKoHX/v4Q75f0ng1LbQuWlanfiAQN5PzM7HDJWkJcWYH0J3xw3H1k+67Fg==
X-Received: by 2002:a05:6512:388e:: with SMTP id n14mr13431241lft.242.1631028979649;
        Tue, 07 Sep 2021 08:36:19 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id p14sm1484458lji.56.2021.09.07.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:36:19 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 6/9] fs/ntfs3: Make mount option nohidden more universal
Date:   Tue,  7 Sep 2021 18:35:54 +0300
Message-Id: <20210907153557.144391-7-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907153557.144391-1-kari.argillander@gmail.com>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we call Opt_nohidden with just keyword hidden, then we can use
hidden/nohidden when mounting. We already use this method for almoust
all other parameters so it is just logical that this will use same
method.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 420cd1409170..729ead6f2fac 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -242,7 +242,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("discard",		Opt_discard),
 	fsparam_flag_no("force",		Opt_force),
 	fsparam_flag_no("sparse",		Opt_sparse),
-	fsparam_flag("nohidden",		Opt_nohidden),
+	fsparam_flag_no("hidden",		Opt_nohidden),
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_string("nls",			Opt_nls),
@@ -331,7 +331,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
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

