Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB146122EFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfLQOj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:39:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36689 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfLQOj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:57 -0500
Received: by mail-io1-f65.google.com with SMTP id r13so993965ioa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSvlHPa+iglQscNJSf7xQ/5HwRTlC6yUkzeNdFCcqV8=;
        b=1w7hkIWzvLtMu/dLZZMcZIijlZyfYWT25XG5COOJJfc8oH+ykaNVmhW+kyy47uEmxT
         44BfhsIy0PIQPcGGVhchbkR3/gV/mUaau6NjOzs4QWM9ffCFMNcxvMItscKe+DnZ8qPF
         Po3NAj4x4dgXGv6qHecBmhualhrDq1w6EvAdBXsygv8MWFEzZ7R9YWkEgVggpMNvni6n
         n37RGtE7bIULBdKOjo8NKGU+SO0IhHzTxOZvEEt83L9ftLfxh3r/Lej6KO9UMyH6X+iN
         W11mqMTLUelQXj54y55ExU0ini0NqxR9dbme6TbUTRm5QE3/urjzZE6sDy95hbxBcJ6x
         ntdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSvlHPa+iglQscNJSf7xQ/5HwRTlC6yUkzeNdFCcqV8=;
        b=pj6d+/OecgbANBN++1MhPx9me1xXLtppcfVxK8BbrvnpmLvPsyBGvHfA8IeV/o/O8B
         q8PY61zd8rqQ1ruIXFb8cXSj6Ziib/hts2FlwlUXsPs/bSJcDyPhUSMUrS7PgO2MbJIq
         06Sg++Lw68y8MYOg4TCK0t5kSILpIrXz6ELZLTaSRS782PwOWm38rY98pIzho4aHsKAo
         WV0TAQbYLs0LP5OQ1zWrV2LET+MWbObVI/Wk4ZhInMgUVQpbnTbdax2warzP3dzdxiuK
         UJ/TMJeZk5o82oPfmWZuGeUC0mW0BZu+D4dhm03cId/y+k6nqNWPneVPTho0x4lYY94H
         KUug==
X-Gm-Message-State: APjAAAXZ1t1m0dkHEYyNo6SGib63SvQP0QCBwfUOfrKR61uXU/Z//aCz
        KUOZPNFPXNYI0Tho1+xZ77m20g==
X-Google-Smtp-Source: APXvYqyLgOsF8+OSoa6LuQKDnmSyMVA3kpVF98IU1cYOBzMtc4vb4+N38upf1F2528sIApqSicZCyw==
X-Received: by 2002:a6b:680d:: with SMTP id d13mr3796828ioc.188.1576593596972;
        Tue, 17 Dec 2019 06:39:56 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] xfs: don't do delayed allocations for uncached buffered writes
Date:   Tue, 17 Dec 2019 07:39:48 -0700
Message-Id: <20191217143948.26380-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217143948.26380-1-axboe@kernel.dk>
References: <20191217143948.26380-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This data is going to be written immediately, so don't bother trying
to do delayed allocation for it.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_iomap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 28e2d1f37267..d0cd4a05d59f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -847,8 +847,11 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 
-	/* we can't use delayed allocations when using extent size hints */
-	if (xfs_get_extsz_hint(ip))
+	/*
+	 * Don't do delayed allocations when using extent size hints, or
+	 * if we were asked to do uncached buffered writes.
+	 */
+	if (xfs_get_extsz_hint(ip) || (flags & IOMAP_UNCACHED))
 		return xfs_direct_write_iomap_begin(inode, offset, count,
 				flags, iomap, srcmap);
 
-- 
2.24.1

