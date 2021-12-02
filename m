Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF9466971
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbhLBR4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:56:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47164 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376467AbhLBR4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:56:40 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2HWrYl029851;
        Thu, 2 Dec 2021 17:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9h9qoq0+5Z1DfSw+DOfFfPwVbbJMS7VhADby13ONuAg=;
 b=gmfRQguMhFuV4uY1imzP+i8lBUZwZQejTtoGLjt816yUctQrJ3tZFWdoi1rQFOJdbqwz
 O7WDjXFXZ3nfWskQeYLTkaaMQIeCqhh358WHKwsje0rVkXrYwmJt4d09u0BcG/U8AXKD
 llXCgm6RxCeJ7l1G6FQOL47toahPMqr25q2xQdgl82OV9u2B8mFI5ffBcmydutx0LgvQ
 9NBd22hPH6U6QppPYAqzKfoR9YmzsECUAgnG4StYttv5InogDgW8L0DFZDR0N4Y9rKxm
 fIMD5NKP6NMhuQra7LqEYvO1V58im4qwV2H73wGhathK/+0+tWFQ+0Dah4TtR3QcUHM7 Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7wesxdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 17:53:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B2Ha7SP053946;
        Thu, 2 Dec 2021 17:53:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3020.oracle.com with ESMTP id 3cnhvh30dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 17:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8dQzcAKip7T3Pl0MMsFoRtH5sU7635xJ6quq9mRaTWuJnyHWlo+Ld2CaVtP2JD3L1IWVRFUhrfnh61ebY5bYbH6e9jE6a5lcSnIyzLuSmmWKEwuzeNQx5I0rsORPCJQ3X9pM7TlLGyGTzh4DnruQAng7pVT4FB3GJstmrqtRBdpkClYB5BhB7Gt6Tg3fvBqqUUn7R1wKsJHXRvVeCQmXdSkrgd6M9VMWjznsDPEcsxCIl+VoeNOdisYYMUmTZ3f9+RPKnpNqwhvlZBHuRW6riDdHPub+3QH9nhkcvlYKg/P+hMWjXcKOJ9scRV2BVKZApNCl3XcT1PIpbHyj2LStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h9qoq0+5Z1DfSw+DOfFfPwVbbJMS7VhADby13ONuAg=;
 b=GlrVVq+ZjHb3Yzf+KokSy3Z2BogyDA0lABqVXQKckQAjWkssS8GzFYsQ6N9DfQ+Abyd20P1kqFzTyOEZgz3VN81AT19PtAciMTFdbYbSTeljFzvomWxoX72uCQAkDMdmkMzSMt6i/rUSlWcFcKml7H1yCtty/2ScWb2ZJcHk9XSjBxBrr3fJzgQlofuR62w5BFoG/ln+MUOoJMsMZlqivS5MOOe8+o4tpgCeI3fhSRzVwlYTl3Izz7vSlmvFwaMYYNLjSUQJ0jQPpNC8lc6NjMBi79ljOro0edJsMF+LBKiwzXwnsORr5h8rsivD4stWEHGqxnyb67j3UCzwCEByRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h9qoq0+5Z1DfSw+DOfFfPwVbbJMS7VhADby13ONuAg=;
 b=M6UacFI2P1vaeAuI7kdq1BUHld9HEyi55yqoCfwkhqBB3BWlwJVvwNDbssNKspyUK8rjT19sCBaXm8HhG9iKwjtCKJd+Dzgcao70mIXYU4pT8BnK6u3bICFDKS38x/58KYlr4yGL0DlXsgqCVgGIyrQKyrlqFoepBVDXtvTdidg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5661.namprd10.prod.outlook.com (2603:10b6:a03:3da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 17:53:12 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%9]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 17:53:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHXtMzhlpWZW1OG5ESdBSdOgoHETqu+oymAgAANi4CASGLiAIAA/bOAgAA+8oCAAD8yAIAALy8AgAZzIgCAC+1zAIAABPIAgAARGgCAAAipAIAACTgAgAAabACAADKYgIAAGWS/gABccgCAAItQgIAAzjSAgAC0kgCAAAQjAIABxScA
Date:   Thu, 2 Dec 2021 17:53:12 +0000
Message-ID: <E51988BE-DBDC-42B8-9047-14DC1EDD4BD8@oracle.com>
References: <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org> <20211201145118.GA26415@fieldses.org>
In-Reply-To: <20211201145118.GA26415@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6116a74a-b33e-4a19-4a59-08d9b5bc9c42
x-ms-traffictypediagnostic: SJ0PR10MB5661:
x-microsoft-antispam-prvs: <SJ0PR10MB566130890056D08DC770691593699@SJ0PR10MB5661.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqmVaWETKKs64oCIBRF8kfztARa5f/lB4UAmyrGa0dsgMm0bN8VJBJQlXkGk8w2d16lQZBVvdj0j5CQILjMHrebM4QuLF0DhLAxBA0wKaOIrceCMOkL33B0njohfCyfag1cg72Hc/WelDi8YIj1dx+gdsMTswt7EzEJ93bDe4zR9I+NubCnmOOm3p4ijsu2dusm2qDdmKZtlEXDm4//wbgzgB1cg/ABzRZXo/SXkpe6X0aySYo/Ms/4nO/e/7TLdwCwV5/ZJz+BEaCF60oiyfW9ZIgFGvc2U6Ys36cbPE6dkW+eS127hdZ+jzU3TZijVUAjUFbLYZcw5dsbj8xubp4xywJpnAHKG8L+6O4RZ6ZvSQ/VXkwTbrpJTNRrrJa4DaTlwxBprtdTyNrphOtNtFu00ozew0p8/1PPPbxHtn3p1rPCg9xRUNzVDuA8SA0KA5B+RxX442S2o351HpqY8G6J0EKyw4j6bmZfpVEYJmTAfhwzKb24Nq/nImMno1avJXHb6r/KrdNKGhbZiiISuljOzKn9ttvj5lqIlnuGAj+ynMpTcW2ibcZ0gZsT0mUiTBSxJM5mU0YL8WYuPHWhIhOdSeKTnlICcTQizHrZNpnRZyKcKUamWgCBRnlZZAb96cJ77fwlx6Er4mmEC8cc8j1hffNL2ALpsSl0WC6zfXCScyz17hWHMlzq/Yc8Bcq+9Y7oJYFpUSMWDhy0YZtmeP3ef8ftvi+MUXUKB56y7v0GnYRMHOXrAOvkHrla7P088
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(316002)(2906002)(54906003)(26005)(76116006)(36756003)(186003)(4326008)(6486002)(8936002)(8676002)(91956017)(6916009)(53546011)(66556008)(4744005)(38100700002)(5660300002)(64756008)(71200400001)(122000001)(66446008)(2616005)(66946007)(6512007)(86362001)(66476007)(508600001)(83380400001)(6506007)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x73jIsxaEyr16t/g51b8cjo55SGUGorA8CJfJlZPXX9qFwariI4e50+lCJAo?=
 =?us-ascii?Q?MSMKtQiUrmcaHUw4MrhraIw/shWchLNZymbBQ9HGniZvCD/VXx+YWRRFwfUI?=
 =?us-ascii?Q?ZzsHKPVySIv0HHBmWvajxGIS9iTmprcxHT0I9ltUBtCjX76iiE0Ku7em847M?=
 =?us-ascii?Q?fxWbidYL+HHuojNTxbAsBzjM2jEL5J7c57cAf8ZM2FU5luvgCbcxxVuCpJZT?=
 =?us-ascii?Q?uCsvGogLnoX7NDqqSDnUfpsYvxeT4VU0wynoRQDWwvic1aoFbyG2jA5Psdmp?=
 =?us-ascii?Q?gV/bcPP5xKstjSXbLYfaPMl4PyLXBwZdD0YtBVkWeTGqFWyRHdGcCPa5+qTY?=
 =?us-ascii?Q?r+fM1DTyLiR2J2PsDqrKtT+dh6UdnLAxEhX6LLsmjlL6RcGE0jvRuXJy/nkF?=
 =?us-ascii?Q?y/EvtrFrcJ7pzBSdXRBzxe2ubs6J9ueXS7v5wPKko5u1L9GYFHcwdvVOnwb3?=
 =?us-ascii?Q?ON+fejYqaEN26rf00F2vPiHjoXuORYsod9y6AOG0nY3f1j4aOti3QKHHLchy?=
 =?us-ascii?Q?VvCgqBt/rnPIWRVMH+CTnyQlWi43X0PiGk1+ZJ7NCUsAymY/8IQmvp8Pkhw/?=
 =?us-ascii?Q?owx4bqvww9IZRiHMwQgkUYvAwlyKGKk2d8HXj5BwcuLgDFj+9PONg9T5rUGi?=
 =?us-ascii?Q?7rP+jRdjsGs7PH3S4DsovtGImIzj8VKBKsE9XjyQkDPShxocACcz/8EhXTJO?=
 =?us-ascii?Q?eZkG9Ngkxv4SIwwcCqrin+ojjnnmFhg4LXCGhW2+v48DLU7zWOhuoLIoA0GU?=
 =?us-ascii?Q?CMGaz/7b6MHemdZ2rPnpgi1qDUQ56pPD8OyuitjeeBr2E0QjGJ/ygItfnMXg?=
 =?us-ascii?Q?wZu9tMG8MDBWiOGTwVY3mAtgoXSG/PR+Qpi7l/Ix7qLIKXdMPmQ4e6jf3YAc?=
 =?us-ascii?Q?zJCyDliT9GJL6Xl+N5MOVWlLqERA3gTKQnVyohvbYFL8KeCnW1uo57zdH5LQ?=
 =?us-ascii?Q?A9xRjYVnW+cy3AgDMfMWpC9pktTzvV8CXbA22O60zFjRVyZoe+xT+Pqjptt0?=
 =?us-ascii?Q?igzQ+VJf6GI3c1Wf0eS6P0pRbpDdwGL6kqimCKfAUcUJ/MwKXTIB7/Py9NJI?=
 =?us-ascii?Q?xRiSKqGbs1JxG9sfgsc/zWqCNewu3gBnH/KqjpY6zIsQ43XiaQ/EJ+UtIVZm?=
 =?us-ascii?Q?a4Qk2OVHuYqxNDEe8Dsulie3SMzKqDdelurSDjG1cEXK4M9wu75xamxQ9SWe?=
 =?us-ascii?Q?I6BuqUq89ZGTG4Hg3uM6ZffeodBQIuqWt/cZtX4E8Pe8Mla+43UYTfImdGjD?=
 =?us-ascii?Q?6xk0K+rfjPNzVvarcY4ByqPgC+RlU9lLQHI3D1CoSanZRdw0jw7Lp63YORnX?=
 =?us-ascii?Q?enlYR/TQ/kQbzwn1EZbpY7F9tFmvjJMJe1LGoZunsQGMZxCfpvMGUvcWqVQm?=
 =?us-ascii?Q?4RQKaJ9CV4NN3r9apsscK94bwD2qVgSm6O6/O/39nsln8m3Sw+Dn0CG+9VFj?=
 =?us-ascii?Q?/7m5QmgabW+Y0ScFWWfpUeokRG3S/jXYbAk6ZZs9Wx8yxg6dBUffLTnE1Ive?=
 =?us-ascii?Q?yr3wZbNHclbSx8ZmQ2iY1fmS44xlXFsnGaF9XesQ7gvD2plEVIfFcRb7dyAF?=
 =?us-ascii?Q?oYdKzRV5H5GyKM1ffCxjtl4NDFeyV4yW17Ei4FDcpIEYvpXar+Qjf8uCiqY6?=
 =?us-ascii?Q?y0XKg51JFw42o/fm+IWGaQg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A10FD1E3A158FD468D14191449E9030F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6116a74a-b33e-4a19-4a59-08d9b5bc9c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 17:53:12.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPk4BgOfIIBQe5yR1hej/hJ6CjluutwQXlGWHPB2DAMfehnVw/Yn1RvWXHKYyKLET8nZbS4hooOvxNfom3BR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=689 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020114
X-Proofpoint-ORIG-GUID: p9VWCZguILjdfj0dz8UozRipjhu0htCz
X-Proofpoint-GUID: p9VWCZguILjdfj0dz8UozRipjhu0htCz
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 1, 2021, at 9:51 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> Do you have a public git tree with your latest patches?
>=20
> --b.

Dai's patches have been pushed to the nfsd-courteous-server topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

I can fold them into my for-next branch if we agree they are ready for
broader test exposure.


--
Chuck Lever



