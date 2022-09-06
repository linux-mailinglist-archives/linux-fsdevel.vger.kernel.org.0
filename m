Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0025AF2C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIFRfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiIFRe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:34:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ADB832FB
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 10:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idQK7I+jwmMMtxBrdYASTPIVcSRXXUxPKrnwQAAc+Lxv7vwrGNOvSfVl7PpTOknATFFF3WJsjx92Ez3UUWuPoM06z8cTIV6Tr7TfEdQYyNtNtnM3L9Mu4YnrXhidGqJP8Rs03gOch7+D2QLKToijoALAL7ibkfMFr2hlCefPch+PFxcPoYfnQdk1O5k5AefGw/Z7XlrdGeNnhZZ4EHIFVYmlC5ZzsnPoCgP4qWN5oQb9OYxTeyHjTHdlcYzCgyRU1UKjBhlzJYqoyytSKM/newuPII/XBhbA4w4vThL4ej004bhjnPr+WMIEOD8GEnWd/VBnKYlDCJO45V94syz2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUITjiqjAmUfuvHqNyqD0pCALp1Yk7cxqDTxyl+VoJg=;
 b=miOUpKIkvn9b6/JXfx4CRKDyFJXZIEOIhSED8m7IUbSoozmfnR0VkGQvuZCPF/O4QGPrTGI02YdgEuyHpSaIDgJ2/5+KQwvTaC3UjOSfbQxfFGkDtCh342+zalysdqCo0AqAjRHg80apUluLV7UWw2Gb3GP1ZFP9aI76kMMFvp38EYUB2+8t2GHDIj7QU2alRaIa3zKa0TGdTmv7YB3opz2hsisjxu5iFgfDD0B4TG7pkRj9nOWyp6Z4eK1HiDt+xG53VaQhlvQeMJ2JF4gjb3os/DJ558PsEhnVtRalmwOvmxFw7EMHC7bGE5+2j7XBQJg/EPVXG66wzBtwbTO+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUITjiqjAmUfuvHqNyqD0pCALp1Yk7cxqDTxyl+VoJg=;
 b=TEN7DIVW3s5HxZRXWAi00kLvLpNKWObUSreAe7Ah7HmqKs0QOJcZI427DsQdKRZpCa1FTcJOlh+Uz82zOE4NV9PJrDoVoCndWWpOQYATokufrUP9lfmo6WnR1iqI1Oec+H8LdSDdfDeeugbYkgaHLiSlNKmOznGspoZPFSjv6XRPjj8+VRf7wihf6Jchh6kre+XajGneSkFBQpZCz+tN9VY26MwlHmZq//S/YyD4gLMDhtHrim5ty8bt0Sbqj4KhCtbW/HPU1omOyVzd7D3vzyjuNPB6ly74NkzWIr7adtu5cS+ahD4KHrcLzs/K/1ICkk6rUKIsowBXdgbRu5wvuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 6 Sep 2022 17:29:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 17:29:50 +0000
Date:   Tue, 6 Sep 2022 14:29:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <YxeDjTq526iS15Re@nvidia.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7dee57a-29cc-4220-119e-08da902d66d3
X-MS-TrafficTypeDiagnostic: DS7PR12MB5910:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joWHLbIzNXq9JnqRjBh9do3/YbG+ddD4q2tmPGUrMJHuhdWhqBL+XG4sHO2GtVGKfOO7eTa3G2SYVA3PcGCA4hnL4B90le/n7f92TBTNHBkFdZ0nGzGeS0Sez0K6Og21wTrfci1twcbpwukkLQB0VVd+lr4kAmPuBfipWKP9C8yI0SvybtMo2uuWduyYQhjggBxyqHIa2VF1WLUCV1Pl7tfL+svXeGfhmGxKijQedfQDqVJnoXbBBKjlaF8kjajo7lMs6j/4GpvIa2IU+SMWpf8rbM7Oj6pR4XUrKxEyTJOTPSQD9kCx+YtceZG2uynDgOcRwenjDCdXkccb6rx721VM8QmhmYwwTFcC09MpQdsjBWVEGhuvuMERGCre3vg85Ww2o0DNbHUsAYl1gIBfGJjpTYIQjoQXLu/p1PDphxUQE6TAOi8Yk7VDnZ8OSg8VMqT+eGdEMC45jaa/9DHFau8kcsaPwTALHJO94lpguBf4/FE27hS4xb8VXB1ZuG29qVOyAP2Ap9SXGTBUO88hLva2+EQOAiUYGPzwyi0Nte9ADiw8rOamYQfribHGCmHV9S5z0JhlywxBhtF975ftSnfbIC1A4XkfhjjewfSmdNvXaGmrZ2BGgMWcXvgFAWGKxPP94Rbg2FnFH9cSt4wlmMdmOAvOwHBZmpYxolzHaJ6qUh/oMZi1qJeTWWBYpHSQGO8qG8fuQWEicqz7DSXbVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66946007)(4744005)(66476007)(2616005)(66556008)(5660300002)(186003)(4326008)(8676002)(26005)(36756003)(38100700002)(6506007)(316002)(6512007)(41300700001)(478600001)(2906002)(6486002)(8936002)(6916009)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RcrDb/1XToED58xyWbRGd8Ijm/+xgxn62xcAi3nwlIlgABKXoA7myPS2pYTI?=
 =?us-ascii?Q?TF25AMKOLS6h1r+Ani2VTjdsZCsGvjCLXLRf6QvS4RyNEznKttRrFmAk4M62?=
 =?us-ascii?Q?XcGT06xP+aHlwnoHlJtBhGy54uJLCpAg0/Ufhsl5/pQq7m+jMe+QyQGGhJQi?=
 =?us-ascii?Q?W5Y4cPConSL/qNguywZVyh5Lfng7N6mvvdZM6qf2KbHX75wPmXeSmiaFTU/O?=
 =?us-ascii?Q?H4whok7GzOGHxm9uTb24+nO1yl3b6bDrcIGrZhmUD+2x1wr0NHsyP0BM3p/R?=
 =?us-ascii?Q?TyS3nL38apVOu1jjFLv4pqfwxXJtZcztDkdI8Yal5g0AgK/nVQUqCjcvOuaj?=
 =?us-ascii?Q?Tgo6w7ek+IbF5Si10B/lh8/KW8gV4Ug4h7Ehdi2YMZysqprV415UcPY1eKh3?=
 =?us-ascii?Q?FB66fyPPirD30814Mogttkf5BdjYn5CuhsxjXcOdnkJIRXLroy1pDvXR0De/?=
 =?us-ascii?Q?UByFNpbvICLGT3aRKe8bIs48um6s6Fn+xl0efXIyOhFEAWhywD1ca/zEb2f8?=
 =?us-ascii?Q?SN9jED3cek2hLosndpjlXkMHZdsRludLnAm4PpNVCZcg6xgDBpfBrqyYq28H?=
 =?us-ascii?Q?eiJFhc5P61vgS5asQjG287YcJXFyoJnssR+8nLw+eBg8hW0HEldvdgHRCwHv?=
 =?us-ascii?Q?8kg1cAD6y2M7T/HpopKLzqmsCfJ+DvlrfbVmwCtcEQzN+ophiam1aGzP0Ly/?=
 =?us-ascii?Q?l6zuJbELvn9NbLkjDrlfBNiXpKFmjn/vf8R984inOh8+o4OtgEmAZqvOg+qn?=
 =?us-ascii?Q?7ol1kuRTZpbVKg9ESW+eDWYN0Q/Rni4KCzvkZtKOH3drOr2eVWct3XknyDql?=
 =?us-ascii?Q?2D8m6+ucaAjDe04vYOh+l3zDEo15+cIbb0wtICe/0rZmsksJh09kKYtzvpqO?=
 =?us-ascii?Q?7EDoSVZR4fSih1Fw/5WmY598yTKUdEwtEZGNbva4dKJ+/jIfpVPHsq9MUQJn?=
 =?us-ascii?Q?ZpwTPPQTRkch2kxH5tXT5YE8+rGc3hfAMAACKeHxccHPNnvjdt+PcNSRPjsa?=
 =?us-ascii?Q?+TlAAT8Z1BeL63HwBT3PWB+aSOUoUz5MoAxIrTtOQraO6Z4gkkl/Yde2NrcP?=
 =?us-ascii?Q?Z3U4MVsdeE6FcRkSFLcJSJN/PGA71jiB9hafSKHn62Wzry8P3uxgWbNq6uW3?=
 =?us-ascii?Q?T7hjakpBoSA6RMgh6pZ6EnAw47Y6Ho55xw/YSddP3z02coD/G2ErTAw4bgyu?=
 =?us-ascii?Q?p8Q283Xfu5/m8jggWgV4NQQ8bA9Q7fS+/TxTTxzuknA1BJG5wXoWzzBCn0va?=
 =?us-ascii?Q?4AQqPalQjngwt95R+ZotUQ+3pDE74eR77qtabPwSSe/wt/fe27Tp/nyLIHou?=
 =?us-ascii?Q?AeQ6t4hcf35ug04jfwzwb5AzCMxddu4my/xnN22svqS1DoW1fkZ4uJ3mhOMG?=
 =?us-ascii?Q?NDFDQFUGovqrQ4nuhtoZpDvk6IEduK4j30XHwi7t2ONk5g2C0zvoMeuwYmJa?=
 =?us-ascii?Q?4pkrQ7ZtA/dc/E8rFAqMpVQxApSLnazaPlD/ngljHh/ZhJ+VrTLCEeOJDMPP?=
 =?us-ascii?Q?IGX8CFl3X+xrpgFCe8pGgq7IVuEuzxiYZMRGS5oVfYAcT3FPeT0dofjMVO/J?=
 =?us-ascii?Q?ko4xtOSdMkldd/IDN2tGR0nANvQD9Aj0Fy8gvUKO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dee57a-29cc-4220-119e-08da902d66d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 17:29:50.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lCF+t3DWO5U0JR3iGvf/exUFxReDljN7sX3xMKyqmXUuB8gTP8FOOnF9v0x5DEM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:

> > Can we continue to have the weird page->refcount behavior and still
> > change the other things?
> 
> No at a minimum the pgmap vs page->refcount problem needs to be solved
> first.

So who will do the put page after the PTE/PMD's are cleared out? In
the normal case the tlb flusher does it integrated into zap..

Can we safely have the put page in the fsdax side after the zap?

Jason
