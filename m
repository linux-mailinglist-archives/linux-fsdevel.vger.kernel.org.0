Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C03E70D86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfGVXoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 19:44:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2660 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730565AbfGVXoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:44:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MNd931004143;
        Mon, 22 Jul 2019 16:41:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I6NfZ/h0TqHGegpRPCubSw7E1tnooAbYDeoRHVtw884=;
 b=bWB5wfGewSF7ysKOkJyD9y5F2ZOBhAqWwXXOhnuB2RmHWYgNmm6SCMbZkMVp2eF6FqPf
 DtHi72I6JNnT5zrNeWoAqtoZQnTWotB77VpO1LN3sf8uBNrk8mLTKwgcyEaSg+WR4eUE
 UoOBG0ScoaCRwSd7MU5T7RKTBjGtISOrdHM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2twn9ngaxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 16:41:28 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Jul 2019 16:41:27 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Jul 2019 16:41:27 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Jul 2019 16:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eniDSj4dLF0h5OOJnm0eVmmEX0kJpMnToL+Z5vAcSDfUpPNzOhZTrViN0UbV9Nfb1p5jXRV4HS7WPIuyT4Ize9JBdsCJyD5wPZZH0JUL1jV9jJntbSBNRBcOAP/booxkFMio7vgBnSlLeB3eoHaWcbCzS8V0E4fTg4ptj5AidoPQHEyWM3qeSFmVXN4QEd/JwTQUYwN1mRh0RzjZMT5nCoDKHjBZX+3ejZy9+H5kf84e+QaEvENSSx0Lh9vsTsxp4SDf1Y7FVRcGnqFZ2W8CWZyFjipVqlEzU6unq43Di90DVUKYahPjiXgKIEJsfWMJwwGNfcxkmNyWuDUbphQVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6NfZ/h0TqHGegpRPCubSw7E1tnooAbYDeoRHVtw884=;
 b=DoQxjThzj9kCaqGKxUs1kVDXViDi+BoON0dwTTaeWVZDLZqtuPRwZyYaR0bdnSi1CqZwkFuZaNpzkse+lm2CmYNOw7ew6V6jhWymlT3bTVc9qmY4yWX5DMMWBZmUaJqpItwBJG49ErWYKILuGWhqu+163C6iA84FC2Z1yL493PU5C1NSluIH1aN1btcRNyUNBd24d5z2i/H0n9fi2+uoEAAMoHieOdbcqYEhLUMNtDmFjFUOh+rAJ4PxtL6Y/tJiC98m4Zn3W+72qnKk95sogpTNkG7R8Tu/OP//3hAjBsi8GMqFXG9HJgJlW+JezIMMOpfc/A9g4LuEgdCyqvpDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6NfZ/h0TqHGegpRPCubSw7E1tnooAbYDeoRHVtw884=;
 b=h1jpRJOsgCzJ7p1ySxAf5xWmNfNwku7CraWE48XLh7okEVzxczgBsonqiFG+sdZqfALUIGoGESyXcx0GkNWHdV/tbcZHYgCZokz9l8cnnAvBfb0v360b3XCDiD+cijUSglmNQ0l6tv2WjAyWuXo5xxbguRcgO+iRdCf3d9BppiU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1198.namprd15.prod.outlook.com (10.175.3.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 22 Jul 2019 23:41:26 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 23:41:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v9 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Topic: [PATCH v9 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Index: AQHVKurnm0pZpZevHki8fTgvnJjHiqbESjWAgBMt6IA=
Date:   Mon, 22 Jul 2019 23:41:25 +0000
Message-ID: <D2D86FEC-6AAA-4051-A58C-27F305F310A8@fb.com>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-6-songliubraving@fb.com>
 <20190710184811.GF11197@cmpxchg.org>
In-Reply-To: <20190710184811.GF11197@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:c799]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc390eae-4e6a-472e-f34c-08d70efe1c86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1198;
x-ms-traffictypediagnostic: MWHPR15MB1198:
x-microsoft-antispam-prvs: <MWHPR15MB1198049AC116B01346E4E3BBB3C40@MWHPR15MB1198.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(71190400001)(6246003)(81166006)(81156014)(316002)(76176011)(6506007)(6116002)(53546011)(305945005)(71200400001)(4326008)(64756008)(6436002)(6512007)(66476007)(66946007)(76116006)(66556008)(7736002)(66446008)(256004)(6486002)(14444005)(476003)(186003)(2906002)(486006)(68736007)(14454004)(8936002)(8676002)(229853002)(57306001)(86362001)(54906003)(102836004)(6916009)(25786009)(478600001)(46003)(50226002)(99286004)(5660300002)(53936002)(33656002)(446003)(11346002)(36756003)(2616005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1198;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fTR1i/LKTvXLh742Ol9lB4spEwORWJUnasJXAlxSnNj1yggM53uXyCAykMd0ZBzPF2ZsD1sBzmYVuhgflfnSdyw0G9U7b3hf0KvHcecD3BSufR5KsS+XhB+C6O+IqLrrI1Po36Eux3CVo0qCg6BfcxK5RKrLjJZFyMPUwJWZzLab5ke1JbNHpa7C342towggOB4LOg8P8sfeSiA2R51AAi6zhVQYo1AodRhuytY2zq474WY5OLMVzrdZMy+CV3Wz0i+o7w1JV9wsZSrhM0C2pkN1uAXjGQ2e4VpKPvFVe7ptVflYl0dsoJBFQ6q1pqlJJvzjbsZHkNixXDlKP8tctUAViKQJU5oFiVuKp8TxWl8oP14HUVaocCTHpuskJsAZq4rxqyuoI0WaXtKKlg709F8JvjK6aRTDsKuWYtsxbmY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2D0730775384D489CA840F0BE9ADA62@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fc390eae-4e6a-472e-f34c-08d70efe1c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 23:41:25.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220250
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 10, 2019, at 11:48 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> On Mon, Jun 24, 2019 at 05:12:45PM -0700, Song Liu wrote:
>> This patch is (hopefully) the first step to enable THP for non-shmem
>> filesystems.
>>=20
>> This patch enables an application to put part of its text sections to TH=
P
>> via madvise, for example:
>>=20
>>    madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);
>>=20
>> We tried to reuse the logic for THP on tmpfs.
>>=20
>> Currently, write is not supported for non-shmem THP. khugepaged will onl=
y
>> process vma with VM_DENYWRITE. sys_mmap() ignores VM_DENYWRITE requests
>> (see ksys_mmap_pgoff). The only way to create vma with VM_DENYWRITE is
>> execve(). This requirement limits non-shmem THP to text sections.
>>=20
>> The next patch will handle writes, which would only happen when the all
>> the vmas with VM_DENYWRITE are unmapped.
>>=20
>> An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
>> feature.
>>=20
>> Acked-by: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> This is really cool, and less invasive than I anticipated. Nice work.
>=20
> I only have one concern and one question:
>=20
>> @@ -1392,6 +1401,29 @@ static void collapse_file(struct mm_struct *mm,
>> 				result =3D SCAN_FAIL;
>> 				goto xa_unlocked;
>> 			}
>> +		} else if (!page || xa_is_value(page)) {
>> +			xas_unlock_irq(&xas);
>> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
>> +						  index, PAGE_SIZE);
>> +			/* drain pagevecs to help isolate_lru_page() */
>> +			lru_add_drain();
>> +			page =3D find_lock_page(mapping, index);
>> +			if (unlikely(page =3D=3D NULL)) {
>> +				result =3D SCAN_FAIL;
>> +				goto xa_unlocked;
>> +			}
>> +		} else if (!PageUptodate(page)) {
>> +			VM_BUG_ON(is_shmem);
>> +			xas_unlock_irq(&xas);
>> +			wait_on_page_locked(page);
>> +			if (!trylock_page(page)) {
>> +				result =3D SCAN_PAGE_LOCK;
>> +				goto xa_unlocked;
>> +			}
>> +			get_page(page);
>> +		} else if (!is_shmem && PageDirty(page)) {
>> +			result =3D SCAN_FAIL;
>> +			goto xa_locked;
>> 		} else if (trylock_page(page)) {
>> 			get_page(page);
>> 			xas_unlock_irq(&xas);
>=20
> The many else ifs here check fairly complex page state and are hard to
> follow and verify mentally. In fact, it's a bit easier now in the
> patch when you see how it *used* to work with just shmem, but the end
> result is fragile from a maintenance POV.
>=20
> The shmem and file cases have little in common - basically only the
> trylock_page(). Can you please make one big 'if (is_shmem) {} {}'
> structure instead that keeps those two scenarios separate?

Good point! Will fix in next version.=20

>=20
>> @@ -1426,6 +1458,12 @@ static void collapse_file(struct mm_struct *mm,
>> 			goto out_unlock;
>> 		}
>>=20
>> +		if (page_has_private(page) &&
>> +		    !try_to_release_page(page, GFP_KERNEL)) {
>> +			result =3D SCAN_PAGE_HAS_PRIVATE;
>> +			break;
>> +		}
>> +
>> 		if (page_mapped(page))
>> 			unmap_mapping_pages(mapping, index, 1, false);
>=20
>> @@ -1607,6 +1658,17 @@ static void khugepaged_scan_file(struct mm_struct=
 *mm,
>> 			break;
>> 		}
>>=20
>> +		if (page_has_private(page) && trylock_page(page)) {
>> +			int ret;
>> +
>> +			ret =3D try_to_release_page(page, GFP_KERNEL);
>> +			unlock_page(page);
>> +			if (!ret) {
>> +				result =3D SCAN_PAGE_HAS_PRIVATE;
>> +				break;
>> +			}
>> +		}
>> +
>> 		if (page_count(page) !=3D 1 + page_mapcount(page)) {
>> 			result =3D SCAN_PAGE_COUNT;
>> 			break;
>=20
> There is already a try_to_release() inside the page lock section in
> collapse_file(). I'm assuming you added this one because private data
> affects the refcount. But it seems a bit overkill just for that; we
> could also still fail the check, in which case we'd have dropped the
> buffers in vain. Can you fix the check instead?
>=20
> There is an is_page_cache_freeable() function in vmscan.c that handles
> private fs references:
>=20
> static inline int is_page_cache_freeable(struct page *page)
> {
> 	/*
> 	 * A freeable page cache page is referenced only by the caller
> 	 * that isolated the page, the page cache and optional buffer
> 	 * heads at page->private.
> 	 */
> 	int page_cache_pins =3D PageTransHuge(page) && PageSwapCache(page) ?
> 		HPAGE_PMD_NR : 1;
> 	return page_count(page) - page_has_private(page) =3D=3D 1 + page_cache_p=
ins;
> }
>=20
> Wouldn't this work here as well?

Good point! Let me try fix this.=20

Thanks,
Song

