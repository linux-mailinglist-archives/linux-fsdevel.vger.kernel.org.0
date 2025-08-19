Return-Path: <linux-fsdevel+bounces-58240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA3B2B800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC5B3BD26E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42609254846;
	Tue, 19 Aug 2025 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XMCXALrn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YuDKS+tA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tXimgoUA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YvbB6E52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894230C362
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575422; cv=none; b=jnm8llP24qsQge67LgQ9nbTCohnL45kTH3jCxhCTCEmxgc+WFEMOB++rtwSjzR3TZUBDkmStlgtQIam7dISQF7KlYe71ZHFmJNM4iOVGYzPRghzAvlMkRIrcfBl0RvIsjZYqawnSpN7yzY/1wtzUASPMF3otk+ILy5ei5/6ZV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575422; c=relaxed/simple;
	bh=77kW6BmT3aYUp/H51ieIRGW3GNsMMEJvbG+ujfYMw3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VP8F+lVhAza7m2+eBRfcJwF67+tRUz/Ytu3F13IpGYEM5ItiEE7D1kzCo/I08ymBG2LHJu8VncgVPSZn1owWKabat2R+yyzYPadtkwvLE2BC1YV0OZP3XnpKGZVqfKpKAPtw4gHShomx42MtsA30Rnfef9jHEIzTitCt3qkIrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XMCXALrn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YuDKS+tA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tXimgoUA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YvbB6E52; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B461F2125D;
	Tue, 19 Aug 2025 03:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=77kW6BmT3aYUp/H51ieIRGW3GNsMMEJvbG+ujfYMw3U=;
	b=XMCXALrnu2Sgs+gvKVu+Sa4rlAc0kI3ipSoKR4htcRuFZbJp/4x2KIC230ntMk9i/sYEU9
	mMsSiqiy8M29S6OaPy6J3AZPOMGbgnlq0+9YKiNd2oh7XbOBr2ijQp9FfX1T3065J5y4Qi
	DbyMwRxQh9IXJiFZiJbUAf9PKdJLlB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=77kW6BmT3aYUp/H51ieIRGW3GNsMMEJvbG+ujfYMw3U=;
	b=YuDKS+tA0kKfKYU1pkc8mRc20P/mnUprCUBbhqq1p/dVrr2gsHooMhAte6IpIGJ9LC3NqF
	uJm0JmQoFmKPmsAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tXimgoUA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YvbB6E52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=77kW6BmT3aYUp/H51ieIRGW3GNsMMEJvbG+ujfYMw3U=;
	b=tXimgoUAWBqAbAkl7voSHo0j7lJ4dm4bbIYXaZwsl1n1nVwV6fydJWSUobayPu5+1SEpMG
	5R5JFeVHT2sbvrR2s1xiL5IUWI3Z5qJUSEaqd9IJHdbPbf18566p5TeDhQuaT9OCeYjTaI
	XF6WNQy5JOHYiLsUJUYm8vjydr6rcmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=77kW6BmT3aYUp/H51ieIRGW3GNsMMEJvbG+ujfYMw3U=;
	b=YvbB6E52ewN4fsMUbSDQj/sM3zR73uPAoCLWeoVM2z8ulu5pTjNjnnrMNFyaDXeikHHyLU
	XNSs4z7vQv1LXeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D43A13686;
	Tue, 19 Aug 2025 03:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O0oOFWP0o2gJawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 19 Aug 2025 03:49:55 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	ddiss@suse.de,
	nsc@kernel.org
Subject: [PATCH v3 0/8] gen_init_cpio: add copy_file_range / reflink support
Date: Tue, 19 Aug 2025 13:05:43 +1000
Message-ID: <20250819032607.28727-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B461F2125D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.01

This patchset adds copy_file_range() support to gen_init_cpio. When
combined with data segment alignment, large-file archiving performance
is improved on Btrfs and XFS due to reflinks (see patch 7 benchmarks).

cpio data segment alignment is provided by "bending" the newc spec
to zero-pad the filename field. GNU cpio and Linux initramfs
extractors handle this fine as long as PATH_MAX isn't exceeded. A
kernel initramfs extraction unit test for this is provided.

Changes since v2
- add Nicolas' Reviewed-by tag to patches 1-7
- add patch 8 test for extracting a cpio archive with filename padding
- use trailing '||' for multi-line if conditions instead of prefix
- refer to -o output_file in usage instead of output_path
- define _GNU_SOURCE alongside O_LARGEFILE use, instead of later

Changes since v1 RFC
- add alignment patches 6-7
- slightly rework commit and error messages
- rename l->len to avoid 1/i confusion


