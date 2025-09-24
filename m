Return-Path: <linux-fsdevel+bounces-62618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110DB9B2AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294827B2525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD353195EE;
	Wed, 24 Sep 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUkMjecr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBB3148C4;
	Wed, 24 Sep 2025 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737175; cv=none; b=Bipv9n6rvPg+jgCyFdp88gYnsaScd9xBFxRloFcaNZ6dquAnaaPnjbHE2TSt054e9Ceif45lMifrC7rEVpgMUOb+Oqa+xhvOQDfX5FXXAMzC7Jjm/UPEM/thFP7TD2X/bx/rg+xz399eAwM/XhaWPz59D6Bgd/cudDZkSAjZucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737175; c=relaxed/simple;
	bh=+7/S4meIPGSN/YstETcBmWXU5FN9nSZr2kIW0JWrlqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CgbePikAO+EbfPA8eGAc8URN6+3Ba3kJ3meALduYUbDRUla/HINDGD5b+a4cx+8eH1XtXiOYguGQPfjZSeY/exqch6TQZSNEkJXpl6kqxQlylbsfAfhLZg6K92xCXVKOXhVmqKF5fbH3PfCPjkqp5ZLu/KUBokRcvm+iRu4M080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUkMjecr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07640C4CEE7;
	Wed, 24 Sep 2025 18:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737174;
	bh=+7/S4meIPGSN/YstETcBmWXU5FN9nSZr2kIW0JWrlqU=;
	h=From:Subject:Date:To:Cc:From;
	b=BUkMjecrWMRPmJhKglDkxz8GHmbaIabTZ/do3YWRlVpCz93gOGGdvV0teaUGMCOoy
	 CLZjUwQB9mJeERwIQF7UbhUpy+dz4V010I9xZmMxyflxBN6m7OPYVIE0MKwPXgeAda
	 rzcKVIXKrISdWR5AioJs4Vnv1N5MsKVVv1A8CgpEhbO7BzH3Q4yW94FovcU8m/Xedf
	 Tq94Zg15GzXnPc/Qoe8lUh/wQtlbd7t27P5zzbkccbbErHj+slGCnc6T45zh5qU92B
	 buErnYYuwbskoelbawTY7Zgv1P2lqlQX2wxEppMRNh7lutzSwK5VOg4tgs3L9uOhkJ
	 HogvFYBKmA/sw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/38] vfs, nfsd: implement directory delegations
Date: Wed, 24 Sep 2025 14:05:46 -0400
Message-Id: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPsy1GgC/1WMQQ6CMBBFr0K6tmY6QLGuvIdxUe0IEw2YqWk0h
 LtbMCayfD//vVFFEqao9sWohBJHHvoM5aZQl873LWkOmRUCVoCm1oFFB7pTqwkNooGzd6FS+f8
 QuvJraR1PmTuOz0HeSzqZef1WylUlGQ3am2ARnC9tXR1uJD3dt4O0as4k/Kk1WMB/FWe1ccY1A
 IF2dqVO0/QByyIBLd4AAAA=
X-Change-ID: 20240215-dir-deleg-e212210ba9d4
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7598; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+7/S4meIPGSN/YstETcBmWXU5FN9nSZr2kIW0JWrlqU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMF8jPUq07hC+JXFyB+aFMKgJT0u4y2TqDFD
 JQrspyIcFuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzBQAKCRAADmhBGVaC
 FWo5D/9g7HyeH/C2KXyHiUgrSV/2XxABdNtqJhcUO86MYtRpMnX7Z74nptP1jIykAkuPNHT8NgA
 Gs3TBooOpGdAXKq55n3tLCl0X+Tb5xX/2oKIbjzK4js+y1Suqq4YQCjXcQUEmnNh2piXku+x7/A
 kWOrIit4ByIsR5jhoVX7RmM/fNj4xXC4pU3z8v6DJRDgO2DZGVIgje1kQPdS+DLUKvd7vy4xF6c
 X7KB7lOzMjdsptBG7rgdcTDj8QVI1JiHVAc8ujq9yvnCQwYIboKyz/YZX9csqqfsGfAyaZMMJzW
 bXRwZ8A+vrTOuTHGIbt0Nz71fdsCiTAFHP4XUAUZS+YGaxD+aZJLoAl9MNgn4Gh2DfM5ntPy8cy
 7kN/I3dsW85dmNT3NKFNFbifd8JKb7twKV6iTZfur14UJ0DIhgK6dHSn+dQROogO4u0FQ5uPjoh
 K8gl/q3RG43y+gjYTEhjT2n1FBh8ZURqeurkW+1GdoXThu0uycXrLTomos49EQged3/jiY8MgOt
 sKB8JUy8fHTUmTmAX9etqbt6XEH8My/ieWuHlwDdVy+TzaL+Fbj1T/wW3iFKN3AJIbsD3/eijaQ
 zOHYDL/cmS4FaEsDfhF6LYSgGff9CuPmlQpkfJxmb9HaSA0rzzJm1xRWE5q20HqNzixb99liFGq
 sJigsBqJ83fHk5A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset is an update to a patchset that I posted in early June
this year [1]. This version should be basically feature-complete, with a
few caveats.

NFSv4.1 adds a GET_DIR_DELEGATION operation, to allow clients
to request a delegation on a directory. If the client holds a directory
delegation, then it knows that nothing will change the dentries in it
until it has been recalled (modulo the case where the client requests
notifications of directory changes).

In 2023, Rick Macklem gave a talk at the NFS Bakeathon on his
implementation of directory delegations for FreeBSD [2], and showed that
it can greatly improve LOOKUP-heavy workloads. There is also some
earlier work by CITI [3] that showed similar results. The SMB protocol
also has a similar sort of construct, and they have also seen large
performance improvements on certain workloads.

This version also starts with support for trivial directory delegations
that support no notifications.  From there it adds VFS support for
ignoring certain break_lease() events in directories. It then adds
support for basic CB_NOTIFY calls (with names only). Next, support for
sending attributes in the notifications is added.

I think that this version should be getting close to merge ready. Anna
has graciously agreed to work on the client-side pieces for this. I've
mostly been testing using pynfs tests (which I will submit soon).

The main limitation at this point is that callback requests are
currently limited to a single page, so we can't send very many in a
single CB_NOTIFY call. This will make it easy to "get into the weeds" if
you're changing a directory quickly. The server will just recall the
delegation in that case, so it's harmless even though it's not ideal.

If this approach looks acceptable I'll see if we can increase that
limitation (it seems doable).

If anyone wishes to try this out, it's in the "dir-deleg" branch in my
tree at kernel.org [4].

[1]: https://lore.kernel.org/linux-nfs/20250602-dir-deleg-v2-0-a7919700de86@kernel.org/
[2]: https://www.youtube.com/watch?v=DdFyH3BN5pI
[3]: https://linux-nfs.org/wiki/index.php/CITI_Experience_with_Directory_Delegations
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Rework to do minimal work in fsnotify callbacks
- Add support for sending attributes in CB_NOTIFY calls
- Add support for dir attr change notifications
- Link to v2: https://lore.kernel.org/r/20250602-dir-deleg-v2-0-a7919700de86@kernel.org

Changes in v2:
- add support for ignoring certain break_lease() events
- basic support for CB_NOTIFY
- Link to v1: https://lore.kernel.org/r/20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org

---
Jeff Layton (38):
      filelock: push the S_ISREG check down to ->setlease handlers
      filelock: add a lm_may_setlease lease_manager callback
      vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
      vfs: allow mkdir to wait for delegation break on parent
      vfs: allow rmdir to wait for delegation break on parent
      vfs: break parent dir delegations in open(..., O_CREAT) codepath
      vfs: make vfs_create break delegations on parent directory
      vfs: make vfs_mknod break delegations on parent directory
      filelock: lift the ban on directory leases in generic_setlease
      nfsd: allow filecache to hold S_IFDIR files
      nfsd: allow DELEGRETURN on directories
      nfsd: check for delegation conflicts vs. the same client
      nfsd: wire up GET_DIR_DELEGATION handling
      filelock: rework the __break_lease API to use flags
      filelock: add struct delegated_inode
      filelock: add support for ignoring deleg breaks for dir change events
      filelock: add a tracepoint to start of break_lease()
      filelock: add an inode_lease_ignore_mask helper
      nfsd: add protocol support for CB_NOTIFY
      nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
      nfsd: allow nfsd to get a dir lease with an ignore mask
      vfs: add fsnotify_modify_mark_mask()
      nfsd: update the fsnotify mark when setting or removing a dir delegation
      nfsd: make nfsd4_callback_ops->prepare operation bool return
      nfsd: add callback encoding and decoding linkages for CB_NOTIFY
      nfsd: add data structures for handling CB_NOTIFY to directory delegation
      nfsd: add notification handlers for dir events
      nfsd: add tracepoint to dir_event handler
      nfsd: apply the notify mask to the delegation when requested
      nfsd: add helper to marshal a fattr4 from completed args
      nfsd: allow nfsd4_encode_fattr4_change() to work with no export
      nfsd: send basic file attributes in CB_NOTIFY
      nfsd: allow encoding a filehandle into fattr4 without a svc_fh
      nfsd: add a fi_connectable flag to struct nfs4_file
      nfsd: add the filehandle to returned attributes in CB_NOTIFY
      nfsd: properly track requested child attributes
      nfsd: track requested dir attributes
      nfsd: add support to CB_NOTIFY for dir attribute changes

 Documentation/sunrpc/xdr/nfs4_1.x    | 267 +++++++++++++++++-
 drivers/base/devtmpfs.c              |   2 +-
 fs/attr.c                            |   4 +-
 fs/cachefiles/namei.c                |   2 +-
 fs/ecryptfs/inode.c                  |   2 +-
 fs/fuse/dir.c                        |   1 +
 fs/init.c                            |   2 +-
 fs/locks.c                           | 122 ++++++--
 fs/namei.c                           | 253 +++++++++++------
 fs/nfs/nfs4file.c                    |   2 +
 fs/nfsd/filecache.c                  | 101 +++++--
 fs/nfsd/filecache.h                  |   2 +
 fs/nfsd/nfs4callback.c               |  60 +++-
 fs/nfsd/nfs4layouts.c                |   3 +-
 fs/nfsd/nfs4proc.c                   |  36 ++-
 fs/nfsd/nfs4recover.c                |   2 +-
 fs/nfsd/nfs4state.c                  | 531 +++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4xdr.c                    | 298 +++++++++++++++++---
 fs/nfsd/nfs4xdr_gen.c                | 506 ++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  20 +-
 fs/nfsd/state.h                      |  73 ++++-
 fs/nfsd/trace.h                      |  21 ++
 fs/nfsd/vfs.c                        |   7 +-
 fs/nfsd/vfs.h                        |   2 +-
 fs/nfsd/xdr4.h                       |   3 +
 fs/nfsd/xdr4cb.h                     |  12 +
 fs/notify/mark.c                     |  29 ++
 fs/open.c                            |   8 +-
 fs/overlayfs/overlayfs.h             |   2 +-
 fs/posix_acl.c                       |  12 +-
 fs/smb/client/cifsfs.c               |   3 +
 fs/smb/server/vfs.c                  |   2 +-
 fs/utimes.c                          |   4 +-
 fs/xattr.c                           |  16 +-
 fs/xfs/scrub/orphanage.c             |   2 +-
 include/linux/filelock.h             | 143 +++++++---
 include/linux/fs.h                   |  11 +-
 include/linux/fsnotify_backend.h     |   1 +
 include/linux/nfs4.h                 | 127 ---------
 include/linux/sunrpc/xdrgen/nfs4_1.h | 304 +++++++++++++++++++-
 include/linux/xattr.h                |   4 +-
 include/trace/events/filelock.h      |  38 ++-
 include/uapi/linux/nfs4.h            |   2 -
 43 files changed, 2636 insertions(+), 406 deletions(-)
---
base-commit: 36c204d169319562eed170f266c58460d5dad635
change-id: 20240215-dir-deleg-e212210ba9d4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


