Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4116343AA5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 04:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhJZChh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 22:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJZChg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 22:37:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3CC061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 19:35:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f11so12776971pfc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 19:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tt4c+HCmkgmidQwqgmKCZfOLXY12bkB9SNOCF2NcB1o=;
        b=D6z6uOxhi+k1oVEDKVt+wlX1IZQSYksXAFNbhx+cvkUWe48p138cMUeSm8SKEitmVo
         /HQnluL6RA7geqyuKJEjvtFpzieBFakeuQMNlTTnxqfUbE+FPx3JtDxkvZiLXOKo0id6
         OZoXJiKx3yKUIjROnH/iPtmisb8aSB/e30/KQWWPkUo6gTi4UBSbrAHemYDcj5+UHCaX
         MdyhbcNjEghR9ej9R+Ppicq1ojskpu2eCnTr0dAIxP0lKSgAFj57Akf//KiW8XTezDFJ
         LqZ99DWC18D2n2ZTMQndFAwSJxBkohPC9sEGQEVb4HYZJpi3/Zgan3LdCS32WTpp1YUJ
         KSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tt4c+HCmkgmidQwqgmKCZfOLXY12bkB9SNOCF2NcB1o=;
        b=lWR6FXuBa3vYNq57DSj5d4xVGOBwNLoWQiPE33gaGpcRYzs3cmcmz+c7Z4fH0JXDiK
         Zvv6rHBxu86JDy0OZiMVq3t082eSKaKOBe5Ggd2QikYrTf3I2hd+qiJiidxYjDbkBnG/
         KvhYrLkOY8+NGBr3MC5px2oGjlL2lDQ4RFbrDD7WSs9i6zIeTCdwAHLpbtYkP2ZZJ8O8
         q+x+9NRGWlBfO8Qok504HAkibTuv60iYCYEL63KuWvJBWO7TmMlPlPpkmPo+bY8CMN7S
         aU4CtzsMiL4AS0g8IhaALisY+pxEPIqh2VXsoA1R5MjfCeXLtXZpSfnE9p2Zo4Br8a0f
         grtQ==
X-Gm-Message-State: AOAM531Sr85wpXMO8/lIpipOUL3YWhxbxP4oC6pamx4WFtUrNUVrkzk4
        TxW/hHL4NWCtgcCmgUvUWfYkihQwHAOovQ==
X-Google-Smtp-Source: ABdhPJzMDLkdH4tLSPklaB9Ozvpxp7l++bBtMamAxHkWwwGKAYSzV2EQxh/WkpY08CtRwPQIXFYQhQ==
X-Received: by 2002:a65:6554:: with SMTP id a20mr16802017pgw.107.1635215713191;
        Mon, 25 Oct 2021 19:35:13 -0700 (PDT)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id o10sm745246pjh.23.2021.10.25.19.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 19:35:12 -0700 (PDT)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH]  fuse: fix possible write position calculation error
Date:   Tue, 26 Oct 2021 10:34:42 +0800
Message-Id: <20211026023442.76544-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 'written' that generic_file_direct_write return through
filemap_write_and_wait_range is not necessarily sequential,
and its iocb->ki_pos has not been updated.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 26730e699d68..52aaa1fb484d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1314,14 +1314,12 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		loff_t pos = iocb->ki_pos;
+		loff_t pos;
 		written = generic_file_direct_write(iocb, from);
 		if (written < 0 || !iov_iter_count(from))
 			goto out;
 
-		pos += written;
-
-		written_buffered = fuse_perform_write(iocb, mapping, from, pos);
+		written_buffered = fuse_perform_write(iocb, mapping, from, pos = iocb->ki_pos);
 		if (written_buffered < 0) {
 			err = written_buffered;
 			goto out;
-- 
2.27.0

