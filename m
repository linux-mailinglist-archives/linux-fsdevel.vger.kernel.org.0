Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0449B546F55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349591AbiFJVj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 17:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347712AbiFJVjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:39:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1541F613
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 14:39:23 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25AHL9AV003401;
        Fri, 10 Jun 2022 14:37:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+tdSpU4zHdNxUFi9vc8GjkCjWlCUIirKZMGbkgLF0x4=;
 b=j1DJJ6S9o3PoGoDJ9Lli+tyhMwGoyFv0e7iwq4cRir+r+LVN2ByB8v2oJfKG+AYw8ptN
 gFEGWuxmmxSnIU+wts+iVG9MnUGohklUR1qRSgsbapkoNlDZ8Ra4c5hJmn+BBSpK42QT
 xwoeh+x99M53IDqwhAE/9TSu+w9AYI77EMA= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gma9e9npt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 14:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtHj3vjwZGcCJcJ9aya7HT9R7C0D4e/uFzTVovMNnCBP9R8IFPF9ovJwhiyLx/BEIju/huZN2TVCmggnVonqtNdVHIzxqlkzUmP8o0IMgd3HJPM8hPGABp7R0WBIBS39bBtNTgFDXtYSywJMcClXul/AEcRK2LqzjHv+b4u9S/65uuMht8cptufSNc23pN2b2y3Jpc00YYhKXaLk2j5mqBveNv8t0kV2j8q9HurohPJw/Q7MHOMpy98fDgK49TzyK55WexaHIHjL5Y1zp1bQT66pqC3OmmchQW5e33VbhbYYa7mJyltrMVGCuXpKt78ddUenvKAG+QVoY7Fzdu93Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tdSpU4zHdNxUFi9vc8GjkCjWlCUIirKZMGbkgLF0x4=;
 b=iijJfmlLOEQsL7Kc4MF+9b5ZQJguaFBBTTBoUUkeonmREgTbfyDjl+Y2+Cyk/BDxtU3g/9UI4oDQvMg5rxvF2F2My/VlqzPiX9qJa387NHUEzTvOcpexKNF1cARt0EDauyPeYv2zYOt8NEhlIi6gSeklzMMUUlPJWHRo/O87SAs4/gnOTHA12+dXOHsvQ0zFMY44NXpOlQvZ/g4X4XAALd71LAIXrUrA+vZ4gdch7szUZqT66Q7O0Yd5XSf3TCPaVrkbAp7Xr6cjQfRmR23iB1BwuHlOJDUV/EikbJD/nUOtz5WuL1CP+YV1SIrXVg+woXFRFOM85zsBWSsoAuKkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW3PR15MB3980.namprd15.prod.outlook.com (2603:10b6:303:48::23)
 by DM6PR15MB2938.namprd15.prod.outlook.com (2603:10b6:5:13b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Fri, 10 Jun
 2022 21:37:12 +0000
Received: from MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::bd4a:3dd:522c:b57b]) by MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::bd4a:3dd:522c:b57b%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 21:37:12 +0000
Message-ID: <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
Date:   Fri, 10 Jun 2022 14:37:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, clm@fb.com,
        andrii@kernel.org
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein>
From:   Andrii Nakryiko <andriin@fb.com>
In-Reply-To: <20220607084724.7gseviks4h2seeza@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To MW3PR15MB3980.namprd15.prod.outlook.com
 (2603:10b6:303:48::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fb2c1c0-9acd-46f9-4e74-08da4b296129
X-MS-TrafficTypeDiagnostic: DM6PR15MB2938:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2938915421F3C8017F20D045C6A69@DM6PR15MB2938.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /GDw32pSyH3Ep26to/VP7b56nLUaONkkzl8Mn0JQYAJ1a3Y97IPvtQSmUc2q3e8w4iFoLVFi/IzvJaDnPB7bViuenxJSavslfAE7xWPxmhNbhLzOLrrnkaGEeWkHLWl291yJPsPU2TfvUNCrAh9fSBf2M6n4PhaYHpfeVpYNwDcF2rJqIntcdY62BH9WnL2lYiEhwauFFbYADSg4PiDZu0oJ1HbJaduct5tYrM3OT3vmlXslcVadLx7IhtyfWIAvPEITqkjF3cIcA0Op4vF1FQy5FO9dRW1Tfvs5b9alTl+vDuTVgZeQn7UwN2IagnCm1C9dco9n/i62Un5GRgo4UqhopevevEp0EGIoOtWgag36R+mywq1G87LlQv2wCI/jFn7KXYvDqrwDApPhgVWo1OPM2d5pNzId3/P12HpEgk6Dnr1wh5szFIDXwAhTzVfYQTYJXKzrfOeCVOv8BolB2vizf46DP6rN1Ef1hafSOPH4rTPgdmkGGrz4jpz3OhDp/o8Qs7/8/fPBDGQHi2SHCvUwRrqxaoubLFNOihT5Mox6Lu1JOMHdfvNH93jUlOC9PhFU8v9LVGUf+glx8pLMAv59Bwqe8nOvE1sJYHrnv69uHlkQ3j56WOh9+3WJ0zlSfXcJlXQwbzwVU4SLrpNrQzsrKNcv5zRu/owfzvXkZ5ppnpVIShfJI1T02xL6j3NuH4TaW7aAnkmvIwgKtT1Ni37k3BWDi9sdvcWHBiPFZDwUNpD2Uq29mgIfBL2h4mA+DvNKpPTFYr+C4TFDtdjqg9JagZWT0YDltKrl/W0KWlV6/hgohUxV8F+3xpSVDSLNTxMkMhL2Ujhqj5EZ1Xoe+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3980.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(83380400001)(53546011)(6486002)(31696002)(6512007)(52116002)(110136005)(4326008)(8676002)(5660300002)(31686004)(186003)(36756003)(2906002)(66946007)(66556008)(66476007)(316002)(54906003)(8936002)(38100700002)(84970400001)(6506007)(6666004)(86362001)(2616005)(6636002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUx1UG55Ty9HNFVOSUJGb2Z4dmxDWmhJUWNwWTNDV3RYTkV5YWFRaE5sSWI2?=
 =?utf-8?B?OFRBem9xUzI0VWxvcHlvL1JCY0ZUNXV0TkJXZkdqWG1FMUw0THFjSXdoU08v?=
 =?utf-8?B?dGp1TjREQ1VzQ1diUCtLaUNQanFLdzNxVlV3Y1BrQmJDbFhFL0ZYUmNINDZw?=
 =?utf-8?B?dDdaUU0vZUdERXJhSU9iMGZac3hjYU1mMjRoampPMVpPU214OU83YnpoWFRx?=
 =?utf-8?B?SmtSWkI5TTRWL0F4RU1PWmVxNVRWZnFzR2dQbXlYSDRyamZUOUhoUElJaFAw?=
 =?utf-8?B?STkrdzZoQURJQnZFc2FUSnNJKzg1SWNjR0I5UzIycmlGdkV6SlROL3JPVDhu?=
 =?utf-8?B?dHI5dTMxOC8zTVZmd1RMUVpOcWZON2hhZ0tJaXFvd0VTdGoyK3Rma3V6WDcw?=
 =?utf-8?B?VU82ZGZ2WkhlL0NLRTFpMjJTZnFpR3lLL20vc3VTQVB3MUd1YUtWSFZKQUF4?=
 =?utf-8?B?aTZHK093bXYwU3FYL2ZzeXZrVGpQdS83bFgzU3lEQ1Bwb3poRjkzNEwvQkQ1?=
 =?utf-8?B?M1pQcEVaSWU2YWwxOEF2bE1iOHc5akx1ODFLN1lDMUNEYUNhbmRBTytCaHVs?=
 =?utf-8?B?V2V2UVBkVWE4d0I4ZUhNQTBRM290Q3JIa2g0WlNUa1hRZmFpTEE1ZG8wcTNG?=
 =?utf-8?B?WktzTWV4dkFlbnFmVUFXb21jaGJ6c25hSGhtZ3B5UldvdTRJYlZBL3RmRUNu?=
 =?utf-8?B?TFFtSXNjVTEyemlLWnRIVWxOTnBOWERrNmxVWnIzWlVra0FCdXZKVjhlVjNQ?=
 =?utf-8?B?SW9FTmNiSnlJdlRoZlJIRzBHTGZ0eGtKNVYyU0x5T29xbVg3RmVRdEp3KzNR?=
 =?utf-8?B?ZmF2aEIrT1pySTZ1ekZoMmpQeUtiTXJmUkw5clowcHpsRGw3QmJFMjJYNGFx?=
 =?utf-8?B?RDNxTGZaVnJ6S1RZUmVSQmVIMEZ2VFVRaE9SQ3BMUytKWGdaVWh1cW1MZkxh?=
 =?utf-8?B?RDJaVzVQeEd5T042Z01YeHdSL3BUY0ZuTzRDNGdEVXBiU25wb0ZjeWtjcGtM?=
 =?utf-8?B?RllkakFoRXU2ek0wd01oNC9VcnFTZDdtamo5QWVyaHBrdmc4VEhIanR3WlNB?=
 =?utf-8?B?SzBuQUhBN3BydkFleGVGZG81cUlNRSsvQzg4cHk4VDRQMkc2V014NTFwSElN?=
 =?utf-8?B?N0l3ait2R0lWclVSMG15enFrNTNWUHM3dGRuTlNjaU9GVFlIM05MUXBzVkZX?=
 =?utf-8?B?MUhlOVVyTjFGWkZJbVVMV3A1WFBvbDM3cUR6Tkxja3F1UzdaQlBBYTU3cE1q?=
 =?utf-8?B?U29UclRCNnA3SEhYQ0d2QnpIZEVZc211Q0x4a1cweHJqME55a1M1eWU2NzQx?=
 =?utf-8?B?WnVBeU5aQVJ2WXpiL1Z1M0o2TjNrQUszYnZ1QVNiSys5YlNCWHMyM2NpRTc4?=
 =?utf-8?B?ZHF5WFFiUmtqbjNEMlZWdURTa2pIVXhuVE9RdkVQeHZQZmdqdG1DVWdDNTU2?=
 =?utf-8?B?VXp4aTNhTnJLYXFSSFkyL2ExbFpqOVljMitkZWNvTDFoakFSWmtFbkJHMzNM?=
 =?utf-8?B?dW9DbDFYdWpSK0dHRWRLRGhnUzZ5bjJqaW9STnBuVGlISlRXbXB6N0dISDVL?=
 =?utf-8?B?M0RRRXFWaHRyWmY0TG02ZXUrT2tXZlFOSHlSaTUrZ3V1dzJRUTgweFZvT3cx?=
 =?utf-8?B?c0U3SE9CUlJrYjFtWjlCMGszbVF3cmd5YXgrb2FMVjRNclJKMEtuVDFrQktT?=
 =?utf-8?B?U281YWl1YVBkME44aGpUc3JzT3lHZ0NpSmYvOVk3N1I4cldrM1orZk52VHkw?=
 =?utf-8?B?ZlNtMDFoVVlBTGRiOWU5b21abFp5Q0o5Y0Rwek83YmVoME5pa1hBbGZESlk2?=
 =?utf-8?B?cHlybGFzaWl0TVdGcC8zUlpVT05oZzBPb2ZxZTRTb1pRUFF2UjFIME1KQnFQ?=
 =?utf-8?B?bThiNkZXUlFvdVRyL0c5dGdFUyt3S2QzUHRUdytjVENtRHh5VGsvZWkxb3BP?=
 =?utf-8?B?MTRFSnlWZGhVMWJZYkF1ZHFuZ01LM0JjYlRDRFVhSFF0K1B6akJGZnFhS0N0?=
 =?utf-8?B?Z2ZYL2hxQXhIN0JNMzVZbjhHWUNxOGlvSStBVGdmNlppSHZMSitjbGx3eXBq?=
 =?utf-8?B?Q2gyamN3QmV6RjN5c2VnVzJudlh1WGFRdWJXbE5nUFRzUG45OUNnNVpjWTVq?=
 =?utf-8?B?bSs0MjZsQ1FYbE15WE9iMm1JOElnazBjak80NVplVnh0RWpHaExLbnA3TTNP?=
 =?utf-8?B?SVU2WHFNb0tLT1Q1Q3FheVd2WkpwdEdCblZoM3Ruczg1SXp5SnEvZEdOQXRK?=
 =?utf-8?B?SlNMUFJNMEs1UFpyYnYrQlcwSHByYWx6V3llUWs4N1c3b2ZHTS9RWTEySHdN?=
 =?utf-8?B?Vjc4aWg2MWxrc0xmbkhNdXUwb2ZkaEhKTERxZlJGY1dMS3cvckdYUW85Q0RV?=
 =?utf-8?Q?wob2khssqOykaYR8=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb2c1c0-9acd-46f9-4e74-08da4b296129
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3980.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 21:37:12.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETXMhszsMRsUU7zowkEG0alqMzvaJeStMrR3bxKhDLxkaSb9UpMSLSmgIQuC8YXZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2938
X-Proofpoint-ORIG-GUID: J7wzLdE0nPP9fIW1_ycB42ciIwGSchYA
X-Proofpoint-GUID: J7wzLdE0nPP9fIW1_ycB42ciIwGSchYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_09,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/7/22 1:47 AM, Christian Brauner wrote:
> On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
>> Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
>> superblock's namespace or a descendant"), access to allow_other FUSE
>> filesystems has been limited to users in the mounting user namespace or
>> descendants. This prevents a process that is privileged in its userns -
>> but not its parent namespaces - from mounting a FUSE fs w/ allow_other
>> that is accessible to processes in parent namespaces.
>>
>> While this restriction makes sense overall it breaks a legitimate
>> usecase: I have a tracing daemon which needs to peek into
>> process' open files in order to symbolicate - similar to 'perf'. The
>> daemon is a privileged process in the root userns, but is unable to peek
>> into FUSE filesystems mounted with allow_other by processes in child
>> namespaces.
>>
>> This patch adds a module param, allow_other_parent_userns, to act as an
>> escape hatch for this descendant userns logic. Setting
>> allow_other_parent_userns allows non-descendant-userns processes to
>> access FUSEs mounted with allow_other. A sysadmin setting this param
>> must trust allow_other FUSEs on the host to not DoS processes as
>> described in 73f03c2b4b52.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>
>> This is a followup to a previous attempt to solve same problem in a
>> different way: "fuse: allow CAP_SYS_ADMIN in root userns to access
>> allow_other mount" [0].
>>
>> v1 -> v2:
>>    * Use module param instead of capability check
>>
>>    [0]: lore.kernel.org/linux-fsdevel/20211111221142.4096653-1-davemarchevsky@fb.com
>>
>>   fs/fuse/dir.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 9dfee44e97ad..3d593ae7dc66 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/file.h>
>>   #include <linux/fs_context.h>
>> +#include <linux/moduleparam.h>
>>   #include <linux/sched.h>
>>   #include <linux/namei.h>
>>   #include <linux/slab.h>
>> @@ -21,6 +22,12 @@
>>   #include <linux/types.h>
>>   #include <linux/kernel.h>
>>   
>> +static bool __read_mostly allow_other_parent_userns;
>> +module_param(allow_other_parent_userns, bool, 0644);
>> +MODULE_PARM_DESC(allow_other_parent_userns,
>> + "Allow users not in mounting or descendant userns "
>> + "to access FUSE with allow_other set");
> 
> The name of the parameter also suggests that access is granted to parent
> userns tasks whereas the change seems to me to allows every task access
> to that fuse filesystem independent of what userns they are in.
> 
> So even a task in a sibling userns could - probably with rather
> elaborate mount propagation trickery - access that fuse filesystem.
> 
> AFaict, either the module parameter is misnamed or the patch doesn't
> implement the behavior expressed in the name.
> 
> The original patch restricted access to a CAP_SYS_ADMIN capable task.
> Did we agree that it was a good idea to weaken it to all tasks?
> Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> the initial userns?

I think it's fine to allow for CAP_SYS_ADMIN only, but can we then 
ignore the allow_other mount option in such case? The idea is that 
CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so 
user not mounting with allow_other preventing root from reading contents 
defeats the purpose at least partially.

> 
>> +
>>   static void fuse_advise_use_readdirplus(struct inode *dir)
>>   {
>>   	struct fuse_inode *fi = get_fuse_inode(dir);
>> @@ -1230,7 +1237,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>>   	const struct cred *cred;
>>   
>>   	if (fc->allow_other)
>> -		return current_in_userns(fc->user_ns);
>> +		return current_in_userns(fc->user_ns) || allow_other_parent_userns;
>>   
>>   	cred = current_cred();
>>   	if (uid_eq(cred->euid, fc->user_id) &&
>> -- 
>> 2.30.2
>>
