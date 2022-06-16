Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8C54E6C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377936AbiFPQQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiFPQQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:16:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9172DD61
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jun 2022 09:16:19 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GGCNlW023659;
        Thu, 16 Jun 2022 09:14:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7ZDegYTDdjhZadaNSqRcIZsQz6/IgrJbBBP5lOjVrkg=;
 b=QLStSN69HrpLCS0WiYZTty4mSpFNXQ9doOn40hbhJuNP/B5G1sgfR6dG2MF70zA8lbAF
 SZmPUapofLlcC8Uire2MxytfaNqVZ91f879DwM8lHIQQl6KP5klnl6R3rTCD5OxC1EO/
 GMDuz4QndNw8JrcFFY13vhZOVuuIVF5Rs5E= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gqve404ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 09:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaTBBt2ZyEjH9Kn6/uvEZfA6pSftykJPHWiqAAntf4hx6onzfEfRW6FAWyahrXL7PoI5ST8qCxRgyUTiCoT7DcI5tH9Qn05PLw6TJf1ZXzjboSi/duaNXddIHLDXupyafPmKBgdyGO4aXTzRPPgOOt8SfI7j1DNEdmAF7No0dGwCC73g2O52rAoBKJG4Lyc4OL0/hsiJOvwgUeVVCDPWKvr3pTH1W5XTE5M2HsTSj9eVVIYdtjPXSPVNVFaLQkQ5FdpPpePcXfFf0T+ZLpqxjBqBZ4ZDPRPTiKSbpT3hdTOen+/x/VU930Bg7fGh36TXF9hG6sVMnkwfQ926t6J0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZDegYTDdjhZadaNSqRcIZsQz6/IgrJbBBP5lOjVrkg=;
 b=oRvO4svl4o7cUxfuWHbE9xs9blcnUZr2TO+ylXLa88dCr7IfFVe6kcqz8h085zQwamTcuf4ARgfry/b+hTMygYX9M9KuWCCE6xsLxPmDLIAAZw6bv4WkqoU6hV19reQWJDIIaRtDyYi2lXVFT63jZ6BVqSN+TA2AyUoG6PR0DnZXT26ghSb9TtonrI09iOwKGUcsiLn0p+AWKijGKc82R4tU1WjKkeS8UBMaAVYdIKOLa5CmFPGDrzr0pLKOkWoAAXT0t3Qma/uXVp8x+Z+vZTtsOc8RllXWVPsXUoFOZ688ln4Z/aK4HV/jKgsi8Sp+NEM1DyYJ+k3s+BYQ2xQNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MW4PR15MB4473.namprd15.prod.outlook.com (2603:10b6:303:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 16:14:09 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%9]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:14:09 +0000
Message-ID: <d12a3287-a4ad-19da-db07-dbe62b2362a2@fb.com>
Date:   Thu, 16 Jun 2022 09:14:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-fsdevel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chris Mason <clm@fb.com>, Andrii Nakryiko <andrii@kernel.org>
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein>
 <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
 <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
 <20220613093745.4szlhoutyqpizyys@wittgenstein>
 <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
 <CAEf4BzaqfkfTgjbE2bEzELsTRpofv1Bstz2cPL8bGKS7jXvYTg@mail.gmail.com>
 <20220614143344.wxh2rmwz3gikhzga@wittgenstein>
 <CAEf4BzZFy2amO9jYLnhTCSA7sac85xWxFH_EH58T7eSKacG9Pg@mail.gmail.com>
 <20220616080154.rrgsh6a3775z4qan@wittgenstein>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220616080154.rrgsh6a3775z4qan@wittgenstein>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0f31b7b-9faf-4329-e7d4-08da4fb33e7b
X-MS-TrafficTypeDiagnostic: MW4PR15MB4473:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB4473A77CBAE9E3205EA187B8A0AC9@MW4PR15MB4473.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rbECXJNyCnlU9Y2sCfMWUWUWtqLoJyRJd9s6sRgbkOQHmVFz8DlK1XRajFk/oUD7VJpRywUTJtrjc+nszJL7xsnFdQG/lQUDZaqhGluHBsrB/gCzuDFh3wsBUI77qHzQhKF2WesNVDoZZs3zUwL8A0B5hXcIt0LoMz0c43sIUVoUiXqiDH/DOtm1ZW7W4wrvTHhLzYQex5IImHXhlJ5aLPNJ/VaIKSdDAcJyLPiAvvQoKHks/MIVPnUIYohCtulOiCP6fl6T9I0/eZu1un6GFkCFvchZ9iN5z1TRUdcdWlOvs8D63C6CjGFPH8wngQN+l22RAoXMJOgc6gkYd3dFu+5xLyLaPR9I5WxoSsJnt7aFSc8Vm/kv4RREdmLQtEAstI/3blac6fX9tJ6RzkVb51U3bLZqucm5Gx57UAeFYv3axca45kdGhg8hFbNAUAlcVqDYx/vz8Lq5gzbOwqy+wvENYa4sithsOJ38/G6rtK8tOBu0OPflg2fkQgj2xtUImPNAG1aY9Cf0YqogmoNUxvVnrvgGcGlHoUcBNPNOCxzjryh/KaMs1KDKcShwroInhtJWTXYH3dOiRVIMB1izuhXqiieV9fNNuLUPxVAn0BpgfdoPeM4OzWwVx1/58oQAF6n4zkp5FS9IyfPpa5Lg5JG3ucP5D2jSbkroDg04YsOzE7I/z1UlFKmvb3E5WV72NPJA8v1AsRdQRNNvGB89slWusQFqZBiUAboWTk38PQBY8od8WCZ7onqAfHK1NBoUA8ErWji807mQl3n3CT9cHtNfyiI7GoQwgICDMJT7xWF78VXnOKeQtqA9Ct5eWIX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(966005)(4326008)(53546011)(66946007)(66476007)(66556008)(8676002)(6506007)(5660300002)(8936002)(508600001)(6486002)(186003)(2616005)(36756003)(38100700002)(31686004)(110136005)(6512007)(83380400001)(86362001)(31696002)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9MMzM1RFhwbDBxU28xbWg3QSs2QVpJZnExcVRWTjBFU3ZOdkRjbGx5cWpq?=
 =?utf-8?B?aWtFa0Q1ekNpN0RvK2FxR0FYQWFPSXk0dlVZbTBtV05RbEsvWDhRcG1lY0FG?=
 =?utf-8?B?ZXFEa1J1allJMGJnNnRDTU5FbW84VTZUR09meWJ4SW5PZlN1cVVCMFNmeDhl?=
 =?utf-8?B?c2N2V01FU1g5T1NkTjQ5cDkvMVBUSEFVV25MV29QbURPNmgxWUs2U003L1FR?=
 =?utf-8?B?b0UwcGhOSDBLMzBtREtJMlRaemRYZko3L0pPdVd0NmFVdHFGRVNBSlRHWFA0?=
 =?utf-8?B?WnplWWZ1WlZiMXFWS3VteGpEdEdpTTBPRGpiLzVDSlphblozZ3cvMjR2eHp1?=
 =?utf-8?B?anBKREtBUjVJQXNOSXVIOUdCejE4Z3dMNmlOWmNXZjJSSU1xT1I3aHBTeW1M?=
 =?utf-8?B?SVUrVS9SWldPZGNsMXc3ZFVScXp0ak9admNxRkRhdFNYekplNzZBaVY2SmxB?=
 =?utf-8?B?cjZhRkpEMEpiU1hCL1I3K2xiTVcvVThuUWN1aFdZTVhvQjZNL2hqTkZ5NmJP?=
 =?utf-8?B?MytUbURGeFlKSS9SR0Y4NmdGY1dseG1rL09ML0toVnIxak1rWnRKKy9kSUp5?=
 =?utf-8?B?ankzaWh2M1gzVXlPckxEeVovQVY3aklmTCswYXFpS2NXc3ZvT2t4UTBYdnNa?=
 =?utf-8?B?b2MzZ2Y1aTNRRjVPQUF1VC9tUlNxamZROVA2ZktoK0lHN2w5WGJneU5iYUMy?=
 =?utf-8?B?cWc4MzZPTGt0aHdLYmZRQmRWcjZtUVdHd1luaXJZNGNia2JyWE9MU2Q0ZGd0?=
 =?utf-8?B?UzNobHo4THoxY01EOUhER0NzNFJFWjlLOFVURUlNY281b05wVVkvU0w3TzI0?=
 =?utf-8?B?ZWhKMi9UUjEwZXRXRmRBTlZWK2RTT3hKNCs4OW9VcVdFRHhEd0NORG5HbmhP?=
 =?utf-8?B?WU5OaFdKZ1RaSXAzaTJQTXJ0ZU5iYUFwUGlsZmhCMlJJbGRYVkY5Y0tsM0hu?=
 =?utf-8?B?ajBrQ3JVa2g2QmEzWlRtd3kzWTMvMDNuRDJ4MFZFZTJCMXl6WUJMdk9iWHha?=
 =?utf-8?B?ZENrTjV1ZTZhSEpUMjVSWHlaVENHRE5GRUl5K2hOMTJZaXc3cUl2NnFRUlFC?=
 =?utf-8?B?OE83ZkZYRUw3V3RZSTdyVDlJeWN3T1RlaDRybm5GMTJIYVd0aWhuMU1qZHJR?=
 =?utf-8?B?ZitrYnV5NllGd0RLeHY5KzNLdFM4WExFWStzaTZDNFdwN2QvZEZnM1lRUWE5?=
 =?utf-8?B?bkFBZGtuSElZTFo2dmZjTGlRUitxNTFTaUZETS9iNnNHcXBPU1hWU0hRR1NU?=
 =?utf-8?B?a0VnUEVvbzFrMkQwSHpKK0F2elArbmU5RlBPZVdYNHphL1JUSEg4WWtNREwy?=
 =?utf-8?B?Q3ZBZlNDcEluK005M256cWlqejRPbzlBbzVyRnRNWmZHOHlsd2dZTmM0dk9V?=
 =?utf-8?B?Z1lMaDI0alVlSVBFcUdxUzF5ek5ucTVpaVdiZGNYa05sM2dnazJPNVFqRkRN?=
 =?utf-8?B?cDAyaXMzTkV2d2dzRWpvaWNlbXdRdGtKWUxJak81WXQvaCtlai9aV1NrZVhp?=
 =?utf-8?B?TzRoOGpVcDY4SjF0Wk8xT29BN1pjZEZxeHFYTmZwUXVJZ09BY0pGNjMvMDYz?=
 =?utf-8?B?WHNCcW9NMWxEM0JmYlY3T012d2dUUzJQZ2VMN0FCRCtjRE41Z2pFTXNHbmNk?=
 =?utf-8?B?U3pPZWNtMHY5c1VGM1NJd3JvcGhRQVNrbGVKS29IUVlmZlYwOS9RQ2tnSDhr?=
 =?utf-8?B?L2p6eE0rcFRSUHMrY0VSTDdSL09SNDEzQ0pmb2xQU2lpeEZhK1dtZGtWTzVV?=
 =?utf-8?B?NmtzN21wVXArVUxHUkdLaVNhQm52K2h3bHZETWZ4RHl2SFdvaUtmZDFESWk0?=
 =?utf-8?B?LzVrUks3WkJ3Vk5WZSt3dkFONmdKdkVYVkUwV1RwbllFZGcvMEpFYWMzanNH?=
 =?utf-8?B?UnFGQ2hZbThPSDlEbnFlRDgvM2dSd2VHb0NvekVieEUrZUxWMUNzRUEyNXNZ?=
 =?utf-8?B?dDVyZ3Z1cWIybmJ1eTl1UWNxWG9uUjFLYXVVZ2VWa0hMTW1wbXVjdWsvaEFz?=
 =?utf-8?B?Tkp0VjFzazEyRlhselU2bXNhK2JDT3lWMVRZcHoraHpCdkNkbjVpUUhKRm9x?=
 =?utf-8?B?ZEdXdFExcmZDbFFRTkowQkQzN2lBeVQ3TjVJK3lPN0VuYUtlVnRHTCtOSVA5?=
 =?utf-8?B?ZUcrNWVOOTA2OENvUTZlYzRkcjh5YUorNEQwb2JtaVoydVFtRGh5bzZ2M09o?=
 =?utf-8?B?TFo0S0hMUUVyVVJXemUyQU85b21kSjJtOWozUHhQUkJTbXRMdDc1cTFHR1J4?=
 =?utf-8?B?MHhrS3VxYjUweElZWmtvbm1QYkR3WEtlYUU4Q2kzT3N6elN4MnFTV01nb3ht?=
 =?utf-8?B?ZjBzY0VkYlhuYTJ0Q1VUT09PT1h0U2JiRnVSdkUzTXBMcmNoYmZsZndyWmFP?=
 =?utf-8?Q?0ikz6usy6Rg33YQXF2t+IfgJThdazDwyfIWor?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f31b7b-9faf-4329-e7d4-08da4fb33e7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:14:09.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUgE9PLF5If92Reg8nFCs8igAgL1nesW+JhwmWfAQnJinydrP/Mu/HGtp91UIHZpb+lrT4HN+XTcplORjQZGHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4473
X-Proofpoint-ORIG-GUID: _TqHr_f5RxSVp9t-Cw4nLcLFYCMFtHjr
X-Proofpoint-GUID: _TqHr_f5RxSVp9t-Cw4nLcLFYCMFtHjr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_12,2022-06-16_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/16/22 4:01 AM, Christian Brauner wrote:   
> On Wed, Jun 15, 2022 at 04:36:35PM -0700, Andrii Nakryiko wrote:
>> On Tue, Jun 14, 2022 at 7:33 AM Christian Brauner <brauner@kernel.org> wrote:
>>>
>>> On Mon, Jun 13, 2022 at 11:21:24AM -0700, Andrii Nakryiko wrote:
>>>> On Mon, Jun 13, 2022 at 3:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>
>>>>> On Mon, 13 Jun 2022 at 11:37, Christian Brauner <brauner@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, Jun 13, 2022 at 10:23:47AM +0200, Miklos Szeredi wrote:
>>>>>>> On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 6/7/22 1:47 AM, Christian Brauner wrote:
>>>>>>>>> On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>>> +static bool __read_mostly allow_other_parent_userns;
>>>>>>>>>> +module_param(allow_other_parent_userns, bool, 0644);
>>>>>>>>>> +MODULE_PARM_DESC(allow_other_parent_userns,
>>>>>>>>>> + "Allow users not in mounting or descendant userns "
>>>>>>>>>> + "to access FUSE with allow_other set");
>>>>>>>>>
>>>>>>>>> The name of the parameter also suggests that access is granted to parent
>>>>>>>>> userns tasks whereas the change seems to me to allows every task access
>>>>>>>>> to that fuse filesystem independent of what userns they are in.
>>>>>>>>>
>>>>>>>>> So even a task in a sibling userns could - probably with rather
>>>>>>>>> elaborate mount propagation trickery - access that fuse filesystem.
>>>>>>>>>
>>>>>>>>> AFaict, either the module parameter is misnamed or the patch doesn't
>>>>>>>>> implement the behavior expressed in the name.
>>>>>>>>>
>>>>>>>>> The original patch restricted access to a CAP_SYS_ADMIN capable task.
>>>>>>>>> Did we agree that it was a good idea to weaken it to all tasks?
>>>>>>>>> Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
>>>>>>>>> the initial userns?
>>>>>>>>
>>>>>>>> I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
>>>>>>>> ignore the allow_other mount option in such case? The idea is that
>>>>>>>> CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
>>>>>>>> user not mounting with allow_other preventing root from reading contents
>>>>>>>> defeats the purpose at least partially.
>>>>>>>
>>>>>>> If we want to be compatible with "user_allow_other", then it should be
>>>>>>> checking if the uid/gid of the current task is mapped in the
>>>>>>> filesystems user_ns (fsuidgid_has_mapping()).  Right?
>>>>>>
>>>>>> I think that's doable. So assuming we're still talking about requiring
>>>>>> cap_sys_admin then we'd roughly have sm like:
>>>>>>
>>>>>>         if (fc->allow_other)
>>>>>>                 return current_in_userns(fc->user_ns) ||
>>>>>>                         (capable(CAP_SYS_ADMIN) &&
>>>>>>                         fsuidgid_has_mapping(..., &init_user_ns));
>>>>>
>>>>> No, I meant this:
>>>>>
>>>>>         if (fc->allow_other)
>>>>>                 return current_in_userns(fc->user_ns) ||
>>>>>                         (userns_allow_other &&
>>>>>                         fsuidgid_has_mapping(..., &init_user_ns));
>>>>>
>>>>> But I think the OP wanted to allow real root to access the fs, which
>>>>> this doesn't allow (since 0 will have no mapping in the user ns), so
>>>>> I'm not sure what's the right solution...
>>>>
>>>> Right, so I was basically asking why not do something like this:
>>>>
>>>> $ git diff
>>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>>> index 74303d6e987b..8c04955eb26e 100644
>>>> --- a/fs/fuse/dir.c
>>>> +++ b/fs/fuse/dir.c
>>>> @@ -1224,6 +1224,9 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>>>>  {
>>>>         const struct cred *cred;
>>>>
>>>> +       if (fuse_allow_sys_admin_access && capable(CAP_SYS_ADMIN))
>>>> +               return 1;
>>>> +
>>>>         if (fc->allow_other)
>>>>                 return current_in_userns(fc->user_ns);
>>>>
>>>>
>>>> where fuse_allow_sys_admin_access is module param which has to be
>>>> opted into through sysfs?
>>>
>>> You can either do this or do what I suggested in:
>>> https://lore.kernel.org/linux-fsdevel/20220613104604.t5ptuhrl2d4l7kbl@wittgenstein
>>> which is a bit more lax.
>>
>> My logic was that given we require opt-in and we are root, we
>> shouldn't be prevented from reading contents just because someone
>> didn't know about allow_other mount option. So I'd go with a simple
>> check before we even check fc-allow_other.
> 
> I don't see a problem with this but it other than that it subverts the
> allow_other mount option a bit tbh...

Will send v3 doing this shortly.

>>
>>>
>>> If you make it module load parameter only it has the advantage that it
>>> can't be changed after fuse has been loaded which in this case might be
>>> an advantage. It's likely that users might not be too happy if module
>>> semantics can be changed that drastically at runtime. But I have no
>>> strong opinions here.
>>>
>>
>> I'm not too familiar with this, whatever Dave was doing with
>> MODULE_PARM_DESC seems to be working fine? Did you have some other
>> preference for a specific param mechanism?
> 
> Nope, that one seems fine.

For our usecase, changing the behavior after FUSE module has been loaded is
preferable. Otherwise perf - or our internal tool - would have to emit some
message like "can't symbolicate these paths, please reload FUSE and try again"
