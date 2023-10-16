Return-Path: <linux-fsdevel+bounces-388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA167CA6FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307C3B20D9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838C262A5;
	Mon, 16 Oct 2023 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZvnukhVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B932628A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:52:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB1DC;
	Mon, 16 Oct 2023 04:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YngqZPT8GeGWhC8F111ic+vicnsCbRcXDHN8xiOS3bYLDK03MuIdce2aKGBiU1qoko/lI2eM3xz8wGCnrMUbkwc3GA6gBiGHjK/bRH15IXRvWzOYXel8LLHWWw2qloX6B5TpDdOjfUtrubY6KzLbSZ4d6egaQ7IGObP6KzmbR9Sf4STqujSMmTREaLsodsMQWMMELpqXy5a+dkEHEpuV9YOYx0IXW+4rSycgpEq2hVO4SgWIVGIVYOxhqGr6nedzf1nLPmQmNdUsRQUUsq2v5F6XHnaIYCmOtl2ihny2nL+Ds5UUYRFArJHVbDF3i1TgNTzVEvBazquXwhrdSQPWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpTF5ISBAxLP+TjLWKpFyWZ7IGLMCLFMl9FnoZfCrV4=;
 b=Jp7mVb7QwTVTzRtjOBm4slB4fRunH9ePkAR8oHRzDxJjOK485WzST1Jz7Fzpg8htXsv31rcofe7zTYptuv+F/YOwLB5joW2N/8eDrDLI0W3pWYx4Y1XvGzX9+/LGmQaK0tK/uFGXn6t5kZ7SdDoH4n80WARxoTTsscEk1G6fNJsnGXvRTglhkDLvJ7duPJ+jJvGVAJIZ+AApQh6ji/OEDwwpbVADX+bYZhO2rt4SkvVtPKpdZ+BYcF9a8WsYbcoks4KlmDFn1rcBkDqDZD+nuidTH2zAfeJKknY3xX1YnyXsyeE1noAPL0cvUriAX1Qp6kEnUaA0ssP3aRxI/zrb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpTF5ISBAxLP+TjLWKpFyWZ7IGLMCLFMl9FnoZfCrV4=;
 b=ZvnukhVoC6kQBZP/6sKTwAC64oGLCg1fxOYLfA/kLZqxwL8WC4qssqyzI8bmhFQLJatwjvQM2+Pi9WQyFlEXyp1e2PO5l+zFAUQKvR/OXmj2Td1uXT3HoS83GHnEAp+DgwKHdi8WVsgprxSOZJJUfAYBkhwC4DLhzFCkPXr+5FI=
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 11:52:04 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:610:119:cafe::20) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:52:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:52:03 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>,
	"Matthew Wilcox" <willy@infradead.org>
Subject: [PATCH RFC gmem v1 1/8] mm: Introduce AS_INACCESSIBLE for encrypted/confidential memory
Date: Mon, 16 Oct 2023 06:50:21 -0500
Message-ID: <20231016115028.996656-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016115028.996656-1-michael.roth@amd.com>
References: <20231016115028.996656-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 44632831-91fc-43cb-e3ce-08dbce3e5098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OsebtnEQYofdoRWjybAht+iGibpV+J3ZDQduagw/JDnjLyY2agfF3DZhK7AYcilBH5C6V+PgjsMg6s3QbDEofKPdbUqhyaKssZWRaWhZjBOE9msFhmAuB0RBXImKjRadWnkwGiLstWa8QcdyF5bTO+lSImttp00dEMe8P8DPg47EvC96d2zvMOpViG42V7TNlFaFTW1aafcrGHDfINC3g2NrqxW23AbTYx25dp1ZaPhBwmXtI+KVHqM8+gyRmCxAIzqjLT0DFVRuhNI6RW9Xi5TOhlEc23x1aq3n0RCHwGLdnSQTxac0XrieLWdwtYVmx3HU1G0SH+4VGAJk/7N+JfboK/E56dVF43Prhzgkh4gjO93xfUV1bY84LM4/ftHQ+z314M/slUrYeNS3WPNns18ml0aCQzgxsisgMp6QSkD5zF0hV9HUG/pw+dlrK2OfU439fqmFLnL//bR5HT1cA+pgj33Vbbupp0eTxAfzFuee9XislTtUykev3NGYTMJ9cGbzEyWKgD8PPzUGQvArWQlpXGINdUpsRL8ugYKuFxvjR53ESMLpEnZduaWnGBm97y/MwI1x8qBmqH5nklEdvfrK2Y5awwaT/Ia60Y/vYUvd2fw9Lwi1gGIROsgCv6uYiMalgpTgcEtaLx9JOrzOFGqUQFfRr8+hEoQZUdiDkvV3HfnKJSFPoibHXsEC0sD5U8MMBQpdTQUiKwgE39wWFFZeuipTH2YqnTbxre7hkt+pEFlEaP/gaxOBAk6ScHep
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(966005)(478600001)(6666004)(82740400003)(356005)(81166007)(36756003)(86362001)(40460700003)(16526019)(1076003)(2616005)(426003)(26005)(336012)(83380400001)(316002)(6916009)(54906003)(70586007)(70206006)(41300700001)(5660300002)(8936002)(8676002)(4326008)(2906002)(7416002)(47076005)(40480700001)(36860700001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:52:03.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44632831-91fc-43cb-e3ce-08dbce3e5098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

filemap users like guest_memfd may use page cache pages to
allocate/manage memory that is only intended to be accessed by guests
via hardware protections like encryption. Writes to memory of this sort
in common paths like truncation may cause unexpected behavior such
writing garbage instead of zeros when attempting to zero pages, or
worse, triggering hardware protections that are considered fatal as far
as the kernel is concerned.

Introduce a new address_space flag, AS_INACCESSIBLE, and use this
initially to prevent zero'ing of pages during truncation, with the
understanding that it is up to the owner of the mapping to handle this
specially if needed.

Link: https://lore.kernel.org/lkml/ZR9LYhpxTaTk6PJX@google.com/
Cc: Matthew Wilcox <willy@infradead.org>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 include/linux/pagemap.h | 1 +
 mm/truncate.c           | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 82c9bf506b79..9e79cf48f67a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -205,6 +205,7 @@ enum mapping_flags {
 	AS_LARGE_FOLIO_SUPPORT = 6,
 	AS_RELEASE_ALWAYS = 7,	/* Call ->release_folio(), even if no private data */
 	AS_UNMOVABLE	= 8,	/* The mapping cannot be moved, ever */
+	AS_INACCESSIBLE	= 9,	/* Do not attempt direct R/W access to the mapping */
 };
 
 /**
diff --git a/mm/truncate.c b/mm/truncate.c
index 8e3aa9e8618e..0d80bcc250af 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -233,7 +233,8 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	 * doing a complex calculation here, and then doing the zeroing
 	 * anyway if the page split fails.
 	 */
-	folio_zero_range(folio, offset, length);
+	if (!(folio->mapping->flags & AS_INACCESSIBLE))
+		folio_zero_range(folio, offset, length);
 
 	if (folio_has_private(folio))
 		folio_invalidate(folio, offset, length);
-- 
2.25.1


