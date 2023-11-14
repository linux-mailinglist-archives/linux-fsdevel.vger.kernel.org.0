Return-Path: <linux-fsdevel+bounces-2815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C6D7EA9AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF9E28109C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 04:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90278F51;
	Tue, 14 Nov 2023 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gi21ZqN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6838827;
	Tue, 14 Nov 2023 04:41:20 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA42198;
	Mon, 13 Nov 2023 20:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=O76q8kXtMpRQfEz4vWxJaQRBpseXEFxko6RxuL68OhA=; b=Gi21ZqN1N2i+WUUvrObWDFXRKc
	j2hzEMwLd09wJ3aha5hMBJECaqQhp2Ti5i+j/2696xXY5dKjhhAQ9Gek7oURbIvMYdcQsJkcAI7Cz
	kQUb56A4Fm85qumyHF1uUx1+Wc/RI0+trV90BWAP/Fi6X35iS6toG0msjEkAes40FIB+mzgG24Nmc
	N7RBfWoAbrkdq7TeyuIdIr9BgC288r6U9/cXBRsEhA4DB6L+m+mozKPjoAWdEvbwe7LJwwrQw5iqH
	wC5cra1gMILp4at/A8kh2qY01tthkGpp1yNkqDcaFhU3kOxPxf+N90zMC2PxlSRuvXpNpsUDa85Av
	VfncpiiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r2lEc-00FX05-1G;
	Tue, 14 Nov 2023 04:41:10 +0000
Date: Tue, 14 Nov 2023 04:41:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
	autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
Message-ID: <20231114044110.GR1957730@ZenIV>
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 14, 2023 at 12:25:35PM +0800, Ian Kent wrote:
> >         root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> > +       if (!root_inode)
> > +               goto fail;
> 
> Yes, I think this is the only thing it could be.
> 
> There's one small problem though, it leaks the dentry info. ino,
> allocated just above. I think this should goto label fail_ino instead.
> 
> Note that once the root dentry is allocated then the ino struct will
> be freed when the dentry is freed so ino doesn't need to be freed.

There's a simpler solution:

        root_inode = autofs_get_inode(s, S_IFDIR | 0755);
	if (root_inode) {
		root_inode->i_uid = ctx->uid;
		root_inode->i_gid = ctx->gid;
	}
        root = d_make_root(root_inode);
        if (!root)
                goto fail_ino;

d_make_root(NULL) will quietly return NULL, which is all you
need.  FWIW, I would probably bring the rest of initialization
        root_inode->i_fop = &autofs_root_operations;
        root_inode->i_op = &autofs_dir_inode_operations;
in there as well.

Incidentally, why bother with separate fail_dput thing?  Shove it
into ->s_root and return ret - autofs_kill_sb() will take care
of dropping it...

How about the following:
static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
{
	struct autofs_fs_context *ctx = fc->fs_private;
	struct autofs_sb_info *sbi = s->s_fs_info;
	struct inode *root_inode;
	struct autofs_info *ino;

	pr_debug("starting up, sbi = %p\n", sbi);

	sbi->sb = s;
	s->s_blocksize = 1024;
	s->s_blocksize_bits = 10;
	s->s_magic = AUTOFS_SUPER_MAGIC;
	s->s_op = &autofs_sops;
	s->s_d_op = &autofs_dentry_operations;
	s->s_time_gran = 1;

	/*
	 * Get the root inode and dentry, but defer checking for errors.
	 */
	ino = autofs_new_ino(sbi);
	if (!ino)
		return -ENOMEM;

	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
	if (root_inode) {
		root_inode->i_uid = ctx->uid;
		root_inode->i_gid = ctx->gid;
		root_inode->i_fop = &autofs_root_operations;
		root_inode->i_op = &autofs_dir_inode_operations;
	}
	s->s_root = d_make_root(root_inode);
	if (unlikely(!s->s_root)) {
		autofs_free_ino(ino);
		return -ENOMEM;
	}
	s->s_root->d_fsdata = ino;

	if (ctx->pgrp_set) {
		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
		if (!sbi->oz_pgrp) {
			int ret = invalf(fc, "Could not find process group %d",
				     ctx->pgrp);
			return ret;
		}
	} else {
		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
	}

	if (autofs_type_trigger(sbi->type))
		managed_dentry_set_managed(s->s_root);

	pr_debug("pipe fd = %d, pgrp = %u\n",
		 sbi->pipefd, pid_nr(sbi->oz_pgrp));

	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
	return 0;
}

No gotos, no labels to keep track of...

