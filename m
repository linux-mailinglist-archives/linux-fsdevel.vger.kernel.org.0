Return-Path: <linux-fsdevel+bounces-74821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A5wCgWccGlyYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:27:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42C545BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2374B80ADAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4D3BBA05;
	Wed, 21 Jan 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGUGR4tX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PfneHy3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGUGR4tX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PfneHy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C019D89E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986865; cv=none; b=Jo+EfkSHRGFNGAVREvli0E7A4cRYoSoR9E9sLj/Esl2tTKQagV9E/2pi9VUAdWcB+eSgYjN4Oiejo87qp8yKdNXH97JBLH3hF4m51C7cU3tVN35f0NfmrBr5Daelfw9MfpxmyZHTPHN1+XKjSdmXbBTwE/jydPTXgj4is7vSZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986865; c=relaxed/simple;
	bh=5YDLEp/CvTYyVVddVxCFdjGV7z3BpBUELJupr2ir7bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOAoEgCD1XxPQ31xm/khNhxrwdwZQywKsSzU4P7Gj+SlZlNwes9wYiTz2ukiQjUnwIwcLDg0zHf8UlZUpuYky+aX3//mVuwrcohsb3jO/JoUTFeGFfmgcpJNh+rhFRXffDM3YF8+HNb/LYwXygdnNtPz6loPMQKaXUM1vJaCvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGUGR4tX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PfneHy3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGUGR4tX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PfneHy3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 669A233689;
	Wed, 21 Jan 2026 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768986861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b2VyOl4PkB1DnATyXlsc3FFoUTfEVfq5o1UmXW37DZ4=;
	b=fGUGR4tXKC6a66DcAkdXCuftkfe64KlAVKidiEbC4BaaesNdtuqAUlwMRz5P4c0/bHf0zG
	7cj1PbaR5wQuWUpsBu9IPcrSK7WnYilj+yj9tcIlbdAB8FnK2mbfwa/waDqFSoJnthTw1M
	fzFe/wumdLj5qQ3yC9MsitnN97TwaHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768986861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b2VyOl4PkB1DnATyXlsc3FFoUTfEVfq5o1UmXW37DZ4=;
	b=1PfneHy3VAmMTROwDjZwBoPGqrk0hCLx5ceBhlEoxcj2kLDUjSuJ8Dw3pqPwIUpokIciy0
	5vjlyw8OHwBEClBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fGUGR4tX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1PfneHy3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768986861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b2VyOl4PkB1DnATyXlsc3FFoUTfEVfq5o1UmXW37DZ4=;
	b=fGUGR4tXKC6a66DcAkdXCuftkfe64KlAVKidiEbC4BaaesNdtuqAUlwMRz5P4c0/bHf0zG
	7cj1PbaR5wQuWUpsBu9IPcrSK7WnYilj+yj9tcIlbdAB8FnK2mbfwa/waDqFSoJnthTw1M
	fzFe/wumdLj5qQ3yC9MsitnN97TwaHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768986861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b2VyOl4PkB1DnATyXlsc3FFoUTfEVfq5o1UmXW37DZ4=;
	b=1PfneHy3VAmMTROwDjZwBoPGqrk0hCLx5ceBhlEoxcj2kLDUjSuJ8Dw3pqPwIUpokIciy0
	5vjlyw8OHwBEClBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CED83EA63;
	Wed, 21 Jan 2026 09:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hNypFu2YcGk0KwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 09:14:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1226CA09E9; Wed, 21 Jan 2026 10:14:17 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: morton@suse.cz
Cc: bernd@bsbernd.com,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	<linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] flex_proportions: Make fprop_new_period() hardirq safe
Date: Wed, 21 Jan 2026 10:13:56 +0100
Message-ID: <20260121091355.14209-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=jack@suse.cz; h=from:subject; bh=5YDLEp/CvTYyVVddVxCFdjGV7z3BpBUELJupr2ir7bE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpcJjTlmuj9rBRbcf7Vy5IAXkgckTlZsjgChVQJ 3fYEMZGdCaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaXCY0wAKCRCcnaoHP2RA 2TySB/9ayu/xjOVJ47tvA2MxBIBXOcAszF9RQPGYnnOVRS5NO58CHugM6DSCDqsMdc5IWqoHvXK JS+Sfei+crvmeyIkHpyefYhb80TfpbUiykkWTTAeXNkcr9FPvJ5OgvL43O6+Rpv7uaTU9DGk1Ix xgCZ7xZAG483reFUo+76Y/BahfOVIOcY4R9jcYNw7JEvzSXJAOc1aFaONZc9KWVHtj5LlywwrTd fJD1ipHLI3Teml8j9Jd2bRSxjVd5oJBNYDpnoEMiH24E9/MjO17rVdJH76HnUlA2eqeDebUh+o2 bZp9lv9FYWBnqeslyErTMIo/lJsAj1Z7F5JYGFVGBudakeP1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74821-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bsbernd.com,gmail.com,szeredi.hu,vger.kernel.org,suse.cz];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bsbernd.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B42C545BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bernd has reported a lockdep splat from flexible proportions code that
is essentially complaining about the following race:

<timer fires>
run_timer_softirq - we are in softirq context
  call_timer_fn
    writeout_period
      fprop_new_period
        write_seqcount_begin(&p->sequence);

        <hardirq is raised>
        ...
        blk_mq_end_request()
	  blk_update_request()
	    ext4_end_bio()
	      folio_end_writeback()
		__wb_writeout_add()
		  __fprop_add_percpu_max()
		    if (unlikely(max_frac < FPROP_FRAC_BASE)) {
		      fprop_fraction_percpu()
			seq = read_seqcount_begin(&p->sequence);
			  - sees odd sequence so loops indefinitely

Note that a deadlock like this is only possible if the bdi has
configured maximum fraction of writeout throughput which is very rare
in general but frequent for example for FUSE bdis. To fix this problem
we have to make sure write section of the sequence counter is irqsafe.

Reported-by: Bernd Schubert <bernd@bsbernd.com>
Link: https://lore.kernel.org/all/9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com/
Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/flex_proportions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 84ecccddc771..012d5614efb9 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -64,13 +64,14 @@ void fprop_global_destroy(struct fprop_global *p)
 bool fprop_new_period(struct fprop_global *p, int periods)
 {
 	s64 events = percpu_counter_sum(&p->events);
+	unsigned long flags;
 
 	/*
 	 * Don't do anything if there are no events.
 	 */
 	if (events <= 1)
 		return false;
-	preempt_disable_nested();
+	local_irq_save(flags);
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -= events >> periods;
@@ -78,7 +79,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	percpu_counter_add(&p->events, -events);
 	p->period += periods;
 	write_seqcount_end(&p->sequence);
-	preempt_enable_nested();
+	local_irq_restore(flags);
 
 	return true;
 }
-- 
2.51.0


