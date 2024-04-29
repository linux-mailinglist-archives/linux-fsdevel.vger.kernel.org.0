Return-Path: <linux-fsdevel+bounces-18167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B88B619B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0185B280F2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412313BC0C;
	Mon, 29 Apr 2024 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4b46PBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5813AA51;
	Mon, 29 Apr 2024 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417617; cv=none; b=Ln/fZ9iiSNf4qFPP1IqBNbe+Nj9VKoV2st8zGa4hv0xLdEjfytIRjmO4O2Z4pTB7Au0YJGF0hCI3/d3WAbjuCCl0ISupHArdYR/VAB/JQWgEoe1KByxTaKN86O0rxKn1f7wcLcxal+39Pq6D0HWM0BiP/uPSrqpy+Ko53+ode2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417617; c=relaxed/simple;
	bh=YRby+TlApMR2BfFDBOTWsaAzBHBVctrqTpy56VI6Quo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4idNbygMGet3nkg0W8F0WIGCriKnHWVxWM3UfEB9PiscGLwIu1YzkdoOQ+Xvr8XVq1SedtcrpxltfU3bNgkqJo3COTIOC8SRT8GhiCIaeSf8BRx6UAMu4ab30qLnhCWGsAT7M2jayJRg87Dum08mRoeRdamLdq/e9mO73lw6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4b46PBx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3ca546d40so41080465ad.3;
        Mon, 29 Apr 2024 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417616; x=1715022416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfRM+qHBl7JEmbJr1xydN14sHfEFiHH0LtWIzSVr96Y=;
        b=m4b46PBxZIX3ey/S43hGI5HwXVFKEzP7J+VSxWxeajq3sB8vaBotkrA8yl9sEmGc+L
         dEdOy3e0NYDka9Vpi7dd+SWhYY2uvDzdsjnG0jD8LXMc4NYMnP7Yi7bOsHoSTQ6V2/nw
         76yfGl4lDpsYAye9T0qepd73z3yMCazp29I+6o1Ekfs0plPgxrIX0W42dIroF7AJu4Po
         ucU/7d531oIam8qUdT97QleLIHnFIpqdtLTLNOL6p5y8fJI5T5WZjG3j0wP8R0Go3ZX1
         f/BwmTHq6IWzszZG2xg3GXHkbAo0Eo7jSeVO+6l+B2q+yxTcCC4nrFC/dXoBiT8Ec/00
         bcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417616; x=1715022416;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfRM+qHBl7JEmbJr1xydN14sHfEFiHH0LtWIzSVr96Y=;
        b=TPGx7wtAUDL+BpvfZk2eyofWQqBKEXpbTLT7JlJa/XVuOeWdC0xS3F5Wk6D6wOYyCI
         dqkyyhHaeRuA9/m9jpXQJ5kHq+l4al84uXDMi92HspCPxRgPuwcdDyDv8IuGlojhZ6Iq
         0EgLa/vr0f+nMlTaq3AXt0hpaHZQ16/VeEaFq3xqSpk646154jbrlaZpl3Fcu9NLegIx
         ncvhHJrUJG90RB7XX0K/l0NSmlFi4Dy9h8SFFpc9ubFl/jx4edGv3SjoebBfahB1E78R
         aTwMM+4rl8Cf2jLwqWsx7IsTrEUoSrSSe6+9MBWPFHlm61J2NAwI3f4PBFddpBKlf9Le
         vf9g==
X-Forwarded-Encrypted: i=1; AJvYcCUKtoxNmnoO9OWNB6U2BeOmXmHeqkAVFMrZppFg4sWvlqAf05suwJIykckOkH8tRQpNcmTkgC/KRMZyolVC8p29rzRHw/tW2zDx/LCcbfQGrmNoNGW9JZaZTC6RF8FukKc1yvB2w6HaZkNKVdP1cVJkgDagwnTZv49gm8UYW7251apOC2iN7hiA
X-Gm-Message-State: AOJu0YwTT5gj3JHw7TZnnt15xeaydJTWzpWF2mdXGByc3jdX7VvcAitw
	Vy1MLGKF6TlG4h6+A0iJjp+iRR5OKcgV5buFXJIsK45HTMoYhZMu
X-Google-Smtp-Source: AGHT+IG6o6kI/bGN72Zio9V9EuR0QrMbdLin8hBig6iTqFcceqUVveJSWOkf2WaT/c9J9vt33sFWsA==
X-Received: by 2002:a17:902:f681:b0:1e9:4f9:8478 with SMTP id l1-20020a170902f68100b001e904f98478mr524594plg.42.1714417615896;
        Mon, 29 Apr 2024 12:06:55 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.06.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:06:55 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH v3 02/12] nilfs2: drop usage of page_index
Date: Tue, 30 Apr 2024 03:04:50 +0800
Message-ID: <20240429190500.30979-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_index is only for mixed usage of page cache and swap cache, for
pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here (being part of buffer head),
so just drop it, also convert it to use folio.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
---
 fs/nilfs2/bmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 383f0afa2cea..f4e5df0cd720 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -453,9 +453,8 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
 	struct buffer_head *pbh;
 	__u64 key;
 
-	key = page_index(bh->b_page) << (PAGE_SHIFT -
-					 bmap->b_inode->i_blkbits);
-	for (pbh = page_buffers(bh->b_page); pbh != bh; pbh = pbh->b_this_page)
+	key = bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);
+	for (pbh = folio_buffers(bh->b_folio); pbh != bh; pbh = pbh->b_this_page)
 		key++;
 
 	return key;
-- 
2.44.0


