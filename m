Return-Path: <linux-fsdevel+bounces-63116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FADBACEB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 14:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3EA3209D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958D301465;
	Tue, 30 Sep 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p0YoRAJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40625A353
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236471; cv=none; b=BmwnsRgNYmswARkQ4a5cfWavQfW+blMSXXL0P+cFdNuwsRnaARiXq6dX6CPWzHjntNfpaU4zvwMs2s1jNTx7cSMg5mHJwAqSqYlJnMJxQHX58w9+YsSRVOwq6lAs5VK6vIIbPNhpeTc3cXLGq56guwOWOuTtCdVwsLZ1DTAClt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236471; c=relaxed/simple;
	bh=6ODFl3tzmYQcYug2DS09l+n4aJecxEUMjdrP5ELDqoQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KFcIXwIiXs2oSHrfTjKt7jgb0zrHEJEgsgZBuoDwgup96nEYVkXCcOmhzu4LwqIT0lERfUgyMNytaWXxPZtYDz8lIdGMRVGOqvs29ULaArOtnVmt+DnHlebfTzrGynVgG4K2Apb/k0r5MhHg83JeS5lnAgBsrsWmd9PfftOkvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p0YoRAJH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-854585036e8so600382485a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1759236467; x=1759841267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1wC8Vr6Y5iTZjdCwj30WxxG26spUpfyfsqYkfmF0j6E=;
        b=p0YoRAJHgTzIwqCVl7qBn4YLdurEEebPu5ML9Qi97Qw3XAnIUKMMClQguY4tDGd2bn
         Dmi7Vm9FJD0pyoybY+dlcd8SNLGw9xBlZcx1bfEsHB3MXRMi7CWThj4+xxVfGS09adpm
         BTiAQR2OlmtDa4DOyI3vBHto5B0cMuZ6i1ZQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236467; x=1759841267;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wC8Vr6Y5iTZjdCwj30WxxG26spUpfyfsqYkfmF0j6E=;
        b=IbyR/YDdIh7gdzj38xTJbt00/D9twDcrkLSfqBKRVSOR0voEKaDQ6o+18zU2U159ID
         TZ+/KM471JkuQHLk/RxuLXlxEyzSi2841ySfcpmdVMB68fn2dZjWa+niqAns+mtXrKNn
         7f1pW+3Kywqz8xsS3TLrfKMtnzWwp/WyGK9kBf64eLJ7Y057RzkwwmePE0ZChnCLA/oM
         VTtbP7yxwCf8hI2L4GHSDs3/RFIhDCs5FZaE0sagfQQxDdqIpixdjXm/M3dimDuh5tJv
         fMdziK4RI1b1To7pqfcP5mDOA7jbmw95oDOZ1mNaoVHkZ2yx52LViku0FK2tWKRFy5+p
         cIOw==
X-Gm-Message-State: AOJu0YzuMApwa2qhhaY5tuIijzXiZ/Ib+aZDRhP5R65pP0ADioPpLwd2
	pRdwf6W3JbK/emEbbrfaQBMVlWYpI1fmZ46fqlku9Um80lr6sD4MGDbmVD5AM4fue6gNna2JkEw
	L9u3bokR96FzB2ifnHhrP/+Qg1c21jSXKG/L+HTGhWg==
X-Gm-Gg: ASbGncsG41x/vvotVXjOqG894mWljzfCieTAri2qKsZ0KY5Q6U/RMK21YJcwCR6+yJO
	ZLJyxcxkNbSGFX/RwFfdqvAAthNhZNSoZDjOralV/XIYsVc5xfWEz1GUcDEIZlwEHFPKjtQPgst
	1u/+7yAAP2DYiQosmuVlOBBPwY3D79Ev4uIPw6/sV45pROKatnI1OcLMBu7iz9YSfoHeGHv4qtN
	imWHGTSpJslbmnnWDlLia5AlVlvfQZcP2ySLwOc+Xa8MlZj9cIN4b4bc4HIHsez6O9d9IF88xx+
	IqTN3EBP
X-Google-Smtp-Source: AGHT+IEqhTETy8643K21cVM25SZgCqRNORpuhYW7e3EFegJ2RyEn4mI4Ew9+uvdUSr05jh6gIwhJR49uuG1a58WkOuk=
X-Received: by 2002:a05:620a:2982:b0:84b:5751:6c4f with SMTP id
 af79cd13be357-85ae93d275emr2296871185a.62.1759236466837; Tue, 30 Sep 2025
 05:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Sep 2025 14:47:35 +0200
X-Gm-Features: AS18NWCistxXCIc9UvvWaSsLppHNSEKmAKyLZH4naiNoIaLHBXQUWHvVRtqE0Zk
Message-ID: <CAJfpegtWHBZbvMWm2uHq0WAhrF6qHE5N=AG9QjkweyXic-e7gg@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.18

- Extend copy_file_range interface to be fully 64bit capable (Miklos)

- Add selftest for fusectl (Chen Linxuan)

- Move fuse docs into a separate directory (Bagas Sanjaya)

- Allow fuse to enter freezable state in some cases (Sergey Senozhatsky)

- Clean up writeback accounting after removing tmp page copies (Joanne)

- Optimize virtiofs request handling (Li RongQing)

- Add synchronous FUSE_INIT support (Miklos)

- Allow server to request prune of unused inodes (Miklos)

- Fix deadlock with AIO/sync release (Darrick)

- Add some prep patches for block/iomap support (Darrick)

- Misc fixes and cleanups

Thanks,
Miklos


Thanks,
Miklos
---

Bagas Sanjaya (1):
      Documentation: fuse: Consolidate FUSE docs into its own subdirectory

Chen Linxuan (2):
      doc: fuse: Add max_background and congestion_threshold
      selftests: filesystems: Add functional test for the abort file in fusectl

Chunsheng Luo (1):
      fuse: remove unused 'inode' parameter in fuse_passthrough_open

Darrick J. Wong (5):
      fuse: fix livelock in synchronous file put from fuseblk workers
      fuse: capture the unique id of fuse commands being sent
      fuse: enable FUSE_SYNCFS for all fuseblk servers
      fuse: move the backing file idr and code into a new source file
      fuse: move CREATE_TRACE_POINTS to a separate file

Joanne Koong (4):
      fuse: remove unneeded offset assignment when filling write pages
      fuse: use default writeback accounting
      mm: remove BDI_CAP_WRITEBACK_ACCT
      fuse: remove fuse_readpages_end() null mapping check

Li RongQing (2):
      virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
      virtio_fs: fix the hash table using in virtio_fs_enqueue_req()

Marek Szyprowski (1):
      mm: fix lockdep issues in writeback handling

Miklos Szeredi (8):
      fuse: add COPY_FILE_RANGE_64 that allows large copies
      fuse: zero initialize inode private data
      fuse: allow synchronous FUSE_INIT
      fuse: fix references to fuse.rst -> fuse/fuse.rst
      fuse: remove FUSE_NOTIFY_CODE_MAX from <uapi/linux/fuse.h>
      fuse: fix possibly missing fuse_copy_finish() call in fuse_notify()
      fuse: remove redundant calls to fuse_copy_finish() in fuse_notify()
      fuse: add prune notification

Sergey Senozhatsky (2):
      sched/wait: Add wait_event_state_exclusive()
      fuse: use freezable wait in fuse_get_req()

---
 .../filesystems/{ => fuse}/fuse-io-uring.rst       |   0
 Documentation/filesystems/{ => fuse}/fuse-io.rst   |   2 +-
 .../filesystems/{ => fuse}/fuse-passthrough.rst    |   0
 Documentation/filesystems/{ => fuse}/fuse.rst      |  20 +-
 Documentation/filesystems/fuse/index.rst           |  14 ++
 Documentation/filesystems/index.rst                |   5 +-
 Documentation/filesystems/sysfs.rst                |   2 +-
 .../translations/zh_CN/filesystems/sysfs.txt       |   2 +-
 .../translations/zh_TW/filesystems/sysfs.txt       |   2 +-
 MAINTAINERS                                        |   3 +-
 fs/fuse/Kconfig                                    |   2 +-
 fs/fuse/Makefile                                   |   5 +-
 fs/fuse/backing.c                                  | 179 ++++++++++++++++
 fs/fuse/cuse.c                                     |   3 +-
 fs/fuse/dev.c                                      | 227 +++++++++++++--------
 fs/fuse/dev_uring.c                                |   8 +-
 fs/fuse/file.c                                     |  86 ++++----
 fs/fuse/fuse_dev_i.h                               |  13 +-
 fs/fuse/fuse_i.h                                   |  70 ++++---
 fs/fuse/inode.c                                    |  76 +++++--
 fs/fuse/iomode.c                                   |   3 +-
 fs/fuse/passthrough.c                              | 167 +--------------
 fs/fuse/trace.c                                    |  13 ++
 fs/fuse/virtio_fs.c                                |  12 +-
 include/linux/backing-dev.h                        |  14 +-
 include/linux/wait.h                               |  12 ++
 include/uapi/linux/fuse.h                          |  22 +-
 mm/backing-dev.c                                   |   2 +-
 mm/page-writeback.c                                |  45 ++--
 tools/testing/selftests/Makefile                   |   1 +
 .../testing/selftests/filesystems/fuse/.gitignore  |   3 +
 tools/testing/selftests/filesystems/fuse/Makefile  |  21 ++
 .../testing/selftests/filesystems/fuse/fuse_mnt.c  | 146 +++++++++++++
 .../selftests/filesystems/fuse/fusectl_test.c      | 140 +++++++++++++
 34 files changed, 922 insertions(+), 398 deletions(-)
 rename Documentation/filesystems/{ => fuse}/fuse-io-uring.rst (100%)
 rename Documentation/filesystems/{ => fuse}/fuse-io.rst (99%)
 rename Documentation/filesystems/{ => fuse}/fuse-passthrough.rst (100%)
 rename Documentation/filesystems/{ => fuse}/fuse.rst (95%)
 create mode 100644 Documentation/filesystems/fuse/index.rst
 create mode 100644 fs/fuse/backing.c
 create mode 100644 fs/fuse/trace.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_mnt.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fusectl_test.c

