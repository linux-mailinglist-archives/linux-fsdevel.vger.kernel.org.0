Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2079E54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfG3Bu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34278 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfG3Bu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so22944751pgc.1;
        Mon, 29 Jul 2019 18:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+LRMSNrj6ysytmm99Rc/BfD1o0cWeoJWbC6wV2pjKo=;
        b=AOaRnw02TsiwbCxYhAlzGLg8nzDQpMpWKxAHBFB2a2RvzGYWBZFg5mRgPqCx4Vu/Ln
         F7AFryz6gakJOc7pt1+Mezu2nTV+CoYiOL0kEEDEplGq85bmjpgLLccmlg+RkfTCu6vA
         j2pCVHiq3XiXaquRa8YxS9yV/LSwebuWDnGqey3jTN7oa1PMiu5QXpqxjPR5zvMOg8hH
         LAev1+8dhbQDkV1bVk7/YLZuJXDimbINKT82EOpErLSxfD/z9gYMmjcue8T+bzhmVtTr
         DC5m/iDWQFAem/S70vYShqEKwYB81IyQocXsx9QoCdZfX8oI2+osvKNsj2t6+8Uh+4ky
         im8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+LRMSNrj6ysytmm99Rc/BfD1o0cWeoJWbC6wV2pjKo=;
        b=Ly8bwe+btewquGWf+6h6tkbJvPIp1+OnrrDpRS21jjiibwOS8/DJMs2MITkt2CLJsq
         SOuh6Nb7N+WGYg7wTUhQ4/a2niv7KNY3ZfcUXhizWAyo3IrutQ6/n8vs5VCRkSpGh8AU
         HG8XLAjo7qDSLrigGq7u3KnVa1BKYgLWJPB0JynFVS3kGSHS/X43iO1A1Ivv8/eT0c5b
         BYtfgvLOGhXe61wsy0IC11qOAgm7EktchMJ/bJCNd0lkhaq3GFuq9c0gVak/jzpAZP+p
         G7kyicLuPIGgIClOAgFpEw/2PhlTHdithobliDo3I0t1LJaN7nmk3skJs16NouBvkZM8
         EFzw==
X-Gm-Message-State: APjAAAWvDNFt6U2iZRpPKcWe/uOC13J2Zm2xS34OMKXfEe53hz2lSdHi
        KyrvMd8vdAsdsWLkJFTL7cQ=
X-Google-Smtp-Source: APXvYqzh6lY3nSUp4F9grKKAti8Q66DXm71R/Zu8sXqaO+Na/2RIljxHn26XwhCIyD2K77n58g3ICg==
X-Received: by 2002:a63:b747:: with SMTP id w7mr53077423pgt.205.1564451427431;
        Mon, 29 Jul 2019 18:50:27 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:27 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH 07/20] 9p: Fill min and max timestamps in sb
Date:   Mon, 29 Jul 2019 18:49:11 -0700
Message-Id: <20190730014924.2193-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct p9_wstat and struct p9_stat_dotl indicate that the
wire transport uses u32 and u64 fields for timestamps.
Fill in the appropriate limits to avoid inconsistencies in
the vfs cached inode times when timestamps are outside the
permitted range.

Note that the upper bound for V9FS_PROTO_2000L is retained as S64_MAX.
This is because that is the upper bound supported by vfs.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: ericvh@gmail.com
Cc: lucho@ionkov.net
Cc: asmadeus@codewreck.org
Cc: v9fs-developer@lists.sourceforge.net
---
 fs/9p/vfs_super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 08112fbcaece..ca243e658d71 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -69,8 +69,12 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 	if (v9fs_proto_dotl(v9ses)) {
 		sb->s_op = &v9fs_super_ops_dotl;
 		sb->s_xattr = v9fs_xattr_handlers;
-	} else
+	} else {
 		sb->s_op = &v9fs_super_ops;
+		sb->s_time_max = U32_MAX;
+	}
+
+	sb->s_time_min = 0;
 
 	ret = super_setup_bdi(sb);
 	if (ret)
-- 
2.17.1

