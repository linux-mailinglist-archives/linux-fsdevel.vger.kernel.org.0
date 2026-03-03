Return-Path: <linux-fsdevel+bounces-79144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAQyITS6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DC1ECC8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E11103145590
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FE739D6DB;
	Tue,  3 Mar 2026 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PXNg7w0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yNP3QSG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PXNg7w0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yNP3QSG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22E31B114
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534100; cv=none; b=UUiBdqsoVlMJxS062hYe0GoGbxLal5ErMa+7LGDCC2ACuSCbCR5K8KS+xS7hWN1+gNrS/SIwxRda2oD8iZtIj+ZGQmWBt0/iivTBdhExuAZ9Vd5xJiYL18LV8q3SiI8QYk9HLlV59TZmxdBUJs2i4ebrpL1BavfM0qXA0AnqxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534100; c=relaxed/simple;
	bh=KCb+G0Cj2eFjBT81lEvc82rl7DfHgEwXKgkjHk8fdQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhAYeK11F/0OviNxRmw/34+COMXlT4deR8Fvf49MF1ZLaMrI2XrcrJJqMnafMI21C+9uhmgKmSFxx1ATxAdNuqYABkGxu3d934q7DBrGW4KZqZSesDvxtizO+3pcdtb16JPXA7K8x6QUPwoilGAJOCC3RLFnkjyJ2z/khiI3ego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PXNg7w0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yNP3QSG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PXNg7w0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yNP3QSG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C49A63F8FB;
	Tue,  3 Mar 2026 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZ//apcpVW94xq1ae7enGtSi0L9g8IU352jjMI8FbxM=;
	b=1PXNg7w0sgjA+IeL2N72IePtRMm5Uas8WgRnS0k2/z3q4ipdWBqe9Qoz9n0CCPynjQ0vww
	BnWQlMfCP103VD3e8vSPghoFjE9Qbw2j+XSM8OtzRjjSg0lPtslRs1m0WFFZwBbK0UPEJ5
	MvhoHUC3LT8sHhFeAWSkq5D6fNp2cCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZ//apcpVW94xq1ae7enGtSi0L9g8IU352jjMI8FbxM=;
	b=0yNP3QSGNShW6EPYB08ryvgSD04QbI2sW1aUH/js1sqARP8w4RrZpvtrZG2KLmI2Tnaiz9
	zPqnVKQnHF1usPAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZ//apcpVW94xq1ae7enGtSi0L9g8IU352jjMI8FbxM=;
	b=1PXNg7w0sgjA+IeL2N72IePtRMm5Uas8WgRnS0k2/z3q4ipdWBqe9Qoz9n0CCPynjQ0vww
	BnWQlMfCP103VD3e8vSPghoFjE9Qbw2j+XSM8OtzRjjSg0lPtslRs1m0WFFZwBbK0UPEJ5
	MvhoHUC3LT8sHhFeAWSkq5D6fNp2cCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZ//apcpVW94xq1ae7enGtSi0L9g8IU352jjMI8FbxM=;
	b=0yNP3QSGNShW6EPYB08ryvgSD04QbI2sW1aUH/js1sqARP8w4RrZpvtrZG2KLmI2Tnaiz9
	zPqnVKQnHF1usPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB4BC3EA6F;
	Tue,  3 Mar 2026 10:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hU1ZKUC5pmnNFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 664BBA0AE1; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-ext4@vger.kernel.org>,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-aio@kvack.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 04/32] ext2: Sync and invalidate metadata buffers from ext2_evict_inode()
Date: Tue,  3 Mar 2026 11:33:53 +0100
Message-ID: <20260303103406.4355-36-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=jack@suse.cz; h=from:subject; bh=KCb+G0Cj2eFjBT81lEvc82rl7DfHgEwXKgkjHk8fdQs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkhydADQX+7VdRDW1mPf110GpSWmRUvbEo7O PCx4Adt/5KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5IQAKCRCcnaoHP2RA 2d1YB/99e12GNzLteSvmrAGKqt/jAqRskrgiz6YVLBDDWB8IVAaiVYO+1BBErNEjii3QXmdSryS waEUm0VfTLspBWQfaCGnD5RtXXUwig45Ytn435HFSK1utVdXzW9rpzjyc7QicSQhuoHKs4vEUx8 Pu/fn+n98C+SVI+OVFJG6fMN+rn5Lq2CfmnqjLylhn1/isTHhZ1GKIz9hR4v7mFHzag6/c8aXp/ Op7M8IpIpeZMhIm2PdqjCgdmfxTwOU1dK4uHjK8hgLZ+d/IChSuSvdv3oLrhnyJGYz4fCq66WcM Dg4L1v5FMFlT0+22tylV5dMJJeyIR4j04oq9mgdD02ndUfhK
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 1B6DC1ECC8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79144-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

There are only very few filesystems using generic metadata buffer head
tracking and everybody is paying the overhead. When we remove this
tracking for inode reclaim code .evict will start to see inodes with
metadata buffers attached so write them out and prune them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dbfe9098a124..fb91c61aa6d6 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -94,8 +94,9 @@ void ext2_evict_inode(struct inode * inode)
 		if (inode->i_blocks)
 			ext2_truncate_blocks(inode, 0);
 		ext2_xattr_delete_inode(inode);
+	} else {
+		sync_mapping_buffers(&inode->i_data);
 	}
-
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 
-- 
2.51.0


