Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF37B5EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjJCB5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJCB5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:57:14 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE023C6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 18:57:10 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1dd22266f51so82063fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 18:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696298230; x=1696903030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O00OPeBX0OAQavpWTikv1KaJprJXcYLW3QJEgWJmVgY=;
        b=Yeon7PPa3YqWhJYff3tPoqbmqVq0MDrI1PQxipC5xcL/g3XTjVsPThhBSDPS5O6Djo
         6EVoB6fdLNbZaUdUV2VM3L0tMwIrWwCpnj6K2VwPxFOCg9lVzPDngCCyWwZTKaib+LWK
         6P3anLtQc+MVRbQbt5cSKWMHvVXoBslpbs+q0BA5XK55M89sVBySSp6waa91OjZQjDzJ
         F87sBn2w3/SVJjuF/l4D5WGpKwtHIjQbYD4BysR37hKVw1v8wYZc/EOTFJTz9PPfimUn
         oObo8tghYljEPlBSS4TLJe2ggNHDWVeyT3oPDjs5anoGHolY2Ml1866Wpo/1YC6Ojs7Q
         UJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696298230; x=1696903030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O00OPeBX0OAQavpWTikv1KaJprJXcYLW3QJEgWJmVgY=;
        b=wkLB4eUZwuC6CDHNTpB2DVXDVDC2/VBU1Vm9sMuuZYihp1TgdwN44qd/jTcCklifbk
         d01Ndvhtca34wRd/l6z5s5nQW6vhnOX+9q97eOurqpJaVZusktVSvh4fbAH0AddT/K++
         xvdl4fJoTvXHxC7i42a1ArzLcjdA0ywYekyX9XxKNg31NJcEnm07IRX6Hj0hhOdXCP+E
         sNKtDLgvjEiImRo1h+GZ+KW08Mi19bZAnHi/KGdwanmab0nunDklT6dWqb3JuffXKkWr
         1F1jxWdJwe1wqoY9kLTCpq7QXf0BoIl0l1Lv9VLoYUvkvDwKdFXxKJmMFOTzJJG7Hbco
         Zc9Q==
X-Gm-Message-State: AOJu0YxSSkoQXb0Eg6NvZcbd3VObuRtFuZ+CpTwISn8z0qfTHpBwBZ9N
        8K/fswAzP+n16vMugGB/gRa9wDFaiXcAxQ==
X-Google-Smtp-Source: AGHT+IGMJhd67lE+Kn9AwqiETrIu/sIPojytQz9RjEUQ8PA8jl9s9zZ3r6SHYmG4F1v3iGBhsR75mg==
X-Received: by 2002:a05:6870:9707:b0:1d5:f814:56a3 with SMTP id n7-20020a056870970700b001d5f81456a3mr15700234oaq.2.1696298229848;
        Mon, 02 Oct 2023 18:57:09 -0700 (PDT)
Received: from node202.. ([209.16.91.231])
        by smtp.gmail.com with ESMTPSA id f22-20020a9d7b56000000b006b9443ce478sm22803oto.27.2023.10.02.18.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:57:09 -0700 (PDT)
From:   Reuben Hawkins <reubenhwk@gmail.com>
To:     amir73il@gmail.com
Cc:     willy@infradead.org, chrubis@suse.cz, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com, viro@zeniv.linux.org.uk,
        oe-lkp@lists.linux.dev, ltp@lists.linux.it,
        Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH v4] vfs: fix readahead(2) on block devices
Date:   Mon,  2 Oct 2023 20:57:04 -0500
Message-Id: <20231003015704.2415-1-reubenhwk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Readahead was factored to call generic_fadvise.  That refactor added an
S_ISREG restriction which broke readahead on block devices.

In addition to S_ISREG, this change checks S_ISBLK to fix block device
readahead.  There is no change in behavior with any file type besides block
devices in this change.

Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 mm/readahead.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e815c114de21..6925e6959fd3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -735,7 +735,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 */
 	ret = -EINVAL;
 	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	    (!S_ISREG(file_inode(f.file)->i_mode) &&
+	    !S_ISBLK(file_inode(f.file)->i_mode)))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
-- 
2.34.1

