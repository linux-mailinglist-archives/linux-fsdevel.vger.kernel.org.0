Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01407475C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2019 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfFPQI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jun 2019 12:08:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727351AbfFPQI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:08:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5GG6Rri063661;
        Sun, 16 Jun 2019 12:07:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t5e9te9cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jun 2019 12:07:55 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5GG6cp5064406;
        Sun, 16 Jun 2019 12:07:55 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t5e9te9c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jun 2019 12:07:55 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5GFxNC8018708;
        Sun, 16 Jun 2019 16:07:54 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2t4ra61bbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jun 2019 16:07:54 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5GG7reJ32112910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jun 2019 16:07:53 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01BE46E04C;
        Sun, 16 Jun 2019 16:07:53 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E88E06E04E;
        Sun, 16 Jun 2019 16:07:48 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.1.181])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 16 Jun 2019 16:07:48 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, jaegeuk@kernel.org,
        yuchao0@huawei.com, hch@infradead.org
Subject: [PATCH V3 0/7] Consolidate FS read I/O callbacks code
Date:   Sun, 16 Jun 2019 21:38:06 +0530
Message-Id: <20190616160813.24464-1-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset moves the "FS read I/O callbacks" code into a file of its
own (i.e. fs/read_callbacks.c) and modifies the generic
do_mpage_readpge() to make use of the functionality provided.

"FS read I/O callbacks" code implements the state machine that needs
to be executed after reading data from files that are encrypted and/or
have verity metadata associated with them.

With these changes in place, the patchset changes Ext4 to use
mpage_readpage[s] instead of its own custom ext4_readpage[s]()
functions. This is done to reduce duplication of code across
filesystems. Also, "FS read I/O callbacks" source files will be built
only if CONFIG_FS_ENCRYPTION is enabled.

The patchset also modifies fs/buffer.c to get file
encryption/decryption to work with subpage-sized blocks.

The patches can also be obtained from
https://github.com/chandanr/linux.git at branch subpage-encryption-v3.

Changelog:
V2 -> V3:
1. Split the V2 patch "Consolidate 'read callbacks' into a new file" into
   three patches,
   - Introduce the read_callbacks functionality.
   - Convert encryption to use read_callbacks.
   - Remove union from struct fscrypt_context.
2. fs/Kconfig
   Do not explicitly set the default value of 'n' for FS_READ_CALLBACKS.
3. fs/crypto/Kconfig
   Select CONFIG_FS_READ_CALLBACKS only if CONFIG_BLOCK is selected.
4. Remove verity associated code in read_callbacks code.
5. Introduce a callback argument to read_callbacks_setup() function
   which gets invoked for each page for bio. F2FS uses this to perform
   custom operations like decrementing the value of f2fs_sb_info->nr_pages[].
6. Encapsulate the details of "read callbacks" (e.g. Usage of "struct
   read_callbacks *ctx") within its own functions. When CONFIG_FS_READ_CALLBACKS
   is set to 'n', the corresponding stub functions return approriate error
   values.
7. Split fscrypt_decrypt() function into fscrypt_decrypt_bio() and
   fscrypt_decrypt_bh().
8. Split end_read_callbacks() function into end_read_callbacks_bio() and
   end_read_callbacks_bh().

V1 -> V2:
1. Removed the phrase "post_read_process" from file names and
   functions. Instead we now use the phrase "read_callbacks" in its
   place.
2. When performing changes associated with (1), the changes made by
   the patch "Remove the term 'bio' from post read processing" are
   made in the earlier patch "Consolidate 'read callbacks' into a new
   file". Hence the patch "Remove the term 'bio' from post read
   processing" is removed from the patchset.

RFC V2 -> V1:
1. Test and verify FS_CFLG_OWN_PAGES subset of fscrypt_encrypt_page()
   code by executing fstests on UBIFS.
2. Implement F2fs function call back to check if the contents of a
   page holding a verity file's data needs to be verified.

RFC V1 -> RFC V2:
1. Describe the purpose of "Post processing code" in the cover letter.
2. Fix build errors when CONFIG_FS_VERITY is enabled.

Chandan Rajendra (7):
  FS: Introduce read callbacks
  Integrate read callbacks into Ext4 and F2FS
  fscrypt: remove struct fscrypt_ctx
  fs/mpage.c: Integrate read callbacks
  ext4: Wire up ext4_readpage[s] to use mpage_readpage[s]
  Add decryption support for sub-pagesized blocks
  ext4: Enable encryption for subpage-sized blocks

 Documentation/filesystems/fscrypt.rst |   4 +-
 fs/Kconfig                            |   3 +
 fs/Makefile                           |   2 +
 fs/buffer.c                           |  55 +++--
 fs/crypto/Kconfig                     |   1 +
 fs/crypto/bio.c                       |  44 ++--
 fs/crypto/crypto.c                    |  90 +-------
 fs/crypto/fscrypt_private.h           |   3 +
 fs/ext4/Makefile                      |   2 +-
 fs/ext4/inode.c                       |   5 +-
 fs/ext4/readpage.c                    | 295 --------------------------
 fs/ext4/super.c                       |   7 -
 fs/f2fs/data.c                        | 124 ++---------
 fs/f2fs/super.c                       |   9 +-
 fs/mpage.c                            |  11 +-
 fs/read_callbacks.c                   | 233 ++++++++++++++++++++
 include/linux/buffer_head.h           |   1 +
 include/linux/fscrypt.h               |  38 ----
 include/linux/read_callbacks.h        |  45 ++++
 19 files changed, 390 insertions(+), 582 deletions(-)
 delete mode 100644 fs/ext4/readpage.c
 create mode 100644 fs/read_callbacks.c
 create mode 100644 include/linux/read_callbacks.h

-- 
2.19.1

