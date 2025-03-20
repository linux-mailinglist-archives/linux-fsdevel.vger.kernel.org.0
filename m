Return-Path: <linux-fsdevel+bounces-44490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F9A69D16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B9C188829A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49985AD5A;
	Thu, 20 Mar 2025 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="pImCxAYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B879F2;
	Thu, 20 Mar 2025 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429651; cv=none; b=LAZqGC9lwPJU/jcsY+CrXR0MdLfVxnOGDgVa5oabHd3RppWrxPE9dp0zwJ1dBb8S0s0csZCAPlSRWY6rcGoDwsOToed5nEHkhEBTgFO+P97sYO3J3vvvurY8LZXzoYaRzorq7VTRaOrknidEuUXEE2y4/+TLF/0QYpaZi2G/W9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429651; c=relaxed/simple;
	bh=llHSV+7G4W8fjSvREfF+ZiSJfXs53TD9xSG8C/Szsz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uyG8SLSIfzid9mtn6oYSqaFSpCWILqKCmJuSQfVirjXtnQ7jYDhvRxQVnUr2Kil/SR+ONc0LgYZgRHftE+8D4qRewjjn/XeuE1MMaaZnx+ADQ2wUShmOsufkpMEKLq08rDcndFA4uUvEx6Z94ONAQJbkE50Mf13SleZYC0Vp17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=pImCxAYP; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZJ5fG2nsgz9skV;
	Thu, 20 Mar 2025 01:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742429638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xmF6T9wgWmDv9JlK9e1PAWOlAEmjIU7jY2iEqbhLZsg=;
	b=pImCxAYP4uWrWjZedSGJs0CSHryiN9gJD029xCznk/r+X84g/EPFnz471bEiO51Gw6xInW
	akOflDfmBkbF0zHpzRgHSs8oOv/ZmfpjZ3mrx4IcF1CXDyQQH3Ch8neWHO1a0Rsa9GMaJB
	rAMrRKwjHzLaBUmVotYfTtMzVQZE9wAt51SXRrfA5QYs0C/MozV0UBxHtLD6M3h8ojcsF0
	w2u/1T/8rTwFmcs+AUEP8wWLpI3awXm4AvXG5U76FqwfsepL7uDdN7Y7QxR7VYGJqrt6IH
	HugIVlI+pDKM4wfZKAfFIAbEYv9VrCK/7bvvCS9G5J6PbecxoKgnqp0L27syug==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem support
Date: Wed, 19 Mar 2025 20:13:49 -0400
Message-Id: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL5d22cC/yXNQQ7CIBCF4as0sxYDFFp05T1MFwiDnYVtAw1qG
 u4utsv/ZfLNBgkjYYJrs0HETInmqYY8NeBGOz2Rka8NkkvNpeDMLiGxi1eqN73RwXCop0vEQJ+
 duQ+1R0rrHL+7msV/PYBWqAPIgnHmfbC2M2330O6Ga33n0L9t9Ons5hcMpZQf1qa7ZKAAAAA=
X-Change-ID: 20250210-apfs-9d4478785f80
To: brauner@kernel.org, tytso@mit.edu, jack@suse.cz, 
 viro@zeniv.linux.org.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5942;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=llHSV+7G4W8fjSvREfF+ZiSJfXs53TD9xSG8C/Szsz4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOK08zYS9jVy9mbDJOOERQRDg3d3kxcjc4L2NmRGZFCjZBTnY2Y3k3b3VWeUN6NDhh
 OVhwS0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VURWZ6QXl
 uSkM5K2lwbHJybm1HNDl1ZDlrVzh6OHhIYnlCN092U2ZkcE1DbHVtVmJ2L1lmanZJYzU2bGozSA
 p2VjFvNFFPMzlYTnVIc3pJMnBZZHVNRjNLMWZ2ODEybFUxVzVBR2V0VGFzPQo9UVVCWgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZJ5fG2nsgz9skV

Hello everyone,

In series 2, I have fixed the formatting with clang-format of the lzfse
library and fixed the comments to use linux kernel styles. I also
removed my Copyright from files where it was not appropriate. 
Additionally, I removed the encode.c files as they were unused and 
not compiled into the final module They should be easy enough to add 
back if needed. I also rebased on Linus's tree, just in case. 
Nothing broke! ;)

I am holding off on adding Ernesto's Co-developed-by and Signed-off-by
tags until I get a better grasp of where this module is headed. I hope
to here back from Christian and the LSFMMBPF folks sometime in the next
few weeks.

I understand the jury is still out on supporting both reading and
writing. As it stands, I have configured the code to support
reading/writing on mount, but upstream auto-rw is configurable via a
CONFIG option. Some people have expressed that they want the module
upstreamed even if only read is supported. I will stay tuned and make
changes as needed.

Additionally, I realize that staging/ may not be the correct location
for the driver. However, I am basing my upstream process off of the
erofs process. They started in staging. I understand that the correct
tree and dir will be discussed as next weeks LSFMMBPF summit, 
so I will wait on their feedback before making any moves.

I am curious to hear everyone's thoughts on this and to start getting
the ball rolling for the code-review process. Please feel free to
include/CC anyone who may be interested in this driver/the review
process. I have included a few people, but have certainly missed others.

Ernesto, the original author, encouraged me to submit any code
improvements upstream instead of submitting here. I am upstreaming my 
code improvements to his tree, but I will continue the effort here in
caes upstream fs folks are interested. In any case, my goal here is to
create discussion around the project and make the code better while I am
at it.

Some people on Asahi channels have mentioned that this driver could be
helpful for implementing certain features like the fingerprint reader and
simplify the boot process some. This feedback encourages me to continue
with this effort. Asahi folks, keep at it, y'all are awesome.

[0]: https://lore.kernel.org/lkml/20250307165054.GA9774@eaf/

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
Changes in v2:
- remove Ethan copyright in files
- cleanup/format lzfse code and comments
- fix a few checkpatch problems
- Link to v1: https://lore.kernel.org/r/20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com

---
Ethan Carter Edwards (8):
      staging: apfs: init lzfse compression library for APFS
      staging: apfs: init unicode.{c,h}
      staging: apfs: init apfs_raw.h to handle on-disk structures
      staging: apfs: init libzbitmap.{c,h} for decompression
      staging: apfs: init APFS
      staging: apfs: init build support for APFS
      staging: apfs: init TODO and README.rst
      MAINTAINERS: apfs: add entry and relevant information

 MAINTAINERS                                      |    6 +
 drivers/staging/Kconfig                          |    2 +
 drivers/staging/apfs/Kconfig                     |   13 +
 drivers/staging/apfs/Makefile                    |   10 +
 drivers/staging/apfs/README.rst                  |   87 +
 drivers/staging/apfs/TODO                        |    7 +
 drivers/staging/apfs/apfs.h                      | 1192 ++++++++
 drivers/staging/apfs/apfs_raw.h                  | 1566 +++++++++++
 drivers/staging/apfs/btree.c                     | 1174 ++++++++
 drivers/staging/apfs/compress.c                  |  441 +++
 drivers/staging/apfs/dir.c                       | 1439 ++++++++++
 drivers/staging/apfs/extents.c                   | 2370 ++++++++++++++++
 drivers/staging/apfs/file.c                      |  163 ++
 drivers/staging/apfs/inode.c                     | 2234 +++++++++++++++
 drivers/staging/apfs/key.c                       |  337 +++
 drivers/staging/apfs/libzbitmap.c                |  448 +++
 drivers/staging/apfs/libzbitmap.h                |   32 +
 drivers/staging/apfs/lzfse/lzfse.h               |   86 +
 drivers/staging/apfs/lzfse/lzfse_decode.c        |   66 +
 drivers/staging/apfs/lzfse/lzfse_decode_base.c   |  725 +++++
 drivers/staging/apfs/lzfse/lzfse_encode_tables.h |  224 ++
 drivers/staging/apfs/lzfse/lzfse_fse.c           |  214 ++
 drivers/staging/apfs/lzfse/lzfse_fse.h           |  632 +++++
 drivers/staging/apfs/lzfse/lzfse_internal.h      |  599 ++++
 drivers/staging/apfs/lzfse/lzfse_tunables.h      |   50 +
 drivers/staging/apfs/lzfse/lzvn_decode_base.c    |  721 +++++
 drivers/staging/apfs/lzfse/lzvn_decode_base.h    |   53 +
 drivers/staging/apfs/lzfse/lzvn_encode_base.h    |  105 +
 drivers/staging/apfs/message.c                   |   29 +
 drivers/staging/apfs/namei.c                     |  132 +
 drivers/staging/apfs/node.c                      | 2069 ++++++++++++++
 drivers/staging/apfs/object.c                    |  315 +++
 drivers/staging/apfs/snapshot.c                  |  683 +++++
 drivers/staging/apfs/spaceman.c                  | 1433 ++++++++++
 drivers/staging/apfs/super.c                     | 2098 ++++++++++++++
 drivers/staging/apfs/symlink.c                   |   77 +
 drivers/staging/apfs/transaction.c               |  959 +++++++
 drivers/staging/apfs/unicode.c                   | 3156 ++++++++++++++++++++++
 drivers/staging/apfs/unicode.h                   |   27 +
 drivers/staging/apfs/xattr.c                     |  911 +++++++
 drivers/staging/apfs/xfield.c                    |  171 ++
 41 files changed, 27056 insertions(+)
---
base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
change-id: 20250210-apfs-9d4478785f80

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


