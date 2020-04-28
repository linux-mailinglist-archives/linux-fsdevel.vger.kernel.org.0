Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514761BBBC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgD1LAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:00:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35243 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgD1LAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:00:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id x18so24100817wrq.2;
        Tue, 28 Apr 2020 04:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z4rZsUUAXKMchGer60sdNq4ZnifIJDsFAH0WJ3jivdk=;
        b=qCS6QJiCDD/gpKoXbfffR3RhkoKQ4K+CCy3OAaSRDuYjEPipl+2KgH2stOZ8bFSeLU
         grBykhsFvuEseQoN9a2WnC+PRNRmnQ+FpX6lHp8cQZX/Ub06Pcz8en30PDi1Rj1JHiNr
         kTOTqwmlBUUcJGQYDlRqnNgEW3JVc/LEaq5eiWXr7/yoE5KMYieUbM3xm7l45fbJmIwf
         un4zpTwvEETAXPStoSUtVhlR+i4Fs2XIHpiPDa1SeL93Aye1UKfdIeo8rlLQnyiE3cXh
         0XCTU2t3pgviEssfHSvgfk1Z1ShGgq3AwrGqfwlsp1kwwE6PMC5yFZBaCtjQ/QoLWHoR
         uqDg==
X-Gm-Message-State: AGi0PubQSUrvsh0YfJ12WPJayN/d/FG7KlwPfucco3gaSDGmOGUS/+7g
        0RSJ2ZCP144XCv14KtayRjVpHYJ3MJs=
X-Google-Smtp-Source: APiQypI5xNM6szH37J2x24cDQMhUSQ2UyKxh0I/cVgRVbQkJpRrKws5et97ULGT6L+ZFBaPf5evgvA==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr31828215wrw.406.1588071614718;
        Tue, 28 Apr 2020 04:00:14 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-205-206.dynamic.mnet-online.de. [46.244.205.206])
        by smtp.gmail.com with ESMTPSA id c83sm2997739wmd.23.2020.04.28.04.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:00:14 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] Add file-system authentication to BTRFS
Date:   Tue, 28 Apr 2020 12:58:57 +0200
Message-Id: <20200428105859.4719-1-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This series adds file-system authentication to BTRFS. 

Unlike other verified file-system techniques like fs-verity the
authenticated version of BTRFS does not need extra meta-data on disk.

This works because in BTRFS every on-disk block has a checksum, for meta-data
the checksum is in the header of each meta-data item. For data blocks, a
separate checksum tree exists, which holds the checksums for each block.

Currently BRTFS supports CRC32C, XXHASH64, SHA256 and Blake2b for checksumming
these blocks. This series adds a new checksum algorithm, HMAC(SHA-256), which
does need an authentication key. When no, or an incoreect authentication key
is supplied no valid checksum can be generated and a read, fsck or scrub
operation would detect invalid or tampered blocks once the file-system is
mounted again with the correct key. 

Getting the key inside the kernel is out of scope of this implementation, the
file-system driver assumes the key is already in the kernel's keyring at mount
time.

There was interest in also using a HMAC version of Blake2b from the community,
but as none of the crypto libraries used by user-space BTRFS tools as a
backend does currently implement a HMAC version with Blake2b, it is not (yet)
included.

I have CCed Eric Biggers and Richard Weinberger in the submission, as they
previously have worked on filesystem authentication and I hope we can get
input from them as well.

Example usage:
Create a file-system with authentication key 0123456
mkfs.btrfs --csum hmac-sha256 --auth-key 0123456 /dev/disk

Add the key to the kernel's keyring as keyid 'btrfs:foo'
keyctl add logon btrfs:foo 0123456 @u

Mount the fs using the 'btrfs:foo' key
mount -t btrfs -o auth_key=btrfs:foo /dev/disk /mnt/point

Note, this is a re-base of the work I did when I was still at SUSE, hence the
S-o-b being my SUSE address, while the Author being with my WDC address (to
not generate bouncing mails).

Changes since v1:
- None, only rebased the series

Johannes Thumshirn (2):
  btrfs: add authentication support
  btrfs: rename btrfs_parse_device_options back to
    btrfs_parse_early_options

 fs/btrfs/ctree.c                |  3 ++-
 fs/btrfs/ctree.h                |  2 ++
 fs/btrfs/disk-io.c              | 53 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/super.c                | 31 +++++++++++++++++++-----
 include/uapi/linux/btrfs_tree.h |  1 +
 5 files changed, 82 insertions(+), 8 deletions(-)

-- 
2.16.4

