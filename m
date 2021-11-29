Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1A461C8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347599AbhK2RSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 12:18:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11808 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347600AbhK2RQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:16:44 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATHC8TB025094;
        Mon, 29 Nov 2021 17:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WJDKOCIbgGcpKwRJDyIhjIXftlhKpFXYubTv8SeHzqM=;
 b=ib6n2VYwlg0truG4npxNBiniMhVaGG3542IrHPQje2ruoeWVuRV00HEXxNzvL//5eDWB
 0tvBdfX+vfFcPhQFpzwOM7wUf+ot9Jea1mQwoKC4ikoHA5/vkiQe2EdeQexfdMiaA2l+
 YqAUHkkyJMP9qReODT+2NPuJv5JBzWEFDCZVnBcoJ4JuQgtrdGV7im+ow2RyecnplThu
 YuaFgz4V1+Fw488VgWywHLjDgnSU0Vs+BjzSj8JmsS3U3BnDqj2S7nVix8PmDroQ94ux
 Jqdz6RbQigzm7hOOKcTgYbE2jLPwo04uzGhv81VnNuD9UuNqcTvo7prkSsk0DC1IqbFC qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7uh68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 17:13:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATGtguc187376;
        Mon, 29 Nov 2021 17:13:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 3ck9swqsjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 17:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmVLHo0aRbfqNe3Braev83TxoYY95CSEaUoQRk/bD91EC7r5epC0TgWBDS0tiEJojf8y9mDh23X/TKWUc8+cRI9eROuKh92WVTFiVEfkAOifS22vAk63c6aD2mMKy9Hh+4DqA3yzg3UGzKNJGJt9yd+69UNZPEThKqU0OzYJOKwdZXEOeURuZ/Uqv1JmeArnZZl0TUJEJrcKYB0gx3YAwS8w8HgqH9nV0lb9lmdN3YdbzQXmjCTYusR7ZgcXTbF1oABWkbDZcMNdaLWqKaVeHVCipw/sRlpb7w29et7ReRqyOg0SWe7+yc3NFXlcE8KXGQ2fdDUuRHzub+wQNeHOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJDKOCIbgGcpKwRJDyIhjIXftlhKpFXYubTv8SeHzqM=;
 b=bHWF5exizNkBdvvKrrfznxJ/fdGvrucQJmLSoge0l2thp0juIzHpEDCEchJjK30YVjUzR2uz5fUwscXYt4YQvybixeND1c7xc8KDFvs2j4JlYdpILd/i4PSKChtGp/tnd7P5kNFfaKrxONdjBIfshaRgfMkmzLb6SP/8ccD0Zh5QlK/enRAPyTBIOZOl77TJUoSi29gnizvk8y6EpK7XiYGZ/AyxvWaLPYr+K+mXRQEjKepPOBMoSbM8n5VpeLqosptnP6/3oqwypb2LWAhKJ6fSvfqCwUWyUDdTGfhZaqozNi8F6Rt4uc9MmOMKCWxv0XKtrRViaSF+cI7eM/Ehkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJDKOCIbgGcpKwRJDyIhjIXftlhKpFXYubTv8SeHzqM=;
 b=Rvk6qWHLsIhcbfZY5iaerbXAvMErFGRUHQs3ucUc6weXu2PYLvvyglcvMt/17j4w09RewARa6U1VqI3LUD4rgKWCwYtr2srQ9O8pIo+akwREQEfOox/csQH6bmM45w2GAp7kTUK2sfHLmHveYXOLYGez1n1M0yb7NNhZtMCnhEc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 17:13:19 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Mon, 29 Nov 2021
 17:13:19 +0000
Message-ID: <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
Date:   Mon, 29 Nov 2021 09:13:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
In-Reply-To: <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.41] (138.3.200.41) by SN1PR12CA0104.namprd12.prod.outlook.com (2603:10b6:802:21::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 17:13:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 735e454a-059d-4518-22bb-08d9b35b8a1c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4656:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4656B9B2DB4DA0A5F0DF621B87669@SJ0PR10MB4656.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xd1Rv8C93hRYh0NIoy6wbSbG3Z+1UdgXMRekoLbQ1NFU4d7h8tShu/J0avTvp9AK+2n18QinZrklV9JBfgcKHV0GLhCq2/wLISDmkqomhDn9PLxb2t08Y2XbrTbzGB8wapXX0ebzV/2Dgb2EODpDFHa8W2bySFA/k5DlJUrwDdWKuGdYAbqsnARV2Ox6w+mW/Q2kuCdvGH9h4geENINmKBlRyf1Sd5LSza4xMSFB7QtANg+eGEmKGsKxHzmkBblZrOYpbAzyCSx+cIb6MmW0m290DzBUjx2c8QqDSLOkoWEZkP8D2HBiDpOl33FNX1N+Fv9E4L8NpyGhgK2Z7kXlA1NC75fXlElyFH8nA7Li8z83ly0xLwGSL8VtbIhBz7WykKhLGv3soLp9ZoBVWUlUqSWA7h/c1VWlWq9bI7Xs96AdJARYlmZOyGq0iWgKPKr4aq6F+pPf6ufHtKTO1gz8uzeUY7Fr6qkHVWbDoZWy1g7g5nnW4kiLpDjNTN8SNI0mCySwyk6NlbBo++Rp0/bkygNFsRE3bi8Eca+93bhsgOzJ2j43gnJm1DSmWyTVjWAYOp3knP/ohQsUboATmn2wF3L7N4xVkgIU5LBNwQI1mYHWvF40qfWlaqXJWi+c3KbJTKFu8oXJZxELzj863LyHqtid6LwWX3LSWvm0LdQPcLoKo9cziNYxnc+YR8U1t6m00r05NPt0QcUAzPELSz1LXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66946007)(956004)(508600001)(31686004)(38100700002)(4326008)(6916009)(66476007)(5660300002)(31696002)(316002)(16576012)(9686003)(53546011)(2906002)(36756003)(8936002)(86362001)(8676002)(26005)(186003)(6486002)(83380400001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2VmZUtqL2xGbGo5NTJFa0dZNldMNkk1SmdXZURsUDVrdDg3UldJclBzMlFn?=
 =?utf-8?B?RnpnTzJBTDZjVzBjT2w5bjNTQzR2TGNONmxDWUkrV2VJc0l0R1JKR2FFY21K?=
 =?utf-8?B?N1ZLNGNtTVYzYlZOSDFValAxV0RDc25UVWQ2K3JMUTdjOUVnOHNSQXd4MWYz?=
 =?utf-8?B?WUNPRFFnM25BNVhPWVNiWjNvM1F3TG9KeXFYSVdickpPSDQyRDF1am5wSUtq?=
 =?utf-8?B?RDBnQWtyY0VVbU8zcjhjR0JBRFJPYmJ0UEJoamp3Ti9kaTlib1lhT0NPN0VC?=
 =?utf-8?B?Yis3SWxqbWpoc05iUkV4ZTZZSktLQjJJNm04Wm9Jc3dTY2ZQTk9BRjJXOEUy?=
 =?utf-8?B?Y09pdXc4Z2J4b1RpR0hwYTFvNXpRRmlFRTB5UTFYZnZVYmhia200ZTljVW1i?=
 =?utf-8?B?bTlyVEpicGhyeWdvM2RDSThQNDI3bzNGZytkNGhFRkdrYVJDR2JRWVBhSG9s?=
 =?utf-8?B?OXJwYktlSGNVZDRxMWY2dzhaZEd1TkdhblhnN1ZmTXZZdWEvbVZxbm9iZkxw?=
 =?utf-8?B?KzJPUmZXQkZSdXF1Nzd4SndpeEFFbDNKcDcrTDUrbW4rVGUzYnZxZi9iL2xP?=
 =?utf-8?B?MmRMNVZGc0ZienhKN3c0dzJiVzkwQTErd20reTQyWUc1ZzBLTDJJUThKU3R1?=
 =?utf-8?B?dUhjRnFYYWh5ZXRGQTJoTEJsMkc0bXIrWENZVHh6WlJieTJ6a3YyNzZGU1RR?=
 =?utf-8?B?bFNFMlJmSS9ZOXpuRE1HNTNYc3ByTklFRzBaTGRPV21xNjkwNDBnb1I0TUpl?=
 =?utf-8?B?VW5DSS9JSUNQNG5GejgrK0hoSUIvQndybVZpMEJrQ0x6UEllaHpiMnpXOVpr?=
 =?utf-8?B?RU9tdjd5VUJicGYzcS96bTM4L1BQcnF5Mm5PNzRPYnhmenhwa1FtSVNIcng0?=
 =?utf-8?B?TmFaa1F2Z05uUXJURTFkRERKQ1VGUGU4UDlna1hJWHI3YVZFSld1a0x1ZEtz?=
 =?utf-8?B?SkQ4SXY1a3FKSi9mbzd2ZGlUZ0g5YjQvVmk5eW1lY2FuWHJkcWczaVRpQjBo?=
 =?utf-8?B?aHBaTCtvd2NVcXdoK0V3SHVidlpWeUNIRU9yTzdUSkZMLytER2NKR3NsNHVi?=
 =?utf-8?B?UGFqMkVwNjM2SFNUUCtqYkxBTnhDT1NXYnhnaDdlMXhWaVduRG9NYSs5RDdv?=
 =?utf-8?B?citzSTlOYVBOQ0sxY3duNnZjM0JWT3BPeXFteTRoRjU5dmJLM1VWWUt0TGJV?=
 =?utf-8?B?N3ZvWm1FeHdtMjllNzI4MTBxNGt1OFpyeTdPSjVnUGRLTXgzdkFET3RZYmN5?=
 =?utf-8?B?RFE3OHJ1Q1NjMzNzclBPdFhYdXFjVS9oZmdIZXJ1cHdGSEdvV3ZCT2JTRGNN?=
 =?utf-8?B?S2EwYWVUS0xoV1NuQ2JCSTFVMG0zM2NvSUJnbkhiUFVJbVN2RHhsdXEwNUdu?=
 =?utf-8?B?THpncnpyYUtISmpmYjlOTnZrdzFpekhwVFFYcXk4VHpGL1pQM210OUhPOVZx?=
 =?utf-8?B?WDZmVGJGMGIyYjY1eGM0WHlnOTB4RytOZkJSRHJldWs4eHdLYnVvTjE2R2Ju?=
 =?utf-8?B?OGpUUTBxeCtscmVxbTNWOFNYdndTK3hsREpNLzQrUFRKU1QraGw1MVFxbzZC?=
 =?utf-8?B?aWdXSkFnQXdQallURlFtdlFPMGpWRGJOSzcvZXUrSDJmLzVqdUZOZTIzSXhK?=
 =?utf-8?B?ZjdBelh6QS9QZUhCSTJBQlB2U2RiVTFKbEhjQW0vN0JKK0NFaDZiTEovSitP?=
 =?utf-8?B?TFdlTkFWSlQwNUsvRW9QM2hEaDgwVkR6Q0JkOXF5Y1B4cVVadTJtYm9ZOWxn?=
 =?utf-8?B?WC9maEhiMTRyRmZkaHdhQ3RGb1NDUFBaV29NNXYrR1RyYXJXQ2d4VVAwLzdV?=
 =?utf-8?B?NHNkYSt5aEtCUitVbGx4K2d4SWMyU3RTWWpIajliMzVOeENTWm81eDNaak4z?=
 =?utf-8?B?ZDBualgzaThBTFh5SjRJaVh0WnM1VGVOcHZHVnJFYWppMkdBdktsaVBrQ01k?=
 =?utf-8?B?eUROa0dIZTY5TWZWNUR1dGR0bDIrUHdOalRJcHNxWHRzdnIxb0JOQkZCcDV2?=
 =?utf-8?B?VlNOUHgzSFFDRE96OEd1c1hVTWkrdDQ1MHkvQ1dXLyt0Rmh5ZlQrZ3ZVelBS?=
 =?utf-8?B?TWFEYzdBVHZ4M1ZxUUF4TkVXYjdOSTNlWTUrdTdnYXhUWWhxRk8yanFIZ3lm?=
 =?utf-8?B?VGs4eTFZVkhRZDdpVEhyeUh2Tjk4RUhrTXdveG9sVm5pS0tZVExTN1hucEg4?=
 =?utf-8?Q?Hq/k0JXHgCOabWIu2fEmuZE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735e454a-059d-4518-22bb-08d9b35b8a1c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 17:13:19.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGFoV1xVYz9jxikWOE+EmjU9hcoM0VybXT1TCn1O4z/kc/uLN18iGHTyS3Xbtd2gAWELZfxQo7fbrR1iUGpR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290081
X-Proofpoint-ORIG-GUID: WVUrHGUr3Fsbrzf_z1pl1p4jQIfirzHG
X-Proofpoint-GUID: WVUrHGUr3Fsbrzf_z1pl1p4jQIfirzHG
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bruce,

On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>
> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>>>>> Just a reminder that this patch is still waiting for your review.
>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>>> failure for me....
>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>>> seen still there.
>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
>>> 5.15-rc7 server.
>>>
>>> Nfs4.1 results are the same for both courteous and non-courteous 
>>> server:
>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>> Results of nfs4.0 with non-courteous server:
>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>> test failed: LOCK24
>>>
>>> Results of nfs4.0 with courteous server:
>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>> tests failed: LOCK24, OPEN18, OPEN30
>>>
>>> OPEN18 and OPEN30 test pass if each is run by itself.
>> Could well be a bug in the tests, I don't know.
>
> The reason OPEN18 failed was because the test timed out waiting for
> the reply of an OPEN call. The RPC connection used for the test was
> configured with 15 secs timeout. Note that OPEN18 only fails when
> the tests were run with 'all' option, this test passes if it's run
> by itself.
>
> With courteous server, by the time OPEN18 runs, there are about 1026
> courtesy 4.0 clients on the server and all of these clients have opened
> the same file X with WRITE access. These clients were created by the
> previous tests. After each test completed, since 4.0 does not have
> session, the client states are not cleaned up immediately on the
> server and are allowed to become courtesy clients.
>
> When OPEN18 runs (about 20 minutes after the 1st test started), it
> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
> server to check for conflicts with courtesy clients. The loop that
> checks 1026 courtesy clients for share/access conflict took less
> than 1 sec. But it took about 55 secs, on my VM, for the server
> to expire all 1026 courtesy clients.
>
> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
> timeout and OPEN18 now consistently passed. The 4.0 test results are
> now the same for courteous and non-courteous server:
>
> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>
> Note that 4.1 tests do not suffer this timeout problem because the
> 4.1 clients and sessions are destroyed after each test completes.

Do you want me to send the patch to increase the timeout for pynfs?
or is there any other things you think we should do?

Thanks,
-Dai

