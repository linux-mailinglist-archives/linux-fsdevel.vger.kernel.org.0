Return-Path: <linux-fsdevel+bounces-77196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZAv4D0QEkGmTVAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 06:12:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97613B1E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 06:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87407300D737
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC526F29C;
	Sat, 14 Feb 2026 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPzMQaql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423726299
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771045948; cv=none; b=UOnCpkIulczCpCpII1NsgkIMfrA4YTdwwlCk47yN1s9op467/PoiEMp87vtBdAIuBRCGrv01rAWP/D4/AcHGgOHQ3RdEJ1vDP/Ti791gcParCuvsL7q5hb4UWTNms5ethsN84VqWBXnYDWktGJdyrpXfrefaSoo4RB6Qr70V/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771045948; c=relaxed/simple;
	bh=c5FZzUr/2ICzVwIam9S8bFm9T18YPvzFzAfQVxO9i3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNGsfz+EmGZkQvI0FQwqjZdGaz7PTzYqnWUadiEpIxx3mrERZuE4ZXmZtMe1UWAQxAm5oe8/6GbZuyKik2w1P5cs+FInn3x2vkcM1cPpfw2FJdKur3TgaYbMoYWteR9xBDf6deM7UWuxjJIrbCOZdki2QRQuRT28fpV+fWLMFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPzMQaql; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b785801c93so4089018eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 21:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771045947; x=1771650747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJlo6ZHS+DF3FK21d4n+fFU9ryiXMtXmskbuyWVSY5g=;
        b=PPzMQaql5wYDpVFtcLXDZTVnnup2VVP6PWl/SWjar6RWjs+PyKabih82fUEz8CRwKP
         J5sVSGx4bVew8qOS1oYjnd8Zp3Ut6MWmTamItMjaD7ige0TFWQ04ae2lOYASZ/kcc6Dj
         ttjgmKv0dHLP7wUVZRXBAb/tr6RbP+wTsXC9A8Z9/XZIIejAkkJQ37hJv4s5OYg0WF2E
         7EawFpgxu1wfcwFEVY1TIv+/Y88C0KtJlTgUXZYM7+6QVa2O4CXlrYn9bAdv3YoRyLSD
         fzOfZ6qTzlsrmzJdR5eCz15WJXIQOVTU6uE2XoWWVfrthjSGwTjwi0n3cNS2u2HjOLd0
         wcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771045947; x=1771650747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJlo6ZHS+DF3FK21d4n+fFU9ryiXMtXmskbuyWVSY5g=;
        b=ZYAdUc1jlDEb3fMotQxL440ELjw4WXG3Yh8tVLtSu4p9J+KpK861+72SYYVwIdqQye
         0WS8Oq9OhNUmxxydxqnX+gHMU1FIF2/YnLgmBoyiQOwMkxc2xKsNRMlnAfanXOzM2n/t
         tvZI9n34oaebJe5kn8zGyPeRwkrA7tQglKKyXY9lHKLVA2dKtTUWyXKuEiDFKIao4ccz
         FBOeDsBpb97dRErV2CHz2vIhlJwStA+xxbb5J7Xjh/uj+MESCsWg4+tglSajdkSQInht
         HsSk+utAYOUB8ALah+RDvKkWooRgO+DPn+uFwN6f4OVKW3bgom+cSC7ywLzoJEtee0r5
         AqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHG7WZNE7ByACxJRc8fGMC583h/KkIHDjXoTv/uU3Y8yOCTXNKcAgm/KBoWLFNfciOfTZ/GDN0ah+25iiU@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNfbyuzX5pjOS32MRVFQlQ85zarSktG31VNN64mvSwsDXKw+r
	HNPic158WIU7alPRn8J80ulOEDuYYXoFs+9Og5tUi0gfU9RevRkxGJ3Q
X-Gm-Gg: AZuq6aIK7D2KvVXs1ySpVNBUDWR6T3ZsY5FbCUVnsJx/CrydVOsHTo35acdxrwQ16PW
	MKAA4DlzfXj3XBqJx5ZozZVC5yVTCphUe88Cs1leYaXz4WK5/yF4aHeJ5BSpauzA7CLBf/L4wPV
	oCeC/x5c1vakZ57gSJAQqSiOXfTfRWSiOtEOTSLl1a9tQyUXPNcTFD/cnW71WIN4pzMf9pPDMjX
	lHXlg1vAS9DGZ8oG7eDmTjCOSM0u0gO+tsf1qFb3gv8rD5vuUqi2FTp/WVE6xAfmD2QbZKGzzYB
	RYwdUzXV9v7Ie3wsEEHnM8WU+O9gz33UtcS7vHzy7iRu4bMXgjRAxCeIaEnXjxbbswc8MaweFmp
	MYHWUwvBPIh0+fyJBDtDyr2BfH6W96/zNo8Hm60CJfxKwnEu31hdhUSej7TiQsER5nA8HD3hHhn
	iwAW9hPlt+SrlemzlRAUi8J0Gd96XFTqSYQN4IyEIFDQoWocgINCI3QKROjiSJPD/6AahW5nIsu
	4+w+uEPmpL2tHKFgiqpQcfwOjAZZzUf/Q==
X-Received: by 2002:a05:7301:608f:b0:2ba:8ae0:8576 with SMTP id 5a478bee46e88-2bac932ca42mr697972eec.3.1771045946570;
        Fri, 13 Feb 2026 21:12:26 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb5439c6sm1155600eec.6.2026.02.13.21.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 21:12:26 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()
Date: Sat, 14 Feb 2026 13:12:17 +0800
Message-ID: <20260214051217.1381363-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77196-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E97613B1E4
X-Rspamd-Action: no action

fsnotify_recalc_mask() expects a plain struct fsnotify_mark_connector *,
but inode->i_fsnotify_marks is an __rcu pointer.  Use fsn_mark->connector
instead to avoid sparse "different address spaces" warnings.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index b372fb2c56bd..9a5f2af94659 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -573,7 +573,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 
 		/* update the inode with this new fsn_mark */
 		if (dropped || do_inode)
-			fsnotify_recalc_mask(inode->i_fsnotify_marks);
+			fsnotify_recalc_mask(fsn_mark->connector);
 
 	}
 
-- 
2.43.0


