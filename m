Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3F5AE832
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiIFMcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 08:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbiIFMb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:31:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D007FB05
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 05:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3+EZL5PyuTPOOV4DSYD58r3t79QEFXNRgOWU9HauYZNYH9j5k9v5vLlmeOLwlaXRKqVbtXrT7O2XFpsRemY3qqv7BrDTEy3P7lXhCG7jhSJMpVnf3VaOBgnkdy2FK8hhB+dmJ4PkHmkHxC/kZCe6Jr1984iUk1qLZEoYQuCDQT8jWtjFdktOeYGciiF/wb9X30arK/4S5CfYdTcRKFVD2wmePc43czH3i4hRT1csp8E2A4hday/3YyxyV9WXp7Hb4V4EoWEI4NyV71PDXM4DX6O4Dib/u3YArDJaAep3U+wpUVYRzpFo88/WZ/MEqRRkYX1utdtA76DVwh0kBDU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pQSJudcOfTYNKppddOCd3MfN7FA8pWKdTNC5ab6a4k=;
 b=CcwnvKReUPfRCXYKQhAL2lFib6bZ9yBFgWrlBUTsKpVLCNA+mGradg1HLUpxqDJVaUgfuDOInabJhJfJSrLfnTNPXQHZOCuN+WVNhRbcOC5kT5m5EREc0TwHGo4elB3LdC2FNXW9J1HvNiztsS1jJVklyvGx1DHEQrc+nl/ST0+c+ErrN9mlFJh58z8QJfWzWOuHBaLJAROX5jQvUY0xfa6IphK5LTntP6ZS4SheqDzvuQbwk4kvCWylX4W0KAk4KdE2FsIRYUehUpWpYkAMZ1o1JLYO/NP5itbf958VmpFJrY1/7jkCZMPLeO0wXqRsVJz6aAOTa1Rwt1KFk5DyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pQSJudcOfTYNKppddOCd3MfN7FA8pWKdTNC5ab6a4k=;
 b=F4Zh/sICEgCJy3Ww9v5kI5kAgt8PWKcUmLxJX53jeeGf4ONn+ETwMUoyG2UdL9nDVjKPcmh2cZ9qGuWhQF1o8TdkGdwGFgeRKEFrgx7sWqABo/G4zy/eFK/P8rA7J1iOAEqPsl4occswQvI9JHwUyoUAp3jT3e5SIKuhsgLHg2jgpaNe2dAOnLxj2g8i2AiomrLUyVg1q/p38x58d+HKH2h14pHQvJccThd4yj4WRODDXX+O/jnhgcu3i1rreUiRu2hB35vTyXtOsQktCqrxdvnIT+lODJht2DBA2+IasnSPh4Mo2fJmIrhH5VitUnJuSv5LYtbhcQWB84cSdayxKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 12:30:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 12:30:43 +0000
Date:   Tue, 6 Sep 2022 09:30:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/13] fsdax: Manage pgmap references at entry insertion
 and deletion
Message-ID: <Yxc9cTvcyjCt5NXS@nvidia.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <166225780079.2351842.2977488896744053462.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166225780079.2351842.2977488896744053462.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BL1PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650270e5-57a9-47b0-d784-08da90039d81
X-MS-TrafficTypeDiagnostic: CH2PR12MB4937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txeHb/8oExRlyjV9VbxNGH5WTKyYtojtQQmXpopoareiaiKA0UzORed2EhOVgkzHQrzn456+QL6O7oa0MaMuzEVh/DLjbJapBpn3EV6tFjTnYQAnLHc9JL9g2D92NG4z5SoH1RSMm2nZ5ZqbSpMaZfjLJpojZ0ryTTMeUBeR1V+kzrcgtnJuD0o7QLpwjCURYhPo2OiE+nTv5LGqBlbUMX46taauMiQchJVKQWLiHV+KiDVFBZ5H3OgZd00KTCvA2C2ARoHyCnZbIe0UhkADDDPS3dpGENni+IAbPcoZlbECSFF+CMbwgmj92zVLsOspH0uX6Ip8gdOnZUEdLKIrPEzkEAaYiU2jvYeGZRh1SEJQLMZSY89l5S/CanKvkkSBvHyYx6etO5IsbOQxYNEFkMHJuOpw5iKa94ESZqoT8jdU7bUY/jGE9FSvXr58XKymj+xtQodu0RfFC5pbjGuvYHb24nzFjs5LgJEPA2NOqSsQx6/kli4yBjxmZ+kS4jBAIwSsywR5TxUA/NQK0LQRTlVdILQkWrbSODeBvmWcRtWoxGH7l1atLIptRXKp+Lj4OttCeT0Bu+ZAGOWu7sxJRzJKtqlXtRleBTnu3liDxrT5HxXz8SYFW9c8vico3C7y6mzuT5r+126291/cv4bCQsVDmSTkhNxeKOotbKVkIoaEDT3+/uTZHTSKjJhGPQTjnhJy8VMyA9n3MTvNduip7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(5660300002)(316002)(4326008)(8676002)(66556008)(4744005)(66476007)(6916009)(54906003)(36756003)(66946007)(8936002)(2906002)(6486002)(26005)(6512007)(41300700001)(478600001)(86362001)(186003)(2616005)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8b88O9RxdmY95yJkgRORhHBIgwYZBctytnhwjuKare4/390BagyrtW1YcBZ?=
 =?us-ascii?Q?PeEk58EQMAA/fjdu2HIdcks9lkL9S/mWeOidwHLY5YBZgJUxd2W6OL8DKtM4?=
 =?us-ascii?Q?vsiWmT/aMVB8g4FLZYBTee+lCbEy7msODXlA5JSJ3zbOyIrxf0K3TYtA3Xrf?=
 =?us-ascii?Q?NNeG+neVPL8yZpvrcrnp9fGw5N1dy0EWr1ZeF+nrpup2ulvzTTpee8Fg2kSS?=
 =?us-ascii?Q?BS8XN70ekKtOV6sViGCG3BPgCYg52tM/6/yIEPCBhGiSM1WAgDcSsti78R/y?=
 =?us-ascii?Q?OjTq9fTuG9MCghLTh1+AKZTjw3ITOYA324JE+SOhJjemTEpAHTMh+dYRMdAp?=
 =?us-ascii?Q?5MYTjO/v/UXrJfaJTdAvXDyw5K2o0vdGe1c1ZFMoAg6wtMrc7AZPQ1Nq1J1A?=
 =?us-ascii?Q?pSBuDgFRnRYPtfrxxsSXSgG00PlnD3js7gLH/niURyR2jkxFyiOK/U7qgGcc?=
 =?us-ascii?Q?TANQw9fBvCO3SZNTJCdfBYtluVtgT2sSvFG4cAXE6i9j0RygySg3x+5J6bAn?=
 =?us-ascii?Q?PP57aflNtaRnLSwUJBCVfImXkqYrHw9/A3a61Cgd/mzwaH37NOjiXePFmSoh?=
 =?us-ascii?Q?cf5yPI7yYHSQr15zvTIh8Dh98dIR7Bd6CFHI12G2m1+YvzV/lbOXnpNoe9Dt?=
 =?us-ascii?Q?pEIyNEosSI5sxw31YCv/l9QRl9GG4n+aF+hNn4DFiCmr0vShBY+E5NmA4Wcv?=
 =?us-ascii?Q?BJU0sVC8jNDTJA9mu3Ie24aWF48kN2QAR05n5M8iLJxlfO2INiXfQC7bp5Iv?=
 =?us-ascii?Q?jhcSqRGQMST03oix+XfUDR+XfLHMxucNQ6OQK5eHTp63PY8FzkulucnwzCS3?=
 =?us-ascii?Q?7vqZdQQ7JmyOJtmF1TE8nZEQV5j2MZgVLM7RWYceiSKh43Nl11f5KGVVCdbl?=
 =?us-ascii?Q?kXwJfaM60seIKGOrQ5doRnQBe1cUtzPXAKX05Vo6YYzMsjA/nJSDDdGr7/9s?=
 =?us-ascii?Q?z8KHgHpT/40KD77hsiis2vijvj09fpcpMfXiZ7WZnSkqFnRXwnx/p7/qG/tH?=
 =?us-ascii?Q?NgON3CQWJv6ZP1pXn1Yi77sma9cOerUA/1/RpPAMWZMhGtBax9QWJe1pvQgE?=
 =?us-ascii?Q?7J13EjEZ9NHyATicuMZPG/zdD8G7m2jjGDO69YJaWxfpe57S7c/5QPkpDatP?=
 =?us-ascii?Q?WcN5Llm2iH22crftwAw022gBc6x3QLH03jonHemg0QOHuD2xRhMJ3gOKKVza?=
 =?us-ascii?Q?kNluIZ+GCT5FnfmBSO8/dL+8xrIwZMMOxDCLFNpI19FwGxR5jIxwhyh8+HtG?=
 =?us-ascii?Q?hmT++gx/8fUJdSBEczzZG91kFET6iHdw0ZIokLVS0wdYHwQHopM75MkdZkak?=
 =?us-ascii?Q?R9Z2csDWhxDW07I7EcnmRvC9vv2aGsDiaNrP+4Lp4P93514NTJYvaTKwOtlK?=
 =?us-ascii?Q?AnLkWoiFAf5m3bxDIZ7V5ExKIHX1FKDAb/jpObT+57T4dJk+iGNX+hFhB559?=
 =?us-ascii?Q?i//zaU/xBWIcMXFKxFG6lAUZW7ojZ9eYaTyzo0LcYe2TV6u29RYEMYQvWgX9?=
 =?us-ascii?Q?f/idPpCxQ5Q1WDmnfXlWXn5NcsWWtEOy9ZfxPNHM34mdOYkGelHb7yeuSpmz?=
 =?us-ascii?Q?/EKsyWMnXke1t3RecqGD8QWTZh4q6qcnc6/qb7k6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650270e5-57a9-47b0-d784-08da90039d81
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 12:30:43.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfE7oaut1JFajaCePDWz7l2rElVYKGbL4Q6+hiKbicC/D7G63ORjy0Znk5oP1czh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 03, 2022 at 07:16:40PM -0700, Dan Williams wrote:

> +	pfn = dax_to_pfn(entry);
> +	pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
> +	if (!pgmap)
> +		return VM_FAULT_SIGBUS;

I'm not sure this makes sense to me, why do we need to hold this
reference here?

The entire point of normal struct page refcounting is that once we put
the pte we can have the refcount elevated by anything

So this can't be protective because when we get here:

> +	page = pfn_to_page(dax_to_pfn(entry));
> +	put_dev_pagemap_many(page->pgmap, PHYS_PFN(size));

We don't know that all the page references have gone away.

When the pgrefcount reaches zero we call from free_zone_device_page()

	page->pgmap->ops->page_free(page);

Shouldn't we be managing the pgmap at this point instead? Ie when we
make the pageref go from 0->1 we incr the pgmap and when it goes from
1->0 we decr it?

Otherwise, what prevents the above from UAFing?

Jason
