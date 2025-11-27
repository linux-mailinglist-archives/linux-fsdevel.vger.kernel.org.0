Return-Path: <linux-fsdevel+bounces-70067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72395C8FB84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62EC14E1976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97B2EF65B;
	Thu, 27 Nov 2025 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="crC7dUYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SdWY+CQu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="crC7dUYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SdWY+CQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B32EF65C
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264681; cv=none; b=KqFHCMuy17k56NKKpdMYTRlacrAbu6IB/DYwqtf68cjj3ZYAVbPAL5tU/su2Zq74Ac3dbUGwQ4U64WN8UdxyK1G3BCrIuYnrRkXfAZ97RW2rxhgp6BHUsPUWvpQL2A6Lu0rcSUdryWGyT5eGXPdBPbgBvkZxtGBFItpP6S66cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264681; c=relaxed/simple;
	bh=IStrUp8qazgIqNvwC5w17P/SdYdt4KGwMivE092Qh3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAvVeyia8W6dAPcVgFT6nSVJ/SGp9Etsf6B0ltoTMvivBQWwQ0W0DHGbO1ModWkiB9IzEIyQ26bYa6t3brc9tWhAGO3rEwKBDRaCOospBYZYG3fs1omQb5jpSn7bjxSCekaxaJLuAzkMhqP8hPiGAcRmpnr5Gr5uoDH3VpXqgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=crC7dUYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SdWY+CQu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=crC7dUYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SdWY+CQu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E08E3369B;
	Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szRQiwkELnAoS0PiAlu3Npp7Vm8um9lGVuY8uzywQl8=;
	b=crC7dUYdDo8GoDWk5JDWwRbtW72HJpZ673nqYRrYB0ZCiukP3bFv2EYGbOiV313bBSjrYD
	Xh1tG/V5shZ1xSAA3xYMvBSIByPQihMsea4obEcogYL2E3ON5H9sifxo/bqwaL7Pc/fgWJ
	3MG7aY9xKIy8fdz4aZH2wXq3fYjo2qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szRQiwkELnAoS0PiAlu3Npp7Vm8um9lGVuY8uzywQl8=;
	b=SdWY+CQubt72voPvxz4YEm9wSbYbquCzcYzsTVMLzl8LoeS3jx256J8Xd+w8uDOQE/BwsP
	8LnmvZu95rQVhlBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=crC7dUYd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SdWY+CQu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szRQiwkELnAoS0PiAlu3Npp7Vm8um9lGVuY8uzywQl8=;
	b=crC7dUYdDo8GoDWk5JDWwRbtW72HJpZ673nqYRrYB0ZCiukP3bFv2EYGbOiV313bBSjrYD
	Xh1tG/V5shZ1xSAA3xYMvBSIByPQihMsea4obEcogYL2E3ON5H9sifxo/bqwaL7Pc/fgWJ
	3MG7aY9xKIy8fdz4aZH2wXq3fYjo2qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szRQiwkELnAoS0PiAlu3Npp7Vm8um9lGVuY8uzywQl8=;
	b=SdWY+CQubt72voPvxz4YEm9wSbYbquCzcYzsTVMLzl8LoeS3jx256J8Xd+w8uDOQE/BwsP
	8LnmvZu95rQVhlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75A123EA6D;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lToaHLKKKGmTPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 60966A0CB2; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 12/13] fanotify: Don't recalculate mask when mark evictable flag changes
Date: Thu, 27 Nov 2025 18:30:19 +0100
Message-ID: <20251127173012.23500-25-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=jack@suse.cz; h=from:subject; bh=IStrUp8qazgIqNvwC5w17P/SdYdt4KGwMivE092Qh3U=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqtvbtHSZuc5dZfyRhpAJLK2AizfcRbOs2L3 qNqtqPLy++JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKrQAKCRCcnaoHP2RA 2SVyB/wOqMDO+vh38tOQ1VAqrvnDI625bvDI1HQLMLAgTJGOGC1+3OuTxzpDfdfuB7T52iTQntb WkgBZM2qZ36S+m3wEd/PRVLVMG4GXh4tM5KSE4B7ptxB+GubODWAcARKGJZfqkl357kkdO0XtQt 1Lqfoq0CmKaCNnOfnOKpkElMEaQ7C5ZJBNy+0S5+CMwgTv6WrSUa3/iFs8P3W8qGfcRCFSU89al 8lvw54UThGci0J+2x4PXl+BdDoD/dBkEYdakgvtAo6pNo9t6iPSt6JdkSBEnH4lupgZxavgZecS vlLH1QU+f9N78TmNmG2IymhtZMdo5gv5gnqR0GkxMDBg8+NA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3E08E3369B

Since connectors no longer hold inode references, there's no need to
call fsnotify_recalc_mask() only because FSNOTIFY_MARK_FLAG_NO_IREF flag
changed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify_user.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b192ee068a7a..2c440ea96521 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1202,9 +1202,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 				       unsigned int fan_flags)
 {
-	bool want_iref = !(fan_flags & FAN_MARK_EVICTABLE);
 	unsigned int ignore = fan_flags & FANOTIFY_MARK_IGNORE_BITS;
-	bool recalc = false;
 
 	/*
 	 * When using FAN_MARK_IGNORE for the first time, mark starts using
@@ -1215,6 +1213,10 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 	if (ignore == FAN_MARK_IGNORE)
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS;
 
+	/* NO_IREF may be removed from a mark, but not added */
+	if (!(fan_flags & FAN_MARK_EVICTABLE))
+		fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
+
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
@@ -1224,21 +1226,10 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
 		if (!(fsn_mark->mask & FS_MODIFY))
-			recalc = true;
+			return true;
 	}
 
-	if (fsn_mark->connector->type != FSNOTIFY_OBJ_TYPE_INODE ||
-	    want_iref == !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
-		return recalc;
-
-	/*
-	 * NO_IREF may be removed from a mark, but not added.
-	 * When removed, fsnotify_recalc_mask() will take the inode ref.
-	 */
-	WARN_ON_ONCE(!want_iref);
-	fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
-
-	return true;
+	return false;
 }
 
 static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-- 
2.51.0


