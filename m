Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547B9474EAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 00:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhLNXlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 18:41:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7224 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234368AbhLNXls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:41:48 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEMT7wd022485;
        Tue, 14 Dec 2021 23:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E2EFdrm13qjm9EW4EQSIQUyhCcYwixuyJwiJXAdnw/A=;
 b=f+NOY4XJXULkcH9yrvRXGBb8z+6s9Rn+21z3LrAXkN/atoB34yxJ0LNHDHslr/DaHvmd
 dkCmnJ+CMiHYRNl6XMJ0cD3+8oaPQMod6QO5EP9MtMZvcHIdFhufRLTd3kLyalx6LuZY
 RO4lQro/v4EVCLM03bf8peb+wrf2irP0M4wGmnvHEgcsMDzYl1ZFIPbsAAD8pH+qFu6E
 Pj2LeAMYquA9JhBp9l4a8r+gzD2czhl+pMkZgeCVduGSKxZUbMxA+6US64ThF4K6qiQa
 FWidrflbDGGEHHLL9jNcjmMObiTzh5CGU0jdz29ASwba+/qXna9nDSGz4Y+GcYea0zt3 Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrwemv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 23:41:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BENa0Ej059435;
        Tue, 14 Dec 2021 23:41:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3cvh3y73rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 23:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5n8FyLBLaDSujr27IYhe2+mqaT8Hn9x8SI97ZaPPXnFVi4IWDzWw+h5pUzsWWSANrKwRKlW0xpqhdrXypkKmTXpSFuY3WkLDoiKXxVJoqXUdkSQhVcRiSpeFsfI2TNQQV82olAtT92oF+FZCQPFuUVDgspqsPdXPzh07Nmi5naliKkU5fOQFSvNk+EL1YbS2/xiGsXfXflVkINWa105bI9CKRLpvRwB4GFC+7ox0oEe2Pyzuokf0n7nzLgcdVwwaa6KBJ/VMFqB852en9AHH+9w0yaGmaAnlv7mdDtBzgwxVV3G7aAK3mqmLOYQr1YtLDkIplhY1z0Vs2gYI7t4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2EFdrm13qjm9EW4EQSIQUyhCcYwixuyJwiJXAdnw/A=;
 b=Y9cf2TtXz5efKWu7KLGKJuFq7tYRiLIxm8LTVP/y3arPBIBRXBr/JxNEe+bC65R+JuAjge8inuEzbNA9L+9ixWoaFbyVIwRqoxfLJTPYLWCzp59PCkqWZxaoM67nSlkto17OrkhF9xUWeUMLPh2oUIxLtHCTFIGJKn6aihsvFvM4sgxR3IDdzN8/TNQHlEO6Vo/cUZ0MEloCPQRh8bysQ01H89N7IJO3HxoGOA22K6LWCt//CZ/djvwveC4UYUdkY2/Vk77bZHfWB1YzPQJl75p+SdohsEuMf8ujU2vmvxk46Bq4yJvsGPWwsus7FArSZuZZ0xE5PflmBD1zYZz/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2EFdrm13qjm9EW4EQSIQUyhCcYwixuyJwiJXAdnw/A=;
 b=fCL3gQ5KxfMMDU86r52zCp4IdqV2AXJ9LbKd42INML5pCH4XExuIfQBXigvP7HD1xYultvQTOVvV9xFawCkb969J+CLKqpAf+zStKf0n67TGpE1IPDjX+F54759+iOqFGkmX8vxrUrWPMFNKhm/9trp9qvVGzjO7m3G4Y5pG3Rw=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 23:41:41 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853%8]) with mapi id 15.20.4778.016; Tue, 14 Dec 2021
 23:41:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC:     Bruce Fields <bfields@fieldses.org>, Dai Ngo <dai.ngo@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Topic: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Index: AQHX8EZJmW5yrRSTYU2Fiyvh6ExyIKwyp7wA
Date:   Tue, 14 Dec 2021 23:41:41 +0000
Message-ID: <0C2E5E30-86A3-489E-9366-DC4FF109DD93@oracle.com>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
 <20211213172423.49021-2-dai.ngo@oracle.com>
In-Reply-To: <20211213172423.49021-2-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93bdce2f-cc8a-4c61-3683-08d9bf5b4792
x-ms-traffictypediagnostic: CH0PR10MB5036:EE_
x-microsoft-antispam-prvs: <CH0PR10MB503641AACB4AF321F8995B7193759@CH0PR10MB5036.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LX4UdfgT+FWsZPBKZk7N/SkU61pBxAa3PWeF5rlQLElLf/SZLGSyvQ6v8K6YFr/cVEANmecnPWNlF1XNxsMMzXp4SjqQpiJ/tGa4t+aNHVfhAlkp4ul8HU2KaQNXrziRIoirPKsvTWAUPGYcizC6s2Kjs3eQQ/ZY7r7FYkf9eLxW7wU/qzNeHAH6vdwe0iSXKZIstmUGI0ludhezDBCLBHHZFqSrlbKaTsSGGp936HzwljSlWJzt4YnrXQa/PhqXYyZfveXtnLYofXk/CJIkzrtK7YBIXucP1ZYBQXiBKdn+qnrqq7RfNE02FYYq5WsioysJZ5ZTalShZSeOS+UzZnuY14rsRSpCyl5XskWitUQ4Dl3lv7gV1sfA/jKqO6k2PUbSygb9sbr6oKRmy/hypd72gUN6u2/kWSROfgK3Q4d32pYoADye7evw9A+CAjJ4NqoLcWvXRdA8pjP0EpkJaPhtHpYdsRHZW0m6ufbHFMgBEg+XK7of577XnvZePuF5fFmBpFEfWA4q9J7Cm2QuqnJXVaOBjo8qSd70wlzU9sFq2XwV/oYASwAeSBKJom8eFgGa0WK6dkUtEAMVzcvZfNwAGO5GmRLYnS7r0gdFp9AHMeFg2dmyj7Z2LGjywwnYvwn20SYijkoXQYWhEvDmp4TodBg9JtpyICE073qHgY5PzW1PvTy2yJh2lw0R/ge1x6HS2IXQmfkjbbAxHe6An7nuRSUNc3BSj4lERyDDVCeFx4XykzZcLIRjL7zMZPKp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(2906002)(66556008)(86362001)(66476007)(38070700005)(4326008)(66946007)(8676002)(36756003)(8936002)(54906003)(64756008)(316002)(5660300002)(508600001)(66446008)(83380400001)(71200400001)(33656002)(53546011)(6486002)(38100700002)(186003)(26005)(122000001)(2616005)(6512007)(76116006)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T4+VXogCLkZqq2PlasSXoovPeFbsza4UhlA6JOaHEaMZc0YJpLvOAXMOYt69?=
 =?us-ascii?Q?hxrrFjlHCFW0L1vDgd/oeijnG+s58q3Rxim0z/3nLIv8fgRNXvjKCK5kwJQA?=
 =?us-ascii?Q?JVqYe0LaWiH9EnTWeakCFbhgBIZZ/Ekj+vzEibY69mmWVCrMRY6NR7a45L/V?=
 =?us-ascii?Q?CBhUSwNevhEVZPTHL+kExOnfH9awKuNF7Ehv5NeuTEtii24jr6iHIEqicxSD?=
 =?us-ascii?Q?56GozPnJfkj0WYAVaHE54tQM1rZ1E2gqv1GIRFkemeAIUpSuVtQAQwIDhaPj?=
 =?us-ascii?Q?O7GrD1Lc+AmC7z+RPfoKwQk0NTwO1F9mPgMwirSAcP4YxZW9PkpI+VDFvJGO?=
 =?us-ascii?Q?f0Lr2qxQL77aKveagg6copFASZXasrfFuPf8Lcq987QIXjarvBEpUpDN+ZlO?=
 =?us-ascii?Q?m2yEdvQ6rHtCvSq0IS2Y5hpRbwF2AIrYofkLspRq12kNtKfwplred/gNI2uV?=
 =?us-ascii?Q?4ANFJJRpzyG6DBh2XLTdBWL4L36SBOQG4M6FGY2j4nPJXEGbHzz1Ln4tkM2b?=
 =?us-ascii?Q?/SogGRfdB5izWc378FPtMvVLgQoVq0kjSnOmqMJIGVpkjw3kw85yNV2C1wZz?=
 =?us-ascii?Q?CvQAkR/HcFkU6vYviqXTPd+pvn4b8oGB4LtFoHcyraatqGhfRwDzBtKmveky?=
 =?us-ascii?Q?Gvt9KQFdasJ4OQK0uu7fee0XJQ450AL+l8gqSy6SYEff0gVVj0q+eb8uJwIT?=
 =?us-ascii?Q?58tl1fMCIoVUXPIqEWGyPxC+7fDq8HH1zYZQEgGb3BGPY6xVFIOQNNSW0MfD?=
 =?us-ascii?Q?Hsjrl3qRZ9DjsKtmTg+i/3KR0xgOc/Oo3AgMbQqgLZC6DDvRCPYkAoPXGO/t?=
 =?us-ascii?Q?aGZLy6rMaxUO0qb7uU6lVrFPLDMUaNrPIAJrtN0waLUIkbk+mjMSiFZJ7k1K?=
 =?us-ascii?Q?kgv7i6EpUhmMCsjQGs3G8Kr0w5SV1IpWHko7x7n/wNAEZInqCUuJE/XDRkWG?=
 =?us-ascii?Q?pLG5h4D5kgbSkQiOS6sGUmspBRf+ObU+BCPqdINH9gi5dwPiaXUWGiUwL6dr?=
 =?us-ascii?Q?+fzD6E15sSyDlYUtUuNLxGXLK92OjhZ3m5+pWyogE8AaKRKOaXsM9Xt5xEdY?=
 =?us-ascii?Q?qhf2mfge81IAeKooazjwgwxV4xP/780k4lP2Sv+FqJlDI5uTOJ746gRRPN2c?=
 =?us-ascii?Q?/8u/gSjARnliIvfbOt9Jz1WxLrgx7QwaDuoyzmkMwY+6i7G3e4cr1TmV45HP?=
 =?us-ascii?Q?viqSwVyxmCRyZncoQF8yidv4+DTe8WGKoffe3yYd2g0Yk7jMyaMfhXGzrXWr?=
 =?us-ascii?Q?tOxytho2iXb4OOHggTcoFDtNJiO5gE54n8Jzn7vbIxTUXQs2oTQqU9hzHgVW?=
 =?us-ascii?Q?gQHhxB+h0MB9+UQK+CE6xdHNWQD1gWhDuAVWHnwgLd+J0AvTu8RsOjJvWdbh?=
 =?us-ascii?Q?4Azwu+jaQnMmEMP/dmO+V2OoUXerN3bF8b8CG+CwFlGygouoSuaud9SxN7H3?=
 =?us-ascii?Q?e3Ajlo4/HYphQuQnQ1JwGClXaLSYVgHCAFiJLhr2xc4+Skk2z8duVqJjzjkv?=
 =?us-ascii?Q?8QPAB3JovEl4BYDhmsnGL5x1b737DmpGq3dWHJr0DzSsTm4XmQ/ay+px5PdX?=
 =?us-ascii?Q?udParnZO7jofqKq5/9AiUbdmoEoF9+qK3Cz1nMqMb0DSvMqwvQGYGsIMd/6E?=
 =?us-ascii?Q?y9dzsLTVpU5DxPde8/eedfs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F09D881E4AB4494C9AF65FA17F532592@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bdce2f-cc8a-4c61-3683-08d9bf5b4792
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 23:41:41.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jf6iZ3hU7a4BmwWgNR/uw2sK60o/LqZKdgRwMlUIk+UuyyI9MYRByy2fg9A7SmQfw5eq4u0PEkDpSjEgyIyYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140124
X-Proofpoint-ORIG-GUID: Z9hSxdGijFLgE_ICgDOgAtsQ0w78vLfe
X-Proofpoint-GUID: Z9hSxdGijFLgE_ICgDOgAtsQ0w78vLfe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 13, 2021, at 12:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add new callback, lm_expire_lock, to lock_manager_operations to allow
> the lock manager to take appropriate action to resolve the lock conflict
> if possible. The callback takes 2 arguments, file_lock of the blocker
> and a testonly flag:
>=20
> testonly =3D 1  check and return lock manager's private data if lock conf=
lict
>              can be resolved else return NULL.
> testonly =3D 0  resolve the conflict if possible, return true if conflict
>              was resolved esle return false.
>=20
> Lock manager, such as NFSv4 courteous server, uses this callback to
> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> (client that has expired but allowed to maintains its states) that owns
> the lock.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/locks.c         | 40 +++++++++++++++++++++++++++++++++++++---
> include/linux/fs.h |  1 +
> 2 files changed, 38 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 3d6fb4ae847b..5f3ea40ce2aa 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -952,8 +952,11 @@ void
> posix_test_lock(struct file *filp, struct file_lock *fl)
> {
> 	struct file_lock *cfl;
> +	struct file_lock *checked_cfl =3D NULL;
> 	struct file_lock_context *ctx;
> 	struct inode *inode =3D locks_inode(filp);
> +	void *res_data;
> +	void *(*func)(void *priv, bool testonly);
>=20
> 	ctx =3D smp_load_acquire(&inode->i_flctx);
> 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> @@ -962,11 +965,24 @@ posix_test_lock(struct file *filp, struct file_lock=
 *fl)
> 	}
>=20
> 	spin_lock(&ctx->flc_lock);
> +retry:
> 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> -		if (posix_locks_conflict(fl, cfl)) {
> -			locks_copy_conflock(fl, cfl);
> -			goto out;
> +		if (!posix_locks_conflict(fl, cfl))
> +			continue;
> +		if (checked_cfl !=3D cfl && cfl->fl_lmops &&
> +				cfl->fl_lmops->lm_expire_lock) {
> +			res_data =3D cfl->fl_lmops->lm_expire_lock(cfl, true);
> +			if (res_data) {
> +				func =3D cfl->fl_lmops->lm_expire_lock;
> +				spin_unlock(&ctx->flc_lock);
> +				func(res_data, false);
> +				spin_lock(&ctx->flc_lock);
> +				checked_cfl =3D cfl;
> +				goto retry;
> +			}
> 		}

Dai and I discussed this offline. Depending on a pointer to represent
exactly the same struct file_lock across a dropped spinlock is racy.
Dai plans to investigate other mechanisms to perform this check
reliably.


> +		locks_copy_conflock(fl, cfl);
> +		goto out;
> 	}
> 	fl->fl_type =3D F_UNLCK;
> out:
> @@ -1136,10 +1152,13 @@ static int posix_lock_inode(struct inode *inode, =
struct file_lock *request,
> 	struct file_lock *new_fl2 =3D NULL;
> 	struct file_lock *left =3D NULL;
> 	struct file_lock *right =3D NULL;
> +	struct file_lock *checked_fl =3D NULL;
> 	struct file_lock_context *ctx;
> 	int error;
> 	bool added =3D false;
> 	LIST_HEAD(dispose);
> +	void *res_data;
> +	void *(*func)(void *priv, bool testonly);
>=20
> 	ctx =3D locks_get_lock_context(inode, request->fl_type);
> 	if (!ctx)
> @@ -1166,9 +1185,24 @@ static int posix_lock_inode(struct inode *inode, s=
truct file_lock *request,
> 	 * blocker's list of waiters and the global blocked_hash.
> 	 */
> 	if (request->fl_type !=3D F_UNLCK) {
> +retry:
> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> 			if (!posix_locks_conflict(request, fl))
> 				continue;
> +			if (checked_fl !=3D fl && fl->fl_lmops &&
> +					fl->fl_lmops->lm_expire_lock) {
> +				res_data =3D fl->fl_lmops->lm_expire_lock(fl, true);
> +				if (res_data) {
> +					func =3D fl->fl_lmops->lm_expire_lock;
> +					spin_unlock(&ctx->flc_lock);
> +					percpu_up_read(&file_rwsem);
> +					func(res_data, false);
> +					percpu_down_read(&file_rwsem);
> +					spin_lock(&ctx->flc_lock);
> +					checked_fl =3D fl;
> +					goto retry;
> +				}
> +			}
> 			if (conflock)
> 				locks_copy_conflock(conflock, fl);
> 			error =3D -EAGAIN;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e7a633353fd2..8cb910c3a394 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
> 	void (*lm_setup)(struct file_lock *, void **);
> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	void *(*lm_expire_lock)(void *priv, bool testonly);
> };
>=20
> struct lock_manager {
> --=20
> 2.9.5
>=20

--
Chuck Lever



