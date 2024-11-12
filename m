Return-Path: <linux-fsdevel+bounces-34383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E779C4DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403061F24F82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E3208964;
	Tue, 12 Nov 2024 04:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L+4VcAYu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L+4VcAYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9F4C91;
	Tue, 12 Nov 2024 04:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387555; cv=none; b=kDFR4JX9IdB7LbBckdTGePq4x3kFZYT2EEEXIlKjZlNdejpnu6OkZ6/sVy4a/rOieGbP3Ag4RWaQzH/9HFhWCmerv33auufxO2OYJJYZ+PyySXAKczAG2n94DsieHgs7vOjl3ufuj3Jg4Au97LeRJxhmz8L8rUwsrIAaK5J8TlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387555; c=relaxed/simple;
	bh=5DH25WIw+//IB3q1u+V5RXS1KjYqBicunDdkKgSo7do=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QexJ4A48+dwnU1r1OglAEey7eaLdL/cu91mrHwygMAE+4O1WchfWc7FkO1pUw0rbIXt6sR3qBzQsYfO5fwjcHYUP4tCW56Xzb1vF8JCno3K69j7WQQZXfCzxIGsb9RPvcEtIMvlRttcoumIDj2+AshDcFq0M+dZdW37BqVv6mnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L+4VcAYu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L+4VcAYu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 147581F392;
	Tue, 12 Nov 2024 04:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731387551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bg+Dyzwg3x8KB+QLKlNLJTrf47vQEYWjVaY4dCwJE6I=;
	b=L+4VcAYu4ptzxO34rWzWjV5F11ZOtavkJeuAFLM6bPcQs4i6SYtUM6mc4VtcVrzdtXTvxe
	wwmZZcGkPADKRJfF2tMTfpJfA88Km377G6mgm35+Q3Jehoqq6n1b1rM6DwQI1riLbGm2IB
	lP8iwToZavXyvBr6EtM4Q0pMBT828KA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=L+4VcAYu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731387551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bg+Dyzwg3x8KB+QLKlNLJTrf47vQEYWjVaY4dCwJE6I=;
	b=L+4VcAYu4ptzxO34rWzWjV5F11ZOtavkJeuAFLM6bPcQs4i6SYtUM6mc4VtcVrzdtXTvxe
	wwmZZcGkPADKRJfF2tMTfpJfA88Km377G6mgm35+Q3Jehoqq6n1b1rM6DwQI1riLbGm2IB
	lP8iwToZavXyvBr6EtM4Q0pMBT828KA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CE6A13301;
	Tue, 12 Nov 2024 04:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rJOcE53gMmf/TwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 12 Nov 2024 04:59:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ntfs3: remove a_ops->write_begin/end() call backs
Date: Tue, 12 Nov 2024 15:28:47 +1030
Message-ID: <ec1574d80e4b98726e6005a31f3766d84810ca6a.1731387379.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 147581F392
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently a_ops->write_begin/end() helpers are only called by the
following exported functions:
- generic_perform_write()
- generic_cont_expand_simple()
- cont_write_begin()
- page_symlink()

NTFS3 doesn't utilize any of the above functions, thus there is no need to
assign write_begin() nor write_end() call backs in its
address_space_operations structure.

The functions ntfs_write_begin() and ntfs_write_end() are directly
called inside ntfs_extend_initialized_size() only.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/ntfs3/inode.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index be04d2845bb7..6b4a11467c65 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -947,9 +947,6 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	return err;
 }
 
-/*
- * ntfs_write_end - Address_space_operations::write_end.
- */
 int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		   u32 len, u32 copied, struct folio *folio, void *fsdata)
 {
@@ -2092,8 +2089,6 @@ const struct address_space_operations ntfs_aops = {
 	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
 	.writepages	= ntfs_writepages,
-	.write_begin	= ntfs_write_begin,
-	.write_end	= ntfs_write_end,
 	.direct_IO	= ntfs_direct_IO,
 	.bmap		= ntfs_bmap,
 	.dirty_folio	= block_dirty_folio,
-- 
2.47.0


