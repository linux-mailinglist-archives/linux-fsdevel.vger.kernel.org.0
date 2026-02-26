Return-Path: <linux-fsdevel+bounces-78504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDIICABfoGlViwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:56:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB41A811E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 076E93131DA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A13E8C59;
	Thu, 26 Feb 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mVvuPZbu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863539E6D9;
	Thu, 26 Feb 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117404; cv=none; b=sfUKTqUxwSvkVGsDlR5FhXPjpKy/O7kFUcvmTGSS9zKe1NCsCWQ3VRloWnAAwHV64gSjHbTgEuR/1Jd3227WQhAZQXqdrL8FGhCleT30vcAeeSt71L6avHWczjMNoEv511JNfiHw6aP9vJ2Y5ma2PryLQNsl4XRwFgiMcua/SPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117404; c=relaxed/simple;
	bh=HzIcMoFlgwjLmdasTCanlTOmetw6aNcq+a03Og4xM30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqZnK564+1C18MhzVnlHGrIRkKCNMZsBR0VIfcim+n7ZfoiPWeS0K9ekc5bSSnQN0GS7jt4JwQNoEcovXbKrNXhnyohGHq/VPb/9WeKvO7qCbgcwOb6sEavzdiOtnw2OXo2xaaEPKNBDCBEYdy4rS7CBE2AUUYm3l9vyb93xWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mVvuPZbu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mlW1GrWYPpKtXEVPnQNWBHiFH5LdPT6NCG40um9+2Jk=; b=mVvuPZbubKAsBHIRa9ZgMZp7up
	6jBDAhlLzfognU5MoSboXf6xY+4hguYbUiwKibxPVZNaYznsY84WjoTE5yf8uVxB6akss0xbP5C36
	Ks+m6P1nleLZJXHAsDCZeGYMM3HYMk/1lek+KTxojvGRwVPwKsM27NHmQWolGybPywiXlR73dDj9i
	GcDV9T3ghCAv9BPC57TYLcYsvH1dMBaQnHdXjxgqqRus1ibChr9WNzVeBGoJCT2Svceg/apgIJp2p
	XwYc9djEQzWodISFIKsPptFLYEbAoFZVbTMApgTeYd+BwEgliKfM0g3NtLqc4S+ME81XCygCY8NkA
	/AKwlRbA==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgd-00000006NaB-1e5p;
	Thu, 26 Feb 2026 14:49:55 +0000
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
Subject: fscrypt API cleanups v2
Date: Thu, 26 Feb 2026 06:49:20 -0800
Message-ID: <20260226144954.142278-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78504-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid]
X-Rspamd-Queue-Id: EDAB41A811E
X-Rspamd-Action: no action

Hi all,

this series cleans up various fscrypt APIs to pass logical offsets in
and lengths in bytes, and on-disk sectors as 512-byte sector units,
like most of the VFS and block code.

Changes since v1:
 - remove all buffer_head helpers, and do that before the API cleanups
   to simplify the series
 - fix a bisection hazard
 - spelling fixes in the commit logs
 - use "file position" to describe the byte offset into an inode
 - add another small ext4 cleanup at the end

Diffstat:
 fs/buffer.c                 |   17 ++++++++
 fs/crypto/bio.c             |   37 ++++++++----------
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
 12 files changed, 89 insertions(+), 153 deletions(-)

