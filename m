Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCA47F95D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 23:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhLZW0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 17:26:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28966 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234736AbhLZW0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 17:26:41 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BQHT6ed032554;
        Sun, 26 Dec 2021 22:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C89HUoHwfy5JZFX6Kv8hhplcjpsGDljXzCEplPlM9pU=;
 b=be9zUCv7WVN7W8BdIQiwGjJAcnxyFQK+ejpfY8W9TmWPPR69x+VBBXe9192eFAFPfCu7
 QsYMqIQLKQDnJ+Bsg6zj1H0C+RQNfhmrssmmo5uD7wfYR+oi6Nw9VJtCPVrr8l9KgmsL
 3erPUiehUxMkBUEOamRvfknR2Oknn06/YC98J9unGO7q0c8CvSnw1Dzb7asQzaj8Ma70
 NdOUKTCFOJK5C0jCrBTizp3nPAv8eIQv+HcZ1ekPZ0on8n/BuhH5ZM/0wavb2dihW4zo
 YdaVC/aqbFPC9wa9gLWeRxGt93L0JT7jqCC7CCT/6RjfM+tNkUyloijfWAe2A/utPK0R gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d5twssufg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Dec 2021 22:26:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BQMBjQJ002304;
        Sun, 26 Dec 2021 22:26:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3d5sbbe85b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Dec 2021 22:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYr4/sgM3dA9LFzZOlZ+olyOZGhs5RpknWQlfj4Fm9+Y2n0rapdOL1a3myG2dtIRU4v4wQzJq/9pNk2mVfT7sJcLf/3DPk53lrgIztHIIvolKy5czjMlDRrzPu4LAcp4UBGHSvpLsOSMR6/4WoQ+zNOhkZuXdUaRL7gFTbhQZ5k/w7UH+hldN47LX4J8HG+pwDBLlbgy2rEFB4q85d/SGjaw6Z7SlNM52Xb+X8R9FNgqhFTZ62dTqqjvAwbonUI6fxw0L5DSerr92nMTHJJFBPJPPT96PUCcSUfUtwe0U0507PY+O3EM5e6AiUOZBaGHiLSJGJRRLQOLpNRDFhjRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C89HUoHwfy5JZFX6Kv8hhplcjpsGDljXzCEplPlM9pU=;
 b=oId7UVE+EItU7ZhTE36MYid1OY2rc/w3LCg4e65WYDeQJvuG3P5yxfpOhZdjzcTa6D5XrVoy8mpWr6w0+hR2qgipeAn9iUTH9DChQJHErXdY4d4lAHLIqN0otPhJaQfAYFf+nWxFn82tCp2RPrrUQjvhpxJ+m3pX9zZxxLqskuT0Xf8ybWRO925ZJuq5PAaJF8xyaIcrS6RJ7WPfow8Qk7zw1dq8nVEFryPHl69ybwgqqiYiXyXD9DYW0PLeLJnmrMMriDO/aiiwEzXAqcRhW4NFuQauHKbeSGjgXDUCIhbHiQqAOICqPmOV9UBwdb0+R6JrWoagoXzpEW6Aur5b8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C89HUoHwfy5JZFX6Kv8hhplcjpsGDljXzCEplPlM9pU=;
 b=zkU1lKNsE5CkWnRrVQhFSsvILZp3RdQyIUtFMubBeshxS9YqyE/suixeWOLTB+AcA2gyq/PWLRSetWTHLnaLBVcpgpT7n14j9nv5HGn2lWwYgtFGK8qTc3y6jQ3I/0qVBbm5BDms51AlTbfnM5uzXKEq6VBr1ICuTMVFRi3eiLA=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Sun, 26 Dec
 2021 22:26:24 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4823.022; Sun, 26 Dec 2021
 22:26:23 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 00/48] Folios for 5.17
Thread-Topic: [PATCH 00/48] Folios for 5.17
Thread-Index: AQHX6/80rg9MDEdb8U2tokmUet0pZaxFdzoA
Date:   Sun, 26 Dec 2021 22:26:23 +0000
Message-ID: <D0BCCF0D-FCC6-4A36-8FC9-D5F18072E50A@oracle.com>
References: <20211208042256.1923824-1-willy@infradead.org>
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81f9d446-186d-4282-bf2a-08d9c8bebff2
x-ms-traffictypediagnostic: SA1PR10MB5867:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5867AD3BF64B26FBB6B1CC9481419@SA1PR10MB5867.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AYNJT+LTWcH6Q8ew6YHHFJtLajPRS5krKYZ/pHzxuJP+Ca/qklIH5AYMKUjw97ImF4AOKVKNL/OQHpFx63J8EDFbKqmhowWLoLlrPbS0lOY980weMPoq1Fjowp5AtQijkKwTpIfROUbfp+VXC975aXf7ASrOOUDMMFNDwYzzIvdY0BGuFXDQjMQKvyFH7z6r0dVuPhYpMKKUDlzyv8B/Aga8ORewM08YTtoybFDfUEiNTrYvdpOZ8xTwbgVlbojrax+7PNmzwDEUvCnBrOSn4fG5HY6BM3cWyuwdHGowFUdWxZRHmj6wWStBvchHFxKz4PGGlRD+3YpBCV5A6WwGtB5j34SC8u5d2LE7xyBwCaGUUIs2MbKI/6+XHpEzdFo2erRPlYT9VGPph7JHWOUPSwA8tJNCu3G++Qxg+lu0xTkj/EFxqkjYouHurTrxO9x5uzLMnBelrTfWD7EpApFJ/cAhhKz7ZoT/5K4rBYpaEOKa8978GK50n5NdaAcHYViXd7v9s2razcUe4vt5kKYSIYF3Arqam7V9dunmU5ohnJk/BN2YU/DDqA+HKvsuv1LpgUsDnZST5WeBjfsVQ5JCCCao27nvwXJDBssf30WCvSI85vGRPWqWF6aULItUuDt+lhKhdYZB1TrxqeZ+J3ebE7zatLhzFqkOIApAGwaoOCVdA0HRqTPypdmcC75ffSWnrmXPEj5c0uB4Rc8aOqEv/Wuww9QN0YTdlTgJHVTJ6tR/qb5RvOOu2g2O3Frr+A6K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(53546011)(54906003)(83380400001)(91956017)(38070700005)(8676002)(76116006)(66476007)(6916009)(6506007)(2616005)(6486002)(122000001)(508600001)(8936002)(316002)(66556008)(186003)(33656002)(2906002)(5660300002)(64756008)(66946007)(4326008)(66446008)(38100700002)(86362001)(71200400001)(36756003)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F0B9LuGexsbY8HG0IC7ZTwHDJwXbj1+RV7YT57g5JdpU8XRbsroxqMJ8XwO/?=
 =?us-ascii?Q?0ec43gm5w7ZnQetzSSvYw0Ky/nrJ2DBX99fC4WiainuVupsxNnNH3lqjAIZF?=
 =?us-ascii?Q?rT5gdhVtU7c3Bg3fwRRtEycNMyxlOpQ0ADgBIg/b6qcXdvd5ydiPpYz/N2Ww?=
 =?us-ascii?Q?Upan96V9uDLnb1E96CqM4DGd1bABoFSZekP45QNNE5N9IrtBhF0mWEkJAJ/Q?=
 =?us-ascii?Q?VaRPLWy0OR97mEHo6PUGNerNjrnu7HSZ+bWaJNC4AvbJF9iRz5QyXWh5Ja4v?=
 =?us-ascii?Q?kD6RT24vAWOi7s5aMrpMMMX2m8fypFZxTPL5y2rR1xvur0WSNoeUUuOiN4R3?=
 =?us-ascii?Q?JSwzOmNkbBpM5vB6kAwOtFETsY9ES8Jpn6rBFVkbCCFBHgQCPe8ZXMQpf2vl?=
 =?us-ascii?Q?Mj5O8F9Ys93x2LM64Gum+KTWhDjMIZ/JRFNHQYUVcVb0HtIv6t+3B0tnoo7a?=
 =?us-ascii?Q?kkFoNHqaJPzg1kNn2JDJgx3cTJM+egzh13FSb47uu9Jl00tjzfMZNlmpDiWy?=
 =?us-ascii?Q?UtgG/yT/wlmLK0bezLmXm1fiYVCsm2BfL0iF9ZMLaGUy3IF7tqq6Pi83YbjA?=
 =?us-ascii?Q?SbZRTAJe+A+kKj9dltmzQbG0zOJgh4Bwb/Rue3A7AhBqe40IhWOr1v3ER0jD?=
 =?us-ascii?Q?afC7hIjwj5aHn1bGtFL9pFyyQjbRl345fkaY4W2o75jSBYtNONaJLn716k3G?=
 =?us-ascii?Q?EWexYD8xnSDMk2Ufhj8O2pioWboWCYY5BvA3NudicG3LfNU+tDru5hfc3IcQ?=
 =?us-ascii?Q?T7ye2bsEzs3u5cG/L1KrSFR+5ybVxk11qZT0q9w3tsb2G0f7CuCPLVHNq+AN?=
 =?us-ascii?Q?omkHuAIx6GkbKx/95mL3/avB5N54HaBtBx3LNCUsmV/+aLRtuTAJV0GWmgie?=
 =?us-ascii?Q?Hy+82sICs99F8hpT4qTQy66+ROBQoqFmWBTxY0i/8DfFyRzsewdA/jOXT4Uh?=
 =?us-ascii?Q?QJkjVQmPfmxnJjggNz+zRRM29THRmLYDpMNTKLcDyMLQ/eE0grdfe2gc0zIB?=
 =?us-ascii?Q?ulvGAnp+Dp5Grznof8v5ymJbeOUu16oqaIDWcTG7rJIT18HSHn+DJ5Yr8hqO?=
 =?us-ascii?Q?KAt2IMoPHsrW8vZqMHcwzgSl4ywpUoePCZUWAfwPjgT4eRDonBGDYLC1U34Z?=
 =?us-ascii?Q?UIYJ+IEMU/YgHDHvW5gf6qf4Q26Ms4lQ0lSdwnx5dbNmVYHpR9pRteJdPzzP?=
 =?us-ascii?Q?7j3dEli7kADVqH481Y6H21JPCTrqvAHDwvDsLl525GZ1Y1TulvmZEHqyJZmk?=
 =?us-ascii?Q?NnhekWiSUmn+D/zPlqNlrkD+FiWnAXBql8YnUfCOECct41/svV2RcED3x0d0?=
 =?us-ascii?Q?u39CstpIqqZBNoWUbqpHFMcBBqwRhSw1/FoyNVzU6qRo86QVBVkbTcbQyJma?=
 =?us-ascii?Q?ZCnNgiCpwPHrBxMND1yA/8eloc24WSkFtBgq0rWtx9dqf2ABi9MWeTwkXsMf?=
 =?us-ascii?Q?tjaV9pMFNCug5qk+uv0l7ivUShQL7+EDtDls/rFD9yHacnZCze8fVuh6MvoK?=
 =?us-ascii?Q?R+VdyUGe0DPKmBM5ViF2ZAvKkB+CGEC07XMMGgV+V8JwexcyvK/19IwO/dw7?=
 =?us-ascii?Q?G7pC9FlupEZrJXfeBF8RQ3Fo19+VNHmhk34+g0tYETQ0fykXMo7GD5/Dr9Sp?=
 =?us-ascii?Q?BZ46pIxQSZyyBNofLloBC29+PJmPUuOdSEMlM1Guk9cyyoy9L8fq+4lDiZe1?=
 =?us-ascii?Q?9oYZ5kl/1Czhh6w2jlQ/RKBgijd8o/BPKTvhkC3fbAJGo/RByqvynaK8zTmE?=
 =?us-ascii?Q?CvKxsxiGWLHR5sUDRi5q/I5VH3nzIGA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39EF3840F589D24E969B6DEDD2198F67@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f9d446-186d-4282-bf2a-08d9c8bebff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2021 22:26:23.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OAb8+C+GWNwalzr79ZCRu815psuB8axs57djpZaKTMX9LKeGR/CQrcsYTFEz0UweTXVH3dcCPI4075dKczKaEFqpmMV9UkZRFUkSoY0L5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5867
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10209 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112260127
X-Proofpoint-ORIG-GUID: qNNT7nhIWYnZWV_Jk_q6oh_KDBCtSPAn
X-Proofpoint-GUID: qNNT7nhIWYnZWV_Jk_q6oh_KDBCtSPAn
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidated multiple review comments into one email, the majority are nits=
 at
best:

[PATCH 04/48]:

An obnoxiously pendantic English grammar nit:

+ * lock).  This can also be called from mark_buffer_dirty(), which I

The period should be inside the paren, e.g.: "lock.)"


[PATCH 05/48]:

+       unsigned char aux[3];

I'd like to see an explanation of why this is "3."

+static inline void folio_batch_init(struct folio_batch *fbatch)
+{
+       fbatch->nr =3D 0;
+}
+
+static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
+{
+       return fbatch->nr;
+}
+
+static inline unsigned int fbatch_space(struct folio_batch *fbatch)
+{
+       return PAGEVEC_SIZE - fbatch->nr;
+}
+
+/**
+ * folio_batch_add() - Add a folio to a batch.
+ * @fbatch: The folio batch.
+ * @folio: The folio to add.
+ *
+ * The folio is added to the end of the batch.
+ * The batch must have previously been initialised using folio_batch_init(=
).
+ *
+ * Return: The number of slots still available.
+ */
+static inline unsigned folio_batch_add(struct folio_batch *fbatch,
+               struct folio *folio)
+{
+       fbatch->folios[fbatch->nr++] =3D folio;

Is there any need to validate fbatch in these inlines?

[PATCH 07/48]:

+       xas_for_each(&xas, folio, ULONG_MAX) {                  \
                unsigned left;                                  \
-               if (xas_retry(&xas, head))                      \
+               size_t offset =3D offset_in_folio(folio, start + __off);  \
+               if (xas_retry(&xas, folio))                     \
                        continue;                               \
-               if (WARN_ON(xa_is_value(head)))                 \
+               if (WARN_ON(xa_is_value(folio)))                \
                        break;                                  \
-               if (WARN_ON(PageHuge(head)))                    \
+               if (WARN_ON(folio_test_hugetlb(folio)))         \
                        break;                                  \
-               for (j =3D (head->index < index) ? index - head->index : 0;=
 \
-                    j < thp_nr_pages(head); j++) {             \
-                       void *kaddr =3D kmap_local_page(head + j);        \
-                       base =3D kaddr + offset;                  \
-                       len =3D PAGE_SIZE - offset;               \
+               while (offset < folio_size(folio)) {            \

Since offset is not actually used until after a bunch of error conditions
may exit or restart the loop, and isn't used at all in between, defer
its calculation until just before its first use in the "while."

[PATCH 25/48]:

Whether you use your follow-on patch sent to Christop or defer it until lat=
er
as mentioned in your followup email, either approach is fine with me.

Otherwise it all looks good.

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>


> On Dec 7, 2021, at 9:22 PM, Matthew Wilcox (Oracle) <willy@infradead.org>=
 wrote:
>=20
> I was trying to get all the way to adding large folios to the page cache,
> but I ran out of time.  I think the changes in this batch of patches
> are worth adding, even without large folio support for filesystems other
> than tmpfs.
>=20
> The big change here is the last patch which switches from storing
> large folios in the page cache as 2^N identical entries to using the
> XArray support for multi-index entries.  As the changelog says, this
> fixes a bug that can occur when doing (eg) msync() or sync_file_range().
>=20
> Some parts of this have been sent before.  The first patch is already
> in Andrew's tree, but I included it here so the build bots don't freak
> out about not being able to apply this patch series.  The folio_batch
> (replacement for pagevec) is new.  I also fixed a few bugs.
>=20
> This all passes xfstests with no new failures on both xfs and tmpfs.
> I intend to put all this into for-next tomorrow.
>=20
> Matthew Wilcox (Oracle) (48):
>  filemap: Remove PageHWPoison check from next_uptodate_page()
>  fs/writeback: Convert inode_switch_wbs_work_fn to folios
>  mm/doc: Add documentation for folio_test_uptodate
>  mm/writeback: Improve __folio_mark_dirty() comment
>  pagevec: Add folio_batch
>  iov_iter: Add copy_folio_to_iter()
>  iov_iter: Convert iter_xarray to use folios
>  mm: Add folio_test_pmd_mappable()
>  filemap: Add folio_put_wait_locked()
>  filemap: Convert page_cache_delete to take a folio
>  filemap: Add filemap_unaccount_folio()
>  filemap: Convert tracing of page cache operations to folio
>  filemap: Add filemap_remove_folio and __filemap_remove_folio
>  filemap: Convert find_get_entry to return a folio
>  filemap: Remove thp_contains()
>  filemap: Convert filemap_get_read_batch to use folios
>  filemap: Convert find_get_pages_contig to folios
>  filemap: Convert filemap_read_page to take a folio
>  filemap: Convert filemap_create_page to folio
>  filemap: Convert filemap_range_uptodate to folios
>  readahead: Convert page_cache_async_ra() to take a folio
>  readahead: Convert page_cache_ra_unbounded to folios
>  filemap: Convert do_async_mmap_readahead to take a folio
>  filemap: Convert filemap_fault to folio
>  filemap: Add read_cache_folio and read_mapping_folio
>  filemap: Convert filemap_get_pages to use folios
>  filemap: Convert page_cache_delete_batch to folios
>  filemap: Use folios in next_uptodate_page
>  filemap: Use a folio in filemap_map_pages
>  filemap: Use a folio in filemap_page_mkwrite
>  filemap: Add filemap_release_folio()
>  truncate: Add truncate_cleanup_folio()
>  mm: Add unmap_mapping_folio()
>  shmem: Convert part of shmem_undo_range() to use a folio
>  truncate,shmem: Add truncate_inode_folio()
>  truncate: Skip known-truncated indices
>  truncate: Convert invalidate_inode_pages2_range() to use a folio
>  truncate: Add invalidate_complete_folio2()
>  filemap: Convert filemap_read() to use a folio
>  filemap: Convert filemap_get_read_batch() to use a folio_batch
>  filemap: Return only folios from find_get_entries()
>  mm: Convert find_lock_entries() to use a folio_batch
>  mm: Remove pagevec_remove_exceptionals()
>  fs: Convert vfs_dedupe_file_range_compare to folios
>  truncate: Convert invalidate_inode_pages2_range to folios
>  truncate,shmem: Handle truncates that split large folios
>  XArray: Add xas_advance()
>  mm: Use multi-index entries in the page cache
>=20
> fs/fs-writeback.c              |  24 +-
> fs/remap_range.c               | 116 ++--
> include/linux/huge_mm.h        |  14 +
> include/linux/mm.h             |  68 +--
> include/linux/page-flags.h     |  13 +-
> include/linux/pagemap.h        |  59 +-
> include/linux/pagevec.h        |  61 ++-
> include/linux/uio.h            |   7 +
> include/linux/xarray.h         |  18 +
> include/trace/events/filemap.h |  32 +-
> lib/iov_iter.c                 |  29 +-
> lib/xarray.c                   |   6 +-
> mm/filemap.c                   | 967 ++++++++++++++++-----------------
> mm/folio-compat.c              |  11 +
> mm/huge_memory.c               |  20 +-
> mm/internal.h                  |  35 +-
> mm/khugepaged.c                |  12 +-
> mm/memory.c                    |  27 +-
> mm/migrate.c                   |  29 +-
> mm/page-writeback.c            |   6 +-
> mm/readahead.c                 |  24 +-
> mm/shmem.c                     | 174 +++---
> mm/swap.c                      |  26 +-
> mm/truncate.c                  | 305 ++++++-----
> 24 files changed, 1100 insertions(+), 983 deletions(-)
>=20
> --=20
> 2.33.0
>=20
>=20

