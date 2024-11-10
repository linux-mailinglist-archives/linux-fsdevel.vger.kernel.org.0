Return-Path: <linux-fsdevel+bounces-34148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892869C3327
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482A3281528
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37313AA53;
	Sun, 10 Nov 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ouq80bgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF360132132
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252561; cv=none; b=XCa44vFwtibJXMWVlle6rO625klce8kIgf9XLeMDo9xREK+kIUdQtg08c62wlS+F1vDu0jTZiICaV5Yjax8TDm0WvHyArOp3g2QCvhDGopCKHElkhtRCWsPLR7I5wlnEsXVyjDy5U/Ie9XG09+p8Wujodi4rVDQcV91jDstuzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252561; c=relaxed/simple;
	bh=klEANlDo0QcivFe1NIYDNiOFa1lRCa2wf9JjLv/2My8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cinqsgihByUTsl0r+slb4YjFXMuZZWRZY+TEL7dLvL5ImK8ZrwFwr0x4eVvDDMjw0xTl/y89/zyv/U1BRPX59yHuE+MlmlFXq7GuhFzpy6Z+SMASFx0MMRhdInfMwNPSazsWTHu/Ral790r+jYrf8Dis4LhVf4M40mWeJBX3S28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ouq80bgN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e91403950dso2822704a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252558; x=1731857358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=Ouq80bgN+n62Hh9S9w/3uvP7bBk73EYoisR8aw+jBueVfm+r4+aWtgK9tEB+wPWIJ0
         KTgwvudsL7/hDAnzDN948WPH195zh88m4Pv1TNRzon2pLz9Ea+JNHHKBC196Gu1FtZR1
         /F1rRfYGoAHkKOjjx9KaWXSu6SINBA4LeRoPcUNL+7VzvudwSQNrvBCjxb4QxNTgDpqU
         WgQyQCEfKf05RFRBvSjs9tDDP6fcXnbrWYTxSkuKKlkKL10oAjxG4TK1Bk5mzgYxM2w1
         0etMBm3oPlVdz9oNcJUtYzrxfMLHhmEHEE7pjqMr3w5mZ+5lJH0KAUKOtQ7VN5A3n+pZ
         6XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252558; x=1731857358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=ifQvzZR/edEhAuBZXWGwTvnXlX95cMi+uMQMq6eBMhPZBrbD7ZzlX4241R+K6ZfHOs
         ZFdnsETZ3qKfVuQliXtcm7UpFPdPOA7/DXW8De360+tNkoMdp0f8kkDcmuAN5l0YuF2J
         WW8MkTKCz2+j1YMXqz8O7a37Ey0vuARYEHeL4xm7susyF0ORw7xVBNuWCs5z4KlUCPuV
         zrJzeEzY7tH6cLoLzGZMa8sh9qP2GAll7e/e/ChnQXSAohynZB/7cQdB7eELhq8edjmN
         UeO0KeJH/nvyw7r7qa2gvhMJVLImcIsUB4cJOCrnp/FhAnRLv2dibfvltGN/Rt4d3uZs
         UN5g==
X-Forwarded-Encrypted: i=1; AJvYcCXfgQQIU0RpoNjpAeob03TZAz4d9wplq39gSDBalDdnKdQq4VE/GWj/+wCmUgfVza86FpG1+vZxKpL3dYsO@vger.kernel.org
X-Gm-Message-State: AOJu0Yydj4SRWIttJEPbEtiOHFartSEVOzKRG6/3sC8AXh8hv3VLlr/z
	7P9q2l7OZe9ZN4tF8uafkcPR6uQ4y+YxMRfCIxiK5AVUFOJEMDjYCem1XRO6CnU=
X-Google-Smtp-Source: AGHT+IEK+RdpBHKlpp5v8yHzxXuRsIFP9YbjrZgEGVdARDnq+2H6kYv6T3B7kfQSRNLPJFM3Uvu8sw==
X-Received: by 2002:a17:90b:35cf:b0:2e9:48d0:3b59 with SMTP id 98e67ed59e1d1-2e9b16eb007mr12818842a91.8.1731252557781;
        Sun, 10 Nov 2024 07:29:17 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/15] mm: add PG_uncached page flag
Date: Sun, 10 Nov 2024 08:27:55 -0700
Message-ID: <20241110152906.1747545-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a page flag that file IO can use to indicate that the IO being done
is uncached, as in it should not persist in the page cache after the IO
has been completed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cc839e4365c1..3c4003495929 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,6 +110,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_uncached,		/* uncached read/write IO */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -562,6 +563,10 @@ PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
+FOLIO_FLAG(uncached, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(uncached, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(uncached, FOLIO_HEAD_PAGE)
+
 #ifdef CONFIG_HIGHMEM
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..b60057284102 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -116,7 +116,8 @@
 	DEF_PAGEFLAG_NAME(head),					\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(uncached)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
-- 
2.45.2


