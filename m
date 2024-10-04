Return-Path: <linux-fsdevel+bounces-31022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48199103C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2F21C239B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46381D8A13;
	Fri,  4 Oct 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sK6NBrWk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UNP0zAsK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sK6NBrWk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UNP0zAsK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA511D8A0A;
	Fri,  4 Oct 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072317; cv=none; b=Riis2DL0mxGJNWFJj8NiOczedlQ98nFfJCVMecDQZO6jvdyHKh732MCa2ovkz0uy44cJ6mdftSw8aeP7pdSHDZGWmKahbYUtU90sUoVVtHOh25cqYVGvfPSjvXBbOYl3dAtsXg6WYJA1GFJHtm33o2wgQr114P8oDFIPKJYKZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072317; c=relaxed/simple;
	bh=PU72RAjqYI5Qt3bzRwcs259VguCtEYYVGU+g9nP/LOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsEmpqc11rFbjT43QFKGG7plsr77iXZakSwHVvvI2GAfWMAKFy2fRrmIKkLASYvZRLY/DVsYiSEl5D1ws/vR0Vqvqdex7cyvf/QAgpIaoJgpR7nBTOcj6RbRtpu9vxR709dEPi9y9ZA0h9b5CQigMyB2TCYGzog/vIdfTmHNy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sK6NBrWk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UNP0zAsK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sK6NBrWk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UNP0zAsK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E5E11F7B3;
	Fri,  4 Oct 2024 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XSl0wEtuFSDZIcfW3fpnirpGyVoc/LeciFvNQUWMLM=;
	b=sK6NBrWkVSW+a/hc6yqJXz+9pZxbHSoj5BLI0ZlHa3yZBFck/jv1AAq73c701WXN7toYR3
	QPBWbm3KD41jjJ2aM4KQTzYMPP1ze3cj85veh9FApwELhdhBVwuD6c2DesM5/44cdsMr16
	DwvukMOCFxX/q5U4ge0Q4N0+wBaRrX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XSl0wEtuFSDZIcfW3fpnirpGyVoc/LeciFvNQUWMLM=;
	b=UNP0zAsKeiGEXmC/Qe/RZG/A9XLpyL5ynMqA8gG6SDALe1WGnJY4/syjX9/DwPcz5YUfnm
	EXkoO23UNdvzT9Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XSl0wEtuFSDZIcfW3fpnirpGyVoc/LeciFvNQUWMLM=;
	b=sK6NBrWkVSW+a/hc6yqJXz+9pZxbHSoj5BLI0ZlHa3yZBFck/jv1AAq73c701WXN7toYR3
	QPBWbm3KD41jjJ2aM4KQTzYMPP1ze3cj85veh9FApwELhdhBVwuD6c2DesM5/44cdsMr16
	DwvukMOCFxX/q5U4ge0Q4N0+wBaRrX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XSl0wEtuFSDZIcfW3fpnirpGyVoc/LeciFvNQUWMLM=;
	b=UNP0zAsKeiGEXmC/Qe/RZG/A9XLpyL5ynMqA8gG6SDALe1WGnJY4/syjX9/DwPcz5YUfnm
	EXkoO23UNdvzT9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3500A13883;
	Fri,  4 Oct 2024 20:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u5bDBHlKAGfcRQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:13 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 00/12] btrfs reads through iomap
Date: Fri,  4 Oct 2024 16:04:27 -0400
Message-ID: <cover.1728071257.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

These patches incorporate btrfs buffered reads using iomap code.
The final goal here is to give all folio handling to iomap. This is the
first installment to be followed by writes, writebacks and eventually
subpage support.

The crux of the changes are:
 * Since btrfs uses it's own bio handling structure, the btrfs bioset is
passed to iomap code in order to create a bio with the folios.
 * For compressed extents:
   - IOMAP_ENCODED which behaves like IOMAP_MAPPED, except, we supply
     the iomap back to submit_io() to identify if it is encoded.
   - The iomap code needs to keep a track of the previous iomap struct
     in order to pass it to submit_io with the corresponding iomap
   - A change in iomap struct should create a new bio

I have tested this patchset against a full run of xfstests for btrfs.

The current code does not support subpage access of iomap. Subpage
will be hopefully incorporated once the write and the writeback goes
through.

Code is available at https://github.com/goldwynr/linux/tree/buffered-iomap

Goldwyn Rodrigues (12):
  iomap: check if folio size is equal to FS block size
  iomap: Introduce iomap_read_folio_ops
  iomap: add bioset in iomap_read_folio_ops for filesystems to use own
    bioset
  iomap: include iomap_read_end_io() in header
  iomap: Introduce IOMAP_ENCODED
  iomap: Introduce read_inline() function hook
  btrfs: btrfs_em_to_iomap() to convert em to iomap
  btrfs: iomap_begin() for buffered reads
  btrfs: define btrfs_iomap_read_folio_ops
  btrfs: define btrfs_iomap_folio_ops
  btrfs: add read_inline for folio operations for read() calls
  btrfs: switch to iomap for buffered reads

 block/fops.c           |   4 +-
 fs/btrfs/bio.c         |   2 +-
 fs/btrfs/bio.h         |   1 +
 fs/btrfs/extent_io.c   | 131 +++++++++++++++++++++++++++++++++++++++++
 fs/erofs/data.c        |   4 +-
 fs/gfs2/aops.c         |   4 +-
 fs/iomap/buffered-io.c | 117 +++++++++++++++++++++++++-----------
 fs/xfs/xfs_aops.c      |   4 +-
 fs/zonefs/file.c       |   4 +-
 include/linux/iomap.h  |  37 +++++++++++-
 10 files changed, 260 insertions(+), 48 deletions(-)

-- 
2.46.1


