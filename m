Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611F2E90F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 21:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfJ2Unz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 16:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2Unz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:43:55 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E132087F;
        Tue, 29 Oct 2019 20:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572381835;
        bh=PO9FWnMviEuNb31RBWbFM6qoAGbqLACtBOE0D5G9jSY=;
        h=From:To:Cc:Subject:Date:From;
        b=tXVpNGPBJfZ2HxnE4AwO/rpSHRictz/rj27j8Txw6/U7VlJMoTBH9fL5Cn/eP4RI8
         vfqiLz4derg9gYJzw1E4PMXNQf9Tp3CgrcCbyjjmlqTxM9+zOp6SUzKO+QPaJYrhTd
         32TVj4HxDWc0jneJIVgxG8SvQxHdfjPbW9H5Eg34=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 0/4] statx: expose the fs-verity bit
Date:   Tue, 29 Oct 2019 13:41:37 -0700
Message-Id: <20191029204141.145309-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset exposes the verity bit (a.k.a. FS_VERITY_FL) via statx().

This is useful because it allows applications to check whether a file is
a verity file without opening it.  Opening a verity file can be
expensive because the fsverity_info is set up on open, which involves
parsing metadata and optionally verifying a cryptographic signature.

This is analogous to how various other bits are exposed through both
FS_IOC_GETFLAGS and statx(), e.g. the encrypt bit.

This patchset applies to v5.4-rc5.

Eric Biggers (4):
  statx: define STATX_ATTR_VERITY
  ext4: support STATX_ATTR_VERITY
  f2fs: support STATX_ATTR_VERITY
  docs: fs-verity: mention statx() support

 Documentation/filesystems/fsverity.rst | 8 ++++++++
 fs/ext4/inode.c                        | 5 ++++-
 fs/f2fs/file.c                         | 5 ++++-
 include/linux/stat.h                   | 3 ++-
 include/uapi/linux/stat.h              | 2 +-
 5 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

