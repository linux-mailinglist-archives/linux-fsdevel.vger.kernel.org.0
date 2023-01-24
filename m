Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32073678E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjAXCjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:39:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650E6303F7;
        Mon, 23 Jan 2023 18:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C1661177;
        Tue, 24 Jan 2023 02:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE4DC433EF;
        Tue, 24 Jan 2023 02:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674527947;
        bh=F4sTcOFyWGXSAq6Qam4JIEoGJfFTcWlqfUVCdiEqLJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNS87hUFKYpRtzfj7nyDEfEASgBqbRaKmb564FhjdiUgItaDg/ta0btS6/H13vUiy
         CJSmOqpRkh/dJQvA3ED9Lh3l17vSXmyFKhvhfZrd12CnjqlJZgw2+w52jQkiSaJdKc
         39jOnOFohqIP4JYj+IT4Dmyd3FF/Eq8yqBDT+5hDNs8zcl70n6Ih1XDpxx8bZxhuE8
         PcKZzLPwFOl8+1jr86yFID4VtvoZpO3qfpXGHn9xiulLIbCQF/X9sYKsxuUSWV9IeF
         TxBDFoCyAeFlsjePGrk5Qc1JfzERZN4sG9b3+qGzN+DeTT3y5sXK70+xNknavMuz5/
         k6qcnWBjGS6QQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 00/11] Performance fixes for 9p filesystem
Date:   Tue, 24 Jan 2023 02:38:23 +0000
Message-Id: <20230124023834.106339-1-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221218232217.1713283-1-evanhensbergen@icloud.com>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the third version of a patch series which adds a number
of features to improve read/write performance in the 9p filesystem.
Mostly it focuses on fixing caching to help utilize the recently
increased MSIZE limits and also fixes some problematic behavior
within the writeback code.

All together, these show roughly 10x speed increases on simple
file transfers.  Future patch sets will improve cache consistency
and directory caching.

These patches are also available on github:
https://github.com/v9fs/linux/tree/ericvh/for-next
and on kernel.org:
https://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git

Tested against qemu, cpu, and diod with fsx, dbench, and some
simple benchmarks.

Eric Van Hensbergen (11):
  Adjust maximum MSIZE to account for p9 header
  Expand setup of writeback cache to all levels
  Consolidate file operations and add readahead and writeback
  Remove unnecessary superblock flags
  allow disable of xattr support on mount
  fix bug in client create for .L
  Add additional debug flags and open modes
  Add new mount modes
  fix error reporting in v9fs_dir_release
  writeback mode fixes
  Fix revalidate

 Documentation/filesystems/9p.rst |  26 +++--
 fs/9p/fid.c                      |  52 ++++-----
 fs/9p/fid.h                      |  33 +++++-
 fs/9p/v9fs.c                     |  49 +++++---
 fs/9p/v9fs.h                     |   9 +-
 fs/9p/v9fs_vfs.h                 |   4 -
 fs/9p/vfs_addr.c                 |  24 ++--
 fs/9p/vfs_dentry.c               |   3 +-
 fs/9p/vfs_dir.c                  |  16 ++-
 fs/9p/vfs_file.c                 | 194 +++++++------------------------
 fs/9p/vfs_inode.c                |  71 ++++-------
 fs/9p/vfs_inode_dotl.c           |  62 +++++-----
 fs/9p/vfs_super.c                |  28 +++--
 include/net/9p/9p.h              |   5 +
 net/9p/client.c                  |   8 +-
 15 files changed, 256 insertions(+), 328 deletions(-)

-- 
2.37.2

