Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A24772FB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjHGTpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjHGTpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D591FC7;
        Mon,  7 Aug 2023 12:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 353A9621C1;
        Mon,  7 Aug 2023 19:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054D5C433C7;
        Mon,  7 Aug 2023 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437125;
        bh=9NJxICXmYLBXPMfC64XdrCwzqAF8iKfLe8/dZ5HUTCM=;
        h=From:Subject:Date:To:Cc:From;
        b=qVA0Ix0lBGcrjnJMlaHoGn+dmPVHJcXPNwPRNVYPTUHaY6qqAw93e+HMLjVLlc3Ja
         IhWApauDUcVfJmEKAxeUufIWqAFry217pjJdec6Gnx5t1+ywYk3pNZ8WXdPlRwKNOd
         OSlQaHVYM2YnEQ+qBkyv9bQY+28OOz6U5Y/c45rbeadHiicXNG4D8cy/yMF2ZxGYQT
         WF+CZGWrnkMTatxkmUPRWrUl37dNWDGAI5WHVIRN+E3qOc0vGvg3j/8gZRUS/cWeFM
         o6kKmy9XR+DjgsHsIdeKI6U026YwGTiGD5oZ9j361Mp366ShxOWQxvQ1jUtP+L7u3o
         JIESFeiSwFvYg==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 00/13] fs: implement multigrain timestamps
Date:   Mon, 07 Aug 2023 15:38:31 -0400
Message-Id: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADdI0WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0Nj3dz05JLM3FTdNKNEy7RkYyMTS0MLJaDqgqLUtMwKsEnRsbW1AGM
 0/ohZAAAA
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
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
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5508; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9NJxICXmYLBXPMfC64XdrCwzqAF8iKfLe8/dZ5HUTCM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug9Vt6h3uVooR3L32BzC9FtHm9ZXcj5fgD9W
 kZjn/QE83GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPQAKCRAADmhBGVaC
 FTXFD/4tOOz/frcT1juvFdX2M7h8GdVQCCM3jUzq8E7v2hZzdNQ+TudlDlEIxe9c16PcuMEkopG
 +kFNCV6iGCNYHD41A1XVOFEaG1ktWpd4NFo0iZbI38zUAkY1Hq+1jOeJ8bi322DrqAlwoonAz0S
 xjoCCsczgKHec9BxsuY4jfg7RVOvXrFnrpkUDxIomwZ80NN40sF+XG+bvbNSLZLb5dlTvoeQVQc
 smZ+JCtorGZdRxl2ILJbhENfex5Z0Cqgyh5A9MXqnl+J5Hm9s1es+lk7e+q9IK18+YypOP1HSHI
 K4MMDRodJG3ELlDifK8mUDMexXoWFTdW8MdVW5HTGHShQubI6zShgS4psxnRhF+jhlkcLxFz7Ui
 NL0E8WBVqsxLTUShLtKzEZ5j4wrb8yHur66NZrhvTeqgQwKIouSImzG0S+GAC8xIRAfXk06T/Do
 NpD+OXK/CELcMQD5+q1WcE7fPstPcyNp2PfOjHsnyMEzzkXXe3n1aeImG7MmCUDsftccGNQtajU
 WpL+Dq+bljKjojhVg9eJQYbnM0hNchEPUfMtAsdaFl7R/fRVlwsD+brmqMnYjtUGL/EPcQK+KrS
 4PhSQm9PfqdGsTZlG/r+wg2LxN9mxhg3X4wHeNUKI7S2IrJnkf5g6P8SBMSBluFrkbUD4n8Ko27
 OYH1/EhApgN3hYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Credit goes to Dave Chinner for the original idea, and to Ben Coddington
for the catchy name. This series should apply cleanly onto Christian's
vfs.ctime branch, once the v6 mgtime patches have been dropped. That
should be everything above this commit:

    525deaeb2fbf gfs2: fix timestamp handling on quota inodes

base-commit: cf22d118b89a09a0160586412160d89098f7c4c7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v7:
- change update_time operation to fetch the current time itself
- don't modify current_time operation. Leave it always returning coarse timestamp
- rework inode_set_ctime_current for better atomicity and ensure that
  all mgtime filesystems use it
- reorder arguments to fill_mg_cmtime

Changes in v6:
- drop the patch that removed XFS_ICHGTIME_CHG
- change WARN_ON_ONCE to ASSERT in xfs conversion patch

---
Jeff Layton (13):
      fs: remove silly warning from current_time
      fs: pass the request_mask to generic_fillattr
      fs: drop the timespec64 arg from generic_update_time
      btrfs: have it use inode_update_timestamps
      fat: make fat_update_time get its own timestamp
      ubifs: have ubifs_update_time use inode_update_timestamps
      xfs: have xfs_vn_update_time gets its own timestamp
      fs: drop the timespec64 argument from update_time
      fs: add infrastructure for multigrain timestamps
      tmpfs: add support for multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps

 fs/9p/vfs_inode.c               |   4 +-
 fs/9p/vfs_inode_dotl.c          |   4 +-
 fs/afs/inode.c                  |   2 +-
 fs/bad_inode.c                  |   3 +-
 fs/btrfs/file.c                 |  24 +----
 fs/btrfs/inode.c                |  14 +--
 fs/btrfs/super.c                |   5 +-
 fs/btrfs/volumes.c              |   4 +-
 fs/ceph/inode.c                 |   2 +-
 fs/coda/inode.c                 |   3 +-
 fs/ecryptfs/inode.c             |   5 +-
 fs/erofs/inode.c                |   2 +-
 fs/exfat/file.c                 |   2 +-
 fs/ext2/inode.c                 |   2 +-
 fs/ext4/inode.c                 |   2 +-
 fs/ext4/super.c                 |   2 +-
 fs/f2fs/file.c                  |   2 +-
 fs/fat/fat.h                    |   3 +-
 fs/fat/file.c                   |   2 +-
 fs/fat/misc.c                   |   6 +-
 fs/fuse/dir.c                   |   2 +-
 fs/gfs2/inode.c                 |   8 +-
 fs/hfsplus/inode.c              |   2 +-
 fs/inode.c                      | 200 +++++++++++++++++++++++++++++++---------
 fs/kernfs/inode.c               |   2 +-
 fs/libfs.c                      |   4 +-
 fs/minix/inode.c                |   2 +-
 fs/nfs/inode.c                  |   2 +-
 fs/nfs/namespace.c              |   3 +-
 fs/ntfs3/file.c                 |   2 +-
 fs/ocfs2/file.c                 |   2 +-
 fs/orangefs/inode.c             |   5 +-
 fs/overlayfs/inode.c            |   2 +-
 fs/overlayfs/overlayfs.h        |   2 +-
 fs/proc/base.c                  |   4 +-
 fs/proc/fd.c                    |   2 +-
 fs/proc/generic.c               |   2 +-
 fs/proc/proc_net.c              |   2 +-
 fs/proc/proc_sysctl.c           |   2 +-
 fs/proc/root.c                  |   3 +-
 fs/smb/client/inode.c           |   2 +-
 fs/smb/server/smb2pdu.c         |  22 ++---
 fs/smb/server/vfs.c             |   3 +-
 fs/stat.c                       |  65 ++++++++++---
 fs/sysv/itree.c                 |   3 +-
 fs/ubifs/dir.c                  |   2 +-
 fs/ubifs/file.c                 |  19 ++--
 fs/ubifs/ubifs.h                |   2 +-
 fs/udf/symlink.c                |   2 +-
 fs/vboxsf/utils.c               |   2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |   6 +-
 fs/xfs/xfs_iops.c               |  25 +++--
 fs/xfs/xfs_super.c              |   2 +-
 include/linux/fs.h              |  55 +++++++++--
 mm/shmem.c                      |   4 +-
 55 files changed, 368 insertions(+), 192 deletions(-)
---
base-commit: 525deaeb2fbf634222f4231608c72190c551c935
change-id: 20230713-mgctime-f2a9fc324918

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

