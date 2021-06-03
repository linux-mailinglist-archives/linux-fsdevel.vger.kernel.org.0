Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50821399E18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCJwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCJw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:52:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4A5C061756
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jun 2021 02:50:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d4-20020a25b5c40000b02904f8e3c8c6c9so6952992ybg.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kR7sRAYJgYzXAltawUkgM6QLDKs+TdWaYFMXl70NU30=;
        b=LJKZ6LsL2aYsJR1+AehJQAJ7FIgxPEQJIitSrKRyU7XfGtmDPMPSNJEHLM8HTRS5m0
         dWlIDs81zCAdesoohP+0GRT1s3FWql/S2+zquZr7AgfYstU4BGdkDoRjh63t9CQXvwPf
         LtAAb9RqanCPcIgZWoHx4PsRswyPai5x9KKxBFLKC4ZXzc/kRkITdtGrYzTkwlNGCBaG
         XIUQ8dQo/rYaOvXyTufGfx6C2LmrZ/ZbiUoCeX+RX7rrm5jeKYCTHZ77w07DPYopaYMb
         uM8WpcWu30HynSfGekZZGg13SEbYvOHMSZ7QS/h+jHGv6bcNXYpPJRZ/nYl9y1OM7qUQ
         9YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kR7sRAYJgYzXAltawUkgM6QLDKs+TdWaYFMXl70NU30=;
        b=KMkD7sBe50j5LZz1uDUfSlNOCihjHaz7a7yYlJJZcrQ6+gSkBUBXNsnqZKvMdWbQvC
         n3dw6LWBsRUVgHakgnEpzBW5kKEj8S2ZLOY5as1BtSV4ugkkJVTaatPLTkJC0pXo+fKr
         5Hi88r4iQBEZdQQSzEoEzEvpaFpL1HlwBdEl1bqrExptX2LA5DI4APqMheP0Oe2vrynf
         yqstkqxtB7WydYsX1umvxC0Ap9a22qHBYFtSDkMTomLsTNOCHriPuWkS2mv/cedBlAX5
         dI6TsA3HgUsAomnM78+aD57icRjsituJjyFbCs0kDmHfemQWkiPhk1dyTxfp2zYAoPbD
         xLKA==
X-Gm-Message-State: AOAM530o9pDCHj1PYLErcujWJxYp3+7fB4szlf13N1faJphGmgKCV2/K
        NIyBMLRaetGcB+IeRHgn8qA/cgKwKhc=
X-Google-Smtp-Source: ABdhPJwg9zQpmTee0HJgwJoqlYYAiV6WD/aVlCidtVhW+RhGawkkIOnjZoxsSBgw9O6LZXS5cWzq2nbANLM=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a25:3d6:: with SMTP id 205mr9832485ybd.350.1622713844030;
 Thu, 03 Jun 2021 02:50:44 -0700 (PDT)
Date:   Thu,  3 Jun 2021 09:50:37 +0000
In-Reply-To: <20210603095038.314949-1-drosen@google.com>
Message-Id: <20210603095038.314949-2-drosen@google.com>
Mime-Version: 1.0
References: <20210603095038.314949-1-drosen@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 1/2] f2fs: Show casefolding support only when supported
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The casefolding feature is only supported when CONFIG_UNICODE is set.
This modifies the feature list f2fs presents under sysfs accordingly.

Fixes: 5aba54302a46 ("f2fs: include charset encoding information in the superblock")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index dc71bc968c72..09e3f258eb52 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -720,7 +720,9 @@ F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
 F2FS_FEATURE_RO_ATTR(verity, FEAT_VERITY);
 #endif
 F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
+#ifdef CONFIG_UNICODE
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
@@ -829,7 +831,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(verity),
 #endif
 	ATTR_LIST(sb_checksum),
+#ifdef CONFIG_UNICODE
 	ATTR_LIST(casefold),
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

