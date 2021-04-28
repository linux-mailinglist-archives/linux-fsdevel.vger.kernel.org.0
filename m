Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1236DF6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 21:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbhD1TTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbhD1TTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:19:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170DDC061573;
        Wed, 28 Apr 2021 12:18:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6BEEB2501; Wed, 28 Apr 2021 15:18:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6BEEB2501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619637509;
        bh=M/c553g+1Hozm2BeYOv5gpzy6T+BrCwdzO+HXMcmMx0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=om38cNjt8qA4D4p8zXPnAJf8vO6GhHT6MXt/nWjdn4Y0WBiQFTvEKEgxG4NwFx4DB
         Iw4YWoI36Avx7iOJWOxqvXwRhqaUzS4xDdke9f7p2Qjcw6skpMZQjw0wxUM6EdKgx0
         9mTHXxY0qcindBslapbzHdovXZ1J3kw0WkHgZjwg=
Date:   Wed, 28 Apr 2021 15:18:29 -0400
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org
Subject: Re: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
Message-ID: <20210428191829.GB7400@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422002824.12677-1-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:28:14AM +0900, Namjae Jeon wrote:
> This is the patch series for cifsd(ksmbd) kernel server.

Looks like this series probably isn't bisectable.  E.g. while looking at
the ACL code I noticed ksmbd_vfs_setxattr is defined in a later patch
than it's first used in.

I know the requirement that everything build and run after each
individual patch in the series is tough to meet when introducing a whole
new subsystem.  I'm sure it's still possible, but I don't know what the
usual practice is in these cases.

--b.

> 
> What is cifsd(ksmbd) ?
> ======================
> 
> The SMB family of protocols is the most widely deployed
> network filesystem protocol, the default on Windows and Macs (and even
> on many phones and tablets), with clients and servers on all major
> operating systems, but lacked a kernel server for Linux. For many
> cases the current userspace server choices were suboptimal
> either due to memory footprint, performance or difficulty integrating
> well with advanced Linux features.
> 
> ksmbd is a new kernel module which implements the server-side of the SMB3 protocol.
> The target is to provide optimized performance, GPLv2 SMB server, better
> lease handling (distributed caching). The bigger goal is to add new
> features more rapidly (e.g. RDMA aka "smbdirect", and recent encryption
> and signing improvements to the protocol) which are easier to develop
> on a smaller, more tightly optimized kernel server than for example
> in Samba.  The Samba project is much broader in scope (tools, security services,
> LDAP, Active Directory Domain Controller, and a cross platform file server
> for a wider variety of purposes) but the user space file server portion
> of Samba has proved hard to optimize for some Linux workloads, including
> for smaller devices. This is not meant to replace Samba, but rather be
> an extension to allow better optimizing for Linux, and will continue to
> integrate well with Samba user space tools and libraries where appropriate.
> Working with the Samba team we have already made sure that the configuration
> files and xattrs are in a compatible format between the kernel and
> user space server.
> 
> 
> Architecture
> ============
> 
>                |--- ...
>        --------|--- ksmbd/3 - Client 3
>        |-------|--- ksmbd/2 - Client 2
>        |       |         ____________________________________________________
>        |       |        |- Client 1                                          |
> <--- Socket ---|--- ksmbd/1   <<= Authentication : NTLM/NTLM2, Kerberos      |
>        |       |      | |     <<= SMB engine : SMB2, SMB2.1, SMB3, SMB3.0.2, |
>        |       |      | |                SMB3.1.1                            |
>        |       |      | |____________________________________________________|
>        |       |      |
>        |       |      |--- VFS --- Local Filesystem
>        |       |
> KERNEL |--- ksmbd/0(forker kthread)
> ---------------||---------------------------------------------------------------
> USER           ||
>                || communication using NETLINK
>                ||  ______________________________________________
>                || |                                              |
>         ksmbd.mountd <<= DCE/RPC(srvsvc, wkssvc, samr, lsarpc)   |
>                ^  |  <<= configure shares setting, user accounts |
>                |  |______________________________________________|
>                |
>                |------ smb.conf(config file)
>                |
>                |------ ksmbdpwd.db(user account/password file)
>                             ^
>   ksmbd.adduser ---------------|
> 
> The subset of performance related operations(open/read/write/close etc.) belong
> in kernelspace(ksmbd) and the other subset which belong to operations(DCE/RPC,
> user account/share database) which are not really related with performance are
> handled in userspace(ksmbd.mountd).
> 
> When the ksmbd.mountd is started, It starts up a forker thread at initialization
> time and opens a dedicated port 445 for listening to SMB requests. Whenever new
> clients make request, Forker thread will accept the client connection and fork
> a new thread for dedicated communication channel between the client and
> the server.
> 
> 
> ksmbd feature status
> ====================
> 
> ============================== =================================================
> Feature name                   Status
> ============================== =================================================
> Dialects                       Supported. SMB2.1 SMB3.0, SMB3.1.1 dialects
>                                (intentionally excludes security vulnerable SMB1 dialect).
> Auto Negotiation               Supported.
> Compound Request               Supported.
> Oplock Cache Mechanism         Supported.
> SMB2 leases(v1 lease)          Supported.
> Directory leases(v2 lease)     Planned for future.
> Multi-credits                  Supported.
> NTLM/NTLMv2                    Supported.
> HMAC-SHA256 Signing            Supported.
> Secure negotiate               Supported.
> Signing Update                 Supported.
> Pre-authentication integrity   Supported.
> SMB3 encryption(CCM, GCM)      Supported. (CCM and GCM128 supported, GCM256 in progress)
> SMB direct(RDMA)               Partially Supported. SMB3 Multi-channel is required
>                                to connect to Windows client.
> SMB3 Multi-channel             In Progress.
> SMB3.1.1 POSIX extension       Supported.
> ACLs                           Partially Supported. only DACLs available, SACLs
>                                (auditing) is planned for the future. For
>                                ownership (SIDs) ksmbd generates random subauth
>                                values(then store it to disk) and use uid/gid
>                                get from inode as RID for local domain SID.
>                                The current acl implementation is limited to
>                                standalone server, not a domain member.
>                                Integration with Samba tools is being worked on to
>                                allow future support for running as a domain member.
> Kerberos                       Supported.
> Durable handle v1,v2           Planned for future.
> Persistent handle              Planned for future.
> SMB2 notify                    Planned for future.
> Sparse file support            Supported.
> DCE/RPC support                Partially Supported. a few calls(NetShareEnumAll,
>                                NetServerGetInfo, SAMR, LSARPC) that are needed 
>                                for file server handled via netlink interface from
>                                ksmbd.mountd. Additional integration with Samba
>                                tools and libraries via upcall is being investigated
>                                to allow support for additional DCE/RPC management
>                                calls (and future support for Witness protocol e.g.)
> ============================== =================================================
> 
> All features required as file server are currently implemented in ksmbd.
> In particular, the implementation of SMB Direct(RDMA) is only currently
> possible with ksmbd (among Linux servers)
> 
> 
> Stability
> =========
> 
> It has been proved to be stable. A significant amount of xfstests pass and
> are run regularly from Linux to Linux:
> 
>   http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/32
> 
> In addition regression tests using the broadest SMB3 functional test suite
> (Samba's "smbtorture") are run on every checkin. 
> It has already been used by many other open source toolkits and commercial companies
> that need NAS functionality. Their issues have been fixed and contributions are
> applied into ksmbd. Ksmbd has been well tested and verified in the field and market.
> 
> 
> Mailing list and repositories
> =============================
>  - linux-cifsd-devel@lists.sourceforge.net
>  - https://github.com/smfrench/smb3-kernel/tree/cifsd-for-next
>  - https://github.com/cifsd-team/cifsd (out-of-tree)
>  - https://github.com/cifsd-team/ksmbd-tools
> 
> 
> How to run ksmbd 
> ================
> 
>    a. Download ksmbd-tools and compile them.
> 	- https://github.com/cifsd-team/ksmbd-tools
> 
>    b. Create user/password for SMB share.
> 
> 	# mkdir /etc/ksmbd/
> 	# ksmbd.adduser -a <Enter USERNAME for SMB share access>
> 
>    c. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
> 	- Refer smb.conf.example and Documentation/configuration.txt
> 	  in ksmbd-tools
> 
>    d. Insert ksmbd.ko module
> 
> 	# insmod ksmbd.ko
> 
>    e. Start ksmbd user space daemon
> 	# ksmbd.mountd
> 
>    f. Access share from Windows or Linux using SMB 
>        e.g. "mount -t cifs //server/share /mnt ..."
> 
> 
> v2:
>  - fix an error code in smb2_read(). (Dan Carpenter)
>  - fix error handling in ksmbd_server_init() (Dan Carpenter)
>  - remove redundant assignment to variable err. (Colin Ian King)
>  - remove unneeded macros.
>  - fix wrong use of rw semaphore in __session_create().
>  - use kmalloc() for small allocations.
>  - add the check to work file lock and rename behaviors like Windows
>    unless POSIX extensions are negotiated.
>  - clean-up codes using chechpatch.pl --strict.
>  - merge time_wrappers.h into smb_common.h.
>  - fix wrong prototype in comment (kernel test robot).
>  - fix implicit declaration of function 'groups_alloc' (kernel test robot).
>  - fix implicit declaration of function 'locks_alloc_lock' (kernel test robot).
>  - remove smack inherit leftovers.
>  - remove calling d_path in error paths.
>  - handle unhashed dentry in ksmbd_vfs_mkdir.
>  - use file_inode() instead of d_inode().
>  - remove useless error handling in ksmbd_vfs_read.
>  - use xarray instead of linked list for tree connect list.
>  - remove stale prototype and variables.
>  - fix memory leak when loop ends (coverity-bot, Muhammad Usama Anjum).
>  - use kfree to free memory allocated by kmalloc or kzalloc (Muhammad Usama Anjum).
>  - fix memdup.cocci warnings (kernel test robot)
>  - remove wrappers of kvmalloc/kvfree.
>  - change the reference to configuration.txt (Mauro Carvalho Chehab).
>  - prevent a integer overflow in wm_alloc().
>  - select SG_POOL for SMB_SERVER_SMBDIRECT. (Zhang Xiaoxu).
>  - remove unused including <linux/version.h> (Tian Tao).
>  - declare ida statically.
>  - add the check if parent is stable by unexpected rename.
>  - get parent dentry from child in ksmbd_vfs_remove_file().
>  - re-implement ksmbd_vfs_kern_path.
>  - fix reference count decrement of unclaimed file in __ksmbd_lookup_fd.
>  - remove smb2_put_name(). (Marios Makassikis).
>  - remove unused smberr.h, nterr.c and netmisc.c.
>  - fix potential null-ptr-deref in smb2_open() (Marios Makassikis).
>  - use d_inode().
>  - remove the dead code of unimplemented durable handle.
>  - use the generic one in lib/asn1_decoder.c
> 
> v1:
>  - fix a handful of spelling mistakes (Colin Ian King)
>  - fix a precedence bug in parse_dacl() (Dan Carpenter)
>  - fix a IS_ERR() vs NULL bug (Dan Carpenter)
>  - fix a use after free on error path  (Dan Carpenter)
>  - update cifsd.rst Documentation
>  - remove unneeded FIXME comments
>  - fix static checker warnings (Dan Carpenter)
>  - fix WARNING: unmet direct dependencies detected for CRYPTO_ARC4 (Randy Dunlap)
>  - uniquify extract_sharename() (Stephen Rothwell)
>  - fix WARNING: document isn't included in any toctree (Stephen Rothwell)
>  - fix WARNING: Title overline too short (Stephen Rothwell)
>  - fix warning: variable 'total_ace_size' and 'posix_ccontext'set but not used (kernel test rotbot)
>  - fix incorrect function comments (kernel test robot)
> 
> Namjae Jeon (10):
>   cifsd: add document
>   cifsd: add server handler
>   cifsd: add trasport layers
>   cifsd: add authentication
>   cifsd: add smb3 engine part 1
>   cifsd: add smb3 engine part 2
>   cifsd: add oplock/lease cache mechanism
>   cifsd: add file operations
>   cifsd: add Kconfig and Makefile
>   MAINTAINERS: add cifsd kernel server
> 
>  Documentation/filesystems/cifs/cifsd.rst |  152 +
>  Documentation/filesystems/cifs/index.rst |   10 +
>  Documentation/filesystems/index.rst      |    2 +-
>  MAINTAINERS                              |   12 +-
>  fs/Kconfig                               |    1 +
>  fs/Makefile                              |    1 +
>  fs/cifsd/Kconfig                         |   67 +
>  fs/cifsd/Makefile                        |   17 +
>  fs/cifsd/asn1.c                          |  352 +
>  fs/cifsd/asn1.h                          |   29 +
>  fs/cifsd/auth.c                          | 1323 ++++
>  fs/cifsd/auth.h                          |   90 +
>  fs/cifsd/buffer_pool.c                   |  264 +
>  fs/cifsd/buffer_pool.h                   |   20 +
>  fs/cifsd/connection.c                    |  411 ++
>  fs/cifsd/connection.h                    |  208 +
>  fs/cifsd/crypto_ctx.c                    |  286 +
>  fs/cifsd/crypto_ctx.h                    |   77 +
>  fs/cifsd/glob.h                          |   64 +
>  fs/cifsd/ksmbd_server.h                  |  283 +
>  fs/cifsd/ksmbd_work.c                    |   93 +
>  fs/cifsd/ksmbd_work.h                    |  110 +
>  fs/cifsd/mgmt/ksmbd_ida.c                |   48 +
>  fs/cifsd/mgmt/ksmbd_ida.h                |   34 +
>  fs/cifsd/mgmt/share_config.c             |  239 +
>  fs/cifsd/mgmt/share_config.h             |   81 +
>  fs/cifsd/mgmt/tree_connect.c             |  122 +
>  fs/cifsd/mgmt/tree_connect.h             |   56 +
>  fs/cifsd/mgmt/user_config.c              |   70 +
>  fs/cifsd/mgmt/user_config.h              |   66 +
>  fs/cifsd/mgmt/user_session.c             |  328 +
>  fs/cifsd/mgmt/user_session.h             |  103 +
>  fs/cifsd/misc.c                          |  340 +
>  fs/cifsd/misc.h                          |   44 +
>  fs/cifsd/ndr.c                           |  347 +
>  fs/cifsd/ndr.h                           |   21 +
>  fs/cifsd/nterr.h                         |  545 ++
>  fs/cifsd/ntlmssp.h                       |  169 +
>  fs/cifsd/oplock.c                        | 1667 +++++
>  fs/cifsd/oplock.h                        |  133 +
>  fs/cifsd/server.c                        |  631 ++
>  fs/cifsd/server.h                        |   60 +
>  fs/cifsd/smb2misc.c                      |  435 ++
>  fs/cifsd/smb2ops.c                       |  300 +
>  fs/cifsd/smb2pdu.c                       | 8069 ++++++++++++++++++++++
>  fs/cifsd/smb2pdu.h                       | 1646 +++++
>  fs/cifsd/smb_common.c                    |  652 ++
>  fs/cifsd/smb_common.h                    |  544 ++
>  fs/cifsd/smbacl.c                        | 1317 ++++
>  fs/cifsd/smbacl.h                        |  201 +
>  fs/cifsd/smbfsctl.h                      |   90 +
>  fs/cifsd/smbstatus.h                     | 1822 +++++
>  fs/cifsd/spnego_negtokeninit.asn1        |   43 +
>  fs/cifsd/spnego_negtokentarg.asn1        |   19 +
>  fs/cifsd/transport_ipc.c                 |  881 +++
>  fs/cifsd/transport_ipc.h                 |   54 +
>  fs/cifsd/transport_rdma.c                | 2034 ++++++
>  fs/cifsd/transport_rdma.h                |   61 +
>  fs/cifsd/transport_tcp.c                 |  618 ++
>  fs/cifsd/transport_tcp.h                 |   13 +
>  fs/cifsd/unicode.c                       |  383 +
>  fs/cifsd/unicode.h                       |  356 +
>  fs/cifsd/uniupr.h                        |  268 +
>  fs/cifsd/vfs.c                           | 1995 ++++++
>  fs/cifsd/vfs.h                           |  273 +
>  fs/cifsd/vfs_cache.c                     |  683 ++
>  fs/cifsd/vfs_cache.h                     |  185 +
>  67 files changed, 31916 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/filesystems/cifs/cifsd.rst
>  create mode 100644 Documentation/filesystems/cifs/index.rst
>  create mode 100644 fs/cifsd/Kconfig
>  create mode 100644 fs/cifsd/Makefile
>  create mode 100644 fs/cifsd/asn1.c
>  create mode 100644 fs/cifsd/asn1.h
>  create mode 100644 fs/cifsd/auth.c
>  create mode 100644 fs/cifsd/auth.h
>  create mode 100644 fs/cifsd/buffer_pool.c
>  create mode 100644 fs/cifsd/buffer_pool.h
>  create mode 100644 fs/cifsd/connection.c
>  create mode 100644 fs/cifsd/connection.h
>  create mode 100644 fs/cifsd/crypto_ctx.c
>  create mode 100644 fs/cifsd/crypto_ctx.h
>  create mode 100644 fs/cifsd/glob.h
>  create mode 100644 fs/cifsd/ksmbd_server.h
>  create mode 100644 fs/cifsd/ksmbd_work.c
>  create mode 100644 fs/cifsd/ksmbd_work.h
>  create mode 100644 fs/cifsd/mgmt/ksmbd_ida.c
>  create mode 100644 fs/cifsd/mgmt/ksmbd_ida.h
>  create mode 100644 fs/cifsd/mgmt/share_config.c
>  create mode 100644 fs/cifsd/mgmt/share_config.h
>  create mode 100644 fs/cifsd/mgmt/tree_connect.c
>  create mode 100644 fs/cifsd/mgmt/tree_connect.h
>  create mode 100644 fs/cifsd/mgmt/user_config.c
>  create mode 100644 fs/cifsd/mgmt/user_config.h
>  create mode 100644 fs/cifsd/mgmt/user_session.c
>  create mode 100644 fs/cifsd/mgmt/user_session.h
>  create mode 100644 fs/cifsd/misc.c
>  create mode 100644 fs/cifsd/misc.h
>  create mode 100644 fs/cifsd/ndr.c
>  create mode 100644 fs/cifsd/ndr.h
>  create mode 100644 fs/cifsd/nterr.h
>  create mode 100644 fs/cifsd/ntlmssp.h
>  create mode 100644 fs/cifsd/oplock.c
>  create mode 100644 fs/cifsd/oplock.h
>  create mode 100644 fs/cifsd/server.c
>  create mode 100644 fs/cifsd/server.h
>  create mode 100644 fs/cifsd/smb2misc.c
>  create mode 100644 fs/cifsd/smb2ops.c
>  create mode 100644 fs/cifsd/smb2pdu.c
>  create mode 100644 fs/cifsd/smb2pdu.h
>  create mode 100644 fs/cifsd/smb_common.c
>  create mode 100644 fs/cifsd/smb_common.h
>  create mode 100644 fs/cifsd/smbacl.c
>  create mode 100644 fs/cifsd/smbacl.h
>  create mode 100644 fs/cifsd/smbfsctl.h
>  create mode 100644 fs/cifsd/smbstatus.h
>  create mode 100644 fs/cifsd/spnego_negtokeninit.asn1
>  create mode 100644 fs/cifsd/spnego_negtokentarg.asn1
>  create mode 100644 fs/cifsd/transport_ipc.c
>  create mode 100644 fs/cifsd/transport_ipc.h
>  create mode 100644 fs/cifsd/transport_rdma.c
>  create mode 100644 fs/cifsd/transport_rdma.h
>  create mode 100644 fs/cifsd/transport_tcp.c
>  create mode 100644 fs/cifsd/transport_tcp.h
>  create mode 100644 fs/cifsd/unicode.c
>  create mode 100644 fs/cifsd/unicode.h
>  create mode 100644 fs/cifsd/uniupr.h
>  create mode 100644 fs/cifsd/vfs.c
>  create mode 100644 fs/cifsd/vfs.h
>  create mode 100644 fs/cifsd/vfs_cache.c
>  create mode 100644 fs/cifsd/vfs_cache.h
> 
> -- 
> 2.17.1
> 
