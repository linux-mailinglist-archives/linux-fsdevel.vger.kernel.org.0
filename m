Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1553EBA88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhHMRA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:00:27 -0400
Received: from mail-bn1nam07on2069.outbound.protection.outlook.com ([40.107.212.69]:7591
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229841AbhHMRAZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flWRAT8fnukugsURVuo2WbUPXpwDWendO4ukKnsHjcWpY8A9QAkJJtY4iJlPI4VIu/lZFacuI+WkdLT6dZu3xY1JjormMK2Rc6mtKzDMsbcjYnsYwzX9YomVVEOfL4y9ZD/jTY3Nt8NLk0m6BFUwqZsTIIZWj2YSfs2yIzQMa35NBHUMILWxp1ht3p2xNnJb/ClcXI17wQBfJKkqXwcLCeK5pl9pfewySUXhDwUh4eXwuZ1K9GDPPrm3Y7qRZv591Uhc5m7Ba2/9ncXCPqLzsvYTT5/9YbZ4Fwo8JOA+kbnD8BKIw5Le+RahuCG9PdRBG266pmDVgQ1uYbFqYp1Ycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TejLyUpzQ6IZ/s6ownAXRi5rr4cs8ph09jrUknc3bNM=;
 b=Eovxw3Y1p+BqOOOMzTrBcsS8nGtmdw1qL+1IztB2B/R/VIbuJ98vbgr6IylGs/x4/EvHg+LjB6YrEy4O+y+sXLQaZqJCGusM+EC0cvUm2JzGSQVA1sC4xRUWn/b7KG+naKYGg3OW2jssnO+5uK8cJKbX5uQytTCgddrHO/rksHd4bjuh6d5WvzpBNVsMwfMO84YN2bbDKBW7Q23reZsIutlYtke0gqnRrva5pFwFICfS763h46golsioraO6ifVeOy0tjwr0loHSndm0kyB5tL6CY2375GqdU7dB8knkxs1hxG4pN0UuRww+kZGVRywbplKEEPcs9Vmu+o/BkgliKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TejLyUpzQ6IZ/s6ownAXRi5rr4cs8ph09jrUknc3bNM=;
 b=RglP/G+LcNi0YHCOgvnduuygjDSeuu5hRUB1mj+L8bcopCm1WpI7qqP7ozBGf+uq7jzlMVSm9A+Xlb7PHwLu3Ll5A+MD3q+tbFSlB+J8zjK7MXlj1+K9AFj8QL7GmvzEZc453JqFvTIX1MsYH6Hjm5RSre3Ctc5HTHF53Jf5xdo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 16:59:56 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 16:59:56 +0000
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
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 01/12] x86/ioremap: Selectively build arch override encryption functions
Date:   Fri, 13 Aug 2021 11:59:20 -0500
Message-Id: <a4338245609a6be63b162e3516d3f6614db782a4.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0017.namprd08.prod.outlook.com
 (2603:10b6:803:29::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN4PR0801CA0017.namprd08.prod.outlook.com (2603:10b6:803:29::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 16:59:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6594ab2-8c4e-4483-e4aa-08d95e7bc6dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB551841987EBF0DFFF8EFF5DEECFA9@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKOeCVWLQxbtanGHAmPBV5sIWlHP6OHhnoq0XBmHo4/PdrH+PBsrxVWM8o+3rzk1sR5fAwf95B7niVB3W6Da7+OznKMOyazCckXkvRWDOROkp6zOjl8c5mPJDv/dfjsJtzhyjAM3ATVuO3SgBEhm1AdVIFwAzIUDFNfhcfFWM96SNgvwnfpxWdMYZW6EwB4pxilBREjEQ0jMxl63zGOORpRONthh+EeVY+P0GGg88spXGiOFBnynfNClUNSwZlseoUIcOK5UbhoSE4ywgwRCTQqVrf8Xsafx3wZCKrqxOKUjzeWxdIAEKA/8YD6+7M6T0t879L/Zbrw/LN/brqbevnWTCWx0YxWKBGgjcPUNYYRHT/10KgVVQ5/11BXqtdFF5oTUTBBZsbK6WgAOrVyP/q8RwVtf5VKPcvf5Py27MBtLGONaBQzluTg+ARisiatIsqtp05pVWqhDSLaCNGg+VRmHgEDTn5qGNAKcz0bIO1+BalckIrpSuFOnq7+++aa0LNYhPTD+qWImYxAYABjhAuHl23BcHJnvupXYsw6M4uYJspzk6jLqRCutLVyC3ORNrLz9yFbdjIS3UHj47EirHndCrA86QG3I986GwpLCOz3bgu4lIZivsBxPe+3puEW3QMm11I92+rtG6aiQx9fqclmJecVEI1umO63c4JuFqe5l+kmxY7hY/+NH5/KpB7I0PUFYg+XoSMSEsKNExmovfrL6O0kD94ucZxt3mEIlxF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(66946007)(66476007)(66556008)(478600001)(921005)(7696005)(8936002)(8676002)(26005)(52116002)(6666004)(36756003)(186003)(86362001)(2906002)(7416002)(83380400001)(2616005)(38100700002)(956004)(38350700002)(5660300002)(4326008)(6486002)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2uuyrFNe794i9ZdcxzXMnabqnIA3Q49tsutonfhvqTHsXiHHXoPOvBVfkxh?=
 =?us-ascii?Q?NYn/E26ALsENT1KX3eTFKB8gTErrnqCshkYd+KQDL2a5O5s0t8WbpoZ2arbS?=
 =?us-ascii?Q?Zn9ST09FaWtH8HH9in7UVoorySmCYHdIeNmrpK5pi2O/sbpcta7tGul1Q3gG?=
 =?us-ascii?Q?8u0VDTfK6JLTBz1LYBVQ0pPQxKS+cFzXiH2ZLZzTqFmgfw+6TNNAlXUajcJ6?=
 =?us-ascii?Q?N3mYcwt1refTvd9492Kn9SMg/CH6L8r0SHHjmYKa+8O/oxTs2qwQh4b0JB5P?=
 =?us-ascii?Q?wBj/X1KrDQBFo/ABLSyyonIMCfW/+Psbvv1+DKwp+UY9EFRj4EZiwkx1xsnU?=
 =?us-ascii?Q?CdSMRADfqbTqWHlJZZme/4IYLCepNAkKgmI2ttCZWxxnL/lQ7PMYAh4yqa02?=
 =?us-ascii?Q?51lstnffzSHtabkvQCI7MPdQZsAc/EYagxX+i+QGeMWKmh5rOjcz8nSVboXU?=
 =?us-ascii?Q?52tSRKVUdVYZnqO8fW1Yt1+lM1WbZqYvhVYZY05EIt57TQKR0Nzx2inn4ARS?=
 =?us-ascii?Q?GNwlektUBGExYyVP4dg2+fgHl/P3Oazx2g6R199y3djMDizzP1YG/tx8zOMb?=
 =?us-ascii?Q?EllOPnWC3mc2iBm6FyLoDPmfjMbeIKManNzku+hCMUQyyf8GnFj/azoP3ynw?=
 =?us-ascii?Q?CcPG/zZYbtCqNgoWte9dNXwI3V83pxBQ6AHry44R3Fsa+hC1/ByA2CmjH7rA?=
 =?us-ascii?Q?qcbfUYh6K6BeVMO258ZnteuCGEi+x5q+TVIjIImMi03XTXD1Ek9cbk2rVjgW?=
 =?us-ascii?Q?GNBFq4+biPEK70v1/+h5Dh7dco/AXttUQFa8v/OaH7s7ItdNn9N7G/iS6guw?=
 =?us-ascii?Q?iShhsQ2r0fsVIXaBNudCs4qk4tILFmunZLaOWtCigzWH2XF5+amjKJFMULM1?=
 =?us-ascii?Q?fx3r8DENksp3E7OuUzKfT7jI+gY9rDqhRYwWiRUWTWArQzZDVPddveNI0Upt?=
 =?us-ascii?Q?yLdle3rDYW0q2kKr8LxYpbKXk4N5YpD3+t4LqdZa90hPjZknS1JdTrY+4tYo?=
 =?us-ascii?Q?CvvGO+X3nppKhzIGhvTT+eJAk15w84e+MmcPrhLHhVLa3HYY93JmHGquqck3?=
 =?us-ascii?Q?2ifypPw3iPHb8BAMXDga1RhqQSOGFeh2IzvtHQxe3B4ecO00NMxbtCuY/Ff7?=
 =?us-ascii?Q?bSCaFXKz8XnZOYcfvweZWmQ2oXWgGY8/GzB2JSVD2+hhqNLY/yAKyIFNfuut?=
 =?us-ascii?Q?4aco6xe8bgIAsU7ZeY5sDyz+xw2iw1Jh1tZ+TT5vswFHQmuupOryLlZAtZ97?=
 =?us-ascii?Q?+1TWugC5Behm/wEBSXob3k9crZc4/E03YHEp4xGvnKX1DkizSA7jNY+m28sd?=
 =?us-ascii?Q?9upG9TkMiEJXCLjdl07kd5mT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6594ab2-8c4e-4483-e4aa-08d95e7bc6dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 16:59:56.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9NlcWMTlrVaBAyUizVvPvLOMQQ0pIyEWQVdbL8QkKK29ZIS24x7X1mfitpwkh5+PzcCMhzqmp4EtNAM5lbopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In prep for other uses of the prot_guest_has() function besides AMD's
memory encryption support, selectively build the AMD memory encryption
architecture override functions only when CONFIG_AMD_MEM_ENCRYPT=y. These
functions are:
- early_memremap_pgprot_adjust()
- arch_memremap_can_ram_remap()

Additionally, routines that are only invoked by these architecture
override functions can also be conditionally built. These functions are:
- memremap_should_map_decrypted()
- memremap_is_efi_data()
- memremap_is_setup_data()
- early_memremap_is_setup_data()

And finally, phys_mem_access_encrypted() is conditionally built as well,
but requires a static inline version of it when CONFIG_AMD_MEM_ENCRYPT is
not set.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/io.h | 8 ++++++++
 arch/x86/mm/ioremap.c     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 841a5d104afa..5c6a4af0b911 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -391,6 +391,7 @@ extern void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
 #define arch_io_reserve_memtype_wc arch_io_reserve_memtype_wc
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 					unsigned long size,
 					unsigned long flags);
@@ -398,6 +399,13 @@ extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 
 extern bool phys_mem_access_encrypted(unsigned long phys_addr,
 				      unsigned long size);
+#else
+static inline bool phys_mem_access_encrypted(unsigned long phys_addr,
+					     unsigned long size)
+{
+	return true;
+}
+#endif
 
 /**
  * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7dd71bd..ccff76cedd8f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -508,6 +508,7 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 	memunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * Examine the physical address to determine if it is an area of memory
  * that should be mapped decrypted.  If the memory is not part of the
@@ -746,7 +747,6 @@ bool phys_mem_access_encrypted(unsigned long phys_addr, unsigned long size)
 	return arch_memremap_can_ram_remap(phys_addr, size, 0);
 }
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 /* Remap memory with encryption */
 void __init *early_memremap_encrypted(resource_size_t phys_addr,
 				      unsigned long size)
-- 
2.32.0

