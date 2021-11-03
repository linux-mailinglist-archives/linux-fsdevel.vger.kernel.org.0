Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF1443ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 02:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhKCBSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 21:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhKCBSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:18:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD20C061714
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Nov 2021 18:15:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o14so681103pfu.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Nov 2021 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tt4c+HCmkgmidQwqgmKCZfOLXY12bkB9SNOCF2NcB1o=;
        b=lSNSFe25IYMAeT8CIcXQluTA9wzPmfYqpoE8woQMBo4WqCnaS77gfr2fh1AoakB8Z9
         xeWcbH1SnWm/fQ5+FFy23dbrwn6ENaigmax3dcDwCD/Q9zg0d2ZSxDM9EsM4LAK+UGTU
         rF2748mNYFlF4mGZy9X8Vpy5uZS8GEa7cerFRcge4BLJ6lPWzPuPHU7dusDa7fftszKP
         1quaHDNvobAFkeP/Ic4SKHhXBqkVxsI/eanI48ytay7A4oNmAF+0wSc5S4ySkTzkLIEw
         623cTHjp/VcgP4W8vCKIqXXOSaVJVE4h2QVgYBWvd/VIwBvxHjuihqAVvGGfSUtXWDgq
         z4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tt4c+HCmkgmidQwqgmKCZfOLXY12bkB9SNOCF2NcB1o=;
        b=mRIwUEkfrfGhH8mQ8QE4pqomutsh89zXf40Rp++OjTizhuS1fKsNp4dI/HMwlOcCWO
         8Q+k+JiWfSjtW/zZXvT/l+DY60rcDURfeK48Gf9RzZePaxlrnV23TmOBRVfmqRG3LKB1
         6kBl8K6UlXD9nEEGaDU/ax5ddf9W5iCy/oXBo7wSmtCJKH3w0RExZHhVlDrtxLwq+myk
         Pagns1mrY64N9ViJL5Zg+xxJsZMJ6LQ2M7CAZy+fhakFujlU3xtYmxzGnS8XID03lYpZ
         Cef3MPejilcLqywNlVZoudTzjveRjmo1R3HmuVHnxXlZ/cDKXTDcYYTTIJ71QhXengkQ
         BitQ==
X-Gm-Message-State: AOAM530wBtIHZKVeiSXJipehocDU+FYjV4gk9iderAaT8hU19xZqI92A
        zuFyxq1Rc75MHZE89R+NM57iy7dCJcGmbg==
X-Google-Smtp-Source: ABdhPJwqqBD3RMnjMvr7zL1EvPl2XS8FyaoubSMiZ6QRDhaG+QQK34N4RGUg11mTpFUE/AW6fjWa1Q==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr30593985pgr.407.1635902158899;
        Tue, 02 Nov 2021 18:15:58 -0700 (PDT)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id na15sm4116862pjb.31.2021.11.02.18.15.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Nov 2021 18:15:58 -0700 (PDT)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH]  fuse: fix possible write position calculation error
Date:   Wed,  3 Nov 2021 09:15:27 +0800
Message-Id: <20211103011527.42711-1-flyingpeng@tencent.com>
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

