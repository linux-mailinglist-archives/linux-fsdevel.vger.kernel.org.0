Return-Path: <linux-fsdevel+bounces-54199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0550BAFBEC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8443E425EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0801328BA9D;
	Mon,  7 Jul 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgz/lwlB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED9288CB2
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932020; cv=none; b=cjjep+yfXD2PZS0tafQZHiqq416X4muHTj9uPcSd+YfnST7i+pmf+Xyy3qnwUSE+bsse/uZG2zka2lEm0b5mHC/YRrF8xr+A1WUzQCgeFsk4qFWd+DP6BGl5DchFBgbEGc2EGhwEBwJv5U1sXSmE6P92v3iJmVbP79z8eHeyxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932020; c=relaxed/simple;
	bh=4HO8JacwR8tYZm/383eHBp1AIahe9iYZuO/sWaU8sUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtmTPkastAnvpiBmHHHsYfDcIbLPVwQISkc1SGyF0qDYKi6eR3k46xnxOhgdUuEUhT4lv0u78cKR0YAUM9btetyGWcmfKgtklZBHaV2f7HdLx70ZkMf6e7Oz9od9dMyM+GMtHtwQ8yFTMUV0uoEBqXyR7nleG/7Kt+9JNd6RRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgz/lwlB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-236377f00a1so33690175ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 16:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932018; x=1752536818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2QkLbl8Y6csFmF74obpk5VAZjfP3MyEBaRP4bps0CM=;
        b=jgz/lwlBAyCrVjYGFdCJub3QFZ3h4K0MmJTy/OKbregmdJQ0XkDrXC036FSpSbDMep
         DG2xpyd7Eg36vu1vEnEOoL3FiHG7scyLEoan23mC/9R6kGAs6yDhLhjOqdv/2kJbvDL+
         g3hpDVIphXLJlWNX7Ua4JxrG5vqCFel1GLDB/izoh18lgf06W2yiZH7ghqdnGubjSios
         bPbFZodeMgc3fRHt2bTeGEcy/Lb3KVI/T7rAm8uUFwwjUYMJGlFaFA3eEecI7fvVGCiS
         mFhzsbB5RrqldFOIatnGSQXZAWqay6dYIp6EplvuAiuraCK3lrWQyWqPI0UB+gZBqIhZ
         b0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932018; x=1752536818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2QkLbl8Y6csFmF74obpk5VAZjfP3MyEBaRP4bps0CM=;
        b=cirjdJbjwOCU6Ar3+usZfchGMvkl/73VC1/2tPZZRj3129/em61jI7A45UZwzfvyog
         GcMST3vxKK62blnWi9vVmPzBuzkGGbvEX8i9dBPikYZrO/cLE6GDY5DIrgJWJJsWh0nB
         vXIdsMpLaFyIAfTMYeVa3mQ+oFvWdiGTxVzfk1TD18on75PtNSvDLn7pQzdhmzR5F16q
         XHbUwu2qqpJ4j+kX83PW+uwdDgHouJLyZPzM7FhaP/bHi7Ty7adlqBw3gcm8wpWGfA9P
         nROG2X2fA78B81k4rpcTJtnjWkdwC1DM3nhjXfRZ/QLbqG0Gn7cSd/vKPGZi0HetvyK4
         l39A==
X-Gm-Message-State: AOJu0Yx+1cG3tH1NDiqhOdZNOV2CCGyyowZMU/WioXmSQAm/qhQwqLZB
	i39ClF1HbMX1eS7qSyk7tHV/kuGD1ru1XQVgyCm6vMez/S7Txmu2raaySiR38A==
X-Gm-Gg: ASbGncu5H/ZwBfTLVvVJrmgWJk+VEMdPa+H2Xssw6z29q1BEy5B19nlGx2k8WZ9NhFj
	PDXjE+hqwMEPwFFvQUH6xEt21lJrOuTrWJ7dEOBx2IS5EX7JQb+FWkxQbVM6nskZ5zHhMfm1ntv
	k+yPRmh2ee+eWbw0vUw/ypfwnju1UAUF9O8+aMnYMsnZaWvC63naTYiXf5h6Xe+XzqF0RBQAnm/
	jqs+ko5FkY0NmMnnlaokGsNU8gzVIxvANQxlyh413oyl5fc6auimi3HkjmA792FkZMD5aGKRxq3
	L6Yd4GO+xxgi8QceDTZqtF6hSdcoJ665ZpGzlgaQ1o6eAZMHYOkPyA==
X-Google-Smtp-Source: AGHT+IFAEOPpGLsNEswIoTM0viOk+q51H5C+AHk+FOjZzGwODKLLXrX5Tj07mV+O46SIRycTH9rETg==
X-Received: by 2002:a17:903:4b04:b0:234:d7b2:2aa9 with SMTP id d9443c01a7336-23dd1d65108mr7492745ad.29.1751932018123;
        Mon, 07 Jul 2025 16:46:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bdd19sm102186685ad.245.2025.07.07.16.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:46:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/2] fuse/mm: remove BDI_CAP_WRITEBACK_ACCT
Date: Mon,  7 Jul 2025 16:46:04 -0700
Message-ID: <20250707234606.2300149-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the changes in commit 0c58a97f919c ("fuse: remove tmp folio for
writebacks and internal rb tree") which removed using temp folios for dirty
page writeback, fuse can now use the default writeback accounting instead of
doing its own accounting. This allows us to get rid of BDI_CAP_WRITEBACK_ACCT
altogether.


Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20250703164556.1576674-1-joannelkoong@gmail.com/
v1 -> v2:
* Get rid of unused variable declarations (kernel test robot)
* Add David's acked-by


Joanne Koong (2):
  fuse: use default writeback accounting
  mm: remove BDI_CAP_WRITEBACK_ACCT

 fs/fuse/file.c              |  9 +-------
 fs/fuse/inode.c             |  2 --
 include/linux/backing-dev.h | 14 +-----------
 mm/backing-dev.c            |  2 +-
 mm/page-writeback.c         | 43 ++++++++++++++++---------------------
 5 files changed, 21 insertions(+), 49 deletions(-)

-- 
2.47.1


