Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270DD5E996A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 08:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiIZGYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 02:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiIZGYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:24:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE9526AF4;
        Sun, 25 Sep 2022 23:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V71QEiNsX8UuJdjIeIpl69cbAPss448LJ7bgC8PzKsMfaxFFxxGjndDwygRBXTlaxKaXN5s+s4BCjHl3iBQ2ziOp+5KYCaFjWmnoZ1ZiltrfvdMh33c3koIP5BEDhhhDio73z6QeysP+8DvG29ZInzm2bOdJyb61eUvQtrnfXwWlm8ku1wfMgu6AxViiejTsacFXJTO7QdxhFo+co9Soo+YarIKK9CTevlZL9RyvB5g+0THEam4URuMwQBVIbFJxfumiMiMo3HfhfzrMpJ9+sOQgaNSjdnLOWc0UFK+SDZya5PumhJtHNepp+sxuVnDmJYRBeUvopg5DnuqxqyBZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM4wrnB+oM3F4i1kMy/zagNGUnGtU6+pGOd01wX7Pcw=;
 b=WRAISdFXiyqiQjaJ79j/acxjVuNbTvplPxy5HjrctZ0qcGPq+jHV9D1jzbgyApVV3KIilHUmtTkf0sdYiFV+IYmPEB33NcFTTpAUeO0qGvKmmKnVSpU4VqQ0juG8/M1BInTrCBsAYWY/3AvszU9hPAr6ODdey/sXdGtkx6wjdbKtGz8NS4yF7qwSFYbucJJ2ei2rVOhS4JcP4cWnbrJfnLyyQZxyVyo5wzf+L1jo0WW8pfBm6QHyVnBp6R1P3x2RCCd1sO7R8R7UY/qlX0ibNPnMze9HiSed0CM8afKt4wGy9DBNfWERmKBx8Tfm2ihrKE/Z1vD8FW5Z9E5E0ZE+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM4wrnB+oM3F4i1kMy/zagNGUnGtU6+pGOd01wX7Pcw=;
 b=Kicu8nNoUAwEwX+AGwLIVKk9Ampk0NdYkkYg2ewLHENZ+o+xEXAdQbeiIXV4bLYpNIqifTd4jvXXaWEoWWVq/l73oT9xRyoXYI0J3rprMBtU31pU/Ldv5xmMbPRAe2i2fi5U55SXg5j/4uMLVo/KKnR+jmQliDn2Ree7DOyvuoQsl44t+y93B0CCAg1NY4srPWPkUTcJGVKDModp9vTCdGK2Vo3FbK7m4MCu4oPamuTnEpBKV3o8E42+QXF/tv9zik2vjCH4hWelxdcY1t2NdPqZFIXvFSBVgoL6EXhDTOZgrBOF5r+VfImU/KybZHVzR3vlP3uBe/ipx5t6GgiY+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:23:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ed0:a520:ac8e:9966]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ed0:a520:ac8e:9966%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 06:23:59 +0000
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
 <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
 <Yyuml1tSKPmvLS6P@nvidia.com>
 <632bad8e685d5_349629438@dwillia2-xfh.jf.intel.com.notmuch>
 <87v8pgmbl8.fsf@nvdebian.thelocal>
 <632bc9acdbad1_349629435@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Date:   Mon, 26 Sep 2022 16:17:18 +1000
In-reply-to: <632bc9acdbad1_349629435@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87wn9qlklh.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0146.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::31) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bd3eb7-2ae9-4cf8-7110-08da9f87b287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khKs/w82ILxCTsra8Q2PI4rZO4VnVarj8dtw1NJgExfDKsAFxLesIixnqllGsh6fg6pHxa7lusxp0SCwYwqaPkY2V9GjAITNUEyjX+oNTr/3Qxbr3dzcqlDnMm86Gy9+f8YCORPJ777gNtTmuDAKyYxQrhbdiFbHIDURYcll3ctnMeY21zGxFWraGvBeCxlKJzDAzbvbMjExAgt8FXBxu30VJQ3PrTzDiWEC7at7YVMYcODsM4wmc+azekJ28xYr08MonUDuAN/D8AEnxt+0DOhbeCQcE7G0gPr0B31zmgQuoMxoY3V+FSvvPqrlZCpxttuPNnOFKZj0/HHVMAaWCI6HIk+mvs6dKg8zl4zy22onyEZ7OfMbxRREUcLzNU/LT7hJV/+MPJYxA+K07zn0AnF6BqrFDz0/OAYRS9B4ChFQUIQpOqWXmEsghhw6UO3K1aydPjCZJbd4QL40TlQBvt0ykklVgDAbljNDGBUMafIxzAjEIZZujipro70jnF44wI4hdV+sEI5lmpMav6e7uJrOuUI9/g894H4CDDirxKO/be/KeY7OzQksnW17qj8XodZjsYNvfZxwAmCLBrxOhWy+ABegoKCXzBQIaLZ+O876SG5O9vmHeBsfrdXptJ66cFB8MscPw2rmT7rYk3D8ryBo1ctLsSniWSxyIp11uV6RkSOZXnNq9KxBoLd1C8DaDAGQ7Y3sLYllTsDo6mgIW+1leZc7+jGO/Y/RHkBdozwAL6OBp/rmxxQ6jQXkuwl/iGJ3NrD1eIt6X7z+JdS6kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(6512007)(5660300002)(26005)(7416002)(9686003)(6506007)(8936002)(6666004)(83380400001)(41300700001)(38100700002)(186003)(2906002)(54906003)(6916009)(86362001)(66946007)(66476007)(8676002)(4326008)(316002)(6486002)(478600001)(966005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KeXY6UqvsWoL6ICYXTykQLDQVmsWfz7NHVh319kK5O73WHrY5fbOw2TYdLz?=
 =?us-ascii?Q?RnpWqx8tF1zVSCslBtCT1wd2lY4tT9WgaTXzExqYTYg073XLgzPF0tvokTHU?=
 =?us-ascii?Q?3ZZAKnrLT2hn1KO35ZbOXjPo2XlbD3MysedyZ4hBTxD99TTTGcShdNYiiPdd?=
 =?us-ascii?Q?i2vBlQ0uGE1Dzyx6SYrr5798+2leSasuy969+cqi+0Xx6MoKvhMIVKqdm6AG?=
 =?us-ascii?Q?NRprJ8n53h4h1jdcz8bWMdJQbVe+qjFAV6TkQMEPqt6E/RjaEh44SpGHE4Hd?=
 =?us-ascii?Q?cfAuV3aribPX6oHvb9unKzaXoSFqBschRFq6zpnk8rdh9jyVoVJwy+s+XTyf?=
 =?us-ascii?Q?W7mufBR1973NCfQFK80hq/owTTmsgmaaCXBXavEhMh5GDb9r6KVKl72X7dKH?=
 =?us-ascii?Q?DrmemKJh8pT6yVb2rwsAGmKKMsgvgDrBxG+Blkcz2c3S4oyVUBgFu4vMumFL?=
 =?us-ascii?Q?LJdch/wiNo11C8PqPU32syxYy5789O8HJJ0ti+nPMDogRmIIRmUzXaK5/8q3?=
 =?us-ascii?Q?ippi9jmAvp+SqvSOt5VdezngdRWmw9CvYKUkYSi9pR2iGTVasFZ5ZyOU9VK3?=
 =?us-ascii?Q?TyVaZG1oAfTpBbCOh1vyewLv24o7PUA8Rzu0Y8xBXnJG0fgJdjkyCQ0F22B6?=
 =?us-ascii?Q?yhbILFpqrjFs++JmdohSJtNc+d7LTFoYzeO1jUw/kqocf4147CGbHJKNHFqx?=
 =?us-ascii?Q?YSraPC6NUrYQxLSd9h1wySp2icRwAWcCrIae28dgJbPEbB78dBVgdu6KjX10?=
 =?us-ascii?Q?Ngl9D24vCmjvUswKQGZdQAhFU5RSey82xVE94mCywyHKu71SDVAcg31BDMYN?=
 =?us-ascii?Q?V31oFTv1aTnoON8xcc+icYMUgrx14OdZbakdjZl9Q95uy9ARQTob98ieejKs?=
 =?us-ascii?Q?sBp7E6sqN2UWzR/4VM4yiEABqvFnR7anROs4UVqrKrGTpIQCKjLPxYfbv5O2?=
 =?us-ascii?Q?BTDs7sIJzbQGtQrxzyfNLLQ9pMitJAmxsAv/Wv7Q5j2PKO5zYHK083rjTpNf?=
 =?us-ascii?Q?thCj9rbUmzETMVVdbmsYZvmj/qq6Euyi5cF0+lTImw1onfvaxbeNFRkUdulK?=
 =?us-ascii?Q?ZNo1w7elQ1gpnvTVcUnMS8ZTIK8H0AlFWceT3E+eFFvJYXZn+0qCZwIeHopc?=
 =?us-ascii?Q?v6DVTP3zkn1w+vYc9UTVF0WBjVVMxDMotsu7eehtP16R0cTmBTm+UwawQfnw?=
 =?us-ascii?Q?sMGZIwhk1Vorvu/9SF6RDbEADe+YyoeNdrIaC27UVea6LnMV/ZLYZJaFSZZC?=
 =?us-ascii?Q?kfMKW5zDZXI3Zyz/VKYkXQ6timuRwZTyb9ErAGExMVjNtj1AQJWz+Enk0sbE?=
 =?us-ascii?Q?xKLUXoUUJStGSpJhQhMCLkvGtyUhfFXRxfqOnzfGLXxFAcmyF+s1nB6rCBC4?=
 =?us-ascii?Q?TaFeCO3eViT+VvhV8ire8lcIY2HxtfZ5ECHisdA2Jn5dwMH1lSMaj5Rlhlbd?=
 =?us-ascii?Q?OEbPmnF1U6Uytdwobj3FaxOzax7XoN6EBGo2tLXfbf5Fp32nLGvBBYIMCGgu?=
 =?us-ascii?Q?Jxo8vDVSh4mbK6SYHofvRjc9qg/tiiQeMnSKY0xYShjzupC8wfEUxqxlfe4S?=
 =?us-ascii?Q?Tfu+hRRVtN1CUvKkIp1tEubk3K9yeCIzsHSODDok?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bd3eb7-2ae9-4cf8-7110-08da9f87b287
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:23:59.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv19tZVY3GXgYm7dGqLUN2obRqM65A3h6He51pZfU0LGJRzumDe6bc+f1Pajum/nVU6mgf7p8WLZNjk8VqvhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dan Williams <dan.j.williams@intel.com> writes:

[...]

>> >> > > How on earth can a free'd page have both a 0 and 1 refcount??
>> >> >
>> >> > This is residual wonkiness from memremap_pages() handing out pages with
>> >> > elevated reference counts at the outset.
>> >>
>> >> I think the answer to my question is the above troubled code where we
>> >> still set the page refcount back to 1 even in the page_free path, so
>> >> there is some consistency "a freed paged may have a refcount of 1" for
>> >> the driver.
>> >>
>> >> So, I guess this patch makes sense but I would put more noise around
>> >> INIT_PAGEMAP_BUSY (eg annotate every driver that is using it with the
>> >> explicit constant) and alert people that they need to fix their stuff
>> >> to get rid of it.
>> >
>> > Sounds reasonable.
>> >
>> >> We should definately try to fix hmm_test as well so people have a good
>> >> reference code to follow in fixing the other drivers :(
>> >
>> > Oh, that's a good idea. I can probably fix that up and leave it to the
>> > GPU driver folks to catch up with that example so we can kill off
>> > INIT_PAGEMAP_BUSY.
>>
>> I'm hoping to send my series that fixes up all drivers using device
>> coherent/private later this week or early next. So you could also just
>> wait for that and remove INIT_PAGEMAP_BUSY entirely.
>
> Oh, perfect, thanks!

See
https://lore.kernel.org/linux-mm/3d74bb439723c7e46cbe47d1711795308aee4ae3.1664171943.git-series.apopple@nvidia.com/

I already had this in a series because the change was motivated by a
later patch there, but it's a standalone change and there's no reason it
couldn't be split out into it's own patch if that's better for you.

 - Alistair
