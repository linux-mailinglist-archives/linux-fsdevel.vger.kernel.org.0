Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD03F1448
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhHSHT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 03:19:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59070 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231951AbhHSHTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:19:25 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J77ltI013756;
        Thu, 19 Aug 2021 07:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XEh7DJy1VXvMqRl/94yECgFokGirVnKj7q0jYow5tls=;
 b=LmP1Hsx/zzTh9xHB0oRIfSzzs+IfJHY2bzSvvb2ws6IXagj6UsXjZOU4/v3on6ldblr3
 FmwLTQieZiAhlHUqvPCdGq7eBWd1S0qEz/foB55Zbf534ERmgji4cF4sZ9L+XnoIkQ6I
 wcjoXJVHg1k1o7kKJS8DoOCk1T552OnMSN7i6SP6LNnPfm+5TyFgEB10j4XbR0VNS7k1
 fJ1okzb3No5kFmH6dohs5T/yGjgdZ3vccXHUFe8m8+MQzGnhmaOSCPDzIDG5HI6q3Ags
 w7dnXHV7IGBVBesvQhaql3xXqPaXCC6JSZiJnsCe9PWmqZ3+hqFwh8nmClC6C8oWZzhU +w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XEh7DJy1VXvMqRl/94yECgFokGirVnKj7q0jYow5tls=;
 b=JOEY0o2Tvav5kT0vbWKRO6hXmQ3TXPjTkuEOuiPZFE+deLsAhbNPEjGX29KSFitjJ7ae
 tHtQmRA7TNnJqV8Kk52RS0V6Z6wLg1794HmG0lheWxsVw2mqjk+oQsVUuYQt0rlej4pJ
 RccFZzNZrsU+B/J4u/blpB58+Z6PPA2dMlIiXOrv0IOAyexDE6/O49juCtpov6cICj13
 1/vN0RdmIucES/QCisPL/mNwotBKtK0FwBbr6AA9idmiwmoj+0ym8G8u9bBp+tiUvSQ1
 DodOc3mYNkJn7O1O34KKwVDLcm4Tv3SUImcmSPzMjtHVAP4Q1YGY9tUl96K1W//DeZtR ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmjfcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 07:18:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J7ArtK068703;
        Thu, 19 Aug 2021 07:18:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 3ae5nayu55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 07:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN/10Q8brhakQECYg7scJ4xFv9JEIhWX1B1wclfOLzLCV6oJzTApeq+qlaA7M/kC7mA2/0NRo08H/UnzcyuZpCS7BT808FhTQCJv4SaJfPB+AW+fV7zZOoEedc+pky4M/yId+oXVLncFkjuas6Jnw7TBRcFr/93OKB21ItckPTFPzZaK0gtD/M3/ve/MH9wfSuT6uuCPSDiRqFQt1rUJwXQRqt2rtHb/C09s9s/xykatHL5ZjJMoMuK9zAWCjs0bBvTNK1CMcYzt0QDl8ZC4YY9XXlBkVDQzUjNPqH/6CruGsgcXt4pcEszQGT1h4rhzA2OQbOAISgKS4/7QEnMlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEh7DJy1VXvMqRl/94yECgFokGirVnKj7q0jYow5tls=;
 b=gg+LpEXWfDg+mNG7k9HIF8pZ5/3x+KpHT0k06USUP4EGcKpg0r+x5EVg+ZD+eOD6oBnAFB+HehX4MbNX/DsEIpt1aHB6G50+eUyVKbl8VVb1rjNxd3/VgLjZJ+WlLyt7HerZI3BbTEMFMCii59rNZlXZcJbPxgxYWpQRKTQdfJWSEWWARWsSYJKlCexnradqRBIFuAjYPIIbkO92eWn1OFAHpJPRSYeM6rUhXzXWTowSr67/7kllUKtXZQcmiw311RIxmYqeveUeijdRpAr+sHgW6AiP4kNEGmxkiiI08xGsJjtgmMKlpwuy5ubTe/pubLMVh8nC5/5mbBurc6BIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEh7DJy1VXvMqRl/94yECgFokGirVnKj7q0jYow5tls=;
 b=rgToWNtbSN7KuT1K+1nrEu9XIa5U1k26BYZOwXC1iX+NYWX2tJGCW3wuJSTMJL4hGK76sWwlNwn0ziaHVnFBNu2fLbn82s+lvzceFzwK7cd4jC+8eGMU6QnxsVJveqviVXyB6sqAMq3DId8+wKSSfxNElsCllsfwTmh6niQtrwk=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3560.namprd10.prod.outlook.com (2603:10b6:a03:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 07:18:25 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 07:18:25 +0000
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
From:   Jane Chu <jane.chu@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com,
        Jane Chu <jane.chu@oracle.com>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
 <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
 <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
Organization: Oracle Corporation
Message-ID: <d908b630-dbaf-fac5-527b-682ced045643@oracle.com>
Date:   Thu, 19 Aug 2021 00:18:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0057.namprd02.prod.outlook.com
 (2603:10b6:803:20::19) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.39.220.244] (138.3.201.52) by SN4PR0201CA0057.namprd02.prod.outlook.com (2603:10b6:803:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Thu, 19 Aug 2021 07:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6db8ae91-ddc0-4850-da77-08d962e188a4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3560F7D1EBD6E7D0931F56CBF3C09@BYAPR10MB3560.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ec91aALRuuWmRQ/i77w39TEcJ3KiB6CPGOVnEzJTWUyuU4B2p1PDUKCl6oYWmfo96tevIBlLddzcUrg9ma6cvGidfTMPGZ5GZdclk8rYphraHG+DYGRS93hoGnVqQDaqqjTZ57tBBS0ahgAC7KqA7kt7aTA/y2fB49YwxwCrrs5THWN90PXPY8Pb21nk6zAjjaJsQPkQHx1E5ac4gJkPskfR27iJzzPcKGIkXkBTxjXWI1pfgdGnA5lRcN7LitNyvEo2frfCNp+Ym8RKddPFBJWHbnR1ts7ScYvtG1WC3N/WUJxUFZ9ozogmH2wjgFrjeGfyLLM2+ZPIOwa7vFEPxABaoCWbFLLvsz47RATETcGEdz/72tHN8rxPx33VvxnfJGP0UCsfK5ieYt410khM6rwW53RKvp+uLd+YHS5W+RQPy8nD4DCUK9ikEV1760NWZA/NeBvaA5mLuedRB5Mu0qwRp4UKIO2fsGpXqJFOpl0mDoPHofG1ffDcZarJnN/PVAOdNlf5yP9kQCUEB0/bUp4jRal3bWiBZbA80VlaDTKI9ep87LYsrc49dBquSaqi+qiCPIHsMLwXpuhkpvUyoB1GSdT06bNKij+6IIIUgOOTkydf12n8uVcVPVtTkMRyD6LPwB1N9RFKLh4dicl6wtZ5RA6Y2Ry122Q1uaSCnqAzKCzYcBLZV77zblqh1qQxYhlHK7RsV1fknX5QvC17qrIdffA0VWILekSP6fFaYRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(478600001)(6486002)(66476007)(66946007)(66556008)(4326008)(5660300002)(36756003)(2906002)(7416002)(26005)(6666004)(83380400001)(956004)(86362001)(186003)(2616005)(38100700002)(44832011)(107886003)(31696002)(316002)(36916002)(16576012)(31686004)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blVndVRZNFF1THFBTUZuV2lJK2JBNE51ZFRiRldFL29pT3doUFFVc2wweEkv?=
 =?utf-8?B?dXAxQlVncXh1dnNscC96cG82WUF2by9OS01sTlpJT3llVy8xVEUwYkNuSDUx?=
 =?utf-8?B?RzByRW8rRnBSQU9HRDl6ci81dU4ydUl3amhwSndxUTk3c2lkVjUycDBOVk5C?=
 =?utf-8?B?ZzgzSW53TEkzK2VKTmg2aVhiaHA0cFVxMitpY3lIQUozL2cweSt5dEE2RFpx?=
 =?utf-8?B?NVdFSlVkNEdPZmxHNE5sQWZpbXhpTEVkdS90clNNL1k1b3FWc3BoU3IrZldk?=
 =?utf-8?B?WHAxamJYVTlCRUNyTWFIekhzS2Z1K1VOOW9TY2tPaitTUUc2Qm1QYVg2SnFv?=
 =?utf-8?B?ZEp6T2grUHRZOXg1YW9IWmFkQzZlN0FlOGVJcDVSVDFNZFo5YVhnN1VCdGFI?=
 =?utf-8?B?OS9wV3AwUWJ0bHQrUmh3cGtoQityQ1NiN3NBekhYazVGVVBnUnR1SUF2V2tV?=
 =?utf-8?B?NDJhMnR2WjkwUkRYTURqMmlzZDVDMHM4aVpaeS93VVU2ZFJTTVA3Wmp4ZVFR?=
 =?utf-8?B?SHJXRC95eUdkY08yZFhRU09GZERIdVU0OEZ2aVlraXBlN2hGQjZrQUxzeTkz?=
 =?utf-8?B?NFlBb3h1RWE5ZGdFaS9oUGVPWkhaREVhKzFhYUtPaGNnUmd6YW5PV2NZY0tV?=
 =?utf-8?B?Qjg5Nk5MZnhHSG5kbFJqalA3Q3plWWNBdm1QY1NTYUNIT2JPMkZQdzBaS3hL?=
 =?utf-8?B?VnJ4b2N1U3crbmpPRjlBTmJKY2YzYk5RMGpCalhOdjUvM1RGb0xQWkY0S3FH?=
 =?utf-8?B?L2xWdUY5YU15OHh6RnhSL3RKbGdLN09lem1XazhkY0J6NTM4cHJ2YjF0MWRl?=
 =?utf-8?B?R0FLa0lRY2Mzdlc3dmJDekw2Q01XS0wxaGlEbS9nT2Q3MXRud0oxTUIrYjE5?=
 =?utf-8?B?VEk2ZWxXaEFqdUtoeTRxZ1RCaUpoZ3FYQ1BkZ0dDYlNaeUo1V1hnZXdKdStM?=
 =?utf-8?B?cXpLL3JBS3N5VWRDUlBMYyt3ZEpYWHpXZ3pIMEZIb25VUXFWeG9UVTI0UE96?=
 =?utf-8?B?QVdQQ1dkMEp1ZkM4eUc1OGhwNm9QTnhxdWdFMHNwOGdzcks3cDZQcFdmUUxL?=
 =?utf-8?B?eldoREQ5KzFyUW05czlLamhYRlpLdFBGeHY4U2VkUEQ2OUJvaFNLOG93Qzdp?=
 =?utf-8?B?bmRINnNiM09MRWEyUGdSK0w5Yms0RXp5WnVwUEx4d1RYeTFpSUIybGE2cisx?=
 =?utf-8?B?K1lvVjgwTEEyTkpheG5wdFdwNDhXWGNMN2RGM2w0SHZKdVRDK0xEVE9pUHUx?=
 =?utf-8?B?eXlKaXl1bVA2azJFbzFWeVQ3eFRtbFNQRHVUekxDa3FVSHNiWFYwM3JzTlFv?=
 =?utf-8?B?TmdiM29wZk1kTzZaU2hBRWxIL2w2dW9hUTlDd0FqN1lKU0c2Y0JWNjlBbXUw?=
 =?utf-8?B?dml3YXJlUUUxRWdoQjVNb0YwWElTbm9LTU1DSUEyQS9HVWN0ZGRWMzRoWFFv?=
 =?utf-8?B?Q3JSdVlHb3pnTTFOb1pDYnREZWs1UE1VQUNHZFRoRDdRYlpQOElrWXhiOHZD?=
 =?utf-8?B?a0wyYllOMFZjSkRaWXBXWG9MZ21qN2dDNW5yem1NYWw1RWhjNWJxbnFtNlhV?=
 =?utf-8?B?NEc3M2VIa000WmdyUk1EeUZXWFZOV3ZnT3o5VzhyT0JoaWxXU21Lc0dtNlhP?=
 =?utf-8?B?bExoNENLTmRYQlZlQVdsYVZBbGdnbjdFZ3Y0Q0ZnejFOMlpEdlBibk5ISUlv?=
 =?utf-8?B?UzduODl2QnViRDJ3ODAzZElpcnZzL2Uyemd2YWMreXdQQ1B1NjlCaDE5Q0tH?=
 =?utf-8?Q?t+z3Dov4eS97g/UqCH3w6QS2u+8PdC4pJtwBbAH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db8ae91-ddc0-4850-da77-08d962e188a4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 07:18:25.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSO8cwG3tEB+R1VJfQ+wKoKpG1zjuIOBCXMezDLOAZGHjTitIu6ehOjRtWkHfwRkpSKCFkCHVNEZEv7/2dSUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3560
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190039
X-Proofpoint-ORIG-GUID: qA_glU1MWM4pwbIxP5JmInYAB6xn-xwi
X-Proofpoint-GUID: qA_glU1MWM4pwbIxP5JmInYAB6xn-xwi
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Shiyang,

 >  > > 1) What does it take and cost to make
 >  > >     xfs_sb_version_hasrmapbt(&mp->m_sb) to return true?
 >
 > Enable rmpabt feature when making xfs filesystem
 >     `mkfs.xfs -m rmapbt=1 /path/to/device`
 > BTW, reflink is enabled by default.

Thanks!  I tried
mkfs.xfs -d agcount=2,extszinherit=512,su=2m,sw=1 -m reflink=0 -m 
rmapbt=1 -f /dev/pmem0

Again, injected a HW poison to the first page in a dax-file, had
the poison consumed and received a SIGBUS. The result is better -

** SIGBUS(7): canjmp=1, whichstep=0, **
** si_addr(0x0x7ff2d8800000), si_lsb(0x15), si_code(0x4, BUS_MCEERR_AR) **

The SIGBUS payload looks correct.

However, "dmesg" has 2048 lines on sending SIGBUS, one per 512bytes -

[ 7003.482326] Memory failure: 0x1850600: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7003.507956] Memory failure: 0x1850800: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7003.531681] Memory failure: 0x1850a00: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7003.554190] Memory failure: 0x1850c00: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7003.575831] Memory failure: 0x1850e00: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7003.596796] Memory failure: 0x1851000: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
....
[ 7045.738270] Memory failure: 0x194fe00: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7045.758885] Memory failure: 0x1950000: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7045.779495] Memory failure: 0x1950200: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption
[ 7045.800106] Memory failure: 0x1950400: Sending SIGBUS to 
fsdax_poison_v1:4109 due to hardware memory corruption

That's too much for a single process dealing with a single
poison in a PMD page. If nothing else, given an .si_addr_lsb being 0x15,
it doesn't make sense to send a SIGBUS per 512B block.

Could you determine the user process' mapping size from the filesystem,
and take that as a hint to determine how many iterations to call
mf_dax_kill_procs() ?

thanks!
-jane



