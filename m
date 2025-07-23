Return-Path: <linux-fsdevel+bounces-55833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27EEB0F3E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27323BAA58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AEE2E8885;
	Wed, 23 Jul 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0o600WTr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ICV017V2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0o600WTr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ICV017V2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97362E8880
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276936; cv=none; b=g7Mbnzba6AXbIOvN+Ylz1YDa62O/HbNsZBTp9Pf3xKJIcAvu7nKLHUWlwvp08jqnFQosQ+HmpZwcMccgKAd+v157iPXOs74SQWGqo7qm2MpAAAxaAfom0WQNlyAjp4ialfKEB69fjcrzNlJntTk14Sf7WOJtsjcq1JFfyGtEPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276936; c=relaxed/simple;
	bh=5zU8ZAr3SMvfuaM+8iY14N48D84esM2zsmKZnYPnEqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXbeJki57lpTSobrBPAdZluGvSCT5rZzgk1lReiHQcFy97iEv0FNBEO4sBq3EpzhWawpKuT2Fbuz5XHNRKtvLAwta1/yQhvD8JZ2EWZK6yb2ByH9JuLSTyk2gNGY6jDcZJAQToCiNHDH0Pk7jtv76Y81Yq0tXZ8LvWfgiPJn/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0o600WTr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ICV017V2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0o600WTr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ICV017V2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9216E218F2;
	Wed, 23 Jul 2025 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753276922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHb1UmULRkWstV5P4nMj+VxLK8zD/76FhrbXgXNQRUo=;
	b=0o600WTrhF7mqytOXsBYYI4hbogQkBaLYNkZh6yOhsRu0dzDfoThI2SzfeB1U184ufHj8G
	7GbA+URz2VZXrHtSTbT36riHJWUSWhwFuAmShP1d5xNX71G6iq7hOCDBFGO9KRvcSbAe6q
	9ZGwqoxN2M84b5EyhaTDeV/EBfiNu3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753276922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHb1UmULRkWstV5P4nMj+VxLK8zD/76FhrbXgXNQRUo=;
	b=ICV017V2+baXLLVaiY3mCil8ZmvkRtv3ETatf8BEsf8sZlpYy3ZZ3dz1BSSQSvJ5PPNrGf
	4TzUZ+D2SO5FhHBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753276922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHb1UmULRkWstV5P4nMj+VxLK8zD/76FhrbXgXNQRUo=;
	b=0o600WTrhF7mqytOXsBYYI4hbogQkBaLYNkZh6yOhsRu0dzDfoThI2SzfeB1U184ufHj8G
	7GbA+URz2VZXrHtSTbT36riHJWUSWhwFuAmShP1d5xNX71G6iq7hOCDBFGO9KRvcSbAe6q
	9ZGwqoxN2M84b5EyhaTDeV/EBfiNu3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753276922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHb1UmULRkWstV5P4nMj+VxLK8zD/76FhrbXgXNQRUo=;
	b=ICV017V2+baXLLVaiY3mCil8ZmvkRtv3ETatf8BEsf8sZlpYy3ZZ3dz1BSSQSvJ5PPNrGf
	4TzUZ+D2SO5FhHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC85813302;
	Wed, 23 Jul 2025 13:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJ1lNvnhgGhnHwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 23 Jul 2025 13:22:01 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 3/3] docs/vfs: Remove mentions to the old mount API helpers
Date: Wed, 23 Jul 2025 14:21:56 +0100
Message-ID: <20250723132156.225410-4-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723132156.225410-1-pfalcato@suse.de>
References: <20250723132156.225410-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLw5gink3swc9hgcaooqib9oj6)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Now that mount_bdev(), mount_nodev() and mount_single() have all been
removed, remove mentions to them in vfs.rst.

While we're at it, redirect people looking for mount API docs to
mount_api.rst (which documents the newer API).

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 Documentation/filesystems/vfs.rst | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 94eba21265a1..af06144cf0fe 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -209,31 +209,8 @@ method fills in is the "s_op" field.  This is a pointer to a "struct
 super_operations" which describes the next level of the filesystem
 implementation.
 
-Usually, a filesystem uses one of the generic mount() implementations
-and provides a fill_super() callback instead.  The generic variants are:
-
-``mount_bdev``
-	mount a filesystem residing on a block device
-
-``mount_nodev``
-	mount a filesystem that is not backed by a device
-
-``mount_single``
-	mount a filesystem which shares the instance between all mounts
-
-A fill_super() callback implementation has the following arguments:
-
-``struct super_block *sb``
-	the superblock structure.  The callback must initialize this
-	properly.
-
-``void *data``
-	arbitrary mount options, usually comes as an ASCII string (see
-	"Mount Options" section)
-
-``int silent``
-	whether or not to be silent on error
-
+For more information on mounting (and the new mount API), see
+Documentation/filesystems/mount_api.rst.
 
 The Superblock Object
 =====================
-- 
2.50.1


