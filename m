Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8363732AC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFPI7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbjFPI7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5E2D7B
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:30 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085926euoutp012f5e67d6b02a4185080175f2b0730e8b~pGAn_Lm5A0259702597euoutp01B
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230616085926euoutp012f5e67d6b02a4185080175f2b0730e8b~pGAn_Lm5A0259702597euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905966;
        bh=bKHjXNy8SicMLK3u6h0oFziVZ8C7v67WiPAhXVlVsb8=;
        h=From:To:CC:Subject:Date:References:From;
        b=IMYAGleM1fK+arwXQ5/9ZUWDHZ/WufnR846k9wgsV7wjon4g2KUnnPkq0JLQXFokz
         7TRzA0xgwH82k5J8tyz8bfifcwcZIDIzQKyuTUdtKc6yxapinoKKqrr8nE3+zjLxsj
         zHJoOin94goV8ZRpHWjAO3+8zPjxqb3hFZQx551Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230616085926eucas1p102ba06ecb1d8313a8e2667ea9be7df12~pGAn3c-4W2508725087eucas1p1U;
        Fri, 16 Jun 2023 08:59:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.A7.37758.E642C846; Fri, 16
        Jun 2023 09:59:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e~pGAnme8-10928509285eucas1p1i;
        Fri, 16 Jun 2023 08:59:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230616085926eusmtrp193c6d0f2ca73e2460ebada6f7af3b808~pGAnlulpZ0890108901eusmtrp1D;
        Fri, 16 Jun 2023 08:59:26 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-42-648c246ec29d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.2B.10549.E642C846; Fri, 16
        Jun 2023 09:59:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085926eusmtip2c3aadf6d77f65254c937ddad6a3e3b07~pGAnZVpuE1470414704eusmtip2j;
        Fri, 16 Jun 2023 08:59:26 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:25 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 0/8] Remove child from struct ctl_table
Date:   Fri, 16 Jun 2023 10:59:14 +0200
Message-ID: <20230616085922.3066990-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djP87p5Kj0pBnemylrs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlPGl9w15wXKji5qarbA2M
        O/i6GDk5JARMJC6dXsPYxcjFISSwglFi+YpdzBDOF0aJNwv72SGcz4wSk2e2McG0HJ7WDVW1
        nFGi688NhKrLi59BZbYySpy+tZUNpIVNQEfi/Js7zCC2iIC4xInTmxlBbGaBCYwSsw5xgNjC
        AlYSt//eAYuzCKhKHHwynxXE5hWwlbi0dQ0LxGp5ibbr0xkh4oISJ2c+YYGYIy/RvHU20HwO
        oBpliU/PEyDKayVObbnFBHKPhMBSDomWzXNZIRIuEi0fT0G9Iyzx6vgWdghbRuL05B4WiIbJ
        jBL7/31gh3BWM0osa/wK1WEt0XLlCTvINmYBTYn1u/Qhwo4S79qOsUAcwSdx460gxG18EpO2
        TYe6jVeio00IolpNYvW9NywTGJVnIflmFpJvZiHMX8DIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0
        L10vOT93EyMwZZz+d/zrDsYVrz7qHWJk4mA8xCjBwawkwrvsRFeKEG9KYmVValF+fFFpTmrx
        IUZpDhYlcV5t25PJQgLpiSWp2ampBalFMFkmDk6pBqbWWf8dYpJD921lj5XNbv58uVphkVXp
        WZaaw084PeoK//+waTyjpc8/y13+b7LbvA/GPpmFEjo/D57W47Yr14pd0h3UctShYP72j19X
        RPxmOPXl/gTru+cOp5f43RCoFOGe2Lnw2O9EtXPmbDFLAmeb6r7e+2anSPE6Lhk1WZXVl9Y8
        rc950Nh/QUr2aFDJO29LJfWsCxsrll/993nq2xidXWlXDnu/e6i053i8xuM4pwnvOV+FBu9i
        YGLMSROuS7R5YMktNklB4/TS00bXHkzbUyodlLZ4y7qfoTksbuVibxk2TW3nC6ztvbNj7dwA
        3Tj1BVk6C/Ycfyx/ZFlMysG7LzXmnI17e5X5/J3j2xmVWIozEg21mIuKEwELGxReiAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4Pd08lZ4Ug+XT2C327D3JYnF51xw2
        i+l33rNZ3JjwlNGBxWPTqk42j8+b5AKYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQynrS+YS84LlRxc9NVtgbGHXxdjJwcEgImEoendTOD2EIC
        SxklfjxLhYjLSGz8cpUVwhaW+HOti62LkQuo5iOjxIq9e1kgnK2MEh2nTzCCVLEJ6Eicf3MH
        bJKIgLjEidObweLMAhMYJWYd4gCxhQWsJG7/vQMWZxFQlTj4ZD7YBl4BW4lLW9ewQGyTl2i7
        Ph2ohgOoV1Ni/S59iBJBiZMzn7BAjJSXaN46mxmkREJAWeLT8wSIzlqJz3+fMU5gFJqF0DwL
        SfMsJM0LGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbGtmM/N+9gnPfqo94hRiYOxkOM
        EhzMSiK8y050pQjxpiRWVqUW5ccXleakFh9iNAV6ZiKzlGhyPjA680riDc0MTA1NzCwNTC3N
        jJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamJL07qceFjZXdQ06yZgTZd4x6f+RIyGFfn9W
        yfbMq9ze3/MkiOOs/PTE0DWnr8Zo9T1eaui/4JTpY8byWyZrrugqcHP7O61+5f1lj3jGNHlB
        W2Yd7cdSZwMCjwlO5fYubW6bKNUWVtq+JkDe519YfIDXzhqvB7VeBeWuRbdddmhenNzwZFlF
        WjZXVaGr/Ofs/qxFsyokltTITrqUPc3mPaPwNbe/5Tm3IvR9QuO1mnXf37H2uvr4vul6bW6J
        X6x8Gus17liJFO4oEbx35eGc3XM2Z9z+UBugJbvnqsEWsZzzv5sW3Xys3snl0HspYC+Hvy5H
        yozAbNGsST/z0o2mqizf+rA7xV2CUWKXnaUSS3FGoqEWc1FxIgDeI/R4FgMAAA==
X-CMS-MailID: 20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e
References: <CGME20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the effort to remove the empty element of the ctl_table
structures (used to calculate size) and replace it with an ARRAY_SIZE call. By
replacing the child element in struct ctl_table with a flags element we make
sure that there are no forward recursions on child nodes and therefore set
ourselves up for just using an ARRAY_SIZE. We also added some self tests to
make sure that we do not break anything.

Patchset is separated in 4: parport fixes, selftests fixes, selftests additions and
replacement of child element. Tested everything with sysctl self tests and everything
seems "ok".

1. parport fixes: This is related to my previous series and it plugs a sysct
   table leak in the parport driver. @mcgrof: I'm just leaving this here so we
   don't have to retest the parport stuff

2. Selftests fixes: Remove the prefixed zeros when passing a awk field to the
   awk print command because it was causing $0009 to be interpreted as $0.
   Replaced continue with return in sysctl.sh(test_case) so the test actually
   gets skipped. The skip decision is now in sysctl.sh(skip_test).

3. Selftest additions: New test to confirm that unregister actually removes
   targets. New test to confirm that permanently empty targets are indeed
   created and that no other targets can be created "on top".

4. Replaced the child pointer in struct ctl_table with an enum which is used to
   differentiate between permanently empty targets and non-empty ones.

V2: Replaced the u8 flag with an enumeration.

Comments/feedback greatly appreciated

Best
Joel

Joel Granados (8):
  parport: plug a sysctl register leak
  test_sysctl: Fix test metadata getters
  test_sysctl: Group node sysctl test under one func
  test_sysctl: Add an unregister sysctl test
  test_sysctl: Add an option to prevent test skip
  test_sysclt: Test for registering a mount point
  sysctl: Remove debugging dump_stack
  sysctl: replace child with an enumeration

 drivers/parport/procfs.c                 |  23 ++---
 fs/proc/proc_sysctl.c                    |  82 ++++------------
 include/linux/sysctl.h                   |  14 ++-
 lib/test_sysctl.c                        |  91 ++++++++++++++++--
 tools/testing/selftests/sysctl/sysctl.sh | 115 +++++++++++++++++------
 5 files changed, 214 insertions(+), 111 deletions(-)

-- 
2.30.2

