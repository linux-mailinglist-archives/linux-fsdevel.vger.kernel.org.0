Return-Path: <linux-fsdevel+bounces-18458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D68B9225
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 01:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7BA1C21056
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F716ABF8;
	Wed,  1 May 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO9nntvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15827165FCF;
	Wed,  1 May 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605386; cv=none; b=G+qvQjXTpzoajh+OQ5lLlGeWmIc8lKetOC9Pq8fHRbnFjXjNeILPkNMNXlcYiMXZooLsjUI7NyIlz6qmEpwphgiZ1dUh59j/CI4VS820uLmANOnG33tm+iJFlngMufCy0iGmK9pjJ6IrCy67dAfFQmSok8GkGgdvpwnBpq3/Zh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605386; c=relaxed/simple;
	bh=6gk9KXi5PTIE9PO94iveEg+oyKD1+0Jf7RoQi9XALPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgTKkFe58bhbYW5EL8BJ/vSKvB6rOfwjV5eKGhAhGDSKQXLbsHNiDLSk+vWJOl6jMcH5JFlUrVphv8B7FKB2RuRlzD8Hggo7E1VIBO3gwn4bFdCEthw6+HV3F0nKRln9Z98PWmAcjSpX1aaVvvZv4Hcj6utTHb8phHZwbBK235M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO9nntvi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecff9df447so7033738b3a.1;
        Wed, 01 May 2024 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605384; x=1715210184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9gEegwmgLx+ewZR729FK8KfWn4crXShJOZUZzROTT4=;
        b=aO9nntvijcdywRMMjmJAIhQBsL8I4NacqDXGGnjZ8kqNBD3Bbd38JQwN+rnV810CNH
         rGa7RJiBPGrr+NVTxFc6aNGaHdOuusvciWvJPYyIKkH9iOAJNLoFanIdrszkmP705LbT
         9MwqmPTRrBBXj2OI7B7l3KemdCEb5hxfM3vBU3IuIkcIz2JVwYDo/m4AmY5cuqeao882
         tTK8M/+qS0Fa+NwMKVyynTgO4KKkYnJ06kN1rJ58eteLxPCCiSIWOmcrGqoB7AgU1OlB
         k2fYAY8RwkTTJg+FpSqF7qfVYQ6/nncRG/3P8JMMyOIiUJwV9CbuIr1t0M6N5j6yXDrK
         o+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605384; x=1715210184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9gEegwmgLx+ewZR729FK8KfWn4crXShJOZUZzROTT4=;
        b=wurdtZ9+MMjpJw3USbPn1zPoObOYIKBVAsBC7nTyxbDZiqB8Yz3LEi2i+wcn/9EeMU
         XdqNvU9Smfhcne1VBp7J3jJxmRa/lght34d59O8ljFGMSShjtz1hhnGxbBUvwRfwgbEK
         7BCfOPt1Pmnbczk1tAJFXps+wou663YNDCnc6cxUSpKQqZCpdyWYjQgdptldhRR17Ola
         KOmf93nzd3eC/wNnWYGXXHgy/lP8768HVbIeY4Q9cRRZ0jOc2YfhvKwBGawA1rWmysyq
         PC3/Mgzv0G3KFB4WpqZOb/4IgDXfGzYR0UFkEp+16dIJs8gGQWgoF8qc5hf+PdrpubjN
         2rbw==
X-Forwarded-Encrypted: i=1; AJvYcCWfT657J59d7CbJObDM9787wYZlhHUa4a3JbzJFIUvHb5jbKjQkDKsriCEsB2jyG/R83Q09jd+jWWet3ZVwjvHUUH4U6k2By5aIaqRJPYfSV4zs0iXau5wvxness2/P3qKlNQKYjIfJANi52L4eUKPGhYNkZX3uD2vKJe+dksEm79cxUV0A
X-Gm-Message-State: AOJu0YwL/pmKEG5E8DRQZLA9cMOuvwVAxJI3PRPLPZIcmVY5TxQYfaQ6
	YZOJXYJctOVlLDqtUeRvAium/Y5SWJr3h8EwckIiZhS0q2tvfYYU
X-Google-Smtp-Source: AGHT+IEso+Eu0Z9Q7uW/sa0iPvg3WM3iY/JkfYstAc2UznW0RvPozenzvmxb0jkOGepLr5DlwbzoFA==
X-Received: by 2002:a05:6a00:3d4e:b0:6f3:ef3d:60f3 with SMTP id lp14-20020a056a003d4e00b006f3ef3d60f3mr4496901pfb.29.1714605384318;
        Wed, 01 May 2024 16:16:24 -0700 (PDT)
Received: from jbongio9100214.lan (2606-6000-cfc0-0025-4c92-9b61-6920-c02c.res6.spectrum.com. [2606:6000:cfc0:25:4c92:9b61:6920:c02c])
        by smtp.googlemail.com with ESMTPSA id gs18-20020a056a004d9200b006f3fda86d15sm6323389pfb.78.2024.05.01.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:16:23 -0700 (PDT)
From: Jeremy Bongio <bongiojp@gmail.com>
To: Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jeremy Bongio <jbongio@google.com>
Subject: [RFC PATCH 1/1] Remove buffered failover for ext4 and block fops direct writes.
Date: Wed,  1 May 2024 16:15:33 -0700
Message-ID: <20240501231533.3128797-2-bongiojp@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240501231533.3128797-1-bongiojp@gmail.com>
References: <20240501231533.3128797-1-bongiojp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Bongio <jbongio@google.com>

ext4 and block fops would both failover to syncronous, buffered writes if
the direct IO results in a short write where only a portion of the request
was completed.

This patch changes the behavior to simply return the number of bytes
written if the direct write is short.
---
 block/fops.c   |  3 ---
 fs/ext4/file.c | 27 ---------------------------
 2 files changed, 30 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0cf8cf72cdfa..d32574ba9d71 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -704,9 +704,6 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from))
-			ret = direct_write_fallback(iocb, from, ret,
-					blkdev_buffered_write(iocb, from));
 	} else {
 		ret = blkdev_buffered_write(iocb, from);
 	}
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 54d6ff22585c..d0760452a11f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -595,32 +595,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	else
 		inode_unlock(inode);
 
-	if (ret >= 0 && iov_iter_count(from)) {
-		ssize_t err;
-		loff_t endbyte;
-
-		offset = iocb->ki_pos;
-		err = ext4_buffered_write_iter(iocb, from);
-		if (err < 0)
-			return err;
-
-		/*
-		 * We need to ensure that the pages within the page cache for
-		 * the range covered by this I/O are written to disk and
-		 * invalidated. This is in attempt to preserve the expected
-		 * direct I/O semantics in the case we fallback to buffered I/O
-		 * to complete off the I/O request.
-		 */
-		ret += err;
-		endbyte = offset + err - 1;
-		err = filemap_write_and_wait_range(iocb->ki_filp->f_mapping,
-						   offset, endbyte);
-		if (!err)
-			invalidate_mapping_pages(iocb->ki_filp->f_mapping,
-						 offset >> PAGE_SHIFT,
-						 endbyte >> PAGE_SHIFT);
-	}
-
 	return ret;
 }
 
@@ -958,4 +932,3 @@ const struct inode_operations ext4_file_inode_operations = {
 	.fileattr_get	= ext4_fileattr_get,
 	.fileattr_set	= ext4_fileattr_set,
 };
-
-- 
2.44.0.769.g3c40516874-goog


