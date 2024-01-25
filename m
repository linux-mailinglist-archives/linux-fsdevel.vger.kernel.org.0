Return-Path: <linux-fsdevel+bounces-8872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCE83BF31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A6F1F21EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506E28E3F;
	Thu, 25 Jan 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iglxyVuZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D71C6BC;
	Thu, 25 Jan 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179395; cv=none; b=cizGi1nFARu9ZIjg4GgJ9f/x40Rlxw929bnhVVm76gKFnNx2QPsKM8C8DalMKiLAKNL/+0AQUifkiNi9nDVY2UidtwY7RrS2RJDG/fqEqW2d7cAPfHGWnFqvQ38v0MFMY52Xr1IsMQnGtUooxvvNabdGE6wIHWXdGRBTAawGL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179395; c=relaxed/simple;
	bh=EgqtdVA3FSxCSzZYKU7DjI9cXnG+Mshz3nGi6DwFgfY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dsPgnqZ+zujpYC6OPCylr81Z+CaeY53M5dgwROUjXeLSY2At3mMiM8BLwpts0iO91hDko57sqEd59lNyYBNHq/62Imq5jUs2Wb6qa/vK8GR0Tw6HMz0i6RBMMc7XYW+S0nMSWoiaYLuv92UGoGWdEP+lboHIy0ZbbDz3MYb1/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iglxyVuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630D5C433F1;
	Thu, 25 Jan 2024 10:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179395;
	bh=EgqtdVA3FSxCSzZYKU7DjI9cXnG+Mshz3nGi6DwFgfY=;
	h=From:Subject:Date:To:Cc:From;
	b=iglxyVuZf/uH7ukk3PEBWQbDgx6/eplBFxz74n0ZQeYGYySzvqp4UnbUQnSms8wID
	 9aaRLWagKnY8XmtkPCXoWevdLW2ZeA7/rJBYbGSQLyqB3GvdDVwtP4pn6WbT+AQy5E
	 PqWndqHiOlUHH8XAmCWQaPCOdo0m00i1Ct5mhH6XZyFsDlh+IZdUcDGjPpbOD3WkQG
	 0OtSA8VQQoTJUuzz3NS9lnCCQ/wdQcrwaCeoy9G5lqzR71jWKUWYaYeo2f4Zna6zpY
	 dirEzUwePVBAMHgEthqt95UW4a80016LWCDfU1sx9cqKIRJiAc/QXCheOR4TmhETO4
	 7900+5XtZYGwQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/41] filelock: split struct file_lock into file_lock
 and file_lease structs
Date: Thu, 25 Jan 2024 05:42:41 -0500
Message-Id: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACI7smUC/2XMQQ7CIBCF4as0sxYDiFi78h6mi1KGdiKBBppG0
 3B3sVuX/8vLt0PGRJiha3ZIuFGmGGrIUwPjPIQJGdnaILlUXAjNnM+Lp5UZa5RupbJGt1DfS0J
 H70N69rVnymtMnwPexG/9NzbBOBvvljt1ufHhah8vTAH9OaYJ+lLKF38bj+efAAAA
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
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6859; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EgqtdVA3FSxCSzZYKU7DjI9cXnG+Mshz3nGi6DwFgfY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjsxHpi1pj0+m5q0J/ZJESZu0/C/hgYR+tCGQ
 N2Wx7gxu5OJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7MQAKCRAADmhBGVaC
 FXeXEACjKdWKwEr1DQRTHSiS+feKXTRhclAgexBosuuZprWeJnTLr0k4b+Res1IowL1xzN6ixNY
 RZKyVxNNdizgfHJN7CK+TPEFnMdxPboAU6RSeKDX/Tw09m80XOQBePMNeHLbk/Hc2fvNJO1Vfzz
 xem6iucpLJTwRNGPgWJYCfF0FLx0mOeTyC37jQNeA9qUMWZKWjX9PEmMAepmQCXV+v2koZTEN+U
 5APuFvDnvyNzX5XIev8l0HJ+vjYt3h2QKaMdDp4F+aroUE8vxCWZCSRjIecdyIjr8Q73psJ4rBd
 tcvHRkJ2vdmFf4ILaKYAGq8T1hdCoNxb2U/pO7ipOiikHsil9pwN6s5hQyJzRIJwCTodnJj+A4w
 TZj/41yAWcMfixvaXY9LfPMOAvwNuLon5/NYQVSzZbqbACYeP3ug+gtev2MK1NXekPhtN20SLoj
 rXGe9hSvOwLas8qZqifvmwe56sPFbYNMtmeUHSoBiiTNkBSnzoZaOMpjQtTp4kkPc0zLHUzneDQ
 7tYUPwrrXoCSG+KgAOEZVlqPInSUnRFqy/lHaJ+zXjKJI39hn72jDaStjJa0M6+FKx6ECi5P32P
 16Ow3ngig+Nb3yX0uscC0GBt4ahNz9b6EDF01iD4MxevEQKlsN2sNGuMyJYF9t0upicC78h3Z8X
 f9IP+AtSWOCSYSw==
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- renamed file_lock_core fields to have "flc_" prefix
- used macros to more easily do the change piecemeal
- broke up patches into per-subsystem ones
- Link to v1: https://lore.kernel.org/r/20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org

---
Jeff Layton (41):
      filelock: rename some fields in tracepoints
      filelock: rename fl_pid variable in lock_get_status
      dlm: rename fl_flags variable in dlm_posix_unlock
      nfs: rename fl_flags variable in nfs4_proc_unlck
      nfsd: rename fl_type and fl_flags variables in nfsd4_lock
      lockd: rename fl_flags and fl_type variables in nlmclnt_lock
      9p: rename fl_type variable in v9fs_file_do_lock
      afs: rename fl_type variable in afs_next_locker
      filelock: drop the IS_* macros
      filelock: split common fields into struct file_lock_core
      filelock: add coccinelle scripts to move fields to struct file_lock_core
      filelock: have fs/locks.c deal with file_lock_core directly
      filelock: convert some internal functions to use file_lock_core instead
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
      lockd: adapt to breakup of struct file_lock
      nfs: adapt to breakup of struct file_lock
      nfsd: adapt to breakup of struct file_lock
      ocfs2: adapt to breakup of struct file_lock
      smb/client: adapt to breakup of struct file_lock
      smb/server: adapt to breakup of struct file_lock
      filelock: remove temporary compatability macros
      filelock: split leases out of struct file_lock

 cocci/filelock.cocci            |  88 +++++
 cocci/nlm.cocci                 |  81 ++++
 fs/9p/vfs_file.c                |  40 +-
 fs/afs/flock.c                  |  59 +--
 fs/ceph/locks.c                 |  74 ++--
 fs/dlm/plock.c                  |  44 +--
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
 fs/locks.c                      | 848 ++++++++++++++++++++++------------------
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
 fs/nfsd/nfs4state.c             | 118 +++---
 fs/ocfs2/locks.c                |  12 +-
 fs/ocfs2/stack_user.c           |   2 +-
 fs/open.c                       |   2 +-
 fs/posix_acl.c                  |   4 +-
 fs/smb/client/cifsfs.c          |   2 +-
 fs/smb/client/cifssmb.c         |   8 +-
 fs/smb/client/file.c            |  76 ++--
 fs/smb/client/smb2file.c        |   2 +-
 fs/smb/server/smb2pdu.c         |  44 +--
 fs/smb/server/vfs.c             |  14 +-
 include/linux/filelock.h        |  80 ++--
 include/linux/fs.h              |   5 +-
 include/linux/lockd/lockd.h     |   8 +-
 include/linux/lockd/xdr.h       |   2 +-
 include/trace/events/afs.h      |   4 +-
 include/trace/events/filelock.h | 102 ++---
 49 files changed, 1198 insertions(+), 923 deletions(-)
---
base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
change-id: 20240116-flsplit-bdb46824db68

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


