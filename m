Return-Path: <linux-fsdevel+bounces-8591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC3839296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA34BB2425E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44060255;
	Tue, 23 Jan 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GI0xtpY4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4tISDxo2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GI0xtpY4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4tISDxo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12345FDB2;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023529; cv=none; b=RHCt8Zfj4a999GzxJ+V8v2YDksQ2KNh/aPMcnup+Qg4ElXfjJtGHI1/Z0fV2iS5hbIx/L0lOL2MZ/CCH3dgc1ZXHrLRUB1tpAX26Kf7/0ijbDJ1+oYYpsKZs+k8M8r8szHV5ySltNfEt/r6hiOW2RPc+mQ9XHOd4mne+8JmzXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023529; c=relaxed/simple;
	bh=J6batrQ0krqqS6Fk9nHO3yuHQO2UEbFRTqBXwfpdoQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGoFIe60EULyyHGLiF944nNF6XWU2yEiBgye1GkO0Q0zXnuorI/xtHSgjHeNJrbDgz9n+kbNlXiV0Dw5wl2FTChVrWzw+xOMB/LQJWFeE0noX3w//HzQ1GsGD4C7s0zUSslVhqNIwdAPURdA0RoiK9RGLuJr+AA+l6UYwZvDHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GI0xtpY4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4tISDxo2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GI0xtpY4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4tISDxo2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 080D2222C8;
	Tue, 23 Jan 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3YN/c637qj7Lt2r37Dh2rIefGzzIThCgolWTCRWesc=;
	b=GI0xtpY4Y3YSUiVHFPylw9enuHjR7fVot1pMtCCOkSqgNGi89ooC1hf7cga7gQ5UN8o8uy
	8A8WuIFH3CjZmWcbNgz+t0cZcDdxpZIuzz5XLxSp0HnBSmZPWk+8o0Fzys6hABorLBS324
	enMFxxewvtU6GEkmTnQOxVaY/VwcLdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3YN/c637qj7Lt2r37Dh2rIefGzzIThCgolWTCRWesc=;
	b=4tISDxo2eJTyuLrJ/2fuBbjo9dqAKx9IouOLufi7YivppdXuxtkd6+JXZLUGeR1xsOMVm2
	4RHJpGedBzd4ICBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3YN/c637qj7Lt2r37Dh2rIefGzzIThCgolWTCRWesc=;
	b=GI0xtpY4Y3YSUiVHFPylw9enuHjR7fVot1pMtCCOkSqgNGi89ooC1hf7cga7gQ5UN8o8uy
	8A8WuIFH3CjZmWcbNgz+t0cZcDdxpZIuzz5XLxSp0HnBSmZPWk+8o0Fzys6hABorLBS324
	enMFxxewvtU6GEkmTnQOxVaY/VwcLdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3YN/c637qj7Lt2r37Dh2rIefGzzIThCgolWTCRWesc=;
	b=4tISDxo2eJTyuLrJ/2fuBbjo9dqAKx9IouOLufi7YivppdXuxtkd6+JXZLUGeR1xsOMVm2
	4RHJpGedBzd4ICBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA867139B1;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aS9FOWXar2WndQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03C6CA080A; Tue, 23 Jan 2024 16:25:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6/9] ext2: Drop GFP_NOFS use in ext2_get_blocks()
Date: Tue, 23 Jan 2024 16:25:05 +0100
Message-Id: <20240123152520.4294-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=jack@suse.cz; h=from:subject; bh=J6batrQ0krqqS6Fk9nHO3yuHQO2UEbFRTqBXwfpdoQM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pRcAJhWL9Yd1B4ryk1zgZ4/OuDFJah29KjD0Cj uWQkta+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aUQAKCRCcnaoHP2RA2S6WB/ 43NolxDby68EdfJk2yQZP275rtgSk3436SdWfUGLBYfUUGB7qnisVVtoevyP44Coj5wdy1pK7/uXbg raIXQ86LfHK0v6qxBcC/uxbpzxVA1pFxRs7jVGPjskRQREh4TBYPvIwMjAxIw5MgilCZndCbGW4Why 5g1sv2L8vTwq8mGzua+Kn3nERCC8tNzILv93SxlFpZ5iM2Yl0f9oJgvF40ILhJXRd8NjmY/NA9dH3H PUTO7XHC2DgFTmyjLosUDSEEuQegfA93hcMYCsSpOTWdRF+PSxtraj85ZscPAO84M8FzXpMFAuT03v ZYqQmbPLtm1kWkQvkP25M9uPq5N+8a
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.21%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

ext2_get_blocks() calls sb_issue_zeroout() with GFP_NOFS flag. However
the call is performed under inode->i_rwsem and
EXT2_I(inode)->i_truncate_mutex neither of which is acquired during
direct fs reclaim. So it is safe to change the gfp mask to GFP_KERNEL.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 5a4272b2c6b0..f3d570a9302b 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -754,7 +754,7 @@ static int ext2_get_blocks(struct inode *inode,
 		 */
 		err = sb_issue_zeroout(inode->i_sb,
 				le32_to_cpu(chain[depth-1].key), count,
-				GFP_NOFS);
+				GFP_KERNEL);
 		if (err) {
 			mutex_unlock(&ei->truncate_mutex);
 			goto cleanup;
-- 
2.35.3


