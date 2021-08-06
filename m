Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7D03E29EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbhHFLnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbhHFLnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:43:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6AC061798;
        Fri,  6 Aug 2021 04:43:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b11so10715661wrx.6;
        Fri, 06 Aug 2021 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gc3S+v0WYsSbPNetify2yT5xI0BcVIWyyU5ydgMV3Sc=;
        b=IPbfNVB0w3ZpEq6jRu9ETKWlaCzP45JOcCfWweUo5iZF1eVw0on9idRjVRaSg1Qyij
         oD8oJSofTL9dREYjOSjIr3YMCjTCg3m7RTbd/7OrKMDxLVuDB4twmwDKAECE0ht+pe/f
         idcVWBZMZ+7XaGLrSeWT6JK0kYCQySg7jzCIxIZja4671pXEFqvJ39J/Aj4fiRd+k1tN
         Y67kQ1c3fEK2p5CcjLwq7P4af1qCrt+oruboPf/PmwaenQNnfSsWtFjKQojRIU7V4/B5
         qYy6af+ICpIQdk1+OOVJaIA2P1ZslTGdoFS9wr34WCqTfdJeQYRi6P5UTgfwO9/dLFdR
         l/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gc3S+v0WYsSbPNetify2yT5xI0BcVIWyyU5ydgMV3Sc=;
        b=IoIBCYiiPty0cMPVslM2EXVPrDmKsfUIV/p89nNVWp4rmL03SueDDg7wUas2qS2yMf
         Vl2ivD4ndwRnTM5l4oTu4MGmp92koI8s1lCQZgR/251BONIihrOPsC2RfGTO4rouiTfB
         kIIfE+FTcYXpXh7BBVSioyHX3rmyPJzPLgs8ty5RyAThq6tGf3TqVnEE5InAbwh30HK7
         bLTeaGNLAwvJ9EvNyyphnXHKqRzO0XxgXYoB3Q7AW0YJlV4U512WQ74NdBufT55z681w
         YhFL3nQIhphIVEp9HUJnU+IHJmNW+Tyg1PLEuf7i7l+A+A9s2z4be9M5FFmquU3ssPN6
         VGVw==
X-Gm-Message-State: AOAM531OIdKr8lGCgeIue1eaNnuE6YEduyXgas7MWRrH0DDuhCC7R1ni
        0k6FSypa1JM23Osi8Zccncs=
X-Google-Smtp-Source: ABdhPJwiytsZL5qmxhuH0TmtWLFQN7lk4RhxQtowzzxVSQeJLkjGg1Dr/gT+LkmO+CRdUDo0JhnCQA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr10640255wro.266.1628250197835;
        Fri, 06 Aug 2021 04:43:17 -0700 (PDT)
Received: from localhost.localdomain ([85.255.237.205])
        by smtp.gmail.com with ESMTPSA id a12sm11720548wmj.22.2021.08.06.04.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:43:17 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: [RFC] mm: optimise generic_file_read_iter
Date:   Fri,  6 Aug 2021 12:42:43 +0100
Message-Id: <07bd408d6cad95166b776911823b40044160b434.1628248975.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unless direct I/O path of generic_file_read_iter() ended up with an
error or a short read, it doesn't use inode. So, load inode and size
later, only when they're needed. This cuts two memory reads and also
imrpoves code generation, e.g. loads from stack.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

NOTE: as a side effect, it reads inode->i_size after ->direct_IO(), and
I'm not sure whether that's valid, so would be great to get feedback
from someone who knows better.

 mm/filemap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d1458ecf2f51..0030c454ec35 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2658,10 +2658,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct file *file = iocb->ki_filp;
 		struct address_space *mapping = file->f_mapping;
-		struct inode *inode = mapping->host;
-		loff_t size;
+		struct inode *inode;
 
-		size = i_size_read(inode);
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
 						iocb->ki_pos + count - 1))
@@ -2693,8 +2691,10 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 * the rest of the read.  Buffered reads will not work for
 		 * DAX files, so don't bother trying.
 		 */
-		if (retval < 0 || !count || iocb->ki_pos >= size ||
-		    IS_DAX(inode))
+		if (retval < 0 || !count)
+			return retval;
+		inode = mapping->host;
+		if (iocb->ki_pos >= i_size_read(inode) || IS_DAX(inode))
 			return retval;
 	}
 
-- 
2.32.0

