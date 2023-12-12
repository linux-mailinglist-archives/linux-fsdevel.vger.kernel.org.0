Return-Path: <linux-fsdevel+bounces-5641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE680E802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21BFB20DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1F58AD8;
	Tue, 12 Dec 2023 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqDeMT1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B19DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-33621d443a7so1844617f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374285; x=1702979085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGvQgrVDKEC14MgF+gKdJFeYT9PAXkwMxa0ZsJIU6k=;
        b=MqDeMT1gt65FUjnKXe/V2A+LyrNR0zyQ+UBrLt7kiK8GGwU6F+zcum4lHFQvf/lldD
         99y/9zg5veXkd6ajk6KMbXMWhichDZKwtsIjf456wpyQRV4QE6+fm4D8LwavC2mEg/cN
         lN3DLuoQeo7NFYP+iFjOVfRAdBuJdsbCRpft9dFoEQ6wF6/jCEoVHk129dlZ6OybxMwY
         +9a4aLy37DytEFj1V4kawk2LoOYbKFIc6MEZRIpr2URNjl4UJqVuJJFouCLktiIEo5b1
         u4lBhdqhhILImchpcanK/z8z/hbnhOdSE8IBmCTGZZQlVnZHjkb1q725grSybbQNr3ip
         h9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374285; x=1702979085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrGvQgrVDKEC14MgF+gKdJFeYT9PAXkwMxa0ZsJIU6k=;
        b=aJm94RYtEdshdJiTP/jItxKXQmULExhU6F2hBL3U4F/1movYSLdgUxWZhbnO2fTkvB
         QxkYxaS7KsZxM20x/G5mSUD0/g8gobcq7M9AurwSwvj2gO/YTUk8ipXKpO2idOL/TIsi
         l3VRgMGlrCkgqaz9ShpHbvNf4IuyVCQOkVgSLr9PEVWjBoHGJk7QxzxlQM1ji1zqkX7E
         AappJCd29mpG4hdfALvWH8HMHcSaKHdlIe4C9t5okLQsquddMZD3js4NkuKIpt9uaNGN
         6dR5TMNIirSzZq2rXnMooDatFdEoX0kYw6N/SC9IJMRownyCXhK6vtq79PLAtGzmLwOS
         gpAg==
X-Gm-Message-State: AOJu0Ywwgv7d8qZxnKKxM6leaegTKqzNqCPLrYisewhPD/QNhG+KQBuj
	FT3mAyZM3INtIVHpjGXD818=
X-Google-Smtp-Source: AGHT+IEitV7SjWiJj/sfDwNfEUJ8JGm6dS9SGoIG0v2UBnkBQkQdwu3sYuUe6Pfn4BjBHykXfZXQnw==
X-Received: by 2002:a5d:55c4:0:b0:333:2fd2:2f07 with SMTP id i4-20020a5d55c4000000b003332fd22f07mr2856292wrw.128.1702374284749;
        Tue, 12 Dec 2023 01:44:44 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm10432244wrx.41.2023.12.12.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:44:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/5] Prepare for fsnotify pre-content permission events
Date: Tue, 12 Dec 2023 11:44:35 +0200
Message-Id: <20231212094440.250945-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

This v3 of pre-content event prep patches addresses some comments and
replaces the v1 patches [1] that are currently applied to vfs.rw.

I started with a new cleanup patch for ssize_t return type that you
suggested.

Patch 2 has a fix for a build error reported by kernel tests robot
(moved MAX_RW_COUNT capping to splice_file_range()), so I did not
retain Josef's RVB from v1 on this patch.

Patches 3,4 are unchanged and retain the RVBs from v1.

Patch 5 changes the fsnotify hook name, so I did not retain Josef's
RVB from v1. Jan has already reviewed v2.

Thanks,
Amir.

Changes since v2:
- Fixes to splice helpers return type
- Add RVBs from Jan

Changes since v1 [1]:
- Move MAX_RW_COUNT capping to splice_file_range() to fix build error
- Cleanup splice helpers return type
- Change fsnotify hook name to fsnotify_file_area_perm()
- Add RVBs

[1] https://lore.kernel.org/r/20231207123825.4011620-1-amir73il@gmail.com/

Amir Goldstein (5):
  splice: return type ssize_t from all helpers
  fs: use splice_copy_file_range() inline helper
  fsnotify: split fsnotify_perm() into two hooks
  fsnotify: assert that file_start_write() is not held in permission
    hooks
  fsnotify: optionally pass access range in file permission hooks

 fs/ceph/file.c           |   4 +-
 fs/fuse/file.c           |   5 +-
 fs/internal.h            |   8 +--
 fs/nfs/nfs4file.c        |   5 +-
 fs/open.c                |   4 ++
 fs/overlayfs/copy_up.c   |   2 +-
 fs/read_write.c          |  46 ++++------------
 fs/readdir.c             |   4 ++
 fs/remap_range.c         |   8 ++-
 fs/smb/client/cifsfs.c   |   5 +-
 fs/splice.c              | 110 ++++++++++++++++++++-------------------
 include/linux/fs.h       |   3 --
 include/linux/fsnotify.h |  50 ++++++++++++------
 include/linux/splice.h   |  50 ++++++++++--------
 io_uring/splice.c        |   4 +-
 security/security.c      |  10 +---
 16 files changed, 163 insertions(+), 155 deletions(-)

-- 
2.34.1


