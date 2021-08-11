Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E213E99CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 22:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhHKUlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 16:41:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25770 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhHKUlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:41:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BKH5Bp008658;
        Wed, 11 Aug 2021 20:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=w9G/iSGuixW/fGfmUnMpNmv2gMSO5RmQQ5uKeA6o4QM=;
 b=baYrbFioQuw9nAHanxw4MQRwpD5+3TiNGkdSYIOoHvn7beTydWljWTz0ai4d/hCFsgjN
 atJnQ6krBUkAk2dpiaYAHwR/xKemdTx6MBqA+h3Q1lD1TskJkxWFVzDfXHh5eVEK03oR
 iyHo+nbVgO4kqbHFXeML1eECPJFG3UALWsqqTq37Bb9dI/gmiL683OJ7oZi0TJZhlqPa
 2pTHncxsepsB6B4SfTzYT8sj8JXYrA/xV25VHVxFCj88KyxaClB/sK3FcbvMn6NUlFYz
 kp5sY+Bz0q7+65yGSLk4tBbv2sSh7zlEtXiF3CSJM9wOD4nafSnvk0iS4fdCsxDToPew Eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=w9G/iSGuixW/fGfmUnMpNmv2gMSO5RmQQ5uKeA6o4QM=;
 b=YYQfSZBeXTXSG3oGuxY6vbhqlRbjfbfFYRR0Oo+oh/M++QieZYYdEbLZzWtY9ykJ7AkF
 KPbmeWC6GF8x29MmITZyYXfKhGgEga1ND3CJj7zj6Q2hUyYnA4fk04hWFVMsvTf+Kul6
 bxizAwVli6g7Z3jvrKdvuzpu/t9HVPCu7/ThYtiPnYSIPSjWjdCLbdea6KwZhj5ymbx4
 PDs94VClkBbAE0N667P3N9Wa/21x4hVEpvQn2KSJ2G1i7YLuGFJnZZBQLiqfMlZIde5a
 p4VdMWq4CbZeeXa8TvnCBkehSRmqHJwLC4U4ObelDKemI6e8UZrojm5R8wkg6gOkqHgz +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd649d15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 20:35:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BKGIoh112245;
        Wed, 11 Aug 2021 20:35:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 3aa3xvsbd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 20:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4rJqGraOLxh4xiLur8hXm3vn9Px5SPJKfrgtbk+qn0AgN9oMrvUe2bPpgGglFf3Rem1oXVE+aP13MTHutzYq7WA8CtWyyhE0tIGMiO0Pu13csY9nhJASW0ylwMClR1A3SeRa/mUnxrHoJv9A9nzfqZtHGOMu7A1AUy6WpF+S8lYtXCqNMxjALBfYSl/5CzSxqSVfe1UKyTl9pkpRXdBIaeQExxo5ZHFKK75fRxJN6eOi+oWkWCIBgw1ddveb++s8CFWjJ3ueCGod/HO9cLIJ6zb+u5bNqH4yj6Dg7WYOBo16hIEOpPLk48OyX09QHlcu9pE0909Hn46v2hWzdCIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9G/iSGuixW/fGfmUnMpNmv2gMSO5RmQQ5uKeA6o4QM=;
 b=g+OjhUr0mbkiBYFeNuM/8mxcWzzPLRe1vDzYacY3aCVq8jlVg88MIN0eje5a5Ti0mstV9vbP6oqxZ+v1MRXE6WzHJPvC0kelxIBUCniZNtaXL/GU5uvIb8VOux0U1YBKUzUaXn3n6+uDPmHOQFVY5msCy+j2xgseOPmvy5mElyBR/C5AwWNwy6NwtfeFGRHc5PRZDAugZ5kzZ3XNV5COEs3wlc6ffzwHlPlx5WOAws7cQEtFN2MpWBK5gBtHSwCno/H6im1bP9MAX3bRhEbuQUxS26R8e5exJl1E0C8OVIqkILGdXLtAC5ZrVAlgqEfCBnkwm0VueJLz+uuc38xnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9G/iSGuixW/fGfmUnMpNmv2gMSO5RmQQ5uKeA6o4QM=;
 b=ibBm4H9KaUOx3AQGIy9Npi+es84krRVdIFWsDYElaSZ/frW76UDxwL6Wn2Wc17CJpbvObE69dvgp4xFsrT4HiWE3aN69lYRKkD0iyPjk1s9aLwbLG0QAva4Ve90m8eXuGkyzzjCL+xUGYyf1/uSNmFrAv0kJj/ZUozfBdjp0F64=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1702.namprd10.prod.outlook.com
 (2603:10b6:910:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 20:35:05 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f%6]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 20:35:05 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
Thread-Topic: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
Thread-Index: AQHXjvBecLHj6CuNF0ypEXBwDT9dtg==
Date:   Wed, 11 Aug 2021 20:35:05 +0000
Message-ID: <20FB1F52-61FB-47DB-8777-E7C880FD875E@oracle.com>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
 <20210811070542.3403116-4-jhubbard@nvidia.com>
In-Reply-To: <20210811070542.3403116-4-jhubbard@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3689.0.4)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a92e4ef-d080-43ca-aca0-08d95d0780ec
x-ms-traffictypediagnostic: CY4PR10MB1702:
x-microsoft-antispam-prvs: <CY4PR10MB1702664DAE730E707999476D81F89@CY4PR10MB1702.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTuBX3jZe2XmD10VqH0ZDSlE/aBoAjLOzzxubbKMkNzsprlzGEfx+S1y+aheaQiCqu/+i/Uz6oIUwE33sccmELWNqTJD+ly4Eawa8sD5pRz93J7k4+ewAEg/tvKqs1YBcW2RyLTyRPdUk827GyC5TWUzZX2tn1ugJopG7r1rvulQMjvsqOKEIqIcF5vW0giDj1Lw9t2A7TDG/XyeEhzTCJsFSQSuA5iaIvBRjHjCRpRY/hgJXUf0lcgK8c+SFR3EIeGjp9a6fcEDuQLcB39/zpJFF2aweMoOGqZ1iJgAuFfS6GkLQS0uNB+mCmsZ8qdkq19PlSLytQgOyabzhJ+ZCToK3coqL8DE46yf3mFHn1xlZntiWTj9E0ZrRll5eC8nKARv9JAay80o8roYaP8fz7S8jK26qdNc9IB8JckfHNx8IWKkc9iqNEV58NCvqF3V1pE9cDpbHPN8AXccU5tD/b/3PKLCxOqNS4ZNgkMnDjjSpWVXx8C0las73hdX9xtRcxqS5XvYJiLJGqOoj2bzstZS2K6o71GHzFRwEv0aajOpF882vjc2F6JXFLGc1Lsx5CpTwRvc6ZN253oDggxLGSadgMR8xf2Rl50Cvn2Siz9BlwGmm11ECkEGhPoqTJ5Gj7HpjRnhf46Rc61HcVH1S+k3qs4vsO51COWn5yYBY3UzSutdwOFnXG/atz0qjQiVV1zrugSZJTmDNrdsORwMW6X/rkGu9Jda63iyg5Yo/G0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(6486002)(6506007)(66446008)(53546011)(8676002)(4326008)(71200400001)(5660300002)(38070700005)(6512007)(478600001)(33656002)(66476007)(64756008)(86362001)(186003)(7416002)(38100700002)(6916009)(2906002)(66556008)(8936002)(83380400001)(44832011)(2616005)(54906003)(66946007)(36756003)(316002)(122000001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wE35fMa2fgF5dj+lWRxlrafURl44SN6ngEkztihNibM96IMH30RokYDm5I9W?=
 =?us-ascii?Q?DHbV45Z9fbZ1Guh9Q1dNjzyWZSHtjjQadyRE2Ovz4TklLgEcWrXMWDNNaD4o?=
 =?us-ascii?Q?erTk1A67FnSv+cFtD9+iL+O3zxoFb0mbOxxcLb7H43LJeUKsGyWY+/3vLZiz?=
 =?us-ascii?Q?5Dfm92Olt3G/+y5Hn0XEygsKzy1iCTvrM7rbP/w5TVjHMbgQxSIjLB/km/ra?=
 =?us-ascii?Q?p1ZiBx2g0ocxIyv6qgSBjKypvn0hxgHbMMnKxeEd+5jQKO6n7592vho+6/rQ?=
 =?us-ascii?Q?krJ+xMqMjrKWjTVM72GNDiQYHuXZRr4emWIWIN39rCMy5rUNXXl4Qd9sKzyh?=
 =?us-ascii?Q?C91E+gljevOctJ0xnqsX54TR+1P9hbKvGMg0g91VupewiOA3t2L6ZQRYbBsF?=
 =?us-ascii?Q?B2XOnyDlOhPNZKXtptkDf06g6VlLkgaKLV/D2d11aNSmp6cL6Dpeion2nFQv?=
 =?us-ascii?Q?4G74PXYkRflS1VTMj5+Dc/O3ZSy9zaRFWMgj++KRo3Jcft/12bOMSsx4chjp?=
 =?us-ascii?Q?ZDu9ZESqypddtQWLMh2xClzxC6k1HrsX5zHZbPl5bYtXGY9jEIeHSoUGOQaO?=
 =?us-ascii?Q?IvjEMfF23s5SUs41GiacYBZ7X+7FzqizwIeIoTA7czw5qJdRxCN3ihA35l+0?=
 =?us-ascii?Q?9Mibwveb9XnFZEcFNRe2cI4kRuc1Ewkm4ScfWZBkAtiCzwi/J5IWHXo3XcKX?=
 =?us-ascii?Q?Ke+tid57GynyHo109HhkARuab2W4zuoH5/M9JymgO5SceGavqv3KIs715AHJ?=
 =?us-ascii?Q?wJhu760J/tbDOglZ0mvOvQQwwFnJyTbBTCFyTOP96u3FOWB/Ya5b5EyQ/Fu3?=
 =?us-ascii?Q?QaJOi5Yr8szAkRTgv8AWFaDiMVOb+shD+4x2cUiO+u46BfCD1bHM+EJlP9Qx?=
 =?us-ascii?Q?9kwwf2UJ2THFiFLuir/x2pJ/dBUrZMOx9IaCyAZj4F194kJSpPeAyMCOaFrR?=
 =?us-ascii?Q?AoBaQsWL5XI8lJYZWUOt2oNCkg54/ke7T9NjpTWIRcDb3hmPQgsb2/2vbVWP?=
 =?us-ascii?Q?BwGcwSsnG1UlbuIOfwsaY+hsP7s4IUjVkka6Kt1/r9AA4GzFt7S05zHd+Z3u?=
 =?us-ascii?Q?HT0/DvniSfRLwjNk0EsgNLvT09oVTQJk01lSNDLnc5yEXq5y7abmFzwSuzBV?=
 =?us-ascii?Q?h+h+D5Iz1ns+M+W8iNhc25Yyu8QWXlpT72IS06HUIrmGGUfnJT5SkQNE99ra?=
 =?us-ascii?Q?ubmPQdnDoNS+Hq3+K+R4ecrkUU+gKolR65wpSDZYsfODPka3ydbt+9Yyjaqn?=
 =?us-ascii?Q?lJ0PO+aTD6caBGkhwZ4Njo7tSyA9IH+bWifz3qXsJ6NUalXXe/NT0W3bmseF?=
 =?us-ascii?Q?MA7ZoIqlas6bGB0mVGck9t4nDR8b8R3wUasWwOuUub1Q0ydzzvLL0cIgDD0B?=
 =?us-ascii?Q?emjOURErCF54REYahTmCxikC3+q+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46A3989F798F22439104A567DE57BF0A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a92e4ef-d080-43ca-aca0-08d95d0780ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 20:35:05.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfeJARspy+5tL75048TRSSHou29ClD2JXV/tgt2GzvqIJcErXI0FHh9LX3ykKdzCadexedW1b7HqxsxfN1kad7FDb2HKIknurv4j8KkPs1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110139
X-Proofpoint-GUID: uubmqvfjN-TfzC0r1s03azEgssFGUN9V
X-Proofpoint-ORIG-GUID: uubmqvfjN-TfzC0r1s03azEgssFGUN9V
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I agree that try_get_page() should probably be removed entirely; is there
a reason you didn't in v2 of the patch?

I'm also curious why you changed try_get_compound_head() into a routine
from an inline.

If you want to retain try_get_page() it should be an inline as well, especi=
ally
in its current implementation.

    William Kucharski

> On Aug 11, 2021, at 1:05 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> try_get_page() is very similar to try_get_compound_head(), and in fact
> try_get_page() has fallen a little behind in terms of maintenance:
> try_get_compound_head() handles speculative page references more
> thoroughly.
>=20
> There are only two try_get_page() callsites, so just call
> try_get_compound_head() directly from those, and remove try_get_page()
> entirely.
>=20
> Also, seeing as how this changes try_get_compound_head() into a
> non-static function, provide some kerneldoc documentation for it.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> arch/s390/mm/fault.c |  2 +-
> fs/pipe.c            |  2 +-
> include/linux/mm.h   | 10 +---------
> mm/gup.c             | 21 +++++++++++++++++----
> 4 files changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 212632d57db9..fe1d2c1dbe3b 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -822,7 +822,7 @@ void do_secure_storage_access(struct pt_regs *regs)
> 		break;
> 	case KERNEL_FAULT:
> 		page =3D phys_to_page(addr);
> -		if (unlikely(!try_get_page(page)))
> +		if (unlikely(try_get_compound_head(page, 1) =3D=3D NULL))
> 			break;
> 		rc =3D arch_make_page_accessible(page);
> 		put_page(page);
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 8e6ef62aeb1c..06ba9df37410 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -191,7 +191,7 @@ EXPORT_SYMBOL(generic_pipe_buf_try_steal);
>  */
> bool generic_pipe_buf_get(struct pipe_inode_info *pipe, struct pipe_buffe=
r *buf)
> {
> -	return try_get_page(buf->page);
> +	return try_get_compound_head(buf->page, 1) !=3D NULL;
> }
> EXPORT_SYMBOL(generic_pipe_buf_get);
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ce8fc0fd6d6e..cd00d1222235 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1207,15 +1207,7 @@ bool __must_check try_grab_page(struct page *page,=
 unsigned int flags);
> __maybe_unused struct page *try_grab_compound_head(struct page *page, int=
 refs,
> 						   unsigned int flags);
>=20
> -
> -static inline __must_check bool try_get_page(struct page *page)
> -{
> -	page =3D compound_head(page);
> -	if (WARN_ON_ONCE(page_ref_count(page) <=3D 0))
> -		return false;
> -	page_ref_inc(page);
> -	return true;
> -}
> +struct page *try_get_compound_head(struct page *page, int refs);
>=20
> /**
>  * folio_put - Decrement the reference count on a folio.
> diff --git a/mm/gup.c b/mm/gup.c
> index 64798d6b5043..c2d19d370c99 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -62,11 +62,24 @@ static void put_page_refs(struct page *page, int refs=
)
> 	put_page(page);
> }
>=20
> -/*
> - * Return the compound head page with ref appropriately incremented,
> - * or NULL if that failed.
> +/**
> + * try_get_compound_head() - return the compound head page with refcount
> + * appropriately incremented, or NULL if that failed.
> + *
> + * This handles potential refcount overflow correctly. It also works cor=
rectly
> + * for various lockless get_user_pages()-related callers, due to the use=
 of
> + * page_cache_add_speculative().
> + *
> + * Even though the name includes "compound_head", this function is still
> + * appropriate for callers that have a non-compound @page to get.
> + *
> + * @page:  pointer to page to be gotten
> + * @refs:  the value to add to the page's refcount
> + *
> + * Return: head page (with refcount appropriately incremented) for succe=
ss, or
> + * NULL upon failure.
>  */
> -static inline struct page *try_get_compound_head(struct page *page, int =
refs)
> +struct page *try_get_compound_head(struct page *page, int refs)
> {
> 	struct page *head =3D compound_head(page);
>=20
> --=20
> 2.32.0
>=20
>=20

