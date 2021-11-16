Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB98045391F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 19:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhKPSFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 13:05:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1792 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239262AbhKPSFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:05:20 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGHnTje030336;
        Tue, 16 Nov 2021 18:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=tMkUq81VD0IhHqiYGrhIXZGRjTZoSOLUz9RIfLFMKMo=;
 b=LyeKAUnLvWAvgeJDee2tWoce9fyyXw0f2ryTgQhmYxF1iXIvIvHvsTSqIPFN744j3i9X
 t/OxyQcZsiMvmgiwGQOkiHFLOVIxlqvTRIC1RiE1RfD01ilZYTZJX6qsTW+unpgtnvoV
 P+a4FKvxggryk79kBnNjT+k6hG3GUVvx9f179Uf9/C1eoWx/spU8vFnhZ8cj8IyyRj7X
 KIkt7j2vqW/L1ULACXQ+jd4iqcYv0QIXxd+xC6N274vdfKqyLS1nRDIMnFn8OdrF2S+s
 C76VM2LArbDn/jsBqttndj7b4UY39y75+aZftbaaWdUSbtwTvcklzGYqBkTJ+JzcZWBu qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnubyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 18:02:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGHoR2g040517;
        Tue, 16 Nov 2021 18:02:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3030.oracle.com with ESMTP id 3ccccnyc9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 18:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoHHICvQ12Z66uItyZe9fHH0zhzQf9eyvoKUvCpdYLMnzKh4v5esJem6h6OwWQmFmVeiWLsXZsOZQC5NUEoprn/rHQXBkT48dot9a6SMri/NkmN86np6y+bNwyfNvkfZsFSTNbx0088txRWX6VIHZK68WIisgVqKwpgs+HzJiAm5XLpScJuqlhJDiWmVbKIizO+B9VaYYHVtuFZotw6LPHbrYNvSbZkzh/+s77bWp3639axcGd49QJSH22W7eeN6JgLaAxH66+wd33NwSZrxDRTdf+KvT7FzyPU6ZPgcHlhyjhVelaaFJ2F/WfYuRb8iZ0T2EIgec0GePe+Yhp34aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMkUq81VD0IhHqiYGrhIXZGRjTZoSOLUz9RIfLFMKMo=;
 b=R7AIhM8nRktMPoybA0P+JHCor/m+ezjoE72ncHIX/9SZore2/oA55vq46ZBd5A3/lU3iS7M2GCAsqiO5q4lWYCQ4QNe7Ti+qV32jZHArA++N0oU+EtyotywFm+SZYRz/fU43bNQTD3JDbJ/4cvdpYzf4W6Ipcv1XULheydKR2IbEKHE+W6eA2r4XmEBdvkBWU+ciw1l3ik3zcK7GOWByGVye5ygOVZiEiZyMWusAfl+zGDjuBko8Ni4LbHcc2VKiubml+Wp+t0lEbW+iGZKI2LJL8pmpn45k+gJVeRLOKlNrtkWUIMDYVwUtZYaOdwmtzw266ozlLwLGH0gShbYOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMkUq81VD0IhHqiYGrhIXZGRjTZoSOLUz9RIfLFMKMo=;
 b=rvouKTZV6PIIGoVyCZLGrgSi7YBuihP35iziC4CM5XK49gjAiRvQMyqUU89rUfq+eHt1HwCBuUSCWDS/0+kjg5UDitKqLVQJ1vVyucgR6sbvPoYtRVc60E98WhW+9BklPwYutPc84Eu4YWw4uokBABIvQ0i4Askafdn1tBkt7Bc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1293.namprd10.prod.outlook.com
 (2603:10b6:300:21::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 18:02:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 18:02:16 +0000
Date:   Tue, 16 Nov 2021 21:01:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] fanotify: record name info for FAN_DIR_MODIFY event
Message-ID: <20211116180146.GK27562@kadam>
References: <20211116114516.GA11780@kili>
 <CAOQ4uxhHzoK=MU4Toc3uQSk5HZLZia0=DBBkC2L1ZeVVLTLGXw@mail.gmail.com>
 <20211116175709.GJ27562@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116175709.GJ27562@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Tue, 16 Nov 2021 18:02:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6817293d-d59c-46ad-6091-08d9a92b396c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1293:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1293B7CE50A35BA0CEA38D3E8E999@MWHPR10MB1293.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXbsGasnEwjcXJcM+Yc3amN3qOxz0oe8W1E2dY38TI1cbLcyX3QCTlAn1PRL8yKO8rDU1KVHEyplVxc6rPgiLlJiUp9Ami0P2Otpvp6L6x20ZRRRnNwe6Y2kG2r8L8ZvY+QF/OQNPdlnmOqGNnVJt/up/UN6W2JGmwiTTSQuwu87ZiPlbAZB3VSc429/hbH9V6aHk0mAyalBiKnkwUM3z0E66jweonQ0YrjWhKdtbMsu6PX5fs1qZl4SkhF+svlDJMMsIR06CKqRYGABDYBI+Z0VXHGN0KgARX47gu+sKwz02ETo5q2RZSJpuP2cCTLEOTucsw1BN/3CTND+xCg2BKqxvakhK7WaIX0RaZ//M9vGXgG1hyUtERT+isxjyici32hVdDuwO6eHLA0xNnICdG1VO5ZJ7UbXeewPytne0DU7aGdYdwf+O+cMOd8mQoxEu4RxoEtiOCnYRUuetneugzlODL6nVNZ2YLortFnrukmTokaeNe0L7xpDsKzDpS9L0/EuDNZa3xmNczWYINQFLvmFH+OwEoW65DvLWlIQWy1YBzQVi8qd9JdT+nLAeN87ZRfDg9oI1pU650dT3sdgfc+A3KGWvvLsJu9Z/naLhenDh/HAb/cvz1RmO1j/K++j7cnlxlDIOxSKOB/KI7qqBnkwMq5vUlMQzUXne6lOjt0serGirNkUzIu+yJCy53c+xnp7aewn3bzFbhaETj52FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(9686003)(33656002)(83380400001)(8936002)(33716001)(55016002)(6496006)(2906002)(38350700002)(53546011)(508600001)(316002)(6666004)(5660300002)(38100700002)(1076003)(44832011)(9576002)(66476007)(86362001)(186003)(52116002)(66946007)(66556008)(6916009)(956004)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gEsYE/yaVXNwEMwigm1GuO9Q0ktKU4qMtJIAuzPkDZkixf1WASzMtfmz8rN/?=
 =?us-ascii?Q?Q/0MCnBCSJKEUfVJi9QZbTvVPj8rZGsHwV1xioV55MWIKTP/eyONueV3vPD8?=
 =?us-ascii?Q?uhO2p0XcPt5oWHBkgVNQk3GRheESGg2dGPtWfcJqFhYk0eIbGyAjMFpH35Ir?=
 =?us-ascii?Q?ObESZn0gn8bwK95XgNTWD99vo8P+ywkqSquYe5R6XQLi+0J//EfDpv9Ofsvz?=
 =?us-ascii?Q?WOih4H2760ohmK50PbMiwDX7DOghJH0cfXIWlY2S/2rS4IaXSon6/V3uLdCt?=
 =?us-ascii?Q?NYXDQdTFGxKLk9WjcO+FgmmAbweMa9Mi1gy3WgmYZyNliqVjMrCFXZkGjM2w?=
 =?us-ascii?Q?iv5JKX7LADJrORpDm/zGPJb7H//RBmUaI6284DzFwJ/jnBACm5AKs80KNos2?=
 =?us-ascii?Q?8KFm2MBttVWXInzL5JAk1ygFGwyMLB2xJVR4SYas2Sr0uf9lKx2LPlVPAd4N?=
 =?us-ascii?Q?k/aoizjwY7zh1GUtUWsHy/DmNyCt69QzIKR/kErMctHj18f6yvUJkK/3B9mT?=
 =?us-ascii?Q?KfelZ8Wd59Zx9wC7Tu2QPkfXoULoAZzdh/EIug548cWFTkfSxFgUlf2fvjZY?=
 =?us-ascii?Q?Gd4JJzG1SZkbJROf9XsCnCVXSNTuHEcq6PcavNi7NcL3QYC0OD6SKPrO7KY6?=
 =?us-ascii?Q?a2qclJAaxMbavswX9PgMOClH0roBtkZzJObNBkGhdzZjeCML1pjhi+RbMKWf?=
 =?us-ascii?Q?SHRHXtYeNfEwp57/iLqGau7NX+B+xeeTDAHLhE6XVJXzvHUhEA7tePwdzC4B?=
 =?us-ascii?Q?uLi7AmgtHL4BNcwL8f1lvxkQddsHyAs2A8DNz6RUjXGBKoV7GsGRlLHmu2LU?=
 =?us-ascii?Q?htFR2Vn6I9Wm2XUhSbDZoUga9pMwPXVeNrmtZfDayr8+owGrw2OcOFl1QeHr?=
 =?us-ascii?Q?3q0DjS4QxtvX67luO/KaFyD838O7K++ly2ve8NDakjtY02bYFoyUVzzT2LVb?=
 =?us-ascii?Q?eO5+fxefeeJuiWDowfzkrCNIqZD/ZqHz2DKfnb8hDu0x97A/yWHtoAL++nSN?=
 =?us-ascii?Q?wgwgezxYw2nw1dn2w4Q3qw7JTnz6ExClgKe8Ei9/fIHhI98hnPWbAT6ikO50?=
 =?us-ascii?Q?QdRZ8NIuTX7hbWdwGsTlpLUI20pZKlPhpvAhEzqm6WyNY4Uih1nuiGdXAy1S?=
 =?us-ascii?Q?tzd7ZIHkGyJ96BKpBp2hIRqEa2zNELpVc4v5XvRhnKz9Wv/TQbCvGP/yporJ?=
 =?us-ascii?Q?FPHnatysMu4Vy27kfclDbyPr0apJCJ9mD9Ya7ffpY2FCr94mJEkKfx5dSHUo?=
 =?us-ascii?Q?FOJ44fz8EHYa6K3m8bFMyLLw8tTnyYWKSdc1fFRv2Skda6FFVw4OpAQmYGvh?=
 =?us-ascii?Q?sXe4dimdw9xcrHu+/HD5Xq247ZDtH+fQnh40K57A0gCatZMaDlS7rlw2AQ3p?=
 =?us-ascii?Q?RTjHw6Hb2wun8zAy+7PV+gUgPwTPfdwIY64La7ACjjMUaaXI4t5X+1IKjKww?=
 =?us-ascii?Q?lcyXotRSVi/5bc2Bdi+jzhNMZGLw7UWlvOVipb4cCFrDtZRAoaLUrce8iGsx?=
 =?us-ascii?Q?N2AIJ7DlmnZwIMfp2jC4u7iZrQ01kZamdeaawdjhQxAQ+J1lr/Ifm2C7Woiv?=
 =?us-ascii?Q?mL77jbBs7RzfgyVzv8TKmwKIMpcP3gOYB64G6jLvPBl7bqlUkNVreKogUepB?=
 =?us-ascii?Q?3wdQq+g6opijZE9Ni1b58TVRlrjWepL4yOAIrd0eawys4qMnLZyd9zeueOa+?=
 =?us-ascii?Q?c0YgI3Faz1CZVlPgKKfgF6a+NCY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6817293d-d59c-46ad-6091-08d9a92b396c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 18:02:16.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deEzd66s3rwyLJtAl44UJv1RVXbG4uYTPFcRcztXWt4IC1OTKl7ZIhlsPfYdKoRgdayhmBpzLDgElr+lHhuyWl9z3ZsJyjGZZaSropY+8c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1293
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160087
X-Proofpoint-ORIG-GUID: I_zY7uXJxKeFV7IfBDQZ021FLhacEWUv
X-Proofpoint-GUID: I_zY7uXJxKeFV7IfBDQZ021FLhacEWUv
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 08:57:09PM +0300, Dan Carpenter wrote:
> On Tue, Nov 16, 2021 at 05:21:34PM +0200, Amir Goldstein wrote:
> > On Tue, Nov 16, 2021 at 1:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > Hello Amir Goldstein,
> > >
> > > The patch cacfb956d46e: "fanotify: record name info for
> > > FAN_DIR_MODIFY event" from Mar 19, 2020, leads to the following
> > > Smatch static checker warning:
> > >
> > >         fs/notify/fanotify/fanotify_user.c:401 copy_fid_info_to_user()
> > >         error: we previously assumed 'fh' could be null (see line 362)
> > >
> > > fs/notify/fanotify/fanotify_user.c
> > >     354 static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> > >     355                                  int info_type, const char *name,
> > >     356                                  size_t name_len,
> > >     357                                  char __user *buf, size_t count)
> > >     358 {
> > >     359         struct fanotify_event_info_fid info = { };
> > >     360         struct file_handle handle = { };
> > >     361         unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
> > >     362         size_t fh_len = fh ? fh->len : 0;
> > >                                 ^^^^^^^^^^^^^
> > > The patch adds a check for in "fh" is NULL
> > >
> > >     363         size_t info_len = fanotify_fid_info_len(fh_len, name_len);
> > >     364         size_t len = info_len;
> > >     365
> > >     366         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
> > >     367                  __func__, fh_len, name_len, info_len, count);
> > >     368
> > 
> > Upstream has these two lines:
> >        if (!fh_len)
> >                 return 0;
> > 
> > Which diffuses the reported bug.
> > Where did those lines go?
> 
> I'm not sure, I suspected this might be a merge issue.

Oh, duh.  I'm using linux-next.  Probably that's relevant information.

regards,
dan carpenter

