Return-Path: <linux-fsdevel+bounces-70063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B976C8FB46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64E83AD59B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F12ECE97;
	Thu, 27 Nov 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WpWp76hQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Kz3nxoa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WpWp76hQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Kz3nxoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E5287507
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264659; cv=none; b=BEQbZhrR+WQPRGMqOwVT6BRodddS5rakHueUDRaeGfNWFXADZ3hk6pkPQ0TWstUeWnJLJqjf1G3vd3Wxi+KYKNDQvds2GDYAkYKAT2mqu/o0PDXIlCAlrUcsURswpwQ6NE56yJEJJHvgvhAFS69q4daysFC5h6fiv2+a9eMHJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264659; c=relaxed/simple;
	bh=X4NWgFtOIvp2uHb2TgY3siNxZxayZ/zZxVMvGru9Vks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I98VcWxdcOoUydhfNWv/b/FsgDGKbFBFVDTXWW2ob50N2A91u04PPrd/iCc3/zEVqN5FChODCR+R3HUGXemUmLx9l0lQ/5QxURkfXhqgQcAK828R/Jgrz4BK16oba20fe+CGpHFpIhdeSgPZDn9vHdZEMfZq5C3HOvKT68hMBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WpWp76hQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Kz3nxoa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WpWp76hQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Kz3nxoa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F10C5BCD0;
	Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOZyRanqlwYR4BgD1WYBmsRdXMs8P+sQZtJszx4jUAg=;
	b=WpWp76hQcxG8qgmBH6Ht0WUbgUYHbR5q8T2Dd26Jndt5QcnniZ+N81x48GXuS2IKzMXyYP
	tlaPTdIvSYd9O5vOWnyCPyUekTkuJgkM/NvUw0TJLtHJSi848pdOgBOwJBLxQHz1PF8B+r
	nEjMcRcmK8BEaFimteS9Ays5AsZXMi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOZyRanqlwYR4BgD1WYBmsRdXMs8P+sQZtJszx4jUAg=;
	b=8Kz3nxoa2DSCZNPdy2Bz/fKebnZFbLMhwf3TwM4WI5BhzFCbKVm9U3WxaD2scJc3cDdeZT
	Yiy1pV0QD9CLsMBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOZyRanqlwYR4BgD1WYBmsRdXMs8P+sQZtJszx4jUAg=;
	b=WpWp76hQcxG8qgmBH6Ht0WUbgUYHbR5q8T2Dd26Jndt5QcnniZ+N81x48GXuS2IKzMXyYP
	tlaPTdIvSYd9O5vOWnyCPyUekTkuJgkM/NvUw0TJLtHJSi848pdOgBOwJBLxQHz1PF8B+r
	nEjMcRcmK8BEaFimteS9Ays5AsZXMi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOZyRanqlwYR4BgD1WYBmsRdXMs8P+sQZtJszx4jUAg=;
	b=8Kz3nxoa2DSCZNPdy2Bz/fKebnZFbLMhwf3TwM4WI5BhzFCbKVm9U3WxaD2scJc3cDdeZT
	Yiy1pV0QD9CLsMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D0623EA6F;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cT49HrKKKGmYPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58CD7A0CB1; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 11/13] fsnotify: Drop fsnotify_{get,put}_sb_watched_objects()
Date: Thu, 27 Nov 2025 18:30:18 +0100
Message-ID: <20251127173012.23500-24-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=jack@suse.cz; h=from:subject; bh=X4NWgFtOIvp2uHb2TgY3siNxZxayZ/zZxVMvGru9Vks=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqt/wRMs+snztK6i2rUVZJv9eKTlN2TNKauR 9XUnRut4aGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKrQAKCRCcnaoHP2RA 2eWHB/sHr0Y2IYdhW0qDsqV8ZbWQDWGMRvv7hkhXtGD6yTMlNDmJJ0i3+5oJknzu8TH87hbo2iV 4Zt+4mRjReVJuBQnrYjlM7TkBJpNI+0COgr1HxVwWGu6BkuMLdgf9bshGhGMqsRusn4+w2kDYMv sD7oT7s5Atph+c+/gTFEipGr9f1XA+poJsJ0YX8zqQAWjihgPz9FxfVlT/TGIj3cjV8hL3+0E2g 7Aqp6Y6QwO8dGY2M/EBpdodMRmjfF3Na8YmpxyXnC+lgZFQJw1+4XvfPGeC113dQhCvSuuq8W1T 7r7CLwUxD7gm3JyT3k+gjggLIo9x3UsMli9ZexJ/KVXBPd6D
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

These are used only in a single place now. Inline them to the call site.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/mark.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c01c38244f30..c9b5ca198f3b 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -138,16 +138,6 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
 	return READ_ONCE(*fsnotify_conn_mask_p(conn));
 }
 
-static void fsnotify_get_sb_watched_objects(struct fsnotify_sb_info *sbinfo)
-{
-	atomic_long_inc(&sbinfo->watched_objects[0]);
-}
-
-static void fsnotify_put_sb_watched_objects(struct fsnotify_sb_info *sbinfo)
-{
-	atomic_long_dec(&sbinfo->watched_objects[0]);
-}
-
 /*
  * Grab or drop watched objects reference depending on whether the connector
  * is attached and has any marks attached.
@@ -183,10 +173,10 @@ static void fsnotify_update_sb_watchers(struct fsnotify_mark_connector *conn)
 	BUILD_BUG_ON(FSNOTIFY_PRIO_NORMAL != 0);
 	if (first_mark && !is_watched) {
 		conn->flags |= FSNOTIFY_CONN_FLAG_IS_WATCHED;
-		fsnotify_get_sb_watched_objects(sbinfo);
+		atomic_long_inc(&sbinfo->watched_objects[0]);
 	} else if (!first_mark && is_watched) {
 		conn->flags &= ~FSNOTIFY_CONN_FLAG_IS_WATCHED;
-		fsnotify_put_sb_watched_objects(sbinfo);
+		atomic_long_dec(&sbinfo->watched_objects[0]);
 	}
 }
 
-- 
2.51.0


