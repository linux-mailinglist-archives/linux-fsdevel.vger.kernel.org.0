Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1266B482D42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 00:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiABXqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 18:46:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25914 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbiABXqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:46:46 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2029DRmf028072;
        Sun, 2 Jan 2022 23:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wwtuagr4QOGIbpGgoOmmPE/gX/r/gp+2+CxZy8Pv39A=;
 b=Erl8qc3fZNE/YuRthfiA1LAiYfgM12ZTSa3z7VO88I91KF21sx1bDcS2EwyPjjISRHET
 Sjh9sTf8TVtFlVbAIJgZKSU4QQa/UL3CvUvyF2Csppur5IwXVVzrpAb/1mS9+n93R5RP
 jE9f2vKK/tcf7Akn7OiOz8OA3jtPOld+eE2u61+63QEjZ6OoyKe6ZpVcA3aiIsDHl2wZ
 hSc2ObqOCnjqIZGfdl/hscZsNUNNbF1bfVBVtsr7UIT9V6+28yMrteQcB4INbAmaS3LS
 TiTTM0vlecd5Pf/8/2s/tdDH228ph/GLnAsssJvJVriJRYwJUEyadKxbjhF0Xog9pCv1 Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dadj1sprk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Jan 2022 23:46:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 202Njd8Y194920;
        Sun, 2 Jan 2022 23:46:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3030.oracle.com with ESMTP id 3dac2ttmta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Jan 2022 23:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdRe6Xds4LZAMkn6dHI0O516OrBPANKlN7Y2OrZgpnBmdefUulSPtZuZ9rWu2Myh8MSDecCwUZU74d5fxuBZuinsm1T1wjTHMWTchlHAZYFwdYo7blJ4wvAWK1UBASfhRhOIqM/cAgHy8RmOWu+AdE8hB6kTgSEAeYeHNGwGWOjjMZiDS3tpWQZzsvwXTGFm6xwJwIZv0N9L8YvcUSOpD6GczxVTwoHVv6uNXG3e2BnWsA8hzxaMrJLz1JiDCPeqQVye1G2W4xgiZuC0P12RQUVcyrYT8UK4PTzas+ESVBA1iVqTK81AvNbmNjmpG9ihDpXYPOBB0UGTIT0ohIHvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwtuagr4QOGIbpGgoOmmPE/gX/r/gp+2+CxZy8Pv39A=;
 b=QzxW+/oIH6psEnnOR3VhkIX5z7yCW+ODu///y3ixrUWJ0xcg3FBMte8+E/g+P3XmuLL3s4y8gsa/8vEd53VCR77W6CwdUZO9eFx16+BedMxkgKyBsI/G/CELoeoIr+hn9obUtlBXZ0FeiW+2izaGR6aZ17dCZbkpt6Js8TYdkw5MbEjhTaIuOOgmXft/dZnO/k9SjWjtr+fl8CUnD1MX0aWNryCrRi+1v2FDOJTrYID2Sc06vxoBoemaPOGwFMcoMjyRdQ0HAu65rqZ7tV4BngffSVq1+wL8vxTOGQmabPm8bWp9GUvL0HSObAI00lFrIstlFAqBJle2HpoKjHLDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwtuagr4QOGIbpGgoOmmPE/gX/r/gp+2+CxZy8Pv39A=;
 b=xni6ENnFlVYUYZcxYbWwDjCkup3UdMWcyDDufjLH4TIcSaWRiIch9GFPrhphZ/ojxCG3aLNMriHHqvrWFWoq+aAk/GUo6Q+R499CvOBbwpCKeKoApa3zlqSKbXysPNEX+YYkZPrstrsmYliGDvbU62ke84lRivE5lIMSFgR9Mxw=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2925.namprd10.prod.outlook.com (2603:10b6:805:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sun, 2 Jan
 2022 23:46:22 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 23:46:22 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 00/48] Folios for 5.17
Thread-Topic: [PATCH 00/48] Folios for 5.17
Thread-Index: AQHX6/80rg9MDEdb8U2tokmUet0pZaxQERiAgAB8zIA=
Date:   Sun, 2 Jan 2022 23:46:22 +0000
Message-ID: <0612EB9C-CB83-497F-AA8F-47566F61EF7C@oracle.com>
References: <20211208042256.1923824-1-willy@infradead.org>
 <YdHQnSqA10iwhJ85@casper.infradead.org>
In-Reply-To: <YdHQnSqA10iwhJ85@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.21)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ec21f4e-b233-4c6a-f5e4-08d9ce4a14f0
x-ms-traffictypediagnostic: SN6PR10MB2925:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2925B75BDAEECEA9144C9C5181489@SN6PR10MB2925.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EQdWarDsyrrgM2mUCeI3cYVMMZA+y8pp9rR724ntcUvq8aoreL+Y13cmY7gj+oekHjOkJZ/zaN164HNattidtfJQV/CHFOPz7yCUUVdlA6rgrN8i9/mhmE3JRBFGc2Wt3Tor3rXzZetXn2AetmUzDlDcb7NdSOb2ngPeKoIZ5qM9fajvPyBytAGVjP84pHxUSiB1vnDI3yxWv/t5jWqtHxjlzyZfSj5Rjk9AGYvMypDVQnVOBiZT96ldMtCzAvY4bXUH2NXN//DTVqQSHNZcgC6HiE0ejg9Sm2OwU9HCxdrT32uDcGXY0aejyoxawJN3b/PYeaQsqJ8ayCnG07jebI+bWBHRIrq0daE1H3U3IucUob/l3GmSpfZXxJ5yrIxxDTIOvqQ/1SJpvO9ptEkQQ0uYCRxkXysRgKDsyrGuZkGUBfPJVP1SBqdEz2uS3ykZgB1DF6ZDK0InRcRjbbduoWj+oF0xs7DnqIItmwI8bCP0PY2dW+J6jh0/fKCpBMoBk5fUHYuP6mQY42NTduS79KbH3st9enNFrAbhQPKDl+T3t848AGBOIUWK7Unxh8vA47yvSehbLsCCXuWDhDXpJsFU++qPII+/fkWQ0Fkl/jo0ma6KP+CEejTqEM411VES/StNUg646sv74PYZ7YTja83Mz0XALMY+sPN2IaIwhkVjs8bVhg6vGrvPPU2zSypwA/9W7EEarUT++lF2zJnN+DxAWI52F19T0ekx36dEGQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(6512007)(33656002)(83380400001)(2616005)(44832011)(6486002)(36756003)(4326008)(38070700005)(6916009)(508600001)(5660300002)(186003)(66446008)(316002)(66476007)(64756008)(8936002)(91956017)(66556008)(76116006)(8676002)(122000001)(2906002)(71200400001)(53546011)(6506007)(38100700002)(54906003)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vg37w0cVSnJYzRBAiK+xbfY0oOMOBlkgdeDOJv52+lUKJpgAwdoxiJOYN0mG?=
 =?us-ascii?Q?TERGmj4tBOxdDyg8XSWQRXMimF8+fpHBcfW9pLQflVEkFO6MOADK22toJLY7?=
 =?us-ascii?Q?n9rw8vGh0RtprfVnCHPn+Gm/AL1qus4nEh/Y63y34CJv9UQivxOOUEneSxnt?=
 =?us-ascii?Q?W7+TEPNZx5mtQmk0nwwTIoSbMdJnE/iR/JFAvng3g5Z4+zHcYXvONQFRq4KO?=
 =?us-ascii?Q?D2/tJnHNx9+ZFwKUwKOHkDmAp0NEYS1Y6IlTvd25sP6co+pLb/2thTc5eabs?=
 =?us-ascii?Q?Ad4vAF0BcIq8BfEqFJmKge0nlFdmHM00ZWEWhuntiOx42IWIWpxCPtuYCyKD?=
 =?us-ascii?Q?nAL68oDhhhJd31BUUT0qK+DfkvtgKId82Gk0egyErpUvKkXokbQ3sYaOrIOC?=
 =?us-ascii?Q?TZG+SbbNSkRnz5rXYY1RJ80ALANeKWjpZhYzc+6Nw0t2J+sKoWBLkZkAmLvN?=
 =?us-ascii?Q?BsKj6a1VemCrvxgWbh4CtcsFGdwDh0qFf5dRZQRgiAwjEht+wcA0Ase5LbZl?=
 =?us-ascii?Q?scnkdDvtwzjcAicKR6QrENUjgmScsygKTO0sCjYUdUldp+SRfTGJdaadx4tR?=
 =?us-ascii?Q?icqrPoXLfsYA8ryy2C8tDloZcIl4hMZsyhVwzWGG6nKiuLsrZo73ox3kVzUi?=
 =?us-ascii?Q?ChVQlyIyidOL8Ub8iEhiKzoNkQubK9UnGSbt7ThrGY2niFcvlvNeFI1c5uZb?=
 =?us-ascii?Q?hdfHyhB6qzz+RhmoArYSJpdQY3zUWDZ/pMsbsADERv+ETjiYNxyE+w4bUnUL?=
 =?us-ascii?Q?mfRbQYwjT8g+1xheTOQdWBlFz9PbMADzf8ti3WxZ1tilbSkFzD48OADsoMZj?=
 =?us-ascii?Q?t0CVeVi3QXCeH0ObWWwlu0QYsx0vlWFOPRA9GOPUCGKZMu/iSfsq2XfyYE8p?=
 =?us-ascii?Q?tsHdBwFboP642tnYEOLVRERnjE2RM/ne+R5SnPX2Z58sCNcaOg9RdvegQmmc?=
 =?us-ascii?Q?ZEsmikdVi7tvKckyjZPtCFEXlyweHsZ+nePI7wb4B7Rd9jKrvxm6dnlftT9s?=
 =?us-ascii?Q?Gq1JTAwcjEXBoHhAWDrRJ7YKDa8Ku+VtYnu0fIVKrE+A+IRfo4biD2F/IAuX?=
 =?us-ascii?Q?n/RDOzmiPTr/JEivzIqZgE+urIRDfmGwOeVFHWRnYuGBkKP2ymhv4cZvQWl+?=
 =?us-ascii?Q?/nn8g2i6BM6/pT5mfuZaqpJMwDvbNh76Dl4NMoIx24rhVdsjU0T288rB0/3p?=
 =?us-ascii?Q?U8rmqQpb/w8fmoBDkp51OToPDz86/SZ31wyIBGnW4cSvY4ReSA+QelBB11S7?=
 =?us-ascii?Q?r9g548OdpFhngdpXmqjOYsjY9byuJ9edmGgbOfkbm7KXZlbjcBjEtuARglFj?=
 =?us-ascii?Q?W7tP3ofZnMHqQIq1YQJrGCqZRIfgzNEfrNDealA3gnYlZ09zCrusTjzsDLss?=
 =?us-ascii?Q?vam7Z1PRk4HZVDJWhcZMvl4XY0q44tXhKCcbrcqTq645VYrobM1W8FjI6C0U?=
 =?us-ascii?Q?9fG6UHIueL2XWUWZY1uDR8ETfEPDcmKFFtd060vs7aJksTrZ6DgQSPO0Cax/?=
 =?us-ascii?Q?8qFN2jMIH6+DeZcLlYKlVbmTFtfkqxlyB4HJjgdYe01BvloViHmwwo0VGRud?=
 =?us-ascii?Q?wOQpdswQBAJ1dpy8L/1hg0Vd1XedS593ooRWQiM4SBczAlUnLkwwO4InMDmV?=
 =?us-ascii?Q?9MdsfuWOClwK3mOVIKz+vX8+Xt+Hzipzk2QKmmDIEc6AX6jzGrT3lOMqRPxr?=
 =?us-ascii?Q?ucOd7abzFKGbiS8cGcLdj20blKp5Dp8c5OCkn1qoSqrkru0+qNuhTH0PZa5e?=
 =?us-ascii?Q?6sffMUvDl9YY4MYnT5Brbr9+/Iujvfw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F3CA8F259B2D04DBAD48F8E1188850C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec21f4e-b233-4c6a-f5e4-08d9ce4a14f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2022 23:46:22.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7HYaFna1hPvlqLfR/3fBPJLybRSw/y6lhtxSibGY0ZoouXZNYTXQLjV6byP/xnPCGJ+WZfhw4Wm6lOwpaL+fd5+wYPuGFd+Jp5zM/wVJR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10215 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201020172
X-Proofpoint-GUID: gGBO1vSIc1w0YgddMkyDSwp1ujwoCkGV
X-Proofpoint-ORIG-GUID: gGBO1vSIc1w0YgddMkyDSwp1ujwoCkGV
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good, addresses one of my comments as well.

Again:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Jan 2, 2022, at 9:19 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
>> This all passes xfstests with no new failures on both xfs and tmpfs.
>> I intend to put all this into for-next tomorrow.
>=20
> As a result of Christoph's review, here's the diff.  I don't
> think it's worth re-posting the entire patch series.
>=20
>=20
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 7d3494f7fb70..dda8d5868c81 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -18,6 +18,7 @@ struct page;
> struct folio;
> struct address_space;
>=20
> +/* Layout must match folio_batch */
> struct pagevec {
> 	unsigned char nr;
> 	bool percpu_pvec_drained;
> @@ -85,17 +86,22 @@ static inline void pagevec_release(struct pagevec *pv=
ec)
>  * struct folio_batch - A collection of folios.
>  *
>  * The folio_batch is used to amortise the cost of retrieving and
> - * operating on a set of folios.  The order of folios in the batch is
> - * not considered important.  Some users of the folio_batch store
> - * "exceptional" entries in it which can be removed by calling
> - * folio_batch_remove_exceptionals().
> + * operating on a set of folios.  The order of folios in the batch may b=
e
> + * significant (eg delete_from_page_cache_batch()).  Some users of the
> + * folio_batch store "exceptional" entries in it which can be removed
> + * by calling folio_batch_remove_exceptionals().
>  */
> struct folio_batch {
> 	unsigned char nr;
> -	unsigned char aux[3];
> +	bool percpu_pvec_drained;
> 	struct folio *folios[PAGEVEC_SIZE];
> };
>=20
> +/* Layout must match pagevec */
> +static_assert(sizeof(struct pagevec) =3D=3D sizeof(struct folio_batch));
> +static_assert(offsetof(struct pagevec, pages) =3D=3D
> +		offsetof(struct folio_batch, folios));
> +
> /**
>  * folio_batch_init() - Initialise a batch of folios
>  * @fbatch: The folio batch.
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 8479cf46b5b1..781d98d96611 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -150,7 +150,7 @@ size_t _copy_from_iter_nocache(void *addr, size_t byt=
es, struct iov_iter *i);
> static inline size_t copy_folio_to_iter(struct folio *folio, size_t offse=
t,
> 		size_t bytes, struct iov_iter *i)
> {
> -	return copy_page_to_iter((struct page *)folio, offset, bytes, i);
> +	return copy_page_to_iter(&folio->page, offset, bytes, i);
> }
>=20
> static __always_inline __must_check
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9b5b2d962c37..33077c264d79 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3451,45 +3451,12 @@ static struct folio *do_read_cache_folio(struct a=
ddress_space *mapping,
> 	if (folio_test_uptodate(folio))
> 		goto out;
>=20
> -	/*
> -	 * Page is not up to date and may be locked due to one of the following
> -	 * case a: Page is being filled and the page lock is held
> -	 * case b: Read/write error clearing the page uptodate status
> -	 * case c: Truncation in progress (page locked)
> -	 * case d: Reclaim in progress
> -	 *
> -	 * Case a, the page will be up to date when the page is unlocked.
> -	 *    There is no need to serialise on the page lock here as the page
> -	 *    is pinned so the lock gives no additional protection. Even if the
> -	 *    page is truncated, the data is still valid if PageUptodate as
> -	 *    it's a race vs truncate race.
> -	 * Case b, the page will not be up to date
> -	 * Case c, the page may be truncated but in itself, the data may still
> -	 *    be valid after IO completes as it's a read vs truncate race. The
> -	 *    operation must restart if the page is not uptodate on unlock but
> -	 *    otherwise serialising on page lock to stabilise the mapping gives
> -	 *    no additional guarantees to the caller as the page lock is
> -	 *    released before return.
> -	 * Case d, similar to truncation. If reclaim holds the page lock, it
> -	 *    will be a race with remove_mapping that determines if the mapping
> -	 *    is valid on unlock but otherwise the data is valid and there is
> -	 *    no need to serialise with page lock.
> -	 *
> -	 * As the page lock gives no additional guarantee, we optimistically
> -	 * wait on the page to be unlocked and check if it's up to date and
> -	 * use the page if it is. Otherwise, the page lock is required to
> -	 * distinguish between the different cases. The motivation is that we
> -	 * avoid spurious serialisations and wakeups when multiple processes
> -	 * wait on the same page for IO to complete.
> -	 */
> -	folio_wait_locked(folio);
> -	if (folio_test_uptodate(folio))
> -		goto out;
> -
> -	/* Distinguish between all the cases under the safety of the lock */
> -	folio_lock(folio);
> +	if (!folio_trylock(folio)) {
> +		folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE);
> +		goto repeat;
> +	}
>=20
> -	/* Case c or d, restart the operation */
> +	/* Folio was truncated from mapping */
> 	if (!folio->mapping) {
> 		folio_unlock(folio);
> 		folio_put(folio);
> @@ -3543,7 +3510,9 @@ EXPORT_SYMBOL(read_cache_folio);
> static struct page *do_read_cache_page(struct address_space *mapping,
> 		pgoff_t index, filler_t *filler, void *data, gfp_t gfp)
> {
> -	struct folio *folio =3D read_cache_folio(mapping, index, filler, data);
> +	struct folio *folio;
> +
> +	folio =3D do_read_cache_folio(mapping, index, filler, data, gfp);
> 	if (IS_ERR(folio))
> 		return &folio->page;
> 	return folio_file_page(folio, index);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 735404fdfcc3..6cd3af0addc1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -942,18 +942,18 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, loff_t lend,
> 		index++;
> 	}
>=20
> -	partial_end =3D ((lend + 1) % PAGE_SIZE) > 0;
> +	partial_end =3D ((lend + 1) % PAGE_SIZE) !=3D 0;
> 	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_READ);
> 	if (folio) {
> -		bool same_page;
> +		bool same_folio;
>=20
> -		same_page =3D lend < folio_pos(folio) + folio_size(folio);
> -		if (same_page)
> +		same_folio =3D lend < folio_pos(folio) + folio_size(folio);
> +		if (same_folio)
> 			partial_end =3D false;
> 		folio_mark_dirty(folio);
> 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
> 			start =3D folio->index + folio_nr_pages(folio);
> -			if (same_page)
> +			if (same_folio)
> 				end =3D folio->index;
> 		}
> 		folio_unlock(folio);
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 336c8d099efa..749aac71fda5 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -350,8 +350,8 @@ void truncate_inode_pages_range(struct address_space =
*mapping,
> 	pgoff_t		indices[PAGEVEC_SIZE];
> 	pgoff_t		index;
> 	int		i;
> -	struct folio *	folio;
> -	bool partial_end;
> +	struct folio	*folio;
> +	bool		partial_end;
>=20
> 	if (mapping_empty(mapping))
> 		goto out;
> @@ -388,7 +388,7 @@ void truncate_inode_pages_range(struct address_space =
*mapping,
> 		cond_resched();
> 	}
>=20
> -	partial_end =3D ((lend + 1) % PAGE_SIZE) > 0;
> +	partial_end =3D ((lend + 1) % PAGE_SIZE) !=3D 0;
> 	folio =3D __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0=
);
> 	if (folio) {
> 		bool same_folio =3D lend < folio_pos(folio) + folio_size(folio);
>=20

