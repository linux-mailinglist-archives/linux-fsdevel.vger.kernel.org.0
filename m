Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37704A4EDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbiAaStV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:49:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243086AbiAaStT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:49:19 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VIKclK010040;
        Mon, 31 Jan 2022 18:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ISRBQ8HzjcPaW9JKFlBlcSmZ3FVVMtiZvTjDbdzjw04=;
 b=eZHgX1kbooribR/aQxOo+cE5mUz8LzvYJL8FD20RJLrFd4TMMztXCpd66P2Uip80Y179
 hJN5ca3OwVStvPSQiMAHn02kkmXJKICg1cN1vFkEoyVnEbsLv/hCfJF95bpgammgJy25
 xXknT7lIlvq9XCnPt3MvAwWAfmgvpWvJmMp0gZbIpkSrTxOr9d7eCRDBZBA9ML6i8sHb
 IeTFskECumuTKcqLJGzTyojO7xCG/P0A4SyqWYVFs0Rpri3QStdBG1+GJj8DXk3dcYSg
 C/40f/X8cnZv5d8wgeW6miP+6OWfmiagvwcz+mBZM7RZ60ycSjETKxF5ZkPnBWYBIMRb 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac0pg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 18:49:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VIfde9183976;
        Mon, 31 Jan 2022 18:49:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3dvume1rk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 18:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpTgxfg3wYZ6NL3QzBvWw3OEmcubenkw99WkqBneV6tPJgdKEBiTTvqu6JZSJqfR7dr1KMYs+m2h3IxVLHyzFh+xMcPqwES/XlyvDmRA7JwUJBvftGFmtVsRQBssyED2g8VvrvXfghI9Ei6srguK3VhlluOIPcje//TA5iA/iapeJ78z3geZCRnrX1w+VvxyI/raiiDPxi2oDSt/xhQcCqURHMcPLPwgp1PhzhRJX+qwiH50NYgRAB5wvAz2cJuYGUxedvsDLpYcigiYJwV+/xxZxu7GEWEARn0JdrCq6OM/qFt2KdHaqy1kg/JR9XIKrukaCo7fwLitpm8GKvr1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISRBQ8HzjcPaW9JKFlBlcSmZ3FVVMtiZvTjDbdzjw04=;
 b=FDhLM1+6JzSAK5EMsL3tW/KeMhPqjpQhDSvVA9Patef6OJ/O0bMo1IZekbsDdrn2iLuaxfSCuhZg9Mj/s2JgKviYDssPWP97CETVKRT8c93dzqbL0U58urouiKmiboZOv4i5Nl3la/Hx/ESvWymGO0bbUyiiLP9DtcO0z9S59PCMEhhbZpZC6x4M+0QJHg6KvkbHb0dystL5gdxpEYc/1SewKQnIWvffHxLx4OvQBOY/dICdTQcLADa5pk6isLCFAUGz2Fi/5TeVIPRkYQ4YYTacIPNc64aY+ArdmSK5HO1MASyr46OGvK6Vgp08gtCGFQqMaJ53NLPgl2AAHVhsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISRBQ8HzjcPaW9JKFlBlcSmZ3FVVMtiZvTjDbdzjw04=;
 b=bsL73UQxk3QxDrzSlB6YneLy+MgF+JNBELr/6tpgYr+Nq0I/tgcTm+BA1gff2RkfYcAVgBv558Py9QNx6XiHn0SAH4xMLbTUiwk8NTKsyQIUKsnVeLcpIzZ0BUfdcyaVen7aw5uQzr6BYAlbDrYQp/bcMuJFZskAv2HII+ty9aY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM6PR10MB2748.namprd10.prod.outlook.com (2603:10b6:5:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 18:49:13 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 18:49:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
Thread-Topic: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of
 large file sizes
Thread-Index: AQHYFtAIqaz3sFLzU0KCmTXzQ7oeOqx9dbEAgAADKYA=
Date:   Mon, 31 Jan 2022 18:49:13 +0000
Message-ID: <A3A5CC01-BDDB-4C14-A164-1AA3753DEA11@oracle.com>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
 <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
 <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
In-Reply-To: <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 000157d8-eb1f-44ee-9823-08d9e4ea6020
x-ms-traffictypediagnostic: DM6PR10MB2748:EE_
x-microsoft-antispam-prvs: <DM6PR10MB2748E6BB48FEA6E79DD7A23293259@DM6PR10MB2748.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oDBRnG9TF1h/WtSlDj3r6g1G/Y3NciRb756JmeEPQ4X8sLipqRLBW1/oBr75m4NJMGnoKR+tCzo14zqcBFwg61vAdGOTZivelAplrKiYnobIJ6MriMMdSan776mn1rae5jhYJU9If2X7SfqD1sG5m/qpoMGGRJlXg1b3LFbwgkQL8GCYqVHlnclt6h+4aSVazToBghBwmVlI0JWdJLmn+UTC06mqWlcyoNydAfk3RVh5EMUZto3mOvk/zskmz0hy2e0DgLnCBXh3DSbtEs1opJRX/86f/aw0ioYmKjRKJsC8P14SKPkyX+POwAn7uQ90wGAnH8uHSxlYznHYbYxPyDkOxCHarv0rF7P34QlpctpCzxtBwQVhL5qhwj1TJ6/NhnI5iTsKsoURbAe+utKLnvbR8Q0FL2+3ZzOYlEQ9K7Tm/wH8dHySnDDa6nwkBAHBi9PIcbmryI7eZDbkRsSi6nvmZx29woljSkxNP51yptsYb/XsKm19o9LiZj6XoFJa/w8oPOHk/QREMSLOUzJeqbUsOt1ZKVaw6DHpRwnjkSfZwRizDYkdaH3T23SsQZqAzxOKCh/plbD+DlLDMF+yR7HSKrH4U6/NgXgpeLsoUwfCdtgWwjqropEuQMTh+1UCz2zDlVUjsr2pr1yVZumqYElue9B1sHIApaNOI/U5q6aMyc69fp9m8oIABSdLDnrqIJ23KIu8E/osiQkaveWjsxOUHFnsYyEJ4Y4a6aU52+4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(122000001)(38070700005)(316002)(86362001)(4326008)(64756008)(8936002)(66476007)(66556008)(8676002)(66446008)(76116006)(36756003)(66946007)(54906003)(6916009)(71200400001)(508600001)(6512007)(186003)(26005)(53546011)(5660300002)(2906002)(2616005)(83380400001)(33656002)(6506007)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vZF6Wi+DI6VxY1e2QLNb9Gnkvd7mPuCBJJkf0iKcOsYQszi3mzJo5KgwKtnT?=
 =?us-ascii?Q?Q8rHoH2Kt0jaY/NjBBPYwQDes4nVApIjrY0xQQKdAYiossBJzWPrEGADCG1w?=
 =?us-ascii?Q?XmMwh2sWcpSvjwJNW83KDVDoMM2mFy3ca8u3MYCHsU8dAmloW3lipejJg6PV?=
 =?us-ascii?Q?P7chq58kIm11aw4SrhNKwxBLKvr+HcZ64YaTy/oJW9WVOKlgK3AwxXt9nxfF?=
 =?us-ascii?Q?GVCfdszS7qtFWbCZwUcjovCOlILtRJKhcS/GvHlXbxTuIEMB4N9EXrLVlq/a?=
 =?us-ascii?Q?z8PBi0sHnW1eGriZKR4DrtySvB7iZzwwptKG4As4ytSg5W6ROEGPb3GCfDwB?=
 =?us-ascii?Q?6swCgQ270Pn9u4U+rhzc7wpUQ0qz8wPBmsl3LJV8A4dY/rl3KL6NYwXxlG8t?=
 =?us-ascii?Q?v6lM0lE+lwHbuZOy/FqEce7yj2L7J/VZrNmBkTDb3zAobCouCcjZZLPoNwJn?=
 =?us-ascii?Q?zPp9spg0/KkYEXvUfNFoSSqcRs18uK2MTyIOvUPh/+W3TKyhqu2NmA/EbSCv?=
 =?us-ascii?Q?ZCD8ZE/HpvkeF/k0d9C0rWErU3Lz3BiJ9g2ameTI7MKTtsQuhJPZzsh4S4Nd?=
 =?us-ascii?Q?7LXdFBfEwf5lVeeUryzhMMu8odnDLEQu9POOX1Ryg/Iw656U7R/GXmyhsmCH?=
 =?us-ascii?Q?0ZK1QKed2TjKco5PmP8gzHCb9BH6f9KPGqGU6E3KSO6ojArbDXq15bNeqtq8?=
 =?us-ascii?Q?is0rthvbFCCqtvpjZCF3PWv87/xWvjfQgaixIMsbKLezllNhRoC9bglsOhAF?=
 =?us-ascii?Q?+PRNgQURIUF72usYx2zSi5e9a9eQUBVcXxVAH4Vi1ZwJz8ZEXC9AfIfhI5nR?=
 =?us-ascii?Q?hwhuZNZvPtZft1/Hm1CfY6OeopwZ6nI+YAcifquNXdufaOr+r6cnKrBS/iQt?=
 =?us-ascii?Q?bQX7HeaJmt7swRVIWKKWAxNFGwjHc/J4kR95zz9XpAipAVcWPTgVhzSU6Hzw?=
 =?us-ascii?Q?zn2YzS5CVoHr2XX3bWEM7Kp3TAC7tHI1NdCH9agx0yeXHBJE5GAQObKaQvrs?=
 =?us-ascii?Q?xGZOxp4QdwWaBFmc4LjR0PqIyozeW+lQbznOZ58mY8S+Dyy3NhgLjd9DHN/7?=
 =?us-ascii?Q?GhcW/1pUR6ziQCYKzlF5VcMEdnlC+0/xFGScJkLRU9uf26Dl8djzuplf98RB?=
 =?us-ascii?Q?jpvPHimryc1lDPV4wi9ZXi4U51Xh5zk9kJ1icewduNXCVAx6UdSxmWE3nfw7?=
 =?us-ascii?Q?C6TDmgVySotJar4zxElKkfri+bERuMlHq2EGcKvfzgvkjLqBd/c+8jhQM4zL?=
 =?us-ascii?Q?m4FHms8lpRHhB2oM5uP0KORvr86w24YqofRtCaugerLpBP9GvPjFXzoStO4R?=
 =?us-ascii?Q?f7uJ+oe5EH6k3TwGyD0f/sO4eE4PqDiAYSM2v9PIaS3rjG0m65LbmjXaVsoW?=
 =?us-ascii?Q?0AM4q249S5W1KO4IlhDNy53Oay2oOIMJJ6nsw07on4cRMvm0Mke56ixysZth?=
 =?us-ascii?Q?LifumxwrJuSkHfAN+n1JuJajMU+/Q+yQ2bMWRm4s1CMN6EenM0DPXLoksxHK?=
 =?us-ascii?Q?Lgdd1h4j03/U/iETR2Wf0kpFmvrvnQIsNbHZgiMAahwtuR1G2fHamGetxpji?=
 =?us-ascii?Q?fzOABzpyCFxURxJS/371He1fLM+ypGN4g1FD8hHjsXzB7xeTtFEh/tVTIQ6h?=
 =?us-ascii?Q?BOsCPEhPa65H40ObE3oj1x8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <106049B2681F2F4797E332EF06734370@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000157d8-eb1f-44ee-9823-08d9e4ea6020
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 18:49:13.5083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2ZhVM6V4ihoRq5L+4RfCWo2UliFi4+ioReUkiZ5UYf0kD5g/gpb0kSk5w6hNtxRyfUBq9vLhndMNMq0Z5s5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2748
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310121
X-Proofpoint-GUID: 2CQDdHN_39cicMwdYeQSPofGQHu7kLsm
X-Proofpoint-ORIG-GUID: 2CQDdHN_39cicMwdYeQSPofGQHu7kLsm
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 31, 2022, at 1:37 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-01-31 at 13:24 -0500, Chuck Lever wrote:
>> iattr::ia_size is a loff_t, so these NFSv3 procedures must be
>> careful to deal with incoming client size values that are larger
>> than s64_max without corrupting the value.
>>=20
>> Silently capping the value results in storing a different value
>> than the client passed in which is unexpected behavior, so remove
>> the min_t() check in decode_sattr3().
>>=20
>> Moreover, a large file size is not an XDR error, since anything up
>> to U64_MAX is permitted for NFSv3 file size values. So it has to be
>> dealt with in nfs3proc.c, not in the XDR decoder.
>>=20
>> Size comparisons like in inode_newsize_ok should now work as
>> expected -- the VFS returns -EFBIG if the new size is larger than
>> the underlying filesystem's s_maxbytes.
>>=20
>> However, RFC 1813 permits only the WRITE procedure to return
>> NFS3ERR_FBIG. Extra checks are needed to prevent NFSv3 SETATTR and
>> CREATE from returning FBIG. Unfortunately RFC 1813 does not provide
>> a specific status code for either procedure to indicate this
>> specific failure, so I've chosen NFS3ERR_INVAL for SETATTR and
>> NFS3ERR_IO for CREATE.
>>=20
>> Applications and NFS clients might be better served if the server
>> stuck with NFS3ERR_FBIG despite what RFC 1813 says.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs3proc.c |    9 +++++++++
>>  fs/nfsd/nfs3xdr.c  |    2 +-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index 8ef53f6726ec..02edc7074d06 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -73,6 +73,10 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>>         fh_copy(&resp->fh, &argp->fh);
>>         resp->status =3D nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
>>                                     argp->check_guard, argp-
>>> guardtime);
>> +
>> +       if (resp->status =3D=3D nfserr_fbig)
>> +               resp->status =3D nfserr_inval;
>> +
>>         return rpc_success;
>>  }
>> =20
>> @@ -245,6 +249,11 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>>         resp->status =3D do_nfsd_create(rqstp, dirfhp, argp->name,
>> argp->len,
>>                                       attr, newfhp, argp->createmode,
>>                                       (u32 *)argp->verf, NULL, NULL);
>> +
>> +       /* CREATE must not return NFS3ERR_FBIG */
>> +       if (resp->status =3D=3D nfserr_fbig)
>> +               resp->status =3D nfserr_io;
>> +
>>         return rpc_success;
>>  }
>> =20
>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>> index 7c45ba4db61b..2e47a07029f1 100644
>> --- a/fs/nfsd/nfs3xdr.c
>> +++ b/fs/nfsd/nfs3xdr.c
>> @@ -254,7 +254,7 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp,
>> struct xdr_stream *xdr,
>>                 if (xdr_stream_decode_u64(xdr, &newsize) < 0)
>>                         return false;
>>                 iap->ia_valid |=3D ATTR_SIZE;
>> -               iap->ia_size =3D min_t(u64, newsize, NFS_OFFSET_MAX);
>> +               iap->ia_size =3D newsize;
>>         }
>>         if (xdr_stream_decode_u32(xdr, &set_it) < 0)0
>>                 return false;
>>=20
>>=20
>=20
> NACK.
>=20
> Unlike NFSV4, NFSv3 has reference implementations, not a reference
> specification document. There is no need to change those
> implementations to deal with the fact that RFC1813 is underspecified.
>=20
> This change would just serve to break client behaviour, for no good
> reason.

So, I _have_ been asking around. This is not a change that
I'm proposing blithely.

Which part of the change is wrong, and which clients would
break? Solaris NFSv3 server is supposed to return NFS3ERR_FBIG
in this case, I believe. NFSD could return NFS3ERR_FBIG in
these cases instead.

Is there somewhere that the behavior of the reference
implementation is documented? If the current XDR decoder
behavior is a de facto standard, that should be noted in a
comment here.


--
Chuck Lever



