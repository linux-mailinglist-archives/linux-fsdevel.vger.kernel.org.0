Return-Path: <linux-fsdevel+bounces-62505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EEB9599A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72761894DD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCB3218D8;
	Tue, 23 Sep 2025 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vCAyZfiF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pdRGFNqs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vCAyZfiF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pdRGFNqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95232144A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626226; cv=none; b=dMHXJC49DdQIUNRL+qY2Dvxm2xF0ds2Msf3dwcOAddCe+dNo7yWCtUF25P0N3wb2hHP+9+AH4ipWSimy8YDBbMHjRcBYBxxFsZzH9s4EfzHWQTmBkYof0mefqGwPp8938lKcR2uokT9c4mrIy5YPXfKii7UBcXB6hEJbn9Zo5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626226; c=relaxed/simple;
	bh=zhhqZ83dce0MR01fXWXPs8Ou8y5BhNyOlncGG1KZhSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq2ls5G3A4Iumelhra+JWvvryOfNNm9V4rRT6hc0DAiGnBq/jL6D2GkSzY9dN5hiGsEPF1RHkkt42NGZwM+eoEhaHP/p+XYRwDuiNWUkrrZrLnAfcKyRmpimCWd1oUj/yO8pNo5izYkQ6/Zv1eGksBw3APNbvm0pCbsyNffYvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vCAyZfiF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pdRGFNqs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vCAyZfiF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pdRGFNqs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 659FD1F795;
	Tue, 23 Sep 2025 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758626222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aj6XB5cLlYFGBMoCl3L4Eyrz0r1NoVev57mbCf3LkRU=;
	b=vCAyZfiFHvOhW40ItlyGOFTW76xeijcAnO2VK2e9LM7XQaTqEQcrTrYGfSl1qnGuXkIiCD
	dGj/bqSYmW2VVsyUazzsBeMlBP98W7du0yYTePAwN+uEGQOgIdEkY0nwd2vV96H5g6jfCF
	fodRy0NpT0eR2qRDf/oNgjzoXNE9ntg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758626222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aj6XB5cLlYFGBMoCl3L4Eyrz0r1NoVev57mbCf3LkRU=;
	b=pdRGFNqsL0tnq/fPbd9rih75BlPn2dAJaEE+CpCm5ldl3lvJTLaOkFoZWVoX89xfkqfSaH
	u/WrYphjGLjbVRAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758626222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aj6XB5cLlYFGBMoCl3L4Eyrz0r1NoVev57mbCf3LkRU=;
	b=vCAyZfiFHvOhW40ItlyGOFTW76xeijcAnO2VK2e9LM7XQaTqEQcrTrYGfSl1qnGuXkIiCD
	dGj/bqSYmW2VVsyUazzsBeMlBP98W7du0yYTePAwN+uEGQOgIdEkY0nwd2vV96H5g6jfCF
	fodRy0NpT0eR2qRDf/oNgjzoXNE9ntg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758626222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aj6XB5cLlYFGBMoCl3L4Eyrz0r1NoVev57mbCf3LkRU=;
	b=pdRGFNqsL0tnq/fPbd9rih75BlPn2dAJaEE+CpCm5ldl3lvJTLaOkFoZWVoX89xfkqfSaH
	u/WrYphjGLjbVRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51D561388C;
	Tue, 23 Sep 2025 11:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qIv0E66B0mgvfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Sep 2025 11:17:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FE3AA09AF; Tue, 23 Sep 2025 13:16:58 +0200 (CEST)
Date: Tue, 23 Sep 2025 13:16:58 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
Message-ID: <bh5kbxlwoavjgliq2m2fco2ahg2ub25ldl4keojewzfadpocv7@3wdcjneve3iw>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 23-09-25 12:47:06, Mateusz Guzik wrote:
> First commit message quoted verbatim with rationable + API:
> 
> [quote]
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> Given the late stage of the release cycle this patchset only aims to
> hide access, it does not provide any of the checks.
> 
> Consumers can be trivially converted. Suppose flags I_A and I_B are to
> be handled, then:
> 
> state = inode->i_state          => state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
> [/quote]
> 
> Right now this is one big NOP, except for READ_ONCE/WRITE_ONCE for every access.
> 
> Given this, I decided to not submit any per-fs patches. Instead, the
> conversion is done in 2 parts: coccinelle and whatever which was missed.

This looks good to me now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Generated against:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries
> 
> v6:
> - rename routines:
> set -> assign; add -> set; del -> clear
> - update commentary in patch 3 replacing smp_store/load with smp_wmb/rmb
> 
> v5:
> - drop lockdep for the time being
> 
> v4:
> https://lore.kernel.org/linux-fsdevel/CAGudoHFViBUZ4TPNuLWC7qyK0v8LRwxbpZd9Mx3rHdh5GW9CrQ@mail.gmail.com/T/#m866b3b5740691de9b4008184a9a3f922dfa8e439
> 
> 
> Mateusz Guzik (4):
>   fs: provide accessors for ->i_state
>   Convert the kernel to use ->i_state accessors
>   Manual conversion of ->i_state uses
>   fs: make plain ->i_state access fail to compile
> 
>  Documentation/filesystems/porting.rst |   2 +-
>  block/bdev.c                          |   4 +-
>  drivers/dax/super.c                   |   2 +-
>  fs/9p/vfs_inode.c                     |   2 +-
>  fs/9p/vfs_inode_dotl.c                |   2 +-
>  fs/affs/inode.c                       |   2 +-
>  fs/afs/dynroot.c                      |   6 +-
>  fs/afs/inode.c                        |   6 +-
>  fs/bcachefs/fs.c                      |   8 +-
>  fs/befs/linuxvfs.c                    |   2 +-
>  fs/bfs/inode.c                        |   2 +-
>  fs/btrfs/inode.c                      |  10 +--
>  fs/buffer.c                           |   4 +-
>  fs/ceph/cache.c                       |   2 +-
>  fs/ceph/crypto.c                      |   4 +-
>  fs/ceph/file.c                        |   4 +-
>  fs/ceph/inode.c                       |  28 +++---
>  fs/coda/cnode.c                       |   4 +-
>  fs/cramfs/inode.c                     |   2 +-
>  fs/crypto/keyring.c                   |   2 +-
>  fs/crypto/keysetup.c                  |   2 +-
>  fs/dcache.c                           |   8 +-
>  fs/drop_caches.c                      |   2 +-
>  fs/ecryptfs/inode.c                   |   6 +-
>  fs/efs/inode.c                        |   2 +-
>  fs/erofs/inode.c                      |   2 +-
>  fs/ext2/inode.c                       |   2 +-
>  fs/ext4/inode.c                       |  10 +--
>  fs/ext4/orphan.c                      |   4 +-
>  fs/f2fs/data.c                        |   2 +-
>  fs/f2fs/inode.c                       |   2 +-
>  fs/f2fs/namei.c                       |   4 +-
>  fs/f2fs/super.c                       |   2 +-
>  fs/freevxfs/vxfs_inode.c              |   2 +-
>  fs/fs-writeback.c                     | 123 +++++++++++++-------------
>  fs/fuse/inode.c                       |   4 +-
>  fs/gfs2/file.c                        |   2 +-
>  fs/gfs2/glops.c                       |   2 +-
>  fs/gfs2/inode.c                       |   4 +-
>  fs/gfs2/ops_fstype.c                  |   2 +-
>  fs/hfs/btree.c                        |   2 +-
>  fs/hfs/inode.c                        |   2 +-
>  fs/hfsplus/super.c                    |   2 +-
>  fs/hostfs/hostfs_kern.c               |   2 +-
>  fs/hpfs/dir.c                         |   2 +-
>  fs/hpfs/inode.c                       |   2 +-
>  fs/inode.c                            | 100 ++++++++++-----------
>  fs/isofs/inode.c                      |   2 +-
>  fs/jffs2/fs.c                         |   4 +-
>  fs/jfs/file.c                         |   4 +-
>  fs/jfs/inode.c                        |   2 +-
>  fs/jfs/jfs_txnmgr.c                   |   2 +-
>  fs/kernfs/inode.c                     |   2 +-
>  fs/libfs.c                            |   6 +-
>  fs/minix/inode.c                      |   2 +-
>  fs/namei.c                            |   8 +-
>  fs/netfs/misc.c                       |   8 +-
>  fs/netfs/read_single.c                |   6 +-
>  fs/nfs/inode.c                        |   2 +-
>  fs/nfs/pnfs.c                         |   2 +-
>  fs/nfsd/vfs.c                         |   2 +-
>  fs/nilfs2/cpfile.c                    |   2 +-
>  fs/nilfs2/dat.c                       |   2 +-
>  fs/nilfs2/ifile.c                     |   2 +-
>  fs/nilfs2/inode.c                     |  10 +--
>  fs/nilfs2/sufile.c                    |   2 +-
>  fs/notify/fsnotify.c                  |   2 +-
>  fs/ntfs3/inode.c                      |   2 +-
>  fs/ocfs2/dlmglue.c                    |   2 +-
>  fs/ocfs2/inode.c                      |  10 +--
>  fs/omfs/inode.c                       |   2 +-
>  fs/openpromfs/inode.c                 |   2 +-
>  fs/orangefs/inode.c                   |   2 +-
>  fs/orangefs/orangefs-utils.c          |   6 +-
>  fs/overlayfs/dir.c                    |   2 +-
>  fs/overlayfs/inode.c                  |   6 +-
>  fs/overlayfs/util.c                   |  10 +--
>  fs/pipe.c                             |   2 +-
>  fs/qnx4/inode.c                       |   2 +-
>  fs/qnx6/inode.c                       |   2 +-
>  fs/quota/dquot.c                      |   2 +-
>  fs/romfs/super.c                      |   2 +-
>  fs/smb/client/cifsfs.c                |   2 +-
>  fs/smb/client/inode.c                 |  14 +--
>  fs/squashfs/inode.c                   |   2 +-
>  fs/sync.c                             |   2 +-
>  fs/ubifs/file.c                       |   2 +-
>  fs/ubifs/super.c                      |   2 +-
>  fs/udf/inode.c                        |   2 +-
>  fs/ufs/inode.c                        |   2 +-
>  fs/xfs/scrub/common.c                 |   2 +-
>  fs/xfs/scrub/inode_repair.c           |   2 +-
>  fs/xfs/scrub/parent.c                 |   2 +-
>  fs/xfs/xfs_bmap_util.c                |   2 +-
>  fs/xfs/xfs_health.c                   |   4 +-
>  fs/xfs/xfs_icache.c                   |   6 +-
>  fs/xfs/xfs_inode.c                    |   6 +-
>  fs/xfs/xfs_inode_item.c               |   4 +-
>  fs/xfs/xfs_iops.c                     |   2 +-
>  fs/xfs/xfs_reflink.h                  |   2 +-
>  fs/zonefs/super.c                     |   4 +-
>  include/linux/backing-dev.h           |   7 +-
>  include/linux/fs.h                    |  42 ++++++++-
>  include/linux/writeback.h             |   4 +-
>  include/trace/events/writeback.h      |   8 +-
>  mm/backing-dev.c                      |   2 +-
>  security/landlock/fs.c                |   2 +-
>  107 files changed, 345 insertions(+), 307 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

