Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99E11D2B48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgENJYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 05:24:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44512 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENJYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 05:24:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id 50so2905009wrc.11;
        Thu, 14 May 2020 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvLcRj3zFxBfrwvPJw8Re1n0yA4eLs/LIsJCgzVzMpU=;
        b=Wfa7s4KOnvy2WzGq5GAQqe6zsCqtq+vgOYACvyWVQfDCLwTmzWnlDxGOyCHLw1gx+l
         Ezcfys6ihKO73hbP3IKQsEnbPYwzQOpSfKPkEzkXuwOTLOyOxlciYY7f9O6iwta+vu9p
         1Oe35wOVz+RiwzB/4eVhG9pD5GZr/46QUCbXZVclNZuoQv7fETtJViYrK23XQNHttjVm
         fKOn84+VMk5jRB8xGiq5stnmLFbZRRmjeMFu1jVCis/OTaOnI/GYjileppWHi0GtOSyj
         tK83ltTYz0YcTD6E2SXU3BQrSSknLkn9Nple3YaKNeS149VytLSYzHV41DBtVVlQz01u
         2q3w==
X-Gm-Message-State: AOAM532aHs6T1QD7eOWCb0FRvGO+vVQOPJWd2b/SyIZEoT4QkeAKP37y
        CcaYgjmfLjT7Ry/pqyr6aPY=
X-Google-Smtp-Source: ABdhPJzMksLJ4HOEMDykfeERVMe+0JLicmjf2ryyiIAz2rIlrZvHs1eJh9g0Ll74wg/sb2kVU6cV2A==
X-Received: by 2002:adf:fa4d:: with SMTP id y13mr4490865wrr.263.1589448279652;
        Thu, 14 May 2020 02:24:39 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id z132sm38877763wmc.29.2020.05.14.02.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:24:39 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/3] Add file-system authentication to BTRFS
Date:   Thu, 14 May 2020 11:24:12 +0200
Message-Id: <20200514092415.5389-1-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There was interest in also using keyed Blake2b from the community, but this
support is not yet included.

I have CCed Eric Biggers and Richard Weinberger in the submission, as they
previously have worked on filesystem authentication and I hope we can get
input from them as well.

Example usage:
Create a file-system with authentication key 0123456
mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk

Add the key to the kernel's keyring as keyid 'btrfs:foo'
keyctl add logon btrfs:foo 0123456 @u

Mount the fs using the 'btrfs:foo' key
mount -t btrfs -o auth_key=btrfs:foo,auth_hash_name="hmac(sha256)" /dev/disk /mnt/point

Note, this is a re-base of the work I did when I was still at SUSE, hence the
S-o-b being my SUSE address, while the Author being with my WDC address (to
not generate bouncing mails).

Changes since v2:
- Select CONFIG_CRYPTO_HMAC and CONFIG_KEYS (kbuild robot)
- Fix double free in error path
- Fix memory leak in error path
- Disallow nodatasum and nodatacow when authetication is use (Eric)
- Pass in authentication algorithm as mount option (Eric)
- Don't use the work "replay" in the documentation, as it is wrong and
  harmful in this context (Eric)
- Force key name to begin with 'btrfs:' (Eric)
- Use '4' as on-disk checksum type for HMAC(SHA256) to not have holes in the
  checksum types array.

Changes since v1:
- None, only rebased the series

Johannes Thumshirn (3):
  btrfs: rename btrfs_parse_device_options back to
    btrfs_parse_early_options
  btrfs: add authentication support
  btrfs: document btrfs authentication

 .../filesystems/btrfs-authentication.rst      | 168 ++++++++++++++++++
 fs/btrfs/Kconfig                              |   2 +
 fs/btrfs/ctree.c                              |  22 ++-
 fs/btrfs/ctree.h                              |   5 +-
 fs/btrfs/disk-io.c                            |  71 +++++++-
 fs/btrfs/ioctl.c                              |   7 +-
 fs/btrfs/super.c                              |  65 ++++++-
 include/uapi/linux/btrfs_tree.h               |   1 +
 8 files changed, 326 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/filesystems/btrfs-authentication.rst

-- 
2.26.1

