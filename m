Return-Path: <linux-fsdevel+bounces-26221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769CD956340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8611C215F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0814D715;
	Mon, 19 Aug 2024 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EFjPuPmW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R/++aP6g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EFjPuPmW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R/++aP6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE414A4F9;
	Mon, 19 Aug 2024 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045800; cv=none; b=CC58iPsh9QssN/vDP4u61NG7IRMFyGFwAJZ93IDS4gF4b8SoyRjPMy3bseI9JsDNxMG+X4qg2TUFR0rZnSX5RCKYw4qiPB5GL0gOtxx9niozeDFJ/a9U+z7ieMxzrWbkonbIjm7w0Prt90fzEDEOXKEs7+euzH4nZ1g/yk03P+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045800; c=relaxed/simple;
	bh=32REPx+SnFeqcSA1ZKlCBK7rmxV4QIB7l3YHcmAwNbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lD5+82yZCThVI2OgdS/tR2liiu/EM/2BJa6bWdPJCPUWmBuQWG8t7Ym/u/p7P5faBQD6vAYW5ho2TsYL+jqCaDo/wXTmgIFKoTGMdDAfy/r+cXG4GkGHlq5bTZGLZ61WDmMXk4EHsaEbs+/YJtgskatxn8vZg3STN5qqTLou2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EFjPuPmW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R/++aP6g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EFjPuPmW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R/++aP6g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B74C41FE48;
	Mon, 19 Aug 2024 05:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ol62alPdFg7n/E5tqX4gdgEXdgm/Q/r6hFzL9Rj6O/k=;
	b=EFjPuPmWdh0t3TdpG+YLvqiqUwVksOtdaU+MoIyRAIoYxUhq3wzTlnGvCB/oyePHP9/TfD
	NS6elvOda9ZBPV1bf5ZwdHxIkafvqzLMB1zAk0xi+1yCPYIDkyMyI/Jb9oqvmRF6DVl5KH
	BjIYqYAiYkiAtCNLghTQqZdiEWn2J1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ol62alPdFg7n/E5tqX4gdgEXdgm/Q/r6hFzL9Rj6O/k=;
	b=R/++aP6g7zYf2vbVLj665p09T0eqgfO5n+QG1/xdKXfG3KPJOcZcVxMczan3p9e7WqQFRH
	EHxCrAhvhzdS+mAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EFjPuPmW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="R/++aP6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ol62alPdFg7n/E5tqX4gdgEXdgm/Q/r6hFzL9Rj6O/k=;
	b=EFjPuPmWdh0t3TdpG+YLvqiqUwVksOtdaU+MoIyRAIoYxUhq3wzTlnGvCB/oyePHP9/TfD
	NS6elvOda9ZBPV1bf5ZwdHxIkafvqzLMB1zAk0xi+1yCPYIDkyMyI/Jb9oqvmRF6DVl5KH
	BjIYqYAiYkiAtCNLghTQqZdiEWn2J1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ol62alPdFg7n/E5tqX4gdgEXdgm/Q/r6hFzL9Rj6O/k=;
	b=R/++aP6g7zYf2vbVLj665p09T0eqgfO5n+QG1/xdKXfG3KPJOcZcVxMczan3p9e7WqQFRH
	EHxCrAhvhzdS+mAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9C61397F;
	Mon, 19 Aug 2024 05:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FXYbJNvZwma3YQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:36:27 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
Date: Mon, 19 Aug 2024 15:20:34 +1000
Message-ID: <20240819053605.11706-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B74C41FE48
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.01

I wasn't really sure who to send this too, and get_maintainer.pl
suggested 132 addresses which seemed excessive.  So I've focussed on
'sched' maintainers.  I'll probably submit individual patches to
relevant maintainers/lists if I get positive feedback at this level.

This series was motivated by 

   Commit ed0172af5d6f ("SUNRPC: Fix a race to wake a sync task")

which adds smp_mb__after_atomic().  I thought "any API that requires that
sort of thing needs to be fixed".

The main patches here are 7 and 8 which revise wake_up_bit and
wake_up_var respectively.  They result in 3 interfaces:
  wake_up_{bit,var}           includes smp_mb__after_atomic()
  wake_up_{bit,var}_relaxed() doesn't have a barrier
  wake_up_{bit,var}_mb()      includes smb_mb().

I think this set of interfaces should be easier to use correctly.  They
are also now documented more clearly.

The preceeding patches clean up various places where the exiting
interfaces weren't used optimally.  The final patch uses
clear_and_wake_up_bit() more widely because it seems like a good idea.

I have three questions:

1/ is my understanding of the needed barriers correct.
 i.e:
   smp_mb__after_atomic() needed after a clear_bit() to atomic_set() 
     or similar, or a change inside a locked region
   smb_mb() needed after any non-locked update
   nothing needed after test_and_clear_bit() or atomic_dec_and_test()
     or similar.
   (I realised while working on this that my previous understanding
    of the barrier requires was wrong, so maybe it still is).

2/ How should we handle the "flag day" where a barrier is added to
   wake_up_bit() and wake_up_var().  Some options are:
   a/ have a big patch for the flag-day as this series does
   b/ add the barrier in a new wake_up_atomic_{bit,var} and deprecate
      wake_up_{bit,var}
   c/ don't worry about the fact that there will be an extra barrier for
      a while - just make the change to wake_up_xxx() first, then submit
      individual patches to remove barriers as needed.

3/ Who else should I ask to remove this at this high level?

Thanks,
NeilBrown


 [PATCH 1/9] i915: remove wake_up on I915_RESET_MODESET.
 [PATCH 2/9] Introduce atomic_dec_and_wake_up_var().
 [PATCH 3/9] XFS: use wait_var_event() when waiting of i_pincount.
 [PATCH 4/9] Use wait_var_event() instead of I_DIO_WAKEUP
 [PATCH 5/9] Block: switch bd_prepare_to_claim to use
 [PATCH 6/9] block/pktdvd: switch congestion waiting to
 [PATCH 7/9] Improve and expand wake_up_bit() interface.
 [PATCH 8/9] Improve and extend wake_up_var() interface.
 [PATCH 9/9] Use clear_and_wake_up_bit() where appropriate.

