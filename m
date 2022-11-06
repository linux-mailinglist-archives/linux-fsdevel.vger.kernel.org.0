Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA7C61E64D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 22:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKFVJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 16:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKFVJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:09:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC9411C02;
        Sun,  6 Nov 2022 13:09:13 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A6KY9bE029827;
        Sun, 6 Nov 2022 21:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=FCFmmf5SMlz4D4zKWJbVwaLDA71ZZuVqOiFaCs4nqXY=;
 b=QTlLeOTYDd7A2oozuLhuTb0TjcuCsgNgzdNuWOdTUSbpd0rH83ostwjx5QjdfTy7TLRa
 3+wPGuGmI8o1mBSXjLAUEXodyKnSMxYBYEyzU0zO/kOFN4osqqtiaTSUEJPoVh/UfQAs
 vXm/1LglvyPApCfg5Qp/nmtIUL27UFY13NOX7p1cFuoDDjGXu9WHQihEe/40w1KxoSiw
 C05hj2BV+JgI5EtTG5Z2t88PP17A6rNKH7sj5xCYDnBwkHrT/f2WQ/ofRWvRp6cP8Htf
 Fr3xErmq0TEh8e0mmDE6zj6P+t69Ac6+E3Ti29FM/6zgLAXGZ4FYJY/IKSrzOzr0WvRE gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1f652ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:08 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A6L87SQ001447;
        Sun, 6 Nov 2022 21:08:07 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1f652a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:07 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A6L6Eh8012622;
        Sun, 6 Nov 2022 21:08:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3kngmqh79j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A6L2N8P44630406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Nov 2022 21:02:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D3A11C050;
        Sun,  6 Nov 2022 21:08:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 171B311C04A;
        Sun,  6 Nov 2022 21:07:58 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.78.124])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Nov 2022 21:07:57 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 0/4] powerpc/pseries: expose firmware security variables via filesystem
Date:   Sun,  6 Nov 2022 16:07:40 -0500
Message-Id: <20221106210744.603240-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4ST7mGbUOu9sIIIKura1pB350hQLJg8K
X-Proofpoint-GUID: OqnmsFptL42RZI1SpLC9JCSG9pasCybZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-06_14,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211060188
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PowerVM provides an isolated Platform KeyStore (PKS)[1] storage allocation
for each logical partition (LPAR) with individually managed access controls
to store sensitive information securely. The Linux kernel can access this
storage by interfacing with the hypervisor using a new set of hypervisor
calls.
 
The PowerVM guest secure boot feature intends to use PKS for the purpose of
storing public keys. Secure boot requires public keys in order to verify
GRUB and the boot kernel. To allow authenticated manipulation of keys, PKS
supports variables to store key authorities namely, PK and KEK. Other
variables are used to store code signing keys, db and grubdb. It also
supports deny lists to disallow booting GRUB or kernels even if they are
signed with valid keys. This is done via deny list databases stored in dbx
and sbat variables. These variables are stored in PKS and are managed and
controlled by firmware.

The purpose of this patchset is to add the userspace interface to manage
these variables.

Currently, OpenPOWER exposes variables via sysfs, while EFI platforms have
used sysfs and then moved to their own efivarfs filesystem. The recent
coco feature uses securityfs to expose secrets to TEEs. All of these
environments are different both syntactically and semantically.

securityfs is meant for Linux security subsystems to expose policies, logs,
and other information and it does not interact with firmware for managing
these variables. However, there are various firmware security features that
expose their variables for user management via pseudo filesystems as
discussed above. There is currently no single place to expose these
variables. Different platforms use sysfs, platform-specific filesystems
such as efivars, or securityfs as they have found appropriate. This has
resulted in interfaces scattered around the tree. The multiple interfac
 problem can be addressed by providing a single pseudo filesystem for all
platforms to expose their variables for firmware security features. Doing
so simplifies the interface for users of these platforms.

This patchset introduces a new firmware security pseudo filesystem,
fwsecurityfs. Any platform can expose the variables that are required by
firmware security features via this interface. It provides a common place
for exposing variables managed by firmware while still allowing platforms
to implement their own underlying semantics.

This design consists of two parts:

1. Firmware security filesystem (fwsecurityfs) that provides platforms
   with APIs to create their own underlying directory and file structure.
   It should be mounted on a new well-known mountpoint,
   /sys/firmware/security.
2. Platform-specific layer for these variables that implements underlying
   semantics. Platforms can expose their variables as files allowing
   read/write/add/delete operations by defining their own inode and file
   functions.

This patchset adds:
1. An update to the PLPKS driver to support the signed update H_CALL for
   authenticated variables used in guest secure boot.
2. A firmware security filesystem named fwsecurityfs.
3. An interface to expose secure variables stored in the LPAR's PKS via
   fwsecurityfs.
 
Note: This patchset is not intended to modify existing interfaces already
used by OpenPOWER or EFI but rather to ensure that new similar interfaces
have a common base going forward.

The first patch related to PLPKS driver is dependent on bugfixes posted
as part of patchset[4].

Changelog:

First non-RFC version after RFC versions[2,3].
Feedback from non-RFC version are included to update fwsecurityfs.
 * PLPKS driver patch had been upstreamed separately. In this set, Patch 1
 updates existing driver to include signed update support.
 * Fix fwsecurityfs to also pin the file system, refactor and cleanup. The
 consideration of namespacing has been done and is concluded that currently
 no firmware object or entity is handled by namespacing. The purpose of
 fwsecurityfs is to expose firmware space which is similar to exposing
 space in TPM. And TPM is also not currently namespaced. If containers have
 to make use of some such space in the future, it would have to be some
 software space. With that, this currently only considers the host using the
 firmware space.
 * Fix secvars support for powerpc. It supports policy handling within the
 kernel, supports UCS2 naming and cleanups.
 * Read-only PLPKS configuration is exposed.
 * secvars directory is now moved within a new parent directory plpks.
 * Patch is now no more an RFC version.

[1] https://community.ibm.com/community/user/power/blogs/chris-engel1/2020/11/20/powervm-introduces-the-platform-keystore
[2] RFC v2: https://lore.kernel.org/linuxppc-dev/20220622215648.96723-1-nayna@linux.ibm.com/ 
[3] RFC v1: https://lore.kernel.org/linuxppc-dev/20220122005637.28199-1-nayna@linux.ibm.com/
[4] https://lore.kernel.org/linuxppc-dev/20221106205839.600442-1-nayna@linux.ibm.com/T/#t

Nayna Jain (4):
  powerpc/pseries: Add new functions to PLPKS driver
  fs: define a firmware security filesystem named fwsecurityfs
  powerpc/pseries: initialize fwsecurityfs with plpks arch-specific
    structure
  powerpc/pseries: expose authenticated variables stored in LPAR PKS

 arch/powerpc/include/asm/hvcall.h             |   3 +-
 arch/powerpc/platforms/pseries/Kconfig        |  20 +
 arch/powerpc/platforms/pseries/Makefile       |   2 +
 .../platforms/pseries/fwsecurityfs_arch.c     | 124 ++++++
 arch/powerpc/platforms/pseries/plpks.c        | 112 +++++-
 arch/powerpc/platforms/pseries/plpks.h        |  38 ++
 arch/powerpc/platforms/pseries/secvars.c      | 365 ++++++++++++++++++
 fs/Kconfig                                    |   1 +
 fs/Makefile                                   |   1 +
 fs/fwsecurityfs/Kconfig                       |  14 +
 fs/fwsecurityfs/Makefile                      |  10 +
 fs/fwsecurityfs/super.c                       | 263 +++++++++++++
 include/linux/fwsecurityfs.h                  |  33 ++
 include/uapi/linux/magic.h                    |   1 +
 14 files changed, 981 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/fwsecurityfs_arch.c
 create mode 100644 arch/powerpc/platforms/pseries/secvars.c
 create mode 100644 fs/fwsecurityfs/Kconfig
 create mode 100644 fs/fwsecurityfs/Makefile
 create mode 100644 fs/fwsecurityfs/super.c
 create mode 100644 include/linux/fwsecurityfs.h

-- 
2.31.1
