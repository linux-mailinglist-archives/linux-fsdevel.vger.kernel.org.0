Return-Path: <linux-fsdevel+bounces-15622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC189109A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD791C25981
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9A1D699;
	Fri, 29 Mar 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aB/f3A+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5F171D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677242; cv=none; b=mn4v5zT0c4g/hehaWDhEb0UUTv1lFUrbgnBdKKhE1Eh1t2CYx2d12F0OW3Xs3jgk858v/5F/SDUZGv4Mmnk+fPKbGrwHfLcBooUF0LcFcyvudcWN1dICWkDi4+eB8GIAJZFHFFp0p8mxfHLop8HslJ+Et0OImRVaIAtGoPAVvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677242; c=relaxed/simple;
	bh=lZQQuABwJOZmsUVIT61uWFDnm9sPaB2yuqUrKtsNR+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r4rHDxZnv7+smD2ygC7xYljNctSFBHnMf0BWhLVcXpPX1WjA8XI3QJymmy1kQsfOKnxyOrTK5semmYIdlMkYHhH5iGLQ+/ihPunxuNJfCl5xZWWg5WXK43E9zg5l1f6fhVZraCLeNW8e4ipaO1C+WqUoq87dhx4PmXU0sPa+NkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aB/f3A+0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ab69a9e6fso32646767b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677240; x=1712282040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0NIzBAv+SjWsssKXwGXD1rG7WqoBIi+ZSW1OwLkK/0=;
        b=aB/f3A+0y2zE3//JflrfPOK/EMqYs4pKgx5lsOtZOxmrr4t9pxHB/UVniPQL776sOh
         HoNA8wORbOBoSfSG6QBQhyXndgV/Z7FxKPsEW/CL8vdpEFDLmS3Mvki8FxMEZzzOLtMn
         niv8in4Et03d21JGWbsJFrymPXOAO7AblFKOnoFTyut96PLXHRUHKvrQQ4nKJPmsy0Ne
         4yRLNtNVayYO7HYP3H1LIk1CQ7J9XtAIT+d5txKgNfRglCk7ObzRPlBsK2T1NEHzPuRJ
         no/YqmVe4gYDEraWAVjCjit3EQ/OsHhZEVw0bLXYAvbtX7Uosvz29P6oykAT//vCwmwc
         KeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677240; x=1712282040;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0NIzBAv+SjWsssKXwGXD1rG7WqoBIi+ZSW1OwLkK/0=;
        b=YSccLQF/3Nu+jU5tbkKRQ1waFntIzgXnR/EUGIWTAuYXqTvKljKlRmRH3zbyoLfr1E
         qUIx28vv39buZXdjVEKhItTsj0E9pGM5eDzUawOBJbXD+F0WzcyFZj8t6nl1JIL/HJkL
         2/5Bujdl0q4fJA3AG6U2CPiNwVu2fCziUurVlu/1bnR8h8lpYBpK4YnOKM3Uc9hijEP6
         zR6tGQ/yaUTg0qFkiqsfLSK6EFBahZj+WpDN5SThEVSy5pF+RAqMzhETVRBCcPn2Aayv
         fd6hENOnROyvgcVqJqlByow5NIFCUfQfa1d0YDj5nRFRLvw9SnR8weeU/rbQS7/9rhsD
         u3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXtYNJEYAUGx+oqP70lw3PJUxdUEPNh4xSx7/tNEPVcU28ULH7eXSXx/4qIOeSjBhp6sb+zUs1TfPG8vv30fKGVjqhRR0WKwDOAjKzxbQ==
X-Gm-Message-State: AOJu0Yy1YET+jiSkH8GjMEcwFpWZoLh+P44nKZfg+NRKOyOiLPMoEB0+
	S3yVjtDOtIoZdXkZmH9yqRuQ2gw1oKtJ4xFBCOzuWN5LLqw45FUE5gIaKqlOhzTXdx54tme+RwU
	mhQ==
X-Google-Smtp-Source: AGHT+IHyDXdhzOnaRkdixUL2++rweJn9lx+Erbim0MGnWcbc9hWfYz0a9yunyZZkRCL+mZoYrYs+P/ft4MQ=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a25:c753:0:b0:dd3:f55f:ff02 with SMTP id
 w80-20020a25c753000000b00dd3f55fff02mr840384ybe.1.1711677239983; Thu, 28 Mar
 2024 18:53:59 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-1-drosen@google.com>
Subject: [RFC PATCH v4 00/36] Fuse-BPF and plans on merging with Fuse Passthrough
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

I've recently gotten some time to re-focus on fuse-bpf efforts, and
had some questions on how to best integrate with recent changes that
have landed in the last year. I've included a rebased version (ontop
of bpf-next e63985ecd226 ("bpf, riscv64/cfi: Support kCFI + BPF on
riscv64") of the old patchset for reference here.

On the bpf end, I'm struggling a little bit with the interface for
selecting programs. I'd like to be able to pass the map id to fuse,
since that's a value userspace already knows the program by. Would it
be reasonable to either pass that ID down to the registration
function, or otherwise provide a path for a separate module to
translate from a map id to a struct_op program?

On the fuse end, I'm wondering how the interface will extend to
directories. At LSFMMBPF last year, some people brought up concerns
with the interface we had, specifically that it required opens to get
fds, which we'd then use to respond to lookup requests, adding a lot
of extra overhead. I had been planning to switch to a path that the
response would supply instead, likely limited by RESOLVE_BENEATH. That
seems pretty different from Fuse Passthrough's approach. Are there any
current plans on how that interface will extend for a directory
passthrough?

Could someone clarify why passthrough has an extra layer to register
for use as a backing file? Does the ioctl provide some additional
tracking purpose? I recall there being some security issue around
directly responding with the fd. In fuse-bpf, we were handling this by
responding to the fuse request via an ioctl in those cases.

Passthrough also maintains a separate cred instance for each backing
file. I had been planning to have a single one for the userspace
daemon, likely grabbed during the init response. I'm unsure how the
current Passthrough method there should scale to directories.

Now on to my plans. Struct ops programs have more dynamic support now
[1]. I'm hoping to be able to move most of the Fuse BPF related code
to live closer to Fuse, and to have it more neatly encapsulated when
building as a module. I'm not sure if everything that's needed for
that exists, but I need to play with it a bit more to understand what
I'm missing. I'll probably show up at bpf office hours at some point.

Struct ops have proper multi page support now [2], which removes
another patch. I'm still slightly over the struct ops limit, but that
may change with other changes I'm considering.

I'm very excited to see the new generic stacking filesystem support
with backing-file [3]. I imagine in time we'll extend that to have a
backing-inode as well, for the various inode_operations. That will
definitely involve a lot of refactoring of the way fuse-bpf is
currently structured, but it's clearly the right way forward.

I'm glad to see fuse passthrough, which provides a subset of the
fuse-bpf functionality, has landed[4]. I'm planning to rework the
patch set to integrate better with that. First off, I've been
considering splitting up the bpf progam into a dentry, inode, and file
set. That has the added bonus of pushing us back down below the
current struct_op function list limits. I would want to establish some
linkage between the sets, so that you could still just set the bpf
program at a folder level, and have all objects underneath inherit the
correct program. That's not an issue for a version with just file
support, but I'll want to ensure the interface extends naturally. With
the increased module support, I plan to redo all of the bpf program
linking anyways. The existing code was a temporary placeholder while
the method of registering struct ops programs was still in flux.

My plan for the next patch set is to prune down to just the file
operations. That removes a lot of the tricky questions for the moment,
and should shrink down the patch set massively. Along with that, I'll
clean up the struct_op implementation to take more advantage of the
recent bpf additions.

[1] https://lore.kernel.org/r/20240119225005.668602-12-thinker.li@gmail.com
[2] https://lore.kernel.org/all/20240224223418.526631-3-thinker.li@gmail.com/
[3] https://lore.kernel.org/all/20240105-vfs-rw-9b5809292b57@brauner/
[4] https://lore.kernel.org/all/CAJfpegsZoLMfcpBXBPr7wdAnuXfAYUZYyinru3jrOWWEz7DJPQ@mail.gmail.com/


Daniel Rosenberg (36):
  fuse-bpf: Update fuse side uapi
  fuse-bpf: Add data structures for fuse-bpf
  fuse-bpf: Prepare for fuse-bpf patch
  fuse: Add fuse-bpf, a stacked fs extension for FUSE
  fuse-bpf: Add ioctl interface for /dev/fuse
  fuse-bpf: Don't support export_operations
  fuse-bpf: Add support for access
  fuse-bpf: Partially add mapping support
  fuse-bpf: Add lseek support
  fuse-bpf: Add support for fallocate
  fuse-bpf: Support file/dir open/close
  fuse-bpf: Support mknod/unlink/mkdir/rmdir
  fuse-bpf: Add support for read/write iter
  fuse-bpf: support readdir
  fuse-bpf: Add support for sync operations
  fuse-bpf: Add Rename support
  fuse-bpf: Add attr support
  fuse-bpf: Add support for FUSE_COPY_FILE_RANGE
  fuse-bpf: Add xattr support
  fuse-bpf: Add symlink/link support
  fuse-bpf: Add partial flock support
  fuse-bpf: Add partial ioctl support
  fuse-bpf: allow mounting with no userspace daemon
  fuse-bpf: Add fuse-bpf constants
  bpf: Increase struct_op max members
  WIP: bpf: Add fuse_ops struct_op programs
  fuse-bpf: Export Functions
  fuse: Provide registration functions for fuse-bpf
  fuse-bpf: Set fuse_ops at mount or lookup time
  fuse-bpf: Call bpf for pre/post filters
  fuse-bpf: Add userspace pre/post filters
  WIP: fuse-bpf: add error_out
  fuse-bpf: Add default filter op
  tools: Add FUSE, update bpf includes
  fuse-bpf: Add selftests
  fuse: Provide easy way to test fuse struct_op call

 fs/fuse/Kconfig                               |    8 +
 fs/fuse/Makefile                              |    1 +
 fs/fuse/backing.c                             | 4287 +++++++++++++++++
 fs/fuse/bpf_register.c                        |  207 +
 fs/fuse/control.c                             |    2 +-
 fs/fuse/dev.c                                 |   85 +-
 fs/fuse/dir.c                                 |  318 +-
 fs/fuse/file.c                                |  126 +-
 fs/fuse/fuse_i.h                              |  472 +-
 fs/fuse/inode.c                               |  377 +-
 fs/fuse/ioctl.c                               |   11 +-
 fs/fuse/readdir.c                             |    5 +
 fs/fuse/xattr.c                               |   18 +
 include/linux/bpf.h                           |    2 +-
 include/linux/bpf_fuse.h                      |  285 ++
 include/uapi/linux/bpf.h                      |   13 +
 include/uapi/linux/fuse.h                     |   41 +
 kernel/bpf/Makefile                           |    4 +
 kernel/bpf/bpf_fuse.c                         |  716 +++
 kernel/bpf/bpf_struct_ops.c                   |    2 +
 kernel/bpf/btf.c                              |    1 +
 kernel/bpf/verifier.c                         |   10 +-
 tools/include/uapi/linux/bpf.h                |   13 +
 tools/include/uapi/linux/fuse.h               | 1197 +++++
 .../selftests/filesystems/fuse/.gitignore     |    2 +
 .../selftests/filesystems/fuse/Makefile       |  189 +
 .../testing/selftests/filesystems/fuse/OWNERS |    2 +
 .../selftests/filesystems/fuse/bpf_common.h   |   51 +
 .../selftests/filesystems/fuse/bpf_loader.c   |  597 +++
 .../testing/selftests/filesystems/fuse/fd.txt |   21 +
 .../selftests/filesystems/fuse/fd_bpf.bpf.c   |  397 ++
 .../selftests/filesystems/fuse/fuse_daemon.c  |  300 ++
 .../selftests/filesystems/fuse/fuse_test.c    | 2476 ++++++++++
 .../filesystems/fuse/struct_op_test.bpf.c     |  642 +++
 .../selftests/filesystems/fuse/test.bpf.c     | 1045 ++++
 .../filesystems/fuse/test_framework.h         |  172 +
 .../selftests/filesystems/fuse/test_fuse.h    |  494 ++
 37 files changed, 14385 insertions(+), 204 deletions(-)
 create mode 100644 fs/fuse/backing.c
 create mode 100644 fs/fuse/bpf_register.c
 create mode 100644 include/linux/bpf_fuse.h
 create mode 100644 kernel/bpf/bpf_fuse.c
 create mode 100644 tools/include/uapi/linux/fuse.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fuse/OWNERS
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_common.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_loader.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd.txt
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd_bpf.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_daemon.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_test.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/struct_op_test.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_framework.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_fuse.h


base-commit: e63985ecd22681c7f5975f2e8637187a326b6791
-- 
2.44.0.478.gd926399ef9-goog


