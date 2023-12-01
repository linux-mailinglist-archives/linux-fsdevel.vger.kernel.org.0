Return-Path: <linux-fsdevel+bounces-4620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7DF801679
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6567E1F21034
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3B3F8D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="N4EVIv29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82C310D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:11:58 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5cd81e76164so29415317b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468718; x=1702073518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4D2ssBblD7dUjePS+uFyWXaSTg3hGeewoVwZQIYlZAc=;
        b=N4EVIv291IeX0jMhU4ZY1SCS0z4xkvCyMIdkU+1HmAfCyvk0vYI46RGKN5YY54Hh+L
         svK1NCx/Wk94xSAVAotldi+uxmHAVw+cblCddj55TndtUfYx1eKgUsBA3tAlfiz/Cn3+
         Fx+h+PtxRQJrOwNd6XfEbzoA+9zElFtGpm4BJYVCSL1xzX1sW2IDJRsJancHFn08RdNk
         LGd462/a8K6BmlvhH4HKJFw875i8GIvnt8l/Cql0Dvo0xFZV8YV6V/85fqHV474qpi3l
         64ZuVSYKZBK4ekEXLSMJ8uAm5XTQRKHWLQ8VsTzjTQsaI2sY35R8k5OFxnib4oH0f9KG
         T5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468718; x=1702073518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4D2ssBblD7dUjePS+uFyWXaSTg3hGeewoVwZQIYlZAc=;
        b=PaCy2xQ6gHvXf+vwQ5ISpLS3HlrGv0ySiPL5YXsu7KlADcI0t6RMf0TpKqfh2EKjQg
         dl3NZUMHRNM/FRTW/GkiHa8sddbnvndsqz12o6ZVCpA/nF18Y6TDtJYgLHirVPj+9K7m
         dN+9DLnsHGPiB1mIdAVWWVzmyu1redFyUDWteYyhWyBKIZjMQVZGg+sfyK1z8Ts34DIP
         SbeslkIREt8JrPhBEAYJCXbTDqLJUqRxPLbldI35yfxFWZ6zWKvFbI19oGRmpSPg3KJE
         dukIsq9+lWEDNZifAKekKOizQSeTn3ZveO/SbIMjZzKGt6YQCiehQLLkwstPWop2D5HG
         M0cA==
X-Gm-Message-State: AOJu0YxJbMHAA/jJ/kLZyPEbpJrzbs7xI615oSO0hZAE+6Eyh60UePU9
	+8VFKkm8Y3f3hWpwiMhv5Zdfyw==
X-Google-Smtp-Source: AGHT+IHHlDTe3kN9sZvz3Rvne4DhloRRkvFGzmwLmC72NybYQyzqUp7G5LETq7oxtGxL3t5zKGxHUA==
X-Received: by 2002:a05:690c:3348:b0:5ce:a72e:a30a with SMTP id fk8-20020a05690c334800b005cea72ea30amr370225ywb.24.1701468718037;
        Fri, 01 Dec 2023 14:11:58 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c129-20020a0dc187000000b0059f766f9750sm1391018ywd.124.2023.12.01.14.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:11:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 00/46] btrfs: add fscrypt support
Date: Fri,  1 Dec 2023 17:10:57 -0500
Message-ID: <cover.1701468305.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v3 can be found here

https://lore.kernel.org/linux-btrfs/cover.1697480198.git.josef@toxicpanda.com/

There's been a longer delay between versions than I'd like, this was mostly due
to Plumbers, Holidays, and then uncovering a bunch of new issues with '-o
test_dummy_encryption'.  I'm still working through some of the btrfs specific
failures, but the fscrypt side appears to be stable.  I had to add a few changes
to fscrypt since the last time, but nothing earth shattering, just moving the
keyring destruction and adding a helper we need for btrfs send to work properly.

This is passing a good chunk of the fstests, at this point the majority appear
to be cases where I need to exclude the test when using test_dummy_encryption
because of various limitations of our tools or other infrastructure related
things.

I likely will have a follow-up series with more fixes, but the bulk of this is
unchanged since the last posting.  There were some bug fixes and such but the
overall design remains the same.  Thanks,

Josef

v3->v4:
- Added support for '-o test_dummy_encryption' at Eric's suggestion, this
  uncovered a load of issues.
- Preliminary work to support decrypting names for our various name resolution
  ioctls.  I didn't get everything but I got the ones we depend on in fstests.
- Preliminary work for send of an encrypted directory with the key loaded.
  There's probably still bugs in here, but it doesn't crash anymore.
- Fixed how we limit the bio size to work with direct and buffered io.
- Fixed using the wrong fscrypt extent context for writes into prealloc extents.

Josef Bacik (31):
  fs: move fscrypt keyring destruction to after ->put_super
  fscrypt: add per-extent encryption support
  fscrypt: add a fscrypt_inode_open helper
  fscrypt: conditionally don't wipe mk secret until the last active user
    is done
  blk-crypto: add a process bio callback
  fscrypt: add documentation about extent encryption
  btrfs: add infrastructure for safe em freeing
  btrfs: add fscrypt_info and encryption_type to ordered_extent
  btrfs: plumb through setting the fscrypt_info for ordered extents
  btrfs: plumb the fscrypt extent context through create_io_em
  btrfs: populate the ordered_extent with the fscrypt context
  btrfs: keep track of fscrypt info and orig_start for dio reads
  btrfs: add an optional encryption context to the end of file extents
  btrfs: pass through fscrypt_extent_info to the file extent helpers
  btrfs: pass the fscrypt_info through the replace extent infrastructure
  btrfs: implement the fscrypt extent encryption hooks
  btrfs: setup fscrypt_extent_info for new extents
  btrfs: populate ordered_extent with the orig offset
  btrfs: set the bio fscrypt context when applicable
  btrfs: add a bio argument to btrfs_csum_one_bio
  btrfs: add orig_logical to btrfs_bio
  btrfs: limit encrypted writes to 256 segments
  btrfs: implement process_bio cb for fscrypt
  btrfs: add test_dummy_encryption support
  btrfs: don't rewrite ret from inode_permission
  btrfs: move inode_to_path higher in backref.c
  btrfs: make btrfs_ref_to_path handle encrypted filenames
  btrfs: don't search back for dir inode item in INO_LOOKUP_USER
  btrfs: deal with encrypted symlinks in send
  btrfs: decrypt file names for send
  btrfs: load the inode context before sending writes

Omar Sandoval (7):
  fscrypt: expose fscrypt_nokey_name
  btrfs: disable various operations on encrypted inodes
  btrfs: start using fscrypt hooks
  btrfs: add inode encryption contexts
  btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
  btrfs: adapt readdir for encrypted and nokey names
  btrfs: implement fscrypt ioctls

Sweet Tea Dorminy (8):
  btrfs: disable verity on encrypted inodes
  btrfs: handle nokey names.
  btrfs: add encryption to CONFIG_BTRFS_DEBUG
  btrfs: add get_devices hook for fscrypt
  btrfs: turn on inlinecrypt mount option for encrypt
  btrfs: set file extent encryption excplicitly
  btrfs: add fscrypt_info and encryption_type to extent_map
  btrfs: explicitly track file extent length for replace and drop

 Documentation/filesystems/fscrypt.rst |  41 ++
 block/blk-crypto-fallback.c           |  40 ++
 block/blk-crypto-internal.h           |   8 +
 block/blk-crypto-profile.c            |   2 +
 block/blk-crypto.c                    |   6 +-
 fs/btrfs/Makefile                     |   1 +
 fs/btrfs/accessors.h                  |  50 +++
 fs/btrfs/backref.c                    | 114 ++++--
 fs/btrfs/bio.c                        |  75 +++-
 fs/btrfs/bio.h                        |   6 +
 fs/btrfs/btrfs_inode.h                |   3 +-
 fs/btrfs/compression.c                |   6 +
 fs/btrfs/ctree.h                      |   4 +
 fs/btrfs/defrag.c                     |  10 +-
 fs/btrfs/delayed-inode.c              |  29 +-
 fs/btrfs/delayed-inode.h              |   6 +-
 fs/btrfs/dir-item.c                   | 108 +++++-
 fs/btrfs/dir-item.h                   |  11 +-
 fs/btrfs/disk-io.c                    |   1 +
 fs/btrfs/extent_io.c                  | 114 +++++-
 fs/btrfs/extent_io.h                  |   3 +
 fs/btrfs/extent_map.c                 | 102 ++++-
 fs/btrfs/extent_map.h                 |  12 +
 fs/btrfs/file-item.c                  |  17 +-
 fs/btrfs/file-item.h                  |   7 +-
 fs/btrfs/file.c                       |  16 +-
 fs/btrfs/fs.h                         |   6 +-
 fs/btrfs/fscrypt.c                    | 412 ++++++++++++++++++++
 fs/btrfs/fscrypt.h                    | 112 ++++++
 fs/btrfs/inode.c                      | 518 ++++++++++++++++++++------
 fs/btrfs/ioctl.c                      |  68 ++--
 fs/btrfs/ordered-data.c               |  36 +-
 fs/btrfs/ordered-data.h               |  21 +-
 fs/btrfs/reflink.c                    |   8 +
 fs/btrfs/root-tree.c                  |   8 +-
 fs/btrfs/root-tree.h                  |   2 +-
 fs/btrfs/send.c                       | 133 ++++++-
 fs/btrfs/super.c                      |  75 ++++
 fs/btrfs/sysfs.c                      |   6 +
 fs/btrfs/tree-checker.c               |  66 +++-
 fs/btrfs/tree-log.c                   |  26 +-
 fs/btrfs/verity.c                     |   3 +
 fs/crypto/crypto.c                    |  10 +-
 fs/crypto/fname.c                     |  39 +-
 fs/crypto/fscrypt_private.h           |  44 +++
 fs/crypto/hooks.c                     |  42 +++
 fs/crypto/inline_crypt.c              |  87 ++++-
 fs/crypto/keyring.c                   |  18 +-
 fs/crypto/keysetup.c                  | 155 ++++++++
 fs/crypto/policy.c                    |  59 +++
 fs/super.c                            |  12 +-
 include/linux/blk-crypto.h            |   9 +-
 include/linux/fscrypt.h               | 130 +++++++
 include/uapi/linux/btrfs.h            |   1 +
 include/uapi/linux/btrfs_tree.h       |  35 +-
 55 files changed, 2619 insertions(+), 314 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h

-- 
2.41.0


