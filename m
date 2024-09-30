Return-Path: <linux-fsdevel+bounces-30374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11098A5BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC821C225ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADDC190079;
	Mon, 30 Sep 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dRIZRh0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1D190471
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703954; cv=none; b=JoaTZHQY1VESyEoMAfqRkXQbz0YjOdO9h1qabfAe/ZsxfrHmEljCSrvDPYuIuXm9c/VSBx+YZSVmi9zTVXSC005cqOevOGIV0It5uizkZOnM+bw11/bun6o08y4MUeCTxV/q+FVIRqURIB7HPcQIqWVyWVGyuTVB1AWY/U0Twa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703954; c=relaxed/simple;
	bh=ms4yYgL0E9iyFXWAfAhYgK4KaUE8et45BfesbrUOark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rcs7oV/eXWCxf2i51+Y8kZp2VQPXl2BcUzVZ07IafGfXrhv7hAYtPB6NLCnpr4mIJ+TAL4WmAkDTItzrLWcGtjP7m2XYqv8h7fSK1sYsr5fAH/P1nfM3G39KRv7qGGdWPuDaMPCIIyNcRAMBWdoP9+zCHH7xM81PW6zL4y+HC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dRIZRh0n; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7acdd65fbceso365790785a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703952; x=1728308752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14HFQdB4kShb1FL6dQLgu7eLq4rRewlARylk3CgabXw=;
        b=dRIZRh0nAzUoeXgcbR6fIclmMEb4tL0oQCKuIX80QpjxRJdoq6iaqNM4YS2/wL4dO9
         AoODZkwhZadqbvVunoxbPAglFHIuZQHI7F6UxkcJGLOurlyIAaqgSNPlH8TPbSX2BNWE
         U8pRi+bvlbsxRWCqwhjFEV+U+AOL8N5Xbv7zy9Q4gVdPZZFgyIZg95D3F8i0m5KXK5Ce
         zeRacPq3cVETEuN0Cq8i8KkUa83B1/SXLfbT+cT8agc61O23D0XAoahp37f8ogme+5XZ
         saOp1guvMYku6mps7Luv2pDUhrtxjySZJSUnNGGF4dqQG17znsw7+K0WRhq0yzZckiw8
         js8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703952; x=1728308752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14HFQdB4kShb1FL6dQLgu7eLq4rRewlARylk3CgabXw=;
        b=ImPANaiAVEb1nbECL4k888PFtuXjmV7S11bYFIm1jrykl1lK/bskV8zuxK9IdaNJPB
         WHrLRtS+liU03JYla3nzC0bMepJKWmQw1d8HVEV+G06nhRsmGpRFP0I00bnaYkMX7xuJ
         xyF+PWBxGkFqE3wYEHYpFqewiddQ2IG/qC63PMdGrKAsGXsiMB6L7kLBg1GmLQhp6N3z
         9zA3A+2hjtBFLNlC7Qs6knbz2FgQ6hKeYZXtBO9amH3Wr0BTJcLlVoA+S88V6DGYdWkY
         Ooevdjpxhb6goMYga5IoRZXg4W9r/y3EyK/9OXek8W+p0g8J1ebwM9FU7OpcJMLUgULx
         3x8w==
X-Gm-Message-State: AOJu0YxTavEFvM65LSQGExEhufjNzd8py0oraHvT5RfV5GSBstRR48/l
	nsYdXeT8hFDxvQIpkX/410Rv+vIGo4BG8upWSYVLOnH3b6T6TdoDHdMyMscwXpEa03vPZa8gV/y
	Q
X-Google-Smtp-Source: AGHT+IGRB27P/2NzIFaZtLeRDJvEJRcMAJBKbSKZCFg+yMOJGXyawp+l6PRTWUJ+7Lvv64u3/7MrWQ==
X-Received: by 2002:a05:620a:471f:b0:7ac:d673:2057 with SMTP id af79cd13be357-7ae3782577cmr2523901085a.13.1727703951581;
        Mon, 30 Sep 2024 06:45:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782cd47sm412422085a.79.2024.09.30.06.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v4 09/10] fuse: convert fuse_retrieve to use folios
Date: Mon, 30 Sep 2024 09:45:17 -0400
Message-ID: <af41165be9e7fa3b0db2dd6166320bc1623a2066.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're just looking for pages in a mapping, use a folio and the folio
lookup function directly instead of using the page helper.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1f64ae6d7a69..a332cb799967 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1756,15 +1756,15 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	index = outarg->offset >> PAGE_SHIFT;
 
 	while (num && ap->num_pages < num_pages) {
-		struct page *page;
+		struct folio *folio;
 		unsigned int this_num;
 
-		page = find_get_page(mapping, index);
-		if (!page)
+		folio = filemap_get_folio(mapping, index);
+		if (IS_ERR(folio))
 			break;
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		ap->pages[ap->num_pages] = page;
+		ap->pages[ap->num_pages] = &folio->page;
 		ap->descs[ap->num_pages].offset = offset;
 		ap->descs[ap->num_pages].length = this_num;
 		ap->num_pages++;
-- 
2.43.0


