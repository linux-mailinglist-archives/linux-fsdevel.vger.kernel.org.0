Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9C4E51D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 13:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiCWMIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 08:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbiCWMIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:08:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8AD6462;
        Wed, 23 Mar 2022 05:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVpB2D335nkDtuks2i6N9Qy0u/BLLBoM7adCRAQqq9CIVJC6SLs03uKYiSmxFdK3Vn/JXNcwEOfKWKSb8/A1YWR9Ti9p0MMlzM4RH5oKQBjIvZLWy885mGqZTgLEeZvVlhLGFjnMmP0gWNzl5MjHPZsyrRxOy6maBw2q8N32b/3kBIVxgS+RhdRpgnb0IGjz15zrSvkxiSk0We5+ZxJ1X824CQ1B7Yuqx6q9xW9TouTjXU84hdOKEyEE6AUeCDN0XGHYdxQwJl4cKNv1snHv46CTIM4mbjKnPQ+AaXMdIexGjG4pce9YA3mepOFbziP+btmtFt3qMOsZCFhL1YVWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZddvL3/8Jcn60h01nM84H8jvC6V0u7YPSMGbhBdrFQ=;
 b=PphzLxZBjJzwRfzHnmJISmknpkcgm8UE4oFgfoP2zdjhGWaqhX1z7gLeFM4ahnZRiSP3gPDONJA6z3wmxYamJ1gJcyYsrIfpl1RfC1v+ALI55CHR+wMpeXxklgsHk1A21jt93mtPhssUcbMw4A3U5DEVW0Z5PY+n4YULMu5xe/AvjmV2XOoAnIUPb1YzrShgieyQHAru9xY5SpBXXVip4YI0gneLzXld7l7aVZDFFQYd07V/ZeZ7ggTjS2pdrARQ3QdDhY/SyfNrE4UtH1imc5+0NZEJSJv7GwK/pbJHddCYhZtt8L/+TNJ/i3GVJ0+4+n9+zV43VdczJu0Nc0puww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZddvL3/8Jcn60h01nM84H8jvC6V0u7YPSMGbhBdrFQ=;
 b=ejOInUGasHIdu14Ca8uU225IwLBVdKKmjAmcz+I2I63JK0DZvQoanfGCT8aQQzkgs2l0OvAKslCqmnqMdmXDPkQlXmJsd4zFsZe14CBQrm9xXFv/k0m+phATsc+hvKeBDYN+N0k2BdqGxR1gxDvq4LyjQWAPxx/00IqvKPL19z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by SA0PR19MB4288.namprd19.prod.outlook.com (2603:10b6:806:81::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 12:06:40 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::a012:79d3:ea4e:b406]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::a012:79d3:ea4e:b406%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 12:06:40 +0000
Message-ID: <f90f4e31-edd0-54a7-8b5e-c722930e9c34@ddn.com>
Date:   Wed, 23 Mar 2022 13:06:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] getvalues(2) prototype
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <YjrJWf+XMnWVd6K0@kroah.com> <d0e2573a-7736-bb3e-9f6a-5fa25e6d31a2@ddn.com>
 <YjsHtg7uzRGUlsb3@kroah.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YjsHtg7uzRGUlsb3@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::33) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b73bdf5-1418-4b9b-9abe-08da0cc59699
X-MS-TrafficTypeDiagnostic: SA0PR19MB4288:EE_
X-Microsoft-Antispam-PRVS: <SA0PR19MB42886D39A644CD2AA4D4D235B5189@SA0PR19MB4288.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoxUIgZr0HMhfVZ4L7vPTQxSbcWaGO1RYlU7BZ7DqJNZAdNtvulEUAb0qJLLi6uw3H8oCTBRBDPhA+ZknbRkTBYqW+fx+ab/CLxk341f6qAEai0fdHi75zmNIXI/lak+WuQKfhnMYMIJwBEif85LU0AsaLEfk5XYAJ+jDvmQfJVCNnXUtCaOw+5tR3QXGLDDD4S775WxScWq3c/RNCstzy33/Ko6O7u6oh9Nez/EcyUZqCvVdOqB2hhCJR1OfiuOF6RJ3Pjz/l5y4ljiGZhCeNyBturBJydyBypX+qFcB8TIQMwiq4fjvzD3YSxiV+UPSc5W1VqnEBxylEOtaKbfnq13ozSLORrCm1hDXUvqxPGL0o2cfF2kjE16Dwz28oqpWeoqTzXTvEIH4I1H0Cwt9AQTAoTmAVo9cZxme3PUOqBtXrxzDG5kLH7cPARWG/YeSeE1d2KteADH9K0rOGAIcXBjDBJk9H3QbHpuGR73yDT8TjRQm0rl6VcYJIVjKO9fKi/2cr60aFrIdO9IDxRUjnqurysSJlfm4svsUOSPYL1AR97blCwtjHprbRqxuUI3++f+KceWaZbD1l8Jv94H0kN325fDEar9gRFmwM2N5QRnxnZ0UbA8S8vGHSqwNdbjmIo2EQxg+r5rLd5f0YFPkhr9/jC2YH0/E9ZeNE8OMEuUvh4329o+EngggpMiebm9HZ+zrQus7oSsqpwDth2SxGmlXLog2uqNQX9EL+QgAtA0jrdOPqG5VPZUOCYJBP/4Vs/Wy//Kkrm2QcBVYFG1qZheUwiXrPsf8ch6KKKobwA2rgiZkDZOdzI3qLb+Xxw+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(36756003)(6916009)(8936002)(54906003)(53546011)(2906002)(31696002)(316002)(2616005)(186003)(6666004)(6512007)(6506007)(66946007)(66556008)(966005)(6486002)(66476007)(38100700002)(31686004)(83380400001)(5660300002)(8676002)(7416002)(4326008)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmVvOEQ2d1NsMFhpUUJvZjlJeVZ4VXhaWVg0cU5od0Y3RmRIVFljL0NtZXVk?=
 =?utf-8?B?NzZXSXJXMDNIQUc4Z2RaN29wQU9DM0xqdWgrckU1azFyOWpiRmU2QUo2bGtK?=
 =?utf-8?B?S3N0LzZQY0RiaE42b1pxWU9KWFk0cXpTR2ovenIrc3NVaWNKU0NJcEJ6Z3VB?=
 =?utf-8?B?dHVnZEo5VW5KNlE4bWRRcnh1WUJSTmJwSjZNRWNmcVhtRjNUa2R4SmtVdkNB?=
 =?utf-8?B?aGh5RE5kWmUwdVRwNHIrRzllMTZZcytSNlNqbzkyUVVzUnJLd0VpeXlYam1u?=
 =?utf-8?B?VnpNVStmZG1HWEs4WTZwWWwyWEdpb3VEU2RBV0hqT0JWMWFDU2NLN201KzU4?=
 =?utf-8?B?QnFFUnRiejVNZnJSZGdocEtPaE0xMkkrT3N5VkFpNWRkTkNJdmw0b0RObU41?=
 =?utf-8?B?VTFOeVVUVzVFVmRyYTk0c0xZRUp3OXZmdWFJalczMjQrT0tCakpMM3lBbmIw?=
 =?utf-8?B?WXdEbVJMTmZhd3FOSHEvb0g4ZTVVNEhhSTFZQjBCcFZpNC96Q2t3RmFoTnky?=
 =?utf-8?B?S3JYN1pzM1Y4Q3hnejU2RXI3OVdqdUp4OFkzWE1OUjJENmRPM0MyelhpZUpK?=
 =?utf-8?B?ay9MNmRteHIxSUoycEpFRi9mazFWMkpCM2JzNzFBRnFSZ1I0N2xTNlV1QlBa?=
 =?utf-8?B?dFVvU05PdkNUbitrRTA5WU9FVHZBRmM2OWxjODk4VUQ3dHVKNWNyWFFpUkJK?=
 =?utf-8?B?QjIxbDNOTFBTYW1FSWNkS3h0T2VFSExSbjE0YjdreXQybnBsZ2g3UUZNWUNy?=
 =?utf-8?B?REZYdEE1UnlIbVlRNjV2QWRyQTMyaHk0UDUyc3dpbFp3d25EK0NQcjJ0WHFQ?=
 =?utf-8?B?M2pjK3JuZXNuNHJhc0lwK0lsZEZYMi9pSUxMODZqaGNTRzhySFU5MVExdkVG?=
 =?utf-8?B?YVlWNXJtbUZDMlZEb0xWRUhVaEV2bWJHa1hqeVFDVkJtN2diSGhXbmpjWGdx?=
 =?utf-8?B?MklFMmp5NXhiOXdwd3ZjL3UwdjFneDFNK08zdEVVa2owWmFkN2pKaUFha01H?=
 =?utf-8?B?dytLcjB4cm5raHFtOE4wbytPNmoxT0k3dEx4bVExdUN0QlZNRkJFcnUzU2N0?=
 =?utf-8?B?bHZnamJmK25VQXRyQnBSZXdCd3NBK1BRTmx6aHoyT1VZZFFDWDdyQ3ZJQ2Fy?=
 =?utf-8?B?WmZHN0dWa1pqWEtlSEtabFJPWVp0RDREYmgzZEZDM2FBeG1XbUdYNzhEclhS?=
 =?utf-8?B?N0J4WldhQk9PdEExT3ZuU0hFWnF1dFhTSVdEcUh1MzlnR2hjamFXTHFvd2xk?=
 =?utf-8?B?TUhHYnNVSkg5Nk5Da0pqRk5QN0Z4UVduT2U4ejhWTXdPcEpjM0w2Z1NSMFpV?=
 =?utf-8?B?K05Ea0Z1K3A4aUs1am5RTFBxTDJ3OG8raVRuZld1azA3Znk0MUVmb1NSL21o?=
 =?utf-8?B?enhjbFBob1RQeVQxRUtOejBveGN4RW0xTStDNkFpQ1JYYm5mdXFqaEQ4dGZw?=
 =?utf-8?B?dmcwY0pLWUNtbHhMbmttVFFaaVkyWlEwbGZuSmg3UTNlcHo2U2tOZ1pWSXNJ?=
 =?utf-8?B?Vmo1TWpoRDBwY3Q0SytEWEdCUFFhWGJRVEVBeDdTK2JWbWZqK3hGNExLN2hr?=
 =?utf-8?B?RkV1UEkzYitZeXJiL0ZmcktldjZBbHlFOGdqdW51aXM0S3VpYWNOOEFEZk56?=
 =?utf-8?B?S2ZJUG81a1dTY0plUkRPblQ5eFFMejU2ejdDa1MzYjZQYXlqQjBRTmlPUWhG?=
 =?utf-8?B?YmgwTTZ0L2x1N3V5SUwvazRBdFpxRnFvUmd3WmkvaG42ZlpyZWVYeXBxaDN6?=
 =?utf-8?B?RDZTQmZ0NmZTZmhLdzI5QUpOMGJUN21yeFNWQ0NYQkhhVjVqOVpmTnM4Q0ls?=
 =?utf-8?B?cUdjQjdibGc3UDB0d0JpSEJkU2I0N0t2MGhVcEpxK1hrQVNESVBJNllKV0dw?=
 =?utf-8?B?a1JHS3lMOTRqT1g3ZXdacGxBZUJRelBDa05aYTVmTjRaVTVpcWNJeGpQdngr?=
 =?utf-8?B?UWVWUEpFTEVWbXA2RWdCUlFaNjNWZXRVZUZwWW9TQld1UmJiWHRlaVl1cmpO?=
 =?utf-8?B?WEN6Wm9KZldKMUU5dDQ4Zm11V0F4Tkpwd1cvOEIzbllzQkpkcXpBVUQwYXFV?=
 =?utf-8?Q?lFUScm?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b73bdf5-1418-4b9b-9abe-08da0cc59699
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 12:06:40.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mA9kedMf8skoLnfbQPAxX3gKgG/bNYpyoDBHVb46FgwwQuG/xPGt4c7ifWfMGq7Rzyqpb8tQmXf8YOUaNi02ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/23/22 12:42, Greg KH wrote:
> On Wed, Mar 23, 2022 at 11:26:11AM +0100, Bernd Schubert wrote:
>> On 3/23/22 08:16, Greg KH wrote:
>>> On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:
>>>> Add a new userspace API that allows getting multiple short values in a
>>>> single syscall.
>>>>
>>>> This would be useful for the following reasons:
>>>>
>>>> - Calling open/read/close for many small files is inefficient.  E.g. on my
>>>>     desktop invoking lsof(1) results in ~60k open + read + close calls under
>>>>     /proc and 90% of those are 128 bytes or less.
>>>
>>> As I found out in testing readfile():
>>> 	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org
>>>
>>> microbenchmarks do show a tiny improvement in doing something like this,
>>> but that's not a real-world application.
>>>
>>> Do you have anything real that can use this that shows a speedup?
>>
>> Add in network file systems. Demonstrating that this is useful locally and
>> with micro benchmarks - yeah, helps a bit to make it locally faster. But the
>> real case is when thousands of clients are handled by a few network servers.
>> Even reducing wire latency for a single client would make a difference here.
> 
> I think I tried running readfile on NFS.  Didn't see any improvements.
> But please, try it again.  Also note that this proposal isn't for NFS,
> or any other "real" filesystem :)

How did you run it on NFS? To get real benefit you would need to add a 
READ_FILE rpc to the NFS protocol and code? Just having it locally won't 
avoid the expensive wire calls?

> 
>> There is a bit of chicken-egg problem - it is a bit of work to add to file
>> systems like NFS (or others that are not the kernel), but the work won't be
>> made there before there is no syscall for it. To demonstrate it on NFS one
>> also needs a an official protocol change first. And then applications also
>> need to support that new syscall first.
>> I had a hard time explaining weather physicist back in 2009 that it is not a
>> good idea to have millions of 512B files on  Lustre. With recent AI workload
>> this gets even worse.
> 
> Can you try using the readfile() patch to see if that helps you all out
> on Lustre?  If so, that's a good reason to consider it.  But again, has
> nothing to do with this getvalues(2) api.

I don't have a Lustre system to easily play with (I'm working on another 
network file system). But unless Lustre would implement aggressive 
prefetch of data on stat, I don't see how either approach would work 
without a protocol addition. For Lustre it probably would be helpful 
only when small data are inlined into the inode.
In end this is exactly the chicken-egg problem - Lustre (or anything 
else) won't implement it before the kernel does not support it. But then 
the new syscall won't be added before it is proven that it helps.


  - Bernd


