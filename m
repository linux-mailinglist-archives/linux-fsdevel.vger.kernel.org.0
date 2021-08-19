Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894E23F0F71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhHSA1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhHSA1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:27:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416CAC061764;
        Wed, 18 Aug 2021 17:27:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so8385839ljn.1;
        Wed, 18 Aug 2021 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mLjxLSEHZbWDASGXk6f6L4oOTwEXpRclV6xV2hv/zQ=;
        b=KVGz7UtKDDA5D4dyMAchK21PYLITGd23DuesglQwSDdZKDgRcMgpgyfgbeI0spunGt
         +Zw+sr5Yybpq2ql2yqW+T5rob10oybFDgSlKBeIv7dlPjnWciq8vEoF10XzaoWGHSOWi
         Xmh8bzXgIw50kFs2m3bO3coWuw1n6F6Mwe/S9nxYsFzCx4uRRim9bWP3E4Amle3o34Lm
         gouiVf4vsP7BD84jtebstAw7NikELniQGlDnungnPv8coXHznp4ysEwYkgIvpKGN4giM
         oq1yq8n2Tkb8abEmNy+Ok2DLmhmJVY/l1ZakOUHtMqEg0CYDzoR36+D8aaNVna5/yK1z
         JBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mLjxLSEHZbWDASGXk6f6L4oOTwEXpRclV6xV2hv/zQ=;
        b=gCuCYnIt26IT201Xgy3WmQPxYAMQgTrRpHvbSCaw86Hy1td1DSDWPMVAllybYpJFKQ
         YssjQ3ZR35nAB8HGkkUyI7UPAwP8N7b1fglTHjlpoFtCcRlYRvwCNXOW4GzA5H5ktSRq
         xS/eEovBDWaYwbhfjhLy7xUnjy0n5kk38HuksWiXd/DtiWCpQD0neZME072QPlHDj8KR
         BCYEl/NDK7fmojZsqst5xGTA7BcwQcN72GuJE/f5XomIrlllIdNRZ4oCT7d1tyq7zxQz
         5EuSVDN6BALhEz/NYoU5SbL5oNI5/rsz5xPVNpLw/f/KO2FpeamrzUgTQiRl4DTe4Bct
         I1iQ==
X-Gm-Message-State: AOAM532tZtAjSZ0VfyBmfwSjPoAitmOF3lvawEFxDehEvouJAvNr+YR1
        SMdd40vn/xQmFpPjXjmG+Ss=
X-Google-Smtp-Source: ABdhPJzEz78zC8JxSKikbHOB2+HRAblmqMoJ/I20iwWQFQ422ar8BBo1ck1ZNqEn7R4GLt4fVTErGw==
X-Received: by 2002:a2e:8583:: with SMTP id b3mr9842869lji.389.1629332830685;
        Wed, 18 Aug 2021 17:27:10 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l14sm125907lji.106.2021.08.18.17.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:27:10 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/6] fs/ntfs3: Remove unnecesarry remount flag handling
Date:   Thu, 19 Aug 2021 03:26:29 +0300
Message-Id: <20210819002633.689831-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819002633.689831-1-kari.argillander@gmail.com>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unnecesarry remount flag handling. This does not do anything for
this driver. We have already set SB_NODIRATIME when we fill super. Also
noatime should be set from mount option. Now for some reson we try to
set it when remounting.

Lazytime part looks like it is copied from f2fs and there is own mount
parameter for it. That is why they use it. We do not set lazytime
anywhere in our code. So basically this just blocks lazytime when
remounting.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 081ac875a61a..702da1437cfd 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -406,8 +406,6 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 
 	clear_mount_options(&old_opts);
 
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME) |
-		 SB_NODIRATIME | SB_NOATIME;
 	ntfs_info(sb, "re-mounted. Opts: %s", orig_data);
 	err = 0;
 	goto out;
-- 
2.25.1

