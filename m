Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE275BE913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiITObw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiITObu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:31:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FE286E7;
        Tue, 20 Sep 2022 07:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjy/4/ZC4PVT5PSsuoR1B0uzK3u5Mgx6BFawG7/HJ/ige8FQFajXSYw4uhq7w4X29plriYqQc319gnOGen360XM3jst4rxPR4+ycUVJ3J7vNogShLTFMY14YJdZaXqGGtTPs25kB52Efv8434a6D6Yh21CsyGRys+6xhXAWxglYZX2jAzNfbKMecXYbeihfGG7cQYIrvJCvkDZFNMUGEZ6gpZ86AheVwvF2K5zdCRNkW8Mw8WNdi5q14GjvDgVt1qL0YdMuB7jUN7pvPr1o2yfnaKkutof87/oRLkTu7xw3MMMLbq5SCXGYfxIfYGr96iJJOKnwxUoE7U+RP9W4wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDsQpYNxDD2GqwJG7F3KSLxoYbr6RroQzx7f4K1MQTU=;
 b=eoyL5aoBSS6bN+RCEuPKrukE8oiLeuxIYSIHXyQMTy/KON1MMUhGJYEHl1Z0bCI44LVGgqq094+NBypOv10vf0PPVJr1tl4EkbsL1iTf1J8pxZL70RU/qR6eHj4aNzCGCsiusckFp+CrIz56rQeG9jZbfVDpf3neGlPx7Koq4T09UYO4/x0phz2qc8ZgrKlv+OfYzTDi3mak8IHSxzdc7eWCsfQzD7KDLwwn94zagTpM5gqc5xqa9fcc7rNvfayM9MYYNRKSuWSRC0Re1GsxDqR9iBh83Zr1ShRxSRn9v43YtuAUmEb0brF5z6QzSWArHipc4N+wD0rIk75oQ2Gi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDsQpYNxDD2GqwJG7F3KSLxoYbr6RroQzx7f4K1MQTU=;
 b=UqBg6t+52goBTDv0hUOdf88OAnwoMcwG9EOFu5+I7kqlG9d7HUq0p0YlrZF/1mEo3yUsVk3F+JUP75EkpTWyyYCoHEMKxdLINy3XOgXxWkB7I1Pm5F8fM8FJdksIeXmxTGQtDSvLsvLhFM/lxnBw34Ey9Dlal58V1FYwJPYeJiculhT7vq4HYgJc88sp/kGu5ZweSV58LX5memFTIzpU/7PFPmXmIH+B0S6ipMYnoim1hOpQ1x8u08l6qxy7xz5Hq8nmBl5FxhQLx6GVMSfk3mjD5OQjxMTXaQH55iykU6PZnjfshbJHXA/zOHFf08Ns9KIl6lQyt6+H9JtBpq7rCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 14:31:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:31:47 +0000
Date:   Tue, 20 Sep 2022 11:31:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 02/18] fsdax: Use dax_page_idle() to document DAX busy
 page checking
Message-ID: <YynO0Yse0hh9mdyh@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329932151.2786261.15762187070104795379.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329932151.2786261.15762187070104795379.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 1872365c-f96c-4b5c-5466-08da9b14d945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaqAeEZX0AY+uX5tgTh93jiubXUeFTQqVBbUmsULD6OVqWbRT+3g+z6xpVZ6ZO602hhAsunFaLrvCCWYPKuyLpsnvyT4INxEy7zKPo875Bx5j1DzgWV3E2ra1/WP50VRgNvpcOT8r8W9mCyFdwUsuxD31VR0XyQuSTSGMOwPRkxvmG++i5B/cNlANxLmuH+6rRzQAsuBQcxD+QggO07l0c2Q5q1VyinPnIDPux7ep8ipNNz9dQH/9ItzUuJ7wuwljXKjO/1cMTN+rY/Y/x+PO35GhpobzxlhrSDNZQCYETnmOwU2x+yCy10AJkYMI5uCAOrUr266+DyZKVXQOJSipmKiMc498gSNSE9GDJg92S0iDEcIJ72qwue6KIBMvSJ42Kyj9ytrcJ7EIVq85MCDvCPVU+eRIXhCNzs/OMvPdErfza4Un2bHMQDtWGEY7zBPtOyHkP4/hxkUu5lclHUn/1O+PjF6QWGj/EwJoFCSAHVius69PgZAWQndc8MABoFjB0es8fqMjiUl4VvkswOAKkJE9A4LRUGPDSnncmr6y47IP2Pwd0OskmvLn7jn84dUibS5xAjPqdPOzq6mduHtbRYXUq0w+F8BkUIDK9mR01w48PPIZ7LRYdY1kR/K8fX4M3hIWpl0M3I/5VQQLptgs514E035M9TCWt1zGmbagTE5D1B4xOc0Ns+aMM9aDDTTCXWIfPodZxJaNszazXEc8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(38100700002)(6512007)(26005)(6506007)(8676002)(4326008)(4744005)(54906003)(2906002)(2616005)(66946007)(41300700001)(186003)(7416002)(5660300002)(36756003)(478600001)(66556008)(86362001)(8936002)(66476007)(6916009)(83380400001)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDnYb9ebqg6rzzwXtT/Ue4+0+ztlaO5Yx25yiXAFlEFYNImtwYpNX69lA5Kx?=
 =?us-ascii?Q?i29jq+mo6sMxI/TBBr+80u9OPVO0ZRXXUlGsaQeQTLTSwm4GuDTnX3Uujar2?=
 =?us-ascii?Q?IN6mdVaaaeJ0VP12qTHihUntOQrAPvZIHtAw8JJwwGseJp4vHsk/NChLn/HE?=
 =?us-ascii?Q?Q9ssuasN+P+tpo5mrDy84T3Qgi+X98guZQtdwK48z8J1/P2wdS/Dj4DagYS4?=
 =?us-ascii?Q?S/6liuTJIZ5D5Bo/O6RUH0CCuv/2IjxtliqjJvHmPXws72Qbdi4jUu8WGQ81?=
 =?us-ascii?Q?+nfM/5/ewGIDwpAOSYh5eZKmzcDozPZsnrDBJdGkQ4h2l/Sv8R7YjfZP2ZKG?=
 =?us-ascii?Q?l3H3yCdpGSLBFpHuqh9UccHej0+r2gcQPlVeKE1O4Ihtp9BJbTO78M1TTbr5?=
 =?us-ascii?Q?fpLo2fp+8DVHUYKp+EWGAMKvOjobCTyz3x6B2s9e65pxiicE6ZFqMXB9ODDF?=
 =?us-ascii?Q?8Ikc9SWEduQXfZICPtw3fmUoIM4Lf6hm0U8/fSyZkl8Yez5DTFdejPDRebcr?=
 =?us-ascii?Q?pwCZM4U8HWpKn8H2UKVlbAlJ8DEsz2kOcVTD/jHN2Wh11BRNz2BdFKbKVgI6?=
 =?us-ascii?Q?tgxyZ9XtV1+wv7IegC+kRCemsWg2aQxnGlex8qwT5JHg/FTh0NMUbHXtqNlq?=
 =?us-ascii?Q?U+tX3G4pENF1WGcmGJEHpnHJtYLOwqQfPSxYBnpbIs5iGMWc4bI9HrXHwnDu?=
 =?us-ascii?Q?Sr4XlJDj+P+NSxMCv5m/9xG9eXKU9B+r9I0qsm4r12HcH7NuvqtvZyY0ax4C?=
 =?us-ascii?Q?6B+gFRtZS0PgCOqdXKEivnxpO1uYI6+F18BtQFh/Vq0l0/YXqCNh7g8MeApx?=
 =?us-ascii?Q?ZdN/uW41pC7HQTAL1Da0XwvGcx4l/rhKjgdQykbMakihBIwt4iQ+jauaIy7x?=
 =?us-ascii?Q?UDBiQD/y46uKyTwKGPlOq596xbkJfChu7CIzxRoeww2/yP+gkPDJGAtsLj+G?=
 =?us-ascii?Q?/822MxJfGa8a9m0qOZIyDydTYHXR7Je4QrLzJgMC+dYv5g949MP/J2EGWUhO?=
 =?us-ascii?Q?GkPfS3KLFrYlpuXRMjGW3yqak91cUsVPIlFFMafqs2f1EL23O6WiP+MmWfYl?=
 =?us-ascii?Q?5W/nr2yu/exXzoA7Uq+iN0xFqZ0jBLKaVtC3W7K4BXU6fqVL7vaWpv0nrqX0?=
 =?us-ascii?Q?HXO9N/uPYyw9N9eBIQUVJQfdnDLZWfSujB77OA5fiGpYlryyHnFlvzZNgFl1?=
 =?us-ascii?Q?sIJyfANlDTFLl3SLXdlsSaebekDQPv8hftI+PcnFTYHIu4kT2GW99VUd4tE5?=
 =?us-ascii?Q?BeovQ5wDMapy2OQKpHpRVPlBvxNCoYC+QMLTQxvTQgMinH//zWJF8erdtvkL?=
 =?us-ascii?Q?76chW1Pgn0YR4hDaeFuZ3P23huHfUMZOjaQuKIiBc3WWFnp3vOWsNjUv2HuX?=
 =?us-ascii?Q?5b6uuEHdWeToQCJ6NJCAczYzoDmuff+/CroFaMRkb+rB8ybQIaRf2aJfUcFA?=
 =?us-ascii?Q?rbAZXbdmNFC8d+shfQBbDAuT9CeVM28ofKq7RKomfiorvYsUUaS7htVYWSSu?=
 =?us-ascii?Q?SFcV/LNDtCWDBQj8XKGcNTIZcOEJ3I9l4VyA/0a9z9Nye9fzffzOCY/lMmhZ?=
 =?us-ascii?Q?HAimPzjpKXlq9tr8PlhFTKaPphBp6RdGKFldwQCR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1872365c-f96c-4b5c-5466-08da9b14d945
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:31:47.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHFV/bDnqirPSqyqf4LSPJCMvsP+AynYxK9MTTweDjN9WS1q1xeYttmiMmfS2VfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:35:21PM -0700, Dan Williams wrote:
> In advance of converting DAX pages to be 0-based, use a new
> dax_page_idle() helper to both simplify that future conversion, but also
> document all the kernel locations that are watching for DAX page idle
> events.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/dax.c            |    4 ++--
>  fs/ext4/inode.c     |    3 +--
>  fs/fuse/dax.c       |    5 ++---
>  fs/xfs/xfs_file.c   |    5 ++---
>  include/linux/dax.h |    9 +++++++++
>  5 files changed, 16 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
