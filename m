Return-Path: <linux-fsdevel+bounces-37391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9029F1913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C52188F08F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FDF1F12E3;
	Fri, 13 Dec 2024 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItWDnVb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9C1F0E2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128605; cv=none; b=Y+jvEh4tGp7n4V622fNq51w1J186/lO8LKrgDVbdskBCzWeOxHR16YtEWumQ/CHg7pNcRJKIwvRxac9g5EQUevCoaFtl2NHCvdUBeR5A57VVtPkeaf6Emkg+bqcMPkEoDOHROEU+IYrZmeegyJCVrlsx0j+rCaj703cKsn0NheU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128605; c=relaxed/simple;
	bh=3BNbFm5jNBG6QEuzUOjwPNlY5z77HfjfRWherkDukMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijfAarZT4aJJZRa4UWUYcPPVD+S7lsb7rh4QGIQ8Ab8U+MetxROR28rg1pNHF08sbbbyQzRIcmGTJQswpQKO9LUdaKQFjehX6Hj7lxAJGBsY9P3MEs/No8+qSCXova5cJsS12WkD4P7HdhBk5wTpDpN4EVUoJbsxmIcioLvN+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItWDnVb6; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3fd6cd9ef7so1722799276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128603; x=1734733403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/rkiTJp2FwPBEaVH+i5vrwjhP0Gq4YPeew8BSrv5bU=;
        b=ItWDnVb6Nq9AxINsNKYlqbjVLzHIiaLz2/jzkmeM+duvO4bC10dKFb+RatUJIVdhbg
         NrJWpjT+Yvz8y3FRYtM4YRsxC5cPDjn+HTCX6U7qswoZdCTO+OrMi3cqGNgFnqj7L608
         D4hVexyTExOKprzAA99oUOrzENIdgtkLqXnlgpwOtFoyk4sWIWKr9cScXCkQZr+EqPi9
         cUQ7//j5YmQ2hBnJSKqm93sbiiehQfABJ2JBOOwIjU+MmA9I/P8poBBRmOwmpptt5MMd
         w0Ta8LMKJUqbq6Mu4lNdZH62e1luVGL22a4jdYWaauH137723bCQxMQowZXPbnJVTLFh
         g+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128603; x=1734733403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/rkiTJp2FwPBEaVH+i5vrwjhP0Gq4YPeew8BSrv5bU=;
        b=NnRhfcpOJ6TvqlJtM0f4JaV4DGrA870wgT0+kRzLnEEs+dgOOKec7/62RXDfGt6XMt
         OPru3Q2YhEcjDaDIjI9AoyaW1Qlx3sI9lPTAHG0XTm1rkcUMeqNMRoWx0g3KuD6i3h3g
         ySHTtot82aZMvKCaKzyiVGkScaRF0dps4SrRZR3yqHZ9croChRf/WPygiBrK8SHlCFfg
         h2OpMNalo8NK0vcDli+YJr0tNU+UKIynX80z2RXg/fBJagc1cPUa3/0UDZnaa+3mDquE
         iGJhfZ+YNJ4cAIlkCUnWZ4P0EsrB76CckMlP1Vw5h0SlGunPk17bKtuXebYGErRrOChx
         qLhA==
X-Forwarded-Encrypted: i=1; AJvYcCUWQS6uvNzlm32OiULFVPXDFSBhjdlvKfFNTPn+I0kbSW0i1zwnMub29N3ksgf8eJ3oWfdK+qkYwovRSMk3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8zqrMdX2zxDu30BQphroUb66VLnlLyNoKQvpnlopNhtaiTPZi
	/FBTY4VtrkHG6TBGSsGffs8HyA4kzexGO0TBuCp3uWRlD4k27Waq
X-Gm-Gg: ASbGncvu9hH6M2M/tN2DMocob7KxhSita71uuvGbKvhvwX2F/5FuTUWRqnq9IAnEvRT
	f5fvB0zaEHE0slczHCHQmy/wwFFOSWSwdC2iramQRGHhitSyZ2IzxrKPHRV4XQnp6BsqGqiwQAX
	xbNwoASPwOEdXDM/2NLHbzvrVkPu16ph92rHUiCF2ATxKg9IzkutmNXpjOsK31BoW7CZcGeSQA9
	jE/5ER309qKhgg1l+gbTkIqGI5MCPjzyKBxuIrWi2vdag0MaUoAMtIaLAKe4g7duc5A5QUpvCie
	/bW+V6+0HJoG1JY=
X-Google-Smtp-Source: AGHT+IGT2kcafMP4OXwKhV0bMgJYo/omINH1kMlRcqKMIZMd+EGN9XbhJruAzQAK/Mj1Y21tcOaSFw==
X-Received: by 2002:a05:690c:6ac3:b0:6ee:4855:45de with SMTP id 00721157ae682-6f275c4ed77mr57024957b3.9.1734128603133;
        Fri, 13 Dec 2024 14:23:23 -0800 (PST)
Received: from localhost (fwdproxy-nha-011.fbsv.net. [2a03:2880:25ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f289031306sm1224767b3.56.2024.12.13.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:22 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 12/12] fuse: enable large folios
Date: Fri, 13 Dec 2024 14:18:18 -0800
Message-ID: <20241213221818.322371-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
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
index 6a7141e73606..e313ded276a9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3187,12 +3187,17 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
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


