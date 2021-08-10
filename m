Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827033E7BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbhHJPMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbhHJPMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:12:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE194C0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k29so13979879wrd.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qly801pD8R1BCAJDgcv2Jy+JMcMqItg9ZtCsmo0L3YI=;
        b=rvoSiV1VnvykmqsYGqBOYG0NYCiNhP7yRiqC/egVr1alQK00TeLSWJmMZlEhBx3CcN
         P6bvkJUxf7cKSTJdJ6OZxhkgVl9upazMadO54KtAV7aBJTv6FHQbXqRVLxkwMirX8CGk
         aD0JXCjBmwi5REf70bdVd6ETxsHqL/bMkcKYmOhSmFIjjuboiCJ9t5roa0+XYlv/PTdz
         7ls0BCArC9v8qWIXhvIqcs1egySBBx9iePBzJ+045AN06otuDvOlvLB/kLaIxz0c3wnM
         87jwx8KGBFp2EwNjNmk+NFJGEUV5EFwYKC/UhJ24od54Es1VVxacFIWcBqVgcwiaz0YP
         2QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qly801pD8R1BCAJDgcv2Jy+JMcMqItg9ZtCsmo0L3YI=;
        b=VXoTRDcJ5TtOR+KVC13QIovGqY+sKhr9Mk8FcJNfOKU4UA3cSE00dKaGH7ULIY6qvo
         3OOnSUSDDFc071er5bMON/coBHx4j4iU4wvqsqeAf+Ky2gi/10ZsEiTsKaNruHjHB5CE
         hdmZhXu/rYpGLFuwK3NTv+/5iEMbumkhIFAOlSphjqCN4SxM8OuBM1NBlu2Y0daTB2nl
         Nw0q0QFeeE8jKoa4uxX+pu2G0hgKvSby8/Scu0lo1G9Aeb3D2vT14yMG7FAYkIvC/VS2
         K4rd/izHQkpuB8yeqOagToy7/RsHMGR7edkaTZml7o4ppMVqdOgUnt0Dd4uNkV0acmm8
         G6NA==
X-Gm-Message-State: AOAM5316gw9kSxpQ6Y7T3VYXRPXkT4LcozitXjpfbbR91rkRwIvn7SDw
        wR4sanS6PzmmN2r/FG4B33M=
X-Google-Smtp-Source: ABdhPJz/A9XJZt3kUZ1frZvQFpXmR6qog3J4r4xspf3LimwQnDkB5qdL3BfyKNmEJnLVLtCQZ92mEg==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr30651035wro.279.1628608348616;
        Tue, 10 Aug 2021 08:12:28 -0700 (PDT)
Received: from localhost.localdomain ([141.226.248.20])
        by smtp.gmail.com with ESMTPSA id k12sm9568920wrd.75.2021.08.10.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:12:28 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <repnop@google.com>
Subject: [PATCH v2 4/4] fsnotify: optimize the case of no marks of any type
Date:   Tue, 10 Aug 2021 18:12:20 +0300
Message-Id: <20210810151220.285179-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810151220.285179-1-amir73il@gmail.com>
References: <20210810151220.285179-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple check in the inline helpers to avoid calling fsnotify()
and __fsnotify_parent() in case there are no marks of any type
(inode/sb/mount) for an inode's sb, so there can be no objects
of any type interested in the event.

Reviewed-by: Matthew Bobrowski <repnop@google.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..12d3a7d308ab 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -30,6 +30,9 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
 				 struct inode *child,
 				 const struct qstr *name, u32 cookie)
 {
+	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
+		return;
+
 	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
 }
 
@@ -41,6 +44,9 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 
 static inline void fsnotify_inode(struct inode *inode, __u32 mask)
 {
+	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+		return;
+
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
@@ -53,6 +59,9 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 {
 	struct inode *inode = d_inode(dentry);
 
+	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+		return 0;
+
 	if (S_ISDIR(inode->i_mode)) {
 		mask |= FS_ISDIR;
 
-- 
2.32.0

