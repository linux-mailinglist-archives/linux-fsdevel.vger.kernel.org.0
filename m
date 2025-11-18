Return-Path: <linux-fsdevel+bounces-68887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE48C67AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B78BE29124
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D983A2E62C7;
	Tue, 18 Nov 2025 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UjwADqvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595D242D9D;
	Tue, 18 Nov 2025 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446931; cv=none; b=PVqQ264A94YeW7iSJbws0e3vJadEeFrZmdYxr78gXrK5cd0q6G/6g2SyEqOtQ9KqHcwdmAcPrtyMgQeBfeKTFYxrNHJCanVJkqrYwfvnId4Yqco/tYauopKPQgZ0U92vkwm5j7gTi6gxhOtQOYwPtw1qP/4II9OGwlLq26eyomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446931; c=relaxed/simple;
	bh=CmyZJBJCSagA0onAahRgbQ4VgWmU6yVR3uCwRGFwDf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8oUfyOEkVuZAdMxyGq9dcZ3y5eG66pLnXVTKNUuN8geNPiqdbPSpBc57/nr1QzpprlqsTTKrGWZPt9k0ucvO1hbkDX1YbrM0CjpgSU5cJfTvsBY7I135RGpVGc9sy7hzYHAOGUXLBvxt5ITMP0uHhsCG6170BwgobL364D07eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UjwADqvL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xRGDQlHnczKIUXO+TmIW+WyJeT9hPKks9Od5qE6nNxM=; b=UjwADqvLrMmeBzU+K4k2KvS/Ly
	ttrbhZY7relSVo65q7B1SN9FBiT/DlRf3fGwzH8FMn3hGklt/shngR0PbsV1SGOAXEdu5Rdx69FhJ
	i9d2/L25TSw0CvTtLwtXn+XYEelSXTzh+QNxQrzEPrcYNdzL02Hcp6x664E6yowicHVgzmlejmFKs
	JWi5Mr3hDB3BVkTBGY3Yvr+3wJrBt5Azng9lwyX1TUwFu0eTlfk1XP38i0GmkpgX4x7ZdF9F3/bdm
	whE4HSuj3Wdr/H1FwyZmMGUhHXDB+kc+p+PtYceKKYVHj9qeu8GrbTHKV4hShktEfGf0pKPCQ2V0H
	KAaliWSA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF6N-0000000HUNw-2BiG;
	Tue, 18 Nov 2025 06:22:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: fscrypt API cleanups
Date: Tue, 18 Nov 2025 07:21:43 +0100
Message-ID: <20251118062159.2358085-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series cleans up various fscrypt APIs to pass logical offsets in
and lengths in bytes, and on-disk sectors as 512-byte sector units,
like most of the VFS and block code.

Note that this is based on top of fscrypt/for-current and not
fscrypt/for-next to pick up "fscrypt: fix left shift underflow when
inode->i_blkbits > PAGE_SHIFT".  There also is a minor conflict in
linux-next with the iomap tree tue to that tree changing and adjacent
line to one changes in this patch.

Eric only asked for the first two patches to be sent out, but I more of
my stack as I think it should be useful.  Feel free to apply as many
as you think are suitable.

Diffstat:
 fs/crypto/bio.c             |  108 +++++++++++++++++++++++++-------------------
 fs/crypto/fscrypt_private.h |    3 -
 fs/crypto/inline_crypt.c    |   34 ++++++-------
 fs/crypto/keysetup.c        |    2 
 fs/ext4/inode.c             |    5 +-
 fs/ext4/readpage.c          |    7 +-
 fs/f2fs/data.c              |    7 ++
 fs/f2fs/file.c              |    4 +
 fs/iomap/direct-io.c        |    6 --
 include/linux/fscrypt.h     |   19 +++----
 10 files changed, 105 insertions(+), 90 deletions(-)

