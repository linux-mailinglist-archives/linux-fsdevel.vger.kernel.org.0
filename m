Return-Path: <linux-fsdevel+bounces-5295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CC3809AFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 05:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2C01F21128
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FB63B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kxEJzfw8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bvOOsRMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE261721;
	Thu,  7 Dec 2023 19:30:57 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5E20220FA;
	Fri,  8 Dec 2023 03:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702006255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDQYdne0DAzlGGGJZTNP/1WiB4ya0IEng6FXcLsrx3E=;
	b=kxEJzfw852I1pebVZpIvOZFm58YLyLf03hOuU+L5jy6BWRJK2dLEt3c9KZOrIcD2QX8FId
	VIr2VJxQAI6Q0j/JUVEroHwadNpO8y4TomUtw9vCg0ID/Edcbi0rCakZ2m0u3iI5d8pB/p
	DCdcyOgiklrgEguWBs0U9sOygeLf6tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702006255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDQYdne0DAzlGGGJZTNP/1WiB4ya0IEng6FXcLsrx3E=;
	b=bvOOsRMbaJQU2pYYXCg57Ki+nRANJ2GKR5gsoIHILcCMYq6reMSFF1EPSTsS/C/CVuMLV4
	02nKP3nMq0U1reAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FADB1375D;
	Fri,  8 Dec 2023 03:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WRj9AeuNcmUcMQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 08 Dec 2023 03:30:51 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] VFS: don't export flush_delayed_fput().
Date: Fri,  8 Dec 2023 14:27:28 +1100
Message-ID: <20231208033006.5546-4-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208033006.5546-1-neilb@suse.de>
References: <20231208033006.5546-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 4.90

There are no more users of flush_delayed_fput().
Modules shouldn't need it.  __fput_sync() is a better approach
for any code which might benefit from flush_delayed_fput()

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/file_table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..de9155f82d4a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -436,7 +436,6 @@ void flush_delayed_fput(void)
 {
 	delayed_fput(NULL);
 }
-EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-- 
2.43.0


