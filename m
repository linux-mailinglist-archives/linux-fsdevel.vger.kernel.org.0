Return-Path: <linux-fsdevel+bounces-35463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516499D506E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B97282FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A7C487A7;
	Thu, 21 Nov 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmnS+lJo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IUQgtJw4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e7bfvoUm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RNxPCw7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DE155CBF;
	Thu, 21 Nov 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205082; cv=none; b=mwcQsvhbjry0Iy+8o8KuZUrXc2h98RUua/cKiIX+gVOKOFYPymFPbXTfR45zTk+uALWLnvGb5pksIjlqT0G6uXIeeEglvkP0Rcj+XH0P68uzz7nEjrnBsIv6TDUADcGWA/ap1pI3W0qUhbT1AqXLpKrVCtkvlLKzp3Mu8A8961Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205082; c=relaxed/simple;
	bh=fAH8jEz/dLOykIJUZbAzrLo6nOAluy4XwygNCqRLxNM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tr3kJ+uHUJdTeZIRgdEVWR3jkCJKIILerBzVRgOGNEShidYglm8QGjt/nGvpdqYRPwS4+V9CC60fV2jJxTNh+v26FVynNfSW2HMnR0+i18Pqos1ep8CdBhhT+td4KogF5EECSwl89n5ShFC1SVuNyuqFal4iW/X+mDC8cMHq+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmnS+lJo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IUQgtJw4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e7bfvoUm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RNxPCw7f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3D8521A14;
	Thu, 21 Nov 2024 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732205078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=lubBdRES4nIMJWv3O+HXFDvpQzGdY+7PDzXZ4xU9kgk=;
	b=lmnS+lJonypEqaQd63X5BeiqFee+joLfkFu7wm5plF6pn4wkwIeW31ySPXR3skwPYr4v+N
	kHo8MPzMtdU4sgFbTj8bqFBvikhCaygWIi+0qKMkraqrCYSdZOHKIvOUrF5FQkvo0NsO7K
	eypmAfZ3VUtjj29PSMXyiHrI9YooEkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732205078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=lubBdRES4nIMJWv3O+HXFDvpQzGdY+7PDzXZ4xU9kgk=;
	b=IUQgtJw4v8mAk2+1atKVAIPGnWz3sPAvGmbttJhimcUv3t5PZcOA3l7QWb1yct+HcK8K2E
	I+FdQ4pV2HzaM3Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e7bfvoUm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RNxPCw7f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732205077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=lubBdRES4nIMJWv3O+HXFDvpQzGdY+7PDzXZ4xU9kgk=;
	b=e7bfvoUmWvqOd91wJlvDTADLeHVo1a+jZib4GqZjGTrGjeRzk+iUr57KIbttxJp0zsaR1B
	UaT/n7S6spMLxYiXe/ysjimvAczu591lCkg6jaD+rT6egjgbY+s3j4mf8mZOAaZr2faMUg
	pP+Or+JxJbQHpzxTwHlDp14ErEile8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732205077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=lubBdRES4nIMJWv3O+HXFDvpQzGdY+7PDzXZ4xU9kgk=;
	b=RNxPCw7fZV9BC5mQbmCe3dwwQ7NUzRP+Ljfed4dnxdc2TxvoGU79vYg0IrkV99lVuNHVHV
	aJ+rd+Fvx9/YXYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D791013927;
	Thu, 21 Nov 2024 16:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A+KdNBVaP2cnWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 16:04:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86B38A08A2; Thu, 21 Nov 2024 17:04:33 +0100 (CET)
Date: Thu, 21 Nov 2024 17:04:33 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: [GIT PULL] Remove reiserfs
Message-ID: <20241121160433.2xoi3lorp3y3rows@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: E3D8521A14
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git reiserfs_delete

The deprecation period of reiserfs is ending at the end of this year so it
is time to remove it.

Top of the tree is fb6f20ecb121. The full shortlog is:

Jan Kara (1):
      reiserfs: The last commit

The diffstat is

 Documentation/filesystems/porting.rst              |    2 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +-
 MAINTAINERS                                        |    5 -
 arch/alpha/configs/defconfig                       |    1 -
 arch/arm/configs/pxa_defconfig                     |    4 -
 arch/m68k/configs/amiga_defconfig                  |    1 -
 arch/m68k/configs/apollo_defconfig                 |    1 -
 arch/m68k/configs/atari_defconfig                  |    1 -
 arch/m68k/configs/bvme6000_defconfig               |    1 -
 arch/m68k/configs/hp300_defconfig                  |    1 -
 arch/m68k/configs/mac_defconfig                    |    1 -
 arch/m68k/configs/multi_defconfig                  |    1 -
 arch/m68k/configs/mvme147_defconfig                |    1 -
 arch/m68k/configs/mvme16x_defconfig                |    1 -
 arch/m68k/configs/q40_defconfig                    |    1 -
 arch/m68k/configs/sun3_defconfig                   |    1 -
 arch/m68k/configs/sun3x_defconfig                  |    1 -
 arch/sh/configs/landisk_defconfig                  |    1 -
 arch/sh/configs/titan_defconfig                    |    1 -
 arch/um/configs/i386_defconfig                     |    1 -
 arch/um/configs/x86_64_defconfig                   |    1 -
 drivers/block/Kconfig                              |    2 +-
 fs/Kconfig                                         |    1 -
 fs/Makefile                                        |    1 -
 fs/buffer.c                                        |    3 +-
 fs/quota/Kconfig                                   |   15 +-
 fs/reiserfs/Kconfig                                |   91 -
 fs/reiserfs/Makefile                               |   30 -
 fs/reiserfs/README                                 |  151 -
 fs/reiserfs/acl.h                                  |   78 -
 fs/reiserfs/bitmap.c                               | 1476 -------
 fs/reiserfs/dir.c                                  |  346 --
 fs/reiserfs/do_balan.c                             | 1900 ---------
 fs/reiserfs/file.c                                 |  270 --
 fs/reiserfs/fix_node.c                             | 2822 -------------
 fs/reiserfs/hashes.c                               |  177 -
 fs/reiserfs/ibalance.c                             | 1161 ------
 fs/reiserfs/inode.c                                | 3416 ---------------
 fs/reiserfs/ioctl.c                                |  221 -
 fs/reiserfs/item_ops.c                             |  737 ----
 fs/reiserfs/journal.c                              | 4404 --------------------
 fs/reiserfs/lbalance.c                             | 1426 -------
 fs/reiserfs/lock.c                                 |  101 -
 fs/reiserfs/namei.c                                | 1725 --------
 fs/reiserfs/objectid.c                             |  216 -
 fs/reiserfs/prints.c                               |  792 ----
 fs/reiserfs/procfs.c                               |  490 ---
 fs/reiserfs/reiserfs.h                             | 3419 ---------------
 fs/reiserfs/resize.c                               |  230 -
 fs/reiserfs/stree.c                                | 2280 ----------
 fs/reiserfs/super.c                                | 2646 ------------
 fs/reiserfs/tail_conversion.c                      |  318 --
 fs/reiserfs/xattr.c                                | 1039 -----
 fs/reiserfs/xattr.h                                |  117 -
 fs/reiserfs/xattr_acl.c                            |  411 --
 fs/reiserfs/xattr_security.c                       |  127 -
 fs/reiserfs/xattr_trusted.c                        |   46 -
 fs/reiserfs/xattr_user.c                           |   43 -
 include/uapi/linux/reiserfs_fs.h                   |   27 -
 include/uapi/linux/reiserfs_xattr.h                |   25 -
 scripts/selinux/mdp/mdp.c                          |    3 -
 tools/objtool/noreturns.h                          |    1 -
 .../filesystems/statmount/statmount_test.c         |    2 +-
 63 files changed, 12 insertions(+), 32804 deletions(-)
 delete mode 100644 fs/reiserfs/Kconfig
 delete mode 100644 fs/reiserfs/Makefile
 delete mode 100644 fs/reiserfs/README
 delete mode 100644 fs/reiserfs/acl.h
 delete mode 100644 fs/reiserfs/bitmap.c
 delete mode 100644 fs/reiserfs/dir.c
 delete mode 100644 fs/reiserfs/do_balan.c
 delete mode 100644 fs/reiserfs/file.c
 delete mode 100644 fs/reiserfs/fix_node.c
 delete mode 100644 fs/reiserfs/hashes.c
 delete mode 100644 fs/reiserfs/ibalance.c
 delete mode 100644 fs/reiserfs/inode.c
 delete mode 100644 fs/reiserfs/ioctl.c
 delete mode 100644 fs/reiserfs/item_ops.c
 delete mode 100644 fs/reiserfs/journal.c
 delete mode 100644 fs/reiserfs/lbalance.c
 delete mode 100644 fs/reiserfs/lock.c
 delete mode 100644 fs/reiserfs/namei.c
 delete mode 100644 fs/reiserfs/objectid.c
 delete mode 100644 fs/reiserfs/prints.c
 delete mode 100644 fs/reiserfs/procfs.c
 delete mode 100644 fs/reiserfs/reiserfs.h
 delete mode 100644 fs/reiserfs/resize.c
 delete mode 100644 fs/reiserfs/stree.c
 delete mode 100644 fs/reiserfs/super.c
 delete mode 100644 fs/reiserfs/tail_conversion.c
 delete mode 100644 fs/reiserfs/xattr.c
 delete mode 100644 fs/reiserfs/xattr.h
 delete mode 100644 fs/reiserfs/xattr_acl.c
 delete mode 100644 fs/reiserfs/xattr_security.c
 delete mode 100644 fs/reiserfs/xattr_trusted.c
 delete mode 100644 fs/reiserfs/xattr_user.c
 delete mode 100644 include/uapi/linux/reiserfs_fs.h
 delete mode 100644 include/uapi/linux/reiserfs_xattr.h

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

