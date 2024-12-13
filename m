Return-Path: <linux-fsdevel+bounces-37384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DE9F190C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CF016087B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF551EF099;
	Fri, 13 Dec 2024 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1K5DIxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436231ADFF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128594; cv=none; b=PL1OqqTAyC+d+Xi2u8rAPoLPKzR3rvRsN4E80L2NI0+zCft4G+bI4h6m+jUj3dRlOWnCx182KMFlh81QmEITQXcfvwnJcNW3VwtUc8b8MpZkW5x63rpw7A/S2DBJ3qjUK7St15zpucJFcPBLjnCIxsOQZ8TCdOOKzgegx/KGYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128594; c=relaxed/simple;
	bh=y4IUyWw5ByiaCtOzYA7dWGyCd0TAauGsNCkei9fETmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pycW3kSiJRYP+K7CC7wQWu77O3fdHVzPXX5sGOeufw5YdL+uspwi/dkhfYbrTYmHRc5LkbYjRrS2+kWqKGbGCPjkOXM9n1KekiyTr80xA0+3keSQeUL1kbD0lXrSkhFQ2Pe5X4BGrsFtwLv859/y+FGzd1rPra8NYDRbUI3QP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1K5DIxM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f00da6232bso21558037b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128592; x=1734733392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVG2h1mzHc6NlXH+G68nOAQKK5O5FHaevI4RaKIS6rk=;
        b=A1K5DIxMPvlAAkUTxu59TS7opa2vb8LMkzubxF7UvzUdZO61DXRfcKJ1w0HS/W0NXJ
         WB8JPrCmwJyvaM+TmNey7gHWoXyJCqjzoVrRoAUozZbTQbggp0Ysn6/7ySA98+hghMlE
         jtgfgSFJTax4SkZ36o41wQmMreZdx6c7FwWgodI//DkoRNBNHVflJ6vpiTurHPrb88J/
         mMpLGCGDSvwNMdDEXWwrtQFmsrSwcQ+Gye1x/rUR8PyEUD38WI+KXieb1uncWXU//Ghi
         Iljln4oHYjbNnpfzQ4s7J+ICo03yQNH/5zgrHm11oZ9VorJ/fTh62nc/4sO6ciix80E0
         FHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128592; x=1734733392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVG2h1mzHc6NlXH+G68nOAQKK5O5FHaevI4RaKIS6rk=;
        b=uALO6zjGEOnZXHtB1wQx+vLzN7q3f9dencOlLiWNmRyUW3kkiRqJVv1BQKLI88yhiu
         Q/q/XcmAT+r5BV3xYJ7SDHMiMhPwXaGrCKoLWPYUbfwjMUEo97L1wsXDaSRvbYTVl6oj
         qyNM6CMGUGzugrnuhhL2Qg6+3UWQVhySZhuWwLGW1eKo7BBaVyosMQNe7B/luoefCb6V
         G02iTzqQ+eqU+EMz4PT8NTmZFZB2xEmOjYYXcLRLwH9Uj1EmirkayPat4xt3oDiTTUC5
         vm2u005deaAhIa3zBPvHV6ALPfkBAmXX/JTmW2ohSz6Fs0QgubO+ZlkAkWHbBDNrZNkx
         ztoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6n/Ah1sHQZnLL6NEuCXD7uE/l6O2ioN2ftuCOj/ZhFNYVXZu/K6Yc+ZJ8Rcwa4MPMBQdDdlArkDjZEJKC@vger.kernel.org
X-Gm-Message-State: AOJu0YyehMS8yiS52UmN200vx26YXMVSgRXffjzZ2w6AJLcJqnRm1TU6
	zEpSFh4Gk+uxbfy4LQG0HJLSMRLavqFUWOy63ib1L5derKhnE2iw
X-Gm-Gg: ASbGncuut05SalTTBHWdUgPeOoEOb0nbm36bLF7HUn5Ka/LZHNcxGKtXuZJMprx3Ujw
	cVXffQp2iQiL5uGyKuvA/5AvjU8AvkpaGt3CRUfdMRy4M3wrk5u9rzGy74aNlTmQg2rDA+5aiV9
	EQP3moVynUT602RY/ZxRWYXjPZ6fV4ufIHJpk1hd/kGjLGs5T7HOIR7gkQgxXhxz/b1lza1A5O6
	IQ5V3xGZcquUsZiGIXNEp4wJlCxNt+TzJsLUYhb1dL0zihGJiELi9sTd7DeQpES1X84Igwv6t5f
	EPAARB0ML2CZcEg=
X-Google-Smtp-Source: AGHT+IGe+dFlduHLiN0xEB5RIPddDCQG8ACBYsC6x68iqcnsx1OH0dPTC6oLpnFrg4Ip4zR0S+ID2g==
X-Received: by 2002:a05:690c:f95:b0:6ef:838b:5cb4 with SMTP id 00721157ae682-6f279b90056mr40089107b3.29.1734128592123;
        Fri, 13 Dec 2024 14:23:12 -0800 (PST)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288ec62d4sm1287117b3.0.2024.12.13.14.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:11 -0800 (PST)
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
Subject: [PATCH v3 05/12] fuse: support large folios for folio reads
Date: Fri, 13 Dec 2024 14:18:11 -0800
Message-ID: <20241213221818.322371-6-joannelkoong@gmail.com>
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

Add support for folios larger than one page size for folio reads into
the page cache.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 84e39426862a..2f704f522b00 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -797,7 +797,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-- 
2.43.5


