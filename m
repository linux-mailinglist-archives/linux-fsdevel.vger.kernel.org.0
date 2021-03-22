Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6B343845
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 06:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCVFWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 01:22:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:46578 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhCVFWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:22:09 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210322052207epoutp034f3b0a33282c53685c0baa9ff911cb75~ukp72W9Ra0298502985epoutp03A
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210322052207epoutp034f3b0a33282c53685c0baa9ff911cb75~ukp72W9Ra0298502985epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616390527;
        bh=ld0DdfpAi1ldJSH8fmcbWyETfv8HO4eS/ih4jpNMomo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLvj+dBCcxkVnEi/XV3nIjI4kQg5XpDs9OYLU+orMmEwg4fsquN+0FHdbuvPmxXvJ
         FzNI6JyNyZc2cQ9UHKK0N9Jk+Wt6RbQKyuHRj/xljfX87FDCC4l9VlnjFGF3jpeKCc
         YA1DSoy3pgqCUIOVhR3aDtF+kJNoNYDNPsv9Y65o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210322052206epcas1p3e063b4ea94fcaad33d6de1383ad323b9~ukp7A72Wv1492314923epcas1p3C;
        Mon, 22 Mar 2021 05:22:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F3jY95GS3z4x9Q2; Mon, 22 Mar
        2021 05:22:05 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.DF.22618.D7928506; Mon, 22 Mar 2021 14:22:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7~ukp5NB-Ap2745027450epcas1p1i;
        Mon, 22 Mar 2021 05:22:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210322052204epsmtrp21c88350bf7c93087d1c19b66133da23b~ukp5LdM2Q0546105461epsmtrp2k;
        Mon, 22 Mar 2021 05:22:04 +0000 (GMT)
X-AuditID: b6c32a38-e63ff7000001585a-2b-6058297df591
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.26.08745.C7928506; Mon, 22 Mar 2021 14:22:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210322052204epsmtip159ab640f4b6e2d09b75c5bd63d7545c6~ukp4rwjju1741417414epsmtip1E;
        Mon, 22 Mar 2021 05:22:04 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 1/5] cifsd: add server handler and tranport layers
Date:   Mon, 22 Mar 2021 14:13:40 +0900
Message-Id: <20210322051344.1706-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322051344.1706-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xbVRT29r2+PphdXgq4a01G9zbcgLS0/LxTOqaS+TJ/sWxTQlR40Bcg
        PNquhbkBZvUPJnaWweJAUSIpMw4YMhg0pYyB4ISJOBljATImRBAcwgbNxo+KWFoW/e873/nO
        Od89914Sk/xASMlMbQ5n0LI8Tfjitu5ghfzD4MQU5eeDNPporg9HPbNrIuSqsxBo9p9yHPWV
        WAWopu66AN357YEIzaw7MLSyvgTQ1fYbOBp0fEWg5fJTaO6uW2spXhSiwtshqK3RSqB65+8i
        9NdMN4FGS78m0M21HuF+f6bCZCGYL00DONNaMSZirlwMYdqqnAKmbcREMIX2NRGzMDWKM8XN
        tYBprp4QMA3NQzjjbNrONE3OCRLESXxsBsdqOIOM06bpNJnadDX92uHkV5KjopUquWoviqFl
        WjabU9PxryfID2Ty7sPSsuMsn+umElijkQ7bF2vQ5eZwsgydMUdNc3oNr1cp9Qojm23M1aYr
        0nTZL6iUyvAotzKFz+ic6gd6a6HviaFzjUITsJWRZuBDQioS2izTuBn4khLKDuDteYvIGywC
        uPxNI+YNnADWTHSInpRYrdUCb8IB4IWBGU/CU2IbU5sBSRJUKPy7OWCD9qfeg8P2WU8jjLqD
        wZ6qL8BGwo96GVaem/DU4lQQ7B1vwTawmHoRnr6/CLzDAmHd5U4P70PFwrJvP/F4hdQkCVdH
        rmNeUTxct9cSXuwH7/c0bzqVQud8O7FhCFL5cKFjU14E4MyS2osj4EjDZeGGBKOCYYMjzEvv
        gK2uSo8FjNoK5x99KvR2EcOi0xKvJAgW3+oWePFz0Pzxw82hDOy/Vb+5xLMAuszTeAnYXvHf
        hCoAasEznN6Ync4ZVfrI/19ZE/A85xBkB5VzDxVdQECCLgBJjPYX96YdSZGINezJPM6gSzbk
        8pyxC0S5d1eKSQPSdO7/oM1JVkWFR0REoMjomOioCHqbOFU5niyh0tkcLovj9JzhSZ2A9JGa
        BKI9J0WDfTI+7LutBw5eykrduftGS8Hw/uAfH+8ouvio42BJfWDQzUVpn0JyVPfUL53B1j8+
        G05Y1p+3+g1UPS/ct+fYxJLm55kreS/l9sYdCuPNsUd1w29Hnnrn2dqm7Eux90yuOimQu1LV
        qqSnz/wKLqR2UHu37Uws//PeLjaxW+43On7E0i2XKxxDyNbneCs/qa6mpccwGxp3himXXSv7
        YEqyf+GQ6W57v4VXtq2u5L8JhKHvL+UJ/VyPucB3r4lWJa4tNPaG/dVd38dMj03afA7Ha46b
        +N7qLRknVhqODZ9l48J30+eLAgqySgP1662myCKJ8+oD/4FBR1LBT8V8A40bM1hVCGYwsv8C
        ihkgs1cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnG6NZkSCwZNf6haNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWaz8/Zrd48+Iwm8WtifPZLM7/Pc7qIOIxq6GXzWN2w0UWj52z
        7rJ7bF6h5bF7wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK
        4I3isklJzcksSy3St0vgyjjw9CxjwaJWroqrkzayNjBum8bRxcjJISFgIrFo0WKmLkYuDiGB
        HYwSF54cYIFISEscO3GGuYuRA8gWljh8uBii5gOjxMxJh8HibALaEn+2iIKUiwjES9xsuM0C
        UsMs8IpZYtXa00wgCWEBJ4m5kx6yg9gsAqoSJx5sZQaxeQWsJdpefWKE2CUvsXrDAbA4p4CN
        xLTlnWA3CAHVzGy9zzSBkW8BI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgKNLS
        2sG4Z9UHvUOMTByMhxglOJiVRHhPJIckCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkgg
        PbEkNTs1tSC1CCbLxMEp1cC0f9I8hXz3qZc8xBv/MXySWH//TQn7Gufzt1LFti7d+bXV59Q6
        K8+tm/zCFt1Z4Gm4Y63EDuuPgfxC89yFrp163LY6OuOL7pZ1EjwThby2zK61YtL/NvPC9tSb
        ey5Mvft4XVHKti2N8U8jRYW7r+qXub8S6+2/cjk6WCRKfIbl9gbDr+Jyp56ddH8as5s9ee9x
        /QlFhRHOQnsaZ4ZqdMwSu9E+4Vrsv1c8XyXZ7bbsKJYrK+5NPT1F7/BpYxar/bOmlx/SkLBw
        yZAv3nxfdWd2pxnP7ObuLMu7Bo+bhZkOfZkp/7vKrTBIyXkPR6+FSnb5Q52uM16HTXY4X0m5
        mj/j5vdpPBc7NFaHS86svP9YiaU4I9FQi7moOBEACiMRqhEDAAA=
X-CMS-MailID: 20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds server handler for central processing,
transport layers(tcp, rdma, ipc) and a document describing cifsd
architecture.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 Documentation/filesystems/cifs/cifsd.rst |  180 ++
 Documentation/filesystems/cifs/index.rst |   10 +
 Documentation/filesystems/index.rst      |    2 +-
 fs/cifsd/connection.c                    |  416 +++++
 fs/cifsd/connection.h                    |  212 +++
 fs/cifsd/glob.h                          |   67 +
 fs/cifsd/ksmbd_server.h                  |  285 +++
 fs/cifsd/ksmbd_work.c                    |   93 +
 fs/cifsd/ksmbd_work.h                    |  124 ++
 fs/cifsd/server.c                        |  632 +++++++
 fs/cifsd/server.h                        |   62 +
 fs/cifsd/transport_ipc.c                 |  897 ++++++++++
 fs/cifsd/transport_ipc.h                 |   62 +
 fs/cifsd/transport_rdma.c                | 2051 ++++++++++++++++++++++
 fs/cifsd/transport_rdma.h                |   61 +
 fs/cifsd/transport_tcp.c                 |  625 +++++++
 fs/cifsd/transport_tcp.h                 |   13 +
 17 files changed, 5791 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/cifs/cifsd.rst
 create mode 100644 Documentation/filesystems/cifs/index.rst
 create mode 100644 fs/cifsd/connection.c
 create mode 100644 fs/cifsd/connection.h
 create mode 100644 fs/cifsd/glob.h
 create mode 100644 fs/cifsd/ksmbd_server.h
 create mode 100644 fs/cifsd/ksmbd_work.c
 create mode 100644 fs/cifsd/ksmbd_work.h
 create mode 100644 fs/cifsd/server.c
 create mode 100644 fs/cifsd/server.h
 create mode 100644 fs/cifsd/transport_ipc.c
 create mode 100644 fs/cifsd/transport_ipc.h
 create mode 100644 fs/cifsd/transport_rdma.c
 create mode 100644 fs/cifsd/transport_rdma.h
 create mode 100644 fs/cifsd/transport_tcp.c
 create mode 100644 fs/cifsd/transport_tcp.h

diff --git a/Documentation/filesystems/cifs/cifsd.rst b/Documentation/filesystems/cifs/cifsd.rst
new file mode 100644
index 000000000000..7eac7e459c2d
--- /dev/null
+++ b/Documentation/filesystems/cifs/cifsd.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+CIFSD - SMB3 Kernel Server
+==========================
+
+CIFSD is a linux kernel server which implements SMB3 protocol in kernel space
+for sharing files over network.
+
+CIFSD architecture
+==================
+
+               |--- ...
+       --------|--- ksmbd/3 - Client 3
+       |-------|--- ksmbd/2 - Client 2
+       |       |         ____________________________________________________
+       |       |        |- Client 1                                          |
+<--- Socket ---|--- ksmbd/1   <<= Authentication : NTLM/NTLM2, Kerberos      |
+       |       |      | |     <<= SMB engine : SMB2, SMB2.1, SMB3, SMB3.0.2, |
+       |       |      | |                SMB3.1.1                            |
+       |       |      | |____________________________________________________|
+       |       |      |
+       |       |      |--- VFS --- Local Filesystem
+       |       |
+KERNEL |--- ksmbd/0(forker kthread)
+---------------||---------------------------------------------------------------
+USER           ||
+               || communication using NETLINK
+               ||  ______________________________________________
+               || |                                              |
+        ksmbd.mountd <<= DCE/RPC(srvsvc, wkssvc, smar, lsarpc)   |
+               ^  |  <<= configure shares setting, user accounts |
+               |  |______________________________________________|
+               |
+               |------ smb.conf(config file)
+               |
+               |------ ksmbdpwd.db(user account/password file)
+                            ^
+  ksmbd.adduser ---------------|
+
+The subset of performance related operations belong in kernelspace and
+the other subset which belong to operations which are not really related with
+performance in userspace. So, DCE/RPC management that has historically resulted
+into number of buffer overflow issues and dangerous security bugs and user
+account management are implemented in user space as ksmbd.mountd.
+File operations that are related with performance (open/read/write/close etc.)
+in kernel space (ksmbd). This also allows for easier integration with VFS
+interface for all file operations.
+
+ksmbd (kernel daemon)
+---------------------
+
+When the server daemon is started, It starts up a forker thread
+(ksmbd/interface name) at initialization time and open a dedicated port 445
+for listening to SMB requests. Whenever new clients make request, Forker
+thread will accept the client connection and fork a new thread for dedicated
+communication channel between the client and the server. It allows for parallel
+processing of SMB requests(commands) from clients as well as allowing for new
+clients to make new connections. Each instance is named ksmbd/1~n(port number)
+to indicate connected clients. Depending on the SMB request types, each new
+thread can decide to pass through the commands to the user space (ksmbd.mountd),
+currently DCE/RPC commands are identified to be handled through the user space.
+To further utilize the linux kernel, it has been chosen to process the commands
+as workitems and to be executed in the handlers of the ksmbd-io kworker threads.
+It allows for multiplexing of the handlers as the kernel take care of initiating
+extra worker threads if the load is increased and vice versa, if the load is
+decreased it destroys the extra worker threads. So, after connection is
+established with client. Dedicated ksmbd/1..n(port number) takes complete
+ownership of receiving/parsing of SMB commands. Each received command is worked
+in parallel i.e., There can be multiple clients commands which are worked in
+parallel. After receiving each command a separated kernel workitem is prepared
+for each command which is further queued to be handled by ksmbd-io kworkers.
+So, each SMB workitem is queued to the kworkers. This allows the benefit of load
+sharing to be managed optimally by the default kernel and optimizing client
+performance by handling client commands in parallel.
+
+ksmbd.mountd (user space daemon)
+--------------------------------
+
+ksmbd.mountd is userspace process to, transfer user account and password that
+are registered using ksmbd.adduser(part of utils for user space). Further it
+allows sharing information parameters that parsed from smb.conf to ksmbd in
+kernel. For the execution part it has a daemon which is continuously running
+and connected to the kernel interface using netlink socket, it waits for the
+requests(dcerpc and share/user info). It handles RPC calls (at a minimum few
+dozen) that are most important for file server from NetShareEnum and
+NetServerGetInfo. Complete DCE/RPC response is prepared from the user space
+and passed over to the associated kernel thread for the client.
+
+
+CIFSD Feature Status
+====================
+
+============================== =================================================
+Feature name                   Status
+============================== =================================================
+Dialects                       Supported. SMB2.1 SMB3.0, SMB3.1.1 dialects
+                               excluding security vulnerable SMB1.
+Auto Negotiation               Supported.
+Compound Request               Supported.
+Oplock Cache Mechanism         Supported.
+SMB2 leases(v1 lease)          Supported.
+Directory leases(v2 lease)     Planned for future.
+Multi-credits                  Supported.
+NTLM/NTLMv2                    Supported.
+HMAC-SHA256 Signing            Supported.
+Secure negotiate               Supported.
+Signing Update                 Supported.
+Pre-authentication integrity   Supported.
+SMB3 encryption(CCM, GCM)      Supported.
+SMB direct(RDMA)               Partial Supported. SMB3 Multi-channel is required
+                               to connect to Windows client.
+SMB3 Multi-channel             In Progress.
+SMB3.1.1 POSIX extension       Supported.
+ACLs                           Partial Supported. only DACLs available, SACLs is
+                               planned for future. ksmbd generate random subauth
+                               values(then store it to disk) and use uid/gid
+                               get from inode as RID for local domain SID.
+                               The current acl implementation is limited to
+                               standalone server, not a domain member.
+Kerberos                       Supported.
+Durable handle v1,v2           Planned for future.
+Persistent handle              Planned for future.
+SMB2 notify                    Planned for future.
+Sparse file support            Supported.
+DCE/RPC support                Partial Supported. a few calls(NetShareEnumAll,
+                               NetServerGetInfo, SAMR, LSARPC) that needed as
+                               file server via netlink interface from
+                               ksmbd.mountd.
+============================== =================================================
+
+
+How to run
+==========
+
+1. Download ksmbd-tools and compile them.
+	- https://github.com/cifsd-team/ksmbd-tools
+
+2. Create user/password for SMB share.
+
+	# mkdir /etc/ksmbd/
+	# ksmbd.adduser -a <Enter USERNAME for SMB share access>
+
+3. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
+	- Refer smb.conf.example and Documentation/configuration.txt
+	  in ksmbd-tools
+
+4. Insert ksmbd.ko module
+
+	# insmod ksmbd.ko
+
+5. Start ksmbd user space daemon
+	# ksmbd.mountd
+
+6. Access share from Windows or Linux using CIFS
+
+Shutdown CIFSD
+==============
+
+1. kill user and kernel space daemon
+	# sudo ksmbd.control -s
+
+How to turn debug print on
+==========================
+
+Each layer
+/sys/class/ksmbd-control/debug
+
+1. Enable all component prints
+	# sudo ksmbd.control -d "all"
+
+2. Enable one of components(smb, auth, vfs, oplock, ipc, conn, rdma)
+	# sudo ksmbd.control -d "smb"
+
+3. Show what prints are enable.
+	# cat/sys/class/ksmbd-control/debug
+	  [smb] auth vfs oplock ipc conn [rdma]
+
+4. Disable prints:
+	If you try the selected component once more, It is disabled without brackets.
diff --git a/Documentation/filesystems/cifs/index.rst b/Documentation/filesystems/cifs/index.rst
new file mode 100644
index 000000000000..e762586b5dc7
--- /dev/null
+++ b/Documentation/filesystems/cifs/index.rst
@@ -0,0 +1,10 @@
+===============================
+CIFS
+===============================
+
+
+.. toctree::
+   :maxdepth: 1
+
+   cifsd
+   cifsroot
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1f76b1cb3348..085702b5dbba 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -71,7 +71,7 @@ Documentation for filesystem implementations.
    befs
    bfs
    btrfs
-   cifs/cifsroot
+   cifs/index
    ceph
    coda
    configfs
diff --git a/fs/cifsd/connection.c b/fs/cifsd/connection.c
new file mode 100644
index 000000000000..d27553dee2ad
--- /dev/null
+++ b/fs/cifsd/connection.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <namjae.jeon@protocolfreedom.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/mutex.h>
+#include <linux/freezer.h>
+#include <linux/module.h>
+
+#include "server.h"
+#include "buffer_pool.h"
+#include "smb_common.h"
+#include "mgmt/ksmbd_ida.h"
+#include "connection.h"
+#include "transport_tcp.h"
+#include "transport_rdma.h"
+
+static DEFINE_MUTEX(init_lock);
+
+static struct ksmbd_conn_ops default_conn_ops;
+
+static LIST_HEAD(conn_list);
+static DEFINE_RWLOCK(conn_list_lock);
+
+/**
+ * ksmbd_conn_free() - free resources of the connection instance
+ *
+ * @conn:	connection instance to be cleand up
+ *
+ * During the thread termination, the corresponding conn instance
+ * resources(sock/memory) are released and finally the conn object is freed.
+ */
+void ksmbd_conn_free(struct ksmbd_conn *conn)
+{
+	write_lock(&conn_list_lock);
+	list_del(&conn->conns_list);
+	write_unlock(&conn_list_lock);
+
+	ksmbd_free_request(conn->request_buf);
+	ksmbd_ida_free(conn->async_ida);
+	kfree(conn->preauth_info);
+	kfree(conn);
+}
+
+/**
+ * ksmbd_conn_alloc() - initialize a new connection instance
+ *
+ * Return:	ksmbd_conn struct on success, otherwise NULL
+ */
+struct ksmbd_conn *ksmbd_conn_alloc(void)
+{
+	struct ksmbd_conn *conn;
+
+	conn = kzalloc(sizeof(struct ksmbd_conn), GFP_KERNEL);
+	if (!conn)
+		return NULL;
+
+	conn->need_neg = true;
+	conn->status = KSMBD_SESS_NEW;
+	conn->local_nls = load_nls("utf8");
+	if (!conn->local_nls)
+		conn->local_nls = load_nls_default();
+	atomic_set(&conn->req_running, 0);
+	atomic_set(&conn->r_count, 0);
+	init_waitqueue_head(&conn->req_running_q);
+	INIT_LIST_HEAD(&conn->conns_list);
+	INIT_LIST_HEAD(&conn->sessions);
+	INIT_LIST_HEAD(&conn->requests);
+	INIT_LIST_HEAD(&conn->async_requests);
+	spin_lock_init(&conn->request_lock);
+	spin_lock_init(&conn->credits_lock);
+	conn->async_ida = ksmbd_ida_alloc();
+
+	write_lock(&conn_list_lock);
+	list_add(&conn->conns_list, &conn_list);
+	write_unlock(&conn_list_lock);
+	return conn;
+}
+
+bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
+{
+	struct ksmbd_conn *t;
+	bool ret = false;
+
+	read_lock(&conn_list_lock);
+	list_for_each_entry(t, &conn_list, conns_list) {
+		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
+			continue;
+
+		ret = true;
+		break;
+	}
+	read_unlock(&conn_list_lock);
+	return ret;
+}
+
+void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct list_head *requests_queue = NULL;
+
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
+		requests_queue = &conn->requests;
+		work->syncronous = true;
+	}
+
+	if (requests_queue) {
+		atomic_inc(&conn->req_running);
+		spin_lock(&conn->request_lock);
+		list_add_tail(&work->request_entry, requests_queue);
+		spin_unlock(&conn->request_lock);
+	}
+}
+
+int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	int ret = 1;
+
+	if (list_empty(&work->request_entry) &&
+		list_empty(&work->async_request_entry))
+		return 0;
+
+	atomic_dec(&conn->req_running);
+	spin_lock(&conn->request_lock);
+	if (!work->multiRsp) {
+		list_del_init(&work->request_entry);
+		if (work->syncronous == false)
+			list_del_init(&work->async_request_entry);
+		ret = 0;
+	}
+	spin_unlock(&conn->request_lock);
+
+	wake_up_all(&conn->req_running_q);
+	return ret;
+}
+
+static void ksmbd_conn_lock(struct ksmbd_conn *conn)
+{
+	mutex_lock(&conn->srv_mutex);
+}
+
+static void ksmbd_conn_unlock(struct ksmbd_conn *conn)
+{
+	mutex_unlock(&conn->srv_mutex);
+}
+
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
+{
+	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
+}
+
+int ksmbd_conn_write(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb_hdr *rsp_hdr = RESPONSE_BUF(work);
+	size_t len = 0;
+	int sent;
+	struct kvec iov[3];
+	int iov_idx = 0;
+
+	ksmbd_conn_try_dequeue_request(work);
+	if (!rsp_hdr) {
+		ksmbd_err("NULL response header\n");
+		return -EINVAL;
+	}
+
+	if (HAS_TRANSFORM_BUF(work)) {
+		iov[iov_idx] = (struct kvec) { work->tr_buf,
+				sizeof(struct smb2_transform_hdr) };
+		len += iov[iov_idx++].iov_len;
+	}
+
+	if (HAS_AUX_PAYLOAD(work)) {
+		iov[iov_idx] = (struct kvec) { rsp_hdr, RESP_HDR_SIZE(work) };
+		len += iov[iov_idx++].iov_len;
+		iov[iov_idx] = (struct kvec) { AUX_PAYLOAD(work),
+			AUX_PAYLOAD_SIZE(work) };
+		len += iov[iov_idx++].iov_len;
+	} else {
+		if (HAS_TRANSFORM_BUF(work))
+			iov[iov_idx].iov_len = RESP_HDR_SIZE(work);
+		else
+			iov[iov_idx].iov_len = get_rfc1002_len(rsp_hdr) + 4;
+		iov[iov_idx].iov_base = rsp_hdr;
+		len += iov[iov_idx++].iov_len;
+	}
+
+	ksmbd_conn_lock(conn);
+	sent = conn->transport->ops->writev(conn->transport, &iov[0],
+					iov_idx, len,
+					work->need_invalidate_rkey,
+					work->remote_key);
+	ksmbd_conn_unlock(conn);
+
+	if (sent < 0) {
+		ksmbd_err("Failed to send message: %d\n", sent);
+		return sent;
+	}
+
+	return 0;
+}
+
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn,
+				void *buf, unsigned int buflen,
+				u32 remote_key, u64 remote_offset,
+				u32 remote_len)
+{
+	int ret = -EINVAL;
+
+	if (conn->transport->ops->rdma_read)
+		ret = conn->transport->ops->rdma_read(conn->transport,
+						buf, buflen,
+						remote_key, remote_offset,
+						remote_len);
+	return ret;
+}
+
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn,
+				void *buf, unsigned int buflen,
+				u32 remote_key, u64 remote_offset,
+				u32 remote_len)
+{
+	int ret = -EINVAL;
+
+	if (conn->transport->ops->rdma_write)
+		ret = conn->transport->ops->rdma_write(conn->transport,
+						buf, buflen,
+						remote_key, remote_offset,
+						remote_len);
+	return ret;
+}
+
+bool ksmbd_conn_alive(struct ksmbd_conn *conn)
+{
+	if (!ksmbd_server_running())
+		return false;
+
+	if (conn->status == KSMBD_SESS_EXITING)
+		return false;
+
+	if (kthread_should_stop())
+		return false;
+
+	if (atomic_read(&conn->stats.open_files_count) > 0)
+		return true;
+
+	/*
+	 * Stop current session if the time that get last request from client
+	 * is bigger than deadtime user configured and openning file count is
+	 * zero.
+	 */
+	if (server_conf.deadtime > 0 &&
+		time_after(jiffies, conn->last_active + server_conf.deadtime)) {
+		ksmbd_debug(CONN, "No response from client in %lu minutes\n",
+			server_conf.deadtime / SMB_ECHO_INTERVAL);
+		return false;
+	}
+	return true;
+}
+
+/**
+ * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
+ * @p:		connection instance
+ *
+ * One thread each per connection
+ *
+ * Return:	0 on success
+ */
+int ksmbd_conn_handler_loop(void *p)
+{
+	struct ksmbd_conn *conn = (struct ksmbd_conn *)p;
+	struct ksmbd_transport *t = conn->transport;
+	unsigned int pdu_size;
+	char hdr_buf[4] = {0,};
+	int size;
+
+	mutex_init(&conn->srv_mutex);
+	__module_get(THIS_MODULE);
+
+	if (t->ops->prepare && t->ops->prepare(t))
+		goto out;
+
+	conn->last_active = jiffies;
+	while (ksmbd_conn_alive(conn)) {
+		if (try_to_freeze())
+			continue;
+
+		ksmbd_free_request(conn->request_buf);
+		conn->request_buf = NULL;
+
+		size = t->ops->read(t, hdr_buf, sizeof(hdr_buf));
+		if (size != sizeof(hdr_buf))
+			break;
+
+		pdu_size = get_rfc1002_len(hdr_buf);
+		ksmbd_debug(CONN, "RFC1002 header %u bytes\n", pdu_size);
+
+		/* make sure we have enough to get to SMB header end */
+		if (!ksmbd_pdu_size_has_room(pdu_size)) {
+			ksmbd_debug(CONN, "SMB request too short (%u bytes)\n",
+				    pdu_size);
+			continue;
+		}
+
+		/* 4 for rfc1002 length field */
+		size = pdu_size + 4;
+		conn->request_buf = ksmbd_alloc_request(size);
+		if (!conn->request_buf)
+			continue;
+
+		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
+		if (!ksmbd_smb_request(conn))
+			break;
+
+		/*
+		 * We already read 4 bytes to find out PDU size, now
+		 * read in PDU
+		 */
+		size = t->ops->read(t, conn->request_buf + 4, pdu_size);
+		if (size < 0) {
+			ksmbd_err("sock_read failed: %d\n", size);
+			break;
+		}
+
+		if (size != pdu_size) {
+			ksmbd_err("PDU error. Read: %d, Expected: %d\n",
+				  size,
+				  pdu_size);
+			continue;
+		}
+
+		if (!default_conn_ops.process_fn) {
+			ksmbd_err("No connection request callback\n");
+			break;
+		}
+
+		if (default_conn_ops.process_fn(conn)) {
+			ksmbd_err("Cannot handle request\n");
+			break;
+		}
+	}
+
+out:
+	/* Wait till all reference dropped to the Server object*/
+	while (atomic_read(&conn->r_count) > 0)
+		schedule_timeout(HZ);
+
+	unload_nls(conn->local_nls);
+	if (default_conn_ops.terminate_fn)
+		default_conn_ops.terminate_fn(conn);
+	t->ops->disconnect(t);
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops)
+{
+	default_conn_ops.process_fn = ops->process_fn;
+	default_conn_ops.terminate_fn = ops->terminate_fn;
+}
+
+int ksmbd_conn_transport_init(void)
+{
+	int ret;
+
+	mutex_lock(&init_lock);
+	ret = ksmbd_tcp_init();
+	if (ret) {
+		pr_err("Failed to init TCP subsystem: %d\n", ret);
+		goto out;
+	}
+
+	ret = ksmbd_rdma_init();
+	if (ret) {
+		pr_err("Failed to init KSMBD subsystem: %d\n", ret);
+		goto out;
+	}
+out:
+	mutex_unlock(&init_lock);
+	return ret;
+}
+
+static void stop_sessions(void)
+{
+	struct ksmbd_conn *conn;
+
+again:
+	read_lock(&conn_list_lock);
+	list_for_each_entry(conn, &conn_list, conns_list) {
+		struct task_struct *task;
+
+		task = conn->transport->handler;
+		if (task)
+			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
+				  task->comm,
+				  task_pid_nr(task));
+		conn->status = KSMBD_SESS_EXITING;
+	}
+	read_unlock(&conn_list_lock);
+
+	if (!list_empty(&conn_list)) {
+		schedule_timeout_interruptible(HZ/10); /* 100ms */
+		goto again;
+	}
+}
+
+void ksmbd_conn_transport_destroy(void)
+{
+	mutex_lock(&init_lock);
+	ksmbd_tcp_destroy();
+	ksmbd_rdma_destroy();
+	stop_sessions();
+	mutex_unlock(&init_lock);
+}
diff --git a/fs/cifsd/connection.h b/fs/cifsd/connection.h
new file mode 100644
index 000000000000..179fb9278999
--- /dev/null
+++ b/fs/cifsd/connection.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_CONNECTION_H__
+#define __KSMBD_CONNECTION_H__
+
+#include <linux/list.h>
+#include <linux/ip.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <net/inet_connection_sock.h>
+#include <net/request_sock.h>
+#include <linux/kthread.h>
+#include <linux/nls.h>
+
+#include "smb_common.h"
+#include "ksmbd_work.h"
+
+#define KSMBD_SOCKET_BACKLOG		16
+
+/*
+ * WARNING
+ *
+ * This is nothing but a HACK. Session status should move to channel
+ * or to session. As of now we have 1 tcp_conn : 1 ksmbd_session, but
+ * we need to change it to 1 tcp_conn : N ksmbd_sessions.
+ */
+enum {
+	KSMBD_SESS_NEW = 0,
+	KSMBD_SESS_GOOD,
+	KSMBD_SESS_EXITING,
+	KSMBD_SESS_NEED_RECONNECT,
+	KSMBD_SESS_NEED_NEGOTIATE
+};
+
+struct ksmbd_stats {
+	atomic_t			open_files_count;
+	atomic64_t			request_served;
+};
+
+struct ksmbd_transport;
+
+struct ksmbd_conn {
+	struct smb_version_values	*vals;
+	struct smb_version_ops		*ops;
+	struct smb_version_cmds		*cmds;
+	unsigned int			max_cmds;
+	struct mutex			srv_mutex;
+	int				status;
+	unsigned int			cli_cap;
+	char				*request_buf;
+	struct ksmbd_transport		*transport;
+	struct nls_table		*local_nls;
+	struct list_head		conns_list;
+	/* smb session 1 per user */
+	struct list_head		sessions;
+	unsigned long			last_active;
+	/* How many request are running currently */
+	atomic_t			req_running;
+	/* References which are made for this Server object*/
+	atomic_t			r_count;
+	unsigned short			total_credits;
+	unsigned short			max_credits;
+	spinlock_t			credits_lock;
+	wait_queue_head_t		req_running_q;
+	/* Lock to protect requests list*/
+	spinlock_t			request_lock;
+	struct list_head		requests;
+	struct list_head		async_requests;
+	int				connection_type;
+	struct ksmbd_stats		stats;
+	char				ClientGUID[SMB2_CLIENT_GUID_SIZE];
+	union {
+		/* pending trans request table */
+		struct trans_state	*recent_trans;
+		/* Used by ntlmssp */
+		char			*ntlmssp_cryptkey;
+	};
+
+	struct preauth_integrity_info	*preauth_info;
+
+	bool				need_neg;
+	unsigned int			auth_mechs;
+	unsigned int			preferred_auth_mech;
+	bool				sign;
+	bool				use_spnego:1;
+	__u16				cli_sec_mode;
+	__u16				srv_sec_mode;
+	/* dialect index that server chose */
+	__u16				dialect;
+
+	char				*mechToken;
+
+	struct ksmbd_conn_ops	*conn_ops;
+
+	/* Preauth Session Table */
+	struct list_head		preauth_sess_table;
+
+	struct sockaddr_storage		peer_addr;
+
+	/* Identifier for async message */
+	struct ksmbd_ida		*async_ida;
+
+	__le16				cipher_type;
+	__le16				compress_algorithm;
+	bool				posix_ext_supported;
+};
+
+struct ksmbd_conn_ops {
+	int	(*process_fn)(struct ksmbd_conn *conn);
+	int	(*terminate_fn)(struct ksmbd_conn *conn);
+};
+
+struct ksmbd_transport_ops {
+	int (*prepare)(struct ksmbd_transport *t);
+	void (*disconnect)(struct ksmbd_transport *t);
+	int (*read)(struct ksmbd_transport *t,
+			char *buf, unsigned int size);
+	int (*writev)(struct ksmbd_transport *t,
+			struct kvec *iovs, int niov, int size,
+			bool need_invalidate_rkey, unsigned int remote_key);
+	int (*rdma_read)(struct ksmbd_transport *t,
+				void *buf, unsigned int len, u32 remote_key,
+				u64 remote_offset, u32 remote_len);
+	int (*rdma_write)(struct ksmbd_transport *t,
+				void *buf, unsigned int len, u32 remote_key,
+				u64 remote_offset, u32 remote_len);
+};
+
+struct ksmbd_transport {
+	struct ksmbd_conn		*conn;
+	struct ksmbd_transport_ops	*ops;
+	struct task_struct		*handler;
+};
+
+#define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
+#define KSMBD_TCP_SEND_TIMEOUT	(5 * HZ)
+#define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
+
+bool ksmbd_conn_alive(struct ksmbd_conn *conn);
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
+
+struct ksmbd_conn *ksmbd_conn_alloc(void);
+void ksmbd_conn_free(struct ksmbd_conn *conn);
+bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
+int ksmbd_conn_write(struct ksmbd_work *work);
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn,
+				void *buf, unsigned int buflen,
+				u32 remote_key, u64 remote_offset,
+				u32 remote_len);
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn,
+				void *buf, unsigned int buflen,
+				u32 remote_key, u64 remote_offset,
+				u32 remote_len);
+
+void ksmbd_conn_enqueue_request(struct ksmbd_work *work);
+int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work);
+void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
+
+int ksmbd_conn_handler_loop(void *p);
+
+int ksmbd_conn_transport_init(void);
+void ksmbd_conn_transport_destroy(void);
+
+/*
+ * WARNING
+ *
+ * This is a hack. We will move status to a proper place once we land
+ * a multi-sessions support.
+ */
+static inline bool ksmbd_conn_good(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_GOOD;
+}
+
+static inline bool ksmbd_conn_need_negotiate(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_NEED_NEGOTIATE;
+}
+
+static inline bool ksmbd_conn_need_reconnect(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_NEED_RECONNECT;
+}
+
+static inline bool ksmbd_conn_exiting(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_EXITING;
+}
+
+static inline void ksmbd_conn_set_good(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_GOOD;
+}
+
+static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_NEED_NEGOTIATE;
+}
+
+static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_NEED_RECONNECT;
+}
+
+static inline void ksmbd_conn_set_exiting(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_EXITING;
+}
+#endif /* __CONNECTION_H__ */
diff --git a/fs/cifsd/glob.h b/fs/cifsd/glob.h
new file mode 100644
index 000000000000..2dc3f603e837
--- /dev/null
+++ b/fs/cifsd/glob.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_GLOB_H
+#define __KSMBD_GLOB_H
+
+#include <linux/ctype.h>
+#include <linux/version.h>
+
+#include "unicode.h"
+#include "vfs_cache.h"
+#include "smberr.h"
+
+#define KSMBD_VERSION	"3.1.9"
+
+/* @FIXME clean up this code */
+
+extern int ksmbd_debug_types;
+extern int ksmbd_caseless_search;
+
+#define DATA_STREAM	1
+#define DIR_STREAM	2
+
+#define KSMBD_DEBUG_SMB         (1 << 0)
+#define KSMBD_DEBUG_AUTH        (1 << 1)
+#define KSMBD_DEBUG_VFS         (1 << 2)
+#define KSMBD_DEBUG_OPLOCK      (1 << 3)
+#define KSMBD_DEBUG_IPC         (1 << 4)
+#define KSMBD_DEBUG_CONN        (1 << 5)
+#define KSMBD_DEBUG_RDMA        (1 << 6)
+#define KSMBD_DEBUG_ALL         (KSMBD_DEBUG_SMB | KSMBD_DEBUG_AUTH |	\
+				KSMBD_DEBUG_VFS | KSMBD_DEBUG_OPLOCK |	\
+				KSMBD_DEBUG_IPC | KSMBD_DEBUG_CONN |	\
+				KSMBD_DEBUG_RDMA)
+
+#ifndef ksmbd_pr_fmt
+#ifdef SUBMOD_NAME
+#define ksmbd_pr_fmt(fmt)	"ksmbd: " SUBMOD_NAME ": " fmt
+#else
+#define ksmbd_pr_fmt(fmt)	"ksmbd: " fmt
+#endif
+#endif
+
+#define ksmbd_debug(type, fmt, ...)				\
+	do {							\
+		if (ksmbd_debug_types & KSMBD_DEBUG_##type)	\
+			pr_info(ksmbd_pr_fmt("%s:%d: " fmt),	\
+				__func__,			\
+				__LINE__,			\
+				##__VA_ARGS__);			\
+	} while (0)
+
+#define ksmbd_info(fmt, ...)					\
+			pr_info(ksmbd_pr_fmt(fmt), ##__VA_ARGS__)
+
+#define ksmbd_err(fmt, ...)					\
+			pr_err(ksmbd_pr_fmt("%s:%d: " fmt),	\
+				__func__,			\
+				__LINE__,			\
+				##__VA_ARGS__)
+
+#define UNICODE_LEN(x)		((x) * 2)
+
+#endif /* __KSMBD_GLOB_H */
diff --git a/fs/cifsd/ksmbd_server.h b/fs/cifsd/ksmbd_server.h
new file mode 100644
index 000000000000..01eaf9ec4fde
--- /dev/null
+++ b/fs/cifsd/ksmbd_server.h
@@ -0,0 +1,285 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ *
+ *   linux-ksmbd-devel@lists.sourceforge.net
+ */
+
+#ifndef _LINUX_KSMBD_SERVER_H
+#define _LINUX_KSMBD_SERVER_H
+
+#include <linux/types.h>
+
+#define KSMBD_GENL_NAME		"SMBD_GENL"
+#define KSMBD_GENL_VERSION		0x01
+
+#ifndef ____ksmbd_align
+#define ____ksmbd_align		__aligned(4)
+#endif
+
+#define KSMBD_REQ_MAX_ACCOUNT_NAME_SZ	48
+#define KSMBD_REQ_MAX_HASH_SZ		18
+#define KSMBD_REQ_MAX_SHARE_NAME	64
+
+struct ksmbd_heartbeat {
+	__u32	handle;
+};
+
+/*
+ * Global config flags.
+ */
+#define KSMBD_GLOBAL_FLAG_INVALID		(0)
+#define KSMBD_GLOBAL_FLAG_SMB2_LEASES		(1 << 0)
+#define KSMBD_GLOBAL_FLAG_CACHE_TBUF		(1 << 1)
+#define KSMBD_GLOBAL_FLAG_CACHE_RBUF		(1 << 2)
+#define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	(1 << 3)
+#define KSMBD_GLOBAL_FLAG_DURABLE_HANDLE	(1 << 4)
+
+struct ksmbd_startup_request {
+	__u32	flags;
+	__s32	signing;
+	__s8	min_prot[16];
+	__s8	max_prot[16];
+	__s8	netbios_name[16];
+	__s8	work_group[64];
+	__s8	server_string[64];
+	__u16	tcp_port;
+	__u16	ipc_timeout;
+	__u32	deadtime;
+	__u32	file_max;
+	__u32	smb2_max_write;
+	__u32	smb2_max_read;
+	__u32	smb2_max_trans;
+	__u32	share_fake_fscaps;
+	__u32	sub_auth[3];
+	__u32	ifc_list_sz;
+	__s8	____payload[0];
+} ____ksmbd_align;
+
+#define KSMBD_STARTUP_CONFIG_INTERFACES(s)	((s)->____payload)
+
+struct ksmbd_shutdown_request {
+	__s32	reserved;
+} ____ksmbd_align;
+
+struct ksmbd_login_request {
+	__u32	handle;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+} ____ksmbd_align;
+
+struct ksmbd_login_response {
+	__u32	handle;
+	__u32	gid;
+	__u32	uid;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+	__u16	status;
+	__u16	hash_sz;
+	__s8	hash[KSMBD_REQ_MAX_HASH_SZ];
+} ____ksmbd_align;
+
+struct ksmbd_share_config_request {
+	__u32	handle;
+	__s8	share_name[KSMBD_REQ_MAX_SHARE_NAME];
+} ____ksmbd_align;
+
+struct ksmbd_share_config_response {
+	__u32	handle;
+	__u32	flags;
+	__u16	create_mask;
+	__u16	directory_mask;
+	__u16	force_create_mode;
+	__u16	force_directory_mode;
+	__u16	force_uid;
+	__u16	force_gid;
+	__u32	veto_list_sz;
+	__s8	____payload[0];
+} ____ksmbd_align;
+
+#define KSMBD_SHARE_CONFIG_VETO_LIST(s)	((s)->____payload)
+#define KSMBD_SHARE_CONFIG_PATH(s)				\
+	({							\
+		char *p = (s)->____payload;			\
+		if ((s)->veto_list_sz)				\
+			p += (s)->veto_list_sz + 1;		\
+		p;						\
+	 })
+
+struct ksmbd_tree_connect_request {
+	__u32	handle;
+	__u16	account_flags;
+	__u16	flags;
+	__u64	session_id;
+	__u64	connect_id;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+	__s8	share[KSMBD_REQ_MAX_SHARE_NAME];
+	__s8	peer_addr[64];
+} ____ksmbd_align;
+
+struct ksmbd_tree_connect_response {
+	__u32	handle;
+	__u16	status;
+	__u16	connection_flags;
+} ____ksmbd_align;
+
+struct ksmbd_tree_disconnect_request {
+	__u64	session_id;
+	__u64	connect_id;
+} ____ksmbd_align;
+
+struct ksmbd_logout_request {
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+} ____ksmbd_align;
+
+struct ksmbd_rpc_command {
+	__u32	handle;
+	__u32	flags;
+	__u32	payload_sz;
+	__u8	payload[0];
+} ____ksmbd_align;
+
+struct ksmbd_spnego_authen_request {
+	__u32	handle;
+	__u16	spnego_blob_len;
+	__u8	spnego_blob[0];
+} ____ksmbd_align;
+
+struct ksmbd_spnego_authen_response {
+	__u32	handle;
+	struct ksmbd_login_response	login_response;
+	__u16	session_key_len;
+	__u16	spnego_blob_len;
+	__u8	payload[0];		/* session key + AP_REP */
+} ____ksmbd_align;
+
+/*
+ * This also used as NETLINK attribute type value.
+ *
+ * NOTE:
+ * Response message type value should be equal to
+ * request message type value + 1.
+ */
+enum ksmbd_event {
+	KSMBD_EVENT_UNSPEC			= 0,
+	KSMBD_EVENT_HEARTBEAT_REQUEST,
+
+	KSMBD_EVENT_STARTING_UP,
+	KSMBD_EVENT_SHUTTING_DOWN,
+
+	KSMBD_EVENT_LOGIN_REQUEST,
+	KSMBD_EVENT_LOGIN_RESPONSE		= 5,
+
+	KSMBD_EVENT_SHARE_CONFIG_REQUEST,
+	KSMBD_EVENT_SHARE_CONFIG_RESPONSE,
+
+	KSMBD_EVENT_TREE_CONNECT_REQUEST,
+	KSMBD_EVENT_TREE_CONNECT_RESPONSE,
+
+	KSMBD_EVENT_TREE_DISCONNECT_REQUEST	= 10,
+
+	KSMBD_EVENT_LOGOUT_REQUEST,
+
+	KSMBD_EVENT_RPC_REQUEST,
+	KSMBD_EVENT_RPC_RESPONSE,
+
+	KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
+	KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE	= 15,
+
+	KSMBD_EVENT_MAX
+};
+
+enum KSMBD_TREE_CONN_STATUS {
+	KSMBD_TREE_CONN_STATUS_OK		= 0,
+	KSMBD_TREE_CONN_STATUS_NOMEM,
+	KSMBD_TREE_CONN_STATUS_NO_SHARE,
+	KSMBD_TREE_CONN_STATUS_NO_USER,
+	KSMBD_TREE_CONN_STATUS_INVALID_USER,
+	KSMBD_TREE_CONN_STATUS_HOST_DENIED	= 5,
+	KSMBD_TREE_CONN_STATUS_CONN_EXIST,
+	KSMBD_TREE_CONN_STATUS_TOO_MANY_CONNS,
+	KSMBD_TREE_CONN_STATUS_TOO_MANY_SESSIONS,
+	KSMBD_TREE_CONN_STATUS_ERROR,
+};
+
+/*
+ * User config flags.
+ */
+#define KSMBD_USER_FLAG_INVALID		(0)
+#define KSMBD_USER_FLAG_OK		(1 << 0)
+#define KSMBD_USER_FLAG_BAD_PASSWORD	(1 << 1)
+#define KSMBD_USER_FLAG_BAD_UID		(1 << 2)
+#define KSMBD_USER_FLAG_BAD_USER	(1 << 3)
+#define KSMBD_USER_FLAG_GUEST_ACCOUNT	(1 << 4)
+
+/*
+ * Share config flags.
+ */
+#define KSMBD_SHARE_FLAG_INVALID		(0)
+#define KSMBD_SHARE_FLAG_AVAILABLE		(1 << 0)
+#define KSMBD_SHARE_FLAG_BROWSEABLE		(1 << 1)
+#define KSMBD_SHARE_FLAG_WRITEABLE		(1 << 2)
+#define KSMBD_SHARE_FLAG_READONLY		(1 << 3)
+#define KSMBD_SHARE_FLAG_GUEST_OK		(1 << 4)
+#define KSMBD_SHARE_FLAG_GUEST_ONLY		(1 << 5)
+#define KSMBD_SHARE_FLAG_STORE_DOS_ATTRS	(1 << 6)
+#define KSMBD_SHARE_FLAG_OPLOCKS		(1 << 7)
+#define KSMBD_SHARE_FLAG_PIPE			(1 << 8)
+#define KSMBD_SHARE_FLAG_HIDE_DOT_FILES		(1 << 9)
+#define KSMBD_SHARE_FLAG_INHERIT_SMACK		(1 << 10)
+#define KSMBD_SHARE_FLAG_INHERIT_OWNER		(1 << 11)
+#define KSMBD_SHARE_FLAG_STREAMS		(1 << 12)
+#define KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS	(1 << 13)
+#define KSMBD_SHARE_FLAG_ACL_XATTR		(1 << 14)
+
+/*
+ * Tree connect request flags.
+ */
+#define KSMBD_TREE_CONN_FLAG_REQUEST_SMB1	(0)
+#define KSMBD_TREE_CONN_FLAG_REQUEST_IPV6	(1 << 0)
+#define KSMBD_TREE_CONN_FLAG_REQUEST_SMB2	(1 << 1)
+
+/*
+ * Tree connect flags.
+ */
+#define KSMBD_TREE_CONN_FLAG_GUEST_ACCOUNT	(1 << 0)
+#define KSMBD_TREE_CONN_FLAG_READ_ONLY		(1 << 1)
+#define KSMBD_TREE_CONN_FLAG_WRITABLE		(1 << 2)
+#define KSMBD_TREE_CONN_FLAG_ADMIN_ACCOUNT	(1 << 3)
+
+/*
+ * RPC over IPC.
+ */
+#define KSMBD_RPC_METHOD_RETURN		(1 << 0)
+#define KSMBD_RPC_SRVSVC_METHOD_INVOKE	(1 << 1)
+#define KSMBD_RPC_SRVSVC_METHOD_RETURN	((1 << 1) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_WKSSVC_METHOD_INVOKE	(1 << 2)
+#define KSMBD_RPC_WKSSVC_METHOD_RETURN	((1 << 2) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_IOCTL_METHOD		((1 << 3) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_OPEN_METHOD		(1 << 4)
+#define KSMBD_RPC_WRITE_METHOD		(1 << 5)
+#define KSMBD_RPC_READ_METHOD		((1 << 6) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_CLOSE_METHOD		(1 << 7)
+#define KSMBD_RPC_RAP_METHOD		((1 << 8) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_RESTRICTED_CONTEXT	(1 << 9)
+#define KSMBD_RPC_SAMR_METHOD_INVOKE	(1 << 10)
+#define KSMBD_RPC_SAMR_METHOD_RETURN	((1 << 10) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_LSARPC_METHOD_INVOKE	(1 << 11)
+#define KSMBD_RPC_LSARPC_METHOD_RETURN	((1 << 11) | KSMBD_RPC_METHOD_RETURN)
+
+#define KSMBD_RPC_OK			0
+#define KSMBD_RPC_EBAD_FUNC		0x00000001
+#define KSMBD_RPC_EACCESS_DENIED	0x00000005
+#define KSMBD_RPC_EBAD_FID		0x00000006
+#define KSMBD_RPC_ENOMEM		0x00000008
+#define KSMBD_RPC_EBAD_DATA		0x0000000D
+#define KSMBD_RPC_ENOTIMPLEMENTED	0x00000040
+#define KSMBD_RPC_EINVALID_PARAMETER	0x00000057
+#define KSMBD_RPC_EMORE_DATA		0x000000EA
+#define KSMBD_RPC_EINVALID_LEVEL	0x0000007C
+#define KSMBD_RPC_SOME_NOT_MAPPED	0x00000107
+
+#define KSMBD_CONFIG_OPT_DISABLED	0
+#define KSMBD_CONFIG_OPT_ENABLED	1
+#define KSMBD_CONFIG_OPT_AUTO		2
+#define KSMBD_CONFIG_OPT_MANDATORY	3
+
+#endif /* _LINUX_KSMBD_SERVER_H */
diff --git a/fs/cifsd/ksmbd_work.c b/fs/cifsd/ksmbd_work.c
new file mode 100644
index 000000000000..8cd5dff0762d
--- /dev/null
+++ b/fs/cifsd/ksmbd_work.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include "server.h"
+#include "connection.h"
+#include "ksmbd_work.h"
+#include "buffer_pool.h"
+#include "mgmt/ksmbd_ida.h"
+
+/* @FIXME */
+#include "ksmbd_server.h"
+
+static struct kmem_cache *work_cache;
+static struct workqueue_struct *ksmbd_wq;
+
+struct ksmbd_work *ksmbd_alloc_work_struct(void)
+{
+	struct ksmbd_work *work = kmem_cache_zalloc(work_cache, GFP_KERNEL);
+
+	if (work) {
+		work->compound_fid = KSMBD_NO_FID;
+		work->compound_pfid = KSMBD_NO_FID;
+		INIT_LIST_HEAD(&work->request_entry);
+		INIT_LIST_HEAD(&work->async_request_entry);
+		INIT_LIST_HEAD(&work->fp_entry);
+		INIT_LIST_HEAD(&work->interim_entry);
+	}
+	return work;
+}
+
+void ksmbd_free_work_struct(struct ksmbd_work *work)
+{
+	WARN_ON(work->saved_cred != NULL);
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_TBUF &&
+			work->set_trans_buf)
+		ksmbd_release_buffer(RESPONSE_BUF(work));
+	else
+		ksmbd_free_response(RESPONSE_BUF(work));
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_RBUF &&
+			work->set_read_buf)
+		ksmbd_release_buffer(AUX_PAYLOAD(work));
+	else
+		ksmbd_free_response(AUX_PAYLOAD(work));
+
+	ksmbd_free_response(TRANSFORM_BUF(work));
+	ksmbd_free_request(REQUEST_BUF(work));
+	if (work->async_id)
+		ksmbd_release_id(work->conn->async_ida, work->async_id);
+	kmem_cache_free(work_cache, work);
+}
+
+void ksmbd_work_pool_destroy(void)
+{
+	kmem_cache_destroy(work_cache);
+}
+
+int ksmbd_work_pool_init(void)
+{
+	work_cache = kmem_cache_create("ksmbd_work_cache",
+					sizeof(struct ksmbd_work), 0,
+					SLAB_HWCACHE_ALIGN, NULL);
+	if (!work_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+int ksmbd_workqueue_init(void)
+{
+	ksmbd_wq = alloc_workqueue("ksmbd-io", 0, 0);
+	if (!ksmbd_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+void ksmbd_workqueue_destroy(void)
+{
+	flush_workqueue(ksmbd_wq);
+	destroy_workqueue(ksmbd_wq);
+	ksmbd_wq = NULL;
+}
+
+bool ksmbd_queue_work(struct ksmbd_work *work)
+{
+	return queue_work(ksmbd_wq, &work->work);
+}
diff --git a/fs/cifsd/ksmbd_work.h b/fs/cifsd/ksmbd_work.h
new file mode 100644
index 000000000000..405434d4c8ab
--- /dev/null
+++ b/fs/cifsd/ksmbd_work.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_WORK_H__
+#define __KSMBD_WORK_H__
+
+#include <linux/ctype.h>
+#include <linux/workqueue.h>
+
+struct ksmbd_conn;
+struct ksmbd_session;
+struct ksmbd_tree_connect;
+
+enum {
+	KSMBD_WORK_ACTIVE = 0,
+	KSMBD_WORK_CANCELLED,
+	KSMBD_WORK_CLOSED,
+};
+
+/* one of these for every pending CIFS request at the connection */
+struct ksmbd_work {
+	/* Server corresponding to this mid */
+	struct ksmbd_conn               *conn;
+	struct ksmbd_session            *sess;
+	struct ksmbd_tree_connect       *tcon;
+
+	/* Pointer to received SMB header */
+	char                            *request_buf;
+	/* Response buffer */
+	char                            *response_buf;
+
+	/* Read data buffer */
+	char                            *aux_payload_buf;
+
+	/* Next cmd hdr in compound req buf*/
+	int                             next_smb2_rcv_hdr_off;
+	/* Next cmd hdr in compound rsp buf*/
+	int                             next_smb2_rsp_hdr_off;
+
+	/*
+	 * Current Local FID assigned compound response if SMB2 CREATE
+	 * command is present in compound request
+	 */
+	unsigned int                    compound_fid;
+	unsigned int                    compound_pfid;
+	unsigned int                    compound_sid;
+
+	const struct cred		*saved_cred;
+
+	/* Number of granted credits */
+	unsigned int			credits_granted;
+
+	/* response smb header size */
+	unsigned int                    resp_hdr_sz;
+	unsigned int                    response_sz;
+	/* Read data count */
+	unsigned int                    aux_payload_sz;
+
+	void				*tr_buf;
+
+	unsigned char			state;
+	/* Multiple responses for one request e.g. SMB ECHO */
+	bool                            multiRsp:1;
+	/* No response for cancelled request */
+	bool                            send_no_response:1;
+	/* Request is encrypted */
+	bool                            encrypted:1;
+	/* Is this SYNC or ASYNC ksmbd_work */
+	bool                            syncronous:1;
+	bool                            need_invalidate_rkey:1;
+	bool                            set_trans_buf:1;
+	bool                            set_read_buf:1;
+
+	unsigned int                    remote_key;
+	/* cancel works */
+	int                             async_id;
+	void                            **cancel_argv;
+	void                            (*cancel_fn)(void **argv);
+
+	struct work_struct              work;
+	/* List head at conn->requests */
+	struct list_head                request_entry;
+	/* List head at conn->async_requests */
+	struct list_head                async_request_entry;
+	struct list_head                fp_entry;
+	struct list_head                interim_entry;
+};
+
+#define WORK_CANCELLED(w)	((w)->state == KSMBD_WORK_CANCELLED)
+#define WORK_CLOSED(w)		((w)->state == KSMBD_WORK_CLOSED)
+#define WORK_ACTIVE(w)		((w)->state == KSMBD_WORK_ACTIVE)
+
+#define RESPONSE_BUF(w)		((void *)(w)->response_buf)
+#define REQUEST_BUF(w)		((void *)(w)->request_buf)
+
+#define RESPONSE_BUF_NEXT(w)	\
+	((void *)((w)->response_buf + (w)->next_smb2_rsp_hdr_off))
+#define REQUEST_BUF_NEXT(w)	\
+	((void *)((w)->request_buf + (w)->next_smb2_rcv_hdr_off))
+
+#define RESPONSE_SZ(w)		((w)->response_sz)
+
+#define INIT_AUX_PAYLOAD(w)	((w)->aux_payload_buf = NULL)
+#define HAS_AUX_PAYLOAD(w)	((w)->aux_payload_sz != 0)
+#define AUX_PAYLOAD(w)		((void *)((w)->aux_payload_buf))
+#define AUX_PAYLOAD_SIZE(w)	((w)->aux_payload_sz)
+#define RESP_HDR_SIZE(w)	((w)->resp_hdr_sz)
+
+#define HAS_TRANSFORM_BUF(w)	((w)->tr_buf != NULL)
+#define TRANSFORM_BUF(w)	((void *)((w)->tr_buf))
+
+struct ksmbd_work *ksmbd_alloc_work_struct(void);
+void ksmbd_free_work_struct(struct ksmbd_work *work);
+
+void ksmbd_work_pool_destroy(void);
+int ksmbd_work_pool_init(void);
+
+int ksmbd_workqueue_init(void);
+void ksmbd_workqueue_destroy(void);
+bool ksmbd_queue_work(struct ksmbd_work *work);
+
+#endif /* __KSMBD_WORK_H__ */
diff --git a/fs/cifsd/server.c b/fs/cifsd/server.c
new file mode 100644
index 000000000000..85862c3ea7c0
--- /dev/null
+++ b/fs/cifsd/server.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include "glob.h"
+#include "oplock.h"
+#include "misc.h"
+#include <linux/sched/signal.h>
+#include <linux/workqueue.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "server.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "transport_ipc.h"
+#include "mgmt/user_session.h"
+#include "crypto_ctx.h"
+#include "auth.h"
+
+int ksmbd_debug_types;
+
+struct ksmbd_server_config server_conf;
+
+enum SERVER_CTRL_TYPE {
+	SERVER_CTRL_TYPE_INIT,
+	SERVER_CTRL_TYPE_RESET,
+};
+
+struct server_ctrl_struct {
+	int			type;
+	struct work_struct	ctrl_work;
+};
+
+static DEFINE_MUTEX(ctrl_lock);
+
+static int ___server_conf_set(int idx, char *val)
+{
+	if (idx >= ARRAY_SIZE(server_conf.conf))
+		return -EINVAL;
+
+	if (!val || val[0] == 0x00)
+		return -EINVAL;
+
+	kfree(server_conf.conf[idx]);
+	server_conf.conf[idx] = kstrdup(val, GFP_KERNEL);
+	if (!server_conf.conf[idx])
+		return -ENOMEM;
+	return 0;
+}
+
+int ksmbd_set_netbios_name(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_NETBIOS_NAME, v);
+}
+
+int ksmbd_set_server_string(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_SERVER_STRING, v);
+}
+
+int ksmbd_set_work_group(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_WORK_GROUP, v);
+}
+
+char *ksmbd_netbios_name(void)
+{
+	return server_conf.conf[SERVER_CONF_NETBIOS_NAME];
+}
+
+char *ksmbd_server_string(void)
+{
+	return server_conf.conf[SERVER_CONF_SERVER_STRING];
+}
+
+char *ksmbd_work_group(void)
+{
+	return server_conf.conf[SERVER_CONF_WORK_GROUP];
+}
+
+/**
+ * check_conn_state() - check state of server thread connection
+ * @work:     smb work containing server thread information
+ *
+ * Return:	0 on valid connection, otherwise 1 to reconnect
+ */
+static inline int check_conn_state(struct ksmbd_work *work)
+{
+	struct smb_hdr *rsp_hdr;
+
+	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+		rsp_hdr = RESPONSE_BUF(work);
+		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
+		return 1;
+	}
+	return 0;
+}
+
+#define TCP_HANDLER_CONTINUE	0
+#define TCP_HANDLER_ABORT	1
+
+static int __process_request(struct ksmbd_work *work,
+			     struct ksmbd_conn *conn,
+			     uint16_t *cmd)
+{
+	struct smb_version_cmds *cmds;
+	uint16_t command;
+	int ret;
+
+	if (check_conn_state(work))
+		return TCP_HANDLER_CONTINUE;
+
+	if (ksmbd_verify_smb_message(work))
+		return TCP_HANDLER_ABORT;
+
+	command = conn->ops->get_cmd_val(work);
+	*cmd = command;
+
+andx_again:
+	if (command >= conn->max_cmds) {
+		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
+		return TCP_HANDLER_CONTINUE;
+	}
+
+	cmds = &conn->cmds[command];
+	if (!cmds->proc) {
+		ksmbd_debug(SMB, "*** not implemented yet cmd = %x\n", command);
+		conn->ops->set_rsp_status(work, STATUS_NOT_IMPLEMENTED);
+		return TCP_HANDLER_CONTINUE;
+	}
+
+	if (work->sess && conn->ops->is_sign_req(work, command)) {
+		ret = conn->ops->check_sign_req(work);
+		if (!ret) {
+			conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
+			return TCP_HANDLER_CONTINUE;
+		}
+	}
+
+	ret = cmds->proc(work);
+
+	if (ret < 0)
+		ksmbd_debug(CONN, "Failed to process %u [%d]\n", command, ret);
+	/* AndX commands - chained request can return positive values */
+	else if (ret > 0) {
+		command = ret;
+		*cmd = command;
+		goto andx_again;
+	}
+
+	if (work->send_no_response)
+		return TCP_HANDLER_ABORT;
+	return TCP_HANDLER_CONTINUE;
+}
+
+static void __handle_ksmbd_work(struct ksmbd_work *work,
+				struct ksmbd_conn *conn)
+{
+	uint16_t command = 0;
+	int rc;
+
+	if (conn->ops->allocate_rsp_buf(work))
+		return;
+
+	if (conn->ops->is_transform_hdr &&
+		conn->ops->is_transform_hdr(REQUEST_BUF(work))) {
+		rc = conn->ops->decrypt_req(work);
+		if (rc < 0) {
+			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			goto send;
+		}
+
+		work->encrypted = true;
+	}
+
+	rc = conn->ops->init_rsp_hdr(work);
+	if (rc) {
+		/* either uid or tid is not correct */
+		conn->ops->set_rsp_status(work, STATUS_INVALID_HANDLE);
+		goto send;
+	}
+
+	if (conn->ops->check_user_session) {
+		rc = conn->ops->check_user_session(work);
+		if (rc < 0) {
+			command = conn->ops->get_cmd_val(work);
+			conn->ops->set_rsp_status(work,
+					STATUS_USER_SESSION_DELETED);
+			goto send;
+		} else if (rc > 0) {
+			rc = conn->ops->get_ksmbd_tcon(work);
+			if (rc < 0) {
+				conn->ops->set_rsp_status(work,
+					STATUS_NETWORK_NAME_DELETED);
+				goto send;
+			}
+		}
+	}
+
+	do {
+		rc = __process_request(work, conn, &command);
+		if (rc == TCP_HANDLER_ABORT)
+			break;
+
+		/*
+		 * Call smb2_set_rsp_credits() function to set number of credits
+		 * granted in hdr of smb2 response.
+		 */
+		if (conn->ops->set_rsp_credits) {
+			spin_lock(&conn->credits_lock);
+			rc = conn->ops->set_rsp_credits(work);
+			spin_unlock(&conn->credits_lock);
+			if (rc < 0) {
+				conn->ops->set_rsp_status(work,
+					STATUS_INVALID_PARAMETER);
+				goto send;
+			}
+		}
+
+		if (work->sess && (work->sess->sign ||
+		     smb3_11_final_sess_setup_resp(work) ||
+		     conn->ops->is_sign_req(work, command)))
+			conn->ops->set_sign_rsp(work);
+	} while (is_chained_smb2_message(work));
+
+	if (work->send_no_response)
+		return;
+
+send:
+	smb3_preauth_hash_rsp(work);
+	if (work->sess && work->sess->enc && work->encrypted &&
+		conn->ops->encrypt_resp) {
+		rc = conn->ops->encrypt_resp(work);
+		if (rc < 0) {
+			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			goto send;
+		}
+	}
+
+	ksmbd_conn_write(work);
+}
+
+/**
+ * handle_ksmbd_work() - process pending smb work requests
+ * @wk:	smb work containing request command buffer
+ *
+ * called by kworker threads to processing remaining smb work requests
+ */
+static void handle_ksmbd_work(struct work_struct *wk)
+{
+	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
+	struct ksmbd_conn *conn = work->conn;
+
+	atomic64_inc(&conn->stats.request_served);
+
+	__handle_ksmbd_work(work, conn);
+
+	ksmbd_conn_try_dequeue_request(work);
+	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->r_count);
+}
+
+/**
+ * queue_ksmbd_work() - queue a smb request to worker thread queue
+ *		for proccessing smb command and sending response
+ * @conn:	connection instance
+ *
+ * read remaining data from socket create and submit work.
+ */
+static int queue_ksmbd_work(struct ksmbd_conn *conn)
+{
+	struct ksmbd_work *work;
+
+	work = ksmbd_alloc_work_struct();
+	if (!work) {
+		ksmbd_err("allocation for work failed\n");
+		return -ENOMEM;
+	}
+
+	work->conn = conn;
+	work->request_buf = conn->request_buf;
+	conn->request_buf = NULL;
+
+	if (ksmbd_init_smb_server(work)) {
+		ksmbd_free_work_struct(work);
+		return -EINVAL;
+	}
+
+	ksmbd_conn_enqueue_request(work);
+	atomic_inc(&conn->r_count);
+	/* update activity on connection */
+	conn->last_active = jiffies;
+	INIT_WORK(&work->work, handle_ksmbd_work);
+	ksmbd_queue_work(work);
+	return 0;
+}
+
+static int ksmbd_server_process_request(struct ksmbd_conn *conn)
+{
+	return queue_ksmbd_work(conn);
+}
+
+static int ksmbd_server_terminate_conn(struct ksmbd_conn *conn)
+{
+	ksmbd_sessions_deregister(conn);
+	destroy_lease_table(conn);
+	return 0;
+}
+
+static void ksmbd_server_tcp_callbacks_init(void)
+{
+	struct ksmbd_conn_ops ops;
+
+	ops.process_fn = ksmbd_server_process_request;
+	ops.terminate_fn = ksmbd_server_terminate_conn;
+
+	ksmbd_conn_init_server_callbacks(&ops);
+}
+
+static void server_conf_free(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(server_conf.conf); i++) {
+		kfree(server_conf.conf[i]);
+		server_conf.conf[i] = NULL;
+	}
+}
+
+static int server_conf_init(void)
+{
+	WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
+	server_conf.enforced_signing = 0;
+	server_conf.min_protocol = ksmbd_min_protocol();
+	server_conf.max_protocol = ksmbd_max_protocol();
+	server_conf.auth_mechs = KSMBD_AUTH_NTLMSSP;
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+	server_conf.auth_mechs |= KSMBD_AUTH_KRB5 |
+				KSMBD_AUTH_MSKRB5;
+#endif
+	return 0;
+}
+
+static void server_ctrl_handle_init(struct server_ctrl_struct *ctrl)
+{
+	int ret;
+
+	ret = ksmbd_conn_transport_init();
+	if (ret) {
+		server_queue_ctrl_reset_work();
+		return;
+	}
+
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RUNNING);
+}
+
+static void server_ctrl_handle_reset(struct server_ctrl_struct *ctrl)
+{
+	ksmbd_ipc_soft_reset();
+	ksmbd_conn_transport_destroy();
+	server_conf_free();
+	server_conf_init();
+	WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
+}
+
+static void server_ctrl_handle_work(struct work_struct *work)
+{
+	struct server_ctrl_struct *ctrl;
+
+	ctrl = container_of(work, struct server_ctrl_struct, ctrl_work);
+
+	mutex_lock(&ctrl_lock);
+	switch (ctrl->type) {
+	case SERVER_CTRL_TYPE_INIT:
+		server_ctrl_handle_init(ctrl);
+		break;
+	case SERVER_CTRL_TYPE_RESET:
+		server_ctrl_handle_reset(ctrl);
+		break;
+	default:
+		pr_err("Unknown server work type: %d\n", ctrl->type);
+	}
+	mutex_unlock(&ctrl_lock);
+	kfree(ctrl);
+	module_put(THIS_MODULE);
+}
+
+static int __queue_ctrl_work(int type)
+{
+	struct server_ctrl_struct *ctrl;
+
+	ctrl = kmalloc(sizeof(struct server_ctrl_struct), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	__module_get(THIS_MODULE);
+	ctrl->type = type;
+	INIT_WORK(&ctrl->ctrl_work, server_ctrl_handle_work);
+	queue_work(system_long_wq, &ctrl->ctrl_work);
+	return 0;
+}
+
+int server_queue_ctrl_init_work(void)
+{
+	return __queue_ctrl_work(SERVER_CTRL_TYPE_INIT);
+}
+
+int server_queue_ctrl_reset_work(void)
+{
+	return __queue_ctrl_work(SERVER_CTRL_TYPE_RESET);
+}
+
+static ssize_t stats_show(struct class *class,
+			  struct class_attribute *attr,
+			  char *buf)
+{
+	/*
+	 * Inc this each time you change stats output format,
+	 * so user space will know what to do.
+	 */
+	static int stats_version = 2;
+	static const char * const state[] = {
+		"startup",
+		"running",
+		"reset",
+		"shutdown"
+	};
+
+	ssize_t sz = scnprintf(buf,
+				PAGE_SIZE,
+				"%d %s %d %lu\n",
+				stats_version,
+				state[server_conf.state],
+				server_conf.tcp_port,
+				server_conf.ipc_last_active / HZ);
+	return sz;
+}
+
+static ssize_t kill_server_store(struct class *class,
+				 struct class_attribute *attr,
+				 const char *buf,
+				 size_t len)
+{
+	if (!sysfs_streq(buf, "hard"))
+		return len;
+
+	ksmbd_info("kill command received\n");
+	mutex_lock(&ctrl_lock);
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RESETTING);
+	__module_get(THIS_MODULE);
+	server_ctrl_handle_reset(NULL);
+	module_put(THIS_MODULE);
+	mutex_unlock(&ctrl_lock);
+	return len;
+}
+
+static const char * const debug_type_strings[] = {"smb", "auth", "vfs",
+						"oplock", "ipc", "conn",
+						"rdma"};
+
+static ssize_t debug_show(struct class *class,
+		struct class_attribute *attr,
+		char *buf)
+{
+	ssize_t sz = 0;
+	int i, pos = 0;
+
+	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
+		if ((ksmbd_debug_types >> i) & 1) {
+			pos = scnprintf(buf + sz,
+					PAGE_SIZE - sz,
+					"[%s] ",
+					debug_type_strings[i]);
+		} else {
+			pos = scnprintf(buf + sz,
+					PAGE_SIZE - sz,
+					"%s ",
+					debug_type_strings[i]);
+		}
+		sz += pos;
+
+	}
+	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
+	return sz;
+}
+
+static ssize_t debug_store(struct class *class,
+		struct class_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
+		if (sysfs_streq(buf, "all")) {
+			if (ksmbd_debug_types == KSMBD_DEBUG_ALL)
+				ksmbd_debug_types = 0;
+			else
+				ksmbd_debug_types = KSMBD_DEBUG_ALL;
+			break;
+		}
+
+		if (sysfs_streq(buf, debug_type_strings[i])) {
+			if (ksmbd_debug_types & (1 << i))
+				ksmbd_debug_types &= ~(1 << i);
+			else
+				ksmbd_debug_types |= (1 << i);
+			break;
+		}
+	}
+
+	return len;
+}
+
+static CLASS_ATTR_RO(stats);
+static CLASS_ATTR_WO(kill_server);
+static CLASS_ATTR_RW(debug);
+
+static struct attribute *ksmbd_control_class_attrs[] = {
+	&class_attr_stats.attr,
+	&class_attr_kill_server.attr,
+	&class_attr_debug.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ksmbd_control_class);
+
+static struct class ksmbd_control_class = {
+	.name		= "ksmbd-control",
+	.owner		= THIS_MODULE,
+	.class_groups	= ksmbd_control_class_groups,
+};
+
+static int ksmbd_server_shutdown(void)
+{
+	WRITE_ONCE(server_conf.state, SERVER_STATE_SHUTTING_DOWN);
+
+	class_unregister(&ksmbd_control_class);
+	ksmbd_workqueue_destroy();
+	ksmbd_ipc_release();
+	ksmbd_conn_transport_destroy();
+	ksmbd_free_session_table();
+	ksmbd_crypto_destroy();
+	ksmbd_free_global_file_table();
+	destroy_lease_table(NULL);
+	ksmbd_destroy_buffer_pools();
+	server_conf_free();
+	return 0;
+}
+
+static int __init ksmbd_server_init(void)
+{
+	int ret;
+
+	ret = class_register(&ksmbd_control_class);
+	if (ret) {
+		ksmbd_err("Unable to register ksmbd-control class\n");
+		return ret;
+	}
+
+	ksmbd_server_tcp_callbacks_init();
+
+	ret = server_conf_init();
+	if (ret)
+		return ret;
+
+	ret = ksmbd_init_buffer_pools();
+	if (ret)
+		return ret;
+
+	ret = ksmbd_init_session_table();
+	if (ret)
+		goto error;
+
+	ret = ksmbd_ipc_init();
+	if (ret)
+		goto error;
+
+	ret = ksmbd_init_global_file_table();
+	if (ret)
+		goto error;
+
+	ret = ksmbd_inode_hash_init();
+	if (ret)
+		goto error;
+
+	ret = ksmbd_crypto_create();
+	if (ret)
+		goto error;
+
+	ret = ksmbd_workqueue_init();
+	if (ret)
+		goto error;
+	return 0;
+
+error:
+	ksmbd_server_shutdown();
+	return ret;
+}
+
+/**
+ * ksmbd_server_exit() - shutdown forker thread and free memory at module exit
+ */
+static void __exit ksmbd_server_exit(void)
+{
+	ksmbd_server_shutdown();
+	ksmbd_release_inode_hash();
+}
+
+MODULE_AUTHOR("Namjae Jeon <linkinjeon@kernel.org>");
+MODULE_VERSION(KSMBD_VERSION);
+MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: ecb");
+MODULE_SOFTDEP("pre: hmac");
+MODULE_SOFTDEP("pre: md4");
+MODULE_SOFTDEP("pre: md5");
+MODULE_SOFTDEP("pre: nls");
+MODULE_SOFTDEP("pre: aes");
+MODULE_SOFTDEP("pre: cmac");
+MODULE_SOFTDEP("pre: sha256");
+MODULE_SOFTDEP("pre: sha512");
+MODULE_SOFTDEP("pre: aead2");
+MODULE_SOFTDEP("pre: ccm");
+MODULE_SOFTDEP("pre: gcm");
+module_init(ksmbd_server_init)
+module_exit(ksmbd_server_exit)
diff --git a/fs/cifsd/server.h b/fs/cifsd/server.h
new file mode 100644
index 000000000000..7b2f6318fcff
--- /dev/null
+++ b/fs/cifsd/server.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __SERVER_H__
+#define __SERVER_H__
+
+#include "smbacl.h"
+
+#define SERVER_STATE_STARTING_UP	0
+#define SERVER_STATE_RUNNING		1
+#define SERVER_STATE_RESETTING		2
+#define SERVER_STATE_SHUTTING_DOWN	3
+
+#define SERVER_CONF_NETBIOS_NAME	0
+#define SERVER_CONF_SERVER_STRING	1
+#define SERVER_CONF_WORK_GROUP		2
+
+extern int ksmbd_debugging;
+
+struct ksmbd_server_config {
+	unsigned int		flags;
+	unsigned int		state;
+	short			signing;
+	short			enforced_signing;
+	short			min_protocol;
+	short			max_protocol;
+	unsigned short		tcp_port;
+	unsigned short		ipc_timeout;
+	unsigned long		ipc_last_active;
+	unsigned long		deadtime;
+	unsigned int		share_fake_fscaps;
+	struct smb_sid		domain_sid;
+	unsigned int		auth_mechs;
+
+	char			*conf[SERVER_CONF_WORK_GROUP + 1];
+};
+
+extern struct ksmbd_server_config server_conf;
+
+int ksmbd_set_netbios_name(char *v);
+int ksmbd_set_server_string(char *v);
+int ksmbd_set_work_group(char *v);
+
+char *ksmbd_netbios_name(void);
+char *ksmbd_server_string(void);
+char *ksmbd_work_group(void);
+
+static inline int ksmbd_server_running(void)
+{
+	return READ_ONCE(server_conf.state) == SERVER_STATE_RUNNING;
+}
+
+static inline int ksmbd_server_configurable(void)
+{
+	return READ_ONCE(server_conf.state) < SERVER_STATE_RESETTING;
+}
+
+int server_queue_ctrl_init_work(void);
+int server_queue_ctrl_reset_work(void);
+#endif /* __SERVER_H__ */
diff --git a/fs/cifsd/transport_ipc.c b/fs/cifsd/transport_ipc.c
new file mode 100644
index 000000000000..c49e46fda9b1
--- /dev/null
+++ b/fs/cifsd/transport_ipc.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/jhash.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/hashtable.h>
+#include <net/net_namespace.h>
+#include <net/genetlink.h>
+#include <linux/socket.h>
+#include <linux/workqueue.h>
+
+#include "vfs_cache.h"
+#include "transport_ipc.h"
+#include "buffer_pool.h"
+#include "server.h"
+#include "smb_common.h"
+
+#include "mgmt/user_config.h"
+#include "mgmt/share_config.h"
+#include "mgmt/user_session.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/ksmbd_ida.h"
+#include "connection.h"
+#include "transport_tcp.h"
+
+#define IPC_WAIT_TIMEOUT	(2 * HZ)
+
+#define IPC_MSG_HASH_BITS	3
+static DEFINE_HASHTABLE(ipc_msg_table, IPC_MSG_HASH_BITS);
+static DECLARE_RWSEM(ipc_msg_table_lock);
+static DEFINE_MUTEX(startup_lock);
+
+static struct ksmbd_ida *ida;
+
+static unsigned int ksmbd_tools_pid;
+
+#define KSMBD_IPC_MSG_HANDLE(m)	(*(unsigned int *)m)
+
+static bool ksmbd_ipc_validate_version(struct genl_info *m)
+{
+	if (m->genlhdr->version != KSMBD_GENL_VERSION) {
+		ksmbd_err("%s. ksmbd: %d, kernel module: %d. %s.\n",
+			  "Daemon and kernel module version mismatch",
+			  m->genlhdr->version,
+			  KSMBD_GENL_VERSION,
+			  "User-space ksmbd should terminate");
+		return false;
+	}
+	return true;
+}
+
+struct ksmbd_ipc_msg {
+	unsigned int		type;
+	unsigned int		sz;
+	unsigned char		____payload[0];
+};
+
+#define KSMBD_IPC_MSG_PAYLOAD(m)					\
+	((void *)(((struct ksmbd_ipc_msg *)(m))->____payload))
+
+struct ipc_msg_table_entry {
+	unsigned int		handle;
+	unsigned int		type;
+	wait_queue_head_t	wait;
+	struct hlist_node	ipc_table_hlist;
+
+	void			*response;
+};
+
+static struct delayed_work ipc_timer_work;
+
+static int handle_startup_event(struct sk_buff *skb, struct genl_info *info);
+static int handle_unsupported_event(struct sk_buff *skb,
+				    struct genl_info *info);
+static int handle_generic_event(struct sk_buff *skb, struct genl_info *info);
+static int ksmbd_ipc_heartbeat_request(void);
+
+static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX] = {
+	[KSMBD_EVENT_UNSPEC] = {
+		.len = 0,
+	},
+	[KSMBD_EVENT_HEARTBEAT_REQUEST] = {
+		.len = sizeof(struct ksmbd_heartbeat),
+	},
+	[KSMBD_EVENT_STARTING_UP] = {
+		.len = sizeof(struct ksmbd_startup_request),
+	},
+	[KSMBD_EVENT_SHUTTING_DOWN] = {
+		.len = sizeof(struct ksmbd_shutdown_request),
+	},
+	[KSMBD_EVENT_LOGIN_REQUEST] = {
+		.len = sizeof(struct ksmbd_login_request),
+	},
+	[KSMBD_EVENT_LOGIN_RESPONSE] = {
+		.len = sizeof(struct ksmbd_login_response),
+	},
+	[KSMBD_EVENT_SHARE_CONFIG_REQUEST] = {
+		.len = sizeof(struct ksmbd_share_config_request),
+	},
+	[KSMBD_EVENT_SHARE_CONFIG_RESPONSE] = {
+		.len = sizeof(struct ksmbd_share_config_response),
+	},
+	[KSMBD_EVENT_TREE_CONNECT_REQUEST] = {
+		.len = sizeof(struct ksmbd_tree_connect_request),
+	},
+	[KSMBD_EVENT_TREE_CONNECT_RESPONSE] = {
+		.len = sizeof(struct ksmbd_tree_connect_response),
+	},
+	[KSMBD_EVENT_TREE_DISCONNECT_REQUEST] = {
+		.len = sizeof(struct ksmbd_tree_disconnect_request),
+	},
+	[KSMBD_EVENT_LOGOUT_REQUEST] = {
+		.len = sizeof(struct ksmbd_logout_request),
+	},
+	[KSMBD_EVENT_RPC_REQUEST] = {
+	},
+	[KSMBD_EVENT_RPC_RESPONSE] = {
+	},
+	[KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST] = {
+	},
+	[KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE] = {
+	},
+};
+
+static struct genl_ops ksmbd_genl_ops[] = {
+	{
+		.cmd	= KSMBD_EVENT_UNSPEC,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_HEARTBEAT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_STARTING_UP,
+		.doit	= handle_startup_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SHUTTING_DOWN,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_LOGIN_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_LOGIN_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SHARE_CONFIG_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SHARE_CONFIG_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_TREE_CONNECT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_TREE_CONNECT_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_TREE_DISCONNECT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_LOGOUT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_RPC_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_RPC_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+};
+
+static struct genl_family ksmbd_genl_family = {
+	.name		= KSMBD_GENL_NAME,
+	.version	= KSMBD_GENL_VERSION,
+	.hdrsize	= 0,
+	.maxattr	= KSMBD_EVENT_MAX,
+	.netnsok	= true,
+	.module		= THIS_MODULE,
+	.ops		= ksmbd_genl_ops,
+	.n_ops		= ARRAY_SIZE(ksmbd_genl_ops),
+};
+
+static void ksmbd_nl_init_fixup(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ksmbd_genl_ops); i++)
+		ksmbd_genl_ops[i].validate = GENL_DONT_VALIDATE_STRICT |
+						GENL_DONT_VALIDATE_DUMP;
+
+	ksmbd_genl_family.policy = ksmbd_nl_policy;
+}
+
+static int rpc_context_flags(struct ksmbd_session *sess)
+{
+	if (user_guest(sess->user))
+		return KSMBD_RPC_RESTRICTED_CONTEXT;
+	return 0;
+}
+
+static void ipc_update_last_active(void)
+{
+	if (server_conf.ipc_timeout)
+		server_conf.ipc_last_active = jiffies;
+}
+
+static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
+
+	msg = ksmbd_alloc(msg_sz);
+	if (msg)
+		msg->sz = sz;
+	return msg;
+}
+
+static void ipc_msg_free(struct ksmbd_ipc_msg *msg)
+{
+	ksmbd_free(msg);
+}
+
+static void ipc_msg_handle_free(int handle)
+{
+	if (handle >= 0)
+		ksmbd_release_id(ida, handle);
+}
+
+static int handle_response(int type, void *payload, size_t sz)
+{
+	int handle = KSMBD_IPC_MSG_HANDLE(payload);
+	struct ipc_msg_table_entry *entry;
+	int ret = 0;
+
+	ipc_update_last_active();
+	down_read(&ipc_msg_table_lock);
+	hash_for_each_possible(ipc_msg_table, entry, ipc_table_hlist, handle) {
+		if (handle != entry->handle)
+			continue;
+
+		entry->response = NULL;
+		/*
+		 * Response message type value should be equal to
+		 * request message type + 1.
+		 */
+		if (entry->type + 1 != type) {
+			ksmbd_err("Waiting for IPC type %d, got %d. Ignore.\n",
+				entry->type + 1, type);
+		}
+
+		entry->response = ksmbd_alloc(sz);
+		if (!entry->response) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		memcpy(entry->response, payload, sz);
+		wake_up_interruptible(&entry->wait);
+		ret = 0;
+		break;
+	}
+	up_read(&ipc_msg_table_lock);
+
+	return ret;
+}
+
+static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
+{
+	int ret;
+
+	ksmbd_set_fd_limit(req->file_max);
+	server_conf.flags = req->flags;
+	server_conf.signing = req->signing;
+	server_conf.tcp_port = req->tcp_port;
+	server_conf.ipc_timeout = req->ipc_timeout * HZ;
+	server_conf.deadtime = req->deadtime * SMB_ECHO_INTERVAL;
+	server_conf.share_fake_fscaps = req->share_fake_fscaps;
+	ksmbd_init_domain(req->sub_auth);
+
+	if (req->smb2_max_read)
+		init_smb2_max_read_size(req->smb2_max_read);
+	if (req->smb2_max_write)
+		init_smb2_max_write_size(req->smb2_max_write);
+	if (req->smb2_max_trans)
+		init_smb2_max_trans_size(req->smb2_max_trans);
+
+	ret = ksmbd_set_netbios_name(req->netbios_name);
+	ret |= ksmbd_set_server_string(req->server_string);
+	ret |= ksmbd_set_work_group(req->work_group);
+	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
+					req->ifc_list_sz);
+	if (ret) {
+		ksmbd_err("Server configuration error: %s %s %s\n",
+				req->netbios_name,
+				req->server_string,
+				req->work_group);
+		return ret;
+	}
+
+	if (req->min_prot[0]) {
+		ret = ksmbd_lookup_protocol_idx(req->min_prot);
+		if (ret >= 0)
+			server_conf.min_protocol = ret;
+	}
+	if (req->max_prot[0]) {
+		ret = ksmbd_lookup_protocol_idx(req->max_prot);
+		if (ret >= 0)
+			server_conf.max_protocol = ret;
+	}
+
+	if (server_conf.ipc_timeout)
+		schedule_delayed_work(&ipc_timer_work, server_conf.ipc_timeout);
+	return 0;
+}
+
+static int handle_startup_event(struct sk_buff *skb, struct genl_info *info)
+{
+	int ret = 0;
+
+#ifdef CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+#endif
+
+	if (!ksmbd_ipc_validate_version(info))
+		return -EINVAL;
+
+	if (!info->attrs[KSMBD_EVENT_STARTING_UP])
+		return -EINVAL;
+
+	mutex_lock(&startup_lock);
+	if (!ksmbd_server_configurable()) {
+		mutex_unlock(&startup_lock);
+		ksmbd_err("Server reset is in progress, can't start daemon\n");
+		return -EINVAL;
+	}
+
+	if (ksmbd_tools_pid) {
+		if (ksmbd_ipc_heartbeat_request() == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ksmbd_err("Reconnect to a new user space daemon\n");
+	} else {
+		struct ksmbd_startup_request *req;
+
+		req = nla_data(info->attrs[info->genlhdr->cmd]);
+		ret = ipc_server_config_on_startup(req);
+		if (ret)
+			goto out;
+		server_queue_ctrl_init_work();
+	}
+
+	ksmbd_tools_pid = info->snd_portid;
+	ipc_update_last_active();
+
+out:
+	mutex_unlock(&startup_lock);
+	return ret;
+}
+
+static int handle_unsupported_event(struct sk_buff *skb,
+				    struct genl_info *info)
+{
+	ksmbd_err("Unknown IPC event: %d, ignore.\n", info->genlhdr->cmd);
+	return -EINVAL;
+}
+
+static int handle_generic_event(struct sk_buff *skb, struct genl_info *info)
+{
+	void *payload;
+	int sz;
+	int type = info->genlhdr->cmd;
+
+#ifdef CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+#endif
+
+	if (type >= KSMBD_EVENT_MAX) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (!ksmbd_ipc_validate_version(info))
+		return -EINVAL;
+
+	if (!info->attrs[type])
+		return -EINVAL;
+
+	payload = nla_data(info->attrs[info->genlhdr->cmd]);
+	sz = nla_len(info->attrs[info->genlhdr->cmd]);
+	return handle_response(type, payload, sz);
+}
+
+static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
+{
+	struct genlmsghdr *nlh;
+	struct sk_buff *skb;
+	int ret = -EINVAL;
+
+	if (!ksmbd_tools_pid)
+		return ret;
+
+	skb = genlmsg_new(msg->sz, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	nlh = genlmsg_put(skb, 0, 0, &ksmbd_genl_family, 0, msg->type);
+	if (!nlh)
+		goto out;
+
+	ret = nla_put(skb, msg->type, msg->sz, KSMBD_IPC_MSG_PAYLOAD(msg));
+	if (ret) {
+		genlmsg_cancel(skb, nlh);
+		goto out;
+	}
+
+	genlmsg_end(skb, nlh);
+	ret = genlmsg_unicast(&init_net, skb, ksmbd_tools_pid);
+	if (!ret)
+		ipc_update_last_active();
+	return ret;
+
+out:
+	nlmsg_free(skb);
+	return ret;
+}
+
+static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg,
+				  unsigned int handle)
+{
+	struct ipc_msg_table_entry entry;
+	int ret;
+
+	if ((int)handle < 0)
+		return NULL;
+
+	entry.type = msg->type;
+	entry.response = NULL;
+	init_waitqueue_head(&entry.wait);
+
+	down_write(&ipc_msg_table_lock);
+	entry.handle = handle;
+	hash_add(ipc_msg_table, &entry.ipc_table_hlist, entry.handle);
+	up_write(&ipc_msg_table_lock);
+
+	ret = ipc_msg_send(msg);
+	if (ret)
+		goto out;
+
+	ret = wait_event_interruptible_timeout(entry.wait,
+					       entry.response != NULL,
+					       IPC_WAIT_TIMEOUT);
+out:
+	down_write(&ipc_msg_table_lock);
+	hash_del(&entry.ipc_table_hlist);
+	up_write(&ipc_msg_table_lock);
+	return entry.response;
+}
+
+static int ksmbd_ipc_heartbeat_request(void)
+{
+	struct ksmbd_ipc_msg *msg;
+	int ret;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_heartbeat));
+	if (!msg)
+		return -EINVAL;
+
+	msg->type = KSMBD_EVENT_HEARTBEAT_REQUEST;
+	ret = ipc_msg_send(msg);
+	ipc_msg_free(msg);
+	return ret;
+}
+
+struct ksmbd_login_response *ksmbd_ipc_login_request(const char *account)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_login_request *req;
+	struct ksmbd_login_response *resp;
+
+	if (strlen(account) >= KSMBD_REQ_MAX_ACCOUNT_NAME_SZ)
+		return NULL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_login_request));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_LOGIN_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(ida);
+	strscpy(req->account, account, KSMBD_REQ_MAX_ACCOUNT_NAME_SZ);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_spnego_authen_response *
+ksmbd_ipc_spnego_authen_request(const char *spnego_blob, int blob_len)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_spnego_authen_request *req;
+	struct ksmbd_spnego_authen_response *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_spnego_authen_request) +
+			blob_len + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(ida);
+	req->spnego_blob_len = blob_len;
+	memcpy(req->spnego_blob, spnego_blob, blob_len);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_tree_connect_response *
+ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
+			       struct ksmbd_share_config *share,
+			       struct ksmbd_tree_connect *tree_conn,
+			       struct sockaddr *peer_addr)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_tree_connect_request *req;
+	struct ksmbd_tree_connect_response *resp;
+
+	if (strlen(user_name(sess->user)) >= KSMBD_REQ_MAX_ACCOUNT_NAME_SZ)
+		return NULL;
+
+	if (strlen(share->name) >= KSMBD_REQ_MAX_SHARE_NAME)
+		return NULL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_tree_connect_request));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_TREE_CONNECT_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+
+	req->handle = ksmbd_acquire_id(ida);
+	req->account_flags = sess->user->flags;
+	req->session_id = sess->id;
+	req->connect_id = tree_conn->id;
+	strscpy(req->account, user_name(sess->user), KSMBD_REQ_MAX_ACCOUNT_NAME_SZ);
+	strscpy(req->share, share->name, KSMBD_REQ_MAX_SHARE_NAME);
+	snprintf(req->peer_addr, sizeof(req->peer_addr), "%pIS", peer_addr);
+
+	if (peer_addr->sa_family == AF_INET6)
+		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_IPV6;
+	if (test_session_flag(sess, CIFDS_SESSION_FLAG_SMB2))
+		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_SMB2;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+int ksmbd_ipc_tree_disconnect_request(unsigned long long session_id,
+				      unsigned long long connect_id)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_tree_disconnect_request *req;
+	int ret;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_tree_disconnect_request));
+	if (!msg)
+		return -ENOMEM;
+
+	msg->type = KSMBD_EVENT_TREE_DISCONNECT_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->session_id = session_id;
+	req->connect_id = connect_id;
+
+	ret = ipc_msg_send(msg);
+	ipc_msg_free(msg);
+	return ret;
+}
+
+int ksmbd_ipc_logout_request(const char *account)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_logout_request *req;
+	int ret;
+
+	if (strlen(account) >= KSMBD_REQ_MAX_ACCOUNT_NAME_SZ)
+		return -EINVAL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_logout_request));
+	if (!msg)
+		return -ENOMEM;
+
+	msg->type = KSMBD_EVENT_LOGOUT_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	strscpy(req->account, account, KSMBD_REQ_MAX_ACCOUNT_NAME_SZ);
+
+	ret = ipc_msg_send(msg);
+	ipc_msg_free(msg);
+	return ret;
+}
+
+struct ksmbd_share_config_response *
+ksmbd_ipc_share_config_request(const char *name)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_share_config_request *req;
+	struct ksmbd_share_config_response *resp;
+
+	if (strlen(name) >= KSMBD_REQ_MAX_SHARE_NAME)
+		return NULL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_share_config_request));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_SHARE_CONFIG_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(ida);
+	strscpy(req->share_name, name, KSMBD_REQ_MAX_SHARE_NAME);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_open(struct ksmbd_session *sess,
+					 int handle)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= KSMBD_RPC_OPEN_METHOD;
+	req->payload_sz = 0;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_close(struct ksmbd_session *sess,
+					  int handle)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= KSMBD_RPC_CLOSE_METHOD;
+	req->payload_sz = 0;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess,
+					  int handle,
+					  void *payload,
+					  size_t payload_sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_WRITE_METHOD;
+	req->payload_sz = payload_sz;
+	memcpy(req->payload, payload, payload_sz);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess,
+					 int handle)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_READ_METHOD;
+	req->payload_sz = 0;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess,
+					  int handle,
+					  void *payload,
+					  size_t payload_sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_IOCTL_METHOD;
+	req->payload_sz = payload_sz;
+	memcpy(req->payload, payload, payload_sz);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_rap(struct ksmbd_session *sess,
+					void *payload,
+					size_t payload_sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(ida);
+	req->flags = rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_RAP_METHOD;
+	req->payload_sz = payload_sz;
+	memcpy(req->payload, payload, payload_sz);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+static int __ipc_heartbeat(void)
+{
+	unsigned long delta;
+
+	if (!ksmbd_server_running())
+		return 0;
+
+	if (time_after(jiffies, server_conf.ipc_last_active)) {
+		delta = (jiffies - server_conf.ipc_last_active);
+	} else {
+		ipc_update_last_active();
+		schedule_delayed_work(&ipc_timer_work,
+				      server_conf.ipc_timeout);
+		return 0;
+	}
+
+	if (delta < server_conf.ipc_timeout) {
+		schedule_delayed_work(&ipc_timer_work,
+				      server_conf.ipc_timeout - delta);
+		return 0;
+	}
+
+	if (ksmbd_ipc_heartbeat_request() == 0) {
+		schedule_delayed_work(&ipc_timer_work,
+				      server_conf.ipc_timeout);
+		return 0;
+	}
+
+	mutex_lock(&startup_lock);
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RESETTING);
+	server_conf.ipc_last_active = 0;
+	ksmbd_tools_pid = 0;
+	ksmbd_err("No IPC daemon response for %lus\n", delta / HZ);
+	mutex_unlock(&startup_lock);
+	return -EINVAL;
+}
+
+static void ipc_timer_heartbeat(struct work_struct *w)
+{
+	if (__ipc_heartbeat())
+		server_queue_ctrl_reset_work();
+}
+
+int ksmbd_ipc_id_alloc(void)
+{
+	return ksmbd_acquire_id(ida);
+}
+
+void ksmbd_rpc_id_free(int handle)
+{
+	ksmbd_release_id(ida, handle);
+}
+
+void ksmbd_ipc_release(void)
+{
+	cancel_delayed_work_sync(&ipc_timer_work);
+	ksmbd_ida_free(ida);
+	genl_unregister_family(&ksmbd_genl_family);
+}
+
+void ksmbd_ipc_soft_reset(void)
+{
+	mutex_lock(&startup_lock);
+	ksmbd_tools_pid = 0;
+	cancel_delayed_work_sync(&ipc_timer_work);
+	mutex_unlock(&startup_lock);
+}
+
+int ksmbd_ipc_init(void)
+{
+	int ret;
+
+	ksmbd_nl_init_fixup();
+	INIT_DELAYED_WORK(&ipc_timer_work, ipc_timer_heartbeat);
+
+	ret = genl_register_family(&ksmbd_genl_family);
+	if (ret) {
+		ksmbd_err("Failed to register KSMBD netlink interface %d\n",
+				ret);
+		return ret;
+	}
+
+	ida = ksmbd_ida_alloc();
+	if (!ida)
+		return -ENOMEM;
+	return 0;
+}
diff --git a/fs/cifsd/transport_ipc.h b/fs/cifsd/transport_ipc.h
new file mode 100644
index 000000000000..6ed7cbea727e
--- /dev/null
+++ b/fs/cifsd/transport_ipc.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_TRANSPORT_IPC_H__
+#define __KSMBD_TRANSPORT_IPC_H__
+
+#include <linux/wait.h>
+
+#define KSMBD_IPC_MAX_PAYLOAD	4096
+
+struct ksmbd_login_response *
+ksmbd_ipc_login_request(const char *account);
+
+struct ksmbd_session;
+struct ksmbd_share_config;
+struct ksmbd_tree_connect;
+struct sockaddr;
+
+struct ksmbd_tree_connect_response *
+ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
+			       struct ksmbd_share_config *share,
+			       struct ksmbd_tree_connect *tree_conn,
+			       struct sockaddr *peer_addr);
+
+int ksmbd_ipc_tree_disconnect_request(unsigned long long session_id,
+				      unsigned long long connect_id);
+int ksmbd_ipc_logout_request(const char *account);
+
+struct ksmbd_share_config_response *
+ksmbd_ipc_share_config_request(const char *name);
+
+struct ksmbd_spnego_authen_response *
+ksmbd_ipc_spnego_authen_request(const char *spnego_blob, int blob_len);
+
+int ksmbd_ipc_id_alloc(void);
+void ksmbd_rpc_id_free(int handle);
+
+struct ksmbd_rpc_command *ksmbd_rpc_open(struct ksmbd_session *sess,
+					 int handle);
+struct ksmbd_rpc_command *ksmbd_rpc_close(struct ksmbd_session *sess,
+					  int handle);
+
+struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess,
+					  int handle,
+					  void *payload,
+					  size_t payload_sz);
+struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess,
+					 int handle);
+struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess,
+					  int handle,
+					  void *payload,
+					  size_t payload_sz);
+struct ksmbd_rpc_command *ksmbd_rpc_rap(struct ksmbd_session *sess,
+					  void *payload,
+					  size_t payload_sz);
+
+void ksmbd_ipc_release(void);
+void ksmbd_ipc_soft_reset(void);
+int ksmbd_ipc_init(void);
+#endif /* __KSMBD_TRANSPORT_IPC_H__ */
diff --git a/fs/cifsd/transport_rdma.c b/fs/cifsd/transport_rdma.c
new file mode 100644
index 000000000000..45b76847f1e7
--- /dev/null
+++ b/fs/cifsd/transport_rdma.c
@@ -0,0 +1,2051 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2017, Microsoft Corporation.
+ *   Copyright (C) 2018, LG Electronics.
+ *
+ *   Author(s): Long Li <longli@microsoft.com>,
+ *		Hyunchul Lee <hyc.lee@gmail.com>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ */
+
+#define SUBMOD_NAME	"smb_direct"
+
+#include <linux/kthread.h>
+#include <linux/rwlock.h>
+#include <linux/list.h>
+#include <linux/mempool.h>
+#include <linux/highmem.h>
+#include <linux/scatterlist.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/rdma_cm.h>
+#include <rdma/rw.h>
+
+#include "glob.h"
+#include "connection.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "buffer_pool.h"
+#include "transport_rdma.h"
+
+#define SMB_DIRECT_PORT	5445
+
+#define SMB_DIRECT_VERSION_LE		cpu_to_le16(0x0100)
+
+/* SMB_DIRECT negotiation timeout in seconds */
+#define SMB_DIRECT_NEGOTIATE_TIMEOUT		120
+
+#define SMB_DIRECT_MAX_SEND_SGES		8
+#define SMB_DIRECT_MAX_RECV_SGES		1
+
+/*
+ * Default maximum number of RDMA read/write outstanding on this connection
+ * This value is possibly decreased during QP creation on hardware limit
+ */
+#define SMB_DIRECT_CM_INITIATOR_DEPTH		8
+
+/* Maximum number of retries on data transfer operations */
+#define SMB_DIRECT_CM_RETRY			6
+/* No need to retry on Receiver Not Ready since SMB_DIRECT manages credits */
+#define SMB_DIRECT_CM_RNR_RETRY		0
+
+/*
+ * User configurable initial values per SMB_DIRECT transport connection
+ * as defined in [MS-KSMBD] 3.1.1.1
+ * Those may change after a SMB_DIRECT negotiation
+ */
+/* The local peer's maximum number of credits to grant to the peer */
+static int smb_direct_receive_credit_max = 255;
+
+/* The remote peer's credit request of local peer */
+static int smb_direct_send_credit_target = 255;
+
+/* The maximum single message size can be sent to remote peer */
+static int smb_direct_max_send_size = 8192;
+
+/*  The maximum fragmented upper-layer payload receive size supported */
+static int smb_direct_max_fragmented_recv_size = 1024 * 1024;
+
+/*  The maximum single-message size which can be received */
+static int smb_direct_max_receive_size = 8192;
+
+static int smb_direct_max_read_write_size = 1024 * 1024;
+
+static int smb_direct_max_outstanding_rw_ops = 8;
+
+static struct smb_direct_listener {
+	struct rdma_cm_id	*cm_id;
+} smb_direct_listener;
+
+
+static struct workqueue_struct *smb_direct_wq;
+
+enum smb_direct_status {
+	SMB_DIRECT_CS_NEW = 0,
+	SMB_DIRECT_CS_CONNECTED,
+	SMB_DIRECT_CS_DISCONNECTING,
+	SMB_DIRECT_CS_DISCONNECTED,
+};
+
+struct smb_direct_transport {
+	struct ksmbd_transport	transport;
+
+	enum smb_direct_status	status;
+	bool			full_packet_received;
+	wait_queue_head_t	wait_status;
+
+	struct rdma_cm_id	*cm_id;
+	struct ib_cq		*send_cq;
+	struct ib_cq		*recv_cq;
+	struct ib_pd		*pd;
+	struct ib_qp		*qp;
+
+	int			max_send_size;
+	int			max_recv_size;
+	int			max_fragmented_send_size;
+	int			max_fragmented_recv_size;
+	int			max_rdma_rw_size;
+
+	spinlock_t		reassembly_queue_lock;
+	struct list_head	reassembly_queue;
+	int			reassembly_data_length;
+	int			reassembly_queue_length;
+	int			first_entry_offset;
+	wait_queue_head_t	wait_reassembly_queue;
+
+	spinlock_t		receive_credit_lock;
+	int			recv_credits;
+	int			count_avail_recvmsg;
+	int			recv_credit_max;
+	int			recv_credit_target;
+
+	spinlock_t		recvmsg_queue_lock;
+	struct list_head	recvmsg_queue;
+
+	spinlock_t		empty_recvmsg_queue_lock;
+	struct list_head	empty_recvmsg_queue;
+
+	int			send_credit_target;
+	atomic_t		send_credits;
+	spinlock_t		lock_new_recv_credits;
+	int			new_recv_credits;
+	atomic_t		rw_avail_ops;
+
+	wait_queue_head_t	wait_send_credits;
+	wait_queue_head_t	wait_rw_avail_ops;
+
+	mempool_t		*sendmsg_mempool;
+	struct kmem_cache	*sendmsg_cache;
+	mempool_t		*recvmsg_mempool;
+	struct kmem_cache	*recvmsg_cache;
+
+	wait_queue_head_t	wait_send_payload_pending;
+	atomic_t		send_payload_pending;
+	wait_queue_head_t	wait_send_pending;
+	atomic_t		send_pending;
+
+	struct delayed_work	post_recv_credits_work;
+	struct work_struct	send_immediate_work;
+	struct work_struct	disconnect_work;
+
+	bool			negotiation_requested;
+};
+
+#define KSMBD_TRANS(t) ((struct ksmbd_transport *)&((t)->transport))
+#define SMB_DIRECT_TRANS(t) ((struct smb_direct_transport *)container_of(t, \
+				struct smb_direct_transport, transport))
+
+enum {
+	SMB_DIRECT_MSG_NEGOTIATE_REQ = 0,
+	SMB_DIRECT_MSG_DATA_TRANSFER
+};
+
+static struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops;
+
+struct smb_direct_send_ctx {
+	struct list_head	msg_list;
+	int			wr_cnt;
+	bool			need_invalidate_rkey;
+	unsigned int		remote_key;
+};
+
+struct smb_direct_sendmsg {
+	struct smb_direct_transport	*transport;
+	struct ib_send_wr	wr;
+	struct list_head	list;
+	int			num_sge;
+	struct ib_sge		sge[SMB_DIRECT_MAX_SEND_SGES];
+	struct ib_cqe		cqe;
+	u8			packet[];
+};
+
+struct smb_direct_recvmsg {
+	struct smb_direct_transport	*transport;
+	struct list_head	list;
+	int			type;
+	struct ib_sge		sge;
+	struct ib_cqe		cqe;
+	bool			first_segment;
+	u8			packet[];
+};
+
+struct smb_direct_rdma_rw_msg {
+	struct smb_direct_transport	*t;
+	struct ib_cqe		cqe;
+	struct completion	*completion;
+	struct rdma_rw_ctx	rw_ctx;
+	struct sg_table		sgt;
+	struct scatterlist	sg_list[0];
+};
+
+#define BUFFER_NR_PAGES(buf, len)					\
+		(DIV_ROUND_UP((unsigned long)(buf) + (len), PAGE_SIZE)	\
+			- (unsigned long)(buf) / PAGE_SIZE)
+
+static void smb_direct_destroy_pools(struct smb_direct_transport *transport);
+static void smb_direct_post_recv_credits(struct work_struct *work);
+static int smb_direct_post_send_data(struct smb_direct_transport *t,
+			struct smb_direct_send_ctx *send_ctx,
+			struct kvec *iov, int niov, int remaining_data_length);
+
+static inline void
+*smb_direct_recvmsg_payload(struct smb_direct_recvmsg *recvmsg)
+{
+	return (void *)recvmsg->packet;
+}
+
+static inline bool is_receive_credit_post_required(int receive_credits,
+			int avail_recvmsg_count)
+{
+	return receive_credits <= (smb_direct_receive_credit_max >> 3) &&
+		avail_recvmsg_count >= (receive_credits >> 2);
+}
+
+static struct
+smb_direct_recvmsg *get_free_recvmsg(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg = NULL;
+
+	spin_lock(&t->recvmsg_queue_lock);
+	if (!list_empty(&t->recvmsg_queue)) {
+		recvmsg = list_first_entry(&t->recvmsg_queue,
+					   struct smb_direct_recvmsg,
+					   list);
+		list_del(&recvmsg->list);
+	}
+	spin_unlock(&t->recvmsg_queue_lock);
+	return recvmsg;
+}
+
+static void put_recvmsg(struct smb_direct_transport *t,
+				struct smb_direct_recvmsg *recvmsg)
+{
+	ib_dma_unmap_single(t->cm_id->device, recvmsg->sge.addr,
+			recvmsg->sge.length, DMA_FROM_DEVICE);
+
+	spin_lock(&t->recvmsg_queue_lock);
+	list_add(&recvmsg->list, &t->recvmsg_queue);
+	spin_unlock(&t->recvmsg_queue_lock);
+
+}
+
+static struct
+smb_direct_recvmsg *get_empty_recvmsg(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg = NULL;
+
+	spin_lock(&t->empty_recvmsg_queue_lock);
+	if (!list_empty(&t->empty_recvmsg_queue)) {
+		recvmsg = list_first_entry(
+			&t->empty_recvmsg_queue,
+			struct smb_direct_recvmsg, list);
+		list_del(&recvmsg->list);
+	}
+	spin_unlock(&t->empty_recvmsg_queue_lock);
+	return recvmsg;
+}
+
+static void put_empty_recvmsg(struct smb_direct_transport *t,
+			struct smb_direct_recvmsg *recvmsg)
+{
+	ib_dma_unmap_single(t->cm_id->device, recvmsg->sge.addr,
+			recvmsg->sge.length, DMA_FROM_DEVICE);
+
+	spin_lock(&t->empty_recvmsg_queue_lock);
+	list_add_tail(&recvmsg->list, &t->empty_recvmsg_queue);
+	spin_unlock(&t->empty_recvmsg_queue_lock);
+}
+
+static void enqueue_reassembly(struct smb_direct_transport *t,
+					struct smb_direct_recvmsg *recvmsg,
+					int data_length)
+{
+	spin_lock(&t->reassembly_queue_lock);
+	list_add_tail(&recvmsg->list, &t->reassembly_queue);
+	t->reassembly_queue_length++;
+	/*
+	 * Make sure reassembly_data_length is updated after list and
+	 * reassembly_queue_length are updated. On the dequeue side
+	 * reassembly_data_length is checked without a lock to determine
+	 * if reassembly_queue_length and list is up to date
+	 */
+	virt_wmb();
+	t->reassembly_data_length += data_length;
+	spin_unlock(&t->reassembly_queue_lock);
+
+}
+
+static struct smb_direct_recvmsg *get_first_reassembly(
+				struct smb_direct_transport *t)
+{
+	if (!list_empty(&t->reassembly_queue))
+		return list_first_entry(&t->reassembly_queue,
+				struct smb_direct_recvmsg, list);
+	else
+		return NULL;
+}
+
+static void smb_direct_disconnect_rdma_work(struct work_struct *work)
+{
+	struct smb_direct_transport *t =
+		container_of(work, struct smb_direct_transport,
+			     disconnect_work);
+
+	if (t->status == SMB_DIRECT_CS_CONNECTED) {
+		t->status = SMB_DIRECT_CS_DISCONNECTING;
+		rdma_disconnect(t->cm_id);
+	}
+}
+
+static void
+smb_direct_disconnect_rdma_connection(struct smb_direct_transport *t)
+{
+	queue_work(smb_direct_wq, &t->disconnect_work);
+}
+
+static void smb_direct_send_immediate_work(struct work_struct *work)
+{
+	struct smb_direct_transport *t = container_of(work,
+			struct smb_direct_transport, send_immediate_work);
+
+	if (t->status != SMB_DIRECT_CS_CONNECTED)
+		return;
+
+	smb_direct_post_send_data(t, NULL, NULL, 0, 0);
+}
+
+static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
+{
+	struct smb_direct_transport *t;
+	struct ksmbd_conn *conn;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+
+	t->cm_id = cm_id;
+	cm_id->context = t;
+
+	t->status = SMB_DIRECT_CS_NEW;
+	init_waitqueue_head(&t->wait_status);
+
+	spin_lock_init(&t->reassembly_queue_lock);
+	INIT_LIST_HEAD(&t->reassembly_queue);
+	t->reassembly_data_length = 0;
+	t->reassembly_queue_length = 0;
+	init_waitqueue_head(&t->wait_reassembly_queue);
+	init_waitqueue_head(&t->wait_send_credits);
+	init_waitqueue_head(&t->wait_rw_avail_ops);
+
+	spin_lock_init(&t->receive_credit_lock);
+	spin_lock_init(&t->recvmsg_queue_lock);
+	INIT_LIST_HEAD(&t->recvmsg_queue);
+
+	spin_lock_init(&t->empty_recvmsg_queue_lock);
+	INIT_LIST_HEAD(&t->empty_recvmsg_queue);
+
+	init_waitqueue_head(&t->wait_send_payload_pending);
+	atomic_set(&t->send_payload_pending, 0);
+	init_waitqueue_head(&t->wait_send_pending);
+	atomic_set(&t->send_pending, 0);
+
+	spin_lock_init(&t->lock_new_recv_credits);
+
+	INIT_DELAYED_WORK(&t->post_recv_credits_work,
+			  smb_direct_post_recv_credits);
+	INIT_WORK(&t->send_immediate_work, smb_direct_send_immediate_work);
+	INIT_WORK(&t->disconnect_work, smb_direct_disconnect_rdma_work);
+
+	conn = ksmbd_conn_alloc();
+	if (!conn)
+		goto err;
+	conn->transport = KSMBD_TRANS(t);
+	KSMBD_TRANS(t)->conn = conn;
+	KSMBD_TRANS(t)->ops = &ksmbd_smb_direct_transport_ops;
+	return t;
+err:
+	kfree(t);
+	return NULL;
+}
+
+static void free_transport(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg;
+
+	wake_up_interruptible(&t->wait_send_credits);
+
+	ksmbd_debug(RDMA, "wait for all send posted to IB to finish\n");
+	wait_event(t->wait_send_payload_pending,
+		atomic_read(&t->send_payload_pending) == 0);
+	wait_event(t->wait_send_pending,
+		atomic_read(&t->send_pending) == 0);
+
+	cancel_work_sync(&t->disconnect_work);
+	cancel_delayed_work_sync(&t->post_recv_credits_work);
+	cancel_work_sync(&t->send_immediate_work);
+
+	if (t->qp) {
+		ib_drain_qp(t->qp);
+		ib_destroy_qp(t->qp);
+	}
+
+	ksmbd_debug(RDMA, "drain the reassembly queue\n");
+	do {
+		spin_lock(&t->reassembly_queue_lock);
+		recvmsg = get_first_reassembly(t);
+		if (recvmsg) {
+			list_del(&recvmsg->list);
+			spin_unlock(
+				&t->reassembly_queue_lock);
+			put_recvmsg(t, recvmsg);
+		} else
+			spin_unlock(&t->reassembly_queue_lock);
+	} while (recvmsg);
+	t->reassembly_data_length = 0;
+
+	if (t->send_cq)
+		ib_free_cq(t->send_cq);
+	if (t->recv_cq)
+		ib_free_cq(t->recv_cq);
+	if (t->pd)
+		ib_dealloc_pd(t->pd);
+	if (t->cm_id)
+		rdma_destroy_id(t->cm_id);
+
+	smb_direct_destroy_pools(t);
+	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+	kfree(t);
+}
+
+static struct smb_direct_sendmsg
+*smb_direct_alloc_sendmsg(struct smb_direct_transport *t)
+{
+	struct smb_direct_sendmsg *msg;
+
+	msg = mempool_alloc(t->sendmsg_mempool, GFP_KERNEL);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+	msg->transport = t;
+	INIT_LIST_HEAD(&msg->list);
+	msg->num_sge = 0;
+	return msg;
+}
+
+static void smb_direct_free_sendmsg(struct smb_direct_transport *t,
+			struct smb_direct_sendmsg *msg)
+{
+	int i;
+
+	if (msg->num_sge > 0) {
+		ib_dma_unmap_single(t->cm_id->device,
+				msg->sge[0].addr, msg->sge[0].length,
+				DMA_TO_DEVICE);
+		for (i = 1; i < msg->num_sge; i++)
+			ib_dma_unmap_page(t->cm_id->device,
+					msg->sge[i].addr, msg->sge[i].length,
+					DMA_TO_DEVICE);
+	}
+	mempool_free(msg, t->sendmsg_mempool);
+}
+
+static int smb_direct_check_recvmsg(struct smb_direct_recvmsg *recvmsg)
+{
+	switch (recvmsg->type) {
+	case SMB_DIRECT_MSG_DATA_TRANSFER: {
+		struct smb_direct_data_transfer *req =
+			(struct smb_direct_data_transfer *) recvmsg->packet;
+		struct smb2_hdr *hdr = (struct smb2_hdr *) (recvmsg->packet
+				+ le32_to_cpu(req->data_offset) - 4);
+		ksmbd_debug(RDMA,
+				"CreditGranted: %u, CreditRequested: %u, DataLength: %u, RemainingDataLength: %u, SMB: %x, Command: %u\n",
+				le16_to_cpu(req->credits_granted),
+				le16_to_cpu(req->credits_requested),
+				req->data_length, req->remaining_data_length,
+				hdr->ProtocolId, hdr->Command);
+		break;
+	}
+	case SMB_DIRECT_MSG_NEGOTIATE_REQ: {
+		struct smb_direct_negotiate_req *req =
+			(struct smb_direct_negotiate_req *)recvmsg->packet;
+		ksmbd_debug(RDMA,
+			"MinVersion: %u, MaxVersion: %u, CreditRequested: %u, MaxSendSize: %u, MaxRecvSize: %u, MaxFragmentedSize: %u\n",
+			le16_to_cpu(req->min_version),
+			le16_to_cpu(req->max_version),
+			le16_to_cpu(req->credits_requested),
+			le32_to_cpu(req->preferred_send_size),
+			le32_to_cpu(req->max_receive_size),
+			le32_to_cpu(req->max_fragmented_size));
+		if (le16_to_cpu(req->min_version) > 0x0100 ||
+				le16_to_cpu(req->max_version) < 0x0100)
+			return -EOPNOTSUPP;
+		if (le16_to_cpu(req->credits_requested) <= 0 ||
+				le32_to_cpu(req->max_receive_size) <= 128 ||
+				le32_to_cpu(req->max_fragmented_size) <=
+					128*1024)
+			return -ECONNABORTED;
+
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_transport *t;
+
+	recvmsg = container_of(wc->wr_cqe, struct smb_direct_recvmsg, cqe);
+	t = recvmsg->transport;
+
+	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
+		if (wc->status != IB_WC_WR_FLUSH_ERR) {
+			ksmbd_err("Recv error. status='%s (%d)' opcode=%d\n",
+				ib_wc_status_msg(wc->status), wc->status,
+				wc->opcode);
+			smb_direct_disconnect_rdma_connection(t);
+		}
+		put_empty_recvmsg(t, recvmsg);
+		return;
+	}
+
+	ksmbd_debug(RDMA, "Recv completed. status='%s (%d)', opcode=%d\n",
+			ib_wc_status_msg(wc->status), wc->status,
+			wc->opcode);
+
+	ib_dma_sync_single_for_cpu(wc->qp->device, recvmsg->sge.addr,
+			recvmsg->sge.length, DMA_FROM_DEVICE);
+
+	switch (recvmsg->type) {
+	case SMB_DIRECT_MSG_NEGOTIATE_REQ:
+		t->negotiation_requested = true;
+		t->full_packet_received = true;
+		wake_up_interruptible(&t->wait_status);
+		break;
+	case SMB_DIRECT_MSG_DATA_TRANSFER: {
+		struct smb_direct_data_transfer *data_transfer =
+			(struct smb_direct_data_transfer *)recvmsg->packet;
+		int data_length = le32_to_cpu(data_transfer->data_length);
+		int avail_recvmsg_count, receive_credits;
+
+		if (data_length) {
+			if (t->full_packet_received)
+				recvmsg->first_segment = true;
+
+			if (le32_to_cpu(data_transfer->remaining_data_length))
+				t->full_packet_received = false;
+			else
+				t->full_packet_received = true;
+
+			enqueue_reassembly(t, recvmsg, data_length);
+			wake_up_interruptible(&t->wait_reassembly_queue);
+
+			spin_lock(&t->receive_credit_lock);
+			receive_credits = --(t->recv_credits);
+			avail_recvmsg_count = t->count_avail_recvmsg;
+			spin_unlock(&t->receive_credit_lock);
+		} else {
+			put_empty_recvmsg(t, recvmsg);
+
+			spin_lock(&t->receive_credit_lock);
+			receive_credits = --(t->recv_credits);
+			avail_recvmsg_count = ++(t->count_avail_recvmsg);
+			spin_unlock(&t->receive_credit_lock);
+		}
+
+		t->recv_credit_target =
+				le16_to_cpu(data_transfer->credits_requested);
+		atomic_add(le16_to_cpu(data_transfer->credits_granted),
+				&t->send_credits);
+
+		if (le16_to_cpu(data_transfer->flags) &
+				SMB_DIRECT_RESPONSE_REQUESTED)
+			queue_work(smb_direct_wq, &t->send_immediate_work);
+
+		if (atomic_read(&t->send_credits) > 0)
+			wake_up_interruptible(&t->wait_send_credits);
+
+		if (is_receive_credit_post_required(receive_credits,
+					avail_recvmsg_count))
+			mod_delayed_work(smb_direct_wq,
+					&t->post_recv_credits_work, 0);
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static int smb_direct_post_recv(struct smb_direct_transport *t,
+			struct smb_direct_recvmsg *recvmsg)
+{
+	struct ib_recv_wr wr;
+	int ret;
+
+	recvmsg->sge.addr = ib_dma_map_single(t->cm_id->device,
+			recvmsg->packet, t->max_recv_size,
+			DMA_FROM_DEVICE);
+	ret = ib_dma_mapping_error(t->cm_id->device, recvmsg->sge.addr);
+	if (ret)
+		return ret;
+	recvmsg->sge.length = t->max_recv_size;
+	recvmsg->sge.lkey = t->pd->local_dma_lkey;
+	recvmsg->cqe.done = recv_done;
+
+	wr.wr_cqe = &recvmsg->cqe;
+	wr.next = NULL;
+	wr.sg_list = &recvmsg->sge;
+	wr.num_sge = 1;
+
+	ret = ib_post_recv(t->qp, &wr, NULL);
+	if (ret) {
+		ksmbd_err("Can't post recv: %d\n", ret);
+		ib_dma_unmap_single(t->cm_id->device,
+			recvmsg->sge.addr, recvmsg->sge.length,
+			DMA_FROM_DEVICE);
+		smb_direct_disconnect_rdma_connection(t);
+		return ret;
+	}
+	return ret;
+}
+
+static int smb_direct_read(struct ksmbd_transport *t, char *buf,
+		unsigned int size)
+{
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_data_transfer *data_transfer;
+	int to_copy, to_read, data_read, offset;
+	u32 data_length, remaining_data_length, data_offset;
+	int rc;
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+
+again:
+	if (st->status != SMB_DIRECT_CS_CONNECTED) {
+		ksmbd_err("disconnected\n");
+		return -ENOTCONN;
+	}
+
+	/*
+	 * No need to hold the reassembly queue lock all the time as we are
+	 * the only one reading from the front of the queue. The transport
+	 * may add more entries to the back of the queue at the same time
+	 */
+	if (st->reassembly_data_length >= size) {
+		int queue_length;
+		int queue_removed = 0;
+
+		/*
+		 * Need to make sure reassembly_data_length is read before
+		 * reading reassembly_queue_length and calling
+		 * get_first_reassembly. This call is lock free
+		 * as we never read at the end of the queue which are being
+		 * updated in SOFTIRQ as more data is received
+		 */
+		virt_rmb();
+		queue_length = st->reassembly_queue_length;
+		data_read = 0;
+		to_read = size;
+		offset = st->first_entry_offset;
+		while (data_read < size) {
+			recvmsg = get_first_reassembly(st);
+			data_transfer = smb_direct_recvmsg_payload(recvmsg);
+			data_length = le32_to_cpu(data_transfer->data_length);
+			remaining_data_length =
+				le32_to_cpu(
+					data_transfer->remaining_data_length);
+			data_offset = le32_to_cpu(data_transfer->data_offset);
+
+			/*
+			 * The upper layer expects RFC1002 length at the
+			 * beginning of the payload. Return it to indicate
+			 * the total length of the packet. This minimize the
+			 * change to upper layer packet processing logic. This
+			 * will be eventually remove when an intermediate
+			 * transport layer is added
+			 */
+			if (recvmsg->first_segment && size == 4) {
+				unsigned int rfc1002_len =
+					data_length + remaining_data_length;
+				*((__be32 *)buf) = cpu_to_be32(rfc1002_len);
+				data_read = 4;
+				recvmsg->first_segment = false;
+				ksmbd_debug(RDMA,
+					"returning rfc1002 length %d\n",
+					rfc1002_len);
+				goto read_rfc1002_done;
+			}
+
+			to_copy = min_t(int, data_length - offset, to_read);
+			memcpy(
+				buf + data_read,
+				(char *)data_transfer + data_offset + offset,
+				to_copy);
+
+			/* move on to the next buffer? */
+			if (to_copy == data_length - offset) {
+				queue_length--;
+				/*
+				 * No need to lock if we are not at the
+				 * end of the queue
+				 */
+				if (queue_length)
+					list_del(&recvmsg->list);
+				else {
+					spin_lock_irq(
+						&st->reassembly_queue_lock);
+					list_del(&recvmsg->list);
+					spin_unlock_irq(
+						&st->reassembly_queue_lock);
+				}
+				queue_removed++;
+				put_recvmsg(st, recvmsg);
+				offset = 0;
+			} else
+				offset += to_copy;
+
+			to_read -= to_copy;
+			data_read += to_copy;
+		}
+
+		spin_lock_irq(&st->reassembly_queue_lock);
+		st->reassembly_data_length -= data_read;
+		st->reassembly_queue_length -= queue_removed;
+		spin_unlock_irq(&st->reassembly_queue_lock);
+
+		spin_lock(&st->receive_credit_lock);
+		st->count_avail_recvmsg += queue_removed;
+		if (is_receive_credit_post_required(st->recv_credits,
+					st->count_avail_recvmsg)) {
+			spin_unlock(&st->receive_credit_lock);
+			mod_delayed_work(smb_direct_wq,
+					&st->post_recv_credits_work, 0);
+		} else
+			spin_unlock(&st->receive_credit_lock);
+
+		st->first_entry_offset = offset;
+		ksmbd_debug(RDMA,
+			"returning to thread data_read=%d reassembly_data_length=%d first_entry_offset=%d\n",
+			data_read, st->reassembly_data_length,
+			st->first_entry_offset);
+read_rfc1002_done:
+		return data_read;
+	}
+
+	ksmbd_debug(RDMA, "wait_event on more data\n");
+	rc = wait_event_interruptible(
+		st->wait_reassembly_queue,
+		st->reassembly_data_length >= size ||
+		st->status != SMB_DIRECT_CS_CONNECTED);
+	if (rc)
+		return -EINTR;
+
+	goto again;
+}
+
+static void smb_direct_post_recv_credits(struct work_struct *work)
+{
+	struct smb_direct_transport *t = container_of(work,
+		struct smb_direct_transport, post_recv_credits_work.work);
+	struct smb_direct_recvmsg *recvmsg;
+	int receive_credits, credits = 0;
+	int ret;
+	int use_free = 1;
+
+	spin_lock(&t->receive_credit_lock);
+	receive_credits = t->recv_credits;
+	spin_unlock(&t->receive_credit_lock);
+
+	if (receive_credits < t->recv_credit_target) {
+		while (true) {
+			if (use_free)
+				recvmsg = get_free_recvmsg(t);
+			else
+				recvmsg = get_empty_recvmsg(t);
+			if (!recvmsg) {
+				if (use_free) {
+					use_free = 0;
+					continue;
+				} else
+					break;
+			}
+
+			recvmsg->type = SMB_DIRECT_MSG_DATA_TRANSFER;
+			recvmsg->first_segment = false;
+
+			ret = smb_direct_post_recv(t, recvmsg);
+			if (ret) {
+				ksmbd_err("Can't post recv: %d\n", ret);
+				put_recvmsg(t, recvmsg);
+				break;
+			}
+			credits++;
+		}
+	}
+
+	spin_lock(&t->receive_credit_lock);
+	t->recv_credits += credits;
+	t->count_avail_recvmsg -= credits;
+	spin_unlock(&t->receive_credit_lock);
+
+	spin_lock(&t->lock_new_recv_credits);
+	t->new_recv_credits += credits;
+	spin_unlock(&t->lock_new_recv_credits);
+
+	if (credits)
+		queue_work(smb_direct_wq, &t->send_immediate_work);
+}
+
+static void send_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct smb_direct_sendmsg *sendmsg, *sibling;
+	struct smb_direct_transport *t;
+	struct list_head *pos, *prev, *end;
+
+	sendmsg = container_of(wc->wr_cqe, struct smb_direct_sendmsg, cqe);
+	t = sendmsg->transport;
+
+	ksmbd_debug(RDMA, "Send completed. status='%s (%d)', opcode=%d\n",
+			ib_wc_status_msg(wc->status), wc->status,
+			wc->opcode);
+
+	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
+		ksmbd_err("Send error. status='%s (%d)', opcode=%d\n",
+			ib_wc_status_msg(wc->status), wc->status,
+			wc->opcode);
+		smb_direct_disconnect_rdma_connection(t);
+	}
+
+	if (sendmsg->num_sge > 1) {
+		if (atomic_dec_and_test(&t->send_payload_pending))
+			wake_up(&t->wait_send_payload_pending);
+	} else {
+		if (atomic_dec_and_test(&t->send_pending))
+			wake_up(&t->wait_send_pending);
+	}
+
+	/* iterate and free the list of messages in reverse. the list's head
+	 * is invalid.
+	 */
+	for (pos = &sendmsg->list, prev = pos->prev, end = sendmsg->list.next;
+			prev != end; pos = prev, prev = prev->prev) {
+		sibling = container_of(pos, struct smb_direct_sendmsg, list);
+		smb_direct_free_sendmsg(t, sibling);
+	}
+
+	sibling = container_of(pos, struct smb_direct_sendmsg, list);
+	smb_direct_free_sendmsg(t, sibling);
+}
+
+static int manage_credits_prior_sending(struct smb_direct_transport *t)
+{
+	int new_credits;
+
+	spin_lock(&t->lock_new_recv_credits);
+	new_credits = t->new_recv_credits;
+	t->new_recv_credits = 0;
+	spin_unlock(&t->lock_new_recv_credits);
+
+	return new_credits;
+}
+
+static int smb_direct_post_send(struct smb_direct_transport *t,
+		struct ib_send_wr *wr)
+{
+	int ret;
+
+	if (wr->num_sge > 1)
+		atomic_inc(&t->send_payload_pending);
+	else
+		atomic_inc(&t->send_pending);
+
+	ret = ib_post_send(t->qp, wr, NULL);
+	if (ret) {
+		ksmbd_err("failed to post send: %d\n", ret);
+		if (wr->num_sge > 1) {
+			if (atomic_dec_and_test(&t->send_payload_pending))
+				wake_up(&t->wait_send_payload_pending);
+		} else {
+			if (atomic_dec_and_test(&t->send_pending))
+				wake_up(&t->wait_send_pending);
+		}
+		smb_direct_disconnect_rdma_connection(t);
+	}
+	return ret;
+}
+
+static void smb_direct_send_ctx_init(struct smb_direct_transport *t,
+			struct smb_direct_send_ctx *send_ctx,
+			bool need_invalidate_rkey, unsigned int remote_key)
+{
+	INIT_LIST_HEAD(&send_ctx->msg_list);
+	send_ctx->wr_cnt = 0;
+	send_ctx->need_invalidate_rkey = need_invalidate_rkey;
+	send_ctx->remote_key = remote_key;
+}
+
+static int smb_direct_flush_send_list(struct smb_direct_transport *t,
+			struct smb_direct_send_ctx *send_ctx, bool is_last)
+{
+	struct smb_direct_sendmsg *first, *last;
+	int ret;
+
+	if (list_empty(&send_ctx->msg_list))
+		return 0;
+
+	first = list_first_entry(&send_ctx->msg_list,
+				struct smb_direct_sendmsg,
+				list);
+	last = list_last_entry(&send_ctx->msg_list,
+				struct smb_direct_sendmsg,
+				list);
+
+	last->wr.send_flags = IB_SEND_SIGNALED;
+	last->wr.wr_cqe = &last->cqe;
+	if (is_last && send_ctx->need_invalidate_rkey) {
+		last->wr.opcode = IB_WR_SEND_WITH_INV;
+		last->wr.ex.invalidate_rkey = send_ctx->remote_key;
+	}
+
+	ret = smb_direct_post_send(t, &first->wr);
+	if (!ret) {
+		smb_direct_send_ctx_init(t, send_ctx,
+			send_ctx->need_invalidate_rkey, send_ctx->remote_key);
+	} else {
+		atomic_add(send_ctx->wr_cnt, &t->send_credits);
+		wake_up(&t->wait_send_credits);
+		list_for_each_entry_safe(first, last, &send_ctx->msg_list,
+				list) {
+			smb_direct_free_sendmsg(t, first);
+		}
+	}
+	return ret;
+}
+
+static int wait_for_credits(struct smb_direct_transport *t,
+		wait_queue_head_t *waitq, atomic_t *credits)
+{
+	int ret;
+
+	do {
+		if (atomic_dec_return(credits) >= 0)
+			return 0;
+
+		atomic_inc(credits);
+		ret = wait_event_interruptible(*waitq,
+				atomic_read(credits) > 0 ||
+				t->status != SMB_DIRECT_CS_CONNECTED);
+
+		if (t->status != SMB_DIRECT_CS_CONNECTED)
+			return -ENOTCONN;
+		else if (ret < 0)
+			return ret;
+	} while (true);
+}
+
+static int wait_for_send_credits(struct smb_direct_transport *t,
+				struct smb_direct_send_ctx *send_ctx)
+{
+	int ret;
+
+	if (send_ctx && (send_ctx->wr_cnt >= 16 ||
+			atomic_read(&t->send_credits) <= 1)) {
+		ret = smb_direct_flush_send_list(t, send_ctx, false);
+		if (ret)
+			return ret;
+	}
+
+	return wait_for_credits(t, &t->wait_send_credits, &t->send_credits);
+}
+
+static int smb_direct_create_header(struct smb_direct_transport *t,
+		int size, int remaining_data_length,
+		struct smb_direct_sendmsg **sendmsg_out)
+{
+	struct smb_direct_sendmsg *sendmsg;
+	struct smb_direct_data_transfer *packet;
+	int header_length;
+	int ret;
+
+	sendmsg = smb_direct_alloc_sendmsg(t);
+	if (IS_ERR(sendmsg))
+		return PTR_ERR(sendmsg);
+
+	/* Fill in the packet header */
+	packet = (struct smb_direct_data_transfer *)sendmsg->packet;
+	packet->credits_requested = cpu_to_le16(t->send_credit_target);
+	packet->credits_granted = cpu_to_le16(manage_credits_prior_sending(t));
+
+	packet->flags = 0;
+	packet->reserved = 0;
+	if (!size)
+		packet->data_offset = 0;
+	else
+		packet->data_offset = cpu_to_le32(24);
+	packet->data_length = cpu_to_le32(size);
+	packet->remaining_data_length = cpu_to_le32(remaining_data_length);
+	packet->padding = 0;
+
+	ksmbd_debug(RDMA,
+		"credits_requested=%d credits_granted=%d data_offset=%d data_length=%d remaining_data_length=%d\n",
+		le16_to_cpu(packet->credits_requested),
+		le16_to_cpu(packet->credits_granted),
+		le32_to_cpu(packet->data_offset),
+		le32_to_cpu(packet->data_length),
+		le32_to_cpu(packet->remaining_data_length));
+
+	/* Map the packet to DMA */
+	header_length = sizeof(struct smb_direct_data_transfer);
+	/* If this is a packet without payload, don't send padding */
+	if (!size)
+		header_length =
+			offsetof(struct smb_direct_data_transfer, padding);
+
+	sendmsg->sge[0].addr = ib_dma_map_single(t->cm_id->device,
+						 (void *)packet,
+						 header_length,
+						 DMA_TO_DEVICE);
+	ret = ib_dma_mapping_error(t->cm_id->device, sendmsg->sge[0].addr);
+	if (ret) {
+		smb_direct_free_sendmsg(t, sendmsg);
+		return ret;
+	}
+
+	sendmsg->num_sge = 1;
+	sendmsg->sge[0].length = header_length;
+	sendmsg->sge[0].lkey = t->pd->local_dma_lkey;
+
+	*sendmsg_out = sendmsg;
+	return 0;
+}
+
+static int get_sg_list(void *buf, int size,
+			struct scatterlist *sg_list, int nentries)
+{
+	bool high = is_vmalloc_addr(buf);
+	struct page *page;
+	int offset, len;
+	int i = 0;
+
+	if (nentries < BUFFER_NR_PAGES(buf, size))
+		return -EINVAL;
+
+	offset = offset_in_page(buf);
+	buf -= offset;
+	while (size > 0) {
+		len = min_t(int, PAGE_SIZE - offset, size);
+		if (high)
+			page = vmalloc_to_page(buf);
+		else
+			page = kmap_to_page(buf);
+
+		if (!sg_list)
+			return -EINVAL;
+		sg_set_page(sg_list, page, len, offset);
+		sg_list = sg_next(sg_list);
+
+		buf += PAGE_SIZE;
+		size -= len;
+		offset = 0;
+		i++;
+	}
+	return i;
+}
+
+static int get_mapped_sg_list(struct ib_device *device, void *buf, int size,
+			struct scatterlist *sg_list, int nentries,
+			enum dma_data_direction dir)
+{
+	int npages;
+
+	npages = get_sg_list(buf, size, sg_list, nentries);
+	if (npages <= 0)
+		return -EINVAL;
+	return ib_dma_map_sg(device, sg_list, npages, dir);
+}
+
+static int post_sendmsg(struct smb_direct_transport *t,
+			struct smb_direct_send_ctx *send_ctx,
+			struct smb_direct_sendmsg *msg)
+{
+	int i;
+
+	for (i = 0; i < msg->num_sge; i++)
+		ib_dma_sync_single_for_device(t->cm_id->device,
+				msg->sge[i].addr, msg->sge[i].length,
+				DMA_TO_DEVICE);
+
+	msg->cqe.done = send_done;
+	msg->wr.opcode = IB_WR_SEND;
+	msg->wr.sg_list = &msg->sge[0];
+	msg->wr.num_sge = msg->num_sge;
+	msg->wr.next = NULL;
+
+	if (send_ctx) {
+		msg->wr.wr_cqe = NULL;
+		msg->wr.send_flags = 0;
+		if (!list_empty(&send_ctx->msg_list)) {
+			struct smb_direct_sendmsg *last;
+
+			last = list_last_entry(&send_ctx->msg_list,
+					       struct smb_direct_sendmsg,
+					       list);
+			last->wr.next = &msg->wr;
+		}
+		list_add_tail(&msg->list, &send_ctx->msg_list);
+		send_ctx->wr_cnt++;
+		return 0;
+	}
+
+	msg->wr.wr_cqe = &msg->cqe;
+	msg->wr.send_flags = IB_SEND_SIGNALED;
+	return smb_direct_post_send(t, &msg->wr);
+}
+
+static int smb_direct_post_send_data(struct smb_direct_transport *t,
+			struct smb_direct_send_ctx *send_ctx,
+			struct kvec *iov, int niov, int remaining_data_length)
+{
+	int i, j, ret;
+	struct smb_direct_sendmsg *msg;
+	int data_length;
+	struct scatterlist sg[SMB_DIRECT_MAX_SEND_SGES-1];
+
+	ret = wait_for_send_credits(t, send_ctx);
+	if (ret)
+		return ret;
+
+	data_length = 0;
+	for (i = 0; i < niov; i++)
+		data_length += iov[i].iov_len;
+
+	ret = smb_direct_create_header(t, data_length, remaining_data_length,
+				       &msg);
+	if (ret) {
+		atomic_inc(&t->send_credits);
+		return ret;
+	}
+
+	for (i = 0; i < niov; i++) {
+		struct ib_sge *sge;
+		int sg_cnt;
+
+		sg_init_table(sg, SMB_DIRECT_MAX_SEND_SGES-1);
+		sg_cnt = get_mapped_sg_list(t->cm_id->device,
+				iov[i].iov_base, iov[i].iov_len,
+				sg, SMB_DIRECT_MAX_SEND_SGES-1, DMA_TO_DEVICE);
+		if (sg_cnt <= 0) {
+			ksmbd_err("failed to map buffer\n");
+			ret = -ENOMEM;
+			goto err;
+		} else if (sg_cnt + msg->num_sge > SMB_DIRECT_MAX_SEND_SGES-1) {
+			ksmbd_err("buffer not fitted into sges\n");
+			ret = -E2BIG;
+			ib_dma_unmap_sg(t->cm_id->device, sg, sg_cnt,
+					DMA_TO_DEVICE);
+			goto err;
+		}
+
+		for (j = 0; j < sg_cnt; j++) {
+			sge = &msg->sge[msg->num_sge];
+			sge->addr = sg_dma_address(&sg[j]);
+			sge->length = sg_dma_len(&sg[j]);
+			sge->lkey  = t->pd->local_dma_lkey;
+			msg->num_sge++;
+		}
+	}
+
+	ret = post_sendmsg(t, send_ctx, msg);
+	if (ret)
+		goto err;
+	return 0;
+err:
+	smb_direct_free_sendmsg(t, msg);
+	atomic_inc(&t->send_credits);
+	return ret;
+}
+
+static int smb_direct_writev(struct ksmbd_transport *t,
+			struct kvec *iov, int niovs, int buflen,
+			bool need_invalidate, unsigned int remote_key)
+{
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+	int remaining_data_length;
+	int start, i, j;
+	int max_iov_size = st->max_send_size -
+			sizeof(struct smb_direct_data_transfer);
+	int ret;
+	struct kvec vec;
+	struct smb_direct_send_ctx send_ctx;
+
+	if (st->status != SMB_DIRECT_CS_CONNECTED) {
+		ret = -ENOTCONN;
+		goto done;
+	}
+
+	//FIXME: skip RFC1002 header..
+	buflen -= 4;
+	iov[0].iov_base += 4;
+	iov[0].iov_len -= 4;
+
+	remaining_data_length = buflen;
+	ksmbd_debug(RDMA, "Sending smb (RDMA): smb_len=%u\n", buflen);
+
+	smb_direct_send_ctx_init(st, &send_ctx, need_invalidate, remote_key);
+	start = i = 0;
+	buflen = 0;
+	while (true) {
+		buflen += iov[i].iov_len;
+		if (buflen > max_iov_size) {
+			if (i > start) {
+				remaining_data_length -=
+					(buflen-iov[i].iov_len);
+				ret = smb_direct_post_send_data(st, &send_ctx,
+						&iov[start], i-start,
+						remaining_data_length);
+				if (ret)
+					goto done;
+			} else {
+				/* iov[start] is too big, break it */
+				int nvec  = (buflen+max_iov_size-1) /
+						max_iov_size;
+
+				for (j = 0; j < nvec; j++) {
+					vec.iov_base =
+						(char *)iov[start].iov_base +
+						j*max_iov_size;
+					vec.iov_len =
+						min_t(int, max_iov_size,
+						buflen - max_iov_size*j);
+					remaining_data_length -= vec.iov_len;
+					ret = smb_direct_post_send_data(st,
+						&send_ctx, &vec, 1,
+						remaining_data_length);
+					if (ret)
+						goto done;
+				}
+				i++;
+				if (i == niovs)
+					break;
+			}
+			start = i;
+			buflen = 0;
+		} else {
+			i++;
+			if (i == niovs) {
+				/* send out all remaining vecs */
+				remaining_data_length -= buflen;
+				ret = smb_direct_post_send_data(st, &send_ctx,
+					&iov[start], i-start,
+					remaining_data_length);
+				if (ret)
+					goto done;
+				break;
+			}
+		}
+	}
+
+done:
+	ret = smb_direct_flush_send_list(st, &send_ctx, true);
+
+	/*
+	 * As an optimization, we don't wait for individual I/O to finish
+	 * before sending the next one.
+	 * Send them all and wait for pending send count to get to 0
+	 * that means all the I/Os have been out and we are good to return
+	 */
+
+	wait_event(st->wait_send_payload_pending,
+		atomic_read(&st->send_payload_pending) == 0);
+	return ret;
+}
+
+static void read_write_done(struct ib_cq *cq, struct ib_wc *wc,
+				enum dma_data_direction dir)
+{
+	struct smb_direct_rdma_rw_msg *msg = container_of(wc->wr_cqe,
+					struct smb_direct_rdma_rw_msg, cqe);
+	struct smb_direct_transport *t = msg->t;
+
+	if (wc->status != IB_WC_SUCCESS) {
+		ksmbd_err("read/write error. opcode = %d, status = %s(%d)\n",
+			wc->opcode, ib_wc_status_msg(wc->status), wc->status);
+		smb_direct_disconnect_rdma_connection(t);
+	}
+
+	if (atomic_inc_return(&t->rw_avail_ops) > 0)
+		wake_up(&t->wait_rw_avail_ops);
+
+	rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
+			msg->sg_list, msg->sgt.nents, dir);
+	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+	complete(msg->completion);
+	kfree(msg);
+}
+
+static void read_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	read_write_done(cq, wc, DMA_FROM_DEVICE);
+}
+
+static void write_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	read_write_done(cq, wc, DMA_TO_DEVICE);
+}
+
+static int smb_direct_rdma_xmit(struct smb_direct_transport *t, void *buf,
+	int buf_len, u32 remote_key, u64 remote_offset, u32 remote_len,
+	bool is_read)
+{
+	struct smb_direct_rdma_rw_msg *msg;
+	int ret;
+	DECLARE_COMPLETION_ONSTACK(completion);
+	struct ib_send_wr *first_wr = NULL;
+
+	ret = wait_for_credits(t, &t->wait_rw_avail_ops, &t->rw_avail_ops);
+	if (ret < 0)
+		return ret;
+
+	/* TODO: mempool */
+	msg = kmalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
+		sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
+	if (!msg) {
+		atomic_inc(&t->rw_avail_ops);
+		return -ENOMEM;
+	}
+
+	msg->sgt.sgl = &msg->sg_list[0];
+	ret = sg_alloc_table_chained(&msg->sgt,
+				BUFFER_NR_PAGES(buf, buf_len),
+				msg->sg_list, SG_CHUNK_SIZE);
+	if (ret) {
+		atomic_inc(&t->rw_avail_ops);
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	ret = get_sg_list(buf, buf_len, msg->sgt.sgl, msg->sgt.orig_nents);
+	if (ret <= 0) {
+		ksmbd_err("failed to get pages\n");
+		goto err;
+	}
+
+	ret = rdma_rw_ctx_init(&msg->rw_ctx, t->qp, t->qp->port,
+			msg->sg_list, BUFFER_NR_PAGES(buf, buf_len),
+			0, remote_offset, remote_key,
+			is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	if (ret < 0) {
+		ksmbd_err("failed to init rdma_rw_ctx: %d\n", ret);
+		goto err;
+	}
+
+	msg->t = t;
+	msg->cqe.done = is_read ? read_done : write_done;
+	msg->completion = &completion;
+	first_wr = rdma_rw_ctx_wrs(&msg->rw_ctx, t->qp, t->qp->port,
+				&msg->cqe, NULL);
+
+	ret = ib_post_send(t->qp, first_wr, NULL);
+	if (ret) {
+		ksmbd_err("failed to post send wr: %d\n", ret);
+		goto err;
+	}
+
+	wait_for_completion(&completion);
+	return 0;
+
+err:
+	atomic_inc(&t->rw_avail_ops);
+	if (first_wr)
+		rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
+				msg->sg_list, msg->sgt.nents,
+				is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+	kfree(msg);
+	return ret;
+
+}
+
+static int smb_direct_rdma_write(struct ksmbd_transport *t,
+			void *buf, unsigned int buflen,
+			u32 remote_key, u64 remote_offset,
+			u32 remote_len)
+{
+	return smb_direct_rdma_xmit(SMB_DIRECT_TRANS(t), buf, buflen,
+			remote_key, remote_offset,
+			remote_len, false);
+}
+
+static int smb_direct_rdma_read(struct ksmbd_transport *t,
+			void *buf, unsigned int buflen,
+			u32 remote_key, u64 remote_offset,
+			u32 remote_len)
+{
+	return smb_direct_rdma_xmit(SMB_DIRECT_TRANS(t), buf, buflen,
+			remote_key, remote_offset,
+			remote_len, true);
+}
+
+static void smb_direct_disconnect(struct ksmbd_transport *t)
+{
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+
+	ksmbd_debug(RDMA, "Disconnecting cm_id=%p\n", st->cm_id);
+
+	smb_direct_disconnect_rdma_connection(st);
+	wait_event_interruptible(st->wait_status,
+			st->status == SMB_DIRECT_CS_DISCONNECTED);
+	free_transport(st);
+}
+
+static int smb_direct_cm_handler(struct rdma_cm_id *cm_id,
+				struct rdma_cm_event *event)
+{
+	struct smb_direct_transport *t = cm_id->context;
+
+	ksmbd_debug(RDMA, "RDMA CM event. cm_id=%p event=%s (%d)\n",
+			cm_id, rdma_event_msg(event->event), event->event);
+
+	switch (event->event) {
+	case RDMA_CM_EVENT_ESTABLISHED: {
+		t->status = SMB_DIRECT_CS_CONNECTED;
+		wake_up_interruptible(&t->wait_status);
+		break;
+	}
+	case RDMA_CM_EVENT_DEVICE_REMOVAL:
+	case RDMA_CM_EVENT_DISCONNECTED: {
+		t->status = SMB_DIRECT_CS_DISCONNECTED;
+		wake_up_interruptible(&t->wait_status);
+		wake_up_interruptible(&t->wait_reassembly_queue);
+		wake_up(&t->wait_send_credits);
+		break;
+	}
+	case RDMA_CM_EVENT_CONNECT_ERROR: {
+		t->status = SMB_DIRECT_CS_DISCONNECTED;
+		wake_up_interruptible(&t->wait_status);
+		break;
+	}
+	default:
+		ksmbd_err("Unexpected RDMA CM event. cm_id=%p, event=%s (%d)\n",
+				cm_id, rdma_event_msg(event->event),
+				event->event);
+		break;
+	}
+	return 0;
+}
+
+static void smb_direct_qpair_handler(struct ib_event *event, void *context)
+{
+	struct smb_direct_transport *t = context;
+
+	ksmbd_debug(RDMA, "Received QP event. cm_id=%p, event=%s (%d)\n",
+			t->cm_id, ib_event_msg(event->event), event->event);
+
+	switch (event->event) {
+	case IB_EVENT_CQ_ERR:
+	case IB_EVENT_QP_FATAL:
+		smb_direct_disconnect_rdma_connection(t);
+		break;
+	default:
+		break;
+	}
+}
+
+static int smb_direct_send_negotiate_response(struct smb_direct_transport *t,
+		int failed)
+{
+	struct smb_direct_sendmsg *sendmsg;
+	struct smb_direct_negotiate_resp *resp;
+	int ret;
+
+	sendmsg = smb_direct_alloc_sendmsg(t);
+	if (IS_ERR(sendmsg))
+		return -ENOMEM;
+
+	resp = (struct smb_direct_negotiate_resp *)sendmsg->packet;
+	if (failed) {
+		memset(resp, 0, sizeof(*resp));
+		resp->min_version = cpu_to_le16(0x0100);
+		resp->max_version = cpu_to_le16(0x0100);
+		resp->status = STATUS_NOT_SUPPORTED;
+	} else {
+		resp->status = STATUS_SUCCESS;
+		resp->min_version = SMB_DIRECT_VERSION_LE;
+		resp->max_version = SMB_DIRECT_VERSION_LE;
+		resp->negotiated_version = SMB_DIRECT_VERSION_LE;
+		resp->reserved = 0;
+		resp->credits_requested =
+				cpu_to_le16(t->send_credit_target);
+		resp->credits_granted = cpu_to_le16(
+				manage_credits_prior_sending(t));
+		resp->max_readwrite_size = cpu_to_le32(t->max_rdma_rw_size);
+		resp->preferred_send_size = cpu_to_le32(t->max_send_size);
+		resp->max_receive_size = cpu_to_le32(t->max_recv_size);
+		resp->max_fragmented_size =
+				cpu_to_le32(t->max_fragmented_recv_size);
+	}
+
+	sendmsg->sge[0].addr = ib_dma_map_single(t->cm_id->device,
+				(void *)resp, sizeof(*resp), DMA_TO_DEVICE);
+	ret = ib_dma_mapping_error(t->cm_id->device,
+				sendmsg->sge[0].addr);
+	if (ret) {
+		smb_direct_free_sendmsg(t, sendmsg);
+		return ret;
+	}
+
+	sendmsg->num_sge = 1;
+	sendmsg->sge[0].length = sizeof(*resp);
+	sendmsg->sge[0].lkey = t->pd->local_dma_lkey;
+
+	ret = post_sendmsg(t, NULL, sendmsg);
+	if (ret) {
+		smb_direct_free_sendmsg(t, sendmsg);
+		return ret;
+	}
+
+	wait_event(t->wait_send_pending,
+			atomic_read(&t->send_pending) == 0);
+	return 0;
+}
+
+static int smb_direct_accept_client(struct smb_direct_transport *t)
+{
+	struct rdma_conn_param conn_param;
+	struct ib_port_immutable port_immutable;
+	u32 ird_ord_hdr[2];
+	int ret;
+
+	memset(&conn_param, 0, sizeof(conn_param));
+	conn_param.initiator_depth = min_t(u8,
+				t->cm_id->device->attrs.max_qp_rd_atom,
+				SMB_DIRECT_CM_INITIATOR_DEPTH);
+	conn_param.responder_resources = 0;
+
+	t->cm_id->device->ops.get_port_immutable(t->cm_id->device,
+			t->cm_id->port_num, &port_immutable);
+	if (port_immutable.core_cap_flags & RDMA_CORE_PORT_IWARP) {
+		ird_ord_hdr[0] = conn_param.responder_resources;
+		ird_ord_hdr[1] = 1;
+		conn_param.private_data = ird_ord_hdr;
+		conn_param.private_data_len = sizeof(ird_ord_hdr);
+	} else {
+		conn_param.private_data = NULL;
+		conn_param.private_data_len = 0;
+	}
+	conn_param.retry_count = SMB_DIRECT_CM_RETRY;
+	conn_param.rnr_retry_count = SMB_DIRECT_CM_RNR_RETRY;
+	conn_param.flow_control = 0;
+
+	ret = rdma_accept(t->cm_id, &conn_param);
+	if (ret) {
+		ksmbd_err("error at rdma_accept: %d\n", ret);
+		return ret;
+	}
+
+	wait_event_interruptible(t->wait_status,
+				 t->status != SMB_DIRECT_CS_NEW);
+	if (t->status != SMB_DIRECT_CS_CONNECTED)
+		return -ENOTCONN;
+	return 0;
+}
+
+static int smb_direct_negotiate(struct smb_direct_transport *t)
+{
+	int ret;
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_negotiate_req *req;
+
+	recvmsg = get_free_recvmsg(t);
+	if (!recvmsg)
+		return -ENOMEM;
+	recvmsg->type = SMB_DIRECT_MSG_NEGOTIATE_REQ;
+
+	ret = smb_direct_post_recv(t, recvmsg);
+	if (ret) {
+		ksmbd_err("Can't post recv: %d\n", ret);
+		goto out;
+	}
+
+	t->negotiation_requested = false;
+	ret = smb_direct_accept_client(t);
+	if (ret) {
+		ksmbd_err("Can't accept client\n");
+		goto out;
+	}
+
+	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
+
+	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
+	ret = wait_event_interruptible_timeout(t->wait_status,
+			t->negotiation_requested ||
+			t->status == SMB_DIRECT_CS_DISCONNECTED,
+			SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
+	if (ret <= 0 || t->status == SMB_DIRECT_CS_DISCONNECTED) {
+		ret = ret < 0 ? ret : -ETIMEDOUT;
+		goto out;
+	}
+
+	ret = smb_direct_check_recvmsg(recvmsg);
+	if (ret == -ECONNABORTED)
+		goto out;
+
+	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
+	t->max_recv_size = min_t(int, t->max_recv_size,
+			le32_to_cpu(req->preferred_send_size));
+	t->max_send_size = min_t(int, t->max_send_size,
+			le32_to_cpu(req->max_receive_size));
+	t->max_fragmented_send_size =
+			le32_to_cpu(req->max_fragmented_size);
+
+	ret = smb_direct_send_negotiate_response(t, ret);
+out:
+	if (recvmsg)
+		put_recvmsg(t, recvmsg);
+	return ret;
+}
+
+static int smb_direct_init_params(struct smb_direct_transport *t,
+		struct ib_qp_cap *cap)
+{
+	struct ib_device *device = t->cm_id->device;
+	int max_send_sges, max_pages, max_rw_wrs, max_send_wrs;
+
+	/* need 2 more sge. because a SMB_DIRECT header will be mapped,
+	 * and maybe a send buffer could be not page aligned.
+	 */
+	t->max_send_size = smb_direct_max_send_size;
+	max_send_sges = DIV_ROUND_UP(t->max_send_size, PAGE_SIZE) + 2;
+	if (max_send_sges > SMB_DIRECT_MAX_SEND_SGES) {
+		ksmbd_err("max_send_size %d is too large\n", t->max_send_size);
+		return -EINVAL;
+	}
+
+	/*
+	 * allow smb_direct_max_outstanding_rw_ops of in-flight RDMA
+	 * read/writes. HCA guarantees at least max_send_sge of sges for
+	 * a RDMA read/write work request, and if memory registration is used,
+	 * we need reg_mr, local_inv wrs for each read/write.
+	 */
+	t->max_rdma_rw_size = smb_direct_max_read_write_size;
+	max_pages = DIV_ROUND_UP(t->max_rdma_rw_size, PAGE_SIZE) + 1;
+	max_rw_wrs = DIV_ROUND_UP(max_pages, SMB_DIRECT_MAX_SEND_SGES);
+	max_rw_wrs += rdma_rw_mr_factor(device, t->cm_id->port_num,
+			max_pages) * 2;
+	max_rw_wrs *= smb_direct_max_outstanding_rw_ops;
+
+	max_send_wrs = smb_direct_send_credit_target + max_rw_wrs;
+	if (max_send_wrs > device->attrs.max_cqe ||
+			max_send_wrs > device->attrs.max_qp_wr) {
+		ksmbd_err("consider lowering send_credit_target = %d, or max_outstanding_rw_ops = %d\n",
+			smb_direct_send_credit_target,
+			smb_direct_max_outstanding_rw_ops);
+		ksmbd_err("Possible CQE overrun, device reporting max_cqe %d max_qp_wr %d\n",
+			device->attrs.max_cqe, device->attrs.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (smb_direct_receive_credit_max > device->attrs.max_cqe ||
+	    smb_direct_receive_credit_max > device->attrs.max_qp_wr) {
+		ksmbd_err("consider lowering receive_credit_max = %d\n",
+			smb_direct_receive_credit_max);
+		ksmbd_err("Possible CQE overrun, device reporting max_cpe %d max_qp_wr %d\n",
+			device->attrs.max_cqe, device->attrs.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (device->attrs.max_send_sge < SMB_DIRECT_MAX_SEND_SGES) {
+		ksmbd_err("warning: device max_send_sge = %d too small\n",
+			device->attrs.max_send_sge);
+		return -EINVAL;
+	}
+	if (device->attrs.max_recv_sge < SMB_DIRECT_MAX_RECV_SGES) {
+		ksmbd_err("warning: device max_recv_sge = %d too small\n",
+			device->attrs.max_recv_sge);
+		return -EINVAL;
+	}
+
+	t->recv_credits = 0;
+	t->count_avail_recvmsg = 0;
+
+	t->recv_credit_max = smb_direct_receive_credit_max;
+	t->recv_credit_target = 10;
+	t->new_recv_credits = 0;
+
+	t->send_credit_target = smb_direct_send_credit_target;
+	atomic_set(&t->send_credits, 0);
+	atomic_set(&t->rw_avail_ops, smb_direct_max_outstanding_rw_ops);
+
+	t->max_send_size = smb_direct_max_send_size;
+	t->max_recv_size = smb_direct_max_receive_size;
+	t->max_fragmented_recv_size = smb_direct_max_fragmented_recv_size;
+
+	cap->max_send_wr = max_send_wrs;
+	cap->max_recv_wr = t->recv_credit_max;
+	cap->max_send_sge = SMB_DIRECT_MAX_SEND_SGES;
+	cap->max_recv_sge = SMB_DIRECT_MAX_RECV_SGES;
+	cap->max_inline_data = 0;
+	cap->max_rdma_ctxs = 0;
+	return 0;
+}
+
+static void smb_direct_destroy_pools(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg;
+
+	while ((recvmsg = get_free_recvmsg(t)))
+		mempool_free(recvmsg, t->recvmsg_mempool);
+	while ((recvmsg = get_empty_recvmsg(t)))
+		mempool_free(recvmsg, t->recvmsg_mempool);
+
+	mempool_destroy(t->recvmsg_mempool);
+	t->recvmsg_mempool = NULL;
+
+	kmem_cache_destroy(t->recvmsg_cache);
+	t->recvmsg_cache = NULL;
+
+	mempool_destroy(t->sendmsg_mempool);
+	t->sendmsg_mempool = NULL;
+
+	kmem_cache_destroy(t->sendmsg_cache);
+	t->sendmsg_cache = NULL;
+}
+
+static int smb_direct_create_pools(struct smb_direct_transport *t)
+{
+	char name[80];
+	int i;
+	struct smb_direct_recvmsg *recvmsg;
+
+	snprintf(name, sizeof(name), "smb_direct_rqst_pool_%p", t);
+	t->sendmsg_cache = kmem_cache_create(name,
+			sizeof(struct smb_direct_sendmsg) +
+			sizeof(struct smb_direct_negotiate_resp),
+			0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!t->sendmsg_cache)
+		return -ENOMEM;
+
+	t->sendmsg_mempool = mempool_create(t->send_credit_target,
+			mempool_alloc_slab, mempool_free_slab,
+			t->sendmsg_cache);
+	if (!t->sendmsg_mempool)
+		goto err;
+
+	snprintf(name, sizeof(name), "smb_direct_resp_%p", t);
+	t->recvmsg_cache = kmem_cache_create(name,
+			sizeof(struct smb_direct_recvmsg) +
+			t->max_recv_size,
+			0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!t->recvmsg_cache)
+		goto err;
+
+	t->recvmsg_mempool =
+		mempool_create(t->recv_credit_max, mempool_alloc_slab,
+		       mempool_free_slab, t->recvmsg_cache);
+	if (!t->recvmsg_mempool)
+		goto err;
+
+	INIT_LIST_HEAD(&t->recvmsg_queue);
+
+	for (i = 0; i < t->recv_credit_max; i++) {
+		recvmsg = mempool_alloc(t->recvmsg_mempool, GFP_KERNEL);
+		if (!recvmsg)
+			goto err;
+		recvmsg->transport = t;
+		list_add(&recvmsg->list, &t->recvmsg_queue);
+	}
+	t->count_avail_recvmsg = t->recv_credit_max;
+
+	return 0;
+err:
+	smb_direct_destroy_pools(t);
+	return -ENOMEM;
+}
+
+static int smb_direct_create_qpair(struct smb_direct_transport *t,
+		struct ib_qp_cap *cap)
+{
+	int ret;
+	struct ib_qp_init_attr qp_attr;
+
+	t->pd = ib_alloc_pd(t->cm_id->device, 0);
+	if (IS_ERR(t->pd)) {
+		ksmbd_err("Can't create RDMA PD\n");
+		ret = PTR_ERR(t->pd);
+		t->pd = NULL;
+		return ret;
+	}
+
+	t->send_cq = ib_alloc_cq(t->cm_id->device, t,
+			t->send_credit_target, 0, IB_POLL_WORKQUEUE);
+	if (IS_ERR(t->send_cq)) {
+		ksmbd_err("Can't create RDMA send CQ\n");
+		ret = PTR_ERR(t->send_cq);
+		t->send_cq = NULL;
+		goto err;
+	}
+
+	t->recv_cq = ib_alloc_cq(t->cm_id->device, t,
+			cap->max_send_wr + cap->max_rdma_ctxs,
+			0, IB_POLL_WORKQUEUE);
+	if (IS_ERR(t->recv_cq)) {
+		ksmbd_err("Can't create RDMA recv CQ\n");
+		ret = PTR_ERR(t->recv_cq);
+		t->recv_cq = NULL;
+		goto err;
+	}
+
+	memset(&qp_attr, 0, sizeof(qp_attr));
+	qp_attr.event_handler = smb_direct_qpair_handler;
+	qp_attr.qp_context = t;
+	qp_attr.cap = *cap;
+	qp_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
+	qp_attr.qp_type = IB_QPT_RC;
+	qp_attr.send_cq = t->send_cq;
+	qp_attr.recv_cq = t->recv_cq;
+	qp_attr.port_num = ~0;
+
+	ret = rdma_create_qp(t->cm_id, t->pd, &qp_attr);
+	if (ret) {
+		ksmbd_err("Can't create RDMA QP: %d\n", ret);
+		goto err;
+	}
+
+	t->qp = t->cm_id->qp;
+	t->cm_id->event_handler = smb_direct_cm_handler;
+
+	return 0;
+err:
+	if (t->qp) {
+		ib_destroy_qp(t->qp);
+		t->qp = NULL;
+	}
+	if (t->recv_cq) {
+		ib_destroy_cq(t->recv_cq);
+		t->recv_cq = NULL;
+	}
+	if (t->send_cq) {
+		ib_destroy_cq(t->send_cq);
+		t->send_cq = NULL;
+	}
+	if (t->pd) {
+		ib_dealloc_pd(t->pd);
+		t->pd = NULL;
+	}
+	return ret;
+}
+
+static int smb_direct_prepare(struct ksmbd_transport *t)
+{
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+	int ret;
+	struct ib_qp_cap qp_cap;
+
+	ret = smb_direct_init_params(st, &qp_cap);
+	if (ret) {
+		ksmbd_err("Can't configure RDMA parameters\n");
+		return ret;
+	}
+
+	ret = smb_direct_create_pools(st);
+	if (ret) {
+		ksmbd_err("Can't init RDMA pool: %d\n", ret);
+		return ret;
+	}
+
+	ret = smb_direct_create_qpair(st, &qp_cap);
+	if (ret) {
+		ksmbd_err("Can't accept RDMA client: %d\n", ret);
+		return ret;
+	}
+
+	ret = smb_direct_negotiate(st);
+	if (ret) {
+		ksmbd_err("Can't negotiate: %d\n", ret);
+		return ret;
+	}
+
+	st->status = SMB_DIRECT_CS_CONNECTED;
+	return 0;
+}
+
+static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
+{
+	if (!(attrs->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))
+		return false;
+	if (attrs->max_fast_reg_page_list_len == 0)
+		return false;
+	return true;
+}
+
+static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
+{
+	struct smb_direct_transport *t;
+
+	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
+		ksmbd_debug(RDMA,
+			"Fast Registration Work Requests is not supported. device capabilities=%llx\n",
+			new_cm_id->device->attrs.device_cap_flags);
+		return -EPROTONOSUPPORT;
+	}
+
+	t = alloc_transport(new_cm_id);
+	if (!t)
+		return -ENOMEM;
+
+	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
+			KSMBD_TRANS(t)->conn, "ksmbd:r%u", SMB_DIRECT_PORT);
+	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+		int ret = PTR_ERR(KSMBD_TRANS(t)->handler);
+
+		ksmbd_err("Can't start thread\n");
+		free_transport(t);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
+				struct rdma_cm_event *event)
+{
+	switch (event->event) {
+	case RDMA_CM_EVENT_CONNECT_REQUEST: {
+		int ret = smb_direct_handle_connect_request(cm_id);
+
+		if (ret) {
+			ksmbd_err("Can't create transport: %d\n", ret);
+			return ret;
+		}
+
+		ksmbd_debug(RDMA, "Received connection request. cm_id=%p\n",
+			cm_id);
+		break;
+	}
+	default:
+		ksmbd_err("Unexpected listen event. cm_id=%p, event=%s (%d)\n",
+				cm_id,
+				rdma_event_msg(event->event), event->event);
+		break;
+	}
+	return 0;
+}
+
+static int smb_direct_listen(int port)
+{
+	int ret;
+	struct rdma_cm_id *cm_id;
+	struct sockaddr_in sin = {
+		.sin_family		= AF_INET,
+		.sin_addr.s_addr	= htonl(INADDR_ANY),
+		.sin_port		= htons(port),
+	};
+
+	cm_id = rdma_create_id(&init_net, smb_direct_listen_handler,
+		&smb_direct_listener, RDMA_PS_TCP, IB_QPT_RC);
+	if (IS_ERR(cm_id)) {
+		ksmbd_err("Can't create cm id: %ld\n",
+				PTR_ERR(cm_id));
+		return PTR_ERR(cm_id);
+	}
+
+	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&sin);
+	if (ret) {
+		ksmbd_err("Can't bind: %d\n", ret);
+		goto err;
+	}
+
+	smb_direct_listener.cm_id = cm_id;
+
+	ret = rdma_listen(cm_id, 10);
+	if (ret) {
+		ksmbd_err("Can't listen: %d\n", ret);
+		goto err;
+	}
+	return 0;
+err:
+	smb_direct_listener.cm_id = NULL;
+	rdma_destroy_id(cm_id);
+	return ret;
+}
+
+int ksmbd_rdma_init(void)
+{
+	int ret;
+
+	smb_direct_listener.cm_id = NULL;
+
+	/* When a client is running out of send credits, the credits are
+	 * granted by the server's sending a packet using this queue.
+	 * This avoids the situation that a clients cannot send packets
+	 * for lack of credits
+	 */
+	smb_direct_wq = alloc_workqueue("ksmbd-smb_direct-wq",
+				WQ_HIGHPRI|WQ_MEM_RECLAIM, 0);
+	if (!smb_direct_wq)
+		return -ENOMEM;
+
+	ret = smb_direct_listen(SMB_DIRECT_PORT);
+	if (ret) {
+		destroy_workqueue(smb_direct_wq);
+		smb_direct_wq = NULL;
+		ksmbd_err("Can't listen: %d\n", ret);
+		return ret;
+	}
+
+	ksmbd_debug(RDMA, "init RDMA listener. cm_id=%p\n",
+		smb_direct_listener.cm_id);
+	return 0;
+}
+
+int ksmbd_rdma_destroy(void)
+{
+	if (smb_direct_listener.cm_id)
+		rdma_destroy_id(smb_direct_listener.cm_id);
+	smb_direct_listener.cm_id = NULL;
+
+	if (smb_direct_wq) {
+		flush_workqueue(smb_direct_wq);
+		destroy_workqueue(smb_direct_wq);
+		smb_direct_wq = NULL;
+	}
+	return 0;
+}
+
+static struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops = {
+	.prepare	= smb_direct_prepare,
+	.disconnect	= smb_direct_disconnect,
+	.writev		= smb_direct_writev,
+	.read		= smb_direct_read,
+	.rdma_read	= smb_direct_rdma_read,
+	.rdma_write	= smb_direct_rdma_write,
+};
diff --git a/fs/cifsd/transport_rdma.h b/fs/cifsd/transport_rdma.h
new file mode 100644
index 000000000000..da60fcec3ede
--- /dev/null
+++ b/fs/cifsd/transport_rdma.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2017, Microsoft Corporation.
+ *   Copyright (C) 2018, LG Electronics.
+ */
+
+#ifndef __KSMBD_TRANSPORT_RDMA_H__
+#define __KSMBD_TRANSPORT_RDMA_H__
+
+#define SMB_DIRECT_PORT	5445
+
+/* SMB DIRECT negotiation request packet [MS-KSMBD] 2.2.1 */
+struct smb_direct_negotiate_req {
+	__le16 min_version;
+	__le16 max_version;
+	__le16 reserved;
+	__le16 credits_requested;
+	__le32 preferred_send_size;
+	__le32 max_receive_size;
+	__le32 max_fragmented_size;
+} __packed;
+
+/* SMB DIRECT negotiation response packet [MS-KSMBD] 2.2.2 */
+struct smb_direct_negotiate_resp {
+	__le16 min_version;
+	__le16 max_version;
+	__le16 negotiated_version;
+	__le16 reserved;
+	__le16 credits_requested;
+	__le16 credits_granted;
+	__le32 status;
+	__le32 max_readwrite_size;
+	__le32 preferred_send_size;
+	__le32 max_receive_size;
+	__le32 max_fragmented_size;
+} __packed;
+
+#define SMB_DIRECT_RESPONSE_REQUESTED 0x0001
+
+/* SMB DIRECT data transfer packet with payload [MS-KSMBD] 2.2.3 */
+struct smb_direct_data_transfer {
+	__le16 credits_requested;
+	__le16 credits_granted;
+	__le16 flags;
+	__le16 reserved;
+	__le32 remaining_data_length;
+	__le32 data_offset;
+	__le32 data_length;
+	__le32 padding;
+	__u8 buffer[];
+} __packed;
+
+#ifdef CONFIG_SMB_SERVER_SMBDIRECT
+int ksmbd_rdma_init(void);
+int ksmbd_rdma_destroy(void);
+#else
+static inline int ksmbd_rdma_init(void) { return 0; }
+static inline int ksmbd_rdma_destroy(void) { return 0; }
+#endif
+
+#endif /* __KSMBD_TRANSPORT_RDMA_H__ */
diff --git a/fs/cifsd/transport_tcp.c b/fs/cifsd/transport_tcp.c
new file mode 100644
index 000000000000..359401227d93
--- /dev/null
+++ b/fs/cifsd/transport_tcp.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/freezer.h>
+
+#include "smb_common.h"
+#include "server.h"
+#include "auth.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "transport_tcp.h"
+
+#define IFACE_STATE_DOWN		(1 << 0)
+#define IFACE_STATE_CONFIGURED		(1 << 1)
+
+struct interface {
+	struct task_struct	*ksmbd_kthread;
+	struct socket		*ksmbd_socket;
+	struct list_head	entry;
+	char			*name;
+	struct mutex		sock_release_lock;
+	int			state;
+};
+
+static LIST_HEAD(iface_list);
+
+static int bind_additional_ifaces;
+
+struct tcp_transport {
+	struct ksmbd_transport		transport;
+	struct socket			*sock;
+	struct kvec			*iov;
+	unsigned int			nr_iov;
+};
+
+static struct ksmbd_transport_ops ksmbd_tcp_transport_ops;
+
+static void tcp_stop_kthread(struct task_struct *kthread);
+static struct interface *alloc_iface(char *ifname);
+
+#define KSMBD_TRANS(t)	(&(t)->transport)
+#define TCP_TRANS(t)	((struct tcp_transport *)container_of(t, \
+				struct tcp_transport, transport))
+
+static inline void ksmbd_tcp_nodelay(struct socket *sock)
+{
+	tcp_sock_set_nodelay(sock->sk);
+}
+
+static inline void ksmbd_tcp_reuseaddr(struct socket *sock)
+{
+	sock_set_reuseaddr(sock->sk);
+}
+
+static inline void ksmbd_tcp_rcv_timeout(struct socket *sock, s64 secs)
+{
+	lock_sock(sock->sk);
+	if (secs && secs < MAX_SCHEDULE_TIMEOUT / HZ - 1)
+		sock->sk->sk_rcvtimeo = secs * HZ;
+	else
+		sock->sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT;
+	release_sock(sock->sk);
+}
+
+static inline void ksmbd_tcp_snd_timeout(struct socket *sock, s64 secs)
+{
+	sock_set_sndtimeo(sock->sk, secs);
+}
+
+static struct tcp_transport *alloc_transport(struct socket *client_sk)
+{
+	struct tcp_transport *t;
+	struct ksmbd_conn *conn;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+	t->sock = client_sk;
+
+	conn = ksmbd_conn_alloc();
+	if (!conn) {
+		kfree(t);
+		return NULL;
+	}
+
+	conn->transport = KSMBD_TRANS(t);
+	KSMBD_TRANS(t)->conn = conn;
+	KSMBD_TRANS(t)->ops = &ksmbd_tcp_transport_ops;
+	return t;
+}
+
+static void free_transport(struct tcp_transport *t)
+{
+	kernel_sock_shutdown(t->sock, SHUT_RDWR);
+	sock_release(t->sock);
+	t->sock = NULL;
+
+	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+	kfree(t->iov);
+	kfree(t);
+}
+
+/**
+ * kvec_array_init() - initialize a IO vector segment
+ * @new:	IO vector to be initialized
+ * @iov:	base IO vector
+ * @nr_segs:	number of segments in base iov
+ * @bytes:	total iovec length so far for read
+ *
+ * Return:	Number of IO segments
+ */
+static unsigned int kvec_array_init(struct kvec *new, struct kvec *iov,
+				    unsigned int nr_segs, size_t bytes)
+{
+	size_t base = 0;
+
+	while (bytes || !iov->iov_len) {
+		int copy = min(bytes, iov->iov_len);
+
+		bytes -= copy;
+		base += copy;
+		if (iov->iov_len == base) {
+			iov++;
+			nr_segs--;
+			base = 0;
+		}
+	}
+
+	memcpy(new, iov, sizeof(*iov) * nr_segs);
+	new->iov_base += base;
+	new->iov_len -= base;
+	return nr_segs;
+}
+
+/**
+ * get_conn_iovec() - get connection iovec for reading from socket
+ * @t:		TCP transport instance
+ * @nr_segs:	number of segments in iov
+ *
+ * Return:	return existing or newly allocate iovec
+ */
+static struct kvec *get_conn_iovec(struct tcp_transport *t,
+				     unsigned int nr_segs)
+{
+	struct kvec *new_iov;
+
+	if (t->iov && nr_segs <= t->nr_iov)
+		return t->iov;
+
+	/* not big enough -- allocate a new one and release the old */
+	new_iov = kmalloc_array(nr_segs, sizeof(*new_iov), GFP_KERNEL);
+	if (new_iov) {
+		kfree(t->iov);
+		t->iov = new_iov;
+		t->nr_iov = nr_segs;
+	}
+	return new_iov;
+}
+
+static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
+{
+	switch (sa->sa_family) {
+	case AF_INET:
+		return ntohs(((struct sockaddr_in *)sa)->sin_port);
+	case AF_INET6:
+		return ntohs(((struct sockaddr_in6 *)sa)->sin6_port);
+	}
+	return 0;
+}
+
+/**
+ * ksmbd_tcp_new_connection() - create a new tcp session on mount
+ * @client_sk:	socket associated with new connection
+ *
+ * whenever a new connection is requested, create a conn thread
+ * (session thread) to handle new incoming smb requests from the connection
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int ksmbd_tcp_new_connection(struct socket *client_sk)
+{
+	struct sockaddr *csin;
+	int rc = 0;
+	struct tcp_transport *t;
+
+	t = alloc_transport(client_sk);
+	if (!t)
+		return -ENOMEM;
+
+	csin = KSMBD_TCP_PEER_SOCKADDR(KSMBD_TRANS(t)->conn);
+	if (kernel_getpeername(client_sk, csin) < 0) {
+		ksmbd_err("client ip resolution failed\n");
+		rc = -EINVAL;
+		goto out_error;
+	}
+
+	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
+					KSMBD_TRANS(t)->conn,
+					"ksmbd:%u", ksmbd_tcp_get_port(csin));
+	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+		ksmbd_err("cannot start conn thread\n");
+		rc = PTR_ERR(KSMBD_TRANS(t)->handler);
+		free_transport(t);
+	}
+	return rc;
+
+out_error:
+	free_transport(t);
+	return rc;
+}
+
+/**
+ * ksmbd_kthread_fn() - listen to new SMB connections and callback server
+ * @p:		arguments to forker thread
+ *
+ * Return:	Returns a task_struct or ERR_PTR
+ */
+static int ksmbd_kthread_fn(void *p)
+{
+	struct socket *client_sk = NULL;
+	struct interface *iface = (struct interface *)p;
+	int ret;
+
+	while (!kthread_should_stop()) {
+		mutex_lock(&iface->sock_release_lock);
+		if (!iface->ksmbd_socket) {
+			mutex_unlock(&iface->sock_release_lock);
+			break;
+		}
+		ret = kernel_accept(iface->ksmbd_socket, &client_sk,
+				O_NONBLOCK);
+		mutex_unlock(&iface->sock_release_lock);
+		if (ret) {
+			if (ret == -EAGAIN)
+				/* check for new connections every 100 msecs */
+				schedule_timeout_interruptible(HZ / 10);
+			continue;
+		}
+
+		ksmbd_debug(CONN, "connect success: accepted new connection\n");
+		client_sk->sk->sk_rcvtimeo = KSMBD_TCP_RECV_TIMEOUT;
+		client_sk->sk->sk_sndtimeo = KSMBD_TCP_SEND_TIMEOUT;
+
+		ksmbd_tcp_new_connection(client_sk);
+	}
+
+	ksmbd_debug(CONN, "releasing socket\n");
+	return 0;
+}
+
+/**
+ * ksmbd_tcp_run_kthread() - start forker thread
+ * @iface: pointer to struct interface
+ *
+ * start forker thread(ksmbd/0) at module init time to listen
+ * on port 445 for new SMB connection requests. It creates per connection
+ * server threads(ksmbd/x)
+ *
+ * Return:	0 on success or error number
+ */
+static int ksmbd_tcp_run_kthread(struct interface *iface)
+{
+	int rc;
+	struct task_struct *kthread;
+
+	kthread = kthread_run(ksmbd_kthread_fn, (void *)iface,
+		"ksmbd-%s", iface->name);
+	if (IS_ERR(kthread)) {
+		rc = PTR_ERR(kthread);
+		return rc;
+	}
+	iface->ksmbd_kthread = kthread;
+
+	return 0;
+}
+
+/**
+ * ksmbd_tcp_readv() - read data from socket in given iovec
+ * @t:		TCP transport instance
+ * @iov_orig:	base IO vector
+ * @nr_segs:	number of segments in base iov
+ * @to_read:	number of bytes to read from socket
+ *
+ * Return:	on success return number of bytes read from socket,
+ *		otherwise return error number
+ */
+static int ksmbd_tcp_readv(struct tcp_transport *t,
+			   struct kvec *iov_orig,
+			   unsigned int nr_segs,
+			   unsigned int to_read)
+{
+	int length = 0;
+	int total_read;
+	unsigned int segs;
+	struct msghdr ksmbd_msg;
+	struct kvec *iov;
+	struct ksmbd_conn *conn = KSMBD_TRANS(t)->conn;
+
+	iov = get_conn_iovec(t, nr_segs);
+	if (!iov)
+		return -ENOMEM;
+
+	ksmbd_msg.msg_control = NULL;
+	ksmbd_msg.msg_controllen = 0;
+
+	for (total_read = 0; to_read; total_read += length, to_read -= length) {
+		try_to_freeze();
+
+		if (!ksmbd_conn_alive(conn)) {
+			total_read = -ESHUTDOWN;
+			break;
+		}
+		segs = kvec_array_init(iov, iov_orig, nr_segs, total_read);
+
+		length = kernel_recvmsg(t->sock, &ksmbd_msg,
+					iov, segs, to_read, 0);
+
+		if (length == -EINTR) {
+			total_read = -ESHUTDOWN;
+			break;
+		} else if (conn->status == KSMBD_SESS_NEED_RECONNECT) {
+			total_read = -EAGAIN;
+			break;
+		} else if (length == -ERESTARTSYS || length == -EAGAIN) {
+			usleep_range(1000, 2000);
+			length = 0;
+			continue;
+		} else if (length <= 0) {
+			total_read = -EAGAIN;
+			break;
+		}
+	}
+	return total_read;
+}
+
+/**
+ * ksmbd_tcp_read() - read data from socket in given buffer
+ * @t:		TCP transport instance
+ * @buf:	buffer to store read data from socket
+ * @to_read:	number of bytes to read from socket
+ *
+ * Return:	on success return number of bytes read from socket,
+ *		otherwise return error number
+ */
+static int ksmbd_tcp_read(struct ksmbd_transport *t,
+		   char *buf,
+		   unsigned int to_read)
+{
+	struct kvec iov;
+
+	iov.iov_base = buf;
+	iov.iov_len = to_read;
+
+	return ksmbd_tcp_readv(TCP_TRANS(t), &iov, 1, to_read);
+}
+
+static int ksmbd_tcp_writev(struct ksmbd_transport *t,
+			struct kvec *iov, int nvecs, int size,
+			bool need_invalidate, unsigned int remote_key)
+
+{
+	struct msghdr smb_msg = {.msg_flags = MSG_NOSIGNAL};
+
+	return kernel_sendmsg(TCP_TRANS(t)->sock, &smb_msg, iov, nvecs, size);
+}
+
+static void ksmbd_tcp_disconnect(struct ksmbd_transport *t)
+{
+	free_transport(TCP_TRANS(t));
+}
+
+static void tcp_destroy_socket(struct socket *ksmbd_socket)
+{
+	int ret;
+
+	if (!ksmbd_socket)
+		return;
+
+	/* set zero to timeout */
+	ksmbd_tcp_rcv_timeout(ksmbd_socket, 0);
+	ksmbd_tcp_snd_timeout(ksmbd_socket, 0);
+
+	ret = kernel_sock_shutdown(ksmbd_socket, SHUT_RDWR);
+	if (ret)
+		ksmbd_err("Failed to shutdown socket: %d\n", ret);
+	else
+		sock_release(ksmbd_socket);
+}
+
+/**
+ * create_socket - create socket for ksmbd/0
+ *
+ * Return:	Returns a task_struct or ERR_PTR
+ */
+static int create_socket(struct interface *iface)
+{
+	int ret;
+	struct sockaddr_in6 sin6;
+	struct sockaddr_in sin;
+	struct socket *ksmbd_socket;
+	bool ipv4 = false;
+
+	ret = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
+	if (ret) {
+		ksmbd_err("Can't create socket for ipv6, try ipv4: %d\n", ret);
+		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
+				&ksmbd_socket);
+		if (ret) {
+			ksmbd_err("Can't create socket for ipv4: %d\n", ret);
+			goto out_error;
+		}
+
+		sin.sin_family = PF_INET;
+		sin.sin_addr.s_addr = htonl(INADDR_ANY);
+		sin.sin_port = htons(server_conf.tcp_port);
+		ipv4 = true;
+	} else {
+		sin6.sin6_family = PF_INET6;
+		sin6.sin6_addr = in6addr_any;
+		sin6.sin6_port = htons(server_conf.tcp_port);
+	}
+
+	ksmbd_tcp_nodelay(ksmbd_socket);
+	ksmbd_tcp_reuseaddr(ksmbd_socket);
+
+	ret = sock_setsockopt(ksmbd_socket,
+				SOL_SOCKET,
+				SO_BINDTODEVICE,
+				KERNEL_SOCKPTR(iface->name),
+				strlen(iface->name));
+	if (ret != -ENODEV && ret < 0) {
+		ksmbd_err("Failed to set SO_BINDTODEVICE: %d\n", ret);
+		goto out_error;
+	}
+
+	if (ipv4)
+		ret = kernel_bind(ksmbd_socket, (struct sockaddr *)&sin,
+				sizeof(sin));
+	else
+		ret = kernel_bind(ksmbd_socket, (struct sockaddr *)&sin6,
+				sizeof(sin6));
+	if (ret) {
+		ksmbd_err("Failed to bind socket: %d\n", ret);
+		goto out_error;
+	}
+
+	ksmbd_socket->sk->sk_rcvtimeo = KSMBD_TCP_RECV_TIMEOUT;
+	ksmbd_socket->sk->sk_sndtimeo = KSMBD_TCP_SEND_TIMEOUT;
+
+	ret = kernel_listen(ksmbd_socket, KSMBD_SOCKET_BACKLOG);
+	if (ret) {
+		ksmbd_err("Port listen() error: %d\n", ret);
+		goto out_error;
+	}
+
+	iface->ksmbd_socket = ksmbd_socket;
+	ret = ksmbd_tcp_run_kthread(iface);
+	if (ret) {
+		ksmbd_err("Can't start ksmbd main kthread: %d\n", ret);
+		goto out_error;
+	}
+	iface->state = IFACE_STATE_CONFIGURED;
+
+	return 0;
+
+out_error:
+	tcp_destroy_socket(ksmbd_socket);
+	iface->ksmbd_socket = NULL;
+	return ret;
+}
+
+static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
+				void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct interface *iface;
+	int ret, found = 0;
+
+	switch (event) {
+	case NETDEV_UP:
+		if (netdev->priv_flags & IFF_BRIDGE_PORT)
+			return NOTIFY_OK;
+
+		list_for_each_entry(iface, &iface_list, entry) {
+			if (!strcmp(iface->name, netdev->name)) {
+				found = 1;
+				if (iface->state != IFACE_STATE_DOWN)
+					break;
+				ret = create_socket(iface);
+				if (ret)
+					return NOTIFY_OK;
+				break;
+			}
+		}
+		if (!found && bind_additional_ifaces) {
+			iface = alloc_iface(kstrdup(netdev->name, GFP_KERNEL));
+			if (!iface)
+				return NOTIFY_OK;
+			ret = create_socket(iface);
+			if (ret)
+				break;
+		}
+		break;
+	case NETDEV_DOWN:
+		list_for_each_entry(iface, &iface_list, entry) {
+			if (!strcmp(iface->name, netdev->name) &&
+			    iface->state == IFACE_STATE_CONFIGURED) {
+				tcp_stop_kthread(iface->ksmbd_kthread);
+				iface->ksmbd_kthread = NULL;
+				mutex_lock(&iface->sock_release_lock);
+				tcp_destroy_socket(iface->ksmbd_socket);
+				iface->ksmbd_socket = NULL;
+				mutex_unlock(&iface->sock_release_lock);
+
+				iface->state = IFACE_STATE_DOWN;
+				break;
+			}
+		}
+		break;
+	}
+
+	return NOTIFY_DONE;
+
+}
+
+static struct notifier_block ksmbd_netdev_notifier = {
+	.notifier_call = ksmbd_netdev_event,
+};
+
+int ksmbd_tcp_init(void)
+{
+	register_netdevice_notifier(&ksmbd_netdev_notifier);
+
+	return 0;
+}
+
+static void tcp_stop_kthread(struct task_struct *kthread)
+{
+	int ret;
+
+	if (!kthread)
+		return;
+
+	ret = kthread_stop(kthread);
+	if (ret)
+		ksmbd_err("failed to stop forker thread\n");
+}
+
+void ksmbd_tcp_destroy(void)
+{
+	struct interface *iface, *tmp;
+
+	unregister_netdevice_notifier(&ksmbd_netdev_notifier);
+
+	list_for_each_entry_safe(iface, tmp, &iface_list, entry) {
+		list_del(&iface->entry);
+		kfree(iface->name);
+		ksmbd_free(iface);
+	}
+}
+
+static struct interface *alloc_iface(char *ifname)
+{
+	struct interface *iface;
+
+	if (!ifname)
+		return NULL;
+
+	iface = ksmbd_alloc(sizeof(struct interface));
+	if (!iface) {
+		kfree(ifname);
+		return NULL;
+	}
+
+	iface->name = ifname;
+	iface->state = IFACE_STATE_DOWN;
+	list_add(&iface->entry, &iface_list);
+	mutex_init(&iface->sock_release_lock);
+	return iface;
+}
+
+int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
+{
+	int sz = 0;
+
+	if (!ifc_list_sz) {
+		struct net_device *netdev;
+
+		rtnl_lock();
+		for_each_netdev(&init_net, netdev) {
+			if (netdev->priv_flags & IFF_BRIDGE_PORT)
+				continue;
+			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
+				return -ENOMEM;
+		}
+		rtnl_unlock();
+		bind_additional_ifaces = 1;
+		return 0;
+	}
+
+	while (ifc_list_sz > 0) {
+		if (!alloc_iface(kstrdup(ifc_list, GFP_KERNEL)))
+			return -ENOMEM;
+
+		sz = strlen(ifc_list);
+		if (!sz)
+			break;
+
+		ifc_list += sz + 1;
+		ifc_list_sz -= (sz + 1);
+	}
+
+	bind_additional_ifaces = 0;
+
+	return 0;
+}
+
+static struct ksmbd_transport_ops ksmbd_tcp_transport_ops = {
+	.read		= ksmbd_tcp_read,
+	.writev		= ksmbd_tcp_writev,
+	.disconnect	= ksmbd_tcp_disconnect,
+};
diff --git a/fs/cifsd/transport_tcp.h b/fs/cifsd/transport_tcp.h
new file mode 100644
index 000000000000..e338bebe322f
--- /dev/null
+++ b/fs/cifsd/transport_tcp.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_TRANSPORT_TCP_H__
+#define __KSMBD_TRANSPORT_TCP_H__
+
+int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
+int ksmbd_tcp_init(void);
+void ksmbd_tcp_destroy(void);
+
+#endif /* __KSMBD_TRANSPORT_TCP_H__ */
-- 
2.17.1

