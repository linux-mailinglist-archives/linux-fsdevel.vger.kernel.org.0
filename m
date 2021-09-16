Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CBB40EA7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbhIPTCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 15:02:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55464 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345734AbhIPTBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:01:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GI9fc3002295;
        Thu, 16 Sep 2021 19:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ev2iYEB1n70aOKIs61spi837s/X3vCjo69krzBUCQqs=;
 b=YXs0bPckrdMs6eR/pyNNSVVW7EsUtyxAk9M57ZjrbeKWm+AWTJdQ5/oMGEaV1FB9vfQH
 ofJhi/371VWGoWgn4ne4IBHFtzMadjWKdCTHgLOa5r6TbYBmT1clhz/AJBKHYl0ynNoq
 k8Iy9UfbLqUXbHaeTrQxO/a+af1keNwK9M7ZGi/so0mglfcrr4yfmQZSpnisWObx0De7
 Mlvj4qDxkJaIq9/Sjf4As652B5+1pPEpXazAReJ0XD7eKEX509nXgne8fuxFMj4rQPTI
 08oNkm+Pj+KXKQXTg4vfA4LzI0tad+7GicL18hTjSShHaIukRx1sIFGwNLyDTwbz1rVW 1w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ev2iYEB1n70aOKIs61spi837s/X3vCjo69krzBUCQqs=;
 b=rBGvtJ+gBC1wDgCZzXp4dQvbToCQ4QYp3lOtfwu99OHQTehQgvDJLsZfD4tRtXPfTiw1
 hmmoAYsjnT9pIhAyp9UKRKP2ncO6fmk62Xw6rBYLZv4KIE2FlopK5aqhFh5HUW4hNk2Q
 qTNtNGzaBrSS1edY4X4vCfgtdAEeSWJQ1hC1vnz4HK7dt7/a7+WLgU+CnLYzGC/jfsmT
 htAqTfb3CxPRHUasuZUEqqSeOUnMHkYJE5ChrJoD/wQwwYp0BwzPyfHPoeN8GXuTPmHK
 tTrLi+5DVqB41NWieuIKhrIq2OP0kLbrp6v40pDyMgRLjp7b+M2/6V7Lmn60jALsomwE ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jysn3sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 19:00:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GIpHo3175733;
        Thu, 16 Sep 2021 19:00:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3b0hjyq7uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 19:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da/z2aOjaY65Lckh9eVYjff7zNv4QnAFx1zb7Grln06mXRMj70JIz9HKXMSHUsGVyrHbDHNK5yAJjXTn4hhKS3BFqso/DBAElRKeyZk2gQ6R5S/8jpl7wuwuoKR+44gxosMN5gnAkdRnfMnQYASDuuO9O2L9Ye/rMVzqx0jgHRBPL/7pTd4sbcLG1bqFQtmFxdeEd6z9wQ9gQdFY2p5B1vqiCPviSRoe8T3crWYY4Y6STyaWwAsxEzx5Qwn5hRrUD6d2Vtv8rYRgqOwfP15JgcjDDbRLPzR9oB0OTczTW6cVbLRY0a5kxeLKyXSVzrd/GK75bx3wKBYxARSAnXdLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ev2iYEB1n70aOKIs61spi837s/X3vCjo69krzBUCQqs=;
 b=aVhorlLdrUjs5/ZEx6pdLcPXrP45oug2q6VVnTudy2age7ww3NB9KNCVLG7VjE4tgsjiHtsgCzQTKhDrPUmW+y5mDI+GgUPfN/Zw2imYhvFTYstnP7GkKMD5oJc/W2V3VCvHZ1zEWy90oUcYDkrCPiSl1Sm1t0ZBU6+hfUNhzyV0QD7TnY8e6OAlIEoAd6Uosf2YIYce7LOapcXVaV/6mACZtm0dcgbva/SmyNQAPDRkbq+2EoTakr7ryU2ByD31O5o9K4QjpnYL8G9Rstr16vIEwDD56Yn03aQhaSQN93COisHGqejF2pvL0urQdWFWc+NlAIfsFhRZofzv6ZFUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev2iYEB1n70aOKIs61spi837s/X3vCjo69krzBUCQqs=;
 b=Mgi9cvWFV8PqI++3DJWgNfU++eToKUZmL1pWgJ3yazDy68ZcuNgxEuprk8/7VPJQ3xYsQgfXbs4O9beWOaNJ04+ATK1D7NkGiXo4tZP1XJdun2BBxyJyK7NjmliI2G3EYDUhoL6bUNFYh9hoC7AyEx6BOwFWyZBPT7Vf/Bdmm0M=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 19:00:20 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 19:00:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] nfsd: back channel stuck in
 SEQ4_STATUS_CB_PATH_DOWN
Thread-Topic: [PATCH v3 3/3] nfsd: back channel stuck in
 SEQ4_STATUS_CB_PATH_DOWN
Thread-Index: AQHXqyfKhuo61dig2EChssFVEZ7BIaunA+AA
Date:   Thu, 16 Sep 2021 19:00:20 +0000
Message-ID: <8EB546E2-124E-4FB5-B72B-15E0CB66798F@oracle.com>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-4-dai.ngo@oracle.com>
In-Reply-To: <20210916182212.81608-4-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b98e3cd3-a55c-4d0a-a801-08d979443b2f
x-ms-traffictypediagnostic: SJ0PR10MB5647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB56478455A8DD9C49B8E7E55E93DC9@SJ0PR10MB5647.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mY3NWAfnqtgXwKOc/XjFf63ZGqYuOys/MrU863TEHEM2IqENgYYIS5GfKx7L5d+j/PHQ+4JDKX4goPtfb52RkBJDxUAHaYsJrEtu3ltvM2+PWHvelmeJvtprg2BWTFlDUCfQPE3GAGzFbVKr2fImJMlh7/Dln5h6H9kLhWpA9Anw0JO+GiMCazBspLYCOC0ZJZV4Xj0YilrD9f57EGwzFtx4NEOga0LETQl/vWC5lKsNQR0mENn2b5eiXc64Jh/i9NorpsuOpwpP2H6mFhe7r/OEmUjx4gng8cDmSORrHqaIIRN+a3Ug6YcqFX560nyL9WZLyEH8WtOEWwYo0GhiB1B1op/AF9ZmHTLi08+TfaBtGhfcxh5FLPwUfWRlawPCZUqBJARIHHxeiEQ08pMdCsCugZgtfeovzKdD45KieerJ8e3/34bEjz5AUT94k38+FJ1vYkXUdzJQxJPC4MsPupDfaDb8U7gPbJiw+nSA2JDsMth1YCnpu+4y62nQWk4KmUlRfuJ4sja7OWeC+SoQRy/g5TfZVrBcwV5Y+MsJV46ROaOhbK2dmCL5XWF5+rgDXm23ec+JSRGyc2fRbGt1cXXBzxW/LcMiUkqugAo/sXv5iKDXnnzCohmpfZWD7KGv2ie1tIO3VMtCJxni+JZCkfR+iF7oN+PlFAaat8XC2srZgJEL7CkhcCZoDwYDOi+a3p17CSvatkRBBeB6RSkAhZU6Q64YTwaCUyQzc8E/eQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(2616005)(316002)(76116006)(91956017)(2906002)(66946007)(83380400001)(66476007)(66556008)(64756008)(66446008)(86362001)(33656002)(38070700005)(6486002)(186003)(8936002)(4326008)(5660300002)(38100700002)(6512007)(122000001)(54906003)(110136005)(26005)(71200400001)(36756003)(6506007)(53546011)(8676002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/jSaHzuMSakfYnZ8OhYLQknTTnGqxsabT9WMlT0jczjXG7oskL1FXLeWhqSI?=
 =?us-ascii?Q?Q8SO8RVQSqqBBaN8pka77XnpB20HzlxSXdXbhFUf+Umox7EiOd+gB47KcYb7?=
 =?us-ascii?Q?ngrgOqQ+OwNKtFaY/cFhDDFdkmaDnw64YQhSDqorpIvERczSQT1pjELtHV+/?=
 =?us-ascii?Q?bskmbfrTpAoQK8xfKVwVNxIP3UChRQb9VRgFFQ8rvRE03+2mFGmvn++XZyuF?=
 =?us-ascii?Q?szJkNoXqwmmshdTQRfXk0b/IKSiafbykvVxQIiHxp+Uoh2KiNaEfIIe/HElH?=
 =?us-ascii?Q?0KutCMoZt6wGcJu9GWu+5UyuCXkS1SHkOKw2S89nEhTgIGWC9gPmM8t/WRa2?=
 =?us-ascii?Q?/hYRnaOf8qsiG9ZqvfKCTfZMEVKgv64RpGkF6Dt8PqRyZCWdzythV9sYCKw6?=
 =?us-ascii?Q?fOtLVDM26U9KnsRiUuqc0GIFphuG24hS/ZljIn62Behlw9+9JFSFxYWkgzK7?=
 =?us-ascii?Q?j9XGUR9VEQPNXTKhMm2/4S1j0FsyQ/EtVoieaHr1AX5qICZ3cFPGFKWGrZ72?=
 =?us-ascii?Q?PLQc5baBs67UjRPGH3XyjlgCUzplolmTu/YKwTTnWaA+cTaYcsLBUJyvBcBE?=
 =?us-ascii?Q?KIoolh7acScgD9+EiQnCCUQSom8ZjehcS32VGGEQyjeep8L7JmgKKDEqb9DV?=
 =?us-ascii?Q?7U02eyuVVE91rPCDlkFjbbzOKOL+daI08PlxHU9qvYvC4Jt2FF50wXftpN3o?=
 =?us-ascii?Q?D3HUFDwirngQCjCf8zrevUfnJa/tTgK9VonBXXtz8E/aD03PiFlh4WaO3XoI?=
 =?us-ascii?Q?mw4St8R9bCbLrB+HI4TbaECrEe4vM8RT1ElJVoOM/WT95Giu6zA7JAxUGayW?=
 =?us-ascii?Q?FbndPVAHJSbcE1bOxXYcI/HEqo5nyVvg+8kC/d6ZDwziXzF0jjc/D3q9uNoe?=
 =?us-ascii?Q?gX09LBMs3i+T/pzHVsD1imwnITtogiUJGWZhzAYZuY2ObDGXi/az+CHlY4kp?=
 =?us-ascii?Q?jxuUQpsjfWwrXD3fFGGFXguPSkGaZS12HkWdvliAuk+jUEsSwymPkUdbivGr?=
 =?us-ascii?Q?JMGQMP3SHo/2zOiMO66XSdrdTkg8VajejBLynx8EP0k0FehaxU6rhrCIXcE5?=
 =?us-ascii?Q?LWmG2RgKq7OUlHrxS3KE3S3ftrLx/7YFFfTSkTiWC9KtDoZ3sRSyMGlch/WL?=
 =?us-ascii?Q?2wrzNCLbisrekYE6Nze/dyGESGAgOwSuFbtl9FiaFvpIpH83hYARSwVWev7f?=
 =?us-ascii?Q?hLt1sB9X5RjPxFqjiKW8NWAMUtxoMbiu+N84Bbn70JJRD7U+iqG+oZHhZJ9A?=
 =?us-ascii?Q?QsU6PFSXxslS2ATKHgHk4WNRmHyWKWO+izQjEES5WJt8TMiHMloAu3zbd1a+?=
 =?us-ascii?Q?dLnHLvt9N2Pze6MhGjBX8kjM?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3DDAEA38118F34CB21D3F64F0EE3D4D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98e3cd3-a55c-4d0a-a801-08d979443b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 19:00:20.6455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JR20s7lNlt5DdbPPjaIidJq8ByJOgtn1Tj9KwZ5q9ZolaV5rScotrhNTmwTgdwYbaxruFoH1DoBNF1smH0mKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160109
X-Proofpoint-GUID: KULxme1hbVgZ16iDYwSF3Sy09s7o3THd
X-Proofpoint-ORIG-GUID: KULxme1hbVgZ16iDYwSF3Sy09s7o3THd
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bruce, Dai -

> On Sep 16, 2021, at 2:22 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> When the back channel enters SEQ4_STATUS_CB_PATH_DOWN state, the client
> recovers by sending BIND_CONN_TO_SESSION but the server fails to recover
> the back channel and leaves it as NFSD4_CB_DOWN.
>=20
> Fix by enhancing nfsd4_bind_conn_to_session to probe the back channel
> by calling nfsd4_probe_callback.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

I'm wondering if this one is appropriate to pull into v5.15-rc.


> ---
> fs/nfsd/nfs4state.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 54e5317f00f1..63b4d0e6fc29 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3580,7 +3580,7 @@ static struct nfsd4_conn *__nfsd4_find_conn(struct =
svc_xprt *xpt, struct nfsd4_s
> }
>=20
> static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
> -				struct nfsd4_session *session, u32 req)
> +		struct nfsd4_session *session, u32 req, struct nfsd4_conn **conn)
> {
> 	struct nfs4_client *clp =3D session->se_client;
> 	struct svc_xprt *xpt =3D rqst->rq_xprt;
> @@ -3603,6 +3603,8 @@ static __be32 nfsd4_match_existing_connection(struc=
t svc_rqst *rqst,
> 	else
> 		status =3D nfserr_inval;
> 	spin_unlock(&clp->cl_lock);
> +	if (status =3D=3D nfs_ok && conn)
> +		*conn =3D c;
> 	return status;
> }
>=20
> @@ -3627,8 +3629,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst =
*rqstp,
> 	status =3D nfserr_wrong_cred;
> 	if (!nfsd4_mach_creds_match(session->se_client, rqstp))
> 		goto out;
> -	status =3D nfsd4_match_existing_connection(rqstp, session, bcts->dir);
> -	if (status =3D=3D nfs_ok || status =3D=3D nfserr_inval)
> +	status =3D nfsd4_match_existing_connection(rqstp, session,
> +			bcts->dir, &conn);
> +	if (status =3D=3D nfs_ok) {
> +		if (bcts->dir =3D=3D NFS4_CDFC4_FORE_OR_BOTH ||
> +				bcts->dir =3D=3D NFS4_CDFC4_BACK)
> +			conn->cn_flags |=3D NFS4_CDFC4_BACK;
> +		nfsd4_probe_callback(session->se_client);
> +		goto out;
> +	}
> +	if (status =3D=3D nfserr_inval)
> 		goto out;
> 	status =3D nfsd4_map_bcts_dir(&bcts->dir);
> 	if (status)
> --=20
> 2.9.5
>=20

--
Chuck Lever



