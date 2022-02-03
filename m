Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0054A8C77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 20:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiBCTcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 14:32:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33728 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240903AbiBCTcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:32:14 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HTBwB011613;
        Thu, 3 Feb 2022 19:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eY+XqNFduAX41W8TpvYE5P42MITUoi/qtS6yb4jnpec=;
 b=Q4Ubnusopz6nD0SA30m7hJ1yls8fqaT2joXPSLsqav94AqE4B8C2EyRjaPiETmpGZQOi
 B7d+DW48SWhBUyNtZat3iV3w8j+Jy3SuvXhBXLzcwc0D0+H+sehc3DxApnLkRYJxXwTT
 m3J+OzYr0PqXPcuDJhofSsf0N/LwjQzowVo2WGrEfmXAYq7wI94qjiN+KvIR/dzwl2Wk
 pxRbT451C3qvFg/sTzBn1oT2XddOYDCAyzWMYHVeflYBoSqEsBrAr3NZYRsknjyaP/hF
 MhBDTbMkXAYBm1aU27ietm0e1vNM8CgyyP/K8mNFZ9GvOq/NQY2gTZYLWJ2954B8paGa UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0het8s47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 19:32:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213JLo3P066261;
        Thu, 3 Feb 2022 19:32:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3dvtq5vm48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 19:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y15KGUOrxNklf7ismq52WgqxZvaz2s/iUpzPEov8NL+TEqdhW/S4yOi1593H88p6XaVWJLPIvlGZXDDluGuY040l/MYUqbLzMsSU68om7FQ6eZ+C9WkjUJe1a3sRz7SfOmyd7pXk/yRM57ey7zkYcJ2h7C5NV/5E3Sx5GBv/1gDZiMyYbV9tkGPQpP40ikL73N9wd6xlzCy09GebmD+YZ4SbicnvnjwYwTBRtXJNIosiC1basAp0Tbd+WgYJZ3c9BoGWylFppJPbBl6/ZIKUFkUBjsNzvEGR0FHjAmTT1xU2rCIslKZnIFAuAyVKi1SUQA/jXNhwY/+Jwgek8qReBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY+XqNFduAX41W8TpvYE5P42MITUoi/qtS6yb4jnpec=;
 b=Vqs9Os5dtmu+lDGUCscOP2CuRPQyqPeBs3TSlX6nzg7R4Kehc00wQevGnfcPhGJ/8OBdJ1Sb7IXI0OYp4G+Ip7Ge5fHsZ36pbPcjfLMUkbMKqG/vYZdBfMEj6qZBCRxM2NivW7y/imKAlDz2eBH16+aWsIub6CM8882GpN4rvNFZ+9SqKkw+TTv3p7ceXMYnxm+OuXfcUPiqGmFxj1v/u6Ha2U556PJxbbujxdvuBtwCf+4ZwbeFdeeR9hXM+JYDRLMzP99uPDvUCDgnQnp2pDcnkmpqGaQ/KvYGtclZy5mY+886yRkjh6CIwGJClg4JwKomSiHjCzJ7xJingyggdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY+XqNFduAX41W8TpvYE5P42MITUoi/qtS6yb4jnpec=;
 b=eLNxlixrRt6cchcY7hyRPCMofYQc8YIKdu2Ppbb2pf5k+ieTP2hgc57XsrR1e1fXBwDRRoA+q3Zw/H/zBmnujDBme4y+fZ+5WwbXZ9G+QdTO621F8G9+PkcMIfrRHiuk8yF+jXo6UtLxr7dYbw/s5TtmhNEofrBKShpyoOLjo1w=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM6PR10MB3385.namprd10.prod.outlook.com (2603:10b6:5:1af::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 19:32:09 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 19:32:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/3] fs/lock: only call lm_breaker_owns_lease if there
 is conflict.
Thread-Topic: [PATCH RFC 2/3] fs/lock: only call lm_breaker_owns_lease if
 there is conflict.
Thread-Index: AQHYFH7W0rGCTsT7ak+Nt+Sdq6K0MayCQHkA
Date:   Thu, 3 Feb 2022 19:32:09 +0000
Message-ID: <7CA3D081-8AC4-4B24-849C-7840457D18F8@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1643398773-29149-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 961227dd-1eba-4811-d56b-08d9e74bdeda
x-ms-traffictypediagnostic: DM6PR10MB3385:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3385BFCD912B523E4FE8B3A693289@DM6PR10MB3385.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyR+skVVx95sYih2MmY5RAJ4sYIt32M7z2VbJxFehTQkYuN17A/dWj6YJKCUBe7aU2tlOfTgor3m5ZcCYdQGO9NdGG/cfHsfKMML563pt5tt+NuZYJbrvdEj0sux0ltWRWF7nIqNg5JCCqRTPg8z+6bzl9eiWL4/A0UzUYWfHhznNzmvd+/+P/sUiltbGUk21sJ4r4VXgOqt+ih7wlFWhBAv4NiaRe8ie4RnE/4GssAewpsnPkJR3auLaGB0To8c2kbrFr47Yw/bEvzoCP6ANKKmqbhpgfqtuboyDGy8Lu6PuZlSEn0etWyFRXQRBx0jDZQqpeGA0Jj1VkFajghSSK57C9zNG7/gOx7okC/8Y074TSnmQ4argnmC7j9ng6YBeb9AqNzaTnhWOicXcTRCQfP96vFQwh54miFRGoF8tmWVA7BkaYRZlfFkUfi8XXOhev7WEahCaY7VMFfrVW8sxJC/IyV11aObzDjnOnY9g9pPhvauLQo/wtAwngz0fm69Twvw34HcGYItlG7xnvctKD14Iu72hFqBbiIAq64qfXjkLbeIEg6o6WHj3Y3ElTl0W5JiVLEZsM3mlN3KNZTknXO4uksSk6qGpEky74q2lMJ5azjJajj+Cwvsi9SN4D7pUtvEk1+ebjvp2JCINCa3PvsnsY9t46L0HwWfgLDKd63O46PCIraHUx3/8iA1WJaUOVfe1T48QlrDEZVW/73oLD6TDj4R1YpCQqoFHIv1Cf/mGwWXicLTQZvV3eiA5G7S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(86362001)(71200400001)(64756008)(5660300002)(54906003)(53546011)(122000001)(38100700002)(6916009)(38070700005)(6486002)(508600001)(66446008)(76116006)(6506007)(8676002)(8936002)(6512007)(66946007)(66476007)(316002)(66556008)(83380400001)(2906002)(33656002)(2616005)(186003)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ol3liXdTjZnCTWG92YtZf/LShWGwHwjBq/6MQzNGKP0NBqbIkRFTrAHgNEgU?=
 =?us-ascii?Q?Y5mT8Ov3On2igES/FYlDdenIRIxMYStxPd5dmkijZ7pGLIQogBtebSUEU9Fa?=
 =?us-ascii?Q?bjPr2uIZQKK64FtXAAlxMI2hc3K9bkwjFzgyVRlvRUv8n5jyTnjjL4YoCiFc?=
 =?us-ascii?Q?BA0ymbvL1UpsL2Lzg+cdfLa4xJK8gQZrbDvom8ZVJQxkP6g8A830ZVFHQgAH?=
 =?us-ascii?Q?2sotDMP5jduHMfQb9DWoZ2ZDvAd0k84rcB6U2bumpO0wXoBTqpVoSGva0TtU?=
 =?us-ascii?Q?uFF+7HEQm5CJsfrr4misfLyHdx1buir17dc2dIbpWM1yv9PaImO+RXaU6n9M?=
 =?us-ascii?Q?zeagxgPdzDHZ4PrRUnN9JQYDvSHiay4lwGchva21CmQdTReCS5NXP1fzdRCj?=
 =?us-ascii?Q?DhzTNoObyb0jNWVOswvdZytNU+nJNz1HEu3AivT/7DFw1M4vW4lVSWWOZimr?=
 =?us-ascii?Q?dMij2KU6/evom9IVYL1NL4FmCuJtbXX0Pw/4hFzV6EassKktt0QUMfjATNC3?=
 =?us-ascii?Q?mj3Iw6K5/0ysimTifAtLqSTmCc83q9V73XYPD5xEFHJeYTe2Tqb2jRNQp9YN?=
 =?us-ascii?Q?gMuZYJrVPeBZ0HlZw/4mkkW76M++TvrWj8CXVwAsIXfqT3DkWOm/wVebry17?=
 =?us-ascii?Q?Szj2iXQo6CNbup39ZQVvOLPrhpaqU7IZC3BOydotvbGzEMtbqDhoNEKGqMGS?=
 =?us-ascii?Q?WhOE2Tqoxu5QNWZ7PChup1NGa7z2wYv6n1qJ3AC/5jpCiXFbyMkWL8cx66R2?=
 =?us-ascii?Q?bSMkNhbOjvUihDpuz+ufggg6qTsvIxnztsRyIksAACXBcfP/LJ0ee/HYhEcS?=
 =?us-ascii?Q?iphK7jCVHD4i/HUet0KyHuisDV+OYW/reZSP9hYY1A0kJ1g9Yjs9isNTv2E8?=
 =?us-ascii?Q?culkNG0Q2FRNvgMzfzhm+JtTVe3d/Kf0vu6dNSx7VqfEHqNUOr/gYhJof/LJ?=
 =?us-ascii?Q?hP86cqOXtTY0d4VDglYLdb73fKDQp44PJ+eZG2namVgWiWrCYZI1l3jXsVKM?=
 =?us-ascii?Q?/qtnL5u29F9ZvA/vQurscGLnShzb/HPo9hVUqe6rZFrmXQhpPioDZqsPEMKx?=
 =?us-ascii?Q?SrxIH5wz3C+uaWm1JIjR4LjIUO3p3ET0A1CLtshd0YmEg3UtA83UJqzwoTm6?=
 =?us-ascii?Q?dmrYSsjY8krZqBk7kdqS8DmTsKQAMecweqGNdFWAGNeBvUNUu7rRHSv/19y0?=
 =?us-ascii?Q?uea4OS+B31TnuP2bV1/twc7W0GN2gqzP4mDaTZu/qaK4c4ZFy2jIi4YUk/cD?=
 =?us-ascii?Q?m701VDXbbYxbo+022c2y/KoPtXWg5x9Ac1Dc9vcTIqOvszVkFkDc+qszPQB+?=
 =?us-ascii?Q?HjsAYvc953ilgI3BRBURaL0OFlcnphkddkJjH+Ghz7RNT0Nt8id24rDmM3KH?=
 =?us-ascii?Q?NBefmPH5YEv+ObvsknJvYLs0r9rTrVePVJF94wyTHi+XzIK7GVL5e0aCPdZO?=
 =?us-ascii?Q?Ox9SvbUgM2j3Ldu1cBQxIfh2cFGyTLlFAtrbDo+VESQ/blD3It3zdcZ3lZvj?=
 =?us-ascii?Q?s125xjCsCik28mvEkYosfunXY5xryb3QuGXpmzWCktMoo8mxqrr1VbNeea9Q?=
 =?us-ascii?Q?pU8eaZqfHXSR5nGRtuaUQW4qAb7d0PRnC3GayUVGpWkqBiuWAQUuZCMDmef0?=
 =?us-ascii?Q?dPJG4tiC4KcuW8CE9t967H4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16751B1856D9C34BADA3C27A50C2F55A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961227dd-1eba-4811-d56b-08d9e74bdeda
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 19:32:09.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8SON7q1ooBoiG76Hm+zAkf5ExC0cXvbfH7h9fCnctHHTIHCPuqmKTEO78Q8JWQLif0nUFoJs2wC1cuO5wkAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3385
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030116
X-Proofpoint-ORIG-GUID: HZ1C_32tS73GD78d07RLrAg7D3QUee5C
X-Proofpoint-GUID: HZ1C_32tS73GD78d07RLrAg7D3QUee5C
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff-

> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Modify leases_conflict to call lm_breaker_owns_lease only if
> there is real conflict.  This is to allow the lock manager to
> resolve the conflict if possible.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

If we are to take 1/3 and 2/3 through the nfsd tree,
can you send an Acked-by: ?


> ---
> fs/locks.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 052b42cc7f25..456717873cff 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1357,9 +1357,6 @@ static bool leases_conflict(struct file_lock *lease=
, struct file_lock *breaker)
> {
> 	bool rc;
>=20
> -	if (lease->fl_lmops->lm_breaker_owns_lease
> -			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
> -		return false;
> 	if ((breaker->fl_flags & FL_LAYOUT) !=3D (lease->fl_flags & FL_LAYOUT)) =
{
> 		rc =3D false;
> 		goto trace;
> @@ -1370,6 +1367,9 @@ static bool leases_conflict(struct file_lock *lease=
, struct file_lock *breaker)
> 	}
>=20
> 	rc =3D locks_conflict(breaker, lease);
> +	if (rc && lease->fl_lmops->lm_breaker_owns_lease &&
> +		lease->fl_lmops->lm_breaker_owns_lease(lease))
> +		rc =3D false;
> trace:
> 	trace_leases_conflict(rc, lease, breaker);
> 	return rc;
> --=20
> 2.9.5
>=20

--
Chuck Lever



