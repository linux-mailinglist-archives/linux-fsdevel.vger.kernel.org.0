Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D6738075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjFUJsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjFUJsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:48:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E87E9;
        Wed, 21 Jun 2023 02:48:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621094825euoutp0181b4f6b040aecf3eeebdeaf12ec2cb95~qo50ZY65B2236622366euoutp01_;
        Wed, 21 Jun 2023 09:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621094825euoutp0181b4f6b040aecf3eeebdeaf12ec2cb95~qo50ZY65B2236622366euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687340905;
        bh=hW7nv4xAjVfG7za+1C5oUlGPxr8RrFgRO4qPCmCRgg4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pvqcIs+1ajOpVCiyEQvsllPVyFIFy9DNCDjcSoLtGIHFsF/eeGNWaxfu+hnFPU5U8
         Qgr/Wkz7tKZcVV91E4yYDuQRnhhP8MEH8JVYfcjgIbcusHKAmDEFhlMf6a3Eexw3sc
         v2ojHF1rzsp7Mu1ArtQ56tO7A6yjgr0QAiZFYi4o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621094825eucas1p1548829d9f587def24707307e2152e9d2~qo5z9joL92428124281eucas1p1e;
        Wed, 21 Jun 2023 09:48:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 55.37.11320.867C2946; Wed, 21
        Jun 2023 10:48:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3~qo5zHPofw2803828038eucas1p2j;
        Wed, 21 Jun 2023 09:48:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230621094824eusmtrp1ad53bbd4b5f9d962f68895e21ba8293f~qo5zCs_hA1249712497eusmtrp1W;
        Wed, 21 Jun 2023 09:48:24 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-44-6492c768f5f8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.F5.10549.767C2946; Wed, 21
        Jun 2023 10:48:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621094823eusmtip29cf7ab827cf574b4306610d555107eae~qo5yRx4Lo1505515055eusmtip2Y;
        Wed, 21 Jun 2023 09:48:23 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:48:21 +0100
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
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Song Liu <song@kernel.org>, Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        David Howells <dhowells@redhat.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Anton Altaparmakov <anton@tuxera.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        John Stultz <jstultz@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Remi Denis-Courmont <courmisch@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Martin Schiller <ms@dev.tdt.de>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Joel Granados <j.granados@samsung.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-hyperv@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-aio@kvack.org>, <linux-cachefs@redhat.com>,
        <codalist@coda.cs.cmu.edu>, <linux-mm@kvack.org>,
        <linux-nfs@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>,
        <ocfs2-devel@oss.oracle.com>, <fsverity@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kexec@lists.infradead.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-hams@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
        <coreteam@netfilter.org>, <bridge@lists.linux-foundation.org>,
        <dccp@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
        <mptcp@lists.linux.dev>, <lvs-devel@vger.kernel.org>,
        <rds-devel@oss.oracle.com>, <linux-afs@lists.infradead.org>,
        <linux-sctp@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        <linux-x25@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: [PATCH 09/11] sysctl: Remove the end element in sysctl table arrays
Date:   Wed, 21 Jun 2023 11:48:00 +0200
Message-ID: <20230621094817.433842-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0yTZxT2/b6vFxm4Aipv0GWEqcmcgG4sO2Zg5qLu2+KiYWNzbpk28AWY
        XFwLohI3akFEUNsyMALjKgVHN2dty2CA2HWlyF1BEAG5jovcW6owLisUF/49z/uc55zznOTl
        kg59HGduUGg4IwjlB7uybSiNfqbOLbBS5r/z3nUPuF09xAZDSw4Bfw4+oSC2eJGCYqWKBfMy
        PQcmzseSoFCJCHj21xQCg+IJBx70NrPh2pCIgvShGg6MyxMRtMsGOLDYMUDADUM3AfPFcSQs
        aqQk5GabSRj8PQ5Ben0MBf0SNQlN0+Ns+LV0jgTN5UIE4+Jv4VERDSm3nSBNcoeAvqs9LMh/
        eAtBV7Mz5LRqCKiqM1OgacpE0HE1mYKahBBQt59nw0D5ZQIaNFdY0Feo5sBPs3kkxD/Po0By
        fxeUllVRls4dBExcHGNBp2KRBQ0V1SyIyyxBIMkWk6C7VUtBe5KcgooyS3NtchmCar2BAnHm
        FAmzBZUsyGtpJEARf9OyUuUCAa2SfgS5+ds+4NOKDAWiHz5qJOl/Z2WIzlBE0WnRjRQ9/biO
        oGdnttOqm48JOkE3TNL9jT50mTmLootTOzh0THkbh85SRtAlJSIL042yDrsdtfHyZ4KDTjEC
        jz3HbQJVbQ2ckylS1ukuqRxFo6558hJay8U8T5z3Tz5xCdlwHXgFCN+ta6asxIRwnLlrhRgR
        lg/ks15aLty4haxCPsLdv+k5/1e9kCvZVqJGWNl6n71kYfN24PqRdnJJWM+L2YZ/Vg8uNyZ5
        6etx9+QCsVTlyDuI00YfLzso3lasNcUuYzueF9blPGFbh7+OL7RcQ0t4Lc8b1/eOU9Yae1x1
        vW8Zk5YasTqNtGKM7w0OrmR9A7eU5670OYfvq9qWc2Neji3ubDERVmEfVtQ2rWBHPFyp4ljx
        ZlydlEhZDUmWQy1McKyk0HIb0fSK430c09S34tiLDTl/W8ZxLXgdbh21t260Dss010jrsx2+
        eMFBgrakrsqQuipD6qoMWYj8BTkxEcKQAEb4digT6S7khwgjQgPc/cJClMjyEasXKk1/oPzh
        SXctIrhIizCXdF1v95pS5u9g588/c5YRhB0TRAQzQi3axKVcneze8q7yc+AF8MOZEwxzkhG8
        VAnuWudo4sRXYuPRDCczv/v70Bk9rYs7RJ329jOaKtqed481+tQYdxeObJd/0hBqv8b3G9V3
        uiJW65aJo5/P1domlKYzB9sOqM0fi/gVeq9Mvxdvhh/SuyWaXEaIuGST5CmKCvPYDK+6+Jbv
        6ZkdHtl33Dt2t6Czeef4g0JcahT0RxbdRBt2nboi3trWc65gb9ExqnN/sX4x5bCnTBv5yqbo
        wKADG3ufhW88eDEn6Mt3P/zhU7HA88wX0vgfo6akAUMKvGW41kXqcdf57EdHsrnvrKnR7jdM
        Nqb0vje3VXVHOe8r4QeP7ZCLFj5jezomefpE2vZ+LaVq+NNH6qKrKryNs14bynVPM10pYSB/
        13ZSIOT/BweDHzr3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTH99x7e1tYairiuCEuLmVqwqRQ3jwQIFv4clU0muHCnJN1UoFJ
        gbWgm2AECjJgKPBBGIXKRJBheauFCSMQK9KyEkFAWMEBtjhex/uLCIUV6hK+PPk/5/x+z5Pz
        4bBwm0ymPSs8MkYojhREcElrQrehGXQK1eSEuJQpHaFGN06Ctu8uBgVVChLUCUegs/IBgpU1
        GQ5/jA0QkFK/SUC9UsWAxNYiBphyWpmwuDrAhPQNFQGzSSk4KFSJGBhNahIWqjfMR4uGhMkn
        8wi0CjPXZXxBQu54IgEF4+1MmCn9GcHLnFEmbP49isE97SsMlhV/YZAgXSfBVJ+Kw8KrUQZs
        1mXjUPzrMg5j1akICjqSCTD1ZZDQlKxE0JRXQcJ00hoBr7Nqcege2QU9SzMkVDakYGY1mQkV
        jes4vG41MCHNsElCXaZ5qhnpeejMX2aAtLiKhN7faVBrmpkwKS9HkDGxD6S1Swhu19iBLOsh
        BiO3DAyQ5UoxKBlIY0BP6SwJ97urEOSsZqFPnyK6u+c4vZJyk6CHpkwErZArzKXe5zi99jYH
        0f2GJZyeftaGaLkijs5PyCRpWcJzgn6gaMHpopYAekn/DKPfrjrSqt/02KkzZ3k+4qjYGOFH
        YVGSGF/uV3xw5fG9gOfq7sXjux352tvVg+vs5xMijAi/LBQ7+33DC1P1dzKjb2czfhjOLkUJ
        aNiEpyMrFsVxp27cq0LpyJplwylB1NgdPdPS2EfVLL5gWPIear03nbRAc4h62jPJsFxqEbVY
        Ub1tkJzDVMfUS3yrYctJOkjVdk1tUzgnz5ZqU8jRFrWHE0DJ/tWTW5ngHKDUiynbmc3xoVru
        DpCW//ZTN/pyt3krji/VYZwhtrKNmbkz240s/G6q7ZeR7Tpu5qW1MtySKerx2Ni74Ryovqbi
        d29eoxZM/6AsZJu/Q8/foefv0IsQXo5shbESUahIwudJBCJJbGQo70KUSInMe1HXuvrwEZJP
        zPHUCGMhNaJYONeW/aEyJ8SGHSL48apQHBUsjo0QStTIwzxnNm6/90KUebEiY4L5ni4efHdP
        LxcPL083rh37aPRPAhtOqCBGeEkojBaK//cwlpV9AnbsepzB62jXxpv7Iy2SGRYDdGr6ymfs
        suTlik+k1wOxD/rSU0mH2HOiWrcTT5o/rlkuZDtc1vkP6csPRnTvLbT9cjxguEXbzzpkjN/t
        z/AWqJo3H+OBeefOGxYja5znr/BLGgLrhnD2ycjvjU63SvWmU3amzwsb6DyJMncW5v/8Tqeo
        2WU9kj5QmuFADVQYHXu5cUHSxfLUY/qF06MOZZdYHWPymf2NHLusyptXs7hFvo2as4eCCr44
        0T7tGRymzBz/VqWbeC/vzfpa2rXjwSe9g0a1ovjTxUbNnE+4/0W6IMlJ7jJ45mKncDCj+P32
        5cOQWGLQ9vgFPdKuBFdUxnMJSZiA74iLJYL/AN+vVrqgBAAA
X-CMS-MailID: 20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3
X-Msg-Generator: CA
X-RootMTR: 20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3@eucas1p2.samsung.com>
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

Remove the empty end element from all the arrays that are passed to the
register sysctl calls. In some files this means reducing the explicit
array size by one. Also make sure that we are using the size in
ctl_table_header instead of evaluating the .procname element.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/arm/kernel/isa.c                         |  4 +-
 arch/arm64/kernel/armv8_deprecated.c          |  8 ++--
 arch/arm64/kernel/fpsimd.c                    |  6 +--
 arch/arm64/kernel/process.c                   |  3 +-
 arch/ia64/kernel/crash.c                      |  3 +-
 arch/powerpc/kernel/idle.c                    |  3 +-
 arch/powerpc/platforms/pseries/mobility.c     |  3 +-
 arch/s390/appldata/appldata_base.c            |  7 ++--
 arch/s390/kernel/debug.c                      |  3 +-
 arch/s390/kernel/topology.c                   |  3 +-
 arch/s390/mm/cmm.c                            |  3 +-
 arch/s390/mm/pgalloc.c                        |  3 +-
 arch/x86/entry/vdso/vdso32-setup.c            |  3 +-
 arch/x86/kernel/cpu/intel.c                   |  3 +-
 arch/x86/kernel/itmt.c                        |  3 +-
 crypto/fips.c                                 |  3 +-
 drivers/base/firmware_loader/fallback_table.c |  3 +-
 drivers/cdrom/cdrom.c                         |  3 +-
 drivers/char/hpet.c                           | 13 +++---
 drivers/char/ipmi/ipmi_poweroff.c             |  3 +-
 drivers/char/random.c                         |  3 +-
 drivers/gpu/drm/i915/i915_perf.c              | 33 +++++++--------
 drivers/hv/hv_common.c                        |  3 +-
 drivers/infiniband/core/iwcm.c                |  3 +-
 drivers/infiniband/core/ucma.c                |  3 +-
 drivers/macintosh/mac_hid.c                   |  3 +-
 drivers/md/md.c                               |  3 +-
 drivers/misc/sgi-xp/xpc_main.c                |  6 +--
 drivers/net/vrf.c                             |  3 +-
 drivers/parport/procfs.c                      | 42 ++++++++-----------
 drivers/perf/arm_pmuv3.c                      |  3 +-
 drivers/scsi/scsi_sysctl.c                    |  3 +-
 drivers/scsi/sg.c                             |  3 +-
 drivers/tty/tty_io.c                          |  3 +-
 drivers/xen/balloon.c                         |  3 +-
 fs/aio.c                                      |  3 +-
 fs/cachefiles/error_inject.c                  |  3 +-
 fs/coda/sysctl.c                              |  3 +-
 fs/coredump.c                                 |  3 +-
 fs/dcache.c                                   |  3 +-
 fs/devpts/inode.c                             |  3 +-
 fs/eventpoll.c                                |  3 +-
 fs/exec.c                                     |  3 +-
 fs/file_table.c                               |  3 +-
 fs/inode.c                                    |  3 +-
 fs/lockd/svc.c                                |  3 +-
 fs/locks.c                                    |  3 +-
 fs/namei.c                                    |  3 +-
 fs/namespace.c                                |  3 +-
 fs/nfs/nfs4sysctl.c                           |  3 +-
 fs/nfs/sysctl.c                               |  3 +-
 fs/notify/dnotify/dnotify.c                   |  3 +-
 fs/notify/fanotify/fanotify_user.c            |  3 +-
 fs/notify/inotify/inotify_user.c              |  3 +-
 fs/ntfs/sysctl.c                              |  3 +-
 fs/ocfs2/stackglue.c                          |  3 +-
 fs/pipe.c                                     |  3 +-
 fs/proc/proc_sysctl.c                         |  8 ++--
 fs/quota/dquot.c                              |  3 +-
 fs/sysctls.c                                  |  3 +-
 fs/userfaultfd.c                              |  3 +-
 fs/verity/signature.c                         |  3 +-
 fs/xfs/xfs_sysctl.c                           |  4 +-
 init/do_mounts_initrd.c                       |  3 +-
 ipc/ipc_sysctl.c                              |  3 +-
 ipc/mq_sysctl.c                               |  3 +-
 kernel/acct.c                                 |  3 +-
 kernel/bpf/syscall.c                          |  3 +-
 kernel/delayacct.c                            |  3 +-
 kernel/exit.c                                 |  3 +-
 kernel/hung_task.c                            |  3 +-
 kernel/kexec_core.c                           |  3 +-
 kernel/kprobes.c                              |  3 +-
 kernel/latencytop.c                           |  3 +-
 kernel/locking/lockdep.c                      |  3 +-
 kernel/panic.c                                |  3 +-
 kernel/pid_namespace.c                        |  3 +-
 kernel/pid_sysctl.h                           |  3 +-
 kernel/printk/sysctl.c                        |  3 +-
 kernel/reboot.c                               |  3 +-
 kernel/sched/autogroup.c                      |  3 +-
 kernel/sched/core.c                           |  3 +-
 kernel/sched/deadline.c                       |  3 +-
 kernel/sched/fair.c                           |  3 +-
 kernel/sched/rt.c                             |  3 +-
 kernel/sched/topology.c                       |  3 +-
 kernel/seccomp.c                              |  3 +-
 kernel/signal.c                               |  3 +-
 kernel/stackleak.c                            |  3 +-
 kernel/sysctl.c                               |  6 +--
 kernel/time/timer.c                           |  3 +-
 kernel/trace/ftrace.c                         |  3 +-
 kernel/trace/trace_events_user.c              |  3 +-
 kernel/ucount.c                               |  7 ++--
 kernel/umh.c                                  |  3 +-
 kernel/utsname_sysctl.c                       |  3 +-
 kernel/watchdog.c                             |  3 +-
 lib/test_sysctl.c                             |  6 +--
 mm/compaction.c                               |  3 +-
 mm/hugetlb.c                                  |  3 +-
 mm/hugetlb_vmemmap.c                          |  3 +-
 mm/memory-failure.c                           |  3 +-
 mm/oom_kill.c                                 |  3 +-
 mm/page-writeback.c                           |  3 +-
 net/appletalk/sysctl_net_atalk.c              |  3 +-
 net/ax25/sysctl_net_ax25.c                    |  5 +--
 net/bridge/br_netfilter_hooks.c               |  3 +-
 net/core/neighbour.c                          | 14 +++----
 net/core/sysctl_net_core.c                    |  6 +--
 net/dccp/sysctl.c                             |  4 +-
 net/ieee802154/6lowpan/reassembly.c           |  6 +--
 net/ipv4/devinet.c                            |  5 +--
 net/ipv4/ip_fragment.c                        |  6 +--
 net/ipv4/route.c                              |  6 +--
 net/ipv4/sysctl_net_ipv4.c                    |  6 +--
 net/ipv4/xfrm4_policy.c                       |  3 +-
 net/ipv6/addrconf.c                           |  5 +--
 net/ipv6/icmp.c                               |  3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c       |  3 +-
 net/ipv6/reassembly.c                         |  6 +--
 net/ipv6/route.c                              |  3 +-
 net/ipv6/sysctl_net_ipv6.c                    |  6 +--
 net/ipv6/xfrm6_policy.c                       |  3 +-
 net/llc/sysctl_net_llc.c                      |  4 +-
 net/mpls/af_mpls.c                            | 10 ++---
 net/mptcp/ctrl.c                              |  3 +-
 net/netfilter/ipvs/ip_vs_ctl.c                |  3 +-
 net/netfilter/ipvs/ip_vs_lblc.c               |  3 +-
 net/netfilter/ipvs/ip_vs_lblcr.c              |  3 +-
 net/netfilter/nf_conntrack_standalone.c       | 10 ++---
 net/netfilter/nf_log.c                        |  5 +--
 net/netrom/sysctl_net_netrom.c                |  3 +-
 net/phonet/sysctl.c                           |  3 +-
 net/rds/ib_sysctl.c                           |  3 +-
 net/rds/sysctl.c                              |  3 +-
 net/rds/tcp.c                                 |  3 +-
 net/rose/sysctl_net_rose.c                    |  3 +-
 net/rxrpc/sysctl.c                            |  3 +-
 net/sctp/sysctl.c                             | 10 ++---
 net/smc/smc_sysctl.c                          |  3 +-
 net/sunrpc/sysctl.c                           |  3 +-
 net/sunrpc/xprtrdma/svc_rdma.c                |  3 +-
 net/sunrpc/xprtrdma/transport.c               |  3 +-
 net/sunrpc/xprtsock.c                         |  3 +-
 net/tipc/sysctl.c                             |  3 +-
 net/unix/sysctl_net_unix.c                    |  3 +-
 net/x25/sysctl_net_x25.c                      |  3 +-
 net/xfrm/xfrm_sysctl.c                        |  3 +-
 security/apparmor/lsm.c                       |  4 +-
 security/keys/sysctl.c                        |  7 ++--
 security/loadpin/loadpin.c                    |  3 +-
 security/yama/yama_lsm.c                      |  3 +-
 152 files changed, 228 insertions(+), 407 deletions(-)

diff --git a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
index 561432e3c55a..72b1a0e63d21 100644
--- a/arch/arm/kernel/isa.c
+++ b/arch/arm/kernel/isa.c
@@ -16,7 +16,7 @@
 
 static unsigned int isa_membase, isa_portbase, isa_portshift;
 
-static struct ctl_table ctl_isa_vars[4] = {
+static struct ctl_table ctl_isa_vars[] = {
 	{
 		.procname	= "membase",
 		.data		= &isa_membase, 
@@ -35,7 +35,7 @@ static struct ctl_table ctl_isa_vars[4] = {
 		.maxlen		= sizeof(isa_portshift),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
-	}, {}
+	}
 };
 
 static struct ctl_table_header *isa_sysctl_header;
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 68ed60a521a6..43945a8bb8e0 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -52,10 +52,8 @@ struct insn_emulation {
 	int min;
 	int max;
 
-	/*
-	 * sysctl for this emulation + a sentinal entry.
-	 */
-	struct ctl_table sysctl[2];
+	/* sysctl for this emulation */
+	struct ctl_table sysctl;
 };
 
 #define ARM_OPCODE_CONDTEST_FAIL   0
@@ -558,7 +556,7 @@ static void __init register_insn_emulation(struct insn_emulation *insn)
 	update_insn_emulation_mode(insn, INSN_UNDEF);
 
 	if (insn->status != INSN_UNAVAILABLE) {
-		sysctl = &insn->sysctl[0];
+		sysctl = &insn->sysctl;
 
 		sysctl->mode = 0644;
 		sysctl->maxlen = sizeof(int);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ecfb2ef6a036..37155b4ae893 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -588,8 +588,7 @@ static struct ctl_table sve_default_vl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= vec_proc_do_default_vl,
 		.extra1		= &vl_info[ARM64_VEC_SVE],
-	},
-	{ }
+	}
 };
 
 static int __init sve_sysctl_init(void)
@@ -613,8 +612,7 @@ static struct ctl_table sme_default_vl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= vec_proc_do_default_vl,
 		.extra1		= &vl_info[ARM64_VEC_SME],
-	},
-	{ }
+	}
 };
 
 static int __init sme_sysctl_init(void)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index cfe232960f2f..ae837130a265 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -723,8 +723,7 @@ static struct ctl_table tagged_addr_sysctl_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init tagged_addr_init(void)
diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 66917b879b2a..958ab3bbbdbc 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -231,8 +231,7 @@ static struct ctl_table kdump_ctl_table[] = {
 		.maxlen = sizeof(int),
 		.mode = 0644,
 		.proc_handler = proc_dointvec,
-	},
-	{ }
+	}
 };
 #endif
 
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 3807169fc7e7..f98f7b00d3cf 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -104,8 +104,7 @@ static struct ctl_table powersave_nap_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 
 static int __init
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 9fdbee8ee126..48337c9dd3a0 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -59,8 +59,7 @@ static struct ctl_table nmi_wd_lpm_factor_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-	},
-	{}
+	}
 };
 
 static int __init register_nmi_wd_lpm_factor_sysctl(void)
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 54d8ed1c4518..0e1136b3dc01 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -62,8 +62,7 @@ static struct ctl_table appldata_table[] = {
 		.procname	= "interval",
 		.mode		= S_IRUGO | S_IWUSR,
 		.proc_handler	= appldata_interval_handler,
-	},
-	{ },
+	}
 };
 
 /*
@@ -352,7 +351,7 @@ int appldata_register_ops(struct appldata_ops *ops)
 		return -EINVAL;
 
 	/* The last entry must be an empty one */
-	ops->ctl_table = kcalloc(2, sizeof(struct ctl_table), GFP_KERNEL);
+	ops->ctl_table = kcalloc(1, sizeof(struct ctl_table), GFP_KERNEL);
 	if (!ops->ctl_table)
 		return -ENOMEM;
 
@@ -365,7 +364,7 @@ int appldata_register_ops(struct appldata_ops *ops)
 	ops->ctl_table[0].proc_handler = appldata_generic_handler;
 	ops->ctl_table[0].data = ops;
 
-	ops->sysctl_header = register_sysctl(appldata_proc_name, ops->ctl_table);
+	ops->sysctl_header = register_sysctl(appldata_proc_name, ops->ctl_table, 1);
 	if (!ops->sysctl_header)
 		goto out;
 	return 0;
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 002f843e6523..24f33be6565d 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -977,8 +977,7 @@ static struct ctl_table s390dbf_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= S_IRUGO | S_IWUSR,
 		.proc_handler	= s390dbf_procactive,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table_header *s390dbf_sysctl_header;
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 372d2c7c9a8e..931da71b8a4a 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -633,8 +633,7 @@ static struct ctl_table topology_ctl_table[] = {
 		.procname	= "topology",
 		.mode		= 0644,
 		.proc_handler	= topology_ctl_handler,
-	},
-	{ },
+	}
 };
 
 static int __init topology_init(void)
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 918816dcb42a..1b304352a3e9 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -331,8 +331,7 @@ static struct ctl_table cmm_table[] = {
 		.procname	= "cmm_timeout",
 		.mode		= 0644,
 		.proc_handler	= cmm_timeout_handler,
-	},
-	{ }
+	}
 };
 
 #ifdef CONFIG_CMM_IUCV
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index a723f1a8236a..59444f580d0d 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -29,8 +29,7 @@ static struct ctl_table page_table_sysctl[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init page_table_register_sysctl(void)
diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index e28cdba83e0e..ab794f70a550 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -66,8 +66,7 @@ static struct ctl_table abi_table2[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static __init int ia32_binfmt_init(void)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c77a3961443d..d446f2a0fbeb 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1189,8 +1189,7 @@ static struct ctl_table sld_sysctls[] = {
 		.proc_handler	= proc_douintvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static int __init sld_mitigate_sysctl_init(void)
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 58ec95fce798..427093e4ef87 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -73,8 +73,7 @@ static struct ctl_table itmt_kern_table[] = {
 		.proc_handler	= sched_itmt_update_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static struct ctl_table_header *itmt_sysctl_header;
diff --git a/crypto/fips.c b/crypto/fips.c
index 05a251680700..611a86bd2538 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -62,8 +62,7 @@ static struct ctl_table crypto_sysctl_table[] = {
 		.maxlen		= 64,
 		.mode		= 0444,
 		.proc_handler	= proc_dostring
-	},
-	{}
+	}
 };
 
 static struct ctl_table_header *crypto_sysctls;
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 7a2d584233bb..d7dedfb2f4d0 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -43,8 +43,7 @@ static struct ctl_table firmware_config_table[] = {
 		.proc_handler   = proc_douintvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table_header *firmware_config_sysct_table_header;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 3855da76a16d..e1c352ebab16 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3668,8 +3668,7 @@ static struct ctl_table cdrom_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= cdrom_sysctl_handler
-	},
-	{ }
+	}
 };
 static struct ctl_table_header *cdrom_sysctl_header;
 
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index bb1eb801b20c..44eaec98f958 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -722,13 +722,12 @@ static int hpet_is_known(struct hpet_data *hdp)
 
 static struct ctl_table hpet_table[] = {
 	{
-	 .procname = "max-user-freq",
-	 .data = &hpet_max_freq,
-	 .maxlen = sizeof(int),
-	 .mode = 0644,
-	 .proc_handler = proc_dointvec,
-	 },
-	{}
+		.procname = "max-user-freq",
+		.data = &hpet_max_freq,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec,
+	}
 };
 
 static struct ctl_table_header *sysctl_header;
diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 46b1ea866da9..40c43417a42e 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -655,8 +655,7 @@ static struct ctl_table ipmi_table[] = {
 	  .data		= &poweroff_powercycle,
 	  .maxlen	= sizeof(poweroff_powercycle),
 	  .mode		= 0644,
-	  .proc_handler	= proc_dointvec },
-	{ }
+	  .proc_handler	= proc_dointvec }
 };
 
 static struct ctl_table_header *ipmi_table_header;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8db2ea9e3d66..e2998580afc6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1682,8 +1682,7 @@ static struct ctl_table random_table[] = {
 		.procname	= "uuid",
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
-	},
-	{ }
+	}
 };
 
 /*
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index f43950219ffc..e4d7372afb10 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4884,24 +4884,23 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
 
 static struct ctl_table oa_table[] = {
 	{
-	 .procname = "perf_stream_paranoid",
-	 .data = &i915_perf_stream_paranoid,
-	 .maxlen = sizeof(i915_perf_stream_paranoid),
-	 .mode = 0644,
-	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = SYSCTL_ZERO,
-	 .extra2 = SYSCTL_ONE,
-	 },
+		.procname = "perf_stream_paranoid",
+		.data = &i915_perf_stream_paranoid,
+		.maxlen = sizeof(i915_perf_stream_paranoid),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_minmax,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = SYSCTL_ONE,
+	},
 	{
-	 .procname = "oa_max_sample_rate",
-	 .data = &i915_oa_max_sample_rate,
-	 .maxlen = sizeof(i915_oa_max_sample_rate),
-	 .mode = 0644,
-	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = SYSCTL_ZERO,
-	 .extra2 = &oa_sample_rate_hard_limit,
-	 },
-	{}
+		.procname = "oa_max_sample_rate",
+		.data = &i915_oa_max_sample_rate,
+		.maxlen = sizeof(i915_oa_max_sample_rate),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_minmax,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = &oa_sample_rate_hard_limit,
+	}
 };
 
 static u32 num_perf_groups_per_gt(struct intel_gt *gt)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index dd751c391cf7..0216ccd96496 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -146,8 +146,7 @@ static struct ctl_table hv_ctl_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
-	},
-	{}
+	}
 };
 
 static int hv_die_panic_notify_crash(struct notifier_block *self,
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 20627a894c89..0147aae8fe9b 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -110,8 +110,7 @@ static struct ctl_table iwcm_ctl_table[] = {
 		.maxlen		= sizeof(default_backlog),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 /*
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index f737ab0de883..cbe1ebef2f2e 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -70,8 +70,7 @@ static struct ctl_table ucma_ctl_table[] = {
 		.maxlen		= sizeof max_backlog,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 struct ucma_file {
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 5d433ef430fa..822517cf4735 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -235,8 +235,7 @@ static struct ctl_table mac_hid_files[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table_header *mac_hid_sysctl_header;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c10cc8ddd94d..3ad23a7bfbc5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -318,8 +318,7 @@ static struct ctl_table raid_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= S_IRUGO|S_IWUSR,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static int start_readonly;
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 264b919d0610..3e6a598df22a 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -109,8 +109,7 @@ static struct ctl_table xpc_sys_xpc_hb[] = {
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec_minmax,
 	 .extra1 = &xpc_hb_check_min_interval,
-	 .extra2 = &xpc_hb_check_max_interval},
-	{}
+	 .extra2 = &xpc_hb_check_max_interval}
 };
 static struct ctl_table xpc_sys_xpc[] = {
 	{
@@ -120,8 +119,7 @@ static struct ctl_table xpc_sys_xpc[] = {
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec_minmax,
 	 .extra1 = &xpc_disengage_min_timelimit,
-	 .extra2 = &xpc_disengage_max_timelimit},
-	{}
+	 .extra2 = &xpc_disengage_max_timelimit}
 };
 
 static struct ctl_table_header *xpc_sysctl;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index edd8f2ba5595..22dedd3671ec 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1964,8 +1964,7 @@ static const struct ctl_table vrf_table[] = {
 		.proc_handler	= vrf_shared_table_handler,
 		/* set by the vrf_netns_init */
 		.extra1		= NULL,
-	},
-	{ },
+	}
 };
 
 static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 16cee52f035f..f6e0121f8904 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -259,8 +259,12 @@ PARPORT_MAX_SPINTIME_VALUE;
 struct parport_sysctl_table {
 	struct ctl_table_header *port_header;
 	struct ctl_table_header *devices_header;
-	struct ctl_table vars[12];
-	struct ctl_table device_dir[2];
+#ifdef CONFIG_PARPORT_1284
+	struct ctl_table vars[10];
+#else
+	struct ctl_table vars[5];
+#endif /* IEEE 1284 support */
+	struct ctl_table device_dir[1];
 };
 
 static const struct parport_sysctl_table parport_sysctl_template = {
@@ -303,9 +307,9 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.maxlen		= 0,
 			.mode		= 0444,
 			.proc_handler	= do_hardware_modes
-		},
+		}
 #ifdef CONFIG_PARPORT_1284
-		{
+		, {
 			.procname	= "autoprobe",
 			.data		= NULL,
 			.maxlen		= 0,
@@ -339,9 +343,8 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.maxlen		= 0,
 			.mode		= 0444,
 			.proc_handler	= do_autoprobe
-		},
+		}
 #endif /* IEEE 1284 support */
-		{}
 	},
 	{
 		{
@@ -350,20 +353,15 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.maxlen		= 0,
 			.mode		= 0444,
 			.proc_handler	= do_active_device
-		},
-		{}
+		}
 	},
 };
 
 struct parport_device_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table vars[2];
-	struct ctl_table device_dir[2];
-	struct ctl_table devices_root_dir[2];
-	struct ctl_table port_dir[2];
-	struct ctl_table parport_dir[2];
-	struct ctl_table dev_dir[2];
+	struct ctl_table vars[1];
+	struct ctl_table device_dir[1];
 };
 
 static const struct parport_device_sysctl_table
@@ -378,8 +376,7 @@ parport_device_sysctl_template = {
 			.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
 			.extra1		= (void*) &parport_min_timeslice_value,
 			.extra2		= (void*) &parport_max_timeslice_value
-		},
-		{}
+		}
 	},
 	{
 		{
@@ -387,18 +384,14 @@ parport_device_sysctl_template = {
 			.data		= NULL,
 			.maxlen		= 0,
 			.mode		= 0555,
-		},
-		{}
+		}
 	}
 };
 
 struct parport_default_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table vars[3];
-	struct ctl_table default_dir[2];
-	struct ctl_table parport_dir[2];
-	struct ctl_table dev_dir[2];
+	struct ctl_table vars[2];
 };
 
 static struct parport_default_sysctl_table
@@ -422,8 +415,7 @@ parport_default_sysctl_table = {
 			.proc_handler	= proc_dointvec_minmax,
 			.extra1		= (void*) &parport_min_spintime_value,
 			.extra2		= (void*) &parport_max_spintime_value
-		},
-		{}
+		}
 	}
 };
 
@@ -443,7 +435,9 @@ int parport_proc_register(struct parport *port)
 	t->vars[0].data = &port->spintime;
 	for (i = 0; i < 5; i++) {
 		t->vars[i].extra1 = port;
+#ifdef CONFIG_PARPORT_1284
 		t->vars[5 + i].extra2 = &port->probe_info[i];
+#endif /* IEEE 1284 support */
 	}
 
 	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 763f9c8acfbf..85285c85bd49 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1179,8 +1179,7 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
 		.proc_handler	= armv8pmu_proc_user_access_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static void armv8_pmu_register_sysctl_table(void)
diff --git a/drivers/scsi/scsi_sysctl.c b/drivers/scsi/scsi_sysctl.c
index 0378bd63fea4..22c2d055821e 100644
--- a/drivers/scsi/scsi_sysctl.c
+++ b/drivers/scsi/scsi_sysctl.c
@@ -17,8 +17,7 @@ static struct ctl_table scsi_table[] = {
 	  .data		= &scsi_logging_level,
 	  .maxlen	= sizeof(scsi_logging_level),
 	  .mode		= 0644,
-	  .proc_handler	= proc_dointvec },
-	{ }
+	  .proc_handler	= proc_dointvec }
 };
 
 static struct ctl_table_header *scsi_table_header;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d12cdf875b50..102a3640c6c7 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1638,8 +1638,7 @@ static struct ctl_table sg_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 
 static struct ctl_table_header *hdr;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 63fb3c543b94..bd6b12394d76 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3608,8 +3608,7 @@ static struct ctl_table tty_table[] = {
 		.proc_handler	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 /*
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index e4544262a429..bef75c236104 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -93,8 +93,7 @@ static struct ctl_table balloon_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 #else
diff --git a/fs/aio.c b/fs/aio.c
index b09abe7a14d3..f2ed0a34a5d4 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -238,8 +238,7 @@ static struct ctl_table aio_sysctls[] = {
 		.maxlen		= sizeof(aio_max_nr),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{}
+	}
 };
 
 static void __init aio_sysctl_init(void)
diff --git a/fs/cachefiles/error_inject.c b/fs/cachefiles/error_inject.c
index ea6bcce4f6f1..4fa84880c0d1 100644
--- a/fs/cachefiles/error_inject.c
+++ b/fs/cachefiles/error_inject.c
@@ -18,8 +18,7 @@ static struct ctl_table cachefiles_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec,
-	},
-	{}
+	}
 };
 
 int __init cachefiles_register_error_injection(void)
diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 16224a7c6691..e377e400bfed 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -35,8 +35,7 @@ static struct ctl_table coda_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec
-	},
-	{}
+	}
 };
 
 void coda_sysctl_init(void)
diff --git a/fs/coredump.c b/fs/coredump.c
index 7e55428dce13..99142426a156 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -978,8 +978,7 @@ static struct ctl_table coredump_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_coredump_sysctls(void)
diff --git a/fs/dcache.c b/fs/dcache.c
index f02bfd383e66..257450fd8f01 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -190,8 +190,7 @@ static struct ctl_table fs_dcache_sysctls[] = {
 		.maxlen		= 6*sizeof(long),
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_dcache_sysctls(void)
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index c17f971a8c4b..8d56add71e71 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -68,8 +68,7 @@ static struct ctl_table pty_table[] = {
 		.mode		= 0444,
 		.data		= &pty_count,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 
 struct pts_mount_opts {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e1a0e6a6d3de..b0556c52685c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -321,8 +321,7 @@ static struct ctl_table epoll_table[] = {
 		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &long_zero,
 		.extra2		= &long_max,
-	},
-	{ }
+	}
 };
 
 static void __init epoll_sysctls_init(void)
diff --git a/fs/exec.c b/fs/exec.c
index 5572d148738b..9458ef2b8028 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2164,8 +2164,7 @@ static struct ctl_table fs_exec_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax_coredump,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_exec_sysctls(void)
diff --git a/fs/file_table.c b/fs/file_table.c
index 23a645521960..6fec4c691f0a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -114,8 +114,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &sysctl_nr_open_min,
 		.extra2		= &sysctl_nr_open_max,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_stat_sysctls(void)
diff --git a/fs/inode.c b/fs/inode.c
index 0a0ad1a2a5d2..79c5916cade7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -129,8 +129,7 @@ static struct ctl_table inodes_sysctls[] = {
 		.maxlen		= 7*sizeof(long),
 		.mode		= 0444,
 		.proc_handler	= proc_nr_inodes,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_inode_sysctls(void)
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 84736267f4e1..082fcf6340d4 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -506,8 +506,7 @@ static struct ctl_table nlm_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 #endif	/* CONFIG_SYSCTL */
diff --git a/fs/locks.c b/fs/locks.c
index ce5733480aa6..9750076cdd8d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -109,9 +109,8 @@ static struct ctl_table locks_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
+	}
 #endif /* CONFIG_MMU */
-	{}
 };
 
 static int __init init_fs_locks_sysctls(void)
diff --git a/fs/namei.c b/fs/namei.c
index 9b567af081af..b0f8d09c2111 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1067,8 +1067,7 @@ static struct ctl_table namei_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_namei_sysctls(void)
diff --git a/fs/namespace.c b/fs/namespace.c
index e7f251e40485..780e9292fa52 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4709,8 +4709,7 @@ static struct ctl_table fs_namespace_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_namespace_sysctls(void)
diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index 4a542ee11e68..5515c2e8afe7 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -33,8 +33,7 @@ static struct ctl_table nfs4_cb_sysctls[] = {
 		.maxlen = sizeof(int),
 		.mode = 0644,
 		.proc_handler = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 int nfs4_register_sysctl(void)
diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
index 9dafd44670e4..8a71d31e5dc3 100644
--- a/fs/nfs/sysctl.c
+++ b/fs/nfs/sysctl.c
@@ -28,8 +28,7 @@ static struct ctl_table nfs_cb_sysctls[] = {
 		.maxlen		= sizeof(nfs_congestion_kb),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 int nfs_register_sysctl(void)
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 2c6fe98d6fe1..409ca0a9a048 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -28,8 +28,7 @@ static struct ctl_table dnotify_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 static void __init dnotify_sysctl_init(void)
 {
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 78d3bf479f59..4c43eb38b9cf 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -85,8 +85,7 @@ static struct ctl_table fanotify_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO
-	},
-	{ }
+	}
 };
 
 static void __init fanotify_sysctls_init(void)
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 0ce25c4ddfec..02b74d8b4e28 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -84,8 +84,7 @@ static struct ctl_table inotify_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO
-	},
-	{ }
+	}
 };
 
 static void __init inotify_sysctls_init(void)
diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index 2c48f48a0b80..fef88fb6a40f 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -27,8 +27,7 @@ static struct ctl_table ntfs_sysctls[] = {
 		.maxlen		= sizeof(debug_msgs),
 		.mode		= 0644,			/* Mode, proc handler. */
 		.proc_handler	= proc_dointvec
-	},
-	{}
+	}
 };
 
 /* Storage for the sysctls header. */
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index 9a653875d1c5..7be619f93960 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -657,8 +657,7 @@ static struct ctl_table ocfs2_nm_table[] = {
 		.maxlen		= OCFS2_MAX_HB_CTL_PATH,
 		.mode		= 0644,
 		.proc_handler	= proc_dostring,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table_header *ocfs2_table_header;
diff --git a/fs/pipe.c b/fs/pipe.c
index 8a808fc25552..8fab91c2d546 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1491,8 +1491,7 @@ static struct ctl_table fs_pipe_sysctls[] = {
 		.maxlen		= sizeof(pipe_user_pages_soft),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{ }
+	}
 };
 #endif
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9670c5b7b5b2..1debd01209fc 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,8 +19,9 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
-#define list_for_each_table_entry(entry, header) \
-	for ((entry) = (header->ctl_table); (entry)->procname; (entry)++)
+#define list_for_each_table_entry(entry, header)	\
+	entry = header->ctl_table;			\
+	for (size_t i = 0 ; i < header->ctl_table_size ; ++i, entry++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
@@ -69,8 +70,7 @@ static struct ctl_table root_table[] = {
 	{
 		.procname = "",
 		.mode = S_IFDIR|S_IRUGO|S_IXUGO,
-	},
-	{ }
+	}
 };
 static struct ctl_table_root sysctl_table_root = {
 	.default_set.dir.header = {
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 7c07654e4253..1eb18c8bd639 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2941,9 +2941,8 @@ static struct ctl_table fs_dqstats_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
+	}
 #endif
-	{ },
 };
 
 static int __init dquot_init(void)
diff --git a/fs/sysctls.c b/fs/sysctls.c
index 944254dd92c0..d6ed656738ff 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -25,8 +25,7 @@ static struct ctl_table fs_shared_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_MAXOLDUID,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_sysctls(void)
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4c3858769226..165b9c52e626 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -44,8 +44,7 @@ static struct ctl_table vm_userfaultfd_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 #endif
 
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index f617c6a1f16c..05585e93f32b 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -97,8 +97,7 @@ static struct ctl_table fsverity_sysctl_table[] = {
 		.proc_handler   = proc_dointvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init fsverity_sysctl_init(void)
diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
index 61075e9c9e37..5c6337526070 100644
--- a/fs/xfs/xfs_sysctl.c
+++ b/fs/xfs/xfs_sysctl.c
@@ -204,10 +204,8 @@ static struct ctl_table xfs_table[] = {
 		.proc_handler	= xfs_stats_clear_proc_handler,
 		.extra1		= &xfs_params.stats_clear.min,
 		.extra2		= &xfs_params.stats_clear.max
-	},
+	}
 #endif /* CONFIG_PROC_FS */
-
-	{}
 };
 
 int
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 2b10abb8c80e..a894519efdd3 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -28,8 +28,7 @@ static struct ctl_table kern_do_mounts_initrd_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_do_mounts_initrd_sysctls_init(void)
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8c62e443f78b..a46d15f5b476 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -175,9 +175,8 @@ static struct ctl_table ipc_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
-	},
+	}
 #endif
-	{}
 };
 
 static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index ebb5ed81c151..8191d03b39cb 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -62,8 +62,7 @@ static struct ctl_table mq_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_maxsize_limit_min,
 		.extra2		= &msg_maxsize_limit_max,
-	},
-	{}
+	}
 };
 
 static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
diff --git a/kernel/acct.c b/kernel/acct.c
index 67125b7c5ca2..93417042762b 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -83,8 +83,7 @@ static struct ctl_table kern_acct_table[] = {
 		.maxlen         = 3*sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_acct_sysctls_init(void)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a81b5122b16b..980ad104fff8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5400,8 +5400,7 @@ static struct ctl_table bpf_syscall_table[] = {
 		.data		= &bpf_stats_enabled_key.key,
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
-	},
-	{ }
+	}
 };
 
 static int __init bpf_syscall_sysctl_init(void)
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 4ef14cb5b5a0..539cab051d17 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -73,8 +73,7 @@ static struct ctl_table kern_delayacct_table[] = {
 		.proc_handler   = sysctl_delayacct,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_delayacct_sysctls_init(void)
diff --git a/kernel/exit.c b/kernel/exit.c
index 633c7a52ef80..87cb53a33bbc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -89,8 +89,7 @@ static struct ctl_table kern_exit_table[] = {
 		.maxlen         = sizeof(oops_limit),
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_exit_sysctls_init(void)
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 816f133266c4..8d0659453421 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -312,8 +312,7 @@ static struct ctl_table hung_task_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_NEG_ONE,
-	},
-	{}
+	}
 };
 
 static void __init hung_task_sysctl_init(void)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 63b04e710890..160779e0a503 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1001,8 +1001,7 @@ static struct ctl_table kexec_core_sysctls[] = {
 		.data		= &load_limit_reboot,
 		.mode		= 0644,
 		.proc_handler	= kexec_limit_handler,
-	},
-	{ }
+	}
 };
 
 static int __init kexec_core_sysctl_init(void)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 06a3ac7993f0..ae6b0f78ae6c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -967,8 +967,7 @@ static struct ctl_table kprobe_sysctls[] = {
 		.proc_handler	= proc_kprobes_optimization_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static void __init kprobe_sysctls_init(void)
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 55050ae0e197..bb4dd0691b3c 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -84,8 +84,7 @@ static struct ctl_table latencytop_sysctl[] = {
 		.maxlen     = sizeof(int),
 		.mode       = 0644,
 		.proc_handler   = sysctl_latencytop,
-	},
-	{}
+	}
 };
 #endif
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1e29cec7e00c..0db8af590f87 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -95,9 +95,8 @@ static struct ctl_table kern_lockdep_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
+	}
 #endif /* CONFIG_LOCK_STAT */
-	{ }
 };
 
 static __init int kernel_lockdep_sysctls_init(void)
diff --git a/kernel/panic.c b/kernel/panic.c
index 0008273d23fd..79786433efda 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -98,8 +98,7 @@ static struct ctl_table kern_panic_table[] = {
 		.maxlen         = sizeof(warn_limit),
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_panic_sysctls_init(void)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7fd5e8adc2e8..dc7adbd2f412 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -311,8 +311,7 @@ static struct ctl_table pid_ns_ctl_table[] = {
 		.proc_handler = pid_ns_ctl_handler,
 		.extra1 = SYSCTL_ZERO,
 		.extra2 = &pid_max,
-	},
-	{ }
+	}
 };
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
 
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index 8b24744752cb..b9528766d2d8 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -43,8 +43,7 @@ static struct ctl_table pid_ns_ctl_table_vm[] = {
 		.proc_handler	= pid_mfd_noexec_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
-	},
-	{ }
+	}
 };
 static inline void register_pid_ns_sysctl_table_vm(void)
 {
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index 28f37b86414e..d608832b4489 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -75,8 +75,7 @@ static struct ctl_table printk_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
-	},
-	{}
+	}
 };
 
 void __init printk_sysctl_init(void)
diff --git a/kernel/reboot.c b/kernel/reboot.c
index cf81d8bfb523..e29d415810c1 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1271,8 +1271,7 @@ static struct ctl_table kern_reboot_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static void __init kernel_reboot_sysctls_init(void)
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2b9ce82279a5..4c558f0de4f7 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -18,8 +18,7 @@ static struct ctl_table sched_autogroup_sysctls[] = {
 		.proc_handler   = proc_dointvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static void __init sched_autogroup_sysctl_init(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8c7e01dd78a..f11ac1d3e315 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4671,9 +4671,8 @@ static struct ctl_table sched_core_sysctls[] = {
 		.proc_handler	= sysctl_numa_balancing,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_FOUR,
-	},
+	}
 #endif /* CONFIG_NUMA_BALANCING */
-	{}
 };
 static int __init sched_core_sysctl_init(void)
 {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2aacf5ea2ff3..a6cbdf588590 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -40,8 +40,7 @@ static struct ctl_table sched_dl_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec_minmax,
 		.extra2         = (void *)&sysctl_sched_dl_period_max,
-	},
-	{}
+	}
 };
 
 static int __init sched_dl_sysctl_init(void)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index db09e56c2dd3..876f110e696d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -210,9 +210,8 @@ static struct ctl_table sched_fair_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-	},
+	}
 #endif /* CONFIG_NUMA_BALANCING */
-	{}
 };
 
 static int __init sched_fair_sysctl_init(void)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index aab9b900ed6f..2e2d49467dd9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -51,8 +51,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rr_handler,
-	},
-	{}
+	}
 };
 
 static int __init sched_rt_sysctl_init(void)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 46d7c3f3e830..cd3fffecbce3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -249,8 +249,7 @@ static struct ctl_table sched_energy_aware_sysctls[] = {
 		.proc_handler   = sched_energy_aware_handler,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static int __init sched_energy_aware_sysctl_init(void)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 9683a9a4709d..1693f0935904 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2380,8 +2380,7 @@ static struct ctl_table seccomp_sysctl_table[] = {
 		.procname	= "actions_logged",
 		.mode		= 0644,
 		.proc_handler	= seccomp_actions_logged_handler,
-	},
-	{ }
+	}
 };
 
 static int __init seccomp_sysctl_init(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index 19791930f12a..4a87ba91491f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4781,9 +4781,8 @@ static struct ctl_table signal_debug_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
-	},
+	}
 #endif
-	{ }
 };
 
 static int __init init_signal_sysctls(void)
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 123844341148..6a9a65ace05a 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -53,8 +53,7 @@ static struct ctl_table stackleak_sysctls[] = {
 		.proc_handler	= stack_erasing_sysctl,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static int __init stackleak_sysctls_init(void)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2b9b0c8569ba..f1865c593666 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2041,9 +2041,8 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_INT_MAX,
-	},
+	}
 #endif
-	{ }
 };
 
 static struct ctl_table vm_table[] = {
@@ -2314,9 +2313,8 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= (void *)&mmap_rnd_compat_bits_min,
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
-	},
+	}
 #endif
-	{ }
 };
 
 int __init sysctl_init_bases(void)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index de385b365a7a..b7594ac53c99 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -259,8 +259,7 @@ static struct ctl_table timer_sysctl[] = {
 		.proc_handler	= timer_migration_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static int __init timer_sysctl_init(void)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 84ef42111f78..7a5a607b6cc2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8213,8 +8213,7 @@ static struct ctl_table ftrace_sysctls[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = ftrace_enable_sysctl,
-	},
-	{}
+	}
 };
 
 static int __init ftrace_sysctl_init(void)
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ac019cb21b18..baf48c16d2c5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2530,8 +2530,7 @@ static struct ctl_table user_event_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= set_max_user_events_sysctl,
-	},
-	{}
+	}
 };
 
 static int __init trace_events_user_init(void)
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 59bf6983f1cf..ce7ab90f7953 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -85,10 +85,9 @@ static struct ctl_table user_table[] = {
 #endif
 #ifdef CONFIG_FANOTIFY
 	UCOUNT_ENTRY("max_fanotify_groups"),
-	UCOUNT_ENTRY("max_fanotify_marks"),
+	UCOUNT_ENTRY("max_fanotify_marks")
 #endif
-	{ }
-};
+	};
 #endif /* CONFIG_SYSCTL */
 
 bool setup_userns_sysctls(struct user_namespace *ns)
@@ -96,7 +95,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 #ifdef CONFIG_SYSCTL
 	struct ctl_table *tbl;
 
-	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
+	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS);
 	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
 	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
 	if (tbl) {
diff --git a/kernel/umh.c b/kernel/umh.c
index 187a30ff8541..e1304be4823a 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -559,8 +559,7 @@ static struct ctl_table usermodehelper_table[] = {
 		.maxlen		= 2 * sizeof(unsigned long),
 		.mode		= 0600,
 		.proc_handler	= proc_cap_handler,
-	},
-	{ }
+	}
 };
 
 static int __init init_umh_sysctls(void)
diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 24527b155538..8776d45daf3a 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -119,8 +119,7 @@ static struct ctl_table uts_kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_uts_string,
 		.poll		= &domainname_poll,
-	},
-	{}
+	}
 };
 
 #ifdef CONFIG_PROC_SYSCTL
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index dd5a343fadde..b79e6cfc008c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -839,10 +839,9 @@ static struct ctl_table watchdog_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
+	}
 #endif /* CONFIG_SMP */
 #endif
-	{}
 };
 
 static void __init watchdog_sysctl_init(void)
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 83d37a163836..5a9018787d71 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -129,8 +129,7 @@ static struct ctl_table test_table[] = {
 		.maxlen		= SYSCTL_TEST_BITMAP_SIZE,
 		.mode		= 0644,
 		.proc_handler	= proc_do_large_bitmap,
-	},
-	{ }
+	}
 };
 
 static void test_sysctl_calc_match_int_ok(void)
@@ -184,8 +183,7 @@ static struct ctl_table test_table_unregister[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-	},
-	{}
+	}
 };
 
 static int test_sysctl_run_unregister_nested(void)
diff --git a/mm/compaction.c b/mm/compaction.c
index ca09cdd72bf3..5013f5b7b44b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3126,8 +3126,7 @@ static struct ctl_table vm_compaction[] = {
 		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init kcompactd_init(void)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7838b0c0b82b..5236805aee57 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4675,8 +4675,7 @@ static struct ctl_table hugetlb_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= hugetlb_overcommit_handler,
-	},
-	{ }
+	}
 };
 
 static void hugetlb_sysctl_init(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 65885a06269b..b1a2a1089aa3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -584,8 +584,7 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 		.maxlen		= sizeof(vmemmap_optimize_enabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dobool,
-	},
-	{ }
+	}
 };
 
 static int __init hugetlb_vmemmap_init(void)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 46aef76d8e91..9bf5dd7a394e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -142,8 +142,7 @@ static struct ctl_table memory_failure_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init memory_failure_sysctl_init(void)
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 500cf2ef9faa..a05416f798e7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -725,8 +725,7 @@ static struct ctl_table vm_oom_kill_table[] = {
 		.maxlen		= sizeof(sysctl_oom_dump_tasks),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 #endif
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9f997de8d12f..b75aaae6f77b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2290,8 +2290,7 @@ static struct ctl_table vm_page_writeback_sysctls[] = {
 		.maxlen		= sizeof(laptop_mode),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{}
+	}
 };
 #endif
 
diff --git a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
index 30dcbbb8aeff..3975c1fad48c 100644
--- a/net/appletalk/sysctl_net_atalk.c
+++ b/net/appletalk/sysctl_net_atalk.c
@@ -39,8 +39,7 @@ static struct ctl_table atalk_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ },
+	}
 };
 
 static struct ctl_table_header *atalk_table_header;
diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index 06afbc14b783..e7e81787e5de 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -139,10 +139,9 @@ static const struct ctl_table ax25_param_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_ds_timeout,
 		.extra2		= &max_ds_timeout
-	},
+	}
 #endif
-
-	{ }	/* that's all, folks! */
+/* that's all, folks! */
 };
 
 int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index ebbaef748a48..dfc37ac00980 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1100,8 +1100,7 @@ static struct ctl_table brnf_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
-	},
-	{ }
+	}
 };
 
 static inline void br_netfilter_sysctl_default(struct brnf_net *brnf)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index aa5ad1cfc9b1..096d86013300 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3716,7 +3716,7 @@ static int neigh_proc_base_reachable_time(struct ctl_table *ctl, int write,
 
 static struct neigh_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table neigh_vars[NEIGH_VAR_MAX + 1];
+	struct ctl_table neigh_vars[NEIGH_VAR_MAX];
 } neigh_sysctl_template __read_mostly = {
 	.neigh_vars = {
 		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_PROBES, "mcast_solicit"),
@@ -3766,9 +3766,8 @@ static struct neigh_sysctl_table {
 			.extra1		= SYSCTL_ZERO,
 			.extra2		= SYSCTL_INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
-		},
-		{},
-	},
+		}
+	}
 };
 
 int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
@@ -3779,6 +3778,7 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 	const char *dev_name_source;
 	char neigh_path[ sizeof("net//neigh/") + IFNAMSIZ + IFNAMSIZ ];
 	char *p_name;
+	size_t neigh_vars_size;
 
 	t = kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCOUNT);
 	if (!t)
@@ -3790,11 +3790,11 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 		t->neigh_vars[i].extra2 = p;
 	}
 
+	neigh_vars_size = ARRAY_SIZE(t->neigh_vars);
 	if (dev) {
 		dev_name_source = dev->name;
 		/* Terminate the table early */
-		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
-		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
+		neigh_vars_size = NEIGH_VAR_BASE_REACHABLE_TIME_MS;
 	} else {
 		struct neigh_table *tbl = p->tbl;
 		dev_name_source = "default";
@@ -3843,7 +3843,7 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 		p_name, dev_name_source);
 	t->sysctl_header =
 		register_net_sysctl(neigh_parms_net(p), neigh_path, t->neigh_vars,
-				    ARRAY_SIZE(t->neigh_vars));
+				    neigh_vars_size);
 	if (!t->sysctl_header)
 		goto free;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index aa615f22507b..9acde2a110cd 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -652,8 +652,7 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table netns_core_table[] = {
@@ -681,8 +680,7 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{ }
+	}
 };
 
 static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index 1140748858b0..7a5ccae4fc10 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -89,9 +89,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_sync_ratelimit),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-
-	{ }
+	}
 };
 
 static struct ctl_table_header *dccp_table_header;
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 7b717434368c..3d9f2fbb8ec0 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -337,8 +337,7 @@ static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ }
+	}
 };
 
 /* secret interval has been deprecated */
@@ -350,8 +349,7 @@ static struct ctl_table lowpan_frags_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ }
+	}
 };
 
 static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 6360425dfcb2..eeb229b1ab78 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2516,7 +2516,7 @@ static int ipv4_doint_and_flush(struct ctl_table *ctl, int write,
 
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table devinet_vars[__IPV4_DEVCONF_MAX];
+	struct ctl_table devinet_vars[IPV4_DEVCONF_MAX];
 } devinet_sysctl = {
 	.devinet_vars = {
 		DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "forwarding",
@@ -2653,8 +2653,7 @@ static struct ctl_table ctl_forward_entry[] = {
 		.proc_handler	= devinet_sysctl_forward,
 		.extra1		= &ipv4_devconf,
 		.extra2		= &init_net,
-	},
-	{ },
+	}
 };
 #endif
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 3d7a82a900b5..2f8a8ac058da 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -579,8 +579,7 @@ static struct ctl_table ip4_frags_ns_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &dist_min,
-	},
-	{ }
+	}
 };
 
 /* secret interval has been deprecated */
@@ -592,8 +591,7 @@ static struct ctl_table ip4_frags_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ }
+	}
 };
 
 static int __net_init ip4_frags_ns_ctl_register(struct net *net)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 883f4f1ee056..de0c0f9078b5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3551,8 +3551,7 @@ static struct ctl_table ipv4_route_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static const char ipv4_route_flush_procname[] = "flush";
@@ -3585,8 +3584,7 @@ static struct ctl_table ipv4_route_netns_table[] = {
 		.maxlen     = sizeof(int),
 		.mode       = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ },
+	}
 };
 
 static __net_init int sysctl_route_net_init(struct net *net)
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1821f403efc0..31306925a35d 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -577,8 +577,7 @@ static struct ctl_table ipv4_table[] = {
 		.proc_handler	= proc_douintvec_minmax,
 		.extra1		= &sysctl_fib_sync_mem_min,
 		.extra2		= &sysctl_fib_sync_mem_max,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table ipv4_net_table[] = {
@@ -1469,8 +1468,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler   = proc_dointvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = &tcp_plb_max_cong_thresh,
-	},
-	{ }
+	}
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index ec1d68dbffc3..40610bb3a75a 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -160,8 +160,7 @@ static struct ctl_table xfrm4_policy_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static __net_init int xfrm4_net_sysctl_init(struct net *net)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 68a2925c66a5..c72887ad79a3 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7055,9 +7055,6 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
-	},
-	{
-		/* sentinel */
 	}
 };
 
@@ -7072,7 +7069,7 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 	if (!table)
 		goto out;
 
-	for (i = 0; table[i].data; i++) {
+	for (i = 0; i < ARRAY_SIZE(addrconf_sysctl); i++) {
 		table[i].data += (char *)p - (char *)&ipv6_devconf;
 		/* If one of these is already set, then it is not safe to
 		 * overwrite either of them: this makes proc_dointvec_minmax
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 4159662fa214..b57e2c447969 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1204,8 +1204,7 @@ static struct ctl_table ipv6_icmp_table_template[] = {
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ },
+	}
 };
 
 struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index dca8e0aabc51..18106042a3ed 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -61,8 +61,7 @@ static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{ }
+	}
 };
 
 static int nf_ct_frag6_sysctl_register(struct net *net)
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 0688261202de..b7d7dd6e1f75 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -435,8 +435,7 @@ static struct ctl_table ip6_frags_ns_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ }
+	}
 };
 
 /* secret interval has been deprecated */
@@ -448,8 +447,7 @@ static struct ctl_table ip6_frags_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ }
+	}
 };
 
 static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a35470576077..0b2a3afe620e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6417,8 +6417,7 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.proc_handler	=	proc_dointvec_minmax,
 		.extra1		=	SYSCTL_ZERO,
 		.extra2		=	SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 29f121f513a6..0d45a8a32752 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -212,8 +212,7 @@ static struct ctl_table ipv6_table_template[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 		.extra2		= &ioam6_id_wide_max,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table ipv6_rotable[] = {
@@ -246,9 +245,8 @@ static struct ctl_table ipv6_rotable[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
+	}
 #endif /* CONFIG_NETLABEL */
-	{ }
 };
 
 static int __net_init ipv6_sysctl_net_init(struct net *net)
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 27efdb18a018..f3559ff33ff4 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -187,8 +187,7 @@ static struct ctl_table xfrm6_policy_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static int __net_init xfrm6_net_sysctl_init(struct net *net)
diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
index 195296ba29f0..520fc52059b1 100644
--- a/net/llc/sysctl_net_llc.c
+++ b/net/llc/sysctl_net_llc.c
@@ -43,12 +43,10 @@ static struct ctl_table llc2_timeout_table[] = {
 		.maxlen		= sizeof(sysctl_llc2_rej_timeout),
 		.mode		= 0644,
 		.proc_handler   = proc_dointvec_jiffies,
-	},
-	{ },
+	}
 };
 
 static struct ctl_table llc_station_table[] = {
-	{ },
 };
 
 static struct ctl_table_header *llc2_timeout_header;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 6f96aae76537..a78daceddf74 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1391,8 +1391,7 @@ static const struct ctl_table mpls_dev_table[] = {
 		.mode		= 0644,
 		.proc_handler	= mpls_conf_proc,
 		.data		= MPLS_PERDEV_SYSCTL_OFFSET(input_enabled),
-	},
-	{ }
+	}
 };
 
 static int mpls_platform_labels(struct ctl_table *table, int write,
@@ -1425,8 +1424,7 @@ static const struct ctl_table mpls_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &ttl_max,
-	},
-	{ }
+	}
 };
 
 static int mpls_dev_sysctl_register(struct net_device *dev,
@@ -1444,7 +1442,7 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 	/* Table data contains only offsets relative to the base of
 	 * the mdev at this point, so make them absolute.
 	 */
-	for (i = 0; i < ARRAY_SIZE(mpls_dev_table) - 1; i++) {
+	for (i = 0; i < ARRAY_SIZE(mpls_dev_table); i++) {
 		table[i].data = (char *)mdev + (uintptr_t)table[i].data;
 		table[i].extra1 = mdev;
 		table[i].extra2 = net;
@@ -2689,7 +2687,7 @@ static int mpls_net_init(struct net *net)
 	/* Table data contains only offsets relative to the base of
 	 * the mdev at this point, so make them absolute.
 	 */
-	for (i = 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
+	for (i = 0; i < ARRAY_SIZE(mpls_table); i++)
 		table[i].data = (char *)net + (uintptr_t)table[i].data;
 
 	net->mpls.ctl = register_net_sysctl(net, "net/mpls", table,
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 42dfc834e5c6..27fb556d2273 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -127,8 +127,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.proc_handler = proc_dou8vec_minmax,
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = &mptcp_pm_type_max
-	},
-	{}
+	}
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index abbd30ee3ce0..fef7104ac33e 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2258,9 +2258,8 @@ static struct ctl_table vs_vars[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
+	}
 #endif
-	{ }
 };
 
 #endif
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 254eb3b61e15..e6297bb6922b 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -122,8 +122,7 @@ static struct ctl_table vs_vars_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ }
+	}
 };
 #endif
 
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index 0e39a4fd421f..f3056767818b 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -293,8 +293,7 @@ static struct ctl_table vs_vars_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ }
+	}
 };
 #endif
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index a3b2029ef098..26efc6f28b34 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -616,11 +616,9 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_LWTUNNEL,
 #endif
 
-	__NF_SYSCTL_CT_LAST_SYSCTL,
+	NF_SYSCTL_CT_LAST_SYSCTL,
 };
 
-#define NF_SYSCTL_CT_LAST_SYSCTL (__NF_SYSCTL_CT_LAST_SYSCTL + 1)
-
 static struct ctl_table nf_ct_sysctl_table[] = {
 	[NF_SYSCTL_CT_MAX] = {
 		.procname	= "nf_conntrack_max",
@@ -955,9 +953,8 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= nf_hooks_lwtunnel_sysctl_handler,
-	},
+	}
 #endif
-	{}
 };
 
 static struct ctl_table nf_ct_netfilter_table[] = {
@@ -967,8 +964,7 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static void nf_conntrack_standalone_init_tcp_sysctl(struct net *net,
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 755f9cf570ce..686040b5e431 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -389,7 +389,7 @@ static const struct seq_operations nflog_seq_ops = {
 
 #ifdef CONFIG_SYSCTL
 static char nf_log_sysctl_fnames[NFPROTO_NUMPROTO-NFPROTO_UNSPEC][3];
-static struct ctl_table nf_log_sysctl_table[NFPROTO_NUMPROTO+1];
+static struct ctl_table nf_log_sysctl_table[NFPROTO_NUMPROTO];
 static struct ctl_table_header *nf_log_sysctl_fhdr;
 
 static struct ctl_table nf_log_sysctl_ftable[] = {
@@ -399,8 +399,7 @@ static struct ctl_table nf_log_sysctl_ftable[] = {
 		.maxlen		= sizeof(sysctl_nf_log_all_netns),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static int nf_log_proc_dostring(struct ctl_table *table, int write,
diff --git a/net/netrom/sysctl_net_netrom.c b/net/netrom/sysctl_net_netrom.c
index c02b93fd9d4f..133dccdc2201 100644
--- a/net/netrom/sysctl_net_netrom.c
+++ b/net/netrom/sysctl_net_netrom.c
@@ -139,8 +139,7 @@ static struct ctl_table nr_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_reset,
 		.extra2		= &max_reset
-	},
-	{ }
+	}
 };
 
 int __init nr_register_sysctl(void)
diff --git a/net/phonet/sysctl.c b/net/phonet/sysctl.c
index 0fd0fcb00505..5385e980693e 100644
--- a/net/phonet/sysctl.c
+++ b/net/phonet/sysctl.c
@@ -80,8 +80,7 @@ static struct ctl_table phonet_table[] = {
 		.maxlen		= sizeof(local_port_range),
 		.mode		= 0644,
 		.proc_handler	= proc_local_port_range,
-	},
-	{ }
+	}
 };
 
 int __init phonet_sysctl_init(void)
diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index 102fd4a18df7..ee9ec39d9b30 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -102,8 +102,7 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.maxlen		= sizeof(rds_ib_sysctl_flow_control),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 void rds_ib_sysctl_exit(void)
diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index 5abd2730a1bc..17b325585bd9 100644
--- a/net/rds/sysctl.c
+++ b/net/rds/sysctl.c
@@ -88,8 +88,7 @@ static struct ctl_table rds_sysctl_rds_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 void rds_sysctl_exit(void)
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 2e90a2570d3b..e4abe20c4d2d 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -85,8 +85,7 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		.mode           = 0644,
 		.proc_handler   = rds_tcp_skbuf_handler,
 		.extra1		= &rds_tcp_min_rcvbuf,
-	},
-	{ }
+	}
 };
 
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc)
diff --git a/net/rose/sysctl_net_rose.c b/net/rose/sysctl_net_rose.c
index 4f5a1e8b6c54..1a244a4d0221 100644
--- a/net/rose/sysctl_net_rose.c
+++ b/net/rose/sysctl_net_rose.c
@@ -111,8 +111,7 @@ static struct ctl_table rose_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_window,
 		.extra2		= &max_window
-	},
-	{ }
+	}
 };
 
 void __init rose_register_sysctl(void)
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index 2b5824416036..583306fad3ef 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -124,8 +124,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= (void *)SYSCTL_ONE,
 		.extra2		= (void *)&four,
-	},
-	{ }
+	}
 };
 
 int __init rxrpc_sysctl_init(void)
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 233f37f0fa28..93ea4decbb1b 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -79,9 +79,7 @@ static struct ctl_table sctp_table[] = {
 		.maxlen		= sizeof(sysctl_sctp_wmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-
-	{ /* sentinel */ }
+	}
 };
 
 /* The following index defines are used in sctp_sysctl_net_register().
@@ -383,9 +381,7 @@ static struct ctl_table sctp_net_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &pf_expose_max,
-	},
-
-	{ /* sentinel */ }
+	}
 };
 
 static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
@@ -604,7 +600,7 @@ int sctp_sysctl_net_register(struct net *net)
 	if (!table)
 		return -ENOMEM;
 
-	for (i = 0; table[i].data; i++)
+	for (i = 0; i < ARRAY_SIZE(sctp_net_table); i++)
 		table[i].data += (char *)(&net->sctp) - (char *)&init_net.sctp;
 
 	table[SCTP_RTO_MIN_IDX].extra2 = &net->sctp.rto_max;
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 9404123883c0..89af1f1dbb58 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -61,8 +61,7 @@ static struct ctl_table smc_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_rcvbuf,
-	},
-	{  }
+	}
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 61222addda7e..f4ac3376c25b 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -159,8 +159,7 @@ static struct ctl_table debug_table[] = {
 		.maxlen		= 256,
 		.mode		= 0444,
 		.proc_handler	= proc_do_xprt,
-	},
-	{ }
+	}
 };
 
 void
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index df7fb9c8b785..cbc75193bc70 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -208,8 +208,7 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &zero,
-	},
-	{ },
+	}
 };
 
 static void svc_rdma_proc_cleanup(void)
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index bf43e05044a3..75c789712cd9 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -136,8 +136,7 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ },
+	}
 };
 
 #endif
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7c3d5ed708be..c0c59cd3b31c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -154,8 +154,7 @@ static struct ctl_table xs_tunables_table[] = {
 		.maxlen		= sizeof(xs_tcp_fin_timeout),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{ },
+	}
 };
 
 /*
diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
index b9cbc3b359aa..e492d8c6c6f3 100644
--- a/net/tipc/sysctl.c
+++ b/net/tipc/sysctl.c
@@ -90,8 +90,7 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_bc_retruni),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{}
+	}
 };
 
 int tipc_register_sysctl(void)
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 92f3bc3cd704..716dee11d9e3 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -18,8 +18,7 @@ static struct ctl_table unix_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
-	},
-	{ }
+	}
 };
 
 int __net_init unix_sysctl_register(struct net *net)
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index 4d7c2ee41943..1e76f96ba77f 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -70,8 +70,7 @@ static struct ctl_table x25_table[] = {
 		.maxlen = 	sizeof(int),
 		.mode = 	0644,
 		.proc_handler = proc_dointvec,
-	},
-	{ },
+	}
 };
 
 int __init x25_register_sysctl(void)
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index d04b25a47575..e2b2c3437fbc 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -37,8 +37,7 @@ static struct ctl_table xfrm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
-	},
-	{}
+	}
 };
 
 int __net_init xfrm_sysctl_init(struct net *net)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b77344506cf3..67aa6e236e66 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1778,9 +1778,7 @@ static struct ctl_table apparmor_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0600,
 		.proc_handler   = apparmor_dointvec,
-	},
-
-	{ }
+	}
 };
 
 static int __init apparmor_init_sysctl(void)
diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index fa305f74f658..7c944ef5a58c 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -54,9 +54,9 @@ struct ctl_table key_sysctls[] = {
 		.proc_handler = proc_dointvec_minmax,
 		.extra1 = (void *) SYSCTL_ZERO,
 		.extra2 = (void *) SYSCTL_INT_MAX,
-	},
+	}
 #ifdef CONFIG_PERSISTENT_KEYRINGS
-	{
+	, {
 		.procname = "persistent_keyring_expiry",
 		.data = &persistent_keyring_expiry,
 		.maxlen = sizeof(unsigned),
@@ -64,9 +64,8 @@ struct ctl_table key_sysctls[] = {
 		.proc_handler = proc_dointvec_minmax,
 		.extra1 = (void *) SYSCTL_ZERO,
 		.extra2 = (void *) SYSCTL_INT_MAX,
-	},
+	}
 #endif
-	{ }
 };
 
 static int __init init_security_keys_sysctls(void)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 6f2cc827df41..28b411adbf0b 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -61,8 +61,7 @@ static struct ctl_table loadpin_sysctl_table[] = {
 		.proc_handler   = proc_dointvec_minmax,
 		.extra1         = SYSCTL_ONE,
 		.extra2         = SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static void set_sysctl(bool is_writable)
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 7b8164a4b504..2d2700af9f6b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -456,8 +456,7 @@ static struct ctl_table yama_sysctl_table[] = {
 		.proc_handler   = yama_dointvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = &max_scope,
-	},
-	{ }
+	}
 };
 static void __init yama_init_sysctl(void)
 {
-- 
2.30.2

