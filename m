Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F75737EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjFUJL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFUJLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:11:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AA1FF2;
        Wed, 21 Jun 2023 02:10:33 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091030euoutp014ad40326cb733a0a56272604c4496620~qoYt05suO1148511485euoutp01L;
        Wed, 21 Jun 2023 09:10:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621091030euoutp014ad40326cb733a0a56272604c4496620~qoYt05suO1148511485euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338630;
        bh=A9vJqtefMweXRl5hA0piF7XKpY7+Y1RrvCTm+EtEXlQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Ka4ZfoeHZ9KJZ0KIhhdzO1ExiUUNFd4pQTnInOxAgqyf0eUSdqf9fGf4ADqTzHos1
         ywZFhN8UlbjrBOzPZnyD8ZTVyakxnTGgnKeSkWsclDeJldAylGgwILHjQdvJGQ1yCF
         Ta2ndNd0iIyvJvB9swtxZqirf7z/BsD/JzVDihvI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230621091030eucas1p2b9431b5e8ae4acfd91cec8a259953008~qoYtbzuHT2538825388eucas1p2C;
        Wed, 21 Jun 2023 09:10:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.84.37758.58EB2946; Wed, 21
        Jun 2023 10:10:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091029eucas1p2f9fd694dae3dfbdfffd25dccf4fcb568~qoYsgN9G-1816318163eucas1p2-;
        Wed, 21 Jun 2023 09:10:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091029eusmtrp2a0edd6b63446d061037baf6b483c48bb~qoYsaZmkS2225722257eusmtrp2B;
        Wed, 21 Jun 2023 09:10:29 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-7e-6492be85d3cb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.E1.14344.48EB2946; Wed, 21
        Jun 2023 10:10:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091028eusmtip2a2c40ec1c961aabd77e7ae0ea239ab31~qoYr28XcU1980519805eusmtip2i;
        Wed, 21 Jun 2023 09:10:28 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:27 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>, Corey Minyard <minyard@acm.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Song Liu <song@kernel.org>, Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        David Howells <dhowells@redhat.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Anton Altaparmakov <anton@tuxera.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Stultz <jstultz@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     Joel Granados <j.granados@samsung.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-hyperv@vger.kernel.org>,
        <linux-raid@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-cachefs@redhat.com>, <codalist@coda.cs.cmu.edu>,
        <linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>,
        <ocfs2-devel@oss.oracle.com>, <fsverity@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <netdev@vger.kernel.org>,
        <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH 07/11] sysctl: Add size to register_sysctl
Date:   Wed, 21 Jun 2023 11:09:56 +0200
Message-ID: <20230621091000.424843-8-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTdxTe797bewsRdi1m/AJsRBS26ETcWHLcREe26M10zswlW3xtBa5g
        pOBa1OkyQylvnNE6BgJDEOTRIoWKKAQ6x5CHbLxaqEzU8Iq1CK0iIg9hwmUL/33nfN93ft85
        yU9MSvoYN/GhiCheHiEN96IdqcqGybZ18QZ1iF+MiYDylkc0NJkvEdBeqkUQVzVHQZW+QgTK
        hhwRvFQ3MGCPiSNh4GUdDWNlszQM//kUga3gNIJe9UMG5u49JCC/qY+A5yV3CIhWzdBgKUtA
        kNUWS4EhVo/AkH6FhtGYaQqMg85gGrfRcKVmhoShhn4GkvrnaLCpDkB7xnMRqPJ0NHRf52A4
        W4MgxeoBv5a7QubZqwRkpqkIuHw3SQSFRh2CyQINA82tzyko1eUR0PQsjobaXAKKC14wMNNU
        TsNfKTJorzwjgkHtNQb0A90ieJJ/m4EH9ycJqKltpiD1nJ0Ge+KoCIzVWTS032wRQUJiFoKE
        i9UIzuaqSEgx33glOd1PQ/XMDQbqUmsRTE/Mij4O4Yym7dxE3BmKK8kuQZyxu4PkpqfUiMuI
        /pnmMqM7KE5bUk9yOfU7uPGeVoKrKO4huEuPoiluqONLTtejprmqjHsMV3nTe9eGPY6bQvjw
        Q8d4+frN3zmGJXbqyCMdvxE/jA6Pi6KR0YqSkYMYs/64vKiVSUaOYglbhHBL2zlynpCwzxBu
        N0oEYgzhyuQiOhmJFxy56eFCvxDhqxoj9b/owS+xtFBcQ7hB00XMj6LZd3Hb415ynljB9qzA
        2Y9tzDxBsjUO2F4QNI9d2A9x8/nLC6Eo1ht3jF9a0Dixm/D9Zh0hhPXE8ea0BY0DG4DbBmyU
        oFmOmy8MUsJMT6y6lkkKGOM/LBZS8K7CZkMeLeCf8O2Kf4j5QJjVLMOp1VOLD3yK1Vlji5dx
        wdbGCkbAHniu6uKi4TzCv8/aGaHQIlygHF90f4RjTYOLjkDcWKoXCRdzxndGlguJnLG6Mo0U
        2k44MV5yFq3OWLJDxpIdMpbskINIDXLljypkobzi/Qj+uK9CKlMcjQj1DY6U6dGrX9gy2zh+
        AxVZn/jWIUKM6hAWk14rnN7Uq0MkTiHSEyd5eeS38qPhvKIOuYspL1entQHNwRI2VBrFH+b5
        I7z8P5YQO7hFE/7FiVs+/2J90dpY/7vDriO3cps6TtkOvpG3/+v81ebOiVPKigsDhf3Ht76z
        j9neuHHHhOmkqcsn823tMn5j/i3vfM8Xfrdd1mYZdMemNfa/PWJ2H4h6r90tOVPu97qhac1l
        sso2G540InPxsRz+QDm0bqusOrl+MruY89oW9iyoxn8vUbClnNlzOmen7cfXwgJ2f2Wx7ht4
        emp5drU2zRK036PXuHNXY2Bwf8jBBDbA8cL1vsNsWeSUuQZk3n7uzmbVmLR31d4TnVGp9k92
        +tlSyjiW9Em35OUOKR8mTFl9rAwRqEw7QV0E2/SB7z97sbnT/Ru9y8qVruu2PfI3tLyV31Xh
        RSnCpBvWkHKF9F+mKDof9AQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbZRiH851zek5ZhNUO5Ii4YXeJ063j7gsy1On0KMSJMSY6BnRQAW2B
        9aIDGSkU5CqBLm6zXMelC+M2KiAQIMqQcZmUrhsdk7GMizAgUMZgTm4WGhP+e77f9/zeL98f
        LxvnZlAO7MgomVASJRDxyB1E3/qNkcPJ7aow5+xMN6jre0RCt7EEg4GaSgQpzRsENGvrWZDY
        VcyCNVUXBaakFBzG1jpIWLy2TsLM9ccI5jVZCIZVkxRs3J/EoKz7IQbLVXcxUChXSdhozMVh
        6loqgnxdMgHtyVoE7ZeqSZhLWiHAMG4Dt5fmSahuXcVhomuUgvTRDRLmlUEwoF5mgbK0loTB
        XxmYKbyKIHPaES7U2UNezi8Y5F1UYlD+VzoLrhhqEZTcbcTgmeYqBT39ywTU1JZi0P0khYS2
        yxhUaP6hYLW7joSbmWIYaMxmwXhlAwXasUEWLJT1UvBg5BkGrW09BPyUayLBlDbHAkNLPgkD
        v/WxIDUtH0FqUQuCnMtKHDKNTWYla5SEltUm6u2vGMNtP+ZpSjbBVBVWIcYwqMeZlX9ViFEr
        fiSZPIWeYCqrOnGmuNOfWRrqx5j6iiGMKXmkIJgJ/adM7ZCKZNqWiwmmWX2f+sT1S76PJFou
        EzpFREtlR3knXcCV7+IFfFd3L76L2xunvF09eEd8fcKEoshvhZIjviH8iLRbtXiMvgA7Ozez
        xFIgwzTKQGw2zXGnL18SZaAdbC6nHNFDT2+acytz7kjXPbnDsvAuenUwg7RIC4j+Y6iSshwa
        EF33uGjLIjmHaN3sML55YcsZsqUL7g1ujcI5rVa0SXN6k3dxvOme8+VbOcHZT+uXSqhNtub4
        0CM9tZjluT30D8aLW44V5yitG5snNplrdopMBmTxn6d7fh4nLPP30MqGPNzCNP371BRumbOX
        NraXkhY+Ry+u/Y1ykK16W129ra7eVi9G+FVkK5RLxeFiqStfKhBL5VHh/NBosRaZl6Kx61l9
        E6qYXuB3IIyNOhDNxnm21i9rVWFc6zBBbJxQEh0skYuE0g7kYf5nLu5gFxpt3qooWbCLp7OH
        i7unl7OHl6cbz976w5g0AZcTLpAJvxEKY4SS/3sY28pBgcnfkm+UTR8oT9SEiGRWKuriS7Pp
        Pv666qhTkhbDF012QRfYx9A7nRvvqpvsxHtjnPa//yJbNvJRY2zCZFDn0mcpaTPaEMPuV/tE
        k9mpB6N4aGXdJsGoe24u5FY9z89HEfhdqLqXazrRuhOdyYyIHS0M5H8e4dXcG7BbVHjAaZTZ
        pz/xAT8wPvL619x8eUWK8r2d8zX2cUnnhx0Px6HmxVfuGXcey3r95J2YiuGyM/Su5ePSiYMP
        0kUBuvg3ufisM1/v35hwVlt2pT/Aq26/avZ4U6rH2NrD06HMwrkXnErKbHS5Gg/Nn8GJ8X67
        Z7sCxN66wBtTlKHAIWZf1se+IqdD3/MIaYTA5TVcIhX8B9lnSFCdBAAA
X-CMS-MailID: 20230621091029eucas1p2f9fd694dae3dfbdfffd25dccf4fcb568
X-Msg-Generator: CA
X-RootMTR: 20230621091029eucas1p2f9fd694dae3dfbdfffd25dccf4fcb568
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091029eucas1p2f9fd694dae3dfbdfffd25dccf4fcb568
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091029eucas1p2f9fd694dae3dfbdfffd25dccf4fcb568@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to remove the end element from the ctl_table struct arrays, we
explicitly define the size when registering the targes.
We add a size argument to register_sysctl and change all the callers to
pass the ARRAY_SIZE of their table arg.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/arm/kernel/isa.c                         |  2 +-
 arch/arm64/kernel/armv8_deprecated.c          |  2 +-
 arch/arm64/kernel/fpsimd.c                    |  6 +++--
 arch/arm64/kernel/process.c                   |  3 ++-
 arch/ia64/kernel/crash.c                      |  3 ++-
 arch/powerpc/kernel/idle.c                    |  3 ++-
 arch/powerpc/platforms/pseries/mobility.c     |  3 ++-
 arch/s390/appldata/appldata_base.c            |  4 +++-
 arch/s390/kernel/debug.c                      |  3 ++-
 arch/s390/kernel/topology.c                   |  3 ++-
 arch/s390/mm/cmm.c                            |  3 ++-
 arch/s390/mm/pgalloc.c                        |  3 ++-
 arch/x86/entry/vdso/vdso32-setup.c            |  2 +-
 arch/x86/kernel/itmt.c                        |  3 ++-
 crypto/fips.c                                 |  3 ++-
 drivers/base/firmware_loader/fallback_table.c |  6 ++---
 drivers/cdrom/cdrom.c                         |  3 ++-
 drivers/char/hpet.c                           |  3 ++-
 drivers/char/ipmi/ipmi_poweroff.c             |  3 ++-
 drivers/gpu/drm/i915/i915_perf.c              |  3 ++-
 drivers/hv/hv_common.c                        |  3 ++-
 drivers/macintosh/mac_hid.c                   |  3 ++-
 drivers/md/md.c                               |  3 ++-
 drivers/misc/sgi-xp/xpc_main.c                |  6 +++--
 drivers/parport/procfs.c                      | 11 +++++----
 drivers/perf/arm_pmuv3.c                      |  3 ++-
 drivers/scsi/scsi_sysctl.c                    |  3 ++-
 drivers/scsi/sg.c                             |  3 ++-
 fs/cachefiles/error_inject.c                  |  3 ++-
 fs/coda/sysctl.c                              |  3 ++-
 fs/devpts/inode.c                             |  3 ++-
 fs/eventpoll.c                                |  2 +-
 fs/lockd/svc.c                                |  3 ++-
 fs/nfs/nfs4sysctl.c                           |  3 ++-
 fs/nfs/sysctl.c                               |  3 ++-
 fs/notify/fanotify/fanotify_user.c            |  3 ++-
 fs/notify/inotify/inotify_user.c              |  3 ++-
 fs/ntfs/sysctl.c                              |  3 ++-
 fs/ocfs2/stackglue.c                          |  3 ++-
 fs/proc/proc_sysctl.c                         | 23 ++++++++++---------
 fs/verity/signature.c                         |  4 +++-
 fs/xfs/xfs_sysctl.c                           |  3 ++-
 include/linux/sysctl.h                        |  6 +++--
 kernel/pid_sysctl.h                           |  2 +-
 kernel/time/timer.c                           |  2 +-
 kernel/ucount.c                               |  2 +-
 kernel/utsname_sysctl.c                       |  2 +-
 lib/test_sysctl.c                             |  9 +++++---
 net/sunrpc/sysctl.c                           |  3 ++-
 net/sunrpc/xprtrdma/svc_rdma.c                |  3 ++-
 net/sunrpc/xprtrdma/transport.c               |  4 +++-
 net/sunrpc/xprtsock.c                         |  4 +++-
 net/sysctl_net.c                              |  2 +-
 security/apparmor/lsm.c                       |  3 ++-
 security/loadpin/loadpin.c                    |  3 ++-
 security/yama/yama_lsm.c                      |  3 ++-
 56 files changed, 133 insertions(+), 76 deletions(-)

diff --git a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
index 20218876bef2..561432e3c55a 100644
--- a/arch/arm/kernel/isa.c
+++ b/arch/arm/kernel/isa.c
@@ -46,5 +46,5 @@ register_isa_ports(unsigned int membase, unsigned int portbase, unsigned int por
 	isa_membase = membase;
 	isa_portbase = portbase;
 	isa_portshift = portshift;
-	isa_sysctl_header = register_sysctl("bus/isa", ctl_isa_vars);
+	isa_sysctl_header = register_sysctl("bus/isa", ctl_isa_vars, ARRAY_SIZE(ctl_isa_vars));
 }
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 1febd412b4d2..68ed60a521a6 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -569,7 +569,7 @@ static void __init register_insn_emulation(struct insn_emulation *insn)
 		sysctl->extra2 = &insn->max;
 		sysctl->proc_handler = emulation_proc_handler;
 
-		register_sysctl("abi", sysctl);
+		register_sysctl("abi", sysctl, 1);
 	}
 }
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2fbafa5cc7ac..ecfb2ef6a036 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -595,7 +595,8 @@ static struct ctl_table sve_default_vl_table[] = {
 static int __init sve_sysctl_init(void)
 {
 	if (system_supports_sve())
-		if (!register_sysctl("abi", sve_default_vl_table))
+		if (!register_sysctl("abi", sve_default_vl_table,
+				     ARRAY_SIZE(sve_default_vl_table)))
 			return -EINVAL;
 
 	return 0;
@@ -619,7 +620,8 @@ static struct ctl_table sme_default_vl_table[] = {
 static int __init sme_sysctl_init(void)
 {
 	if (system_supports_sme())
-		if (!register_sysctl("abi", sme_default_vl_table))
+		if (!register_sysctl("abi", sme_default_vl_table,
+				     ARRAY_SIZE(sme_default_vl_table)))
 			return -EINVAL;
 
 	return 0;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0fcc4eb1a7ab..cfe232960f2f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -729,7 +729,8 @@ static struct ctl_table tagged_addr_sysctl_table[] = {
 
 static int __init tagged_addr_init(void)
 {
-	if (!register_sysctl("abi", tagged_addr_sysctl_table))
+	if (!register_sysctl("abi", tagged_addr_sysctl_table,
+			     ARRAY_SIZE(tagged_addr_sysctl_table)))
 		return -EINVAL;
 	return 0;
 }
diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 88b3ce3e66cd..66917b879b2a 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -248,7 +248,8 @@ machine_crash_setup(void)
 	if((ret = register_die_notifier(&kdump_init_notifier_nb)) != 0)
 		return ret;
 #ifdef CONFIG_SYSCTL
-	register_sysctl("kernel", kdump_ctl_table);
+	register_sysctl("kernel", kdump_ctl_table,
+			ARRAY_SIZE(kdump_ctl_table));
 #endif
 	return 0;
 }
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index b1c0418b25c8..3807169fc7e7 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -111,7 +111,8 @@ static struct ctl_table powersave_nap_ctl_table[] = {
 static int __init
 register_powersave_nap_sysctl(void)
 {
-	register_sysctl("kernel", powersave_nap_ctl_table);
+	register_sysctl("kernel", powersave_nap_ctl_table,
+			ARRAY_SIZE(powersave_nap_ctl_table));
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 6f30113b5468..9fdbee8ee126 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -65,7 +65,8 @@ static struct ctl_table nmi_wd_lpm_factor_ctl_table[] = {
 
 static int __init register_nmi_wd_lpm_factor_sysctl(void)
 {
-	register_sysctl("kernel", nmi_wd_lpm_factor_ctl_table);
+	register_sysctl("kernel", nmi_wd_lpm_factor_ctl_table,
+			ARRAY_SIZE(nmi_wd_lpm_factor_ctl_table));
 
 	return 0;
 }
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index b07b0610950e..54d8ed1c4518 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -408,7 +408,9 @@ static int __init appldata_init(void)
 	appldata_wq = alloc_ordered_workqueue("appldata", 0);
 	if (!appldata_wq)
 		return -ENOMEM;
-	appldata_sysctl_header = register_sysctl(appldata_proc_name, appldata_table);
+	appldata_sysctl_header = register_sysctl(appldata_proc_name,
+						 appldata_table,
+						 ARRAY_SIZE(appldata_table));
 	return 0;
 }
 
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index a85e0c3e7027..002f843e6523 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1564,7 +1564,8 @@ static int debug_sprintf_format_fn(debug_info_t *id, struct debug_view *view,
  */
 static int __init debug_init(void)
 {
-	s390dbf_sysctl_header = register_sysctl("s390dbf", s390dbf_table);
+	s390dbf_sysctl_header = register_sysctl("s390dbf", s390dbf_table,
+						ARRAY_SIZE(s390dbf_table));
 	mutex_lock(&debug_mutex);
 	debug_debugfs_root_entry = debugfs_create_dir(DEBUG_DIR_ROOT, NULL);
 	initialized = 1;
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 9fd19530c9a5..372d2c7c9a8e 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -647,7 +647,8 @@ static int __init topology_init(void)
 		set_topology_timer();
 	else
 		topology_update_polarization_simple();
-	register_sysctl("s390", topology_ctl_table);
+	register_sysctl("s390", topology_ctl_table,
+			ARRAY_SIZE(topology_ctl_table));
 
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 5300c6867d5e..918816dcb42a 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -379,7 +379,8 @@ static int __init cmm_init(void)
 {
 	int rc = -ENOMEM;
 
-	cmm_sysctl_header = register_sysctl("vm", cmm_table);
+	cmm_sysctl_header = register_sysctl("vm", cmm_table,
+					    ARRAY_SIZE(cmm_table));
 	if (!cmm_sysctl_header)
 		goto out_sysctl;
 #ifdef CONFIG_CMM_IUCV
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 66ab68db9842..a723f1a8236a 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -35,7 +35,8 @@ static struct ctl_table page_table_sysctl[] = {
 
 static int __init page_table_register_sysctl(void)
 {
-	return register_sysctl("vm", page_table_sysctl) ? 0 : -ENOMEM;
+	return register_sysctl("vm", page_table_sysctl,
+			       ARRAY_SIZE(page_table_sysctl)) ? 0 : -ENOMEM;
 }
 __initcall(page_table_register_sysctl);
 
diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index f3b3cacbcbb0..e28cdba83e0e 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -72,7 +72,7 @@ static struct ctl_table abi_table2[] = {
 
 static __init int ia32_binfmt_init(void)
 {
-	register_sysctl("abi", abi_table2);
+	register_sysctl("abi", abi_table2, ARRAY_SIZE(abi_table2));
 	return 0;
 }
 __initcall(ia32_binfmt_init);
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 670eb08b972a..58ec95fce798 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -105,7 +105,8 @@ int sched_set_itmt_support(void)
 		return 0;
 	}
 
-	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table);
+	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table,
+					     ARRAY_SIZE(itmt_kern_table));
 	if (!itmt_sysctl_header) {
 		mutex_unlock(&itmt_update_mutex);
 		return -ENOMEM;
diff --git a/crypto/fips.c b/crypto/fips.c
index 92fd506abb21..05a251680700 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -70,7 +70,8 @@ static struct ctl_table_header *crypto_sysctls;
 
 static void crypto_proc_fips_init(void)
 {
-	crypto_sysctls = register_sysctl("crypto", crypto_sysctl_table);
+	crypto_sysctls = register_sysctl("crypto", crypto_sysctl_table,
+					 ARRAY_SIZE(crypto_sysctl_table));
 }
 
 static void crypto_proc_fips_exit(void)
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index e5ac098d0742..7a2d584233bb 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -50,9 +50,9 @@ static struct ctl_table firmware_config_table[] = {
 static struct ctl_table_header *firmware_config_sysct_table_header;
 int register_firmware_config_sysctl(void)
 {
-	firmware_config_sysct_table_header =
-		register_sysctl("kernel/firmware_config",
-				firmware_config_table);
+	firmware_config_sysct_table_header = register_sysctl("kernel/firmware_config",
+							     firmware_config_table,
+							     ARRAY_SIZE(firmware_config_table));
 	if (!firmware_config_sysct_table_header)
 		return -ENOMEM;
 	return 0;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb..3855da76a16d 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3680,7 +3680,8 @@ static void cdrom_sysctl_register(void)
 	if (!atomic_add_unless(&initialized, 1, 1))
 		return;
 
-	cdrom_sysctl_header = register_sysctl("dev/cdrom", cdrom_table);
+	cdrom_sysctl_header = register_sysctl("dev/cdrom", cdrom_table,
+					      ARRAY_SIZE(cdrom_table));
 
 	/* set the defaults */
 	cdrom_sysctl_settings.autoclose = autoclose;
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ee71376f174b..bb1eb801b20c 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -1027,7 +1027,8 @@ static int __init hpet_init(void)
 	if (result < 0)
 		return -ENODEV;
 
-	sysctl_header = register_sysctl("dev/hpet", hpet_table);
+	sysctl_header = register_sysctl("dev/hpet", hpet_table,
+					ARRAY_SIZE(hpet_table));
 
 	result = acpi_bus_register_driver(&hpet_acpi_driver);
 	if (result < 0) {
diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 870659d91db2..46b1ea866da9 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -675,7 +675,8 @@ static int __init ipmi_poweroff_init(void)
 		pr_info("Power cycle is enabled\n");
 
 #ifdef CONFIG_PROC_FS
-	ipmi_table_header = register_sysctl("dev/ipmi", ipmi_table);
+	ipmi_table_header = register_sysctl("dev/ipmi", ipmi_table,
+					    ARRAY_SIZE(ipmi_table));
 	if (!ipmi_table_header) {
 		pr_err("Unable to register powercycle sysctl\n");
 		rv = -ENOMEM;
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 050b8ae7b8e7..f43950219ffc 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -5266,7 +5266,8 @@ static int destroy_config(int id, void *p, void *data)
 
 int i915_perf_sysctl_register(void)
 {
-	sysctl_header = register_sysctl("dev/i915", oa_table);
+	sysctl_header = register_sysctl("dev/i915", oa_table,
+					ARRAY_SIZE(oa_table));
 	return 0;
 }
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 64f9ceca887b..dd751c391cf7 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -302,7 +302,8 @@ int __init hv_common_init(void)
 		 * message recording won't be available in isolated
 		 * guests should the following registration fail.
 		 */
-		hv_ctl_table_hdr = register_sysctl("kernel", hv_ctl_table);
+		hv_ctl_table_hdr = register_sysctl("kernel", hv_ctl_table,
+						   ARRAY_SIZE(hv_ctl_table));
 		if (!hv_ctl_table_hdr)
 			pr_err("Hyper-V: sysctl table register error");
 
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index d8c4d5664145..5d433ef430fa 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -243,7 +243,8 @@ static struct ctl_table_header *mac_hid_sysctl_header;
 
 static int __init mac_hid_init(void)
 {
-	mac_hid_sysctl_header = register_sysctl("dev/mac_hid", mac_hid_files);
+	mac_hid_sysctl_header = register_sysctl("dev/mac_hid", mac_hid_files,
+						ARRAY_SIZE(mac_hid_files));
 	if (!mac_hid_sysctl_header)
 		return -ENOMEM;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8e344b4b3444..c10cc8ddd94d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9633,7 +9633,8 @@ static int __init md_init(void)
 	mdp_major = ret;
 
 	register_reboot_notifier(&md_notifier);
-	raid_table_header = register_sysctl("dev/raid", raid_table);
+	raid_table_header = register_sysctl("dev/raid", raid_table,
+					    ARRAY_SIZE(raid_table));
 
 	md_geninit();
 	return 0;
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 6da509d692bb..264b919d0610 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -1236,8 +1236,10 @@ xpc_init(void)
 		goto out_1;
 	}
 
-	xpc_sysctl = register_sysctl("xpc", xpc_sys_xpc);
-	xpc_sysctl_hb = register_sysctl("xpc/hb", xpc_sys_xpc_hb);
+	xpc_sysctl = register_sysctl("xpc", xpc_sys_xpc,
+				     ARRAY_SIZE(xpc_sys_xpc));
+	xpc_sysctl_hb = register_sysctl("xpc/hb", xpc_sys_xpc_hb,
+					ARRAY_SIZE(xpc_sys_xpc_hb));
 
 	/*
 	 * Fill the partition reserved page with the information needed by
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 4e5b972c3e26..16cee52f035f 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -464,7 +464,8 @@ int parport_proc_register(struct parport *port)
 		err = -ENOENT;
 		goto exit_free_tmp_dir_path;
 	}
-	t->devices_header = register_sysctl(tmp_dir_path, t->device_dir);
+	t->devices_header = register_sysctl(tmp_dir_path, t->device_dir,
+					    ARRAY_SIZE(t->device_dir));
 	if (t->devices_header == NULL) {
 		err = -ENOENT;
 		goto  exit_free_tmp_dir_path;
@@ -478,7 +479,8 @@ int parport_proc_register(struct parport *port)
 		goto unregister_devices_h;
 	}
 
-	t->port_header = register_sysctl(tmp_dir_path, t->vars);
+	t->port_header = register_sysctl(tmp_dir_path, t->vars,
+					 ARRAY_SIZE(t->vars));
 	if (t->port_header == NULL) {
 		err = -ENOENT;
 		goto unregister_devices_h;
@@ -544,7 +546,7 @@ int parport_device_proc_register(struct pardevice *device)
 
 	t->vars[0].data = &device->timeslice;
 
-	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
+	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars, ARRAY_SIZE(t->vars));
 	if (t->sysctl_header == NULL) {
 		kfree(t);
 		t = NULL;
@@ -579,7 +581,8 @@ static int __init parport_default_proc_register(void)
 	int ret;
 
 	parport_default_sysctl_table.sysctl_header =
-		register_sysctl("dev/parport/default", parport_default_sysctl_table.vars);
+		register_sysctl("dev/parport/default", parport_default_sysctl_table.vars,
+				ARRAY_SIZE(parport_default_sysctl_table.vars));
 	if (!parport_default_sysctl_table.sysctl_header)
 		return -ENOMEM;
 	ret = parport_bus_init();
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index c98e4039386d..763f9c8acfbf 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1188,7 +1188,8 @@ static void armv8_pmu_register_sysctl_table(void)
 	static u32 tbl_registered = 0;
 
 	if (!cmpxchg_relaxed(&tbl_registered, 0, 1))
-		register_sysctl("kernel", armv8_pmu_sysctl_table);
+		register_sysctl("kernel", armv8_pmu_sysctl_table,
+				ARRAY_SIZE(armv8_pmu_sysctl_table));
 }
 
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
diff --git a/drivers/scsi/scsi_sysctl.c b/drivers/scsi/scsi_sysctl.c
index 7f0914ea168f..0378bd63fea4 100644
--- a/drivers/scsi/scsi_sysctl.c
+++ b/drivers/scsi/scsi_sysctl.c
@@ -25,7 +25,8 @@ static struct ctl_table_header *scsi_table_header;
 
 int __init scsi_init_sysctl(void)
 {
-	scsi_table_header = register_sysctl("dev/scsi", scsi_table);
+	scsi_table_header = register_sysctl("dev/scsi", scsi_table,
+					    ARRAY_SIZE(scsi_table));
 	if (!scsi_table_header)
 		return -ENOMEM;
 	return 0;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 037f8c98a6d3..d12cdf875b50 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1646,7 +1646,8 @@ static struct ctl_table_header *hdr;
 static void register_sg_sysctls(void)
 {
 	if (!hdr)
-		hdr = register_sysctl("kernel", sg_sysctls);
+		hdr = register_sysctl("kernel", sg_sysctls,
+				      ARRAY_SIZE(sg_sysctls));
 }
 
 static void unregister_sg_sysctls(void)
diff --git a/fs/cachefiles/error_inject.c b/fs/cachefiles/error_inject.c
index 18de8a876b02..ea6bcce4f6f1 100644
--- a/fs/cachefiles/error_inject.c
+++ b/fs/cachefiles/error_inject.c
@@ -24,7 +24,8 @@ static struct ctl_table cachefiles_sysctls[] = {
 
 int __init cachefiles_register_error_injection(void)
 {
-	cachefiles_sysctl = register_sysctl("cachefiles", cachefiles_sysctls);
+	cachefiles_sysctl = register_sysctl("cachefiles", cachefiles_sysctls,
+					    ARRAY_SIZE(cachefiles_sysctls));
 	if (!cachefiles_sysctl)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index a247c14aaab7..16224a7c6691 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -42,7 +42,8 @@ static struct ctl_table coda_table[] = {
 void coda_sysctl_init(void)
 {
 	if ( !fs_table_header )
-		fs_table_header = register_sysctl("coda", coda_table);
+		fs_table_header = register_sysctl("coda", coda_table,
+						  ARRAY_SIZE(coda_table));
 }
 
 void coda_sysctl_clean(void)
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index fe3db0eda8e4..c17f971a8c4b 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -612,7 +612,8 @@ static int __init init_devpts_fs(void)
 {
 	int err = register_filesystem(&devpts_fs_type);
 	if (!err) {
-		register_sysctl("kernel/pty", pty_table);
+		register_sysctl("kernel/pty", pty_table,
+				ARRAY_SIZE(pty_table));
 	}
 	return err;
 }
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 980483455cc0..e1a0e6a6d3de 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -327,7 +327,7 @@ static struct ctl_table epoll_table[] = {
 
 static void __init epoll_sysctls_init(void)
 {
-	register_sysctl("fs/epoll", epoll_table);
+	register_sysctl("fs/epoll", epoll_table, ARRAY_SIZE(epoll_table));
 }
 #else
 #define epoll_sysctls_init() do { } while (0)
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index bb94949bc223..84736267f4e1 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -626,7 +626,8 @@ static int __init init_nlm(void)
 
 #ifdef CONFIG_SYSCTL
 	err = -ENOMEM;
-	nlm_sysctl_table = register_sysctl("fs/nfs", nlm_sysctls);
+	nlm_sysctl_table = register_sysctl("fs/nfs", nlm_sysctls,
+					   ARRAY_SIZE(nlm_sysctls));
 	if (nlm_sysctl_table == NULL)
 		goto err_sysctl;
 #endif
diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index e776200e9a11..4a542ee11e68 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -40,7 +40,8 @@ static struct ctl_table nfs4_cb_sysctls[] = {
 int nfs4_register_sysctl(void)
 {
 	nfs4_callback_sysctl_table = register_sysctl("fs/nfs",
-						     nfs4_cb_sysctls);
+						     nfs4_cb_sysctls,
+						     ARRAY_SIZE(nfs4_cb_sysctls));
 	if (nfs4_callback_sysctl_table == NULL)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
index f39e2089bc4c..9dafd44670e4 100644
--- a/fs/nfs/sysctl.c
+++ b/fs/nfs/sysctl.c
@@ -34,7 +34,8 @@ static struct ctl_table nfs_cb_sysctls[] = {
 
 int nfs_register_sysctl(void)
 {
-	nfs_callback_sysctl_table = register_sysctl("fs/nfs", nfs_cb_sysctls);
+	nfs_callback_sysctl_table = register_sysctl("fs/nfs", nfs_cb_sysctls,
+						    ARRAY_SIZE(nfs_cb_sysctls));
 	if (nfs_callback_sysctl_table == NULL)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 22fb1cf7e1fc..78d3bf479f59 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -91,7 +91,8 @@ static struct ctl_table fanotify_table[] = {
 
 static void __init fanotify_sysctls_init(void)
 {
-	register_sysctl("fs/fanotify", fanotify_table);
+	register_sysctl("fs/fanotify", fanotify_table,
+			ARRAY_SIZE(fanotify_table));
 }
 #else
 #define fanotify_sysctls_init() do { } while (0)
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 1c4bfdab008d..0ce25c4ddfec 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -90,7 +90,8 @@ static struct ctl_table inotify_table[] = {
 
 static void __init inotify_sysctls_init(void)
 {
-	register_sysctl("fs/inotify", inotify_table);
+	register_sysctl("fs/inotify", inotify_table,
+			ARRAY_SIZE(inotify_table));
 }
 
 #else
diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index 174fe536a1c0..2c48f48a0b80 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -44,7 +44,8 @@ int ntfs_sysctl(int add)
 {
 	if (add) {
 		BUG_ON(sysctls_root_table);
-		sysctls_root_table = register_sysctl("fs", ntfs_sysctls);
+		sysctls_root_table = register_sysctl("fs", ntfs_sysctls,
+						     ARRAY_SIZE(ntfs_sysctls));
 		if (!sysctls_root_table)
 			return -ENOMEM;
 	} else {
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index a8d5ca98fa57..9a653875d1c5 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -673,7 +673,8 @@ static int __init ocfs2_stack_glue_init(void)
 
 	strcpy(cluster_stack_name, OCFS2_STACK_PLUGIN_O2CB);
 
-	ocfs2_table_header = register_sysctl("fs/ocfs2/nm", ocfs2_nm_table);
+	ocfs2_table_header = register_sysctl("fs/ocfs2/nm", ocfs2_nm_table,
+					     ARRAY_SIZE(ocfs2_nm_table));
 	if (!ocfs2_table_header) {
 		printk(KERN_ERR
 		       "ocfs2 stack glue: unable to register sysctl\n");
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8c415048d540..66c9d7a07d2e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -43,7 +43,7 @@ struct ctl_table sysctl_mount_point[] = {
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl(path, sysctl_mount_point);
+	return register_sysctl(path, sysctl_mount_point, 0);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
@@ -1414,17 +1414,11 @@ struct ctl_table_header *__register_sysctl_table(
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
+struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table,
+					 size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-	struct ctl_table_header t_hdr;
-
-	t_hdr.ctl_table = table;
-	list_for_each_table_entry(entry, (&t_hdr))
-		count++;
 	return __register_sysctl_table(&sysctl_table_root.default_set,
-					path, table, count);
+					path, table, table_size);
 }
 EXPORT_SYMBOL(register_sysctl);
 
@@ -1451,7 +1445,14 @@ EXPORT_SYMBOL(register_sysctl);
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)
 {
-	struct ctl_table_header *hdr = register_sysctl(path, table);
+	int count = 0;
+	struct ctl_table *entry;
+	struct ctl_table_header t_hdr, *hdr;
+
+	t_hdr.ctl_table = table;
+	list_for_each_table_entry(entry, (&t_hdr))
+		count++;
+	hdr = register_sysctl(path, table, count);
 
 	if (unlikely(!hdr)) {
 		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index b8c51ad40d3a..f617c6a1f16c 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -103,7 +103,9 @@ static struct ctl_table fsverity_sysctl_table[] = {
 
 static int __init fsverity_sysctl_init(void)
 {
-	fsverity_sysctl_header = register_sysctl("fs/verity", fsverity_sysctl_table);
+	fsverity_sysctl_header = register_sysctl("fs/verity",
+						 fsverity_sysctl_table,
+						 ARRAY_SIZE(fsverity_sysctl_table));
 	if (!fsverity_sysctl_header) {
 		pr_err("sysctl registration failed!\n");
 		return -ENOMEM;
diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
index fade33735393..61075e9c9e37 100644
--- a/fs/xfs/xfs_sysctl.c
+++ b/fs/xfs/xfs_sysctl.c
@@ -213,7 +213,8 @@ static struct ctl_table xfs_table[] = {
 int
 xfs_sysctl_register(void)
 {
-	xfs_table_header = register_sysctl("fs/xfs", xfs_table);
+	xfs_table_header = register_sysctl("fs/xfs", xfs_table,
+					   ARRAY_SIZE(xfs_table));
 	if (!xfs_table_header)
 		return -ENOMEM;
 	return 0;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 0495c858989f..71d7935e50f0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -227,7 +227,8 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, struct ctl_table *table, size_t table_size);
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
+struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table,
+					 size_t table_size);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
@@ -262,7 +263,8 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 	return NULL;
 }
 
-static inline struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
+static inline struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table,
+						       size_t table_size)
 {
 	return NULL;
 }
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index d67a4d45bb42..8b24744752cb 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -48,7 +48,7 @@ static struct ctl_table pid_ns_ctl_table_vm[] = {
 };
 static inline void register_pid_ns_sysctl_table_vm(void)
 {
-	register_sysctl("vm", pid_ns_ctl_table_vm);
+	register_sysctl("vm", pid_ns_ctl_table_vm, ARRAY_SIZE(pid_ns_ctl_table_vm));
 }
 #else
 static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..de385b365a7a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -265,7 +265,7 @@ static struct ctl_table timer_sysctl[] = {
 
 static int __init timer_sysctl_init(void)
 {
-	register_sysctl("kernel", timer_sysctl);
+	register_sysctl("kernel", timer_sysctl, ARRAY_SIZE(timer_sysctl));
 	return 0;
 }
 device_initcall(timer_sysctl_init);
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 2b80264bb79f..59bf6983f1cf 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -365,7 +365,7 @@ static __init int user_namespace_sysctl_init(void)
 	 * default set so that registrations in the child sets work
 	 * properly.
 	 */
-	user_header = register_sysctl("user", empty);
+	user_header = register_sysctl("user", empty, 0);
 	kmemleak_ignore(user_header);
 	BUG_ON(!user_header);
 	BUG_ON(!setup_userns_sysctls(&init_user_ns));
diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 019e3a1566cf..24527b155538 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -138,7 +138,7 @@ void uts_proc_notify(enum uts_proc proc)
 
 static int __init utsname_sysctl_init(void)
 {
-	register_sysctl("kernel", uts_kern_table);
+	register_sysctl("kernel", uts_kern_table, ARRAY_SIZE(uts_kern_table));
 	return 0;
 }
 
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 8036aa91a1cb..83d37a163836 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -166,7 +166,8 @@ static int test_sysctl_setup_node_tests(void)
 	test_data.bitmap_0001 = kzalloc(SYSCTL_TEST_BITMAP_SIZE/8, GFP_KERNEL);
 	if (!test_data.bitmap_0001)
 		return -ENOMEM;
-	sysctl_test_headers.test_h_setup_node = register_sysctl("debug/test_sysctl", test_table);
+	sysctl_test_headers.test_h_setup_node = register_sysctl("debug/test_sysctl", test_table,
+					     ARRAY_SIZE(test_table));
 	if (!sysctl_test_headers.test_h_setup_node) {
 		kfree(test_data.bitmap_0001);
 		return -ENOMEM;
@@ -192,7 +193,8 @@ static int test_sysctl_run_unregister_nested(void)
 	struct ctl_table_header *unregister;
 
 	unregister = register_sysctl("debug/test_sysctl/unregister_error",
-				   test_table_unregister);
+				     test_table_unregister,
+				     ARRAY_SIZE(test_table_unregister));
 	if (!unregister)
 		return -ENOMEM;
 
@@ -209,7 +211,8 @@ static int test_sysctl_run_register_mount_point(void)
 
 	sysctl_test_headers.test_h_mnterror
 		= register_sysctl("debug/test_sysctl/mnt/mnt_error",
-				  test_table_unregister);
+				  test_table_unregister,
+				  ARRAY_SIZE(test_table_unregister));
 	/*
 	 * Don't check the result.:
 	 * If it fails (expected behavior), return 0.
diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 93941ab12549..61222addda7e 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -167,7 +167,8 @@ void
 rpc_register_sysctl(void)
 {
 	if (!sunrpc_table_header)
-		sunrpc_table_header = register_sysctl("sunrpc", debug_table);
+		sunrpc_table_header = register_sysctl("sunrpc", debug_table,
+						      ARRAY_SIZE(debug_table));
 }
 
 void
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index f0d5eeed4c88..df7fb9c8b785 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -246,7 +246,8 @@ static int svc_rdma_proc_init(void)
 		goto out_err;
 
 	svcrdma_table_header = register_sysctl("sunrpc/svc_rdma",
-					       svcrdma_parm_table);
+					       svcrdma_parm_table,
+					       ARRAY_SIZE(svcrdma_parm_table));
 	return 0;
 
 out_err:
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 29b0562d62e7..bf43e05044a3 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -790,7 +790,9 @@ int xprt_rdma_init(void)
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	if (!sunrpc_table_header)
-		sunrpc_table_header = register_sysctl("sunrpc", xr_tunables_table);
+		sunrpc_table_header = register_sysctl("sunrpc",
+						      xr_tunables_table,
+						      ARRAY_SIZE(xr_tunables_table));
 #endif
 	return 0;
 }
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 5f9030b81c9e..7c3d5ed708be 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -3169,7 +3169,9 @@ static struct xprt_class	xs_bc_tcp_transport = {
 int init_socket_xprt(void)
 {
 	if (!sunrpc_table_header)
-		sunrpc_table_header = register_sysctl("sunrpc", xs_tunables_table);
+		sunrpc_table_header = register_sysctl("sunrpc",
+						      xs_tunables_table,
+						      ARRAY_SIZE(xs_tunables_table));
 
 	xprt_register_transport(&xs_local_transport);
 	xprt_register_transport(&xs_udp_transport);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 1757c18ea065..f96e6633fdd3 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -101,7 +101,7 @@ __init int net_sysctl_init(void)
 	 * registering "/proc/sys/net" as an empty directory not in a
 	 * network namespace.
 	 */
-	net_header = register_sysctl("net", empty);
+	net_header = register_sysctl("net", empty, 0);
 	if (!net_header)
 		goto out;
 	ret = register_pernet_subsys(&sysctl_pernet_ops);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f431251ffb91..b77344506cf3 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1785,7 +1785,8 @@ static struct ctl_table apparmor_sysctl_table[] = {
 
 static int __init apparmor_init_sysctl(void)
 {
-	return register_sysctl("kernel", apparmor_sysctl_table) ? 0 : -ENOMEM;
+	return register_sysctl("kernel", apparmor_sysctl_table,
+			       ARRAY_SIZE(apparmor_sysctl_table)) ? 0 : -ENOMEM;
 }
 #else
 static inline int apparmor_init_sysctl(void)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ebae964f7cc9..6f2cc827df41 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -256,7 +256,8 @@ static int __init loadpin_init(void)
 		enforce ? "" : "not ");
 	parse_exclude();
 #ifdef CONFIG_SYSCTL
-	if (!register_sysctl("kernel/loadpin", loadpin_sysctl_table))
+	if (!register_sysctl("kernel/loadpin", loadpin_sysctl_table,
+			     ARRAY_SIZE(loadpin_sysctl_table)))
 		pr_notice("sysctl registration failed!\n");
 #endif
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 2503cf153d4a..7b8164a4b504 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -461,7 +461,8 @@ static struct ctl_table yama_sysctl_table[] = {
 };
 static void __init yama_init_sysctl(void)
 {
-	if (!register_sysctl("kernel/yama", yama_sysctl_table))
+	if (!register_sysctl("kernel/yama", yama_sysctl_table,
+			     ARRAY_SIZE(yama_sysctl_table)))
 		panic("Yama: sysctl registration failed.\n");
 }
 #else
-- 
2.30.2

