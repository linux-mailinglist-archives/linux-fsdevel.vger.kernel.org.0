Return-Path: <linux-fsdevel+bounces-8095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81882F702
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E338B2212D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4264CE0;
	Tue, 16 Jan 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE0PHYDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DA64CF8;
	Tue, 16 Jan 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434407; cv=none; b=MijsS1sfewAe8pwJUtPdfU1g3bcek+nmm7vRRfQk2/jpZeDcEHGldhgxDBgfK4Cu3mIT7zYklMzntLOrSsoEM2MSSewzoX8Lm4pl8AfHI4g4+pcby210Dic1jj3BQ/cH8AWdst98IxxQ91dwFjXNlst31Fq9shMWRsWXdA/2OHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434407; c=relaxed/simple;
	bh=+jfAumQNnkzv9I79/OPpoM4LCmBymLZ6ObiQOrhxH0w=;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key; b=jwyESINJp2XXgW4X8n2dOZ1+QqMjD84rLBTHv+1DFvXBwTDp1yj6nd/vEGI+mdcLtQcGYdNPW0TMcDY2TVqLiSaTkxVtJLXbx0dfmgYN7y6ig/rvSuFLwTIe69dwiOEHVOzixkV9mcPZtsKc0fLA77B+e0+kNWJvtxI2lj+bZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE0PHYDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F6CC433B1;
	Tue, 16 Jan 2024 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434406;
	bh=+jfAumQNnkzv9I79/OPpoM4LCmBymLZ6ObiQOrhxH0w=;
	h=From:Subject:Date:To:Cc:From;
	b=OE0PHYDRr27Lj0JVd5OY7CULI9axTc05pbGbQNnslL4ulzD4U5h75uneDW18itYj3
	 Wvzbmg/5qqyEwOY7sasMaFTyarhnzUGK4d//nOpec98nvoBa0a4DPBSu0O2DCkUROj
	 qX6rzGWm/Qqk3ev1qM0VK7ueXT8O8P5TOcu9ryS2Hain83qn9pjuuxlfvIBNX3HiwG
	 jm6uHWO3Ju/36EtoCuO0kG6318kVEaCEBVOFRCzqEkKdRk4NrpT6/vN+SlOQLFCmXR
	 Mc8pdjTTs8F5A9Ylew8DRxnna6RYtiQtR9eDUD3cC+Q7wzBHAonbevYGeFmd/AQV99
	 MEW2LPM4uQriQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/20] filelock: split struct file_lock into file_lock and
 file_lease structs
Date: Tue, 16 Jan 2024 14:45:56 -0500
Message-Id: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXcpmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Mz3bSc4oKczBLdpJQkEzMLI5OUJDMLJaDqgqLUtMwKsEnRsbW1AEa
 nPdxZAAAA
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <lsahlber@redhat.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5588; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+jfAumQNnkzv9I79/OPpoM4LCmBymLZ6ObiQOrhxH0w=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0ftqJwQuqAD38FN6MoC29Q0W1W9QXxgUAdV
 kpvyO+OpfKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdHwAKCRAADmhBGVaC
 FYuoD/0citvA0J2DhINaMqSXWn5Xpj24lo64MwYEBG1Y97QveOHDi5+KKxVVKG1xoO1rDxMptqR
 qaT6JEi5qs613mZ7A1s2AInOfU/SJAiI0DoPNzmbqOVmZte+wk06nmV3oXbsQtCDRWAhY7mXzWc
 0QKrxLHPFSb7m6/nmjSxWBUWzhripWiyDd8PPqxpuE2rQGPUwI8o+pop815DhSUsVwBYnnXphGo
 60IV3K/e19/H/BbYJflkf838lI41U1Igkjw7d7IY8uskoTqGqWW4pe/CO97hyftI0tFwOY5OHnh
 PhwI4dinEh14pi/50opiudRbL7Vc3zgVEEqmWShzVI5sGz3SUsBngOFRS5qLqiZ9OMgaod7E/gM
 Vwf3a5NlILJjAleixtNLywe7xW6V4vchaP2pCUdM5bQ2ks2+fMmHQKmsCQVVVmrzZG9xjbQQ6vA
 R6gUeeGfidpaZJadjA8Hw0lCiOPKNKcHiycgu9W2niTpt0MZjzu5DnWv9k2R4t9EELlKyICvXcf
 uOxhKR/fgNQnTJu7zK9Uku3vCCj4gG/mKG01YhWLIeAB/f3feeyHJiKWsRxYzjZfTuScN4Wepn2
 dx+/QflCrACPDo/n+qTrubHdnI11DdXEgLwRD5DkoeC7f5Prjw8lWn3j33kWbjp5kTPW5EF0ZV1
 Mw9Mtry0LNNhQ/A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Long ago, file locks used to hang off of a singly-linked list in struct
inode. Because of this, when leases were added, they were added to the
same list and so they had to be tracked using the same sort of
structure.

Several years ago, we added struct file_lock_context, which allowed us
to use separate lists to track different types of file locks. Given
that, leases no longer need to be tracked using struct file_lock.

That said, a lot of the underlying infrastructure _is_ the same between
file leases and locks, so we can't completely separate everything.

This patchset first splits a group of fields used by both file locks and
leases into a new struct file_lock_core, that is then embedded in struct
file_lock. Coccinelle was then used to convert a lot of the callers to
deal with the move, with the remaining 25% or so converted by hand.

It then converts several internal functions in fs/locks.c to work
with struct file_lock_core. Lastly, struct file_lock is split into
struct file_lock and file_lease, and the lease-related APIs converted to
take struct file_lease.

After the first few patches (which I left split up for easier review),
the set should be bisectable. I'll plan to squash the first few
together to make sure the resulting set is bisectable before merge.

Finally, I left the coccinelle scripts I used in tree. I had heard it
was preferable to merge those along with the patches that they
generate, but I wasn't sure where they go. I can either move those to a
more appropriate location or we can just drop that commit if it's not
needed.

I'd like to have this considered for inclusion in v6.9. Christian, would
you be amenable to shepherding this into mainline (assuming there are no
major objections, of course)?

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (20):
      filelock: split common fields into struct file_lock_core
      filelock: add coccinelle scripts to move fields to struct file_lock_core
      filelock: the results of the coccinelle conversion
      filelock: fixups after the coccinelle changes
      filelock: convert some internal functions to use file_lock_core instead
      filelock: convert more internal functions to use file_lock_core
      filelock: make posix_same_owner take file_lock_core pointers
      filelock: convert posix_owner_key to take file_lock_core arg
      filelock: make locks_{insert,delete}_global_locks take file_lock_core arg
      filelock: convert locks_{insert,delete}_global_blocked
      filelock: convert the IS_* macros to take file_lock_core
      filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core
      filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core
      filelock: convert fl_blocker to file_lock_core
      filelock: clean up locks_delete_block internals
      filelock: reorganize locks_delete_block and __locks_insert_block
      filelock: make assign_type helper take a file_lock_core pointer
      filelock: convert locks_wake_up_blocks to take a file_lock_core pointer
      filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
      filelock: split leases out of struct file_lock

 cocci/filelock.cocci            |  81 +++++
 cocci/filelock2.cocci           |   6 +
 cocci/nlm.cocci                 |  81 +++++
 fs/9p/vfs_file.c                |  38 +-
 fs/afs/flock.c                  |  55 +--
 fs/ceph/locks.c                 |  74 ++--
 fs/dlm/plock.c                  |  44 +--
 fs/fuse/file.c                  |  14 +-
 fs/gfs2/file.c                  |  16 +-
 fs/libfs.c                      |   2 +-
 fs/lockd/clnt4xdr.c             |  14 +-
 fs/lockd/clntlock.c             |   2 +-
 fs/lockd/clntproc.c             |  60 +--
 fs/lockd/clntxdr.c              |  14 +-
 fs/lockd/svc4proc.c             |  10 +-
 fs/lockd/svclock.c              |  64 ++--
 fs/lockd/svcproc.c              |  10 +-
 fs/lockd/svcsubs.c              |  24 +-
 fs/lockd/xdr.c                  |  14 +-
 fs/lockd/xdr4.c                 |  14 +-
 fs/locks.c                      | 785 ++++++++++++++++++++++------------------
 fs/nfs/delegation.c             |   4 +-
 fs/nfs/file.c                   |  22 +-
 fs/nfs/nfs3proc.c               |   2 +-
 fs/nfs/nfs4_fs.h                |   2 +-
 fs/nfs/nfs4file.c               |   2 +-
 fs/nfs/nfs4proc.c               |  39 +-
 fs/nfs/nfs4state.c              |   6 +-
 fs/nfs/nfs4trace.h              |   4 +-
 fs/nfs/nfs4xdr.c                |   8 +-
 fs/nfs/write.c                  |   8 +-
 fs/nfsd/filecache.c             |   4 +-
 fs/nfsd/nfs4callback.c          |   2 +-
 fs/nfsd/nfs4layouts.c           |  34 +-
 fs/nfsd/nfs4state.c             |  98 ++---
 fs/ocfs2/locks.c                |  12 +-
 fs/ocfs2/stack_user.c           |   2 +-
 fs/smb/client/cifsfs.c          |   2 +-
 fs/smb/client/cifssmb.c         |   8 +-
 fs/smb/client/file.c            |  74 ++--
 fs/smb/client/smb2file.c        |   2 +-
 fs/smb/server/smb2pdu.c         |  44 +--
 fs/smb/server/vfs.c             |  14 +-
 include/linux/filelock.h        |  58 ++-
 include/linux/fs.h              |   5 +-
 include/linux/lockd/lockd.h     |   8 +-
 include/trace/events/afs.h      |   4 +-
 include/trace/events/filelock.h |  54 +--
 48 files changed, 1119 insertions(+), 825 deletions(-)
---
base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
change-id: 20240116-flsplit-bdb46824db68

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


