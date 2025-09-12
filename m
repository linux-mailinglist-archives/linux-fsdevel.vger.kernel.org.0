Return-Path: <linux-fsdevel+bounces-61035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E659B54A03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721F91CC5401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2662EBBAC;
	Fri, 12 Sep 2025 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ule3a0YW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aeaY8l6j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ule3a0YW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aeaY8l6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE62EB5DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673534; cv=none; b=SH4ERR7yOVBD6nQOzR1jyGL/K9fqQPT9+X/ihDpQOSaFuAnzogAl1Y8uGodHPv8Nm2Am9BXXpRIclLpnuoaHczsg5Oszl0hB5SVPJV48604fCmtQiC+jgXqnevazVT1ds9X72HQn+pDON/XnlxniDcK0BMW7F9vch3ofY0R1Vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673534; c=relaxed/simple;
	bh=H08bFqXsOUw0/u4hvWRhww4ES9b73bK5WrgtrrT7lMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbQAacK/DTCYNH6Xk+DeCDvl3OWc6j6npK0JbiX0+2tKkOuT8I9eNdethq11ylyiyHGHkMkbrTk/hlZhqeo/syGRExDWUP3/UvD7WFV75vVWSTaYbL3FZ3HnTSg6GLKhF4nI78BdD2JgB5yxEvpZ8LIm70AUOEFX6QcgROXxFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ule3a0YW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aeaY8l6j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ule3a0YW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aeaY8l6j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80A8D5C872;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wasKdYKXn9ieNuLpvYInVqOdUbbupsfGG4IwsHcQHMM=;
	b=ule3a0YWbdjfT27BFpVQ+modEvsLgQULMlzQYy2Gb+fL5JCz731UbtXnPivI+UM9Y/B+F6
	HcrFWV1ozEn262Td/GWBNf5ov41VxyngZeYH+giVNsharbT8bVL1aRD4wqg5FSktNxBXyL
	V+2bD0mUnmBDkPzRpJStPCoJQ1w3i9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wasKdYKXn9ieNuLpvYInVqOdUbbupsfGG4IwsHcQHMM=;
	b=aeaY8l6jKIzIN8Bh+0vfzO1vO902io4IOS35aSMTkky36i/y722Yp4WBDo6E7bC5ZgkArB
	9nBKZpfHokBZdIDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wasKdYKXn9ieNuLpvYInVqOdUbbupsfGG4IwsHcQHMM=;
	b=ule3a0YWbdjfT27BFpVQ+modEvsLgQULMlzQYy2Gb+fL5JCz731UbtXnPivI+UM9Y/B+F6
	HcrFWV1ozEn262Td/GWBNf5ov41VxyngZeYH+giVNsharbT8bVL1aRD4wqg5FSktNxBXyL
	V+2bD0mUnmBDkPzRpJStPCoJQ1w3i9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wasKdYKXn9ieNuLpvYInVqOdUbbupsfGG4IwsHcQHMM=;
	b=aeaY8l6jKIzIN8Bh+0vfzO1vO902io4IOS35aSMTkky36i/y722Yp4WBDo6E7bC5ZgkArB
	9nBKZpfHokBZdIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7276513AC0;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jT+xGzr4w2gqWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 10:38:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 09EE6A098E; Fri, 12 Sep 2025 12:38:50 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/4] writeback: Avoid lockups when switching inodes
Date: Fri, 12 Sep 2025 12:38:34 +0200
Message-ID: <20250912103522.2935-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=jack@suse.cz; h=from:subject:message-id; bh=H08bFqXsOUw0/u4hvWRhww4ES9b73bK5WrgtrrT7lMo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBow/gqIgTts4ZHH7A93YI2aiRV3hfo5zgKdm7Gj 1VrGYd6QjuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMP4KgAKCRCcnaoHP2RA 2YfQB/9spG5mcMZCiEvui9yTwGHHw6Eb9SUXU66uAG+i9JbHDXBqIRk0lIZKRqbV9X1BHoHhhqT vrwodXNTDi1mikxNdBTSP1A1azXJZTqs1MQDLlxJOi24czkYHaPpZ1MWOnbEhg59V444eMFK0Qn TpcMzN6gUAiLQYDvJbIyOWjwtzNGakHylubO1+7z3ERFwBUjLVO7vp+utWCNfUpUlaF9mAXAq4t PwJD3HmopnG/s2zmvwtnUe5dVCiiNKE1lUXpNROW4StYWhWdIdpbAo6xPWDs5leV5q0/tXZmO9I KYHs65i+ZxjIVE98SVSI1GPCtSxyVqRzsro2amanKwXGPfUL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hello!

This patch series addresses lockups reported by users when systemd unit reading
lots of files from a filesystem mounted with lazytime mount option exits. See
patch 3 for more details about the reproducer.

There are two main issues why switching many inodes between wbs:

1) Multiple workers will be spawned to do the switching but they all contend
on the same wb->list_lock making all the parallelism pointless and just
wasting time.

2) Sorting of wb->b_dirty list by dirtied_time_when is inherently slow.

Patches 1-3 address these problems, patch 4 adds a tracepoint for better
observability of inode writeback switching.

Changes since v1:
* Added Acked-by's from Tejun
* Modified patch 1 to directly insert isw items into a list of switches to
  make instead of queueing rcu_work for that. This actually speeded up
  large scale switching about 2x.

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20250909143734.30801-1-jack@suse.cz # v1

