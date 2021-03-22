Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43425343841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 06:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCVFWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 01:22:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34205 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVFWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:22:08 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210322052206epoutp0141105756bfc507e5b80b9cad2f2da956~ukp6auimn2629626296epoutp01j
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210322052206epoutp0141105756bfc507e5b80b9cad2f2da956~ukp6auimn2629626296epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616390526;
        bh=XY1VdWU42yNpStyLEaDnCHpIawMWeInlOE6ay9E3s3s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Lx7H6H3Ioel2tkvV2ByOw9dV0rEj0wtOnxBFONGXZSxAdyQXfaKxOAztloFrsL/51
         d7DIaOoxRJMH13kawv8OnH7xq0/yqMr7f0+3jImR4gruT1MWafkTxXj6GOtrJJi73d
         8jsuZdgHSpKc7UnD8Y8ARabZ6Nm3+V0ZSgC+1DXM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210322052205epcas1p13f628e53c30526a6731384858a954fbd~ukp5nW7CR2745627456epcas1p1n;
        Mon, 22 Mar 2021 05:22:05 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F3jY82SmKz4x9Q1; Mon, 22 Mar
        2021 05:22:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.0A.63458.C7928506; Mon, 22 Mar 2021 14:22:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210322052203epcas1p21fe2d04c4df5396c466c38f4d57d8bb8~ukp3_dy1W2676126761epcas1p2V;
        Mon, 22 Mar 2021 05:22:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210322052203epsmtrp1737e9c03cd0affac343e061a41a0f8aa~ukp39YPkV2013120131epsmtrp1D;
        Mon, 22 Mar 2021 05:22:03 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-0d-6058297c68ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.26.08745.B7928506; Mon, 22 Mar 2021 14:22:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210322052203epsmtip11b0566c1e2afdf6b381296aa81b8be5f~ukp3qZeHe1741517415epsmtip1j;
        Mon, 22 Mar 2021 05:22:03 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 0/5] cifsd: introduce new SMB3 kernel server
Date:   Mon, 22 Mar 2021 14:13:39 +0900
Message-Id: <20210322051344.1706-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmgW6NZkSCwcvr3BaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWb14cZrM4//c4q4OQx6yGXjaP2Q0XWTx2zrrL7rF5hZbH7gWf
        mTx232xg8/j49BaLR9+WVYweWxY/ZPJYv+Uqi8fnTXIem568ZQrgicqxyUhNTEktUkjNS85P
        ycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6TkmhLDGnFCgUkFhcrKRvZ1OU
        X1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2VoYGBkClSZkJNx7dJL1oLFVRXLJnSw
        NjA2hnQxcnJICJhI7H63nbWLkYtDSGAHo8SxrjvMEM4nRomDa68xQjifGSVablxhhWlZcuA1
        VMsuRomFf38itDRv2MvSxcjBwSagLfFniyhIg4hArMSNHa/BapgFfjFJbP/4E2ySsICNxIk3
        sxlBbBYBVYktt3cxg9i8AtYSsw68YILYJi+xesMBsGYJgS0cEjuOPmADWSAh4CLx+ZQGRI2w
        xKvjW9ghbCmJl/1t7BAl1RIf9zNDhDsYJV58t4WwjSVurt/AClLCLKApsX6XPkRYUWLn77lg
        1zAL8Em8+9rDCjGFV6KjTQiiRFWi79JhqMOkJbraP0At9ZCY1bQCrFwI6NuDh3wmMMrOQpi/
        gJFxFaNYakFxbnpqsWGBEXIUbWIEp1ctsx2Mk95+0DvEyMTBeIhRgoNZSYT3RHJIghBvSmJl
        VWpRfnxRaU5q8SFGU2BgTWSWEk3OByb4vJJ4Q1MjY2NjCxMzczNTYyVx3kSDB/FCAumJJanZ
        qakFqUUwfUwcnFINTDZMiU67EnKS+Px3zymJl3lvwvKgpi9ZXFPG6JxpO2+El57xIcUVnp5u
        996o8Dlz1X6v3J76kp3V5GDL/fuVcQFX1O1vPZzzI+Cl/VzteNayJC6D/hKhK0WtX6cJmYUe
        a7Tf8Wj7vE0KLYrSW2X3SCytnCaieFqsy7M+7pHAJ9Oli0x3d+4N79V8/kZH3vNtTu+b9H8R
        944cYlV9ozr7/YPHe6ZpP4jfxev27iPbKjfmHy/0E85xfLXcqv29KVCOJ1+w8urngGWOFRMi
        ftXtunXehFn6xo4SB/MntU3M0+c+2DS9v/Wp0rv0rtO/3E9aBvjIx/q6Rb7eMPeYSpz7TsvP
        VybsYH2TXn0+yvSCEktxRqKhFnNRcSIAsFtSEjgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnG61ZkSCweI7YhaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWb14cZrM4//c4q4OQx6yGXjaP2Q0XWTx2zrrL7rF5hZbH7gWf
        mTx232xg8/j49BaLR9+WVYweWxY/ZPJYv+Uqi8fnTXIem568ZQrgieKySUnNySxLLdK3S+DK
        uHbpJWvB4qqKZRM6WBsYG0O6GDk5JARMJJYceM0KYgsJ7GCU+PXTBCIuLXHsxBnmLkYOIFtY
        4vDh4i5GLqCSD4wSnc/Ws4DE2QS0Jf5sEQUpFxGIl7jZcJsFpIZZoIdZYu27CewgCWEBG4kT
        b2YzgtgsAqoSW27vYgaxeQWsJWYdeMEEsUteYvWGA8wTGHkWMDKsYpRMLSjOTc8tNiwwykst
        1ytOzC0uzUvXS87P3cQIDngtrR2Me1Z90DvEyMTBeIhRgoNZSYT3RHJIghBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1Mezqen5Y/9/fxn8naOXFTGm6X
        LD5dNiW289Q9toXzv9y0OKV4xfvXB4XDCpnrLfLr7bJrZrfMDF5pXxWSr79JiynI8fF3823u
        fhs5wl0ijnJcKMvkZ5U/kvx/1fUZyVV/OBN9Eq41zw+wfH8pJTnt1ZM70epLX9Vc0prIlFz1
        SfP6k8roBSvmTj+4oF1MavOZKHbXnetfuIZxNx/rtzjqJn1x5gJrHptylncXf058oSvN8+zm
        m89Rizv1e6YdvPw5Kdpkw/JarmsKvfdPRHxd2SS6xOfBwwhBY5YDj0SuuNwxktFlyZ0XoqBm
        wfVuo/iFn5Mc+x/qqLNumSSr/cnFOfaJ6pq9e81cvybGSqn3K7EUZyQaajEXFScCACFhLUnn
        AgAA
X-CMS-MailID: 20210322052203epcas1p21fe2d04c4df5396c466c38f4d57d8bb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052203epcas1p21fe2d04c4df5396c466c38f4d57d8bb8
References: <CGME20210322052203epcas1p21fe2d04c4df5396c466c38f4d57d8bb8@epcas1p2.samsung.com>
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
============================== =================================================

All features required as file server are currently implemented in ksmbd.
In particular, the implementation of SMB Direct(RDMA) is only currently
possible with ksmbd (among Linux servers)


Stability
=========

It has been proved to be stable. A significant amount of xfstests pass and
are run regularly from Linux to Linux:

  http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/26

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

v0:
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
 - fix incorrect function comments

Namjae Jeon (5):
  cifsd: add server handler and tranport layers
  cifsd: add server-side procedures for SMB3
  cifsd: add file operations
  cifsd: add Kconfig and Makefile
  MAINTAINERS: add cifsd kernel server

 Documentation/filesystems/cifs/cifsd.rst |  180 +
 Documentation/filesystems/cifs/index.rst |   10 +
 Documentation/filesystems/index.rst      |    2 +-
 MAINTAINERS                              |   12 +-
 fs/Kconfig                               |    1 +
 fs/Makefile                              |    1 +
 fs/cifsd/Kconfig                         |   64 +
 fs/cifsd/Makefile                        |   13 +
 fs/cifsd/asn1.c                          |  702 ++
 fs/cifsd/asn1.h                          |   29 +
 fs/cifsd/auth.c                          | 1348 ++++
 fs/cifsd/auth.h                          |   90 +
 fs/cifsd/buffer_pool.c                   |  292 +
 fs/cifsd/buffer_pool.h                   |   28 +
 fs/cifsd/connection.c                    |  416 ++
 fs/cifsd/connection.h                    |  212 +
 fs/cifsd/crypto_ctx.c                    |  287 +
 fs/cifsd/crypto_ctx.h                    |   77 +
 fs/cifsd/glob.h                          |   67 +
 fs/cifsd/ksmbd_server.h                  |  285 +
 fs/cifsd/ksmbd_work.c                    |   93 +
 fs/cifsd/ksmbd_work.h                    |  124 +
 fs/cifsd/mgmt/ksmbd_ida.c                |   69 +
 fs/cifsd/mgmt/ksmbd_ida.h                |   41 +
 fs/cifsd/mgmt/share_config.c             |  238 +
 fs/cifsd/mgmt/share_config.h             |   81 +
 fs/cifsd/mgmt/tree_connect.c             |  128 +
 fs/cifsd/mgmt/tree_connect.h             |   56 +
 fs/cifsd/mgmt/user_config.c              |   69 +
 fs/cifsd/mgmt/user_config.h              |   66 +
 fs/cifsd/mgmt/user_session.c             |  344 +
 fs/cifsd/mgmt/user_session.h             |  105 +
 fs/cifsd/misc.c                          |  296 +
 fs/cifsd/misc.h                          |   38 +
 fs/cifsd/ndr.c                           |  344 +
 fs/cifsd/ndr.h                           |   21 +
 fs/cifsd/netmisc.c                       |   46 +
 fs/cifsd/nterr.c                         |  674 ++
 fs/cifsd/nterr.h                         |  552 ++
 fs/cifsd/ntlmssp.h                       |  169 +
 fs/cifsd/oplock.c                        | 1681 +++++
 fs/cifsd/oplock.h                        |  138 +
 fs/cifsd/server.c                        |  632 ++
 fs/cifsd/server.h                        |   62 +
 fs/cifsd/smb2misc.c                      |  458 ++
 fs/cifsd/smb2ops.c                       |  300 +
 fs/cifsd/smb2pdu.c                       | 8452 ++++++++++++++++++++++
 fs/cifsd/smb2pdu.h                       | 1649 +++++
 fs/cifsd/smb_common.c                    |  667 ++
 fs/cifsd/smb_common.h                    |  546 ++
 fs/cifsd/smbacl.c                        | 1324 ++++
 fs/cifsd/smbacl.h                        |  202 +
 fs/cifsd/smberr.h                        |  235 +
 fs/cifsd/smbfsctl.h                      |   90 +
 fs/cifsd/smbstatus.h                     | 1822 +++++
 fs/cifsd/time_wrappers.h                 |   34 +
 fs/cifsd/transport_ipc.c                 |  897 +++
 fs/cifsd/transport_ipc.h                 |   62 +
 fs/cifsd/transport_rdma.c                | 2051 ++++++
 fs/cifsd/transport_rdma.h                |   61 +
 fs/cifsd/transport_tcp.c                 |  625 ++
 fs/cifsd/transport_tcp.h                 |   13 +
 fs/cifsd/unicode.c                       |  391 +
 fs/cifsd/unicode.h                       |  374 +
 fs/cifsd/uniupr.h                        |  268 +
 fs/cifsd/vfs.c                           | 1989 +++++
 fs/cifsd/vfs.h                           |  314 +
 fs/cifsd/vfs_cache.c                     |  851 +++
 fs/cifsd/vfs_cache.h                     |  213 +
 69 files changed, 34069 insertions(+), 2 deletions(-)
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
 create mode 100644 fs/cifsd/netmisc.c
 create mode 100644 fs/cifsd/nterr.c
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
 create mode 100644 fs/cifsd/smberr.h
 create mode 100644 fs/cifsd/smbfsctl.h
 create mode 100644 fs/cifsd/smbstatus.h
 create mode 100644 fs/cifsd/time_wrappers.h
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

