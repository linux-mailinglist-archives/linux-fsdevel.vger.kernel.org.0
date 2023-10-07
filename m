Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1C67BC621
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjJGIon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJGIol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:44:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E988B9;
        Sat,  7 Oct 2023 01:44:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3296b87aa13so1141907f8f.3;
        Sat, 07 Oct 2023 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696668279; x=1697273079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8Q6RB7pZRofW9grFTMD1CNsmWWlfFvEqQfQ3qiNILA=;
        b=LF7TGU9p9zVClDuBLIDKdbGGsAqWagsP33055tE/3zDXtmLnBkFtWrxouQT5F/1oIN
         St/lg9nu5HPe9NAgR01Sewg+qjP5I8/4drrD5XXcqp+HbZN5gONPbU3TEdQ8L9pDiooP
         o9JpJAm9/PQEHF703iV+GoVv+J2Q38ct2VWyHxt43AamWA/ck0dbPTIk49nFDjuBEa/a
         C94nvvBtgSJRGZ6MVlHTvx8HuxicaLYhJM3oS25tPdt6G8kvjH0n+4y36yOBFlMuGyky
         72UtuUgVuehYkV31RQ/TmCEu3TYS0Udm8aIfj3/Dv11RMIbGJspw9tJjSXWWVZ5PzADL
         YQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668279; x=1697273079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8Q6RB7pZRofW9grFTMD1CNsmWWlfFvEqQfQ3qiNILA=;
        b=j64AT7T6/Tzo9vo33eo6Nd8v3JXq/0AbOGqnqN1/f1bIa3OU9V9aFXUxAw+Z1bN6Ka
         ENrlGNcxlmxYTxnV2KVQLAcEN+K92vomoP3Nc0OZscuB/iivk1nSZzFX1kjaalz0Kn9Y
         XdGh0YNI2+mIy8LNaeo9yh7lRoLqA7y7c+mVgJaEHUXgVSosvZaWZyWiNANL32suueCT
         GchYNbsen1Thv1j54PzBVIBIzvtmS69ooePIub1x0n2WEmenR9J2XwT7DDv+OARAj1Pg
         5ME/15rzy1gPj6R5et/tP4ZE1fSNPVrD/v4UPWnPLUqnJqDpIltU1heWlseBIqJs17rt
         XlGA==
X-Gm-Message-State: AOJu0Yxat1LbASO++mIJcSOwAWgg9VGT56ZXRXRsPm6TmBCsT8zHCAUO
        zN1iQRQixaCJZP+Ea5vJG/g=
X-Google-Smtp-Source: AGHT+IFvZbr6hhHd2T1Ug+7rj0jacx1PmFHcSWJVko1czZJ7BoTnXKH9FIICdPnTHbJJHx8a1eLhaQ==
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id b12-20020a5d4d8c000000b0032336a308camr9504559wru.28.1696668278356;
        Sat, 07 Oct 2023 01:44:38 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a12-20020adff7cc000000b0031423a8f4f7sm3677850wrq.56.2023.10.07.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:44:37 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Reduce impact of overlayfs backing files fake path
Date:   Sat,  7 Oct 2023 11:44:30 +0300
Message-Id: <20231007084433.1417887-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

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

 arch/arc/kernel/troubleshoot.c |  3 +-
 fs/file_table.c                | 12 ++++----
 fs/internal.h                  | 15 ++++++++--
 fs/open.c                      | 55 +++++++++++++++++++++++-----------
 fs/overlayfs/super.c           | 11 ++++++-
 fs/proc/base.c                 |  2 +-
 fs/proc/nommu.c                |  2 +-
 fs/proc/task_mmu.c             |  4 +--
 fs/proc/task_nommu.c           |  2 +-
 include/linux/fs.h             | 27 ++++++++++-------
 include/linux/fsnotify.h       |  3 +-
 kernel/trace/trace_output.c    |  2 +-
 12 files changed, 92 insertions(+), 46 deletions(-)

-- 
2.34.1

