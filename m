Return-Path: <linux-fsdevel+bounces-38375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A621A01183
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 02:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDBB3A4657
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C44174A;
	Sat,  4 Jan 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="e21MOVU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FczubmTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE218125D5
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735953645; cv=none; b=gAIBG+WvJBryOPvXzXx0y7kHm8Bequ1IXjdYkLiLJUqu+WykHTF47IRiZ/PAvz3jZHEek3a5hblCMwC1XQWwy88jPPjnIlWn3qXYQkQJQSyzEV/zc/R8tCGqki5j7pMJa7dxOBcZQ5f9PpXimOkqq29LGPinua0HRYDm1lYCMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735953645; c=relaxed/simple;
	bh=k1H97hhOeZn6z+zbwFZKoYV5rcCrE+zknB2SLrJMYfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dph/pRpXnSO3d3BZR+LQRfCDluzBfAG8vT9uHY7Y2NdMqMfY0afZq4cyRwO9ZLQdAbFFL94Dj7nUFT7Mf+z1hHvRMs49KkTsORSoAtcYOsw/t8IQ4X92Udlf9kNvaLABQ3/8LW0PWfw/LkWOjIyeOsgGfA3oizuYshyu5lCTwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io; spf=pass smtp.mailfrom=devkernel.io; dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b=e21MOVU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FczubmTm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D93931380232;
	Fri,  3 Jan 2025 20:20:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 03 Jan 2025 20:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1735953641; x=1736040041; bh=hC/m9P7PjtOpQenVYa1xG
	aGlnEienU5z/T5QpgQf3jM=; b=e21MOVU1eRNlsIxk3nWMB/Ddz6BPPVzWU2RYo
	aGUHJx3da2ipdgQDGTWnBnamF1p8lKbzS2G4T8pzVtw6Ta0yPawy2ykokvVFKYdf
	jvsQPcL1/hNbipwzIylauhf5lBHQv6AE8NKV7qUaSrPg4P/X2X2uqPxo5fNq7NOX
	wnPdq396r6WMqsY5sBkPThTL2gPe1VxmH0FdimT0KjtamG1Mp/ypvt0XW9j0D4Jt
	/ojKhJCYc0uWzwDH1HpIivTzYpRruDxsfI0OBYvfOe7Oxx+i87wxHdTrpKrke87Q
	2Y44BKqgLu4pHJM9FfmxVRgBFdXfWuLs5K4M5+2TqEc0NRwZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735953641; x=1736040041; bh=hC/m9P7PjtOpQenVYa1xGaGlnEienU5z/T5
	QpgQf3jM=; b=FczubmTm+fOLHVKbblEEnkDjkyoVHXPtvLq5IBbuxOe3j0+MU/9
	oi+bsC76kWmdfQk3RczjY0XUTPcS+kBxXInmbO1sg59E9ibwM0xQj0fRCqhKTa0r
	PAzzx+Z9jCZEAEylnTJmg0Kc/zThdIVEJs75JV/sxvOrSlDM3AaoL30r8b6sAy6B
	05R9cK7EkXjIvP4CFgjFBk5OQwJmqA2YpdLuwiAgJd6Y4onjvD/qvVwlV3gWAyHN
	vVz6B5/HrdJ9SfmhE03r4VZRsa/qxzkXGXb8hiNVETQ5dreD3kmcxDM0N8PkXXX+
	Xk902WhPbVQ3um5R1MWbPufXLzEly5Eymeg==
X-ME-Sender: <xms:6Yx4Z_Qw0MfiG9B5ymsfAfbvAzE5h9lWZ2LALvqA5RIeqhd0PnZovA>
    <xme:6Yx4ZwwshiA2TtDwhiUjcSjiTKL-V_mznG0Nb2hHD7rlZC5PytKCnS4uTgbD-zY7F
    _cUA0kCixmetn75zeU>
X-ME-Received: <xmr:6Yx4Z03hI1-Z0hKQ5K2dbD9E5X8lgDgfYEiMWbu1_foQ7fZhB85ZkoQgyt4d8AA9-THyZPGqE28GJxRJOC17pH7VbuapApHBgHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefhedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceo
    shhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevieegfeffhf
    ekudeuieelgfeljeekgedthfeiveeltedukeegfeeuvdelvdejueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihhopdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepiiiiqhhqtddutdefrdhhvgihsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:6Yx4Z_CHkXyteKf0cGKyTVaNd73HCTI86umkGAv8eQZKGn9XH35B8g>
    <xmx:6Yx4Z4hFnHckja2MwOfMsPtz7hMk_t_fidzHnlFDRtXmBYA8ToWYgw>
    <xmx:6Yx4ZzpnSN6_F6FKz8dwgSk2ok0qhDVzAJMn8V3duIw2P4kIiZczRg>
    <xmx:6Yx4Zzihp5n0VcwFpKfzoVxOspRH32C5zc78eeGoGSVVLQl_zW6SAg>
    <xmx:6Yx4ZzW7O7Ye-bsdjrccJvYQEcsG7kq4LKLPwwlSWetztKF_-VINVfvp>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 20:20:40 -0500 (EST)
From: Stefan Roesch <shr@devkernel.io>
To: willy@infradead.org,
	zzqq0103.hey@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: shr@devkernel.io
Subject: [PATCH v1] mm: fix div by zero in bdi_ratio_from_pages
Date: Fri,  3 Jan 2025 17:20:37 -0800
Message-ID: <20250104012037.159386-1-shr@devkernel.io>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During testing it has been detected, that it is possible to get div by
zero error in bdi_set_min_bytes. The error is caused by the function
bdi_ratio_from_pages(). bdi_ratio_from_pages() calls
global_dirty_limits. If the dirty threshold is 0, the div by zero is
raised. This can happen if the root user is setting:

echo 0 > /proc/sys/vm/dirty_ration.

The following is a test case:

echo 0 > /proc/sys/vm/dirty_ratio
cd /sys/class/bdi/<device>
echo 1 > strict_limit
echo 8192 > min_bytes

==> error is raised.

The problem is addressed by returning -EINVAL if dirty_ratio or
dirty_bytes is set to 0.

Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/linux-mm/87pll35yd0.fsf@devkernel.io/T/#t
Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/page-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d213ead95675..91aa7a5c0078 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -692,6 +692,8 @@ static unsigned long bdi_ratio_from_pages(unsigned long pages)
 	unsigned long ratio;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
+	if (!dirty_thresh)
+		return -EINVAL;
 	ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
 
 	return ratio;

base-commit: 0bc21e701a6ffacfdde7f04f87d664d82e8a13bf
-- 
2.47.1


