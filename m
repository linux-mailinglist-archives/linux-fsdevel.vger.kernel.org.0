Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE664E3DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLOWmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 17:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOWmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:42:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BBD58BF1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671144139; bh=3oIJmH8dPuhuKzA9sfPCzKvM+IHoMHC9mDv8O5LZFak=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=NiWhsFJgNWwMlazYv5As5/9TSJkOcQC056S8ywkccG8OY5Ti2Hb1A6jvkOEH03tR5
         WevXc+d6bFDhofU2t0ACI7/23eGqxcCvgsmyrs4bkQLHNjYPc4poRYWAH1BQ/PpjB4
         ODasrbU8VSf4rUbU5AmwZRFYiBLAHvuCognQsQ3YC60cBuyPIrPRGxm/TeGm3WLrbJ
         xDaG0yA4k5EVa8bh0CnIzsSSuNrKf3vmPrJc7M/mFWK0xH8Ia4BCTacB5UTC7h7uaU
         MA6DbH2Ro3nwNCiitsbKKk6QmE2aTieGINr6bQmEDSA+ijcCU3KME04qfLyMFXb+Wo
         LS2WHya0VAUGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530 ([92.116.161.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1p4aYA2KaL-003giH; Thu, 15
 Dec 2022 23:42:19 +0100
Date:   Thu, 15 Dec 2022 23:42:18 +0100
From:   Helge Deller <deller@gmx.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/stat.c: Drop choose_32_64() macro
Message-ID: <Y5uiykbotOf9H8BI@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:qcrMVNHoOrxN/2rs3ENLATqIvsMGNOkKUgb2YQwRuPTpMGBkVzX
 9EtTcjCS/L1tEQI3RQZzW78RLMDFOfidBi0D7cViE+V83ZJKtZLzcfYvijvJmRMZs0u4KUB
 irthPD+NrL/4cYeVx5OgSgvR2QX7I1SI25ftm9oHQL1N/zdChZvYt2FLrZK3JeB32lKyS/0
 DdRXJfpN9z7Lvhlm9kz7g==
UI-OutboundReport: notjunk:1;M01:P0:JrR2bAOwKmw=;wDXYaOC4Gj2lojmn/BiIUH4DT+E
 uJXFFQVyfWjQtXlJJC5pMiTVKzNLWttwDNjN+E1pnHNCXYOJJA5859wh+ECGwzQzuOsUBCYJZ
 ad3aRqTfYgUG/LxFa5oRcRnAWeNOSO1CLh6HzGJpPzvylrB8F9KAAm/1w32aS48tdfCdIAJu5
 2AUByo/KDzdJXKRZ2kC3mj0WtXjnLWNcAEy0AOD3L+RNc5H74Ql75wb7vvhDdn7+5mKf+AFFj
 DQl4mQ2aA+JT5akkBeIJbmNgUGjAdUjIBhHgeupusDB1enksNHB+7Px9lYX1fQ9w5Bwtv1nUI
 0Y4gQteXCs5/jIKycUhchxEPJeATlLpAwIJ1XGhNOlm5DOMCFYiUCSN4ybSDnS3CMHKhpPjjg
 2ECOHlpi+sXc8kUJMRHmsOY3eK6XL8z2/GgSBorwAXfdlHCRr70jBtfuN5Yw1jUcvL9zFNpai
 U+0HeQ2Yp2ghplaEcpLkzUacEtU1MifpaHeMRcW0YWbRWP3BnSgnUyqLLONOKrHkXb8ZOpEFZ
 wGiE8SCji4ayPMtEHLs8+Gxtk5TaTcgedPGNAXSiECmy/6DOVNimZLYLKo6e+ZMJ8hhZaJsbW
 GebiJIm5SyCQ6LiQooPRoI5VBeGRJeTKwk6DKOynmmCijXogRm+RimUHV7yxaMxP+BQcuZibM
 hzsK/Q7Io9U+UBitUc/WFYeJU5rKrUZgwg0vBokzYbfa4SeRK0/OCIgZAo3bi7gVSjgqCrKRD
 7deCcan28pWuASmoMNiNnex9h35nFgDxSepT2hckLyTctocLkzYbS8RCv15gb7SBuPbqf5X4C
 daI76g67fV3ZbCzOe3MXdqmkvrR/PhZKJXvRxJfbycf+xxWVVbBanuu9YK38qajywyEcNS4Hj
 fxY60g9bFHzBEL0xHWFXFRVi1QZ5I4kOw2MNBZuzNpGsJ8KVjHUkkSq/doobC7QRNGZnqB0R3
 ed49Vg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The choose_32_64() macro is never used. Drop it.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/fs/stat.c b/fs/stat.c
index ef50573c72a2..1813eb6d2114 100644
=2D-- a/fs/stat.c
+++ b/fs/stat.c
@@ -354,12 +354,6 @@ SYSCALL_DEFINE2(fstat, unsigned int, fd, struct __old=
_kernel_stat __user *, stat

 #ifdef __ARCH_WANT_NEW_STAT

-#if BITS_PER_LONG =3D=3D 32
-#  define choose_32_64(a,b) a
-#else
-#  define choose_32_64(a,b) b
-#endif
-
 #ifndef INIT_STRUCT_STAT_PADDING
 #  define INIT_STRUCT_STAT_PADDING(st) memset(&st, 0, sizeof(st))
 #endif
