Return-Path: <linux-fsdevel+bounces-14331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ABE87B0AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0CAB2CD28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B295914A;
	Wed, 13 Mar 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="egQGNkPZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1+UZ4fn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="egQGNkPZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1+UZ4fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670058AB8
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352497; cv=none; b=P3xthoHUQF79A1feC/L2AUWZYbw8Six7mk+3D6m6ZT/yKv306gHQhql6H87SrXq66/fWYL31ViiJsf2Vhqm108Ph9m/3XN4CMe11Fhgxtlohechptfk612SSsW33iUC82Quo3LmKzVzdvBNEC6z/DsRG2lanNNhT18vwnjeMABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352497; c=relaxed/simple;
	bh=8I0asITXXS7CQK5ilm0DVcgEHRHu5ongYvD30Zjurqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b6JICstOXnl3OYy8AlbqWjqWoIg7e02tmL3Bd4ycWvOPLiD9ul+Zi1M7riwRPdTIyTqym02mS6F4Mmk8ZiH0AvnHwh1jxfLhzSMmwO7JCrctVLgfnjTjErCpnLzl6YXFC1hvOb/yntdTC23/XsblvHopXx9XwnVwvsbiRhMQKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=egQGNkPZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1+UZ4fn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=egQGNkPZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1+UZ4fn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 270321F7D2;
	Wed, 13 Mar 2024 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710352493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rOzN5FmS9kVFzCe0lIh84A0t/lhcMllWajZkPm1vWo=;
	b=egQGNkPZp66Bilotunph67MA0bx2f9JJ87BNj3tm/oR2VGV4PzdykHiRAjJEWZu0DJ7p96
	M+Ayq4KmRkQyMvS4f4oyonFR2+5xVmyTYdszkw7CwYEod3nk0BFRs+teCov4OuTAXQLjet
	07MLM2KhRsbW1szv/i+xtJ2K7KpDDOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710352493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rOzN5FmS9kVFzCe0lIh84A0t/lhcMllWajZkPm1vWo=;
	b=O1+UZ4fnfTO7C3Uz7RZ+vtK+9jH/wIp0dC+edAxtOL12hHKMW0hrLLAefrabu5yK5pGbpS
	Q0b7LDoUX8r3eVBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710352493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rOzN5FmS9kVFzCe0lIh84A0t/lhcMllWajZkPm1vWo=;
	b=egQGNkPZp66Bilotunph67MA0bx2f9JJ87BNj3tm/oR2VGV4PzdykHiRAjJEWZu0DJ7p96
	M+Ayq4KmRkQyMvS4f4oyonFR2+5xVmyTYdszkw7CwYEod3nk0BFRs+teCov4OuTAXQLjet
	07MLM2KhRsbW1szv/i+xtJ2K7KpDDOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710352493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rOzN5FmS9kVFzCe0lIh84A0t/lhcMllWajZkPm1vWo=;
	b=O1+UZ4fnfTO7C3Uz7RZ+vtK+9jH/wIp0dC+edAxtOL12hHKMW0hrLLAefrabu5yK5pGbpS
	Q0b7LDoUX8r3eVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10CAD1397F;
	Wed, 13 Mar 2024 17:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B0PVA23o8WXkJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Mar 2024 17:54:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87146A07D9; Wed, 13 Mar 2024 18:54:52 +0100 (CET)
Date: Wed, 13 Mar 2024 18:54:52 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, isofs, udf, quota fixes for 6.9-rc1
Message-ID: <20240313175452.tr6vqhy7u4fbe3ow@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=egQGNkPZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O1+UZ4fn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -7.51
X-Rspamd-Queue-Id: 270321F7D2
X-Spam-Flag: NO


  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.9-rc1

A lot of material this time:
 * removal of a lot of GFP_NOFS usage from ext2, udf, quota (either it was
   legacy or replaced with scoped memalloc_nofs_*() API)
 * removal of BUG_ONs in quota code
 * conversion of UDF to the new mount API
 * tightening quota on disk format verification
 * fix some potentially unsafe use of RCU pointers in quota code and
   annotate everything properly to make sparse happy
 * a few other small quota, ext2, udf, and isofs fixes

Top of the tree is a78e41a67bef. The full shortlog is:

Alex Henrie (1):
      isofs: handle CDs with bad root inode but good Joliet root directory

Chao Yu (1):
      MAINTAINERS: add missing git address for ext2 entry

Chengming Zhou (4):
      ext2: remove SLAB_MEM_SPREAD flag usage
      isofs: remove SLAB_MEM_SPREAD flag usage
      quota: remove SLAB_MEM_SPREAD flag usage
      udf: remove SLAB_MEM_SPREAD flag usage

Eric Sandeen (2):
      udf: convert novrs to an option flag
      udf: convert to new mount API

Jan Kara (16):
      quota: Replace BUG_ON in dqput()
      quota: Remove BUG_ON in dquot_load_quota_sb()
      quota: Remove BUG_ON from dqget()
      udf: Remove GFP_NOFS from dir iteration code
      udf: Avoid GFP_NOFS allocation in udf_symlink()
      udf: Avoid GFP_NOFS allocation in udf_load_pvoldesc()
      udf: Remove GFP_NOFS allocation in udf_expand_file_adinicb()
      ext2: Drop GFP_NOFS allocation from ext2_init_block_alloc_info()
      ext2: Drop GFP_NOFS use in ext2_get_blocks()
      ext2: Remove GFP_NOFS use in ext2_xattr_cache_insert()
      quota: Set nofs allocation context when acquiring dqio_sem
      quota: Drop GFP_NOFS instances under dquot->dq_lock and dqio_sem
      udf: Avoid invalid LVID used on mount
      quota: Fix rcu annotations of inode dquot pointers
      quota: Properly annotate i_dquot arrays with __rcu
      quota: Detect loops in quota tree

Michael Opdenacker (1):
      ext2: mark as deprecated

Wang Jianjian (1):
      quota: Fix potential NULL pointer dereference

The diffstat is

 MAINTAINERS              |   1 +
 fs/ext2/Kconfig          |  15 +-
 fs/ext2/balloc.c         |   2 +-
 fs/ext2/ext2.h           |   2 +-
 fs/ext2/inode.c          |   2 +-
 fs/ext2/super.c          |   5 +-
 fs/ext2/xattr.c          |   2 +-
 fs/ext4/ext4.h           |   2 +-
 fs/ext4/super.c          |   2 +-
 fs/f2fs/f2fs.h           |   2 +-
 fs/f2fs/super.c          |   2 +-
 fs/isofs/inode.c         |  20 +-
 fs/jfs/jfs_incore.h      |   2 +-
 fs/jfs/super.c           |   2 +-
 fs/ocfs2/inode.h         |   2 +-
 fs/ocfs2/quota_global.c  |  12 +
 fs/ocfs2/quota_local.c   |   3 +
 fs/ocfs2/super.c         |   2 +-
 fs/quota/dquot.c         | 174 ++++++++-------
 fs/quota/quota_tree.c    | 152 +++++++++----
 fs/quota/quota_v1.c      |   6 +
 fs/quota/quota_v2.c      |  35 ++-
 fs/reiserfs/reiserfs.h   |   2 +-
 fs/reiserfs/super.c      |   2 +-
 fs/udf/dir.c             |   2 +-
 fs/udf/inode.c           |   2 +-
 fs/udf/namei.c           |  21 +-
 fs/udf/super.c           | 556 +++++++++++++++++++++++++----------------------
 fs/udf/udf_sb.h          |   1 +
 include/linux/fs.h       |   2 +-
 include/linux/shmem_fs.h |   2 +-
 mm/shmem.c               |   2 +-
 32 files changed, 611 insertions(+), 428 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

