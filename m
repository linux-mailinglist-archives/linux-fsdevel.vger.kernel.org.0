Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98A7AC69E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 07:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjIXFJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXFJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 01:09:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0812311B
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 22:08:59 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae18567f42so464925b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695532138; x=1696136938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iihM7fNHraKjWmXna1UvLf+5E692wDKvi6IGfIk1b2A=;
        b=J8Lb+/+KZ6Fh2YEUz26AFJ3mRAIATZ0TEfCm3BjH7BCukQYdp7dub18YAPR0t+thf3
         4Q1BXlEnf9tK/ZgV2UAUZqvDCvDLmH1pfxyl0WkyQY+uH7WdiU2TbquANkkvitnNo5kn
         5wU3P13x2UuSa4rzCdO+cVUkzPtiT1n7yhQfhW7wkbsm1TpKsCBruCOBWdYnFlpxKnxD
         YrAp8JZeIobw4PBwMdr3De0ogDQsy6HfzW39ZcZehF/F39JndhgWcLdyO6/8ddmitQrI
         92coZ6C2yTzNhM2ssA8sgN+KMLZC0y+qwMCMblEMs8GJDjLwTOpBn+1BU7RFuIUCuDtf
         8/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695532138; x=1696136938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iihM7fNHraKjWmXna1UvLf+5E692wDKvi6IGfIk1b2A=;
        b=G3NBNUMHzyFk2+UiSuFfc2bRFivszKIo0Kw7tBBlFa+ZmegZ/z/7wSFBSY4UtXE1st
         D+fTN/obQDX9bvzQyD0HO9egoZWdWpjCWT0j/oW7ReUcuiGJIGdzcwHdIexzsCukM9IG
         Je45FHDpdr53znZJrdprC5yNY1/P6fbalNWOu+W3bqZxtIDu9LbR6krIvw5rj+O+nJD4
         d78IV7Cz7zh7h+cJ6ujiwy+7FHX5PXw6pRP5a/kkJgrQ/rkaXlkV4AhEOyKVmzCFCDO/
         sOBNNSaZBzU4HHP1nuTc6wz1RTGsKyh+/x2uaZX06qC9N4URusTM8ML5CopfHxrfSY+e
         mYwQ==
X-Gm-Message-State: AOJu0YysReWdPmjkHChrc+7vUbZ5iw5Lw5uqgKClXvmyIVLaFRd3Ws8F
        kFAOUJec+3fXNTqJKOjvhyM=
X-Google-Smtp-Source: AGHT+IEWXTeY45Kdzy/4A5emiEePpYA2DmqOJKpzmWxay/53yMaIrDRx8U2UFxT52j4G3C6Eq9gUjw==
X-Received: by 2002:a05:6870:c105:b0:1d6:790f:2007 with SMTP id f5-20020a056870c10500b001d6790f2007mr3151863oad.4.1695532138132;
        Sat, 23 Sep 2023 22:08:58 -0700 (PDT)
Received: from node202.. ([209.16.91.231])
        by smtp.gmail.com with ESMTPSA id dk7-20020a0568303b0700b006b96aee5195sm1350018otb.11.2023.09.23.22.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 22:08:57 -0700 (PDT)
From:   Reuben Hawkins <reubenhwk@gmail.com>
To:     amir73il@gmail.com
Cc:     willy@infradead.org, chrubis@suse.cz, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com, viro@zeniv.linux.org.uk,
        oe-lkp@lists.linux.dev, ltp@lists.linux.it,
        Reuben Hawkins <reubenhwk@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3] vfs: fix readahead(2) on block devices
Date:   Sun, 24 Sep 2023 00:08:46 -0500
Message-Id: <20230924050846.2263-1-reubenhwk@gmail.com>
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

Readahead was factored to call generic_fadvise.  That refactor added an S_ISREG
restriction which broke readahead on block devices.

This change swaps out the existing restrictions with an FMODE_LSEEK check to
fix block device readahead.

The readahead01.c and readahead02.c tests pass in ltp/testcases/...

Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 mm/readahead.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e815c114de21..0ff6fffe3c84 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -734,8 +734,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 * on this file, then we must return -EINVAL.
 	 */
 	ret = -EINVAL;
-	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	if (!(f.file->f_mode & FMODE_LSEEK))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
-- 
2.34.1

