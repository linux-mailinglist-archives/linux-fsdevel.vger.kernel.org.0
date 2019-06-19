Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2444B852
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfFSMak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37419 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbfFSMaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so1646965wme.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XPGarDbNQvdg9HgXJCH37X+Od5kwHmLIcOjFshcWxM=;
        b=hAlfqUKJKxH1CtozGbhxNCIvoRpYgLHHuO+VyP5no3jt9BY+TNmDubu9IRLuVRAYXl
         y0Mk0V68OzfL+AZcYGl7vmitWDwm9Q/9/KIzUx3L5aU023v8ymPwzOcaDRYV4rU9HTTQ
         gmh21JcDpmhnFAFyOCCgncl6BsorALVrGVA7LOL7Qh2HhrUjVel3lNHWZo3fgJG8h2Qz
         lIsGQlH112KyCo9DS9Q0alieyt8PDrVkel7ZHAXdhR1RpoQyxj71+SKpmyTTgb3CuF6F
         mVyT/6ZKyVEz3hu6Izw6ZUGSLKZWkRGgATo930by+nD9E3F8/fZ/hKN9g9DLGh7GwTv7
         6ASQ==
X-Gm-Message-State: APjAAAUDyr+pgrEKPSRFQ+Fppo0BhF12+KIUDVYFUEfVF8E+G/LOMRla
        qgmGRXC3D3xH0nyvLc39Lq67hw==
X-Google-Smtp-Source: APXvYqxRFzpttWVNpTPiQbdLpMWn0xb6IHJ5FyTailY17pShWafJilfmh1UScZ9oGl2gwVqFz8iRLA==
X-Received: by 2002:a05:600c:214e:: with SMTP id v14mr8496323wml.96.1560947437553;
        Wed, 19 Jun 2019 05:30:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:37 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] sysfs: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:14 +0200
Message-Id: <20190619123019.30032-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the sysfs filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/sysfs/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index ba576a976e8c..4797b7952fc5 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -49,7 +49,7 @@ static void sysfs_fs_context_free(struct fs_context *fc)
 
 static const struct fs_context_operations sysfs_fs_context_ops = {
 	.free		= sysfs_fs_context_free,
-	.parse_param	= vfs_parse_sb_flag,
+	.parse_param	= vfs_parse_ro_rw,
 	.get_tree	= sysfs_get_tree,
 };
 
-- 
2.21.0

