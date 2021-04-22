Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16836764B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbhDVAjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:39:13 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40601 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhDVAjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:39:12 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210422003837epoutp017f65f81eeb2aece3d74fb461828a2f68~4ByQRS_i21755917559epoutp01s
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 00:38:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210422003837epoutp017f65f81eeb2aece3d74fb461828a2f68~4ByQRS_i21755917559epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619051917;
        bh=QESwoHRTPFqJRs9XUAeL7/T3DFC29aEbLZHyoK/v5Vw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FAX9WDGgVxjR089BXyhfz7efVOMwuHKNNnt51R+bKp+cWZbo5afgMb7wBLm5zMWw8
         IsvT8XHnsj0Ndjlnd6TB0VYybfw2uo4Kq4vMoYuRE6fs3WifRrgMNtUsgLaGaIsCsA
         PLgXIaY9sJynZ3QTraNRlIRiQCmZ+0PUCcXPTaFs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210422003836epcas1p195b2b8435238c8bfc94c2d300aafe3ee~4ByPvI7Et0643506435epcas1p1H;
        Thu, 22 Apr 2021 00:38:36 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FQdnl6cCmz4x9Pw; Thu, 22 Apr
        2021 00:38:35 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.42.09578.B85C0806; Thu, 22 Apr 2021 09:38:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7~4ByOMscX02421024210epcas1p2N;
        Thu, 22 Apr 2021 00:38:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210422003835epsmtrp2ae5e14653a4575c8be9a186ef2487034~4ByOLT2nf1951619516epsmtrp2P;
        Thu, 22 Apr 2021 00:38:35 +0000 (GMT)
X-AuditID: b6c32a35-fb9ff7000000256a-51-6080c58b42a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.BA.08637.B85C0806; Thu, 22 Apr 2021 09:38:35 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210422003834epsmtip14654362f65e6f739be77df0492227629~4ByN3c-wv1957719577epsmtip1K;
        Thu, 22 Apr 2021 00:38:34 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
Date:   Thu, 22 Apr 2021 09:28:14 +0900
Message-Id: <20210422002824.12677-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmvm730YYEg0sPjS0a355msTj++i+7
        xe/VvWwWr/9NZ7E4PWERk8XK1UeZLK7df89usWfvSRaLy7vmsFn8mF5v8fYOUEVv3ydWi9Yr
        Wha7Ny5is3jz4jCbxfm/x1ktfv+Yw+Yg6DGroZfNY3bDRRaPnbPusntsXqHlsftmA5vHx6e3
        WDz6tqxi9Niy+CGTx/otV1k8Pm+S89j05C1TAHdUjk1GamJKapFCal5yfkpmXrqtkndwvHO8
        qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0E9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul
        1IKUnAJDgwK94sTc4tK8dL3k/FwrQwMDI1OgyoScjLPvOpgLNnUzVjTfX8/cwHgoqYuRk0NC
        wETi0JENbF2MXBxCAjsYJS5/2cIK4XxilFjQsIMdwvnGKLHixEcWmJZLKw8xQiT2MkrcW3Of
        Ea5ld8MyoGEcHGwC2hJ/toiCmCIC9hK3F/uAlDALPGOSOPz3D9ggYQFHiUOvJjCD2CwCqhK/
        dp5gBLF5BWwk7uzqYYZYJi+xesMBZpBmCYGFHBJ/5vRAXeEi8XLSMzYIW1ji1fEt7BC2lMTn
        d3vBbpAQqJb4uB9qTgejxIvvthC2scTN9RtYQUqYBTQl1u/ShwgrSuz8PRfsBGYBPol3X3tY
        IabwSnS0CUGUqEr0XTrMBGFLS3S1f4Ba6iFx+8E7sLiQQKzEl5a7bBMYZWchLFjAyLiKUSy1
        oDg3PbXYsMAQOZI2MYLTqZbpDsaJbz/oHWJk4mA8xCjBwawkwru2uCFBiDclsbIqtSg/vqg0
        J7X4EKMpMLgmMkuJJucDE3peSbyhqZGxsbGFiZm5mamxkjhvunN1gpBAemJJanZqakFqEUwf
        EwenVAPTqSkd+RsET0+uNdbecmTvHr6qf8amEXtj+HY537/aMDHj3MT15UYT4lUfnin9sSLj
        1P34gG1nBJ8s2C/1aCb3pRNRa3983fxd5dAMwVCuLYt/hvTvtTN1iFZ6syt2/tW9KyvCYp58
        MZPuyWmU2fIve0ZqyL6yLd9vTwhUUdq26H99bMismtKo7K7ml5L9gQ8lLk7d13HXTOlGg5Vv
        /dwdj1efmNPez266akbV79oDPa/umt6/NvvIg6cTVVetlEh+8PTTjT3KER8lmRqPh96RPxiv
        YftRf+ORq5MPJN54dqFBNvW/lWWgKmNnYvKsE+1vdi1nYNaR3tF/bP3dK+v965ZkZyctv//W
        0XeSkPPGYgElluKMREMt5qLiRADx9SDHMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnG730YYEg+797BaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e32LP3JIvF5V1z2Cx+TK+3eHsHqKK37xOrResV
        LYvdGxexWbx5cZjN4vzf46wWv3/MYXMQ9JjV0MvmMbvhIovHzll32T02r9Dy2H2zgc3j49Nb
        LB59W1YxemxZ/JDJY/2WqywenzfJeWx68pYpgDuKyyYlNSezLLVI3y6BK+Psuw7mgk3djBXN
        99czNzAeSupi5OSQEDCRuLTyEGMXIxeHkMBuRomDFxoYIRLSEsdOnGHuYuQAsoUlDh8uBgkL
        CXxglLh+TwMkzCagLfFniyhIWETAUeLE1EVgY5gFfjBJbHt2nwkkIQyUOPRqAjOIzSKgKvFr
        5wmw8bwCNhJ3dvUwQ6ySl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLz
        czcxgsNbS3MH4/ZVH/QOMTJxMB5ilOBgVhLhXVvckCDEm5JYWZValB9fVJqTWnyIUZqDRUmc
        90LXyXghgfTEktTs1NSC1CKYLBMHp1QDE7v0Dg9utuPRT06nrQ1fK6V3Y09JbGJkglkZJ0dC
        V+yxQrGVrP/ajx6T2+6/d5r6Hbk/NcvLIlSvl9ncbP4TrLDnUunSD+/UeO8tWxXNcD4viKv6
        knj2P+GjvGuySgOWXim7HLNYZuYFnnufNRokW2wuvlr8tnNyFL9nHKdPmgHn2edK1haaHgHR
        Gf8vcdWV8dZ8uCp0z+TWzw4WZ8FfvvUbruzVu/FEROXsnwUMsr++TC+ecVYy3UfS83KR9vc/
        zCwndAysk9oiGszE9VkNZomeLZjX/Yzd/fkczxmem8xti0vrmVZaVc5P/JhqVvnOgkkxKOzn
        +hRZ/8c/J/ZO/pl/J3jh9kln+Oztgi2UWIozEg21mIuKEwEeofQo3gIAAA==
X-CMS-MailID: 20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the patch series for cifsd(ksmbd) kernel server.

What is cifsd(ksmbd) ?
======================

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
  ksmbd.adduser ---------------|

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
============================== =================================================

All features required as file server are currently implemented in ksmbd.
In particular, the implementation of SMB Direct(RDMA) is only currently
possible with ksmbd (among Linux servers)


Stability
=========

It has been proved to be stable. A significant amount of xfstests pass and
are run regularly from Linux to Linux:

  http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/32

In addition regression tests using the broadest SMB3 functional test suite
(Samba's "smbtorture") are run on every checkin. 
It has already been used by many other open source toolkits and commercial companies
that need NAS functionality. Their issues have been fixed and contributions are
applied into ksmbd. Ksmbd has been well tested and verified in the field and market.


Mailing list and repositories
=============================
 - linux-cifsd-devel@lists.sourceforge.net
 - https://github.com/smfrench/smb3-kernel/tree/cifsd-for-next
 - https://github.com/cifsd-team/cifsd (out-of-tree)
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

Namjae Jeon (10):
  cifsd: add document
  cifsd: add server handler
  cifsd: add trasport layers
  cifsd: add authentication
  cifsd: add smb3 engine part 1
  cifsd: add smb3 engine part 2
  cifsd: add oplock/lease cache mechanism
  cifsd: add file operations
  cifsd: add Kconfig and Makefile
  MAINTAINERS: add cifsd kernel server

 Documentation/filesystems/cifs/cifsd.rst |  152 +
 Documentation/filesystems/cifs/index.rst |   10 +
 Documentation/filesystems/index.rst      |    2 +-
 MAINTAINERS                              |   12 +-
 fs/Kconfig                               |    1 +
 fs/Makefile                              |    1 +
 fs/cifsd/Kconfig                         |   67 +
 fs/cifsd/Makefile                        |   17 +
 fs/cifsd/asn1.c                          |  352 +
 fs/cifsd/asn1.h                          |   29 +
 fs/cifsd/auth.c                          | 1323 ++++
 fs/cifsd/auth.h                          |   90 +
 fs/cifsd/buffer_pool.c                   |  264 +
 fs/cifsd/buffer_pool.h                   |   20 +
 fs/cifsd/connection.c                    |  411 ++
 fs/cifsd/connection.h                    |  208 +
 fs/cifsd/crypto_ctx.c                    |  286 +
 fs/cifsd/crypto_ctx.h                    |   77 +
 fs/cifsd/glob.h                          |   64 +
 fs/cifsd/ksmbd_server.h                  |  283 +
 fs/cifsd/ksmbd_work.c                    |   93 +
 fs/cifsd/ksmbd_work.h                    |  110 +
 fs/cifsd/mgmt/ksmbd_ida.c                |   48 +
 fs/cifsd/mgmt/ksmbd_ida.h                |   34 +
 fs/cifsd/mgmt/share_config.c             |  239 +
 fs/cifsd/mgmt/share_config.h             |   81 +
 fs/cifsd/mgmt/tree_connect.c             |  122 +
 fs/cifsd/mgmt/tree_connect.h             |   56 +
 fs/cifsd/mgmt/user_config.c              |   70 +
 fs/cifsd/mgmt/user_config.h              |   66 +
 fs/cifsd/mgmt/user_session.c             |  328 +
 fs/cifsd/mgmt/user_session.h             |  103 +
 fs/cifsd/misc.c                          |  340 +
 fs/cifsd/misc.h                          |   44 +
 fs/cifsd/ndr.c                           |  347 +
 fs/cifsd/ndr.h                           |   21 +
 fs/cifsd/nterr.h                         |  545 ++
 fs/cifsd/ntlmssp.h                       |  169 +
 fs/cifsd/oplock.c                        | 1667 +++++
 fs/cifsd/oplock.h                        |  133 +
 fs/cifsd/server.c                        |  631 ++
 fs/cifsd/server.h                        |   60 +
 fs/cifsd/smb2misc.c                      |  435 ++
 fs/cifsd/smb2ops.c                       |  300 +
 fs/cifsd/smb2pdu.c                       | 8069 ++++++++++++++++++++++
 fs/cifsd/smb2pdu.h                       | 1646 +++++
 fs/cifsd/smb_common.c                    |  652 ++
 fs/cifsd/smb_common.h                    |  544 ++
 fs/cifsd/smbacl.c                        | 1317 ++++
 fs/cifsd/smbacl.h                        |  201 +
 fs/cifsd/smbfsctl.h                      |   90 +
 fs/cifsd/smbstatus.h                     | 1822 +++++
 fs/cifsd/spnego_negtokeninit.asn1        |   43 +
 fs/cifsd/spnego_negtokentarg.asn1        |   19 +
 fs/cifsd/transport_ipc.c                 |  881 +++
 fs/cifsd/transport_ipc.h                 |   54 +
 fs/cifsd/transport_rdma.c                | 2034 ++++++
 fs/cifsd/transport_rdma.h                |   61 +
 fs/cifsd/transport_tcp.c                 |  618 ++
 fs/cifsd/transport_tcp.h                 |   13 +
 fs/cifsd/unicode.c                       |  383 +
 fs/cifsd/unicode.h                       |  356 +
 fs/cifsd/uniupr.h                        |  268 +
 fs/cifsd/vfs.c                           | 1995 ++++++
 fs/cifsd/vfs.h                           |  273 +
 fs/cifsd/vfs_cache.c                     |  683 ++
 fs/cifsd/vfs_cache.h                     |  185 +
 67 files changed, 31916 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/filesystems/cifs/cifsd.rst
 create mode 100644 Documentation/filesystems/cifs/index.rst
 create mode 100644 fs/cifsd/Kconfig
 create mode 100644 fs/cifsd/Makefile
 create mode 100644 fs/cifsd/asn1.c
 create mode 100644 fs/cifsd/asn1.h
 create mode 100644 fs/cifsd/auth.c
 create mode 100644 fs/cifsd/auth.h
 create mode 100644 fs/cifsd/buffer_pool.c
 create mode 100644 fs/cifsd/buffer_pool.h
 create mode 100644 fs/cifsd/connection.c
 create mode 100644 fs/cifsd/connection.h
 create mode 100644 fs/cifsd/crypto_ctx.c
 create mode 100644 fs/cifsd/crypto_ctx.h
 create mode 100644 fs/cifsd/glob.h
 create mode 100644 fs/cifsd/ksmbd_server.h
 create mode 100644 fs/cifsd/ksmbd_work.c
 create mode 100644 fs/cifsd/ksmbd_work.h
 create mode 100644 fs/cifsd/mgmt/ksmbd_ida.c
 create mode 100644 fs/cifsd/mgmt/ksmbd_ida.h
 create mode 100644 fs/cifsd/mgmt/share_config.c
 create mode 100644 fs/cifsd/mgmt/share_config.h
 create mode 100644 fs/cifsd/mgmt/tree_connect.c
 create mode 100644 fs/cifsd/mgmt/tree_connect.h
 create mode 100644 fs/cifsd/mgmt/user_config.c
 create mode 100644 fs/cifsd/mgmt/user_config.h
 create mode 100644 fs/cifsd/mgmt/user_session.c
 create mode 100644 fs/cifsd/mgmt/user_session.h
 create mode 100644 fs/cifsd/misc.c
 create mode 100644 fs/cifsd/misc.h
 create mode 100644 fs/cifsd/ndr.c
 create mode 100644 fs/cifsd/ndr.h
 create mode 100644 fs/cifsd/nterr.h
 create mode 100644 fs/cifsd/ntlmssp.h
 create mode 100644 fs/cifsd/oplock.c
 create mode 100644 fs/cifsd/oplock.h
 create mode 100644 fs/cifsd/server.c
 create mode 100644 fs/cifsd/server.h
 create mode 100644 fs/cifsd/smb2misc.c
 create mode 100644 fs/cifsd/smb2ops.c
 create mode 100644 fs/cifsd/smb2pdu.c
 create mode 100644 fs/cifsd/smb2pdu.h
 create mode 100644 fs/cifsd/smb_common.c
 create mode 100644 fs/cifsd/smb_common.h
 create mode 100644 fs/cifsd/smbacl.c
 create mode 100644 fs/cifsd/smbacl.h
 create mode 100644 fs/cifsd/smbfsctl.h
 create mode 100644 fs/cifsd/smbstatus.h
 create mode 100644 fs/cifsd/spnego_negtokeninit.asn1
 create mode 100644 fs/cifsd/spnego_negtokentarg.asn1
 create mode 100644 fs/cifsd/transport_ipc.c
 create mode 100644 fs/cifsd/transport_ipc.h
 create mode 100644 fs/cifsd/transport_rdma.c
 create mode 100644 fs/cifsd/transport_rdma.h
 create mode 100644 fs/cifsd/transport_tcp.c
 create mode 100644 fs/cifsd/transport_tcp.h
 create mode 100644 fs/cifsd/unicode.c
 create mode 100644 fs/cifsd/unicode.h
 create mode 100644 fs/cifsd/uniupr.h
 create mode 100644 fs/cifsd/vfs.c
 create mode 100644 fs/cifsd/vfs.h
 create mode 100644 fs/cifsd/vfs_cache.c
 create mode 100644 fs/cifsd/vfs_cache.h

-- 
2.17.1

