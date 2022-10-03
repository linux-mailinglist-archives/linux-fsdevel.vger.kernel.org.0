Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204295F38E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJCWWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJCWWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C787550A8;
        Mon,  3 Oct 2022 15:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz4BRlalncUCjNQmN1JsYs36emAhRY3y1S5R5X6k3YgOfUHQ6pX5qlRpm2m1alrR/6sLMxBMjB/sXY/mnKjs+afUcnmRq4L1+d24uOBFKlYo44a4IOmf6oXnAQ9taMk8m/Ks+l4Hs8lnZovx7E9fx7bkpISNB4pp95cm5Cmf/coiBaU+VEwvC4OlyHvAUgrK6KteTvHFQ8sduwYd0It93WzB0Ks1adeG9SJL8iYADMcMU/htJJduQ7gl77exGZryc0qgGMX0o0tv0DA/DUkEU3PlUAjpjg4DucHV/SroV8RZqnZALfIOIjGLShtDBN4MTFlOOlMB7Zio3kPQwRm6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjPFCrEB1SGmj5J5Ix6tTabj4drSc36AnHk3HRtrIsg=;
 b=WUlYEhRo3eJmnIolAhif+oIKDerGhxZWBBX8kBcDJJp4VaXzB3tcUzskl3AzytC5uD6Yjs/Ac9EbCxl96KlF71GUYNAURKW51qa08B8nmgFIr+FHB6s/dcFJ0dDjOC0/M7K1U8T7UrS+EP71Z8fewv+V2T6yBbcpFR0389riIl7UnffgMPs5hfLET++uXmTqYyPQe+52PYqlsoRGibeGAoxUPxZmqT8Dev2dKxbQeNhFMrRwniITmID2BGo3IqTg4QhSyhx83E0nMbatEwknA5GicpTX7Ftt5E3T8fs02c9jRmeUcxy/QvQnnXzvHxNsy87jg2zhib7Xk1REFUir8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjPFCrEB1SGmj5J5Ix6tTabj4drSc36AnHk3HRtrIsg=;
 b=dUu0nlXgMxEcknq+5p78Xm0UPyhpsbidoPjjHFFYNwPx+hQJqssqKTsmsF8nI2wtzQ3LZxJO69QNfIm/4ScBf0G4oRTp7cMkrv+MQfZQlI9hZOYZMtblUyBdqvmEXH+GUUm7KCJet/8rU2tAuv/Zi6qnbvYwJMBfY/8okzzFiepX/7AjDCEaa8r6da7rg+HH6NvFpjKg8GwtuHpr0q30BlM3qHdDgcoF4rONHhpXm7+UXcbKcQi/zeIFzUnzHpbuWPVwHPggTLl2UOH0XM1PyvMj9WovhKGEJ2ykySJ48SMSqo8KqAFuPSBDghj1E+Tbc5RGhs6AhiVasHRWMTQfHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by SJ0PR03MB6270.namprd03.prod.outlook.com (2603:10b6:a03:3ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 22:22:02 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:22:02 +0000
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
Subject: [RFC UKL 07/10] x86/signal: Adjust signal handler register values and return frame
Date:   Mon,  3 Oct 2022 18:21:30 -0400
Message-Id: <20221003222133.20948-8-aliraza@bu.edu>
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
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|SJ0PR03MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 94929797-b5d6-4e87-a4ac-08daa58db1aa
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSpd4QtLjnrXfe7PfRk3eMM/9PorsNWWJuH2cAoPmbVP/Mw1tRt6/cjzU42FAlIyhUP0Qb1Z5fvT6Yx+DbR11ypc/jJ9/hQyE9F3X4RIqNIMTpeRBJUynDoHg4y5ANq3FlDD8+Vnce/FrrTKhHbBuYSjnj3AQhZ2s0iCM/L/61wM7dO5ydCzsNXXWneczmfZGpMY8/3gxkWI2GdBClqtiM62Wkg5KDJbvXU5DnJw7J2BR7uUSh805mls9atf+1WNr5O+N75X6vh5aJDSqNMSaTe4qfqp/WY15adZ/GO7ZKhgaYr0/Tnd+4DFgUHvzdof6AqBtaDeDRDasXBfHbxarKsSCCxLCSvE8YiHkRNpPNFp9DI403+4fgIf+PcIanAUoA+Bx/Iy1h7cs2Bokl6YeH+VqL3CAwQdo+DzEQwrzyt+lAkX5AOC6bSkkVhCYsDDPF/2bxW6oaFO+bOBifGF7BJyS3hew81FgJjjj13ER82tWNy8dJAR6APwvpBr6FSovKmjA91K/80cHm92vBKGfAAwtcAnonyCw6sxpZMEyc6ulQkwwHF5G5fQqsfoBPe+cpLeLZtpZUKlj5E7R3eo3yrcEOaTjPtDq8oFFu3xaW+5PzeOZ5CPVedZ3EKekIipEr8FuCiPTsMnAWMDWJksifnwOFHktPTQkRadWIO3iM+UKan/PbYtVRgMBvE0KJQyY59HBLs324M/3CnTmJ5JkgtFpWS7VGc/GTgwMk3X8dZEyC1voZ/mp8xGezYRtf5soW5ZRKjiwgk8HggQs3qt9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(52116002)(186003)(41320700001)(38100700002)(38350700002)(8676002)(4326008)(66476007)(66556008)(316002)(786003)(6916009)(2906002)(7406005)(41300700001)(8936002)(5660300002)(7416002)(2616005)(1076003)(6486002)(478600001)(26005)(6512007)(6666004)(83380400001)(6506007)(66946007)(86362001)(36756003)(75432002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7mguedHQm3C0aa0NIYcVIo4ihqwwvd5ISDazngCK2quctDCgT23db9Cntoji?=
 =?us-ascii?Q?AbrJYtwco/zgnBWxRTFT4g+tNtEyvMmNWdlh4H1IgCAaEBtySs3MhV25MuoJ?=
 =?us-ascii?Q?kHKRlheQkiPhlAparE1NrllPVuPe4QDVuBh+Gi5WhDEJbxk0Uh6n4k+9b+d1?=
 =?us-ascii?Q?5gVz2fSQBJ04XTpiTerUOCWm5mlNdap8n8Vn9CsiMvEktR5ynNO6YJ0YkOMk?=
 =?us-ascii?Q?pS5eFq+GCLwuJjlqcKG6K1I9wVGZfMGFXKQ7grl0KS3Z2YvTEIaGq0GXOPdM?=
 =?us-ascii?Q?PhTeS5CAuikjTyyQav8piZ2HDX7OIqXeud790ujLRuWz3082jrYkgR1F23yl?=
 =?us-ascii?Q?hrB/p7R/D1sURI6Upgg8r1K2MbCjuDdbUlJrlM3H9xNGsx1NK42W6vxBUuJX?=
 =?us-ascii?Q?eZBrjOcsYcXWJt0UsEoJb6htjS+it5I1bx2a9Sr0DMYPAEWYSDcT1nXwaBsz?=
 =?us-ascii?Q?7iikBnGvBsQOEjcGqWeaExrTVG6k0muWSn42cyicZbGqQnhowHKAvJpn9VRX?=
 =?us-ascii?Q?4dt1Hvgu/iauqyrw+HvSIaVU09jMItNWS6W1MzKhX/JBjpEXtnTi7FDkAHFs?=
 =?us-ascii?Q?0mpxM3xXWv2oLsLO1/XdQeIRKK/p0U7PR7QNdS5brUUKcP+gFmmV8qJi01vX?=
 =?us-ascii?Q?q/YuWeWZbbcBNNbGpYCLDamz1uoPGYQ3899f1BkQLDRPVAFwyth+6/zkRDUw?=
 =?us-ascii?Q?e4ZfUx3wty97n6fg3pzfDGKJKvZ2v3hrF81f6soTrtral7QXWCWxkjurzEnU?=
 =?us-ascii?Q?1SwOR8f9TROh3Izw4BiuLiDePJ6lGCa5sVLc/eQosOIsND1dVTWSqdnqIXiH?=
 =?us-ascii?Q?7/nt23quK1EH409N8PBRl1mds7e/wnq6PqOuyBwdD5diIgG+vnFMIY5U16ri?=
 =?us-ascii?Q?DMOr31QLfOMuob3pwUugKGJjQCVWTjFWMwBn4yv24wrimWBo7YgqG6vJCP0z?=
 =?us-ascii?Q?Z4tdJmudba05CZZVp3Esqpy64bBi8AiqUTytlzI3mDqSvsrckMRJ5yKkLIBd?=
 =?us-ascii?Q?Qri0D2PdnFnCPuLz31BibHZWrI2cVW+LEdWRwWeOHJcZZKYXV3Ke56vCzf1f?=
 =?us-ascii?Q?SUEu5zHuyWvGZ0M+iBVvJZKlYCuHcD7LW2yxyGzFjdhnLiniaOCNQkvjvBai?=
 =?us-ascii?Q?5cOeIFLaqQob3AM+noz2BFsxw7eMgoPrDckILArik08wvyfFDC5gC3SmODpm?=
 =?us-ascii?Q?qE6FJdL6rRBm3DdciVz9bZ9Phk8C14KTodUwNKLw+J5ki/+WfwezLAWaT4Cv?=
 =?us-ascii?Q?6u0woFXVoSl8sB250STJy2ZiIuPgdpZByZpwn6aHI+j7P+Y96ItXss8Ke9SJ?=
 =?us-ascii?Q?MKdKjrIJjaXtceP1+B88VcvuKnFr35+VEiv6oDrMWN8lU2HJ6xOIpoq+w7OC?=
 =?us-ascii?Q?0syJRzm/JZfFZvJFBUOT+oPXs9HX3kwyhZ4y87aP4F0TyGjBkr6PmZP//poD?=
 =?us-ascii?Q?HM+r5bAVDqUCfATusBp6Z40D7pplzIxJa1BNFhxEeFobkiopyGZbgOmMReJ5?=
 =?us-ascii?Q?ZDY1buZgm1y4/wbch4U+Xc4oY+m7l53AAUdT1JlMufUWf8BCru+YULTrmAhI?=
 =?us-ascii?Q?YKGRF6zEkQf1hA4HhtNIzCs4abWtim8mL4LoK5sS?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 94929797-b5d6-4e87-a4ac-08daa58db1aa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:22:01.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUQ3oNim42MNhsplV4odpA95OswXRkC0rN47swyUyfgW4SdQbh9jg568lBtxPC2c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a UKL thread, returning to a signal handler is not done with iret or
sysret.  This means we need to adjust the way the return stack frame is
handled for these threads.  When constructing the signal frame, we leave
the previous frame in place because we will return to it from the signal
handler.  We also leave space for pushing eflags and the return address.
UKL threads will only use the __KERNEL_DS value in the ss register and 0xC3
in the cs register.

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

Co-developed-by: Eric B Munson <munsoner@bu.edu>
Signed-off-by: Eric B Munson <munsoner@bu.edu>
Co-developed-by: Ali Raza <aliraza@bu.edu>
Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 arch/x86/kernel/signal.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9c7265b524c7..a95c12f6dac6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -121,8 +121,10 @@ static bool restore_sigcontext(struct pt_regs *regs,
 #endif /* CONFIG_X86_64 */
 
 	/* Get CS/SS and force CPL3 */
-	regs->cs = sc.cs | 0x03;
-	regs->ss = sc.ss | 0x03;
+	if (!is_ukl_thread()) {
+		regs->cs = sc.cs | 0x03;
+		regs->ss = sc.ss | 0x03;
+	}
 
 	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
 	/* disable syscall checks */
@@ -522,10 +524,15 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	 * a trampoline.)  So we do our best: if the old SS was valid,
 	 * we keep it.  Otherwise we replace it.
 	 */
-	regs->cs = __USER_CS;
+	if (!is_ukl_thread()) {
+		regs->cs = __USER_CS;
 
-	if (unlikely(regs->ss != __USER_DS))
-		force_valid_ss(regs);
+		if (unlikely(regs->ss != __USER_DS))
+			force_valid_ss(regs);
+	} else {
+		regs->cs = 0xC3;
+		regs->ss = __KERNEL_DS;
+	}
 
 	return 0;
 
@@ -662,7 +669,10 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	sigset_t set;
 	unsigned long uc_flags;
 
-	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (is_ukl_thread())
+		frame = (struct rt_sigframe __user *)(regs->sp + sizeof(long));
+	else
+		frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
-- 
2.21.3

