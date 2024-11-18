Return-Path: <linux-fsdevel+bounces-35061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39B39D0950
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 07:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9281F2268A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B6145B27;
	Mon, 18 Nov 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dj432bVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80522083
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910106; cv=none; b=P0JdKwB/Iwsc6ep2gyJ14yyM5epzAotPWgxbOysGm0vIFb2QUlya0lS3gKHJ+godrFWc7aGolIVSlq0SVf5ZaCYjLsmKJoUqzO4fxjlv+WVAYhaOBb1+vLicBuHw9ep3OsB9j6Tu5h/LItlO8qFIHG5jzwZJJfkypVNjKHQPa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910106; c=relaxed/simple;
	bh=cJ2P6uR4opZsVGWIta5h5IZmD3jekZ9UDttr48No1E0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H6Db6fDsON3FDXwG5t5rFYAe8E8j41P00mjVbplPkdmk0EPk+pyg+lufCQ8IlHwElQ6vtjMfqj5FZPIsX9CI/yNFq94ACTQ5nQKTBef9vkjykMquPCJKmU8Hb3mmUZtHkoc+ddS0WrkvDZUwOfNCTPaYD4QTsZ5TBvCJvaIbEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dj432bVi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so34715825e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 22:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731910103; x=1732514903; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fF7b8budhWUD2De6hv7m+BHsAeeg1J7TYowVwHq0Uok=;
        b=Dj432bVieEbcQxizrB7AhmvEEiIYvJJsuqzBbCQJEsDYCv4WHJaiNywoHacU8CEwht
         2hxP89nt6T5IjXvtqiihUxB7cDYRmidNWlayEYHqgnC9vmoWpGt5Fir/KiAdFsv1O7oB
         VF+LY5UiBFR0qtkU7rA3ODPWU4mN8hYptXymGWWJH3mKLS92Wj/IK1e+drcCiqyCX2qY
         +DuKsUBhz0JpSy8pTZM4zHevnzf/GnkJA8NxR3Q1rJ6UY2pnia+Rxq0/cVYX41bmBSYc
         IM1Mkpc0x6oGZ8t+sDGFoDG/9FqnWHd1/tFfNvXXf/WIUlidmGsOTCWiWdo/4khMXhmu
         e3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731910103; x=1732514903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fF7b8budhWUD2De6hv7m+BHsAeeg1J7TYowVwHq0Uok=;
        b=F97bBkxAYGYJJkXafkpymR20oUAqtv0yfeoPso2RF48TQpOY3B29RYb9QsYfcpC7Or
         x5MNeNcapIQpt9DSAJsj+jflHzRIUXKJZZCRz9GxDZQ5iETUbMhXP5UZocm+ULZVmWcl
         1SoiGA8EzTzKVmarkaspXxg8ajEbMRbPJ6ZkiPtyzvlFTa8LrNkYUmzvahgrEyXHLA6u
         wmb79h2as+TutxQ9DIGZvi07u0OCYXsABp6vmfg+5Vt8IbBv//2pyEDo/XCubg2SeDdR
         lNhWsPu+YTu1fhVDcPqP5/BqgVjM5gD+d8tw9rap/zrI93X+18Dz/NMroZ/B3ZkBJEpk
         8Phw==
X-Forwarded-Encrypted: i=1; AJvYcCVPNtNPXfp2hphn80Zv4WxU0KButCbZZ3yMncahOYSGtjHyIm/nsGvM8YUI5E8/E8MC6un9Qou/mb3iBREW@vger.kernel.org
X-Gm-Message-State: AOJu0YzaetQ+xAPFI9baWHS6SBYNkRhUNyhU2MI+YG6sdH9SzUVMmBDk
	fvCQOyJRZL3hPfM7XWY4sG1J8VXmI2gq0ZoyBhs62CxQN2dLVQrwcZqBJBN2Oos=
X-Google-Smtp-Source: AGHT+IEro4yYmZP5OKHef+XOzgZ/LRIKlD6qWiYZLHMGCu2nTq/i6YxPj2oMalXqgeMbxjS/2dLAvw==
X-Received: by 2002:a05:600c:4505:b0:431:1868:417f with SMTP id 5b1f17b1804b1-432df74be9amr107263115e9.17.1731910102919;
        Sun, 17 Nov 2024 22:08:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab788a2sm141599425e9.11.2024.11.17.22.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 22:08:22 -0800 (PST)
Date: Mon, 18 Nov 2024 09:08:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: silence an uninitialized variable warning
Message-ID: <867904ba-85fe-4766-91cb-3c8ce0703c1e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that "ret" is uninitialized on the success path if we
don't enter the nested loop at the end of the function.  In real life we
will enter that loop so "ret" will be zero.

Generally, I don't endorse silencing static checker warnings but in this
case, I think it make sense.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/write_issue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index cd2b349243b3..8f02d8effe78 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -862,7 +862,7 @@ int netfs_writeback_single(struct address_space *mapping,
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct folio_queue *fq;
 	size_t size = iov_iter_count(iter);
-	int ret;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
 		return -EIO;
-- 
2.45.2


