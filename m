Return-Path: <linux-fsdevel+bounces-43203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E87A4F417
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 02:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CD9167CF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 01:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD8154BE5;
	Wed,  5 Mar 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jx/Of5PV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43911146A6F;
	Wed,  5 Mar 2025 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139592; cv=none; b=R0yQnc/6baiczDNzCpO2e2tLzwdQjU8cG982Aw7jEwNbMHRUcKXFBwXIiMMRN820J3Z9ocPPSg7lut+tNIN+KrBITSVOi3bxUgzwe3lHjqdJ8kbrYOYVIFBbv1/m6y89aJQ32XRXiUg+lqaF2AQI74PwP5AXML12t7d5VU1tozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139592; c=relaxed/simple;
	bh=tlaqVgr8vtGbRleo/L1EpGdIMlFP9kz8AIunLQ7ShQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZanNeDQHPSfAqJiq5degYd7KQmbWFyGGc8+WZYiRXKaN+H7GlEe9okwlCQYbhex+R1gSiJvNIF3EnyqGVVkzco2xAFBgs2qf4ksM/5D4pnLBszyTvSeajLDmPKALI2ovn4QCi6exIPfywyfJvmwclBlwSUSTTXr+A7vWyLm6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jx/Of5PV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZrC3f8pMRf+T5oXLUaMnjlglozHjJOk02SyBFDBOYb0=; b=Jx/Of5PVEs5IPOpFTHi/F756ku
	Zi7Pmxn62ZbcMwDhtjP8/XvnEhMx+IXnz3C+AZjySOkrU694OWksh16eKYlUuiuSWKRqieJDh7Zz1
	md5/5fjF+s3fNxSixkScqB5m/DzmOwBELOePfsSMfg5V8fATNg3P4hwUK7R0gU1eS5/hPqjbuqwtT
	n9gMuS3fB4H/Xdz8VTTdxtFvpGyRM0qWMTfvz6oQ5fyDxK2JSsmMYA3RP+Dzf0diGhhpq9bQOIeMb
	E911quhvz4xy4jnRJjqhy8SqVnpiAGscHZaZSvJyZWPkosHJA2FWzc53zTHG/ztTC5ULlu3vdDB2j
	qS7JZDZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpdwW-00000006krT-37YN;
	Wed, 05 Mar 2025 01:53:04 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: kbusch@kernel.org,
	john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()
Date: Tue,  4 Mar 2025 17:53:01 -0800
Message-ID: <20250305015301.1610092-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The commit titled "block/bdev: lift block size restrictions to 64k"
lifted the block layer's max supported block size to 64k inside the
helper blk_validate_block_size() now that we support large folios.
However in lifting the block size we also removed the silly use
cases many filesystems have to use sb_set_blocksize() to *verify*
that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
happen in-kernel given mkfs utilities *can* create for example an
ext4 32k block size filesystem on x86_64, the issue we want to prevent
is mounting it on x86_64 unless the filesystem supports LBS.

While, we could argue that such checks should be filesystem specific,
there are much more users of sb_set_blocksize() than LBS enabled
filesystem on linux-next, so just do the easier thing and bring back
the PAGE_SIZE check for sb_set_blocksize() users.

This will ensure that tests such as generic/466 when run in a loop
against say, ext4, won't try to try to actually mount a filesystem with
a block size larger than your filesystem supports given your PAGE_SIZE
and in the worst case crash.

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Christian, a small fixup for a crash when running generic/466 on ext4
in a loop. The issue is obvious, and we just need to ensure we don't
break old filesystem expectations of sb_set_blocksize().

This still allows XFS with 32k block size and I even tested with XFS
with 32k block size and a 32k sector size set.

 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3bd948e6438d..de9ebc3e5d15 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -181,7 +181,7 @@ EXPORT_SYMBOL(set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
-	if (set_blocksize(sb->s_bdev_file, size))
+	if (size > PAGE_SIZE || set_blocksize(sb->s_bdev_file, size))
 		return 0;
 	/* If we get here, we know size is validated */
 	sb->s_blocksize = size;
-- 
2.47.2


