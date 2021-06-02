Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E310397FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 05:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhFBEAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:00:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:63395 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhFBEAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:00:00 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210602035816epoutp02d99a7c0a93d29111324a7bcc1156d67a~Ep9RiGDmn1707717077epoutp02Q
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 03:58:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210602035816epoutp02d99a7c0a93d29111324a7bcc1156d67a~Ep9RiGDmn1707717077epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622606296;
        bh=OBUF6dJK8b9cnFeRDGC6f3w5/HHk4PP6sg2gZPQNrHo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Yrsb2p7Ch3rtTTVefV4vwLpJQO0ZZu8KLA32UWgxZuku/MHeK10WUm3BjIJVs6eTA
         9mSz2u7E2ykpyk/PSUC7tuRUsDhg/KycYSlppkInaHtc3vVyD3AFstjzGSM/sIVXGc
         ZUwpiY0hrWhg8UrhoimkvhCUIw6oPdsStN4T8dNM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210602035815epcas1p25b70b0036ed4a9363fc82e07872d6ad7~Ep9QygEI73142031420epcas1p2h;
        Wed,  2 Jun 2021 03:58:15 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FvwHB3fbKz4x9Pt; Wed,  2 Jun
        2021 03:58:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.1B.09701.6D107B06; Wed,  2 Jun 2021 12:58:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210602035813epcas1p49ba4ff37fe4b784aa76dce67e4036227~Ep9PRLmp_2751027510epcas1p4C;
        Wed,  2 Jun 2021 03:58:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210602035813epsmtrp1631281eddcd23c86c3c0a3524784aae3~Ep9PQCy5E1583215832epsmtrp1E;
        Wed,  2 Jun 2021 03:58:13 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-26-60b701d6b698
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.B3.08163.5D107B06; Wed,  2 Jun 2021 12:58:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210602035813epsmtip2629cb77584f7dfc0a2201a9d550a7726~Ep9O_k2AL0074100741epsmtip2p;
        Wed,  2 Jun 2021 03:58:13 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, stfrench@microsoft.com, willy@infradead.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, hch@lst.de, dan.carpenter@oracle.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 00/10] cifsd: introduce new SMB3 kernel server
Date:   Wed,  2 Jun 2021 12:48:37 +0900
Message-Id: <20210602034847.5371-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmge41xu0JBgsPiFs0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBYv/u9itvj5/zujxZ69J1ksLu+aw2bxY3q9RW/fJ1aL1itaFrs3
        LmKzePPiMJvFrYnz2SzO/z3OavH7xxw2B0GP2Q0XWTx2zrrL7rF5hZbH7gWfmTx232xg82jd
        8Zfd4+PTWywefVtWMXpsWfyQyWP9lqssHp83yXlsevKWKYAnKscmIzUxJbVIITUvOT8lMy/d
        Vsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gxJYWyxJxSoFBAYnGxkr6dTVF+aUmq
        QkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsaL1dOZCx4sZaxY8mAhUwPj
        soouRg4OCQETibPPdboYOTmEBHYwSmyZ6t3FyAVkf2KU+P7oHjOE85lRovPmOXaYhrvP2CEa
        djFKvL2pB2EDNWx8wQRSwiagLfFniyhIWEQgVuLGjtdgY5gFHjJJTGx+zghSIyzgKNG0nwOk
        hkVAVWLd9p9sIDavgLXEokcLmEFsCQF5idUbDoD1Sgis5ZB4eGULC0TCReLBpk+MELawxKvj
        W9ghbCmJl/1tUHa5xImTv5gg7BqJDfP2QZ1vLNHzogTEZBbQlFi/Sx+iQlFi5++5YBOZBfgk
        3n3tYYWo5pXoaBOCKFGV6Lt0GGqgtERX+weoRR4SMzfcZIEEQqzEjKc/WScwys5CWLCAkXEV
        o1hqQXFuemqxYYERcvxsYgSnUy2zHYyT3n7QO8TIxMF4iFGCg1lJhNc9b2uCEG9KYmVValF+
        fFFpTmrxIUZTYHBNZJYSTc4HJvS8knhDUyNjY2MLEzNzM1NjJXHedOfqBCGB9MSS1OzU1ILU
        Ipg+Jg5OqQYmr/afZWFrkiQyy2RqvVgbE7UzA6/Nb2thP3gjuNNGuuUT93tVs0lrhLlkT8az
        +4mxe5w5UvPj6iVeBpHpq6ZeXdHE22v04tS7/xL9045fmP5QbNbhr15FU0RTnBwLF+5iWN/9
        YsUU3ZNPqve/Uzr/bTGzRan+Lo6v85pNn355ZSa8cNL7HK1nYpZiBdPm7HijKGRgeECRtUTj
        EEu07advpgcE9Hc+fXa9ULGfNc3Vbmuv1mkbvS+1xbMbPYOLbjqfYorKX3PlwXPJ1sgyfqc1
        5w5FHWbNTPJbfK1Ys0vUb+vEK5uE/luVloZ82PCrqk5z+TtVk/j/F58JC7HYvxbN2Ro3beP5
        LXn3T6zKu3BPiaU4I9FQi7moOBEAL9FT9zAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvO5Vxu0JBs1dBhaNb0+zWBx//Zfd
        4vW/6SwWpycsYrJYufook8WL/7uYLX7+/85osWfvSRaLy7vmsFn8mF5v0dv3idWi9YqWxe6N
        i9gs3rw4zGZxa+J8Novzf4+zWvz+MYfNQdBjdsNFFo+ds+6ye2xeoeWxe8FnJo/dNxvYPFp3
        /GX3+Pj0FotH35ZVjB5bFj9k8li/5SqLx+dNch6bnrxlCuCJ4rJJSc3JLEst0rdL4Mp4sXo6
        c8GDpYwVSx4sZGpgXFbRxcjBISFgInH3GXsXIyeHkMAORokNvXUgtoSAtMSxE2eYIUqEJQ4f
        Lu5i5AIq+cAocW7LEyaQOJuAtsSfLaIg5SIC8RI3G26zgNQwC3xmkjje9ZEVpEZYwFGiaT8H
        SA2LgKrEuu0/2UBsXgFriUWPFjBDrJKXWL3hAPMERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoT
        c4tL89L1kvNzNzGCg1xLawfjnlUf9A4xMnEwHmKU4GBWEuF1z9uaIMSbklhZlVqUH19UmpNa
        fIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTrCy5f/W8W76+8N3JcXvvD/aZn/u+
        NrIHuqy+7mAuesy5kUvK8uEZ5W+Oug6u3s0PbiWJBHHy8LokKJ4ymcZfdqE1JPKww/zJvDIH
        f1x4c2eGko+NrK36MZYr+zYv5zwaaNxl73z6/J8f3Mp6h5Zfeuev7Hd9c0Lyw3ct23b8DZpZ
        EfF3YllO3i1nFy57kWxL9ZL6kit75xZnp0a0Pj5xUyp8wsO9kx2KPx15c8w/6eD8IsbDDBq1
        IpxRvzwmsq7kL/227Y5E5qEgrmdip1xyXv/9ERKpvnn6n//MO3U0XIUjPsbG3bh5QPH4/W9c
        3h+OW+r2Rc07s0tL6o3oVunWhKAu6Wy7fc3sBuKxbWeVWIozEg21mIuKEwFr1xY34QIAAA==
X-CMS-MailID: 20210602035813epcas1p49ba4ff37fe4b784aa76dce67e4036227
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602035813epcas1p49ba4ff37fe4b784aa76dce67e4036227
References: <CGME20210602035813epcas1p49ba4ff37fe4b784aa76dce67e4036227@epcas1p4.samsung.com>
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

  http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/43

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

 Documentation/filesystems/cifs/cifsd.rst |  164 +
 Documentation/filesystems/cifs/index.rst |   10 +
 Documentation/filesystems/index.rst      |    2 +-
 MAINTAINERS                              |   12 +-
 fs/Kconfig                               |    1 +
 fs/Makefile                              |    1 +
 fs/cifsd/Kconfig                         |   68 +
 fs/cifsd/Makefile                        |   17 +
 fs/cifsd/asn1.c                          |  339 +
 fs/cifsd/asn1.h                          |   21 +
 fs/cifsd/auth.c                          | 1355 ++++
 fs/cifsd/auth.h                          |   65 +
 fs/cifsd/buffer_pool.c                   |  265 +
 fs/cifsd/buffer_pool.h                   |   17 +
 fs/cifsd/connection.c                    |  411 ++
 fs/cifsd/connection.h                    |  204 +
 fs/cifsd/crypto_ctx.c                    |  283 +
 fs/cifsd/crypto_ctx.h                    |   74 +
 fs/cifsd/glob.h                          |   64 +
 fs/cifsd/ksmbd_server.h                  |  283 +
 fs/cifsd/ksmbd_work.c                    |   93 +
 fs/cifsd/ksmbd_work.h                    |  110 +
 fs/cifsd/mgmt/ksmbd_ida.c                |   46 +
 fs/cifsd/mgmt/ksmbd_ida.h                |   34 +
 fs/cifsd/mgmt/share_config.c             |  239 +
 fs/cifsd/mgmt/share_config.h             |   81 +
 fs/cifsd/mgmt/tree_connect.c             |  122 +
 fs/cifsd/mgmt/tree_connect.h             |   56 +
 fs/cifsd/mgmt/user_config.c              |   70 +
 fs/cifsd/mgmt/user_config.h              |   66 +
 fs/cifsd/mgmt/user_session.c             |  328 +
 fs/cifsd/mgmt/user_session.h             |  101 +
 fs/cifsd/misc.c                          |  338 +
 fs/cifsd/misc.h                          |   35 +
 fs/cifsd/ndr.c                           |  348 +
 fs/cifsd/ndr.h                           |   22 +
 fs/cifsd/nterr.h                         |  543 ++
 fs/cifsd/ntlmssp.h                       |  169 +
 fs/cifsd/oplock.c                        | 1661 +++++
 fs/cifsd/oplock.h                        |  132 +
 fs/cifsd/server.c                        |  627 ++
 fs/cifsd/server.h                        |   60 +
 fs/cifsd/smb2misc.c                      |  435 ++
 fs/cifsd/smb2ops.c                       |  300 +
 fs/cifsd/smb2pdu.c                       | 8166 ++++++++++++++++++++++
 fs/cifsd/smb2pdu.h                       | 1664 +++++
 fs/cifsd/smb_common.c                    |  655 ++
 fs/cifsd/smb_common.h                    |  544 ++
 fs/cifsd/smbacl.c                        | 1321 ++++
 fs/cifsd/smbacl.h                        |  202 +
 fs/cifsd/smbfsctl.h                      |   91 +
 fs/cifsd/smbstatus.h                     | 1822 +++++
 fs/cifsd/spnego_negtokeninit.asn1        |   43 +
 fs/cifsd/spnego_negtokentarg.asn1        |   19 +
 fs/cifsd/transport_ipc.c                 |  880 +++
 fs/cifsd/transport_ipc.h                 |   47 +
 fs/cifsd/transport_rdma.c                | 2040 ++++++
 fs/cifsd/transport_rdma.h                |   61 +
 fs/cifsd/transport_tcp.c                 |  620 ++
 fs/cifsd/transport_tcp.h                 |   13 +
 fs/cifsd/unicode.c                       |  384 +
 fs/cifsd/unicode.h                       |  357 +
 fs/cifsd/uniupr.h                        |  268 +
 fs/cifsd/vfs.c                           | 2015 ++++++
 fs/cifsd/vfs.h                           |  275 +
 fs/cifsd/vfs_cache.c                     |  685 ++
 fs/cifsd/vfs_cache.h                     |  185 +
 67 files changed, 32027 insertions(+), 2 deletions(-)
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

