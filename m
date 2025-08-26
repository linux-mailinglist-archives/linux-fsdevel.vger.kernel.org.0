Return-Path: <linux-fsdevel+bounces-59261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C9B36E88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A57D8E7370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570413629BC;
	Tue, 26 Aug 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zEftBxnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857D3629A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222892; cv=none; b=VNj9S1dsJY3TIjencgIFoqTN1UzN/+b0875a18vbNpin/gxm1tMWmcqPKySP2V6b49ZukrQjX0hZp0ssWBNvdmYCP2TpQcn8fVuFC4FtY+LyLs4QHDzxaFZC2QZcJ6oHCSPavf5ydM4JJQ63TeM7wROzmCgj/ytceb0SpsqY7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222892; c=relaxed/simple;
	bh=7Rb0WDz6RNiTOxNcfVfw/tSky4eT2lKquvzMe9BAl6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE4CGHbTo4B8ONVd5IrYa9swQvXg9z15Ka2OKphLaiYOzpJcxKWqEaBJpVsUZJ5r+5i0YH4zHQZyO98bMTKvKrPxWQm6IITOOX3cm6m1NleiwR6IUrT0Owov7lBw3neTzcA3W8DK0WLOWbk7pjWYGuR5ls6RuX63TdbwxeXSYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zEftBxnH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e931c71a1baso8241212276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222888; x=1756827688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pKHzHpITaAc/mjXTKQS2R/PEauqoOSV7l2KfBiByOc=;
        b=zEftBxnHOYqdJPVmTEXMYULPzm+1QQ1YN0kFgb3VDGK+z9TCCHC2njCjZoYJmPf0zI
         xZos5vZFx0pUPPuPWAFDp8hzx7eQDWWtj8TzNrfWp2vOukmRps/7etBdjP/fXKxYMG7y
         ZW9tl4+OOns9pZy6c3vgi8vCR7raxs+g5vXa3Xa7+8EyaOk7P8OASzrl7AkNWnzEs3ys
         /zdBiA0XBuwDWjDrKj/pP3n483Nnw9AzFAGis9z/mEVVv+XwXjfuVHlO7y6ZlN1aqCpk
         Iv9iz8/b36g46zQVGbEGYmombxLPIJZ0EDlY6DVBcyVnbJrNOH7Ghe63wJ6bPF3Dzqzk
         hOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222888; x=1756827688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pKHzHpITaAc/mjXTKQS2R/PEauqoOSV7l2KfBiByOc=;
        b=r9nLWKa3WTfqJ+w6SBoHShDw/Mxp87cb1bhAXNntsjPHwOyd+5qAqVLG+qhRDfSEcc
         P01A9PLifevFO0RM+1gHR5iit4iLYKMOLPh07f0SnRpA1ZP4N7BErrLIwgoqA41Qo7eD
         ophTg7yLX82m4jlpQeArVZh8iATx2M1AHqLpLt8pYz/1/rhnlUyOAWCqXSL1DSfFrW0O
         ITucSkOE3SNv+3yPV5Z2kWftS+9OTpFDyNYcV/gJPyFnAS517dJOripzXubx7YtUBeiX
         vg8rmDSanBAw/ZQbmCIv9amnQvqsj4iQQu1gax4aHAjCrVLhit9Uakk0ZwDFy5BwZeGv
         5XiA==
X-Gm-Message-State: AOJu0YzXe2rzIQfrfehlKVnRMr9pCe6ty2jSghblPNezKH3Raeej4t0p
	OjcPhsBmiHU8zWJK7O80vwccFOso+ORpGmKRD2eF7u/rigtwaCBj29WvB0rbrfIQew+xcypYvO9
	s7HNG
X-Gm-Gg: ASbGnct8swR1o5N9e/pXNUHg1feFZ5UoghLZNSFbH8ts2A++laV11ncgGM0k3sT7rFe
	csMYVQ3DiobZXZvWa4WVOIdxK4aoIhnJOrRQHlxEoKMJk3opTLipttkzUuDNAFnAHPYBcGOTNLk
	+vaET1j/lm8KFz8dTJ5yehghbybsvYY6VJpuf8zO6G8nFBMR7Gd2ONo1oqKxFaP+DhBIf5av98V
	dtdft478u2vqj4O/f/JCRYHIq3nr9nQzKLjrnPz+ROG2Et2P5NkIWIdex/wxYgbD0S6IfUO/1bj
	Adwy7zl/TE8pwqAf5v7qWzLn1K3oGsnHA2G/iCxRnn+85L7WHhM7mWZAyffNyC2lDwNBEWsxnpp
	1acJBjSg74ICkB1mYtbA91XgPkhyz43o3sAJgBmqhYsaqrc+VhTRp7bn26z8tYB6BxM6GJg==
X-Google-Smtp-Source: AGHT+IHpeaJ39DrKl0SHq4TeALy48X7MoeQZe8JyD4wQTO8EFKaesDAqzHePbJNfnv8wB7k8ckcMHg==
X-Received: by 2002:a05:6902:3483:b0:e95:3b7b:6e4e with SMTP id 3f1490d57ef6-e953b7b72d3mr8336972276.53.1756222887983;
        Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96ea63fab0sm169958276.8.2025.08.26.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 27/54] fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
Date: Tue, 26 Aug 2025 11:39:27 -0400
Message-ID: <5b72bc52855034d68887e466dbf790d6c2a1a9eb.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only want to add to the LRU if the current caller is potentially the
last one dropping a reference, so if our refcount is 0 we're being
deleted, and if the refcount is > 1 then there is another ref holder and
they can add the inode to the LRU list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d34da95a3295..082addba546c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -597,8 +597,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	lockdep_assert_held(&inode->i_lock);
 
-	if (inode->i_state & (I_FREEING | I_WILL_FREE))
-		return;
 	if (icount_read(inode) != 1)
 		return;
 	if (inode->__i_nlink == 0)
-- 
2.49.0


