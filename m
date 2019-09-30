Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F2C1A54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 05:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfI3DWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Sep 2019 23:22:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45338 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3DWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Sep 2019 23:22:13 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so34285671iot.12;
        Sun, 29 Sep 2019 20:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RTk8o5y2OPdzeM4DZQR03uMoZrvcDTNy01aX7f4t5ng=;
        b=E3oXxSpn06DltBkGV1TKMJM9wzbTOptdQLKZGVGE8ZilsjoiFCsEqqqpbUK9xQHYF0
         MmajzeMtnrpQQs0yuQDw/hf+XWqu0ColCwy9SYXZk1vcHbriBUcLZo4t0g6XfHqyUp9q
         afQgOfXeEXF4pcTbIvEeMCuq0pYZ2hWYUBl+Gf7cdnCNDHtotZEzRG2o65H8Scnjp7ut
         Iat0yz7mwfeSOkX2m4jCcIWKS7VOWRQdBzd6rxElYdklgvTTON0FwjbqSET4a13ljVJ5
         nEi4GS+oHQc2P0epmShYmEC/MJNeqG5DWpcW3CBaXgfeyukWvpMYTIe0JUaJIGsZmXLY
         uH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RTk8o5y2OPdzeM4DZQR03uMoZrvcDTNy01aX7f4t5ng=;
        b=Iyq5vJKmy2oyxDLEVJDLCnbA6K4O6RgSxS1QC4MHrFDUGnJmw/UnRHTKQms8qTg5+n
         bmm+VoaCnYEYkCyyscKabYMjNkPlriSnWJusu1J0jHfgdriFuyuQSVmNBAy35PmluKVs
         fJn05pep2BDVV6IWN7Byi2o+8w6jUBpvzdGBixHMUw82anQ2QwEJ0t/KukvFdfnN9Ka1
         LS09zDzYMsCLQXj1vh1da59P9ct1YykHR8JDH9wNXdcoSF8qp6iOvEdajrDQfXn7Z2+m
         WKoRsXVOq3YYWETdz7zLXqmyc9D1teuhTlszR80E4/EaXps7xErcT0r304GuXL8Ambe9
         plXQ==
X-Gm-Message-State: APjAAAWKp+4P+YYpo1EczysUi1UTmF3/pTIR2ZmMTqxk2uUypmDDtOn0
        cP2eV4wPHzHy9EEeTySln/o=
X-Google-Smtp-Source: APXvYqw0xIH4YEErxHKd1cWTbiTh0e/nyDizgg12MsP8PWV5gRx64ITCSEOYECK+pTn9HF9v+beiFg==
X-Received: by 2002:a92:9e08:: with SMTP id q8mr18219649ili.263.1569813732351;
        Sun, 29 Sep 2019 20:22:12 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s19sm5343826iob.81.2019.09.29.20.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 20:22:12 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: affs: fix a memroy leak in affs_remount
Date:   Sun, 29 Sep 2019 22:21:57 -0500
Message-Id: <20190930032200.30474-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In affs_remount if data is provided it is duplicated into new_opts. But
this is not actually used later! The allocated memory for new_opts is
only released if pare_options fail. This commit adds release for
new_opts.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/affs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index cc463ae47c12..1d38fdbc5148 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -598,6 +598,8 @@ affs_remount(struct super_block *sb, int *flags, char *data)
 	memcpy(sbi->s_volume, volume, 32);
 	spin_unlock(&sbi->symlink_lock);
 
+	kfree(new_opts);
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
 
-- 
2.17.1

