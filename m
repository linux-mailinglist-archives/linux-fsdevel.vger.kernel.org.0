Return-Path: <linux-fsdevel+bounces-78429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOtFO6Crn2m1dAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:10:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C91A009C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8419E302BEA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9617913DDAA;
	Thu, 26 Feb 2026 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6MaZ94p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF537416C;
	Thu, 26 Feb 2026 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071578; cv=none; b=efXPcfDhssyDWM7d8l+S+6fQZuWquTINJb6RBRwIfWRITFRZFTwnqcHPjI04graySP3i+qhNM0H++gGgDuQVKrG6X1VZUqVDrZDPIhVvg+NLRbjUyzSZMdJ6j5eHD/MZbCeYyee+hHirasOQsUIG/s3iAsu8L0zgpmvkqUoCmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071578; c=relaxed/simple;
	bh=3yv/C2cGfmMb5IKP7aTlXkEj9I0ttJX/d1El7hGbw2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLlOE6wADJZh/yh93GW4wLCQ6ludqsOE0CBV0hGr0wjAmCe97ADgEEXkYR+nKlr5MiRsCg6oHBN8vqqR2hyi8NB9P3LcYiz+cAwYC4tO+ZRT/Lx47a1dsnY+3LG4f4LSDzbxu/NcqFGe9Ci5fiU1hDO5MInl5CwCUoemhUQKTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p6MaZ94p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0a+DuFrY2dECD/MNyDqv47h3TRZqMfre5JcIARl9yKs=; b=p6MaZ94pjopVrpFOBip5Pro8Gj
	GX+iJISmX5kvB63LpzMbzvpcJvzdiOxu8BopLYgi//DdQbJQZdrnwGLfqjWMpP5HdWU/6IJtADtbx
	IJC157xC5Jb+5V1LWxrdtkH0F/lyu7AecOZ77q/pNQUEGP0IbT8UG5mkpgwqUWLG/j9+YwFzISQTb
	baikeP9v3zl0/zbv4fg+YXwjt8eVzNcCW0Zh3WzTYiFzFkeyxgy9KoYbQBMxTNBHCFS6t8iQvLXZj
	OixIj27a6rYGEHt/ApKw7qgZYcDQV5NgGwiqvc8zOfCwWLYe8/Si+m9RqolkGkaGo18zkYBew3Uwz
	CsJpHlTw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvQlc-00000005DnS-1APU;
	Thu, 26 Feb 2026 02:06:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] ntfs: repair docum. malformed table
Date: Wed, 25 Feb 2026 18:06:15 -0800
Message-ID: <20260226020615.495490-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,gmail.com,vger.kernel.org,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78429-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lwn.net:email]
X-Rspamd-Queue-Id: 6E6C91A009C
X-Rspamd-Action: no action

Make the top and bottom borders be that same length to
avoid a documentation build error:

Documentation/filesystems/ntfs.rst:159: ERROR: Malformed table.
Bottom border or header rule does not match top border.

(top)
======================= ===================================================
(bottom)
======================= ==================================================

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org

 Documentation/filesystems/ntfs.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260225.orig/Documentation/filesystems/ntfs.rst
+++ linux-next-20260225/Documentation/filesystems/ntfs.rst
@@ -39,7 +39,7 @@ Supported mount options
 
 The NTFS driver supports the following mount options:
 
-======================= ===================================================
+======================= ====================================================
 iocharset=name          Character set to use for converting between
                         the encoding is used for user visible filename and
                         16 bit Unicode characters.
@@ -156,4 +156,4 @@ windows_names=<BOOL>    Refuse creation/
 discard=<BOOL>          Issue block device discard for clusters freed on
                         file deletion/truncation to inform underlying
                         storage.
-======================= ==================================================
+======================= ====================================================

