Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96252E2D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbiETDEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbiETDED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:04:03 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A4864718;
        Thu, 19 May 2022 20:04:00 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K2uqVW023920;
        Fri, 20 May 2022 03:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=EGpBC3trx9zQYBqWb8tK8rraLF23c6igBtI1617Xiso=;
 b=WFdhwS5I8sQs+HRTUdVq7zGiZwaKOhUqkJJZD5gCCbxE2yYUWyUYPiqapRHV20Zy/4oA
 YInBCX5zLgo8qowS1isf7Nkd6VM2XnckrBN8HlG+9jDyBpDzrQRylppmGE1KWZeio9sb
 ntGWKnYseCNiLLg78rH//QM729kGeXOa3IyYuQJtJVTb3TYe3uYbT8SYvtp/TJ9UOnGS
 NsWZy4IxMpzlFhe0/stUtaubglRa71Ry1IeXX6Qb1wE8vaBmPwpTdnLVvmKqrbWxcZ+K
 2HwBAQdtbLkhMZjNIETlYi5R8KM6zjbMzdfW9XAttjFXm+c1WC7ThszS/5Af9x9fNCYn wA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3g23d8mw9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 03:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp6pGhh5s3PuyaAsELn1qRGHwdo7sY5bUjNaRCrSNusG2gQ+cIpMcT3Btpi9E1L+0uBhat5ZIsXX2TUWXk8CWQ6ukEIaSn2kft55H+VzXp01j9V6EBDIJq4jHp+m1yHHVBwGe4H/YCJDdXAwBY4Bc4v5moj+f9DAgzVHQURns8ZVdSvrNvfiHZWKZZQQ159CrVe63n+/wLdncIG7W2s41tLvjEP46d2S1sTZu+bqyyxkHA+4/narnZDxOV6VIHskYXtUQqnMsqU5GQFs7eCwjRfe9CEmQskK4eHfuGPxJwDCeHnj+enhULszje//EB11t027yZrfz2j9bsqRZ5NNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGpBC3trx9zQYBqWb8tK8rraLF23c6igBtI1617Xiso=;
 b=cgQxMWAqZJjwb9FuLH4/JdDdTEpB+g4Z+owcJ7CZHj8fd1EhrLW9zfpu39wuW5MGKW+Ll8Co+Tdacr0Fjn931qFjkX8uHWDzd6J9W7j5lg/QGbMaAJEsMtDVbxL0ZAWjOqTGD03ZpoUJzJDDGbjRV8KY8HEuthDkK9gzVM4L7IYey6k3cUJ3hIOE/blIwk60os4PTdGKljsS0NcmpAHhJxPfPXKxaSG6W8AotkvTBsgRKc61urfqxj0DWg2TphMc3cbvX8NKUS3qBBNk9MlWX4fKb/CI1J9eI+hL9xt51y3lT3dVGxiTDHuS8d23j9GeqjTIMrt6BZFPUytkJGAjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 03:03:42 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::1cd4:125:344:9fc]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::1cd4:125:344:9fc%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 03:03:41 +0000
Message-ID: <d6a2a914-fd1d-b00a-13d4-94ee1ff5b6fd@windriver.com>
Date:   Fri, 20 May 2022 11:03:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
 <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
 <87czg94msb.fsf@brahms.olymp>
From:   He Zhe <zhe.he@windriver.com>
In-Reply-To: <87czg94msb.fsf@brahms.olymp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d901a7d4-a9d7-400a-a996-08da3a0d57ec
X-MS-TrafficTypeDiagnostic: MN2PR11MB4551:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB455114CEA217B671D4A23B038FD39@MN2PR11MB4551.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlwFp9GrKRY90obQV5I/91sdk4T813EBKr0TMkvheSKEBN7pOGyVEmheeC1iZi7GUDA/5ORftCS6j31SDHMCrp+P5FMsbGYChlojwWhW7En460nGYJmztK0XgpvTlkoCR3/nPHf5FUOfj7iqEjZYapIhDg8+Y6sGAiVEsJlWdjQLtGXvoDrvDt/xzmZE5hoVrQoW9gqpyLmuGq20BxCPirgqvZfkb9PT6LibJRlZJZXMs2vfLbeEKQGztrAVVGbSIQaB3ApnCaT3m98NtIpM2Ms/IS0QInBK5Mjw8r/ymDvH10uKTPcSow40dPJ1267tImycVS+YWuoSRGgofYUopsYZoJjf6kTvU597BpHgum9hBKT/ouSL/6y0hPh1SLkg66TRT1U77yGClP1fi+VsMSOpnBjTI80ZJ5MlT47q88G40IvN6B49OfCpWMZSzmgTtM64rgWHI7qWqDdPKv7W52Cn1d34W2pVIXmbHGly55p5lyEDjssZmkpEoaiSJ2OslE4kzNB9cG4yWJCtJ3OVABUR67O2d9XI+NYKHPyFOGCN4scF7zwtT/iPAQcMKVXS/gQlp3A+ITn5WhEgMIio/ZfYiqhc9OToF2e1a5wg3TovsaKfEyTuBywZwfkIgtB+XVZmgXHHZ2MimoM2gnL2Cp5c5SIOG5mhXCM4fpnqRxh0tUr/2VUKGuOGmaxb2QPaaCUZmLpPr7POCA2xJdihb/2NyJ75+wFqhd2xagznw93MTDCj4QTp60sKeL7I+kIM8l752dCaCow0v6Ugx448cF8quhXEQFqrGcdH0GxAD7h06I1aYy7FKY0wQEwOY1bZ3HiVHSJVdjUYQxw+qgKwFd6tuw0DsiAM85w0yBU0uT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1358.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(966005)(6486002)(8936002)(86362001)(52116002)(54906003)(186003)(36756003)(6666004)(38100700002)(38350700002)(110136005)(66574015)(316002)(31686004)(26005)(6506007)(4326008)(31696002)(8676002)(66556008)(66946007)(6512007)(66476007)(2906002)(508600001)(83380400001)(53546011)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThUWk5DNElDeisxWnRzVkVkZk91VFNMOFJOSDJOdWRzMFZrb250aEJHekRu?=
 =?utf-8?B?UTgzYlRFVTZkdzBhenFaTjBTYWRyeXIydGVVZnZ0VW9zMWozR2kxeS81OXVQ?=
 =?utf-8?B?Smg0S3BnMU8vSlROZ3BqTGM0M2F0QzcxU244dFF6MTNydXJLZFIyVVNnMzZQ?=
 =?utf-8?B?eDZwc2MydkxwYlZtUkV4QjRnblZ4WlB3MjBFeDhqK29iUVIzWEFNWUVSWHdT?=
 =?utf-8?B?ZnNhcUY5NGF6Y3RncVExWmMrdXJuVU8yRkk5ZTZjaVRpalh6NFpQc1VMRlZp?=
 =?utf-8?B?aFFzYVVwakJZMXJ0d3JhNk5sQjdFVFVDSlFPdStBU3pMZjV4RHByOGJVRDVp?=
 =?utf-8?B?dlZjS1JCY0xHaHJMekZ4TEFYRlVaRmF5bXJ0RGRmakhWZkh3Y1ZPbk5QTU5a?=
 =?utf-8?B?SktmclJ5c0dRSHhHeVRWWTZHdGN2b3pmYTBKQWlleW9jU0pJN094eWtETmVM?=
 =?utf-8?B?SVh3WHlPTWlrNnVTUTZHTDZGWFpPckIzWmVqYkZCdXhVTVV4Z1JQMmtRbVh2?=
 =?utf-8?B?blJUVWlIaFVoeThoZzU5cGNsM0wyZXpDRUtxVklCSDdJdldhSVNZOWVYaDVI?=
 =?utf-8?B?cnVaVWxxZHZmNHlWdjlUeHFVSSt5WjQvcEJVNWtvalFZNk5WN1A2bEV3UmpF?=
 =?utf-8?B?cmhoQUFoUlJrbFZyeUx4TExKZXJkTVpraEpqM21CVjBkRi9kaFRoMDJLRVh0?=
 =?utf-8?B?NXBxWTdjeFB0QmYyMldPV2c0K1BEZUowQWdnbWgzc3VuNTZWSHZUazArS3Ew?=
 =?utf-8?B?Wld2dVE0d3BxazdpRzZEWWJQeENlV3ZqSkxXREhMa1NTTjdWclROV2p3Tk1X?=
 =?utf-8?B?bGtvNmJSMEdWZE44Y3A3QkREdlpZdHp3T0RFaGZFU1kwb0RiSC9idUh0SFJa?=
 =?utf-8?B?eGtuTHl3VnFYWnQ1RjA3RUU2bnp5RTYrMGZxMmF0NnpqYkZzWDdFdjNuZ3dv?=
 =?utf-8?B?QW9HTFMzR21oQmNKMWJZVjlCNXZBUnU2RG8wSDhCQjZDNkN3Y2JtWEZIYm5F?=
 =?utf-8?B?UStUcm40c0R5MmFhVFpWbEUvODBxcXhFdzh6NFNodnJLNi9KV0crWEtBaFc2?=
 =?utf-8?B?L0RUcDFLRXpDbml5bkZXalhMMk5HZU5yNEROR0o5c2sya09MTjlKZDlDT0dO?=
 =?utf-8?B?WVY4aTN3THRmV2twS2dkQ2pvQmZHeDJ3NVUzNXhjZmVQNnVQTEJHSkZyVnlU?=
 =?utf-8?B?bmdScEpOSVZjZ3NXdVdWRmVFYm1pRU1KZkxlK01iNUdMV2owd1pOLzhNNjhX?=
 =?utf-8?B?dEJ6RE5PVWw2VjBoT1daeURVcHNJdXJyN3llVHRUOUdGdEY5OHE5bTl0WU9Y?=
 =?utf-8?B?cExJTGJsbFpKTFA4S1kvRlJoZkVFUEZMaVZxNk9SR25waHozTnBkL0VxdmZJ?=
 =?utf-8?B?UVFWYmpRZDRHdGUrL0xYTFRSODZwa3I3MURzWkc3ZC9DU05WaVRUemNlQzJl?=
 =?utf-8?B?RUtSOWljNkkzb2w2Y01la2pFcElhWG5maXdQODU0Z0hVNXR6N0Z6L0pDMXRh?=
 =?utf-8?B?NGhGQTVEYjBIUXZFRXhiZU9ISk16WXExR242L2NlZSswNXRhaFA3TU9HeWVy?=
 =?utf-8?B?bEIxVVN0WUZMVHVYYVpEWlBrRnVLM2lmMmNxSmt2S3orWkdsTVh2cXNmODc4?=
 =?utf-8?B?RW1vc0JzMHJBUUE3b09KZkkyVElxcTdlTHlSazh3Y0U3aWZ0dGVIQjJMaUNH?=
 =?utf-8?B?SGZnVnN5YmMwZUhiQlEydnJaUnk1Qmxud3pUL0V5cmdrbjV2MHB4UmdCbWhh?=
 =?utf-8?B?T1RSaW4zVnVONnpxRTZ5eFRKb2NpRFNlclF5SzdMblExbjdiVW1tN0dLKzdv?=
 =?utf-8?B?RG13a3luWTcrZDFYZzU5U1NBalpSaDI2dXlYK3FqZ0ZHN0RSTXEvclJ2aGxD?=
 =?utf-8?B?Mk1GS2U2dzFtZWNCcTMvbnY4bW9Sbkl3dkh3QXA5YVg2RTJPRDJCZGJJVnhE?=
 =?utf-8?B?Nm5sTHpsT0V5bzc0TGpkMXk5bHRlSHdmVjViTmNOTkEydThzZ1JaSW5QQlBH?=
 =?utf-8?B?YVpNTGhpU1ZqU3Jmd2dpZjl1SDlwYytkZG56dXRocmVoQmV6RE0vOUh3UzBn?=
 =?utf-8?B?d1VXUDlncXZmdUJWak0vdE9CR1pva2dDRVBodnJsMFJWZVJaa1I3R21RcjBN?=
 =?utf-8?B?RmNSdE9WdGttaVBJTERwUTFwZnBXV1hyZ2I3a3JmZFM1U1NFTEowWGN5bXpu?=
 =?utf-8?B?T2I0T3lzelEzRURyM1VlVnRmS0JZbE5zSS9na2tlZzRyV0ZNbGNGNDcwY0Ra?=
 =?utf-8?B?akM1azhpOXJUMEY3am8wc3c3Vy9uWUd2c3JiZks2YTNRdWg3VE55MUpkVEpD?=
 =?utf-8?B?aUVCY25EVWJWdkdKaGxpS213cjczQ2RuUjg2QlFRVjRQZXRZbnE5Zz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d901a7d4-a9d7-400a-a996-08da3a0d57ec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:03:41.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dawoSBZ/6341viuTa0a8eNAdr5f107eXbjMBmRdbdsiCfvYdCWJTaboZnVDK4UcW5lM5mVSFGqKhqS8NJOOXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-Proofpoint-GUID: Pg0b7rQm0Xm4GiH8I4xNZ5eyRJ6a2-Mp
X-Proofpoint-ORIG-GUID: Pg0b7rQm0Xm4GiH8I4xNZ5eyRJ6a2-Mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_06,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200021
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/19/22 22:31, Luís Henriques wrote:
> Amir Goldstein <amir73il@gmail.com> writes:
>
>> On Thu, May 19, 2022 at 11:22 AM He Zhe <zhe.he@windriver.com> wrote:
>>> Hi,
>>>
>>> We are experiencing the following warning from
>>> "WARN_ON_ONCE(ret == -EOPNOTSUPP);" in vfs_copy_file_range, from
>>> 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
>>>
>>> # cat /sys/class/net/can0/phys_switch_id
>>>
>>> WARNING: CPU: 7 PID: 673 at fs/read_write.c:1516 vfs_copy_file_range+0x380/0x440
>>> Modules linked in: llce_can llce_logger llce_mailbox llce_core sch_fq_codel
>>> openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>>> CPU: 7 PID: 673 Comm: cat Not tainted 5.15.38-yocto-standard #1
>>> Hardware name: Freescale S32G399A (DT)
>>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : vfs_copy_file_range+0x380/0x440
>>> lr : vfs_copy_file_range+0x16c/0x440
>>> sp : ffffffc00e0f3ce0
>>> x29: ffffffc00e0f3ce0 x28: ffffff88157b5a40 x27: 0000000000000000
>>> x26: ffffff8816ac3230 x25: ffffff881c060008 x24: 0000000000001000
>>> x23: 0000000000000000 x22: 0000000000000000 x21: ffffff881cc99540
>>> x20: ffffff881cc9a340 x19: ffffffffffffffa1 x18: ffffffffffffffff
>>> x17: 0000000000000001 x16: 0000adfbb5178cde x15: ffffffc08e0f3647
>>> x14: 0000000000000000 x13: 34613178302f3061 x12: 3178302b636e7973
>>> x11: 0000000000058395 x10: 00000000fd1c5755 x9 : ffffffc008361950
>>> x8 : ffffffc00a7d4d58 x7 : 0000000000000000 x6 : 0000000000000001
>>> x5 : ffffffc009e81000 x4 : ffffffc009e817f8 x3 : 0000000000000000
>>> x2 : 0000000000000000 x1 : ffffff88157b5a40 x0 : ffffffffffffffa1
>>> Call trace:
>>>  vfs_copy_file_range+0x380/0x440
>>>  __do_sys_copy_file_range+0x178/0x3a4
>>>  __arm64_sys_copy_file_range+0x34/0x4c
>>>  invoke_syscall+0x5c/0x130
>>>  el0_svc_common.constprop.0+0x68/0x124
>>>  do_el0_svc+0x50/0xbc
>>>  el0_svc+0x54/0x130
>>>  el0t_64_sync_handler+0xa4/0x130
>>>  el0t_64_sync+0x1a0/0x1a4
>>> cat: /sys/class/net/can0/phys_switch_id: Operation not supported
>>>
>>> And we found this is triggered by the following stack. Specifically, all
>>> netdev_ops in CAN drivers we can find now do not have ndo_get_port_parent_id and
>>> ndo_get_devlink_port, which makes phys_switch_id_show return -EOPNOTSUPP all the
>>> way back to vfs_copy_file_range.
>>>
>>> phys_switch_id_show+0xf4/0x11c
>>> dev_attr_show+0x2c/0x6c
>>> sysfs_kf_seq_show+0xb8/0x150
>>> kernfs_seq_show+0x38/0x44
>>> seq_read_iter+0x1c4/0x4c0
>>> kernfs_fop_read_iter+0x44/0x50
>>> generic_file_splice_read+0xdc/0x190
>>> do_splice_to+0xa0/0xfc
>>> splice_direct_to_actor+0xc4/0x250
>>> do_splice_direct+0x94/0xe0
>>> vfs_copy_file_range+0x16c/0x440
>>> __do_sys_copy_file_range+0x178/0x3a4
>>> __arm64_sys_copy_file_range+0x34/0x4c
>>> invoke_syscall+0x5c/0x130
>>> el0_svc_common.constprop.0+0x68/0x124
>>> do_el0_svc+0x50/0xbc
>>> el0_svc+0x54/0x130
>>> el0t_64_sync_handler+0xa4/0x130
>>> el0t_64_sync+0x1a0/0x1a4
>>>
>>> According to the original commit log, this warning is for operational validity
>>> checks to generic_copy_file_range(). The reading will eventually return as
>>> not supported as printed above. But is this warning still necessary? If so we
>>> might want to remove it to have a cleaner dmesg.
>>>
>> Sigh! Those filesystems have no business doing copy_file_range()
>>
>> Here is a patch that Luis has been trying to push last year
>> to fix a problem with copy_file_range() from tracefs:
>>
>> https://lore.kernel.org/linux-fsdevel/20210702090012.28458-1-lhenriques@suse.de/
> Yikes!  It's been a while and I completely forgot about it.  I can
> definitely try to respin this patch if someone's interested in picking
> it.  I'll have to go re-read everything again and see what's missing and
> what has changed in between.

Thank you both for quick replies.

It would be good if this could be sorted out, as folks who are not familiar with
it might be confused by the call trace. But if this is supposed to cost a long
time, maybe we can first solve the false positive warning for the drivers in this
case, as it seems the "operational validity checks" was not for these drivers.

Regards,
Zhe

>
> Cheers,

