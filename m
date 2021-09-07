Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A85402BEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbhIGPh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbhIGPhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D652C061575;
        Tue,  7 Sep 2021 08:36:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so17245915lje.2;
        Tue, 07 Sep 2021 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wnl5XEhkh1MPnWBnjk0/9SddCZUQ/Patup1iPbeWRo=;
        b=TrcQyDIOury2E1YNGllTiyd9zQIT/S19byBaL6Tkko9MZoj++wOT6b4iYeAjiWY6u2
         MsDFIXsUnf5r9rIOr3cYnlQVTX/u/9H9gqFhw89/QjV3GlFyOjuG6JBXvD3NRUATM+VV
         +ebQHQ8DFhzxIwBG+X2VAifnkbfcwKKRhqMvIcTPHYEQZ8YUkxbxKglVQ85p/+4hO723
         Dbx98HjId2Yzs6YNVKGBoda/ojZU3K/EW4H+JLikgsn9ZgI1FoqVoiMNSd+GAUTC1gTt
         PhUdNHqFvCIDhyQTAzJpjV+c5hUF2qSJZgMY48va8ICmz2y6SbrkNM6EYNaDUYyrqIDi
         Tz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wnl5XEhkh1MPnWBnjk0/9SddCZUQ/Patup1iPbeWRo=;
        b=kZnUhuYpMqGKL4n1wD4KSHdz+rcPyLNyieOK7GpDofHpCg8HKzxXQnpH0gVUh9Dgys
         lVwMEn87SEfGKSROKjoQXPDLrKF6ayZZdcirfJjaHa+4soANH5TSLeFDwcmFEf46QU5s
         rcq9Y/5tbTiBgJVg2a6ZvcT4PzNO7kPEbZowKvF4rhrTIiTv9DE7gVvH2UswckEUJXd6
         Q+cun5CecUnJKF9Heg0FZ+W3m450tSAJPhOMj1L31bOj58PT7G279OCKoexOwG/YE5ue
         MKnlhVF5bD558xTtmmT2uOl4EODhAZKVk+iGfNw54liCbTQfYgzkj/o+G+Ad/1QILHmp
         f2WQ==
X-Gm-Message-State: AOAM531L9vzKIqwhmsFmwLQ+LNi7KS3Ii3bApL2cUViRXQp0xr01qp+C
        G2czYd9QlJM8LzQThN80LUo=
X-Google-Smtp-Source: ABdhPJwgvFMH2G3rwok9ZZOeY6CuDzZMwUDdV5/PmUlytfXrNH3n0s6VNKjSUC7m/Fw8FKjqrkdkOA==
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr14797242ljk.121.1631028971244;
        Tue, 07 Sep 2021 08:36:11 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id p14sm1484458lji.56.2021.09.07.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:36:10 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 2/9] fs/ntfs3: Remove unnecesarry remount flag handling
Date:   Tue,  7 Sep 2021 18:35:50 +0300
Message-Id: <20210907153557.144391-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907153557.144391-1-kari.argillander@gmail.com>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
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
index a18b99a3e3b5..6cb689605089 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -417,8 +417,6 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 
 	clear_mount_options(&old_opts);
 
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME) |
-		 SB_NODIRATIME | SB_NOATIME;
 	ntfs_info(sb, "re-mounted. Opts: %s", orig_data);
 	err = 0;
 	goto out;
-- 
2.25.1

