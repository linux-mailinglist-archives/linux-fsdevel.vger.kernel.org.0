Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF715A85D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 12:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBLLzW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 06:55:22 -0500
Received: from albireo.enyo.de ([37.24.231.21]:57468 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgBLLzW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:55:22 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 06:55:20 EST
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1j1qWy-0000MT-Hp; Wed, 12 Feb 2020 11:50:12 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1j1qVd-00029u-Nu; Wed, 12 Feb 2020 12:48:49 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     linux-xfs@vger.kernel.org
Cc:     libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org
Subject: XFS reports lchmod failure, but changes file system contents
Date:   Wed, 12 Feb 2020 12:48:49 +0100
Message-ID: <874kvwowke.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In principle, Linux supports lchmod via O_PATH descriptors and chmod
on /proc/self/fd.  (lchmod is the non-symbolic-link-following variant
of chmod.)

This helper program can be used to do this:

#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

int
main (int argc, char **argv)
{
  if (argc != 3)
    {
      fprintf (stderr, "usage: %s MODE FILE\n", argv[0]);
      return 2;
    }

  unsigned int mode;
  if (sscanf (argv[1], "%o", &mode) != 1
      || mode != (mode_t) mode)
    errx (1, "invalid mode: %s", argv[1]);

  int fd = open (argv[2], O_PATH | O_NOFOLLOW);
  if (fd < 0)
    err (1, "open");

  char *fd_path;
  if (asprintf (&fd_path, "/proc/self/fd/%d", fd) < 0)
    err (1, "asprintf");

  if (chmod (fd_path, mode) != 0)
    err (1, "chmod");

  free (fd_path);
  if (close (fd) != 0)
    err (1, "close");

  return 0;
}

When changing the permissions of on XFS in this way, the chmod
operation fails:

$ ln -s does-not-exist /var/tmp/symlink
$ ls -l /var/tmp/symlink 
lrwxrwxrwx. 1 fweimer fweimer 14 Feb 12 12:41 /var/tmp/symlink -> does-not-exist
$ strace ./lchmod 0 /var/tmp/symlink
[…]
openat(AT_FDCWD, "/var/tmp/symlink", O_RDONLY|O_NOFOLLOW|O_PATH) = 3
[…]
chmod("/proc/self/fd/3", 000)           = -1 EOPNOTSUPP (Operation not supported)
write(2, "lchmod: ", 8lchmod: )                 = 8
write(2, "chmod", 5chmod)                    = 5
write(2, ": Operation not supported\n", 26: Operation not supported
) = 26
exit_group(1)                           = ?

But the file system contents has changed nevertheless:

$ ls -l /var/tmp/symlink 
l---------. 1 fweimer fweimer 14 Feb 12 12:41 /var/tmp/symlink -> does-not-exist
$ echo 3 | sudo tee /proc/sys/vm/drop_caches 
$ ls -l /var/tmp/symlink 
l---------. 1 fweimer fweimer 14 Feb 12 12:41 /var/tmp/symlink -> does-not-exist

This looks like an XFS bug to me.  With tmpfs, the chmod succeeds and
is reflected in the file system.

This bug also affects regular files, not just symbolic links.

It causes the io/tst-lchmod glibc test to fail (after it has been
fixed, the in-tree version has another bug).
