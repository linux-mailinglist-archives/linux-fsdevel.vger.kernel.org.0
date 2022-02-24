Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713294C31C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 17:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiBXQqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 11:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBXQql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:46:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA21637E1;
        Thu, 24 Feb 2022 08:46:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFX0Gd000642;
        Thu, 24 Feb 2022 16:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y2xHOSctmZmK/oYfkFba1YuHc2NeG4bieaKISfqFt7M=;
 b=pniz/At5IM2HrN8OHB4gkZ1qJiK4CJ2mKCTSOnRdGySnfHuOg7tbMsCpo7dHGm4fX+00
 h4aRXa5wFnQb5JS2SyRFcmvLtbQcb8saluUFfgvZE2NYS8RtZoqR+cQLX0yrCwJ9jpsU
 BqorxTZmqUi3Ze8Tb/rXwd1aQwZ/L87MReszJHBmbgc+v/Uxg1tO1+4xeu0LgTKkpxOD
 utLy2VwKqBkzjNRwuEvu62QCn9yR4WNp1O8LoE6mRr3qlAai6g4IbtRCceLMraSyZ0ab
 SrrBIwGWMeczXZcqjBWzhpn2TJ41a7Eb8nwGx+c9o9Ax4dloEFHTY6JjL+a/QFZW0YpS oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6eyte0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:45:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OGUv39009718;
        Thu, 24 Feb 2022 16:45:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 3eat0r1am5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEaUxb0H+iAFYjrNajSmYNPCEKtdJku6bUs40eyhtO540ECQAyQKIycg/9Kq2yOqdpeAxHjbJvo7tf7in8bvCtFCbd5J0lyoS8kWjWUHh2EE2kaz0s/ShLST4837GgW6DCNc77BoH9z+GowA16z1Zwr+90Y9bKwOGnFet4blL3NMj6SWMVCKJLYUYJnT7aW7Q159jidYX7GpxpSedr65P7ByH6IsXzNw9F2B6ToG7y2G8AzxYtOF6kbUdQeyAxytIZSFYSblLP7kITuFqWNNuNgQWwvmbV6iw3t++q65ea0HavR4RgxFqgXDtUcMzR0TEMcHMIu4/7DaRweM+MmUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2xHOSctmZmK/oYfkFba1YuHc2NeG4bieaKISfqFt7M=;
 b=GGTxheviGM7tRco1cX0Pkvjbif71dUVKYuwATCsNRX7fyh4QNLGvo/n+jy4JSN6U/FbdX449sQhY3Jb4EFk1+4upT3CgjEbyTzMcAChcAQH1E+ZWVe3bYMHyhja8mbBtqJyOfBxImSPFGxJHg1MjdBKVoqDXF+mZFahh2umf80EfbGvriyfBx1lJEMcDb5s8NLBQmoTmQCQSSbhm2mlSQSuAsE2QoOJno7SI3TzNsGK2W4hznlQNx6AnGhCJXMvWtloiaBwniehKR1ByArmNrCL8kvGjce4LJ+1tU14GB7BLtdYPXA1fWIhCQgaWKegAl9dl1uiVEZhsU50ilDr84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2xHOSctmZmK/oYfkFba1YuHc2NeG4bieaKISfqFt7M=;
 b=bxWnHSKBiog9oT4L085Aq6U64C0A8oYMi9ldC62iZL3DmkR0kSWxpRJtG95ePgJJZHXRMzZszcQ6lk/B9jFGsxOTAQYpsQoIIZVJhKDlDBSxCA/Si/IibRky4n7Q/l9OIvqw/VCeYhEDtLLOa9YqvvNetoYQRZ25oTTsrZStN2s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4110.namprd10.prod.outlook.com (2603:10b6:208:115::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:45:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 16:45:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 22 (NFSD_V2_ACL)
Thread-Topic: linux-next: Tree for Feb 22 (NFSD_V2_ACL)
Thread-Index: AQHYKHvjd7nIQ/9dd0WHn6e/zlcx+qyhS2SAgAD35ICAAIyUAIAAGOcAgAACPQA=
Date:   Thu, 24 Feb 2022 16:45:52 +0000
Message-ID: <1253C13F-B917-4AEE-A746-4ABB06150ED4@oracle.com>
References: <20220223014135.2764641-1-broonie@kernel.org>
 <5ef34a6f-c8ed-bb32-db24-050398c897a0@infradead.org>
 <EEADAF6A-04D6-42C8-9AAE-7D4EFB2FA507@oracle.com>
 <4820dc3e-6c4d-58f4-701a-784726f6c786@infradead.org>
 <3CFFC488-CC2F-4B2B-9DD3-F939468A85C7@oracle.com>
 <bc529f39-52c7-fd54-b435-d6c62351c526@infradead.org>
In-Reply-To: <bc529f39-52c7-fd54-b435-d6c62351c526@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b919b8db-6eac-4ada-501c-08d9f7b51ee8
x-ms-traffictypediagnostic: MN2PR10MB4110:EE_
x-microsoft-antispam-prvs: <MN2PR10MB4110F056275EECDBD041D021933D9@MN2PR10MB4110.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yN9kjX/tWN/6Pqxd4bq38l9WGKfPP9LJc2HAsmRefmMpqR0ZwM7r+YHmjn8S3cA2qLhDx+l+2yI5nLInABQvoBQPCPEh0paF+TOEWu8bfnS57RzY0oNdvbOCrF33vJ+uR8g89Df8tJ6QxSSiREgmrYO8scxiN1Xwp1nodLczmHQcqPjBYzBbXZDKQx4imJiOgq5SLrASpdNJp+YNNyBDMjYQESBPTJE9e5su4k7DvOqbuQzecNPKmFKCKWNRXhWRalXR3OAhAn6di29M24Rvaxcw+joDBvfx5gxHXS+Iw/H81A/fBlgcZKrb8Jp7xs5PB+CAdCPjWZLKr5noKVOx8SAybiFZHc4fuVEH/ktbCkTeWziXvD7JylWVPUzuffFpnaMZBLJuVTdnfEH+ahsjSnlrGGQmNUKIRkpMrLxcb77H5kn0kF0tc6pL7Ft4+80efyV8aP9qQTJC5a1Ljw77vq0lWhXh32uDiNJsK/tig8RriN5H0jQXHULr6Rtmu4jrpPf2lsxX9rXZeZfChXm1waOCIGNsgumAmr0I359MvHitN8kRi8N+bLFH46MRJEEPozQW/6s0njFkAUlP0cdDfBGJw1ZHWQpy4LQzEewqP5Juml42PgRfQNH26zKfGVWpxIjjhdloUqLv1Sxi0UVRHsh86GGa+7ApFZErde8oYdOeuHQ3+I3Y7775x6GFp9iSGQU4NqZxifNC+VsRBXJOkq8ld2zD5I3NlFbmniuuI+RrupZZnqIvlF59oeOQ4MwG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(33656002)(6486002)(8936002)(6512007)(5660300002)(6506007)(508600001)(86362001)(2906002)(83380400001)(122000001)(71200400001)(26005)(316002)(76116006)(186003)(6916009)(66946007)(38100700002)(64756008)(2616005)(66556008)(66476007)(66446008)(36756003)(8676002)(91956017)(54906003)(38070700005)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sCGeiC1lFKzrrYkKgNcqDcC//FbY/sF3XnSPUJyswVZDSD33VfZa3L/alzal?=
 =?us-ascii?Q?7ehkTux5BVcnHHGDTgoUQo9jTF416P8ieW1HROVQmI8V0GSpqzUnjgkricql?=
 =?us-ascii?Q?R927ZGSaFCoieQx5od0rw6iNO4l8MWnOdNwksKozop7fZ7k57HofaVRvBYt1?=
 =?us-ascii?Q?qLlb7MWQVmRMyHT3WZBnh79rH6qJY1GsljiqzG3rQzX1XIhNjsHgvbhrn+g0?=
 =?us-ascii?Q?3k7cAUNYP0MXNPTLd8skYqHLyYCGxK0dJKmjxC8TfCaQ/V3eFkke23bE89MO?=
 =?us-ascii?Q?iEME74T3yvQn4PnjEkeeBbCnFWQ0GZz+9RETygSmG/TqaLXiKAlhRH/QII27?=
 =?us-ascii?Q?mFZXE6D0uyHWZpdqKEaF+0d+gKFLrP6uMrjETKoMdY7SDDWkl/wXZtoxmas3?=
 =?us-ascii?Q?BdyVjjZp/AI2soINFTIJ9IvZr8oFHoHPWgbIqObsPPaaV65WsvjNgMNMtqS9?=
 =?us-ascii?Q?J5czJlXXsoMOds3fY4tYtPLh0s2/ZZjQKLZ9+Dakn4DKLU3FCrN4b0u/p1GN?=
 =?us-ascii?Q?viG3CN+LA7n+rH7JR3VGZ1lgJ4KUluU6ZUdodWlVeMrNmk+FsBcoQZaAQtkc?=
 =?us-ascii?Q?w41dNNyLbqFdbq55uFiyXRiSeWli30fddmyHC6T4uoP8XKCLXhTeoP1iH870?=
 =?us-ascii?Q?NAvRRhnO2bjqk8UckXRgRPNsNv/FYbvUDA95mf+Oi3SL0rw/ANzvvZFWNzfo?=
 =?us-ascii?Q?VqJ0ab1PsS54sZQ/jHB8YAu1M+fu1GezCX58rTJ0hlbOlF1UGZYKkw4lXXcQ?=
 =?us-ascii?Q?kW9K3/uWMqhWAIx2BamY81pyBSjz6jPSGEFBt69sssMGTGophu+gFe7o3PK1?=
 =?us-ascii?Q?PuF7nqMNnKCTi7ZvuE+oje18cDoJTz3/BoqTDOngDAEiYBA2vEgy2LjL5aLb?=
 =?us-ascii?Q?rRVS6XGTPjqm8Iy0yw6caO8Ai7CgAl6dx37mu30CbWnjSGN7Hb/dXwXuTv+b?=
 =?us-ascii?Q?M76TbtyvAVrQm7YTOYEFANfMS3s/s0F3bqONz4CuVsU2f16YUGlQe1GeSc27?=
 =?us-ascii?Q?usq5kBVa6db/Qc5VqjR8JVlw5O57VXdO/k8kt83BCCfIscMtCqRvzNnE2AQm?=
 =?us-ascii?Q?qWi6E1FISBAq06VIAN2tbQv70D8QRrgsk9wuVGiJzWTHwdKvtAvQkKxeePJ1?=
 =?us-ascii?Q?m3POfuqGYCU10Yq77BcDZGbP5ZWntaPh06fsRncgrG0qBiAAEAHq3bpO57r/?=
 =?us-ascii?Q?7Jd/9CAOm3IzZm2F4d+8cpJ2SgCAOma5bkFQBcmjGork8PQIp3rJuiH1dv53?=
 =?us-ascii?Q?Jq9wN/wC16QZmx97H54pw7OnWb0GS4txAFUDDwfnBnq/XZU5FOXnpeDVaWGh?=
 =?us-ascii?Q?Sxxlt0T+wZhU073rxFKYDivCR6OBNvjRIQlUol79ooRmJKRy7g1skPIb2d12?=
 =?us-ascii?Q?UTBepAjUblL0kAebAlmhheNgUD3l6eivMlNWfHjiJ+cwsW7JQwgrQkAUv/pO?=
 =?us-ascii?Q?JNezcS15QidRGoblF5xWDVPlpfAyUedAViQ9IgEJWFjfPYWBIAD78mc9GNiD?=
 =?us-ascii?Q?V7KdPZ/2A9DhwqbFCvq3cTJKkFHKP+Czxb/+k2oEzGIerbr0Id+PQH7pYFKh?=
 =?us-ascii?Q?iesq680a3S6+cYa41zFtN7DFLNk2Vifi5mwvLIdWyCUa/C2Vf3gY/uDdUWG1?=
 =?us-ascii?Q?Bf30rTGO86/TKnGZ46cb1gA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E943538B278C3F4683E8AE9479E4025C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b919b8db-6eac-4ada-501c-08d9f7b51ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 16:45:52.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HktnkhpP8DlKrRl3L1kZVVzQ2OoammfjQHOf/YNLiybb24xnjof8DzGd6cD6qI/JZ0xIwZ72ufmRejOUQRGwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4110
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240096
X-Proofpoint-GUID: je2OkmKn-K9SRYO9SEOrggECOP4JInHG
X-Proofpoint-ORIG-GUID: je2OkmKn-K9SRYO9SEOrggECOP4JInHG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 24, 2022, at 11:37 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> On 2/24/22 07:08, Chuck Lever III wrote:
>>=20
>>=20
>>> On Feb 24, 2022, at 1:45 AM, Randy Dunlap <rdunlap@infradead.org> wrote=
:
>>>=20
>>>=20
>>>=20
>>> On 2/23/22 07:58, Chuck Lever III wrote:
>>>>=20
>>>>> On Feb 23, 2022, at 1:08 AM, Randy Dunlap <rdunlap@infradead.org> wro=
te:
>>>>>=20
>>>>> On 2/22/22 17:41, broonie@kernel.org wrote:
>>>>>> Hi all,
>>>>>>=20
>>>>>> Note that today's -next does not include the akpm tree since it's be=
en a
>>>>>> long day and the conflicts seemed more than it was wise for me to
>>>>>> attempt at this point.  I'll have another go tomorrow but no guarant=
ees.
>>>>>>=20
>>>>>> Changes since 20220217:
>>>>>=20
>>>>> on x86_64:
>>>>>=20
>>>>> WARNING: unmet direct dependencies detected for NFSD_V2_ACL
>>>>> Depends on [n]: NETWORK_FILESYSTEMS [=3Dy] && NFSD [=3Dn]
>>>>> Selected by [y]:
>>>>> - NFSD_V3_ACL [=3Dy] && NETWORK_FILESYSTEMS [=3Dy]
>>>>=20
>>>> Thanks, Randy. I think I've got it addressed in my for-next.
>>>=20
>>> Hi Chuck,
>>>=20
>>> I'm still seeing this in next-20220223...
>>=20
>> I tested my fixed version of the commit with the randconfig
>> you attached to yesterday's email. Do you see this in
>> fs/nfsd/Kconfig from next-20220223 ?
>=20
> Not all of it -- it's missing one line:
>=20
>> config NFSD_V2_ACL
>>        bool
>>        depends on NFSD
>>=20
>> config NFSD_V3_ACL
>>        bool "NFS server support for the NFSv3 ACL protocol extension"
>>        depends on NFSD      <<<<<<<<<<<<<<<<<<<<<< HERE <<<<<<<<<<<<<<<
>>        select NFSD_V2_ACL
>>        help
>=20
> When I add that, I no longer see the problem.

That's the fix. I guess next-20220223 hasn't pulled in my latest
for-next yet.

--
Chuck Lever



