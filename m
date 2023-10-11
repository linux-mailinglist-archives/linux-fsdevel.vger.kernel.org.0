Return-Path: <linux-fsdevel+bounces-79-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F17C580D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055C828264C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4C208A6;
	Wed, 11 Oct 2023 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaZpnSME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016C208A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB8CC433C7;
	Wed, 11 Oct 2023 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697038063;
	bh=7RZyiacWyfzPvWEqzLgY4Ad7VtrgFG6HkGvT4m3kmO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaZpnSMEaI0DGU84iKsQFVVPvyC16VvEM8T5n460Au6MNQ/ww2lxz4UfQ+DA6vXFm
	 BCtrP7/qifoV3YuL88v5Z4hcMkOI/aOIq9hyegqYo11WsSBfpE1ueICf/cUBdDE9Bh
	 A+N2mupq/0QsAcz+XUx3VosdLofH9isxy1pRIIJNYMcYdcT28SYP9Ba8kkcZeNF5g0
	 ZNuBaGoPPHI6az5feLlT4O9rib8qxW48pAN9rCw9yaJHhnk2reRwFnoBTVt0Bu3F2a
	 V3k//nJlWORSya2SLRtvjvZ6ykCCdUchhQINAPcQQTeolGD+jWvQIO2+kVnB8rQERq
	 hqKdJxh8IxFnA==
Date: Wed, 11 Oct 2023 17:27:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Max Kellermann <max.kellermann@ionos.com>
Cc: Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011-braumeister-anrufen-62127dc64de0@brauner>
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com>
 <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011135922.4bij3ittlg4ujkd7@quack3>

On Wed, Oct 11, 2023 at 03:59:22PM +0200, Jan Kara wrote:
> On Wed 11-10-23 14:27:49, Max Kellermann wrote:
> > On Wed, Oct 11, 2023 at 2:18 PM Max Kellermann <max.kellermann@ionos.com> wrote:
> > > But without the other filesystems. I'll resend it with just the
> > > posix_acl.h hunk.
> > 
> > Thinking again, I don't think this is the proper solution. This may
> > server as a workaround so those broken filesystems don't suffer from
> > this bug, but it's not proper.
> > 
> > posix_acl_create() is only supposed to appy the umask if the inode
> > supports ACLs; if not, the VFS is supposed to do it. But if the
> > filesystem pretends to have ACL support but the kernel does not, it's
> > really a filesystem bug. Hacking the umask code into
> > posix_acl_create() for that inconsistent case doesn't sound right.
> > 
> > A better workaround would be this patch:
> > https://patchwork.kernel.org/project/linux-nfs/patch/151603744662.29035.4910161264124875658.stgit@rabbit.intern.cm-ag/
> > I submitted it more than 5 years ago, it got one positive review, but
> > was never merged.
> > 
> > This patch enables the VFS's umask code even if the filesystem
> > prerents to support ACLs. This still doesn't fix the filesystem bug,
> > but makes VFS's behavior consistent.
> 
> OK, that solution works for me as well. I agree it seems a tad bit cleaner.
> Christian, which one would you prefer?

So it always bugged me that POSIX ACLs push umask stripping down into
the individual filesystems but it's hard to get rid of this. And we
tried to improve the situation during the POSIX ACL rework by
introducing vfs_prepare_umask().

Aside from that, the problem had been that filesystems like nfs v4
intentionally raised SB_POSIXACL to prevent umask stripping in the VFS.
IOW, for them SB_POSIXACL was equivalent to "don't apply any umask".

And afaict nfs v4 has it's own thing going on how and where umasks are
applied. However, since we now have the following commit in vfs.misc:

commit f61b9bb3f8386a5e59b49bf1310f5b34f47bcef9
Author:     Jeff Layton <jlayton@kernel.org>
AuthorDate: Mon Sep 11 20:25:50 2023 -0400
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Thu Sep 21 15:37:47 2023 +0200

    fs: add a new SB_I_NOUMASK flag

    SB_POSIXACL must be set when a filesystem supports POSIX ACLs, but NFSv4
    also sets this flag to prevent the VFS from applying the umask on
    newly-created files. NFSv4 doesn't support POSIX ACLs however, which
    causes confusion when other subsystems try to test for them.

    Add a new SB_I_NOUMASK flag that allows filesystems to opt-in to umask
    stripping without advertising support for POSIX ACLs. Set the new flag
    on NFSv4 instead of SB_POSIXACL.

    Also, move mode_strip_umask to namei.h and convert init_mknod and
    init_mkdir to use it.

    Signed-off-by: Jeff Layton <jlayton@kernel.org>
    Message-Id: <20230911-acl-fix-v3-1-b25315333f6c@kernel.org>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

I think it's possible to pick up the first patch linked above:
   
fix umask on NFS with CONFIG_FS_POSIX_ACL=n doesn't lead to any

and see whether we see any regressions from this.

The second patch I can't easily judge that should go through nfs if at
all.

So proposal/question: should we take the first patch into vfs.misc?

