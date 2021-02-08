Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCB3142C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 23:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBHWTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 17:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhBHWTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:19:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500BC06178A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 14:18:38 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l18so426548pji.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 14:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l21CUn6uOrJ6V+uVH7pfm2X9pDOAs2Cr5X1HAOPDvBM=;
        b=CkUpTf4LsCzZxBf8xCPGD9HLztKuswz0Wz7mkj/6AHj1jEV5viIjhGkLl/M0cI8J//
         YP5VkdWIj0dzDanvSVirVQ0PK3pZDI05qlB8A3d3pKAsbn2yW/gNuOSraXYqSYQ7DFoN
         K6eFLBvv5XjfRIG+oPbxqWY8tjvUgjLhfz39BTfw5axsankjScRZtVRa1990CQs+sz5k
         RsaBW81w/If5OHKriQMeTrp1A/pJQVLqD1USt/TlJvccTgyyVy7XzH94Dpkk2kIzDx42
         zcH+/GiUASWBwFiPFFO0dc9zxHTjre3uaUtyaxw5u3SJeVRq7W2SeEWYM7qpyL5eVVM+
         to7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l21CUn6uOrJ6V+uVH7pfm2X9pDOAs2Cr5X1HAOPDvBM=;
        b=awBKRLgc/GBwIo5ssF/qEPNhF6gtF2GHeixOnR+wnsKgQf4G/CmfhNor5SCYMJVEFp
         HAuvrXT4RIYS3jmm4zrrHCPnIPdqhQzXw8UWSrChoB7aC5yL/vv92guFmqZ3ucp+yLJN
         9KKNF0kAfDoJ6BOtDq/CPpnyAvSjnw+EN8L4q6B8ojYwaiWSTaQ068q/AQZRQw91ZROK
         2WONohA9iJ8SuDthCbxs04C5bejqT1Qd412rTPlaWOc9Z7hYs8iMqNYb8sB1vfG5mzYx
         9eb0Rjhso5WdMyZ9CsZV2XUvgTwxF6RKXBXDZHLUMJ1+L/Jv5GAf4Ff1Ag4NsGU0R97g
         bQHQ==
X-Gm-Message-State: AOAM530UZlT8CPKUxOeAl2xGqOGOMO0X4xG/5GUNc5KeZMK5POmzKDxm
        /5miCSIrsaGYBHdg8FBRVfWru2nPocGP+//I
X-Google-Smtp-Source: ABdhPJwk636mSXsDJfOY2icC7pKLKXKi13Hf9+733aw6b6XHlVfNF13HD2wUVVO8AIxkBCDamgOU6g==
X-Received: by 2002:a17:90a:e292:: with SMTP id d18mr940078pjz.66.1612822718274;
        Mon, 08 Feb 2021 14:18:38 -0800 (PST)
Received: from localhost.localdomain ([2600:380:4a36:d38a:f60:a5d4:5474:9bbc])
        by smtp.gmail.com with ESMTPSA id o10sm19324472pfp.87.2021.02.08.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:18:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] mm: use filemap_range_needs_writeback() for O_DIRECT IO
Date:   Mon,  8 Feb 2021 15:18:28 -0700
Message-Id: <20210208221829.17247-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208221829.17247-1-axboe@kernel.dk>
References: <20210208221829.17247-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the generic page cache read/write helpers, use the better variant
of checking for the need to call filemap_write_and_wait_range() when
doing O_DIRECT reads or writes. This avoids falling back to the slow
path for IOCB_NOWAIT, if there are no pages to wait for (or write out).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1ed7acac8a1b..3bc76f99ddc3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2646,8 +2646,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		size = i_size_read(inode);
 		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_has_page(mapping, iocb->ki_pos,
-						   iocb->ki_pos + count - 1))
+			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
+							  iocb->ki_pos + count - 1))
 				return -EAGAIN;
 		} else {
 			retval = filemap_write_and_wait_range(mapping,
@@ -3326,7 +3326,7 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/* If there are pages to writeback, return */
-		if (filemap_range_has_page(file->f_mapping, pos,
+		if (filemap_range_needs_writeback(file->f_mapping, pos,
 					   pos + write_len - 1))
 			return -EAGAIN;
 	} else {
-- 
2.30.0

