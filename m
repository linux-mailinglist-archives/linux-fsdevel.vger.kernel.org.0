Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D415BE8F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiITO34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiITO3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:29:54 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73361182E;
        Tue, 20 Sep 2022 07:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU2t8vy++EU71lYosktFe0Uo3+9WYFNXZ48hAiWp0DoApzzMff4gxz6He1rkJ9OndQBZd2xyvZjRd4y3AiZQIboHu92aeETxFxcGv+gSVnucHE3NtHqiJqsdkiDSJc2C2GfVv9p4YV98D4b6fZ1SH/BQcq5CNuVsuHCCHtwGUtNIFZHzSSCI8ddkxJJcP1vJZnDzxE7IWqx9geXe+gBvITEHlCVS5HFU2+V1Bn0kJk5Qc6r8SSDSeIyyMw4EGY8FbLdH0vazxbg0WV01841OPpnYqgIYSOt0zHKl3MMz4RJSupY+Sil9RGpUmr54ODzf+y4kY92cWl7CLbz2S1BzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4QxQOF3j4N4ok5PxUm3x8trDAWeL4/L1R6hAgNqXBw=;
 b=Iaxh2yjAwT5j4C0emxxgPryI2jQ8dHvCWmXi8K+Q8+10vWfXcQTym6tJ0mcsj/Wnc51UQHgXuzmFDlD3YYYN/q0tFLh/3SIGz0us9rlXZ0H5pejuuIJiL8mYR6matQGIaszkwOFjr71h9JmoiCh+alp4gn54t6S3TAo+HiTxNF61tXPMf5yc3IleGfqGtMuyjXrcUQKABC3gF6HvBWz4XpjptQkWrZ077BobuR9CUwoTdRrpl1isJwbT5T1EZ1HtmRFglg0t8R+HXiuTRIcO+uzQUnZ/F759EnQFisIi646Oj8a9kKfAe44d1+mLD2oonTCkHsDUKlfK3PiFLCiaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4QxQOF3j4N4ok5PxUm3x8trDAWeL4/L1R6hAgNqXBw=;
 b=oRD7O0qlDKXneF92dqI1k9b9R/iCBzwtdMjo0IJfpAUlYaiDfZDG5SQcAcvQSKPN5iGaF98at650sGLVVbT09I977cKFDuhF0uqu9mMVljai1idcqoxw1XNWqUNlugMLuHJBbts+pWIKdZRbHWYvX8kGryAOYlzgIhmrehrf2apjD7QdJ9mm/IIMU2Qs7RVVv+VhWfpyMXebaW/gDaxKHdIXePbcY/DtpdxNQLboUUqfpslPZIkcyrBQFXvotWtMFSERMbdQ5iqlC2J3y+06jLfjzlRYB+SxrWia0F6iI8GpaMcnJOZI+jzHmjeKx/oIAtcbepW23cvzRxiPJRxA0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 14:29:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:29:50 +0000
Date:   Tue, 20 Sep 2022 11:29:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Fix the DAX-gup mistake
Message-ID: <YynOXa8+jxxCjH5k@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 063f9051-4695-436d-66ad-08da9b14939a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nNvbL6k9eF2Muvpmm6pB3hcO87Ndwqcs+TgH10p2YAUYVXT0Wv2iCnw2XmyVtowoKO0SCWeobHvmHMTGDgEHiknqqiO00Z2Ty5vLZPJclHzogvAsn2kcLiqMWW14Y3ysc5DQhgg303Ldup1VTP6D+9zS0JFpAlQ1uB0GCBnMI+PApJVBHQ1qvdX1feDZXwv3bBpONGA6iUXAbGZjEMgxfGFWjoNU3grx9uwFe+pNrzpCAgVPRJXg542drvKyRnhUeHVTvo1AYRMiUlzUllNw8/Zhd9DtSCku0vOnOiP9ZKTPfKrSQjNaPgRtcb6gPaKhZGRErHGPJ+vUk5QrJIRPK6Vd4bcgMPE/bukU8ZXlQOCkOVXRhtSdG1Dv8sx52cSALcYDnRRls89ZxNVr4+JmEYyViELL6rxrUwsgTAHJuAfVa3nlqJI8mMe35kO5/PHx0OlQEWCRKzDxqxcvo5ONIFkIOOnlWFerEP/I+3eDdfTbjMl+7prH9fAW+BSxVYrcJuQxGPAEb9l3nEYarX/XwKIzhQT0K80O/GK6yVdsyr6BFfrAQ+GprBPsnNnkMh8pBr15wArggdNaLhng70oqKthFtyCZmzvSemCfp/13AsrWk9wYyQSZnq0Wqw8VzvgO0vLd0acpnKRXmuWR0Wn9oQmQF1fuc0ktsko3HAOM3y3KMOh+DgdUhjDCS1VPrFzJLvBi0UHmG1IAVx8GFfkZkUybev59XL9Fu7wdDomJ2JQW/nlb3pxvw+4BHZtCifl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(38100700002)(36756003)(86362001)(2906002)(186003)(6506007)(6512007)(7416002)(478600001)(2616005)(41300700001)(26005)(6486002)(6916009)(5660300002)(54906003)(8936002)(316002)(66946007)(8676002)(4326008)(66476007)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gzVaANg579vVe4vzhgXTFXWoUc/WexrGwFPl6BPoT8XWigRo/llEmYbLPJEU?=
 =?us-ascii?Q?bXZrQt94EjB+3E3M9+OBEFujemBOWS0ACcNA4+CwB65Ws+YqFjrkqZMI9mwQ?=
 =?us-ascii?Q?cIFx5iIMaIiXxv3XwXMJGUmAvV3+w9PJk9JZ8Jso/oO/OGqHX2bhpLq6zRbm?=
 =?us-ascii?Q?JmvW9Ooi97LT3teJ0clqqoLLZWe6GrebU7cJ3komYPWqQ1pyu3BTSkb1o17c?=
 =?us-ascii?Q?Jy44NHnLBkQ9leUlXsgzDl4z4OybA8N25baTK/yKhCMORHi2cxHaKa2GdrQx?=
 =?us-ascii?Q?GKnzaxdYRczEwTdJIFXJH2Oej4y1xC0j/aRy8HkU8b3eEJtRvAkiU7Igqpc3?=
 =?us-ascii?Q?/xDf7thqTkNBOpiHpHWs0VLDjaY1j1JooZUYOvxBpgfdZf8TYbKLRobTlrM3?=
 =?us-ascii?Q?X84Uao9Dv6B+QVLuV+Re+8oQQI4IGDdkyvmjnzkfWUl+AcH51Xs8lWr8PDes?=
 =?us-ascii?Q?etyLSSN+/47Bk7gZwSXFeuE/erpCEGpQ+9Nlg8M8BLya6/oh8RFvFiHgi9hT?=
 =?us-ascii?Q?fMPKtR4Y+xXgJAHkaSiQ6Sb4tz6unmSeQ3DkSbmzgZPq+YXDNZQ3W5duf7yd?=
 =?us-ascii?Q?QHytrIDKXWsTJ0KILJo2WZ+wJaP5ciovWWuP/2cKpLOgZu33PGDKyvXI8iJz?=
 =?us-ascii?Q?ku/0K6UlCCFNOhET3/RuKTlgKiPA+mmKXCLbsmuQzGMqOLsyez8fnwTS+s4I?=
 =?us-ascii?Q?MbckTDVCS0Tpm5PFECOj0ZToZUq+E1ARHAv/uoAHpmFHrWhSNiy/0V7pJOFJ?=
 =?us-ascii?Q?hOP406UWVvkJ2RwfS8HtXi9esQw/LzPMfKP3WpC6LmSZ/NLANscR3BzG0F0K?=
 =?us-ascii?Q?n3pRYV3j0gFWH5+/glxptb8TV1Buc1MiIArh8mLdgCZhMtyukaRJjLIeMWWV?=
 =?us-ascii?Q?ArP+k8Z+ZuX2V96KjxjhMDSVUixDfP9CQbg0VXNL69cam4nRBqfL28gZGH0M?=
 =?us-ascii?Q?HlwDMRFxIaJRgY9sjpGDHhvVfzSvHjqmM45kAxiK3Wx1uC9v1xi1gPoIouC9?=
 =?us-ascii?Q?eg3NuFTzFUs/4Jw6TLqHxkp8lZw8YFHhAdPQ/7MMUh6/WhkzL7maapcxs3ha?=
 =?us-ascii?Q?uChi5MTfpv9zXQpJgiwdwSabjJr+HpZDLEp6If3Pmzphs7DtMcdCEgtKzmgG?=
 =?us-ascii?Q?jq1j992jaxnQ+f/6wx0hjvIlNYQ5KhuQ1byQonmgpySOIzR4kxD+yQXjhaes?=
 =?us-ascii?Q?Ynym1fTEcFyCrv/0oBIghO3qTG/lKfhdrwZQ2idbftwUBogxMUfNAct7fNev?=
 =?us-ascii?Q?kLRqrmaR7Mp9fmO+eHajfbB6kc7DMQTS1btXm1cC6354Q7DnPUsgEpYyya3/?=
 =?us-ascii?Q?7YR8ftbJ70cqCfaYiRRz28/PxR5T8Tfw/8AsQpV/jyxweKbkaHlM7xLhLuFB?=
 =?us-ascii?Q?OSlYoqzY+UgK+6JfzHbdGQ8nNCrhPtwILIcSmsT4PJnzOZEzsUtADH3fqMuW?=
 =?us-ascii?Q?/BvjPigMOXFyMAdGlclqVqV31VA0ncI1Wc9nGIZkQccJK5o5qhRUJ+6FykdV?=
 =?us-ascii?Q?/07fkfrO/h/o23vaMb2E1WARMvivAv110hSRrAlNWoltQT0+8S33DleM1qs8?=
 =?us-ascii?Q?b25UWbBeLooc1d1gQu6d9D9d86ikXbVpgIHCdCV9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063f9051-4695-436d-66ad-08da9b14939a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:29:50.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKuWuXlai2SPubKRoaJMF8x1l9G5YVHbP6IZFK7Pd7d+6qgbVpWVklpGJcq1ewAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:35:08PM -0700, Dan Williams wrote:

> This hackery continues the status of DAX pages as special cases in the
> VM. The thought being carrying the Xarray / mapping infrastructure
> forward still allows for the continuation of the page-less DAX effort.
> Otherwise, the work to convert DAX pages to behave like typical
> vm_normal_page() needs more investigation to untangle transparent huge
> page assumptions.

I see it differently, ZONE_DEVICE by definition is page-based. As long
as DAX is using ZONE_DEVICE it should follow the normal struct page
rules, including proper reference counting everywhere.

By not doing this DAX is causing all ZONE_DEVICE users to suffer
because we haven't really special cased just DAX out of all the other
users.

If there is some kind of non-struct page future, then it will not be
ZONE_DEVICE and it will have its own mechanisms, somehow.

So, we should be systematically stripping away all the half-backed
non-struct page stuff from ZONE_DEVICE as a matter of principle. DAX
included, whatever DAX's future may hold.

The pte bit and the missing refcounting in the page table paths is the
remaining big issue and I hope we fix it. The main problem is that
FS-DAX must create compound pages for the 2M page size.

Jason
