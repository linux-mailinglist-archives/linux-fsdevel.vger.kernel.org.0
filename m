Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461E152C463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242448AbiERU2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 16:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242438AbiERU2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 16:28:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1801312A4;
        Wed, 18 May 2022 13:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeZXOMJnJRleiqb8flEllqYLG11Y/RX7Uh2ixHnBGcTazj2/TOvaEPdIa328TvkIjhCZyw9aXL5bZR5X0QXEEUCDc4KK7YgZtnBj7VPhFbTgn2kMmsNs37rJYz/4FhASNLVKK0KGdyZuG6c/IB8eJadftC0s04pSdbpKmuNee0iOwv+aW8B2DGHUvFULgtlzgkmb7uvl2ke+6hDxrRmNDYpTpOed2z4QPaYU81tvbrx0A1FZ1Ol2DcEUQhi5O0QoBD4YrD1gFFN6VLZ+YyvLpaFvqRejPDAl+dLlzt7VEhS8q/nzfIB8P56h82/XMZ9up3UKGCVjnAPQJNhmnaK6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ/Jp8GAzTccamjju9HemHnduZQ/c746ySNPt1qyj9w=;
 b=TleSBYfp9i268873RCirMetkBWYitBeDEnVyFHSdF0WTYnVUPwwh6dYOntLvhTDSBDYwpRvOfUR8y4Xz9uCWu3SzihYhFVjN9KiT2yFP6N6R1rKF6S8U2dhThNi9KvyJTkUlg1CTFqYMR1D0PFODKvi507kE0QDTmpR3mKsx2/MBCFGVtQEaWk2BFqKMWdXH5zukqEr0YatqrBxs/SqnlsXUkD7cXmcMB2buGxmbq2OtEFXbZJXTL++wm4PGCSP+9G5UlFeoOoBgMGYWoFCBjWFuS8l6PR7akYUBWF6TK4YZ/jgXH2cWzA4Dm834S0v2u2mB4CJzm9nmFhGR9At8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ/Jp8GAzTccamjju9HemHnduZQ/c746ySNPt1qyj9w=;
 b=N3UBJd8Cf5NOUvoaBKDe8HXjX1rDuIfSpGn08mPderqIfKxtHD86hCs7CA8dQOg7sKRGv45oa5FYIrp1FmFWo41EIdUVgLak8vgHZ87j5hYXfyqaR/j+YkftT0B+4kiH/0rphggYPclkEuhvXr7f4iDSv3uNuMVaDGvGKNK3kyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM5PR19MB1004.namprd19.prod.outlook.com (2603:10b6:3:2f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 20:28:39 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 20:28:39 +0000
Message-ID: <b8334bd4-8d24-1afa-8809-9b499dd357ea@ddn.com>
Date:   Wed, 18 May 2022 22:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/3] FUSE: Avoid lookups in fuse create
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <20220517100744.26849-2-dharamhans87@gmail.com> <YoUvrSdh4B0rKy78@redhat.com>
 <YoUwgoAHiywYzvpK@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YoUwgoAHiywYzvpK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::12) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39d2cb4c-495d-4ffe-a11a-08da390cfde4
X-MS-TrafficTypeDiagnostic: DM5PR19MB1004:EE_
X-Microsoft-Antispam-PRVS: <DM5PR19MB10046E84889314AEF593641FB5D19@DM5PR19MB1004.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igfI7eDvmUCC3QE3PDrUmRH7tYNpRiemw5WgoDP7T4Yk7mx0lZ9utw+NTCg5Efgby2Z7QBWzaJk4antuES8XCmBS/T8dw96iz8bFcnPlpEfKlHFM9+YQWvqsq5l2JBOW/Uc6lkfUJiKx/kSmqMUS9rWIR36d8frQM9+Q87iembj/lJPQOY8JJiElbeodW6+GiDZePZNBKpr2bxo4yQfthqSJhsNInRCBHla41SLe7lTXXH7tk+Jwh7zz6tsexlj41pbu9UR4dyNM9ysnqyaZPDJpYq0WVVGfmhzQ+aqtwhIL9DDXERoa9fD0iiK3J/UeVL7Wi2FmjSLV+tzJSlq8gC8DP9P0toxUIyquwxWMT8DbHeztZd+q0a6/rOHB2TWfkFxjfQ4OHdoKxzDBsO9tZ8VQlL3egDUWWn2IRwxEQSfCBbNq6oGv9s+C3Wvni8mcRWLbbBI3kkBM0xfbeEnpBtY1xV7AANnMOfzQn02inrN2Hyxfg2AjgKsOQgwixI8gPSUxCdgUJH7/3bQUHqcM95Xk8WkRY6v0kCiX/4hICQjWwspMspXzyqalcVq0BnsrqgbyyJspYz/hi/rW2uwf6lSQkiv82o9qCkvYmWRfHBkKcJLwLpK6bLU9422oIqVn15eOHT6fuwtu3zYiBK7NJdfVYhSiNCaGL4SNXqp7W2kBWpoPOJ/DljXV8iCXSLPkDwvYuT7lCappc05nyn0dpXNsBURq6STaFKsctnAIJUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(83380400001)(6512007)(53546011)(66946007)(6506007)(186003)(6666004)(31696002)(66556008)(8936002)(508600001)(86362001)(31686004)(316002)(36756003)(66476007)(5660300002)(2616005)(6486002)(4326008)(2906002)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODFjNzVZNENxbVVBODd2aEN1SGZnS1gzTmM3MnR4T1dmYUdNb0M1ZHN5RExS?=
 =?utf-8?B?SUJNc08yeWZ3UC9wVXEzVituOHZrU1VCVXZnV2FIVHZINGZtS1FtRkNVM0lw?=
 =?utf-8?B?Uk9hVGhZOVdhUWRUTTlBQWZUMGlZcVNyc1AxYjBVeHN5N2dabk9NZmdNNklm?=
 =?utf-8?B?clRTcU51VlJzWjlKcy9KMWlzZWNKUkNyM3h3eHNRQmI3SS95SHRQK2gyZ1hp?=
 =?utf-8?B?ZDdwcGxndDlzRHV5QU1yVUVtcVFMaXlaVW1OVHVzVklWdDFNeTBCQ3lJVW80?=
 =?utf-8?B?L3BWMk1sOVRmaDBibnJmNWFKa3R5cWR0SngrNEhPd1BlTW8rWUpERTE4K2h2?=
 =?utf-8?B?K0tvdE5KQXR0aXhyOXMvejYySVVtOVpoWUFoTUQ3dWJFTTU4Q2RtcUlINmU1?=
 =?utf-8?B?OFNZWTE3UktrZFBUajNxaHZCUVVTNG1YRk1RSi9nTm9Cd2xnU0ZuZ2ZLdFZ1?=
 =?utf-8?B?REZTcWVrQjZNMThuUW5TY3JGOWJEeVZKYURLaGtudFFGZ0hXeFg5VkJEdGxV?=
 =?utf-8?B?MjFIbm9oVXFpclRWQmRubitMVStSNjl0K1RDd0V1ZE9ucU1EQmtOQStDMTFV?=
 =?utf-8?B?YnZwM0doaUFjSmY3RXBhc2FRcjBscE40Zlc2NXdLWDRjVTlrbVVZVTRHWU4y?=
 =?utf-8?B?QiszbUpUYW5FdEpmNEhRckJWZ1pwcXNPVUxzZFFFaFRvcFg5cU1WZ2hEVDJi?=
 =?utf-8?B?S2d4SWtWTWtucmVOL3NTWHgydUNmWFRCMGt6RTRyRXAxVzdwWUFUTXhHb0JN?=
 =?utf-8?B?Uzc1b3RBYnRhMjJqUERoOFJ0UUx4VUNzSFZBYU1HR0VTVVlJNjZscHkxK2xK?=
 =?utf-8?B?OGcvbGdxUkw2cmFXMWdXUWlSUE1HMzhGQjgrSWhCbzhzRUhUaUFjK2M4bWFz?=
 =?utf-8?B?NlNRSFVDWG8xZGNZQ2U5R2NlWkhrMUZja3lLQkF6US95cmhmWEQ4eHJ2QWg4?=
 =?utf-8?B?bjg2WXQxamdmODd2Q3BvaEVFb25jNTY0NTZMZHNhKzRkYXdMZ0FZTVRmbkJU?=
 =?utf-8?B?VE1NdHlCY2dIZW9pWEhvMVFMRGd1QUxGZVZrRU1Id2NzRUo1bVU5ZEdUMkNi?=
 =?utf-8?B?dmQ1NlNmV3lEeWVnL2plTDFVaWMzWW1QSE40OUFiZlFIeHRpdzQwSUpjSmdJ?=
 =?utf-8?B?L1hlbGZnSy9EclhBUFJ4SzVWbjJHYWxtTmNZS01qbUxEUGJKc05GbDY3MHpE?=
 =?utf-8?B?aytnM3hUdlJVOWN4WDRLVnhTM1QraXZ2UUNYci9IRm9TUEwzL1BoZHluUGE1?=
 =?utf-8?B?M3dBb1l2ejk0VkNjVDhwbE1YL2JBY2xHb0creHFWekF1N252VjljV0F1dlJK?=
 =?utf-8?B?MFFHQ2RtRy9obVhSTlEzeFMrL21ST243QlF4d2ZpbE5hMDZlUUJaK2J1YUU0?=
 =?utf-8?B?b0hCSVg2RnZFcE1OYWsyWVEya0pPdmRlbUdvNVhZMVhzZkc2cjcrODZHSFpj?=
 =?utf-8?B?ZUtRMSs3cVphbmpvZGp0SUMzSHQwWjlwMFBXK21oQ0dpSjVyRFRjK2syL25R?=
 =?utf-8?B?K3FTOU9vYUdXTjVUanRyT3UrVlNyYXdvcWZKaVJ0TURHTHZwUHpqYUdaN3Rm?=
 =?utf-8?B?SW9rRzBzNXVkQzkrTDJNVTREUE0yeUQ4U3I1RmlOdmR1Z0RoS3V5aDRyeHEw?=
 =?utf-8?B?STdYa2VPSEVlR0ZpaFRpNldiZFROaldTQ3k2R3pCYmdISmZpSkpVK1JHbzQ1?=
 =?utf-8?B?UkRza0haZmRVSXdzRWV2LzJqLzhDZlJSTHZyd2JKaGovaVkzQ3N1MnRIRkFE?=
 =?utf-8?B?VDRGWnpKSDcrSE5yNVFFaitLZzZmVndRY2dPUDFzcDM3UVlycFlDWWpmNjR0?=
 =?utf-8?B?aXR1VzUrSW9HdjVBWmFEYVpYWlZVTkxJcTNBd3dXRDJoRklsbFpsYWJMSk5O?=
 =?utf-8?B?SkszODN1ejFXekdsVERtUm15YnFoWk40c0FvQXBJTlo1K3BXYTdBYW1VdHps?=
 =?utf-8?B?dllJV08yRmt4ZlpXbk91SzhYdEdsdG82d2dIdWdGaFc4TlFqUnlCNGtHNEhW?=
 =?utf-8?B?STVCQm9tTUlveUtSWUVBb2lVd1UvTGVoZWJiTTl3enZkU0UrTWJyZTNnYlc5?=
 =?utf-8?B?T3BWelhudEIwOTYzMUZTRHNicFFXQi9IN2Nlb3QrVmllcDh2N01wODN4VVRK?=
 =?utf-8?B?VUVuTFZ0ME04QUhBdTRiZjF5NEJJQzNoMjMySFNyeW93S1lJQkxXQTBVVEFU?=
 =?utf-8?B?OGNUc1Qvc0NiOHpvS003TUhYbHFVUW9JR0IwbEg3bXBxOWV5aUxZSnNrcnU2?=
 =?utf-8?B?Q2toKzNMaG5EZ3duYkhkNzFHWjJJaVJ2S1RQMld3aVlrU3g3QnU0K2FlK29K?=
 =?utf-8?B?aVBNRFFXS3RBRE55TktWckprTlJVUVU0RDFOR1c2TEFlS0FmMzZTMEFSTC8w?=
 =?utf-8?Q?VAn/zCPg5w05puxh/RTBarUXreFJ4VZvOPhTXG2jgQ2Me?=
X-MS-Exchange-AntiSpam-MessageData-1: nNDtzwzTNR0SAg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d2cb4c-495d-4ffe-a11a-08da390cfde4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 20:28:39.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PH48Jz5lHDxsY5U4u8I5sJ/fcoGn0c0V9vsopAghvlSvPt24jvXXvaNM2KWw2UfL+9QkVuhJL2AIb+ZBQIOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1004
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/18/22 19:44, Vivek Goyal wrote:
> On Wed, May 18, 2022 at 01:41:02PM -0400, Vivek Goyal wrote:
>> On Tue, May 17, 2022 at 03:37:42PM +0530, Dharmendra Singh wrote:
>>
>> [..]
>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>> index d6ccee961891..bebe4be3f1cb 100644
>>> --- a/include/uapi/linux/fuse.h
>>> +++ b/include/uapi/linux/fuse.h
>>> @@ -301,6 +301,7 @@ struct fuse_file_lock {
>>>    * FOPEN_CACHE_DIR: allow caching this directory
>>>    * FOPEN_STREAM: the file is stream-like (no file position at all)
>>>    * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
>>> + * FOPEN_FILE_CREATED: the file was actually created
>>>    */
>>>   #define FOPEN_DIRECT_IO		(1 << 0)
>>>   #define FOPEN_KEEP_CACHE	(1 << 1)
>>> @@ -308,6 +309,7 @@ struct fuse_file_lock {
>>>   #define FOPEN_CACHE_DIR		(1 << 3)
>>>   #define FOPEN_STREAM		(1 << 4)
>>>   #define FOPEN_NOFLUSH		(1 << 5)
>>> +#define FOPEN_FILE_CREATED	(1 << 6)
>>>   
>>>   /**
>>>    * INIT request/reply flags
>>> @@ -537,6 +539,7 @@ enum fuse_opcode {
>>>   	FUSE_SETUPMAPPING	= 48,
>>>   	FUSE_REMOVEMAPPING	= 49,
>>>   	FUSE_SYNCFS		= 50,
>>> +	FUSE_CREATE_EXT		= 51,
>>
>> I am wondering if we really have to introduce a new opcode for this. Both
>> FUSE_CREATE and FUSE_CREATE_EXT prepare and send fuse_create_in{} and
>> expect fuse_entry_out and fuse_open_out in response. So no new structures
>> are being added. Only thing FUSE_CREATE_EXT does extra is that it also
>> reports back whether file was actually created or not.
>>
>> May be instead of adding an new fuse_opcode, we could simply add a
>> new flag which we send in fuse_create_in and that reqeusts to report
>> if file was created or not. This is along the lines of
>> FUSE_OPEN_KILL_SUIDGID.
>>
>> So say, a new flag FUSE_OPEN_REPORT_CREATE flag. Which we will set in
>> fuse_create_in->open_flags. If file server sees this flag is set, it
>> knows that it needs to set FOPEN_FILE_CREATED flag in response.
>>
>> To me creating a new flag FUSE_OPEN_REPORT_CREATE seems better instead
>> of adding a new opcode.
> 
> Actually I take that back. If we were to use a flag, then we will have to
> do feature negotiation in advance at init time and only then we can set
> FUSE_OPEN_REPORT_CREATE. But we are relying on no new feature bit instead
> -ENOSYS will be returned if server does not support FUSE_CREATE_EXT.
> So adding a new opcode is better.

I guess it might work, if a flag is set and also returned (I would then 
call it FUSE_CREATE_EXT) - user space creat would need to set 
FOPEN_FILE_CREATED and that new flag. I just doubt that it simplifies 
things.

Btw, thanks a lot for your thorough reviews! Much appreciated.


Thanks,
Bernd
