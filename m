Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8F52E7DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbiETIjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 04:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347316AbiETIjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 04:39:20 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C39D4EB;
        Fri, 20 May 2022 01:39:11 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220520083908epoutp04e5d832cdb53a09d97a5302b58812c15f~ww2-NMO6u0301803018epoutp04d;
        Fri, 20 May 2022 08:39:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220520083908epoutp04e5d832cdb53a09d97a5302b58812c15f~ww2-NMO6u0301803018epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035948;
        bh=AhwgzerEVuyodIt2V4RrrdlfDM0bzVilGZy8x4sycs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rB9mGpJKv/QU7ikLSrehieGW0N7+ipKkLWILLN4Zb0gO5zeQhvV3Lsj2fREzYqJK3
         prI85zw5E82ahobCBB0BJAYfUdGfxlsOELX73Lsa+Ne51+tE707SQOVtbKtJQrj3pi
         5SV4iFkm9nG1zthB/ni2KOBTr9exXbsxtV0zAu7c=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220520083907epcas5p12ad73903879b0f71f319779b8d6c69dc~ww2_kPNVf2141921419epcas5p1a;
        Fri, 20 May 2022 08:39:07 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.C5.09827.BA357826; Fri, 20 May 2022 17:39:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220520083742epcas5p4fa741caf7079a1305ef99cf00a07054a~ww1vXeOUf0679106791epcas5p4y;
        Fri, 20 May 2022 08:37:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520083742epsmtrp29ba296b9455ba9da4f8688efb4724e3e~ww1vUWa821034110341epsmtrp2e;
        Fri, 20 May 2022 08:37:42 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-9b-628753ab2940
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.F7.08924.65357826; Fri, 20 May 2022 17:37:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520083734epsmtip22c4d3ea9b7cead988478e126befdfaea~ww1n_Xarw2680526805epsmtip2X;
        Fri, 20 May 2022 08:37:34 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, arnd@arndb.de
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 3/5] arch:hexagon/powerpc: use KSYM_NAME_LEN as array size
Date:   Fri, 20 May 2022 14:06:59 +0530
Message-Id: <20220520083701.2610975-4-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPffe3hZM3aWYcIabLmRdAmrd3CQnZPLYnF7IHrJlDxbHLHID
        jGdaGGyJsWAFeW0NgkBbK48IyNNqFWwLw7KUhyivbIA8BlISmAiF8thogNEWM//7/s738833
        /E5yODgvi+3OiYpLZERxwhgP0pm41+bpebjmi4ywt8euQ6R+OEsiZUMtiXLTCjGkmxkh0Eae
        kY0mdVICmdMu4ahWk4qhqQ0DibrnxthI2bNtPKp4QKJe+SoLPVNVAzRl1GCobOgehoZrxKg7
        OxZJ1X0spG/uJNCCtIlEA1oliSSKNRaSlV7EUfbg9tmUXEUi69omCz00dhCo7Xo6gSrbNzE0
        JJsGqLzyLdTfWoIhjWS7uSZ/g42qcswsVPt7ORu157ZiaGtqhYVaLk9gqPuGAqDs9WKAdOoy
        ElU01LGRofMaQNLRY/4C2rqeB2iFpI+g861qFq25OYzRZbMSgr4vH2PT0pYnbPpOlRddrp/F
        6Jw5KYu+XZ1J0qN/6km6o8hK0LKyVkCrOoPpnqJScNr9W+f3w5mYqB8Z0RHfs86RxuwGIqF/
        d0rVP0ZcAkadsgCHA6n34IMNvyzgzOFROgAvNa1ijmEJwFrVwM5gAfBXzTyeBZzsiUrL+I6h
        BbC1eoLtGJYBvKIsxWwUSQlgtVZP2PReSk3C1e5PbBBOjWGwfsbMthmuVBBUdNXZIYLiw5Xl
        EWDTXMoXFvQVYY66A7C4f83OO1F+cGh+lHAwLrCz2GTX+DZz8a4CtxVAqtkZZk9Pk47wCSh/
        Osx2aFf4d7tmR7tDy3wz6XiBZHhXdsGRlQL4mzJ/J+sHTX2lLBuDU56wQXvEcfw6LOiqxxy9
        e2Cu1bRzTy5sUr3QfCgdvsVy6H3QsrhIODQNZQtyO8Oj8gCskvNl4A35S+vIX1pH/n9zCcCr
        watMgjg2ghEfSzgaxyQLxMJYcVJchOBcfOxtYP8uXkFNYHLCLDAAjAMMAHJwj71cECsN43HD
        hT/9zIjivxclxTBiA9jHITzcuNRWahiPihAmMtEMk8CIXrgYx8ldgikyij9/eobfa/bRD+7/
        Ny6xSCNIddUuosI9B77Le/zNGd9GMW/sA4M1seCqkQxrW+/wdGl7pePE1v2e8Y3z55S7TPPH
        yTsZ0RGXYaAhuWIwff9nf9xS/WUpqAOnN7/06w0O0A54735yqtU5bS56hQw5OFJ3HkvDnyuY
        5cSGHx5/nQ6oj4sqA681urnWNDptsYT1Vy/kFYbxZ2fReHHkVznP+F1L8uML/rLVmXcPnmwx
        nboykpR1OPhT3WQo97WBEvOKf2boocGTAZNoZMPtTVVKSFfKh1MfRfkQR/N1oZnqIPK5t8Un
        P5AKDgg/OzoTcmjFZMRd4m8s7NJ7/+J3M33pkQchjhS+44WLxML/AIyvveadBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+T57fmzL5bNJxyPcpQcnh1Ar0o5PZdB11/nocaednXeWBw15
        GJ4boz0QQ6HWGGiAHO6AYAMUSMePEY6WR7IQZ00IOGSVAY6MwzIKB0lEicNgu+78733v1+vz
        +fzzEQpkfUS48GhWDqfNUqgiSTF+6VrklmcPHjiZ9vzNainYh2ZJqO+ykXDa8AkGvb/dwsFv
        clMw3WvEYcFQLACb4yMMZvwuEobnpiioH10DIxeuknDD/DcBfzS2I5hxOzBoHr+EwUQHD8Nl
        ajDaxwhwfjWIw7yxh4TvLteToLcsE1DZVCSAsh/XuhlzIwkry6sEDLkHcLh2tgQH6/VVDMYr
        f0HQYo0GT/85DBz6tcsdVX4KWssXCLB93ULB9dP9GDyaWSKg79TPGAyftyAoe1CHoNfeTMKF
        rk4KXIMNCIzeF1+TsysPTIi16MdwtmrFTrCOtgmMbZ7V4+yX5imKNfZNUuznrbFsi3MWY8vn
        jATb3f4xyXpvOkl2oHYFZyub+xHbOPgmO1rbhPaHvy3elc6pjr7PaZ9LfFec6S7rwrM9T+ha
        /3EL9MgrKkUiIUPvZKyLP2GlSCyU0T2I+X1yRhAEEcy/q/N4MG9i2lbvUkHpPmKKa+wBQNJy
        pv2yE18HofQUyfx6siJgCei7GHNxeiCwahO9l7F82xmYwOltzNJft9B6ltCJTPVYLRY8sYWp
        8yxT61lEJzHjPm/Al6057qomMuhLmcG6O4FesOYXfWERVCLa/BgyP4bOIawdbeayebVSzcdn
        v5DF5cl5hZrPzVLKj2jU3SjwYrGxPcjZviB3IUyIXIgRCiJDJUhtTJNJ0hX5xzmtJlWbq+J4
        F4oQ4pFhkhulg6kyWqnI4Y5xXDan/Z9iQlG4HsNOvPJBS0HhRVtyiU+6dd4gTzhD7ta9UWLd
        Y1CqK17vmNsYdiWuNPrh04elfE0Wvu9U3A7GlPhn7+5c+23D/Bkp9rIlasP3nYYTd76ZfTiq
        yhg6aPPpUjP9h4Qjybpj7HkqbENavrXcUsG9Orn00hXNMzyVMSLOGKPRO4s1e3qefEvj+Mw7
        mpLQexjei97uyUv2pWpyXRtVP4QMxFf0xaRs8+hDrhLJbRH+I1uPSztjNk9GpXTX7c3xFXzY
        eG/aROvGJU9t35eUd6jhgPNeetrOanHU2Yk4O0Z/qsynmoaTaJG+JQE3PVKHFosLCwpDbD7L
        /l0xi/eLxOkNt1Hbjkicz1TExwq0vOI/7edTGNEDAAA=
X-CMS-MailID: 20220520083742epcas5p4fa741caf7079a1305ef99cf00a07054a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220520083742epcas5p4fa741caf7079a1305ef99cf00a07054a
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083742epcas5p4fa741caf7079a1305ef99cf00a07054a@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
writes on index "KSYM_NAME_LEN - 1".

Thus array size should be KSYM_NAME_LEN.

for powerpc and hexagon it was defined as "128" directly.
and commit '61968dbc2d5d' changed define value to 512,
So both were missed to update with new size.

Fixes: 61968dbc2d5d("kallsyms: increase maximum kernel symbol length to 512")
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 arch/powerpc/xmon/xmon.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..65b30b6ea226 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -82,7 +82,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	const char *name = NULL;
 	unsigned long *newfp;
 	unsigned long low, high;
-	char tmpstr[128];
+	char tmpstr[KSYM_NAME_LEN];
 	char *modname;
 	int i;
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index afc827c65ff2..3441fc70ac92 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -91,7 +91,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];
-- 
2.17.1

