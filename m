Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB6E4C8473
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 07:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiCAG7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 01:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiCAG7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:59:03 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C45BD3E;
        Mon, 28 Feb 2022 22:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTNlgkp3w5F9Srr5eAkJoFtO1iMHk7tFCIhHSUJpgpjb5r0E9hFeRk629OZdRLZ3j4f6u2AGMUY8ChOlQ8UqEM0EbZwF/8AlDZlMCnurhtMlgFPPKUobBuKXKQVchyIZxWx1r3RjnSbPZoNtx1n7jQ4LS3gm08EPjb1Bg6roCGveyAvy8iu2Vyxvzr/czDYgRCcTEieIJBIdLPVqhEm87x45pf7kyptjX2/6jajkl3NpJ/rMKHCkkzmlLNPqA4yQVJVkP1pi+I1xPwt7uN+zU+EyBax+VxNGlIAIECxzw4uSMXOn/6VyOtOQJB2+JAACrtF3nLxu+JxM34PZwdOfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WlYi2+z9qf/G5XR/EMe4TYAEchDotRGCA6kSqeG/mc=;
 b=k1SBkKH18oBRw1pRV3pLLuaxkprMpojWO6OsWKT4eytZq5Vib/DhauEEAg58FJ3w9R1W+HEM0sDL1vuEBrmCmAScu1tR97we3s1zLbDOBBvI6Ym0kwyoZctif9Ez+RRHpasS+YJZvwsg7ZwXG3+LJmKRKfTvFDYz5MktGCtDPyrUta1nlWmcO49UGNqH5VxgwBENTCfXeRIxKwT0vRXgnuJiBlVVqaeGaqm/VI2sNAHuErJqqsnAuozzKgX/ihysyQ8thpj/gFvnXFeHmWjEapy8yPLuFMFs29DTjD2O8Eq9eATu0TjzgLNfVZoUTBSX+4M5ohWUPf+E7kYvL3p4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WlYi2+z9qf/G5XR/EMe4TYAEchDotRGCA6kSqeG/mc=;
 b=SbFfm+L5ADlQ0r1bMMW/Ajibv2fk2wsB77LiNsikUeN5RAIEw2FiKewBL4uMGAiX7ByL+cKmw73Cxv/JSq147qZcb/VaTR9SZRc1OJtxTKC2pLkyTnXK7u3pfZc7+woC2YSFwXVx5uOFaHODHS1yXoA+SVYy4H1aL7sONhSyYJ2cvJh0GI0z7hkHNCW7yUFJDnx1ENb8KkY9vwFzfKQXQ/95EWif2h3QxtJg5FRz3QULhJsQqIrtVx80mUZGM3Cyg0YcqKGiRk5fz398h9KCFX8l+YAqJKGMCuf0Kdz1bc05KPUcVSda/mFvjK7fnbWFUjjY3Z0OgePfwhelKfW2iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by BN8PR12MB3314.namprd12.prod.outlook.com (2603:10b6:408:45::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 06:58:18 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0ae:d0d1:39ba:e4e1]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0ae:d0d1:39ba:e4e1%2]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:58:18 +0000
Message-ID: <938587de-2589-809f-ede3-76fba9007968@nvidia.com>
Date:   Mon, 28 Feb 2022 22:58:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BPF TOPIC] FOLL_PIN + file systems
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gary Gunthorpe <jgg@nvidia.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c6e152ad-2b31-48cd-3d5e-c109d24a0e79@nvidia.com>
 <Yh2//uwOCPNVZPKB@mit.edu>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yh2//uwOCPNVZPKB@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a81bf92-5cb5-46fb-adac-08d9fb50dd83
X-MS-TrafficTypeDiagnostic: BN8PR12MB3314:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3314BB26CF5C62B5BFD6C07AA8029@BN8PR12MB3314.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkpH2ocOAK8TAVpYbUlFprJOVdW5kNjRgP62Gx9yTdoFKH6k6x7KFt1EHDjMHskYuvcK2iulCSkX6HIxHCEFUXMgjg851541ib7OFHgK2eBjBo2+q3HhSQT+6RJjO1jDeJ4kNaDKjbqP4dREczXXOuxsP1b2wrvBPPA6ukABeTG73M/AwLZ6yhSbNGAXhJRzGbuJmVsml6ytgqRRiay9mRjGAe3uL5bSJRb0i8smZDVTc4shlu+Mh3jnDKHcdErLyDxasAvSeeQWJqNYKPpDrwdFyCfohsJmK5qKZDwwdAbB507Mr6dYhqQBgSwlGBfjGaaGDN0GiYbRz+94tVAx4gMEPVwIF6TRpPmN3uJ6Hd8A9HepNCpgIJB4YVFk5ORpwwVzd32nXPJZao8FhwqxbnBPb+y1cvl0uJIOYIFjhDU2evqepctCwtOfj50K3QP+DnswjHI39xqXMMIL4fjQjZdSDOObEsS1lZ5vAodWgzVBGe5M4JXAiSY+Ury8kP6BB0eWirWILzoai0kaGH/8DqJQ+H4w66eRYhF6jomyPz7BPR0jUxqkkNiA2Eod4b9UH8895zj20bsPnoqfvBfhowGPT0GMY6J9WjhFX2bK6TENYXcppza6npEwSdwqXn2g8Y+IPz0n30DsQBukTyAo4BBoH5Wzn1qbhF33dBORXithG160XlLmnYeNrcKbB+QHhh6M6yCyorGDoCjKvZYtEPvuQ4pPqsS7JzPoi+gzqCz6NAbWXe2woLJjZCFr1Hhw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(31686004)(86362001)(83380400001)(508600001)(54906003)(2906002)(66946007)(6506007)(6666004)(6512007)(66476007)(8936002)(66556008)(36756003)(2616005)(5660300002)(4326008)(26005)(8676002)(38100700002)(53546011)(6916009)(316002)(31696002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3MzOTByam9xd3BPcHlNQm5RZlhOSkwrb05vZW44Z20vOFB6cms0cWRkUkI5?=
 =?utf-8?B?WGFTZUdFektkeHlkT0tXSFVIckhDMFV6SHBFdEVZU0VPNzEyTSt0aytSM1lu?=
 =?utf-8?B?MnNBM2xvdDhsdGlQTWNWTXd1T3RMYVhpdTZUcmNRZG1GdXMvRElRWnBvQUNv?=
 =?utf-8?B?WFZSS3ZaT0tZNUh4UGhPZHJGcUFhR3FlWGV3Mk9zblZhd2lqdmtkT1liM2xR?=
 =?utf-8?B?S3p4S1YrSXFjUmNJYkpXN1ZKZ3dpdzE3RStXbUJyS1poNEdVQzVLTEs5WVJX?=
 =?utf-8?B?bERLYkgrOThZNVVldjUzQStlSEE3d29BQ0pkemJTamlWVXVsSHgydFhBY2Nv?=
 =?utf-8?B?bkZnUnNVTEI1WHdUTkpvUlVuNzN6NVdLSytsYXNiN0lpK2crVWlEM3BhUzJZ?=
 =?utf-8?B?R0RTMHVib3lYZW54TVNIRVYwR3NCRlpHNHk1c0J0V0l5U29WN01mRWhvT3hJ?=
 =?utf-8?B?bWxUbUdrTVZaTm5WU0NqbVM4NzFPdFZleUhRalc3VDE0U2NBVUNIaWF4bE0x?=
 =?utf-8?B?bGxFWUF1d1F4WUJsSXI4UEpQczJJZXpkU2VNK3k4RVYyK1VPNGpaYVFyNlQ5?=
 =?utf-8?B?aEphMkgvdmJweHdGakdKSTZabEJkemQvYStqZTJVREhJMTM0S1VIUTZPSXVT?=
 =?utf-8?B?RkxsZWcreWNwWHBjWTNaLzFieVc2czArZk1vVGdVZ3NXaDdhbm5FTmUvN1Yv?=
 =?utf-8?B?L25RTU50N0dIUHhBRmlMUE4zdmJrR1lWenBkUHVRU0tYWllFUmxBbDBrU0Nx?=
 =?utf-8?B?a2NiU0hTZ3NPSVVvanZuV2lqcDdsTnF6ZlNONEZQbkhSeTB1OVVyV3JiYzJj?=
 =?utf-8?B?TEJLb3NKRER4aVNvZFhxdXNzVFdLWENKQzRBeTZjWVNWYmwxNUs3N1RXRHhC?=
 =?utf-8?B?eFRSeW9xWVU3Mi90Tm0zN3VFSnJyRGtlR2pZVFVNSmVDdG1pNzJNSG1QZCtH?=
 =?utf-8?B?ZllXSWJpRGt3NDRHOHQ4eko4WVBrM1FxUFZ1SmVnVklDWVN2UHpuR2JXaVFN?=
 =?utf-8?B?dE1uMEtiQTdFaDFxd085ZXJDTlU0WDNMUVZyTk44U2drNnlDL3pLRXJMVDBn?=
 =?utf-8?B?WFIxRWpWdDRKZEJXck9lSGk4MGFLVmVLOHFyc3pId1BYT0lyVXdPT3NrSW9n?=
 =?utf-8?B?alhQYWppUFhtSFlpS21pWWp4MzRGOE9GRW9wdzRENUVqd3ZIYy9KZjBjQ2VH?=
 =?utf-8?B?ZWpEcnJoR1MyN1RkMmlINVpWSnZrVjVVWWd2NmlLRjR0bG5PeVN3SGtlQk1Z?=
 =?utf-8?B?MEZBOHBLNWdwVEwyenN1K2pkVnJXZ1VOclhOQWl1RmE1SXFXNnFicy9QVUVJ?=
 =?utf-8?B?WmhyZFRaTGR1alV6dE1aZ3pUWGVTd2tmc2ZhblFrRHFNMjdXS083NFk5UlRj?=
 =?utf-8?B?QmFIdUdjQVhQdjZRT1JTRjY5M1FSOHpBekdmeXRwbEU0THhxR0dQY3hhbmlM?=
 =?utf-8?B?R3M4aDJndHRKSDdsVzhDa0k1N1g4VFhjS1V4T2h5bTBXU01LMHdNV1V4UkFv?=
 =?utf-8?B?ZElVYkNrTnVhVjJJN05WUmFBZCs2cjNTdUY3ZXRmNGN0cXNObW51YnAvb0Jz?=
 =?utf-8?B?T0xxZjhZMW5ILzRzSzhuQ29KZFVpQW1uZHZFRXZQK3FrVUpiT2VZV2NrejBE?=
 =?utf-8?B?Wjk0MFpjQ3NzVjRtMkZLaStXcUlIbllYSklDWlpwRDBWZnkxaGVTN1J6Y29p?=
 =?utf-8?B?WktqdmNnTjZDM2REU2VDZHVBeDJhL3Zaa1JneW56K2xwKzI1d1VkNWxiWTVD?=
 =?utf-8?B?bnd3OHBrUWFtbHdad1VGWmw5TkVxWmRZWGlBcHVhRzdCSEl2cnhJVGpUTjFl?=
 =?utf-8?B?RnRIWi9iMlRnYjNjMUVvNVNTZTR5R1hjNHZaUkZhRzdwcUE0NHlPa0l3WHVV?=
 =?utf-8?B?anFPbUl5SUdEVlhjN0FBcVZVbXFsRm96M3RTUDZMOFROQ0pZK3U3RVJDUmVN?=
 =?utf-8?B?bkk2RjRSc0I0Z1ZQaXJWSWJuNVJ0S2JWZ2wraGNVQm03UjhQNG1ucXNpVFNL?=
 =?utf-8?B?UC9vbFF4L0x5SlBOSU45YTgrZDdzcDZGUnUrL25JSzRRSGw0djVGN1dRVi9P?=
 =?utf-8?B?aVhaUHNNSExMVlUzVFIyRVFzazVMQm1QMkN0QTk1aG9JVjJwVHpmVzMvcTl0?=
 =?utf-8?B?eGpCTEovL0ZwMGFOektRbUpZem9FOW5LS0FwQS9TbnhPMENVeVZKVGNxTitX?=
 =?utf-8?Q?skjXRbWEuLgd52B8jHa9fmE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a81bf92-5cb5-46fb-adac-08d9fb50dd83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 06:58:18.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRKTAV0fIfS/ta0/kSdA60lHTIRJqgCeGEX+WCG9uD+D/pYdEGeTnKhUBwplr2RsMmM+XrPrPjBsiKCjP5PypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3314
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/22 22:41, Theodore Ts'o wrote:
> On Fri, Jan 28, 2022 at 05:47:47PM -0800, John Hubbard wrote:
>> By the time we meet for LSF/MM/BPF in May, the Direct IO layer will
>> likely be converted to use FOLL_PIN page pinning (that is, changed from
>> using get_user_pages_fast(), to pin_user_pages_fast()).
>>
>> Direct IO conversion to FOLL_PIN was the last missing piece, and so the
>> time is right to discuss how to use the output of all of this work
>> (which is: the ability to call page_maybe_dma_pinned()), in order to fix
>> one of the original problems that prompted FOLL_PIN's creation.
>>
>> That problem is: file systems do not currently tolerate having their
>> pages pinned and DMA'd to/from. See [1] for an extensive background of
>> some 11 LWN articles since 2018.
>> ....
>>
>> I'll volunteer to present a few slides to provide the background and get
>> the discussion started. It's critical to have filesystem people in
>> attendance for this, such as Jan Kara, Dave Chinner, Christoph Hellwig,
>> and many more that I won't try to list explicitly here. RDMA
>> representation (Jason Gunthorpe, Leon Romanovsky, Chaitanya Kulkarni,
>> and others) will help keep the file system folks from creating rules
>> that break them "too much". And of course -mm folks. There are many
>> people who have contributed to this project, so again, apologies for not
>> listing everyone explicitly.
> 
> I'd definitely be interested in participating in this discussion,
> following up on some e-mail threads that we've had on this subject.
>
> Unfortunately a number of file system folks are listed above may not
> be able to attend, so I really hope we can figure out some way to
> allow remote participation for those people who aren't able to travel
> due to various reasons, including corporate policies surrounding COVID.
> 
>         	       			  	    	     - Ted

Yes, I think the organizers mentioned that they were working on trying
to make that work, somehow. And it does look like the various rules
and policies around the world are going to have an effect, maybe a
big one, this year. I hope a hybrid or even virtual even works out,
because it is really time to talk about this.

And along those lines, I'm no longer even certain that I will be able to
present in person, after all. It depends on various policies. We'll see!


thanks,
-- 
John Hubbard
NVIDIA
