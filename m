Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C033248CB63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbiALS44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 13:56:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46082 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344217AbiALS4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:56:39 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CGxKK5031725;
        Wed, 12 Jan 2022 18:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jXuBm4G45jQwNyIOerAFdVjBgB4bUhdG9pEm/Sr8MDs=;
 b=fLh0D7IxTwX1aXzedUrqcWhauZYNhBJZ1ig0rkxa45JpEOm/GTX66HiNp9Qtt09ONzs4
 dMc0jHr9tOnDF5pE3CN+Pr9FmMJjcURPkDvplKa0a0A+eLZlgUvnDZjUL89z7K3/YrK3
 KN3C5NaXGLsnljWg/jWSGrxs4sDAYyHO8RQRo13b+AyEI87fwdZ18x1H2pOzPTMJ2qzZ
 9NZ2IvPfwOp7WLVwPpXSFrbp2wu9U222CxgYtmx1cftN0WPurB1QaaT9AWeRE7MC7uxe
 t9Axmum04WUlDTzAEET1nPLuVlBsxpspudQtHIf9v7uiGPuJC3Ju2Nje/EWCT2DSip2/ wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9f7dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 18:56:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20CIeFTS104504;
        Wed, 12 Jan 2022 18:56:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3deyr0bnyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 18:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6HOj0KLVboFtJUZku49Hpjc2/QKAz9H9ECmaKydwH6XvS1CUgw2qrW+rWY8jsmNIdnSd6TO2prKBT8z9HU9y1bWF08slaa+ySYvgDPG0CKvz2TPa9UYU6myawKIOFT0/H8akF8Mx/1s8ZI3n4I617qsrrUu2oun9d6M8Q+aSexMcSoLIou9tZrpn6maJeJMh/5Re9WeBkWkd6SmRUo4OqjYpxwQ4g2/G291RmeewGy//9IQ1Yf2QPwNwa4gAKFGYgcb55s3BD81BTa+X9NoI8eSGw9L1w4hQ7nW0Z9CEqA9Vu9jzx+c7hGbV05PogrmX9hfrvb8Yqz2Oxwke/mkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXuBm4G45jQwNyIOerAFdVjBgB4bUhdG9pEm/Sr8MDs=;
 b=BwxH6FU5g37vs7neRpwxjF0/sjfCsFluT/e5faCjYQ39iQuljbBq42pLxZaCTp9E0AIkZ1JS0GL3EhJsVOacOu654S8bI3yP/2iQDEFG6dKfMLqOu2JrQ+WlXS31AbFySw4b5z1DBUNX9KLrKqLUVucTdJuTrbCg0hsBmiqeHzAWoO4f2zui0k1+vXXBfdHYl9KLhaZ+46xIRQ9HyYI9GFQAbCFqyLUyHhD5qMUExzJy2T1XdTBDGOKIrjf4tCPju4mvgdXYBWQADR/1B3wRN3PY5YyhhjL8EXaChHK3zFHQHWZZtc3UR27hwzNNjAflTyXcrdwg2drB/IokNnqvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXuBm4G45jQwNyIOerAFdVjBgB4bUhdG9pEm/Sr8MDs=;
 b=Z2TWmZCeGPbEYEb4QJN02y0xbliCRtJB0E/iu0GBpWA7xdjaS2tpa0AURlH+NrXmclafmDVOl7V5fn7RGPP7J6GfuheJ1vYgz85zUq9gQ2eW8lnEwq6zoRZmN9aYL7khyCoiKLqSHj3kquio0Z89somvde+e8WxvohkXXymj7R0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MWHPR10MB1726.namprd10.prod.outlook.com (2603:10b6:301:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 18:56:31 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29%7]) with mapi id 15.20.4888.009; Wed, 12 Jan 2022
 18:56:31 +0000
Message-ID: <a4b46792-49f0-b2eb-77f9-547b96e61224@oracle.com>
Date:   Wed, 12 Jan 2022 10:56:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
 <E70D7FE7-59BA-4200-BF31-B346956C9880@oracle.com>
 <f5ba01ea-33e8-03e9-2cee-8ff7814abceb@oracle.com>
 <D2CF771C-FF71-4356-8567-33427EAC0DA9@oracle.com>
 <20220112185327.GA10518@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220112185327.GA10518@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0194.namprd05.prod.outlook.com
 (2603:10b6:a03:330::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 298c6df5-faad-42eb-5407-08d9d5fd3f61
X-MS-TrafficTypeDiagnostic: MWHPR10MB1726:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB17260B268C1FFD4417C5D88587529@MWHPR10MB1726.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UofnoJiC8gwt2vpmhnv5SFdUAdS1eOkzNlrt/WoE59Yo6kNA4eGKLw/cUZV4GiEQRPyLbmcrr59GpHJCuL6u+yWHtA1hup/ebjNJLqH25AOYKG2QH+H7awQIAS7m9Qdp7TDzzlFa7JGQeeiPMVvTj5YLb32+IqILFQrjXnwaUKtADbfhsAwjs3o516seR+HeLPrMG98L0p0DaTEzdwQoTtaGlU6znJ02DUiF3+Gn+8NIVSTSTWCSldnrSoqSwTl8lYXKosyDvipi7nzEiS/XfYAQh/oxxmq7BLC5cvLwI4RVXt8yjL/Yv61keuVoDccNZbKZ1aty4AhJUxWh+xa2xgUEcEsBkdXivFebi/MRtNNHHokEz/tbGlIfd06aLkNSs93vsr/CBhgtIDFbFItE6HvoIpFgFP7tkyqyG19UGL3vC4hrteRwPtJBfPCOjjXmM46gdoaC5bpbknKHowwxScIlzEuzZZ2bh/vh3t+f1agHkUq1sdarGThrq0SuRyZLtRadpOjea1s+qcxfvZB8HrbMxXsd/LKhWBd9cZtxASXINzH9Eo/YeIArnKTtMWX+7kHp1I5UE0vweNfx+ID667q778BmpdDGmrldCDLU9skw0rRvtf/DhYoC2bO05bO4ZSKHNl/stTbtMF1bLf9CyWzV5BLQqiAYRlZ2cZEF0pIWLA/IwEmwhLDe9F+uLEl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(2616005)(110136005)(2906002)(83380400001)(6486002)(8676002)(66556008)(4326008)(31696002)(66476007)(38100700002)(5660300002)(316002)(9686003)(31686004)(54906003)(6512007)(26005)(36756003)(6506007)(186003)(508600001)(8936002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEI2WUpqdjJBMXp3WWZyU3dJQnF0V3h2QTVGT2NGbUV4elZYTXhXL0RLMHpS?=
 =?utf-8?B?eGhWYVNXUlpad2JIUWx4cFEySHFxWGVLRUtFV0ViZXA3VjNWZk5hcUlHTTg1?=
 =?utf-8?B?MVJhS0h2R2ROZVJzQjdlRXV5UWxDN3drQmRFV3dBN1hwMERqUnBzcXB0dVh4?=
 =?utf-8?B?a2hqNzNSYUgyQmdqNEp6dkhVa0dSOG42MStHanJONEVuYWJkbUtYR0phSXRZ?=
 =?utf-8?B?cXdxQ3M3Z0dwcnAwd0h2NC9uanlJVzRTOEM5b2VacWZlUlFoYUVndUtYOU5H?=
 =?utf-8?B?OC9PMHAzYXVwOVRLUXNQVHQ0WjZMTUtjN3RqbUVHZkFxVG9jaVZHemRxRExj?=
 =?utf-8?B?NzQ1YXZqc2xpS0VSR2NCNDRDOHIwNEVPSEdNMUt0bTd4Rjl4bHg2YlYrdm9y?=
 =?utf-8?B?Y0ZydGxZS3lEMENuYUpKWE1VVDdReDB3Tlo1cjh3V050K3BFYkxMYlU0Zk1D?=
 =?utf-8?B?UVVnNEN1ZTFla1g1L2NMTWJlNWlJbkR6M2pQVzdqUGJSODJTamg3Mk5BWmNT?=
 =?utf-8?B?RTRBZXplUjFMU3M3QTV2M0ZLS01iV09ZcTNSR0pMTnFOaWpQUUlXSElwbTNH?=
 =?utf-8?B?UUFIclRSamhlOE52c3lFT0hIUWQ1VU1adDg5NnUxZ295V2k2VWU5eHVhaG1y?=
 =?utf-8?B?MW5iUkZvbUVkMHphSmhzSnlhSUh2Y3hycXBvNWNzbmRIVk0xZVRxVk1ZUmVq?=
 =?utf-8?B?by83WXR0RTRrWVZHQ2JscWZ0KzJxb3Jid2pEZXoxYmFrV05wcTdSTnlwUHlR?=
 =?utf-8?B?dklnSWtkbXIza2RGL3ZFTGZNQXZZb25tM1FXUVM1OWRRUW93MEJjU0FPSlRy?=
 =?utf-8?B?eVNsdVJvQjcyTmlpYmdyRklkTjNYZnQyNFRNVno5Q3FrdjRtWWNJUXFJUUgv?=
 =?utf-8?B?ZUVEamtNTzRTWmI4L1d0VWNuWVhLMVBrYkU4dTRzV1NvN2dyLzVLb0RENFZ5?=
 =?utf-8?B?cGtHdnhEL243azE3VHpHeWJvdVg3aFl2RUlzNUl3Q1hGcW8xY1VuaTNBQ1JJ?=
 =?utf-8?B?L3lGb2s3YVA1aGdoWW0vamd6cnMrT1dKb2JCQnZoRml2TS9heHdMZmV1OFhW?=
 =?utf-8?B?bm1KZW1vZHZFNDFtQUUvak8rcEIza2cvYWZybHBwS1JIS3FscVh0NGNQUXk2?=
 =?utf-8?B?cmRsN0psc25OY0Rna3JQQlkvaVUxRkFHOHI4c3ZOUXNobm92Zy8xL0RINTU2?=
 =?utf-8?B?OVJNSzNwSnYxQThBRnd3R3pkeHROcDRScmFYTThXRzEyZXUxSTRTZWlPc1hZ?=
 =?utf-8?B?Z2QxbHJEUHN0SEl6dkpZWkhGOGJMRnZSL1E4VFlSZVpBTC9JQjVSZnFaVVM3?=
 =?utf-8?B?SXpxTFhwUUdiQ0tJaVV4VkNMZ3U4MFkvcVhZZzB0ZmFxOHlZQ2V0WlAwR09W?=
 =?utf-8?B?bzBQK1pJbzB5QlYxMjhtNWdBZXY0ZnhGZmk1cmVwZGNIR2dIUjl3WllvbEhX?=
 =?utf-8?B?b1M2N2R2ZjZ3Q0hwR3hBc1AyanNJaEhDeVQyb0NSVWpkaVlQczI0ZkQ3bjdF?=
 =?utf-8?B?NDU5eHZXVVRVT2tRZ3Fkd0JBMmdyRTY3Wnl1bmJJRk1rWGRqSlRQcHBxZ1Vj?=
 =?utf-8?B?QjZheGs4ZDFHUnhpeHRqTzVGZ21CcFcxWWFuTHVRenUzcUp1OTRjSHBUNmlN?=
 =?utf-8?B?ZUFTbTN4Z3FyTzBsS3hjUU9DcTRlV1o3U201QTBZRHBNUzhMRmIwRjBsK25U?=
 =?utf-8?B?cDMzVDYvVHdhRkRzVDdZQ0NuMjhRbHRiYUZaeGpaeUtoZ2s0bU1EMythTXlB?=
 =?utf-8?B?NklJSlQxSVR4YWJzWHBvZVQxWkprYXQrWHlyM0lUYjBZVzdaVkdzeUpQUGx0?=
 =?utf-8?B?clJqdlFHQTVEMERwek9YSHJCLzBVOWVya0ZwdVA0OVpMN29RUXJ3aVFxSkRr?=
 =?utf-8?B?QWRZc1FWOExnbDZHSWVOcnRCM29iNmg5a3VMSE5abVBhQ3BDYXlFZHJDN2Jx?=
 =?utf-8?B?cGg5djFoYkI1dU9wem9yMEE3OGlCVUNESzRzaitGVVlCSWZzZWhQQ0ZleU1P?=
 =?utf-8?B?THoxc2RPMTcxZkF5OHBadkd2dTdYV3VGeTlKaW82Mk5wMy9ud1BEZW9NUnZk?=
 =?utf-8?B?MHFtWjlBYzVmYnJmK2dFdy82d3BBVTB2SjdWeDNTT0J3c2lieUk0RVpRaWk3?=
 =?utf-8?B?Ni85c3JTY0dsZjErUUduZ1lqK3hobW5iOUZzdU5kZGs1TkFMN292NW5ETnps?=
 =?utf-8?Q?EoybMC+ELil3a6kFNC5+KTM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298c6df5-faad-42eb-5407-08d9d5fd3f61
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 18:56:31.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o16uYXrAV/35QB3gjH/WYRS8Te0WfzyCCWb0Zvln4mBwZ9xbpTPCNnDfropxaxzhTgkT27PpBJo5Y4jqGrnkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1726
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120112
X-Proofpoint-GUID: CudW8VPXThiaLSg0LsSTweGj6bnzUIr5
X-Proofpoint-ORIG-GUID: CudW8VPXThiaLSg0LsSTweGj6bnzUIr5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/12/22 10:53 AM, Bruce Fields wrote:
> On Tue, Jan 11, 2022 at 03:49:19PM +0000, Chuck Lever III wrote:
>>> On Jan 10, 2022, at 8:03 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>> I think this is something you and Bruce have been discussing
>>> on whether when we should remove and add the client record from
>>> the database when the client transits from active to COURTESY
>>> and vice versa. With this patch we now expire the courtesy clients
>>> asynchronously in the background so the overhead/delay from
>>> removing the record from the database does not have any impact
>>> on resolving conflicts.
>> As I recall, our idea was to record the client as expired when
>> it transitions from active to COURTEOUS so that if the server
>> happens to reboot, it doesn't allow a courteous client to
>> reclaim locks the server may have already given to another
>> active client.
>>
>> So I think the server needs to do an nfsdtrack upcall when
>> transitioning from active -> COURTEOUS to prevent that edge
>> case. That would happen only in the laundromat, right?
>>
>> So when a COURTEOUS client comes back to the server, the server
>> will need to persistently record the transition from COURTEOUS
>> to active.
> Yep.  The bad case would be:
>
> 	- client A is marked DESTROY_COURTESY, client B is given A's
> 	  lock.
> 	- server goes down before laundromat thread removes the
> 	  DESTROY_COURTESY client.
> 	- client A's network comes back up.
> 	- server comes back up and starts grace period.
>
> At this point, both A and B believe they have the lock.  Also both still
> have nfsdcltrack records, so the server can't tell which is in the
> right.
>
> We can't start granting A's locks to B until we've recorded in stable
> storage that A has expired.
>
> What we'd like to do:
>
> 	- When a client transitions from active to courteous, it needs
> 	  to do nfsdcltrack upcall to expire it.
> 	- We mark client as COURTESY only after that upcall has
> 	  returned.
> 	- When the client comes back, we do an nfsdcltrack upcall to
> 	  mark it as active again.  We don't remove the COURTESY mark
> 	  until that's returned.

Got it Bruce and Chuck, I will add this in v10.

Thanks,
-Dai

