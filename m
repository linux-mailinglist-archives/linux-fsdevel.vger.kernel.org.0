Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D263FAA8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhH2J5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhH2J5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987F6C061575;
        Sun, 29 Aug 2021 02:56:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m4so20067526ljq.8;
        Sun, 29 Aug 2021 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5JhVyRqtdJpuGBlvHxS0x0qfaPttBBsFZAiPeZDkRE=;
        b=qzYp3rH7/Jm8TDxr6yuA+GxjZA0ElQbz+XiSyKTodB3ODMiqYP6Z1EQ5n9KB2NIwTw
         2SvuQ+RKW2jsUtPbsUtkyHU0F9IavDD2WE6BKHNy41tM6LxZcN5Ff6VVaM6EdfKdUEqQ
         SPE2ql5GgbpuGftmpq2DpuZWToI8bxY65K0LDETKTkgbRgOl9agQJpyH6Dvkj5rhIXQu
         yDP7ycj8oV9G65tXPhwIzU5P8AqWGWhhWzYM/rVW8ECRD9PNt7XAF+cFYS5nX+W9hDFR
         9Q3OkArdxcj55YnD5JiYMD23jkuVL66GW1qazxsMyWMmOLig/yu52046SJZ1r2xyHdRW
         aWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5JhVyRqtdJpuGBlvHxS0x0qfaPttBBsFZAiPeZDkRE=;
        b=hPtzx0/uHJYCd2T36mkHqjqCdBltYh+Y6pdYRl2zx8j3i2h7bsjo2Y2yB4BZaRZJ/H
         8DqxIGNdPSwpJgXwBPZVtkre46w4VZxU9xd14zsbRKF83c12PM3rBjYmy8w2lUlDoLoF
         CMTusGbu73yDhlE7zwT/ZMgGraYTpT1uevxZWFw6ON69yteI/QcC8Xb5/nLothU0PLCx
         5fT9jRIQdm3lk7YdFbcjE9t09Y08q1RE7p47XdK+Ifs4AaZ9N8iVi6r5kLb+vJwyH0Ea
         1k3jY9/uNw0t/LZKuJUaVicR12yG4o/l/++LJ5xTk0sTs5BVDpY4fpIeusQ0694u3oeZ
         BgyQ==
X-Gm-Message-State: AOAM531oT72dY0UWdeDa/XfdBGfOGiFPnVifsTsBsF+gCVEKxhuPZXcD
        8L0GaCit4ObErQJFpnbHmIc=
X-Google-Smtp-Source: ABdhPJzvp+0/k+8fJsE1oNkghP54+v3DnfTEMaNOWwPx7Ct3+qO6Agd5rJZIQr2pxzu+SOwtXi9dwQ==
X-Received: by 2002:a2e:1514:: with SMTP id s20mr16140249ljd.34.1630230998034;
        Sun, 29 Aug 2021 02:56:38 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:37 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 2/9] fs/ntfs3: Remove unnecesarry remount flag handling
Date:   Sun, 29 Aug 2021 12:56:07 +0300
Message-Id: <20210829095614.50021-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unnecesarry remount flag handling. This does not do anything for
this driver. We have already set SB_NODIRATIME when we fill super. Also
noatime should be set from mount option. Now for some reson we try to
set it when remounting.

Lazytime part looks like it is copied from f2fs and there is own mount
parameter for it. That is why they use it. We do not set lazytime
anywhere in our code. So basically this just blocks lazytime when
remounting.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 267f123b0109..c590872070e1 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -407,8 +407,6 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 
 	clear_mount_options(&old_opts);
 
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME) |
-		 SB_NODIRATIME | SB_NOATIME;
 	ntfs_info(sb, "re-mounted. Opts: %s", orig_data);
 	err = 0;
 	goto out;
-- 
2.25.1

