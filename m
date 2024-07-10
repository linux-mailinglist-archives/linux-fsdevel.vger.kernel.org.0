Return-Path: <linux-fsdevel+bounces-23452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CAB92C7C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF29284825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3C8F62;
	Wed, 10 Jul 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AkbhUu+B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AkbhUu+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B88522E;
	Wed, 10 Jul 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573699; cv=none; b=t/yuIu6XF10QFlmYRennFWMS6onNbG1KcqIVIx4NDQxS4er/JocCUIH7SyPDckAxMCp8qz2h9ZoVJ0QApnd/mFA8cU88U90a2nz6pyc2RcnS031dUX7O2xxKfoyQW2WLZcezfme57dh1n5GT/MyTVLUJBeHn+xoioT+BKFiZUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573699; c=relaxed/simple;
	bh=ozzA3va8DgjeYgVz17NXB5p4q7v+TFTiZ8UK+05oJRw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ftvz/vv/aWGnAWl4SmHvOwvmhCOi1sKeHn+W3ne+lZX7ybrlSmpca+p0Qp380eqs1R0IHU0iEb69Rjtg4AiQxZlCnIG/KvPACgy4wTE8USWsr9R7r8Rmm514alE0aFV1vZLakMdi2MgphZcM3Rm1sSWQqKq5G6o+5VsC8PJZJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AkbhUu+B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AkbhUu+B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1160E1F7CD;
	Wed, 10 Jul 2024 01:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720573695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LRJjtkA62dGtzTYeDaCxrJybyaUrrk/lLoMPFfZZfoQ=;
	b=AkbhUu+BKFSzNPbx90M25I0+GFHv+loJxIYmyEAjWmnOIS5qyBDPxMllkYCxgTd9DcPFHv
	7uV4ePvpcSHa9+Di6IalB4Y0ondwcKKP/nrb7Mmv+7d4wbfvjL2ThmkdhlsRHJSHI/xhWC
	9RTBowROwH3YXk36CGlJjqtOjsjr/Iw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720573695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LRJjtkA62dGtzTYeDaCxrJybyaUrrk/lLoMPFfZZfoQ=;
	b=AkbhUu+BKFSzNPbx90M25I0+GFHv+loJxIYmyEAjWmnOIS5qyBDPxMllkYCxgTd9DcPFHv
	7uV4ePvpcSHa9+Di6IalB4Y0ondwcKKP/nrb7Mmv+7d4wbfvjL2ThmkdhlsRHJSHI/xhWC
	9RTBowROwH3YXk36CGlJjqtOjsjr/Iw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 978D41369A;
	Wed, 10 Jul 2024 01:08:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LinKE/3ejWaYTQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 10 Jul 2024 01:08:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] mm: skip memcg for certain address space
Date: Wed, 10 Jul 2024 10:37:45 +0930
Message-ID: <cover.1720572937.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Recently I'm hitting soft lockup if adding an order 2 folio to a
filemap using GFP_NOFS | __GFP_NOFAIL. The softlockup happens at memcg
charge code, and I guess that's exactly what __GFP_NOFAIL is expected to
do, wait indefinitely until the request can be met.

On the other hand, if we do not use __GFP_NOFAIL, we can be limited by
memcg at a lot of critical location, and lead to unnecessary transaction
abort just due to memcg limit.

However for that specific btrfs call site, there is really no need charge
the memcg, as that address space belongs to btree inode, which is not
accessible to any end user, and that btree inode is a shared pool for
all metadata of a btrfs.

So this patchset introduces a new address space flag, AS_NO_MEMCG, so
that folios added to that address space will not trigger any memcg
charge.

This would be the basis for future btrfs changes, like removing
__GFP_NOFAIL completely and larger metadata folios.

Qu Wenruo (2):
  mm: make lru_gen_eviction() to handle folios without memcg info
  mm: allow certain address space to be not accounted by memcg

 fs/btrfs/disk-io.c      |  1 +
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 12 +++++++++---
 mm/workingset.c         |  2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.45.2


