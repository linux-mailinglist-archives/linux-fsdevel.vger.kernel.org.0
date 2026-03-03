Return-Path: <linux-fsdevel+bounces-79152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIuLO3+6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3A1ECD12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44C51315E23A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B0438836C;
	Tue,  3 Mar 2026 10:35:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622C38836B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534124; cv=none; b=CrxXQzxbV80Nmn2B0tXncnqdZE4R8K+OlYuauosGPh2eVpWNhPn0nTM1iH6H0bopr9q/Ho4CGypG5s7BwdVBGQ6kALfweavBrvo1DuDBMN/vkReZwTgiDTnUeTmGEgFK4p3+L5oEHrgJHF5vyibX6EAChJCrgntpyE2WTqxDVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534124; c=relaxed/simple;
	bh=3fS727Sb8yeAInT3qAHa47xqfXMgVJWE1jEhMxa+cYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJeKJ3gaTIeY/v7kxGwgwVw+NRgzzamlqpB5hruzKOiyrjsMuY7DDW8CbxJcEyuuVX0xivykh0dIDeVyJX68jdZleLY4yisS8MZJxMvqfjFJx25kUtB2cTfNhe77OUOyXZQIwpi4IYakEgkcIjMULsJnbNRX6JnZUrsvMm72+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 418C45BE1F;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36CFE3EA72;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yetfDUW5pmmJFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F1C39A0B6F; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 21/32] bdev: Drop pointless invalidate_mapping_buffers() call
Date: Tue,  3 Mar 2026 11:34:10 +0100
Message-ID: <20260303103406.4355-53-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=jack@suse.cz; h=from:subject; bh=3fS727Sb8yeAInT3qAHa47xqfXMgVJWE1jEhMxa+cYI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkwJU3tlp7qhclMR8b60WNVwl6KQfH0b4J9W fbr3SYqlOSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5MAAKCRCcnaoHP2RA 2YGNB/9OtFONbI9Bdr4PTwp7ci11Ixyrcxo+4xa9vhga1M2zpXPU3KkCu8UO/upLo+dFr9HUlB0 +kKObJC/FbgyeLsW6UWXlC1Fx5tecqMuui+e/tFgBlyJOo7+YR154CW2HAEf9VHdnl0fl4Qfq65 F4452cYAKGDuYhVEXjWGXBo6qZkDfoYrZqnHDzh10/V2JW9Ne5UESOZBB/x2fvraPE2nT7IvDof O45WqMxEA5x//n/dQH4WmLnAcAPPDMhara8Qzn2LfBXQG/SkPUX+dUsTZNPaE1A491y/fjic2a+ Z7GN9AvHjJ7mlTJ2WXHbI33uNIIykKvqRM7BWUbzU6r8l0Da
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
X-Rspamd-Queue-Id: 63B3A1ECD12
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
	TAGGED_FROM(0.00)[bounces-79152-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz,kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.881];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Nobody is calling mark_buffer_dirty_inode() with internal bdev inode and
it doesn't make sense for internal bdev inode to have any metadata
buffer heads. Just drop the pointless invalidate_mapping_buffers() call.

CC: Jens Axboe <axboe@kernel.dk>
CC: linux-block@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index ed022f8c48c7..ad1660b6b324 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -420,7 +420,6 @@ static void init_once(void *data)
 static void bdev_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
-	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
 }
 
-- 
2.51.0


