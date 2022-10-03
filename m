Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B705F38CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJCWWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJCWWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413F53037;
        Mon,  3 Oct 2022 15:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZGZLcwrhmMFuxpdSckqK3bo1Ai9/rCChCC4EtP8PXo8hQjEvgYybAxx1xWDNKZkssFMswY87kAJaAKEOYNL5Zw5JQ2252gd3Nec2bV6XX+megjf/IQNrhwEw0ePkPUPGRckXZE4lj70dcEh25xdn+DkFHlCQJVgeRs0JpqIZPbn91x9hdwIJX2ne5jx4DfmhVWKMSumbMSz0SjQqfr0qj0GFWGrzObld7XU8swn1riCGukVPYdG31QIF6zw/rV09SKhJZjrKBhQncO8d9GdV6oYDL42S605c9x8bHGyJww72JbsLvDaRTb2NRmfzfl9+EgatArRGCh3VpvoI3ocPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8518zTRI17HbsZNfkeZY1Q6TIPgIuAuW6ZRtNWowSI=;
 b=Cb9M5X3yNadbrS8qW2e1/869W2L1tz4iauBcswN3aQmKRVMoMwfYecLOg2y5tml/C9xvfEYvJ9OHjCAAbJ64nYbLN44pHlTHU+RKuyMGhbKfGT8U0cbPJXHwaadGBG0cEKIq4DB958K1epuWuanYtnEDDKE0wjplb2jOpQyaKMksbJY9BRb6gD+BgJIJ7ODO7s0r5D48zogk//CwN+/24Ipcd85dBdwOosqZiJdC9MBizeJmne1m+Kh2HsGKgLvpOSc8ArdfiSPUzZU+k+u1GbMf0CVVkDL1Oi8JK84erFLAJs1kciXIFMte/IGmzqBOn+rLDHAUbHPX4UsNXSYyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8518zTRI17HbsZNfkeZY1Q6TIPgIuAuW6ZRtNWowSI=;
 b=IGsR7XhAMdFZc0smUKWVtSp/p3/ypRtr6m7Fj7LL/9iSpMWg5own4HwQz2SNxDClPSA+EsllZUpFC+Yq7tlPpEtHoqR0q9+4hiiLh9s7/gzIxvhaviJifkjLQYWA66Dn7h53C8rCTsnTlyg7qfXOXIxNFgqwhCOLhkohZyT0VPGnZS475kKRLr/3WRZ2EhBvXufuBoNUI6vjMM2pCq1CQcpFlLoEXOPf/RP66PMnCTjyadO3WBLk0gbOLaTL4qx6BapgHd31KBa/6oFMkw7mDKB27T4/ZBVOqtCRnEmzGNhEYLKHJQqBP+h6IvI523vVeDksRGy1e5+OBOAMr+v14g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB4928.namprd03.prod.outlook.com (2603:10b6:208:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:21:56 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:21:56 +0000
From:   Ali Raza <aliraza@bu.edu>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pbonzini@redhat.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu, Ali Raza <aliraza@bu.edu>
Subject: [RFC UKL 02/10] x86/boot: Load the PT_TLS segment for Unikernel configs
Date:   Mon,  3 Oct 2022 18:21:25 -0400
Message-Id: <20221003222133.20948-3-aliraza@bu.edu>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003222133.20948-1-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|MN2PR03MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: a232e0bb-987e-418d-407b-08daa58dae2a
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmQ+jE4C6SqbijVDVgWeXPjE7uLdhsVrKx2H0MvUo8ES+LKx0+2DIDiOXqmQLROvIygXWl1DrtMIYiynfZkBWImBsm+STauGdbCXC/BVUlQmigelZ0t5eZDpOiTjNURRybr/TU/0U3dLLGwSLNt96FMBG+7qWeet35x1GQTqm/85af24nK2HwzXf36rT4Ad9INugex924IfrBbZ2u037xEMUD0CoeZ3eUWzAfWPQ3VCed4ugZtgGy6O2EfUpH14RF52Tiehn0N76H2w3rFSviLFwYAZWux8KiP49A335GTa+uutT/q8icybuw0bAysOH3w+mrmvmPkjYJV4aJijfVHnTN367e55JKrZVSRZtZRF4Vuo/wkpCWVNQpntch5fPMzTa3E7MbV4dsB5Vj9M8b2G/+bCCXzmiBYbSk43SA2H847LHSFxwjJhnNOKQZvoEEjHOGwDQH8L41pPT3YxcriNwIIGDAnjkCKAEqyzSDcqXR7/PNrUj+CdC8l9k8MvrZLYiVf6qOhqNKskOZANrbEhts6IxOf4rXmqhYfFUhq3hnm6wbQu3d7CTpa6vCxapL14oSXuAdVb8JLVuBpIpoaD2E3AO/rrsLQDGJR2JL5UGVYMHBQbnOjW0PLyIDFbi70MPg34c+Hmh3t9uJqjFt2Z/1k93YNt3y3PWQYK5hgsE3MHrk2bV5/SjVtXEHRAbFQeVsH/qM2RvAeeODVzmod/cqn5Fg+R4d12cfFz7pPi/RyXsJulP7zVJYZpxLNHiS0QaLgpx1H8epMu/qyPSJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(7406005)(41300700001)(6666004)(38350700002)(75432002)(66556008)(66476007)(4326008)(8676002)(1076003)(186003)(6512007)(2906002)(2616005)(66946007)(52116002)(6506007)(36756003)(5660300002)(7416002)(26005)(86362001)(41320700001)(6916009)(38100700002)(316002)(6486002)(478600001)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YuYwJLoeVeZXSZUmCeV2JJZZmQkzv+aOOe95Tf+3AEoGIDRys2pbh47l7R23?=
 =?us-ascii?Q?r+0/RGt6vRxze6XA5bw0nxd8f5B0HIe8VZUNEn1QJvAE1ZxzcfyVSqP6d+7Z?=
 =?us-ascii?Q?PIkhMMxOt6sxh3egnCjhJVQImgL8LsDWrIz2TMSM89wCZXEydG83oXhA93wY?=
 =?us-ascii?Q?h1/z2y6A1Za2BxdXXKUsIC6f2NG4PAU0lnFLWmPXqfHlKlndwSGFmwmLGXrf?=
 =?us-ascii?Q?FL4asFNBR7BtsZKjKt48uqJcue1gtVdyRXhSgRiNcg0BAZvukz8i9nmzHMDW?=
 =?us-ascii?Q?HogUR5olwTKBFFxy6u5t/aRa58Y8gdB6kiD/mvSr/TkyOlUGdIHi1sD/gGaS?=
 =?us-ascii?Q?LD0aQvCYcIT5MlhvIE2M+ludu348w3scD85LaW/faG32kFbBSiQCCd6jJdGX?=
 =?us-ascii?Q?Y+kek+CRpzRI1QUTCK3Ck3OvQ47AOLAp+Caz0P/Wa+nNYST5SK3zMAV4y3D9?=
 =?us-ascii?Q?NFMnsgeHXTiKLmOb+btFc4eIayZMBiAGLMONIur2YeeQ6pQDHi9lhkEqb/ea?=
 =?us-ascii?Q?dTLJcwtgU97VuMH4ZGAHeiXRXROuIMzOlHvhDqQxnJQuPEsXw1ucJ/81IOoP?=
 =?us-ascii?Q?rf6XpvRsuaBC9TivhRqM4wBdO72Ya8jJavcLQCU0Z8zst26f8YuVRKs0Dp3P?=
 =?us-ascii?Q?qR007J9NWBMwIO6v1bsm5EQhdtn74XzqPs2GgJK+Y4lnfupo189Ek7xUodDV?=
 =?us-ascii?Q?FmGwBAFX5XWhoY1mfaxDathNDvIvQ21SucPEt4/42mg+r6adtEPKaenW2k0Z?=
 =?us-ascii?Q?Re6WJcNejI8DNGEu+jNa8E6oBMV5f48SK9OEhSZd2RaUTLsumFlBHcFyhF6g?=
 =?us-ascii?Q?UMNHBLtN6Db74V4oLEvPILB1pCGI6bhezUiiMPRzlqP8f97Qu1kohK3RCiiJ?=
 =?us-ascii?Q?4Weh5YzSXAK6Zip7dfNmI7zs9Yq0eM3bYWXCWN0jRoxUibe1WUyXgsD8UyDT?=
 =?us-ascii?Q?bjXCHlmyp7eFHaCw916jDuOb3zK9y4g/UTnBAT0+f9VhxA99XLNtVQ5qL/mC?=
 =?us-ascii?Q?t7qGhSBoNHQgxb0LTdkD17FIBveoL3FrvRS++adY8IxxoW22UozP5I60EGuv?=
 =?us-ascii?Q?XLYmaChbnohhMloCnbHE5au9lShgpOIc4OV+pT3jbE2K603QLVW/isynWHjU?=
 =?us-ascii?Q?z5s+DBPVrcVqqoS916pXr1/qMxxIDp9kVT5iMcwWjm3SH1dMu0A1gF9k8Ew5?=
 =?us-ascii?Q?gUT447d7O4SwYLRn4BIUsVt/y7+gRfXebQHB5xJnEuUzhDY1GGTV0JF57jsA?=
 =?us-ascii?Q?8pjNHwej+kX1/sSxaUEp/a2nEahxgVnycGkV9rd0PrXr27mjtqiUHYm3a6z+?=
 =?us-ascii?Q?zh35omsbNeGhwaqKavZ3xaJpWnzkx29UBGAx+8iLp9Gn9vDti7CObKewrc87?=
 =?us-ascii?Q?OhQ0GRNqT1cTa0lgh296YH7l0zTKTRCXfkPDCpZIiJaWwRam+X8zmESNTuaL?=
 =?us-ascii?Q?KnYSKKpwTL3EPxhTFuvlvMDsbK6wcsJF4yYLFRVfk1TfnI96+idTss5Pavf/?=
 =?us-ascii?Q?t8jaiK0T1ST5ea87KHyL64E4MLNQaIcMUdvWaYQeyIB28wKOR2SLrzTRlfOn?=
 =?us-ascii?Q?b4z/g1mXJeFwiLvn6yBUam+5RX2Yl/NX24ixj7ty?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a232e0bb-987e-418d-407b-08daa58dae2a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:21:55.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwNLJFU7uVriXvc3j20WELWE0GjNjOITOd7J6aZPS/8+5rMtWFTtT83HhTSaB2ic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel normally skips loading this segment as it is not inlcuded in
standard builds. However, when linked with an application in the Unikernel
configuration the segment will be present. Load PT_TLS when configured as a
unikernel.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>

Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 arch/x86/boot/compressed/misc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index cf690d8712f4..0d07b5661c9c 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -310,6 +310,9 @@ static void parse_elf(void *output)
 		phdr = &phdrs[i];
 
 		switch (phdr->p_type) {
+#ifdef CONFIG_UNIKERNEL_LINUX
+		case PT_TLS:
+#endif
 		case PT_LOAD:
 #ifdef CONFIG_X86_64
 			if ((phdr->p_align % 0x200000) != 0)
-- 
2.21.3

