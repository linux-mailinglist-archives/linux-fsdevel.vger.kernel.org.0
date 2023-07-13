Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA23752D56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjGMXBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjGMXBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D02127;
        Thu, 13 Jul 2023 16:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B9961B79;
        Thu, 13 Jul 2023 23:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61080C433C8;
        Thu, 13 Jul 2023 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289269;
        bh=BvE/6xVatY3gzbwR0vDrqr3MzJ01oINoYu0cSNelaB8=;
        h=From:Subject:Date:To:Cc:From;
        b=j9LDsK+FDIrm6x6MxYyXms5zVTjaW1P6LxjzfQKg1pbSvAHLTtuNDrEBEAvQz7a59
         IEj5BzbSPgpyeqfAqbd+Re3r0d6jbIHKhpnRq3qprdKRfzdD9X103cXf3qX6JZft6A
         8K/RH8+CdgTcLHSepEL1YlNk2ZQmp4oagzqZSvVyVEd/d4TvlnBEIAX/8mUMo/DIpV
         2h3UVlHoa/Q76fgIu2dVBLs3sOHMs2qunAcM77C5kvmuuB2TAhiX7+yoiPjn4EbiL6
         oufcrYQQLmAklyR8BnHSjocZBlFXqdC5grfG/sCfx8gif0JU3ybUeAnX6i/lTGUMEc
         tKVmtuCgMrfHw==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/8] fs: implement multigrain timestamps
Date:   Thu, 13 Jul 2023 19:00:49 -0400
Message-Id: <20230713-mgctime-v5-0-9eb795d2ae37@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGCsGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0Nj3dz05JLM3FTdNKNEy7RkYyMTS0MLJaDqgqLUtMwKsEnRsbW1AO6
 XW1JZAAAA
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BvE/6xVatY3gzbwR0vDrqr3MzJ01oINoYu0cSNelaB8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBksIIu4PKEKGnoDdi+GMLN5ufs2UB8ZsDTn9Oqp
 SYtweP3skyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLCCLgAKCRAADmhBGVaC
 FXJhEADW493xZyCYf/hlVo1POCOZGol0XDpJIN1EQK3h+61XPis26awGDTcXczc9yZK/JvZV7oC
 VtVStL44kvzeqn7kh1AH/EuLmeazbYMEFTdl5PiizH53xrWmidL26fTjpjn01gvjb9Y5gGXTvuI
 h0JLInpNr5Hn509RQU2T5/D8WBKVnLWeHB/itiDWCZ1CG8iFNWfgbgC/bpdW2+H0eIDHvr6bUcJ
 m0mfxwAUL6lA/b/G8kmsdj0YEEWf2bOLzdxZcQPh/MEfkRuKwWqy9d5mFLJlJ5GiheG9qiqOwOA
 wLz9M0J4e32Di/q+QL/HpihUZOB0jrZB+bRhKxqWD04cFRtTTwE15w/xGAgjvPLe2l+sNzEUxoq
 nIscPnAScgiRW3Bzq6PUd7ljrtLvvU6Vcgd0HqFcyfn9APLCjnLCckVW7S0ofkRL7oksLIoSGDJ
 qo/IpJl4X/Mu1LBY//fFZp6QVhp54iwAR+D7VJ3z7wtZSktaXJ9f1o0qcT1Bo254702FlLGvbxf
 Bkj6FZDMZrSXrx81pjrLvUB8jCQQ13oz7O3kmOzVX4pLmnO9PRLcQLj14velupamDvwexZgudyW
 jiqR3IwVXCTiN2WgmssqUyuQi+GQ1LKePEwVpDx8izF0VnbQshX6OqMvuRzVcDG29pzQBTc0dy+
 lAVc/7Mp3vHZu0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS always uses coarse-grained timestamps when updating the
ctime and mtime after a change. This has the benefit of allowing
filesystems to optimize away a lot metadata updates, down to around 1
per jiffy, even when a file is under heavy writes.

Unfortunately, this coarseness has always been an issue when we're
exporting via NFSv3, which relies on timestamps to validate caches. A
lot of changes can happen in a jiffy, so timestamps aren't sufficient to
help the client decide to invalidate the cache.

Even with NFSv4, a lot of exported filesystems don't properly support a
change attribute and are subject to the same problems with timestamp
granularity. Other applications have similar issues with timestamps (e.g
backup applications).

If we were to always use fine-grained timestamps, that would improve the
situation, but that becomes rather expensive, as the underlying
filesystem would have to log a lot more metadata updates.

What we need is a way to only use fine-grained timestamps when they are
being actively queried. The idea is to use an unused bit in the ctime's
tv_nsec field to mark when the mtime or ctime has been queried via
getattr. Once that has been marked, the next m/ctime update will use a
fine-grained timestamp.

This patch series is based on top of Christian's vfs.all branch, which
has the recent conversion to the new ctime accessors. It should apply
cleanly on top of linux-next.

While the patchset does work, I'm mostly looking for feedback on the
core infrastructure API. Does this look reasonable? Am I missing any
races?

Signed-off-by: Jeff Layton <jlayton@kernel.org>
base-commit: cf22d118b89a09a0160586412160d89098f7c4c7
---
Jeff Layton (8):
      fs: pass the request_mask to generic_fillattr
      fs: add infrastructure for multigrain timestamps
      tmpfs: bump the mtime/ctime/iversion when page becomes writeable
      tmpfs: add support for multigrain timestamps
      xfs: XFS_ICHGTIME_CREATE is unused
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps

 fs/9p/vfs_inode.c               |  4 +-
 fs/9p/vfs_inode_dotl.c          |  4 +-
 fs/afs/inode.c                  |  2 +-
 fs/btrfs/file.c                 | 24 ++--------
 fs/btrfs/inode.c                |  2 +-
 fs/btrfs/super.c                |  5 ++-
 fs/ceph/inode.c                 |  2 +-
 fs/coda/inode.c                 |  3 +-
 fs/ecryptfs/inode.c             |  5 ++-
 fs/erofs/inode.c                |  2 +-
 fs/exfat/file.c                 |  2 +-
 fs/ext2/inode.c                 |  2 +-
 fs/ext4/inode.c                 |  2 +-
 fs/ext4/super.c                 |  2 +-
 fs/f2fs/file.c                  |  2 +-
 fs/fat/file.c                   |  2 +-
 fs/fuse/dir.c                   |  2 +-
 fs/gfs2/inode.c                 |  2 +-
 fs/hfsplus/inode.c              |  2 +-
 fs/inode.c                      | 98 +++++++++++++++++++++++++++++------------
 fs/kernfs/inode.c               |  2 +-
 fs/libfs.c                      |  4 +-
 fs/minix/inode.c                |  2 +-
 fs/nfs/inode.c                  |  2 +-
 fs/nfs/namespace.c              |  3 +-
 fs/ntfs3/file.c                 |  2 +-
 fs/ocfs2/file.c                 |  2 +-
 fs/orangefs/inode.c             |  2 +-
 fs/proc/base.c                  |  4 +-
 fs/proc/fd.c                    |  2 +-
 fs/proc/generic.c               |  2 +-
 fs/proc/proc_net.c              |  2 +-
 fs/proc/proc_sysctl.c           |  2 +-
 fs/proc/root.c                  |  3 +-
 fs/smb/client/inode.c           |  2 +-
 fs/smb/server/smb2pdu.c         | 22 ++++-----
 fs/smb/server/vfs.c             |  3 +-
 fs/stat.c                       | 59 ++++++++++++++++++++-----
 fs/sysv/itree.c                 |  3 +-
 fs/ubifs/dir.c                  |  2 +-
 fs/udf/symlink.c                |  2 +-
 fs/vboxsf/utils.c               |  2 +-
 fs/xfs/libxfs/xfs_shared.h      |  2 -
 fs/xfs/libxfs/xfs_trans_inode.c |  8 ++--
 fs/xfs/xfs_iops.c               |  4 +-
 fs/xfs/xfs_super.c              |  2 +-
 include/linux/fs.h              | 47 ++++++++++++++++++--
 mm/shmem.c                      | 16 ++++++-
 48 files changed, 248 insertions(+), 129 deletions(-)
---
base-commit: cf22d118b89a09a0160586412160d89098f7c4c7
change-id: 20230713-mgctime-f2a9fc324918

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

