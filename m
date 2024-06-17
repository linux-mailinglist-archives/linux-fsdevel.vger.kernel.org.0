Return-Path: <linux-fsdevel+bounces-21828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC88090B566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671D31F211CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1F13C660;
	Mon, 17 Jun 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fnUTT+0P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="extEB2/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBD213BAFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638926; cv=none; b=MILeb8NIykeMlPZQAGDo/2g/BOd2LkcW66kFsrWvE2sNE1OkerKXpbNalNthngq05DVtyhOm5KbjUZGYQXoLFPmH6JXFcwuyUDeNLb9ev22QvZXHuRL9EwDS8l3lkQ7Ps4QigpOfz1CnB3zBbmt8kMIkVfjcMiFUBFFyOxFRiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638926; c=relaxed/simple;
	bh=RfgQfL5LXIUDoL/qFXgEgoM8jiMTiLhJ72mXm5gMEBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/6prDWDOzYVlBuk9efEdLi/V7/vlPNOXu4f9tKcKknC6aKExtXlZgJTgfDw490EKC9N+lI1OZPuL7E9g3Ww20GaNEwx+BE+PciEwiXpeIIi9moi1XRctgY43F4ElOuBrO4UrBRPCuBE/xz6hy1aJR6BAlSDlG7Qn8yI8hXDYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fnUTT+0P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=extEB2/G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1371383B7;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718638921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0tObAiDF1uvHjxKzyBFYGOWCeIlG2rs85ONhpLMRkw=;
	b=fnUTT+0PHY/e6DBgmtBWl/6m4eSOvdj2iM6+LuiMNBRL8ofwdzwb00vHXirkFwi46kdS9c
	6ZDOZlUfXtVBkx0yTTZZ6pUD/3Q4dLRkbZSoZXAI6cOjEccGn/cHZ6/5BdP1+Aqv97dnVy
	YOxTPfvytT3yDf/cnPCidV0eW2Ep0tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718638921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0tObAiDF1uvHjxKzyBFYGOWCeIlG2rs85ONhpLMRkw=;
	b=extEB2/GeF2JEOHmmLYvbFNKZ6KmhOF7L3oaQYlcSJjjGve5BgdXSWyfDcOJ9/ebEgqIqX
	fcBwFOziT7eooxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 952B913AAA;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U4bdI0lZcGYicAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 15:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34E50A088A; Mon, 17 Jun 2024 17:42:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com
Subject: [PATCH 1/3] udf: Fix bogus checksum computation in udf_rename()
Date: Mon, 17 Jun 2024 17:41:51 +0200
Message-Id: <20240617154201.29512-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617154024.22295-1-jack@suse.cz>
References: <20240617154024.22295-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=jack@suse.cz; h=from:subject; bh=RfgQfL5LXIUDoL/qFXgEgoM8jiMTiLhJ72mXm5gMEBw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmcFk+M6D44/2X2mQSnUz8ABuCZLf62UCy0K/rCAk2 1fp4hO2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnBZPgAKCRCcnaoHP2RA2RetCA CXbOgDjBJ3+WoSurA+latqveQHHhlvjX0zpwPf8dhIoFX5fxi6n4G/x0uZCPqUhw61h1FZl0CJcjJP f/Ct+0jR+mEgRdjtYIzGXbw5MIFDAhVT1TniVxfF0HH7PV+OP7dY6tViYDnm9WGKMYQc4FOt5gsn1f YHkrYqaBibGsSUWme6c0A5ZE18ef9Hxt2P/5LXo9DtKx1DjoV5WU4oabdLyp+Oq2i9eV4ZEE1lNv4D WdPI8mcSHbl7VWLyl5eoVeIJ8X35ZrBMZLiR/UEWXl9bUvAE7t9x7ui9r34RNF5Mh6qStv6qKbiYoY +txdZ8i9Ty6te7YhVqCte31mXrlGXG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: A1371383B7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[d31185aa54170f7fc1f5]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Syzbot reports uninitialized memory access in udf_rename() when updating
checksum of '..' directory entry of a moved directory. This is indeed
true as we pass on-stack diriter.fi to the udf_update_tag() and because
that has only struct fileIdentDesc included in it and not the impUse or
name fields, the checksumming function is going to checksum random stack
contents beyond the end of the structure. This is actually harmless
because the following udf_fiiter_write_fi() will recompute the checksum
from on-disk buffers where everything is properly included. So all that
is needed is just removing the bogus calculation.

Fixes: e9109a92d2a9 ("udf: Convert udf_rename() to new directory iteration code")
Link: https://lore.kernel.org/all/000000000000cf405f060d8f75a9@google.com/T/
Reported-by: syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1308109fd42d..78a603129dd5 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -876,8 +876,6 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (has_diriter) {
 		diriter.fi.icb.extLocation =
 					cpu_to_lelb(UDF_I(new_dir)->i_location);
-		udf_update_tag((char *)&diriter.fi,
-			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
 	}
-- 
2.35.3


