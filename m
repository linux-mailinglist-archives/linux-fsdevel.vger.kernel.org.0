Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3943CBDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbhJ0OVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242521AbhJ0OVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FBDNXn5opfgZEfd8fE3msBflFHRInWnTIkAZR/iFob4=;
        b=PUdbbrZd94fl1J76+ZYxYvR/FBI52u5ARyJqcrtZ1bE+BqQ/ohCxjagOEDAkUx3+H/u1lU
        mjBxCASnQjMKKAb8C/qGOCH6jLvwo1D9TX9v0tFt+TkZuA/XKRAe1MR7Q71B/0Y0TOKkJG
        uQVAOhJB9nY/pgtFmHKhc2lZcc3mj6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-Xop_k_ESMAiz0Ua_eXBSKA-1; Wed, 27 Oct 2021 10:19:13 -0400
X-MC-Unique: Xop_k_ESMAiz0Ua_eXBSKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EC2F101F7A5;
        Wed, 27 Oct 2021 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08E6E17DBA;
        Wed, 27 Oct 2021 14:19:01 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 00/13] ext4: new mount API conversion
Date:   Wed, 27 Oct 2021 16:18:44 +0200
Message-Id: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After some time I am once again resurrecting the patchset to convert the
ext4 to use the new mount API
(Documentation/filesystems/mount_api.txt).

The series can be applied on top of the current mainline tree and the work
is based on the patches from David Howells (thank you David). It was built
and tested with xfstests and a new ext4 mount options regression test that
was sent to the fstests list. You can check it out on github as well.

https://github.com/lczerner/xfstests/tree/ext4_mount_test

Here is a high level description of the patchset

1. Prepare the ext4 mount parameters required by the new mount API and use
   it for parsing, while still using the old API to get the options
   string.

  fs_parse: allow parameter value to be empty
  ext4: Add fs parameter specifications for mount options
  ext4: move option validation to a separate function
  ext4: Change handle_mount_opt() to use fs_parameter

2. Remove the use of ext4 super block from all the parsing code, because
   with the new mount API the parsing is going to be done before we even
   get the super block.

  ext4: Allow sb to be NULL in ext4_msg()
  ext4: move quota configuration out of handle_mount_opt()
  ext4: check ext2/3 compatibility outside handle_mount_opt()
  ext4: get rid of super block and sbi from handle_mount_ops()

3. Actually finish the separation of the parsing and super block setup
   into distinct steps. This is where the new ext4_fill_super() and
   ext4_remount() functions are created temporarily before the actual
   transition to the new API.

  ext4: Completely separate options parsing and sb setup

4. Make some last preparations and actually switch the ext4 to use the
   new mount API.

  ext4: clean up return values in handle_mount_opt()
  ext4: change token2str() to use ext4_param_specs
  ext4: switch to the new mount api

5. Cleanup the old unused structures and rearrange the parsing function.

  ext4: Remove unused match_table_t tokens

There is still a potential to do some cleanups and perhaps refactoring
such as using the fsparam_flag_no to remove the separate negative
options for example. However that can be done later after the conversion
to the new mount API which is the main purpose of the patchset.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
v3 -> v4: Fix some typos, print exact quotafile type in log messages.
          Remove explicit "Ext4:" from some log messages
V2 -> V3: Rebase to the newer kernel, including new mount options.
V1 -> V2: Rebase to the newer kernel

Lukas Czerner (13):
  fs_parse: allow parameter value to be empty
  ext4: Add fs parameter specifications for mount options
  ext4: move option validation to a separate function
  ext4: Change handle_mount_opt() to use fs_parameter
  ext4: Allow sb to be NULL in ext4_msg()
  ext4: move quota configuration out of handle_mount_opt()
  ext4: check ext2/3 compatibility outside handle_mount_opt()
  ext4: get rid of super block and sbi from handle_mount_ops()
  ext4: Completely separate options parsing and sb setup
  ext4: clean up return values in handle_mount_opt()
  ext4: change token2str() to use ext4_param_specs
  ext4: switch to the new mount api
  ext4: Remove unused match_table_t tokens

 fs/ext4/super.c           | 1848 +++++++++++++++++++++++--------------
 fs/fs_parser.c            |   31 +-
 include/linux/fs_parser.h |    2 +-
 3 files changed, 1189 insertions(+), 692 deletions(-)

-- 
2.31.1

