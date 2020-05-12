Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB41CFE8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgELTnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731045AbgELTnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 15:43:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8CC061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:43:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id n11so13638786ilj.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5f4RJYDHuVh6PmC6voPvbMaVVDseoYYhjdA/uiY/cuE=;
        b=dDiHF6QcMxQj56/4jqPt4rp/TqSru+DYb5YBX3ju2WcjAsD10UHXWv9eb12IepmgEW
         HSipt/qwzbvnX8XXGO4VQkcFHihJfgqksvGWHtpRW7GbV7Y96UrZ/KWBoGTMTyx51U7S
         HfvA/sHFw2IKN+p76Lc+RXjMrhy5RLIJulFb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5f4RJYDHuVh6PmC6voPvbMaVVDseoYYhjdA/uiY/cuE=;
        b=D4oU5ezCmgccYi4K/IM0V70m+Tp/UE7s7chtgzifDzc8OG/U9aqfTlUyqyPSatFPYL
         ahz0p7YGyi/jSnUyVdh7L74OfEEAioDYb67vR04AHzJmjMy9Gz6//fDU6sdSUeaQBCMS
         ch0nV67ZcgRjj5eYIE5792U3H8JtqmpBwsBTzPaRFP1ZOdMLM85cnjkt07WJkyFgca6h
         2lRzHJ3J/RWuHeQjWfvpvbW0QrfocffMxYkbcS5Z3NCvGQtimXXs+njJzOumtoIBpQiE
         C78WZLR5m4W6GzIeJGt7tKcF/H3KrKHXSQ/V8uhJUDTNpeKqACP+qbUWSOILdFy1f0uA
         KsGw==
X-Gm-Message-State: AGi0PubgtcoMIXL+osD/vy/sILGxw59Dq9RvwwNJxHI9jqTv7WqCDazN
        rJhjxGhOHhVFoJC7vy1oUTThPw==
X-Google-Smtp-Source: APiQypIV9anjY93T29+evCtA4VrmEbcf4OSTA50DnDtX7FtsaM8yY0lwTkE+9nA9jpVE3b3YvOfPVA==
X-Received: by 2002:a05:6e02:c74:: with SMTP id f20mr23535878ilj.86.1589312590842;
        Tue, 12 May 2020 12:43:10 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm6177781iok.4.2020.05.12.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:43:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
Date:   Tue, 12 May 2020 13:43:05 -0600
Message-Id: <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589311577.git.skhan@linuxfoundation.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
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
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..ea24bdce939d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 		goto out;
 
 	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
 	fdput(f);
+out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.25.1

