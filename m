Return-Path: <linux-fsdevel+bounces-58663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E44B3068D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125D71D02578
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EBD38D7E7;
	Thu, 21 Aug 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aOBn9oFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEF373FAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807657; cv=none; b=WwT8UWvaWGPALXKXxtEoGz5kqF7xIeVTYw8CgbCq1kREuyaMjqRZtSxLyuvEiQ4mHQvJdgzIFatTef7LoWaVjci9vqZ2EIdoxPN01uRtG/zEqV9ydumouOSY0GkkbFqM8mEb/bDOlndJqfR3Y6umXx0Cvr3pWrKhvo/XA0RMyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807657; c=relaxed/simple;
	bh=NKVthHrTpyCuYxypL0G6ZssB8gJJwQE+Gjakb3Uib/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myhDgVAew20izb/eLze/WOyQ+1eFLxrrJE8fmslsURmlTtutoVSLGNQEVl8adyVQGoozZN3t9HMSpq6WL5m12Nm/f82U6LlnwjmiX52inAYfogCXSq42JzHCPrX0wRqb2h4+mg59EW8kO0krjDyh5O4GAapQWaaN9WfxL6ZyLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aOBn9oFN; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e951246fcb6so862138276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807654; x=1756412454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PorrIJhHXaHO27cDWxDKTAUw8tGpPd1qttfIj42aEmU=;
        b=aOBn9oFNsc51+699KhZE2yc79RJokgJKK9twxQhRbiO48sY/4ek8a9vjqBoCAFFBoh
         wyGcYOMGeCvDABETL7qL9UrzrtEvjEMrUgd80UtZhMTldUb3kClKs4SmdNdkWg/xlYs/
         E6rMPvGBXy1sg0FsKBBNDTjnVb3KU77NC4xSO7bfWccIqnn4/9YVl0gwUTbKrwelCtTy
         2aalGomFgU9e9NZJ5teqxdgsBDR3EL+3D5wG+QPAxN9/rhQpQUj6nKUMAjVMOurDkpPL
         6X+ZtPNWvujefTv5NiYyaqdvRTlUr9btUibDyvnnMwsn4ar6qdjCOXjbu7/UwoJbNW21
         /EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807654; x=1756412454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PorrIJhHXaHO27cDWxDKTAUw8tGpPd1qttfIj42aEmU=;
        b=EKuTJqm3gZvwikM21wutS9Z3YlXhuQmXBHmYmNrDdJMTAsbQBMzm1HmW3ViGhFJeI5
         JMSY4pEIqfq9FUfy1YZjsI01XLkICV6aS3fvwGq2zw+kKCasohcBQZ17TsG4O4aIQjtm
         wX0JVHWAbPay3rhUch6czPKYSaLzZG7bvQWsPAWTHgunps9yRtxdnkh01u9QifpRP0MU
         1imPerQTRG8+8mgxwB9zYaDloP6SBTsxqH+BmPVk5vC1cRgM2qNySNCVXGtHpSuwvgpS
         4yFSsohNFm8Qx8TSTdjlCsksLck1JY2AAUyUF4XSsvcvGPDFJJfIyRuLzkN+w8FGsZjm
         wKvg==
X-Gm-Message-State: AOJu0Yy8+zaaHkZxFF58kCnJPAHKYZfxQ0ghmxqsbV+Fwkl4GxCgJKIf
	spwZXELfTcaH4nDb4m6ni0c9j7I6YSEdVt4G7fcC+Q3WAg0+O0pQ3py9uN6tj5cfDhfEi0z4hxF
	hvdQDKtlP6YuH
X-Gm-Gg: ASbGncvQQty86l2Vs4uSqBqXJ02xamzF2v4ukxAkSYwV/CdGMI64FLqU23yciTGlC98
	bBE6YD6h3kPyhua5b8T3E8jH/wkF3yExllylnUcDhVIvTThZUc+4m3D7MUz2XPbRAa+43vvKe6A
	G7jbBPIE8bES8K54W5Mxl2ZH59qvAGCtWJkzwx8+v8Ol0RHzyWzORQAqQF/JDBtY4u+xjolGxae
	vXkg1lyRS6TKuEzTMJKS2vQSTRqyTzXK1CkdbRHl4+ZRCUsBxFtVMJ31jyvhq7DrBgHHJw02v1M
	wXa4iqhYF3Fpw5J0lZgc+abGCymOWRHvYLyMpMyYErSFBHSbGXDou7oeq+j1vYVljGmZzRNX8v9
	nLSvwBjhormAsHOk+f+3GnZqD1+IYOCjmZzt0VpoVFx4FPHadCW2aeRzPZlAN0t6/G9kR8g==
X-Google-Smtp-Source: AGHT+IGbGhHtW+dkKRPeIKh0lukvvT4QFrNpyVadJdYASbUMv52STVjCCLg+pYG9C9deIRU2g8iINg==
X-Received: by 2002:a05:6902:2b8d:b0:e95:18dd:6a83 with SMTP id 3f1490d57ef6-e951ce0495emr555156276.11.1755807654366;
        Thu, 21 Aug 2025 13:20:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951c976124sm142232276.34.2025.08.21.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 26/50] fs: remove I_WILL_FREE|I_FREEING check in inode_pin_lru_isolating
Date: Thu, 21 Aug 2025 16:18:37 -0400
Message-ID: <954a16d781fd9bfc1b6cfec40af80475f710acf2.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the inode is on the LRU list then it has a valid reference and we do
not need to check for these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index c61400f39876..a14b3a54c4b5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -682,7 +682,7 @@ void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	WARN_ON(inode->i_state & I_LRU_ISOLATING);
 	inode->i_state |= I_LRU_ISOLATING;
 }
 
-- 
2.49.0


