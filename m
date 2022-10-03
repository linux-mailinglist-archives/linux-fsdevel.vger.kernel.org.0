Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2755F38DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJCWWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJCWWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5354855084;
        Mon,  3 Oct 2022 15:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8/c2bggFW592cOpszPOSDZTqgmXrgBfdgnpgbBoIPx3PYHEODsd4KWl57caIlnST5i0+SSCPPvaniAdLj1ho9aYYcicoKLqL+QFj3VE0hTU+0XIJ2WuYfM2WMvRDVMLPRnUnkz/HzHNCGWoGL59AaiJpAUn+l4/6oMEpMuc2HqIOISjQg4YsScyJySOYc57HZJlEERLsJ0hXOa45GfjFg6bLJpNk3h1oCMmOP0d9dciqeIX+3j0z6fZQmDvUFGyFT9KuFo0BNbtILkdjcUOQmVNZqO8r4hphruSHlJa+N5pPX1UDM6RYW5slYKpy4WS3xW8UZKis/68AXJPa2hONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z14fAtkfPrOamaE/1DyoemSLSS4pvPqgduyW0IzSLBE=;
 b=MtqzAww3N9kpeBk3DJAtoib0BNsPZztqp0Sch7bC4/IyoD/uigo1pHSOfIWJQ7tdntuNGTGxrteobMNCltgNmsjwqNu2xqFQrl0NtrYP8LWeuZeX0jx672SLFTGnwanRfJ8QOZPqheU79X6CBcy/3haRy0vEPB/nNNUlXQkFhqEpxGd+dfT9UDewLGb57YeY7EYQvxdBKWyB8LtiP2euIxc0+KPdkK6/bJ3FgYiHShZ+B1ImwYHM65xBWHYAA3DMwx/oiAfHxHbMwBFVgOEs17LhFfat7wRlb2l8wbuxD2r0xOL/u4zxvbvTgqPx2ZWuaTYnp5CpAqfxaBugmDjt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z14fAtkfPrOamaE/1DyoemSLSS4pvPqgduyW0IzSLBE=;
 b=YZIiCvuG4gwt7W+kRyw3GDvf0gsStwDx140Cf3mrP/xIBB529tu21wycV1QeJ5FH+v5K556TR+Scj19JbBDBApxcSyNacTj7OLSarGT+owtpLU1CvC5pMHlyMpkJ+mPM9gxKSZr8VxaCJBRhvoqN+FCynMqjArpiYUwxm+RtU8nqvN8sRPYfgj7e90mVoS48vCYBJIS9DZ4M0ZnaK58/RZJrqB6S/8CBaoqKBqEdMpmS5LcHOwTS/5wgQxi/1DZs0COQBGSP8GPePnls6w1TBK2aai3yao5Ws+HtDazuo2nXd7FGWs5iJvbF9pkOzu0e91IadvDXvyTeyO+nZSuCfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB4928.namprd03.prod.outlook.com (2603:10b6:208:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:22:00 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:21:59 +0000
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
Subject: [RFC UKL 05/10] x86/uaccess: Make access_ok UKL aware
Date:   Mon,  3 Oct 2022 18:21:28 -0400
Message-Id: <20221003222133.20948-6-aliraza@bu.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 484be881-c558-4b48-41b5-08daa58db07e
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTg+Uoix2B5fSTCKIlfm+3zSWdww2Q4SsF7Hhbv5jA312gjd3005gDrgqAlE0wnhN2YnB+frQkmgXnUQMTiI92kQ7XnbJWDqAPL6bBVvUDUYhsr9yaqaCoxkZqZgcMBjtxVQYCVdptW3+VrdOEbWo5XJ/0B8x/8NMD/SZdHb6//p2mlhUIWRCsfPQTGEa9D7fNq6SbwvIg+wLwMBXpnX+rJlIkEsbJOsC6+1k8Xgtqsefl+AUckKuDQ/lr+SQoFr3XYb0PU7F0MYMY71M6Euhxe4HKvtmkkZeECi8ZDkq/cbSX/pUmVIOJHrjqZvohBwv+USHqmV3EUQd1dbphunhoQeCRJGUVVkAZ0pAJLlxh0m8XVIpPFHE6K8cBv9mjoLhkOpBGh6HPwHfEHmNZRZtrk/XCEQLn+1txCWa+DKAcL/K6WJ38tTEk8kS7pLL76+kKlP0w4ilaS6cxp0EvA0MbfcPjMuM0BRMzYIylsXlBChnTiuOCclgR0/scrZtPZ5FEjhxVIxYdCCyNMfw4YPSAibboy1aEsXmCE2Q1w6Ye6kQZ4gm9vVY8UtkJx+vlthGyTDrM/kxoYky6a2ralKNw/9kHc9Ccxc5qTmGsuh1vxW/OhFNryrx0wekymKRjyBt5GHNBrexUozNvBN1+EQV0fx/RAuYEGhwd7vNLv0zX8NU1I3KjBnVW+hn6oB+4htZC5MV3FRqtPoTAksYf4U6sw4sAP8uwZ8vnQLltxch4jd+Kump6I1LerAj6U9r/Csk1EGRlTF4srtx/TMux4m7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(7406005)(41300700001)(6666004)(38350700002)(75432002)(66556008)(66476007)(4326008)(8676002)(1076003)(186003)(6512007)(2906002)(2616005)(66946007)(83380400001)(52116002)(6506007)(36756003)(5660300002)(7416002)(26005)(86362001)(41320700001)(6916009)(38100700002)(316002)(6486002)(478600001)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yMVUkIQVjLTMlW/7DtvFo6XvDzF6cVW0jWybUzfL67VrCG5x3TQSKwDajKaE?=
 =?us-ascii?Q?jj/7nBbmlYH3EIPcIDgy/XSaxZss1xed8JLlJrrATMD0Kz/ojy+fUQVO+BU5?=
 =?us-ascii?Q?os+8nArLW+09LqxeRp4Sa8LvvuAhEByXx56md5dYXcKVLUyhREk0Y573zf9p?=
 =?us-ascii?Q?iOfkBIEzcEiwFCRIVFohDUuUP8FuVYWXxjUosIR+dEnfdtAx1QtDLRtz50gy?=
 =?us-ascii?Q?T4NBbQkf1kGNqLeq7wItyR/C3fsi/dG8YZEKCv+Gr6l0UgibkuUIC8RHTkbs?=
 =?us-ascii?Q?KvpjEmSyi431xxRNPV4IugJzh8diz+kgtb+VZJd3dCNPNDpYAPkpQnAlvkNS?=
 =?us-ascii?Q?Tm7qbZUXoV96KXBYSXbYc0YJwiasRQkLre3ZCqO8B4Ye5iR562AyYpkjM/0J?=
 =?us-ascii?Q?y5b0UiHWphTbOXGBz9TsPCvWz4TI4YpUpDZIhQxQ/P4XR+q41if9H9GZLKQZ?=
 =?us-ascii?Q?O91z2VjFAQ+7xERyfapx1j0NXtF5ZtIDJKAnntlS/7GYZ5LU85a+ToaI5Uuk?=
 =?us-ascii?Q?bnX5xcMMdZg1swAtyQcr2NL9fv0iPfvxP4C5sx5BPaKJfXPvkfIrnMF1xjVK?=
 =?us-ascii?Q?B6X1be4NATRW79r0S9u8wdRj6pIfuGmSJld6Prjk263rFa1c52suSRHRGS4E?=
 =?us-ascii?Q?cDA1N453cFgIc2Hi0A+JXlzklfISLV8PZTdq5OnF1ppdfLkyGD4ylpp+kmoK?=
 =?us-ascii?Q?HE//FcO98U5IfRQ004uzHwuvBFVZkIo4T9hIRwAt7z1F05OtYPqLaJgSVJCv?=
 =?us-ascii?Q?69TruagLZypqCAw4Sj9dQQV0/mnSRrRgzfZtrj+IXZpkLL3DQFr2VdbgaoMx?=
 =?us-ascii?Q?GO9Y6mUyidECvIEvcR8exTKHhlOKn/XwgEOo9muo8pvRm6j7U+CGlPAziwHE?=
 =?us-ascii?Q?rEGddHdOeWY8HAqKOhAW14TwEk1ps8bcdlkhJdeWsKX6CXYxho2/LhYM+IF9?=
 =?us-ascii?Q?xlEiYfieTRaIKKhqycSPAYWNx4xDkvfOLD6AIeP5xHdKDtXY3WtJ5anBtqBY?=
 =?us-ascii?Q?w5AEBcT2DkoEJgwdqLVNbpeOgz8lRnu5V4/R1qiOj3CbQTB9oayE4S0aLwjF?=
 =?us-ascii?Q?OZvGuhWsMJ4j2Npap9KUoXz0tN93NL5uLSpq5QwxioEiEVl42O/AtVBIgl9N?=
 =?us-ascii?Q?5vii7rmMjLBVFFW8ahQmk2RudqKalvWmlHtIPTF0f2IEBvWdAXkvJqAdCQ4v?=
 =?us-ascii?Q?apkDvvrybxrtkt4j0grrAH5cT2Us/D8GNOYJgCyiFGmvutok8MLkEopdvuLJ?=
 =?us-ascii?Q?REfsdubUp4Gkjil4yAVK8CqDs8dkPoWhDDXoOTW56oRwKXjKds8NE4AhKVpQ?=
 =?us-ascii?Q?Q+6ppL7Iyax+9UYHjSsOzPo7/TvL83uG6aHuQm5W6/fpbxI45yAcpuxKlk5T?=
 =?us-ascii?Q?rlfC0yb4YjaQ8Rm5/spemOn2VRgEAoPJPp8y21sA4+U9JGyEw6ME5Lnx5P0+?=
 =?us-ascii?Q?35Zstoiz/uJdP3j6BX445RqF+i0ch7aWZPiDwATq38XX8G0jIYbwufLqyh7t?=
 =?us-ascii?Q?wXaGe/3XoTzD1dbhBjsItdpRI7rzwqAoEbtrRWn8qmjeuudOY8HApPUVmOeV?=
 =?us-ascii?Q?aRt/ANoig9XnySlxZ59eddo5laROzPTEsUELEcgh?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 484be881-c558-4b48-41b5-08daa58db07e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:21:59.8569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BvbyvWu9cfqSMWbOj4598Ci4AQ30aqpBh9YIiwb+3nOGLA4icfHnHmgQPFZXIft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When configured for UKL, access_ok needs to account for the unified address
space that is used by the kernel and the process being run. To do this,
they need to check the task struct field added earlier to determine where
the execution that is making the check is running. For a zero value, the
normal boundary definitions apply, but non-zero value indicates a UKL
thread and a shared address space should be assumed.

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
 arch/x86/include/asm/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 913e593a3b45..adef521b2e59 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -37,11 +37,19 @@ static inline bool pagefault_disabled(void);
  * Return: true (nonzero) if the memory block may be valid, false (zero)
  * if it is definitely invalid.
  */
+#ifdef CONFIG_UNIKERNEL_LINUX
+#define access_ok(addr, size)					\
+({									\
+	WARN_ON_IN_IRQ();						\
+	(is_ukl_thread() ? 1 : likely(__access_ok(addr, size)));	\
+})
+#else
 #define access_ok(addr, size)					\
 ({									\
 	WARN_ON_IN_IRQ();						\
 	likely(__access_ok(addr, size));				\
 })
+#endif
 
 #include <asm-generic/access_ok.h>
 
-- 
2.21.3

