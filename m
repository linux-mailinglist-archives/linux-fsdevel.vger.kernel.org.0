Return-Path: <linux-fsdevel+bounces-35899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00D9D9750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D93B284E8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E14E1D278B;
	Tue, 26 Nov 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Orj+SVJa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jK0PbqB+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Orj+SVJa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jK0PbqB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34843190472
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624441; cv=none; b=HN4IiHpuJzR9Brnu+G1xWsg/S5qRuOgyKytdkiN2bvalk/f3OEkvGT5R90NajJ58+B4U0y8PUZrwERANCjAeI+TgKTjQu/kOCBhwSINfnsDxnkwiMU+LOI9j/g/hbL39Fffsw0sPa+gQgRpnLq/khOa8mAIOKf8qk2pv5LrKRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624441; c=relaxed/simple;
	bh=BwCSROko37uMyhU9qlOErU9VF3GVRnndJq/cNGtyO/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NGRQhPWap4KCZ5TWJEpCb0fEHfgB7i097B5ZNKWEFzUomyErJnl7VDGySDE4hQZuIS9gsETDzI4/PsN0eXhO3/yZuIAq9Yv3JOvlqXrJO2ccOPQbDVAc0up/XJQ6pM4ZYoJxtfVpvyfjhbH4HWU/aqHxIXHoY+jIq2uo9zgKkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Orj+SVJa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jK0PbqB+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Orj+SVJa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jK0PbqB+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D9DE21176;
	Tue, 26 Nov 2024 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BIi/tFOaUBbaSG+lNIPldgYUPtYofJv5R6QgRKhFsvE=;
	b=Orj+SVJawHLWfsSGgTqCbcUEHZDoraX0sxYz5ov2TXxT2Sna2D4UTXrRitzkvQ7PbVq9s/
	1j+rOttdtun7+pVCBcwpaekB1gJbf2/kYhTzSBLstu8YMNqYlgRixwVRJfPOa5AcAGeeup
	2tkZF2up8z2PlckLz7egp8REH8COCj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BIi/tFOaUBbaSG+lNIPldgYUPtYofJv5R6QgRKhFsvE=;
	b=jK0PbqB+Sf5sGlQU+WP81rpkr5c9OWFgnNmyp1jKcC940jaYe5wbAMuzK8V9/V8Q0OQkYz
	BcvuIs3wXAmTajAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Orj+SVJa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jK0PbqB+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BIi/tFOaUBbaSG+lNIPldgYUPtYofJv5R6QgRKhFsvE=;
	b=Orj+SVJawHLWfsSGgTqCbcUEHZDoraX0sxYz5ov2TXxT2Sna2D4UTXrRitzkvQ7PbVq9s/
	1j+rOttdtun7+pVCBcwpaekB1gJbf2/kYhTzSBLstu8YMNqYlgRixwVRJfPOa5AcAGeeup
	2tkZF2up8z2PlckLz7egp8REH8COCj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BIi/tFOaUBbaSG+lNIPldgYUPtYofJv5R6QgRKhFsvE=;
	b=jK0PbqB+Sf5sGlQU+WP81rpkr5c9OWFgnNmyp1jKcC940jaYe5wbAMuzK8V9/V8Q0OQkYz
	BcvuIs3wXAmTajAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22A36139AA;
	Tue, 26 Nov 2024 12:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KeBwCDbARWfIUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 12:33:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BCF91A08CA; Tue, 26 Nov 2024 13:33:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] udf: Verify link count before updating it
Date: Tue, 26 Nov 2024 13:33:47 +0100
Message-Id: <20241126123349.24798-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=257; i=jack@suse.cz; h=from:subject; bh=BwCSROko37uMyhU9qlOErU9VF3GVRnndJq/cNGtyO/E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnRcAllg2q88JLfqvCvt3AAM43heRj5MKyDvprOT6t R0NYdwqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ0XAJQAKCRCcnaoHP2RA2UZPCA DOYGHQu207/KPw+erX/lTMHYMqPJwSPYiI1bzQ5+FgT42WMp1TBR3ALSQm6+WQxx6imd29bFqBgv3e TulVIGlcWybPMXFVtu0cpaZ7kasb4X2SRp+rq2kbhMJutSEGZ7r5Bd7rAUOYtxMJmZf31DOfDZZUNG /2PziGLMuerWXWYzG35iKTHhmre1qD1oQeLrdlEFvPANaC+vq1H8NKm66wTw/mApINRT4Y251h0990 5bgthRw6Oa7FflTmopCLq+qKuzeaFhZoSMFfiB0F0jtWa2oeTgfwjSq3uF4PnnAM1KxReUEf6KyqOT a6G46xZRw9+MwTl/EIVnwqY/xh3Ztp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D9DE21176
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

these two patches fix syzbot complaints that corrupted filesystems can trigger
warnings in VFS that link counts go negative. We need to check the link count
is sane before updating it. I plan to merge these patches to my tree.

								Honza

