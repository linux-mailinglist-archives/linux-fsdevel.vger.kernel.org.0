Return-Path: <linux-fsdevel+bounces-7625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F83828852
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C6A1F2520D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F603A1B8;
	Tue,  9 Jan 2024 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ezuYRZdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4A3A1AB;
	Tue,  9 Jan 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=c+XS5HfQnG/CSaNGln2rfX8jVn7XhBDpzn71I19CImY=; b=ezuYRZdTNc5uwYhpJGlO38FYbc
	sYghiGKvjdikpw1nT4rITm4RPD51sGktE1XgHYDFThVLwe4LrUAM9s9hdYZBara3Sr6A4DjFhZpQd
	dbdOl+fBCTJy64bz2krHdzavTztukWiWGlIMnEHQcQwciP9ihGK+thER5ykBu1vUtjAx+iwNQWo/3
	Sh4rUttXqiLGqbsRAt9PSrFSW9X0R3Lh0/zTvnfTWhTOW0rW8N+otGKEfkBgJny1HNQXSAIT2n/+U
	V8FkPt4ByFUS+caDlgzhTmIjA0ifRKOG12TgFJaram3mneWA7iT8eXCgJ9QtWToEB+XxnzufyY4iv
	WBu5bWLg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNDEX-008Yel-0F;
	Tue, 09 Jan 2024 14:37:37 +0000
Date: Tue, 9 Jan 2024 06:37:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joel Granados <joel.granados@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	mcgrof@kernel.org
Subject: [GIT PULL] sysctl changes for v6.8-rc1
Message-ID: <ZZ1aMZdS5GK1tEfn@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.8-rc1

for you to fetch changes up to 561429807d50aad76f1205b0b1d7b4aacf365d4e:

  sysctl: remove struct ctl_path (2023-12-28 05:02:42 -0800)

This has all been tested on linux-next for over a month. I failed to
include that in the signed message. Joel -- just at note, be sure to
include how much testing is done on each future pull request too :)

----------------------------------------------------------------
sysctl-6.8-rc1

To help make the move of sysctls out of kernel/sysctl.c not incur a size
penalty sysctl has been changed to allow us to not require the sentinel, the
final empty element on the sysctl array. Joel Granados has been doing all this
work. On the v6.6 kernel we got the major infrastructure changes required to
support this. For v6.7 we had all arch/ and drivers/ modified to remove
the sentinel. For v6.8-rc1 we get a few more updates for fs/ directory only.
The kernel/ directory is left but we'll save that for v6.9-rc1 as those patches
are still being reviewed. After that we then can expect also the removal of the
no longer needed check for procname == NULL.

Let us recap the purpose of this work:

  - this helps reduce the overall build time size of the kernel and run time
    memory consumed by the kernel by about ~64 bytes per array
  - the extra 64-byte penalty is no longer inncurred now when we move sysctls
    out from kernel/sysctl.c to their own files

Thomas Weiﬂschuh also sent a few cleanups, for v6.9-rc1 we expect to see further
work by Thomas Weiﬂschuh with the constificatin of the struct ctl_table.

Due to Joel Granados's work, and to help bring in new blood, I have suggested
for him to become a maintainer and he's accepted. So for v6.9-rc1 I look forward
to seeing him sent you a pull request for further sysctl changes. This also
removes Iurii Zaikin as a maintainer as he has moved on to other projects and
has had no time to help at all.

----------------------------------------------------------------
Joel Granados (7):
      sysctl: Fix out of bounds access for empty sysctl registers
      sysctl: Add a selftest for handling empty dirs
      sysclt: Clarify the results of selftest run
      cachefiles: Remove the now superfluous sentinel element from ctl_table array
      fs: Remove the now superfluous sentinel elements from ctl_table array
      sysctl: Remove the now superfluous sentinel elements from ctl_table array
      coda: Remove the now superfluous sentinel elements from ctl_table array

Luis Chamberlain (2):
      MAINTAINERS: remove Iurii Zaikin from proc sysctl
      MAINTAINERS: Add Joel Granados as co-maintainer for proc sysctl

Thomas Weiﬂschuh (2):
      sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
      sysctl: remove struct ctl_path

 MAINTAINERS                              |   2 +-
 fs/aio.c                                 |   1 -
 fs/cachefiles/error_inject.c             |   1 -
 fs/coda/sysctl.c                         |   1 -
 fs/coredump.c                            |   1 -
 fs/dcache.c                              |   1 -
 fs/devpts/inode.c                        |   1 -
 fs/eventpoll.c                           |   1 -
 fs/exec.c                                |   1 -
 fs/file_table.c                          |   1 -
 fs/inode.c                               |   1 -
 fs/lockd/svc.c                           |   1 -
 fs/locks.c                               |   1 -
 fs/namei.c                               |   1 -
 fs/namespace.c                           |   1 -
 fs/nfs/nfs4sysctl.c                      |   1 -
 fs/nfs/sysctl.c                          |   1 -
 fs/notify/dnotify/dnotify.c              |   1 -
 fs/notify/fanotify/fanotify_user.c       |   1 -
 fs/notify/inotify/inotify_user.c         |   1 -
 fs/ntfs/sysctl.c                         |   1 -
 fs/ocfs2/stackglue.c                     |   1 -
 fs/pipe.c                                |   1 -
 fs/proc/proc_sysctl.c                    |  10 ++-
 fs/quota/dquot.c                         |   1 -
 fs/sysctls.c                             |   1 -
 fs/userfaultfd.c                         |   1 -
 fs/verity/init.c                         |   1 -
 fs/xfs/xfs_sysctl.c                      |   2 -
 include/linux/sysctl.h                   |   7 --
 lib/test_sysctl.c                        |  31 ++++++-
 tools/testing/selftests/sysctl/sysctl.sh | 146 ++++++++++++++++++-------------
 32 files changed, 122 insertions(+), 102 deletions(-)

