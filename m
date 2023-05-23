Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95070DC6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjEWMWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjEWMWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763BEDD
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122225euoutp01a17c9db1f7f527d37f394e67046efe9a~hxS-hGfzp1388413884euoutp01k
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230523122225euoutp01a17c9db1f7f527d37f394e67046efe9a~hxS-hGfzp1388413884euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844545;
        bh=KKnox84nz8ObagGJPU3G322Rrgqy3RZM5XV3FY0Rc18=;
        h=From:To:CC:Subject:Date:References:From;
        b=qMTW5bVElvt5z+/ccYJGUUsueSMv01/dhg4Z0/vDErExxwlcW41hR9VQkcXDyP0xv
         I1lTg02b/t63Z6hZ5jNtjjdXLMQssNFsuPXmot+v674NtqV16id/p+nau4OCSIjp2S
         tvE4PxoXq6u/TSUwKjJjyojKrFZDSrBDOBhs5bnY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122224eucas1p1529a287e2c7858ac18f2c3829037fb4a~hxS-Rkmke1811518115eucas1p1k;
        Tue, 23 May 2023 12:22:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.B8.42423.000BC646; Tue, 23
        May 2023 13:22:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122224eucas1p1834662efdd6d8e6f03db5c52b6e0a7ea~hxS_1iiMX2655526555eucas1p11;
        Tue, 23 May 2023 12:22:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122224eusmtrp2c2e5aa8ca093710a85929e4b2f411125~hxS_0-V7w0635006350eusmtrp2U;
        Tue, 23 May 2023 12:22:24 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-d7-646cb0002714
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.BF.10549.000BC646; Tue, 23
        May 2023 13:22:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122224eusmtip25a5de66ce416436d30c4481fc39b77cd~hxS_pbyzI2761627616eusmtip28;
        Tue, 23 May 2023 12:22:24 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:23 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 0/8] sysctl: Completely remove register_sysctl_table from
 sources
Date:   Tue, 23 May 2023 14:22:12 +0200
Message-ID: <20230523122220.1610825-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7oMG3JSDFa90rJ4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxtpvbcwFs8QqVn4/wdjAOFGoi5GTQ0LAROLK1a+M
        XYxcHEICKxglfiy5xwiSEBL4wijx5TwbhP2ZUeLOISeYhpsXTrJBNCxnlHi4t5kZwgEqerrw
        IBOEs4VRYua2RewgLWwCOhLn39xhBrFFBMQlTpzeDLaPWWAnk0R/5y2wHcICYRILNlwD280i
        oCpxYfdPJhCbV8BW4nDDBiaI3fISbdenM0LEBSVOznzCAmIzA8Wbt85mhrAlJA6+eMEMUa8k
        sbrrDxuEXStxasstsOskBO5wSKxZOJMdIuEicbO/FapBWOLV8S1QcRmJ/zvnQzVMZpTY/+8D
        O4SzmlFiWeNXqJOsJVquPIHqcJSY2joVaBIHkM0nceOtIMRFfBKTtk2HCvNKdLRBQ15NYvW9
        NywTGJVnIflnFpJ/ZiH5ZwEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzABHT63/FP
        Oxjnvvqod4iRiYPxEKMEB7OSCO+J8uwUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzatieThQTS
        E0tSs1NTC1KLYLJMHJxSDUzye50PuVfYSEmpzLe7pF145GP/WbNFxR9tpC/nyD2VkDBdopB2
        sXZre2qJkMyJH0u6l3ytNtLQmvT9vuIs0/kPZ29eJZgm3Vjv8KNFVidE/+qtN89cjGYdKA3f
        68vx8GeG6ZzLrj8cVSM+3BBUlTm8bKG/yLJe2U3nQhTYXC9aGZ+7utr1y619E3jPGEZ7rIzz
        /2Gx67zGstvHPtb2aZgaPDjl4/os+6lGR47MP3Fv7wdR+1OlNLJlHB9//y9xOTB7wXzfMyz8
        Xr+//V9pbheZ42kc0ife7zbB6P0KvZzCwE+Hr82+denLyXklD8WlZ+UoS09QFCpk35HEP+vO
        cyWem7NSJj0QMdwaJemjulaJpTgj0VCLuag4EQAbZ0l6rwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7oMG3JSDNrn8lq8PvyJ0eJMd67F
        nr0nWSwu75rDZnFjwlNGiwOnpzBbnP97nNVi2U4/Bw6P2Q0XWTx2zrrL7rFgU6nHplWdbB6f
        N8l5bHrylimALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7Ms
        tUjfLkEvY+23NuaCWWIVK7+fYGxgnCjUxcjJISFgInHzwkk2EFtIYCmjxOfDUhBxGYmNX66y
        QtjCEn+udQHVcAHVfGSUOPJ2HyNEwxZGifurfUBsNgEdifNv7jCD2CIC4hInTm9mBGlgFtjO
        JDHh7y6wDcICIRJ3Fq8BK2IRUJW4sPsnE4jNK2ArcbhhAxPENnmJtuvTGSHighInZz5hAbGZ
        geLNW2czQ9gSEgdfvGCGqFeSWN31hw3CrpX4/PcZ4wRGoVlI2mchaZ+FpH0BI/MqRpHU0uLc
        9NxiQ73ixNzi0rx0veT83E2MwFjbduzn5h2M81591DvEyMTBeIhRgoNZSYT3RHl2ihBvSmJl
        VWpRfnxRaU5q8SFGU6B/JjJLiSbnA6M9ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7
        NbUgtQimj4mDU6qBKbNaVtBq03udvk3f2GwcvQs4NtwrP/ni21Z/7bZd8v99TzxUid8e9bDc
        38ApyHZaK1+c4Ab7M4/jph5rq+5cM903YMldxnm8Uhf/M86M3HSoNK5kR9PJ9kuBrw5fcLvU
        E/BhxiHbb2f6tY9O+x80/5Pubq5HHGpPCy9Pc9jU/N9v5tVnVVXCHhterDQvNnOwi8+UvSal
        9unfzVsdPPYu6zfNr/JddXCuu2BYcdZtDYPrDmasny5PybAPWSw4L26K2aXwxKcFSp3vtv58
        eOfAIZWXChOCNmyYsD1r84Tg+szH1xTnTrMscFeys9D0VFoj9nK6SKcm/6texyWKM5b8F0rp
        OTCZQbL1lkrnyf5oJiWW4oxEQy3mouJEAN2B6so+AwAA
X-CMS-MailID: 20230523122224eucas1p1834662efdd6d8e6f03db5c52b6e0a7ea
X-Msg-Generator: CA
X-RootMTR: 20230523122224eucas1p1834662efdd6d8e6f03db5c52b6e0a7ea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122224eucas1p1834662efdd6d8e6f03db5c52b6e0a7ea
References: <CGME20230523122224eucas1p1834662efdd6d8e6f03db5c52b6e0a7ea@eucas1p1.samsung.com>
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

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. It contains 2 patchsets that were originally sent
separately. I have put them together because the second followed the first.

Parport driver uses the "CHILD" pointer in the ctl_table structure to create
its directory structure. We move to the newer register_sysctl call and remove
the pointer madness. I have separated the parport into 5 patches to clarify the
different changes needed for the 3 calls to register_sysctl_paths.

We no longer export the register_sysctl_table call as parport was the
last user from outside proc_sysctl.c. Also modified documentation slightly
so register_sysctl_table is no longer mentioned.

Replace register_sysctl_table with register_sysctl effectively effectively
transitioning 5 base paths ("kernel", "vm", "fs", "dev" and "debug") to the new
call. Besides removing the actual function, I also removed it from the checks
done in check-sysctl-docs. @mcgrof went a bit further and removed 2 more
functions.

Testing for this change was done in the same way as with previous sysctl
replacement patches: I made sure that the result of `find /proc/sys/ | sha1sum`
was the same before and after the patchset.

V4:
* (mcgrof) : use of register_sysctl_init instead of register_sysctl
* (mcgrof) : removed register_sysctl_table and __register_sysctl_base
* Added a unregister call to properly unwind things when there is an error
* Added kernel proc subdirectories "kernel/usermodehelper" and "kernel/keys"

V3:
* Added a return error value when register fails
* Made sure to free the memory on error when calling parport_proc_register
* Added a bloat-o-meter output to measure bloat
* Replaced kmalloc with kzalloc
* Added comments about testing
* Improved readability when using snprintf

Have pushed this through 0-day. Waiting on results..

Best
Joel

Joel Granados (8):
  parport: Move magic number "15" to a define
  parport: Remove register_sysctl_table from parport_proc_register
  parport: Remove register_sysctl_table from
    parport_device_proc_register
  parport: Remove register_sysctl_table from
    parport_default_proc_register
  parport: Removed sysctl related defines
  sysctl: stop exporting register_sysctl_table
  sysctl: Refactor base paths registrations
  sysctl: Remove register_sysctl_table

 drivers/parport/procfs.c  | 174 ++++++++++++++++++++------------------
 drivers/parport/share.c   |   2 +-
 fs/proc/proc_sysctl.c     | 162 +----------------------------------
 fs/sysctls.c              |   5 +-
 include/linux/parport.h   |   2 +
 include/linux/sysctl.h    |  31 +------
 kernel/sysctl.c           |  30 ++-----
 scripts/check-sysctl-docs |  10 ---
 8 files changed, 110 insertions(+), 306 deletions(-)

-- 
2.30.2

