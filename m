Return-Path: <linux-fsdevel+bounces-63232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203A2BB2F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE960386309
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD572FB995;
	Thu,  2 Oct 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9PS/Xqp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wb635R2e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9PS/Xqp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wb635R2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972C2F6599
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392822; cv=none; b=HUOmpOmOgsc7ayOYmTucF7u7AvZ9GsObYAwx91AJh7hmFAz6nxNxKE35dgZTROv9Gz2pzNnpq41kaVk/u54WCR+q3FqXuRGASeJErMJakPtWOFInUwbTfydqA9hMSFonQakyrGz6bzL2i2ZtfYEsmBdpLUo6FWbtV+3kK4jVm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392822; c=relaxed/simple;
	bh=UsMqyOIhr8WHIm6v1/phOHfCF4/wORmA8WhPGDaHvQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UA6mWhsjqe03jP2qWHox3OjF3WbdFig1plAx624vBPy5yv7Mp9/zy6nrkYvtMRudQGxKLabSp4WyDc+nDKD/y8SWbcnIXrWcEqwURB/t1cugMapLacD0F3x0eS2dgzcmzRQfP7mcWuoqYIrIHYtgsN0A+33DW6/CLcW0pP9GmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9PS/Xqp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wb635R2e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9PS/Xqp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wb635R2e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC67B1FB58;
	Thu,  2 Oct 2025 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=C9PS/XqpRwB0UxviuEwDxPbrPJJwJ4LCFEIURbjaA+NpgyqTtGz+hwws4INrZOffGztQLo
	RkOxRbE8eXXsfP6k95iAXuDJ/jcYphscDhGoO4ln9Pxd2hNG6b2w6x4sOZtqjHhzzZ4yWa
	QJPDA21AAPTieOG4oNDxUAwF5mgXlRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=wb635R2ev6hLEuRvM3mt31zFl9Ysi0h8ox5XgXI+7PDNC7XS+Z+T3UKqB700P93cyUKPEI
	82NFCC28TIfDXIDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="C9PS/Xqp";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wb635R2e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=C9PS/XqpRwB0UxviuEwDxPbrPJJwJ4LCFEIURbjaA+NpgyqTtGz+hwws4INrZOffGztQLo
	RkOxRbE8eXXsfP6k95iAXuDJ/jcYphscDhGoO4ln9Pxd2hNG6b2w6x4sOZtqjHhzzZ4yWa
	QJPDA21AAPTieOG4oNDxUAwF5mgXlRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=wb635R2ev6hLEuRvM3mt31zFl9Ysi0h8ox5XgXI+7PDNC7XS+Z+T3UKqB700P93cyUKPEI
	82NFCC28TIfDXIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2CB21395B;
	Thu,  2 Oct 2025 08:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C2OkKzE03mhoUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 08:13:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C2DBA0A56; Thu,  2 Oct 2025 10:13:37 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	<linux-fsdevel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	Jan Kara <jack@suse.cz>,
	syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com
Subject: [PATCH] dax: fix assertion in dax_iomap_rw()
Date: Thu,  2 Oct 2025 10:13:12 +0200
Message-ID: <20251002081311.10488-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=jack@suse.cz; h=from:subject; bh=UsMqyOIhr8WHIm6v1/phOHfCF4/wORmA8WhPGDaHvQU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBo3jQXQ9++U/Immj1t7Q2t9La2rvw9BDT7qKvX4 aakZ8ucOJGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaN40FwAKCRCcnaoHP2RA 2Z6yCADWOVDY5abLZ6s85kA8oXAY0ON0EFcqsNzUAOxR5+syzjr3MERold2c80b5sRUH/4g7CBV yWqyD8/D+Raml1imo1K7wJcQp94t2xlCRCutADrHW6vmo8Kk7sDNg79sBomyqZvo3FazOzpesvR 5TUe6esMFh2DCYomiSV9UuYL0rEl+q8HyxZ5yar89IpQd89e5btjoC4XZJQJ2vz4mnH3+hX/7R7 XNbs5czy365hJPGwBnr25CN87vcdz5A4ua5c8jhoXwpywav0rpSLGaMryatmtxFlBa8UxoKtzPf Z7YUk6NeBPEmr9VR7U4kMcImAMs7bj9/lPbQtQo7deOOxTLl
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[47680984f2d4969027ea];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BC67B1FB58
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51

dax_iomap_rw() asserts that inode lock is held when reading from it. The
assert triggers on erofs as it indeed doesn't hold any locks in this
case - naturally because there's nothing to race against when the
filesystem is read-only. Check the locking only if the filesystem is
actually writeable.

Reported-by: syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 20ecf652c129..187f8c325744 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1752,7 +1752,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
-	} else {
+	} else if (!IS_RDONLY(iomi.inode)) {
 		lockdep_assert_held(&iomi.inode->i_rwsem);
 	}
 
-- 
2.51.0


