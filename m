Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2E4707B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 18:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbhLJRzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 12:55:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39984 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244749AbhLJRzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:55:36 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAGI33J020406;
        Fri, 10 Dec 2021 17:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2GtFY583nncN87YqQh5firdxlOvMKcmktfTK7f57YLo=;
 b=oRyV5JfV3FX6ISBYVsL7DPFtlS5c5jLtAqPa67tQqSnUt3hMMYGX4alaXfNyds3ze3oG
 Wcp2bGF/YrrF7SZbxxTI2QpB4uAP9OGiTMJVkdcwZBEH9fHZK979babGUMWXuaD4F36X
 jlpeG5bDP1XD8noQOl5EOQrFx2iBg1a8TDel0YXniUN0Z2TnImBJNrIuiFEInl7vW62H
 aiRWMvK4JlIB/7ji+Huk+8t7ghFHb0EtSRqpvFtWNPMKZk5YndLs+G3y0dE6CUYeUEPT
 1z5ZhyyKyRvNyZfwbAs0knXQ0rlBa6KbIeIHxwk9eSN2YIQCKGHR42IZiasERtt5W4DD rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9x079c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 17:51:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAHpLhA101934;
        Fri, 10 Dec 2021 17:51:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3cqwf4c5te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 17:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAQ2gy32rKtP4nQUUws9xPjJdYAxR+9pISK10vblxlDPVmrRhybJbwF7HQUGcXjXLpmgEzAC4Wd7e7tNSqPSQ+bWTD4erpOF3zkFzhu/BZpiW2PjNrfTIL8hLkkRWcim4ppKNFKFdMeO/BfKTRTjdqPWA3HCpLQTnyg/pWAEfUNFjmJfIO1R8COYHdgH0jR0E1qLPVQXiGZig7uc5ORKCeK2TExTiESDMm0q0ZELgBAua86AkLGC4FgkOyrBkVOTLaZtvj9x+I+NCYXFEYS7UBqwlFOsqI4bp9WXVHELSd/BQhur1AUrHSsa2Z1yIzqzIUkgN8N1h9Hm87xG4GIfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GtFY583nncN87YqQh5firdxlOvMKcmktfTK7f57YLo=;
 b=YsFaPAjplk1rP/AKCcdc5VE2+u+b1kGSOqyKXvav0zsfKeKIPm1RMN0Ffej1aD+6J6jP3GSlYfflAYS+8XKlxEtrG01c9Q1HZ7plz0qTmlt40SGr4K6KF1NHYPOIEbgEjXKZM1SsntSdqvj9S5Dub9atqD9Kk5/nIOXrWUav/ZiWtwun4kMBSGTM4VV91UOXSrc96tL4P7KhwEVIqFSW/reitAlozq3HyImZ70sK+IjR25kgJQwZIURnOH7XALO+ZZYfqn9XlT+ZA1Pe9dpw+4UK3APr8EhLxeReBF8NkS+j5RiOiG5QwMtcbpAW6n4lq9jqXuc2AjiJxa2CMJiOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GtFY583nncN87YqQh5firdxlOvMKcmktfTK7f57YLo=;
 b=T05W6RAc61FHVOB2jE8Lo/+govvT2x6IwSaRB/eRV73ub5iuksh2KakwfxyVouyBQNnp234sprYnX/NTtsu6kut4go8kb8vQT7CUgJIIE3s0gplf9ni6FFn3Cwdrkfe0VfgUzc28oxvHxEwKTm7jwJ2fDxmBxOivBfytNVcV994=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2712.namprd10.prod.outlook.com (2603:10b6:a02:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 17:51:54 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%3]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 17:51:54 +0000
Message-ID: <952f356d-2a9d-d9e0-9189-964c93294ea2@oracle.com>
Date:   Fri, 10 Dec 2021 09:51:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
 <ba637e0c64b6a2b53c8b5bf197ce02d239cdc0d2.camel@hammerspace.com>
 <605c2aef-3140-6e1a-4953-fd318dbcc277@oracle.com>
 <20211208163937.GA29555@fieldses.org>
 <cdf6317b-aa42-539a-bc7f-3150e83cbc60@oracle.com>
In-Reply-To: <cdf6317b-aa42-539a-bc7f-3150e83cbc60@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.133.18] (138.3.200.18) by SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Fri, 10 Dec 2021 17:51:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f23642-8eb2-41e9-c5d6-08d9bc05c0da
X-MS-TrafficTypeDiagnostic: BYAPR10MB2712:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2712C53BE09040DDA31FDDF787719@BYAPR10MB2712.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S55l7Xq9okfAppt0Of32EJMU6qCgFwMeG59vfYu/RrhHy1wgCCapG8OLMykGBK9oCM+7bXi/IdsIbgsRdkwJhiCWAo+UrbOsxpGh4nf9/U5jrK7GgH0I/Zvxg61I5JC//2KkPCw5gXT3yswwu05vH5tyZnxpbVAENGoVlYbOvq75PSsscJdYaEnqG9qs1D0abqpDZ7yNHdBuYmBZN91OXLwaoJvMDv/2n4Oh8nZj+GYz3JHD7PrA2gIpIbK5rVstwgRxdfS5hcv1LW/zcxuKZ5h6wSlAgUVq0k2PNKLzOj5J2E+uOMU6NAHxQadIBqv5HxJnpJlNfxYIQOiHiIqZDG6i2CB+IdOZEsGklALQsHVLwmfGD/K27RfRsANFzUXJhOAen6Ma2+OW/mziEtNRgzp3VCLriWX4AMPwW7ZR95D5suq4f3Badaf/tMR/hGIRmUcM6rUYQ2nOg1Jb3uIB9tnv0elAzKrtL9vd2C+zBPm9DPUkJQw44nxu6dJPMcsC/SpxJlwVweHlYjum+2mTG2YGuEOPfVaD+oQ7yFc8yNNCeY+NU7mhWx964MM58GzhGzam9X9kmpSveXlsAhD9Kc5sWzA/PNj8NOkmgQa7gkyoQvHNwvY2UpwwIeHAHWCClNehbJCVhBAPrV0WesU5WHYNzKPYPJq2f5wPFnn66AJS3Jvfgw7pkM688/xtXiw3d4U8wP6xmmWgYLAxWm2qcYycBuPeY+sTeVxjQSiZTj7fcnD65TI/eNOcZO0vpB0kds0Bqu4cwFLN6i6en7qG+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(2616005)(8936002)(9686003)(186003)(5660300002)(8676002)(19627235002)(31686004)(53546011)(4326008)(16576012)(2906002)(66476007)(31696002)(316002)(26005)(6486002)(6916009)(86362001)(966005)(83380400001)(508600001)(36756003)(66946007)(66556008)(54906003)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzNOYTBOUmxoS1lCUHB2SWlVRkVRZTlmTUNUNHpQOTN3ZGs5cE1PSExqWCt3?=
 =?utf-8?B?REkzaWJaNUhjSkg0WnZRcjQ4cUp1WE51NmFPMjY5dWRVNk1JWmhXSWwxQXpm?=
 =?utf-8?B?ZVdRL3duOVhJd0VhdTBqVTNWRGRRWXZRWVlmc1ZqcXhSK0xKVk54a2duRUlV?=
 =?utf-8?B?S1Y5Tnc5Q2dHTGcrb3F6dlBkMlovaTZ4U3RiaXZHck4yT3VBTjQwT0todjRC?=
 =?utf-8?B?YlYzRmpBU3BOUS9BMXk2M2ZOaVRXbTBZVUhrY0gzek0xUnE0T3BMbFNlVFFr?=
 =?utf-8?B?MzhURXdDWWdoY1kwLzlsRXJGbkRMWWZoOUFFMDJOYi9udmRodkFYK25HeUtX?=
 =?utf-8?B?RkpkQXBkQ052RHFzcytjUkhOalpONDJOOVJCOGZScmNqcC9FUzVOQThBS0VV?=
 =?utf-8?B?OWI4cFNqTGs0WkQza0pINHA4ajNwOUlVNmorNzVPU0JSdWFZbndTNDJZSUV2?=
 =?utf-8?B?NVZ4ajlPRDlPeSs2RFFzQ0RYODRVZDlVSHRsTjdqVm5oRkl4ZHpFNVBUamJx?=
 =?utf-8?B?MlBmbkRUcENJbk5rZzRpbTVPekhCdy9yVGlpbUFhVnA5czF1ZW4xeEN1dE9D?=
 =?utf-8?B?NDZJNzVKRE54SkI1MFQ3ZTFkdkRaVHJyaGp3bWJqU3EzVlIrTWhHODlKdFEw?=
 =?utf-8?B?R3paUHFGSjhvVnd5Q1B3NEJmdE4vRWlsbnlYcWh5d3Y5U1V2cUxMVlNWd0RY?=
 =?utf-8?B?MnUySXY0dHRZVktKZkdYRXhXQzVIOWtFMEQrSi9xc3pUekl5SkoySG5DZEcz?=
 =?utf-8?B?TGlyckdpMkpEZzluWkIzNElQTE5QWWg2dlFTRS9CUlljVGRvV2pEMVZkb0Ji?=
 =?utf-8?B?WC90ZmZac1pQQVFPMGZia2NZdnFGbi9DOWdwSVg3ZHlFOE56V09zM3FvU0Zl?=
 =?utf-8?B?TzlUcWN0eDFibFl2emdZK3RoTGdic3M0REpNbVZwdkw0eUpqK2lhaHJvTzU3?=
 =?utf-8?B?bE5EUndiSWhBQktrL3BxcHNjSktjZzNxWHV6L2hoNkZRMWpaTklrZ1VBc2d0?=
 =?utf-8?B?ekorUmQyVFFqWU52WnIrd2wvY3gxR21qREFWaElhd1M0MFA5bXh1dWRVZHoz?=
 =?utf-8?B?ZGRFQ1lCNlFsblBVTzZnRXFVWU5rcGVTSEVid0twSEJtYnFCRlZDWmJYaDMv?=
 =?utf-8?B?eVNVMlQ2YlhyZkRWWS9pL3ZKY2pTV1hNSlJ5Y0V1Rlk2cTBvY3hMODBMSUQr?=
 =?utf-8?B?Mjlodkc1em9WZ0RNaVJuUk96MnJ5TC81VjMvTGk2bkdSb3JCNlBIdnVpdUY3?=
 =?utf-8?B?ak5SUDhZbmtLWm41LzZzWkZHd0wxYk5LTmZFSEF5akhYM1BpV0dBL2JqbmR2?=
 =?utf-8?B?ckh2MDlWOCt4SW5ycm1RZWlGb09OckIySGpyYVBHK0YyNjVLRG1Vc2hhK3hy?=
 =?utf-8?B?UDYxOWZ4Z003dHY1THg2Y29Wdy9TQnY3SVhlaUlEamVMY2Z6aWptNTVKanNo?=
 =?utf-8?B?T0RlY0lMTWpoYzJjNCtvaUN0WXh4T1BSL2oxWm9VU3RHbXVzcWEyZ1ZmT3Nw?=
 =?utf-8?B?WXA5bExzOEpMb05ERnhpUzAyRThqeDlUcWpRUmlESXJ6YnVXTlpxTnNrZHZF?=
 =?utf-8?B?Z2pKeDZRYzIwV3Jvdi9nazg4VWpMRHgzcDBGWU8vNjJDMlhTUmx3cWswVDFn?=
 =?utf-8?B?WFM5ZlRKaUhnc29QSWVNb1R1dWowUG8zRXdYUEEvNVFnZ2JpSTZ1TnI1TTZC?=
 =?utf-8?B?MGtIQVhINDU4clE0a1QrNFFLbGl2ZWJxMXF1Y015RW1rYjVDZDhDNWVBOWJL?=
 =?utf-8?B?aDFhN0s2VjJCUXRhR0xBRkpySDluN0dxVFNNUDdSZGxRZHlCZkVMUU5ReUx5?=
 =?utf-8?B?aGtSUlJUWHd6OG9WUWpsYTJKV3NZNVVZaFhZNS9wL1dBd0RXbUZ1WmFHa0Ro?=
 =?utf-8?B?a3dYdk4zZEhNQUFOcW5VbVQyMVpWUzR6TXd6SnB4V2tCRkJZWVJSU0g3UWln?=
 =?utf-8?B?K1FZL2RXaEhTNkhnYUorZWY1alVxYUtPK0wrc2duRlN4cmo4Q2lVRkl3N1Ba?=
 =?utf-8?B?cDFBUGYrWVB6dVhKcDJZaEgvQ2x4WCtVMW9UWi9wWjdET1RNYU0wTm0yOC9D?=
 =?utf-8?B?SUQ0U1Vja1c1NVdMbDJ6NFl0M29HVkVTRVRjKzlrcjZqdktlTWptTXVjUlZB?=
 =?utf-8?B?aGQ5TWxPVGs3R3JiY01SYnloRk9HUlUwREdESlU1ZDJlaE5aeEo3K0VyY3hL?=
 =?utf-8?Q?HIDRbecv+zhu3Ao8R9l44p4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f23642-8eb2-41e9-c5d6-08d9bc05c0da
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 17:51:54.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWLmUIG2gVIdrjgQbG/1BgJV7mhGDa1wE0Pb00XUsjH0HCCnpppl9xHNAnS5/xq1BH2bCtpkKRavMAhB5Y7/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2712
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100100
X-Proofpoint-ORIG-GUID: rAJ_n1MyCezddUlnlDU1AYZwZBrxfen_
X-Proofpoint-GUID: rAJ_n1MyCezddUlnlDU1AYZwZBrxfen_
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/8/21 9:29 AM, dai.ngo@oracle.com wrote:
>
> On 12/8/21 8:39 AM, bfields@fieldses.org wrote:
>> On Wed, Dec 08, 2021 at 08:25:28AM -0800, dai.ngo@oracle.com wrote:
>>> On 12/8/21 8:16 AM, Trond Myklebust wrote:
>>>> On Wed, 2021-12-08 at 07:54 -0800, dai.ngo@oracle.com wrote:
>>>>> On 12/6/21 11:55 AM, Chuck Lever III wrote:
>>>>>
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Function to check if the nfserr_share_denied error for 'fp'
>>>>>>> resulted
>>>>>>> + * from conflict with courtesy clients then release their state to
>>>>>>> resolve
>>>>>>> + * the conflict.
>>>>>>> + *
>>>>>>> + * Function returns:
>>>>>>> + *      0 -  no conflict with courtesy clients
>>>>>>> + *     >0 -  conflict with courtesy clients resolved, try
>>>>>>> access/deny check again
>>>>>>> + *     -1 -  conflict with courtesy clients being resolved in
>>>>>>> background
>>>>>>> + *            return nfserr_jukebox to NFS client
>>>>>>> + */
>>>>>>> +static int
>>>>>>> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
>>>>>>> +                       struct nfs4_file *fp, struct
>>>>>>> nfs4_ol_stateid *stp,
>>>>>>> +                       u32 access, bool share_access)
>>>>>>> +{
>>>>>>> +       int cnt = 0;
>>>>>>> +       int async_cnt = 0;
>>>>>>> +       bool no_retry = false;
>>>>>>> +       struct nfs4_client *cl;
>>>>>>> +       struct list_head *pos, *next, reaplist;
>>>>>>> +       struct nfsd_net *nn = net_generic(SVC_NET(rqstp),
>>>>>>> nfsd_net_id);
>>>>>>> +
>>>>>>> +       INIT_LIST_HEAD(&reaplist);
>>>>>>> +       spin_lock(&nn->client_lock);
>>>>>>> +       list_for_each_safe(pos, next, &nn->client_lru) {
>>>>>>> +               cl = list_entry(pos, struct nfs4_client, cl_lru);
>>>>>>> +               /*
>>>>>>> +                * check all nfs4_ol_stateid of this client
>>>>>>> +                * for conflicts with 'access'mode.
>>>>>>> +                */
>>>>>>> +               if (nfs4_check_deny_bmap(cl, fp, stp, access,
>>>>>>> share_access)) {
>>>>>>> +                       if (!test_bit(NFSD4_COURTESY_CLIENT, &cl-
>>>>>>>> cl_flags)) {
>>>>>>> +                               /* conflict with non-courtesy
>>>>>>> client */
>>>>>>> +                               no_retry = true;
>>>>>>> +                               cnt = 0;
>>>>>>> +                               goto out;
>>>>>>> +                       }
>>>>>>> +                       /*
>>>>>>> +                        * if too many to resolve synchronously
>>>>>>> +                        * then do the rest in background
>>>>>>> +                        */
>>>>>>> +                       if (cnt > 100) {
>>>>>>> +                               set_bit(NFSD4_DESTROY_COURTESY_CLIE
>>>>>>> NT, &cl->cl_flags);
>>>>>>> +                               async_cnt++;
>>>>>>> +                               continue;
>>>>>>> +                       }
>>>>>>> +                       if (mark_client_expired_locked(cl))
>>>>>>> +                               continue;
>>>>>>> +                       cnt++;
>>>>>>> +                       list_add(&cl->cl_lru, &reaplist);
>>>>>>> +               }
>>>>>>> +       }
>>>>>> Bruce suggested simply returning NFS4ERR_DELAY for all cases.
>>>>>> That would simplify this quite a bit for what is a rare edge
>>>>>> case.
>>>>> If we always do this asynchronously by returning NFS4ERR_DELAY
>>>>> for all cases then the following pynfs tests need to be modified
>>>>> to handle the error:
>>>>>
>>>>> RENEW3 st_renew.testExpired                                     :
>>>>> FAILURE
>>>>> LKU10 st_locku.testTimedoutUnlock                              :
>>>>> FAILURE
>>>>> CLOSE9 st_close.testTimedoutClose2                              :
>>>>> FAILURE
>>>>>
>>>>> and any new tests that opens file have to be prepared to handle
>>>>> NFS4ERR_DELAY due to the lack of destroy_clientid in 4.0.
>>>>>
>>>>> Do we still want to take this approach?
>>>> NFS4ERR_DELAY is a valid error for both CLOSE and LOCKU (see RFC7530
>>>> section 13.2 
>>>> https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc7530*section-13.2__;Iw!!ACWV5N9M2RV99hQ!f8vZHAJophxXdSSJvnxDCSBSRpWFxEOZBo2ZLvjPzXLVrvMYR8RKcc0_Jvjhng$
>>>> ) so if pynfs complains, then it needs fixing regardless.
>>>>
>>>> RENEW, on the other hand, cannot return NFS4ERR_DELAY, but why 
>>>> would it
>>>> need to? Either the lease is still valid, or else someone is already
>>>> trying to tear it down due to an expiration event. I don't see why
>>>> courtesy locks need to add any further complexity to that test.
>>> RENEW fails in the 2nd open:
>>>
>>>      c.create_confirm(t.word(), access=OPEN4_SHARE_ACCESS_BOTH,
>>>                       deny=OPEN4_SHARE_DENY_BOTH) <<======   DENY_BOTH
>>>      sleeptime = c.getLeaseTime() * 2
>>>      env.sleep(sleeptime)
>>>      c2 = env.c2
>>>      c2.init_connection()
>>>      c2.open_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,    
>>> <<=== needs to handle NFS4ERR_DELAY
>>>                      deny=OPEN4_SHARE_DENY_NONE)
>>>
>>> CLOSE and LOCKU also fail in the OPEN, similar to the RENEW test.
>>> Any new pynfs 4.0 test that does open might get NFS4ERR_DELAY.
>> So it's a RENEW test, not the RENEW operation.
>>
>> A general-purpose client always has to be prepared for DELAY on OPEN.
>> But pynfs isn't a general-purpose client, and it assumes that it's the
>> only one touching the files and directories it creates.
>>
>> Within pynfs we've got a problem that the tests don't necessarily clean
>> up after themselves completely, so in theory a test could interfere with
>> later results.
>>
>> But each test uses its own files--e.g. in the fragment above note that
>> the file it's testing gets the name t.word(), which is by design unique
>> to that test.  So it shouldn't be hitting any conflicts with state held
>> by previous tests.  Am I missing something?
>
> Both calls, c.create_confirm and c2.open_confirm, use the same file name
> t.word().
>
> However, it's strange that if I run RENEW3 by itself then it passes.

I found the bug in the courteous server in nfs4_laundromat where idr_get_next
was called, to check if client has states, without 'id' being set 0. This
causes the 4.0 courtesy clients to be expired unexpected, resulting in no
share reservation conflict so there is no expected NFS4ERR_DELAY returned
to the client.

I will submit the v7 patch and also will submit the patch to enhance pynfs
to handle the NFS4ERR_DELAY separately.

-Dai


