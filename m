Return-Path: <linux-fsdevel+bounces-51694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF2ADA474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 00:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9679516D445
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 22:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088E281369;
	Sun, 15 Jun 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="JMkbaykr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B98280332
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750028038; cv=none; b=AzhQIygkhTvjo0Z4lfru8RN/a7CM2H6tzx5W9gA6SkTNvaPf864HI90SC3+OcWIG7vPqASdOjmvrJZEQN0YBYpHj+G9dASDXuNGpo0JByhq6xF7aBVDqG3IPNnkboKRIUXbBZI1ZIJnyn2chAlKO94b7+l77903EaSiG4r82LeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750028038; c=relaxed/simple;
	bh=fJric2xuz/D7KmQiBryCjvqCKImRal40258ZoI4kmdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EM/rUClQuOHSqym5vSIswlFUBsjKLkG5KsStKu+JBwHGzKdTclrCAAaXA5NuOMgZ/M2C4LwiH1p9p9WcgtIYsFhwhb4xJkBXgmRQATwfdYkusBbJkqynQ492D17pziGbcIy/reOMXKn+YBp+3PcZgiynLDXds/z5H18pecE1ljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=JMkbaykr; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id BED5C240028
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 00:53:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1750028034;
	bh=fJric2xuz/D7KmQiBryCjvqCKImRal40258ZoI4kmdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=JMkbaykrVVKtI5b6bPvljsCIZ++v/233NE2h4ZHwsZOHYTVQneI1Em2kapIX9Jny5
	 yhiK3ZA3Rx7qXjfpa/K6xrtHO0vXSiPVjmtkdnkWq2/C7bpPQMfmahtkzqPAxpEu2U
	 FH482o+Eg5s049jJJGKv1OxPh+v/Tm2+8flONGZy6kbT7WPUfBdKhHcWYQNBsANjQx
	 IKrhbb4XRTSANki2u7tBe37ZLIJX1zRu9WAKQRLsWjgT71pzv4+m2Hg7YeoCN4E/kR
	 GW1EajIOaPPq1gycrBFHAzIykg3cVmAs5SWaDeD2zmFIVCmb8QLXFNj6R0kocLTgs6
	 5xrlM0c//1xTPu/EqpJy7O+szA1HuO8UErxhFJJgjvkh6fhm3pDne3IDAGQWzsv67s
	 UAElpjfTiD6t/s3/NUQrI/VTjvJ/Kv/vlkJ7U42TYIv9TAbtNZwos0nQ6tQqonXrtp
	 GY52Xy1ZlB+0d7owVrP3gyKxlIMUjO6JZf+YtG/wdZ8c41bM2TF
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bL7jF2ZZxz9rxF;
	Mon, 16 Jun 2025 00:53:53 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Sun, 15 Jun 2025 22:51:53 +0000
Subject: [PATCH v2] docs: filesystems: vfs: remove broken resource link
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vfs-docs-v2-1-70b82fbabdbe@posteo.net>
X-B4-Tracking: v=1; b=H4sIAIhOT2gC/0XMywrCMBCF4VcpszaSDLZeVr6HdJHLxGaTlEwIS
 sm7Gwvi8j8cvg2YciCG27BBpho4pNgDDwPYRccnieB6A0oc5aRGUT0LlywLoyVqg/aqTh76fc3
 kw2unHnPvJXBJ+b3LVX3XHzL9kaqEEtJdzt5YqY3F+5q4UDpGKjC31j7wTOICoQAAAA==
X-Change-ID: 20250615-vfs-docs-ba02ab2c914f
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, neil@brown.name
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750028010; l=1228;
 i=charmitro@posteo.net; s=20250526; h=from:subject:message-id;
 bh=fJric2xuz/D7KmQiBryCjvqCKImRal40258ZoI4kmdE=;
 b=5zh7zA2RZutpTFQHg8S5OGUNE7swOo+Wd6Cqn5D47Xrt/Ieowfte+DKQxVXALtZkbJQq3cAoo
 mQCxXoB94h2CACCuHi5eGKOUtlEiaUVEDWToiJC0Z5Cvmhol2vJysby
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=PNHEh5o1dcr5kfKoZhfwdsfm3CxVfRje7vFYKIW0Mp4=

The referenced link is no longer accessible. Since an alternative
source is not available, removing it entirely.

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v2:
- Removed "so" from the patch description
- Link to v1: https://lore.kernel.org/r/20250616-vfs-docs-v1-1-0d87fbc0abc2@posteo.net
---
 Documentation/filesystems/vfs.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index fd32a9a17bfb34e3f307ef6281d1114afe4fbc66..a90cba73b26c18344c3d34fdb78acb4ff6f14ae8 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1549,9 +1549,6 @@ Resources
 Creating Linux virtual filesystems. 2002
     <https://lwn.net/Articles/13325/>
 
-The Linux Virtual File-system Layer by Neil Brown. 1999
-    <http://www.cse.unsw.edu.au/~neilb/oss/linux-commentary/vfs.html>
-
 A tour of the Linux VFS by Michael K. Johnson. 1996
     <https://www.tldp.org/LDP/khg/HyperNews/get/fs/vfstour.html>
 

---
base-commit: 4774cfe3543abb8ee98089f535e28ebfd45b975a
change-id: 20250615-vfs-docs-ba02ab2c914f

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


