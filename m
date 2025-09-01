Return-Path: <linux-fsdevel+bounces-59734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D6DB3D8AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CA73B859B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F9C238C3B;
	Mon,  1 Sep 2025 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bHDV9tQP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RgdOt0Zh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5E15E90
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704275; cv=none; b=k8f3O3FST7O09T9Sunz9xC5TVZPf4tgr09uYV7Whbtu7xGF5QaeIzZtEflE4sqneBO1sdw83uZ6fH/bsjyjHM70fq5Y3x8Fy5/2nLxlw7TJLNNeW0DHkOKwYxPlNhSLkD+z/SDOewHLnwAv2jqXn9hJxGg8WrFzoQFvyqxGLr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704275; c=relaxed/simple;
	bh=wgdfVz5J8iEgM5pdpYnXBk0ylKZKtWV+lyOOedWwD3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0glaPVUbyfUmJLet1mZGPxvk3Cuwij14r6VrO/VxB4whLT75i0B+jSlyaUWUKxY8Awemrg0Y/epUa22HUnpoG14QFi1gfD+XM6tOBafINh0iSK+tRk/PVAOypcrP5VU+uq5a9YSA8Pw2CLPL2dhJrH/MfnTCVBMQ3kH1EivxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bHDV9tQP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RgdOt0Zh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFF731F38C;
	Mon,  1 Sep 2025 05:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ANjijpgBq0W36UzSaGjcONYN7yD3kDcDg6ebPHDoFmQ=;
	b=bHDV9tQPvaToTDFVn+OqEtiQ4tco/hC9qp/lMozWCIipUGeCXXsQuwW1wOXl+IxDcXWc4u
	gB1+8KjISDP374fniWgxtCa4oASVPRIuNP3Mgag7WddFR83NRAeLJph8muWEuT77sHTrN6
	uEXpKYR8bDdB2XVblS1gDYqpJd1yc6s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ANjijpgBq0W36UzSaGjcONYN7yD3kDcDg6ebPHDoFmQ=;
	b=RgdOt0Zha+v3Sq3rV6FRXLVpobMHBr2NvyNqklJpjuNpg+YOD6q33e+/NsOsc48eVdQDEQ
	2gg+9PtiIFqMOthaFGR57Ud+ijQZ8DYWTaJEkkWNvyFVuNHGC/MdNZ41kvb/E34jrEishL
	HGXfgewFZBa0kHihYb7rHWYn1IFocdY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBC0F13981;
	Mon,  1 Sep 2025 05:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5zOGKgcutWhBJgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 01 Sep 2025 05:24:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] btrfs: bs > ps support preparation
Date: Mon,  1 Sep 2025 14:54:02 +0930
Message-ID: <cover.1756703958.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Some extra small and safe bs > ps support preparation, mostly focusing
on the bio vec iteration code and cached order/bit members.

This time the difference is, I can enable some early local bs > ps
tests, so basic file read/write and csum verification are all done
properly.

The tricky part is still inside the compression, and maybe some other
functionalities.

Qu Wenruo (4):
  btrfs: support all block sizes which is no larger than page size
  btrfs: cache max and min order inside btrfs_fs_info
  btrfs: replace single page bio_iter_iovec() usage
  btrfs: replace bio_for_each_segment usage

 fs/btrfs/bio.c         |  3 ++-
 fs/btrfs/btrfs_inode.h |  6 +++---
 fs/btrfs/compression.c |  3 +--
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/file-item.c   | 13 +++++++------
 fs/btrfs/fs.c          |  4 ++++
 fs/btrfs/fs.h          |  8 +++++---
 fs/btrfs/raid56.c      | 10 +++++-----
 8 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.50.1


