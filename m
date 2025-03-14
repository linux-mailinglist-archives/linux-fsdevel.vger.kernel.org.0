Return-Path: <linux-fsdevel+bounces-44083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CADA61F87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C54442135A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FA1C8631;
	Fri, 14 Mar 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="tIRZiUN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B0155743;
	Fri, 14 Mar 2025 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989516; cv=none; b=bX190XxtRDe2jGwfgr1A3VvIH/YLj3eZSXwfVjD5/ouLffdv9C4WZE7zIXfp9TaDmqBZZyUA8boDOXMUqT2b6S7VC9ktccE1ok25uuLbgKEOpeliAIOV6RKKIlDw0EhM9xOrHETVzM6vw4DGKRH1Vde97wvcoPBuRA7bC7SD4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989516; c=relaxed/simple;
	bh=UNPNnzvCRlfNLT/98cuL4dZmsHS+ig3ASnt5aAEm1jI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MXDf+dHb/dbUI/C+kuUtM4RaMbRuRiShzXyPxdaid1ODME4OL7Oe++f8p6G6bPE575B8vn5YrJmm2OoPfeNOweGZ1A7zvZgKjRHrK9mPnO+X5r7gPIyLByhYiaxgJVKO/KWEexbpi7IU7xsMd9MVpo5dbPaD91ZcxL4rr9LXbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=tIRZiUN6; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZDyt62qYFz9shx;
	Fri, 14 Mar 2025 22:58:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741989502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eljWF6A2+LoZJ/GR+lrqWY3/PFt8v76bPw+JAiEtG54=;
	b=tIRZiUN63e/0e2WHQl0W7qE6bXHTU+1EhlxvnaF1hITzyc7NaeVNpKLQ8AZdYE8wV+NKck
	yIfugmpz+jCIDCdNbOoAgj65vL3nrkgVckTaZuBB/7mBf4wAdA0QnraOnbdGiPph1YZ1v3
	P//V75+pXdVUgWfWkfH8I4vMx0UXBcAqpp8wc2HBHng//EkIbJ47MXFb7NukgrMbaWb4Xz
	l2sxRoFOD/+iC7g56+V8qNzZKgLai1nS05vgfvWznhWCLgotQ/I1+WUIIVzie/p7XlgyG1
	OaT74AkW4bpaAkGW3MnNUW8TmP170DAtZ+Yu/w1j09GGvmmb3LWu+HaeOc0y2A==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Subject: [RFC PATCH 0/8] staging: apfs: init APFS module
Date: Fri, 14 Mar 2025 17:57:46 -0400
Message-Id: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFqm1GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MD3cSCtGJdyxQTE3MLcwvTNAsDJaDSgqLUtMwKsDHRsbW1AHbVvw5
 WAAAA
X-Change-ID: 20250210-apfs-9d4478785f80
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu
Cc: ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4698;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=UNPNnzvCRlfNLT/98cuL4dZmsHS+ig3ASnt5aAEm1jI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGOVpWaDVoMWZCdTc3c3pYLzhlWDdYSGNxWkt3cTZYClJZSFN6WkZyTTRxbXEwcGQv
 TS9kVWNyQ0lNYkZJQ3VteVBJL1J6bnRvZVlNaFoxL1hacGc1ckF5Z1F4aDRPSVUKZ0ltY25zREk
 4S1JrMVRKWjNmdE44K3ErK1Y4Nzh2WGFYUFdBQmIvRWN6UHVTS3hZSjdqZWhZSGhyeHk3VXJmRw
 pvNGlHdmtUUjNZYWIzNzdpVWlqZndXSm0wWmQrL3RRcG9Rby9UZ0FCSEU3ego9R1pMNQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Hello everyone,

This is a follow up patchset to the driver I sent an email about a few
weeks ago [0]. I understand this patchset will probably get rejected, 
but I wanted to report on what I have done thus far. I have got the 
upstream module imported and building, and it passes some basic tests 
so far (I have not tried getting XFS/FStests running yet). 

Like mentioned earlier, some of the files have been moved to folios, but
a large majority of them still use bufferheads. I would like to have
them completely removed before moved from staging/ into fs/.

I have split everything up into separate commits as best as I could.
Most of the C files rely in functions from other C files, so I included
them all in one patch/commit.

I am curious to hear everyone's thoughts on this and to start getting
the ball rolling for the code-review process. Please feel free to
include/CC anyone who may be interested in this driver/the review
process. I have included a few people, but have certainly missed others.

[0]: https://lore.kernel.org/lkml/20250307165054.GA9774@eaf/

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
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
 drivers/staging/apfs/apfs.h                      | 1193 ++++++++
 drivers/staging/apfs/apfs_raw.h                  | 1567 +++++++++++
 drivers/staging/apfs/btree.c                     | 1174 ++++++++
 drivers/staging/apfs/compress.c                  |  442 +++
 drivers/staging/apfs/dir.c                       | 1440 ++++++++++
 drivers/staging/apfs/extents.c                   | 2371 ++++++++++++++++
 drivers/staging/apfs/file.c                      |  164 ++
 drivers/staging/apfs/inode.c                     | 2235 +++++++++++++++
 drivers/staging/apfs/key.c                       |  337 +++
 drivers/staging/apfs/libzbitmap.c                |  442 +++
 drivers/staging/apfs/libzbitmap.h                |   31 +
 drivers/staging/apfs/lzfse/lzfse.h               |  136 +
 drivers/staging/apfs/lzfse/lzfse_decode.c        |   74 +
 drivers/staging/apfs/lzfse/lzfse_decode_base.c   |  652 +++++
 drivers/staging/apfs/lzfse/lzfse_encode.c        |  163 ++
 drivers/staging/apfs/lzfse/lzfse_encode_base.c   |  826 ++++++
 drivers/staging/apfs/lzfse/lzfse_encode_tables.h |  218 ++
 drivers/staging/apfs/lzfse/lzfse_fse.c           |  217 ++
 drivers/staging/apfs/lzfse/lzfse_fse.h           |  606 +++++
 drivers/staging/apfs/lzfse/lzfse_internal.h      |  612 +++++
 drivers/staging/apfs/lzfse/lzfse_main.c          |  336 +++
 drivers/staging/apfs/lzfse/lzfse_tunables.h      |   60 +
 drivers/staging/apfs/lzfse/lzvn_decode_base.c    |  721 +++++
 drivers/staging/apfs/lzfse/lzvn_decode_base.h    |   68 +
 drivers/staging/apfs/lzfse/lzvn_encode_base.c    |  593 ++++
 drivers/staging/apfs/lzfse/lzvn_encode_base.h    |  116 +
 drivers/staging/apfs/message.c                   |   29 +
 drivers/staging/apfs/namei.c                     |  133 +
 drivers/staging/apfs/node.c                      | 2069 ++++++++++++++
 drivers/staging/apfs/object.c                    |  315 +++
 drivers/staging/apfs/snapshot.c                  |  684 +++++
 drivers/staging/apfs/spaceman.c                  | 1433 ++++++++++
 drivers/staging/apfs/super.c                     | 2099 ++++++++++++++
 drivers/staging/apfs/symlink.c                   |   78 +
 drivers/staging/apfs/transaction.c               |  959 +++++++
 drivers/staging/apfs/unicode.c                   | 3156 ++++++++++++++++++++++
 drivers/staging/apfs/unicode.h                   |   27 +
 drivers/staging/apfs/xattr.c                     |  912 +++++++
 drivers/staging/apfs/xfield.c                    |  171 ++
 45 files changed, 28984 insertions(+)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250210-apfs-9d4478785f80

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


