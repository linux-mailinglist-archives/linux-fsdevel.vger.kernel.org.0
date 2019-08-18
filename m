Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7989591818
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfHRQ7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43599 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfHRQ7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so4618476pld.10;
        Sun, 18 Aug 2019 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+LRMSNrj6ysytmm99Rc/BfD1o0cWeoJWbC6wV2pjKo=;
        b=u0p1xnlWIscokdPFGB1xYyyYkHxHQ1EL+oy8mcZPSMZFggyqqZZ0F9/0+kW22duHD/
         8ju4CMdUcg5dqW8NFvrLjqsPO+3+tcTuwk/zJhzsiYRNobzXm67Xt4msC8U7Gs2RrvU/
         JTyWeqsdkz6Bd3Mer0vl5GbuRd4FHNEKuREypUk8XTJDC5gE68zNpQzwDj2hnam9Ow30
         WEohjyeaEX/tYbtjEMkgHqo8Mt2G5ijBEH8TXthmxHiahwTHkqtFUQmCuGyvxIXPhdRD
         DZo4MpwSedXBGn7w9nPknrg5pDuKae2X+zorJK7HyvQ2p4xWml8IVwIv/Y69Byr8lTb+
         Ajdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+LRMSNrj6ysytmm99Rc/BfD1o0cWeoJWbC6wV2pjKo=;
        b=qkmSRFCXFNkjp8zPk0XkPP59LeSlXs/nUSY13epvHVSrOXehjYhvDMhJ0lo0PdXz+z
         2o1iwuubiWJnjgns/KDuOwDWYPAFXOfk9z4rFVKYbPXLcgiXx+fmlS+9XJ7loiQiXUfH
         UOvrLC8Yjj6vavEsU1MvWFPWYqk9oXNt8Y925/ZAQXFRyHgHz40u6JcrEDpiBK4czqEr
         CwcXWqEB2oQRNi0bD6KlT1IDXyTpgYN5K+04xlK8zg4phSFyHrlXiGhDfcGFR5G573uR
         neCK64IU1daMG71stDa1lYSdHGl2eWS0tETvGQUk45rXRmkUOTEZVvjDXhEA/nLn5xlC
         XmdA==
X-Gm-Message-State: APjAAAWPlvc/Ctb+3F4r2QQPDkmH9pdmkCDUJGwmp3TtNbHV4nefTUmC
        Ui2dA2nI2UVipV1co1f2R64=
X-Google-Smtp-Source: APXvYqz112IoLRouv9ryA9wIoo9SK+U9diVimz4rMdCo6J+hyGg3GbdOEHSKOlp7hb6NH7QwtSqJVQ==
X-Received: by 2002:a17:902:e406:: with SMTP id ci6mr18220361plb.207.1566147588404;
        Sun, 18 Aug 2019 09:59:48 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:48 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH v8 07/20] 9p: Fill min and max timestamps in sb
Date:   Sun, 18 Aug 2019 09:58:04 -0700
Message-Id: <20190818165817.32634-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
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

