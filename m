Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8C48A389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiAJXR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 18:17:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233112AbiAJXRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:17:25 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlisx007280;
        Mon, 10 Jan 2022 23:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vUYeNXXw9KH6nhgRwLh/d6J3s0yHbYghY9Tip0bTCmQ=;
 b=czhNuyEgM25foCi8q2zhLhUm+sDX2FCV+wPCzm653aJP7vm8pR+Bq9ADFypCMN3GY9o5
 Sah/MnQmPHKo7SpyXhM9rsDvf5Aiob+icCXOzul4zE49z/CiBil9ChuPYETfWHGvGj35
 zvnpRTF2L825A8Sm/ViTrEtajM5j9TVAn3nzpmVlQGshVaRnVyD4Sywl1/QtnBJDCzF4
 25ffqaah+NwCWIWQfAspGYzDbnM5lhDfLIB56r2IltO0342yXUsM+kgEL/b9aUin00bP
 1PktjDq3XxQe2uwhXX9vsYDyfd47C22E125QXSRzpcWGrLznd5HNtkFTMs6/JBAzNLz8 Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx1qxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:17:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ANGLVT082391;
        Mon, 10 Jan 2022 23:17:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by userp3030.oracle.com with ESMTP id 3deyqw5ged-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:17:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Docrkcvz54XoZ4HoApPpfUrHrgWLThqAOStW0AkXHL9AHYhFyTAE9Dr+8WBxhEHddf7W0kZZLFs2o6LfQLBmgDpjpnuaXYvpfPGpqYCTuum5RxgKG1oVQu834uSVadIuj89jmXmaaPafiiE7W9kIgKMo4nxJE2XcUnNUzI1b5tNJ7jUdV8WqFiu+NH3dhyYd4TMg58cgLRV7LbzG6K7j8LPkdkiXg6dpypFzIM8M5X69r2KhWFsz73f7gojkHzdK905SeALH9+Zh+3TmwlU++sMMGQssh4Qlwu3K9+maQeVVNgirwQaA8nuPWD+cGDSxiY5FYva3DQXjGzo9cZgLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUYeNXXw9KH6nhgRwLh/d6J3s0yHbYghY9Tip0bTCmQ=;
 b=HFtl6P5vwGa30vXRO6ZTt2uoRPEew839PLDgbV+ZZXuM942Eu9RPEehoZIov1lALbzQVBtyPHIV/vXVQUYqbLv7RghEVFY7SDy7pMWAZK4rf9rAmi8+u+LCjKBmUD9cauOe/YBohYKFzcrYhmkPTqSJcTi7gRAH1kEcnlMeoEE//LJWtLyWAPI7lDTzWboS/qF7vmeicuCukacxakClbanqDTxwpRySFydqW9E5y7x4Mvgi7CiqG4YjlbmD9fS6mNXtJ/8ireQww+i98C73AjR+kNQdMSczdUgNqN5yQQDHr8PflGCJCpAmPZWGrugHAU4zVVzHOllGwalJytBK1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUYeNXXw9KH6nhgRwLh/d6J3s0yHbYghY9Tip0bTCmQ=;
 b=z/Rl6IEsDFw2uU9k7yl25+nfh33zKISPo0L2lyMpCs9E3yxPVss1QY5Mpb2xNfeS6QxKUGt4k9b08J+EwipgYVw5HrE6ShxiLtfrWe3dDtiFUehY+DSnswA5gZgtjT1uXws/zgwlqlCJ+QUk0rtI+laUaHUwMLi1Tgym8hbyrII=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 23:17:19 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 23:17:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYBlMLWE0hIl6tZ0+2dAxrVOaXK6xc48YA
Date:   Mon, 10 Jan 2022 23:17:19 +0000
Message-ID: <E70D7FE7-59BA-4200-BF31-B346956C9880@oracle.com>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f60af6f-287f-488d-309d-08d9d48f596c
x-ms-traffictypediagnostic: CH0PR10MB4858:EE_
x-microsoft-antispam-prvs: <CH0PR10MB485837280F3D4F8C5773DB5A93509@CH0PR10MB4858.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WnEiWsjCrQzQKyza6RgrC9RRlTpzPXoujKSkqrY558irzyzm0ssH/Mt2EmhwwE82tVCqOCmucVM5QPflQe3GB8l9MieJXrafILj16J1FpdJ+lXCyZ2Xk+HDqFLq1kshOUtLrwxA6d6725HF01/y3KMTBhBCeLzVJfCZoy0itmLoAeN82tIcSWYrSpQeAM7Hq+QS+6WzUIaFw4SngEQurxmItAk+H9CGaOBITDuju4fiTb/WRMtG6xC/hjWdIN4MlI+QTw0s0hDaoqWPNmQTmV6f/V2IIHKi4Fp8X6MEJke3p81OCMl49fMHCC4NjJBBRXEA8Oz30X59J9MOJBYQ3OPQSBE4ZOv3ehS9mgJVMQc7NvcO2EeMJAxFfSZqFw4T8S2X3m0ScZw/DUpMSzAvLN2Ypa4e8nAWadN2PTD9jUr/PvaTDJ3EE1ETSRCsF1ZcUtxSCH8jTJdh2qWv6qNo2mxCbAdEYV/94VZZLvxkh9BvqdBzg/gwSBBGi2BBd7pU7pZdZYk1o8A2/uICJ/zUQKsgLJgopT3im3TGFI2kfwaUFEcPFh9V9pl8HggBpC7mUAHSldj9D+dq3j8ETDj7galGaMt+F4uedNWYBWmr29IhqiL7uTzcgZqAb58/NWO0jz/igzVpuO9m24NDMcv3iIcYBpqBVMBJoorloeGe+j4tMBu/z8V7T6Bavg4zVWJk4HjMIePWxCBpCgAoyhI+e7+CoHnLu+P4aPXL60er4/M4/E9STA30EBMbjZFMRPvf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(26005)(2616005)(508600001)(76116006)(66946007)(53546011)(54906003)(37006003)(2906002)(83380400001)(8676002)(4326008)(186003)(64756008)(6636002)(30864003)(86362001)(66556008)(66446008)(66476007)(5660300002)(316002)(71200400001)(38100700002)(38070700005)(122000001)(6862004)(6512007)(36756003)(6506007)(6486002)(33656002)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/MJizFnASE8Ovn8ldtI/Rzxq2k7NESZg96P/45wAO0n465roe1MDOdmkugJW?=
 =?us-ascii?Q?ODrp4wFfU6/qvcvFl00FCwWHbVqYLwFeFDCSJB0kLzDRXHbrxw+6A6Myr/XV?=
 =?us-ascii?Q?ekboKOZvgbMebIQSb2dP62qKuJ8f766ZDODvJBhV1GI0/uS0cu9up3FoFswZ?=
 =?us-ascii?Q?GOA4+i5E6k5Axqj+dG/vICrETuTXkZlW07MVLcH7ZIAqDAWkUImlrfDHnogJ?=
 =?us-ascii?Q?Xw0Ik4e02CzzhwyxBow4DddMP2bO328KPriRqL4+ZuJF8rS8OoNN+S1+xDjT?=
 =?us-ascii?Q?dk943qBHc1MhU2TI0+agy8dJT2GBb2Lo+a4fyVqL7ui5u9H+iozZfWE4pndM?=
 =?us-ascii?Q?iqEJ/J+Ufzxb9khQWEClIWW96FwmEGQVEF2sZGR9gJcoHdQrrMnev2sYPFZU?=
 =?us-ascii?Q?H4B9iTRXwjSUYqXtqY1BdsyBdRJzRDKUqRMtPGkglC+ywz6kmOU3ddYqY80f?=
 =?us-ascii?Q?DdsmmfLMvN1pHG6wmgyN97V32bSmMvVyyNfaDRmyAn2uS++ZPJRey+GVCACh?=
 =?us-ascii?Q?EDEIRL1SyYBaPV9dxlYFNlUTzhmoq1c7oP+XgGlANCZhyiTOxcdYb9raUe0z?=
 =?us-ascii?Q?EO5QbxDLocKC2chhYApjOiexkFG9ZTOjo0obH2XwTEf2Go69RrkkTvfLaDNN?=
 =?us-ascii?Q?y4B1DOBT4qnU5brEDmV5Z9aGKZ/mHIM7/5g/xC4Xby+LjY4FbfIy/B1CluyY?=
 =?us-ascii?Q?HO45m3AdgKkK70oS/Ej+6Fb5N+R0AlJk4UAOEOsmyW1dqASniBvMqgmsqN7/?=
 =?us-ascii?Q?qqX+hQSUU1+Jgh6CD5IrqhkjcEBOGFQ8hdv2B73rEYq7VVRUVKsH1pG19TOQ?=
 =?us-ascii?Q?LmSrrn/HbMzYPbG+r9FWk7pXJLSdqFeArYJnitxTVVrPto+oIFB9+PY/EqWo?=
 =?us-ascii?Q?G9ymaKIs5BN9sIOPwM5xMRLLOX49z585fNu2i6NGC7WQQdWplzfi85y0vfpp?=
 =?us-ascii?Q?GxXPHPxEM3yszuM+UFa5uAHJxAx5NVxNRZ2bLtYA2UfVcrHRVRVrzductMwI?=
 =?us-ascii?Q?Q0NF7nUV08QPCxd5BE68GhFu2uHAyW0z6XO/6dNnAjfDsvmKJvWXB9dMDeJi?=
 =?us-ascii?Q?XwZEeutEcehFa5EurpiHbR4l+MfkkSRdG9jcP+dnMdhyZWhjUmge3AWAIL9Q?=
 =?us-ascii?Q?wlT5uy7pwVw3aMvxcPLM0hHgeRAhDl1qSkTjpEdso3fglFYfMdTFg8+PzHnV?=
 =?us-ascii?Q?Tiab4RZgVSP7MSAXH49A65zBfVkEzvjQ5yjqyeOdG0BBNHbBbhjUFuoZLkVa?=
 =?us-ascii?Q?mK2T5ScUHti9k4FNKHuBzrH5WqbQYddDmQTBluO4ot9r8dGpjxNUNEI9y3NM?=
 =?us-ascii?Q?3wmpJKry0p+kY15v99Zo7q3f9Vy4fyLDO0rzUvzqaJDlJPK/7Ha4VLt7VEhn?=
 =?us-ascii?Q?O6yaAHmsrmXUyHk6VWs1jsY/XeTaE9SEFBI6ZRbVn3ufu+kzDy+hc4OGvjpD?=
 =?us-ascii?Q?4ett7LP91XdmSRSpRqCLzRirRzUuC+GQnw0exTNh03RZ3spktv9A9IKWXtk/?=
 =?us-ascii?Q?pfCDuPb+aB9xR0ADhF+okEkzzqjMX8D5KRt3Ys43L3XRKZ/PcxvUtHwFLU0Y?=
 =?us-ascii?Q?iWei+AL1DXU4bnzTeJhWKmmEtxo1DZPgrHFLfX1BRakvZEvL+4Y3vrgnA3hK?=
 =?us-ascii?Q?PIzfnbra+nwmTDhMH307pGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F17573334BB5F44794C7926F3C3279F1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f60af6f-287f-488d-309d-08d9d48f596c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 23:17:19.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UZAKTlbzGEnRVt0YT3OB5mUgNROayHJu3fy3POSQpjQfCivR281KZM010i1ALNJDVpFQX2zoGgJFeteeajULQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100149
X-Proofpoint-GUID: 8ULWqz7umESwDPELq0MNXlLMpBG7o0z8
X-Proofpoint-ORIG-GUID: 8ULWqz7umESwDPELq0MNXlLMpBG7o0z8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dai-

Still getting the feel of the new approach, but I have
made some comments inline...


> On Jan 10, 2022, at 1:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently an NFSv4 client must maintain its lease by using the at least
> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
> a singleton SEQUENCE (4.1) at least once during each lease period. If the
> client fails to renew the lease, for any reason, the Linux server expunge=
s
> the state tokens immediately upon detection of the "failure to renew the
> lease" condition and begins returning NFS4ERR_EXPIRED if the client shoul=
d
> reconnect and attempt to use the (now) expired state.
>=20
> The default lease period for the Linux server is 90 seconds.  The typical
> client cuts that in half and will issue a lease renewing operation every
> 45 seconds. The 90 second lease period is very short considering the
> potential for moderately long term network partitions.  A network partiti=
on
> refers to any loss of network connectivity between the NFS client and the
> NFS server, regardless of its root cause.  This includes NIC failures, NI=
C
> driver bugs, network misconfigurations & administrative errors, routers &
> switches crashing and/or having software updates applied, even down to
> cables being physically pulled.  In most cases, these network failures ar=
e
> transient, although the duration is unknown.
>=20
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recogniz=
e
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server
> reboots.
>=20
> The initial implementation of the Courteous Server will do the following:
>=20
> . when the laundromat thread detects an expired client and if that client
> still has established states on the Linux server and there is no waiters
> for the client's locks then mark the client as a COURTESY_CLIENT and skip
> destroying the client and all its states, otherwise destroy the client as
> usual.
>=20
> . detects conflict of OPEN request with COURTESY_CLIENT, destroys the
> expired client and all its states, skips the delegation recall then allow=
s
> the conflicting request to succeed.
>=20
> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
> requests with COURTESY_CLIENT, destroys the expired client and all its
> states then allows the conflicting request to succeed.
>=20
> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
> requests with COURTESY_CLIENT, destroys the expired client and all its
> states then allows the conflicting request to succeed.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 323 +++++++++++++++++++++++++++++++++++++++++++++++=
+++--
> fs/nfsd/state.h     |   8 ++
> 2 files changed, 323 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3f4027a5de88..e7fa4da44835 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -125,6 +125,11 @@ static void free_session(struct nfsd4_session *);
> static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>=20
> +static struct workqueue_struct *laundry_wq;
> +static void laundromat_main(struct work_struct *);
> +
> +static const int courtesy_client_expiry =3D (24 * 60 * 60);	/* in secs *=
/
> +
> static bool is_session_dead(struct nfsd4_session *ses)
> {
> 	return ses->se_flags & NFS4_SESSION_DEAD;
> @@ -155,8 +160,10 @@ static __be32 get_client_locked(struct nfs4_client *=
clp)
> 	return nfs_ok;
> }
>=20
> -/* must be called under the client_lock */
> +/* must be called under the client_lock
> static inline void
> +*/
> +void
> renew_client_locked(struct nfs4_client *clp)
> {
> 	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> @@ -172,7 +179,9 @@ renew_client_locked(struct nfs4_client *clp)
>=20
> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
> 	clp->cl_time =3D ktime_get_boottime_seconds();
> +	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> }
> +EXPORT_SYMBOL_GPL(renew_client_locked);

I don't see renew_client_locked() being called from outside
fs/nfsd/nfs4state.c, and the patch doesn't add a global
declaration.

Please leave this function as "static inline void".


> static void put_client_renew_locked(struct nfs4_client *clp)
> {
> @@ -1912,10 +1921,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *=
sessionid, struct net *net,
> {
> 	struct nfsd4_session *session;
> 	__be32 status =3D nfserr_badsession;
> +	struct nfs4_client *clp;
>=20
> 	session =3D __find_in_sessionid_hashtbl(sessionid, net);
> 	if (!session)
> 		goto out;
> +	clp =3D session->se_client;
> +	if (clp) {
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			session =3D NULL;
> +			goto out;
> +		}
> +		clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +		spin_unlock(&clp->cl_cs_lock);
> +	}
> 	status =3D nfsd4_get_session_locked(session);
> 	if (status)
> 		session =3D NULL;
> @@ -1992,6 +2013,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name)
> 	INIT_LIST_HEAD(&clp->async_copies);
> 	spin_lock_init(&clp->async_lock);
> 	spin_lock_init(&clp->cl_lock);
> +	spin_lock_init(&clp->cl_cs_lock);
> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
> 	return clp;
> err_no_hashtbl:
> @@ -2389,6 +2411,10 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> 		seq_puts(m, "status: confirmed\n");
> 	else
> 		seq_puts(m, "status: unconfirmed\n");
> +	seq_printf(m, "courtesy client: %s\n",
> +		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
> +	seq_printf(m, "seconds from last renew: %lld\n",
> +		ktime_get_boottime_seconds() - clp->cl_time);
> 	seq_printf(m, "name: ");
> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> @@ -2809,8 +2835,17 @@ find_clp_in_name_tree(struct xdr_netobj *name, str=
uct rb_root *root)
> 			node =3D node->rb_left;
> 		else if (cmp < 0)
> 			node =3D node->rb_right;
> -		else
> -			return clp;
> +		else {
> +			spin_lock(&clp->cl_cs_lock);
> +			if (!test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
> +					&clp->cl_flags)) {
> +				clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +				spin_unlock(&clp->cl_cs_lock);
> +				return clp;
> +			}
> +			spin_unlock(&clp->cl_cs_lock);
> +			return NULL;
> +		}
> 	}
> 	return NULL;
> }
> @@ -2856,6 +2891,14 @@ find_client_in_id_table(struct list_head *tbl, cli=
entid_t *clid, bool sessions)
> 		if (same_clid(&clp->cl_clientid, clid)) {
> 			if ((bool)clp->cl_minorversion !=3D sessions)
> 				return NULL;
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
> +					&clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				continue;
> +			}
> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			spin_unlock(&clp->cl_cs_lock);

I'm wondering about the transition from COURTESY to active.
Does that need to be synchronous with the client tracking
database?


> 			renew_client_locked(clp);
> 			return clp;
> 		}
> @@ -4662,6 +4705,36 @@ static void nfsd_break_one_deleg(struct nfs4_deleg=
ation *dp)
> 	nfsd4_run_cb(&dp->dl_recall);
> }
>=20
> +/*
> + * This function is called when a file is opened and there is a
> + * delegation conflict with another client. If the other client
> + * is a courtesy client then kick start the laundromat to destroy
> + * it.
> + */
> +static bool
> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
> +{
> +	struct svc_rqst *rqst;
> +	struct nfs4_client *clp =3D dp->dl_recall.cb_clp;
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> +
> +	if (!i_am_nfsd())
> +		goto out;
> +	rqst =3D kthread_data(current);
> +	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> +		return false;
> +out:
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> +		spin_unlock(&clp->cl_cs_lock);
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);

I'm not sure what is the purpose of the mod_delayed_work()
here and below. What's the harm in leaving a DESTROYED
nfs4_client around until the laundromat runs again? Won't
it run every "grace period" seconds anyway?

I didn't think we were depending on the laundromat to
resolve edge case races, so if a call to a scheduler
function isn't totally necessary in this code, I prefer
that it be left out.


> +		return true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +	return false;
> +}
> +
> /* Called from break_lease() with i_lock held. */
> static bool
> nfsd_break_deleg_cb(struct file_lock *fl)
> @@ -4670,6 +4743,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	struct nfs4_delegation *dp =3D (struct nfs4_delegation *)fl->fl_owner;
> 	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
>=20
> +	if (nfsd_check_courtesy_client(dp))
> +		return false;
> 	trace_nfsd_cb_recall(&dp->dl_stid);
>=20
> 	/*
> @@ -4912,7 +4987,128 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc=
_fh *fh,
> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> }
>=20
> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file=
 *fp,
> +static bool
> +__nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> +			bool share_access)
> +{
> +	if (share_access) {
> +		if (!stp->st_deny_bmap)
> +			return false;
> +
> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> +			(access & NFS4_SHARE_ACCESS_READ &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
> +			(access & NFS4_SHARE_ACCESS_WRITE &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
> +			return true;
> +		}
> +		return false;
> +	}
> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> +		(access & NFS4_SHARE_DENY_READ &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> +		(access & NFS4_SHARE_DENY_WRITE &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * Check all files belong to the specified client to determine if there =
is
> + * any conflict with the specified access_mode/deny_mode of the file 'fp=
.
> + *
> + * If share_access is true then 'access' is the access mode. Check if
> + * this access mode conflicts with current deny mode of the file.
> + *
> + * If share_access is false then 'access' the deny mode. Check if
> + * this deny mode conflicts with current access mode of the file.
> + */
> +static bool
> +nfs4_check_access_deny_bmap(struct nfs4_client *clp, struct nfs4_file *f=
p,
> +		struct nfs4_ol_stateid *st, u32 access, bool share_access)
> +{
> +	int i;
> +	struct nfs4_openowner *oo;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_ol_stateid *stp, *stmp;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +					so_strhash) {
> +			if (!so->so_is_open_owner)
> +				continue;
> +			oo =3D openowner(so);
> +			list_for_each_entry_safe(stp, stmp,
> +				&oo->oo_owner.so_stateids, st_perstateowner) {
> +				if (stp =3D=3D st || stp->st_stid.sc_file !=3D fp)
> +					continue;
> +				if (__nfs4_check_access_deny_bmap(stp, access,
> +							share_access)) {
> +					spin_unlock(&clp->cl_lock);
> +					return true;
> +				}
> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> +/*
> + * This function is called to check whether nfserr_share_denied should
> + * be returning to client.
> + *
> + * access: is op_share_access if share_access is true.
> + *	   Check if access mode, op_share_access, would conflict with
> + *	   the current deny mode of the file 'fp'.
> + * access: is op_share_deny if share_access is true.
> + *	   Check if the deny mode, op_share_deny, would conflict with
> + *	   current access of the file 'fp'.
> + * stp:    skip checking this entry.
> + *
> + * Function returns:
> + *	true  - access/deny mode conflict with courtesy client(s).
> + *		Caller to return nfserr_jukebox while client(s) being expired.
> + *	false - access/deny mode conflict with non-courtesy client.
> + *		Caller to return nfserr_share_denied to client.
> + */
> +static bool
> +nfs4_conflict_courtesy_clients(struct svc_rqst *rqstp, struct nfs4_file =
*fp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_client *cl;
> +	bool conflict =3D false;
> +	int async_cnt =3D 0;
> +	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	list_for_each_entry(cl, &nn->client_lru, cl_lru) {
> +		if (!nfs4_check_access_deny_bmap(cl, fp, stp, access, share_access))
> +			continue;
> +		spin_lock(&cl->cl_cs_lock);
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
> +			async_cnt++;

You can get rid of async_cnt. Just set conflict =3D true
after unlocking cl_cs_lock. And again, maybe that
mod_delayed_work() call site isn't necessary.


> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		/* conflict with non-courtesy client */
> +		spin_unlock(&cl->cl_cs_lock);
> +		conflict =3D false;
> +		break;
> +	}
> +	spin_unlock(&nn->client_lock);
> +	if (async_cnt) {
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +		conflict =3D true;
> +	}
> +	return conflict;
> +}
> +
> +static __be32
> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> 		struct nfsd4_open *open)
> {
> @@ -4931,6 +5127,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *r=
qstp, struct nfs4_file *fp,
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status !=3D nfs_ok) {
> 		spin_unlock(&fp->fi_lock);
> +		if (status !=3D nfserr_share_denied)
> +			goto out;
> +		if (nfs4_conflict_courtesy_clients(rqstp, fp,
> +				stp, open->op_share_deny, false))
> +			status =3D nfserr_jukebox;
> 		goto out;
> 	}
>=20
> @@ -4938,6 +5139,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *r=
qstp, struct nfs4_file *fp,
> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
> 	if (status !=3D nfs_ok) {
> 		spin_unlock(&fp->fi_lock);
> +		if (status !=3D nfserr_share_denied)
> +			goto out;
> +		if (nfs4_conflict_courtesy_clients(rqstp, fp,
> +				stp, open->op_share_access, true))
> +			status =3D nfserr_jukebox;
> 		goto out;
> 	}
>=20
> @@ -5572,6 +5778,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_ne=
t *nn)
> }
> #endif
>=20
> +static
> +bool nfs4_anylock_conflict(struct nfs4_client *clp)

This function assumes the caller holds cl_lock. That bears
mentioning here in a comment. Convention suggests adding
"_locked" to the function name too, just like
renew_client_locked() above.

Also, nit: kernel style is either:

static bool
nfs4_anylock_conflict(

or

static bool nfs4_anylock_conflict(


> +{
> +	int i;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +	struct inode *ino;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		/* scan each lock owner */
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +
> +			/* scan lock states of this lock owner */
> +			lo =3D lockowner(so);
> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
> +					st_perstateowner) {
> +				nf =3D stp->st_stid.sc_file;
> +				ino =3D nf->fi_inode;
> +				ctx =3D ino->i_flctx;
> +				if (!ctx)
> +					continue;
> +				/* check each lock belongs to this lock state */
> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +					if (fl->fl_owner !=3D lo)
> +						continue;
> +					if (!list_empty(&fl->fl_blocked_requests))
> +						return true;
> +				}
> +			}
> +		}
> +	}
> +	return false;
> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> @@ -5587,7 +5834,9 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	};
> 	struct nfs4_cpntf_state *cps;
> 	copy_stateid_t *cps_t;
> +	struct nfs4_stid *stid;
> 	int i;
> +	int id;
>=20
> 	if (clients_still_reclaiming(nn)) {
> 		lt.new_timeo =3D 0;
> @@ -5608,8 +5857,41 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		if (!state_expired(&lt, clp->cl_time))
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
> +			goto exp_client;
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			if (ktime_get_boottime_seconds() >=3D clp->courtesy_client_expiry)
> +				goto exp_client;
> +			/*
> +			 * after umount, v4.0 client is still around
> +			 * waiting to be expired. Check again and if
> +			 * it has no state then expire it.
> +			 */
> +			if (clp->cl_minorversion) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				continue;
> +			}
> +		}
> +		if (!state_expired(&lt, clp->cl_time)) {

Now that clients go from active -> COURTEOUS -> DESTROY,
why is this check still necessary? If it truly is, a brief
explanation/comment would help.


> +			spin_unlock(&clp->cl_cs_lock);
> 			break;
> +		}
> +		id =3D 0;
> +		spin_lock(&clp->cl_lock);
> +		stid =3D idr_get_next(&clp->cl_stateids, &id);
> +		if (stid && !nfs4_anylock_conflict(clp)) {
> +			/* client still has states */
> +			spin_unlock(&clp->cl_lock);
> +			clp->courtesy_client_expiry =3D
> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_lock);
> +exp_client:
> +		spin_unlock(&clp->cl_cs_lock);
> 		if (mark_client_expired_locked(clp))
> 			continue;
> 		list_add(&clp->cl_lru, &reaplist);
> @@ -5689,9 +5971,6 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> }
>=20
> -static struct workqueue_struct *laundry_wq;
> -static void laundromat_main(struct work_struct *);
> -

If the new mod_delayed_work() call sites aren't necessary,
then these static definitions can be left here.


> static void
> laundromat_main(struct work_struct *laundry)
> {
> @@ -6496,6 +6775,33 @@ nfs4_transform_lock_offset(struct file_lock *lock)
> 		lock->fl_end =3D OFFSET_MAX;
> }
>=20
> +/*
> + * Return true if lock can be resolved by expiring
> + * courtesy client else return false.
> + */

Since this function is invoked from outside of nfs4state.c,
please turn the above comment into a kerneldoc comment, eg:

/**
 * nfsd4_fl_expire_lock - check if lock conflict can be resolved
 * @fl: pointer to file_lock with a potential conflict
 *
 * Return values:
 *   %true: No conflict exists
 *   %false: Lock conflict can't be resolved
 */


> +static bool
> +nfsd4_fl_expire_lock(struct file_lock *fl)
> +{
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_client *clp;
> +	struct nfsd_net *nn;
> +
> +	if (!fl)
> +		return false;
> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
> +	clp =3D lo->lo_owner.so_client;
> +	spin_lock(&clp->cl_cs_lock);
> +	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +		spin_unlock(&clp->cl_cs_lock);
> +		return false;
> +	}
> +	nn =3D net_generic(clp->net, nfsd_net_id);

Why is "nn =3D" inside the cl_cs_lock critical section here?
I don't think that lock protects clp->net. Also, if the
mod_delayed_work() call isn't needed here, then @nn can
be removed too.


> +	set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> +	spin_unlock(&clp->cl_cs_lock);
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	return true;
> +}
> +
> static fl_owner_t
> nfsd4_fl_get_owner(fl_owner_t owner)
> {
> @@ -6543,6 +6849,7 @@ static const struct lock_manager_operations nfsd_po=
six_mng_ops  =3D {
> 	.lm_notify =3D nfsd4_lm_notify,
> 	.lm_get_owner =3D nfsd4_fl_get_owner,
> 	.lm_put_owner =3D nfsd4_fl_put_owner,
> +	.lm_expire_lock =3D nfsd4_fl_expire_lock,

This applies to 1/2... You might choose a less NFSD-specific
name for the new lm_ method, such as lm_lock_conflict. I'm
guessing only NFSD is going to deal with a conflict by
/expiring/ something ...


> };
>=20
> static inline void
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..7f52a79e0743 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,8 @@ struct nfs4_client {
> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> 					 1 << NFSD4_CLIENT_CB_KILL)
> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
> 	unsigned long		cl_flags;
> 	const struct cred	*cl_cb_cred;
> 	struct rpc_clnt		*cl_cb_client;
> @@ -385,6 +387,12 @@ struct nfs4_client {
> 	struct list_head	async_copies;	/* list of async copies */
> 	spinlock_t		async_lock;	/* lock for async copies */
> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> +	int			courtesy_client_expiry;
> +	/*
> +	 * used to synchronize access to NFSD4_COURTESY_CLIENT
> +	 * and NFSD4_DESTROY_COURTESY_CLIENT for race conditions.
> +	 */
> +	spinlock_t		cl_cs_lock;
> };
>=20
> /* struct nfs4_client_reset
> --=20
> 2.9.5
>=20

--
Chuck Lever



