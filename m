Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04A42ED59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbhJOJQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231273AbhJOJQ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:16:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EEC660EE2;
        Fri, 15 Oct 2021 09:14:50 +0000 (UTC)
Date:   Fri, 15 Oct 2021 11:14:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: The one and only "permission denied" in find /sys
Message-ID: <20211015091447.634toiguzrgyz22j@wittgenstein>
References: <cd81a57e-e2c1-03c5-d0da-f898babf92e7@landley.net>
 <7042EFC5-DA90-4B9A-951A-036889FD89CA@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7042EFC5-DA90-4B9A-951A-036889FD89CA@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:48:26PM -0700, Kees Cook wrote:
> 
> 
> On October 13, 2021 1:12:16 PM PDT, Rob Landley <rob@landley.net> wrote:
> >There is exactly one directory in the whole of sysfs that a normal user can't
> >read (at least on my stock devuan laptop):
> >
> >  $ find /sys -name potato
> >  find: ‘/sys/fs/pstore’: Permission denied
> >
> >It's the "pstore" filesystem, it was explicitly broken by commit d7caa33687ce,
> >and the commit seems to say this was to fix an issue that didn't exist yet but
> >might someday.
> 
> Right, so, the problem did certainly exist: there was a capability check for opening the files, which made it difficult for pstore collector tools to run with sane least privileges. Adjusting the root directory was the simplest way to keep the files secure by default, and allow a system owner the ability to delegate collector permissions to a user or group via just a chmod on the root directory.
> 
> >Did whatever issue it was concerned about ever actually start happening? Why did
> >you not change the permissions on the files _in_ the directory so they weren't
> >world readable instead? Should /dev/shm stop being world ls-able as well?
> 
> Making the per-file permissions configurable at runtime was more complex for little additional gain.
> 
> /dev/shm has the benefit of having an existing permission model for each created file.
> 
> I wouldn't be opposed to a mount option to specify the default file owner/group, but it makes user space plumbing more difficult (i.e. last I checked, stuff like systemd tends to just mount kernel filesystems without options).

Hm, no, we do mount kernel filesystems with different options. :)
So if pstore gains an option that could be changed pretty easily. Unless
you meant something else by kernel filesystems. :)

static const MountPoint mount_table[] = {
        { "proc",        "/proc",                     "proc",       NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
          NULL,          MNT_FATAL|MNT_IN_CONTAINER|MNT_FOLLOW_SYMLINK },
        { "sysfs",       "/sys",                      "sysfs",      NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
          NULL,          MNT_FATAL|MNT_IN_CONTAINER },
        { "devtmpfs",    "/dev",                      "devtmpfs",   "mode=755" TMPFS_LIMITS_DEV,               MS_NOSUID|MS_STRICTATIME,
          NULL,          MNT_FATAL|MNT_IN_CONTAINER },
        { "securityfs",  "/sys/kernel/security",      "securityfs", NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
          NULL,          MNT_NONE                   },
#if ENABLE_SMACK
        { "smackfs",     "/sys/fs/smackfs",           "smackfs",    "smackfsdef=*",                            MS_NOSUID|MS_NOEXEC|MS_NODEV,
          mac_smack_use, MNT_FATAL                  },
        { "tmpfs",       "/dev/shm",                  "tmpfs",      "mode=1777,smackfsroot=*",                 MS_NOSUID|MS_NODEV|MS_STRICTATIME,
          mac_smack_use, MNT_FATAL                  },
#endif
        { "tmpfs",       "/dev/shm",                  "tmpfs",      "mode=1777",                               MS_NOSUID|MS_NODEV|MS_STRICTATIME,
          NULL,          MNT_FATAL|MNT_IN_CONTAINER },
        { "devpts",      "/dev/pts",                  "devpts",     "mode=620,gid=" STRINGIFY(TTY_GID),        MS_NOSUID|MS_NOEXEC,
          NULL,          MNT_IN_CONTAINER           },
#if ENABLE_SMACK
        { "tmpfs",       "/run",                      "tmpfs",      "mode=755,smackfsroot=*" TMPFS_LIMITS_RUN, MS_NOSUID|MS_NODEV|MS_STRICTATIME,
          mac_smack_use, MNT_FATAL                  },
#endif
        { "tmpfs",       "/run",                      "tmpfs",      "mode=755" TMPFS_LIMITS_RUN,               MS_NOSUID|MS_NODEV|MS_STRICTATIME,
          NULL,          MNT_FATAL|MNT_IN_CONTAINER },
        { "cgroup2",     "/sys/fs/cgroup",            "cgroup2",    "nsdelegate,memory_recursiveprot",         MS_NOSUID|MS_NOEXEC|MS_NODEV,
          cg_is_unified_wanted, MNT_IN_CONTAINER|MNT_CHECK_WRITABLE },
        { "cgroup2",     "/sys/fs/cgroup",            "cgroup2",    "nsdelegate",                              MS_NOSUID|MS_NOEXEC|MS_NODEV,
          cg_is_unified_wanted, MNT_IN_CONTAINER|MNT_CHECK_WRITABLE },
        { "cgroup2",     "/sys/fs/cgroup",            "cgroup2",    NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
          cg_is_unified_wanted, MNT_IN_CONTAINER|MNT_CHECK_WRITABLE },
        { "tmpfs",       "/sys/fs/cgroup",            "tmpfs",      "mode=755" TMPFS_LIMITS_SYS_FS_CGROUP,     MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_STRICTATIME,
          cg_is_legacy_wanted, MNT_FATAL|MNT_IN_CONTAINER },
        { "cgroup2",     "/sys/fs/cgroup/unified",    "cgroup2",    "nsdelegate",                              MS_NOSUID|MS_NOEXEC|MS_NODEV,
          cg_is_hybrid_wanted, MNT_IN_CONTAINER|MNT_CHECK_WRITABLE },
        { "cgroup2",     "/sys/fs/cgroup/unified",    "cgroup2",    NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
          cg_is_hybrid_wanted, MNT_IN_CONTAINER|MNT_CHECK_WRITABLE },
        { "cgroup",      "/sys/fs/cgroup/systemd",    "cgroup",     "none,name=systemd,xattr",                 MS_NOSUID|MS_NOEXEC|MS_NODEV,
          cg_is_legacy_wanted, MNT_IN_CONTAINER     },
        { "cgroup",      "/sys/fs/cgroup/systemd",    "cgroup",     "none,name=systemd",                       MS_NOSUID|MS_NOEXEC|MS_NODEV,
          cg_is_legacy_wanted, MNT_FATAL|MNT_IN_CONTAINER },
        { "pstore",      "/sys/fs/pstore",            "pstore",     NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
          NULL,          MNT_NONE                   },
#if ENABLE_EFI
        { "efivarfs",    "/sys/firmware/efi/efivars", "efivarfs",   NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
          is_efi_boot,   MNT_NONE                   },
#endif
        { "bpf",         "/sys/fs/bpf",               "bpf",        "mode=700",                                MS_NOSUID|MS_NOEXEC|MS_NODEV,
          NULL,          MNT_NONE,                  },
};
