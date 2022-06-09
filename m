Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575AE54565E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiFIVPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiFIVPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:15:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BE3A6;
        Thu,  9 Jun 2022 14:15:36 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 259FPVPu002930;
        Thu, 9 Jun 2022 14:15:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XGt8NgoeyJ/90ZofQeS2MlRpvrdetzJ4qYdUpSgpX9k=;
 b=lu5dBgzwDSuW8/6QdI44FMVSyb9CJPutHfNP1H6fWvRUTUKlv1DNjKiWlUbzETSSSNI8
 eiOwvAIzJDh8h9X5F2UZdTGKxgNiCQiHonIbHvErqkzWik8JlcL/ja5TTRP/e5nDtRiQ
 dje5juIt29F/Uv3nWJ5W4uj6bqGwAQkHh70= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gjyva8stn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 14:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsQghESGFFGdAcRLrgfxoDRfihGX8W0UOHTPN/D22Y5wbGKWSjGw0JVcqDPINRpj97DxneoVfAWZxzjCsUV2t6w00JrRaZ7VXVfYlY+nHp5oOje/19nJnsOv2La5XEEARMBPS3dUAEUIQMeRHpb4W+BTzw3vEWxwb3mU6MYc8cuKcTPHShjdvRtW99gc03yYvIwEgfV98PFkEOSU5o1Tz+1pfb3SXJgCagA9DgM7QWdPwEPJQ+lSB4A1TBeUGVQD8I1YqsGQc3isxXt46un+fGxS+0who4jfD2WpMqkMJ09EojdNrt0V/PQFFsN6iDEV+LeNUYJW6jnqy/ZXgQWPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGt8NgoeyJ/90ZofQeS2MlRpvrdetzJ4qYdUpSgpX9k=;
 b=j6HtfWZT/0lLqMcBhyfhiI4E+eHsgmd885PcfofwgmBhuOF3haJMC/bXb+rEPAFR25UuYtO28GakA1aFFD+UsieVQuNNG0pqb4i6qkpfpy0A+SUz+DPjaeloTT38Avb70rM5VEC2GEw023GrLODyLA9Jvcr/kBz34TgHeFJSgOZiFLtPT9PRC+ngsQbzW0zkvH0iLpz2dE/aPbb8dQ6i0eq9QEMGIWfKcInSJTn6EBGdH47MNS2EP55upaeU64/1rhL8+SdNIerxMrJl5s1FB8do7IEgMcFW6afOpwp/VjXvY/OH0b1spU3/Rbkz0nJGWNAxRVMEgDCC9IPEYOw0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by CY5PR15MB5462.namprd15.prod.outlook.com (2603:10b6:930:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 21:15:25 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995%7]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 21:15:25 +0000
Message-ID: <8f4177bd-80ad-5e22-293e-5d1e944e1921@fb.com>
Date:   Thu, 9 Jun 2022 17:15:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] iomap: skip pages past eof in iomap_do_writepage()
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org
References: <20220608004228.3658429-1-clm@fb.com>
 <20220609005313.GX227878@dread.disaster.area>
From:   Chris Mason <clm@fb.com>
In-Reply-To: <20220609005313.GX227878@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:208:234::15) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7483e984-09e4-4e0b-35d6-08da4a5d2b87
X-MS-TrafficTypeDiagnostic: CY5PR15MB5462:EE_
X-Microsoft-Antispam-PRVS: <CY5PR15MB5462CB7F601B6399C15DA220D3A79@CY5PR15MB5462.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUOxbhZj2YUETY15x47bEjO6Y9Ev3fNgP1SOwE6TdpgGI2dLPXqBZjZg2fpHhtOmsn5zUdSYvIqbk582j9hDVQza4hKYwJm7k2xcMKsmCTl2BKYp989hqQeJjDKDD0b3VKubCOb+xij0RwSALd6kf4DsCtGYMg/g4uK5oUOh1t+3/dMbG2ddpBZodjLqkhz24PbrTeLufNKNTbeabuAtqEoFoXwAb/Y+JalthsVNRqdeW/iE5qr8ot4itZ3krNJovT2YDhwk8uuzlpQNfkd+NP+lbRFKLwShQ/HwHIpG3XGfSvw5DF9XyZti5tML2nP8pOBZZbvObzl60QHIGPi02Sgi3dX1Ne0ZSDHatktxDdwDXmtJbnPK7clWNWOaA9YKx0Vs2mcq9MMTg86U6C840zZ4bBfYHTZ4o9Gv0ksEosEWyXGj2mk52RIGEl3w9B/ohTBnD7NHbomB7vfwFGkbCyhltg5Wp9I4d5z8PLPYl6W6ogK9B4rFYD7JQBioCxHO5DM9onahiJzwzRMe61cLtsO2QaNFjVsbqxFDBh1wh/KlZYTNeE/ZBZdXjeVoQQMmH27TUpN6Uf2IX/XU5V7uQKYNodA8RGg+g9BKQEPU3qRAKvhiXezBtGO3ObMlAE97OeLwimbvfhk4eLrod5cs1Y/HDfmacFUggH4JIJWLfFqokWypsjdoLVB6GY6x4ttOzzbhgJmhfdaTJ21WMiigPkb2pqrFjh/IKJPygMjsGGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(31686004)(8676002)(66946007)(4326008)(66476007)(66556008)(6916009)(186003)(6666004)(2616005)(6512007)(83380400001)(53546011)(6506007)(38100700002)(86362001)(8936002)(31696002)(2906002)(6486002)(316002)(508600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdudVFWeDBENGJFd2VRaTk4WUdzeW1zVWh3dzEyYTJRZ2Q1L0VCQURpL3RC?=
 =?utf-8?B?RldSN3BZNkk3R0FTQlVxRmdUc2ZzNFRnZ1VkNWhjbTZ1Sklsc2h6TGJQRDhB?=
 =?utf-8?B?ZG55aWpVcGJWTHpoMzBOVkVOOWlGamppTnMyN3VhVkhkK2lsSjk4c0ZyR0dj?=
 =?utf-8?B?TXhhbkYwWDFIV2NFQjE0MDNGS1Qxb3BiNWJadWw4SlhDdEtGeFloZElsenJG?=
 =?utf-8?B?QnpjRXJreCtjaHlmSWxYbFY0ZEhJWmRCQlV6UXZkajNOUFhyajJjRkdMTUlR?=
 =?utf-8?B?di9USm1KOGtPekxMRGFhZDJXUEJhM1JveGszSEJmNzl1bTB6U25YbVdQekEw?=
 =?utf-8?B?M0prWGMyOGxiTUUybUNOdExUMXZad1N1UGkycEJQdWwvWktySTVjTXROdFFa?=
 =?utf-8?B?czVscTNMRTc3bEgxRVplL2pmcHlxV3dERUU2UXZPQzN3cktKSTVlSmcwSCt5?=
 =?utf-8?B?M1Q0UGtYcU1jSUw3WGVURnJ3Z3dnL0ZxUDNyNEowWm5tNXdrc1JaZlZUa2RT?=
 =?utf-8?B?akUyeURJUjZ0Mm1UMjJ5VVV4a1NFazAwVXhPU0FPczkzWTVvQVBHZUl5ZFFZ?=
 =?utf-8?B?UmltMlpVaGlXa09rWCs3Vy8ydG5STmZVWHFpYzlzUnU2UW1NSVdRd0tqMnoz?=
 =?utf-8?B?dDcvNklIaG9zVEF6eHlXRDNYZ25ibGh1c1hBQ25idFpVZXQ2dGN0TlhaT3JN?=
 =?utf-8?B?UTNOSHpYUHlickRsaGRtOGU4MWFNWjF1WGIrcnpxem5obHVkcllKYmZOVWFr?=
 =?utf-8?B?eGdCaWp4TDQrU3U2aWJqYi9ORnM4L0JTVSsxMGo4Z2c0Z2NERG4xZ2dxbTls?=
 =?utf-8?B?bU8xcWNJOG9sRUJHblVPS25UNE4zb1ZOei91YXdRU1lrTTgyVkQ0aUJ5NWlJ?=
 =?utf-8?B?THpuSnYwS2NiQkFjNWVoaERWODZsN2J0U29wOFpjYmVESWxLQVYxOWNpZHdh?=
 =?utf-8?B?N1AwdDhEL0d5dTdMakNTZ3ZaRFg1UmI5OVpnRVpzL3pFbEMrazhxaTlRY0V3?=
 =?utf-8?B?RE9raTBUSXI4bjVzS1VCWGE1KzhudkhRbnpiRkNtOUFIcGwwb2FRWENWWEw4?=
 =?utf-8?B?WlJNNlRqTi94cDNuUXd5RHh2WWJLeDFvMmQydjVpWkRXdUIrYzRPU0JHNzk2?=
 =?utf-8?B?cEJZSCsrSmpTZXF2d0dJKzltbEtMK2Q4SkM0VXNKUUViRkFYYkVDTWprQzlV?=
 =?utf-8?B?anJEQUE4U1Arc0djY0xlcXBGNzhMOE5WekljODBQRXJKVlA5bFNzZTFUcUND?=
 =?utf-8?B?V01rK28zbGxpSVo0cHhZdEl5bXU1c1pURlplRnAyeVU1bmlIMkx4Ly9KTXd6?=
 =?utf-8?B?ejZ0SWxsWVdERXBqMXdkdnZjVnl1RjBsRElWd2VsREg1S2theXBHZ3lKbU5B?=
 =?utf-8?B?Z1VmUDR4WjBqZzZNdndxRXczd24rQ1ZWSXc2azYydjkyQUFoMFBBVWhwbU45?=
 =?utf-8?B?LzBXTlNtWHFnOTY5L0tkMHpubjBUU3pCMW55MXR3Rkxvdi9PSEU5MDZ5dzE2?=
 =?utf-8?B?NmdaVzNsTVI0QXRxdDdlMHVpb0svZVc3RldyRnoyZlZWajBqM3NsSWxvb0Vo?=
 =?utf-8?B?SVZDajR3Y0ptamxkZWNSb2lvTzNWbWFoZ1dwc2wwc21QZGxRTk4xaTBrZm54?=
 =?utf-8?B?bURSb0wxbk81V015M3hEcUpFNTlZWXI3ZGJ5WXQ2TGRrcFk5UTNYS1ErNlhX?=
 =?utf-8?B?V09lTlA0YTNDOHZWNGhTZDM3VEdHQWVGUHN6OHptb1RaTVdrTkZaRHB3SE8z?=
 =?utf-8?B?WmN5ZGdrSHNiRzNvbHdxK3d6UWJIVFh4NEo2SlczZVA3VVRIUC9xK3FNRERL?=
 =?utf-8?B?WThzQnI5MWFvRlN4Q2Y5MEtjQTloZ3ZrTkoxRjJUVnJwM21BN2FqM1hpamcv?=
 =?utf-8?B?UkxQckRhNEpRUEw1RWpoU1pqSDR1QzhjajRtSUZ3UHAyNEQwU09wVmpXYUZs?=
 =?utf-8?B?WVh2Mmk2b2NTNW96cTM0YVg4Z1ExclJ2eFdwNTdTUm9mbkZBai9USXBGT1JV?=
 =?utf-8?B?cW5ZcXpYVStweTc1bVV0NDZDa3NyTmxQbFZ2TzFLZUJxUVM5MmdDQWJ5a0hR?=
 =?utf-8?B?RzRQZFJkaDZSSkFFNXM5ejZ3VndDem9PaDVIaEJ5cEdPWWNRVll6V3BQc290?=
 =?utf-8?B?V21qMzF5WlJ4OU04eWROelZvOEtsa0JOWTFBNXF1NFhFTUFOYVIxY0RhYTE0?=
 =?utf-8?B?c0xERHpnbVZHVEYxVW1NN1FxNE1TWXNyTU1LcXVINXJ1NXBGSGxnVUZqV2NJ?=
 =?utf-8?B?MFJqaVRIMU8rUVQvWG55bkVCSy84bEtvakRuWXhNczBJY2FUR3lFcnh2cGJH?=
 =?utf-8?B?L1Z4RmFnYnR3SlpFVElDS3JqVm0zQ3pPeFh4ZGpHSG5qcGFUdHEwTTR0RmNY?=
 =?utf-8?Q?0iBfLbMhfLJmRRjI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7483e984-09e4-4e0b-35d6-08da4a5d2b87
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 21:15:25.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbKJXcQ6/BcrAmr7rvMe1JsFhtK/H3dnh71W3277T407sdK9IoE0/nffaTupWTrv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5462
X-Proofpoint-GUID: -9CsGnhCR85EVL8ZUYNAfgvCRApj9HTu
X-Proofpoint-ORIG-GUID: -9CsGnhCR85EVL8ZUYNAfgvCRApj9HTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
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

On 6/8/22 8:53 PM, Dave Chinner wrote:
> On Tue, Jun 07, 2022 at 05:42:29PM -0700, Chris Mason wrote:
>> iomap_do_writepage() sends pages past i_size through
>> folio_redirty_for_writepage(), which normally isn't a problem because
>> truncate and friends clean them very quickly.
>>
>> When the system has cgroups configured, we can end up in situations
>> where one cgroup has almost no dirty pages at all, and other cgroups
>> consume the entire background dirty limit.  This is especially common in
>> our XFS workloads in production because they have cgroups using O_DIRECT
>> for almost all of the IO mixed in with cgroups that do more traditional
>> buffered IO work.
>>
>> We've hit storms where the redirty path hits millions of times in a few
>> seconds, on all a single file that's only ~40 pages long.  This leads to
>> long tail latencies for file writes because the pdflush workers are
>> hogging the CPU from some kworkers bound to the same CPU.
>>
>> Reproducing this on 5.18 was tricky because 869ae85dae ("xfs: flush new
>> eof page on truncate...") ends up writing/waiting most of these dirty pages
>> before truncate gets a chance to wait on them.
> 
> That commit went into 5.10, so this would mean it's not easily
> reproducable on kernels released since then?

Yes, our main two prod kernels right now are v5.6 and v5.12,  but we 
don't have enough of this database tier on 5.12 to have any meaningful 
data from production.  For my repro, I didn't spend much time on 5.12, 
but it was hard to trigger there as well.

[...]

> Regardless, the change looks fine.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Thanks!  Johannes and I are both going on vacation, but I'll get an 
experiment rolled to enough hosts to see if the long tails get shorter. 
  We're unlikely to come back with results before July.

-chris
