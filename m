Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C45EC35F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiI0M4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiI0M4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:56:10 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156A161CE6;
        Tue, 27 Sep 2022 05:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYnVKPeiwcp9MBGdzqwUllUgqsXKcpsG/uSGpqPCVK+zMSFFUPJYSpf5XtsSTwWObpfDjJ3EXgOWP4IXcj4c9cKrqpfZFeeH9P150nWvatzfGDhSKVzJhnMLScQTqB1qsLB2dbQVvArH+Kzbww+aOJbcWS0zEgbN3Q9vXmc8aEN5gChqY0IdG5Iz6Y8s6Q+KlmZUNwIn47cKmZz2pZQJUg5UsUFvBTl2Mt5fpP+ZjpZtQ+Ib3iy0FcKHX7K3NvQHVRln+XeCctCFsB1CZa8lWq7K0FFXOqRioVte5aOq3JLBq6bFKG6VmOnE3hjJg8a+4be/SGECCIziKS7CfB93Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Lb9u8Cp/A5gaaVEuaeOB9FvzXNw71BbMlv/Z005r4s=;
 b=ZOyDeD8JFyFze5Sl23YAz+hMsKfWK6wAARhf9AonaacJRDJHtCzHtko9iJgJspfbV3uiu9WJrAc7mg6b9S/+Q7qV6bPqrCMSDlBW4BBKx61sSNebeXpOO7owit3dldvAxU103Ain/sPwp0PCxyr9u/zMkcqcVc+kzVDippi/nLYuz4OZF3YaNUoKqb2LYNcu/TV+23diQIcUX6YinfTeRUhV0k4DEOoSGNZiOFuL5ifbrp+rGKYjfpehF0cFAxYRH2G1G6EazHeVzZ8Rj1LeBVF+zsjuFAyahS7ieirQolNjTsQQnaMceI4cH7/UvWq4GBevcS/7Cf40EFTGU82qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lb9u8Cp/A5gaaVEuaeOB9FvzXNw71BbMlv/Z005r4s=;
 b=dmBV5IfKLJdpU7e/6n6KtXFLVOFQ+rCBPZXCAXdemseqShPOhaXd3WSm8fVzNgxOhc9BYw0IDOI4b+LCe7GBUUB8koYHn7gcOzshqExt3EbRkKaDZQCE3vWatn84ymwjaQzSr/qc0lpnKzB3Nsm9O07CmdYNv07CibIQQhySUUXlK/CVdwgzSeQIlxwlgx6yl925ERiO8lgIRraD3TjIFXaISHlNuxGeW6JOTEcd27YWxXAxA5e+6Dt3b2Ax9yMcHizt/fRWy1dXaUMgFS9/sN1PLvasoRNxRZ9Dsc9WtwWcLkunaXMVO3BaRjQDaBn/lwzcEL0gGGpUheY78+Faig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 12:56:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 12:56:08 +0000
Date:   Tue, 27 Sep 2022 09:56:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <YzLy5jJOF0jdlrJK@nvidia.com>
References: <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
 <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy2ziac3GdHrpxuh@nvidia.com>
 <632ddeffd86ff_33d629490@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy3wA7/bkza7NO1J@nvidia.com>
 <632e031958740_33d629428@dwillia2-xfh.jf.intel.com.notmuch>
 <8735cdl4pk.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735cdl4pk.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BL1PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: f150e07d-f81d-450f-a417-08daa087a527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euKJ4srsOB96gqPC8nLsvBLT6ecr++Of4KncpemlJs8ABVhNrrx0ieM6UEifl63hnjqhgXdQ2sQtWAJMUDbKghewxKWRDtgd0dKtiBEBBXDXM4EkmKZrA3Hag7gpttG1OCnlbw5AtViq5VjyPMbQ76lVFyw3v9947aJop/3UPTCiWi5xvGP8M2ZrTiMGvsEq0OZufKHDXMUSJgjeVw8xq+vJKMwo75ze4Hb7StBccmwsvQea5PkWwVgsaVBIxI73TfDqr7ja398a1DFOy1Rm4q7fGDoIAppric74j5o5TPJy4PCciToLQ8m9gHP5ugTfy8x34cthSv39sNlg10pj+k/Ork5KOfZnb3muXaicwvXU8obJiHxTZ1vZ7ko+Oci6tdFxoS29/rG/ST2sCOf8ThZu6HmAV87fzkIun+z7RHMGnwH2jHxZ+DdqKDCbBeXwWxXhp8Il0l7pTn913Lr7mGqRnXe2FNYbubLCymsKfx4PBf0wvY4P09TcJVlnfUp+9N0W+902ZK28KXEKIsx7YwrNPGB8jqLUMtDBpIcbRYA4BP+JeSLwaod9wN8kyEv0ZW68dq8nsJAYtFKFn7h8Mw+a47X8vfPvvvHkW8xfEPGevqI8txVxW9F30c3GgQkG7TZSXt1RJ34X/XQwNoH14oaO8n/+BD4rmnlaOcOXzR0KXsj7T+YATSgxnHx935u5GrEajGqkDp5GWFlv1bJ7bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(38100700002)(316002)(6486002)(26005)(6512007)(41300700001)(2616005)(2906002)(36756003)(478600001)(54906003)(37006003)(7416002)(6636002)(83380400001)(8676002)(66946007)(4326008)(6506007)(186003)(6862004)(66476007)(66556008)(8936002)(5660300002)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJ/5fr4FtyCxmq3Y7AFkHwCD4l0oNOmksVkUq1Xd3UcftMVEZp1A+w+K8UZa?=
 =?us-ascii?Q?RQFPrYZlPR+DAOMSXWv6urGp6UkF8r2aSnKGbNNzC93F+pHZ3RzIDnFW6XLK?=
 =?us-ascii?Q?KrauThuN/eq0YI1z4WJnwucWszVdN5joI02Xv+92Zq0VARPw5J7FFjc5vCBa?=
 =?us-ascii?Q?uH18kjPy/nvSt61H+kR1DEdgXJwa6XDQPAusjy9J8/j5VYKbzdRPljVLyQlW?=
 =?us-ascii?Q?L1ByDMpknDcngdOvMgoinSf2FilbnP+p/6JhV2PgvYZTMsvev06fvpwnlsRI?=
 =?us-ascii?Q?3e/OAARWSGNGFU2VTifcIOEnOV0vq+1M7C0QrTn7e58/4zOcSdS6DOmY52n0?=
 =?us-ascii?Q?t/Sce0BkHCKhuGm3tpa06v5jtf7uUGI9pCZTIwESyjuyFnjxovcHlDQTpIeY?=
 =?us-ascii?Q?Dx+99bs2pQIxcPEUOnz9hEoo6Oj15zdRU/MfKfTaFjsqU0pLBvJJHwE4hjlw?=
 =?us-ascii?Q?klnFhbjiVQ/M3VYowm1600k1uT6TF7D6YHZfXRyxrHb2RXBWUi9PHCB5bLZw?=
 =?us-ascii?Q?sqC61YgunFmjteVjUE9gT1ZECvv6rGnKX7WdsuM0Lizubs8n5ohrv2WvyU7N?=
 =?us-ascii?Q?D+Px6IxyxoPVVxIHFYEOoUEmHVIgWGJLFJzhrGoIJmUpPGg6SCpmtepX0iNg?=
 =?us-ascii?Q?yNPB0lgaTND8YV/O0Naca89zk5z4H5I/RsjzOZcuibEX5U93WRo8Gwx884zO?=
 =?us-ascii?Q?g/9Uaowl59pposl/S2YDou4E0vgT+gzW0wFOBJ9UekiXWwSlLvMqXVFx3OBQ?=
 =?us-ascii?Q?5TKPtrjETa7oTKXycCp30Li8qk2FQcEXP9ItdojTmzYYrO8e4iObrwziJIpm?=
 =?us-ascii?Q?eLXLcdSYJmEe55cTUHJrpo+fMVHzdhZY6a+zPGhaSx8K0iW+d2d5H+6CIhvE?=
 =?us-ascii?Q?ntu89B2puvfdZAuOhGrahJW5C6mILZgMPCP6gVl+l2ewxE3uE7upj3Ba28c/?=
 =?us-ascii?Q?evrNhdVNaqj8PbpxQtG3uzN/zqAQzRkQWdahN8bEu1RBpu1soTLQ058tk0eP?=
 =?us-ascii?Q?FQhGymIbqbvW52H4R/Hp8BEGnWlHjSqcN1usnAYsTMsfuc276jhtWs4tcHTk?=
 =?us-ascii?Q?7DNhiTGJbswduQI6EVWDF/VdDP2hWbYOskyyTBX6R3chGeX0OSCN0wTHvHy4?=
 =?us-ascii?Q?fwNskmUku2lwHDjmb7V8zCoTCbOqysNOvArQJN8WKv9SXWqJynC+vV+4gcXq?=
 =?us-ascii?Q?YXlqSNKyDPjCn4JnKG6t5jImgI3FD5tL48IDU3XVztgRsT8f6w1JV6p/Jo3H?=
 =?us-ascii?Q?WPRD2GF9iWxMQjrDLDEXrzjg4TcsEf7Hsb75rZCXG6SVEp0LrBSgeo7L3aeE?=
 =?us-ascii?Q?nsZjq3EBY6qu+lDABQCUJu8r35ev3+qccxP3qwx8liH9UN6ec7HNjHtUj3Yn?=
 =?us-ascii?Q?bNHWIT3SfZdzFh7pgc48sx4up3iIOuqrv1KXV3Imm4a7S4a+C4b5cQPYK8uG?=
 =?us-ascii?Q?v7QIXX45r8tNbJMy4is7JutkMk67/xdcbY3r+5WhRgd1u+RgFEIXrGLdX7XK?=
 =?us-ascii?Q?AvqctkzqYif/K+rt3L1fxPtOBh6rgD4GOZZPbRNbGWDvMB/ws34xIU9KFHeA?=
 =?us-ascii?Q?2/Y/ucul2zDP+di99RM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f150e07d-f81d-450f-a417-08daa087a527
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:56:07.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9/pyBXAlUusqKhj98TYbqZ2hgg9N7QBpEAoIvYlwxb4onfOtMp1pas4jHQOUdRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 04:07:05PM +1000, Alistair Popple wrote:

> That sounds good to me at least. I just noticed we introduced this exact
> bug for device private/coherent pages when making their refcounts zero
> based. Nothing currently takes pgmap->ref when a private/coherent page
> is mapped. Therefore memunmap_pages() will complete and pgmap destroyed
> while pgmap pages are still mapped.

To kind of summarize this thread

Either we should get the pgmap reference during the refcount = 1 flow,
and put it during page_free()

Or we should have the pgmap destroy sweep all the pages and wait for
them to become ref == 0

I don't think we should have pgmap references randomly strewn all over
the place. A positive refcount on the page alone must be enough to
prove that the struct page exists and the pgmap is not destroyed.

Every driver using pgmap needs something liek this, so I'd prefer it
be in the pgmap code..

Jason
