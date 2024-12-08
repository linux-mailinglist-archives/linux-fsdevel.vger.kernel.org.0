Return-Path: <linux-fsdevel+bounces-36701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4839E8379
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 04:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2251F1884918
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 03:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800B62BAEB;
	Sun,  8 Dec 2024 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="p8MVGDLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F618E2A;
	Sun,  8 Dec 2024 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733630136; cv=none; b=ugGebyRcJwxvrlBwqXw9nupyXcwAn2WcQcz42wHJ/kH4kVXR/SIlq9aTuLoLsAYl4CadEM4drRxPdiKbNCZSdepwShMfsft3qVxeTrUvlX1OzOlSdmuOD820MEiuv6EefFDx661HV7exTgcNsgAkE/A/LZ0D8gAQvpzVa3VmtKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733630136; c=relaxed/simple;
	bh=xAmSa2wmvqGf1lGLgOH9ojlWkb6b6Iz9ykFs+KUJMDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzrufKhGA3flh+Jw5+sbnB+rwn8T7gUsLTNGMw4YLGaBnCvj5QTGMsN3TiixM3M7cRW2kN1Dkcy+PLNsF1byJYVcKDBHdCZ+6egftWXBvk9qi7BVmTPmRgW07WAhogCiyfBll4KcDTwDe3QKn0QaRijs4AEA8W8ICCDHxmrWinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b=p8MVGDLv; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 16B4B38A3DB5;
	Sun,  8 Dec 2024 03:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1733630116; bh=sMUgAdv1UYnveXfCZj+caAO4EoyTts+ar0T4j7DKx5g=;
	h=From:To:Cc:Subject:Date:From;
	b=p8MVGDLvZ2DjI2dDUTvpLS4Uu1qiFbOHcJ+q9SHRNTpB/b2x3A8NCF6oWzT2Ee0Au
	 tp0AuiXiHo4GsC1YEaH1mt28adK4CSgXKx7Phw9EGVqY5b4JcxEN7Nk1aTsms8VjMZ
	 9BpLjLTGlUuu+yLngU5G6BfbyHm51dMmtotkFXxti1+pWM6vg9Z72EpctKPYAjHoLs
	 iGR++67RnBmzlc3bE6ZPOdc3ck4V8aOw2lgAmXzuR9ZG0IRjgY8Uu/PS74n1IuBLuF
	 dNEoP5RF7QP9bGnTuUiGJuT+TL7XdKBokO3JyC85E5TfSS/WrlW8MVmsMmTw/C4eFe
	 eK9kGpAOzH5ZnYMSvNXe/C/k4fnhKtsMJl5MgTk/KY4+IDJ1HmU/8cFA4plbKF+wWt
	 y4CZI51euc3CwnTyqWT0kWQIYsM5B8LSvi2w/Ja/WRjayKkZ2QfAAqFkZKzSsAmlGf
	 MO4v3/ckgDgGDNW66vgQZvgJMShBBdwgCo9zy/H3pJkyHZMXRj9CbQoEsGmuXXAMwA
	 ULoRpBpwp/E6R+awAf3v2MQ8NKNIvwxV5KRnOx8dA2mBnD640Dv3LnD/7wdH3bDFaq
	 O1x40Yws4hWETfW9kC4OolO23Vmm4IObAP0HK2mVK7jWtGRZLCc3TuEmCpeOGGz9Mt
	 r7jmOpYqK4hzLxOog9JU1bXk=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w9f5h8Xf5DVg; Sun,  8 Dec 2024 03:55:11 +0000 (UTC)
Received: from xtexx.eu.org (unknown [120.230.227.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sun,  8 Dec 2024 03:55:11 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: Jonathan Corbet <corbet@lwn.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Bingwu Zhang <xtex@aosc.io>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	~xtex/staging@lists.sr.ht
Subject: [PATCH] Documentation: filesystems: fix two misspells
Date: Sun,  8 Dec 2024 11:54:47 +0800
Message-ID: <20241208035447.162465-2-xtex@envs.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=xtex@aosc.io; h=from:subject; bh=hjZ2QViAYHrS5s534bTXhzG7XzBTMciy149RrZNXASU=; b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDOmhEu0PF/41P/nawMPRcl1ngL2V0tK600ERb3rvOu+cy HRDgv91RykLgxgXg6yYIkuRYYM3q046v+iyclmYOaxMIEMYuDgFYCK22gz/FK/qbH4xQy0imcGz Xzay0uj4C8ZH91Q5HjFu36+jK7FIiOF/1joNDZPSBzMLInbZWl2Ouf5877otcltmP2h56Te99wU 7BwA=
X-Developer-Key: i=xtex@aosc.io; a=openpgp; fpr=7231804B052C670F15A6771DB918086ED8045B91
Content-Transfer-Encoding: 8bit

From: Bingwu Zhang <xtex@aosc.io>

This fixes two small misspells in the filesystems documentation.

Signed-off-by: Bingwu Zhang <xtex@aosc.io>
---
I found these typos when learning about OverlayFS recently.
---
 Documentation/filesystems/iomap/operations.rst | 2 +-
 Documentation/filesystems/overlayfs.rst        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index ef082e5a4e0c..2c7f5df9d8b0 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -104,7 +104,7 @@ iomap calls these functions:
 
     For the pagecache, races can happen if writeback doesn't take
     ``i_rwsem`` or ``invalidate_lock`` and updates mapping information.
-    Races can also happen if the filesytem allows concurrent writes.
+    Races can also happen if the filesystem allows concurrent writes.
     For such files, the mapping *must* be revalidated after the folio
     lock has been taken so that iomap can manage the folio correctly.
 
diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 4c8387e1c880..d2a277e3976e 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -156,7 +156,7 @@ A directory is made opaque by setting the xattr "trusted.overlay.opaque"
 to "y".  Where the upper filesystem contains an opaque directory, any
 directory in the lower filesystem with the same name is ignored.
 
-An opaque directory should not conntain any whiteouts, because they do not
+An opaque directory should not contain any whiteouts, because they do not
 serve any purpose.  A merge directory containing regular files with the xattr
 "trusted.overlay.whiteout", should be additionally marked by setting the xattr
 "trusted.overlay.opaque" to "x" on the merge directory itself.

base-commit: 7503345ac5f5e82fd9a36d6e6b447c016376403a
-- 
2.47.1


