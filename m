Return-Path: <linux-fsdevel+bounces-79145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABC7ETK6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1161ECC7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B97553144965
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182CA39D6D9;
	Tue,  3 Mar 2026 10:35:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB839A04F
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534100; cv=none; b=ndBnKy4BXBwP7SyVs+IqkC/n26YNVTTooo+/Xy1R0HZTjI17/OXnvOu9Da/mVr083fmzrzHTNS2vUj/slFbWdIIIh8/Zfz/Dru/fhHsdmFglT4/HArCGffkk2quuX4WaWod482ChHH/Km0pPEBWtU6dju2TtuRCGgKWn9GSqXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534100; c=relaxed/simple;
	bh=NDPLTZYpyB8AvjWnfTi4NCpTDfiFBgirFbbT2/Tf5G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzOeYQtIdDTp/M0YnNLFAr2IMMol2Jzdj5L8HJ8lvZj4ILGU1k+aDLtjsI+6qvM0KDcgHwFMQwPwe9395lDXmrdoCwsIr7a3Xb7BPNN5YDCdefpgJGUpT+Mvxrpt8XmTc8fPvmvSpxs0+8px5iXiV+HgazPgKZDroVT2EeJvurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0350F5BE05;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E95B63EA6F;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PDP4OES5pmltFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 88128A0B3A; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 08/32] affs: Sync and invalidate metadata buffers from affs_evict_inode()
Date: Tue,  3 Mar 2026 11:33:57 +0100
Message-ID: <20260303103406.4355-40-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; i=jack@suse.cz; h=from:subject; bh=NDPLTZYpyB8AvjWnfTi4NCpTDfiFBgirFbbT2/Tf5G4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkk8HckfhJ1pkI9JwuC2AULW5aPa2lEuXAbV pQDis2S6F+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5JAAKCRCcnaoHP2RA 2VFcB/41q8HZKDIyAi9JxfZV2iGf/oWzNNQqiIJu/TgJ83dhPE9JdflB+QrDuZ5WfWU2+g6BnDd 6TbFhNQ7N/GBBAW7OF8mCHQ3CwOAQf+zGJF4sm87/0Um7Cn/fpIOecJsKuVVQZrn7h4roCLAj/b J9WZceJCnZUkZoWPbl6JWLzlCtCnhCVDfHBinSApEgSuDp7g08pLQ+GLT5e+71QrF8saJqnQo5p oUJurV3B9ZeYu3k5S3HIB3JuuoPuuXCwEstfzcII5Fjo5kh+t+jb0bOPZjY0U/c9Wj3DtTung41 IQFDRdiyX/bQtHRK/mcCv1Q2ScIF+tm3tT/3K7+DEDeEsd0z
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 9C1161ECC7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79145-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.871];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

There are only very few filesystems using generic metadata buffer head
tracking and everybody is paying the overhead. When we remove this
tracking for inode reclaim code .evict will start to see inodes with
metadata buffers attached so write them out and prune them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/affs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 0bfc7d151dcd..84afa862f220 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -267,6 +267,8 @@ affs_evict_inode(struct inode *inode)
 	if (!inode->i_nlink) {
 		inode->i_size = 0;
 		affs_truncate(inode);
+	} else {
+		sync_mapping_buffers(&inode->i_data);
 	}
 
 	invalidate_inode_buffers(inode);
-- 
2.51.0


