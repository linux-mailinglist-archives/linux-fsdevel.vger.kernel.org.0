Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611B64230C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhJET3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:29:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34130 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhJET3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:29:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Iuftu010252;
        Tue, 5 Oct 2021 19:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IKPdqbi7QShOVo8FrRIoiMBsCZtwHdkRhfdOyHXIIng=;
 b=nnW5Rh9gl+WgiSoHTQhspc0z3ja04BRDwpaaJcCADk7w1FDDlOn6HOIFV/tqzomF6KQt
 zweHv5apFhB1VQP3fhHm0TJziCPZK2I2l/VSoQFZ+k8CLsUbpnNjLCk0U4x8i2oBs4z1
 pFvBWFSfXyeVI+EWM5l8+9DeGDIKUDC2SI5401EsF8iKhQJotyu59I7Mh8biv3hOPLvw
 Hx/ZipZjtGHmxgP6/zOfsMuF9EbGLhqsF2hHQhuh3RireH1ee0rBiitwkOS7F7yZ3EO3
 aMpkEq/CJkZunc04LmShNG7Jqtoa+3jJ3DV0tFOy/v6kvJAzMZyWRmN13bTK1aYMNqy2 gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3uq2qc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 19:27:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195JFwNN068472;
        Tue, 5 Oct 2021 19:27:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3bev7trad0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 19:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ8jG08xnDw0T6vcHk4QiJwZ0g77Ie3TLKOxRDRu8FHUiljiRv6Qs5f2UmQwmIZiqFftIfGwsWUFtWl2rXTU/fzhkp2Q2ywgy6M6CjI4fZ9zmnQn6FJApBW4YTNN6dnN0bKIH2MvXXekGQQvcdQ7cIdJvYfyVycyE38/Fljx1Y1+nlxWZYw9seJyWahAN0n4gKulrGLWO201Ml8EvyJ0HELy8ac/p8sY0LcylwcbdKyex3ot2E7MDdxuWHVFxe8lEJAo5W4o4g5LVfwaQ1a6HLHKVi9+Ldy4HQlFKtfIBattGeF+kUILr+3BU5MeauBYxgAJkCLREcTbff8fhhp7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKPdqbi7QShOVo8FrRIoiMBsCZtwHdkRhfdOyHXIIng=;
 b=ci1RZBZBAuJwx/3hBVZSa6r+OemfHlcrAE3jOsLFEj/KNIF2c+ZgKfORga/5j17kGZe38bwCOEIxBkO6PAbVfiuj/JlA04CCW5VIdowF8n6lt/nR6BiBqNkXpQEWsAuiQGYMg0+/7GxXGvpjFdugrZLEKJpmtzpQBLlzqY7aGZN2X3XvYV9pWxxk753Hbae36Pjq+/PjN1H4dj7xNXlhQy0qch0WLci6miXY6uZtpuM8qKCI5c6f1g+X9TVbRgU9Pl8PPR5gPpHru/4Q8QsS3nipQhRHuyGjMQIzebgMkU5203/uq4OJUFN2h/iJ19PMF65uipr9duRrPqXbxO/LUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKPdqbi7QShOVo8FrRIoiMBsCZtwHdkRhfdOyHXIIng=;
 b=lPGB66qSctB/tBSLA+PHuymbkUldI+P1pQj3sLutx+f/rCDiW8ffBEur6iUxnhhF1Ar2NLIsqOzoqC9WSnTP1b22e/h3O2Z0JSlmQX9GqolQ7ktxTG2W+6jfcDdG8VuBYXVQcF4jje91PufIm/N8rWAPkp/casHz+Dl2GAtTR8o=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 19:27:05 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 19:27:04 +0000
Subject: Re: [PATCH v2 2/9] x86/xen: simplify xen_oldmem_pfn_is_ram()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211005121430.30136-1-david@redhat.com>
 <20211005121430.30136-3-david@redhat.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <ded331ac-f967-fdd3-e2e6-b79c37ebaa1f@oracle.com>
Date:   Tue, 5 Oct 2021 15:26:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211005121430.30136-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.102.28] (160.34.88.28) by BYAPR06CA0003.namprd06.prod.outlook.com (2603:10b6:a03:d4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Tue, 5 Oct 2021 19:27:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f2840af-997b-492b-af50-08d988361d1b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4144:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4144EDA7472423EA2F39CEB68AAF9@MN2PR10MB4144.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnKNNK+/YutrBMdl4lSOB3m8kcqWHbVZrKIHpeFjCP2YFgxI8LlE3oe7f/cLHhx10c4a5fnNbRVBZ0SLRDWn3sl2t/Exqwns/aOQ8SUL2/5eba7orPyy66Ye/I9iIm19UjGBLn9xGrLdYYyRFiAo0O+XDjTv0CAmvlmIvVLivV/34tA5BVR0TBKw7jw6vYEhtabfNIQSjAboZIWwzg0B85KaRerLmrpQxzJ6Ve/MGvc401eJrYDPWrjxijs2aaVLuYT9t71sr/wTvZaMGn6Fx8bVx2QrOpUtrG4IlgQvzAE4b5V07bbhbpolcg4JDLrQ3BboTvxeCZsi5vtuy5xCn9zJVebYiRsu26cCPMP/dk+ra0PXzpN7eyAWDRVnSi+fKT/rqMLpBCcwTM089nupfA20ayzHBND2nKN6lpnrlHz1iRFm2yyMjcsDyKBEB5yJRHLdvViVxk5wbML6ZhHUa3IRMs5jqaq6SjLciwZfq76bUsd/R/QnrWPf+QhsMkRlPyqTaa8z8pTn9iDgmVVjvgE00ir7/VtwQ+UAZot1Y0OjCtkBBB88cNZsQ71N56FsYsorm29lZfgfdKnDjMF/WhqJOWKOPD1fmHZ1HVkY2C6CwyysEkLW00XXKd2rSEcr2EocMszd3EgoVXOeQSVIcYvt7J3dn4/WQefrfuSy+TbWglwOjlQmk1h1ubz3ZkXNWd/sCaBvVS5M9O+ktm2O8CbAKwGh1I7pJSt5UwPcSOQaVkHvzjX8FDpUHQROs+nl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(2906002)(8676002)(6666004)(54906003)(4326008)(6486002)(86362001)(26005)(956004)(36756003)(31686004)(2616005)(16576012)(8936002)(7416002)(66946007)(31696002)(66556008)(44832011)(38100700002)(5660300002)(316002)(508600001)(558084003)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Z4eW1ybzh0RGkydDBadGxSbU1mNlJmb25TNEorS1VtZGNBMmpxZVhxMVJu?=
 =?utf-8?B?Tjc1Z3dzc0wzR0dFTGRsZndqMk1vTVJvVjBQek9vRkNSVDZ1b3hFNkhwWUpO?=
 =?utf-8?B?QWFtdmNXOVAyL1pFWi9zdFp5NnQ1UzA0YnZDQ1p0ZVNucXMvVVlmSGVLKzBG?=
 =?utf-8?B?eExRMGxDT0dwY3l6a0NNY2lIWDNETkFSN1lHR0x2YUxvLzdnb1FXNVQycStP?=
 =?utf-8?B?bE5yc3JjSjVkSVVESGVpMFJDcUdLWG1UU2ZRTHMvMGFLTHA4NEVrekhMK2ZW?=
 =?utf-8?B?T29yTlNTM0ZnanF3YXk0aERCR1NKdi9EcGQzeEY4NFQ2QytVZFdieW5XNGZt?=
 =?utf-8?B?Zk9mWnVTTzRYNnU0U3lnM1JsQ0NZRHJmVjBlNDFmVmROS3lueFFraTZWNGlu?=
 =?utf-8?B?akJ6cVg5OFVvcVI2QlhBV2UzUW5GbkFlSGpQdzdpSGJjK2V6elFGVkw5Qisx?=
 =?utf-8?B?RDVmTHVVQ1dYK01hWEU3MUxQdFlyNituRUJ5KzErQTl4c3p6NWxaNUtIaDdD?=
 =?utf-8?B?WVZCT29qSzQzMHBrN2Z2eitwOHp3c0ZsdnQvdDhYVmU5WjhpdWE4SGIvSDN1?=
 =?utf-8?B?UllEc2VyTi91aGJUNlF0dlJEeHBRK05jNkNhd0wrdkpSQ0VqdGd1bTluLzhE?=
 =?utf-8?B?eUh6OGtLQk5vYXAydThPRFFWT3dIUXVwNzR5amNKdkNrOTZUaHhsZXJDMEtq?=
 =?utf-8?B?OVU0b3J2RGdmUkhhYUhMMTlWL0hSQ1liZU1YSkJmdVJnVmlodzFQTmJkSTJw?=
 =?utf-8?B?OUE1QkpwTjRlVWIzUlpuNVFzeGtPUUFBeElwQThZcDhmbjRtY1pWMk9VZE41?=
 =?utf-8?B?aW9HOURmQXNVajA5N3l3QTVuYUZNUlYyNU5Zc3g5L3hSRDd1eFlIZFlXeGor?=
 =?utf-8?B?YmVzSk56K3JkZEJ3L3o4dkp3SGV5dC9MWlN1Vm1hYzlXbWtmdWphbWM1M2x4?=
 =?utf-8?B?MlUycG1EUkZKdFFEclZaaDR0TGNRV24wd0FJSWZHWnBJTnpmL24rMHdOR1gw?=
 =?utf-8?B?STYxK3ZTd0g5V2JzU0lUcy9OQXVXOGpqcmpETkx3REtZWFpicm9CRE95cjR4?=
 =?utf-8?B?cE52V084M2dwVi9zUXltS25iQVpaeEVOQUN3Y3dDRWdRTGhGNGRyU1piZmt4?=
 =?utf-8?B?QVg3SmhNMk5nU0xPYVA1Z1JoNFJTS0dKNGtidXB4a0c2UEQxVmZ5VlpGSkJL?=
 =?utf-8?B?UmdJVUQxbE9HMWZlV2VheTJIdEZUdndwMHZ6dWZkYXdlYjFTM2NQNDlVSStw?=
 =?utf-8?B?Zjg0amJ6ZmZEYkYxdnhYdEN1YzE1Sk9WN1NpeXhRSUhkRUJQdVZOSlZjRnNX?=
 =?utf-8?B?UUMzWGxVYmpheW0zWHlUU3gwaHplcmpnaGhxZVhzWTNpWmZDaDBTOHdsN3NM?=
 =?utf-8?B?bTZCUlpqK1JoSldjcDVuRmJZaWJSSjlWTUZCTXZYMXc3c2NubGZnMldnYWtD?=
 =?utf-8?B?YmZjSUNUQmhSVzB4QWcwbXhwK0hpaTk3bUhNWFBkZ0pLRlhaN3FKMDZTaWdi?=
 =?utf-8?B?cGN1WlNNNkxiaElJV2pXdnM1V2hxSEpjQ3JUbVNnUjl6dTEzdFovSDZ3Z2xi?=
 =?utf-8?B?cTBTWUNDcnh0YzB3UkUwdDZoRzExWmdjMUxFNEw0RzhyQVc2VEpKUnhSLzB6?=
 =?utf-8?B?c1VYd01paEdWdW1GdUF1WFFLcVplWklUY3duMk9RQUdWRlRRSGhvR2dmWnRv?=
 =?utf-8?B?TWY3ZjhvdFZOSXhuN21yekFlNUtmbmFEb3NMYlVkelBjcHY0UFMySjluTVFj?=
 =?utf-8?Q?A6lzTU5DpebtI/ZnIv6oELrsyx845vXqcpLH/xJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2840af-997b-492b-af50-08d988361d1b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 19:27:04.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSiGDlu2cAAB5uQNKFE1ffMtuw3gBbFX+95KUzR2+UcX+1n/R7oW6VDhQuKoGAXtGriwJvR3GTCbHwNreNZaaZU4iF9awHcw8Gwf+Jh2TuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050113
X-Proofpoint-ORIG-GUID: 57psMXq2VE5oveGmVVOu08OwAKJQUrof
X-Proofpoint-GUID: 57psMXq2VE5oveGmVVOu08OwAKJQUrof
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/5/21 8:14 AM, David Hildenbrand wrote:
> Let's simplify return handling.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

