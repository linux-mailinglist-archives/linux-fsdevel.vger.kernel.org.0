Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA46319948
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 05:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBLEqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 23:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBLEqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:46:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05746C061797
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e9so4495869plh.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf/FNE2g9dFP9p3d4PnxWCRqpKSooOmCgY06BBUWQtQ=;
        b=D1dJ9Pxbb6GQULURKHNuG77hzlfdpyFwDfIJR/kdcgaKOm7QeDaVsVh7BxWEKBMFBQ
         TUh8hYE6LSrIJiTUxYE1NFvVpRrVqU65AVZVLxKlVm/Jyec+M8CIhJ/j354uZZVbTf34
         E4dy5KCHzyiapdvYwXs32ylZGzOeG5skr/tNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf/FNE2g9dFP9p3d4PnxWCRqpKSooOmCgY06BBUWQtQ=;
        b=VbbWYRN3Y0ff7GCy5w2n5nWa7CAlMSphHP45naAvXMYt1wBX1jkgXszJiCY/NHk0I8
         AJJBiWs7X8XkhEiu+8r1EXYmnsb9hq905U0PA3X7Icwla3SobMbnfSi+oCg/xB33aEJD
         HuP8adM2U98yqqUYsxjceazCiL/UE5gpukqt31xv5Uz9/fbkulvkz7/sZ7lugRvB7NRx
         EN7kIURNIXjw4yedlXiGuLBM8lGjEyNnn8B2iL4HHGp8MM1YvMfFuCZipdXzi/4i2g1b
         dIdWaGqb1s6DVAre4sTXDaVGt/bWHcthqurRODTWNBrDdqFK3xNqyDudxht6SrwvHlg9
         Pm8w==
X-Gm-Message-State: AOAM533MQIo78a0jyiucVpvuz43C7o/fUPR7oVaLUf24ZUDr1zSBbz6S
        24txDHytoncbtKIu9ycR2YC1cw==
X-Google-Smtp-Source: ABdhPJytZbcYqZrhtmpGfcJw/baVcFRWjDI0lVpoG2xuV81ph0vrPS4VW5luUG9QLhZoW8KGx2d7Lw==
X-Received: by 2002:a17:90a:9310:: with SMTP id p16mr1102823pjo.211.1613105096610;
        Thu, 11 Feb 2021 20:44:56 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:56 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] vfs: Disallow copy_file_range on generated file systems
Date:   Fri, 12 Feb 2021 12:44:05 +0800
Message-Id: <20210212124354.6.Idc9c3110d708aa0df9d8fe5a6246524dc8469dae@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

copy_file_range (which calls generic_copy_file_checks) uses the
inode file size to adjust the copy count parameter. This breaks
with special filesystems like procfs/sysfs/debugfs/tracefs, where
the file size appears to be zero, but content is actually returned
when a read operation is performed. Other issues would also
happen on partial writes, as the function would attempt to seek
in the input file.

Use the newly introduced FS_GENERATED_CONTENT filesystem flag
to return -EOPNOTSUPP: applications can then retry with a more
usual read/write based file copy (the fallback code is usually
already present to handle older kernels).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

 fs/read_write.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0029ff2b0ca8..80322e89fb0a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1485,6 +1485,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (flags != 0)
 		return -EINVAL;
 
+	if (file_inode(file_in)->i_sb->s_type->fs_flags & FS_GENERATED_CONTENT)
+		return -EOPNOTSUPP;
+
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
 				       flags);
 	if (unlikely(ret))
-- 
2.30.0.478.g8a0d178c01-goog

