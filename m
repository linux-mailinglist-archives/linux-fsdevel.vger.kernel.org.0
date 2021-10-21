Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D70743608C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhJULrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhJULrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=01Spz1miJqveTKFwmHuV+ca07Xv+jZgHjncZxHGs3nw=;
        b=glpZekb3pB2exwFEB9TfhoYugw7rxjr1SZjArR86db1mPRfek1Sy2D6jOrPSYOg+efJQeo
        Q1+Pv3W3obCa4RAFRpuBw193uH1UDB/Wq/Xd0tzHc9/Wwp1pGJIoqzWV2mWQ650Eihw/0J
        aGdQAY3QL1LHQlXKuWmbOgC6WlA2zQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-y_jgkEPJN1CkF_mBAMJ_mA-1; Thu, 21 Oct 2021 07:45:13 -0400
X-MC-Unique: y_jgkEPJN1CkF_mBAMJ_mA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DE5F1808304;
        Thu, 21 Oct 2021 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC54652AC;
        Thu, 21 Oct 2021 11:45:11 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/13] ext4: new mount API conversion
Date:   Thu, 21 Oct 2021 13:44:55 +0200
Message-Id: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After some time I am once again resurrecting the patchset to convert the
ext4 to use the new mount API
(Documentation/filesystems/mount_api.txt).

The series can be applied on top of the current mainline tree and the work
is based on the patches from David Howells (thank you David). It was built
and tested with xfstests and a new ext4 mount options regression test that
was sent to the fstests list.

https://www.spinics.net/lists/fstests/msg17756.html

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
---
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

 fs/ext4/super.c           | 1846 +++++++++++++++++++++++--------------
 fs/fs_parser.c            |   31 +-
 include/linux/fs_parser.h |    2 +-
 3 files changed, 1187 insertions(+), 692 deletions(-)


base-commit: d9abdee5fd5abffd0e763e52fbfa3116de167822
-- 
2.31.1

