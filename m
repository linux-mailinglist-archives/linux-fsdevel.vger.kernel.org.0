Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7379E48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfG3BvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:51:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33457 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbfG3Buh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so19935370pgj.0;
        Mon, 29 Jul 2019 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pzcazUl/YPKOksb7vbUDmWoTVBPfLTioSqOrhqez9Y=;
        b=pLw9p0nt0hUU7YWjb96e0yxgbLIaZW3MxiGngSf7VlziEjgE3XYrQpkwVaK9yDBbKZ
         Zh15d7rg5YUakKBN8gZARrsLnY2tm4Zd0XabmRrln1L7IJL5PBbNCUbrg0nJ35oOmQwu
         M4uoxxYroyZpW+Io7Lc2Kjx5snWpyeHkcGTMMguW+EwimhSS34kane0RA/t87gz/BVkk
         7KQP3+dAfeHoCVF9pi6M+/1hvr1yhCmcigOyOd1yTca9pXr4oJQBPyrYClPiM/2gIWgL
         miFY53BeQJz1qpTxfSfEGtGYMrA7luW27vw0WhaXKs3o3BKSDGR/FYdihKvOVDdOIMrv
         wwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pzcazUl/YPKOksb7vbUDmWoTVBPfLTioSqOrhqez9Y=;
        b=BSSTCJiW49MSPXuWKZEJ3fbvpsVP9cU12ZTLuZiHoUXXCT58NADXf5CRCvhcu1qzoq
         t0w0JHtesADYmvWtPMR4/SQWyXl5QPCA8HUN9v3ESMArtvgLsvOspy0oJIKCAArN0wK+
         ZjVnMeRNFg8zuJEjTPNKHcKsnjOv2MP6+E3HMArNDFqV+NLUxFUKuYSRqkgQ7c2d8LtL
         L03T6UZ6CS7ZQcRw25i34XSaAwujxGxZdrlfX21c304RXAYVHnjGEgwFp4fO0H/jygPp
         pZiWU7wIePvWNg3Kg6tSvDHlL7X+rCzbU6CwAJNvMJ2R8OOEhZHV1WSrMywdKdpSeP7h
         Mn9w==
X-Gm-Message-State: APjAAAVP7fqZwGhZYpldoj6QFbEuBBKz7ati4OmvbOw8voqAOEZ1BkjU
        2jm727DpmAqJf5B6ZbKXVyc=
X-Google-Smtp-Source: APXvYqwuoNCFskzA7wwr+3fhcEUFUPA856yNJ6Zox7fqtsa9eOMvdD4IodszPXes+qaudx93RAiWMA==
X-Received: by 2002:a62:cec4:: with SMTP id y187mr39052123pfg.84.1564451437010;
        Mon, 29 Jul 2019 18:50:37 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:36 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, hubcap@omnibond.com, martin@omnibond.com,
        devel@lists.orangefs.org
Subject: [PATCH 16/20] fs: orangefs: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:20 -0700
Message-Id: <20190730014924.2193-17-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Assume the limits as unsigned according to the below
commit 98e8eef557a9 ("changed PVFS_time from int64_t to uint64_t")
in https://github.com/waltligon/orangefs

Author: Neill Miller <neillm@mcs.anl.gov>
Date:   Thu Sep 2 15:00:38 2004 +0000

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: hubcap@omnibond.com
Cc: martin@omnibond.com
Cc: devel@lists.orangefs.org
---
 fs/orangefs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index ee5efdc35cc1..dcd97e8158b1 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -439,6 +439,8 @@ static int orangefs_fill_sb(struct super_block *sb,
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_time_min = 0;
+	sb->s_time_max = S64_MAX;
 
 	ret = super_setup_bdi(sb);
 	if (ret)
-- 
2.17.1

