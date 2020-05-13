Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1741A1D2314
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbgEMXd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732688AbgEMXd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 19:33:26 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54127C061A0E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 16:33:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e8so404424ilm.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUaoIVjv4yJVbgEJs+kFc4h5MmRY+QZnwp3EBlQupL0=;
        b=AOn02sBOw6rI0NNLd1GC3BYjmQUvTLcSjrXTztEWRq4Mny7gHvSQOuXcwhB1DG1zIK
         LmPDcv1PHxtRSmYDIijCw9gFwewYx+4zHXeb/92tPn+NLTkDe2hv3JoOuj5gSt0U/HAW
         nx7JRGerb5+ePP9ev2iBS9ORAjzvvAougqm0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUaoIVjv4yJVbgEJs+kFc4h5MmRY+QZnwp3EBlQupL0=;
        b=saNp7yq1k6DZw7MQXekc1wBWXIt+7C+6iz49aGu5Em7P7v2r7LYIRLmlJdXr2aUBTh
         YzdR4ZOVCIHxuKxgoI+c50gkrSv1nmplwbKNDFNTH+pThMv4f0YZvTC+0LMT7XKWk06t
         /g6/Lf246j3Xkcy7+mlmTA/uqH16dfvfhkcuZSWW9ujq6PosgiCiz+E4PhaWmSyVy3Oh
         pMXGeC9KHLYHIijsf4Yj6G/3qmf2H/tyYbVYQqfwZJo9/TlKrjuuDqVpIN0ut/5wartb
         hlFqN5q1+8BQOeywVc9m4xYM6kRcNop1aTyjMqqDDeKV4v9gUGcRMQVG/zO7I30GZik0
         0QVA==
X-Gm-Message-State: AOAM533NkObzyy+kFvtLxUmB1fwBcZsu9LfOT10vhg34Tus5besX07FK
        QFB5QCEV3664KUCWRQgHZmGL5A==
X-Google-Smtp-Source: ABdhPJynTVyMUoEORJzVp73FPhPB3uH0FFgzNgJAcDr5KLrfmAGEm4I66Y+wJYXBhHODi+pkS0ENQw==
X-Received: by 2002:a92:d186:: with SMTP id z6mr1906821ilz.119.1589412805697;
        Wed, 13 May 2020 16:33:25 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b1sm398072ilr.23.2020.05.13.16.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:33:25 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
Date:   Wed, 13 May 2020 17:33:21 -0600
Message-Id: <62659de2dbf32e8c05cff7fe09f6efd24cfaf445.1589411496.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589411496.git.skhan@linuxfoundation.org>
References: <cover.1589411496.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags. Fix it anyway since failed fdget() doesn't require
a fdput().

This was introduced in a commit that added kernel_read_file_from_fd() as
a wrapper for the VFS common kernel_read_file().

Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..16a3d3192d6a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1015,14 +1015,14 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
-	int ret = -EBADF;
+	int ret;
 
 	if (!f.file)
-		goto out;
+		return -EBADF;
 
 	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
 	fdput(f);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.25.1

