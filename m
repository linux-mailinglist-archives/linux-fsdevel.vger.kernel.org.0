Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29FC3BB560
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGEDUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:20:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21421 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhGEDUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:20:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210705031725epoutp03548aeabee508015594c640f14a02282d~OxsBsJxMS0096500965epoutp03K
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jul 2021 03:17:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210705031725epoutp03548aeabee508015594c640f14a02282d~OxsBsJxMS0096500965epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625455045;
        bh=4DtuUE9FCucXlBU9YqQtf8aJYHhz10E9bdPyAE82vP0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LQ1zu8QjUqkzjrBWuKJkTTbrB9Cddo6cGGgg6Iat7pHKejCvrrXxQDQIiZbRenmud
         V+HWH4yeU3li2lhUnrItPYP+PbJPlLZ/GKh3W/0PGrETA/ZI6ZZKAtpBwAvlkgSsIv
         YJWf6nl2KjAvfPDd8o0f64ncymBLUAk1aKAGQONE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210705031724epcas1p36c18c641a6197e35fdbfe2864e7e69dc~OxsA1tQmk1286612866epcas1p3k;
        Mon,  5 Jul 2021 03:17:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GJ9pq2PZ8z4x9Pw; Mon,  5 Jul
        2021 03:17:23 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.4E.10119.2C972E06; Mon,  5 Jul 2021 12:17:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031722epcas1p23795e20355b58decddc9bcacd79ea063~Oxr-Pyi0R1374013740epcas1p2-;
        Mon,  5 Jul 2021 03:17:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705031722epsmtrp225dd03c9a8a719ea90b87fd37b495ce8~Oxr-O2uCJ1726817268epsmtrp2u;
        Mon,  5 Jul 2021 03:17:22 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-e6-60e279c23341
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.AB.08394.2C972E06; Mon,  5 Jul 2021 12:17:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031722epsmtip2efddb1e2c91a3e0c490a1d4611e41969~Oxr_6dAuG2370723707epsmtip2M;
        Mon,  5 Jul 2021 03:17:22 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        willy@infradead.org, hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 00/13] ksmbd: introduce new SMB3 kernel server
Date:   Mon,  5 Jul 2021 12:07:16 +0900
Message-Id: <20210705030729.10292-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmru7hykcJBhv/MFk0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZnP97nNXi9485bA5CHn/nfmT2mN1wkcVj56y77B6bV2h57F7w
        mclj980GNo+PT2+xePRtWcXosWXxQyaP9Vuusnh83iTnsenJW6YAnqgcm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg55QUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZ087YF7zYyVjxfr9f
        A+PcTsYuRk4OCQETiYNfzrB1MXJxCAnsYJSYevUeO4TziVFi6cPbLCBVQgLfGCX235OB6bj8
        aRozRNFeRomWd0eY4Tper1kKNIuDg01AW+LPFlGQBhGBWIkbO16D1TALfGGS2PB3PjtIQljA
        UWLPti9gd7AIqEocOjMZzOYVsJGYc2IpC8Q2eYnVGw6ANUsIbOGQuD77BBtEwkXixs6DUE8I
        S7w6voUdwpaS+PxuL1RNucSJk7+YIOwaiQ3z9rGDHCchYCzR86IExGQW0JRYv0sfokJRYufv
        uWATmQX4JN597WGFqOaV6GgTgihRlei7dBhqoLREV/sHqKUeEs+vH2eHhFWsxJy3d9gmMMrO
        QliwgJFxFaNYakFxbnpqsWGBCXIcbWIEp1ctix2Mc99+0DvEyMTBeIhRgoNZSYQ3dN69BCHe
        lMTKqtSi/Pii0pzU4kOMpsDgmsgsJZqcD0zweSXxhqZGxsbGFiZm5mamxkrivDvZDiUICaQn
        lqRmp6YWpBbB9DFxcEo1MDX7L1aUfVzxcllet6ji9PMKrqKLV5jpfPR9mdjqLLdNU31mjR3n
        JddDyRJpTzap5vXPXnkvwGrpuRJPzh3J5atuujzQfh15pWCK6zLHQ5/W/D8+//HHBPm9XyyN
        5tke5ubo4j6obaAe9n1fKVtiec/+zT4vBc/ra5zRu8zdfviynpNQWk+yruH/540xl+VK25jb
        WYveX9l5eW7Q2bSts0Vss3fuDN/hpjEpS6i+8FCUn49B1TWD6em6tRXT2N9beeUwL4uolVmS
        ZvGSLddeyf+h8kwF/dRTSVszo2acFRGasVCXQ+eeRp315J1RqnuSruVoXGWsuS0VHSE4z8fK
        e2eS+PdynRk31u0NnhepxFKckWioxVxUnAgAtarawTgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO6hykcJBuc3S1s0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZnP97nNXi9485bA5CHn/nfmT2mN1wkcVj56y77B6bV2h57F7w
        mclj980GNo+PT2+xePRtWcXosWXxQyaP9Vuusnh83iTnsenJW6YAnigum5TUnMyy1CJ9uwSu
        jGln7Ate7GSseL/fr4FxbidjFyMnh4SAicTlT9OYuxi5OIQEdjNK7LzVxQSRkJY4duIMUIID
        yBaWOHy4GKLmA6PEylntrCBxNgFtiT9bREHKRQTiJW423GYBqWEWaGOWmPf4ABtIQljAUWLP
        ti9gy1gEVCUOnZkMZvMK2EjMObGUBWKXvMTqDQeYJzDyLGBkWMUomVpQnJueW2xYYJiXWq5X
        nJhbXJqXrpecn7uJERzwWpo7GLev+qB3iJGJg/EQowQHs5IIb+i8ewlCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MCm/2RV5JHzrPt2Jbxs+tU8UuRb3
        Xk5J4EZb19mP4R9ipctZl92auc0v7gTTR5uvfJdvWRj2bGsRNdio9r3048093Ebr7xc/fZlc
        oZU42V00dfOZQxFGvKwxy398Dqzt0UlZuPFlfH102+slS2+eW+Dz3upT0sVtFrw3/2VqTzTZ
        OKv5//qnfeErrRbtcVhf9m3Fu9OMAX3XjzgvWMusYrE1qHVJ+eE6sZqZFT8LZnT87D+hoSz7
        ZL3jzNVx3neXCoiWGTbVzn9hf3Gp8sYvnI8Dtr5ubX07e8ea3pJfcUveh1ZYvuhzfvtwxzmG
        6xkWbmeX9zzt5Z2z70nwea+c1z2fKpwXRiu82PtYaffkvKI/SizFGYmGWsxFxYkADLOTtecC
        AAA=
X-CMS-MailID: 20210705031722epcas1p23795e20355b58decddc9bcacd79ea063
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705031722epcas1p23795e20355b58decddc9bcacd79ea063
References: <CGME20210705031722epcas1p23795e20355b58decddc9bcacd79ea063@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the patch series for ksmbd kernel server.

What is ksmbd ?
===============

The SMB family of protocols is the most widely deployed
network filesystem protocol, the default on Windows and Macs (and even
on many phones and tablets), with clients and servers on all major
operating systems, but lacked a kernel server for Linux. For many
cases the current userspace server choices were suboptimal
either due to memory footprint, performance or difficulty integrating
well with advanced Linux features.

ksmbd is a new kernel module which implements the server-side of the SMB3 protocol.
The target is to provide optimized performance, GPLv2 SMB server, better
lease handling (distributed caching). The bigger goal is to add new
features more rapidly (e.g. RDMA aka "smbdirect", and recent encryption
and signing improvements to the protocol) which are easier to develop
on a smaller, more tightly optimized kernel server than for example
in Samba.  The Samba project is much broader in scope (tools, security services,
LDAP, Active Directory Domain Controller, and a cross platform file server
for a wider variety of purposes) but the user space file server portion
of Samba has proved hard to optimize for some Linux workloads, including
for smaller devices. This is not meant to replace Samba, but rather be
an extension to allow better optimizing for Linux, and will continue to
integrate well with Samba user space tools and libraries where appropriate.
Working with the Samba team we have already made sure that the configuration
files and xattrs are in a compatible format between the kernel and
user space server.


Architecture
============

               |--- ...
       --------|--- ksmbd/3 - Client 3
       |-------|--- ksmbd/2 - Client 2
       |       |         ____________________________________________________
       |       |        |- Client 1                                          |
<--- Socket ---|--- ksmbd/1   <<= Authentication : NTLM/NTLM2, Kerberos      |
       |       |      | |     <<= SMB engine : SMB2, SMB2.1, SMB3, SMB3.0.2, |
       |       |      | |                SMB3.1.1                            |
       |       |      | |____________________________________________________|
       |       |      |
       |       |      |--- VFS --- Local Filesystem
       |       |
KERNEL |--- ksmbd/0(forker kthread)
---------------||---------------------------------------------------------------
USER           ||
               || communication using NETLINK
               ||  ______________________________________________
               || |                                              |
        ksmbd.mountd <<= DCE/RPC(srvsvc, wkssvc, samr, lsarpc)   |
               ^  |  <<= configure shares setting, user accounts |
               |  |______________________________________________|
               |
               |------ smb.conf(config file)
               |
               |------ ksmbdpwd.db(user account/password file)
                            ^
  ksmbd.adduser ------------|

The subset of performance related operations(open/read/write/close etc.) belong
in kernelspace(ksmbd) and the other subset which belong to operations(DCE/RPC,
user account/share database) which are not really related with performance are
handled in userspace(ksmbd.mountd).

When the ksmbd.mountd is started, It starts up a forker thread at initialization
time and opens a dedicated port 445 for listening to SMB requests. Whenever new
clients make request, Forker thread will accept the client connection and fork
a new thread for dedicated communication channel between the client and
the server.


ksmbd feature status
====================

============================== =================================================
Feature name                   Status
============================== =================================================
Dialects                       Supported. SMB2.1 SMB3.0, SMB3.1.1 dialects
                               (intentionally excludes security vulnerable SMB1 dialect).
Auto Negotiation               Supported.
Compound Request               Supported.
Oplock Cache Mechanism         Supported.
SMB2 leases(v1 lease)          Supported.
Directory leases(v2 lease)     Planned for future.
Multi-credits                  Supported.
NTLM/NTLMv2                    Supported.
HMAC-SHA256 Signing            Supported.
Secure negotiate               Supported.
Signing Update                 Supported.
Pre-authentication integrity   Supported.
SMB3 encryption(CCM, GCM)      Supported. (CCM and GCM128 supported, GCM256 in progress)
SMB direct(RDMA)               Partially Supported. SMB3 Multi-channel is required
                               to connect to Windows client.
SMB3 Multi-channel             In Progress.
SMB3.1.1 POSIX extension       Supported.
ACLs                           Partially Supported. only DACLs available, SACLs
                               (auditing) is planned for the future. For
                               ownership (SIDs) ksmbd generates random subauth
                               values(then store it to disk) and use uid/gid
                               get from inode as RID for local domain SID.
                               The current acl implementation is limited to
                               standalone server, not a domain member.
                               Integration with Samba tools is being worked on to
                               allow future support for running as a domain member.
Kerberos                       Supported.
Durable handle v1,v2           Planned for future.
Persistent handle              Planned for future.
SMB2 notify                    Planned for future.
Sparse file support            Supported.
DCE/RPC support                Partially Supported. a few calls(NetShareEnumAll,
                               NetServerGetInfo, SAMR, LSARPC) that are needed 
                               for file server handled via netlink interface from
                               ksmbd.mountd. Additional integration with Samba
                               tools and libraries via upcall is being investigated
                               to allow support for additional DCE/RPC management
                               calls (and future support for Witness protocol e.g.)
ksmbd/nfsd interoperability    Planned for future. The features that ksmbd
                               support are Leases, Notify, ACLs and Share modes.
============================== =================================================

All features required as file server are currently implemented in ksmbd.
In particular, the implementation of SMB Direct(RDMA) is only currently
possible with ksmbd (among Linux servers)


Stability
=========

It has been proved to be stable. A significant amount of xfstests pass and
are run regularly from Linux to Linux:

  http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/49

In addition regression tests using the broadest SMB3 functional test suite
(Samba's "smbtorture") are run on every checkin. 
It has already been used by many other open source toolkits and commercial companies
that need NAS functionality. Their issues have been fixed and contributions are
applied into ksmbd. Ksmbd has been well tested and verified in the field and market.


Mailing list and repositories
=============================
 - linux-cifsd-devel@lists.sourceforge.net
 - https://github.com/smfrench/smb3-kernel/tree/cifsd-for-next
 - https://github.com/cifsd-team/ksmbd (out-of-tree)
 - https://github.com/cifsd-team/ksmbd-tools


How to run ksmbd 
================

   a. Download ksmbd-tools and compile them.
	- https://github.com/cifsd-team/ksmbd-tools

   b. Create user/password for SMB share.

	# mkdir /etc/ksmbd/
	# ksmbd.adduser -a <Enter USERNAME for SMB share access>

   c. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
	- Refer smb.conf.example and Documentation/configuration.txt
	  in ksmbd-tools

   d. Insert ksmbd.ko module

	# insmod ksmbd.ko

   e. Start ksmbd user space daemon
	# ksmbd.mountd

   f. Access share from Windows or Linux using SMB 
       e.g. "mount -t cifs //server/share /mnt ..."


v5:
 - fix list_add double add BUG_ON trap in setup_async_work().
 - set epoch in smb2_lease_break response.
 - fix possible compile error for asn1.c.
 - remove duplicated argument. (Wan Jiabing)
 - append ksmbd prefix into names for asn1 decoder.
 - fix kfree of uninitialized pointer oid. (Colin Ian King)
 - add support for SMB3 multichannel.
 - remove cache read/trans buffer support. (Christoph Hellwig)
 - initialize variables on the declaration. (Christoph Hellwig)
 - remove ksmbd_vfs_copy_file_range. (Christoph Hellwig)
 - use list_for_each_entry instead of list_for_each. (Christoph Hellwig)
 - use goto instead of duplicating the resoure cleanup in ksmbd_open_fd. (Christoph Hellwig)
 - fix overly long line. (Christoph Hellwig)
 - remove unneeded FIXME comment. (Christoph Hellwig)
 - remove ____ksmbd_align in ksmbd_server.h. (Christoph Hellwig)
 - replace KSMBD_SHARE_CONFIG_PATH with inline function. (Christoph Hellwig)
 - remove ksmbd_err/info. (Christoph Hellwig)
 - opencode to avoid trivial wrappers. (Christoph Hellwig)
 - factor out a ksmbd_validate_entry_in_use helper from __ksmbd_vfs_rename. (Christoph Hellwig)
 - opencode posix acl functions instead of wrappers. (Christoph Hellwig)
 - change stream type macro to enumeration. (Christoph Hellwig)
 - use f_bsize instead of q->limits.logical_block_size. (Christoph Hellwig)
 - remove unneeded NULL check in the list iterator. (Dan Carpenter)
 - use f_bsize in FS_SECTOR_SIZE_INFORMATION. (Christoph Hellwig)
 - move fs/cifsd to fs/ksmbd. (Christoph Hellwig)
 - factor out a ksmbd_vfs_lock_parent helper. (Christoph Hellwig)
 - set MAY_* flags together with open flags. (Christoph Hellwig)
 - reorder and document on-disk strctures and netlink structure in headers. (Christoph Hellwig)
 - remove macros in transport_ipc.c.
 - replace BUFFER_NR_PAGES with inline function.
 - replace KSMBD_ALIGN with kernel ALIGN macro.
 - replace PAYLOAD_HEAD with inline function.
 - remove getting worker state macros.
 - remove and replace macros with inline functions in smb_common.h. (Christoph Hellwig)
 - replace SMB_DIRECT_TRANS macro with inline function. (Christoph Hellwig)
 - replace request and respone buffer macro with inline functions. (Christoph Hellwig)
 - allow PROTECTED_DACL_SECINFO and UNPROTECTED_DACL_SECINFO addition information.
 - replace fp macros with inline functions.
 - relax credit_charge check in smb2_validate_credit_charge(). (Marios Makassikis).
 - add user namespace support. (Christoph Hellwig)

v4:
 - add goto fail in asn1_oid_decode() (Dan Carpenter)
 - use memcmp instead of for loop check in oid_eq(). (Dan Carpenter)
 - add goto fail in neg_token_init_mech_type(). (Dan Carpenter)
 - move fips_enabled check before the str_to_key(). (Dan Carpenter)
 - just return smbhash() instead of using rc return value. (Dan Carpenter)
 - move ret check before the out label. (Dan Carpenter)
 - simplify error handling in ksmbd_auth_ntlm(). (Dan Carpenter)
 - remove unneeded type casting. (Dan Carpenter)
 - set error return value for memcmp() difference. (Dan Carpenter)
 - return zero in always success case. (Dan Carpenter)
 - never return 1 on failure. (Dan Carpenter)
 - add the check if nvec is zero. (Dan Carpenter)
 - len can never be negative in ksmbd_init_sg(). (Dan Carpenter)
 - remove unneeded initialization of rc variable in ksmbd_crypt_message(). (Dan Carpenter)
 - fix wrong return value in ksmbd_crypt_message(). (Dan Carpenter)
 - change success handling to failure handling. (Dan Carpenter)
 - add default case in switch statment in alloc_shash_desc().(Dan Carpenter)
 - call kzalloc() directly instead of wrapper. (Dan Carpenter)
 - simplify error handling in ksmbd_gen_preauth_integrity_hash(). (Dan Carpenter)
 - return -ENOMEM about error from ksmbd_crypto_ctx_find_xxx calls. (Dan Carpenter)
 - alignment match open parenthesis. (Dan Carpenter)
 - add the check to prevent potential overflow with smb_strtoUTF16() and
   UNICODE_LEN(). (Dan Carpenter)
 - braces {} should be used on all arms of this statement.
 - spaces preferred around that '/'.
 - don't use multiple blank lines.
 - No space is necessary after a cast.
 - Blank lines aren't necessary after an open brace '{'.
 - remove unnecessary parentheses around.
 - Prefer kernel type 'u16' over 'uint16_t'.
 - lookup a file with LOOKUP_FOLLOW only if 'follow symlinks = yes'.
 - fix Control flow issues in ksmbd_build_ntlmssp_challenge_blob().
 - fix memleak in ksmbd_vfs_stream_write(). (Yang Yingliang)
 - fix memleak in ksmbd_vfs_stream_read(). (Yang Yingliang)
 - check return value of ksmbd_vfs_getcasexattr() correctly.
 - fix potential read overflow in ksmbd_vfs_stream_read().

v3:
 - fix boolreturn.cocci warnings. (kernel test robot)
 - fix xfstests generic/504 test failure.
 - do not use 0 or 0xFFFFFFFF for TreeID. (Marios Makassikis)
 - add support for FSCTL_DUPLICATE_EXTENTS_TO_FILE.
 - fix build error without CONFIG_OID_REGISTRY. (Wei Yongjun)
 - fix invalid memory access in smb2_write(). (Coverity Scan)
 - add support for AES256 encryption.
 - fix potential null-ptr-deref in destroy_previous_session(). (Marios Makassikis).
 - update out_buf_len in smb2_populate_readdir_entry(). (Marios Makassikis)
 - handle ksmbd_session_rpc_open() failure in create_smb2_pipe(). (Marios Makassikis)
 - call smb2_set_err_rsp() in smb2_read/smb2_write error path. (Marios Makassikis)
 - add ksmbd/nfsd interoperability to feature table. (Amir Goldstein)
 - fix regression in smb2_get_info. (Sebastian Gottschall)
 - remove is_attributes_write_allowed() wrapper. (Marios Makassikis)
 - update access check in set_file_allocation_info/set_end_of_file_info. (Marios Makassikis)

v2:
 - fix an error code in smb2_read(). (Dan Carpenter)
 - fix error handling in ksmbd_server_init() (Dan Carpenter)
 - remove redundant assignment to variable err. (Colin Ian King)
 - remove unneeded macros.
 - fix wrong use of rw semaphore in __session_create().
 - use kmalloc() for small allocations.
 - add the check to work file lock and rename behaviors like Windows
   unless POSIX extensions are negotiated.
 - clean-up codes using chechpatch.pl --strict.
 - merge time_wrappers.h into smb_common.h.
 - fix wrong prototype in comment (kernel test robot).
 - fix implicit declaration of function 'groups_alloc' (kernel test robot).
 - fix implicit declaration of function 'locks_alloc_lock' (kernel test robot).
 - remove smack inherit leftovers.
 - remove calling d_path in error paths.
 - handle unhashed dentry in ksmbd_vfs_mkdir.
 - use file_inode() instead of d_inode().
 - remove useless error handling in ksmbd_vfs_read.
 - use xarray instead of linked list for tree connect list.
 - remove stale prototype and variables.
 - fix memory leak when loop ends (coverity-bot, Muhammad Usama Anjum).
 - use kfree to free memory allocated by kmalloc or kzalloc (Muhammad Usama Anjum).
 - fix memdup.cocci warnings (kernel test robot)
 - remove wrappers of kvmalloc/kvfree.
 - change the reference to configuration.txt (Mauro Carvalho Chehab).
 - prevent a integer overflow in wm_alloc().
 - select SG_POOL for SMB_SERVER_SMBDIRECT. (Zhang Xiaoxu).
 - remove unused including <linux/version.h> (Tian Tao).
 - declare ida statically.
 - add the check if parent is stable by unexpected rename.
 - get parent dentry from child in ksmbd_vfs_remove_file().
 - re-implement ksmbd_vfs_kern_path.
 - fix reference count decrement of unclaimed file in __ksmbd_lookup_fd.
 - remove smb2_put_name(). (Marios Makassikis).
 - remove unused smberr.h, nterr.c and netmisc.c.
 - fix potential null-ptr-deref in smb2_open() (Marios Makassikis).
 - use d_inode().
 - remove the dead code of unimplemented durable handle.
 - use the generic one in lib/asn1_decoder.c

v1:
 - fix a handful of spelling mistakes (Colin Ian King)
 - fix a precedence bug in parse_dacl() (Dan Carpenter)
 - fix a IS_ERR() vs NULL bug (Dan Carpenter)
 - fix a use after free on error path  (Dan Carpenter)
 - update cifsd.rst Documentation
 - remove unneeded FIXME comments
 - fix static checker warnings (Dan Carpenter)
 - fix WARNING: unmet direct dependencies detected for CRYPTO_ARC4 (Randy Dunlap)
 - uniquify extract_sharename() (Stephen Rothwell)
 - fix WARNING: document isn't included in any toctree (Stephen Rothwell)
 - fix WARNING: Title overline too short (Stephen Rothwell)
 - fix warning: variable 'total_ace_size' and 'posix_ccontext'set but not used (kernel test rotbot)
 - fix incorrect function comments (kernel test robot)

Namjae Jeon (13):
  ksmbd: add document
  ksmbd: add server handler
  ksmbd: add tcp transport layer
  ksmbd: add ipc transport layer
  ksmbd: add rdma transport layer
  ksmbd: add a utility code that tracks (and caches) sessions data
  ksmbd: add authentication
  ksmbd: add smb3 engine part 1
  ksmbd: add smb3 engine part 2
  ksmbd: add oplock/lease cache mechanism
  ksmbd: add file operations
  ksmbd: add Kconfig and Makefile
  MAINTAINERS: add ksmbd kernel server

 Documentation/filesystems/cifs/index.rst |   10 +
 Documentation/filesystems/cifs/ksmbd.rst |  164 +
 Documentation/filesystems/index.rst      |    2 +-
 MAINTAINERS                              |    9 +
 fs/Kconfig                               |    1 +
 fs/Makefile                              |    1 +
 fs/ksmbd/Kconfig                         |   69 +
 fs/ksmbd/Makefile                        |   20 +
 fs/ksmbd/asn1.c                          |  343 +
 fs/ksmbd/asn1.h                          |   21 +
 fs/ksmbd/auth.c                          | 1364 ++++
 fs/ksmbd/auth.h                          |   67 +
 fs/ksmbd/connection.c                    |  409 ++
 fs/ksmbd/connection.h                    |  205 +
 fs/ksmbd/crypto_ctx.c                    |  282 +
 fs/ksmbd/crypto_ctx.h                    |   74 +
 fs/ksmbd/glob.h                          |   49 +
 fs/ksmbd/ksmbd_netlink.h                 |  395 ++
 fs/ksmbd/ksmbd_spnego_negtokeninit.asn1  |   31 +
 fs/ksmbd/ksmbd_spnego_negtokentarg.asn1  |   19 +
 fs/ksmbd/ksmbd_work.c                    |   80 +
 fs/ksmbd/ksmbd_work.h                    |  117 +
 fs/ksmbd/mgmt/ksmbd_ida.c                |   46 +
 fs/ksmbd/mgmt/ksmbd_ida.h                |   34 +
 fs/ksmbd/mgmt/share_config.c             |  238 +
 fs/ksmbd/mgmt/share_config.h             |   81 +
 fs/ksmbd/mgmt/tree_connect.c             |  121 +
 fs/ksmbd/mgmt/tree_connect.h             |   56 +
 fs/ksmbd/mgmt/user_config.c              |   69 +
 fs/ksmbd/mgmt/user_config.h              |   66 +
 fs/ksmbd/mgmt/user_session.c             |  369 +
 fs/ksmbd/mgmt/user_session.h             |  106 +
 fs/ksmbd/misc.c                          |  338 +
 fs/ksmbd/misc.h                          |   35 +
 fs/ksmbd/ndr.c                           |  338 +
 fs/ksmbd/ndr.h                           |   22 +
 fs/ksmbd/nterr.h                         |  543 ++
 fs/ksmbd/ntlmssp.h                       |  169 +
 fs/ksmbd/oplock.c                        | 1708 +++++
 fs/ksmbd/oplock.h                        |  131 +
 fs/ksmbd/server.c                        |  633 ++
 fs/ksmbd/server.h                        |   70 +
 fs/ksmbd/smb2misc.c                      |  433 ++
 fs/ksmbd/smb2ops.c                       |  308 +
 fs/ksmbd/smb2pdu.c                       | 8289 ++++++++++++++++++++++
 fs/ksmbd/smb2pdu.h                       | 1684 +++++
 fs/ksmbd/smb_common.c                    |  657 ++
 fs/ksmbd/smb_common.h                    |  545 ++
 fs/ksmbd/smbacl.c                        | 1339 ++++
 fs/ksmbd/smbacl.h                        |  212 +
 fs/ksmbd/smbfsctl.h                      |   91 +
 fs/ksmbd/smbstatus.h                     | 1822 +++++
 fs/ksmbd/transport_ipc.c                 |  874 +++
 fs/ksmbd/transport_ipc.h                 |   47 +
 fs/ksmbd/transport_rdma.c                | 2045 ++++++
 fs/ksmbd/transport_rdma.h                |   61 +
 fs/ksmbd/transport_tcp.c                 |  619 ++
 fs/ksmbd/transport_tcp.h                 |   13 +
 fs/ksmbd/unicode.c                       |  384 +
 fs/ksmbd/unicode.h                       |  357 +
 fs/ksmbd/uniupr.h                        |  268 +
 fs/ksmbd/vfs.c                           | 1898 +++++
 fs/ksmbd/vfs.h                           |  197 +
 fs/ksmbd/vfs_cache.c                     |  709 ++
 fs/ksmbd/vfs_cache.h                     |  178 +
 fs/ksmbd/xattr.h                         |  122 +
 66 files changed, 32056 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/cifs/index.rst
 create mode 100644 Documentation/filesystems/cifs/ksmbd.rst
 create mode 100644 fs/ksmbd/Kconfig
 create mode 100644 fs/ksmbd/Makefile
 create mode 100644 fs/ksmbd/asn1.c
 create mode 100644 fs/ksmbd/asn1.h
 create mode 100644 fs/ksmbd/auth.c
 create mode 100644 fs/ksmbd/auth.h
 create mode 100644 fs/ksmbd/connection.c
 create mode 100644 fs/ksmbd/connection.h
 create mode 100644 fs/ksmbd/crypto_ctx.c
 create mode 100644 fs/ksmbd/crypto_ctx.h
 create mode 100644 fs/ksmbd/glob.h
 create mode 100644 fs/ksmbd/ksmbd_netlink.h
 create mode 100644 fs/ksmbd/ksmbd_spnego_negtokeninit.asn1
 create mode 100644 fs/ksmbd/ksmbd_spnego_negtokentarg.asn1
 create mode 100644 fs/ksmbd/ksmbd_work.c
 create mode 100644 fs/ksmbd/ksmbd_work.h
 create mode 100644 fs/ksmbd/mgmt/ksmbd_ida.c
 create mode 100644 fs/ksmbd/mgmt/ksmbd_ida.h
 create mode 100644 fs/ksmbd/mgmt/share_config.c
 create mode 100644 fs/ksmbd/mgmt/share_config.h
 create mode 100644 fs/ksmbd/mgmt/tree_connect.c
 create mode 100644 fs/ksmbd/mgmt/tree_connect.h
 create mode 100644 fs/ksmbd/mgmt/user_config.c
 create mode 100644 fs/ksmbd/mgmt/user_config.h
 create mode 100644 fs/ksmbd/mgmt/user_session.c
 create mode 100644 fs/ksmbd/mgmt/user_session.h
 create mode 100644 fs/ksmbd/misc.c
 create mode 100644 fs/ksmbd/misc.h
 create mode 100644 fs/ksmbd/ndr.c
 create mode 100644 fs/ksmbd/ndr.h
 create mode 100644 fs/ksmbd/nterr.h
 create mode 100644 fs/ksmbd/ntlmssp.h
 create mode 100644 fs/ksmbd/oplock.c
 create mode 100644 fs/ksmbd/oplock.h
 create mode 100644 fs/ksmbd/server.c
 create mode 100644 fs/ksmbd/server.h
 create mode 100644 fs/ksmbd/smb2misc.c
 create mode 100644 fs/ksmbd/smb2ops.c
 create mode 100644 fs/ksmbd/smb2pdu.c
 create mode 100644 fs/ksmbd/smb2pdu.h
 create mode 100644 fs/ksmbd/smb_common.c
 create mode 100644 fs/ksmbd/smb_common.h
 create mode 100644 fs/ksmbd/smbacl.c
 create mode 100644 fs/ksmbd/smbacl.h
 create mode 100644 fs/ksmbd/smbfsctl.h
 create mode 100644 fs/ksmbd/smbstatus.h
 create mode 100644 fs/ksmbd/transport_ipc.c
 create mode 100644 fs/ksmbd/transport_ipc.h
 create mode 100644 fs/ksmbd/transport_rdma.c
 create mode 100644 fs/ksmbd/transport_rdma.h
 create mode 100644 fs/ksmbd/transport_tcp.c
 create mode 100644 fs/ksmbd/transport_tcp.h
 create mode 100644 fs/ksmbd/unicode.c
 create mode 100644 fs/ksmbd/unicode.h
 create mode 100644 fs/ksmbd/uniupr.h
 create mode 100644 fs/ksmbd/vfs.c
 create mode 100644 fs/ksmbd/vfs.h
 create mode 100644 fs/ksmbd/vfs_cache.c
 create mode 100644 fs/ksmbd/vfs_cache.h
 create mode 100644 fs/ksmbd/xattr.h

-- 
2.17.1

