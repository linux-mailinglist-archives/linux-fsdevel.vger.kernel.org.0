Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F363279E53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfG3BuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42671 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfG3BuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so28931294pff.9;
        Mon, 29 Jul 2019 18:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RW8wa5CmvNow6jsuxhZgtbxifDJuKVtv4F+8WUaIVIU=;
        b=YwmjPnB19KAj+BjmIJ50cdgeFM5UHFfUDO0cpXF0s+JcgHsVn1lYYhQ/4LCBEuEQ81
         4BZt/eGZWaz2Yfk+Dq8a8mJWVY5q3Xfq5+S0qlPEKml8x72HTXAYahrfG2/Tocc5fT5r
         85xAHR4qucnnndtFeLW244mj+SpwP590cPXHRy+WJkiO+ffBRDC6SvcdzwcE3wgV5wJ3
         NbCapeZbQOcVTVmfTlZ1xeF5mXVPFYeo1f3frjsMEjiSFOb+t1IOymYCw/o/1s8n3s4A
         Sb0g7mrj/CnrmyOB8+sDfwEwrqG5ovtGVpkqjJjnYicE4aGDMpfeUEu3YNMqeZFv6kjM
         6mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RW8wa5CmvNow6jsuxhZgtbxifDJuKVtv4F+8WUaIVIU=;
        b=HDZfO5b6sUjdMD1RLdfNpx4neJEbx2WFJ+IJ9XC6yXLeWS84VxYulOEWC7NzodBfgF
         K2l5SmOGjs+js0uyWwOVAcchl6/NzoFT9n0qwb11RJR9WN7Miw2xSAEXL8JrOrDaeqVI
         9arVmfuME47kyDuHJ5j1D244bjjQQ5KIACtLmAIXC7YMvInKQh4YSdTzMkqCGjcRMwIF
         d/hvBJO17k0n4akcnk+qUQBVDM+YS/u6woG/Jn4OgalUPzu18eTK7Pl9fKFQb7N49VpR
         yNTY6tXwHFE//B72RgvkOzdjV27yUYbsdjamTBBwtx0BjaPqchp3clcWRvWz5AdqEjU1
         8MIg==
X-Gm-Message-State: APjAAAWlDwXodu6BJ+U2b4fHAZKp530oYiNoA4lxrynjUz5BLQQgfnXJ
        TfgdejmhH6B3+BGgimXkMBg=
X-Google-Smtp-Source: APXvYqz29EMBCshdmdETjuOL+Tr9F3tUgVJAtBZcxutuiiC/3ISyMH46dd/NGOfeMhYKjxoEaaHKkA==
X-Received: by 2002:a62:174a:: with SMTP id 71mr40680263pfx.140.1564451423830;
        Mon, 29 Jul 2019 18:50:23 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:23 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 04/20] mount: Add mount warning for impending timestamp expiry
Date:   Mon, 29 Jul 2019 18:49:08 -0700
Message-Id: <20190730014924.2193-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The warning reuses the uptime max of 30 years used by the
setitimeofday().

Note that the warning is only added for new filesystem mounts
through the mount syscall. Automounts do not have the same warning.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/namespace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index b26778bdc236..5314fac8035e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2739,6 +2739,17 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
 	if (error < 0)
 		mntput(mnt);
+
+	if (!error && sb->s_time_max &&
+	    (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
+		char *buf = (char *)__get_free_page(GFP_KERNEL);
+		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
+
+		pr_warn("Mounted %s file system at %s supports timestamps until 0x%llx\n",
+			fc->fs_type->name, mntpath, (unsigned long long)sb->s_time_max);
+		free_page((unsigned long)buf);
+	}
+
 	return error;
 }
 
-- 
2.17.1

