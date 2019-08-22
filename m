Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0506998C76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfHVHdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 03:33:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42517 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfHVHdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:33:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so3335629pfk.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 00:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=GFPIU3HG0M4VBLKCagBRqf2xANHNJKxYGKLnGfhfjjE=;
        b=bSlLtBizq89/eOMaP5JrccDfJSCz1rwoF5GhRste+iBjy5C/XWnkeHpontUNxFvad8
         OaABzIbntZkh+BCjwcTeUVnZDMr2cFkRUbn9HXMtFENuP58YUe2x0nJIeB2GsYfrjE/n
         5jvREKcyBVexALzw0TkZlvIzFb54ZtG9TIs9oQqA2NyqwXC03s2ZuGZfCgRekQbcXho+
         JPJkuTBGfkDkUlQsXPjP5F6p4jDUzvbB2YkmaagPAx3Cm4TR2jlKymo59i0JcfIyLOqh
         w5ZYl2GvvxfDgxVcXBNn6qtlP/yEE1FWiHEwrr6/IKyT88EQTv0qW6Eei8faPwsqBAbh
         zi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=GFPIU3HG0M4VBLKCagBRqf2xANHNJKxYGKLnGfhfjjE=;
        b=dVLLJgGKUCJBz6BTOK3Mhfp8hX6cf6YdpvL/spdreOLPFiB7hbToOpuaQbvWfRi20d
         a5XAe/MzcBq22OX70huoSq1wrDWFj9FCdDpCi+zaWDlT4LXTx5EPPiTY8U8O4g4U+aH5
         EKkJ5Pqj1Nl1/RBaGgH7uHn0C0flhY/KgNhNakQgnjGCFyxzVikwz1cCdgknPVQQ6Npe
         HBiaqftvXi1KXjTAFbrfe34ZA44llrMruMckpin+wswVZhJBKctO0RD0srrfvqK9R1hW
         i+2kBtaEo3f7fFYuD1kEvHgIdrtJ9vTy3MhwvPF8V9ybaUNB7CzdlXr/2yGqpNIFy8qJ
         dAqQ==
X-Gm-Message-State: APjAAAVeBKkjb2M02ePsTu+ehsu/k7+Hr0IKI9N18ub/f5NdZtY1BFyn
        gkqsGkGfWjGFU9rEb8ZBWhtg0aWj
X-Google-Smtp-Source: APXvYqxjld18WdZ7pRq+5LZWWlZh3AOZX6Wi3D3vDcERG7Rk8C4ZSrylLGcCNAEHfgs3SFzIExR7+A==
X-Received: by 2002:a63:7a06:: with SMTP id v6mr1207570pgc.115.1566459188249;
        Thu, 22 Aug 2019 00:33:08 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z24sm39650153pfr.51.2019.08.22.00.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 00:33:07 -0700 (PDT)
Date:   Thu, 22 Aug 2019 15:33:00 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/open.c: update {m,c}time for truncate
Message-ID: <20190822073300.6ljb36ieah5g2p55@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like what we do for ftruncate. (Why not)
Without this patch, cifs, sometimes NFS, fail to update timestamps
after truncate call.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/open.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index a59abe3c669a..f247085aaee4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -107,7 +107,8 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (!error)
 		error = security_path_truncate(path);
 	if (!error)
-		error = do_truncate(path->dentry, length, 0, NULL);
+		error = do_truncate(path->dentry, length,
+				ATTR_MTIME|ATTR_CTIME, NULL);
 
 put_write_and_out:
 	put_write_access(inode);
-- 
2.21.0

