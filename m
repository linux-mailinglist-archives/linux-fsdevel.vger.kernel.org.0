Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB7143D63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 13:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgAUM5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 07:57:39 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44561 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgAUM5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:57:39 -0500
Received: by mail-pl1-f182.google.com with SMTP id d9so1296703plo.11;
        Tue, 21 Jan 2020 04:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uUXcGfeY5AWUYunvWE8Bf44nS0LbxI+FQR3R1dFLpWE=;
        b=a5d0e5FL+uV06ISkOtyjDcX77miHmQmMR9/lfWdlZoqOBzNqmAh17H4bflHnFNSYdw
         q698Rst0zTMWH+JbVeVTnFnPdLavmCPnlCf3ZG7thiJQ2Osef3ascgwW9K0HxLmHSawr
         EJ5CZine3CCKGu7mBSgfpE59Fu5URgq5hTtZ3irMtXjWCymyZz9cV23wn94OScJ08Cbd
         nS7k/+5OBVVWNpwo+bzV7DDn2q3gZKFF3Zxjvgt1LS5WXHmjbLg36ntZNY55psihEbaJ
         gvPBvRlj81Sf2KY60u2ePzP7a0fT22ilUWt1xUlXGHpcQl0j4NV/bfP3Q4Bi7hB4e+yQ
         n02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uUXcGfeY5AWUYunvWE8Bf44nS0LbxI+FQR3R1dFLpWE=;
        b=oIEBMP8SwqKfrgXVTsSDSyXG3eRw9WwJgiPvc8tH5fW+lPb5EKYYXIsVHg4h93Isvc
         GzIBifGkvjQ7G+StfKmRX2Po2WndIoKzgousxUes8WMIKx+/K6wyEstj5bEAP1GoImhi
         l3tPQ+RNxIHGkqQYpcaxbrsZDWJ/tHZhXruZTv0ViUwmK68m2Om00EcqCEX1NDUoDGSK
         +Yp6/YFGXdzfh+BTqLcseQRlPF1S2uoYqYW/XotLYKT3LZBPLr03fpyH9vl7D0Uiqu5M
         2zTJgWaLKyjFzgdmPFYV3Ov80FKAQ6+H11im/+4B81hYC9cTyhcTW53r5iK0moZBQoUq
         sSYQ==
X-Gm-Message-State: APjAAAWR6KhHd9O/1hky0VkBZiry7VmxLM6YvSwy97urW/tbGKJXjoXy
        LLboaJyoD9I7LtoJBqfMsWQ9Enmr
X-Google-Smtp-Source: APXvYqwNmZ5qw+3k+snewKXN54F/exQ4laGBAxnZFxAj6QfmS6x9eOmze0DASsy3yweiE98IVABSQg==
X-Received: by 2002:a17:902:740c:: with SMTP id g12mr5524364pll.166.1579611458275;
        Tue, 21 Jan 2020 04:57:38 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v4sm43130132pfn.181.2020.01.21.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:57:37 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk,
        Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v13 00/13] add the latest exfat driver
Date:   Tue, 21 Jan 2020 21:57:14 +0900
Message-Id: <20200121125727.24260-1-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

This adds the latest Samsung exfat driver to fs/exfat. This is an
implementation of the Microsoft exFAT specification. Previous versions
of this shipped with millions of Android phones, and a random previous
snaphot has been merged in drivers/staging/.

Compared to the sdfat driver shipped on the phones the following changes
have been made:

 - the support for vfat has been removed as that is already supported
   by fs/fat
 - driver has been renamed to exfat
 - the code has been refactored and clean up to fully integrate into
   the upstream Linux version and follow the Linux coding style
 - metadata operations like create, lookup and readdir have been further
   optimized
 - various major and minor bugs have been fixed

We plan to treat this version as the future upstream for the code base
once merged, and all new features and bug fixes will go upstream first.

v13:
 - rcu-delay unloading nls, freeing upcase table and sbi.
 - Switch to ->free_inode().
 - Push rcu_barrier() from deactivate_locked_super() to filesystems.
 - Remove unused variables in exfat_sb_info structure.

v12:
 - Merge the #12 patch into the #11 patch.
 - Remove an incorrect comment about time_offset mount option.

v11:
 - Use current_time instead of ktime_get_real_ts64.
 - Add i_crtime in exfat inode.
 - Drop the clamping min/max timestamp.
 - Merge exfat_init_file_entry into exfat_init_dir_entry.
 - Initialize the msec fields in exfat_init_dir_entry.
 - Change timestamps written to disk always get stored in UTC instead of
   active timezone.
 - Update EXFAT_DEFAULT_IOCHARSET description in Kconfig.
 - exfat_get/set_entry_time() take a time_ms argument.

v10:
 - Make PBR structures as packed structure.
 - Fix build error on 32 bit system.
 - Change L suffix of UNIX_SECS_2108 macro with LL suffix to work
   on both 32/64bit system.
 - Rework exfat time handling.
 - Don't warp exfat specification URLs.
 - Add _FS suffix to config name.
 - Remove case_sensitive mount option.
 - iocharset=utf8 mount option work as utf8 option.
 - Rename the misleading nls names to corresponding ones.
 - Fix wrong header guard name of exfat_fs.h.
 - Remove the unneeded braces of macros in exfat_fs.h.
 - Move the ondisk values to exfat_raw.h
 - Put the operators at the previous line in exfat_cluster_to_sector().
 - Braces of EXFAT_DELETE macro would outside the ~.
 - Directly use exfat dentry field name.
 - Add EXFAT_CLUSTERS_UNTRACKED macro.
 - Remove both sets of inner braces in exfat_set_vol_flags().
 - Replace is_reserved_cluster() with an explicit check
   for EXFAT_EOF_CLUSTER.
 - Initialize superblock s_time_gran/max/min.
 - Clean-up exfat_bmap and exfat_get_block().
 - Fix wrong boundlen to avoid potential buffer overflow
   in exfat_convert_char_to_ucs2().
 - Process length value as 1 when conversion is failed.
 - Replace union exfat_timezone with masking the valid bit.
 - Change exfat_cmp_uniname() with exfat_uniname_ncmp().
 - Remove struct exfat_timestamp.
 - Add atime update support.
 - Add time_offset mount option.
 - Remove unneeded CLUSTER_32 macro.
 - Process utf16 surrogate pair as one character.
 - Rename MUST_ZERO_LEN to PBR64_RESERVED_LEN.
 - Simplify is_exfat function by just using memchr_inv().
 - Remove __exfat_init_name_hash.
 - Remove exfat_striptail_len.
 - Split dentry ops for the utf8 vs non-utf8 cases.

v9:
 - Add support time zone.
 - Fix data past EOF resulting from fsx testsuite.
 - Remove obsolete comments in __exfat_resolve_path().
 - Remove unused file attributes macros.
 - Remove unneeded #if BITS_PER_LONG.

v8:
 - Rearrange the function grouping in exfat_fs.h
   (exfat_count_dir_entries, exfat_get_dentry, exfat_get_dentry_set,
    exfat_find_location).
 - Mark exfat_extract_uni_name(), exfat_get_uniname_from_ext_entry() and
   exfat_mirror_bh() as static.

v7:
 - Add the helpers macros for bitmap and fat entry to improve readability.
 - Rename exfat_test_bitmap to exfat_find_free_bitmap.
 - Merge exfat_get_num_entries into exfat_calc_num_entries.
 - Add EXFAT_DATA_CLUSTERS and EXFAT_RESERVED_CLUSTERS macro.
 - Add the macros for EXFAT BIOS block(JUMP_BOOT_LEN, OEM_NAME_LEN,
   MUST_BE_ZERO_LEN).
 - Add the macros for EXFAT entry type (IS_EXFAT_CRITICAL_PRI,
   IS_EXFAT_BENIGN_PRI, IS_EXFAT_CRITICAL_SEC).
 - Add EXFAT_FILE_NAME_LEN macro.
 - Change the data type of is_dir with bool in __exfat_write_inode().
 - Change the data type of sync with bool in exfat_set_vol_flags().
 - Merge __exfat_set_vol_flags into exfat_set_vol_flags.
 - Fix wrong statfs->f_namelen.

v6:
 - Fix always false comparison due to limited range of allow_utime's data
   type.
 - Move bh into loop in exfat_find_dir_entry().
 - Move entry_uniname and unichar variables into
   an if "entry_type == TYPE_EXTEND" branch.

v5:
 - Remove a blank line between the message and the error code in
   exfat_load_upcase_table.
 - Move brelse to the end of the while loop and rename release_bh label
   to free_table in exfat_load_upcase_table.
 - Move an error code assignment after a failed function call.
 - Rename labels and directly return instead of goto.
 - Improve the exception handling in exfat_get_dentry_set().
 - Remove ->d_time leftover.
 - fix boolreturn.cocci warnings.

v4:
 - Declare ALLOC_FAT_CHAIN and ALLOC_NO_FAT_CHAIN macros.
 - Rename labels with proper name.
 - Remove blank lines.
 - Remove pointer check for bh.
 - Move ep into loop in exfat_load_bitmap().
 - Replace READ/WRITE_ONCE() with test_and_clear_bit() and set_bit().
 - Change exfat_allow_set_time return type with bool.

v3:
 - fix wrong sbi->s_dirt set.

v2:
 - Check the bitmap count up to the total clusters.
 - Rename goto labels in several places.
 - Change time mode type with enumeration.
 - Directly return error instead of goto at first error check.
 - Combine seq_printf calls into a single one.

Namjae Jeon (13):
  exfat: add in-memory and on-disk structures and headers
  exfat: add super block operations
  exfat: add inode operations
  exfat: add directory operations
  exfat: add file operations
  exfat: add fat entry operations
  exfat: add bitmap operations
  exfat: add exfat cache
  exfat: add misc operations
  exfat: add nls operations
  exfat: add Kconfig and Makefile
  MAINTAINERS: add exfat filesystem
  staging: exfat: make staging/exfat and fs/exfat mutually exclusive

 MAINTAINERS                   |    7 +
 drivers/staging/exfat/Kconfig |    2 +-
 fs/Kconfig                    |    3 +-
 fs/Makefile                   |    1 +
 fs/exfat/Kconfig              |   21 +
 fs/exfat/Makefile             |    8 +
 fs/exfat/balloc.c             |  280 +++++++
 fs/exfat/cache.c              |  325 ++++++++
 fs/exfat/dir.c                | 1238 ++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h           |  519 ++++++++++++
 fs/exfat/exfat_raw.h          |  184 +++++
 fs/exfat/fatent.c             |  463 +++++++++++
 fs/exfat/file.c               |  360 ++++++++
 fs/exfat/inode.c              |  671 +++++++++++++++
 fs/exfat/misc.c               |  163 ++++
 fs/exfat/namei.c              | 1448 +++++++++++++++++++++++++++++++++
 fs/exfat/nls.c                |  831 +++++++++++++++++++
 fs/exfat/super.c              |  728 +++++++++++++++++
 18 files changed, 7250 insertions(+), 2 deletions(-)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile
 create mode 100644 fs/exfat/balloc.c
 create mode 100644 fs/exfat/cache.c
 create mode 100644 fs/exfat/dir.c
 create mode 100644 fs/exfat/exfat_fs.h
 create mode 100644 fs/exfat/exfat_raw.h
 create mode 100644 fs/exfat/fatent.c
 create mode 100644 fs/exfat/file.c
 create mode 100644 fs/exfat/inode.c
 create mode 100644 fs/exfat/misc.c
 create mode 100644 fs/exfat/namei.c
 create mode 100644 fs/exfat/nls.c
 create mode 100644 fs/exfat/super.c

-- 
2.17.1

