Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1A6DD187
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDKFWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDKFWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE122D48;
        Mon, 10 Apr 2023 22:22:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so9762707pja.2;
        Mon, 10 Apr 2023 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190541; x=1683782541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sHHSgyf7JgSxNIge90EAWqHI+AZ4Hp4QV3xDqyTWSU=;
        b=He/XBW2rwYjIDOONpcwrXe8KOwmCl9ast0lIo3eGrALZsraMW+EwUdVMGU0GLPUEED
         6GaDsnBcqx6tBinyW6pYxCzJPiBhcSFUYNF832txvsIqxdhGAI9QCxfvWO1oTsJ9jdFW
         zjQtb+UqcERGTI4J4a5EaYDkSeo5KE3xmze+8Aq6MV7ICBlzwrsOOoKsLrFjKUpHpVxV
         2YHSmWo2li1PBib528SNOLpffDAWJeB48klsCcT3BEo7mBhRLqcrcTAD0LwtOim1P5kN
         wje3ZY0dDMYE65jLSCdeodJBvtWJCKeeZjz3qMgvzotzLhJpISnNA1uRkDWSNW0o7W9H
         chPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190541; x=1683782541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sHHSgyf7JgSxNIge90EAWqHI+AZ4Hp4QV3xDqyTWSU=;
        b=e/JvAu3536aORkD6+5wrke46WwvrWlT8296/dsL3FFmxbFK5zUKl/6DXhHBJQItED2
         htfCQCViWz3YAHCBYJT7tjjS5pxTwSBz9fLFaGzJ6JZV6yWGW6iVn4iO3sEovTCpD15U
         zjy4o1ZeakjAnwvyLuqc6y4j+TqbFrYQ/IMwf+oBfxZfWJ1pETXwvjcwUOd8IIcdKF1S
         kLfzflCoLHp5q+/B/PV6WUtBrX4z6KCK64EPEZ6T7msX/Xega/BfjLXwEPp/BWTdf2EY
         sYMSOXoAw3Z7CBWC8kFbgkrOX/T0ZRzhsyFUVRYz2pNIhUzVWmgFrWWamXtfvoVyNIXS
         zCHg==
X-Gm-Message-State: AAQBX9eWjZ7R1cTIDHvWWn2szljjYy3rv7bGCSnzsJiiu7M9IDCxrP3n
        LJ36CQbD8GzfSbxcqd3ub+GPpNJNz24=
X-Google-Smtp-Source: AKy350ZuNFwpKyQpbBWZByLpfPwlkK27gvk0rB0wlBrQTm4g8yQ9IrnIHn2vxZSyRXX7XoOMgrJWcQ==
X-Received: by 2002:a17:90b:164c:b0:23d:1aae:29e5 with SMTP id il12-20020a17090b164c00b0023d1aae29e5mr17197608pjb.20.1681190541363;
        Mon, 10 Apr 2023 22:22:21 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:21 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 4/8] ext2: Use __generic_file_fsync_nolock implementation
Date:   Tue, 11 Apr 2023 10:51:52 +0530
Message-Id: <eaf4ae72ec573319bc65b5a3747852c4bfb1223a.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Next patch converts ext2 to use iomap interface for DIO.
iomap layer can call generic_write_sync() -> ext2_fsync() from
iomap_dio_complete while still holding the inode_lock().

Now writeback from other paths doesn't need inode_lock().
It seems there is also no need of an inode_lock for
sync_mapping_buffers(). It uses it's own mapping->private_lock
for it's buffer list handling.
Hence this patch is in preparation to move ext2 to iomap.
This uses __generic_file_fsync_nolock() variant in ext2_fsync().

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 6b4bebe982ca..1d0bc3fc88bb 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -153,7 +153,9 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret;
 	struct super_block *sb = file->f_mapping->host->i_sb;
 
-	ret = generic_file_fsync(file, start, end, datasync);
+	ret = __generic_file_fsync_nolock(file, start, end, datasync);
+	if (!ret)
+		ret = blkdev_issue_flush(sb->s_bdev);
 	if (ret == -EIO)
 		/* We don't really know where the IO error happened... */
 		ext2_error(sb, __func__,
-- 
2.39.2

