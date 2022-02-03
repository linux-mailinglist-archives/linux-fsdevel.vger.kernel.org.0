Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A64A8BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353547AbiBCSls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 13:41:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65320 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233256AbiBCSlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:41:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HTBgp011613;
        Thu, 3 Feb 2022 18:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RfNUWz1MtlYdA8pKEWJ3MUwH6m6SMhCW4ei62rJw0Oc=;
 b=RqsiID3C6H++/GYpLTRzHKbdMYQHXgfe7Q5JTdGhnbrpTAf2/91hDI2nhQqC3ypiuX06
 otQyhgo0dooFNeoO+9aPg4LYsHacgNKAgdtC49fbjyWA7UaBSudBNz8A3virGMB44dtP
 VZY8uWOehtXFQ7Ex3wz9FylhHjAefyzScWh1ZznM0O74l6myQyiPV7Ps/qYEs/z7rXwv
 z7B0UqSqi9kXNgmyjEg+3YPIGhxyRWlowWuKGjhSPC4mJOgK6p/YlMSqo5GN07kOI5Q3
 NtNMVfxvT6CAe8nztK02MAiU5mnqJhY9cj6CgKVkNcG6ZvXZ00xPL1/QHCUAfbcyJamY 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0het8n9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 18:41:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213IfVjq111413;
        Thu, 3 Feb 2022 18:41:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq5tfsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 18:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5FZcgBn+SlOUXfIer4QZgdmw5HzFYqaE8YEremC8ckUrq6vIWzR7gueKFdm7nezJzwbZR3y4wgLMQ3tP4rjXggfvy04q32NYL45048S1e8wK6vCwU4kHot6h7odIfRJ5ydJv7/20zLda6ofAw01p4RuPMIqJxHMTyrIARswr99pJU2TJvwo63Jy8EwxM6iq/fNwnfXn15H7t/Q+BS0CND8GRTI0pzwmqcM3a1pKH28Q2yF5li5VX7XXZlV3rOZVS50KjKxSn42R4kSXesSCI67i7g9vS+rnMGvOtCXIw5VvD6nxzHlP24AYLCa2nd8LXFE2hrgi/JAEt8P67r2byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfNUWz1MtlYdA8pKEWJ3MUwH6m6SMhCW4ei62rJw0Oc=;
 b=gFQHIMLKsIRoZXzeUZddv8Q/G3IO0z7t6yfMFUokm9w9lrTLe++nkurQOcJAD5jQWcxFViX/uJ49eTtzx/5Nzxw2769vMsSiwsL3coxSOtcSXRwjeSM5GiSjMqM19ETr2WgJFP9C0ZxxfUuAJqTT3rTm6n18ldCYMA8XfjBb+J13xWPBicIqJdBlZYyXpxr/zJ+7ZzRFZx6E7NvT45JnpDzgn61ul04rlThFmxvj4rJcLm7/l4/6QOUFClB2J0ja+Ik9Uq3+wwnqj1kfUXxlecGNonF+9/uiyBcsr0GhM/zYweDbM8pRfbEgS4gb8t2BxX60u7eOA2NPzgltySAJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfNUWz1MtlYdA8pKEWJ3MUwH6m6SMhCW4ei62rJw0Oc=;
 b=ObX2iYhUYzQA1BLHCuRY2HSMSenUyIqzhZfovQ283lldXU9ezScVpQW/gqpXR7wA0l1jY43LreOqfjDUi/dSpqV9h3/axSvCQe1tijN+nJfPpYdYHoMeyy9nVUZZIGU+KNhu7filmB++JCw1DyqeDCVAnYMDEKdSQ6VS3oTwa4M=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN7PR10MB2436.namprd10.prod.outlook.com (2603:10b6:406:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 18:41:40 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 18:41:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Topic: [PATCH RFC 1/3] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Index: AQHYFH7WfI678dNhb0CTIchhEp3zcqyCMl6A
Date:   Thu, 3 Feb 2022 18:41:40 +0000
Message-ID: <A40572BF-F202-4FB4-8384-4A410860AB0E@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1643398773-29149-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc28caae-05f6-4dee-3874-08d9e744d168
x-ms-traffictypediagnostic: BN7PR10MB2436:EE_
x-microsoft-antispam-prvs: <BN7PR10MB2436F134CB3EAC93FF59874793289@BN7PR10MB2436.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RzlHimqBcsqJQzTyRB+ClWUG4/74uyijOBsIJwHmaWmCI0WGpFpVDVuU3Mq4qYlNQThO647l4tckBMOf5lxRLdxrmWpy/8g6ML8WOx7qBAly0OhnRi5fJ6GC2pt2wrlQEoyW2qlip62ylb1Yw46spfPRxAE9BRLGQuJ4DXtcHwkix4Y2dlyCNf6SodyFh7O/z03CDEPkTPubG9X7K0WemmR0c6kt+DFh9mmYAI/qGjKJDvhygWoL3uD/U98rUk09GaUmSoNWOURTyEGd0sE7YNtosDjO1lNMV+BGwvSRYSk4Ekt5vPpirGyPpxF4Cah9qiqqCQ+rO+NUmPnqlXZ2cQt5/b6Duxv3baRWnmZ+5DRbsHmlEmf0GuFpq9BSN+Y+rsnDAWvAczyAMuc1jpeiOX+VUIVpMeAev44bISgOE+mUjE5cVe2RPBrqooxPn4Lvb1itjzCENEHlNN0EXVSgF0rKMYqVtoFABnOjmWkA6aFBMEuRCcSise0G10SaVGG/DgvgolKIKnSAeBj6pESm6AA4fXUho26tG4vXa8oaz7uunmql8eDKblhNxnsfdk+kaVCS9Y5DktOUhQVQrtz3iBjWgq3kRzqYuoElDpusRvx6oj2QTNF38XAHq5KoGmCupOyom+qi8tZN7DYOq/vPTEXij75l9Sne4VDqR9Um4DF/CiH2hYAB4Hrt+IQ6L1+XxVr1RlKc/rWoX8MYC9RNWZT65ZpiSLDGNt5FtNiCNrzRAt9GuFPKMwpg2lEYqZZz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(54906003)(83380400001)(26005)(186003)(316002)(36756003)(38070700005)(122000001)(38100700002)(6636002)(37006003)(66476007)(8676002)(5660300002)(71200400001)(66946007)(6506007)(8936002)(66446008)(6512007)(64756008)(2906002)(33656002)(508600001)(6862004)(2616005)(66556008)(86362001)(53546011)(76116006)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?si/fd2B1fKOEUbyJDZ5VchniRmeTdzaZpY2fmXfPNtrD8Jn0pgOcU+EneEUf?=
 =?us-ascii?Q?n5dIs+I6iFR4tHqIE9MDpNZ7Nxx1pvoHaxhUAsSJztRvzXUC9tOUSZd6g0hu?=
 =?us-ascii?Q?AWM05a1DC4kmW7GOm7NY4HH/csKNSwnyjsDfxMfPUuQgPPQugL8VqUHdrfxE?=
 =?us-ascii?Q?DMiL0qo3CZAFcdxszdlu1EEM/TxJAiUqAVaUO0kbrN9ESbMlLGiMEApmji8m?=
 =?us-ascii?Q?+tbW04LMinAd+C/LOm0l6WuGRVCmsjoy8kPl4+H7U9xhgR0C+NsLRxtwcbOO?=
 =?us-ascii?Q?GcR+ftrwCFpzViRQB+FLmoRVy5Zro1VF/w+uOCf9abM9lEFSA8F23B4UhnEa?=
 =?us-ascii?Q?cEcFaCBsh0HL9+OR0ca2ZgUFG4j4mJtPT+K4XGgmX9GqRDW6sa9khTJlPtOT?=
 =?us-ascii?Q?iOnSCMFqrirL4uoL0oPMqkRafIebFh8Pcd/kYcYq9UL/VsNV4L3spNUbjmFS?=
 =?us-ascii?Q?HgLdkxR2Vk3keTVLhdiE5Qd6BgbX+6JvLwyJwq6itdgBaKyM8+9GGSZSH3gg?=
 =?us-ascii?Q?Q1IIbLm9oPSL19YMuyDmvHJOYK03aKvhnGaASIk9ClIqS2ML1aXDahcIIAQt?=
 =?us-ascii?Q?9UMIfFs9SHTGkzY+gZMkwctD/ZFBn/W0zEotA7tC/iXc43455RdAWUyXSQEX?=
 =?us-ascii?Q?VoDt7rUXaFtr/NDmJnvQ78+j4sy7oV0j4hS6GTii6n/SmRpqTPwx8EJWjnOj?=
 =?us-ascii?Q?L6uyvl11f5CNBqnucRV+X6/pnw6pOjs41kxKqtf6ygL0JJvmw3iDABn3f4jX?=
 =?us-ascii?Q?Cht7EgoJDv3WNs3Fr2Brf4IgNA4RUAz3FVrvwr+GwUDfXbramNBAU9oBHs1k?=
 =?us-ascii?Q?UQS51pZKCckvm9OfxOnA2MuJ+aoGrtbGVpH6JlpF/kJ3SxWcrToFLaBnKUJU?=
 =?us-ascii?Q?2t4sOxmVL8uFaANya1xftB49yzMhnweikOhnZl8Dm5zHsT6vSbYkpqXsIbeS?=
 =?us-ascii?Q?HEOvbxS2Ldg6YqpSB5jrT184I5U12aDE2wKOLy81ex0oYnRfTgK1CBHgGj3Y?=
 =?us-ascii?Q?bL2vTWyTGJgYtNmlcX2yYt307ga/y9jXIDOptOAlD7atmTB7/H3vaQ/E5V/Z?=
 =?us-ascii?Q?dpI2dmyNeW50MEx7Ys4JJyR9DMZszNIZCVcj/mTpB+hdfCimi4O0t5RNtPVN?=
 =?us-ascii?Q?HVDO8b1NFNDmndH43WIDMxi7Ne+e9mpDw4LbGdeSWEJelFrDiZdmS5fQCPMR?=
 =?us-ascii?Q?vtnCMlqarWnPpSHVdDtJbCN3KpMNdfWflpA586rj4Blx2h4k6/oVYmRnEPB+?=
 =?us-ascii?Q?vlYuodkZ0YBxF+BCGjF57gmrXRqJ97VQLEsAn+UtkbFPRAy4w8NzskEHkKVM?=
 =?us-ascii?Q?LKp4+uMCZ8IM8s5v7bLVqNoiXnywiJlvdb0qDGIuPTuzszBurEuuAPE3EILX?=
 =?us-ascii?Q?S2wIgZ+XPwDjjBVWLcGMCmS4Q9LPDXrNwedPLYR2Xe6TZfqoGIKFVFjfAvKo?=
 =?us-ascii?Q?u3fLnAXS1yrGnymhZN8faNpPwYE3ktNDgj6f3zY7GH+defSL7tJ5MUzPJCof?=
 =?us-ascii?Q?13/OMcR3qhftFqwplknqLSa68WuDkaxrJfahqMrY2WzoLcLiFjG84LPiICPA?=
 =?us-ascii?Q?LtC40Ax1GQeS1jYxTLlsDWFHPRIG14ahxJsId0O69D2HanvM5IbjWw0+LHb8?=
 =?us-ascii?Q?4+WbJhcBv/pPYoralRkSVDU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22DDF84BC8D3224D9DF4B9D3310C6626@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28caae-05f6-4dee-3874-08d9e744d168
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 18:41:40.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vbhRH8mGJTsGpr/df0n7YTXEk+b9NFUM2ApQivZESGaEnCWz/eUI1OiTZHHzf0hyzeLt6mPrcgbjp98p41vVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2436
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030113
X-Proofpoint-ORIG-GUID: 07Py_Pq6bsQCJfq3twPdFPgTEllXKFv9
X-Proofpoint-GUID: 07Py_Pq6bsQCJfq3twPdFPgTEllXKFv9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add new callback, lm_expire_lock, to lock_manager_operations to allow
> the lock manager to take appropriate action to resolve the lock conflict
> if possible. The callback takes 1 argument, the file_lock of the blocker
> and returns true if the conflict was resolved else returns false. Note
> that the lock manager has to be able to resolve the conflict while
> the spinlock flc_lock is held.
>=20
> Lock manager, such as NFSv4 courteous server, uses this callback to
> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> (client that has expired but allowed to maintains its states) that owns
> the lock.

This change is nice and simple now. The only issue is that the
short and long patch descriptions need to be updated to replace
"lm_expire_lock" with "lm_lock_conflict".


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> Documentation/filesystems/locking.rst |  2 ++
> fs/locks.c                            | 14 ++++++++++----
> include/linux/fs.h                    |  1 +
> 3 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index d36fe79167b3..57ce0fbc8ab1 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -439,6 +439,7 @@ prototypes::
> 	void (*lm_break)(struct file_lock *); /* break_lease callback */
> 	int (*lm_change)(struct file_lock **, int);
> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_conflict)(struct file_lock *);
>=20
> locking rules:
>=20
> @@ -450,6 +451,7 @@ lm_grant:		no		no			no
> lm_break:		yes		no			no
> lm_change		yes		no			no
> lm_breaker_owns_lease:	no		no			no
> +lm_lock_conflict:       no		no			no
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 0fca9d680978..052b42cc7f25 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -853,10 +853,13 @@ posix_test_lock(struct file *filp, struct file_lock=
 *fl)
>=20
> 	spin_lock(&ctx->flc_lock);
> 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> -		if (posix_locks_conflict(fl, cfl)) {
> -			locks_copy_conflock(fl, cfl);
> -			goto out;
> -		}
> +		if (!posix_locks_conflict(fl, cfl))
> +			continue;
> +		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_conflict &&
> +			!cfl->fl_lmops->lm_lock_conflict(cfl))
> +			continue;
> +		locks_copy_conflock(fl, cfl);
> +		goto out;
> 	}
> 	fl->fl_type =3D F_UNLCK;
> out:
> @@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> 			if (!posix_locks_conflict(request, fl))
> 				continue;
> +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
> +				!fl->fl_lmops->lm_lock_conflict(fl))
> +				continue;
> 			if (conflock)
> 				locks_copy_conflock(conflock, fl);
> 			error =3D -EAGAIN;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbf812ce89a8..21cb7afe2d63 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1068,6 +1068,7 @@ struct lock_manager_operations {
> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
> 	void (*lm_setup)(struct file_lock *, void **);
> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_conflict)(struct file_lock *cfl);
> };
>=20
> struct lock_manager {
> --=20
> 2.9.5
>=20

--
Chuck Lever



