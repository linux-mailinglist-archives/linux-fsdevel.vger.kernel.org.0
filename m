Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF627CA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfEWMVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 08:21:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbfEWMVZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 08:21:25 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DF1343C60C1E20BF93B0;
        Thu, 23 May 2019 13:21:22 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.46) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 23 May 2019 13:21:11 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>,
        <zohar@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>,
        <dmitry.kasatkin@huawei.com>, <takondra@cisco.com>,
        <kamensky@cisco.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 0/3] initramfs: add support for xattrs in the initial ram disk
Date:   Thu, 23 May 2019 14:18:00 +0200
Message-ID: <20190523121803.21638-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set aims at solving the following use case: appraise files from
the initial ram disk. To do that, IMA checks the signature/hash from the
security.ima xattr. Unfortunately, this use case cannot be implemented
currently, as the CPIO format does not support xattrs.

This proposal consists in including file metadata as additional files named
METADATA!!!, for each file added to the ram disk. The CPIO parser in the
kernel recognizes these special files from the file name, and calls the
appropriate parser to add metadata to the previously extracted file. It has
been proposed to use bit 17:16 of the file mode as a way to recognize files
with metadata, but both the kernel and the cpio tool declare the file mode
as unsigned short.

The difference from v2, v3 (https://lkml.org/lkml/2019/5/9/230,
https://lkml.org/lkml/2019/5/17/466) is that file metadata are stored in
separate files instead of a single file. Given that files with metadata
must immediately follow the files metadata will be added to, image
generators have to be modified in this version.

The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that
all files have the same name. The file metadata are added to is always the
previous one, and the image generator in user space will make sure that
files are in the correct sequence.

The difference with another proposal
(https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
included in an image without changing the image format. Files with metadata
will appear as regular files. It will be task of the parser in the kernel
to process them.

This patch set extends the format of data defined in patch 9/15 of the last
proposal. It adds header version and type, so that new formats can be
defined and arbitrary metadata types can be processed.

The changes introduced by this patch set don't cause any compatibility
issue: kernels without the metadata parser simply extract the special files
and don't process metadata; kernels with the metadata parser don't process
metadata if the special files are not included in the image.

From the kernel space perspective, backporting this functionality to older
kernels should be very easy. It is sufficient to add two calls to the new
function do_process_metadata() in do_copy(), and to check the file name in
do_name(). From the user space perspective, unlike the previous version of
the patch set, it is required to modify the image generators in order to
include metadata as separate files.

Changelog

v3:
- include file metadata as separate files named METADATA!!!
- add the possibility to include in the ram disk arbitrary metadata types

v2:
- replace ksys_lsetxattr() with kern_path() and vfs_setxattr()
  (suggested by Jann Horn)
- replace ksys_open()/ksys_read()/ksys_close() with
  filp_open()/kernel_read()/fput()
  (suggested by Jann Horn)
- use path variable instead of name_buf in do_readxattrs()
- set last byte of str to 0 in do_readxattrs()
- call do_readxattrs() in do_name() before replacing an existing
  .xattr-list
- pass pathname to do_setxattrs()

v1:
- move xattr unmarshaling to CPIO parser


Mimi Zohar (1):
  initramfs: add file metadata

Roberto Sassu (2):
  initramfs: read metadata from special file METADATA!!!
  gen_init_cpio: add support for file metadata

 include/linux/initramfs.h |  21 ++++++
 init/initramfs.c          | 137 +++++++++++++++++++++++++++++++++++++-
 usr/Kconfig               |   8 +++
 usr/Makefile              |   4 +-
 usr/gen_init_cpio.c       | 137 ++++++++++++++++++++++++++++++++++++--
 usr/gen_initramfs_list.sh |  10 ++-
 6 files changed, 305 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/initramfs.h

-- 
2.17.1

