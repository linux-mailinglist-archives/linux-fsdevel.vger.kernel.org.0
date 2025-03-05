Return-Path: <linux-fsdevel+bounces-43261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0875A50048
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 14:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606E418976F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CD2451C3;
	Wed,  5 Mar 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ooxJ5UcG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hG8pPwXk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ooxJ5UcG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hG8pPwXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645524BBEA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180460; cv=none; b=Mj9L7APWrSTxrNmIvKtMeCWS7kau+0Y2O7OqCfWPQX2lzxRcp9Mlzuvjsc/osH66Yhrd+IZFS9audq+vLyNgS67qJZzEMk5uI8S6zjgwI30Pvvvw2/8ngJzcUWGUYFyA3e/CmN45yALA7baKZfDWKrz+/ZAmdzGbns1KUr8MqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180460; c=relaxed/simple;
	bh=OUe2ZfcLEwB8/VE/VtXUnjkNexrrI2jz35WE5bV1aec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6yNZcusNrWl4KRD1PYokUhZL1BgbiAX30CcVzUozpxnLSMTSPc9JJp1tQpGB+v15VVrV1yWHZeoz538ZW5dtfdX5X/LFyTkwgKae3eEB+5knjrpHGmya14xH3YUpIy7etQTyKFsK5bk8nKE1ZgFGuC1K0zZeA6yQaar10IY1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ooxJ5UcG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hG8pPwXk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ooxJ5UcG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hG8pPwXk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0523821196;
	Wed,  5 Mar 2025 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741180457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhrj4+UIic3dv1naYQIR2WZ2yJVEkVJ2hFkZP6Dp8Bk=;
	b=ooxJ5UcGtdmF1ntzeoy04uRP+0L9nar9OH6v86SNDWZghqbtaP8Q7no6MMgdH7kJCF7KTo
	xuWkiuikjQfOygTMgTxcZ1Xef7DD+SpCuxgUdEZCeB34DIugD/Q7r2rLSDtn8soAuHvzJb
	IwJLJAzcQ45ghp0lvmCIyvIfDDyaSS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741180457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhrj4+UIic3dv1naYQIR2WZ2yJVEkVJ2hFkZP6Dp8Bk=;
	b=hG8pPwXks4ggclGh09cdGu+G0CECPd8qSzE+TSgldDTLmlp1t5V6gACF/eF6LSZ/7/98hw
	+SOTXx3Oca/n6zAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ooxJ5UcG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hG8pPwXk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741180457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhrj4+UIic3dv1naYQIR2WZ2yJVEkVJ2hFkZP6Dp8Bk=;
	b=ooxJ5UcGtdmF1ntzeoy04uRP+0L9nar9OH6v86SNDWZghqbtaP8Q7no6MMgdH7kJCF7KTo
	xuWkiuikjQfOygTMgTxcZ1Xef7DD+SpCuxgUdEZCeB34DIugD/Q7r2rLSDtn8soAuHvzJb
	IwJLJAzcQ45ghp0lvmCIyvIfDDyaSS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741180457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhrj4+UIic3dv1naYQIR2WZ2yJVEkVJ2hFkZP6Dp8Bk=;
	b=hG8pPwXks4ggclGh09cdGu+G0CECPd8qSzE+TSgldDTLmlp1t5V6gACF/eF6LSZ/7/98hw
	+SOTXx3Oca/n6zAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A908813939;
	Wed,  5 Mar 2025 13:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WIAZFyZOyGebOAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 05 Mar 2025 13:14:14 +0000
From: David Disseldorp <ddiss@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>,
	kernel test robot <lkp@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] initramfs_test: flag kunit_case __refdata to suppress warning
Date: Thu,  6 Mar 2025 00:09:56 +1100
Message-ID: <20250305130955.24658-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304-anfingen-kondor-c7f9cc352472@brauner>
References: <20250304-anfingen-kondor-c7f9cc352472@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0523821196
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

We already have a comment regarding why .data -> .init references are
present for initramfs_test_cases[]. This allows us to suppress the
modpost warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503050109.t5Ab93hX-lkp@intel.com/
Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---

@Christian: feel free to squash this in with commit b6736cfccb582
("initramfs_test: kunit tests for initramfs unpacking") in your
vfs-6.15.initramfs branch if you like (and remove "These tests introduce
new modpost warnings..." from the commit msg).

 init/initramfs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 6231fe0125831..696fff583ee42 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -387,7 +387,7 @@ static void __init initramfs_test_many(struct kunit *test)
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
  */
-static struct kunit_case initramfs_test_cases[] = {
+static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_extract),
 	KUNIT_CASE(initramfs_test_fname_overrun),
 	KUNIT_CASE(initramfs_test_data),
-- 
2.43.0


