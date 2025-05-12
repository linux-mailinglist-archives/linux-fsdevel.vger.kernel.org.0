Return-Path: <linux-fsdevel+bounces-48737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A1FAB35A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348B21731B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641272882AB;
	Mon, 12 May 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="cMMdtW3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A52566DD;
	Mon, 12 May 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048305; cv=none; b=BZXe3y2G/jNWYlAwAaDbQm3r9F3LmVqr5VGZ1D8LBCHR30u2h0c4jUqk2Uf8vIk+HlIBI4aAPvdXI8yd4vg+enozyBd+sFXqKQc6LJjSL4bNABGyLp98og7LsNY3/90TSSEKyTAoWB7OoldSVeHAf3cMR3yr8AYNMNdd67kWFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048305; c=relaxed/simple;
	bh=s8IVsimdAxqn5dLm0HfceIPWVMmE+X8ujIEov8Zejuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ofjl+Q3EOAHhXonv0SrcPwfLVM1PmnlMXyEW4DJD75VWTWejloQCjbC63DezjElT8o9wGiKxOay3T+UmI8w5R+E2TFmYpoRahiMbw3JTAg8+GkmcCSHoFIl9QgOQS6I4IBOJ+CFQ2GBX81WvwFy4QRCNj1mS6bD3WQ/DlpO7pzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=cMMdtW3z; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-2.centrum.cz (localhost [127.0.0.1])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 51FCB2106B56;
	Mon, 12 May 2025 13:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1747048216; bh=qSZn8HV3F0m0d25zorvEHVYRz/lcZYAE64vPNFRU29Q=;
	h=From:To:Cc:Subject:Date:From;
	b=cMMdtW3zzhI197smm6tobPccWMd42eQAnirYeOCf67C48mNTWAcBARc1Qe4Of7/a1
	 LOUW/qHETLhgrt+dJvlTzZjPC+oV4q6Y8cQ8fN8k0Ob6+s7azi21mg3970XCY3NgDx
	 fpBkRYbFz0iQ5FTPB02sd7FePKOyThoAW+e/5PLk=
Received: from antispam37.centrum.cz (antispam37.cent [10.30.208.37])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id CD20620F55E1;
	Mon, 12 May 2025 13:10:15 +0200 (CEST)
X-CSE-ConnectionGUID: K9TSNbIUTFS9Yxr5BqUDYg==
X-CSE-MsgGUID: xKK+IyrzRNGyFFe9l4fQNQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2FwAwAA1iFo/0vj/y5aHQEBAQEJARIBBQUBQAmBSoMDM?=
 =?us-ascii?q?oFyhFWRcYt6hjOBIIxKDwEBAQEBAQEBAQlRBAEBPgGESItNJzgTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQYBAQEBAQEGBgECgR2FNVOCYgGEKQ8BRigNAiYCc?=
 =?us-ascii?q?YMCgiMBAQEBEAEDMbF7gTIaAmXccgJJBVVkgSmBGy6IUAGEfIYpgg2EfYQKg?=
 =?us-ascii?q?QaDDoJHIgSDQ4QkhCyFF4Jfgh2LeUiBBRwDWSwBVRMNCgsHBYFpAzUMCy4Vb?=
 =?us-ascii?q?jMdgg2FGYIRggSJCIRKK0+FIoEkggdAAwsYDUgRLDcUGwY9AW4Hlg6Ce1EgW?=
 =?us-ascii?q?jRblR+zS4QlhE6cfxozl1MfA5JkAYU8k0SkTIRpgX6BfzMiMIMiUhnXEHY8A?=
 =?us-ascii?q?gcBCgEBAwmCO41PNIFLAQE?=
IronPort-PHdr: A9a23:mYRZ1RH6hSzvPlJjkI6XRp1Gf7RLhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21hmRBc6As6sc2qL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgNJvDAImDAaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 RuooQnLqsUanYRuJ6gtxhfUvndFf/ldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6HQEXGoZixZFHQfL4gziUpj+riX1uOx92DKHPcLtVrA7RS6i7
 6ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWWROQNpeVy1ZAoO9c
 YQPCfYBPf1FpIX5vlcCsAeyCRWpCO7p1zRGhGL53bci3uohDw/LwhEuEdwNvnrTo9r6KKgcX
 PupzKTL1zjPc+lb1Sv/5YXObxsvoeuMXbV1ccfJ00cgCR/Fjk+NooPqJTyV0PoIs2uG5OdnT
 +2vkW0npBt0oje13MchkZPGhp4Ryl/e7iV12po6JNyhRUN9fNWrH4deuTuAOItqXsMtXXtou
 CAix7AapZK2eDYHxIknyhPRd/GKcoaF7gz9WeieLzl1mWxpdK+jihuw7EWt1+/xW8i13VtLr
 CdIk8TAu3AC2hHO68WKTOZ28ES52TuX2A3e6/tILV40mKfbMZIt3KA8m5gJvUnBHiL6gFv6g
 LKYe0k+5OSk9fjrbq/4qpKTK4N4kAXzP6Uol8eiG+o3KBIOUHKe+emk0b3j+lD2T6tSg/0tl
 6nZrIjaJcMGpq6lGwNV0pgs6xK4Dzq+39QYmGALLElAeBKbl4jlJkzCLOrkAvihhVSsjC1rx
 +3DPrH7HprML2DPkLbnfblj905R0AU+wNFF655KCrwMIOj/VlHvuNHaFBM0MQy5z/7iCNpn1
 4MeXWyPArWeMKPXqVKH/PgvI+qWa48Qojn9MeMo6OTyjX89g1AdZrOl0ocWaXygBPRpP12ZY
 WbwgtcGCWoFpBA+TO/wh12HSzFTfW2/ULgg5jE/Eo2mFp3PSZysgbCZxie0AoVWZnxaClCLC
 XrnbYqFVOwLaC2MOcJhkSILVaKnS4A/0RGirhL1y7l/IurO5iIYrY7j1MRy5+DLlRE96Tx0A
 t+Z02GWU2F4hH4HSCEu0KBlvUN90kuD0bR/g/FACdNT4OlJXRwkOp7A1OF6D97zWgTbctePV
 lmmXs2qASstQdIp398Of0F9Fs2mjhDC2SqqHrAUm6WWC5wz7q3RxGbxJ8ljxHbczqUhjEcpQ
 tFJNWK4gq5z7Q/TB5TGk0mBjaalabwc3DLR9GeE1WeOuEBYUAhtUaTKRHwfaFDWosnn6UPcU
 bCuDa8qMhVOycGcMKtGcN7pgktcRPflJtveZ3i9m2CqBRaH3r+Mdpble30B3CXBD0gJiwQT/
 XeANQgjCSatumHeAyJ0FVLpfUzs9fJzqG20TkAq1QGGdU5h2KSv+h4Tm/OcT+kf3rUeuCcus
 zl0Gk2y0MrMC9WcvwphYLlcYdQl7VpFhirlsFl5P5q9P+Vhi0QYfgBfoUzjzVN0B59GnMxsq
 2klnyRoLqfN6F5dbXum1JZTOfWDI3Px9RWmcYbfxlXXy5Cd6PFcu7wDt1z/sVTxRQIZ+HJ93
 owQiiPEjqg=
IronPort-Data: A9a23:bzgADKy6XW0NnjMlu5p6t+cPxyrEfRIJ4+MujC+fZmUNrF6WrkVSn
 WofXz+PPayJZ2f1f40gYY3k9EpUuZPRmoNgHFdo/lhgHilAwSbn6XV1DatS0we6dJCroJdPt
 p1GAjX4BJlpCCKa/1H1b+WJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYx6TSCK13L4
 I6aT/H3Ygf/hmYpazhMsspvlTs21BjMkGJF1rABTa8T1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+ZZk
 4wR6MPqGW/FCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 d9JFAsrZDG+u8yNkYOrULRGn/kPHca+aevzulk4pd3YJfkjBIvGX72TvJlT0TEsnN1LW/3MD
 yYbQWYxKk6dPlsVYAhRV89WcOSA3xETdxVRslGcoKMty2HPyAVqlrP/WDbQUoXSGJwLwB7J+
 goq+UzpITJZFc2F2wCj3WOCqOKemX/1YaQrQejQGvlCxQf7KnYoIBQMVlK+qOORg1K6UskZI
 F580iM+p68/3E+mVN/wW1u0oxasvhUcc95LD6s25Wmlwa3O6QuFLmwbSHhHZcBOnMs3QyE6k
 1OOlPv3CjF19r6YU3SQ8vGTtzzaESwUK3ISICEfQQYb7t3Lvo4+lFTMQ8xlHarzicf6cRn0w
 jaXvG09iq8VgMojyaq25xbEjiiqq5yPSRQ6jjg7RUr5sEUjOdPjPdb3rweGhRpdELukopC6l
 CBss6CjAComV8DT/MBRaI3hxI2U2ss=
IronPort-HdrOrdr: A9a23:YoIE+ao3rft7Gnp2WCqWpoMaV5o8eYIsimQD101hICG9JPb4qy
 nOpoV/6faQsl0ssR4b6LK90cW7MBDhHOdOjrX5ZI3PYOCEghrNEGg41+XfKlTbckWVygc378
 ddmsZFZeHNMQ==
X-Talos-CUID: 9a23:6cT3nWAGQOY1jDz6Ewo2yHUyEOEYTlPmnUbAORKSEFtFebLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AaV1OEg1FqcSa8p8Vc0BTODRAgzUj84eNS2Eci4c?=
 =?us-ascii?q?8neaVGwJ9ajPBgg2Re9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,282,1739833200"; 
   d="scan'208";a="105166094"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam37.centrum.cz with ESMTP; 12 May 2025 13:08:43 +0200
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id 4F66B100CD4EA;
	Mon, 12 May 2025 13:08:43 +0200 (CEST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
Subject: [PATCH RESEND] Documentation: fix typo in root= kernel parameter description
Date: Mon, 12 May 2025 13:08:27 +0200
Message-ID: <20250512110827.32530-1-arkamar@atlas.cz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes a typo in the root= parameter description, changing
"this a a" to "this is a".

Fixes: c0c1a7dcb6f5 ("init: move the nfs/cifs/ram special cases out of name_to_dev_t")
Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9fd26b95b34..eddb27ce3f0c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6250,7 +6250,7 @@
 			port and the regular usb controller gets disabled.
 
 	root=		[KNL] Root filesystem
-			Usually this a a block device specifier of some kind,
+			Usually this is a block device specifier of some kind,
 			see the early_lookup_bdev comment in
 			block/early-lookup.c for details.
 			Alternatively this can be "ram" for the legacy initial
-- 
2.48.1


