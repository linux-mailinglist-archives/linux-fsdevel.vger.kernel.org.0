Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED0556E0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiFVV5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFVV5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:57:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78640A02;
        Wed, 22 Jun 2022 14:57:40 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MLPvrW013871;
        Wed, 22 Jun 2022 21:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=wNrQVEVaFcDMWmqDST9SZuYibDEqKfSUZp7T+Wo55Ac=;
 b=G2u+N0OgeVVS8kzXrD4OajoJy1zGHoZg8PXfuSlx38UTYBP1e83uWZmCjNA4Is4j/5Nu
 cZSQ9Ft7AkyrVfLZe1uWpdQ7PT0zDv+ILR0dQYjKEopnetCS7Jw3WygGTEEGxdzVxKMx
 bW0sYVM5LEYXLEi6zhrDxPBDmBMZGnJ5QgRi1co0/b4J5G0URJAe/ruSPONt4j5B+uJL
 xFtvpASaNBQso0snWI2t83Z2IzARV0k6V0YJy3C61BfSX4c6A7juaLALGtMm+b4+hFoa
 ohXsKsOo8SXl4h4caRJM8RGorZ2Ihq6ClYS+KtRMegSTJkKnIk50WmzyaIDzUOetVBZ/ JA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvb08gsc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MLqKwm002781;
        Wed, 22 Jun 2022 21:57:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3gs6b8x8h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MLuEX912714340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 21:56:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8240A4040;
        Wed, 22 Jun 2022 21:57:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4158EA404D;
        Wed, 22 Jun 2022 21:56:58 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.125.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 21:56:58 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [RFC PATCH v2 0/3] powerpc/pseries: add support for local secure storage called Platform KeyStore(PKS) 
Date:   Wed, 22 Jun 2022 17:56:45 -0400
Message-Id: <20220622215648.96723-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ie8oPpULTEbPRXGCYP4_7THoM8DyvL3m
X-Proofpoint-GUID: ie8oPpULTEbPRXGCYP4_7THoM8DyvL3m
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_08,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PowerVM provides an isolated Platform KeyStore(PKS)[1] storage allocation
for each partition(LPAR) with individually managed access controls to store
sensitive information securely. Linux Kernel can access this storage by
interfacing with hypervisor using a new set of hypervisor calls. 

PowerVM guest secure boot feature intend to use Platform KeyStore for
the purpose of storing public keys. Secure boot requires public keys to
be able to verify the grub and boot kernel. To allow authenticated
 manipulation of keys, it supports variables to store key authorities
- PK/KEK. Other variables are used to store code signing keys - db/grubdb.
It also supports denied list to disallow booting even if signed with
valid key. This is done via denied list database - dbx or sbat. These
variables would be stored in PKS, and are managed and controlled by
firmware.

The purpose of this patchset is to add userspace interface to manage
these variables.

For v1[2] version, we received following feedback
"Ok, this is like the 3rd or 4th different platform-specific proposal for
this type of functionality.  I think we need to give up on
platform-specific user/kernel apis on this (random sysfs/securityfs
files scattered around the tree), and come up with a standard place for
all of this."

Currently, OpenPOWER exposes variables via sysfs, while EFI platforms
have used sysfs and then moved to their own efivarfs filesystem.
Recently, coco feature is using securityfs to expose their
secrets. All of these environments are different both syntactically and
semantically.

securityfs is meant for linux security subsystems to expose policies/logs
or any other information, and do not interact with firmware for managing
these variables. However, there are various firmware security
features which expose their variables for user management via kernel as
discussed above. There is currently no single place to expose these
variables. Different platforms use sysfs/platform specific
filesystem(efivarfs)/securityfs interface as find appropriate. This has
resulted in interfaces scattered around the tree.

This resulted in demand of a need for a common single place for new
platform interfaces to expose their variables for firmware security
features. This would simplify the interface for users of these platforms.
This patchset proposes firmware security filesystem(fwsecurityfs). Any
platform can expose the variables which are required by firmware security
features via this interface. Going forward, this would give a common place
for exposing variables managed by firmware while still allowing platforms
to implement their own underlying semantics.

This design consists of two parts:
1. firmware security filesystem(fwsecurityfs) that provides platforms with
APIs to create their own underlying directory and file structure. It is
recommended to establish a well known mount point:
i.e. /sys/firmware/security/

2. platform specific implementation for these variables which implements
underlying semantics. Platforms can expose their variables as files
allowing read/write/add/delete operations by defining their own inode and
file operations.

This patchset defines:
1. pseries driver to access LPAR Platform Key Store(PLPKS)
2. firmware security filesystem named fwsecurityfs
3. Interface to expose secure variables stored in LPAR PKS via fwsecurityfs

[1] https://community.ibm.com/community/user/power/blogs/chris-engel1/2020/11/20/powervm-introduces-the-platform-keystore
[2] https://lore.kernel.org/linuxppc-dev/20220122005637.28199-1-nayna@linux.ibm.com/

Changelog:

v1:

* Defined unified interface(firmware security filesystem) for all platforms
to expose their variables used for security features. 
* Expose secvars using firmware security fileystem.
* Renamed PKS driver to PLPKS to avoid naming conflict as mentioned by
Dave Hanson.

Nayna Jain (3):
  powerpc/pseries: define driver for Platform KeyStore
  fs: define a firmware security filesystem named fwsecurityfs
  powerpc/pseries: expose authenticated variables stored in LPAR PKS

 arch/powerpc/include/asm/hvcall.h             |  12 +-
 arch/powerpc/include/asm/plpks.h              |  92 ++++
 arch/powerpc/platforms/pseries/Kconfig        |  27 +
 arch/powerpc/platforms/pseries/Makefile       |   2 +
 arch/powerpc/platforms/pseries/plpks/Makefile |   9 +
 .../pseries/plpks/fwsecurityfs_arch.c         |  16 +
 .../platforms/pseries/plpks/internal.h        |  18 +
 arch/powerpc/platforms/pseries/plpks/plpks.c  | 517 ++++++++++++++++++
 .../powerpc/platforms/pseries/plpks/secvars.c | 239 ++++++++
 fs/Kconfig                                    |   1 +
 fs/Makefile                                   |   1 +
 fs/fwsecurityfs/Kconfig                       |  14 +
 fs/fwsecurityfs/Makefile                      |  10 +
 fs/fwsecurityfs/inode.c                       | 159 ++++++
 fs/fwsecurityfs/internal.h                    |  13 +
 fs/fwsecurityfs/super.c                       | 154 ++++++
 include/linux/fwsecurityfs.h                  |  33 ++
 include/uapi/linux/magic.h                    |   1 +
 18 files changed, 1317 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/plpks.h
 create mode 100644 arch/powerpc/platforms/pseries/plpks/Makefile
 create mode 100644 arch/powerpc/platforms/pseries/plpks/fwsecurityfs_arch.c
 create mode 100644 arch/powerpc/platforms/pseries/plpks/internal.h
 create mode 100644 arch/powerpc/platforms/pseries/plpks/plpks.c
 create mode 100644 arch/powerpc/platforms/pseries/plpks/secvars.c
 create mode 100644 fs/fwsecurityfs/Kconfig
 create mode 100644 fs/fwsecurityfs/Makefile
 create mode 100644 fs/fwsecurityfs/inode.c
 create mode 100644 fs/fwsecurityfs/internal.h
 create mode 100644 fs/fwsecurityfs/super.c
 create mode 100644 include/linux/fwsecurityfs.h

-- 
2.27.0
