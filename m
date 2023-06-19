Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D1734A42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFSC3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFSC3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8A4E49;
        Sun, 18 Jun 2023 19:29:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-54fba092ef5so2457111a12.2;
        Sun, 18 Jun 2023 19:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141758; x=1689733758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWsRu9lf/AHg76xNxq1yUxMqefCmChrWsrWNBoCROHU=;
        b=AlpPLfyiQA8L3Db4lUewZxgPeK1a9flv/KxPiDptyCFXgM2rN7ecTf8CDdlP+IGCk5
         k6iY8Z+3F+/pY9iwBdPlOMmYYyI6TFkT6GPe3dQv1Wpq0I+Q1HEsUR2uP6lMF+PtqJYz
         kK8Zn1IopgbiXdinY2a38N/H9JJo5hPExIbP1LVdzja1k2g8MTu/Hpw+gbGF7/x+Pldu
         v4e8z+HaxVrwzG8HHJYjBYwnnH6LzU75ooSFLDVNYkwgQeV/vSbNe2iHWA9ZHoB+1mgQ
         Bu8M1Dut9z4P098ZIRgREgrSi/hzD5+l9OSH+rV9hcGBbz/5gV5WMVGMoDj72fEdVy1p
         49qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141758; x=1689733758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWsRu9lf/AHg76xNxq1yUxMqefCmChrWsrWNBoCROHU=;
        b=l9li8roXhqe0FHCSajrKYBEg2K/Sf3Wrcg/CYEbU38LdqgztLG/cp7dE3dj4q7XxVW
         QnsavjRumhxTiMqAzo1L3YHSUN5UCQGqJy971thIA7ChzXEg6nhRcYk4bJXeWjqRA3pS
         uOCgvF66NBRZW6cvNFDBWqlokYe9ltmyoK++k/6SQH9q6Cz85c6GEdAGRIeVV2EEOY/5
         sfN6+xV75UcdR8i8ROhr6yy3WakQtzX5wP/KnaBbJe5YhYApje+sSG+iNqav+OWeQ9pS
         RF3g73xPTloYWwnWzHd77O+BMvTy8k9LgQt/eAS7xKD4JhsBp2+lgO5qRP2Md83Jh3Ms
         HH9g==
X-Gm-Message-State: AC+VfDyer2zEvy5fly/mbQHdSHyIHpzg60t4IzBYk8Dusd6kNP8KBDrq
        sO2nzHrCJuOTrKX9uYsdqhQuJqKQYTQ=
X-Google-Smtp-Source: ACHHUZ4OwvcEHhaEgiYsZQE9FIG20K1YASUUck59wcJxjycWFq4kRnwKp7CfbMxIhdc4NOJXQClamA==
X-Received: by 2002:a05:6a20:734f:b0:10c:3cf3:ef7e with SMTP id v15-20020a056a20734f00b0010c3cf3ef7emr12209630pzc.42.1687141758244;
        Sun, 18 Jun 2023 19:29:18 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:17 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv10 5/8] iomap: Use iomap_punch_t typedef
Date:   Mon, 19 Jun 2023 07:58:48 +0530
Message-Id: <f639e1e646a35806b00fc2eff7e88ffa5075c1fd.1687140389.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687140389.git.ritesh.list@gmail.com>
References: <cover.1687140389.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It makes it much easier if we have iomap_punch_t typedef for "punch"
function pointer in all delalloc related punch, scan and release
functions. It will be useful in later patches when we will factor out
iomap_write_delalloc_punch() function.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8206f3628586..e03ffdc259c4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,6 +23,7 @@
 
 #define IOEND_BATCH_SIZE	4096
 
+typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
 /*
  * Structure allocated for each folio to track per-block uptodate state
  * and I/O completions.
@@ -900,7 +901,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
  */
 static int iomap_write_delalloc_scan(struct inode *inode,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
-		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
+		iomap_punch_t punch)
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
@@ -978,8 +979,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
  * the code to subtle off-by-one bugs....
  */
 static int iomap_write_delalloc_release(struct inode *inode,
-		loff_t start_byte, loff_t end_byte,
-		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
+		loff_t start_byte, loff_t end_byte, iomap_punch_t punch)
 {
 	loff_t punch_start_byte = start_byte;
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
@@ -1072,8 +1072,7 @@ static int iomap_write_delalloc_release(struct inode *inode,
  */
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length,
-		ssize_t written,
-		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
+		ssize_t written, iomap_punch_t punch)
 {
 	loff_t			start_byte;
 	loff_t			end_byte;
-- 
2.40.1

