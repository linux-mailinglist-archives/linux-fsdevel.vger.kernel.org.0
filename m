Return-Path: <linux-fsdevel+bounces-35555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4569D5C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 10:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52EDB25BDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4191DE3A9;
	Fri, 22 Nov 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="famk3Dyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2C1D79BB;
	Fri, 22 Nov 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269475; cv=none; b=c49Q0J+8N6+W86LAyGla4B6fGWLWh/2Qd5AwH9mOFK0Ohj69r97QV/mJ2meU54sUFQwQweSAsvVT4FH0h92mPk38dpl5ZjOIsXxA9K7H+R4vV5Tpbsr0Iu1fE7n18VSZJusI6SgckjKRucnPv0UezaGdRyKTaOKV2RAqb3oZ/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269475; c=relaxed/simple;
	bh=DROrcZMktV46vS9hDs7wxjs4RZ7k0PD0goqABW4Ck0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XM7wlG1gpMyi9oXNQIs2YXObqv2wyuMEyuAv0LGCT5hh8HiG7lXfN//xTdLcm6chIee2AaWjky4wBqksBandAH08T8NJFA+sObQWrMKSfB87fWaxs67loXk7Z7h0hHJvI7vhJc4CZwTCJcLXNk+NLd966Q2zNkwzleH6YIrSTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=famk3Dyq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ef275b980so306199366b.0;
        Fri, 22 Nov 2024 01:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732269471; x=1732874271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1YNjxFnMu7YgunhEkueJiGg2Ls9YnMrEIaJQYBXqDw=;
        b=famk3DyqqooLn+AVJMnuQTkk+x9k7D0uFoBEnTeOJmTUJf9X2LXcP6OK2/Qo+td7M4
         p9N/7x9c+Awr41ewcmhutzILiAYyrBmp376FlQ58oU7Ds78evRqHQddtb0yjHiqOl+I4
         FoWa7tIMEPp82PfDinHBgRK9RpUbZbo4YXXQnihA6z2cKsLmXFOKb3lzzLcKelUIgrnI
         PgI33VoLqUak6j48B//Y7+WyoCpjyzgy/1qU1X+wCxHZtV5DR+WD+Ga2fsvtBayuRXvf
         TqMoDKpcfpqpLxiKOmBsNvxuuJEjKy1+ctXkseWur3gqTuG2rAaXVMz7NAMkT51h1vQe
         6m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269471; x=1732874271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1YNjxFnMu7YgunhEkueJiGg2Ls9YnMrEIaJQYBXqDw=;
        b=f+Zl4hksWEXulQTu4LDeZLBeW7P3kLEqE74O7OMRENa50/jJ5E8dDL4VrW1pe+H7YY
         0auwTRxlcGzjz19Czdb4sI8FH5uVZdeJ0anf6JOXUrO/gDxxkG4146DuCNIISIysqDti
         vOg+palQmqC0yP69QWjNl6i5A4uHIDI0FEC+t5St+UTJcPfrRnKFq9Cd0PCbJPqspoRL
         g7VKgt1xSBTwywQ8Z+EsoWPs8JokXCmAxlZSWFVKy98sRtwWGNL7v/gl6O+SUFAyCD4W
         YW6sXTRE8m6zYr5ABosMgGDPZZFgH9p8qazyFliX/oqBwFt+NlbHuHEm4Ge2t1kKgJct
         l6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM0P8N8uTrcbMAJ6Q/MPQPgr9qVqlWE+zD/excxYVDMGjKY2P2i56I3RQRHq2ZI4Rxkb7DYmMUuL1KGeqUZg==@vger.kernel.org, AJvYcCVOCuU21fN4PVEJbmaq5b24lgaMt4ei+7STrsRljg78eG37fCQXJh78OBE28+1VDBm8yYEvHxuvzyrv9qpW@vger.kernel.org, AJvYcCXetUxdz84lYpbepKVx4mAYLJHTfl0IhcS4n7mYigyN88otwZPaH+IhWT4mYVr5zDYGwh3YFInB0A1Kl+wE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2BGdc1Qc7ljjXSM8hjhjxD0A4axJKI2UJ4T3SMQkQ/N/Ph3X
	6to2SwGUVNGVr5CuSfzcVgPQlkvjIbvSnRmcKauTeyiLd4bpyilf
X-Gm-Gg: ASbGncvvegx3n958xIVEiK47E+Ta60GgCK7GUWU3ZLusiyI6TGO0Hp6k2Ig1xPaNWrp
	PMIUfn0BoaOsLNONfliqiXfikQBDfjNzHk7+lVMPRyMlfrr31VzWniZczpK7LnOZVPjz7Wtbf1G
	CitCkfFlA3/B6cLibzW5exCcWlWJ4HRAvwEz0HTEUg2aKGR6Vv9aEe8cnRunRNRucNG5PEOkPIA
	TpXmnnkmEmBsL2JyWsl4cYMuCrG8BF9xrKnvSmHDswYeULS+v3wf9SVEouwVtKM4EjaugljcLMi
	R3LA+jraPZTDYKlzJYLIoUl/r2DbfOpcu4GYHUKqWsVQQnc=
X-Google-Smtp-Source: AGHT+IGlXtYvtFI2fCcfNTMjkok1wT9AVTZQ1CDek+TBZjQJfwlcWeDAxmdNY1dtnE+KYuSIWXrzsQ==
X-Received: by 2002:a17:907:2718:b0:a99:c075:6592 with SMTP id a640c23a62f3a-aa509c0d6dbmr192813266b.56.1732269471061;
        Fri, 22 Nov 2024 01:57:51 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b530aa0sm77567866b.115.2024.11.22.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:57:50 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs updates for 6.13
Date: Fri, 22 Nov 2024 10:57:46 +0100
Message-Id: <20241122095746.198762-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs updates for 6.13.

This pull request has some changes in code outside of fs/overlayfs:

1. The backing_file API change touches fuse code - that was collaborated
   with Miklos who authored this API change

2. The additions of revert/override_creds_light() helpers in cred.{h,c}
   were collaborated with Christian who has suggested those helpers

There was also an overlayfs change in this cycle coming from Christian
(file descriptors based layer setup).  His changes do not conflict with
this branch and I have also tested his change along with the fs-next
community test branch.

Most of this branch has been sitting in linux-next for over a week except
for one syzbot issue fix that was added three days ago.

The code has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.13

for you to fetch changes up to c8b359dddb418c60df1a69beea01d1b3322bfe83:

  ovl: Filter invalid inodes with missing lookup function (2024-11-20 10:23:04 +0100)

----------------------------------------------------------------
overlayfs updates for 6.13

- Fix a syzbot reported NULL pointer deref with bfs lower layers

- Fix a copy up failure of large file from lower fuse fs

- Followup cleanup of backing_file API from Miklos

- Introduction and use of revert/override_creds_light() helpers, that were
  suggested by Christian as a mitigation to cache line bouncing and false
  sharing of fields in overlayfs creator_cred long lived struct cred copy.

- Store up to two backing file references (upper and lower) in an ovl_file
  container instead of storing a single backing file in file->private_data.

  This is used to avoid the practice of opening a short lived backing file
  for the duration of some file operations and to avoid the specialized use
  of FDPUT_FPUT in such occasions, that was getting in the way of Al's
  fd_file() conversions.

----------------------------------------------------------------
Amir Goldstein (6):
      ovl: pass an explicit reference of creators creds to callers
      ovl: do not open non-data lower file for fsync
      ovl: allocate a container struct ovl_file for ovl private context
      ovl: store upper real file in ovl_file struct
      ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
      ovl: convert ovl_real_fdget() callers to ovl_real_file()

Miklos Szeredi (1):
      backing-file: clean up the API

Oleksandr Tymoshenko (1):
      ovl: properly handle large files in ovl_security_fileattr

Vasiliy Kovalev (1):
      ovl: Filter invalid inodes with missing lookup function

Vinicius Costa Gomes (4):
      cred: Add a light version of override/revert_creds()
      fs/backing-file: Convert to revert/override_creds_light()
      ovl: use wrapper ovl_revert_creds()
      ovl: Optimize override/revert creds

 fs/backing-file.c            |  53 ++++---
 fs/fuse/passthrough.c        |  32 +++--
 fs/overlayfs/copy_up.c       |   2 +-
 fs/overlayfs/dir.c           |  68 ++++++---
 fs/overlayfs/file.c          | 327 +++++++++++++++++++++++++------------------
 fs/overlayfs/inode.c         |  27 ++--
 fs/overlayfs/namei.c         |  10 +-
 fs/overlayfs/overlayfs.h     |   4 +
 fs/overlayfs/readdir.c       |   8 +-
 fs/overlayfs/util.c          |  14 +-
 fs/overlayfs/xattrs.c        |   9 +-
 include/linux/backing-file.h |  11 +-
 include/linux/cred.h         |  18 +++
 kernel/cred.c                |   6 +-
 14 files changed, 352 insertions(+), 237 deletions(-)

