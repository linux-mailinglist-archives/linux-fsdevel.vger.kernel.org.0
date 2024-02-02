Return-Path: <linux-fsdevel+bounces-9999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B596846EC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F0E1F2770C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130413DB86;
	Fri,  2 Feb 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIClvloQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058647F78;
	Fri,  2 Feb 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872623; cv=none; b=i8OC3HwIAcQLCUQvYIIhpocvqr7QYvdkwKeEn5rZpUR5r1uUk4wC0RcJMIQB2gPjL1mXxzkvfaU+BF8ejAXoQ0X7+jOC841jamO8CSBhhqR5GJfyiNgZ80KcEmcKPMqnC/KAYuzXRzqN8mENNfE2HfH6Ur4tFmeuACBkvyu2ytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872623; c=relaxed/simple;
	bh=FCOQ3oxfwys8se6zxDBVnjGUrQ0D43QqafAIstBsJ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW5RgozmrnQ3pKS8CLKjnYgWhW9NIXk2Weoy3c5IhG7Dw3tlLq/UhF5nZQ8nANs0DQ6GAyMtyLgx3GiKWvngya6VLk3l4qGGPezq+Zu0z/XJjHCxC4KVhzahkVLDtYCluvffqUXRSDhwkG5i5cmgfqyYvDoepAjW2lFPBr79dtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIClvloQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0642EC433C7;
	Fri,  2 Feb 2024 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706872622;
	bh=FCOQ3oxfwys8se6zxDBVnjGUrQ0D43QqafAIstBsJ2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIClvloQZ1M129peATTtWb6atela5X7cYHFsZrb67lwZ1vtHh1l4IF6scBTjv/PzB
	 87X+qdn9IaowdLggFLz78Dw2QGQYzTGTKYlYjesUecF7SKGmXP3K7d4MiNpysRK0C4
	 t1j6G+/iD6LfqO1isYZWLf7PzibnKlRmHEvbs7+NgM3HuNE42GCI1Q9GRAefkReH7D
	 h1xPrbjqj6a/OYMEAXoJHIZOoDahFAwploUpVgqALFamW0OGHq4qX5LWxM1UPydgH/
	 YFeXyS+Ct198tCxuXtgduVxQagdX4vudq08ofGv4NLeAgh6fW/WoGrhSFTAIx7hFzB
	 9jJR67v3JsAHQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 00/47] filelock: split file leases out of struct file_lock
Date: Fri,  2 Feb 2024 12:16:44 +0100
Message-ID: <20240202-neigung-ergiebig-9e4a18e7afa3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=7495; i=brauner@kernel.org; h=from:subject:message-id; bh=FCOQ3oxfwys8se6zxDBVnjGUrQ0D43QqafAIstBsJ2g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTuOS+797jkjleqZtyND8RfphxXTPnGFqfbdXTF9ZorU m3xJaVmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMp/szIsFSbbfeTWHs/ozKH C7Ehv34yMCgvm1q6s+pDttikJ9sudzD8d1F9tTlx75EtAWdeGenLRlVo7ZEr/xU0sd55YRk/75c /7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 18:01:41 -0500, Jeff Layton wrote:
> I'm not sure this is much prettier than the last, but contracting
> "fl_core" to "c", as Neil suggested is a bit easier on the eyes.
> 
> I also added a few small helpers and converted several users over to
> them. That reduces the size of the per-fs conversion patches later in
> the series. I played with some others too, but they were too awkward
> or not frequently used enough to make it worthwhile.
> 
> [...]

Fyi, I've merged this series as in I've turned this series into a pull
request based on the patches. And this has a merge commit of the
following form:

commit 363af2435e403ac323ab2543da91f5984047bdb8
Merge: 6613476e225e 6c6109548454
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Fri Feb 2 12:09:26 2024 +0100
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Fri Feb 2 12:09:26 2024 +0100

    Merge patch series "filelock: split file leases out of struct file_lock"

    Pull file locking patch series from Jeff Layton:

For larger series such as this this is what I think we should end up
doing because it gives bigger series an overall summary without forcing
the author to always provide a tag or branch or whatever. Often the
cover letter description is good for long term contributors already. So
I stole most of it from v1.

Thanks for basing this on a mainline tag!

---

Applied to the vfs.file branch of the vfs/vfs.git tree.
Patches in the vfs.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.file

[01/47] filelock: fl_pid field should be signed int
        https://git.kernel.org/vfs/vfs/c/0e9876d8e88d
[02/47] filelock: rename some fields in tracepoints
        https://git.kernel.org/vfs/vfs/c/587a67b6830b
[03/47] filelock: rename fl_pid variable in lock_get_status
        https://git.kernel.org/vfs/vfs/c/6021d62c677f
[04/47] filelock: add some new helper functions
        https://git.kernel.org/vfs/vfs/c/403594111407
[05/47] 9p: rename fl_type variable in v9fs_file_do_lock
        https://git.kernel.org/vfs/vfs/c/2911c0e3a5dd
[06/47] afs: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/46a9b98baecc
[07/47] ceph: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/7c82f3103915
[08/47] dlm: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/7851cb526662
[09/47] gfs2: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/47bc8fa51b46
[10/47] lockd: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/b9570e87b652
[11/47] nfs: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/28ad1884a338
[12/47] nfsd: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/4e2cd366d826
[13/47] ocfs2: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/a336b91b2340
[14/47] smb/client: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/39647541cb26
[15/47] smb/server: convert to using new filelock helpers
        https://git.kernel.org/vfs/vfs/c/1d9b1c4525f6
[16/47] filelock: drop the IS_* macros
        https://git.kernel.org/vfs/vfs/c/22716eba8323
[17/47] filelock: split common fields into struct file_lock_core
        https://git.kernel.org/vfs/vfs/c/b2566e35e7d6
[18/47] filelock: have fs/locks.c deal with file_lock_core directly
        https://git.kernel.org/vfs/vfs/c/424dc929f8f1
[19/47] filelock: convert more internal functions to use file_lock_core
        https://git.kernel.org/vfs/vfs/c/2d1cfb3cf69e
[20/47] filelock: make posix_same_owner take file_lock_core pointers
        https://git.kernel.org/vfs/vfs/c/c91b6f218894
[21/47] filelock: convert posix_owner_key to take file_lock_core arg
        https://git.kernel.org/vfs/vfs/c/6944d789d1a1
[22/47] filelock: make locks_{insert,delete}_global_locks take file_lock_core arg
        https://git.kernel.org/vfs/vfs/c/ff30006ce158
[23/47] filelock: convert locks_{insert,delete}_global_blocked
        https://git.kernel.org/vfs/vfs/c/b7ae01bb4138
[24/47] filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core
        https://git.kernel.org/vfs/vfs/c/6ada65e99171
[25/47] filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core
        https://git.kernel.org/vfs/vfs/c/f449edd19f07
[26/47] filelock: convert fl_blocker to file_lock_core
        https://git.kernel.org/vfs/vfs/c/9bb41e6b6ea5
[27/47] filelock: clean up locks_delete_block internals
        https://git.kernel.org/vfs/vfs/c/78d1567cb873
[28/47] filelock: reorganize locks_delete_block and __locks_insert_block
        https://git.kernel.org/vfs/vfs/c/b261e8d3d5eb
[29/47] filelock: make assign_type helper take a file_lock_core pointer
        https://git.kernel.org/vfs/vfs/c/ae37275d53ed
[30/47] filelock: convert locks_wake_up_blocks to take a file_lock_core pointer
        https://git.kernel.org/vfs/vfs/c/acd1c6f76c17
[31/47] filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
        https://git.kernel.org/vfs/vfs/c/77d7ed489db4
[32/47] filelock: convert locks_translate_pid to take file_lock_core
        https://git.kernel.org/vfs/vfs/c/e2c23bf73104
[33/47] filelock: convert seqfile handling to use file_lock_core
        https://git.kernel.org/vfs/vfs/c/a15d945405a3
[34/47] 9p: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/d09f798f208c
[35/47] afs: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/febb326af51b
[36/47] ceph: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/afd5898079d2
[37/47] dlm: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/f40b314ab0f2
[38/47] gfs2: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/f1b0d238e179
[39/47] fuse: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/ca2a24a9ff7f
[40/47] lockd: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/1c910b2459cf
[41/47] nfs: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/455100f41471
[42/47] nfsd: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/48c7900f7b21
[43/47] ocfs2: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/b7b8c39a9587
[44/47] smb/client: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/7cd03c482447
[45/47] smb/server: adapt to breakup of struct file_lock
        https://git.kernel.org/vfs/vfs/c/5087b21fd5ee
[46/47] filelock: remove temporary compatibility macros
        https://git.kernel.org/vfs/vfs/c/e0bde6d6d7e3
[47/47] filelock: split leases out of struct file_lock
        https://git.kernel.org/vfs/vfs/c/6c6109548454

