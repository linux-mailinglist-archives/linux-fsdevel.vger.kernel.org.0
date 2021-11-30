Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378574628EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhK3APY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 19:15:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230422AbhK3APU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:15:20 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU03Ho2026596;
        Tue, 30 Nov 2021 00:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kwx+Jt5t79pxxCSb2Goxn3/vzAqgwmihfcQ6fSWV190=;
 b=E4knPjciFbPJFA+XiX52cMdy+GcZ4qJmKKCO3xNHQJBLble7RjwW/TJBslRTLAloBbZL
 M2OaL+qI1jOV+0zkZCAp9IDs/nQNh32mbczHG76iEawf0jO6P8Js5UTICDbDzqCC3jPS
 Q13yups918NfBGWz8DU58LVXtPAEHFxlkhc+ftyF48uXAcjcY2plvwtciYj6kE4Ozkxw
 e8xdqgfi/rrdZrhHU5MqfUeeOVodlxm3oPuPlaNbYndj5GkOlkpciB4WnF88mNifC7uB
 PjkfzDlQrhHl8+EhRhB7hNL/d5ESkG2dFZrNzdodrjAshJhIK+CPyZOLv7erZA8fyHU7 hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c596j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 00:11:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU05bEr046494;
        Tue, 30 Nov 2021 00:11:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3ckaqdpmwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 00:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeIqB5aZ14ZRP4RqRB0UKchLhnGTp/qMjhnfDWpF/Dc7YQZa7YcGQHsalIkDi/veK4XSdQIPYWMVNaSwnnbUK2g2UmAqYhxUO2v/ZPwMtjiXJ1x+6o1SEfuKVbpG4gTZcBUMu/G3Q7+XIvI/kw+eQW5edwbS5OagtTe1Xcm4yjxh4RsBRwfbWjhL97Fe49G95fca4rct+ThX53KCVtzjVWgzbPTnhqLBTYzb/gKJkJLaKw4/perrcl0jkwB3llblcFZOQFxsiouv5W9HvymEcP4XYdoUm0XTXnr2oYGIdcaFA5Ak2gjvnMn4pXFWig0eAlHyscx0Q/jymihntvlW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwx+Jt5t79pxxCSb2Goxn3/vzAqgwmihfcQ6fSWV190=;
 b=QQTcmaWe3IDmkTZF+h/w7zPOVVgljeN27xeJdncKv+bEQNPWcloCwFJtZtk9aCZwBUiI+pePgwpXfpU7mGJrSkOKBY29T5Zi+GSErDkOrmAKU3V33F4k6cQHXejsI1siOEciskj3BQSGCf/HbOpflLNSTcFcIsko8awo5iHMp1j8JjJMK3o6ZalUAFIj9geSHTJf5kP1LaZKmmX8dM5ac+egAW3WEPUNegZPp6k6GpxHLvHnxE1BKqHE27Qb9eboxTvnOTgx190mFm50dZjxSKeZeEGDmcIN8TXovArRdm+JgLjlArXQa2mbBw+pAhHl3f/TkiU9uwkMsc1c2sDvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwx+Jt5t79pxxCSb2Goxn3/vzAqgwmihfcQ6fSWV190=;
 b=EckgKADZWiax9XSwJo/niJEClmhmvs+T6kGqO5kXd361a8hEIiXypaOTgWms+/aH7NPDB2tNEYOM37IqabUdAVDZbClu1vN5tvrtGc0aml98BZ1O0JS7lfCFFXNOl4TLZTMlNHbDo/UeKy93l9RstVtDbW8QOOkmlJuEkz3PxQg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3269.namprd10.prod.outlook.com (2603:10b6:a03:155::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 30 Nov
 2021 00:11:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Tue, 30 Nov 2021
 00:11:52 +0000
Message-ID: <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
Date:   Mon, 29 Nov 2021 16:11:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:806:d1::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.41] (138.3.200.41) by SA0PR11CA0095.namprd11.prod.outlook.com (2603:10b6:806:d1::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 00:11:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ed9123-cfce-411b-700f-08d9b39602e8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3269:
X-Microsoft-Antispam-PRVS: <BYAPR10MB326974FAA336CE07EB0BAE8F87679@BYAPR10MB3269.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ECUZnvBJjK1uScqJAy3kT5GFK15UH2AwcCEcTcmbf1QUfgUSDI+keekn9VxBwqZepFx1EXMM/XNwlT84clOmiIZ5XLYpobAFhTpzLJdsOGo5OhcKQ6I6uU9I76WLWlXHAVMh5kcvxdxfhIJ6dAFjwjt08fAmQkjVL0+Hm1pBcdqWgT4T62v3cc+ad4HMTWHTRU8iqxqATFaFF6kKwYrZc+pZghvS1Nrih782XCkZPU6wybeLvV6ZeZPmEC3NK3lHYeIzmAjAh16s+1/a6KPJ/iIsIyxiypa6sgoVXLo2cGOmm0aT1S4QLyB32XN1KXK9TS2swNULoFBnkMXSWf3zNfCRCbWEBcHXUIzNjDdo5Bpaxids+dPeGvaF6Bqp0DbQmBdxz9pWdXUseQkf2PSxrtr+Tsp07rg8+x0aXvWBJj1B7e6ludw/swKQBOsoGxzCks42w70X2O7KDpE5Cyw0sPXUjj2PYB0gltQJhXISwRO6W1rDSyAabFkWVu+h0YEReKX3P5HAx1SXNYMo4VivOI3nPfA+uMrv1wk51WHj2E6pb28sxc73/LY0zW5ETb0sYW0vaUPwelBcCme3rSFpQgTE5U00Mk5bWU4XredB1ft6eyFgrWpYQawFrR/0jmYUr3SyuU4sqh2P7DgvXTj7ToTtBXerfQStswF9fHLT5FgZJ9fFCM/s2EkNZ1a9KmLTMFdciAS4u7PT6EbMWo8aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(83380400001)(66556008)(66476007)(6486002)(9686003)(31686004)(16576012)(54906003)(37006003)(38100700002)(2906002)(53546011)(36756003)(316002)(31696002)(186003)(5660300002)(508600001)(4326008)(2616005)(956004)(8936002)(26005)(8676002)(6862004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFDa3k3S0VhRmdLNmVWelBlN2FheWxrbHlSSkhzSng1Mm5ibFN1dkVLek5r?=
 =?utf-8?B?VHRteHk5SHZqN3p0cXJ0a05IOUE5cVpZdzNrcFNVT2JaL2JiS0NIYjZmUjd2?=
 =?utf-8?B?Q21UT3NIRTE3bWNTNi85U1NMVENEZFJEYzdoZDNBRkx2RkRnc3o3QXU2MjFK?=
 =?utf-8?B?MFZtVFF4Wk45YTBaQmN5MzVQbzZvN3VZQk1aQ290T3RrMkRDTC9QNkRmbEVx?=
 =?utf-8?B?Wk9FVlF1WjRIb09jNFl2QXA1R3pCaHRXNU5WNGZ0VDd3V2l1aWEzNjhpU2RC?=
 =?utf-8?B?WHc3ZnByNWpWMXFuWkh6Z2lkMDZvbHJ4QmYrcDljVkhjNHR2OGlPQ1RwcDNq?=
 =?utf-8?B?b0dNZTdKY0tvMlk5NGdsR2JQRDNFNi80RzRoM2c5UmFxK2lXb1BzcEdRZk94?=
 =?utf-8?B?TGM0SmNjNEhiUCtSYUppYnRHYjRUTmFYczh5RzN5NloxU01pVDVZZmR3azhW?=
 =?utf-8?B?czNKZlYvN1huSDdqS2NmdjhoTGFHYXFRWmJaUjQ4MVdHVlRhMWgxZXNtVW42?=
 =?utf-8?B?ZVdqUk5pSlBIWGFRN2dKRW9pdmlseXV6ellGKzcwbk82bk5CQUtNZGE0ZkQ4?=
 =?utf-8?B?cGd0MmtPRmJOTTV1cmRZUmhiT2Q1cGh3azA0K3NTUkJ4YjJPUlBJSU5TSTNU?=
 =?utf-8?B?eTkrLzZiampFdUlsNHJ3U21MVWE1V0Y4aVFScmZwSFRoRUV6SWRqUmlnYlo3?=
 =?utf-8?B?RzZZMkdrSldUMWZuc3R3RlJDSU5OVTlXaVBYUDhFMnZzd2hkVzdVb09GYnBt?=
 =?utf-8?B?K1FtQ1QzUU1uenJBcEJmN2JKZmRHZTFWa1F6cVBkY0lPMVI2amRFcnp4eGly?=
 =?utf-8?B?N29Rbk9aMlVmWHh1ejhhRDlEN2NlWWxVYVZ3RWJrVyt3V1ZTSmtKQ2h6MXo2?=
 =?utf-8?B?b25sKzh5cHEvS1FuMGJLaXh6R1RvSXZnWXV1NGFLTkY1QjdyLzcrWXBKYlMy?=
 =?utf-8?B?UlV2eTdiZ1RwSjNVNGVqU1NwZ0FTaUZVb2JZUnV3Y3FOenVqYmhtY0Uvc1JK?=
 =?utf-8?B?YW1VM2QxQ2svQUgvMnNYV284bk9OQUJ1Qk9lbTVTNThsNTZUbXdybDFPNk5n?=
 =?utf-8?B?anBZTW1pODM1d29IL0F3ZnhoN09ORFNhVWpHSzd5NUNpbk44ZHF6cFE1WFIv?=
 =?utf-8?B?WGpDUWNxb2x1MEgvc2dWSDBZUHMzaVJZS0ZnTTgrVkw2YU8vQ0dQa2tqSkVy?=
 =?utf-8?B?dDUrQXc5dGZxSTBoMnBuaEJsRWJhT3IrNFUvZ240Kzhrd0JDeU05VVAzbE50?=
 =?utf-8?B?L2JtYXdRODZJdEErNnlzSGhmMkQ0YkI1b0h3cVRkcE5MMkNqV3d6bWw2cXdh?=
 =?utf-8?B?cHM0NGc3Si8xY0g0N0c0VisyQkkrNW5MdUw5Ym5xbjFyb2hINWcrMU56ZTFB?=
 =?utf-8?B?cm5ydU9sYWR0WTBweFBKRTNvSEZDVVhGM3V0TXBINzVRazJ4elVNelNOZEtt?=
 =?utf-8?B?Q2craCt0MHRpVXUydWpkNTF1SDcwd2lnY05WamhxSGh0N2VxSHZIc0lRaEg3?=
 =?utf-8?B?eFUyUHV2bDNEMUltMmVzSXQyQXhxUnVXWS9saXlRWnArQzdERXBuNG14bm1m?=
 =?utf-8?B?eDNIOHpycWdKRWlSTVo4bFgxdXFpVTdveFpwMThWUjY2Qlo2cWlGRWpRaGJJ?=
 =?utf-8?B?bys0Mk5jU0RIRUExOVpva2phbkF6ZWwzNEhEUjg2cDYwMHhSQUNZdkYwNVV6?=
 =?utf-8?B?TTBpc1hGNFc0YXVYQTQwYkMvR3Z4NHRZVmZ2YlJXRWMzOWsxUThtWmlhaStp?=
 =?utf-8?B?OTl4WFJIWlNTM0o1Y29nTU1Md3E1a2hqcUZ1dk82RG5FYWJ2cTBQOEpueDI2?=
 =?utf-8?B?L0FMS3FDM1ptdDUyQ2YrR0pTb0R6U2xMOE9OWUV4clRReHB2dUdqbllEYjB1?=
 =?utf-8?B?Vi9KQzVZOEFDcS9yNHBOQzRTME85NWJiM1BoMTNaSmNxaTVybHVJV05JRHpi?=
 =?utf-8?B?Qzh5bE9vdnkwbTRLLzh5QW1aZU9MdUc2cFU5R083bzkvWmhDNnVNVEVPb3Yz?=
 =?utf-8?B?cTN5V1RsbUw1RjMwaTNoTWlEdlNIQzY3SXhISjkySkp3ZEM0RmpPeWdlT1Vt?=
 =?utf-8?B?LzBRNUovUmd4VjhyTGkwS0ZvWFp0M2xyaEt3dHdBcDZYUXJHZEsvUjBlT2Vj?=
 =?utf-8?B?RUZLQkM5a2U3blJ0RFdRdmw1M0tsL1BVOWIxY3RqS3BLVHVUM2txTUZyL3VM?=
 =?utf-8?Q?BbNECOf8CgID+WmG8LKcYpc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ed9123-cfce-411b-700f-08d9b39602e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 00:11:52.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7/EzMMCp/PmVTmtNDS/d+MCfr/FuimtKs9bzTjpT6iW958V3GY5kx2jK5XGa0YLIoVc7AbEAy8L892kl6ZANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3269
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290116
X-Proofpoint-ORIG-GUID: v3Y3C0vDB0nzITiC1xQc4-830FbGRE3D
X-Proofpoint-GUID: v3Y3C0vDB0nzITiC1xQc4-830FbGRE3D
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/29/21 1:10 PM, Chuck Lever III wrote:
>
>> On Nov 29, 2021, at 2:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 11/29/21 11:03 AM, Chuck Lever III wrote:
>>> Hello Dai!
>>>
>>>
>>>> On Nov 29, 2021, at 1:32 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>>
>>>> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>>>>> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
>>>>>> Hi Bruce,
>>>>>>
>>>>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>>>> Just a reminder that this patch is still waiting for your review.
>>>>>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>>>>>>>>> failure for me....
>>>>>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>>>>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>>>>>>>>> seen still there.
>>>>>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
>>>>>>>>> 5.15-rc7 server.
>>>>>>>>>
>>>>>>>>> Nfs4.1 results are the same for both courteous and
>>>>>>>>> non-courteous server:
>>>>>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>>>>>>>> Results of nfs4.0 with non-courteous server:
>>>>>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>>> test failed: LOCK24
>>>>>>>>>
>>>>>>>>> Results of nfs4.0 with courteous server:
>>>>>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>>>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>>>>
>>>>>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
>>>>>>>> Could well be a bug in the tests, I don't know.
>>>>>>> The reason OPEN18 failed was because the test timed out waiting for
>>>>>>> the reply of an OPEN call. The RPC connection used for the test was
>>>>>>> configured with 15 secs timeout. Note that OPEN18 only fails when
>>>>>>> the tests were run with 'all' option, this test passes if it's run
>>>>>>> by itself.
>>>>>>>
>>>>>>> With courteous server, by the time OPEN18 runs, there are about 1026
>>>>>>> courtesy 4.0 clients on the server and all of these clients have opened
>>>>>>> the same file X with WRITE access. These clients were created by the
>>>>>>> previous tests. After each test completed, since 4.0 does not have
>>>>>>> session, the client states are not cleaned up immediately on the
>>>>>>> server and are allowed to become courtesy clients.
>>>>>>>
>>>>>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
>>>>>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
>>>>>>> server to check for conflicts with courtesy clients. The loop that
>>>>>>> checks 1026 courtesy clients for share/access conflict took less
>>>>>>> than 1 sec. But it took about 55 secs, on my VM, for the server
>>>>>>> to expire all 1026 courtesy clients.
>>>>>>>
>>>>>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
>>>>>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
>>>>>>> now the same for courteous and non-courteous server:
>>>>>>>
>>>>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>
>>>>>>> Note that 4.1 tests do not suffer this timeout problem because the
>>>>>>> 4.1 clients and sessions are destroyed after each test completes.
>>>>>> Do you want me to send the patch to increase the timeout for pynfs?
>>>>>> or is there any other things you think we should do?
>>>>> I don't know.
>>>>>
>>>>> 55 seconds to clean up 1026 clients is about 50ms per client, which is
>>>>> pretty slow.  I wonder why.  I guess it's probably updating the stable
>>>>> storage information.  Is /var/lib/nfs/ on your server backed by a hard
>>>>> drive or an SSD or something else?
>>>> My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
>>>> disk. I think a production system that supports this many clients should
>>>> have faster CPUs, faster storage.
>>>>
>>>>> I wonder if that's an argument for limiting the number of courtesy
>>>>> clients.
>>>> I think we might want to treat 4.0 clients a bit different from 4.1
>>>> clients. With 4.0, every client will become a courtesy client after
>>>> the client is done with the export and unmounts it.
>>> It should be safe for a server to purge a client's lease immediately
>>> if there is no open or lock state associated with it.
>> In this case, each client has opened files so there are open states
>> associated with them.
>>
>>> When an NFSv4.0 client unmounts, all files should be closed at that
>>> point,
>> I'm not sure pynfs does proper clean up after each subtest, I will
>> check. There must be state associated with the client in order for
>> it to become courtesy client.
> Makes sense. Then a synthetic client like pynfs can DoS a courteous
> server.
>
>
>>> so the server can wait for the lease to expire and purge it
>>> normally. Or am I missing something?
>> When 4.0 client lease expires and there are still states associated
>> with the client then the server allows this client to become courtesy
>> client.
> I think the same thing happens if an NFSv4.1 client neglects to send
> DESTROY_SESSION / DESTROY_CLIENTID. Either such a client is broken
> or malicious, but the server faces the same issue of protecting
> itself from a DoS attack.
>
> IMO you should consider limiting the number of courteous clients
> the server can hold onto. Let's say that number is 1000. When the
> server wants to turn a 1001st client into a courteous client, it
> can simply expire and purge the oldest courteous client on its
> list. Otherwise, over time, the 24-hour expiry will reduce the
> set of courteous clients back to zero.
>
> What do you think?

Limiting the number of courteous clients to handle the cases of
broken/malicious 4.1 clients seems reasonable as the last resort.

I think if a malicious 4.1 clients could mount the server's export,
opens a file (to create state) and repeats the same with a different
client id then it seems like some basic security was already broken;
allowing unauthorized clients to mount server's exports.

I think if we have to enforce a limit, then it's only for handling
of seriously buggy 4.1 clients which should not be the norm. The
issue with this is how to pick an optimal number that is suitable
for the running server which can be a very slow or a very fast server.

Note that even if we impose an limit, that does not completely solve
the problem with pynfs 4.0 test since its RPC timeout is configured
with 15 secs which just enough to expire 277 clients based on 53ms
for each client, unless we limit it ~270 clients which I think it's
too low.

This is what I plan to do:

1. do not support 4.0 courteous clients, for sure.

2. limit the number of courteous clients to 1000 (?), if you still
think we need it.

Pls let me know what you think.

Thanks,
-Dai

>
>
>>>> Since there is
>>>> no destroy session/client with 4.0, the courteous server allows the
>>>> client to be around and becomes a courtesy client. So after awhile,
>>>> even with normal usage, there will be lots 4.0 courtesy clients
>>>> hanging around and these clients won't be destroyed until 24hrs
>>>> later, or until they cause conflicts with other clients.
>>>>
>>>> We can reduce the courtesy_client_expiry time for 4.0 clients from
>>>> 24hrs to 15/20 mins, enough for most network partition to heal?,
>>>> or limit the number of 4.0 courtesy clients. Or don't support 4.0
>>>> clients at all which is my preference since I think in general users
>>>> should skip 4.0 and use 4.1 instead.
>>>>
>>>> -Dai
>>> --
>>> Chuck Lever
>>>
>>>
>>>
> --
> Chuck Lever
>
>
>
