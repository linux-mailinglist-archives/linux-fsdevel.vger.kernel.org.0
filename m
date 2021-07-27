Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC213D82D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhG0W2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:28:42 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:51599
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233101AbhG0W2V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:28:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbTuORSJ+kWxeFRFHYjwThQQDavAssVrZLoFxCtPRXW/V9pY5OGGz9y7jzTfl+5/zypx82DfAP1ih2yUaxeQ52MkAvoiF6yV//OZUSE+97Sgiqx1hFcE2/lPflYF+Lw2f4pc/bjMHswjuhOIY1EuCa7gXk5b1i8bBEU1NwdBoLaGGHpWYKy6tzzMlr/sdu3PkW5NCZEVlOHX9zP5dj9BREyEfg82v/HrVDnMwFWZo3uoNlZlncKr+O6JjuSKksUEfXvZMFgoxcfAGvFHqCrB9TZINsIe810uz2vMZDbPZSA7H418/N+vUZWi+gkbcboxIT5UEetOPk6HJEFNx6gBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKsrhM66TBye+IC6wdBCuUHX+ezNw8g/dcZ86WD4xr8=;
 b=PQW3QRvnXBKiP/MUyty52/naTGNkq3UnwqVe4Z4yaVnSTfE0jepcWJlVrguOsNMCRQO8lCPLb37t1MT4zARq+tX9InuilV9ZpjCVMUwReQVBoQJ/myaq1B2qg1QAuC1ZnRYwhfPlIpjAFnPbfUP2G8TTAgKWzNYNbZx7Dmiw4BsXXVKmJjp1eiLsAq+b64KmWJbwXhxgq1csmriGgAjU+4eZ9L3vaxXM6g9aQQEXjGo1Gz/b/FDbdcKzZG67DNl8JFtmxgm/jouYn8tdk1AurhTPqFV8VTi6rbJxO+9MaNSPFhAGvHgNCpiD2wXFYiLtSamKsJNNN8Pe0DhoY1qiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKsrhM66TBye+IC6wdBCuUHX+ezNw8g/dcZ86WD4xr8=;
 b=b5D+2kt5z6/UT7xSYILI0siYWijDQozr6mc/3ad5F/1HwiXyZ/sSZFgRYFwHC+YJewHgPcLEDiREJefI1inMigO48cJm8vvxJob6se0SsZBPc2YAoJ53DAox0Q0oN6VUiNwNIEe8hPFCLFL6D0chu1hlOKfoY4/+kuWpZt434wY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:28:10 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:28:10 +0000
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
Subject: [PATCH 09/11] x86/sev: Remove the now unused mem_encrypt_active() function
Date:   Tue, 27 Jul 2021 17:26:12 -0500
Message-Id: <2e6fb78b7b18437f0e754513bf6312dcba3d1565.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN4PR0501CA0065.namprd05.prod.outlook.com (2603:10b6:803:41::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.12 via Frontend Transport; Tue, 27 Jul 2021 22:28:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1210c41-0710-4a44-4dd0-08d9514dd080
X-MS-TrafficTypeDiagnostic: DM6PR12MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55205EA5C80ACD08C660059FECE99@DM6PR12MB5520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: caY92Oook+0mgYTlSeZEOWrLCK8ng8jh0vvKP1BbkEZAAC3aLHcNNTDH3XMhnf+QJIiRO60OqNZmeXErwAsjuYUuO/WMokPKz24N8o39fqkbrdn3EM+rn7ASkiK/wyHNGhwlhmoXkJ56UKYU2PzAc91i4QWG8+cqIsUBkfxFVReUdloYOnTBdvOurVOemI0PP0vvSzOBim8NSSb0xSvqexy0WSahZH2BXrlric7apUdwjeWOhMtF/ALVwwKm/LqHUagQLkGOGKWmcyjMIFnQ4LfekeQ1wi8N5I7gtXGh9b8gb0OSWWxWPBQ/CgTwvxIVHHxUrSLL5VbL43BvZ7J9JNSM7o1j3mGCcdNVbhkoXvxQD+9YcYDvG8rYGRPkl9xPLgZktk5UC6E+F/UauAkE+JWFwk8L0RP4ezweYV7rkC3qWv1+ZWvygyCxMy+v1sfnNHX5SwCLTOOAPXvzHmMnFbMHFrtRmrnRp96EDGYJDNzIrdarADeFrcczvydnqtbLzK1r0wY+94fkZ6V9ZY64+sq7PKlnSaL5RusL8AU13uv0KYzd81SuLuB5bYcciUOpZfD9JE7OXcX0LJ7nH+apWTDXqkefWZ6ejFtX9XY0omxYGLeDV4oT8qq6H6jrDcFse9C1Z5mXHx5XfvazBD+SzH440iNDFPHPFiW/bAyL90Ol+s+szNel/BmJ628DbyijluEdJ50y0Y2MXICYx3is+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(52116002)(186003)(478600001)(38350700002)(921005)(5660300002)(38100700002)(956004)(8676002)(6486002)(54906003)(4326008)(2616005)(7416002)(7696005)(86362001)(8936002)(316002)(66556008)(6666004)(66476007)(36756003)(66946007)(2906002)(83380400001)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BciGXQlnIeOx5rkJCKv83CMBYwzmZ62spmW5pyKr4uFHG7B1b+N5HPefFk/B?=
 =?us-ascii?Q?kvweRS1jAuUrqRtp0r2/z2mguV5R0h2GiTHMJKaAplo8PnUa2OvH6q2bbl9G?=
 =?us-ascii?Q?mhp8EjsXkN5D/S2kZN8oeStGgfd15n7kg1tnjrGM6px+nbkm5Xl94sAh3iek?=
 =?us-ascii?Q?mMY7R+KLJm89V70WfB0J3xJXlXxhiVAWrOGD0PIK3BvV+KTvLaGRXiboYBvr?=
 =?us-ascii?Q?ydOTlDz29CKbsVTHzIu6GW1YA/wzUjXY/GPBKwY2ylJfD3HRP1sDZLGi6Meo?=
 =?us-ascii?Q?4wwfmoTqoCKxRDqWRaZMWSD1pluJZw96UiEN1xcBuMq5qcqcEHKcxUj57FcS?=
 =?us-ascii?Q?VKFXDr4YdO1fuPwwUuXSzwxtDAFvoSUWc++wSsOuDpBjjTCK5GodGfQqwUI9?=
 =?us-ascii?Q?pIUhFqfEq540t2MFiLl8A3G1mH/VlmPTFVV7XVRXdWCmT40hOc/1VNZiklWA?=
 =?us-ascii?Q?3iHKVO3DPxJbsj8L7+Dlme0vVZxMSakDatDVqTcYU+qe1p+bGpmbDg1zYVdE?=
 =?us-ascii?Q?c4mloPOOtlEmpRRp+acFYyGGuiCuJJ7xNOrTpDz0U7TBYqGh9sjga4Juw9aZ?=
 =?us-ascii?Q?udxw4f1viibGnEgtUPk7KPCbVqGxrPPItcN9Y5K6SO2lUrziBt5BNara8Em8?=
 =?us-ascii?Q?fvwva/6BVkcrv0z/lk7+RqVe4W5Ip0BuHjAJBFUlM+5o+j86nMhKtsrvjblx?=
 =?us-ascii?Q?DbfgcBaXZbMysizvP4firBns88yUNpYqnFn08hWZblQZ+RvwD9CZw54OMUjN?=
 =?us-ascii?Q?ea+nLD6ePkwXoWjvPbKl/y4S5kYH5RMOeM3w7iqdVNc6Di91AUMzQVMeiLff?=
 =?us-ascii?Q?a+JZxPQgAl5k4WSwqFsH19fQREs6ApWRjPn0kRMsLnOSw01mmWyheHzLZngd?=
 =?us-ascii?Q?JvNwdkZSGdNszDmU2RKsC25cAk1SYEzKisIl/G3EIKQnKofWX6Jsb+hahc8e?=
 =?us-ascii?Q?vVm7oYk2WMDkgUWy8KAlDIORmjKu4IzblpQ0bsUK3GNQ+9kV2XOmA7WWC7ca?=
 =?us-ascii?Q?uqHXOwY+X+WGGbpwL2SU9yBFMqQZLhv5xZYXsnf7tVzS392RZxxMPU3fhKoP?=
 =?us-ascii?Q?NWy7XXtOLjAmMunfAQMUlplVemmjoWtwutYpY9Stbjvlx4Jb9cb8nBlIcG5u?=
 =?us-ascii?Q?WkRnfzbAAqUS4Z7bkadtgJOsdz5KqFldipFBXsJTKO0Bl2NTJtPhPtXxYGk+?=
 =?us-ascii?Q?OJfziSz6qYly5+/b5SSanAgs3KbeDPZzhnlue/AK+UkejdvCKbo8DIYy4Sad?=
 =?us-ascii?Q?h+kouLwvicLBqA1UO8dcy0+uBj7OHKKFyrWBwxOibpCR5y8kziY6RKV67DT3?=
 =?us-ascii?Q?FqTuUUKelzCETVLw1bDw+FQ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1210c41-0710-4a44-4dd0-08d9514dd080
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:28:10.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFLvGqgt15SZua3H3/Ow+sfZ51XMCL/axZ8PA9JCScELh+vGxAhBcZExN0voS08kwOfFOAJH6nAfu7AkuMJq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mem_encrypt_active() function has been replaced by prot_guest_has(),
so remove the implementation.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 797146e0cd6b..94c089e9ea69 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -97,11 +97,6 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
 static inline u64 sme_get_me_mask(void)
 {
 	return sme_me_mask;
-- 
2.32.0

