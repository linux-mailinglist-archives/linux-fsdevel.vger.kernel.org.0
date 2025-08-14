Return-Path: <linux-fsdevel+bounces-57832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F1B25B44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1361188713C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC802248B5;
	Thu, 14 Aug 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pbbQpuaN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FVy0pvHS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pbbQpuaN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FVy0pvHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2B2222AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150523; cv=none; b=r/QVtawqzlMGNp4qR4CvBEo5bAm/IjMhmBmhaSNU/XW4XdonDBLL8uHvN1n74m5aPKU3P2uOqiiJ/ULF3Q9WdCpaLI5o+MJi/4VmH3IJP/DifBpuzJe1QpbI6PSCbZPNUSyew5r1qnoqS5UvpCmd6XGN1drDfuhEF1OKJ6erGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150523; c=relaxed/simple;
	bh=acMnuN8CUQ+rqWlUiJ1W27jWZSAHlJMsCKzhF95Cpl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBDxBWQ7WoW2nxC7n0P44KU18okaDG350iVyvTpkSujrqYTdPoj9y0FUDfw9S58F5k8KW3xdhVB4gxS89PyvRr9WgkLxJB7UCzJeQqUz7yGsDLq6G61dNZIqkKBXPqX7oEE/902/28VkdH8NvgWCNJMoHKTL0+4i9kAsBaSWYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pbbQpuaN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FVy0pvHS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pbbQpuaN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FVy0pvHS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5D221F7C7;
	Thu, 14 Aug 2025 05:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l0ODPkxxGipOkRFrS0RDmhF/1xUM0HuEcyfSRUdojfQ=;
	b=pbbQpuaNZ85UjILFp1Ds0Aws1Gk5JcGHaBRnw6iw4jSzxwnc4pWB9xpWD7NiZELplMouYQ
	IlWtTeIYew9X0d61LJ6KmUefCAMSAJc+Q0QPypmjsa1HpM0+vUp+w4MPYIN1Fu+GQSmzXl
	Br2rig9yzANRo0nTfTw24X4mpGCAh8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l0ODPkxxGipOkRFrS0RDmhF/1xUM0HuEcyfSRUdojfQ=;
	b=FVy0pvHStUMzrJ+KKHCp/4Y7XyfM3LReJldqjRYVQvGEt3Ra6UmUSpninheS356SKR0qm3
	HtoFjsmUGc0M59Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l0ODPkxxGipOkRFrS0RDmhF/1xUM0HuEcyfSRUdojfQ=;
	b=pbbQpuaNZ85UjILFp1Ds0Aws1Gk5JcGHaBRnw6iw4jSzxwnc4pWB9xpWD7NiZELplMouYQ
	IlWtTeIYew9X0d61LJ6KmUefCAMSAJc+Q0QPypmjsa1HpM0+vUp+w4MPYIN1Fu+GQSmzXl
	Br2rig9yzANRo0nTfTw24X4mpGCAh8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l0ODPkxxGipOkRFrS0RDmhF/1xUM0HuEcyfSRUdojfQ=;
	b=FVy0pvHStUMzrJ+KKHCp/4Y7XyfM3LReJldqjRYVQvGEt3Ra6UmUSpninheS356SKR0qm3
	HtoFjsmUGc0M59Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4719D13479;
	Thu, 14 Aug 2025 05:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hrUxALZ4nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:37 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org
Subject: [PATCH v2 0/7] gen_init_cpio: add copy_file_range / reflink support
Date: Thu, 14 Aug 2025 15:17:58 +1000
Message-ID: <20250814054818.7266-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

This patchset adds copy_file_range() support to gen_init_cpio. When
combined with data segment alignment, large-file archiving performance
is improved on Btrfs and XFS due to reflinks (see 7/7 benchmarks).

cpio data segment alignment is provided by "bending" the newc spec
to zero-pad the filename field. GNU cpio and Linux initramfs extractors
handle this fine as long as PATH_MAX isn't exceeded.

Changes since v1 RFC
- add alignment patches 6-7
- slightly rework commit and error messages
- rename l->len to avoid 1/i confusion

David Disseldorp (7):
      gen_init_cpio: write to fd instead of stdout stream
      gen_init_cpio: support -o <output_path> parameter
      gen_init_cpio: attempt copy_file_range for file data
      gen_init_cpio: avoid duplicate strlen calls
      gen_initramfs.sh: use gen_init_cpio -o parameter
      docs: initramfs: file data alignment via name padding
      gen_init_cpio: add -a <data_align> as reflink optimization

 .../driver-api/early-userspace/buffer-format.rst   |   5 +
 usr/gen_init_cpio.c                                | 234 ++++++++++++++-------
 usr/gen_initramfs.sh                               |   7 +-
 3 files changed, 166 insertions(+), 80 deletions(-)


