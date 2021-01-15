Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A966F2F8416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbhAOSUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388218AbhAOSUN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3550423A58;
        Fri, 15 Jan 2021 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734772;
        bh=7HZGCsiZfKx7k8RTP6gegLOEC7SUZGN0WL2KEa1MIqw=;
        h=From:To:Cc:Subject:Date:From;
        b=OLgSi9dXP1/YkA9HyFOY/X6hDj3RaQ6Ohe7A5+afoRqJVi76p4BsVaWFg67i7xPN+
         6tZ+JGUzOYkAc4C6Sqpk7z0yCXnts0hnTQUE9wijYEKFxyXOS+SYpEz0qXShSdLEMS
         IeVxDBKO7PWFFEmTKsOKfgQW8p3OWYonyQJLlena81DsNsqLA9MvUbaXw3qdaBVUFQ
         RlvnXyxdljEpWdHSNlQ0ZgoJ6VenS6b64yLhH9TfUezjo6pSp27OciWtK9MAPSrZ7P
         yat9Uam8Fm2+YLYUl4HU+10eRYuebg0aC9S/umMOtp6WfZpH/R0zghGYgHcWvoPGz3
         P26n77xWu0DGw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 0/6] fs-verity: add an ioctl to read verity metadata
Date:   Fri, 15 Jan 2021 10:18:13 -0800
Message-Id: <20210115181819.34732-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[This patchset applies to v5.11-rc3]

Add an ioctl FS_IOC_READ_VERITY_METADATA which allows reading verity
metadata from a file that has fs-verity enabled, including:

- The Merkle tree
- The fsverity_descriptor (not including the signature if present)
- The built-in signature, if present

This ioctl has similar semantics to pread().  It is passed the type of
metadata to read (one of the above three), and a buffer, offset, and
size.  It returns the number of bytes read or an error.

This ioctl doesn't make any assumption about where the metadata is
stored on-disk.  It does assume the metadata is in a stable format, but
that's basically already the case:

- The Merkle tree and fsverity_descriptor are defined by how fs-verity
  file digests are computed; see the "File digest computation" section
  of Documentation/filesystems/fsverity.rst.  Technically, the way in
  which the levels of the tree are ordered relative to each other wasn't
  previously specified, but it's logical to put the root level first.

- The built-in signature is the value passed to FS_IOC_ENABLE_VERITY.

This ioctl is useful because it allows writing a server program that
takes a verity file and serves it to a client program, such that the
client can do its own fs-verity compatible verification of the file.
This only makes sense if the client doesn't trust the server and if the
server needs to provide the storage for the client.

More concretely, there is interest in using this ability in Android to
export APK files (which are protected by fs-verity) to "protected VMs".
This would use Protected KVM (https://lwn.net/Articles/836693), which
provides an isolated execution environment without having to trust the
traditional "host".  A "guest" VM can boot from a signed image and
perform specific tasks in a minimum trusted environment using files that
have fs-verity enabled on the host, without trusting the host or
requiring that the guest has its own trusted storage.

Technically, it would be possible to duplicate the metadata and store it
in separate files for serving.  However, that would be less efficient
and would require extra care in userspace to maintain file consistency.

In addition to the above, the ability to read the built-in signatures is
useful because it allows a system that is using the in-kernel signature
verification to migrate to userspace signature verification.

This patchset has been tested by new xfstests which call this new ioctl
via a new subcommand for the 'fsverity' program from fsverity-utils.

Eric Biggers (6):
  fs-verity: factor out fsverity_get_descriptor()
  fs-verity: don't pass whole descriptor to fsverity_verify_signature()
  fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl
  fs-verity: support reading Merkle tree with ioctl
  fs-verity: support reading descriptor with ioctl
  fs-verity: support reading signature with ioctl

 Documentation/filesystems/fsverity.rst |  76 ++++++++++
 fs/ext4/ioctl.c                        |   7 +
 fs/f2fs/file.c                         |  11 ++
 fs/verity/Makefile                     |   1 +
 fs/verity/fsverity_private.h           |  13 +-
 fs/verity/open.c                       | 133 +++++++++++------
 fs/verity/read_metadata.c              | 195 +++++++++++++++++++++++++
 fs/verity/signature.c                  |  20 +--
 include/linux/fsverity.h               |  12 ++
 include/uapi/linux/fsverity.h          |  14 ++
 10 files changed, 417 insertions(+), 65 deletions(-)
 create mode 100644 fs/verity/read_metadata.c


base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.30.0

