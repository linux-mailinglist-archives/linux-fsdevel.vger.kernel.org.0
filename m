Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C05FEB21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJNIuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJNIt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58292CE31;
        Fri, 14 Oct 2022 01:49:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso4910366wma.1;
        Fri, 14 Oct 2022 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiJoxGZJlGz3xwdy8ebCPccYWzJULAWBypBIpnExuaw=;
        b=aQXy8rp4jlY1YgDvBq1bWyBZHXn7pusOKrg/5bG7Ec06kepOaaMYlnWN31PAE1PhO0
         TiKU6+usEJZY4E0qpN1rIEdfB92GVvNMKknsSFgjYfgeV3g+pzSFATmKMeE04UQL4scQ
         XjyUVRGfqMnFvZ7+ekfDI2ipLglMQJSCdWubbw9vB3pWX5ZABwG8+g26g3rlQoNdpz27
         C/0CQ6oChQqs+ufVKybV/tfloQQhEVBx2g+7BsjAS96KG2vlZDeo1BThWz9v5Fe5Xwvi
         Sf8I1muhzR3/vs9pECQZgEQhe44GnS7aptOVx0dr6ahIvicPhqcmhnIlZ5BnWfoJOlSa
         FNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiJoxGZJlGz3xwdy8ebCPccYWzJULAWBypBIpnExuaw=;
        b=efZDUhKpKdad40f70/izo/m8NbEOB4kcco+G+KS0gOBpciwGWBGUp3JC3gfV1dcGGp
         oYirj2ehDpZKN2uA7ytOa4yvWG6Mn6m/hc+zzNU8uvoIgovr8ZM1Ch9413/VbEfcipGY
         2XQzUKqlgQSCIWvcIH2xc1pWqYmY6/L+esZrov2ZyiZoOcM3l3oP2xWNcQdi/nE3cbPU
         5H3D1qMgA65b37PMKBseSqjgJFH3Wsc0CvYaFO6D0BkXViRoWnsH+u4Te6JuNAIsJhMI
         fbbjQCMmDEn7xHJYlgQv0EIa860wbGUKRdYNCC6+uBnfMagUgpV8ge4rzyXD9DNV+JYb
         U1Jg==
X-Gm-Message-State: ACrzQf1vrVoFe/ABJC1Bj92pOaZbd/cqdhIJm21zXQdvtuRoQNTR+N6Z
        2cb52MVxZDALTx56owFb4hM=
X-Google-Smtp-Source: AMsMyM4FolkT2bmNfdD1h/uAXB6K9stO6Eab/O3lUst48zrWp4fgQUhR7yOOFojOx5Y9yQD+bCbQ2g==
X-Received: by 2002:a05:600c:3c8e:b0:3b4:d224:addf with SMTP id bg14-20020a05600c3c8e00b003b4d224addfmr9435669wmb.132.1665737392984;
        Fri, 14 Oct 2022 01:49:52 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:52 -0700 (PDT)
From:   Hrutvik Kanabar <hrkanabar@gmail.com>
To:     Hrutvik Kanabar <hrutvik@google.com>
Cc:     Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH RFC 6/7] fs/ntfs: support `DISABLE_FS_CSUM_VERIFICATION` config option
Date:   Fri, 14 Oct 2022 08:48:36 +0000
Message-Id: <20221014084837.1787196-7-hrkanabar@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014084837.1787196-1-hrkanabar@gmail.com>
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hrutvik Kanabar <hrutvik@google.com>

When `DISABLE_FS_CSUM_VERIFICATION` is enabled, bypass checksum
verification in `is_boot_sector_ntfs`.

Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
---
 fs/ntfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 001f4e053c85..428c65ce9a80 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -582,7 +582,8 @@ static bool is_boot_sector_ntfs(const struct super_block *sb,
 
 		for (i = 0, u = (le32*)b; u < (le32*)(&b->checksum); ++u)
 			i += le32_to_cpup(u);
-		if (le32_to_cpu(b->checksum) != i)
+		if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+		    le32_to_cpu(b->checksum) != i)
 			ntfs_warning(sb, "Invalid boot sector checksum.");
 	}
 	/* Check OEMidentifier is "NTFS    " */
-- 
2.38.0.413.g74048e4d9e-goog

