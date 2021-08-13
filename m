Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA13EBAC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhHMRBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:01:20 -0400
Received: from mail-bn1nam07on2082.outbound.protection.outlook.com ([40.107.212.82]:62205
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232969AbhHMRBQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:01:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+GQEW84pYzlWZkt5TGT6BajDi44dxIFVur0j7kpaMW7J4ydgnQzsrPege685DXzTgb1YoTvkQYX/DLN+6dfw0hr/ppdI9eUSwer5tc11ZiifcPIfJX5Qn3GeXk5/LzNrzrt5svTZu15j2lX3nM9uBYmZkmB/N6AWd72oZ567IaM+7Rk1tSllPmAlCxWCL9FSw8/aR+jni1J1FIx8OQVJ8uaPNwgnyqJHagLo/Q3HJtVypeNLi4Y+gln988DB7s9cq8aR1hv1ygYBGfwCxZ8+annHVe8U6klf9TofnBQEx021If1g4MyleuxbXqZ/F8juw87BdGaj+z8gzhee4Ctzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxQwjbCDOmZPUdDVU8qcPUZnXp0Y4tgFBdlcjBGS8Fw=;
 b=AoTqvqV8k1ik8mgDUE4HfZM6kjcfNh5JgCKVyuTg4BedsZJH2mttz2gZEh/eKqt7eCmx97fLYW/Zprb3urHpUXv2uZRyMK1EMcAAVW0KPHQHbu5FVQ6a9b/1RXiQ5UzSN2ooxsOWIVp6B7cLaPqWoQVs53PrHLKbL+2hB6Z1z1Sf1HNMY9Z66gSPdADDA8WTib57m3zz8lsr9gZWdCjO0EP/RRSKKoYygpL+MSUV3xeE4GqsicB4/PbNL1tm8Ft2uD15k83ih4XHZHOnMCRfOsM4el93y3u3U1sPNK0bCNC6KJpPoB/Ogu6lj1/hC5yYCBIlETl9xttvN1je7d8ZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxQwjbCDOmZPUdDVU8qcPUZnXp0Y4tgFBdlcjBGS8Fw=;
 b=YpspKJG2ulW2xhf7W0j3kDtwdjXIb68/aeQcmKACPQIm4JDBwQFMC6UtgQ5Lk6rvsXQBF58gHCQt9asa18z56bltDgBFiFXMZ/EN5go61iLGJLhBlJ0i6v4+YNB4ui5GzGazJJ+bgf8Tdt+iZW+rjDZLyhJqXjGA/7DlqZaf45s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 17:00:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:00:47 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 07/12] x86/sev: Replace occurrences of sev_es_active() with prot_guest_has()
Date:   Fri, 13 Aug 2021 11:59:26 -0500
Message-Id: <0b8480d93b5090fcc34cf5d5035d4d89aa765d79.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:806:22::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0040.namprd13.prod.outlook.com (2603:10b6:806:22::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend Transport; Fri, 13 Aug 2021 17:00:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11ba6adf-8653-42e6-4d33-08d95e7be537
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5341B4FAC130EB1E70EC96F7ECFA9@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCrJFva1dfjLBMcm9Cd87ldLHocutxUrMU9yGDJlei9CzMXT7KBNFWCLDseUOoF+0FaroulvuDGFT0ZiK2I+VN0lMWcrSwqLRuEb0NtW5zPfphcsZ6MKS2Uopj7gGuSJbCDvYzJMBi7JVwI5qQXqMriRHL6azkXkzYRbynawIl/yrgq4hcOyJsVtbWzsnpuKWZPM7o6VlSjp8DX7u6+ZHTzf2+MYOJzj4YD/FDGV0/viw0XnqtwH9/OmafZKM0nMqM2/WS3eOHfm5S9mzsJPojqNE5Y35iwOPwQI/5Iww+LvGGW8UU+VFVobnjDcSjGbgQCrDvQ3ANTIyG5SovWkH/0PvKQiprABptNm3YRrz2/ISbUi7ZPJ4Jz0W7bfyodWQPkqs0vvbZ880J4lrzZu8k2keArJaGe/ZTUvcEGHidfqbo/rpPYR1WtZnQoyD3AznDFc5Ab4gQoZSUxwORni/UypcBcetNlsIvyRFxncKgZAOCpI1Gyk6+GUWvfo+AcF9zHful3DH3wNwn1zSauravnkYph71Ni3gcE+kJEFHxoQEziGLAIOy0IbxEbKcqi0t3NLw2lywWwBubhNoHxxVKJ37VvZW9KSBfKI2QLV43d0BDZa0zO3Rrg8OXVByFrx5zNYvW9LQmdEGQfBnFt6N/loGHfu1FyY+MjFOVuEIuYEZwlPFiePKFJX2BM/ZsFK3RfZuBTY8xDzrXRpy2mpzmRqFZzIrdU62yVS0vgx1Uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(86362001)(8676002)(2616005)(5660300002)(6666004)(54906003)(36756003)(38100700002)(7696005)(38350700002)(921005)(52116002)(8936002)(2906002)(478600001)(83380400001)(4326008)(186003)(6486002)(7416002)(26005)(956004)(66476007)(66556008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+z6sArCNkmvuq1B8GmeZZr94DJ+LJ41tbhZAERdadQxupH31EuD4Qw0NcxM?=
 =?us-ascii?Q?f41uuLLRNdm23pC9twbl0FzDQkM/52zSJ89gHE8DwsvNtLhKMtNciBRJDpIp?=
 =?us-ascii?Q?OhnZqr/Ja15XUJIq3624p/s1V8T0tddBKPpEpngANdYpQQPhD0VLO/62pohC?=
 =?us-ascii?Q?59ONDapb/AZ+2c3dlehrt6XhT3gzGxUG2GteUrXPEn4u5y5rXa+w36Y256AJ?=
 =?us-ascii?Q?RHWkWwv1XgF5cS0J6ZyB3l+EW7bTUEj+XT4MfUQiAyQciSglMNmNrFgOk4YN?=
 =?us-ascii?Q?/2I12b+fX1YGeqa0tDTgZ3P4rJ4wb3TXJDrWZSc9EL/P+3mi+ByEOf0qJvZh?=
 =?us-ascii?Q?mG9TWSULY8J34qV5bE8mjmQd1eyndvnhAsnZTm8v8J4Ds6EML1t7/bXyAAit?=
 =?us-ascii?Q?qJLqlYm3awE736BFgDEMFtIXtwnuzGGantMx2kFUIrNvAVXUXSgvj/4huUT4?=
 =?us-ascii?Q?SAcnE/1eu0U8FrGWn+mpvPBkwY2puaB6E986aBBWVQuC3J+M6hDPar9ooEcR?=
 =?us-ascii?Q?vvy70Lw2nTbCmtLO8HBGLepNnxH/B48rQb8QrpiWmNiXD1ic1Nw1x2ACqRK7?=
 =?us-ascii?Q?FRDQ+2e0R4xMm7sh8iJiFC0MfstsV3HGiOXVGG7fL6gdDifXsuQw6FhfLGlJ?=
 =?us-ascii?Q?DsyexsRW9GLfs8DfqLWGppeuXeoCUPUecZLPbVbi0NG1i3FavxBR1mdia+i0?=
 =?us-ascii?Q?XerePxdjkpGHQF3P7NIc61l4DWOIr721x48FKj0v87g7jua+1xbgNCyg4ZFj?=
 =?us-ascii?Q?2cSr8TN0ANymsH3c3QkPKtxsFHm2I3cPKozsSKkSjRiR9qc+P9Q+X9LjyIMe?=
 =?us-ascii?Q?hKy63Ag/oQ9vvLP+Js5Mo4aQ2TEMWHBIAvu4NPxutF3mNv0bPcDntnH35VPx?=
 =?us-ascii?Q?rSlacgeuT0jW5C3VbrG2IxC6KvnQy9Hpt+fVQMreeXPv1mdtHPxFZ6Z3yQe9?=
 =?us-ascii?Q?a+YDcRsKFqbW88JoJSTAWpqK7CBoiDR54/dQlc2v05AxwzI73vfjrV8FB1Ec?=
 =?us-ascii?Q?m+qrKTOmpvQR9CNh0IWA2giXvA63MPXwDuqgqQEhklvMFx+NhBiQyjeanfga?=
 =?us-ascii?Q?exOFuRbrKKhWbVuyH6xTJaFu8wWeeOwiuHNkZVay19cu3YQVLBIMtH5DoiBk?=
 =?us-ascii?Q?AjFL1mSJfqqr2Ng7/0cs9FRfpqYv0xFikyABEyD0SI59C0QghH104z4hQR4b?=
 =?us-ascii?Q?UR6jWGQH+ZiP/O/EQrU/JaLoDW2EmEm7NUKKERadZEOGypnGwd3gzVtFa6A7?=
 =?us-ascii?Q?aycki5k+fzoMKbF7b+WMV1WHpgWsDlVCCAYszgtlnF+gQKm7o9U6yFL57028?=
 =?us-ascii?Q?PIrKe9pikYs1HYTcBZXNYy7h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ba6adf-8653-42e6-4d33-08d95e7be537
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:00:47.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNF5CDhDN7Y+Sj5vN0RvJOmG7fDWjeYVucQO7vg8NlZeRenoV0bfdWtVZsmtXeCxON9n5suSvwdSdnc9Tsrhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace occurrences of sev_es_active() with the more generic
prot_guest_has() using PATTR_GUEST_PROT_STATE, except for in
arch/x86/kernel/sev*.c and arch/x86/mm/mem_encrypt*.c where PATTR_SEV_ES
will be used. If future support is added for other memory encyrption
techonologies, the use of PATTR_GUEST_PROT_STATE can be updated, as
required, to specifically use PATTR_SEV_ES.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h | 2 --
 arch/x86/kernel/sev.c              | 6 +++---
 arch/x86/mm/mem_encrypt.c          | 7 +++----
 arch/x86/realmode/init.c           | 3 +--
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 7e25de37c148..797146e0cd6b 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_es_active(void);
 bool amd_prot_guest_has(unsigned int attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -74,7 +73,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_es_active(void) { return false; }
 static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
 
 static inline int __init
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..66a4ab9d95d7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -11,7 +11,7 @@
 
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/printk.h>
 #include <linux/mm_types.h>
 #include <linux/set_memory.h>
@@ -615,7 +615,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	int cpu;
 	u64 pfn;
 
-	if (!sev_es_active())
+	if (!prot_guest_has(PATTR_SEV_ES))
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
@@ -774,7 +774,7 @@ void __init sev_es_init_vc_handling(void)
 
 	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
 
-	if (!sev_es_active())
+	if (!prot_guest_has(PATTR_SEV_ES))
 		return;
 
 	if (!sev_es_check_cpu_features())
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 83bc928f529e..38dfa84b77a1 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -383,8 +383,7 @@ static bool sme_active(void)
 	return sme_me_mask && !sev_active();
 }
 
-/* Needs to be called from non-instrumentable code */
-bool noinstr sev_es_active(void)
+static bool sev_es_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
@@ -482,7 +481,7 @@ static void print_mem_encrypt_feature_info(void)
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
-	if (sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV_ES))
 		pr_cont(" SEV-ES");
 
 	pr_cont("\n");
@@ -501,7 +500,7 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (amd_prot_guest_has(PATTR_SEV) && !sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV) && !amd_prot_guest_has(PATTR_SEV_ES))
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 2109ae569c67..7711d0071f41 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -2,7 +2,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
 #include <linux/protected_guest.h>
 #include <linux/pgtable.h>
 
@@ -48,7 +47,7 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
 	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
-	if (sev_es_active()) {
+	if (prot_guest_has(PATTR_GUEST_PROT_STATE)) {
 		/*
 		 * Skip the call to verify_cpu() in secondary_startup_64 as it
 		 * will cause #VC exceptions when the AP can't handle them yet.
-- 
2.32.0

