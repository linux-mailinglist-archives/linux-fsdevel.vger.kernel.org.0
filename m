Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05D64C17F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbiBWP7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 10:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiBWP7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:59:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32CBBE0B;
        Wed, 23 Feb 2022 07:58:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NFZ3Nx028019;
        Wed, 23 Feb 2022 15:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8yWWEApGT6VeQ8U3bJOPOm7SHHF8Aa5itP/g3Tm6y7g=;
 b=KceisjE6v9B+aSKfRg63d2q/sssxsCu7l/x7hD4VsXxzOjuAGEGxpWWn01MVTiBfI6hH
 b6v5JxrUYe6J9TtY7+D0t285S2wzEP/caeGUTdrDdNdRAOqzxWW9kDsDYGerx9pJHPuI
 Q1uoWZUUOFnFOnsxRQbkvrAlvWoE6kj/3mIg1iC/iAy2xIMuglqmWY+fryFWsFxteuSH
 nebSiq1fBe8kB13E2eoNAqS1VmQ781IVKFLYVA6XD9lY7c3Wy3ll+YS0gotIREc9T+zh
 pGQVF0wbJAMUn5S+8o/1sV1DO9rWG9ltc3gGVzIeRQqS6ix8O5LTlIZbjUeS5tZXaDRD Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cmhrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 15:58:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NFunbH192193;
        Wed, 23 Feb 2022 15:58:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by userp3020.oracle.com with ESMTP id 3eat0prd2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 15:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHpNXHWboo5WObJuYYb+rKpWPyJKujeps14FHwWrqiWnk5rKfwQTIIolw3Cj2rxFBXyBUib/cONyWS7gy4GLwDrmOWZLmMGUOtOP1UMXosc4+JRJFc1CimG/H1eXS31DNTsAnBTP+DyN4gK5UT7sIBQVd+bDrbZERB7Uc4zrbESFm//QIqsMcmzSl15NZNYcvkIfLaEy+etdy5y9KKL1O76BebPu1koBYdmOl3p5AZaNzcjig76+K8gaxoMsH0AagD73CuttzjNH50xamHZ8viH//EjqZu3sJF6SooCcTFM863SJB6D6eVWSdGzaCXPJcV+5p9csM/C490MVQ2nRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yWWEApGT6VeQ8U3bJOPOm7SHHF8Aa5itP/g3Tm6y7g=;
 b=IJTK/xyvKxeV9CRDqqZkW1QZemO6TZhj0j6akCwHgTKm200wfczBlzWub52Wos+5qjnBl15QX7iAgbOkp+/6uXmE90zi98ozgCjktoWf8wswWzE1NH9nbvn/ezaxtqxzulyTinwMepdSFCxX6FeON48vchyci2MvgjLnWlxDGp78ZVazVkrenbAdKrXHj3fq4CgLoH5QgUdKH2QagXoCFtRq+dz2urZ0cAXcpBg4A7N9amOjZbFfMvWWbV9hDNXiheq9ESqkB6b5vrwXn/e/EFJDkXWEP2+mdFEcdM79pZRseOF5JzfZZnGQxzuKGdd0NYrxTTBroHHiG42WcFBr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yWWEApGT6VeQ8U3bJOPOm7SHHF8Aa5itP/g3Tm6y7g=;
 b=DHV+AgFY0xrKuu0QbJ/IH0HM6h9BebqmglW2dcinq7w78YQqE/VylsEfE9FMpPOFyMdCR8JlNcj4V3GV1rWwb11I9ao1cjHA/2h0qYqy+tu+wXGXeFgUV4kQLHThcmBU+cZAqDWoDSb4jDiGYVGyxaj9VK8TKtVqiX91WEO5ZG0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 15:58:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 15:58:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 22 (NFSD_V2_ACL)
Thread-Topic: linux-next: Tree for Feb 22 (NFSD_V2_ACL)
Thread-Index: AQHYKHvjd7nIQ/9dd0WHn6e/zlcx+qyhS2SA
Date:   Wed, 23 Feb 2022 15:58:22 +0000
Message-ID: <EEADAF6A-04D6-42C8-9AAE-7D4EFB2FA507@oracle.com>
References: <20220223014135.2764641-1-broonie@kernel.org>
 <5ef34a6f-c8ed-bb32-db24-050398c897a0@infradead.org>
In-Reply-To: <5ef34a6f-c8ed-bb32-db24-050398c897a0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd317f0-9e8d-4413-d01c-08d9f6e55164
x-ms-traffictypediagnostic: SA2PR10MB4697:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4697B1737F8AF37EA6E8B13B933C9@SA2PR10MB4697.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9IlK5yflomrbt8wmZqE38iq4RWaGk5JV2VTyT4wUL2xqHAIwfUO6AHDidTbBb9yDgh0afhRYVdO41oWifKmbhVPAxDdbDk3PbGl36F+z+xHr0sU5CwxVJ8Y7Kns7kA+NhbSwzE2iyt/1YZliN+sZjj0rVH4hX7qI0+9daVArkaHWIlnEo+iRa0wuE44RW9totk/TFWYUb2ZV0/TSRqIZ5YQyhCbn0Fz0qHna++iyUuLyUFXtrJpcP0wbqtLHn5UisSyxuHXaz4L4OMVEWvREJac5pbzU+A8rIfCxeA8zJtrTfzvj/CMhT05donuuPwrh8jFLfegut6PS0gYzb1Kd/aptac4Jd0cHK1sYh1ZM4aGXfY2h2Ii06Vh3yJjlQn+zBxRMPyqhv8YC1FW9hWHrCxnyR6P3fYbhklb14DY7qZLeHzFENx1nONP5DzsPRZJL4tEg9ocplfBAl0uR16wZbzfENOaLOZgY6llLb84eQU8H2FxSBReHWUvUSRlzYUS7KAHe3pWN/35vVMMZfJ3I1aRgFOwAcDXQfVjUfHH1CypW6ZahmI9Af95JN0tByPDPNubcPR8vWnuJvb3BmMEzsPclLBBDo2n4ELuDdO5VIY0i/7/Sr/sKiaONoqYjjAHbTvnGLh9Y6VWgN8SuzoT093jbsce/ZJXJpQXz1hL/qN0GxdBTLNTHBH+prEYbk68TZA+mHorBZCnQcsDMUJYrn1+FYzKZaDjx//JxKUhMKiU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(66476007)(4326008)(64756008)(8676002)(316002)(122000001)(66556008)(86362001)(2616005)(186003)(38100700002)(6916009)(54906003)(76116006)(66446008)(91956017)(66946007)(6512007)(36756003)(83380400001)(6506007)(6486002)(8936002)(4744005)(2906002)(508600001)(71200400001)(33656002)(38070700005)(5660300002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NAaFLhYr6wwBxfAWVLy0y+iYGP+FF0KJsWCzBVF2TqIGfOmppFyo9TzxCEZU?=
 =?us-ascii?Q?6FFnEAblemzH10Z8EL40+h6VV1cR+L9S0U9wKMCfUVeaNutiPSkNtxRiOTn/?=
 =?us-ascii?Q?QoZjTyzlxmfBxX33Izjz16VRPkTiCOeL3Zeg27/5kXQvMHQA7HI9ZUYGD4/u?=
 =?us-ascii?Q?pPqw4tQAkclQlP9bQPMtJGl8rN/4+9rwK87V5fGA1eFXfvVoGOdM5Q/H3V/U?=
 =?us-ascii?Q?LSh2iMfwtKsZN4nzdSgqtQnbSY6/MJ7GRu9xS9zb9R8yTOXU6yToxMVx5oAa?=
 =?us-ascii?Q?+f3T47Yth+xR1cn9hm0KaYcU4uKV2uhZOcneuIjdWkGM096xI0xKmI/b2a1K?=
 =?us-ascii?Q?1/mtO4Q46U27wexXvGIpViU/BDWhMOxYzARcLTCUqUtPkLQSlICEdOLEMrXK?=
 =?us-ascii?Q?k6UfTQv4W47TswZRUnl68PJf2qtRhAaDvKKSarA2+62td1nP2zaAI/ocLeFX?=
 =?us-ascii?Q?XqYSvcNoAe519AoxJIKi/iHtSahwgzIxqdUQ5hvgoIB1fZ0fvnTwKzQj3GpR?=
 =?us-ascii?Q?8Kf1KcpzbK6xPCAeAb3gYlFvX66HwjImsiOZbBfBZ49m/6ccaUrVh3iRo6Cg?=
 =?us-ascii?Q?LCKvANyWpyhQkM/0JO8FCL+WP/j5DAULuhppG2n7BPz6VXurabNXqvSJcltO?=
 =?us-ascii?Q?V7snmyjnJK0SjTw8kCdRtTKRG1yvie90AcTfUYuETc9SgLRJk95peekEmOlI?=
 =?us-ascii?Q?Wy6LydudnsS3eOpRNsEncdUEyOtH0nTLbjAllzDymWSgl4klfqlzbfob/36F?=
 =?us-ascii?Q?IWthqZG2j7G1l6zGzPcVWMgcXWjE52fBk8Avm6JaKrYVagjXiqmEBob3yqgL?=
 =?us-ascii?Q?yDzbKauJQyMRDNDmvZbg3WAjnH/d2V7Sltc4R1FxOybMJRP1og8UmtOlaL58?=
 =?us-ascii?Q?b2peMZmWCNvouQtxukzyiLrCs9nImpTAD/aHwLEYzPvUBuSINo1QIwAc/USf?=
 =?us-ascii?Q?clPyf1wqYbJxVzSiqmAMw9KZ+YJFw1qjnZUoX9Ht/Dl3LExFrISPD3VOLpsW?=
 =?us-ascii?Q?+s0Bv8joXLPNPtCyxc2zkB5uY+BQDN5tGJBB2VxXRnY9xmrVbbvponfOu/KJ?=
 =?us-ascii?Q?PoKeVp36ZMcaitTP/S0JL/hy+7RjV/DZBSra0dNB4kO1Y6CcOyh7hsCp2a/R?=
 =?us-ascii?Q?R4QtYAmXosLQHrvN9ZRJuNKjJbcXmjXaHc3qJsaY+lMJinAM7YGz0wwxzcu7?=
 =?us-ascii?Q?408GS9QR1K+LXaWv0RpB66lsJJfQ3Tm13NyRzQ7quzIOHzNQZ1DetpRWOeja?=
 =?us-ascii?Q?dP3Ai208Jhw+b4PCiDrMnxo9d29Zc+KA9cNHA6jvlhKx49egQAsHpAfmtn8P?=
 =?us-ascii?Q?wZ5NyFqou2XqM9lih5rijLK1nC3s2/GEuU4P+ggCUaDbgX7b1qklutaUgTa+?=
 =?us-ascii?Q?zatqYE0+pqg9RgTHleQGP4tJYtbC9vrl6INkcgIjm1myF6PWZ17WMjHRzeIZ?=
 =?us-ascii?Q?KsMtQZQUdvEUouz1xDxyx9E19DHE8Me9lqqo/dc8EZECNJ+7CVvq6wcCAbCu?=
 =?us-ascii?Q?r0l0DTklUcS+BKeIuZcLnNmDMyDPzUj2yFsccSLFyF1S8LtyEABF7XHTDbqZ?=
 =?us-ascii?Q?Jh8rJktyVOq2q0dps06qO2chMCzEGNKGadkgLHm5eBtyYumFmhK5kpoAo1nH?=
 =?us-ascii?Q?7PX+Hg9P/ZwFd3M95U8k328=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CD3104D86D2C04FA1BEF89508EB9A7B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd317f0-9e8d-4413-d01c-08d9f6e55164
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 15:58:22.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yquMfSyfGDq3MIjfXE55sL/tJXWlWxZsoEdKTgS1BYuK5SOnLxIsI8DFy5eSYD3fa+GApCr/AzFZapkkhWvK5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=968 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230090
X-Proofpoint-ORIG-GUID: bS-FBysIlcq1ftzzK91-Ig1lNlNaSI_1
X-Proofpoint-GUID: bS-FBysIlcq1ftzzK91-Ig1lNlNaSI_1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Feb 23, 2022, at 1:08 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> On 2/22/22 17:41, broonie@kernel.org wrote:
>> Hi all,
>>=20
>> Note that today's -next does not include the akpm tree since it's been a
>> long day and the conflicts seemed more than it was wise for me to
>> attempt at this point.  I'll have another go tomorrow but no guarantees.
>>=20
>> Changes since 20220217:
>=20
> on x86_64:
>=20
> WARNING: unmet direct dependencies detected for NFSD_V2_ACL
>  Depends on [n]: NETWORK_FILESYSTEMS [=3Dy] && NFSD [=3Dn]
>  Selected by [y]:
>  - NFSD_V3_ACL [=3Dy] && NETWORK_FILESYSTEMS [=3Dy]

Thanks, Randy. I think I've got it addressed in my for-next.


--
Chuck Lever



