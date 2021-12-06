Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1546A4CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 19:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbhLFSn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 13:43:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30952 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233656AbhLFSnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:43:25 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6GnLrK027649;
        Mon, 6 Dec 2021 18:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=P0QD1TuEhAtXKJrdOtfGT1XNqn77ADHHXGeNn6RUF8Y=;
 b=z6uCiJqbc2QvtEXxXd/mjARFD+xKqdBo0lGkCPLHJbzyv3mfdvfBwVfZ7wr/5WQ3ts77
 A1+XOtT9KG5oIrc0Txn/4Vp3ZdFf7hspK8B3BUE/WVDBpcGntB+aNI349sjQSFj9I9hm
 cL0WiLkvo1ryFU6wieXnbWFvrnbVY2ui7DZ2Q55W5cldSMDp2Latg2tUB1Vz1Bok29yv
 4x3ChnJNMrI/qfjacTLuhHEWUxTizWyOarzjg0Dp3RapBvELSie1LRiRIsme0Acx6oVW
 lJukwddGcNF290yzMVjfPq4RDu5mIuGGmcg081Ir7SHgN6MGCbxfjMhRH61lScUMJeWB Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72b4cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 18:39:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ia4fc193539;
        Mon, 6 Dec 2021 18:39:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cr053tce3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 18:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUEUDjLe9wR9w/jhhAlCvictyURriceWfT1pImga7fbfl13QtGbovBzSSHOELUYuVE60jQo3hLiLqYKImMfI3L0k9w8fQY9a70ssw7seVyfO6fTZfZvHcMYKxKPyn5ZTH3qVLafobTzlN0cM5eMe2Cm4k6aRmi5b9nvZxYxAjNOjYxomKcTK9Am7yMIvkKe/+UENKekq0PZarTMT23BMSWBuvOfYwPyv5cwivDGCoGCzjqK2PSKXx/FzZQoTlQQ/Wlo6zo8ardipt6RDjgLPU648hxzlt6knLLvPzQ68FFvdOrKB/mS/4ZJAZm3fln/a75K0t0lVKuSO92zi6KwYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0QD1TuEhAtXKJrdOtfGT1XNqn77ADHHXGeNn6RUF8Y=;
 b=Zx2f/ciUnScn6PuyUWbiIfqqaMzDdZJryFrL2/W1vemn69oqfN4BafJbfVjPavZLktd5Z4NGLRCnlvErC71aRYPxH2cfDtc2GFgt3DjQWLZ0TLCdEw3sDxOvcoDaisAygBEYH16bTmAnfLW1KCdTTE7B+R9ut7MztucKMHAgQ4jn4QRuLKwZUGgGHeo7y1P/HtjInNYAJgf/hLxXC6kBCXRbEPkxxKtTmMnRI6iYyfebiIKWhOlSUci+G97oQt99IOXAjdDN5dq2EfCmCn+FEfORUUvyBeDckFNXScQIN4qB5JBz7pw/z+d2ONeBLB2XAeOctsQ/27wz4uxJkA+exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0QD1TuEhAtXKJrdOtfGT1XNqn77ADHHXGeNn6RUF8Y=;
 b=BDFMwnbNWivQyo96dx5RzxQw8q0q8+9Ok98XzOZZ3RHuwRgxvNUJySvvZsFAx3gA+2H98mGH9Y0bQENDhdewOerIcxIrg57kzPBi66KAX8U3IWh+zIeVLvVDfIYkTTI3vugRvbjBRoSFh0z99QmynmpQHet7yy551umy45+wUXQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5340.namprd10.prod.outlook.com (2603:10b6:610:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 18:39:51 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 18:39:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Topic: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Index: AQHX6ssSX8kmzDHzL0ydpUvZWW9YQKwly7cA
Date:   Mon, 6 Dec 2021 18:39:51 +0000
Message-ID: <133AE467-0990-469D-A8A9-497C1C1BD09A@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-2-dai.ngo@oracle.com>
In-Reply-To: <20211206175942.47326-2-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afd2b830-678f-4600-0e12-08d9b8e7ca36
x-ms-traffictypediagnostic: CH0PR10MB5340:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5340190423C49C18886FD505936D9@CH0PR10MB5340.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vGnQ5eTQdFL9XWUdWnVU/lB7jTonC39o8ngu3J5MDYa/VWa0VoLUHyUN3CZF94KDxXhSyL+jvsTR9Rhbt9tq90phCMphxt7emBc/gqPj2FcfzwHUrMwawDAAi+WZEcbYNbnUa3F9BYP7BndZ3cewZfBw7kPQtK69bOIJ5RYKzRxvbeGvfG6db68cExBvbkzt9+kpIwex+2pkA90MQjltVJKH8zY/uWBJGgtQc9tf+rXKcZGVtfPSr60W44ds51VwbElGMDtA/JaGU2rzOo1xbX+yw8OLtp51dssj5UJnImvGKTHbIs2h4d6dJyybtiXnMO8DIq0R0F/S6XDe4brc+VaoWIyxeN93XqAjG2MZ8c0xRYsl56Dhgf0f6Cf9xVi4hMq9H0YRPiRhKWhJkEK5U/815dEaEZ/s61OMM8V09nyfGPDJBQFoFCFBDh61xII6tSSPUe5r6y+2tp+F8yjnIkInNUhO29+zDn3OcSyIZTHIxJVHqCxptRKz+hRbHK8NFbGjJFiGI4Ow05wamQrKBliZs6tiFS6/ZfYHHoF19jCwxUIGhOp+PXbgqyvJlCyFYfQUgFG9iy3Le5t7gaF1zJx4XLzDi8weyHI5iFgb/Gf/MsWquBRXo/JuPW4O8UkRL9YxThxu6FF2USasXPhqO1O2iLuE2/7c+ofATN1ZAHfxzwNTbRnMa4GGbwetj2jGDCZjWV+NgZfNxgs+Gjmq/KFOd6hzMtGzD7Q2wfual+4uYBNb7FUMOAG7gaYNQUh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(110136005)(71200400001)(122000001)(8676002)(107886003)(54906003)(6506007)(4326008)(2906002)(508600001)(33656002)(53546011)(6486002)(6512007)(66946007)(86362001)(38070700005)(2616005)(316002)(64756008)(26005)(66446008)(38100700002)(66556008)(66476007)(76116006)(186003)(36756003)(83380400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZt8A1mTjNJv48pV1TAvQvCEE5tBif7x+BYqRPiLusYafsEOzjxPOOc4PcTR?=
 =?us-ascii?Q?tIU9Jhli2Ol4mA5ws2SLFOwRPGiYIiUVWSuG++xQptLKqx0aLounmjidBI3M?=
 =?us-ascii?Q?g+gLxLF1rftSvFLsYcV4QwZL2LicBECC/LA1QzlIQkTlw1wt0G2HJVxYyhD/?=
 =?us-ascii?Q?j5N9V5REmlTJ2jFRbGPbcFOGumZ46CHt+aWdEA7RIDI7TO9a0XQYVFCrc2hy?=
 =?us-ascii?Q?/3Oe0fBzJgyYtNbOjN8ZYXspwSjQ1KZRExN15REIReFfT0kV+qgy+ocR8Z8n?=
 =?us-ascii?Q?C2sOtOUH3PIkWzWmIrmuAp6V7JPahupvmpxciOzNoIRtKslkB8aYuE8kn31j?=
 =?us-ascii?Q?R4CVM033/JCwh8DxXQ5w3zBP7BaqqHNAUYRzktCr9KPgVqkYRBJXFXav5Uh4?=
 =?us-ascii?Q?WyHg+YO+uCQn3BTI2L3H4Xo7oFxHyuEYyW420bYX3iQcfLnJoSK93t6G/8Zq?=
 =?us-ascii?Q?4zIkL/snNCYrKxFP2N3tFqjwM85URt0gFRXiP9HVBGYIl4UCSr65fBIyphua?=
 =?us-ascii?Q?x9T/ejHOnU6uj8j77gNTMrcfshRvJS2HfNxi9e0v87/g0KFrfkoJZgbtldUT?=
 =?us-ascii?Q?+BiObyss2vVNrTrkh5WEB5LjYcM4G+hilLMj/PNU7/kc42g87a/pt6UZ/7Jr?=
 =?us-ascii?Q?NAqEr2xkIwgKCxbKIo60Wvf8ywjqwQZKKWPnwnBB4Braz3BJPdZ8ZRR/f5by?=
 =?us-ascii?Q?zaSjC5aPtXO8ff/+Fwe4TKxkvh6JUdrAEhTx93Xb/EpBvvSndarDWt/Z6fyk?=
 =?us-ascii?Q?5LyS3X443/VBqOh3FWXeao7eOkb/aOd1fYkRDtKt1UHgztwx4SXF5RevJjA8?=
 =?us-ascii?Q?Qko2+L4nau1qXsnQxGEGynyh6Cl6nuTZGZGw9LikOeUJc/53fbKQKvxTZ1JB?=
 =?us-ascii?Q?QTB3nSUHzSSGfgjjkwIwQNqb/gJQcVKRR4bc98FEx7xp52le339/I2svGi0Q?=
 =?us-ascii?Q?kCSR4SvlDTS3ZCTQ3iBidQDe1L0LKz/SaGZ5hUJCu99bfzajw98ZMkN4AcIc?=
 =?us-ascii?Q?dMBqtWFgFlC+6+YC8p3XTF9fCkUSbLEJAXCWZHuDXRwVBJysdHZphtxV4rnl?=
 =?us-ascii?Q?6aWz/0IxDcHOnyyUfRWyIoOI2M+UR2YBpy0Z1Shkd5bUa1S1sT/AzgiIEgdX?=
 =?us-ascii?Q?1L8ZLu8bJM9XkLIT8C3SCNrqhSnZRNnC00rVZxm5fZx3XOI709/aT8Hrgx7q?=
 =?us-ascii?Q?ePp2dYjR8bBg4brh9Kyl+DJ43F7txGpZuP1yFk4yG7VdqpiOJgk8jopDNSXv?=
 =?us-ascii?Q?ngc8kVW3KyYEnC/Y/wseB6Gut4znOuh9fdPcipBU2sBmcQuR7Kn2ZsBeGpiU?=
 =?us-ascii?Q?P4ZXPlN4NX5/FQn+FBgzleCxYfqjH5dH5tFiwEEmrHQ5mz20elvryFd5Q3Wz?=
 =?us-ascii?Q?vscy1RTm22ZyPMYldI36WI4x6gZGlPE46r7m8eOsUI8r0ChpWH77H/SSRu/F?=
 =?us-ascii?Q?g+cpzEE3TXvnkQy6eWP3Qvcy2+pCp4dpszYuA+HN+OItGsE0KnNGUJwlSdQN?=
 =?us-ascii?Q?wJjeP5Nk+nY7IHEYRe7END2DNGU84RsdHsS5HXj55nFfTxCW4RMQd9gxNyMt?=
 =?us-ascii?Q?D/8TVNSkz5BRJDaJAAqI2wHDqRLt1/YirdN9aPjgwjrq2Eu5gfedcgNxiA9g?=
 =?us-ascii?Q?QMqlFV7Q6zWiduvEUSwPCrY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <914631708601C44688B5265C29B5E8B3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd2b830-678f-4600-0e12-08d9b8e7ca36
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 18:39:51.8684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PKZVqOewDQ2Jchc/ABl7MUb7N6oZtFZr5lE4oZG8BfE4VDCwMPndSO22z0LouGTsPE51qsFxv4HrPmyCk5UPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5340
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060111
X-Proofpoint-ORIG-GUID: HHiUM23jVUgNWxlHcGse3dr0iOB5I4gL
X-Proofpoint-GUID: HHiUM23jVUgNWxlHcGse3dr0iOB5I4gL
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 6, 2021, at 12:59 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add new callback, lm_expire_lock, to lock_manager_operations to allow
> the lock manager to take appropriate action to resolve the lock conflict
> if possible. The callback takes 2 arguments, file_lock of the blocker
> and a testonly flag:
>=20
> testonly =3D 1  check and return true if lock conflict can be resolved
>              else return false.
> testonly =3D 0  resolve the conflict if possible, return true if conflict
>              was resolved esle return false.
>=20
> Lock manager, such as NFSv4 courteous server, uses this callback to
> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> (client that has expired but allowed to maintains its states) that owns
> the lock.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Al, Jeff, as co-maintainers of record for fs/locks.c, can you give
an Ack or Reviewed-by? I'd like to take this patch through the nfsd
tree for v5.17. Thanks for your time!


> ---
> fs/locks.c         | 28 +++++++++++++++++++++++++---
> include/linux/fs.h |  1 +
> 2 files changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 3d6fb4ae847b..0fef0a6322c7 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -954,6 +954,7 @@ posix_test_lock(struct file *filp, struct file_lock *=
fl)
> 	struct file_lock *cfl;
> 	struct file_lock_context *ctx;
> 	struct inode *inode =3D locks_inode(filp);
> +	bool ret;
>=20
> 	ctx =3D smp_load_acquire(&inode->i_flctx);
> 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> @@ -962,11 +963,20 @@ posix_test_lock(struct file *filp, struct file_lock=
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
> +		if (cfl->fl_lmops && cfl->fl_lmops->lm_expire_lock &&
> +				cfl->fl_lmops->lm_expire_lock(cfl, 1)) {
> +			spin_unlock(&ctx->flc_lock);
> +			ret =3D cfl->fl_lmops->lm_expire_lock(cfl, 0);
> +			spin_lock(&ctx->flc_lock);
> +			if (ret)
> +				goto retry;
> 		}
> +		locks_copy_conflock(fl, cfl);
> +		goto out;
> 	}
> 	fl->fl_type =3D F_UNLCK;
> out:
> @@ -1140,6 +1150,7 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
> 	int error;
> 	bool added =3D false;
> 	LIST_HEAD(dispose);
> +	bool ret;
>=20
> 	ctx =3D locks_get_lock_context(inode, request->fl_type);
> 	if (!ctx)
> @@ -1166,9 +1177,20 @@ static int posix_lock_inode(struct inode *inode, s=
truct file_lock *request,
> 	 * blocker's list of waiters and the global blocked_hash.
> 	 */
> 	if (request->fl_type !=3D F_UNLCK) {
> +retry:
> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> 			if (!posix_locks_conflict(request, fl))
> 				continue;
> +			if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock &&
> +					fl->fl_lmops->lm_expire_lock(fl, 1)) {
> +				spin_unlock(&ctx->flc_lock);
> +				percpu_up_read(&file_rwsem);
> +				ret =3D fl->fl_lmops->lm_expire_lock(fl, 0);
> +				percpu_down_read(&file_rwsem);
> +				spin_lock(&ctx->flc_lock);
> +				if (ret)
> +					goto retry;
> +			}
> 			if (conflock)
> 				locks_copy_conflock(conflock, fl);
> 			error =3D -EAGAIN;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e7a633353fd2..1a76b6451398 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
> 	void (*lm_setup)(struct file_lock *, void **);
> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_expire_lock)(struct file_lock *fl, bool testonly);
> };
>=20
> struct lock_manager {
> --=20
> 2.9.5
>=20

--
Chuck Lever



