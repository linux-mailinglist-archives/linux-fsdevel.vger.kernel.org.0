Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19356188EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfEIL1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 07:27:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32927 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfEIL1d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 07:27:33 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EE505197B016B0870572;
        Thu,  9 May 2019 12:27:31 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 May 2019 12:27:25 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/3] initramfs: add support for xattrs in the initial ram disk
Date:   Thu, 9 May 2019 13:24:17 +0200
Message-ID: <20190509112420.15671-1-roberto.sassu@huawei.com>
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

This proposal consists in marshaling pathnames and xattrs in a file called
.xattr-list. They are unmarshaled by the CPIO parser after all files have
been extracted.

The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that all
xattrs are stored in a single file and not per file (solves the file name
limitation issue, as it is not necessary to add a suffix to files
containing xattrs).

The difference with another proposal
(https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
included in an image without changing the image format, as opposed to
defining a new one. As seen from the discussion, if a new format has to be
defined, it should fix the issues of the existing format, which requires
more time.

To fulfill both requirements, adding support for xattrs in a short time and
defining a new image format properly, this patch set takes an incremental
approach: it introduces a parser of xattrs that can be used either if
xattrs are in a regular file or directly added to the image (this patch set
reuses patch 9/15 of the existing proposal); in addition, it introduces a
wrapper of the xattr parser, to read xattrs from a file.

The changes introduced by this patch set don't cause any compatibility
issue: kernels without the xattr parser simply extracts .xattr-list and
don't unmarshal xattrs; kernels with the xattr parser don't unmarshal
xattrs if .xattr-list is not found in the image.

From the kernel space perspective, backporting this functionality to older
kernels should be very easy. It is sufficient to add a call to the new
function do_readxattrs(). From the user space perspective, no change is
required for the use case. A new dracut module (module-setup.sh) will
execute:

getfattr --absolute-names -d -P -R -e hex -m security.ima \
    <file list> | xattr.awk -b > ${initdir}/.xattr-list

where xattr.awk is the script that marshals xattrs (see patch 3/3). The
same can be done with the initramfs-tools ram disk generator.

Changelog

v1:

- move xattr unmarshaling to CPIO parser


Mimi Zohar (1):
  initramfs: set extended attributes

Roberto Sassu (2):
  fs: add ksys_lsetxattr() wrapper
  initramfs: introduce do_readxattrs()

 fs/xattr.c               |   9 ++-
 include/linux/syscalls.h |   3 +
 init/initramfs.c         | 152 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 161 insertions(+), 3 deletions(-)

-- 
2.17.1

