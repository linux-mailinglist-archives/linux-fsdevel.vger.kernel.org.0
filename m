Return-Path: <linux-fsdevel+bounces-60675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA7B4FFCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D8D1C26043
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDB350D64;
	Tue,  9 Sep 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nxoYQKyy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4r5dJ4OA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nxoYQKyy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4r5dJ4OA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16FF35083D
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429079; cv=none; b=eDNCh6vjlQANyq4I0jO6BQOy/10Pjhd1Yb1aaFSq7912BbsSTjgMVqiRUtdCYRSJI6bMDiUh0plgbosTneITkNtYfyzuBZK0OLfjvztVDaFk4zKvHQSI4mOW6wrebP1LAO5dNI1ZDTehE//JM6m2ckgRkZ1l42Xfw8/CuKUOh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429079; c=relaxed/simple;
	bh=QU/RRZ1ttQqdYSWBMbIx59YWtlCZ5t/foE88fwjrlo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0VptQzCc0LFLuNKnNL62rJ65qtwp2P2PuO4bytzNuXCZimotbMYWwQpajJ8xG+zjSsGfshb/R/OJIPksrPCIDMfYF6Y1UoR8o3AgoGNzj9F4bEkqVGOfvFv4IPdPG3yNvJThEmRKTP34L/9OHeUCgjUApAj7SdnCgmH8ZYcFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nxoYQKyy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4r5dJ4OA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nxoYQKyy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4r5dJ4OA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF78A5F93E;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RuZZKvrV4J/cDTOkwo8O71+cK78vkqFl/cxpEWR43BE=;
	b=nxoYQKyyNeHQXlNKrD511WrY/WUC1Jx6jM48ZZ1A4XVL6/hW7ZeF93YK6IJzXpNXg87ELH
	aFOfAZytllgexnJCpGonxj/gpu9qYo02pWp/3AL4/PGx1KkFZqW0caTpHAKfWouXH9eGWc
	WNgFKrIZKQtkg6CiMB2fTFZ9VHbVxUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RuZZKvrV4J/cDTOkwo8O71+cK78vkqFl/cxpEWR43BE=;
	b=4r5dJ4OAJpyrQmFXc8F0c0zhSY7jLRcwja7NzX8jf3mahCpBUQJWhPpWqRh4aYW4bze8rl
	fIEIDY6RgSX8MfCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nxoYQKyy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4r5dJ4OA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RuZZKvrV4J/cDTOkwo8O71+cK78vkqFl/cxpEWR43BE=;
	b=nxoYQKyyNeHQXlNKrD511WrY/WUC1Jx6jM48ZZ1A4XVL6/hW7ZeF93YK6IJzXpNXg87ELH
	aFOfAZytllgexnJCpGonxj/gpu9qYo02pWp/3AL4/PGx1KkFZqW0caTpHAKfWouXH9eGWc
	WNgFKrIZKQtkg6CiMB2fTFZ9VHbVxUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RuZZKvrV4J/cDTOkwo8O71+cK78vkqFl/cxpEWR43BE=;
	b=4r5dJ4OAJpyrQmFXc8F0c0zhSY7jLRcwja7NzX8jf3mahCpBUQJWhPpWqRh4aYW4bze8rl
	fIEIDY6RgSX8MfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF8F013ABA;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VJptNk09wGiWdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 14:44:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 699D9A0A2D; Tue,  9 Sep 2025 16:44:29 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] writeback: Avoid lockups when switching inodes
Date: Tue,  9 Sep 2025 16:44:01 +0200
Message-ID: <20250909143734.30801-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; i=jack@suse.cz; h=from:subject:message-id; bh=QU/RRZ1ttQqdYSWBMbIx59YWtlCZ5t/foE88fwjrlo4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBowD0wMz2JzPUEPhtFCOLrUmaeT5LGa+vu7IUb0 n4Emi+9KeCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMA9MAAKCRCcnaoHP2RA 2UkMCADBAD9eN2Ge7hTwQTtLtTcIqISWxDxYcYOVWqc0BgoG4LCad/P3GZNa893jEBOSXiUmp3e EnM+w5Au4GTZC+Vq/Gg+91v4rz/v3tf3I3B0shJ76YHkLNFTbmDeQ7r/+zDdqZkO8evgaaDlnXR PWlyuNXvLuIlfL1qouzDgZpeAcTEAXd/GYabHXz0U5SM4H40dithyHsHeq3NkYYPit0t2yEnr0n P55uG9FrkkUK/MWYoCCHPzUWlvT8tyfOKZEHQ/vyzkRzdYmIIX0HqMuqgq+l5fs+3mr/YB3tWZF qV2feg4QsOChSExQScDp8WhK+usDTm9cjSq8e56sW5/+vtfQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EF78A5F93E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.01

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

								Honza

