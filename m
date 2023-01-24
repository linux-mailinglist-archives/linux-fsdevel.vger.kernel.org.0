Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCC679A61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjAXNq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjAXNpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:45:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24D47EE3;
        Tue, 24 Jan 2023 05:44:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvXZnMsA8pHUsAGe551sLXh0MbVCKcZWFIHzsj50sItvlsLUhXPRwYTl/yG40JA4HwLhT/qBwV66OHIkv5s4kJD8eKdA1TRSeikgqGXqNlXuSsY61wg70yt85yyea9ziTztoiCKRqHIW2E9QZ143O7UgIOgRCYhNHx83DtUbjZtfyzzGGbiXPDwZCGadaw+l0/DktwZ7z+dBdTPbalZVx+DvAqHZN4SHv7xHONFklGqFYSEguZnPHH92kiwoTHqYM8OmMXQAYy7MBQiBSONBtV/8Cgi/GCO/0Fgc3J1AiEJpb6YrCANL0Y3wF5cEc4Jv3S7nfU5P5sJLJO2BcNA6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeaEBHG980ovNvnkyFcVitfAuITfVhQYbiWU8YTDtt0=;
 b=a+aAmXN5T60p3KepaoFbV1dS3/LdEQPBou2wR1riUOZUDsSIr1xnXtmjkErlGdp43sv1YQIogPigPER8EXxwtoEOWHZxe80MvIMKnwGY3I4EjWQdeaxHFHI2DHlMkbzrSMs0Q3x6iDInKN619rEeDqDcd+tpUi/954Xt+F2NLfn4GVUFinipG4+Atp2CZbKOqPG6KgFYeO7JAxcFgDDD7SuLElwbVjAJdvWNq7wOZ1h6SSN7kA7mqpG+efZRWw8w/T0EHatV7eUKam3lcZ+LhAOMIGjuBI4Rx25v1QawoBIm5UCkwPbknvoXMR8XmKuHL7L8GtqJQItZ856RfvpmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeaEBHG980ovNvnkyFcVitfAuITfVhQYbiWU8YTDtt0=;
 b=itTicEKOTsx8L+TsOYYRirqFAruiK9gpffzbFdZ4Z6bOYu9Eqah8IuTelTmpouhFP4xSbChNBWASswV4Iox/3SV9dhP9V1sNPsivD1GIbxXVBz52Sr8GBy34VGOtzdzIhtYEq3tYZbt5NPVq6UujfUZh8IZawqH6eFYbFIX5G7/ewIS44gcbLgZJF4zeTGkQmCAjLZhU1AXMtVEFsQDyQTfrHCDoqK/Y0ZmGdB351+zaTP7l02D5n+7JW9wKGOHxZJyYlrkIcYeNaKOC4mWcbDrtUi3Kwcez0CYFOtQmGAkrj03NJ6T0R6RbX/pCrhJI+VeNLLTYxmFrRrp9so5Tcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Tue, 24 Jan 2023 13:43:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 13:43:29 +0000
Date:   Tue, 24 Jan 2023 09:43:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y8/gfyonV18PVkKU@nvidia.com>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <Y8/ZekMEAfi8VeFl@nvidia.com>
 <Y8/ajxH0PF8PaiA9@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/ajxH0PF8PaiA9@infradead.org>
X-ClientProxiedBy: MN2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:208:178::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc769d5-e9f7-4aee-1736-08dafe10f9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDRuOekzhQNgwkLnOqoh7U6w143nqc9om5clNoK9ZMo16x6pqz877ASdgFonAvekhBEumt1mqZh2bH9Lw5opIjd9V4NZ3Tkac4TzCIh/PcQhbdn1DOZFrIsyMudTPPTmNAjeODmAd6RZdvdv13/Ggqgzo/4oVjK7dJD0VCFN0QTa5F2UZJve2I8fi4w0tG+wBgpZF9cpSQu7T7m3H0PqSOctRn0lqmHA5wH0MR/g0PxFqwIaYj0xNQCE+ASRtHHOm2mRpFWM79AofLeOfk6vSJCkLL0+WW/xFy0Qy19Zk62kHdRgfq9U3J8Tp95w74L8z/qh7eOC3b1mwW6eSq785//Ex1Kgsf1KIEAo1rPkMrOdTRdFlvUlsXcPc5SBarVg2ASLr/zsr2dIB+jWHntAozqallCiQY0enFU+G9FMfoVjPYzLw9363BOHrVzlkVwJls87gOcN55SxDBTWwcP7rZkR1vi1yr/sBxEgwhChIAQWKzIautNI6CYjzQcBaGUn+DVY66h7XxvyCSF7aOifP7KCMyVIldb+hMcfWecGOu+OCgXWIgXgbqOEtjQ3RELD+JcJFEYf87wTm8BTUeVUUoTZxyPReKSCl0cvlBvOkYwUHZJvG74Z/uYbtxir21vhsnHkXKQ5C00CSNy0SYGqeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(36756003)(86362001)(2906002)(7416002)(4326008)(4744005)(8936002)(5660300002)(41300700001)(83380400001)(38100700002)(478600001)(6486002)(66946007)(6916009)(8676002)(6506007)(26005)(6512007)(186003)(66556008)(54906003)(66476007)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EU5Y9y6k4N5a2kHkxWueNuOQCzNM0fdmdayaz5omFN5iO6FTjjatXRHGl2SS?=
 =?us-ascii?Q?QuFPEW1r0e2U/spKFuHsESosuI8HVvrJl8ZOFx5T+E/SlJMgbH3qidIk/yTT?=
 =?us-ascii?Q?ztRGlOJc7cfLDGUjw5WtzPkoNDEbC4EFCoB9U38JEqOrry9O/8Be83A2byLx?=
 =?us-ascii?Q?M90DPzem6a7CHCIOIx+EG+GI2C7zuS+38Cb753aEyhXruzFFGVnBdbcS+IYq?=
 =?us-ascii?Q?O9MCwh9iUhk6Vihy0DtY+isFNSBsiGtz2jcYhHJfEEvqcqClJouYQUDW67zp?=
 =?us-ascii?Q?7XOfU+ICOLf4f+sMzZ01m/aRt5xO9ngCaxPpEfs1TCWHRM7gCBxQGShYyx0Y?=
 =?us-ascii?Q?zX8SRvEIX7+I4MvpGo7m1pFMGvx50AaKcPZ3PgByC/QLvUnxpj3hq34A9BJM?=
 =?us-ascii?Q?Yl53b6BI3TBs5d5bf5+HnC2Qfe80BAvC8nUV5qWlX8MO9NwAIFWjmko31pd+?=
 =?us-ascii?Q?hOM2JueOQvVJ64RmMw4RgdU4k+gratmGnVaM8lRlh691f5H6L7WUQT0XyFgo?=
 =?us-ascii?Q?EYg4qSX01NJ2X6ah0vj3flvB8aRerNmXPL/aMkJECAFbGephOky2wpgUQMQn?=
 =?us-ascii?Q?MEvCK6+2925Y/lpczNfLAwCivuAWAL6QI/iOB+M6fca5fUVnZPYSqlxvsjEo?=
 =?us-ascii?Q?lxCvZyXhhAqn5LmMVWvlgSLw+Er7fgHK2vdz+fcpdUM+PvsM/KM8W6nA9ubN?=
 =?us-ascii?Q?J/yWtJ83dgXGraBPYx4cs1CzhNqcbQyWtjSPnMbu6tpH5eXoMjRPUBMoz/5F?=
 =?us-ascii?Q?cJVNLIp6Xl2ZuPMSO+gbQD1895KL10ITXnbKgmYNjwAY2EbJtjdPPF+KU+Te?=
 =?us-ascii?Q?7nZiSON9hQ7YTJOb1bBTUI7r06dDB6wtUUwshZZvRpByIXkvAMGhhuTRbDt0?=
 =?us-ascii?Q?VnH2Qgt1jhlmZggTHxsKkVvLZjJvJwmwLYsjPNIelxTbi1FDEDQ430YAE7v9?=
 =?us-ascii?Q?1b32ghst96AUmb8o5js2YezTID6JFbHQUIvMXhZEBhN0+AkyrR7toNqdodG3?=
 =?us-ascii?Q?IR4qnHokuzjCT7KwsGpK7YcjIRv6/U4H0141kMAHEk/spvlEnABIH8P7swXi?=
 =?us-ascii?Q?fuleDedaszdyR9KHSYzP0jog/mfgY1Xn/xDgJul86c8RA/TDVyNyY44qlbR+?=
 =?us-ascii?Q?DWZhlI3AmN/MvydyIDIKW8lB4flAOMbn/tfdUuflhdzN+ExLOSq3oLDcP2C4?=
 =?us-ascii?Q?AwPh/XUvNosOahkJ/cbfsyWrJcVlVnPEA/iBGHj0dot5G43bxcHrak4E+UB0?=
 =?us-ascii?Q?53+wsjkzmRTcY4sUXQpKx9rDZheARa4yigRh9e7CqNyyOCV3RDsmJUu5WyMj?=
 =?us-ascii?Q?18SVwuh+PV05Wykzk03Ejuf5DlSBmZjJof9iTWIy0N+GZgHiW5d2Ct5gPj4V?=
 =?us-ascii?Q?/MS9cYZrPDRLFwe88JxKbdL6dQE/BCnUZnF7KmzeHXQ0WXpl0JOpZYL1MI+D?=
 =?us-ascii?Q?/gnUAeyE4H1pBZwBoj3oguE25nt6vepIbeoQcXNR9FSD0mxr8B1EVkXbKlfv?=
 =?us-ascii?Q?nHFxXY2DyA9pgEbH1TZFTjTkG8Tq4LbS93aGhlGZ7/BepsnSfQrhNinD0jlp?=
 =?us-ascii?Q?tcgDRMTOkbaoxyYARfTb8qSFJJGT93TWHkBBUjSQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc769d5-e9f7-4aee-1736-08dafe10f9d2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 13:43:29.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7prtQsKRAP7rfoycjVtcrfP1/7tpDiHIt5/EGrP1TAYHGkFiCRfx8Fhtm8akrILl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 05:18:07AM -0800, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 09:13:30AM -0400, Jason Gunthorpe wrote:
> > Yeah, I already wrote a similar patch, using the 1<< notation, 
> > splitting the internal/external, and rebasing on the move to
> > mm_types.. I can certainly drop that patch if we'd rather do this.
> 
> Given that you are doing more work in that area it might be best
> to drop this patch from this series.
> 
> > Though, I'm not so keen on using FOLL_ internal flags inside the block
> > layer.. Can you stick with the BIO versions of these?
> 
> The block layer doesn't really use it - the new helper in iov_iter.c
> returns it, and the block layer instantly turns it into an internal
> flag.  But maybe it should just return a bool pinned (by reference)
> now?

Yes, a bool flag to the new mm helper instead of a FOLL_* seems good
to me

Thanks,
Jason
