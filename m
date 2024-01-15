Return-Path: <linux-fsdevel+bounces-7937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F342182D91D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 13:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971A9B21567
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F815AF6;
	Mon, 15 Jan 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I67Sf4Ii";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4qpxphe4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I67Sf4Ii";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4qpxphe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E61841
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88E6B221BC;
	Mon, 15 Jan 2024 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
	b=I67Sf4IiaL0cZgO8X8nftrUrli6rafiFucNVrWwlVtNd0vRZPHR1qE5Aw0ptgHLPMfZqe8
	SWSWWwtXOpuiZx6tAUB08L8fa0wb3cKoYNLwnIEAp2mDYDfNmwkKEa7IRVRJ0oC/FRgVyY
	et3oxYiUPHc8WE520w8v8ttPMS5/v9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
	b=4qpxphe4IrsEuqgKSdKwxvA2+dMs0wy6ho8aSYO84IOS/55agQ0snHwlfI7ZZIvRkkhldB
	caPjTUW0E2wT5DAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
	b=I67Sf4IiaL0cZgO8X8nftrUrli6rafiFucNVrWwlVtNd0vRZPHR1qE5Aw0ptgHLPMfZqe8
	SWSWWwtXOpuiZx6tAUB08L8fa0wb3cKoYNLwnIEAp2mDYDfNmwkKEa7IRVRJ0oC/FRgVyY
	et3oxYiUPHc8WE520w8v8ttPMS5/v9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
	b=4qpxphe4IrsEuqgKSdKwxvA2+dMs0wy6ho8aSYO84IOS/55agQ0snHwlfI7ZZIvRkkhldB
	caPjTUW0E2wT5DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A72513751;
	Mon, 15 Jan 2024 12:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 30beHMMqpWWNVQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 12:53:23 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Cc: Matthew Wilcox <willy@infradead.org>,
	amir73il@gmail.com,
	mszeredi@redhat.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/4] Add tst_fd iterator API
Date: Mon, 15 Jan 2024 13:53:47 +0100
Message-ID: <20240115125351.7266-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Changes in v3:
  - Made use of newly introduced API to specify an array of possible errors

    Jan and Amir please check if the error sets are not missing anything

  - Fixed a few minor problems as pointed out by Peter

Changes in v2:

 - Changed the API into iterator rather than a funciton callback
 - Added a lot more fd types
 - Added splice test

Cyril Hrubis (4):
  lib: Add tst_fd iterator
  syscalls: readahead01: Make use of tst_fd
  syscalls: accept: Add tst_fd test
  syscalls: splice07: New splice tst_fd iterator test

 include/tst_fd.h                              |  61 ++++
 include/tst_test.h                            |   1 +
 lib/tst_fd.c                                  | 325 ++++++++++++++++++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/accept/.gitignore   |   1 +
 testcases/kernel/syscalls/accept/accept01.c   |   8 -
 testcases/kernel/syscalls/accept/accept03.c   |  60 ++++
 .../kernel/syscalls/readahead/readahead01.c   |  52 +--
 testcases/kernel/syscalls/splice/.gitignore   |   1 +
 testcases/kernel/syscalls/splice/splice07.c   |  70 ++++
 10 files changed, 548 insertions(+), 33 deletions(-)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

-- 
2.43.0


