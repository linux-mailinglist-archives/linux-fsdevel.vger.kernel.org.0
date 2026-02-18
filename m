Return-Path: <linux-fsdevel+bounces-77514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMyoNg9ZlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ECC1534AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F029301D0E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406D3090F7;
	Wed, 18 Feb 2026 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UAfAZw2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D726FA6F;
	Wed, 18 Feb 2026 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395338; cv=none; b=Q0z2z+0qf9zXFUJ2MCfhhH81lu69jpe8GBZVht6ddxxstb7NxfE3WmWwwpyr2i/XJlU1CTq9HF3ZkIYBpVjbZ0mM4mzei1fgENiRsNkkXyXTgctHFDy2HszV8KqcQnz+US7xk2jiudUYZls84wfEAKhRL3eDteiaudMJOnXOhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395338; c=relaxed/simple;
	bh=hoQ5/U84bsuguMuewD1BFqmQWJ4u9kruzIdiTMJm1v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPAMTnpVtdDzAQnEAiS0KGRGFjbtW5mMAL175xkqR7TOgth3lcxtToK9qLSj8oEcJE76Mwg1bQjfh9A3hz30YD2/3eJ6273NxtsdQIycml4fanG7SPDA5aIvYY176LG9ywLTSwaxQ1sVC4mHi+SXXqMaCGqJERJe0ViFO2rVaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UAfAZw2C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=cIpjf5hWnYH6fYx2YR3FldNkF2HhRTKOd+610y1ar28=; b=UAfAZw2C/LvkMKQ4CLWfMCcXH8
	a94h2MZbbIu1kjZPb/OTF/JhbGuTqzW7NdqO2pIHySURqhlX/q7zLCtpv+3wwZWItbQvwEp74ewJ6
	UeGZSymB4EDmm2fG7jUiRuFLnIBGqsrBhAidPmCPZGzaBVLO6pbVEFRtrsSYH3DOJDh3U0vgoJeKd
	1E7XmtUSGiKCUzUfCGW3fn3gpr0806Iwy0kXlkFdW9LpWTLlPWvU/zvTqXmhD1Ou3c4us8oyKBegb
	EKk3esbz4EU5m3tiJEGP6RiWF1c3vCXDBBgNNF8Tha9ASQX5MydmGSHJyuBKVtJVUqjXCdHnGcy4f
	A9lN0WGQ==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaqW-00000009Lec-0JXr;
	Wed, 18 Feb 2026 06:15:36 +0000
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
Date: Wed, 18 Feb 2026 07:14:38 +0100
Message-ID: <20260218061531.3318130-1-hch@lst.de>
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
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77514-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0ECC1534AB
X-Rspamd-Action: no action

Hi all,

this series cleans up various fscrypt APIs to pass logical offsets in
and lengths in bytes, and on-disk sectors as 512-byte sector units,
like most of the VFS and block code.

Diffstat:
 fs/crypto/bio.c             |   35 +++++++++++++++--------------------
 fs/crypto/fscrypt_private.h |    3 ---
 fs/crypto/inline_crypt.c    |   34 ++++++++++++++++------------------
 fs/crypto/keysetup.c        |    2 --
 fs/ext4/inode.c             |    5 ++++-
 fs/ext4/readpage.c          |    7 ++++---
 fs/f2fs/data.c              |    7 +++++--
 fs/f2fs/file.c              |    4 +++-
 fs/iomap/direct-io.c        |    6 ++----
 include/linux/fscrypt.h     |   19 +++++++++----------
 10 files changed, 58 insertions(+), 64 deletions(-)

