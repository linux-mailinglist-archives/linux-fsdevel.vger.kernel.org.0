Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616755F38E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJCWWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJCWWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F361550A8;
        Mon,  3 Oct 2022 15:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvWC7dP+nAyz/Tur0QvGr9zBQxLung8farDkz9PpqwQBxhrr4Soqq5i18Z5mgYnj/1z+Ej9HiM8pQKpvMcijbi+QYm7nzM7xiOIQ3pIqstLsbJnfec/uFdY3twJ6vkZpPjKg7BaiU7RYPUWxQStaHQGgML9ByoyoPuwx0RK1laS8WlSHwB6CO777uzZmXFyRwTq0nE6MpFk7DmkxXLJq+No49DDI5hgCiOAlL/HBQ3cX4mHTVhtDmxo/DE/zAZMrB9J7Oc3ZofRhkavL2CwGXvdGXRjzaHW+oQYNBXBEouUKjfdA60Iv1oomUMwELa+RMficC61Bno36qo4lMJ923w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaq7NPEdmF6sLDvhdoNRQ7kvkb7UJg1hsFjyRbdXRlc=;
 b=T0K/XUuj8MfHtuq8eHoUtAwv5kXwpsfWzYiuGOy69hvuTZDhSOUYAf4635q7N9MAMp/F6QZnbqnVFP1xcW7fkq9SAig8eLpUkCrpr2PHFAf15ilJm8HLd26hUXsT84Y7PAGUS64h1rjRk2OhSJHYfoVfDtbVQSDn+esa2bPAkv3DOyG49yFdLLd6+dE+214LFw7c4TbGSy9QlsRfOHnKYkGdhLuz5RlHb48fXptGAxkWmllnnVgb+1mimVtIbPH6rwxSkPK/z4MdWOAL/gBXEUuckZvIKT8AXzHmRdyX2jP0EmxElpG+0rNwlynGfHlxS9TaQHlj6iplReosXECZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaq7NPEdmF6sLDvhdoNRQ7kvkb7UJg1hsFjyRbdXRlc=;
 b=PEr3BSinX07KUs1LnIyoUQm+izp5N/7swMN9v5j/fWdOOwulg9bTmN5v8qWGylFVDy8GjRsqbur+ldEm3vGwtzx+9ciK/0gqIiTV195Bp6HwOBi5zGfsYtoidojidQwbIklfndzr88t0BkeeZAvjceTAh5nmebBSnJN6E5V82SPP0vV7Z2uwbrl9lPIM5nTUqK85z22MTAbhFaplQu+kNulaDrYUZlPenrJYDCK4/974W59OhNDIcjRwHK/BHGo+G9C9jRaGZ/xKgSNZJiiKb0WNocxGxN2aeaiosVcN/2P8XCHWUOtvXsQg4iE5uLpWYOWcNmItviuYhsVy9QawGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by SJ0PR03MB6270.namprd03.prod.outlook.com (2603:10b6:a03:3ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 22:22:03 +0000
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
Subject: [RFC UKL 08/10] exec: Make exec path for starting UKL application
Date:   Mon,  3 Oct 2022 18:21:31 -0400
Message-Id: <20221003222133.20948-9-aliraza@bu.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 89f3e219-0efe-4349-9aba-08daa58db245
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgkXhGH2TTBnkNVk3OscN+0gupR9Ul1vdv4Y+Q1Nod6jNGQxGj+1LnnvzpxU58W9TshqWcWZ+9+Ddy7xu19ZTGsQILwx6trRkJB3b3QrgKLfY5q6aHsQNduVT7MfEmp7ZVUT3fKDgK/fIge1Uj3ZvutUh5txf5j733+kqNVJT1HognLDTgVUHgyIERLdK/FqRBciqAIQC+ox7dW9nDTQ685RC9L48ipYuoBOMBsF/huKdyodoAReHqMeEZbhB7538dJQDiLRj6wVf6iYf47ZPucqShWUMn1K6tzCHIwM8Of78QVYPbvDzzetqIf/ngtAn86IIKRYCU8MuAOInbiaYTU7y3jxmVTfZGWGI5B9AI9wTznul2PRDVoGgWzxg5J7S0JKUzAIyAiR3CuLQlMVaCtbwVZF13/+BaBuR4G1rpjdiahaPAZXnsvG524V9dYXdoAaEYB+x2+AAZpAJxaui853L8NwcTs9m9h7BphltDWXwybALThElcIAKPOZdWe9DJzvsSZf6LTD2FV1u0SNa9u0dWx7rULKf9FCFyBY+1LCbMbxu55tbfd+Z+6hantAdLq8zb1FcmQkyVtG7jpgWjjY6aJIFU3iv8m/jN+g3xoqbEZnIqhvMjC38jEUksqAD2rAMUAt3ztnunjSp1igAUpmQgbcX7z2xEZMl4yTUf/HRjdlL0pTxjgTcL6Ukr0WDzsqKWdmCQvSMgQLSaXOzhoE1Z1vTBXWuC6P89NXn1I4P826pmQml1Hzqf3Qzj23RBtiyATmJGqA9obHJY5DjvuCBcZWMY6iZ1LBfcMRcmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(52116002)(186003)(41320700001)(38100700002)(38350700002)(8676002)(4326008)(66476007)(66556008)(316002)(786003)(6916009)(2906002)(7406005)(41300700001)(8936002)(5660300002)(7416002)(2616005)(1076003)(6486002)(478600001)(26005)(6512007)(6666004)(83380400001)(6506007)(66946007)(86362001)(36756003)(75432002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SoyTFAUWmyBX8nLOyZk8fOluaidxwziaalGQmGJ3nADrYqDl6I3MJtcojpht?=
 =?us-ascii?Q?ZwIMUvkeN9wD4M181BEOw4OGYCw+e6YCdDBp7+IsfcZdgEBTiYDEjxHOoHNX?=
 =?us-ascii?Q?ebnyX7vAHWIHkH2n2rwLx8ZK6jKKs63BoxGPBhyGSevPGH3JH9oTexldsBTc?=
 =?us-ascii?Q?Qm+hm9KVYparlbTPMh19590U5EcoGF/qpRrJw3xYHJfhfwy+62qusqT5iURv?=
 =?us-ascii?Q?uhBBq46KPt2HbV6za9XLIM14ZWhGqrA0TAmLmNFtXsSgG2Sncr7T8cB4t+R2?=
 =?us-ascii?Q?ubIknggG6gKVoum+P4EUyCQaYTIRX42B8TuxesL+/QE77tAUMLOAqus4hMii?=
 =?us-ascii?Q?JZgqkxyZuBxK1whuGbeZvBnJDraGkD2Ioueg2FWgpRoMAIuqf4TBwb4GK4Z7?=
 =?us-ascii?Q?VYXTqIDX9rGabOWNDHAhznoNcQFB78lg1k6i2rP8ZmukvHWikUqYcL6JD5LZ?=
 =?us-ascii?Q?yIJhFftI8FWy5WaXxBxS88UCDathzUJl5oJ6IBSUR1CZOcU0dQ88AZkMN/Ew?=
 =?us-ascii?Q?fNyG9Y7uAkHw+NLc2c7XwwDHkcYUGjaYyHZTUuv3CzM2G+nqr5Zpn7siyIBL?=
 =?us-ascii?Q?xBfWXRLkob+j8dj5EO3rMdR0RMcsW9hBJ729hHU6R+a48f6eyamfnuSSOeMf?=
 =?us-ascii?Q?fj0DehXJqgxxcDqvdJlPEXdf+wR0MT/4fI61ymW1vbcpfz7dJdDuLzB+nR6g?=
 =?us-ascii?Q?uKtoqfaYbVFOg43gciLIPMqTMLVdReax1ivSXgl9gI4E577G5kn4/q8p/u5m?=
 =?us-ascii?Q?QwXsx56IuaZN8GmBeNKVZx9+iaqnOxc/oEaxlj1eZrD9fnD3URZNAWQSt9XK?=
 =?us-ascii?Q?kN8btPHRofVC5/1J8NM5xtUTts6EAPoIs9ypIBHrextaoOqDszSykhagFLjn?=
 =?us-ascii?Q?UP8nNXoMNoketFmoo/DGhXALnchmAHJxKobpKVRrvJD9TcZZ3Urn5X7RjaD3?=
 =?us-ascii?Q?6ktbIAp/3gd8MgZpgRN+1hPp31JfXygfk5X6RnJ6M196ZbEsYdeDabj1wiln?=
 =?us-ascii?Q?AuVsuDMvBBrt21oAZ51PHSmb4kkeabp5Rxg6GicXBkXHquM3wRlz4J/BRI3m?=
 =?us-ascii?Q?qZ/a6h2lF+ZbqBQpDTQMMvENM09Ze0geEUw/7GhmDzr1tPOXOKtF9NMLKtq/?=
 =?us-ascii?Q?Wb5DBoZuzsG67y4SZkxPt+zMhNKBtk7tXAj++ppcjiXbdpWvPUphHUAzphUp?=
 =?us-ascii?Q?3mCS0Dvi0MSH2whh5QdY73dzQtSAjTTFPL6VyvITfAXY8UyM+YczFX4SMKVL?=
 =?us-ascii?Q?CCbQTittpgu+4pIs2lV65dkIvQaKL86yRiAGQkO/BoyrqmmGMCr1jMUn3Xt+?=
 =?us-ascii?Q?JP59VYJMiiNWzuxDN73FksK09lIbA5ZbLNOOQz4rxW9In66FhSQszX6cAb6s?=
 =?us-ascii?Q?+tg8xh+5lsaZrwNfqKSh9JMfWdavciV65UwAqJHkFNCtmbqeZ58sq05CPF0o?=
 =?us-ascii?Q?/h36flxTDaXHWVNGP5pIOqVaHe6ecM5gJWl12Ljz1jTOC4lk7mCOVt/Monfx?=
 =?us-ascii?Q?jfbeH5TK9BpV1JzVbIT9qwijalJJuarjfaA45UOtx6g4Kj1/tYjsYDM62eCN?=
 =?us-ascii?Q?+/EdDIeoBho9tvunJyE4vK0Ie5O3Rb6he6RS/lYU?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f3e219-0efe-4349-9aba-08daa58db245
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:22:02.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJv+t/rrDRpzdFQGYgw42fDv2c0LLZCoCrpgDlpqQtrKLJfU1RwslyRN+jLdaBFQ
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

The UKL application still relies on much of the setup done to start a
standard user space process, so we still need to use much of that path.
There are several areas that the UKL application doesn't need or want so we
bypass them in the case of UKL. These are: ELF loading, because it is part
of the kernel image; and segments register value initialization.  We need
to record a starting location for the application heap, this normally is
the end of the ELF binary, once loaded. We choose an arbitrary low address
because there is no binary to load. We also hardcode the entry point for
the application to ukl__start which is the entry point for glibc plus the
'ukl_' prefix.

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

Suggested-by: Thomas Unger <tommyu@bu.edu>
Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 arch/x86/include/asm/elf.h   |  9 ++++--
 arch/x86/kernel/process.c    | 13 +++++++++
 arch/x86/kernel/process_64.c | 27 ++++++++++--------
 fs/binfmt_elf.c              | 28 ++++++++++++++++++
 fs/exec.c                    | 55 ++++++++++++++++++++++++++----------
 5 files changed, 103 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index cb0ff1055ab1..91b6efafb46f 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -6,6 +6,7 @@
  * ELF register definitions..
  */
 #include <linux/thread_info.h>
+#include <linux/sched.h>
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
@@ -164,9 +165,11 @@ static inline void elf_common_init(struct thread_struct *t,
 	regs->si = regs->di = regs->bp = 0;
 	regs->r8 = regs->r9 = regs->r10 = regs->r11 = 0;
 	regs->r12 = regs->r13 = regs->r14 = regs->r15 = 0;
-	t->fsbase = t->gsbase = 0;
-	t->fsindex = t->gsindex = 0;
-	t->ds = t->es = ds;
+	if (!is_ukl_thread()) {
+		t->fsbase = t->gsbase = 0;
+		t->fsindex = t->gsindex = 0;
+		t->ds = t->es = ds;
+	}
 }
 
 #define ELF_PLAT_INIT(_r, load_addr)			\
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58a6ea472db9..8395fc0c3398 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -192,6 +192,19 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->bx = 0;
 	*childregs = *current_pt_regs();
 	childregs->ax = 0;
+
+#ifdef CONFIG_UNIKERNEL_LINUX
+	/*
+	 * UKL leaves return address and flags on user stack. This works
+	 * fine for clone (i.e., VM shared) but not for 'fork' style
+	 * clone (i.e., VM not shared). This is where we clean those extra
+	 * elements from user stack.
+	 */
+	if (is_ukl_thread() & !(clone_flags & CLONE_VM)) {
+		childregs->sp += 2*(sizeof(long));
+	}
+#endif
+
 	if (sp)
 		childregs->sp = sp;
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e9e4a2946452..cf007b95d684 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -530,21 +530,26 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 {
 	WARN_ON_ONCE(regs != current_pt_regs());
 
-	if (static_cpu_has(X86_BUG_NULL_SEG)) {
-		/* Loading zero below won't clear the base. */
-		loadsegment(fs, __USER_DS);
-		load_gs_index(__USER_DS);
-	}
+	if (!is_ukl_thread()) {
+		if (static_cpu_has(X86_BUG_NULL_SEG)) {
+			/* Loading zero below won't clear the base. */
+			loadsegment(fs, __USER_DS);
+			load_gs_index(__USER_DS);
+		}
 
-	loadsegment(fs, 0);
-	loadsegment(es, _ds);
-	loadsegment(ds, _ds);
-	load_gs_index(0);
+		loadsegment(fs, 0);
+		loadsegment(es, _ds);
+		loadsegment(ds, _ds);
+		load_gs_index(0);
 
+		regs->cs		= _cs;
+		regs->ss		= _ss;
+	} else {
+		regs->cs		= __KERNEL_CS;
+		regs->ss		= __KERNEL_DS;
+	}
 	regs->ip		= new_ip;
 	regs->sp		= new_sp;
-	regs->cs		= _cs;
-	regs->ss		= _ss;
 	regs->flags		= X86_EFLAGS_IF;
 }
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 63c7ebb0da89..1c91f1179398 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -845,6 +845,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct pt_regs *regs;
 
 	retval = -ENOEXEC;
+
+	if (is_ukl_thread())
+		goto UKL_SKIP_READING_ELF;
+
 	/* First of all, some simple consistency checks */
 	if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
 		goto out;
@@ -998,6 +1002,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval)
 		goto out_free_dentry;
 
+UKL_SKIP_READING_ELF:
 	/* Flush all traces of the currently running executable */
 	retval = begin_new_exec(bprm);
 	if (retval)
@@ -1029,6 +1034,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data = 0;
 	end_data = 0;
 
+	if (is_ukl_thread()) {
+		/*
+		 * load_bias needs to ensure that we push the heap start
+		 * past the end of the executable, but in this case, it is
+		 * already mapped with the kernel text.  So we select an
+		 * address that is "high enough"
+		 */
+		load_bias = 0x405000;
+		goto UKL_SKIP_LOADING_ELF;
+	}
+
 	/* Now we do a little grungy work by mmapping the ELF image into
 	   the correct location in memory. */
 	for(i = 0, elf_ppnt = elf_phdata;
@@ -1224,6 +1240,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 	}
 
+UKL_SKIP_LOADING_ELF:
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
 	elf_bss += load_bias;
@@ -1246,6 +1263,16 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_dentry;
 	}
 
+	if (is_ukl_thread()) {
+		/*
+		 * We know that this symbol exists and that it is the entry
+		 * point for the linked application.
+		 */
+		extern void ukl__start(void);
+		elf_entry = (unsigned long) ukl__start;
+		goto UKL_SKIP_FINDING_ELF_ENTRY;
+	}
+
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
 					    interpreter,
@@ -1283,6 +1310,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
+UKL_SKIP_FINDING_ELF_ENTRY:
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
 	if (retval < 0)
diff --git a/fs/exec.c b/fs/exec.c
index d046dbb9cbd0..4ae06fcf7436 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1246,9 +1246,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	int retval;
 
 	/* Once we are committed compute the creds */
-	retval = bprm_creds_from_file(bprm);
-	if (retval)
-		return retval;
+	if (!is_ukl_thread()) {
+		retval = bprm_creds_from_file(bprm);
+		if (retval)
+			return retval;
+	}
 
 	/*
 	 * Ensure all future errors are fatal.
@@ -1282,9 +1284,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 		goto out;
 
 	/* If the binary is not readable then enforce mm->dumpable=0 */
-	would_dump(bprm, bprm->file);
-	if (bprm->have_execfd)
-		would_dump(bprm, bprm->executable);
+	if (!is_ukl_thread()) {
+		would_dump(bprm, bprm->file);
+		if (bprm->have_execfd)
+			would_dump(bprm, bprm->executable);
+	}
 
 	/*
 	 * Release all of the old mmap stuff
@@ -1509,6 +1513,11 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 	if (!bprm)
 		goto out;
 
+	if (is_ukl_thread()) {
+		bprm->filename = "UKL";
+		goto out_ukl;
+	}
+
 	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
@@ -1522,6 +1531,8 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 
 		bprm->filename = bprm->fdpath;
 	}
+
+out_ukl:
 	bprm->interp = bprm->filename;
 
 	retval = bprm_mm_init(bprm);
@@ -1708,6 +1719,15 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	struct linux_binfmt *fmt;
 	int retval;
 
+	if (is_ukl_thread()) {
+		list_for_each_entry(fmt, &formats, lh) {
+			retval = fmt->load_binary(bprm);
+			if (retval == 0)
+				return retval;
+		}
+		goto out_ukl;
+	}
+
 	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		return retval;
@@ -1717,7 +1737,7 @@ static int search_binary_handler(struct linux_binprm *bprm)
 		return retval;
 
 	retval = -ENOENT;
- retry:
+retry:
 	read_lock(&binfmt_lock);
 	list_for_each_entry(fmt, &formats, lh) {
 		if (!try_module_get(fmt->module))
@@ -1745,6 +1765,7 @@ static int search_binary_handler(struct linux_binprm *bprm)
 		goto retry;
 	}
 
+out_ukl:
 	return retval;
 }
 
@@ -1799,7 +1820,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 static int bprm_execve(struct linux_binprm *bprm,
 		       int fd, struct filename *filename, int flags)
 {
-	struct file *file;
+	struct file *file = NULL;
 	int retval;
 
 	retval = prepare_bprm_creds(bprm);
@@ -1809,10 +1830,12 @@ static int bprm_execve(struct linux_binprm *bprm,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	file = do_open_execat(fd, filename, flags);
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		goto out_unmark;
+	if (!is_ukl_thread()) {
+		file = do_open_execat(fd, filename, flags);
+		retval = PTR_ERR(file);
+		if (IS_ERR(file))
+			goto out_unmark;
+	}
 
 	sched_exec();
 
@@ -1830,9 +1853,11 @@ static int bprm_execve(struct linux_binprm *bprm,
 		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
 
 	/* Set the unchanging part of bprm->cred */
-	retval = security_bprm_creds_for_exec(bprm);
-	if (retval)
-		goto out;
+	if (!is_ukl_thread()) {
+		retval = security_bprm_creds_for_exec(bprm);
+		if (retval)
+			goto out;
+	}
 
 	retval = exec_binprm(bprm);
 	if (retval < 0)
-- 
2.21.3

