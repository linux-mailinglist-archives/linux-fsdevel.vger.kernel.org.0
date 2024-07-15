Return-Path: <linux-fsdevel+bounces-23684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA68F931398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5415DB23C27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7C18A947;
	Mon, 15 Jul 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VD2/umn1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VD2/umn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379891E51D;
	Mon, 15 Jul 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045296; cv=none; b=DyBwas2oPShwSk0xtV/uzjTcNcD99oXQdxuXFXU0/O/QaYKkEv+q3kRUVh+Uv4Vycq/MQrcp03aP9GWJLrLLkZNuhbSkNYsKbQZ3OiEOzomId5orTGrzLvSVMkn7McSNDdp5oIwJWlNzaHM/h33crzoqdfVjgY2JQBivmJ8+yFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045296; c=relaxed/simple;
	bh=+24K5iZcsujaxjjrIUAmidftw7jLqEiRN1XT9yzX20U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpP+EyUDb+CziO2DOT+C10qeneJYKNbP0ebrH2VPe+LMnkEdGPIEiseSKXgHW0koEyQWfdoRKTt2DEWEAjvNXcBqdf733e3km12qJI1bLDBaaWkT6i+YDob8W4UXuMCZ8l4KW3FgmCXCFpo+QTl4/SDPOM4115wMeukxD1Tl79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VD2/umn1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VD2/umn1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2709021962;
	Mon, 15 Jul 2024 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721045291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iM7h0ngJnCCzaco1I/l6pMGsHYRhbItHxFWUVJNby7U=;
	b=VD2/umn1I/S5m1nuFEYSVGXvPaod30Fpckt0Sy8TjVkY+vjFQYAB6kDf+iz9nGVCsMvwMP
	rjZeKYTiLw2Y5NLprYpqZH6C0h9z10CbpU7fi0Kw53cfbvBpBe1WMCm9DppEtp9zQeAPYq
	FVHFHe1UD6vfrtiOx5YFhO0mm2O9P2Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="VD2/umn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721045291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iM7h0ngJnCCzaco1I/l6pMGsHYRhbItHxFWUVJNby7U=;
	b=VD2/umn1I/S5m1nuFEYSVGXvPaod30Fpckt0Sy8TjVkY+vjFQYAB6kDf+iz9nGVCsMvwMP
	rjZeKYTiLw2Y5NLprYpqZH6C0h9z10CbpU7fi0Kw53cfbvBpBe1WMCm9DppEtp9zQeAPYq
	FVHFHe1UD6vfrtiOx5YFhO0mm2O9P2Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15A31137EB;
	Mon, 15 Jul 2024 12:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VWE/BSsRlWbpPQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 15 Jul 2024 12:08:11 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS updates for 6.11
Date: Mon, 15 Jul 2024 14:08:02 +0200
Message-ID: <cover.1721044972.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 2709021962

Hi,

please pull the following conversions of the one-element to flexible
arrays. Thanks.

----------------------------------------------------------------
The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-6.11-tag

for you to fetch changes up to 0aef1d41c61b52b21e1750e7b53447126ff257de:

  affs: struct slink_front: Replace 1-element array with flexible array (2024-07-11 16:14:26 +0200)

----------------------------------------------------------------
Kees Cook (3):
      affs: struct affs_head: Replace 1-element array with flexible array
      affs: struct affs_data_head: Replace 1-element array with flexible array
      affs: struct slink_front: Replace 1-element array with flexible array

 fs/affs/amigaffs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

