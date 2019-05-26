Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0772A89D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 08:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfEZGLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 02:11:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39168 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfEZGLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 02:11:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so4888362wrv.6;
        Sat, 25 May 2019 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cNKwvO5MUB9vIEOYCzNWnpEb6DCMPOl/EdbDoCx4lyw=;
        b=QYqqfGka1EsmfNwoXaCiP/l08BQQlSPmuIaN4Fv5iMVZJmFQo9BxIQ+2TZc7MS4Oe1
         Ih8zsJRnU4YCo1oU/WnRMTfaG5bp+WOo02IIKPCmqJO2mWP4qnTONG4UtM18j0e3FVd+
         lxQXcvLG0BgAvj6aGWiWk1DHsLhRpmtGLEyXDLezaXJRN6XFi3wTApYdXxIF7gHf9GkD
         bDB4/zMep2Gb2qpIuHK4kW9AyiAsdvrNXt5ZbaE19ECf5tlBSfwkHFRcxei6X3CqwR4a
         RcNa2bZoavR0CllcaTuzbmnZFho5uV/8xv1AgblphqRI1YJdmTIIEwEXpnWeHhJ1LCDG
         lxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cNKwvO5MUB9vIEOYCzNWnpEb6DCMPOl/EdbDoCx4lyw=;
        b=C9tOJ+NWJlxGnJFJ4oOy7OFmre4HwhoEcLrErD9akv5QM6E85t2sfkgwgM1nNvZWA2
         10nYIUUS4/aiZIfpNMs1XOWNE7nvZVWcX8QqlOhQSaQB0Js/SOOA6aPpfb5TDJ7QpANI
         5H1k5qVpbvsCRUqzlvvYVJ04UwOlMa50CgfUDN9lTZOB74wxppb+TgonLIoXbiK+/vT5
         FeyJfxZ2PNxuyaQRYT5osCZptTzz/t7NaS3qOK0E+uWBqDG7IH0VHDXWgC51gWE7uCSH
         jIVFk/vvWanLuOuaTP5OO9T0z5qKjRwRZaWAin3uV7CRgk55txAMUdgZTcxr4aSEPOiy
         xxzQ==
X-Gm-Message-State: APjAAAUYWrXXi7CCskWtsC3akU8c/JdUpGpoWYnQZ+SPbzCVzrroSfQ+
        Q6U9pwg4epoZnum8CPK2Z6M=
X-Google-Smtp-Source: APXvYqyiBiGQ8rTpBQSdxI26WBUk3CKAN4bf1ZiNqIaIGtNHvD7/0Jm/m+Rja9fXJ0rlyQN4ooz3cQ==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr235957wru.288.1558851071846;
        Sat, 25 May 2019 23:11:11 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id a124sm5302943wmh.3.2019.05.25.23.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 23:11:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/8] Fixes for major copy_file_range() issues
Date:   Sun, 26 May 2019 09:10:51 +0300
Message-Id: <20190526061100.21761-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Following is a re-work of Dave Chinner's patches from December [4].
I have updated the kernel patches [1] xfstests [2] and man-page [3]
according to the feedback on v1.

NOTE that this work changes user visible behavior of copy_file_range(2)!
It introduces new errors for cases that were not checked before and it
allows cross-device copy by default. After this work, cifs copy offload
should be possible between two shares on the same server, but I did not
check this functionality.

The major difference from v1 is to conform to short read(2) semantics
that are already implemented for copy_file_range(2) instead of the
documented EINVAL, as suggested by Christoph.

My tests of this work included testing various filesystems for the
fallback default copy_file_range implementation, both filesystems that
support copy_file_range and filesystems that do not. My tests did not
include actual copy offload with nfs/cifs/ceph, so any such tests by
said filesystem developers would be much appreciated.
Special thanks to Olga Kornievskaia and Luis Henriques for helping me
test this work on nfs and ceph.

Darrick, seeing that you and Dave invested most in this work and
previous similar fixes and tests of the remap_file_range series, I
though it would be best if you carried these patches through the xfs
tree or collaborate their merge with the vfs tree.

Please note that the patch [8/8] is not related to copy_file_range,
but I included it in the series because it belongs in the context.

The man page update patch (again, mostly Dave's work) is appended
to the series.

Thanks,
Amir.

Changes since v1:
- Short read instead of EINVAL (Christoph)
- generic_file_rw_checks() helper (Darrick)
- generic_copy_file_range_prep() helper (Christoph)
- Not calling ->remap_file_range() with different sb
- Not calling ->copy_file_range() with different fs type
- Remove changes to overlayfs
- Extra fix to clone/dedupe checks

Amir Goldstein (5):
  vfs: introduce generic_file_rw_checks()
  vfs: add missing checks to copy_file_range
  vfs: copy_file_range needs to strip setuid bits
  vfs: allow copy_file_range to copy across devices
  vfs: remove redundant checks from generic_remap_checks()

Dave Chinner (3):
  vfs: introduce generic_copy_file_range()
  vfs: no fallback for ->copy_file_range
  vfs: copy_file_range should update file timestamps

 fs/ceph/file.c     |  32 +++++++++-
 fs/cifs/cifsfs.c   |  13 +++-
 fs/fuse/file.c     |  28 ++++++++-
 fs/nfs/nfs42proc.c |   8 ++-
 fs/nfs/nfs4file.c  |  23 ++++++-
 fs/read_write.c    | 146 +++++++++++++++++++++++++++++++++------------
 include/linux/fs.h |   9 +++
 mm/filemap.c       |  81 +++++++++++++++++++++++--
 8 files changed, 283 insertions(+), 57 deletions(-)

[1] https://github.com/amir73il/linux/commits/copy_file_range-v2
[2] https://github.com/amir73il/xfstests/commits/copy_file_range-v2
[3] https://github.com/amir73il/man-pages/commits/copy_file_range-v2
[4] https://lore.kernel.org/linux-fsdevel/20181203083416.28978-1-david@fromorbit.com/

Original cover letter by Dave:
------------------------------

Hi folks,

As most of you already know, we really suck at introducing new
functionality. The recent problems we found with clone/dedupe file
range interfaces also plague the copy_file_range() API and
implementation. Not only doesn't it do exactly what the man page
says, the man page doesn't document everything the syscall does
either.

There's a few problems:
	- can overwrite setuid files
	- can read from and overwrite active swap files
	- can overwrite immutable files
	- doesn't update timestamps
	- doesn't obey resource limits
	- doesn't catch overlapping copy ranges to the same file
	- doesn't consistently implement fallback strategies
	- does error out when the source range extends past EOF like
	  the man page says it should
	- isn't consistent with clone file range behaviour
	- inconsistent behaviour between filesystems
	- inconsistent fallback implementations

And so on. There's so much wrong, and I haven't even got to the
problems that the generic fallback code (i.e. do_splice_direct()
has). That's for another day.

So, what this series attempts to do is clean up the code, implement
all the missing checks, provide an infrastructure layout that allows
for consistent behaviour across filesystems and allows filesysetms
to control fallback mechanisms and cross-device copies.

I'll repeat that so it's clear: the series also enabled cross-device
copies once all the problems are sorted out.

To that end, the current fallback code is moved to
generic_copy_file_range(), and that is called only if the filesystem
does not provide a ->copy_file_range implementation. If the
filesystem provides such a method, it must implement the page cache
copy fallback itself by calling generic_copy_file_range() when
appropriate. I did this because different filesystems have different
copy-offload capabilities and so need to fall back in different
situations. It's easier to have them call generic_copy_file_range()
to do that copy when necessary than it is to have them try to
communicate back up to vfs_copy_file_range() that it should run a
fallback copy.

To make all the implementations perform the same validity checks,
I've created a generic_copy_file_checks() which is similar to the
checks we do for clone/dedupe. It's not quite the same, but the core
is very similar. This strips setuid, updates timestamps, checks and
enforces filesystem and resource limits, bounds checks the copy
ranges, etc.

This needs to be run before we call ->remap_file_range() so that we
end up with consistent behaviour across copy_file_range() calls.
e.g. we want an XFS filesystem with reflink=1 (i.e. supports
->remap_file_range()) to behave the same as an XFS filesystem with
reflink=0. Hence we need to check all the parameters up front so we
don't end up with calls to ->remap_file_range() resulting in
different behaviour.

It also means that ->copy_file_range implementations only need to
bounds checking the input against fileystem internal constraints,
not everything. This makes the filesystem implementations simpler,
and means they can call the fallback generic_copy_file_range()
implementation without having to care about further bounds checking.

I have not changed the fallback behaviour of the CIFS, Ceph or NFS
client implementations. They still reject copy_file_range() to the
same file with EINVAL, even though it is supported by the fallback
and filesystems that implement ->remap_file_range(). I'll leave it
for the maintainers to decide if they want to implement the manual
data copy fallback or not. My personal opinion is that they should
implement the fallback where-ever they can, but userspace has to be
prepared for copy_file_range() to fail and so implementing the
fallback is an optional feature.

In terms of testing, Darrick and I have been beating the hell out of
copy_file_range with fsx on XFS to sort out all the data corruption
problems it has exposed (we're still working on that). Patches have
been posted to enhance fsx and fsstress in fstests to exercise
clone/dedupe/copy_file_range. Thread here:

https://www.spinics.net/lists/fstests/msg10920.html

I've also written a bounds/behaviour exercising test:

https://marc.info/?l=fstests&m=154381938829897&w=2
https://marc.info/?l=fstests&m=154381939029898&w=2
https://marc.info/?l=fstests&m=154381939229899&w=2
https://marc.info/?l=fstests&m=154381939329900&w=2

I don't know whether I've got all the permission tests right in this
patchset. There's absolutely no documentation telling us when we
should use file_permission, inode_permission, etc in the
documentation or the code, so I just added the things that made the
tests do the things i think are the right things to be doing.

To run the tests, you'll also need modifications to xfs_io to allow
it to modify state appropriately. This is something we have
overlooked in the past, and so a lots of xfs_io based behaviour
checking is not actually testing the syscall we thought it was
testing but is instead testing the permission checking of the open()
syscall. Those patches are here:

https://marc.info/?l=linux-xfs&m=154378403323889&w=2
https://marc.info/?l=linux-xfs&m=154378403523890&w=2
https://marc.info/?l=linux-xfs&m=154378403323888&w=2
https://marc.info/?l=linux-xfs&m=154379644526132&w=2

These changes really need to go in before we merge any more
copy_file_range() features - we need to get the basics right and get
test coverage over it before we unleash things like NFS server-side
copies on unsuspecting users with filesystems that have busted
copy_file_range() implementations.

I'll be appending a man page patch to this series that documents all
the errors this syscall can throw, the expected behaviours, etc. The
test and the man page were written together first, and the
implementation changes were done second. So if you don't agree with
the behaviour, discuss what the man page patch should say and define,
then I'll change the test to reflect that and I'll go from there.

-Dave.
-- 
2.17.1

