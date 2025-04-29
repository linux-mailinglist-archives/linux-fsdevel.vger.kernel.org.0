Return-Path: <linux-fsdevel+bounces-47592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B6AA0AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2C8844863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4E2D1901;
	Tue, 29 Apr 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l46bT0bH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69D2C1E3B;
	Tue, 29 Apr 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927424; cv=none; b=t+V3oaZs5EwKOFPwQNuXNzDiJJRW0f93wQYmtARCts7zpwjNjOH3ld7i0YwwBM/HgGJga2joaCyiFOlYVgWNrhynXlfBiximlLLjarph9zN32M5PUzJm6dFTjPKxqwwAPNcewzQTmK0/7lYHagsDHA56HX62Xs8Yj4OGLyu7cfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927424; c=relaxed/simple;
	bh=uKkWq78XfYV8C1wGjeLxUClR6JZktKdqmRzCLRPiniM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs2IN8JPiCk974YjXMFS4TwueRCdqoQo6jMIx7XdQgdaH/6BBObob1VD/GHQSRTD8rJB5qseif1tmyW7En6OSq2nA1fszb39lAUX46Jom+eXAo485a9lWIj+Vl7afVCS0TKE/h7req4AOijvETVHBr4BI0f3AHX8TWkPJSuaE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l46bT0bH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8347668b3a.2;
        Tue, 29 Apr 2025 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745927422; x=1746532222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWrdBEdzmL3R/kfX7rqlGT9fsre+XXLU7YQDNncr/vk=;
        b=l46bT0bHkv0JBZn2e9RwrDbyrhAoUsCrNSsEcoc16UvDS3dwyc1EXNUEq8CeuM745H
         QrSeW6X9T7p2om6YqjTHIZjNAWB5aSU2XOeFF03AhdW5IpU+uvH8N0xfsNW1cxbh4O0A
         upAIZaz3X24IJaktUKqF4t0zmL2esmx5WNwyu0JuRhDD672Ojzqa29TDHuiJVUmGRwR9
         aef7U7FuNZ0eZwawJc/ZrMUBJ8T+ZAPy3qsdaASe0jBsNpPa519SOd1Cq5bXMo1GWaXa
         4/8lNHQWUrcbyUuU4RicV2+6G81wGRiW3zStBzKBMH0YGqK3pgZmfmcQD8G0TjexYMUL
         J1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745927422; x=1746532222;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWrdBEdzmL3R/kfX7rqlGT9fsre+XXLU7YQDNncr/vk=;
        b=WBmFvaRETe58pkQMjmvJe8KQHAMbMjPM17H1uLZVmpCU0JWRpNhQZ5YGR4IU/a3tXw
         B5by+YTDo1Rko6g+JB0x5xe2Q2Vg4wgTucnq+h3lCKDYLrkVeOeXB3IZhKP2WdDJsT6j
         NPWRWeHFGzkv7fPXFsDy3sYQ+6nPfdsneB63GgBC1W5XDC0KX7xGoz6k2uP3AjAiIXq/
         cGE9zs0r+beHoUFU9Cv+Olc2/W/RutfK9vVhD3CeF0VF+Wn/bzg2/fs4gZMwfGD7ag9e
         gDq7a1WHyqASpA5tW+iU97F4Yo7Bt1A445wXMwU7aP+05K0sq8PCspsVuiL6n7tuOZmh
         ulJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZayXrQhnx1EHbgHzCRj/EFQ0brZTAD+n13BngvBz+Gl8Uziz73n+U2aWo/V3F9S5yIuVDwBiCgTAN1Ypg@vger.kernel.org, AJvYcCVoRPvhqh1379tL49Hbd5+Sbe0d9pzMIodBs8E0NZK9rflDTwjp70CaCOc0MAw8Fb+oNRDLsymuPlQusmo0@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdJrQSlaUuVTR5T9zld5hyCjVyB7Qahk4dAGLyql463LZW0km
	V3IH+SrQ8Cw/hZUMKsrsm1mGAU5XuSLdpXMEUjbIFGqa3q6xcuLy
X-Gm-Gg: ASbGncsEEr4dvX60a+sDKKF5rD8yoEhcZjRgxdgkDb5gyE/aLG6rBbOPfHH8Not5bRB
	VuLkGZhfq82VZJZaEh+337BImxMuN80cPdGKdn1/CAktzeWcydEeK7S8zF7SEwX+d6YkE9LEQyU
	38utsZxunj6ioz8ijVuFBX+c4H1ngk35bgvMOxHsCoS6dAu4m4gqjKf/d1yLGy0XBnyBEORVjh3
	ktog271kacnnrCTRpaBSCAbmfQsIVx+17bAs9RMYOf+y4+rgK7khqHmzHDP3+y4R9U8f1CMiz73
	Q/Yd+0oGsEcwirjMB3BNhv4E5NY4GPUNuN/SxPMQD2CdEBcILZ9Xm+WkiewuWuQaKaVO42g=
X-Google-Smtp-Source: AGHT+IE/utjdT7UzJxrdlrhtOtlOMqX4ScwR+z3Gkz6IueKwrIHT/ooBVXODi9qD8WVpFTeDHyYaSA==
X-Received: by 2002:a05:6a00:14c6:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-73ff73eed7fmr16992178b3a.21.1745927422335;
        Tue, 29 Apr 2025 04:50:22 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca62csm9661644b3a.167.2025.04.29.04.50.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Apr 2025 04:50:21 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/6] fuse: drop usage of folio_index
Date: Tue, 29 Apr 2025 19:49:44 +0800
Message-ID: <20250429114949.41124-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429114949.41124-1-ryncsn@gmail.com>
References: <20250429114949.41124-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_index is only needed for mixed usage of page cache and swap
cache, for pure page cache usage, the caller can just use
folio->index instead.

It can't be a swap cache folio here.  Swap mapping may only call into fs
through `swap_rw` but fuse does not use that method for SWAP.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f71..6f19a4daa559 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -487,7 +487,7 @@ static inline bool fuse_folio_is_writeback(struct inode *inode,
 					   struct folio *folio)
 {
 	pgoff_t last = folio_next_index(folio) - 1;
-	return fuse_range_is_writeback(inode, folio_index(folio), last);
+	return fuse_range_is_writeback(inode, folio->index, last);
 }
 
 static void fuse_wait_on_folio_writeback(struct inode *inode,
@@ -2349,7 +2349,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio->index)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-- 
2.49.0


