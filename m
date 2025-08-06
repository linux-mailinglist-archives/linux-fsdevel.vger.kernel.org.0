Return-Path: <linux-fsdevel+bounces-56800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC7B1BDC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 02:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D586E1842AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7462D171C9;
	Wed,  6 Aug 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="THl0uyUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xc2PVzhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EBBA3F;
	Wed,  6 Aug 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439059; cv=none; b=prTf3oX1iCojbhnDnDkGrYMoUF841V7sV2kunIb5yVhxhJwFrlSWnYBkAqgFZRigafNhVAgyfPTvcTDC/5jIQMNL3BZd75ZPG7/9e0ucbWZtWF7AOP40G6MMb3YWAOyBWMlSbgV4oVPoodslA7Uj3bZSefm3ctCr6ob3eLABAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439059; c=relaxed/simple;
	bh=I6P/03EdZUqLyTSNaJL54cFHm0SXdiYpucASsJ/Niow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hONXryW3uonnP3r8UhIBpe4NvDtMsL2WYVApHBDUFIdLczHpJLmwQtmIvOuUz2emXuaFGCG46UCgaMvbBRdvfiCYhUYa+S2ZIkBNouugBQ4TA+ZBu4rbbeblb7oGA6Zza5BepUUo2xMPYe2hVYMWqSfTtrU55paVzG4uE6/xkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=THl0uyUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xc2PVzhP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DB23E1D001BF;
	Tue,  5 Aug 2025 20:10:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 20:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754439056; x=
	1754525456; bh=NZ7TZBffuEffDJUzZyM4ZUtL9XNWT9f5kOkVlSi+KCM=; b=T
	Hl0uyUDCDWHd33pWZ1uMbQXhsdRRcJJRrAH+g7B4PkT9ObG76RBgGWKHwNCsHFk1
	mkY58O/hpwpjdnzQnAp1ISDsIamu04TPsI9iQ/s2mGs7PnapMq2qvJDouu01Wcft
	33RIVS0+vPZGM3hcsxM6gFtt/vo3hc1c6swjB/sXE/lBUB8xdBAAlGbuq4aJDCqi
	OuFgJkTrCKywpNePty+6N0qUWfQFkVE9uuFJdjaqLbDP83rukrndHvWBuBBeQ+e8
	af16q4YCxT1W0B23byonYVTvJDuXqrPoUwjjSSKFANlID2/t0DPyb646KFA+k+qy
	75eUdIGBE7A6V1gUQdWVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754439056; x=1754525456; bh=N
	Z7TZBffuEffDJUzZyM4ZUtL9XNWT9f5kOkVlSi+KCM=; b=Xc2PVzhPIXXkfThYe
	SbPQ9DRZprBnldpzeRw+pnm2rA4LOa+OQyPbEO9M59wf5c51TTJAmWFqQB413zEW
	fvMsdfGZljbcLkLOu24PWcNZ60uZyUfSMTpVeKLl40RaV1BP1E9ZKTvTqBtxXd01
	Fc2j3/luXH0KFE88eAOF20zEntBSeU4cK5btBhR1xYYvbmWYSOH1lTIeIuyUrP0/
	ICIpwXgZhEhHRl3Brevhp8dpuqhCzsUt9N7oNsORTYD5o+TPf7jY+WsXUoW9CFij
	yORn+tMPcbfRwkdVqddCtjwXlp7OiSKgXCnK5hwrPU1AathgdYmOvttQzY0E59P4
	8IEwQ==
X-ME-Sender: <xms:kJ2SaJA_7H5wLX-S1XGsDNrBtZYsGidLKn4anpyHGWySGEU1lTa62Q>
    <xme:kJ2SaLVEJwxtfaHZJP8ZxUURyOkdqDeFjAZumzSf9J6KdAPuihYsT8LC6fAD-ihe_
    CFax02rxCxQIQvK0UA>
X-ME-Received: <xmr:kJ2SaNo-nBOM5ZXi4JixsW7h3bVcEKlzh-ILppwnKti_lDSaAvDw_zDFzURFeOV26KoUi2vHbB2fdPc7mHJZ6Ap7RWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepgedute
    ffveeileetueejheevveeugfdttddvgfeijefhjeetjeduffehkeelkeehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhi
    nhhugidruggvvhdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtohepfihquhesshhushgvrdgtohhm
X-ME-Proxy: <xmx:kJ2SaHT60CohRpcWORKyL9Dtxv3cnBo_InPO_khRHvlCf61oQh05SQ>
    <xmx:kJ2SaH3WVwUkzRf2KHBb-F9W76aG6iU281gy_g5xmdT-8KYemzxaGg>
    <xmx:kJ2SaDBf4-WuHmUXbw2JQsxxkOOtSGkNt0x9kYQQn1HFA8Iba6Uc1A>
    <xmx:kJ2SaDjFff54Aa4ybzJxDv0RQhEnRw7cABsAU0RCdmAmGrz7aa-i3Q>
    <xmx:kJ2SaKT4L7eQKJhUd-ZuA2qMn1M36aScMBI3hIDGttEaYvzCh_CptYIm>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 20:10:55 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	hch@infradead.org,
	wqu@suse.com
Subject: [PATCH 2/3] btrfs: use filemap_add_folio_nocharge() for extent_buffers
Date: Tue,  5 Aug 2025 17:11:48 -0700
Message-ID: <176a4973304b6c04c9a85f5f08a03d1e90e30d82.1754438418.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754438418.git.boris@bur.io>
References: <cover.1754438418.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't block on cgroup reclaim or subject shared extent_buffers to cgroup
reclaim.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9ccbe5a203a..1f25447f1e39 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3258,8 +3258,8 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 retry:
 	existing_folio = NULL;
-	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
-				GFP_NOFS | __GFP_NOFAIL);
+	ret = filemap_add_folio_nocharge(mapping, eb->folios[i], index + i,
+					 GFP_NOFS | __GFP_NOFAIL);
 	if (!ret)
 		goto finish;
 
-- 
2.50.1


