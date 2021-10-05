Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FDE4230CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhJETc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:32:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8746 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231343AbhJETcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:32:55 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195IlY6R029400;
        Tue, 5 Oct 2021 19:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hagq3upWVQMX0uoE2qylRWfS6OLtiOzrGNSqBcp1/dM=;
 b=ZvTdKpCCNg1zH0jX5r5B14HnxSm/EIgN0GwaSLpVWZSzeEB+VCVihtWCxg7mmD8NsCFZ
 gtOkwBg5OrSo2KYxSEH+bvaZ37NuxDO113LJeSQVT24uxOsWbbI4vsN+amw34POVsBhm
 XD+u3Ei0zyGHDlwjf+CGfTDmkR/YgoV6MNq8hZhxje+kZhTPA0X8nOnrvFnSI2gSIuFQ
 nFTE9ow8H0WsuOZ/Uv+DKM0GScB/NsmEAOdGtx+p5QSGUsVhVa3FyHwn6Lw+R9MM6fkw
 UzOdh/7K9btZ/QvhQTbzLYhuvkd0SAbOR5uAJA7bD5+0Iwu7xizAtoqdxYUqnd3f35pu LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42ktgy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 19:30:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195JEhGH090684;
        Tue, 5 Oct 2021 19:30:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3020.oracle.com with ESMTP id 3bf16tkrh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 19:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhG+CHmJv+g13mSyIzn+Q/QOfO3dtXQO6YwGC4re9MHNraMS68qvxKK9wNr7mRkjR+ObY+cHxU0L8QeazjVcZ68XKYrzxkGyFU+/8/WmFDuA/i0C026gpMh3j3kefZY/zTbCwsSTQbTSlkY/10mMqo8UHfHTwcsl3aiCM4sqoEcf1864TlS060yeWs91LJbTlljO3NjJn76AIWl2td7fjOySkVkMuWsfs3Dj5fk8UM/qwGVZmEJ8RizLgqUd3jFwqe4DG3nqtdjwsglnoW9M6ltJuokBRi7LEa3OVkfpLlMgi8dzROX+FZK2U0/cuR7JniEetBH/cC/fJLaDVs4JrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hagq3upWVQMX0uoE2qylRWfS6OLtiOzrGNSqBcp1/dM=;
 b=ZwP2jGr4NSEyEL6oMUcxm9QrVokbwf6aD9Kp+jK+X5Vi17PaCnGuo0UHF8m8yGbsS3DPdH54GWvI8yIFXknL/1yw0YrQnea0q1hnJlqJ3WCA3D3OEpNnhev/WatLpmStAaifoUp7ntvceV2j+aEJFy5hNq+WtwgX0LwqwgotxQnf9gW+PpSJcGoFrC1KFUdCOy9o4xkZmIO9TjIRYMt7FXnSqjWp9gDE8kRf3KHLgasG4koQPLAjjE1epz4u1ebHZ8qQFKx9iaO4vT7dgYEORMYrWDWV80OvJFEFP2Af0aC5M5FvtDfBLrsl8r0Qr+ebPrcDIqy+2gfbY7wNNqBpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hagq3upWVQMX0uoE2qylRWfS6OLtiOzrGNSqBcp1/dM=;
 b=qPylVRxOIlxXKgnIG2P85vz2WJt3m5TZYJT5cb9MBflJ0HUEb4SVajybyGXn4SEFKC5PUa6ciiaYjYnPKRStmBHxoU48B0wtSA5mtnLRwmeWBwCCKMmy8/UCoBPRHq6/ea2Exp5qd5S5ewLhoE8jqIKr6/LjiOdT5mTUVlSSsSU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 19:30:34 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 19:30:34 +0000
Subject: Re: [PATCH v2 3/9] x86/xen: print a warning when HVMOP_get_mem_type
 fails
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
 <20211005121430.30136-4-david@redhat.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <4814ff2e-dc1f-71d5-9082-19f8ede9aeaa@oracle.com>
Date:   Tue, 5 Oct 2021 15:30:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211005121430.30136-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.102.28] (160.34.88.28) by BYAPR08CA0064.namprd08.prod.outlook.com (2603:10b6:a03:117::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend Transport; Tue, 5 Oct 2021 19:30:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 312199c2-60a4-41e4-a46e-08d988369a15
X-MS-TrafficTypeDiagnostic: MN2PR10MB4288:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42885A0738B3963CE55D8BA28AAF9@MN2PR10MB4288.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23Tsd2HQlKw8tGlcFDe8AVzNBsK0PBwnfw8JYR+sbWjt1Bgqkr1A4PUt2bR3a5iZg7C9Wgfi0JmIa2ODkSiYIc8mUNuPn+yBbxFGP7V6whJyUd4a5yIB+Tt2IlJk+mQW3+ncLyBn0FgNgL21rqq0PvknpkevM89CsZeanWJnpmCH/11aUKCPQ16PT2FPBrN1p7ms9wiE34QTg9XXQL/TokW0IB4Sxez/1HknB/r0OgB8aK1SgrPiDV6UEXFBeYn/I3FO5NbUBKY2H495fqSPu9oVeVtQUc+7UGXEfWfGWjASgweQCL1d8yMqvpgyN/wrVZHYsgd+HXit68nDXoIOOHho8hceMXafgoZtrSPls4C0qTD+fPx9p1HvT3v8tskML6nKf9RW/KEx9oLRcG+0y9sGTE2Y481S25ZWDRvP3Q4cilKc5mzu1AqUuoivDvi0oRK25oJKE1CyRMgMwr9ikamnhQYfGfVBkI8zl8k19BVyXmT9zdgwcYZq/c50VZy0UaYgDeu0+CvlKXrTE2cCFOVUBF0ANw10FB9AeXFzEFNLpYbi+VXNzneHHlqb5y6q3R8LelokQU3xf6Z8HplxmZ5gieY5Mi1HYDwZxNeDofl87U7z/bFHFCg6/NBJpldiOTZCo3VUdSn0OiDDC/YMDd1+81a2CMMdjDRaxKg+cOo0u0J8Z0/AzogS1DY2K1SY5HGguyh+lp5VzZM4ShJQpmuLuxyT5pnHzPkhlXczKcm87VjY9hF+BOjsthNZFfMgBjuzpUmbk9OsWooDJqyV2zdi9jmcU+nRIXUFVjIkxzqWZuveW9g9/CLnCb5c6CPLaUGkKjcegSnd5CC1Be4Oxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(8676002)(8936002)(31686004)(44832011)(31696002)(316002)(2616005)(956004)(6486002)(38100700002)(6666004)(508600001)(16576012)(186003)(7416002)(4744005)(5660300002)(26005)(2906002)(966005)(4326008)(66556008)(66946007)(66476007)(86362001)(36756003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d05rRVlmVmtTakJsQ0g4aUg2RTFJMk9KRi9nTTBWWjVoVDZHeWdtV2RwMEZz?=
 =?utf-8?B?T21ZNk01WS9hMHgrUmlMWnFUV3ZyYTNFZitqTDN3QXpzbGt4aUJqSG1FdlE4?=
 =?utf-8?B?RS9WaGlmWjBpYlNKcDFmVW5xVUhTWjRGZjZ6cEdMVm45Q0dYNDAxSTBMd0Ry?=
 =?utf-8?B?WndrWmJWdGw1SklxWHhiQUhTb3U3V0lNdmRzd2J2aUg2cTdGdGFhMkdleW4r?=
 =?utf-8?B?TnlIbkhDYkFnQkJVK09LRktLQ1dQV2YzTlRFNWhPbDBUblRoamhrWEdUdlYv?=
 =?utf-8?B?MFBEK2JJTk1PcmVjbEtHdTFjTEs4UHVCbjRadVpYdm02Y0FKK3JUcDg0M1Bo?=
 =?utf-8?B?Y0MwYVQ4bVcya3BKWkNodnE5QzRORE9yVnB1VTJ1ME1YQnFyREUyVWo1TC90?=
 =?utf-8?B?ZmhsbUJnSlFmN1VJRmJ6SS9KOEVrWndUVHp2MDdUblZ1b0l0UnYzQXlLMUxl?=
 =?utf-8?B?RkRBbG5Va0I3ZHpzRmZlNjcyZCtiQ1lKK0cwVytrY0dFamo4YWZnVnlrZ2tO?=
 =?utf-8?B?cWZUV0N2aE8wM2ZZZWl3NDM0c3hnb2RmRHAzSjhQSDM4MUNTbkpZbkg3dy93?=
 =?utf-8?B?WVQ5NjZ5Tys0MWEzYTFQK0F2SXNCRmtMc2JVRUlnYmpnTDBEWUg2alg3OEhB?=
 =?utf-8?B?NmhhRTg2YTV3QXJRaDhIblJ4Ni9CZ3VZYmxEVm1LcHB4ME52NUdOeWkwa0pV?=
 =?utf-8?B?RDVkdXZ0SjMzaE1vTEhIUVNVcHZnVWpVejhZbVoralkwbVhNMlpUOUU4TU43?=
 =?utf-8?B?OUhkOWpxVTdGVGNSaHpEME53Y1pjbDRNRGhqS0VydkMwN3hSNWtrNGduUVE0?=
 =?utf-8?B?aXN3L0U0SCtwYWI5eGJ4SURuZ01VOHBSaklib2daN2k3dW5zamtmd0Y2VUM1?=
 =?utf-8?B?UEdnK01ydVdEdDYzQ29sR210WEVnUHFtTFlrQkV6VmZKeW9BS0wvbnZqUDE2?=
 =?utf-8?B?dWl0Q0xQYVFyd3RPNHV2eERwLzJtc1BkU0dYcVpQTFFUMkxjeUlDV3ZjYjNw?=
 =?utf-8?B?MFYzOHJzV0xnTGQxb1JnbGpseFI1MlEvajhaTkxkRStaaUhCTzBTbkFQZjVE?=
 =?utf-8?B?ZjJnSGJpU0xUc1F1akJhWVAwL0lsVEp0SUozc3dONEtSSmtwSHRyN0pSbERi?=
 =?utf-8?B?TG90WmsrQVFhQ0VmNWZnK3ZFbEVXcStUd09UejQxOTlJU1JrcmFGWDdOMndq?=
 =?utf-8?B?RmNnK1MzTTZTd2NxUnUxWVh0WXNlMEppT0JHeG40ZXovbG51Lytsc1VlZlNs?=
 =?utf-8?B?UzYvWmt3cnZiSCtwZXkwSVZqWkhRSzE5Tlp1eXJOWlNsUWpJRDRQTWc4RHlO?=
 =?utf-8?B?UjhLc3d4VGF5Z3ZPRCtVc3I0d2Z3Y0hNQ2IxZ3NCc1lpTGpvS3VZcWx1anNs?=
 =?utf-8?B?bGpwRVpXMnk3Ui9NSDV1NVNGbmJobEtQWWtGWk5sN2tmd0ZQL2toTGQ5dlRI?=
 =?utf-8?B?SHJ2dE5HU2IvUHZrM21mSjB3anN4L2c2WCt2OE5JRVVEcEUveVc0eFR0aUMw?=
 =?utf-8?B?Zy9LVVFkSEQ1R0RieDZOWVRDZVR2QlovZll2TlgzUTREd2VLVlp5MTVITHVC?=
 =?utf-8?B?Nk9vdElWV2dxK3ZIZGdRRFFDL3YwYUxIbHdieU9remJ3cVhBU2lsTDBPQjc0?=
 =?utf-8?B?ZW9jL05HU3htMlRuM2VvTnpXckl3dHRFZVFPanEwUXprQkFaRXRKRm0xR1kr?=
 =?utf-8?B?RElFUC9PMUpFWkQxWUM1TURDcWlrY0I0R3BaVWhPeFJkL3k0bEpLZTNMTWxt?=
 =?utf-8?Q?tKw1pXOhijcX1e8+WQiuS1pBXLiB6c1LQA+P2lz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312199c2-60a4-41e4-a46e-08d988369a15
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 19:30:34.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POou7n8kWBmLvWbSJ2PUsI2Mnu8eSjvULsPjJ2t3gVwTyhXivB3KASVF3npFAUQkDmispqca+JwJQklfVkHN886Vdy805nsmpi0NNXiUacw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050113
X-Proofpoint-GUID: cswN1txcG0lsYY_KX0sYrFnNGrS2DbC2
X-Proofpoint-ORIG-GUID: cswN1txcG0lsYY_KX0sYrFnNGrS2DbC2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/5/21 8:14 AM, David Hildenbrand wrote:
> HVMOP_get_mem_type is not expected to fail, "This call failing is
> indication of something going quite wrong and it would be good to know
> about this." [1]
>
> Let's add a pr_warn_once().
>
> [1] https://lkml.kernel.org/r/3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com
>
> Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

