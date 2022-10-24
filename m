Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0970660B66D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiJXS5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiJXS5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C81EA540;
        Mon, 24 Oct 2022 10:36:55 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OG6FrO025351;
        Mon, 24 Oct 2022 10:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=enTb1HmUOP7TXxu6ljp9Mpx1UtN+zJ8vJMMxgp3EBtE=;
 b=CJ3cposQ8KLhJzIkJVC/YvZEwm0mF8rKKDQ7BCxzl9hrmEQq8uPgUij14hWyxfKafCsL
 T4JS8NeMJHKFtS6ZhJrWwXRRli/DO2r/sUpGv08G7KYm0d/LtHpAwO0ES44Bl2i74tKn
 wbIyAtN6bb51ipXEpkQ0z/xYGewhQfkw31smHhgJIB8RMB5A4Q+3wh3r7lfZxXDD9ad+
 pc7EmS2+sokqzFSrIyWCg7qNOBzwLqfegcLfm267T9BYZfY1pZLcXSGxDGZlpaP/Nsad
 kdyN1sC6j4uGnxCPQ9qno4KpNJkaiAwRlp0/KzFbbjETJzOUP+sTuJLs/wzEnuDiYIrD MA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kcdmucukr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 10:35:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOB3wZf5WKvpDA9FIMvFyt0OsUyk0kPNr+qjJS8anQDUqCUxpk9d5sQwPgft8I0MRhYCSK8d3EGPFazJXKqVpphOsJoUBl2+1wHXFyAkEYzTWKE+0aYBDC8JcNGpPr7BU9oJXc41AlArcGe5kgnzz+n+bOC8mI2of9TyC7YN1Kc40mZESTCLzfl6ttnSA9sgC4QpOhNIHP+5icSqnbJkDYT1pbnz/XkvxHV5M+EQfsTdc0Ue8+NyZJIJy7jlR4pNlHcWQrVRecOMyyYY6zre14iFGtxp32dvdQdSxl1tdmM+Roui3pbhrNIwxbqpkHzC3gyiEmleLqTo14B4FJflOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAtvJDt11ZnIVrYkLXcP4r+4COT0WahL/yyqCEuQoCQ=;
 b=aJUvCFv8cDsq5AN8pgZNcBpgtbICkFNt87P7JtADxRXskwxDBsKr0dvzgZ/42N4Nw2cDa+5PsXrP8+R0UJIAIWOK+kHTZBwBs6EDwuR3RoxViP8WGnD5HiY6cFRQbISHpQBO1JIOXvTqJx8+T+3l0nvU7TBzrROpyfUOJBUwW6w7TUI/wL0Sr7LLrEThOlx3RQ52HMKnGz+NSHPfnxhu4jJ5YCqZy6JHOV7XZ3uZxW4lrD7YXUu1VCpNaK3VjDFy6S4rsa8ORiG0IdYA/7cm+86MujqQNg/AVehtxuDWVn743AnZiHdYAQ8Not9UwgQcf2HC/Vm+lYSMapfptfwaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by CO1PR15MB4890.namprd15.prod.outlook.com (2603:10b6:303:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Mon, 24 Oct
 2022 17:35:01 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553%6]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 17:35:01 +0000
Message-ID: <891da9bf-f703-0ddb-15e8-74647da297ea@meta.com>
Date:   Mon, 24 Oct 2022 13:34:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20221024171042.GF5824@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|CO1PR15MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 2460b064-15e7-49da-96e1-08dab5e613f7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCqWNkFBbTomoIwbh1497NPyy9CIiw4cHid1F/WPVkJThn5Vf6/SwT1jK40v0e5zUfw6SxmtNL2NawMcebv5WF+4BgKtixRUijvzF8//7I10QIovaXexKHTa0FQaaLW0bWvcWjiNtg0TSQB+q/UKyoVPEcW1kjGmUG+jQVMFwCLNQ+hmkNde7PkmyrT0qh0lL82asI2wsMw/9hIQ5v4r6w7nNMGOea9MP9lYTTSI0RN9rkK21qJl/nk5Dfk71uycSDNXrgqq/IePUghyZtic9ikkiP9NIKUmcOZUKcJCZN2V775KByKBEswzilpuXeOUGi1s2XPQXDNOXdX4BZQmlNVcS2A2CM2YayrSFx05//plQim29z6lj1geTSj0XcVkUyS1itpAPrp3kiOkAcVne/CCIvu7wzB8b92YiRYfRYCoK3bMVRnRHpaYeUczhply+P9oLPrzoDG8hj2q6pVt/qlfLvMFNCcIXpsdG524BzMZJxE9vteoN4ccXoD9MARih0HwAkoc8r1EW64NPCt1cQ9e5S0KNFpxC1I/2IKqb62MwD0i6VPauHolrW0rKkcJ1bVbM8311O1IKkCPHSbMbg19LO3bl6Y/+pwmb74iCq+zA+oAFJeXcMSczhGvZio67JeLfd6KPNvvRMrVjFtsW7BRms30NS7/K/I1IadeqCXxpuqxPLhyoY58VR1UWuNCufvJpnM3qrX3T39ni0j/gD2f5EYDarWN6MNmlXQ4UQJdpP7oXw83I2nreyNbTgi13YS8UWVrUpVmmK7j2+R8NlepvzUK7hoGBjbViwACS5BiIFzzH1hkIx6oXw+SPO3QGQJiEpPsv66G1Fywq7E2Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(31686004)(6916009)(316002)(66946007)(478600001)(66476007)(66556008)(54906003)(966005)(8676002)(6486002)(53546011)(4326008)(6506007)(41300700001)(6512007)(8936002)(186003)(2616005)(7416002)(5660300002)(2906002)(36756003)(83380400001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymh2N3RyamdodWl6RTYxYldnVjJVRlYzcFhzT2czOUV6eEQ2dEJabm1DSjVT?=
 =?utf-8?B?Wlg2c1pJMS9pK2JJQlVlTnNONWI0NXRucmVaUzJHRmQxT0tGd1Awc0Y3dEpz?=
 =?utf-8?B?cjJtbUNtZFhsMDFjMGZ4RWNKVnA1eUE2WXlEUWZGVkJYbFlwNVB1WGFvZjlT?=
 =?utf-8?B?NzB5RjNqcTNrMUhjWTUwNjRWbURlblBBRm9xcnhJUjU3cFZpTTRnaDZ3NXdv?=
 =?utf-8?B?ZFNQUGhKOFpwTmdQdWVISVVIU0QwdldhcGRvbHVNL3F1cWFJU3pycUN3c3Bz?=
 =?utf-8?B?VWQ2Ui85d1JYeFZyb3V2TDlpRGQxekJNSlN3V3JLaTAzTEdUc1BhbUZ2cVhR?=
 =?utf-8?B?YjIxNFRXODkzYUF3Q0xobWc5ZmdycFNaSjhRVTdxU3lRWFpIbVZVaVpJa2tk?=
 =?utf-8?B?QVVZN2lOTGpnSVVFSFdmMG9vTlY3MkRzT0JFSjhlQ08yQk8yQWlYUjFXRFNp?=
 =?utf-8?B?Mk03UmhLWHFSb2QyRU9UQnVHRjlPZDFGdlZwV3VGWFRESXpNZ1Joc2FDU2tO?=
 =?utf-8?B?R3p1VUdCemhTVzVxSlYxL3I2QlBCaU9CQ3NIa2tIeFV3SnhyMHBJVnFVNWls?=
 =?utf-8?B?SFBsUWdhVmZQQk9Bc2tEL084NHV3cjlYSzZjN0U5bnppcndKQTlMMkdmbFdJ?=
 =?utf-8?B?WGxZQUFnZjRHV255eFQ1NjlQODB2bXNUanYxc29XcXF2UFltWlFHWlhrNjZx?=
 =?utf-8?B?dmJDQnFwTC9TSFljeTRqdzRFUTRZKzhBLzZyd2daY1Q1ZXFRYnp2NW9Fc210?=
 =?utf-8?B?bmRwVGZzUy9YQkJ6MkR2Zm9wMVRaNCtwWWJpbm1pMkRUVkFNMFhsTmplMlA4?=
 =?utf-8?B?MzFBK3ByaDRqSGNQeEhBUTE3anVPUVg1ak5mNWUrNkt0Njd4Mnc5SzEySkEz?=
 =?utf-8?B?Q0RwWVdyZms1ejM5N29uK1VCY1V0d1dPQ3U1MUZNRGhQVGMwL1hFcEoyb3JQ?=
 =?utf-8?B?WnR4ekszSUNLbFJaUHBwRmJvaE04YThGVzdta01kL0JQRGd3RTZ2Mkd5WExw?=
 =?utf-8?B?TStIN2hMLy9yNHo3dTdwV0RDNFpUZGRkT05WbkVpR1B3QUVuNGgwKzQzMTUr?=
 =?utf-8?B?c2JTck9NQ2k2bUVZdHlONHcrSy9DaGdSSk5aYnBGalhZMkVjckdEQlY4TjNM?=
 =?utf-8?B?OXVsc25sblY3T0FZalArZXBDclVWa25uQmdubi9sSmZGcUZNNy9SaHcxTEFH?=
 =?utf-8?B?WE5FVmdXMGVLbTNSQkk0WVFJS091RGJ2K2hnNnora3NMdzBTVDUvbitrVXlq?=
 =?utf-8?B?U2FQREhMMmJ0SGlNWERUQXl5dERzYklwTjlCRGVSU3c1R2dvenNBV2N0bU5z?=
 =?utf-8?B?UUlNT1BzVW1FclBtOXRaam5teFN3anhiMGpzTG53UnRqN21BYTA3UlhSanNX?=
 =?utf-8?B?RzRXdHhmRzRCbVlXSW0xa1BhUUxmK2p4OVgrS2FhYjBvVm9SRVI1SU05YzV6?=
 =?utf-8?B?K1JNNVcwN1hoeGkrZTBoUW5nenFteSt0TVczUkJnVlRMdUxYYlNlazhFYVUv?=
 =?utf-8?B?NCt6TVNNK2lEdzJ2UDdNR0ZldVBwd1NKNGUxN0xBT1Fucm12ODlVNDlnQXRZ?=
 =?utf-8?B?aHY2ZVRpeDRyb2UranRJK1F4VGVieWZYcWFXa0pzNTlpSFJHTFA2NW45UG5s?=
 =?utf-8?B?cXdCaWdDdHNyY081S0NDeHd6eHZ6blNOUkdJQkdnMEdqVW9VdTQ5RjMyN08w?=
 =?utf-8?B?YWNHb1lSTWRlVWNxd1Z3d1R1RS9BQ2VpSEROUTEydTM4TjRyNFNMUENzbTFn?=
 =?utf-8?B?OUo5bjBqRGJNUStKbzI2YTlOMFFEekpNQnZEam1NS3dHUEU0V0l2R28ya2Mv?=
 =?utf-8?B?KzB1Z2xnVjM5bVI4NDlxKzBpK3AzelV1TG9BcTF2YjVEN3dNMDI1MmsrbStq?=
 =?utf-8?B?YjlWVG5pTVR6RE8xSndjRWNEM2NUSDJZYS9PS1Zva05hN3ZMcENrNDZIdldC?=
 =?utf-8?B?NGZ5aUg1TDlRdmxFdFpMVkxTM2FJYmlZUnJNeDM5NlJHU1BkMC81WmE0Z1Ev?=
 =?utf-8?B?QUhJWHBHclArSGpXYkpZa0lBTWNDa1dqRUFCWDZGajIvTTl2bU5qQ3F1aDM2?=
 =?utf-8?B?aGtQYXVqNmc0NXdWcFI5QkpZSlhEWGxXWEJFekhwcXVIbC9EZEdRZkFmSkZ2?=
 =?utf-8?B?QWFnSTNFQTl6WlNIVThieUdNOUZkcDJacmRhUE0vZFpJdVNyTzhRcHE4OFBR?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2460b064-15e7-49da-96e1-08dab5e613f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:35:00.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMpdsF6aL25JVmMibMyqIgfoohEFtlqEjkTvAjl+NPv9hyJBSDjWSJzwip4QQhhh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4890
X-Proofpoint-GUID: b04Jqw3NLGQzfXStp7G85lsjJdGzoEYx
X-Proofpoint-ORIG-GUID: b04Jqw3NLGQzfXStp7G85lsjJdGzoEYx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/24/22 1:10 PM, David Sterba wrote:
> On Mon, Oct 24, 2022 at 11:25:04AM -0400, Chris Mason wrote:
>> On 10/24/22 10:44 AM, Christoph Hellwig wrote:
>>> On Mon, Oct 24, 2022 at 08:12:29AM +0000, Johannes Thumshirn wrote:
>>>> David, what's your plan to progress with this series?
>>>
>>> FYI, I object to merging any of my code into btrfs without a proper
>>> copyright notice, and I also need to find some time to remove my
>>> previous significant changes given that the btrfs maintainer
>>> refuses to take the proper and legally required copyright notice.
>>>
>>> So don't waste any of your time on this.
>>
>> Christoph's request is well within the norms for the kernel, given that
>> he's making substantial changes to these files.  I talked this over with
>> GregKH, who pointed me at:
>>
>> https://www.linuxfoundation.org/blog/blog/copyright-notices-in-open-source-software-projects
>>
>> Even if we'd taken up some of the other policies suggested by this doc,
>> I'd still defer to preferences of developers who have made significant
>> changes.
> 
> I've asked for recommendations or best practice similar to the SPDX
> process. Something that TAB can acknowledge and that is perhaps also
> consulted with lawyers. And understood within the linux project,
> not just that some dudes have an argument because it's all clear as mud
> and people are used to do things differently.

The LF in general doesn't give legal advice, but the link above does 
help describe common practices.

It's up to us to bring in our own lawyers and make decisions about the 
kinds of changes we're willing to accept.  We could ask the TAB (btw, 
I'm no longer on the TAB) to weigh in, but I think we'll find the normal 
variety of answers based on subsystem.

It's also up to contributors to decide on what kinds of requirements 
they want to place on continued participation.  Individuals and 
corporations have their own preferences based on advice from their 
lawyers, and as long as the change is significant, I think we can and 
should honor their wishes.

Does this mean going through and retroactively adding copyright lines? 
I'd really rather not.  If a major contributor comes in and shows a long 
list of commits and asks for a copyright line, I personally would say yes.

> 
> The link from linux foundation blog is nice but unless this is codified
> into the process it's just somebody's blog post. Also there's a paragraph
> about "Why not list every copyright holder?" that covers several points
> why I don't want to do that.

I'm also happy to gather advice about following the suggestions in the 
LF post.  I understand your concerns about listing every copyright 
holder, but I don't think this has been a major problem in the kernel in 
general.

> 
> But, if TAB says so I will do, perhaps spending hours of unproductive
> time looking up the whole history of contributors and adding year, name,
> company whatever to files.

I can't imagine anyone asking you to spend time this way.

-chris

