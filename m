Return-Path: <linux-fsdevel+bounces-9730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92413844BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68251C29BD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C573A8E3;
	Wed, 31 Jan 2024 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhirEnt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FB39ACA;
	Wed, 31 Jan 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742137; cv=none; b=Hhi3wtisvX4PFmePI93TNrZOnqik8663/+3uGwpnAX/3MDR5+jz/xLOsZhlgrwA4L60qdSVwmmdq3PuoLruQQGFo8Af4p+u2zOCkn7dlbgr6lkKQWFbXUqyiKVzKsrYHpgYUa6BzC60CHr9m+qZYKoEQP5GzLE24sWsOs8WH89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742137; c=relaxed/simple;
	bh=1ymBo0INWu+oPCIXg5dFg0fy8TzeUnBhzt2lS0EtzoY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pKt7SoQv5cZno2fXZZyaIHzng+PvdkKGRltYFWsrHziqUcXhz/pJUFNPwQNvwFlDwGebcj/ylbeTaj+oLlbEbVjxOBZpWV9Pbg5IWcIf0MgWS/47uP6fpG80llU+yhYdmwumKJN1hU+H9lI5drTUcHmgXB0pywpCzGfDhcxCrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhirEnt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922D9C433F1;
	Wed, 31 Jan 2024 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742136;
	bh=1ymBo0INWu+oPCIXg5dFg0fy8TzeUnBhzt2lS0EtzoY=;
	h=From:Subject:Date:To:Cc:From;
	b=YhirEnt1Zyoo4luUVzDdhSoDLVYvWigAqZF0B6hVmStfBkJ81ZoY39zwG3iBO9dS3
	 UYBF0Q8RcOdj4DLYqYcLH9+HwFhRPqM8sr4l+4Il/5FK5xaENi8BPZzoQ3LTc/ySys
	 Y4fu6SPpYhOe8o4BbIfWndzP03DZi1TDZo3BkgcEoqnW1M841wkkTaIjktr55VVGnH
	 6j46ERLyOG+jxpZy48Kyyx/spWmdM5QedwoaChlR9qlOraUOKjp69/lHRqhu5ydVI0
	 RQ37ndFqeTkfovRnE0B+DYp/FMolc046xp3Tq9jE5seO5eqxXw2ryDiMg2kMBQ0z8c
	 dIzjdHR4VqszA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/47] filelock: split file leases out of struct
 file_lock
Date: Wed, 31 Jan 2024 18:01:41 -0500
Message-Id: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbRumUC/2WMQQ6CMBBFr2JmbU07lIKuvIdxQekAEwmQljQaw
 t0tbNS4fD//vQUCeaYAl8MCniIHHocE2fEAdVcNLQl2iQElaqmUEU0fpp5nYZ3VpkTtrCkhvSd
 PDT/30u2euOMwj/61h6Pa1v9GVEKK+uxko7NCVrm7PsgP1J9G38IWifglYv4RMYmFLvMM0Rqsi
 x9xXdc3cRWMZtgAAAA=
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6354; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1ymBo0INWu+oPCIXg5dFg0fy8TzeUnBhzt2lS0EtzoY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFn5pVegv7wNPnRDWvz5ftMiiWf6qEKdb/80
 QHt3K4JatCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRZwAKCRAADmhBGVaC
 FaDtD/45qGT25WHA6zNfMY4o5AjgAKZZlcUtRncdLVT81F2yreqMOIaNjye9MC055FEkD5eD/yn
 5qGUPayFTJnbXrWOJ6qCHgdWPvOC+N0uF/REAlEvKvDfNrVSZcytjZJjZ7EiN+Wo3hJ0YVgaR85
 yObKm+iEt+pVQGn7ZjEpowyjMZHFB0rg992VC3+gMVpVg3f+2Brk6AvoUkVt37xDoykVj+XWyU2
 A9uEpvwZArHybQTiLDX6sAHTAwFII4CZ3SdtcW3If/O8fbZfrj7wUxLx8W6me8AbdJhZ9+Ftq1b
 V4WznhWm6dPkSSM5+85TLMhwZZ7UHdFau30VG+1Hng4D1KKqIZeFRvG0LYHXI+BXIpysYSf975R
 X6URKIL/rU4sXiADc3XwbFr1uB/rK8vMsqMtFzjeikeUUJwUMtPtH4kboUFPoYpLCJNIWCFW5St
 aMvmAS6pP0qiBuiD1Ys9qPFFJ6+7bVEp52AbjgfGNcr4DrXOSbIgZgFNLvhfmnBlVl3fVINHljH
 dyaKRXELg73UFp9S2NpQg86UFtLiNfn/eJcFPCdiQrpTYlU3QP1glBfaInAaqLEUK16Kqjoy3SO
 vPsEegggG3uCfKeIk0PPW4Cyv6BILX88fkRb9jRlEW8PriwPL7iQSJz/2pydIb6xuEYI3qqvdQ2
 EUZuYzpqa6UbpxQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I'm not sure this is much prettier than the last, but contracting
"fl_core" to "c", as Neil suggested is a bit easier on the eyes.

I also added a few small helpers and converted several users over to
them. That reduces the size of the per-fs conversion patches later in
the series. I played with some others too, but they were too awkward
or not frequently used enough to make it worthwhile.

Many thanks to Chuck and Neil for the earlier R-b's and comments. I've
dropped those for now since this set is a bit different from the last.

I'd like to get this into linux-next soon and we can see about merging
it for v6.9, unless anyone has major objections.

Thanks!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Rename "flc_core" fields in file_lock and file_lease to "c"
- new helpers: locks_wake_up, for_each_file_lock, and lock_is_{unlock,read,write}
- Link to v2: https://lore.kernel.org/r/20240125-flsplit-v2-0-7485322b62c7@kernel.org

Changes in v2:
- renamed file_lock_core fields to have "flc_" prefix
- used macros to more easily do the change piecemeal
- broke up patches into per-subsystem ones
- Link to v1: https://lore.kernel.org/r/20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org

---
Jeff Layton (47):
      filelock: fl_pid field should be signed int
      filelock: rename some fields in tracepoints
      filelock: rename fl_pid variable in lock_get_status
      filelock: add some new helper functions
      9p: rename fl_type variable in v9fs_file_do_lock
      afs: convert to using new filelock helpers
      ceph: convert to using new filelock helpers
      dlm: convert to using new filelock helpers
      gfs2: convert to using new filelock helpers
      lockd: convert to using new filelock helpers
      nfs: convert to using new filelock helpers
      nfsd: convert to using new filelock helpers
      ocfs2: convert to using new filelock helpers
      smb/client: convert to using new filelock helpers
      smb/server: convert to using new filelock helpers
      filelock: drop the IS_* macros
      filelock: split common fields into struct file_lock_core
      filelock: have fs/locks.c deal with file_lock_core directly
      filelock: convert more internal functions to use file_lock_core
      filelock: make posix_same_owner take file_lock_core pointers
      filelock: convert posix_owner_key to take file_lock_core arg
      filelock: make locks_{insert,delete}_global_locks take file_lock_core arg
      filelock: convert locks_{insert,delete}_global_blocked
      filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core
      filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core
      filelock: convert fl_blocker to file_lock_core
      filelock: clean up locks_delete_block internals
      filelock: reorganize locks_delete_block and __locks_insert_block
      filelock: make assign_type helper take a file_lock_core pointer
      filelock: convert locks_wake_up_blocks to take a file_lock_core pointer
      filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
      filelock: convert locks_translate_pid to take file_lock_core
      filelock: convert seqfile handling to use file_lock_core
      9p: adapt to breakup of struct file_lock
      afs: adapt to breakup of struct file_lock
      ceph: adapt to breakup of struct file_lock
      dlm: adapt to breakup of struct file_lock
      gfs2: adapt to breakup of struct file_lock
      fuse: adapt to breakup of struct file_lock
      lockd: adapt to breakup of struct file_lock
      nfs: adapt to breakup of struct file_lock
      nfsd: adapt to breakup of struct file_lock
      ocfs2: adapt to breakup of struct file_lock
      smb/client: adapt to breakup of struct file_lock
      smb/server: adapt to breakup of struct file_lock
      filelock: remove temporary compatibility macros
      filelock: split leases out of struct file_lock

 fs/9p/vfs_file.c                |  40 +-
 fs/afs/flock.c                  |  60 +--
 fs/ceph/locks.c                 |  74 ++--
 fs/dlm/plock.c                  |  44 +--
 fs/fuse/file.c                  |  14 +-
 fs/gfs2/file.c                  |  16 +-
 fs/libfs.c                      |   2 +-
 fs/lockd/clnt4xdr.c             |  14 +-
 fs/lockd/clntlock.c             |   2 +-
 fs/lockd/clntproc.c             |  65 +--
 fs/lockd/clntxdr.c              |  14 +-
 fs/lockd/svc4proc.c             |  10 +-
 fs/lockd/svclock.c              |  64 +--
 fs/lockd/svcproc.c              |  10 +-
 fs/lockd/svcsubs.c              |  24 +-
 fs/lockd/xdr.c                  |  14 +-
 fs/lockd/xdr4.c                 |  14 +-
 fs/locks.c                      | 851 ++++++++++++++++++++++------------------
 fs/nfs/delegation.c             |   4 +-
 fs/nfs/file.c                   |  22 +-
 fs/nfs/nfs3proc.c               |   2 +-
 fs/nfs/nfs4_fs.h                |   2 +-
 fs/nfs/nfs4file.c               |   2 +-
 fs/nfs/nfs4proc.c               |  39 +-
 fs/nfs/nfs4state.c              |  22 +-
 fs/nfs/nfs4trace.h              |   4 +-
 fs/nfs/nfs4xdr.c                |   8 +-
 fs/nfs/write.c                  |   8 +-
 fs/nfsd/filecache.c             |   4 +-
 fs/nfsd/nfs4callback.c          |   2 +-
 fs/nfsd/nfs4layouts.c           |  34 +-
 fs/nfsd/nfs4state.c             | 120 +++---
 fs/ocfs2/locks.c                |  12 +-
 fs/ocfs2/stack_user.c           |   2 +-
 fs/open.c                       |   2 +-
 fs/posix_acl.c                  |   4 +-
 fs/smb/client/cifsfs.c          |   2 +-
 fs/smb/client/cifssmb.c         |   8 +-
 fs/smb/client/file.c            |  78 ++--
 fs/smb/client/smb2file.c        |   2 +-
 fs/smb/server/smb2pdu.c         |  44 +--
 fs/smb/server/vfs.c             |  14 +-
 include/linux/filelock.h        | 103 +++--
 include/linux/fs.h              |   5 +-
 include/linux/lockd/lockd.h     |   8 +-
 include/linux/lockd/xdr.h       |   2 +-
 include/trace/events/afs.h      |   4 +-
 include/trace/events/filelock.h | 102 ++---
 48 files changed, 1064 insertions(+), 933 deletions(-)
---
base-commit: e96efe9f69ebb12b38c722c159413fd6850b782c
change-id: 20240116-flsplit-bdb46824db68

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


