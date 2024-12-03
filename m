Return-Path: <linux-fsdevel+bounces-36359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001B9E2357
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97F2286F17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A27200132;
	Tue,  3 Dec 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RuMwze1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C81FCF41
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239975; cv=none; b=NC4gVMEXzjyT91Hlc87ldgwFCe7BNgM4rb5bhsfcMOOCE0urj2O8E01MlgJ4YCtoJ7v3Gbe7XV1xCnMkNSh46J0PIJ2ftY+/KbBB5oBj+qytuLlAIcArX65n7SQCRmQYVpWSNLsr0OKAc/jkCQDA+AQlUYD/qxjNkouBYsiYifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239975; c=relaxed/simple;
	bh=SQI+ulnw+CRtDMqT4Q5a3RM/yVgI6AvOV11bMjB5isk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU48wsTepPVK00X+mFMTjARA33zBy6LsruyjEV7tBsYfLK3wlE7eCiWiR5plTx/gnpyuk4ur7y8z/1Lj8Z7DgR0oNlikkftFPO5sdS5Dk6WOC0OJQJr4Jw4XKzxxxTcPZOyFy7dE+IwMM0vipjoqMDEc5gSMnSbMaq8ZOIX3LU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RuMwze1b; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e786167712so2728080b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239973; x=1733844773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elv86DXnTmRzX7BzNNN54cJv91/ZhMhRandVuyh+78M=;
        b=RuMwze1bubbkloeBcqqhIIKdhgXrelfY/tzbUVkN72jNmqL1Pu1EcLkjbX/221s3Ec
         gC2rfqKx9VyjuhWcbokwU5l6TMtPQ7D1KDHv31FBP0RgjchCEVvWU4qS9CUYNHcaScAm
         iAl6bJwhqxTCuPouyfBG9Yw44cwPJhpJjgEZ282vfGnD2YOlL83R1ZlgCiU2f+AhwtcY
         ViAk7w1NRl8Q+6m/mMvDaeDm5OGC8TyhI78JxVnjwC/4fwBcfY/FJNdBKtQONWx5YzTb
         t6mS9rkO5MPiEZghVzftLG2OUnEoZ78TmE80CO/jUbE8N/RArWNWGqmfE85hBajtwZjY
         W0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239973; x=1733844773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elv86DXnTmRzX7BzNNN54cJv91/ZhMhRandVuyh+78M=;
        b=R3liiuUae835+GsfHOTMMDzkix8CFUphSOlAPiTzNmnoVwqhjMNEeMZ4zgtJbPujCL
         n64NuldaOgUyfYp4WpJSzHGsP+Fc+CuMHNJINSwmA3E4U4DaeEL5/2d1Iya03NFpxZwD
         KwUvXd87EORyIoSD4RAwsKiINkxMallfiFLWdHVx+GzqqgLjc1ojYNxQXDbfGp8m47xI
         zXbHCztqGjs2TbpfRRkukrQ6jSKX9e09bVnqUyImUQeeBwiH8OmhcHIazw0+d/wvkgry
         L1MC3TuwhmfQZTUv6Cxsu1l6el51i8dHty6JwzAB8Ntq4odY+hjxJer+RNR2nVIJJlJ0
         LEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4VZHlOWv1bR+iRfAa0up/acGAVFiwErr+WDLcpNQJ31tkW0PQ8hqhb5szZxBdfM11pCcL/IKWiUoJZM81@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPWrbX0tAKctHfe7bLqS0zR8r3PwORl0X3IikW2556zz1CulF
	CQ2olic0sXzcK5FxNvt0bcTaLwX4WYZCtMqJU4ccEkCd6zPxd6ZZjM0Ikg/V3WY=
X-Gm-Gg: ASbGncv6k0edUD7+CK1wj1WSYkO4mzRT2iJxDQjkGCvfrj0WmjT79ZO2Ub5UtCn5aXS
	a/YZLXtLSLUndfLiCHRVB1RfwPyZNwKIQqUeyVVVQnkoR+BBJwg6Toze7b1WX9lDt8FvFdw1aUB
	7oLsOZp57h0hPRZdxf+asw140EvHet06KLbjcgjxljtf0pt/2v95q91LAQiLvkXO8nJcHirAml8
	X4gjlhY7dQJMrg0q7Dkh4P3ILyVAheCBB6kEScKajDmAMOflHzViPo+Ukg=
X-Google-Smtp-Source: AGHT+IGEqY5mPPeclzVfJP1sqwpK2NEo6ZfmI2zg3SEWdjZlSMpJ+brY6rhQdeJiLlo5jFiEsUF9Rw==
X-Received: by 2002:a05:6808:1795:b0:3ea:4c23:daf5 with SMTP id 5614622812f47-3eae4ecb2camr3172373b6e.8.1733239972824;
        Tue, 03 Dec 2024 07:32:52 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/12] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Tue,  3 Dec 2024 08:31:41 -0700
Message-ID: <20241203153232.92224-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 898e992039e8..dd3042de8038 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2527,7 +2527,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2542,12 +2541,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


