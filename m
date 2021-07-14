Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10E3C8B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhGNSuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbhGNSub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803EEC061766
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:39 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c15so1539434qvw.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xk61Zn1WGvZe9oDMxIvYakdXIuBAH34lTAxcJ/5AdLQ=;
        b=C/tU9se623yVpBbPLXzFaiqyH5+3u2knGq7aYpkFU2IFNxYVmHnF4ubtLLIKmwU/ba
         VlbsOEykpVidDiKXTPu6Qb7LUJZaVaqn52Y+TR2QnpmWqkl9VnSNlAy72Qd8jlucIIyP
         MpISqrlGcdEd/7u3jcvx2D/jc8mIA4quJUZjX8arcjY1lGE2FT0we3ncgNQzDrEORb2T
         3zhKTtPOAjpwttUJ1ud+pLS7y3hxbKtk8zT/AvvrAJRnwPgsJ1+rimZ5tLXaRO02xQaX
         vuLa0Om6VU+knEndziipA/1eSWQpnf8bbRmwFwBydyhp3AeIuOAu8ijLOjOA+FrXcadY
         txVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xk61Zn1WGvZe9oDMxIvYakdXIuBAH34lTAxcJ/5AdLQ=;
        b=prKF42pMyrdCo8uaT9PIk9g/90K0YWVt3hg8ypr56KUNhPI65BQaO7QLF+JOcQfpC/
         dBPQpcyhdpA26fTPyXYzOtflMMkBW4dK0NAFKD1QXpnzTYIXnTRggCCWGn26qVct47fX
         TDdXLmHv/5VrtQmI/yhqIHFX8qokC0CP84+7RgXk1z92dAMb4QmNgVP463zYug/78Inh
         Z5G05QRtyVDdbSJ1C6yppx5ZHTvctQZlJmGOfZv8V+zgbKJOcm5vOAD/ztlHJaJnN7V1
         ranTbTGvHHK6woSnnGlBvWZySCAJhLH681qqrBS8NmhWGHky83ml/OuO3AlQmCZZhBFB
         8A8Q==
X-Gm-Message-State: AOAM530NIsskvEK93Bvs+lgzWMSmfxENTuzqvlRLx2wunVyhsz48s9Po
        Iv7U5hTFyGAuq5z8zAc1tDpdpQ==
X-Google-Smtp-Source: ABdhPJw3QYNBAYnp6RjYuMBTO3Ziqr3hboUy69T139RW4CtDXDHnTyQ2CAeV6P+JinJdVKM8Wjn9+g==
X-Received: by 2002:ad4:5426:: with SMTP id g6mr12153276qvt.47.1626288458688;
        Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a190sm1474962qkf.9.2021.07.14.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 8/9] 9p: migrate from sync_inode to filemap_fdatawrite_wbc
Date:   Wed, 14 Jul 2021 14:47:24 -0400
Message-Id: <696f89db6b30858af65749cafb72a896552cfc44.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We're going to remove sync_inode, so migrate to filemap_fdatawrite_wbc
instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/9p/vfs_file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 59c32c9b799f..6b64e8391f30 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -625,12 +625,7 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
 
 	inode = file_inode(vma->vm_file);
-
-	if (!mapping_can_writeback(inode->i_mapping))
-		wbc.nr_to_write = 0;
-
-	might_sleep();
-	sync_inode(inode, &wbc);
+	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
 }
 
 
-- 
2.26.3

