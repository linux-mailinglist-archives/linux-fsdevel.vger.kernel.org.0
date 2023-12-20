Return-Path: <linux-fsdevel+bounces-6547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332B8197F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345D42882A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFA1173D;
	Wed, 20 Dec 2023 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j4XbmawT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F71170D
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RGIQl2yy4dkREPvZUwLKe26GcjOrszwyZiwOHUJl8QE=; b=j4XbmawTXJseeOgOqWuJjzW26i
	WAdp0VJZeDv4frys+dVron3EVq49g2QxkF/0dKmFPdJFsPKDqWM4/9W0pK0X3ns6/SiQeYtrYmJ4E
	JYX9fd2SKHXyRe/eUwndETLO2yoJhwa9K98IEhAEW14H/rby555GKDbq8SQ9A0rjFFrUcoOZgElSE
	9ux3zm3hJ6AXy7UmnwetjgfrrbtcoJGvhqUfEgMkojy+QBRaVCc7qGl/8scjBeHwwMaQ+8jeM5oIY
	MoD0JLaX9NZHA2mUL3Df8YAXlEPovbVvdP/me0lqU9JRNFhwAIkfMbHXl85XLkfUMusQM+zcoIgIC
	Bq/rtDow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFotw-00HIMU-23
	for linux-fsdevel@vger.kernel.org;
	Wed, 20 Dec 2023 05:13:48 +0000
Date: Wed, 20 Dec 2023 05:13:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCHES] assorted fs cleanups
Message-ID: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Assorted cleanups in various filesystems.  Currently
that pile sits in vfs.git #work.misc; if anyone wants to pick
these into relevant filesystem tree, I'll be glad to drop those
from the queue...

Diffstat:
 fs/affs/namei.c                |  3 ---
 fs/befs/linuxvfs.c             |  3 ---
 fs/bfs/dir.c                   |  5 -----
 fs/ceph/dir.c                  | 21 +++++++++++++--------
 fs/ceph/export.c               |  2 --
 fs/ext4/namei.c                |  2 --
 fs/gfs2/export.c               |  2 --
 fs/gfs2/super.c                | 12 +-----------
 fs/hostfs/hostfs_kern.c        |  8 ++------
 fs/kernfs/mount.c              |  3 ---
 fs/nfsd/nfsctl.c               |  4 ----
 fs/nilfs2/namei.c              |  7 +------
 fs/ocfs2/dcache.c              |  7 -------
 fs/ocfs2/dir.c                 |  9 ---------
 fs/orangefs/dir.c              | 32 ++++++++++++--------------------
 fs/proc/proc_sysctl.c          | 14 ++------------
 fs/reiserfs/namei.c            |  7 -------
 fs/udf/namei.c                 | 11 +----------
 fs/zonefs/super.c              |  2 --
 security/apparmor/apparmorfs.c |  7 +------
 20 files changed, 33 insertions(+), 128 deletions(-)

Shortlog:
Al Viro (22):
      hostfs: use d_splice_alias() calling conventions to simplify failure exits
      /proc/sys: use d_splice_alias() calling conventions to simplify failure exits
      zonefs: d_splice_alias() will do the right thing on ERR_PTR() inode
      udf: d_splice_alias() will do the right thing on ERR_PTR() inode
      affs: d_obtain_alias(ERR_PTR(...)) will do the right thing
      befs: d_obtain_alias(ERR_PTR(...)) will do the right thing
      ceph: d_obtain_{alias,root}(ERR_PTR(...)) will do the right thing
      gfs2: d_obtain_alias(ERR_PTR(...)) will do the right thing
      kernfs: d_obtain_alias(NULL) will do the right thing...
      nilfs2: d_obtain_alias(ERR_PTR(...)) will do the right thing...
      udf: d_obtain_alias(ERR_PTR(...)) will do the right thing...
      ext4_add_entry(): ->d_name.len is never 0
      bfs_add_entry(): get rid of pointless ->d_name.len checks
      __ocfs2_add_entry(), ocfs2_prepare_dir_for_insert()
      reiserfs_add_entry(): get rid of pointless namelen checks
      udf_fiiter_add_entry(): check for zero ->d_name.len is bogus...
      get rid of passing callbacks to ceph __dentry_leases_walk()
      nfsd: kill stale comment about simple_fill_super() requirements
      ocfs2_find_match(): there's no such thing as NULL or negative ->d_parent
      gfs2: use is_subdir()
      orangefs: saner arguments passing in readdir guts
      apparmorfs: don't duplicate kfree_link()

First group (1--11) is about making use of d_splice_alias() and d_obtain_alias()
calling conventions; a bunch of failure exits are pointless, since the primitive
will do the right thing.  Then (12--16) killing impossible checks for dentry
name length (never 0, never exceeds what ->lookup() would reject with ENAMETOOLONG).
The rest is really without any common theme...

As far as I can tell, nothing in there has conflicts in linux-next.
Individual patches in followups.  Please, review; again, if anything of
that gets picked by relevant filesystem tree, I'll gladly drop it from
this branch.

