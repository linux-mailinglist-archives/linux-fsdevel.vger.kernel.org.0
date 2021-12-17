Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D394795FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 22:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbhLQVHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 16:07:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24660 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhLQVHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:07:02 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHK3DCR013129;
        Fri, 17 Dec 2021 21:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZVm6ZZ7nz8gzu3Uy5A4LsCi6sEDVFL3AHfNzloumqn4=;
 b=h5+Azch6EMlyEUR85qhoKe6BVUNNFy+qqgpvNCwsa4ia1hX0LdA7mvOygGgTNM1Z21NU
 hyqE+GDHMbGKdsNJoLxmZVKJxFk/LlIESxZFJKDpBDmJmOiNTuOBSd8gcGSM+li4I9Ed
 XgEGQAVbRUIHwPBCiwncW+HwBMF+q8ryE8OnTizSI21JV54+gskDh4+v5WVcw+ifUwjQ
 UL91YALNMZ6sne/QdemxBv12LWU4hzewmzEcNGEfMWq28R/LMjF8nPWHU7A6bv+iDIrg
 Nu5uXz8FhzeykcuBfDcsOf7bP+NxauLVBZ93I+F6yuSHXb8G0kqhC6niEbNQxCzRrdJb 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp6t7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 21:06:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHL0dTf165270;
        Fri, 17 Dec 2021 21:06:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3cxmrfdf0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 21:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDyQHsyil8Zd9KfTc3mVJmf86z0Y2OVXAfzLdBnNXY0ml6MGE83loUjSYNrXDIg4WJZzZlBTW1Nu+qRYmUlfER7n/fy3xZejF0KgPuAXy03eF31Pg/ktKrstEqsdwCpbcH5xx3728RoXOr6Ge3/wezT51pL4Jnjj7FcjODjdcKi87kVgKQOUnqcjAUaqdvWqMQg0bgSfgmWTKfpxuAOuhSndjyRQ3Hw8KXsV5ujd9V77uo+jMRbsDwxEtnO1mlYdYbNdHUhhOxB88YKZkBUJPu35yYnGnJDBAXtS0A/xInIc9RvCg/9jxtDuN8lByDdjyGj2qfwaK3ZHA1j1pCtx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVm6ZZ7nz8gzu3Uy5A4LsCi6sEDVFL3AHfNzloumqn4=;
 b=KPG22pLIqj2WN6yPbSvQQ9AxcH4D+rbLHmMZjsFUDz7sxMAAQqRNubGqiOR8T/M4lmxVWxzQBE2+K+0kKi+olJKJMDY9/gfUjRyPfa5DcPMGUh1aqfejZy3f60BLCsbF0ePSLHXc1GiW6XoHnn84DZxkOj9cCRFRpr3nPrUo56J+CmC+Y6JlVTQE8Dny75vGNmxfOnALcSo3ev1hgq2Pi3Zsb1siMSZ25dSl5J1fKrgmcmQe0PQEHT2xLzXl8qhBti/TAAjzgRMbjGirDNy0C4PMK1US5xvvELu66SxPEe3qOVZUkIRq7AFDFBlbuzRFZIlo8wZX+h9Kua3Yp+ehQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVm6ZZ7nz8gzu3Uy5A4LsCi6sEDVFL3AHfNzloumqn4=;
 b=TwYQtHv2lUG0hv2TANFcg54+5rJsu6CEL/jK3AiBcdLkAN9XjNTTDNuKCV++O3V1rTZng4NmtJOUKUkOYb/9/EcZ2uwk54lUJRpA1LvIQL/1hLch3HN3lkH3FZHlZ6aNKJY/QTj1xTPDMlAC1IdBgU5vDtp3qXoHotnmz15c6l4=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:06:52 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853%8]) with mapi id 15.20.4778.016; Fri, 17 Dec 2021
 21:06:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Topic: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Index: AQHX8EZJmW5yrRSTYU2Fiyvh6ExyIKwyp7wAgASC64CAAARegIAABHUA
Date:   Fri, 17 Dec 2021 21:06:52 +0000
Message-ID: <C371AB3F-AFF4-4B8D-878D-17950FACE366@oracle.com>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
 <20211213172423.49021-2-dai.ngo@oracle.com>
 <0C2E5E30-86A3-489E-9366-DC4FF109DD93@oracle.com>
 <20211217203517.GJ28098@fieldses.org>
 <5fa49a09-50c9-efb4-fa72-35c0e8d889b1@oracle.com>
In-Reply-To: <5fa49a09-50c9-efb4-fa72-35c0e8d889b1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5129e192-0d03-4e8a-8a48-08d9c1a12641
x-ms-traffictypediagnostic: CH0PR10MB5195:EE_
x-microsoft-antispam-prvs: <CH0PR10MB519599DADC8B0AA360136BE593789@CH0PR10MB5195.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLPK1R0qIEjMk21muBHGetI545W5X525jbRorvo63jPCmt95QdC7R5ofCg0Bq2c9XSN/jrueiKzDYSnLhwJCroTnKLjBy1g8E/0VaNYjuIenMYlPS6aK116q1M6GMGBVWQ9zHNVMgpUSJf6Z34u7Vi4g3OiI1MXrIXj4A25THozkmmnQ3Z4X8aGDDJ7pK/vmfbpnD8AMcDatcjDYD3Y9KgHKya//79HLLIsr+1oBzSSbOtMMLx12VRveXifkI1AI2nFVY75+Z6t06UCI5YmdnLP16ZO63PRprG6QoO4TwQ+eHF3coRTZ00lG71OaUc/m0rVB8rICPExXUiR7tcPCvORvfgf3HZGYVUCIX02VLO+h14JfdPebGd8P1CITKvaSWmbAu18it4XyCj05Z9Fapd4Apj/uhAxgRZhmOCK3Gfj2FurHmS/MGK7tBQLxugZnNVYCIex8hBrgkLoGB8+cAnuGyq6TvVbVRVGf3LbdUqA/t/lzJ13vU38GXKb+aFV76lNaPTt87Md85vXqPiYdhEWKRPjiQ5fCLYYe4gVn83I9QRiq5tYsIKhsEWX1gByW+abwq7a1HcI9Se2SO6oI8VrpD/u+GFY63aMgxLo4bM28wbgPt2xHRxQRbhSTCr1/pGRvUfL6LzrqkJtRIA8Xuj7k2wbZVR06d2IdZI5PFlSB/8N0zezfxgpmur8zKcyq7KgZ9M9FWfak03xvCXe2rBzUxV78fSzWg3QMt6SD7oqE7+r1X4VTBCnCuOf73UDJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(5660300002)(6512007)(4326008)(33656002)(8676002)(8936002)(83380400001)(6862004)(36756003)(6486002)(122000001)(53546011)(54906003)(316002)(6506007)(38100700002)(38070700005)(66946007)(66476007)(6636002)(2616005)(66446008)(66556008)(64756008)(76116006)(26005)(37006003)(71200400001)(86362001)(508600001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IO0ZveDg/NgzZyxylK7+TQ2bT84u9Te0nGMV5fNTJl593eCB5qBeQUwA20y+?=
 =?us-ascii?Q?0qaHJ4EwiiTbckipJAgpGYdYuR/RWjnRSZ3r/fmwSKqpsKcDcaHA5KvvMs02?=
 =?us-ascii?Q?Vl5Ej+YyLXqgi18EIAg9Az2k+9u//+7KWSvxaJh6ki4W3vgp+do95xhfLJ6l?=
 =?us-ascii?Q?fmM185Qjhd+BlmbcIU/2IU2eI5QKJ3sMdWSpe1dRQ2Y2yhjncW6lgY4LiDzB?=
 =?us-ascii?Q?TEqHKK5uru5GlhCHTtUO1OStCqxn9v3Q1bU4U4Gup8RwikMJ2rYzb/06AD7x?=
 =?us-ascii?Q?Fgoo91W9TYD1b1E8NhJQuy1U26Nct26+09hHM7o4ZdafseVosE/PHmPe8qup?=
 =?us-ascii?Q?8OkxL42X9fSx93OiBPPwDjpIOLsWlgy7a0W7fiVjSVtKn3lxBS247+IETMCQ?=
 =?us-ascii?Q?00ELcvJCwDSNraNoycA3FIjXSjUy9465ijkLoJDc91NQlPe8imgCPdwc/goM?=
 =?us-ascii?Q?QpTy/hUtc/258MLI3UlYqJQ2GzRgQ4qwIFFbVHzCsHxxCkvTcdwi0MDf1DgE?=
 =?us-ascii?Q?R/Q7EuoDCh6TNJninBSI9TVY8C+JvVBFq6Guw7fpgONDpDCQCnoAD479HIgZ?=
 =?us-ascii?Q?hLmWe35JVm43aegLc2ILeiBoWmldgEaJyhapYy2vi9/0jm/Km8tLPVbk1lMo?=
 =?us-ascii?Q?5d8hQ37zNC1WvtTqEZSZq9PHeWoiaigdAWjHDMrADRu2F67xNtzCSFNBTspo?=
 =?us-ascii?Q?XWskhToWWVWnU8w1ESATi8Ic1Get+n6dCJRgTsyjOLUKHQFNsDTyyZfHJt+7?=
 =?us-ascii?Q?9mJ1jdyTG+cCZXORBbZXSmvNHZxQ3HtzCYZp5i7PA7W+VR3aDjH5jn8asy9a?=
 =?us-ascii?Q?pGJym16W2dhnQGl1nDhpUK0iTy4ljev294y1BM8AJcPjKIrdsQhlDw1nFqkL?=
 =?us-ascii?Q?E3hnhJm9Mkae60J1/PTzYm6uCit5w/qiU4dtLKJhCoixl0E4SNTWkbCHSNSP?=
 =?us-ascii?Q?FgI6KCb/JGibXvez5X9kFB6sMRhVr4blAR2xMsrsAGZLPqLIPcqSThIlb8US?=
 =?us-ascii?Q?raFD6DTgabqefK7YB4edlApepyTMGn2qHgUQfMmxgB46FJgtpTZCDNCZidEG?=
 =?us-ascii?Q?IMHFbfZ/J8eoXMPslOI4TcMa9ZSpqrvzJ4Aro3+ObxJ0kFRWtleos/JRESJF?=
 =?us-ascii?Q?AF+daHiY8RKbG1XcwmptMOST9Z1GXWSg2k7RebWruf8ERUCV7YloDkEgPJqO?=
 =?us-ascii?Q?i7j3J4/ny57nqVT3z3CjQaX4Tb51gcnIhErtMk0Rd9LXEcrzywxmUlRnvO4R?=
 =?us-ascii?Q?I/bIn5f+76X2l79nJf8d0jVMoPNaJKH8M0bF4/B/6AaVLemBvIfxTtJY0Yve?=
 =?us-ascii?Q?bkxPkwIMNq7j7dKFDloPuMZgM/FYzapPfUIFbfiDDND6jsEINMcPxRHwHpEc?=
 =?us-ascii?Q?XRHoKw96o0+Cd8AKDV26z7A+FKd34+aO95HVN4AGpz2DPb/SGQZxiumXRnVC?=
 =?us-ascii?Q?Y88gFftwe4bHqlJ7LvxbL14PAdqWcmvwf9WKdtZSxwoDYA2L3x0/w+USE/a/?=
 =?us-ascii?Q?Kk+OoFQ6mkyhC6qQkHDNx16z4CU9aCxCGUYhddN3qFLkgEqooAyrSt1eVgNL?=
 =?us-ascii?Q?0Jv6+S46Tc0J95koVzU0GSo6SaxCsew2pGkjsqzWdlqQ2Mt9vQJUHkF82pM1?=
 =?us-ascii?Q?x3bLbj7e0Dni6kHMGWCLvqs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1D7278289CD2F428ED2D4D0BE50A859@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5129e192-0d03-4e8a-8a48-08d9c1a12641
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 21:06:52.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Et3sqqmam19Z4TpofDb46GR4y4bgKRGG/SPFJrpgPHuIFdpLdDSfhkfWCsQv/sYSKEuzHTUFfwr3DuNxsgFiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170118
X-Proofpoint-ORIG-GUID: zvIm_PDuJhCycpVpvGqZaCt0s7uG-bdK
X-Proofpoint-GUID: zvIm_PDuJhCycpVpvGqZaCt0s7uG-bdK
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Dec 17, 2021, at 3:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 12/17/21 12:35 PM, Bruce Fields wrote:
>> On Tue, Dec 14, 2021 at 11:41:41PM +0000, Chuck Lever III wrote:
>>>=20
>>>> On Dec 13, 2021, at 12:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>=20
>>>> Add new callback, lm_expire_lock, to lock_manager_operations to allow
>>>> the lock manager to take appropriate action to resolve the lock confli=
ct
>>>> if possible. The callback takes 2 arguments, file_lock of the blocker
>>>> and a testonly flag:
>>>>=20
>>>> testonly =3D 1  check and return lock manager's private data if lock c=
onflict
>>>>              can be resolved else return NULL.
>>>> testonly =3D 0  resolve the conflict if possible, return true if confl=
ict
>>>>              was resolved esle return false.
>>>>=20
>>>> Lock manager, such as NFSv4 courteous server, uses this callback to
>>>> resolve conflict by destroying lock owner, or the NFSv4 courtesy clien=
t
>>>> (client that has expired but allowed to maintains its states) that own=
s
>>>> the lock.
>>>>=20
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> fs/locks.c         | 40 +++++++++++++++++++++++++++++++++++++---
>>>> include/linux/fs.h |  1 +
>>>> 2 files changed, 38 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 3d6fb4ae847b..5f3ea40ce2aa 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -952,8 +952,11 @@ void
>>>> posix_test_lock(struct file *filp, struct file_lock *fl)
>>>> {
>>>> 	struct file_lock *cfl;
>>>> +	struct file_lock *checked_cfl =3D NULL;
>>>> 	struct file_lock_context *ctx;
>>>> 	struct inode *inode =3D locks_inode(filp);
>>>> +	void *res_data;
>>>> +	void *(*func)(void *priv, bool testonly);
>>>>=20
>>>> 	ctx =3D smp_load_acquire(&inode->i_flctx);
>>>> 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
>>>> @@ -962,11 +965,24 @@ posix_test_lock(struct file *filp, struct file_l=
ock *fl)
>>>> 	}
>>>>=20
>>>> 	spin_lock(&ctx->flc_lock);
>>>> +retry:
>>>> 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>>>> -		if (posix_locks_conflict(fl, cfl)) {
>>>> -			locks_copy_conflock(fl, cfl);
>>>> -			goto out;
>>>> +		if (!posix_locks_conflict(fl, cfl))
>>>> +			continue;
>>>> +		if (checked_cfl !=3D cfl && cfl->fl_lmops &&
>>>> +				cfl->fl_lmops->lm_expire_lock) {
>>>> +			res_data =3D cfl->fl_lmops->lm_expire_lock(cfl, true);
>>>> +			if (res_data) {
>>>> +				func =3D cfl->fl_lmops->lm_expire_lock;
>>>> +				spin_unlock(&ctx->flc_lock);
>>>> +				func(res_data, false);
>>>> +				spin_lock(&ctx->flc_lock);
>>>> +				checked_cfl =3D cfl;
>>>> +				goto retry;
>>>> +			}
>>>> 		}
>>> Dai and I discussed this offline. Depending on a pointer to represent
>>> exactly the same struct file_lock across a dropped spinlock is racy.
>> Yes.  There's also no need for that (checked_cfl !=3D cfl) check, though=
.
>> By the time func() returns, that lock should be gone from the list
>> anyway.
>=20
> func() eventually calls expire_client. But we do not know if expire_clien=
t
> succeeds.

I don't understand how expire_client() can fail. It calls unhash_client()
and __destroy_client(), neither of which have a failure mode.

If there is some other opportunity for failure, then func() should return
an integer to reflect the failure. It should be explicit, not implied
by whether or not the struct file_lock is still in the list.


> One simple way to know if the conflict client was successfully
> expired is to check the list again. If the client was successfully expire=
d
> then its locks were removed from the list. Otherwise we get the same 'cfl=
'
> from the list again on the next get.

I'm going to NAK this patch. The loop logic here and in posix_lock_inode()
seems unmaintainable to me, and waiting repeatedly for an upcall is not
going to scale with the number of conflict clients. I also don't like the
abuse of "void *" and "bool" in the synopsis of lm_expire_lock.

Let's consider other mechanisms to handle these conflicts.


> -Dai
>=20
>>=20
>> It's a little inefficient to have to restart the list every time--but
>> that theoretical n^2 behavior won't matter much compared to the time
>> spent waiting for clients to expire.  And this approach has the benefit
>> of being simple.
>>=20
>> --b.
>>=20
>>> Dai plans to investigate other mechanisms to perform this check
>>> reliably.
>>>=20
>>>=20
>>>> +		locks_copy_conflock(fl, cfl);
>>>> +		goto out;
>>>> 	}
>>>> 	fl->fl_type =3D F_UNLCK;
>>>> out:
>>>> @@ -1136,10 +1152,13 @@ static int posix_lock_inode(struct inode *inod=
e, struct file_lock *request,
>>>> 	struct file_lock *new_fl2 =3D NULL;
>>>> 	struct file_lock *left =3D NULL;
>>>> 	struct file_lock *right =3D NULL;
>>>> +	struct file_lock *checked_fl =3D NULL;
>>>> 	struct file_lock_context *ctx;
>>>> 	int error;
>>>> 	bool added =3D false;
>>>> 	LIST_HEAD(dispose);
>>>> +	void *res_data;
>>>> +	void *(*func)(void *priv, bool testonly);
>>>>=20
>>>> 	ctx =3D locks_get_lock_context(inode, request->fl_type);
>>>> 	if (!ctx)
>>>> @@ -1166,9 +1185,24 @@ static int posix_lock_inode(struct inode *inode=
, struct file_lock *request,
>>>> 	 * blocker's list of waiters and the global blocked_hash.
>>>> 	 */
>>>> 	if (request->fl_type !=3D F_UNLCK) {
>>>> +retry:
>>>> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>>> 			if (!posix_locks_conflict(request, fl))
>>>> 				continue;
>>>> +			if (checked_fl !=3D fl && fl->fl_lmops &&
>>>> +					fl->fl_lmops->lm_expire_lock) {
>>>> +				res_data =3D fl->fl_lmops->lm_expire_lock(fl, true);
>>>> +				if (res_data) {
>>>> +					func =3D fl->fl_lmops->lm_expire_lock;
>>>> +					spin_unlock(&ctx->flc_lock);
>>>> +					percpu_up_read(&file_rwsem);
>>>> +					func(res_data, false);
>>>> +					percpu_down_read(&file_rwsem);
>>>> +					spin_lock(&ctx->flc_lock);
>>>> +					checked_fl =3D fl;
>>>> +					goto retry;
>>>> +				}
>>>> +			}
>>>> 			if (conflock)
>>>> 				locks_copy_conflock(conflock, fl);
>>>> 			error =3D -EAGAIN;
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index e7a633353fd2..8cb910c3a394 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
>>>> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
>>>> 	void (*lm_setup)(struct file_lock *, void **);
>>>> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>> +	void *(*lm_expire_lock)(void *priv, bool testonly);
>>>> };
>>>>=20
>>>> struct lock_manager {
>>>> --=20
>>>> 2.9.5
>>>>=20
>>> --
>>> Chuck Lever

--
Chuck Lever



