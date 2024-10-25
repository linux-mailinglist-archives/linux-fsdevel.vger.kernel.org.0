Return-Path: <linux-fsdevel+bounces-32848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289C9AF867
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 05:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34411F224E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C61A7AF1;
	Fri, 25 Oct 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP92pPtM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DF19939D;
	Fri, 25 Oct 2024 03:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827991; cv=none; b=OeTTT5Y9MD9uFo6rJKpXVD9JbQR4iIhr+98gaYF0b+xtmMN+bMeiDb8bxh9u1zfToRo+lJFn60XNDEjorNan06wO1DZw7+qLX6oEdyPmhobMA/MynXG6KCLbeHqtiz+Bdo+3t6p7kQLtNjG+XEl4ZUpAv+8rBhw/WF1dUw2XZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827991; c=relaxed/simple;
	bh=o63aZeBXY/zTOtze20RJSIco9C0hmLZ44l45ynxwh6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iktd7zc4sqBarM4YKLFmMA5TQ7I151XK91C7gG9N9ALVtiMbXV5r/85cZ4Db4kBSXCOZ2tGsbjjd7Pm55ofW1NB6jKzaf10mSqUoG1PLsQb4Aek5CpK0o6zd6HdMRCN5eDpPHvlkOPF2o2jVncIbEIjeGE142Lds2dXSr0srXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP92pPtM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so1049477a91.1;
        Thu, 24 Oct 2024 20:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827987; x=1730432787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCbMmlCDwdFDP22giaXn0ktZZ41Vb2DrHB5O9DWkb54=;
        b=KP92pPtMu1wXC3ERCQC+THy8mXCde/pwl3tk4ZiIlr8irwRIw+LYxxV2MsEEz7WHxF
         3Dh5Z8O6JTDnoS2Z66owjRdg+z4QupEFhoZwuMOj4Cy/uk/zhHhWWNnYura81uaFwncK
         08a+pgHjl9BIjeaNc1eFKxJaMke+b9KmJjxyrvD3u7bizyqNWw7nGzlfj+b2X7AFrNU6
         OysT9BWkxwXUi7yWV9sPiq/raep/Y3wMGDcWqNRm3LiSdMcgvae3L1F6KUt/LYhwWl+F
         OlBP7Qq+Y4lnALPmn6YjvWnSgGjp8MDBe6mLMNOaigDOkeGyL+zMq0TltDTFu61tSypi
         Rd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827987; x=1730432787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCbMmlCDwdFDP22giaXn0ktZZ41Vb2DrHB5O9DWkb54=;
        b=ZfZoCDqVN7GWfqmer4zfReDpuhOPIM5pVAbuECgup/jliOMSu+0MzVrw5dkKtnlP0Q
         /W1DUyJItI5rK/DP0WkR6rYmjD7rPFDzqIVOCkb7ron1wqrTIIUMerI66qjbXLmbaElR
         P8t8AQkKmTUEtSupTE1baoa+P9/DVm7kITQBAWWKzKsX6bTuhOXITmpVcSAmzlVMW3Kv
         iaYzJ8Xii6/vsYlPeRscKOTMaNpF07R630CRWrdDCgyzhHGYkU2PrJMVRiov0LVDolnO
         FUWvPDWn54Il4b/p4YwlqfOK3yWZncxug5St/rBwYzhym45oInsHz3AEDBlGBKM7s9ol
         wURg==
X-Forwarded-Encrypted: i=1; AJvYcCUfYXDiHqXalFO47rOhUrZbohYbX1Y8FjApu+9C2kTitB5V9CBrxdBllW+rJb61cKHfI3H5ja8oCJFnLSDZ@vger.kernel.org, AJvYcCUmGiC4JXqWkLyq9b9aO9DWFdwDshjjExq82frY3Se4nPiw9EUDznoLAbNikjkHN7j3XlfIRMz/u8fOZPc/@vger.kernel.org, AJvYcCWQYvyf7ReB/iX+gdazERdwB/qFxF7lQ0wg1h4bX+yW+LZx0azjxz8tEeyLEHDD3sspeqxiUQV3F4H3@vger.kernel.org
X-Gm-Message-State: AOJu0YyuD0zNIGJyOq+IC1+8UYlnRRki+yk9lLwkgWcimVshPncpq1MU
	pMQ5i91FnHlN9eCvunaf4PdOoZT+B740p2zlHeqIQBmEEUx1ULNwc45MoA==
X-Google-Smtp-Source: AGHT+IFAKwYiwV48LqiQb/bilCzX5cHKd8+sfJVkn41DgjX3ae+16SD3YIvvPuCMBqBidCdSRVY9rw==
X-Received: by 2002:a17:90a:b003:b0:2e3:bc3e:feef with SMTP id 98e67ed59e1d1-2e77e5a707cmr6356526a91.3.1729827987017;
        Thu, 24 Oct 2024 20:46:27 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40265fsm3463176a91.0.2024.10.24.20.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:26 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
Date: Fri, 25 Oct 2024 09:15:54 +0530
Message-ID: <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729825985.git.ritesh.list@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystems like ext4 can submit writes in multiples of blocksizes.
But we still can't allow the writes to be split. Hence let's check if
the iomap_length() is same as iter->len or not.

This shouldn't affect XFS since it anyways checks for this in
xfs_file_write_iter() to not support atomic write size request of more
than FS blocksize.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ed4764e3b8f0..1d33b4239b3e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != fs_block_size)
+	if (atomic && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-- 
2.46.0


