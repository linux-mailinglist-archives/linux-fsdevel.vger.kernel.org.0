Return-Path: <linux-fsdevel+bounces-47241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFFCA9AEE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AE3444641
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1E527C17F;
	Thu, 24 Apr 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RkwNrRBz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3pXyl5J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RkwNrRBz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3pXyl5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB3253951
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500989; cv=none; b=F5pNQv3dHqI2uLSft9PXvLNKQGBRK0/QjgrTKKLkEGPP5GoKEze26Tgy/rc2ndXWg29xxl2rTwRe5s0SAXQ+SvhuQpvLJiRofRwr5WLvIuA/ajdEQClDsbBdaW4PElxFiYqxskv3pK53xQASv9WnEQqUMsdtWF+UhULK6oUFMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500989; c=relaxed/simple;
	bh=Q4C0nklljmfff9/O/8ahYFLmFMpMGaA5LMuM0i+Vjt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=by2knuGE9/yeXY3RBZuuw+/i4o+1+hdNkiCmCdL39eMDULreCLkOBdqdIGBiGwsVtJnWNhKCu6YhWEYZHt3/EoGWjJF2Yo2IKGqbeYqOiC2Lb6TGNQx47dw9vQiYmQkTIhGa523rRbb+3YF2j5OZZwOqmTXXCNWpr2hJE4l3xTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RkwNrRBz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3pXyl5J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RkwNrRBz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3pXyl5J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 248F51F445;
	Thu, 24 Apr 2025 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745500986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+ZNaGPKekffWz15E9n8rjartlWAV6WOm68U86VGHHqk=;
	b=RkwNrRBzuAqj9MpIayc2OmLsLSIDGLMy1nJO/+EO8B4f+LLDCNZJF+Ej1qusL2LrfOscXE
	1umvOWI2bxeYgVLmQqCzRGRiGJMs8xwsVvqLXACfEYBQphadC+s4ixTTY1zP9zxrERhRrv
	0ZX9JlKhLfI8w8BhllHGpDFfH7qrayE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745500986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+ZNaGPKekffWz15E9n8rjartlWAV6WOm68U86VGHHqk=;
	b=p3pXyl5JFpEY7Wi1jUlFcJqFH9WHj0ImSN7urp/ehbTU5w5PnPniIqDyQ25LsKnDl93L5l
	xek6bmAHNjw4BpDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RkwNrRBz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p3pXyl5J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745500986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+ZNaGPKekffWz15E9n8rjartlWAV6WOm68U86VGHHqk=;
	b=RkwNrRBzuAqj9MpIayc2OmLsLSIDGLMy1nJO/+EO8B4f+LLDCNZJF+Ej1qusL2LrfOscXE
	1umvOWI2bxeYgVLmQqCzRGRiGJMs8xwsVvqLXACfEYBQphadC+s4ixTTY1zP9zxrERhRrv
	0ZX9JlKhLfI8w8BhllHGpDFfH7qrayE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745500986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+ZNaGPKekffWz15E9n8rjartlWAV6WOm68U86VGHHqk=;
	b=p3pXyl5JFpEY7Wi1jUlFcJqFH9WHj0ImSN7urp/ehbTU5w5PnPniIqDyQ25LsKnDl93L5l
	xek6bmAHNjw4BpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19A911393C;
	Thu, 24 Apr 2025 13:23:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rP8+Bjo7CmiLXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Apr 2025 13:23:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE7E2A0921; Thu, 24 Apr 2025 15:23:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)
Date: Thu, 24 Apr 2025 15:22:47 +0200
Message-ID: <20250424132246.16822-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=jack@suse.cz; h=from:subject; bh=Q4C0nklljmfff9/O/8ahYFLmFMpMGaA5LMuM0i+Vjt4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBoCjsmRRQYHvXApqzyrAvyYX58+Fk95ryBF6Sf77mE vOmpekWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaAo7JgAKCRCcnaoHP2RA2SmfCA C6HbDwjJaUdnO7hzo1L6uAvyDuhh5qhbNjtLPh474UnB6fwAwy8BhtZDe7yFLVAihLUdP0VasfNoUL hHP8nBUGfh/g6MUf2SyvOQLgM+6NX3YVWbAnNzhLdQDJsrpVG5wYubXYw9NAZ39pHIZ01WwsO9OyrN pUcSwncXA+SKFFhcx/P7Sv8nYiZHlvCCvFk6sfKzBIxq3QcPtCBQeCd7jeQVs8qfmebs0VZJ76XqZd wV3oWLmHjexwQ0vIcpnALl7S2Uju2cY4Y/JGgUMH2IchraRnANnZZvWqvvu8pPoIu5GBj0QQIQyyBb AFuDpIgWbbCsOT/dqmeCGFNI5xsc+k
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 248F51F445
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
fail with -EBADF error instead of operating on CWD. Fix it.

Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 02bee149ad96..fabb2a04501e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
 		return error;
 
 	filename = getname_maybe_null(pathname, at_flags);
-	if (!filename) {
+	if (!filename && dfd >= 0) {
 		CLASS(fd, f)(dfd);
 		if (fd_empty(f))
 			error = -EBADF;
@@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 		return error;
 
 	filename = getname_maybe_null(pathname, at_flags);
-	if (!filename) {
+	if (!filename && dfd >= 0) {
 		CLASS(fd, f)(dfd);
 		if (fd_empty(f))
 			return -EBADF;
-- 
2.43.0


