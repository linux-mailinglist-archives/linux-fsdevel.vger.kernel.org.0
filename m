Return-Path: <linux-fsdevel+bounces-91-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2057C591E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE17E1C20EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23E3D3BF;
	Wed, 11 Oct 2023 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHPjHzAx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1jExGE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B67208AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:29:08 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93B91;
	Wed, 11 Oct 2023 09:29:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 553701FF02;
	Wed, 11 Oct 2023 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697041745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYo77x54AzSd+UJL48y6CRA7yZ5+4RMlae1FSxp7kUY=;
	b=XHPjHzAxZGN8OAcbkRlJpzZcxSqh0PmgTt4npi1tF+csKiWIXSr22Q66FJM2N/QWXLTuWe
	8qU5i1XbtqtXqXqGt/BP2COPochp4eKiQbidoNtY9W7y4PLwiWnw+G09P8eyOvIpOvA4z+
	moXDGeLe/pOS1YzwKZ2VAtQlYMqPsxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697041745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYo77x54AzSd+UJL48y6CRA7yZ5+4RMlae1FSxp7kUY=;
	b=T1jExGE6EAUwcpMkNyi3OKySzAjG7myKC5zvA28x5gD6fljvVqNo3e5cwm9l9v5cfaJ+fM
	pqEjb6y8O4ZxlvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43D03134F5;
	Wed, 11 Oct 2023 16:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kvp+EFHNJmVlLQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 16:29:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9ED1A05BC; Wed, 11 Oct 2023 18:29:04 +0200 (CEST)
Date: Wed, 11 Oct 2023 18:29:04 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Max Kellermann <max.kellermann@ionos.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011162904.3dxkids7zzspcolp@quack3>
References: <20231009144340.418904-1-max.kellermann@ionos.com>
 <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011-braumeister-anrufen-62127dc64de0@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 11-10-23 17:27:37, Christian Brauner wrote:
> On Wed, Oct 11, 2023 at 03:59:22PM +0200, Jan Kara wrote:
> > On Wed 11-10-23 14:27:49, Max Kellermann wrote:
> > > On Wed, Oct 11, 2023 at 2:18 PM Max Kellermann <max.kellermann@ionos.com> wrote:
> > > > But without the other filesystems. I'll resend it with just the
> > > > posix_acl.h hunk.
> > > 
> > > Thinking again, I don't think this is the proper solution. This may
> > > server as a workaround so those broken filesystems don't suffer from
> > > this bug, but it's not proper.
> > > 
> > > posix_acl_create() is only supposed to appy the umask if the inode
> > > supports ACLs; if not, the VFS is supposed to do it. But if the
> > > filesystem pretends to have ACL support but the kernel does not, it's
> > > really a filesystem bug. Hacking the umask code into
> > > posix_acl_create() for that inconsistent case doesn't sound right.
> > > 
> > > A better workaround would be this patch:
> > > https://patchwork.kernel.org/project/linux-nfs/patch/151603744662.29035.4910161264124875658.stgit@rabbit.intern.cm-ag/
> > > I submitted it more than 5 years ago, it got one positive review, but
> > > was never merged.
> > > 
> > > This patch enables the VFS's umask code even if the filesystem
> > > prerents to support ACLs. This still doesn't fix the filesystem bug,
> > > but makes VFS's behavior consistent.
> > 
> > OK, that solution works for me as well. I agree it seems a tad bit cleaner.
> > Christian, which one would you prefer?
> 
> So it always bugged me that POSIX ACLs push umask stripping down into
> the individual filesystems but it's hard to get rid of this. And we
> tried to improve the situation during the POSIX ACL rework by
> introducing vfs_prepare_umask().
> 
> Aside from that, the problem had been that filesystems like nfs v4
> intentionally raised SB_POSIXACL to prevent umask stripping in the VFS.
> IOW, for them SB_POSIXACL was equivalent to "don't apply any umask".

Ah, what a hack...

> And afaict nfs v4 has it's own thing going on how and where umasks are
> applied. However, since we now have the following commit in vfs.misc:
> 
> commit f61b9bb3f8386a5e59b49bf1310f5b34f47bcef9
> Author:     Jeff Layton <jlayton@kernel.org>
> AuthorDate: Mon Sep 11 20:25:50 2023 -0400
> Commit:     Christian Brauner <brauner@kernel.org>
> CommitDate: Thu Sep 21 15:37:47 2023 +0200
> 
>     fs: add a new SB_I_NOUMASK flag
> 
>     SB_POSIXACL must be set when a filesystem supports POSIX ACLs, but NFSv4
>     also sets this flag to prevent the VFS from applying the umask on
>     newly-created files. NFSv4 doesn't support POSIX ACLs however, which
>     causes confusion when other subsystems try to test for them.
> 
>     Add a new SB_I_NOUMASK flag that allows filesystems to opt-in to umask
>     stripping without advertising support for POSIX ACLs. Set the new flag
>     on NFSv4 instead of SB_POSIXACL.
> 
>     Also, move mode_strip_umask to namei.h and convert init_mknod and
>     init_mkdir to use it.
> 
>     Signed-off-by: Jeff Layton <jlayton@kernel.org>
>     Message-Id: <20230911-acl-fix-v3-1-b25315333f6c@kernel.org>
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I think it's possible to pick up the first patch linked above:
>    
> fix umask on NFS with CONFIG_FS_POSIX_ACL=n doesn't lead to any
> 
> and see whether we see any regressions from this.
> 
> The second patch I can't easily judge that should go through nfs if at
> all.
> 
> So proposal/question: should we take the first patch into vfs.misc?

Sounds good to me. I have checked whether some other filesystem does not
try to play similar games as NFS and it appears not although overlayfs does
seem to play some games with umasks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

