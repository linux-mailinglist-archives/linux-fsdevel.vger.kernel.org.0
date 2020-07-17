Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB103223071
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGQBfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgGQBff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:35:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F547C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:35:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so9502556ybc.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=;
        b=oxCwlxw8hiOmpc9dDE5VHP0nyw8uhX2w43IaKudLEwrXxdgnP120llEreKyOOyh1yb
         1WL8Dz+vf62oDSYhDCJMemrgkfz8WYWqfwvE/k3RuBACwKsg9UN/b/70jtV8Bh5s5ZUl
         WrqxtcHQKHwvgHTdS5R/09Di9WRfeq7aFwIAp6PB4QWEH0TDZQQYq6ccRf0UpNNMbFFl
         k4ZGdek4wV3r5+sTAIYfuP/jWrOw9Pbl+P1VkdzDRNqXM7DL0BJSJwO91JPyC0vA5ApC
         ngAIgB1BKgaFCSFN5dAUqxUK11W1Cw9dSBzo0il3J6r3PmLNgtmOY/hVfrka9zORhpXj
         ZLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=;
        b=Crq1aUoS+0Xv1zxpO02Tz7iCD1YcJOx2b3jdHoThE3n5SpbpRg5R7oI0FOkLTMMIdg
         HFQJ9VV5ECrJy6eGiAKCaArP0Nm+LYryBMYjxMd1SnH3MrKX5XZmZHe8+iLQV7useryW
         MeG3T5dRKRVBZ6J+u11kAz2zXp0TJqKHUTevaBeioCvqzWB7bDxumCGeiaFogsdmVw+2
         asKM7Z8Iq1ipVGi3SbHScoIT2sUmprcyCbehZL5ENqD+B9gG8pYj766PR9HhtmzpRRw3
         7pw+7kHNTkxlF4l6FQcpbcMkpkVE5CoDNMOtvKeudK1q7DZ5d6cFUqFESyDmfavskpE0
         wpdQ==
X-Gm-Message-State: AOAM533kTecRmLd3LoW04fYqpx2PXaGbmCDDqKAlp8UUlYKBeCPioosF
        8XKw4JKh0IBgEmczPrHW6xQH7Aj3uos=
X-Google-Smtp-Source: ABdhPJwyL6R46WRxWnDIfZEHMgiK0bcZUjuux5QdiBW2epiAYbnHUX5h5wXX6tXlXwwrx+N2jIvS0DNsy54=
X-Received: by 2002:a25:e790:: with SMTP id e138mr11127098ybh.114.1594949734407;
 Thu, 16 Jul 2020 18:35:34 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:35:16 +0000
In-Reply-To: <20200717013518.59219-1-satyat@google.com>
Message-Id: <20200717013518.59219-6-satyat@google.com>
Mime-Version: 1.0
References: <20200717013518.59219-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2 5/7] f2fs: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up f2fs with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..978130b5a195 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4082,7 +4082,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.28.0.rc0.105.gf9edc3c819-goog

