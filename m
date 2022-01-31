Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D25C4A4F32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 20:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359073AbiAaTJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 14:09:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40748 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357719AbiAaTJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:09:14 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VIGIuC031342;
        Mon, 31 Jan 2022 19:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eqOSxmoANqcyNZeCjvPKZ3urebL1d8DdERLwYVoFOFE=;
 b=d5oxAViMFxERszAUP+SJyXeni+v0wCKtCbTdGFEO2X76akEQtOWq0jIepnPzrsJ/Py5C
 5dazCYsewfFWz0JhMxz7vynrrlxGZlVXiuF89N1gUInVxkNqxnO1BS6D4pJj4LbK7nli
 ym4HwA/NMLRk6oT58U/jk3glBhkLj15GJFW4zewqdLVqnUXFpd6sMbB9myaoTGXFi39V
 XhqNYblSMO5sddUDh5eMC+EHBGcJ1fcy7zn0vezw8keYNj1nqBcrsSyZn+xzkcXyzjMn
 tbvc6UF49kvIWGibLiYoXtHQYJnciShFTE95gnaYEDK30a5RSTjuPZkQEq10CtVY+hTR /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9v8qwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 19:09:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VJ56oo153865;
        Mon, 31 Jan 2022 19:09:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3020.oracle.com with ESMTP id 3dvwd4tym0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 19:09:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Gmtaf3gST80xWwBK5ZGuH/iUf/dKG6CFk451zxr2ExfR7/zKFPpPIiXqsF3yUK2J8w5KleHWbc5i5uVpVkeiFhFDRgR/FEqrIbMVQAK4NFStTN+ZwbQwEUkZNbM0uNAa/0iT2DPh8C7Xa0xYcwOXEdNOcoX2JpnVPldl+o6c1jsfYdVOXHvuP9ubCCnraz4pPpppjUtzUwEU8tv1iHjCrfHVPMIbSGXWltnskrszIAczcs/I1qYMmHUoS/FXq/nfEgoo5ey//jWAP3ThXc9r2V7qrYK4xA47Kwz/g53D//6//1PPZs1LVPuNSS+KnneD4UMJfZLhtPgHPrL+aEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqOSxmoANqcyNZeCjvPKZ3urebL1d8DdERLwYVoFOFE=;
 b=DhWVn8HC+X4mHM9ZrP33ssaixpLK9RJt/63sqPnqjbtrEXEdBwP4xtrH9K7c3Z2KlduJvJwUA3XUlSIzfefK1Bz4CBEIgLzNIodayDQ1NUv7xk/OiDQ0TMRla4jW4npCGjmNFdiZTIZW6jm7MYTtpObPFFNXrRVtoIQpxLNRP9dj8TjqJOj1Me0NdD04RyJx/Q+VyPfeeEXPDAcFw1X9tVawceJD+jhjn0b+0eFotg0TkQT3eZYTqSwmLIi6V9orI05HgaBrNsZ9vPlFn5LXbei+cczq7CV9tnTabe3gPTjgz/04ILR/x//g7/tMQsqXplxHaL7KRq3CA6LW6R9yPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqOSxmoANqcyNZeCjvPKZ3urebL1d8DdERLwYVoFOFE=;
 b=S0EKbhimBIFpAoZD/2zb5fHf6khUPT8j2TJYnkpudIFjarToizeKIxR9MYbl+dsjjH2IDBhn2BtMtC11+ZYRME99Zmc4SRqQQ0lwEOQh5BXn6q24C/O1gB9oZfwfEnmqjN6s3EByLwWa9K7jkU4JJ+ulNFLw1D9eIdqRlJp3PTE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN8PR10MB3508.namprd10.prod.outlook.com (2603:10b6:408:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 19:09:08 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 19:09:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
Thread-Topic: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of
 large file sizes
Thread-Index: AQHYFtAIqaz3sFLzU0KCmTXzQ7oeOqx9dbEAgAADKYCAAAKkAIAAAuuA
Date:   Mon, 31 Jan 2022 19:09:08 +0000
Message-ID: <29C8C45B-6D53-4504-AD16-06B93069113A@oracle.com>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
 <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
 <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
 <A3A5CC01-BDDB-4C14-A164-1AA3753DEA11@oracle.com>
 <bbc79f87d4cc26d72bc27dcdccc5011ec0b0b341.camel@hammerspace.com>
In-Reply-To: <bbc79f87d4cc26d72bc27dcdccc5011ec0b0b341.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e5a8e9e-0f78-4805-09a8-08d9e4ed2832
x-ms-traffictypediagnostic: BN8PR10MB3508:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3508A019E03AE85F70B77CBB93259@BN8PR10MB3508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2xVaDubOklorrOs2+ItkzFqzySTeldTpKg/HYoNyatkccDXs9MO9K05589aMkZ1PL6jvXFafSAJm/yK/IbNVWr5+rF6N/B+lkCFwX/xLGcGpx7p3U0p5jjkmCOJFDSOeIGP9Oy9J/plxnzGOjSz5KSPi4K2BWiCk/nT0OSyQDhz+hN8ixLtnaNWI6GoDQeaXH3TdRUnXvimryWzHmnJYwcrj++WGjVugKzKepeOxw5aEPIJc5sLzFU3E17LQRE+0V+Z7ceezPSld1vCQUCzi/4jjDVu7CPts+jFXQ2Wdnd2CXsqQtQz9+G8Yg3PzD223F+uEC4WliyMGIBixmZihJviszRWm7TC0Hg1uVCMUAwFQuYL0//frA5pFx89S5ucj0udqeaEQHKMXg9BmX621WdUquE9/5xI+8jxCYx2dRyWt0P9Zqz2EEPx14bPsb3pJzMbaaha0SlkDLg4JhKPZohY2eONcTSW2SyMgDrWv820KjAPkcyCrZzC1zI+a1QfNP85icg7u3vUcmrWURw0FfOohjZVsM1Lcu8M47LPozmkYrpCWSKPd/wWom4BMOTKDgj32drcelSftk8j/5DyvOLZe89gAJ2DStOUmMOoycP6lCqtZeGjKzQUA7G6165vuwbsg9VUZfVvWUWG+Yf4M1cINPENllk/Rgo+2sH6Y+Meavcdx3TiACxwl4SwLBm4GyGtcX1DH1IBjLtcxNF2iXG1yBm0R73snbQzduitKE8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(5660300002)(6512007)(6506007)(186003)(26005)(83380400001)(33656002)(2906002)(2616005)(38070700005)(316002)(86362001)(66556008)(66476007)(122000001)(38100700002)(6486002)(6916009)(54906003)(508600001)(71200400001)(4326008)(36756003)(66946007)(8936002)(76116006)(64756008)(66446008)(8676002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LyIF+3ygfM74sZ+FloJ3fr2JysLICBoWki7Rx3lP+JU6YGy5JT1VY2JkQ5k5?=
 =?us-ascii?Q?ciQwOUveyq+GEld+BuOT8tmX/RoTTyM5RhPCae/qrQ2g5K4A/uabxiz+o7C2?=
 =?us-ascii?Q?DpR8rb8zBQp5izctS4NOlXz6tYjyQ02XXrIBHFIuBHP38tyczvlhkloBSq9o?=
 =?us-ascii?Q?tFttOB5XHD/fveB4V2VlC++2FfFqRxTBC5uLPBvKBjqesxS9RYjvFbc9PCce?=
 =?us-ascii?Q?SFvWHUUL01rWeQTqgRAMBw8Rg5wObsRszwpuiYdBOOrazdv5QqcCfwsIYySD?=
 =?us-ascii?Q?rCAaqaZmNaQhy48V+AqCUVLcd65ik2rxgjEbb5gKH7hDqalk7ZPe1oy0DFry?=
 =?us-ascii?Q?diCUmTECPPpzC/riiyTgBegx98SlQAupSxuVF4cFdUWkLQUB39OEaMkPuOzL?=
 =?us-ascii?Q?u9d/IW/z9c4iBi4Bq5Sv/Ntv5/fk817E0YKvu70RMLhrfGDk8o39vRtKTQog?=
 =?us-ascii?Q?4DQEVtFjiSqKRp69FiWGCgKIvZ6qjgHiJf7o3dSQDcf4/zrODhEsnIMubABp?=
 =?us-ascii?Q?C/opLmyQrm/SLkgMxA3ppn/vu9Ffb8wnpU+FqYJAQttF+yqH9DxcM6dpVVH+?=
 =?us-ascii?Q?fXz21khpEWKT5XHKJ62p06NqvQ/gW4Tul1XaFIzFcfD43E24Y6KYbDkxAZ6a?=
 =?us-ascii?Q?ehdwUM8CcoSx9siOk8pj0iGhisVhJaRROp9n+iahMdnzNGt9SsmtVOpYL+w2?=
 =?us-ascii?Q?6RfRdJvpIOYOjtCzhTGDQ/fGrgsOPCKbYtvMzQ/NnZwpkeQa1bhfFdbgIHkN?=
 =?us-ascii?Q?XyqHXdvuVWucnOOnP024tdeJvhOQhT/6XBBSRqt34BfMj+oy6kmwEjxgjkG/?=
 =?us-ascii?Q?6HUENwRZYkV0AG0UcEu+1Ba3K2ZlFNZZMf2FjtrjlfpibXlBrXX8cHoUYdak?=
 =?us-ascii?Q?iZfJ2zU3gJGdB+gkEB2mawCBGuuRTvBdIZ5m9Ev9WB3aIqb8CrTOq/JgcBXZ?=
 =?us-ascii?Q?B1NV60Cxn2FOIJB9/gPvUPCHstKauuojVyENyT/LMC8sMbxRj2MwG+3vhdaJ?=
 =?us-ascii?Q?omYov9PXeQdwuIntFBc+TBHxA+DsvQQd4yXb09RxzTxooXVGXNhIdpbQTHIK?=
 =?us-ascii?Q?3bDFG8WfllWvhwIshjDv886nUqFkFsGHcJVZdV4JJ2qfmIoDllzMCVO5qRgm?=
 =?us-ascii?Q?UXAnmBtj1I1jzcETo7XH0udYTT7u82dUl1gJu99PPnClOkbSyjbC705XRqxj?=
 =?us-ascii?Q?I6WT/V05lTzm+Z2t7bGwvyLRAFNCm1bcbtnOaf3CIYGLWt1phOlNvenlwgDK?=
 =?us-ascii?Q?ScLr7TAZl4zMLFb9Mw9qCS5YEaEvUsDcE4HcITe2UhbHRsUmlCh+Kvg8hLTG?=
 =?us-ascii?Q?uethU5VRvYli7o8bln/Par4cb2q+3GU+A31waHlkytHd9STDvtKD6Gq52QT2?=
 =?us-ascii?Q?IW+Yerd4fWxVu4AALPsfz+hcHlnuAIsDv9kt/+ZUq4/yM/TUtv9R4kmBmMCo?=
 =?us-ascii?Q?1gJaqeWG3+lbJro0gVnA2norU/XtjlaXr/xvx6ePwxCq+e8KzIjkbdsSiWkU?=
 =?us-ascii?Q?waXNHJ2RIB8IFVUkMv5ezFDLdmaqiJd0XzodOGwi3Dk3gmhLEgh2crcZPzTr?=
 =?us-ascii?Q?jaCdXp9wXOZkf/IQkWL3hW+ejTDNYm3OOoi+cZH1y2u7/nAWlSIE3tgm5TDM?=
 =?us-ascii?Q?Su+g4pcdOIcpllfyI9F7MF4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1579F211B775FB489F1B151C7EFC2512@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5a8e9e-0f78-4805-09a8-08d9e4ed2832
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 19:09:08.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJoJQrPEkdLmK1xY9cT4T0Kmlqs1lkAKjZaicS5I4iPSThNgQkBwSVD/5cJ+d8xQ5PVSn8dCsBXZxyN7ceCOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310124
X-Proofpoint-ORIG-GUID: 8Tb6ZW3YWdbMMlSPe5HdNwV9xaF_bqNM
X-Proofpoint-GUID: 8Tb6ZW3YWdbMMlSPe5HdNwV9xaF_bqNM
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 31, 2022, at 1:58 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-01-31 at 18:49 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jan 31, 2022, at 1:37 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Mon, 2022-01-31 at 13:24 -0500, Chuck Lever wrote:
>>>> iattr::ia_size is a loff_t, so these NFSv3 procedures must be
>>>> careful to deal with incoming client size values that are larger
>>>> than s64_max without corrupting the value.
>>>>=20
>>>> Silently capping the value results in storing a different value
>>>> than the client passed in which is unexpected behavior, so remove
>>>> the min_t() check in decode_sattr3().
>>>>=20
>>>> Moreover, a large file size is not an XDR error, since anything
>>>> up
>>>> to U64_MAX is permitted for NFSv3 file size values. So it has to
>>>> be
>>>> dealt with in nfs3proc.c, not in the XDR decoder.
>>>>=20
>>>> Size comparisons like in inode_newsize_ok should now work as
>>>> expected -- the VFS returns -EFBIG if the new size is larger than
>>>> the underlying filesystem's s_maxbytes.
>>>>=20
>>>> However, RFC 1813 permits only the WRITE procedure to return
>>>> NFS3ERR_FBIG. Extra checks are needed to prevent NFSv3 SETATTR
>>>> and
>>>> CREATE from returning FBIG. Unfortunately RFC 1813 does not
>>>> provide
>>>> a specific status code for either procedure to indicate this
>>>> specific failure, so I've chosen NFS3ERR_INVAL for SETATTR and
>>>> NFS3ERR_IO for CREATE.
>>>>=20
>>>> Applications and NFS clients might be better served if the server
>>>> stuck with NFS3ERR_FBIG despite what RFC 1813 says.
>>>>=20
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  fs/nfsd/nfs3proc.c |    9 +++++++++
>>>>  fs/nfsd/nfs3xdr.c  |    2 +-
>>>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>>>> index 8ef53f6726ec..02edc7074d06 100644
>>>> --- a/fs/nfsd/nfs3proc.c
>>>> +++ b/fs/nfsd/nfs3proc.c
>>>> @@ -73,6 +73,10 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>>>>         fh_copy(&resp->fh, &argp->fh);
>>>>         resp->status =3D nfsd_setattr(rqstp, &resp->fh, &argp-
>>>>> attrs,
>>>>                                     argp->check_guard, argp-
>>>>> guardtime);
>>>> +
>>>> +       if (resp->status =3D=3D nfserr_fbig)
>>>> +               resp->status =3D nfserr_inval;
>>>> +
>>>>         return rpc_success;
>>>>  }
>>>> =20
>>>> @@ -245,6 +249,11 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>>>>         resp->status =3D do_nfsd_create(rqstp, dirfhp, argp->name,
>>>> argp->len,
>>>>                                       attr, newfhp, argp-
>>>>> createmode,
>>>>                                       (u32 *)argp->verf, NULL,
>>>> NULL);
>>>> +
>>>> +       /* CREATE must not return NFS3ERR_FBIG */
>>>> +       if (resp->status =3D=3D nfserr_fbig)
>>>> +               resp->status =3D nfserr_io;
>>>> +
>>>>         return rpc_success;
>>>>  }
>>>> =20
>>>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>>>> index 7c45ba4db61b..2e47a07029f1 100644
>>>> --- a/fs/nfsd/nfs3xdr.c
>>>> +++ b/fs/nfsd/nfs3xdr.c
>>>> @@ -254,7 +254,7 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp,
>>>> struct xdr_stream *xdr,
>>>>                 if (xdr_stream_decode_u64(xdr, &newsize) < 0)
>>>>                         return false;
>>>>                 iap->ia_valid |=3D ATTR_SIZE;
>>>> -               iap->ia_size =3D min_t(u64, newsize,
>>>> NFS_OFFSET_MAX);
>>>> +               iap->ia_size =3D newsize;
>>>>         }
>>>>         if (xdr_stream_decode_u32(xdr, &set_it) < 0)0
>>>>                 return false;
>>>>=20
>>>>=20
>>>=20
>>> NACK.
>>>=20
>>> Unlike NFSV4, NFSv3 has reference implementations, not a reference
>>> specification document. There is no need to change those
>>> implementations to deal with the fact that RFC1813 is
>>> underspecified.
>>>=20
>>> This change would just serve to break client behaviour, for no good
>>> reason.
>>=20
>> So, I _have_ been asking around. This is not a change that
>> I'm proposing blithely.
>>=20
>> Which part of the change is wrong, and which clients would
>> break? Solaris NFSv3 server is supposed to return NFS3ERR_FBIG
>> in this case, I believe. NFSD could return NFS3ERR_FBIG in
>> these cases instead.
>>=20
>> Is there somewhere that the behavior of the reference
>> implementation is documented? If the current XDR decoder
>> behavior is a de facto standard, that should be noted in a
>> comment here.
>>=20
>>=20
>=20
> Please return NFS3ERR_FBIG in the setattr case, and just drop the
> create change (do_nfsd_create() can never return EFBIG given that nfsd
> always opens the file with O_LARGEFILE).
>=20
> There is no document other than the Solaris and Linux NFS code. RFC1813
> was never intended as an IETF standard, and never saw any follow up.
> Nothing else was published following the Connectathon testing events
> which determined the wire protocol.

So to make sure I understand you: Drop the hunks that
modify nfsd3_proc_setattr() and nfsd3_proc_create().

I'm fine with that.


--
Chuck Lever



