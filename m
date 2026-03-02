Return-Path: <linux-fsdevel+bounces-78910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH1RDo2cpWlfFwYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:19:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88D1DA9A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50E143025E00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E533FFAB0;
	Mon,  2 Mar 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F1v0SWDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC03E0C68;
	Mon,  2 Mar 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461169; cv=none; b=MaVw+fe80Y2g8r91fm6VA+NRwJ9CCMdC7hwwZN0F0xHYaWIGkTSatpx3PZzNTpfEs00+4SM5/dMpuGpxWimAPN6DdQTEDsbJjvmIZ4CgA74dlMn4elxUWaknPuxCkKap9hQ4WjxKwS+4FZECK15hxTu95lD5xv1nghO+KAjKoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461169; c=relaxed/simple;
	bh=uiMOXYztvKq8NLuj8OLv9JS7j8d3WGfEX2Zh3/r2Ezs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRj7jbe9PyInnMp5/IOIek2FPJBdQne20XCmiMl/xW0KWO9c/tZN+tIJqpgd9jMgRtY2TPevioXpKJez7AwMsSCczgOmLrnzUg+ec+EinCQtfLox5ygETjDJ/hYtsLwT+fmFDaRixUbfu9VWK7e27SczSRtubQTaKmm1qYvMex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F1v0SWDr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jZYzU/9Jj6dU7rQhTTpeYwKqyiuou9e5/FVmJO4ciTI=; b=F1v0SWDrYaZF3b2OzFDhrUiQ/K
	FSGJGTXZd9YMS/D0V14LhzcRuKPXY05RMQWipxHZMAF4QBL+MCp8c90JfZarVpGQBkYVqJ7RZ9OYA
	5EyqyePOl0aywNTTE3XbL3kXqqN7GRu/g8kg9FZTuJRjPpNUfxyhpBJk9yP9pjAzjvJCt1ElAN1JU
	X3CkDeESlr1/LzCEHypEZp74xOSbOP4ZtHQyY9YANZ63g3Cw8F4liTnHkKaFpj7nllaBNvLQkAcrT
	TLGtFDlBH4Inf/cEkv4M8XT4xpYrif0YGo6V8oYvJiwlpfRVUS1eIO7c7WysreR32bInNs+2vu3yJ
	ceQ7hVzw==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47I-0000000DDRc-1w0f;
	Mon, 02 Mar 2026 14:19:24 +0000
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
Subject: fscrypt API cleanups v3
Date: Mon,  2 Mar 2026 06:18:05 -0800
Message-ID: <20260302141922.370070-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78910-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 5F88D1DA9A7
X-Rspamd-Action: no action

Hi all,

this series cleans up various fscrypt APIs to pass logical offsets in
and lengths in bytes, and on-disk sectors as 512-byte sector units,
like most of the VFS and block code.

Changes since v2:
 - use the local bio variable in io_submit_init_bio
 - use folio instead of io_folio (and actually test the noinline mode,
   which should have cought this for the last round)
 - add an extra IS_ENABLED(CONFIG_FS_ENCRYPTION) to safeguard
   against potentially stupid compilers
 - document the byte length needs to be a multiple of the block
   size
 - case to u64 when passing the byte length
 - move a hunk to an earlier patch
Changes since v1:
 - remove all buffer_head helpers, and do that before the API cleanups
   to simplify the series
 - fix a bisection hazard
 - spelling fixes in the commit logs
 - use "file position" to describe the byte offset into an inode
 - add another small ext4 cleanup at the end

Diffstat:
 fs/buffer.c                 |   18 ++++++++-
 fs/crypto/bio.c             |   40 +++++++++-----------
 fs/crypto/fscrypt_private.h |    3 -
 fs/crypto/inline_crypt.c    |   86 ++++----------------------------------------
 fs/crypto/keysetup.c        |    2 -
 fs/ext4/inode.c             |    5 ++
 fs/ext4/page-io.c           |   28 ++++++++++----
 fs/ext4/readpage.c          |   10 ++---
 fs/f2fs/data.c              |    7 ++-
 fs/f2fs/file.c              |    4 +-
 fs/iomap/direct-io.c        |    6 +--
 include/linux/fscrypt.h     |   37 ++++--------------
 12 files changed, 92 insertions(+), 154 deletions(-)

