Return-Path: <linux-fsdevel+bounces-28717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC396D633
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A311C234C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A007F198E78;
	Thu,  5 Sep 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zagojlb0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7FfrRaLJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zagojlb0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7FfrRaLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B131EBFEC;
	Thu,  5 Sep 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532601; cv=none; b=qt5nZnY2teZRg90EAGdqah4VfNIigzRy9vOZDG73W+8HRMqeltI/l9ZQcGBlltyva8ua3xEN0c08ObrhfPZnmREi0aPl7qMlFAJ8P4Jd3dfeBZuY71MppQq46oAqvqULuTuyFNe0yaoPNuAOVm8BladdiEaW+gB4x1vF1quFX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532601; c=relaxed/simple;
	bh=yENuZN46jPjIVz0FxqHcz+reBuR2EX4khOhF4z9jrCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0KP/ok05RnB1wgIf0DXsvG/7LXeWLBeux/s5V8oFOrsVUMhIHqj7h6xLmhQDTXGJnVt4qjoLWgsnZ5L0Rpz7OPVVuoVOysDPTBC+aVpWwRKEmQrVkHhJyyxKM+MVYlueGTTBlLy6jORKECRobS5qEtGwSYTP3815qOoHoHYJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zagojlb0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7FfrRaLJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zagojlb0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7FfrRaLJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EE991F811;
	Thu,  5 Sep 2024 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725532597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrQ0eAQTSx7Dllj1ZbCTVu1ER+Z69NqSE9+1bil57/I=;
	b=Zagojlb0zmOSGJriBxxrS+96q1e3kE+rv1+FU1j/ouhm7jOrCVpFUuQ5FSU22TBKSwqWwY
	CTtrysg/NWbIEMCAFu+Qw6Scdpi+6HPf5TZzgdILHFryKMMUb917dN/hm9sJDMxSZFbrdz
	S98FAUW9qnD7l7i5NG5OLJDcN1CQLcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725532597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrQ0eAQTSx7Dllj1ZbCTVu1ER+Z69NqSE9+1bil57/I=;
	b=7FfrRaLJZuzdNayTP8lgi8DRLk7W+0tiG8Qlohu3IhqEgNYN/VDaiX7PhcGP92rJByJUMl
	0HwJKuZIo39LfiAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725532597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrQ0eAQTSx7Dllj1ZbCTVu1ER+Z69NqSE9+1bil57/I=;
	b=Zagojlb0zmOSGJriBxxrS+96q1e3kE+rv1+FU1j/ouhm7jOrCVpFUuQ5FSU22TBKSwqWwY
	CTtrysg/NWbIEMCAFu+Qw6Scdpi+6HPf5TZzgdILHFryKMMUb917dN/hm9sJDMxSZFbrdz
	S98FAUW9qnD7l7i5NG5OLJDcN1CQLcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725532597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrQ0eAQTSx7Dllj1ZbCTVu1ER+Z69NqSE9+1bil57/I=;
	b=7FfrRaLJZuzdNayTP8lgi8DRLk7W+0tiG8Qlohu3IhqEgNYN/VDaiX7PhcGP92rJByJUMl
	0HwJKuZIo39LfiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 521DE139D2;
	Thu,  5 Sep 2024 10:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +bEJFLWJ2WbHTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 10:36:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05F53A0968; Thu,  5 Sep 2024 12:36:21 +0200 (CEST)
Date: Thu, 5 Sep 2024 12:36:21 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, jack@suse.cz, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 18/18] fs: enable pre-content events on supported file
 systems
Message-ID: <20240905103621.abnoeibagmxyu5pp@quack3>
References: <cover.1725481503.git.josef@toxicpanda.com>
 <33151057684a62a89b45466d53671c6232c34a68.1725481503.git.josef@toxicpanda.com>
 <CAOQ4uxgaLY+EQCdGqr+yPsBuRh3uMe2DGLqXrBmC=hvDYBo23A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgaLY+EQCdGqr+yPsBuRh3uMe2DGLqXrBmC=hvDYBo23A@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 05-09-24 10:27:52, Amir Goldstein wrote:
> On Wed, Sep 4, 2024 at 10:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Now that all the code has been added for pre-content events, and the
> > various file systems that need the page fault hooks for fsnotify have
> > been updated, add FS_ALLOW_HSM to the currently tested file systems.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> I would not be devastated if this patch remains as is,
> but I think it would be nicer to:
> 1. Move it before the fs specific patches
> 2. Set the HSM flag only on ext*
> 3. Add the HSM flag in other fs specific patches

I agree that doing this inside the patch where we tweak its functions to
properly support HSM would be more natural. And then only ext4 will remain
here. I guess I'll do this on commit.

								Honza

> 
> Thanks,
> Amir.
> 
> > ---
> >  fs/bcachefs/fs.c   | 2 +-
> >  fs/btrfs/super.c   | 3 ++-
> >  fs/ext4/super.c    | 6 +++---
> >  fs/xfs/xfs_super.c | 2 +-
> >  4 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > index 3a5f49affa0a..f889a105643b 100644
> > --- a/fs/bcachefs/fs.c
> > +++ b/fs/bcachefs/fs.c
> > @@ -2124,7 +2124,7 @@ static struct file_system_type bcache_fs_type = {
> >         .name                   = "bcachefs",
> >         .init_fs_context        = bch2_init_fs_context,
> >         .kill_sb                = bch2_kill_sb,
> > -       .fs_flags               = FS_REQUIRES_DEV,
> > +       .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_HSM,
> >  };
> >
> >  MODULE_ALIAS_FS("bcachefs");
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 0eda8c21d861..201ed90a6083 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -2193,7 +2193,8 @@ static struct file_system_type btrfs_fs_type = {
> >         .init_fs_context        = btrfs_init_fs_context,
> >         .parameters             = btrfs_fs_parameters,
> >         .kill_sb                = btrfs_kill_super,
> > -       .fs_flags               = FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
> > +       .fs_flags               = FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
> > +                                 FS_ALLOW_IDMAP | FS_ALLOW_HSM,
> >   };
> >
> >  MODULE_ALIAS_FS("btrfs");
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index e72145c4ae5a..a042216fb370 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -137,7 +137,7 @@ static struct file_system_type ext2_fs_type = {
> >         .init_fs_context        = ext4_init_fs_context,
> >         .parameters             = ext4_param_specs,
> >         .kill_sb                = ext4_kill_sb,
> > -       .fs_flags               = FS_REQUIRES_DEV,
> > +       .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_HSM,
> >  };
> >  MODULE_ALIAS_FS("ext2");
> >  MODULE_ALIAS("ext2");
> > @@ -153,7 +153,7 @@ static struct file_system_type ext3_fs_type = {
> >         .init_fs_context        = ext4_init_fs_context,
> >         .parameters             = ext4_param_specs,
> >         .kill_sb                = ext4_kill_sb,
> > -       .fs_flags               = FS_REQUIRES_DEV,
> > +       .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_HSM,
> >  };
> >  MODULE_ALIAS_FS("ext3");
> >  MODULE_ALIAS("ext3");
> > @@ -7298,7 +7298,7 @@ static struct file_system_type ext4_fs_type = {
> >         .init_fs_context        = ext4_init_fs_context,
> >         .parameters             = ext4_param_specs,
> >         .kill_sb                = ext4_kill_sb,
> > -       .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > +       .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_ALLOW_HSM,
> >  };
> >  MODULE_ALIAS_FS("ext4");
> >
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 27e9f749c4c7..04a6ec7bc2ae 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -2052,7 +2052,7 @@ static struct file_system_type xfs_fs_type = {
> >         .init_fs_context        = xfs_init_fs_context,
> >         .parameters             = xfs_fs_parameters,
> >         .kill_sb                = xfs_kill_sb,
> > -       .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > +       .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_ALLOW_HSM,
> >  };
> >  MODULE_ALIAS_FS("xfs");
> >
> > --
> > 2.43.0
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

