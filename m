Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49FA1C9F5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEGX5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 19:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbgEGX5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 19:57:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AC7C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 16:57:18 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id m5so2630061ilj.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 16:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YERqo/O0CpgSp6GICUF3/1ifgurCUdYJLrnvIdN1x8=;
        b=SYWQJ+YCPO+1BQsW1dytD0nYU7twT//urz+z/iwpvLCo7DTZxbH8ItmxKrLc9qdYKg
         vchJc/AR5zkgXz7tVhtJgTzpxm3klLYK11xHodMifgBsaH9S2RBP9RiaBDbJae5INVSy
         GhkdUNocSR4HsxMBxvtyK/CQR/j60P9DzTuD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YERqo/O0CpgSp6GICUF3/1ifgurCUdYJLrnvIdN1x8=;
        b=QrgFb1AJ8uZceTa6o8vduOvFX+RwlcMAKpZhzhdt5tWEtUT2gLFW+zaKDeYD4GQS8K
         ohubSrh38ziCI266eYl4bciA5w55T45kPg9N5x3J2BJF5nIjVOYAMLd72xDnZoknPN9E
         H9nOZWiaaC2iKisI/HgHo8980DCHGTnQFaC0ei0YAaeorpaf1n3OdHwiuIU5vvBjFiuR
         394w8DyG4LIOcQAHwSghpbDVlWP9YOSwKuCAEGwl9tqq0Ygjyh7TLRu9Tr4uWi1vU6ox
         5esLooVRpQHCPIwvZcQC5lgTiAr7btMeIsgmGKkFLJoMVPgt4iDR0WFTkrI9AUMpPGLL
         QELQ==
X-Gm-Message-State: AGi0PuY7Rhn6lkfeJTMQZAvf26kVRNG9lOE1GLYuG6wqXCa1p44RJvwZ
        Bv+2vKyl4qyiF12CK5mprIKXSA==
X-Google-Smtp-Source: APiQypKqHlNwMSQC9E2pjfwDU94VGlthfw04mg7vAiNxP1abahKSR5sOWkaEYm0byD44ICMxpXsFSw==
X-Received: by 2002:a92:d801:: with SMTP id y1mr17212948ilm.308.1588895837458;
        Thu, 07 May 2020 16:57:17 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f19sm1369893ioc.9.2020.05.07.16.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:57:17 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
Date:   Thu,  7 May 2020 17:57:10 -0600
Message-Id: <8b2cec548ea7f3b156038873b37bc24084a689ad.1588894359.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588894359.git.skhan@linuxfoundation.org>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
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
2.20.1

