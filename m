Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD679E2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfG3BuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36533 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfG3Bt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:49:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so29163037pgm.3;
        Mon, 29 Jul 2019 18:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xC2OMhdvxaLcA9We7nJNC9uJnugsrezxvB9jzWvgvfs=;
        b=ZJ/pOTcX70i3pJxOfMJ0R187ZTJcXEXsQOkZLMvoUDkHfEzOQD0CbPWvV6rIQSQso/
         J/4DvvhcXqcFuvNZ0QIE3LCvefC42aYyCRlJOylUU7na5VdgFiDnUZjn0QekEuHMUYzB
         FvIR7w48Y3O3lfURiBHAcS20jIE8rH1eE03AuDGI6g63Zhuky1g0wWAs4EpjHU42BKUd
         gNFCefrxVGaQ6oBI0uGmP1vD/mcPIS3rSCRNVGnJxtwyV7WB1++jAmiwHWxQx1567OdQ
         NaWwVs1Zbr9Jdzjr3gasypWX2zMNphChaearxJf7PNHKGut45z0UsUGtAWOJ1B8/YJP/
         L+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xC2OMhdvxaLcA9We7nJNC9uJnugsrezxvB9jzWvgvfs=;
        b=nOrnNGEFQwlukfnC1zkbf8cWEFDNnpj0eaYtxGujicdZmeTIN/02bX5L+bX0e43wuG
         tkqR6DjN2QlXCLJHtHPZSv76eoHx+/gmjKN4EPvHBxKp9sXwNiPQku4OfLU8rFNhkOiJ
         qp0E97FAgiOnn9FBHGO9xORZF7CJcQmwfudhwuyYt4YD5ZAzZ/0LaJ7b7/ldb0V6DBfW
         Z7GyD0qm6KVS71lFT1xNvSBYIDeVRKjvVc6N5wE2u6FBq0uG2iJsY+2SXqtFDOFTSrFN
         9S0Cn7oIIdLTAdAfq4XOuYuuxjI1OnGzL4JqjGnl6CKfPcIO9u+OERFo/Iy383Sc7LZm
         L+iw==
X-Gm-Message-State: APjAAAVkEyneJcgbh3OfbMrznkiI0rtYLnnmjJ26IKa6sM1mrQ/V5xYa
        VhWsXYHVk9SlMaA9wYCffH4=
X-Google-Smtp-Source: APXvYqwjN90VyCjAvq+0tZfhUxx2OyOgUKS5+4BbB5flOCXXyElRWY0uJnx0fdtJok+5LyYc/20JQg==
X-Received: by 2002:a63:f13:: with SMTP id e19mr106525919pgl.132.1564451399146;
        Mon, 29 Jul 2019 18:49:59 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.49.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:49:58 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 02/20] vfs: Add timestamp_truncate() api
Date:   Mon, 29 Jul 2019 18:49:06 -0700
Message-Id: <20190730014924.2193-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

timespec_trunc() function is used to truncate a
filesystem timestamp to the right granularity.
But, the function does not clamp tv_sec part of the
timestamps according to the filesystem timestamp limits.

The replacement api: timestamp_truncate() also alters the
signature of the function to accommodate filesystem
timestamp clamping according to flesystem limits.

Note that the tv_nsec part is set to 0 if tv_sec is not within
the range supported for the filesystem.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/inode.c         | 33 ++++++++++++++++++++++++++++++++-
 include/linux/fs.h |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5f5431ec3d62..0fb1f0fb296a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2166,6 +2166,37 @@ struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran)
 }
 EXPORT_SYMBOL(timespec64_trunc);
 
+/**
+ * timestamp_truncate - Truncate timespec to a granularity
+ * @t: Timespec
+ * @inode: inode being updated
+ *
+ * Truncate a timespec to the granularity supported by the fs
+ * containing the inode. Always rounds down. gran must
+ * not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
+ */
+struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int gran = sb->s_time_gran;
+
+	t.tv_sec = clamp(t.tv_sec, sb->s_time_min, sb->s_time_max);
+	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min))
+		t.tv_nsec = 0;
+
+	/* Avoid division in the common cases 1 ns and 1 s. */
+	if (gran == 1)
+		; /* nothing */
+	else if (gran == NSEC_PER_SEC)
+		t.tv_nsec = 0;
+	else if (gran > 1 && gran < NSEC_PER_SEC)
+		t.tv_nsec -= t.tv_nsec % gran;
+	else
+		WARN(1, "invalid file time granularity: %u", gran);
+	return t;
+}
+EXPORT_SYMBOL(timestamp_truncate);
+
 /**
  * current_time - Return FS time
  * @inode: inode.
@@ -2187,6 +2218,6 @@ struct timespec64 current_time(struct inode *inode)
 		return now;
 	}
 
-	return timespec64_trunc(now, inode->i_sb->s_time_gran);
+	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e9d04e4e5628..fdfe51d096fa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -726,6 +726,8 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
+
 static inline unsigned int i_blocksize(const struct inode *node)
 {
 	return (1 << node->i_blkbits);
-- 
2.17.1

