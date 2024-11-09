Return-Path: <linux-fsdevel+bounces-34122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E59C28B6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472CE2828B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FD156CF;
	Sat,  9 Nov 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eu2IFWls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1E11C83
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111238; cv=none; b=QX7jrO+hAfSKMd89IVuvXnW0S1923XfjlRjtswuZPQjDpIHNz1OF3X+jwsxXJ/inQR9xkkLrNp+bbYJ41Cjey2Aec29utSUiJ7/LKFWYNn67G+x5chZQR1Epjn856RhmroQGvX8xnjBqrRM9PVPGi8HjAFDkwV8A5vwJF8KXUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111238; c=relaxed/simple;
	bh=n0wTy08gTNDcTPVncomZCV+JItLqn+6vP1ed+UPceNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxmBPH/OfeNJolYXHaRvHoT6bf/GWxzWu35l7eIyzCCV544D7/RdX4DjaEQ5rzgFrmpHRU7fYXHBjD5A/1NWKHPwhQ3mFdtnUrL+GAbyBQBsu6aKKqTHB57/0hbNiUHMGKpFcAnZB98XtQMaSsGoWK5cGIFvUkKzvzBRehQZ798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu2IFWls; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e38fa1f82fso22042407b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111236; x=1731716036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cXyCKYyxPU+j24IjLjAHeILBfQqTehQhtOnNEc9Tsc=;
        b=eu2IFWlsQlVW5Q18PoBLYh2rY1YHc/Cc2vG5YxRSioem+GGdmEgqP2VPhA5VDLEY1a
         XUKNmO99eJw29i4/baRatCbUGV1hsNIu5a9aGyzvoHXNxLfbizMp6nA8LQSViQoIQX9u
         Ka5HaRoSPMiXXCODrd6fBWeIBKqqLOp0zNLnVX7/RCTBvyYrBg36MsA6UNSnFYa/kEFT
         milhUiFhuUF5wqlUiqIxvkZGmE9uhWZ7xwAT+7q634a/q3IhB5ab0RNwt5fvSrJum50K
         fmcccfcwcRRl5fLtEEJ4zGSltpF/qsM6z3sopz2m0yeMB2J1yqpLGQVykqVtZ3OJPuGY
         ymWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111236; x=1731716036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cXyCKYyxPU+j24IjLjAHeILBfQqTehQhtOnNEc9Tsc=;
        b=jXdfxgU+byaT8ql1UJa76kPkEonu8b7tMdhmpNoHMTSzfjQxWguTguv3pcen3bwi7V
         JiXgEGZwcXujzSyd8WK7A/mLSa14oz3rlLiKNvBKtENB/lSGkdsH98CoBWJnTrxirxzQ
         sKuQEk+OgP3lHJaBfkdClguvpUhEay1KO2bXFJZqy+nWii9G0gQfjY3dFhWl5rPzuSYO
         VljAWmI53XWSoXhXrTnqjeR6RAPpQdd2GEKbc0XChDXA6sUugLWV96qDJoitXPIdu78e
         YKLI0zU8awVgm+Rq5CEQIkLYjsWohxZmxJU2V5JJ38hKA3+3I/WMd1PfXsS0WGGQXP/U
         mUSA==
X-Forwarded-Encrypted: i=1; AJvYcCU8segOgHodan8gS3EVddEfU5Lkn9dIQe9Kp2dtpjEqHfsK1v/y2ow8WNe7nggN6WeycJ97XShmCIdN2bfY@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGscLU9sFyI/5pxNu1K5toE2VIkVAw9V8vQ9/uP5XkmFxVsfU
	sk+TzSEAYfM2nHoieimrT/4I1QX89GwnccZDOAO3GaE9vBAz3x/k
X-Google-Smtp-Source: AGHT+IH2qlGPjKHETbOw6e2NjWmPSNSapYh0y7aaToGuXoa4CS99SiFpF5hcWXNMicIn655fRs0Yhg==
X-Received: by 2002:a05:690c:7083:b0:6ea:95f5:2608 with SMTP id 00721157ae682-6eaddd8a695mr60643507b3.7.1731111235787;
        Fri, 08 Nov 2024 16:13:55 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8ef3ebsm9417937b3.34.2024.11.08.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:55 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 12/12] fuse: enable large folios
Date: Fri,  8 Nov 2024 16:12:58 -0800
Message-ID: <20241109001258.2216604-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable folios larger than one page size.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a542f16d5a69..20fe3dff8904 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3166,12 +3166,17 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned int max_pages, max_order;
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
 	if (fc->writeback_cache)
 		mapping_set_writeback_may_block(&inode->i_data);
 
+	max_pages = min(fc->max_write >> PAGE_SHIFT, fc->max_pages);
+	max_order = ilog2(max_pages);
+	mapping_set_folio_order_range(inode->i_mapping, 0, max_order);
+
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
 	fi->writectr = 0;
-- 
2.43.5


