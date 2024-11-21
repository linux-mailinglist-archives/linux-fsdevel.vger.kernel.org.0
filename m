Return-Path: <linux-fsdevel+bounces-35429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203A9D4BCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2912C285C6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAB71DE3B6;
	Thu, 21 Nov 2024 11:22:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D71D9A7F;
	Thu, 21 Nov 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188154; cv=none; b=IpGKWB1RnEbiMmFKSkVtOwNI9x6qmh4QQR0C6nSas7p+9TL46niBHUTet3db6EAt5K7cv/aIRkhFbZm0SbADrB3fHEgE3TvL+Fqwu+I1zXRwbiWniMPufi9rsBP0j04WsJphANZaNAI/qgs76YqxeB95yhDsr90+ctnS6LMeYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188154; c=relaxed/simple;
	bh=E5gZZHJpn2wRGkkT0qYFfh/nTnOPjXR1qD7ElQ0HULg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATbtOOkX2FFPFNJGnGVnYZj+ZgC0Z0e1vMLfkdPnuM0bXBbuzOy28ObCggXT1SbUP802CC8pN/CB4JSp2x314z2joJFSCkKOICHcJ+g29U8aW5V1KHnMtRqt4gD+2gV064V1IckjAhrYixEP43koump/dO6eMcAPEkgSgngC9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C371B21A08;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B84CD13AC9;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PLv0LPAXP2dLfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57F1BA0931; Thu, 21 Nov 2024 12:22:24 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 18/19] ext4: add pre-content fsnotify hook for DAX faults
Date: Thu, 21 Nov 2024 12:22:17 +0100
Message-Id: <20241121112218.8249-19-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C371B21A08
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

ext4 has its own handling for DAX faults. Add the pre-content fsnotify
hook for this case.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..07946bf67944 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -737,6 +737,9 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 			return VM_FAULT_SIGBUS;
 		}
 	} else {
+		result = filemap_fsnotify_fault(vmf);
+		if (unlikely(result))
+			return result;
 		filemap_invalidate_lock_shared(mapping);
 	}
 	result = dax_iomap_fault(vmf, order, &pfn, &error, &ext4_iomap_ops);
-- 
2.35.3


