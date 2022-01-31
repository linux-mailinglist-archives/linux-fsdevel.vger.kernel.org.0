Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE44A4F25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 20:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358996AbiAaTEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 14:04:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62678 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235245AbiAaTEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:04:16 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VI9Uwk010613;
        Mon, 31 Jan 2022 19:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Nz+I9BzBivK3ANTcehWnhlMrcqXNuMh/OHCZQYYP/Ug=;
 b=GAym+Jh9nQ9eRp/rjcrqmakRdy0LIJPvFc4cxw4pNbsAWGR2y6++A2cBQC0MYFCFEb9l
 V68L7lkiZor5krn/DuCU2/M3dwOe9WpHtTLLboCS9rnvAtUGCKKq1q0pbbRbPzK78Ub7
 ubRRQ37V2BxEgN/kualZMHdP0g96xCBmXx8P1ZK8XvY7lRvjgAddYEvwU2AZUsiyU49Z
 /H6V9kPHngyaiextYgFsXJmZlYxqhrHcegejrjUHU4re9iyNvAt59uec+X59fJz9L7uL
 T2WsnkwzGWUjPCE4W4VmFcvQZLEysZpXbu8ypWrsZ4cGvqWCC0Wt7hHCHyaGn0/qcyVA Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatrr7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 19:04:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VIv6Sx127709;
        Mon, 31 Jan 2022 19:04:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by aserp3020.oracle.com with ESMTP id 3dvwd4tr6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 19:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRy48RP71bBtiELfOmT4Yi8mcwGlaqc6uJ7jz+YFcDxdBUrTwh6vMZsPi+/1qGFnpxrgJr0Nvt0AdpOgmPL6JmjMpg5OU0dIBZHXC1lyADiHBdu3GipUT+SeR2jIASP8BwEyCRNwZw0+/ogXYxhEDwrDkqon0CiMGO/Y8zWLTUyd1XRD5m1ab6eFuz+HuIo2ZgBsXLSzFOClPFFam7AVz40J6YXVudN/x9mOsll42gH4OdgrPSp+K/AmslFGsZMgBiXcssoFlMsxSTCwz65BOyhINZ8FYLg/z3zsruqom2rpALcdyh9slzh/Wyhh+r2HgnQIvcgK2s59eoBkIA0kJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz+I9BzBivK3ANTcehWnhlMrcqXNuMh/OHCZQYYP/Ug=;
 b=X2TtqMcebivC2JXmYUM6ptgK5+pPhNiFGkbAr+UiQ8dhrHG1Xk/H9eMtLDmaQZuka/TX7VBE218UzU9a6rQ3xQ3bExW48JFmh4ZBMNMwNjQM0t10ZUIXfKLsrg/y7BHlkj2u4ubC92340i7ItWFnCqj9B7Su380oQd7hrkEZEwj9Kgobkjm2zLaEZjMm0uY8DH36VDFKo6Tb4Km9gpLvjypqtImmOVoUVcaZtB0GGJ+sHPygsGgJwck8W8MEPkJrC2DErCFn8gVrHNiOwQjPYVSHw5kAfd0Y8V1TiFodQdqAh3kXe+Q+sTPC3ZGbp3hWpJfK8DadevT4N0WrKEOGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz+I9BzBivK3ANTcehWnhlMrcqXNuMh/OHCZQYYP/Ug=;
 b=KdoO8oc0v8J5BteWTN2lLs+q1JGiGjECWVlnzXO2nIcHOuIdaxwazi2OLMFT2ypNt/X4PtcUE9fEcdjqqQ/k5K1+RRNGbaBSH4d36qx53ajhr0kUJH5U/5ghMeCCxquz7B+ozkhile9VyQz1R7k80UWQKpZK8BWYjB8fheEFh0g=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by MWHPR10MB1885.namprd10.prod.outlook.com (2603:10b6:300:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 19:04:10 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 19:04:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
Thread-Topic: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of
 large file sizes
Thread-Index: AQHYFtAIqaz3sFLzU0KCmTXzQ7oeOqx9dbEAgAACkICAAATGAA==
Date:   Mon, 31 Jan 2022 19:04:10 +0000
Message-ID: <7B55FD48-0E59-4D9D-A06C-B8312BAEDC45@oracle.com>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
 <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
 <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
 <0448eb0e136da9e8e24880411644f5fcb816e833.camel@hammerspace.com>
In-Reply-To: <0448eb0e136da9e8e24880411644f5fcb816e833.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99519e61-e055-47c3-3bda-08d9e4ec76cb
x-ms-traffictypediagnostic: MWHPR10MB1885:EE_
x-microsoft-antispam-prvs: <MWHPR10MB18855A3F2FEAD35F44E484B193259@MWHPR10MB1885.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFU13RuL2B2dlyGUVtQQnUN3BRZQASm44/F73oqX+01QJHPzpFqEpf4viICLqYiF7llHFRdMmcqTn9K2aRkuK+Yu2IB2FYUEuC8fxFHmQ1gdK/Q20zv6h1dGq9S/2fe0R3xa6D9jnffE3oKysSX9woHOVBzTthp+eW1hCl9CkrVL8XIlDMGkgU1Ugj8PuC8idAXtNaXaB6KB3++xESxx9cT4qZUu6xH2QUe2OnkDZIpVlk7P7REiCS2V8ew7a0gthe0w3BcDbZbWRCRJu5yEfQ+MpCNPhnZbOaKWZxdoM9MQ3iwHFSYUgE6AhaX+WATJDECsJd4cu/qalOgtPjv5Kl9+eoueoc84GnKG9av5s4c3RVyUnIjkDdkK7uF7fNb+62QwzRF5I8T00BSHv84SIPOgt2r6ogKHHtst40+ZDU93iyJzYmJO6fO+YU3K83/nSyrm6g7TYgUjRw9+IBC53CUYQkfUZCx/GUjiCDZoyX0lRHZ9yQfyC0d8Fy+8ve4gI5Y55YVmQHgaOzcWtvkBcciKLsGSQZtHX0GusLBrvJf2N49IHkcLttNoytaVqsC3W0PlA18Lbi2vX9CoLO3ieGYeXKU4f3t72huwBRrM4yFuOueTPMR63ZX9yfVlAGAR4PXtkc+2V0jYSTKkPSth9DzIIVegH+d9aPLOLToOI9mIP1ikqqd+Qh6FjJwXdF1KkTy84/Xs6FFcprYbaBTGv15vql4Jy6DiosYqv5E0A5y8pKur9kxScxlTP5deFMTl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(38100700002)(2906002)(508600001)(316002)(54906003)(186003)(26005)(2616005)(6916009)(8936002)(8676002)(86362001)(5660300002)(4326008)(36756003)(6512007)(6506007)(122000001)(83380400001)(76116006)(71200400001)(66446008)(64756008)(66476007)(66946007)(66556008)(33656002)(53546011)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0xix4ZkFWrdlfcU7KkZ5GvYR6b2Snk1IK2pX8TvJIZCTVfaefA4Cj5ZhCXsC?=
 =?us-ascii?Q?4id6OBeLlT7jOlS3xvnAgG3jsEBeKsd2mDR7yk2DTZ4lpDWI18JxhzHdNpVY?=
 =?us-ascii?Q?Szlj8D96jrDQUWoY/N/V5Rcf8HW8BAiShU+mlH/3+ETTW0no7D2vnv2mU7sx?=
 =?us-ascii?Q?MIkYtDyrECzawTu9JCH1RRkTvBLR8bIqGyi7HMP3PubHXN5CrvPqXIbqNXAr?=
 =?us-ascii?Q?L18XsLgmYXS32K6eFCn5+EZ9ArZSqo1tBbKqVqYQmJpB53Km/PhMnCj3/T8V?=
 =?us-ascii?Q?1I4mnxyscSXO4jLb9IieunwKjQ8RQcnLRA4hvPyOhBv50r0kEsW7wuggvK28?=
 =?us-ascii?Q?D0HoG1ZbhIP9qD3mJuB+GzqtM+qLwLUT+X+M4c03rK4MBDReQch1MRhYhqum?=
 =?us-ascii?Q?tpn4MtxfMvTS73pSwp8EtbqFprViQPrHbmFaGN9/jDi1ecMEpNwbgJkUE6ZD?=
 =?us-ascii?Q?EoxCoAbkf/wTmjg9tbLi8X7NuE6cz/NMGGiJ3SwVye//UK904OBgttlBG+3W?=
 =?us-ascii?Q?qbjcAWmLeYszmG5F5+5ygA5lKvu8436WoDWCCFarHPCGYTt4wfzSh9zbiceS?=
 =?us-ascii?Q?Um4ox2ZC672COG6J5cyw1I6UdfdODM+lSnrQVQotcYzNJNkmadGUUrWylzsk?=
 =?us-ascii?Q?SFCYHf6N4IzYVmr2c4Brik7WDY+yxl+2D9BwLn0NfN6tWVrF5pewrfJ7hr2k?=
 =?us-ascii?Q?4HdGQg6yMMA47cYb6ewHjU5xweefi/3VBgV4Yqu6c3HXeci86iAFaV6nrQIG?=
 =?us-ascii?Q?qKKPRTlG0M1DJMuVcaYiVGvb7ZW2U08jUScWSc0t8glE91Zy5FH+2+vpKVnU?=
 =?us-ascii?Q?S8W+pkCdvDTpy6JKMY2Qdy9zl0/zCUnyF2WqJMHAo3051QjYLq/F4I5H+4Ct?=
 =?us-ascii?Q?gqKBxqodk2vsuEsXoIguF5Q2MN8QQA5BVfPWxZa7u8xtvkKTUpdcQ326xJoA?=
 =?us-ascii?Q?ta48Ah4pdreBSWmEe4U4dfunkKh81LxVpArDFzzsN45ynziLEAS8S6s6cI1O?=
 =?us-ascii?Q?BgDWMmr4iHSk0qxgbRFCoLx4n7Cp82YvRrPzNq5T7aKzRWdpls4Zf100vf/B?=
 =?us-ascii?Q?pKjuwtIzHXGUikg7iMEchL4l05ZEP0GEC3tO4LEfMXY80bkcv/zhXeBHZM41?=
 =?us-ascii?Q?/9lYH3JHlsD764IUrXeLdKENAltZEnIJCncsSGQnk90ovidQ7U30YLyfXvge?=
 =?us-ascii?Q?3ns0nb0HJKK7UBKWX7IYNEJmZd9Ua3iL6wC4HH5YxiYnEycSDOETpxFxJIiH?=
 =?us-ascii?Q?hGN2Gsl53eo4srGwJeLMa/bx31EJ3Hg8rls2FFk+14F4BuQu36YVgFEXdOF8?=
 =?us-ascii?Q?k4YV6+fj1j9XGfud9mP6chjapqh+QR5hi3t6UwbQ7R2cPxMF0NOqRaBU7mEv?=
 =?us-ascii?Q?qKnVXLaU8gUf3FaE9Bx1AgUyCWMKq+ZUKYsSbik5jDnMWilFMHDsw/uNW/NQ?=
 =?us-ascii?Q?+3+mK71B9aU20qU+BzC8iJUQxebK/g93R2YeeegfMnBm790v79D3/d9YB83Q?=
 =?us-ascii?Q?TD4uomWXGs9G2D1yPhLi3cfnYZArUmR7cu/aicN4uX6uRKAQG9DyamfbYsRU?=
 =?us-ascii?Q?GNB/S/W522M/j4j2+9TpTmHWqu2+ZROlWlx/mvtXhhiTz49rFXrRfs1elCIS?=
 =?us-ascii?Q?rm1fTCkE6DXfyZuBIAqQXQE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5F8C4C86BDAFF43B7CBF9C515490A5A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99519e61-e055-47c3-3bda-08d9e4ec76cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 19:04:10.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aBDodTs+yDZxPUCsqNZSJC4oB6zUx+S8zNOwK8elvM1olglUT0dd0hrDE5Ft2EFO/vcUWju3XUMoHkhjOvwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1885
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310123
X-Proofpoint-GUID: _ZoH8NF7Z51slURl2u8hgVOueR9iIqsA
X-Proofpoint-ORIG-GUID: _ZoH8NF7Z51slURl2u8hgVOueR9iIqsA
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 31, 2022, at 1:47 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-01-31 at 13:37 -0500, Trond Myklebust wrote:
>> On Mon, 2022-01-31 at 13:24 -0500, Chuck Lever wrote:
>>> iattr::ia_size is a loff_t, so these NFSv3 procedures must be
>>> careful to deal with incoming client size values that are larger
>>> than s64_max without corrupting the value.
>>>=20
>>> Silently capping the value results in storing a different value
>>> than the client passed in which is unexpected behavior, so remove
>>> the min_t() check in decode_sattr3().
>>>=20
>>> Moreover, a large file size is not an XDR error, since anything up
>>> to U64_MAX is permitted for NFSv3 file size values. So it has to be
>>> dealt with in nfs3proc.c, not in the XDR decoder.
>>>=20
>>> Size comparisons like in inode_newsize_ok should now work as
>>> expected -- the VFS returns -EFBIG if the new size is larger than
>>> the underlying filesystem's s_maxbytes.
>>>=20
>>> However, RFC 1813 permits only the WRITE procedure to return
>>> NFS3ERR_FBIG. Extra checks are needed to prevent NFSv3 SETATTR and
>>> CREATE from returning FBIG. Unfortunately RFC 1813 does not provide
>>> a specific status code for either procedure to indicate this
>>> specific failure, so I've chosen NFS3ERR_INVAL for SETATTR and
>>> NFS3ERR_IO for CREATE.
>>>=20
>>> Applications and NFS clients might be better served if the server
>>> stuck with NFS3ERR_FBIG despite what RFC 1813 says.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>  fs/nfsd/nfs3proc.c |    9 +++++++++
>>>  fs/nfsd/nfs3xdr.c  |    2 +-
>>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>>> index 8ef53f6726ec..02edc7074d06 100644
>>> --- a/fs/nfsd/nfs3proc.c
>>> +++ b/fs/nfsd/nfs3proc.c
>>> @@ -73,6 +73,10 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>>>         fh_copy(&resp->fh, &argp->fh);
>>>         resp->status =3D nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
>>>                                     argp->check_guard, argp-
>>>> guardtime);
>>> +
>>> +       if (resp->status =3D=3D nfserr_fbig)
>>> +               resp->status =3D nfserr_inval;
>>> +
>>>         return rpc_success;
>>>  }
>>> =20
>>> @@ -245,6 +249,11 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>>>         resp->status =3D do_nfsd_create(rqstp, dirfhp, argp->name,
>>> argp->len,
>>>                                       attr, newfhp, argp-
>>>> createmode,
>>>                                       (u32 *)argp->verf, NULL,
>>> NULL);
>>> +
>>> +       /* CREATE must not return NFS3ERR_FBIG */
>>> +       if (resp->status =3D=3D nfserr_fbig)
>>> +               resp->status =3D nfserr_io;
>=20
> BTW: This EFBIG / EOVERFLOW case could only possibly happen due to an
> internal server error.
>=20
>       EFBIG  See EOVERFLOW.
>=20
>       EOVERFLOW
>              pathname  refers  to  a  regular  file  that  is too large t=
o be
>              opened.  The usual scenario here is that an application comp=
iled
>              on  a  32-bit  platform  without -D_FILE_OFFSET_BITS=3D64 tr=
ied to
>              open a  file  whose  size  exceeds  (1<<31)-1  bytes;  see  =
also
>              O_LARGEFILE  above.   This is the error specified by POSIX.1=
; in
>              kernels before 2.6.24, Linux gave the error EFBIG for this c=
ase.

What if the client has sent a CREATE with attributes that
has a filesize that is smaller than OFFSET_MAX but larger
than the filesystem's s_maxbytes? I believe notify_change()
will return -EFBIG in this case, and correctly so.

NFSD's NFSv3 SETATTR implementation will leak FBIG in
some cases. If that's going to be a problem for certain
important clients, then I'd like it not to do that.


--
Chuck Lever



