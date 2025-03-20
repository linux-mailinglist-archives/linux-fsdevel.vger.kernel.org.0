Return-Path: <linux-fsdevel+bounces-44496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7CA69D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4887AD69D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6021ADC9B;
	Thu, 20 Mar 2025 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="CtQP/VJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB728E37;
	Thu, 20 Mar 2025 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429681; cv=none; b=hivvdBV6Y+m4ht5ZMOHm6ZTH88dqV78P02Wz9p3Uvt73qwjy9uXSEW32CmoQCQBoYM4EnYkbnsgX5ceebgH8nz7lSIJZzGrmkOS6b8qhb3Z84iWujb91YsVKuu5dZjIT+2ikem6erN6tkahfqCkovy7EcNIzzspAW70N9Qyxk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429681; c=relaxed/simple;
	bh=OxH6dLAlNkMsERxQBauivbdSCvNMO1lcyeujHwxbROc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OecydzXw2YLzUOcwUfRkO93QhhiXo6At85ZnRzDkM43w2aMc/HJVGn2FQBw2xj0tu40TcJ/YoBIahs5grOlHFbxNRxw2wocFa1OsW3K5dliqF8sxxK3Tt8Esi7JSvFV6xUtRUv+27CJLhiFdI64XPytW7XEPuQzkC14NLzVZFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=CtQP/VJR; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZJ5g041Bxz9t3R;
	Thu, 20 Mar 2025 01:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742429676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ3U9+XxhprV8NMKwryw0i4AK/2CXKvIuj4flB2Li2A=;
	b=CtQP/VJR21DmIxDOdXfuk8WxvJSY6ZMZYFbl3QmSQfwGueSZmrtkWpktElRicuBq0PpKxa
	PEmljbETe7r8hf5rctQ8B7G0W6qIMm3MBDKvAHAUeHBp2uU4G2FIccdwnBYJv0z3v+rkte
	slF3AEq5aoejDkFqBZN6Ubhq0HvipzC1hflxn+WWys6oiM3bzwxtUhZKqCt7Dalf/uUERH
	6sdBorrabxjA2NGevlmEpcrDNPGjz5U7TH4JX4Dr87kt6QZfXIzTXbc48plY7gY57VuEZ5
	jPbQUKwnLse/ZlrLueg8B9Yi72AU4w9EHyAEjUwU7B0uptyJmejC6MoMsOly4g==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Wed, 19 Mar 2025 20:13:57 -0400
Subject: [PATCH RFC v2 8/8] MAINTAINERS: apfs: add entry and relevant
 information
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-apfs-v2-8-475de2e25782@ethancedwards.com>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
To: brauner@kernel.org, tytso@mit.edu, jack@suse.cz, 
 viro@zeniv.linux.org.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=OxH6dLAlNkMsERxQBauivbdSCvNMO1lcyeujHwxbROc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOK09QYmhkNWRwYXpRTFhhUzBIcCtqOCttRWg0NkJuCjVuVHNidGtjWmZhdFNtdFZL
 L1ozbExJd2lIRXh5SW9wc3Z6UFVVNTdxRGxEWWVkZmx5YVlPYXhNSUVNWXVEZ0YKWUNJOXRvd01
 XMTZLWkNyejZrWlpYamdxdnB1cFd1N1pVMEgrSGNKRmFzc0tQUjgyWjdldFpHU1k5MFBjdTNyWA
 ptdmY1cCthYzFENFd2YjJibmRWeFV2ekZUWUdKMzlTYXRoemtCQUMrU0VxKwo9N1NEMgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Add the APFS driver to staging/ and add myself as the maintainer.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12852355bd66b2ca1841432b3e0d8c5856c62b9a..b4040e647e3ec6ae6b4723823fedff18c7a94544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -683,6 +683,12 @@ F:	Documentation/filesystems/afs.rst
 F:	fs/afs/
 F:	include/trace/events/afs.h
 
+APFS FILESYSTEM
+M:	Ethan Carter Edwards <ethan@ethancedwards.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/apfs
+
 AGPGART DRIVER
 M:	David Airlie <airlied@redhat.com>
 L:	dri-devel@lists.freedesktop.org

-- 
2.48.1


