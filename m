Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0667BE51E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 17:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377547AbjJIPiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377050AbjJIPhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:37:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1F310F4;
        Mon,  9 Oct 2023 08:37:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32483535e51so4666534f8f.0;
        Mon, 09 Oct 2023 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865840; x=1697470640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDR0W7u1G7fFVPvWf4mUuccTiiZy5dNsBJkbrHnXXc8=;
        b=KKl87cIx5hkk5Rnk2q/+ufl3/XOUsyfscNQUMmCFiB9ghDf85Q6AX2pY1whXL3V8hV
         sfZ4jPmu4a7c6w67B/gFSyIqaI7iITaSq6AzygRnrqRulxUSMLB/wJu+vXZ7bdli+2ry
         /vLQEkEk3ZDi3UjEVbQJSlysjY5DYw+hzJtlk8jZQSla+7bwMsa85+Zec6DImCemEaG3
         hLytWcLPO/SvnXqsU5KOdYqYqqYgpSCr6UWVKChrIRDSSLIIWgpYa9Rr2iQnsibVnoQ5
         v7wZCcxGvurG+Q3jEzAZFAjuK7QE+L6MV5vfBGKuIte88LdGSAq7h/npi2eiPkg711Hi
         SJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865840; x=1697470640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDR0W7u1G7fFVPvWf4mUuccTiiZy5dNsBJkbrHnXXc8=;
        b=KK5ociEXLKkCb3T5sJ3F/Z6QlZ7q7ry2fPSGRpCkdN30mRryZsdDw/9ONBZzE/mkyt
         jmFVx2L7JnWiZd5B1o7H2JdLPpmZQ4WfqFL4xMzPhmy3LTFZ65AEPd9oA1bep2gHihUI
         zyhWu+OpOworuWtlKte2ionqrdvfJyxf5908H/G1BxGsGVTlQvnmfooRKBj2etRpv6YS
         pDT4QVFdSKW2tXYMPe7eN+YJAXhutDxLFDUJyrW2tg48KRij//FequtJdWOAjnBi3ybS
         uln8KfP2KO9H+tHtGnWfJtYvkvSINcETocZHAe+E3lvN0lrI//nOxvh5RpnZkiMfG2oD
         apNg==
X-Gm-Message-State: AOJu0YwMkXN4BndRHvjdFrW1Wozyxj8KE2svJQIqfsoeivwiRY02j2kr
        bU08XNaytzwqmXSjWcwxK84=
X-Google-Smtp-Source: AGHT+IGALbyf0lFjKf5XyJU0wNZWyFwLqh1az96WG1MqE6EIC6IBRC7FVKbhAiMxfAHBpVE/d+bloQ==
X-Received: by 2002:a5d:4f85:0:b0:31a:ea9a:b602 with SMTP id d5-20020a5d4f85000000b0031aea9ab602mr15429199wru.1.1696865839526;
        Mon, 09 Oct 2023 08:37:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b003143c9beeaesm9939924wrx.44.2023.10.09.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:37:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/3] Reduce impact of overlayfs backing files fake path
Date:   Mon,  9 Oct 2023 18:37:09 +0300
Message-Id: <20231009153712.1566422-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

Following v3 addresses Al's review comments on v2.

---
This is another step in the multi step plan to reduce the vulnerability
of filesystems code to overlayfs backing files whose f_path and f_inode
are not on the same sb.

History:
--------
When overlayfs was first merged, overlayfs files of regular files and
directories, the ones that are installed in file table, had a "fake" path,
namely, f_path is the overlayfs path and f_inode is the "real" inode on
the underlying filesystem.

At that time, all filesystem syscalls, generic vfs code and any filesystem
code (among the fs that are supported as overlayfs underlying layers) had
to be aware of the possibility of a file with "fake" path and had to use
the helper file_dentry() to get the "real" dentry and the helper
locks_inode() to get to the overlayfs inode.
At that time, there was no way to get the "real" path.

This situation was fragile because many filesystem developers were not
aware of having to deal with file with "fake" path.
Admittedly, it wasn't very well documented either.

Backing files:
--------------
The first big step to reduce the impact of files with fake path was in
v4.19 that introduced d1d04ef8572b ("ovl: stack file ops").  Since
v4.19, f_inode of the overlayfs files that are installed in file table
are overlayfs inodes, so those files are no longer odd.

As a result of this change, a lot of syscalls code, which take fd as an
argument, is no longer exposed to files with "fake" path and the helper
file_locks() was no longer needed.

However, since v4.19, overlayfs uses internal backing files with "fake"
path, so generic vfs code that overlayfs calls with the backing files and
filesystem code still needs to be aware of files with "fake" path.

The one place where the internal backing files are "exposed" to users
is when users mmap overlayfs files, the backing file (and not the
overlayfs file) is stored in vm_file. The reason that overlayfs backing
files use a "fake" path is so that /proc/<pid>/maps will disaply the
overlayfs file path to users.

Recently:
---------
In v6.5, we took another small step by introducing of the backing_file
container and the file_real_path() helper.  This change allowed vfs and
filesystem code to get the "real" path of an overlayfs backing file.
With this change, we were able to make fsnotify work correctly and
report events on the "real" filesystem objects that were accessed via
overlayfs.

This method works fine, but it still leaves the vfs vulnerable to new
code that is not aware of files with fake path.  A recent example is
commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version").
This commit uses direct referencing to f_path in IMA code that otherwise
uses file_inode() and file_dentry() to reference the filesystem objects
that it is measuring.

Coming up:
----------
This patch set actually implements my initial proposal [1] that was
proposed for v6.5 - instead of having filesystem code opt-in to get the
"real" path, have generic code opt-in for the "fake" path in the few
places that it is needed.

It is possible that I missed a few places that need opt-in for "fake"
path, but in most likelihood, a missed opt-in to "fake" path would just
result in printing the "real" path to user and if %pD is used for
printing, that will probably make no difference anyway.

Is it far more likely that new filesystems code that does not use the
file_dentry() and file_real_path() helpers will end up causing crashes
or averting LSM/audit rules if we keep the "fake" path exposed by default.

Future:
-------
This change already makes file_dentry() moot, but for now we did not
change this helper just added a WARN_ON() in ovl_d_real() to catch if we
have made any wrong assumptions.

After the dust settles on this change, we can make file_dentry() a plain
accessor and we can drop the inode argument to ->d_real().

Testing:
--------
As usual, I ran fstests with overlayfs over xfs and all the LTS tests
that test fsnotify + overlayfs.

I have limited testing ability for audit/IMA/LSM modules, so we will
have to rely on other people and bots testing of linux-next.
Syzbot has been known to be very obsessive about reporting bugs of
overlayfs + IMA.

Merging:
--------
The branch that I tested [2] is based on both the stable vfs.mount.write
branch and vfs.misc of the moment.

If you agree to stage these patches in vfs tree, they would need
to be based on both vfs.mount.write and the file_free_rcu patches.
So perhaps split the file_free_rcu patches out of vfs.misc and into a
vfs.file topic branch that is based on the stable vfs.mount.write branch
and add my patches on top?

I don't need vfs.file to be stable, I understand that the file_free_rcu()
patches may still change, but since I would like to test overlayfs-next
together with the "fake" path patches, it would be nice if the vfs.file
branch would be more stable than vfs.misc usually is.

Thanks,
Amir.

Changes since v2:
- No need to check for NULL user_path->mnt (viro)
- Simplify the ovl_d_real() assertion of non-NULL inode (viro)
- Remove f_path() accessor (viro)

Changes since v1:
- backing_file (fake_file rebranded) container already merged
- fsnotify support for backing files already merged
- Take mnt_writers refcount on the "real" path
- Rename file_fake_path() => file_user_path()
- No need to use file_user_path() for exe_file path access
- No need to use file_user_path() in audit/LSM code
- Added file_user_path() in some tracing/debugging code

[1] https://lore.kernel.org/r/20230609073239.957184-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/ovl_fake_path

Amir Goldstein (3):
  fs: get mnt_writers count for an open backing file's real path
  fs: create helper file_user_path() for user displayed mapped file path
  fs: store real path instead of fake path in backing file f_path

 arch/arc/kernel/troubleshoot.c |  6 ++--
 fs/file_table.c                | 12 ++++----
 fs/internal.h                  | 11 +++++--
 fs/open.c                      | 52 +++++++++++++++++++++++-----------
 fs/overlayfs/super.c           | 16 ++++++++---
 fs/proc/base.c                 |  2 +-
 fs/proc/nommu.c                |  2 +-
 fs/proc/task_mmu.c             |  4 +--
 fs/proc/task_nommu.c           |  2 +-
 include/linux/fs.h             | 22 +++++++-------
 include/linux/fsnotify.h       |  3 +-
 kernel/trace/trace_output.c    |  2 +-
 12 files changed, 84 insertions(+), 50 deletions(-)

-- 
2.34.1

