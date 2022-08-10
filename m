Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995DD58E6DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 07:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiHJF4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 01:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiHJF4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:56:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70121.outbound.protection.outlook.com [40.107.7.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41126548;
        Tue,  9 Aug 2022 22:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtwAWHYT+Quj+wyTvYyUhCTW4DSJa9ZfvPlnn6e43JI5vYl94dGh9owDI2MtPUu1n+6kQwDJvPdwUYK7YYM7WPN04A0kPSySfs+wAFYuD13SH7Jjp9TfinRJbN+yQYH/128CjjtZbqtZiNn9lIxaceYWh2JzvoEbK9Ge3rgwGNV7zRnhsN43oGwYF26MxN/hseD/6U5618ZJ4dI0aCQdrk/NQd09aL+utaLULx/zn1ReYZk8nUm8H4J4LlQYmraXqFjhJUH675TmXU7FH/DdFTPFNPjnR5X36J9GdP//7S5T6h5kg+My0wR/kVjEvC11YdjET/eLzvdXDYcBRvbqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9uuGfQCXLzfE1biQtsQYUVbb0BkCSNC6ArONxI5YyI=;
 b=TyyzSjP0P1fCWPVEED0pwzQU5BxtFKFEvxtlvOo/ppGJiPNLfqy8i+1f1FM18upyZaH/rIpAzMrgN+XoVYmvJofRnGYsHsK+0yR8YuESTUgGlUA7qTIoN9Cew3vEdfPD7JEQWHQvPLQsnRTasZ/zxRb6+yCtqdkfAjLZZ5K3M0b1sdxcblnh0Ru/n0gqdWbzGtmvj4CefCmfNgyC0mjFSl1zDx7d99qGvZIYzKJY1LcNI9BE5lNOTEwE6WDu0q3Iy6u/JME4+g0cL6G+SRqYKA/QoOK9X8lJ8eW6hA+qiD4RSkdG5zE225q1tyygyT3gwz01GCYY91mpWHD14W1U0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9uuGfQCXLzfE1biQtsQYUVbb0BkCSNC6ArONxI5YyI=;
 b=OFdcj7OKW47ZcaQMPYogYgEFzpTS1frXWo6Ly7gfS55g7HFl9jIlLLGuFZFUOaNZaCp/Rn3za30St4wQ7wQe/DBpxIOVAj89QWNkvGXCwmYw7VGQ9h7xcSAGHW+Upze79REmxwr7svVBH5dCiIkKln4yC309rCnjWkrHj2YD+TTMGc/j7HRN+rDdgPyVzFqdUpD3GdSYXUmNAhiVSWNvFsm2A0eDvRXD66iRpHEvOnWXoICCpx97oaajx0CHCCX3CzqbAMV01CPlKL0UD+jyBouEIYwRWwFQd2vgsUt5h4N2mS6liMK+xtQF85G+nhDsL4847e6aRdo2iBpzlJBgiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB6PR08MB2646.eurprd08.prod.outlook.com (2603:10a6:6:20::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Wed, 10 Aug
 2022 05:56:03 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 05:56:02 +0000
Message-ID: <d8fd3251-898d-89fe-226e-e166606c6983@virtuozzo.com>
Date:   Wed, 10 Aug 2022 08:54:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.1
Subject: Re: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
 <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <20220809063111-mutt-send-email-mst@kernel.org>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220809063111-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::15) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46326523-6c99-4ec1-4d26-08da7a9501e3
X-MS-TrafficTypeDiagnostic: DB6PR08MB2646:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nB7Qpc/HWo8/2tcUaZ12tw2I4nBYx8TA3W6Uv684nKJpfxdG53uuvZnVHqHIx0GKwiarndk2oWswWBA5vWZ7R8FBsq5u/gZtAh5wDrQAVk/jXI6Ltb5UOouXv7josDtVy1jvJ83pVPcYX1rF/175VsjMi5UfzGhq1bVeVs/oLPqRqZ9CUkzJkWMStqT6UuVc4Rb2fkips8yP35+RBsf8Jen2K6GZkFWImoCK7nVZotw2Ge3e+MAkMSoqfGtVXXCXGJ4Ph9dGDeAVj87KBjJ0vjsrj1r8asEDfKCjpCSuG9QhxFwP9yjaqpGfdbrenLXw+0Jjps9fZINpXPYvmi7QsjL+fTezdJ6QVQeoWken4VRDjTR8DTUyJHbItMkjj11R2oEnE6C3hKHhTOO4f0kV62SrF+uGpDSo890H+NIJn1a0eaqF5Ih9mIjdZZD2T3b/o/7pvC6keC7V7Z1L2Sjn1JmgRJK97K8ZpMzDbwt7zDTJD2oxbLGIOvriP0RVp/sYzuSfN38X+8XTGuAsIzI+FpYd/Y8WNWKzByI0BhgKm5xIjaQkI9Qqq/bMORrMAiEWbf290Vys9QQ8z15R6tsp8zvsR3N8Jz2fG0Dwaf3ONkInWcCFHl5h+nCoXGp1oyZRxmFt9vz72QqDA5NyE2lDRysi/wUT4WDWV6kk1IhE/WRpTv/NkOKFU0lK/gCbvq49GLU9TcT5KGczTflobTgaxyZzl6cUEmQ3J1wuUg4k0c99/wHzVLW7B4LuQF2xIQTYS9AGCAShSI7Gp6H6ZJVDPSYDKYcISMgHBCCHLvCSJXcZZ/U5Uz1UHLaiJLgg4Sl22IkM6aKxrKRBESdi/jsZWKIABGaF6zuZ6BAqssafruL4me6n1gspGimZ47Q8GrOo5HGDyLIOeBVUrdUR2FnmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39850400004)(366004)(136003)(346002)(38100700002)(38350700002)(26005)(53546011)(2616005)(6512007)(478600001)(31686004)(186003)(41300700001)(52116002)(6666004)(6506007)(2906002)(6916009)(66556008)(86362001)(31696002)(6486002)(316002)(8676002)(66476007)(66946007)(54906003)(5660300002)(4326008)(83380400001)(7416002)(8936002)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmtOQXFjWnpqZFhEM1BnS2hEd1VyRmxTWUpBVWV3QlFoQXhzNWV1TEhObzlv?=
 =?utf-8?B?YklyTWJvZStSRVk0VFBzUWx2TUw2TGlCYXdJRFp5RGM2YTlldXlxUHNnOHRR?=
 =?utf-8?B?R2FFL3VaYVRjby9NZUFFaHQzcEp1U0FEOTVmazFlbW5Oa0VJNGwrTlQzaEpr?=
 =?utf-8?B?anhoZEFmNzVVc2JpRlZ6U3Y0V2FyMC9Wd09PSXA3MzduSnVPQnZYZWViZjlj?=
 =?utf-8?B?bm5QbXRWd1JqV2c0VTFiR0V5YzlEaW5OZURNeVIzUjF1UE4wZS94Z202SW5W?=
 =?utf-8?B?bE5PVllwNmQzNkFLbWVoNG52MVlnQnVRZzlvakpDUVFDRmwvNWVEKzBoS0V5?=
 =?utf-8?B?MWxDdm82bGV4YkYvRUgrK0RyVDA4dmZsVUZDSDZEQ0I0cFViNW1RcXJSc2Nx?=
 =?utf-8?B?ODJIcFNzN2UyQ3lUWkZNQ1R0Q05HV0xiUUxtZWVzbzVZRHd1cnpWYWFuSGdz?=
 =?utf-8?B?ald4MXlBeTNUQkF2aGFtcndnQjI5dXdNN2c3RkZCcUpHenhYSkJ6eE9QTVNH?=
 =?utf-8?B?SG5TQ2NLeExib2VCQ2JxNytsWGh4TC9yZXNiZkU0czdDQ0phcWhLVy8xNHBo?=
 =?utf-8?B?TG5lVlV6azdvZ29aV0JITVZ5T3hOeTJhQkpPcklXR2pYdVZwNldETDA0L1dD?=
 =?utf-8?B?WnJDRkdVdGF3NTFSU1d5K1dEaUpINU5lRHQxVFJJUUFRUmYwTkZKU0Zrd1Mz?=
 =?utf-8?B?YTZPeDZGVE9oUkVCSGE5dEoxeHlTZXBrQWxmNE1hVlRQVm9YWmUwK3dDeWNH?=
 =?utf-8?B?b3FvekkvdEhEbVJPelJnRHR4RFFXemd2TS8vZFhhMFJhWUg3N2czeGZzUWNk?=
 =?utf-8?B?ZVk3TFMxbHVRUWRETjlnUnBmL0o1emNTc0ZndFc1enZ5TTdnWEpyN1VFS3l5?=
 =?utf-8?B?Ti9wNWdBZ2ZveTdNUCtKNEN4eUl4cUd4SHF3SFhack5iVDJJc05JakxTdlNw?=
 =?utf-8?B?YnVoMmxmZnMwWjVGL1VaTkh3bUlhcUxRU29iQWZ4WUNYQnFwMnkvNW12S3pq?=
 =?utf-8?B?SHBRd2ZYMkFVZWFJenpyQ2ZWTk9sSmpDUVkydU5hTzFwVFdTNHRBNzE5cHM2?=
 =?utf-8?B?amcvSFRiYnRFYm93d0NPQUNaK0VUTTN1c1F5aFd0WjhVZ25Qci9aZ1h0UlFt?=
 =?utf-8?B?RmF1L09aRWNQaU5reEJjQ1RxQVVlMkxWMjF2WjlXSTArRDNGcnZEL0dqbDBu?=
 =?utf-8?B?VUtSZk4raDNFZTYrT2ZJRDUxQXlPckJtWVJOeG9COTZtS3JtRHJRZEozeGky?=
 =?utf-8?B?cWl4UkY2WXpPRS9ZZ2w3RnowRk8yMHpnRklTcmo3YlZwOGlPVjl3VHBjcUlM?=
 =?utf-8?B?TGtzYnZZNHZJcEFSYUx1ays1UFVVQ0NJTEFicm1kaUFkemFSSDNlZlJ2Y2VM?=
 =?utf-8?B?czgyTkMyMktmQ1VpSHF5d2JoZ21SOVFia0NuWTJOaVd3VjdRejVIS1ZEM2xm?=
 =?utf-8?B?UGl5TC9uTUY3Z2FXT3QxRlFROW15SmxMQ0t4L1VzcjZtUlUxR2I5QVpScG0x?=
 =?utf-8?B?MzlXY1JiWWtLTmtocG4vL0RoMnZySHRsYzFHczNURFg4M2JjZVVSUGxJWnNk?=
 =?utf-8?B?QTN0RDRKWjlrS3A5c3loSEJucVVXakxpRUZVTUVabGRaM1dsRkNkZnMweUpI?=
 =?utf-8?B?Q3B3NmErbzIrbGN0dXUzeTkvNllwK2t1VTBLOTJOTVMxcEtNaHdOenVKNkc3?=
 =?utf-8?B?K2QwVlIrekNqckQ1NkdhL25FTUlNM01zNU04Njl4OHpnT2N0aVFIV2JjL2Fq?=
 =?utf-8?B?TmY2K1JpZ21GRTdSRnprekg4Q3lZQnJVbFlEQnJ4aFp5MFVSeUs1N1AwUTJL?=
 =?utf-8?B?UU1KUWlNenBXdDVjQmRZbnpsWngzdUZ3dmlBRnl0V3lEZkRDdlFzNno4ZEd6?=
 =?utf-8?B?NEdDbU5Cc2tNbno2U3FTeEdHZ0V6Q0FrOGtCNWlOcUJlVkV2bHdGcHhkSnkz?=
 =?utf-8?B?MEN1aEFZSHZWZlZPZWJDVzJmZUZTQ2RFeklPU1V3bTI3dEZTdWlsd0VkKzRU?=
 =?utf-8?B?KzFyYVBEMFZJYWE4akFWRHZGK3ZnSXpUU1VRbkR4TmtXVzRZSVZUSFN3emxi?=
 =?utf-8?B?V2pvWXh4VWwxV3czK3RQOVVVNXlqODQ1UWhLMnJmTkgzenhuZmZCNWlqT2ti?=
 =?utf-8?B?dkc4RE5Gbkt0UWR0OVdyYkJGTnl3aGtZTkN4WDM5WHdCYk0yNUJyS01rdTZI?=
 =?utf-8?Q?o3jic9wYdFCZjHqG5pnB9lE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46326523-6c99-4ec1-4d26-08da7a9501e3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 05:56:02.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tp1j4HzOtVkp+Z4zeFGWC/dPN4xFSiVGheiN01s3iipDOfBGalCnqYAJH0KCFbJ/YA0dSCfLfGodwueua39xWaEkDuNLZSl/MjOVvx8evbjTA62W1m472veBcawqUJW6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2646
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9.08.22 13:32, Michael S. Tsirkin wrote:
> On Tue, Aug 09, 2022 at 12:49:32PM +0300, Alexander Atanasov wrote:
>> @@ -153,6 +156,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>   		    global_zone_page_state(NR_FREE_CMA_PAGES));
>>   #endif
>>   
>> +#ifdef CONFIG_MEMORY_BALLOON
>> +	inflated_kb = atomic_long_read(&mem_balloon_inflated_kb);
>> +	if (inflated_kb >= 0)
>> +		seq_printf(m,  "Inflated(total): %8ld kB\n", inflated_kb);
>> +	else
>> +		seq_printf(m,  "Inflated(free): %8ld kB\n", -inflated_kb);
>> +#endif
>> +
>>   	hugetlb_report_meminfo(m);
>>   
>>   	arch_report_meminfo(m);
> 
> 
> This seems too baroque for my taste.
> Why not just have two counters for the two pruposes?

I agree it is not good but it reflects the current situation.
Dirvers account in only one way - either used or total - which i don't 
like. So to save space and to avoid the possibility that some driver 
starts to use both at the same time. I suggest to be only one value.


> And is there any value in having this atomic?
> We want a consistent value but just READ_ONCE seems sufficient ...

I do not see this as only a value that is going to be displayed.
I tried to be defensive here and to avoid premature optimization.
One possible scenario is OOM killer(using the value) vs balloon deflate 
on oom will need it. But any other user of that value will likely need 
it atomic too. Drivers use spin_locks for calculations they might find a 
way to reduce the spin lock usage and use the atomic.
While making it a long could only bring bugs without benefits.
It is not on a fast path too so i prefer to be safe.

-- 
Regards,
Alexander Atanasov

