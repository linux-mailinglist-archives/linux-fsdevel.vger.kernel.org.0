Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF105FEAFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJNIuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJNIty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510372793A;
        Fri, 14 Oct 2022 01:49:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n9so2681111wms.1;
        Fri, 14 Oct 2022 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi1PiA14Xvf0/+DfXuVtXD45G5BgebCQf9p57BfhR6s=;
        b=UxT7gVP8q9ze5Ggh2xvvktN6Ml02oBmfbyNFVTxcbcy6qgnZqVwI+fd54u0LJL+LjK
         y9EfYIAWCha0O2HVLdo55pAxb/IFOyVB4eHwuuXfLb3Q+WnwPgMtjSKPzu2oQKEhgIW1
         8w0WFdRg+RSJnOotAcs1Y+eSeMLVjAcWDFJda2lYZblubtGGGkakV9MIfwsDN7apZ3yC
         Rg00X0lJRAafbj8ZJHp9DjnqhMJlcm3+NYiLzY/y+FmG8gOcaLVVoEvJhhCVshISMbUn
         79bKI/g91GDk/8Ucsg8DPhwD6is+bLLgsNqiPgi18MPBUAdCAjxbT3q7n7tlSgWXhmL1
         RzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi1PiA14Xvf0/+DfXuVtXD45G5BgebCQf9p57BfhR6s=;
        b=Ndm+9e02EkIh90achuXSbJ5Oz39gvrY2P+g9PWS0pkPEAZUSDRXxaZvfu68vFJWtvD
         k4Cqs7CVRog3bv3EkdFXhLdDTyrqzNKbugAC2rVjujcRHo6l1jn7yx3UTuWfpV2WsDyq
         VmWuW8YMZ57QSM5DYYLqCnjg5EtWPjMAeIDIZLrWdiIayKRAkuxsgz/amZJdREd04Uw7
         f4aTyhdWNQVrY74PnXttlnKRfOj7PLareYj0vnpeoNRdUJ6xWhc0MPHQ6H3MOCfsDGGm
         Cz4AMRPrLGDOfST/JYIqoW3bE5iXXKdefy/vtpJ4h+zQ11uQKjAEadQ90q/94LX4SEBo
         z23A==
X-Gm-Message-State: ACrzQf0fiECU0BIEkYhgWm8MpfiHLZZwOT1HFtoIj+8Mf93VAjBH+N4k
        WnmgNldrEaELq/nDtoslTr4=
X-Google-Smtp-Source: AMsMyM4fbdkajcL2g53Tyvy1JDbblSDeQm14FaYqXK6zLbEPkMD7/YmebYTcS//ZYjYNy+t3nI8G6Q==
X-Received: by 2002:a05:600c:3044:b0:3c4:8af4:ecc5 with SMTP id n4-20020a05600c304400b003c48af4ecc5mr2758757wmh.52.1665737391668;
        Fri, 14 Oct 2022 01:49:51 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:51 -0700 (PDT)
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
Subject: [PATCH RFC 5/7] fs/xfs: support `DISABLE_FS_CSUM_VERIFICATION` config option
Date:   Fri, 14 Oct 2022 08:48:35 +0000
Message-Id: <20221014084837.1787196-6-hrkanabar@gmail.com>
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

When `DISABLE_FS_CSUM_VERIFICATION` is enabled, return truthy value for
`xfs_verify_cksum`, which is the key function implementing checksum
verification for XFS.

Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
---
 fs/xfs/libxfs/xfs_cksum.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_cksum.h b/fs/xfs/libxfs/xfs_cksum.h
index 999a290cfd72..ba55b1afa382 100644
--- a/fs/xfs/libxfs/xfs_cksum.h
+++ b/fs/xfs/libxfs/xfs_cksum.h
@@ -76,7 +76,10 @@ xfs_verify_cksum(char *buffer, size_t length, unsigned long cksum_offset)
 {
 	uint32_t crc = xfs_start_cksum_safe(buffer, length, cksum_offset);
 
-	return *(__le32 *)(buffer + cksum_offset) == xfs_end_cksum(crc);
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION))
+		return 1;
+	else
+		return *(__le32 *)(buffer + cksum_offset) == xfs_end_cksum(crc);
 }
 
 #endif /* _XFS_CKSUM_H */
-- 
2.38.0.413.g74048e4d9e-goog

