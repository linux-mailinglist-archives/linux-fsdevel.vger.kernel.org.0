Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3163E4EB45D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 22:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiC2UAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 16:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiC2UAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:00:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC6DFDC;
        Tue, 29 Mar 2022 12:58:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TJTPfQ030756;
        Tue, 29 Mar 2022 19:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7GWftjms6Kzb4ScMXV4DkLw+8T3N5An95hhrreVEMUc=;
 b=N088bKWyB/8KBPnixUD2GAfHuaF++TdMcG0VWNmAtbVIPNUg3pdBOq+xAUQxaHUmLncM
 Mc3Ke71ShiGGu293aSIlKM+OCe8w2/b7y7dB4rFyC1l8F+rz7pKXOAsGVttgwBZlUKFt
 Pc0vjJOG0obh/ZQ5+I2Ilw92ZSLhTV8dyi1wFUvZWq5z0RtVwPr1qooXafyu5vgeTEoe
 e10zagfXcLztF22N027jbqTc7aUMdU+ymEPoUoulb9G0xPWtHtcyTKde1QHNqadeyNAJ
 XSxfe3zg65pyFUrTWYrP2wFieRJ6CTjR/OQN90a4SivsWAWOY1iFBBN20r4u2+BilwWS /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cqgh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 19:58:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TJtrgi142219;
        Tue, 29 Mar 2022 19:58:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3f1qxqfr7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 19:58:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWEE/P36hqPARABvemgyCk22LlVTgEgJQI950nWCYOXKekXHhGGpmsxIwBxaY5B5vzeFOMnCe7f3kmOL6msEZb5vLczQUqCeXfUQzuIg2Pb2ylPSlEwsqkrOQvoMm8HhJ3v1Huvn+w/xc79NKC0yZyVquPUxsb+OQY1hD2enm8jBiIbw6+do8yrvdLNHEioqyma1oyLUsuEoKlRfX97vI2G0zrKCrHaJiP/P8+SzliuMZRT31aEYafrUGouusmsyw/BJ4EPnuLTbnZYgpaTMqUNfRBC1S3YCXDp1d9Si5GJBWq/JrwHBSQ3/s+y2aPm8ey39BdHB4ItJoanI1051Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GWftjms6Kzb4ScMXV4DkLw+8T3N5An95hhrreVEMUc=;
 b=Q9dngEyRw//F3k2FFIhPHCVwVCBLHkmiywgesu3jw3kyTIhMvvyLebC9jf6OdFrXyIp9MMo6+dV6ul2qmAmPsAQaaV6vo23lGrNgp2Cli6LmF87uOFPoyMvsNVHvczKQXXA0DNAWXN/EAnX6R438RmUp9o/f8Vir2nFhSNRVGwR1rh+24hqX9QuzAwLkYnUmzg/TZE6gXuaw7dcpBjKLyzd7NKoPnJM9cTfxcpEU4EB4BhQTeC+J3j0rJmqUIx7xn7Mp2EjDbn7bOHCFqbonfglqe2pcrBaWDHLPdKvowOSA4/bRFcRZLiuW02TeF+plOVe881ohefeI7cmfajKsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GWftjms6Kzb4ScMXV4DkLw+8T3N5An95hhrreVEMUc=;
 b=zUwxWPbjBHtjoKkc2LI6+xQ3jRvH/sMdD90Jx9H4OyU8wy6vuTvEd2bHhswwXwcOnoSk5o0/QnvirtVBOqRQdjDAeNpoTa7GIL5aIzRmIa3taYuyQECQxFlaSk/ETC5MCZ5UxdFQh6bER/fQ7ffjMRh/qwc4XrWKYGSwfFK92ws=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1370.namprd10.prod.outlook.com (2603:10b6:3:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 19:58:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 19:58:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>, Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Thread-Topic: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Thread-Index: AQHYQAGu2vXHyzFxzEOK5co/7sorDqzWiKwAgAAI/wCAAALWgIAAHqSAgAAFbQCAAA7/AIAABI+AgAACqAA=
Date:   Tue, 29 Mar 2022 19:58:46 +0000
Message-ID: <ACF56E81-BAB9-4102-A4C3-AB03DE1BAE76@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
 <20220329183916.GC32217@fieldses.org>
 <ED3991C3-0E66-439F-986E-7778B2C81CDB@oracle.com>
 <20220329194915.GD32217@fieldses.org>
In-Reply-To: <20220329194915.GD32217@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6f241a-0da1-4d7d-fbf9-08da11be890f
x-ms-traffictypediagnostic: DM5PR10MB1370:EE_
x-microsoft-antispam-prvs: <DM5PR10MB137019BF908F327D7AC089DE931E9@DM5PR10MB1370.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6jsrQ50OJc8GosUgGOBgXwvq90oH2Bi40lkPSzPU3WW051Pe6ThgDYbVn+5PHxNIHHhp/gAiXux0ORaKAeP31zuJEw67l1CBYo48pU1Aah4TiR5lqSW2jSTfK6HHKvAsb5SrYwmnu83g2mhQKWY2jjMd2iTnjc2SgIJNpFWRVzgJHPEiZp8HQyAmq3KNfsbhdpVoLwSJkK4uDCkIhwQ3qt5ARUc1WZ+Nxm7FTMElFb5z+YkM6jG21JTxeprEIatEM0h7SilY48YYJ60/X8a/LS0Kt5/x9umbD0IYS41YYN27NyoZLS8+MIwACcAr0HjCWyYgnc7sauNruQivoh2M4ehxcw4MJn9eRWaNmv+qRbwHTEIG1lCEnYgBrYjzQLx4XSnL94yZ46cH5QFyoghxqHAcShidlXS2EENpUAJZcoLxlKF++lG9rcSWiexB/BDaHFYMko5Ez4ryHgADSnYwX/AzudfhSaxCGW1EUP+dBo/drL4dchwvX+Vd2FL1/G+kxa6kl3AHNMWZwHCd75KJLQTsU+AKkKkNqfFEoY/pIFS4SRc394TlieB+XTgkgPXmUMU8CSZMghPIrfRST6wZGEs6YZiHPvwwXU9jbTNYjvkdy8zpO9+6NwW+oUMFNCA7qcXHmLA8jti8bPlYKQkVc/ILyEtTXVyvfEjxAX6WET0RvtkFwyRNjChpHrUK69nFF6n7180AqmXP+PkjPm7XTsrSgtp4e7V74FRQQ/svJq4U7VZSfbwKn+ynJbRQRg3E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(66446008)(5660300002)(76116006)(66946007)(83380400001)(66556008)(64756008)(66476007)(6486002)(36756003)(316002)(186003)(6512007)(91956017)(26005)(2906002)(53546011)(6506007)(54906003)(122000001)(38100700002)(508600001)(33656002)(110136005)(2616005)(71200400001)(8936002)(4326008)(86362001)(6636002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tsd+AvahPQWbYP9PHWUnb0MCVvvD/2teFMQtnefJV+FIGEw8gAnbV5G4z574?=
 =?us-ascii?Q?YVvZnLepO4uPkuRvPKmn2QZwawxE2ekA0yRUwUZI7MU1H2I98cf3cZYT77YJ?=
 =?us-ascii?Q?OCatzCOqj0Z858szPO+bm4w3L5AbwoOm3+88zxfHLfHMO9X+xz45IVs6S11u?=
 =?us-ascii?Q?b8EAihDvJenPJyN+JerfO17XHauoq4ziIMYT2Gd4PMMo0WyJb40XkeJdmt+0?=
 =?us-ascii?Q?GVXQLvXGfWuHKhO5STN+Vlck5Msj4fWyTbMnxAiEAjmaG3wwZGAt7K1STmNX?=
 =?us-ascii?Q?zih4GJ6SI62NO81g0FX9/mqaBhw4ofQD+fFZLR9c/K6Et+01yoOpku9uftV4?=
 =?us-ascii?Q?lT9AFes9iLQLqAQMbQoz7QcFIgZTHPJY4WnLo4ChcClgpXrSjRKlD2CpuhdX?=
 =?us-ascii?Q?k0+igiB3dRb+C6/xqsfYYngsm9c72kxx+k4CaSYEZK7C/wk/Tm1y5T6CW4T4?=
 =?us-ascii?Q?NpNJDNoD9lpA3sOfHWrd3YPiNGx4++3hC7X/HddhteP0S9QLstw2O9EMILsS?=
 =?us-ascii?Q?NYbrfPDWoXZNBlsoSbCBRTkwRBUI2pAy3rmR+7K6XN4deAxzU3/mUKslhLrP?=
 =?us-ascii?Q?0zaABb/W7Tg7D8jksKSkmb90n5Zkgwk9gAoAf66VB2S6VywMJH8VafyVP9ly?=
 =?us-ascii?Q?15/96SfdZ6lFqI4LNHGjmJWUYtGAS4q0xlF7LQI8JesiZ6ZFcp3fT2iUv3Gx?=
 =?us-ascii?Q?UA7JnDO2hIMqzZAP1P/BJBv12Wnz5KIyJ3owpuHc5LSVK98H137zMU3e5bAz?=
 =?us-ascii?Q?iqSdhFOQTt9mo/UKWTRb/MPEenu5rIpsnHllVHu5M8gHTrDHFihPYgMB1s2m?=
 =?us-ascii?Q?CWNFc4+pKLKzZq0BvNDy+s47gi8ZE9xona3ip47kn3J4Dqxn3z99MfLOjDxt?=
 =?us-ascii?Q?iYOPSOeDDzbj34X6GLXvJu9RBWMQvuyUDa0sMELB90Hr5S2Es+PAl+uXjwxb?=
 =?us-ascii?Q?sKMnO2hVKM00614s+bqRdW+kqXHuXex7mmGQ4K6tWxu36dZvlxpCteB1w4Yo?=
 =?us-ascii?Q?SxqyuISlBqyKDoLvg7l1d0Q3bL+EqNlAHb9S0f0NUB6hybg56dncdiF1KjrU?=
 =?us-ascii?Q?lZ79VfY9UaXZyvbAqnFY/1vNjtkIsUpAaHQBeXzSu2fvJs9L6GUu++zasfAz?=
 =?us-ascii?Q?fN73UwMwPVxZK68bfBWy/T8tcCwHAGhW9eKuH09s3/VKODM8GZPcZoPaaVdH?=
 =?us-ascii?Q?SkJUcnry1+1MDxca5KqLEkQjFGlA30DRlL9tT61Y04LVrGR843MxUNPO6M2n?=
 =?us-ascii?Q?EKrC0kV39e0rYJLXzfYjbc3bsB7kUoC4hl7+m+RnICWZERqQ4oNtOdgAKGXq?=
 =?us-ascii?Q?PXAsOzeAa4h43Hw8jemkj/YcN7xCwJaqnpWcy3naJdIt0c2NPDTyPjoDe4DU?=
 =?us-ascii?Q?0cOV1zALfPICCY+5iVjMSYFioxpPJcjZYUyZxOqaFlMr7tUwR4KdfD9YQpnl?=
 =?us-ascii?Q?5zVRGzTGUBJXKF/Qk77ieiXnCokS+0YjBoyAG+R2SzdmbHyw5UqtXcQit3h8?=
 =?us-ascii?Q?VjNofvJOJtxSmBmm2Pw3SbIdN0Ovk5mbpc8aS4+OK3KLQHzTcfvpNPoSo8qF?=
 =?us-ascii?Q?76/JGwgkbNpbTvc/OY+xI94xQkpPVPVaixj12JI10vWzRe8ozrwe4oMcSXwD?=
 =?us-ascii?Q?bze6NdGg8KdBUe34e9NnnKxjpT5NAwp8/Zzi6xIC+U+5G/AjSQ00JH62pR+N?=
 =?us-ascii?Q?h7BwLIHNsqYNJZKhzuZpjVDcoVu/hfVB+4kpQBbmQjRp4+QK+d65sulUS2Ez?=
 =?us-ascii?Q?TmB9pp6Or/LnyVCHvCGsm1vt0WvhDrM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D426647FA0DC44B81ECAB7A09C113C3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6f241a-0da1-4d7d-fbf9-08da11be890f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 19:58:46.6518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUBB4J7xcrLVu64mwHsyKhxLvf47QpLTXSl4IMZFuGLXM8REOBo7j334K5FNRnaSPcv1iCuRgP/s6BocG8wR5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1370
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290109
X-Proofpoint-GUID: hEOVotyjEYFoFI7kgNEXXrbG0UbrH0pX
X-Proofpoint-ORIG-GUID: hEOVotyjEYFoFI7kgNEXXrbG0UbrH0pX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 29, 2022, at 3:49 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Tue, Mar 29, 2022 at 07:32:57PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Mar 29, 2022, at 2:39 PM, J. Bruce Fields <bfields@fieldses.org> wro=
te:
>>>=20
>>> On Tue, Mar 29, 2022 at 11:19:51AM -0700, dai.ngo@oracle.com wrote:
>>>>=20
>>>> On 3/29/22 9:30 AM, J. Bruce Fields wrote:
>>>>> On Tue, Mar 29, 2022 at 09:20:02AM -0700, dai.ngo@oracle.com wrote:
>>>>>> On 3/29/22 8:47 AM, J. Bruce Fields wrote:
>>>>>>> On Thu, Mar 24, 2022 at 09:34:42PM -0700, Dai Ngo wrote:
>>>>>>>> Update nfs4_client to add:
>>>>>>>> . cl_cs_client_state: courtesy client state
>>>>>>>> . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
>>>>>>>> . cl_cs_list: list used by laundromat to process courtesy clients
>>>>>>>>=20
>>>>>>>> Modify alloc_client to initialize these fields.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>> fs/nfsd/nfs4state.c |  2 ++
>>>>>>>> fs/nfsd/nfsd.h      |  1 +
>>>>>>>> fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
>>>>>>>> 3 files changed, 36 insertions(+)
>>>>>>>>=20
>>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>>> index 234e852fcdfa..a65d59510681 100644
>>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>>> @@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(st=
ruct xdr_netobj name)
>>>>>>>> 	INIT_LIST_HEAD(&clp->cl_delegations);
>>>>>>>> 	INIT_LIST_HEAD(&clp->cl_lru);
>>>>>>>> 	INIT_LIST_HEAD(&clp->cl_revoked);
>>>>>>>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>>>>>>>> #ifdef CONFIG_NFSD_PNFS
>>>>>>>> 	INIT_LIST_HEAD(&clp->cl_lo_states);
>>>>>>>> #endif
>>>>>>>> 	INIT_LIST_HEAD(&clp->async_copies);
>>>>>>>> 	spin_lock_init(&clp->async_lock);
>>>>>>>> 	spin_lock_init(&clp->cl_lock);
>>>>>>>> +	spin_lock_init(&clp->cl_cs_lock);
>>>>>>>> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>>>>>>>> 	return clp;
>>>>>>>> err_no_hashtbl:
>>>>>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>>>>>> index 4fc1fd639527..23996c6ca75e 100644
>>>>>>>> --- a/fs/nfsd/nfsd.h
>>>>>>>> +++ b/fs/nfsd/nfsd.h
>>>>>>>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>>>>>>> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>>>>>>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>>>>>>>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>>>>>>> /*
>>>>>>>> * The following attributes are currently not supported by the NFSv=
4 server:
>>>>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>>>>> index 95457cfd37fc..40e390abc842 100644
>>>>>>>> --- a/fs/nfsd/state.h
>>>>>>>> +++ b/fs/nfsd/state.h
>>>>>>>> @@ -283,6 +283,35 @@ struct nfsd4_sessionid {
>>>>>>>> #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name=
 plus '\0' */
>>>>>>>> /*
>>>>>>>> + * CLIENT_  CLIENT_ CLIENT_
>>>>>>>> + * COURTESY EXPIRED RECONNECTED      Meaning                  Whe=
re set
>>>>>>>> + * --------------------------------------------------------------=
---------------
>>>>>>>> + * | false | false | false | Confirmed, active    | Default      =
              |
>>>>>>>> + * |-------------------------------------------------------------=
--------------|
>>>>>>>> + * | true  | false | false | Courtesy state.      | nfs4_get_clie=
nt_reaplist   |
>>>>>>>> + * |       |       |       | Lease/lock/share     |              =
              |
>>>>>>>> + * |       |       |       | reservation conflict |              =
              |
>>>>>>>> + * |       |       |       | can cause Courtesy   |              =
              |
>>>>>>>> + * |       |       |       | client to be expired |              =
              |
>>>>>>>> + * |-------------------------------------------------------------=
--------------|
>>>>>>>> + * | false | true  | false | Courtesy client to be| nfs4_laundrom=
at            |
>>>>>>>> + * |       |       |       | expired by Laundromat| nfsd4_lm_lock=
_expired      |
>>>>>>>> + * |       |       |       | due to conflict     | nfsd4_discard_=
courtesy_clnt |
>>>>>>>> + * |       |       |       |                      | nfsd4_expire_=
courtesy_clnt |
>>>>>>>> + * |-------------------------------------------------------------=
--------------|
>>>>>>>> + * | false | false | true  | Courtesy client      | nfsd4_courtes=
y_clnt_expired|
>>>>>>>> + * |       |       |       | reconnected,         |              =
              |
>>>>>>>> + * |       |       |       | becoming active      |              =
              |
>>>>>>>> + * --------------------------------------------------------------=
---------------
>>>>> By the way, where is a client returned to the normal (0) state?  That
>>>>> has to happen at some point.
>>>>=20
>>>> For 4.1 courtesy client reconnects is detected in nfsd4_sequence,
>>>> nfsd4_bind_conn_to_session.
>>>=20
>>> Those are the places where NFSD54_CLIENT_RECONNECTED is set, which isn'=
t
>>> the question I asked.
>>=20
>> "reconnected" simply means the client has gotten back in touch.
>=20
> Again, my question was: when is cl_cs_client_state set back to 0?  As
> far as I can tell, the answer is never.  That means, even long after the
> client has reconnected, it's left in a weird state where it can be
> suddenly expired for all sorts of reasons.

Got it. Agreed, cl_cs_client_state should be reinitialized if
a courtesy client is transitioned back to "active".

Dai, would you add

+enum courtesy_client_state {
>>>	NFSD4_CLIENT_ACTIVE =3D 0,
+	NFSD4_CLIENT_COURTESY,
+	NFSD4_CLIENT_EXPIRED,
+	NFSD4_CLIENT_RECONNECTED,
+};

And set cl_cs_client_state to ACTIVE where the client is
allowed to transition back to being active?


>> The server then has to decide whether to allow the client to
>> become active again or it needs to purge it. That decision
>> is different for each operation and minor version. Look for
>> "if (cl_cs_client_state =3D=3D NFSD4_CLIENT_RECONNECTED)" for how
>> those choices are made.
>>=20
>>=20
>>>>> Why are RECONNECTED clients discarded in so many cases?  (E.g. whenev=
er
>>>>> a bind_conn_to_session fails).
>>>>=20
>>>> find_in_sessionid_hashtbl: we discard the courtesy client when it
>>>> reconnects and there is error from nfsd4_get_session_locked. This
>>>> should be a rare condition so rather than reverting the client
>>>> state back to courtesy, it is simpler just to discard it.
>>>=20
>>> That may be a rare situation, but I don't believe the behavior of
>>> discarding the client in this case is correct.
>>=20
>> Can you explain this? It's a courtesy client... the server can
>> decide it's expired at that point, can't it? IOW what breaks?
>=20
> I'm not worried about courtesy clients, I'm worried about clients that
> were courtesy clients but have since succesfully renewed their state.
> Expiring them for a failed bind_conn_to_session isn't right.


--
Chuck Lever



