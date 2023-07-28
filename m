Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC167661C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 04:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjG1CaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 22:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjG1CaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:30:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D15E30DA;
        Thu, 27 Jul 2023 19:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj7exefdjk0BC5upxEsJaF16NiWsSpD5aqCoq/TyD0UaVlbq1y9Xh6nbr3082ePmMmDR6BLOwc4MRn4OpEGQwY9kcCvY/J8M8ljGcazPEBXERyZOKDMeeQ4zxy3TwBPRt7Vkqa56sIlxC28rsjlwI4/4ULPz51RPFlWhXPohTkLpUD+SZ/UajIlNYEH6hyrHZk7RnEQ14dsm1C6nsrRQdKco+o3Bx6Gm2H2tlWG6PHUPmOeFCtESqoMnTU3gRs4md1DNs5c9YaKJNUKxnLKBUA1dKPWXnFGqd0tFkIGmlpT8Cxef0qSN8YgbMPFsjQ3wkv8JDwwwOrEcB+CvTXsc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGQgFr9l7zey7jHcRF3mJhuBqwQEDJceSSW2x8i0EP0=;
 b=D/1itekzB/L0uQzcYNG9m3pual2oH+VyKeNDBpHJ52atMW6LoVJc+QdheV1l1e9bB5LCkaCq1bAKyiASo5qkH1GzowPU2/w7Hwf7fYeiMYTFn1QbNne0C1JbpCgNnHAmJaX18FwJCpmG4MIuGrenheSI200pmtVMdKOzdU5PWEY7PWgtMHQOjTSV17IJ2Y2I3dwrwRalW7DpXOTO9SbT4X9gGeK5+ImRchoG4IH/4oNdttgHrLuEIC9gwRhlHWiOmwgoZUrzoodEmRjD3/7yO6IwMk1YXqB9CBGgqVbsP+3WueH7cFHwnsdeWaNpktX9814h35XQk5XR4VGAOzGjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGQgFr9l7zey7jHcRF3mJhuBqwQEDJceSSW2x8i0EP0=;
 b=dwgkIkuH0PGW0J4M2PJdQQSeZWU9J8NdkmA4m6PIIfCN9cK4Neuc8xzUm+9yvRuTL9ote1hUmsEg6Mh4JeuuOehPPTO0qPOK/VcughIlvuEkmzviArvzVEMwqj4RQ7RSU67g3m3M8nL1Pi8U7ZjAZeM8qW30J30oqnW4FrS161O1ejhB3aMdPDlpRzwYTYVxuqhhpqAen7WsnCLUDrmV3fskUeHdPYhulMRGXOLkBiZ7hBnQXUNLzdXqkL1Cl/voO9Gkmo2XJH6QGywrTd8Rq9LWH4goyzNY72zpXScgw8+Sl/v8DGHAh3MbX/JgTqzX+aprkgF5sMH6JA/xcR5wXQ==
Received: from SN7PR04CA0116.namprd04.prod.outlook.com (2603:10b6:806:122::31)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 02:30:11 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::f5) by SN7PR04CA0116.outlook.office365.com
 (2603:10b6:806:122::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 02:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 02:30:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 19:30:01 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 19:30:00 -0700
Message-ID: <55c92738-e402-4657-3d46-162ad2c09d68@nvidia.com>
Date:   Thu, 27 Jul 2023 19:30:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] mm/gup: Make follow_page() succeed again on
 PROT_NONE PTEs/PMDs
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <stable@vger.kernel.org>
References: <20230727212845.135673-1-david@redhat.com>
 <20230727212845.135673-3-david@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230727212845.135673-3-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab3b403-7c55-469f-89e4-08db8f12916f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+1yGKS6pQ9yIAPBC2UMxJMx7Q+rqLux+9CJmaIR13CEifiEDgSTG6Q5XuRrbX4YB97p7D/ofu0vRGVmV7rdv/25d2yEW0xIv+yWtSw3Muh0FPNlCbk9LFQOatP1P2cG6hqRnkgUAPPCWl+OAchZb4xHWpA9UByCs+g81KzT5QxWQcXNgUQhYGVPfTMnIM0tFiZpAEKMj/BUzAHAu0x+lSKaq5UToxKKQETDrd6jw5aycYgseWLO84VcVxXU7rSlSbgHGpzMi82ebgMMFOR9brpYy/0HD9Y1rMhJrOwX9m2KbsJI+byYUK3Ol+j+4cKmABKOSPy2yZUdio8eIv38IQqU5OB7XpLx7INtYTmQesWN6hFPGj9fhh7b5+1/a72AQB11Wa9oeJa0kIADSULRUBwokep6UgkQoILD/sIvoPt9pIKXnDkT2HN31Ne4K7fOT6UShLhW25PjA/p0qXocDSOAfuw/Jhlipr2ldbjhIzXfwuJToeRGXaEFc/pxg2v3c7BrTPVK1+QGJ2Z8PFCHNXbpGxPdpLsjnslqokEj7Wxf2p2A+uET8gZ1nXqc7Qyd/ZyVaiF/2TcxHgE2VyudPNV76AzlIzV35p6Uyai4dl1OrzPYmphLZVS4SsczOsaJWAc6QFHX8LYUeURv1BSyvgRZIsTRHSz4QJx4VcWM0kOuNaV61adWGGb12CApqR0aOKDIxoV0Ns9ZVmoFdJI0xA0Bqgwi/dhX4+FtgFoFhteb0CJ94S9VLSl/jcZKhfksWo38IAQMtdbHbJ2Jx3h12Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(110136005)(4326008)(7636003)(54906003)(82740400003)(356005)(478600001)(5660300002)(8676002)(41300700001)(2616005)(8936002)(70206006)(16576012)(70586007)(316002)(36860700001)(336012)(186003)(16526019)(426003)(47076005)(83380400001)(53546011)(26005)(31696002)(86362001)(36756003)(2906002)(7416002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 02:30:11.3840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab3b403-7c55-469f-89e4-08db8f12916f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/27/23 14:28, David Hildenbrand wrote:
> We accidentally enforced PROT_NONE PTE/PMD permission checks for
> follow_page() like we do for get_user_pages() and friends. That was
> undesired, because follow_page() is usually only used to lookup a currently
> mapped page, not to actually access it. Further, follow_page() does not
> actually trigger fault handling, but instead simply fails.

I see that follow_page() is also completely undocumented. And that
reduces us to deducing how it should be used...these things that
change follow_page()'s behavior maybe should have a go at documenting
it too, perhaps.

> 
> Let's restore that behavior by conditionally setting FOLL_FORCE if
> FOLL_WRITE is not set. This way, for example KSM and migration code will
> no longer fail on PROT_NONE mapped PTEs/PMDS.
> 
> Handling this internally doesn't require us to add any new FOLL_FORCE
> usage outside of GUP code.
> 
> While at it, refuse to accept FOLL_FORCE: we don't even perform VMA
> permission checks like in check_vma_flags(), so especially
> FOLL_FORCE|FOLL_WRITE would be dodgy.
> 
> This issue was identified by code inspection. We'll add some
> documentation regarding FOLL_FORCE next.
> 
> Reported-by: Peter Xu <peterx@redhat.com>
> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/gup.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2493ffa10f4b..da9a5cc096ac 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -841,9 +841,17 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>   	if (vma_is_secretmem(vma))
>   		return NULL;
>   
> -	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
> +	if (WARN_ON_ONCE(foll_flags & (FOLL_PIN | FOLL_FORCE)))
>   		return NULL;

This is not a super happy situation: follow_page() is now prohibited
(see above: we should document that interface) from passing in
FOLL_FORCE...

>   
> +	/*
> +	 * Traditionally, follow_page() succeeded on PROT_NONE-mapped pages
> +	 * but failed follow_page(FOLL_WRITE) on R/O-mapped pages. Let's
> +	 * keep these semantics by setting FOLL_FORCE if FOLL_WRITE is not set.
> +	 */
> +	if (!(foll_flags & FOLL_WRITE))
> +		foll_flags |= FOLL_FORCE;
> +

...but then we set it anyway, for special cases. It's awkward because
FOLL_FORCE is not an "internal to gup" flag (yet?).

I don't yet have suggestions, other than:

1) Yes, the FOLL_NUMA made things bad.

2) And they are still very confusing, especially the new use of
    FOLL_FORCE.

...I'll try to let this soak in and maybe recommend something
in a more productive way. :)

thanks,
-- 
John Hubbard
NVIDIA

