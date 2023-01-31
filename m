Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17712683458
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjAaRy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 12:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjAaRyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:54:54 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694402A9A2;
        Tue, 31 Jan 2023 09:54:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZoCLESe1IogTK8Qaort1O0mQ7xdtd82q2dLGM5ekLcZu4SNwYrh7/Y78zP6Lu4tv709lc5ZN8+soXRft+qxJBwVtw4818xzGnnqzIab3N+rMhXdbRKlVe3ZLhZPCc44lEZaxSEAXt2I3Ralsj1iNSCfIs/M3OFJs3W1MtDeZYIl+mytIidniDMts9r0BtL20MUiU7hPCe01MrH51WPUmGbLrenT+IaBOtR6ljLYg467qNMf3PRkDC6cW1zAbQ5XZWAJ9n1L78hPxWzYs8IacbXPJ0OiOkTdEt5r6FWJjJAWfx001goQGaXBGO5XEhgoHL3elbdhhP5V+XFAeZ1VIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY1lpu9KlXeOVvOP2jpOYx174PWpQ62RPpzjLzusRyU=;
 b=IWaPelMNlyRaWLfaVk7HuQd5V1IMtoqhhLstLYV0tOQ3aRjAYDj1dVqfdgNb/Ey/GOsDaPNDYpRi2cIwvVs5u7yzHstFXPAfaZ2WDw+MkLbbk7kQjz/bdna2rQ/jmsXa4iOHQ2Kubz5U9ljo345OXhrO48yd5W9kwFc1IR+GuC7FTPxzYgzKTpHjJ9jZGfZsTv0/jmvzjZ2tEINhRSrx3LWm+r6nVA50aBCCQC5NyPBDBw7tQODvVMkQrOcAFE/przIyoCyOyKeuM9vrLYcMK+ybiIiUofSfgHBjoyXVYKuUpm+BiS7yzPhzjbWvo0eUNRKgOx3fGcjsNPd7MlGCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY1lpu9KlXeOVvOP2jpOYx174PWpQ62RPpzjLzusRyU=;
 b=qqN7g1TfW+QoJX/lzbAAY1ShRbEgttt8UvL3msI7mqz1wrSdstF2ASHAsLnfJRM7S9LqFbuxkbO5qcGbbWdMkoIwNdTtVGsiDaHgQQsi+pULn0nJ+3Hd55Yf02m0V1fmroyykRkmzwljbquluYaLsUll/JuWfI1KLggAtC09qpw1gobmPqWVGZjDhrkIzeZ1S0Ez1PYry2V+yRbdW6c2kOFwbLf/R5n3U3icXT/NRasSOY2JUrh9pKWhlOboBnpHykaHkf1YPSd+oSh9ISgTFCpBsKtPvUckAiuKisXAFZoxg7pUQTqNbxgxYQaPmc+E2Vl7LP7ZIhCnbekU+W7CRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 17:54:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3b11:5acd:837b:c4c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3b11:5acd:837b:c4c7%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:54:51 +0000
Message-ID: <0fc7fded-f6f5-e7e4-1b3d-3dfd224d9458@nvidia.com>
Date:   Tue, 31 Jan 2023 09:54:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
 <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
 <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
 <20230131122857.6tchetnsgepl3ck3@quack3>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230131122857.6tchetnsgepl3ck3@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: e68d6f18-92fc-4013-3b64-08db03b44039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mnawtus+fVEYLlsoyASMJTufIh082mDCAndZ6L2FyA1MldOzhfPP3P2QBM1NITBlb3CXdipriV90JPpb6B0xPhdlYkS4COOwJ3OsrkKlnA0/CfLMMCW8txhKrKjWwe4rxJXwqA1wTB3zrdKJro8eSrvXRqI4ndTAFlMm6IUtidNo9CU4jJf4z6N1yY0kdfEjCzQS3mDYS3wH5aCIO8RBzXmKWNA9pky2vkBMw1x12gPvjmqFpYHU6OW/manzxD7rV+UwjgH4eJwo8zz+mg1II6q80Vh0JIV+HZ6xejiBU6ceVchSWtr7KtBZ7vdTf1BF0YjGi+3yRVt9WbJPccL8BtrStEfB8ZhpAFzATSvWmOnkoqDKwYXaSP0FRuOqpZYmMXyMPC5GyDy3Hl1kfGI4pBYNjjJigwLoHGvkiUocgpsaJWG3VLpkJ9VmhlJCaqLCMg3qW6FwE6ajFDq35QrK7Fx9o1y2ygek9PGbkdiyjepkG6BAXw+SBeyOuB8hrjlhAM5SmzPjyc/4vDChvGRjLrYhUc3ya3SzyyLcoCab8JXVpc+8WvxULt6XpDE8AdAg+BHrJXBt3dj9Ir0pCBb85KZxh87YtNKnT3xCGEZH3H2I2XDeiW2dmZD5QjCN8RzcT0/8Sy1PoWXi9QFEooI6CJHPCFlcyzNOZe9ckIGS8TyDdQ6UlbdAq6zCg5sPK6h8tviJvjM23HEh5JdxCMrqO1JdphOviKjharpOdVc8r1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(31686004)(2906002)(54906003)(26005)(186003)(6512007)(478600001)(6486002)(316002)(110136005)(31696002)(36756003)(86362001)(38100700002)(66946007)(4326008)(8936002)(66476007)(2616005)(66556008)(8676002)(6666004)(41300700001)(53546011)(6506007)(7416002)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnY3OHRBY2MrOG1iUnR1bmo2Qko5Ym50NE42V0RwKytBWHJkUU83cXNCZnhB?=
 =?utf-8?B?MmptL1NNZldtQ1ZHZkdrS0F3UkVRam9zdFJiS1FCeWRhUzJML1hsYWkxNk9R?=
 =?utf-8?B?a3dOS3ozalVmM0g3Wk9mckQxMHB0OWdiL3pucnFiaHpDS1VROXJpa3lUWEpq?=
 =?utf-8?B?eFRRd1dlNkxTN2xtZ2lCS1VjZ2ZyYWV6a0lPRU9CQllaREZ2d0ZpNXh4TEZW?=
 =?utf-8?B?UVlGZ1lualBSYlVrNXR4aTBPOHZDK0FQaWdDeTJmQW03ZHpxbFVmbWVGK2VH?=
 =?utf-8?B?Slh0Y2hpWTN2NjhXbEk4OG5IYVNPRWRmTGxTU205Ymc1UmRiV2JxWjc3N25y?=
 =?utf-8?B?NHROZFlHU0N4dkFCbWtKcFJpa055TCtIUjJTYVBVOVNGNnhRZENTbGtFei9R?=
 =?utf-8?B?dmxNUk9WTmhWcDJKbEZCQ1FxZFlFamtqRjV0Z3o3ejlOTnNyeUY4by9lZ1Ba?=
 =?utf-8?B?dEpHRWpRSU9ZSGJEQ3VCK1EyRXNBdVlxVTRlVktucmdUUFZTcC9MQkRIMjdj?=
 =?utf-8?B?L0tQOExaK1NTUHhCVGtoakpnQU1SNUJ6Nml6MlFOR093VXVXc3VkUFV3SFY5?=
 =?utf-8?B?MFNPaFlxZmdINVh2UHBYYU5Ja21XWllMMHN5VDd0ZmRTZ0ZoYWQ1MWFrTEJX?=
 =?utf-8?B?bStMaitLbnVURWMvVDBoZCs3MVpYOUZBcXRZZFJtVUY1dmFnQ3RYVHdjcHZ4?=
 =?utf-8?B?eFo3QTZSODJCT1pwM0ppYnVsU21JVFFlaG4ycHc3TFRHMU5wWTBMbVRFWVZH?=
 =?utf-8?B?WnBRbTMxRGVoZEUxdlIyZzY0ZjZ4WkhXVklWMm9meW13THo1dTB5d2NBZWZu?=
 =?utf-8?B?MHI5WG1OYzg3YnpERmd5WElSN1YvYTI3M2VOY0x0RXJSNlJEOVo3S255U2JB?=
 =?utf-8?B?Y3dkcEcxSHdubmxpTndwamJ1a29TL3preDJGV1EvUmRVelpyTGhlQ1FYZ0Zn?=
 =?utf-8?B?OHlBNnF5Ui9YSHlVRjlEYU5RQWY3bW0waHNCdTdXcHFJelZ0MVd1ZTV6MCs4?=
 =?utf-8?B?cTVYa1ZvQ0VNMjZBL3p1bStwQjBkNXliUFNwaTNBa2NvbkFObG1GN2s3YzJl?=
 =?utf-8?B?NE1uRUNkeG1UMmd2dzJFc0V2eG5CZUZhcVhMZzJkaktMbVJMUVVKTTUrOGE4?=
 =?utf-8?B?MFg4QnJYYk03ZnBsV3ExNFlteGx4cVFDWGJVTStFY2t4N0ZKT3ozbXpCYys0?=
 =?utf-8?B?MHRuLzdsNVFPNG1QOEtWREJVcWNaMVJlRnpVclRYbUoxd0FPOTlIZDNPcm90?=
 =?utf-8?B?WVBJYXc5NzQ3ZlVXQWlhT0FrbTgrSWJiNTZTMFFRbGV2bVFaMGtETmdING1W?=
 =?utf-8?B?STRPMDVKeWRHV0duWkRtNmh6dFdzY2JuM2JmN0dGaUE0OTFneC9YZi93czA4?=
 =?utf-8?B?NTF5b3RCS0twVThOZDlhc3NJSGxLeVZPeEZsV0dNVTdRc211WHVzWk9VcmE5?=
 =?utf-8?B?QlRoZTVwaTMzRHU3OHlhUVZ2VE4yaFNEVm8yd2dDOFNYVmFDaDVsWUZsTjhz?=
 =?utf-8?B?cjBha3JmU1ZBTzl0am05YjZEL2RGMXR2azZLMnFzYlZHNzQ3MUVFbzJ1ODlx?=
 =?utf-8?B?QU9EYkVTOWJZQzhhanduQXI4cjR0bmljRFVob0EvTFZ3K29rUXY4ZW9MUklz?=
 =?utf-8?B?MmxOMEpzQUpxVGdySzJZcTJiSTVvSnFyYVluSDdNMzNZUTZwZ0ttdE5zUVBB?=
 =?utf-8?B?emN1ZjBhNXpBaHlmNkxLcC9TbHY3YThlNWt5UFBNNDhvd2RESVlsTGtaUm5Y?=
 =?utf-8?B?YjF6ZmhjY0VxMmx1N1BrM0NRbGFWRHZyelZ0TDNscEdFOXM5T1ErdWlxZUE3?=
 =?utf-8?B?QnFaNzMvUU8zTE5MMXc1bmtRMVBYUzJPMElRRDZvS0F2RzhCOGI5VEo0UXhS?=
 =?utf-8?B?YnVJZGU2MXdJUnNaSXFyUldtU1drTzVZRjRuSDVpS1U0ODc0TGordHhrY015?=
 =?utf-8?B?TFdud04vdlE3Mit5UTZzcWNyRjUvV0RVNXBnMUtPVlpqYktzUHh3WCtDY0FT?=
 =?utf-8?B?eVMxa216UVJWVmRqQjBHdmZSTEF4NVZQc2tyYkdwNGdrMVAvZFNnZ1NKTXVL?=
 =?utf-8?B?ZE5wMHNsL015WVF4eEFjNkhlWE9MenBxZit5T21kT2FjOWU2RVJVRU0vSm50?=
 =?utf-8?Q?9O+rhEw72uXDnJHKU1Q8VYG0z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d6f18-92fc-4013-3b64-08db03b44039
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:54:51.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmWGNpCLv7S9Wq9r9nOpeoLPx+qIy/NPeYX34uqYJ8IOsg3Ma/8jcg0JJM/QTRiII6/HqJbmdU29WLFYWXTdwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/31/23 04:28, Jan Kara wrote:
> On Tue 31-01-23 09:32:27, David Hildenbrand wrote:
>> On 30.01.23 23:15, Jens Axboe wrote:
>>> On 1/30/23 3:12 PM, David Howells wrote:
>>>> John Hubbard <jhubbard@nvidia.com> wrote:
>>>>
>>>>> This is something that we say when adding pin_user_pages_fast(),
>>>>> yes. I doubt that I can quickly find the email thread, but we
>>>>> measured it and weren't immediately able to come up with a way
>>>>> to make it faster.
>>>>
>>>> percpu counters maybe - add them up at the point of viewing?
>>>
>>> They are percpu, see my last email. But for every 108 changes (on
>>> my system), they will do two atomic_long_adds(). So not very
>>> useful for anything but low frequency modifications.
>>>
>>
>> Can we just treat the whole acquired/released accounting as a debug
>> mechanism to detect missing releases and do it only for debug kernels?
> 
> Yes, AFAIK it is just a debug mechanism for helping to find out issues with
> page pinning conversions. So I think we can put this behind some debugging
> ifdef. John?
> 

Yes, just for debugging. I wrote a little note just now in response to
the patch about how we ended up here: "yes, it's time to hide these
behind an ifdef".

thanks,
-- 
John Hubbard
NVIDIA

