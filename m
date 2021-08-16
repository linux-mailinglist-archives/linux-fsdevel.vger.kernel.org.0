Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C93ECCC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhHPCs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhHPCs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:48:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FEC061764;
        Sun, 15 Aug 2021 19:48:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f2so3280068ljn.1;
        Sun, 15 Aug 2021 19:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmNCCOG/QkF50ao7O8IMHnzvxCg6OfQtBUkcpafMR68=;
        b=IrnfiWLFX2mcONXfbS8zQgH4GdM8M76nvny3u0/pdeYgSGt/Rw87eaBwzr5hQYaWn2
         JCyuvxi4/Qx87T53K6QOpO7NxMulRPrR1FGU93kb2b0MFTVEnC49PPW5aJmOxKegGjtn
         iyHp9AIwCNqLMCqWqRkDIdQYyOhPCuWwhn63SEvQNP9dLQEBWcjLs1xKB64RSy3AaJMR
         HlYWAe8WjkZoahmCsQ/+VbPxsyc0n8gqhhMNzIY4DOc14+ty2nCuBU/BExMSjeL3zzFf
         U99muw46YaxdTOL8z6W3evOK7R7S3qsz1QuPKgqQnY7YLMcfiLl45WFtdBCAqgSr0nEm
         rjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmNCCOG/QkF50ao7O8IMHnzvxCg6OfQtBUkcpafMR68=;
        b=T32mC3mOFfIV2v6Z03j1kohq8L2LY4sJqryN97u68rJCq+RMevIP9g2pVaPRnP0GtI
         OA6Tcw1hKRPWregI/SV8x68oh3Ux34cFES0vpBR3HHyrXpfZGuf01Ajbh7G4lQQB++tP
         r7kg+EAdPKKKn/6kWaPKPjC1J/01OqTKTXpVxuI5Eid5gleqWB+hzjGWy+E5eoXSO9uD
         5IoQHwSyhvjEneUHH83inVWJRUxaHfEQ6IBlkRnQNBG4GS+GTt4t5EbzI6SpfWKs95Lf
         DUFgIOPJ3fPlnlCOwpuIJJ9vgox36/4T7OnVKfssCtAXNmsrDIzkmfZZzo5KREGlZcsA
         mDuQ==
X-Gm-Message-State: AOAM531LA4i4C4OCYqM/dFX84HkvXdSNs365cIKIFwx3tAWwUzhH6L8q
        T3T8u0JumUxghhjgTN+ebtI=
X-Google-Smtp-Source: ABdhPJyG43qe7hLfz7cK64Gy/xgA5B3A8KoPD1CV7ymqGqEZfy5PGp+igBUccF8+xY86I3w3zjzNCA==
X-Received: by 2002:a05:651c:10a:: with SMTP id a10mr7049739ljb.37.1629082104732;
        Sun, 15 Aug 2021 19:48:24 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b12sm425392lfs.152.2021.08.15.19.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 19:48:24 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 3/4] fs/ntfs3: Make mount option nohidden more universal
Date:   Mon, 16 Aug 2021 05:47:02 +0300
Message-Id: <20210816024703.107251-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816024703.107251-1-kari.argillander@gmail.com>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we call Opt_nohidden with just keyword hidden, then we can use
hidden/nohidden when mounting. We already use this method for almoust
all other parameters so it is just logical that this will use same
method.

We still have to think what to do with no_acl_rules.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index e4e2bd0ebfe6..2a4866c2a512 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -257,7 +257,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("discard",		Opt_discard),
 	fsparam_flag_no("force",		Opt_force),
 	fsparam_flag_no("sparse",		Opt_sparse),
-	fsparam_flag("nohidden",		Opt_nohidden),
+	fsparam_flag_no("hidden",		Opt_nohidden),
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_string("nls",			Opt_nls),
@@ -327,7 +327,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc, struct fs_parameter *param
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

