Return-Path: <linux-fsdevel+bounces-49454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870AABC7C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C45A7A3755
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4E211710;
	Mon, 19 May 2025 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rQtxcOVU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oq9Db3iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59621019C;
	Mon, 19 May 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682823; cv=fail; b=ilPRxbf+ax/NXxpVzUJ8qcGGW7h/bjhCv+wAnEfEZ2eBS8wiY3G/qtDpZodAo1sS6GWs6RCCgKA3Yh000oYwnIl4DA9Iq6jBgWWn8eJkaaSDeARCZgTtEUo5s7ggoHa3ZwywmWF2xLD0wyP3t3HDpFEc7wGcKLaRyxpRhnTEmgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682823; c=relaxed/simple;
	bh=jRwM8km0nKNLW7lKrSnr9Lv2UlKnuqGyOUJF55w+0Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUJ1r/woUUEYRA+Qqlte/rRR26Cv6nKztGbrMDi7YeB8WEwzp7C8phL+GozdXPHzCgPjkTqM+zCQ/5MW/FeYqmXfO0Z2hnWUppH6rYdWYvdu7KeDLC0ji3jXN68vdbWesTEI7sxGhpZkMmxWpZNg6I9d0+Ci/H4yV9g94SSy0w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rQtxcOVU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oq9Db3iz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMoSB026232;
	Mon, 19 May 2025 19:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jRwM8km0nKNLW7lKrS
	nr9Lv2UlKnuqGyOUJF55w+0Vg=; b=rQtxcOVU7+x2XluminHhSDIXaMDh8jiSbU
	hPpCrvWkOOgXD1YE2QVivFoTvRdBd3XlIKbwrKleFIvGLhFZq1OyqjYcxdpTn+/l
	K2jxAYSRMLKM5TSTO0i7CsO/Zj+Qsofdhq8ZMihAprJL3zMamCOnGrOvk9yfvW0B
	ylKazmxBtb9RQKtxwXWwKel8741Jdlq1rewo9njFiLKGrUKXh8UiH23C3Au2mD8H
	eSD0dQg81Fxx9AG+uEjJPmhJgVv+nTxlYv8TbuipXrTp8WWlbND+a3IHBTnB4iw+
	8FFEULrDli6rPgWdDJ7StVT6TOHs5hVUyEOmz8OqeUxPrwhL5Akw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84kthv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:26:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIvAYG028887;
	Mon, 19 May 2025 19:26:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw73bs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWUDAtkYSuD3EPyb9Wxjvr1R+N13byMTZdyZtm6vClpnWE+0lxG6ggNhd3jTIl4D3MUkrFQ7pkCkeUjYU556ibu7sNUogb7+xTg5HgbidPu1Nmduq/u2P6e45XNOdCzp+m3x4yhkcZgoNNk/1oOyyxZhhmXGP2RVULcGYdUXoAsSqyItKIXYmbh6cuNiAjcHuXXJy+TrWRQjxg+tfQhe2b37KHqHf/FWJmWWwimwNX7X7fbAKCWulspo2xg8TXBiXpxXcentgzakoyH51j1a05nth4PCasQ9POBcOAUFo+wtsVyC5f01zyLpsZw3VxA1t6C8VSVDnzDjHnFNZjIspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRwM8km0nKNLW7lKrSnr9Lv2UlKnuqGyOUJF55w+0Vg=;
 b=XXZ8sJ6ix0Qm2zXegDJWzOCL1edYgbGsAawl2FuuMuniLedgMNPvUTuqlw/oVCDD95FXuq42lo7bTVDQtMdcJWOe8JT8mygtHdpGOybfs58R6rNv30IG7X40ROnHKdqrMsLYhVJHYLy9DPxdIwUMvdwZ58XvkH6xAX6lt9RdhObVdSBGUXu83thV8nPfqiG+bT2GGmuj9YUo0EEEErqu/N36JdfgoU54awFeyX3jn0CuEmHYM92ukJMbkgKEYsEISj9H9c/QtumoSduBRbS9i37loBvCvWVQqe8QCraUlYimSiI/3xde95K0X9tT4/pAENig9UXRGFk7WZV7Z6VokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRwM8km0nKNLW7lKrSnr9Lv2UlKnuqGyOUJF55w+0Vg=;
 b=Oq9Db3izWymKmXD2GooVcQV9+6ZvwUnP4HUw9lj4Tw4FepoFa02nWzuZNXEp0qynk329QTO2FUgJbTUhHicUCK2+xhVOkDuZfAAmCojrqZ3m9P88hXQXy7Qa4Fw+evZ7lDqhOO4uNGpvdUtZ1fURxMV6pSq31MM3yimSh1mWvbQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8010.namprd10.prod.outlook.com (2603:10b6:408:282::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Mon, 19 May
 2025 19:26:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 19:26:42 +0000
Date: Mon, 19 May 2025 20:26:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <36ea1ee7-bb6c-47ff-a6cf-18f43fb23493@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
 <3e2d3bbb-8610-41d3-9aee-5a7bba3f2ce8@redhat.com>
 <d8e20b76-1eed-459f-8860-a902d46bc444@lucifer.local>
 <e5085602-e97a-4b30-b640-e1e4f2e77cf1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5085602-e97a-4b30-b640-e1e4f2e77cf1@redhat.com>
X-ClientProxiedBy: LO3P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d04778e-81ef-4acc-ee65-08dd970b15bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXS1dMmvnb1KTvk+5d/YggExtF6eIMb3wkKkmbFowSG6GjLRRb93G3g9q57r?=
 =?us-ascii?Q?zRgoCEzBpN2yWAqBVwdYlDnkwF7wY+LzPyYzDhnyXsEMB9iLKlO8zrIFraQE?=
 =?us-ascii?Q?1RGkSpj40ujvoc+ZikRPKaOHpZ7pT95AlQfCU/xdNh2/a6KZ4vYIw6+Zp3Lb?=
 =?us-ascii?Q?oW+sEy3q32KT7teiFglgavsk+LZyVh18yZFR7UDLvoRpfRH2ewSCep+pRupM?=
 =?us-ascii?Q?wJhGE2YhdGcm+9UqQe16B+KfVYo+u+3T3W4rAaer0yyHcsoTtNpVNQNM505l?=
 =?us-ascii?Q?aqJpAJK3S/Vz9doj6AOH7djLdWKxSr0JiwS39Ij+KPl8VbPduPxxNE+Qu/uF?=
 =?us-ascii?Q?VGXWHVKXnym3YypvNUHX4OcN/wr3dnrE21U2qsk0trbFaMVGaMrOgl95iFBw?=
 =?us-ascii?Q?evY98uCV7RFP0ZUrNes3Ar6aftR77uvr/i1kq7s+HdXebzx9v17Uwtmta/JZ?=
 =?us-ascii?Q?Ajz5gOZd1qnnbOmCF+bX0SDqDudDhCDW26PV5vozXSZp2tQikdHU+y1HLD9n?=
 =?us-ascii?Q?9Cs/ahmqAaTn9qQbSdx5QpfxuVYYXXk9vFtDkH4w0LysGdqIXUp2fm8yYYlc?=
 =?us-ascii?Q?a9eiVUFwzz+3iwdfgdYKEzSFbDFgLCNgQIL0htPCPYCHeAJhASoTDwx1rd/t?=
 =?us-ascii?Q?8F/2EDjMLYmT2gl7rA0v5SKs40VzFljDrti2eLuNZvaN9NV+ktVe8sVg+coX?=
 =?us-ascii?Q?ckQpxYhk2LHhwAzAFvfsArRXHsHlJJPUxYean6RarhmfISAb5PcXS7HYzcWy?=
 =?us-ascii?Q?3tEp09Y49YDhQKhNXzxr1qKy69ybZFvA0N3F5BI5kO5nnp6eFnLg/Hq80rCD?=
 =?us-ascii?Q?IiBEA4gIf2s7oqJuY7LaBwxIaAuc5d5hmIgCVVFFBoeUTZkdl/Ff0jk5zWw0?=
 =?us-ascii?Q?NUAKftlk2fFPmSshBnSV/VE3AqN6W4rPtkODNuqBhPKEAxiSoC8CkNAdK6Cp?=
 =?us-ascii?Q?rXDjO7GS4ALyAvvrXnVpOdOWPPOd38alFS+FEMTEuvU5LqWRBcxqFO95PEhg?=
 =?us-ascii?Q?ztgrhOjjZRdNFX7mi+n6gg/DGlb2tFM1NO3pYYkBAmE6m/28USnw5+6XMh+d?=
 =?us-ascii?Q?XJwEIDoIYcj9LxtmZETKa3nom8wyMCO4O+5BHpZIxx73snl/sxwUaoGFygki?=
 =?us-ascii?Q?KaZztkHmHIuCrQdufBzduhbnL6CVFaxtpCRWtMPo09Y7lxakPRZIgxKRMl/g?=
 =?us-ascii?Q?rsKP/GbOHZJeG9pR9JjQH6tBFN6bdurOGIeSdpo6MFUscBPAXTPbS9qRrMxX?=
 =?us-ascii?Q?p/9/Y8oD+t3Fc3Axz/hMnHld08MYY72pOjNiXNUFc98GGUtsbYRF947myfTr?=
 =?us-ascii?Q?uzQgTIWnEshbmu6UkVAjCED+go8K+Y1JW9uA4Vw+5vck8pjLx0BR5EDuxy2u?=
 =?us-ascii?Q?sr4SSd3PZ5uqV4M0DgHi6lxzcup5NM3hKG4WckH+NEao4dEuCYp09kueI0n9?=
 =?us-ascii?Q?5uuVs+djH8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eiSyG/Gs9u44pEpsFD6OPie5HD19SvkjCLF4lAvmAsW0kGEtfSogWEBMAKC5?=
 =?us-ascii?Q?BeLdbXP2EQ6neEXJZqUzI+f2YWrIBWOIYmjcdDH76bXyZ5kmClkGq9qmuSJt?=
 =?us-ascii?Q?VcCZaJxePPoDM6MFD1pY5gwAu/FcozOWPcguV9fjmSwXPURhZ6nIn8f6wIq5?=
 =?us-ascii?Q?hcMKJFQtXmlYzK7j7XeTDbUXzjqlJdu2QrK/dSTpstGt6vqguv1hDJ+IRG8n?=
 =?us-ascii?Q?OkUKeY8eY+wm+aam0OaUFU9to8fFGtxmlx4KdZXclDGZiiyQwlXlYy0xo5m0?=
 =?us-ascii?Q?KUK46PGtn7s85zdNWwVDVMPlwyDCfU9da/3Hlu2QqOh8y8gZ8xkYb9eYMFKo?=
 =?us-ascii?Q?dZ719pRvs92zhmrgYCKmIhRxkkJ5rZKP6wNsEtg7yz61ITDmZcypDNL/Kzas?=
 =?us-ascii?Q?096v7YYdnUevXrrcSKx+1XAz+1144va2g84ycT0GMYcuANkWk8jWvOnWSY/4?=
 =?us-ascii?Q?UPJCGdwo5A/o9h1kOppKRcH3ZVZEkwu+bLvbttNGIMTVu54cuompsYViceIC?=
 =?us-ascii?Q?pH+0YVPzFiMsG5zzI98Hx23dS3509BV+00WGKob/SyCoG3nuVfyTluwSCsD0?=
 =?us-ascii?Q?9BqYNbTr5vCVpxaTZlcFkpdenyFPtttAKSgteurxdJDTC4guJR2gA7mceW7f?=
 =?us-ascii?Q?8cJUvP3P000peKC9QnA4nmdSvQMy1wzO4EF7G8MUdNGo36ShJGGOIX6o1A3Y?=
 =?us-ascii?Q?nV/cFu1Ps56CKMF1KQXcULzJ5falDOgGpMF2Lr/omS6dAc9v7Nk1c+alq1by?=
 =?us-ascii?Q?8cZLHBMS9ba5qN+UYsQ6q35zG0H9SDlz1iLbqH2RI7ctkkYisJLM4nySi0KD?=
 =?us-ascii?Q?OeVi5ctvGL+E5jU3beUdgM14jJPlKpDvwiknuGpl4cXxe5qmGisDVglxFshv?=
 =?us-ascii?Q?K5UYVrENugwXt0mO4WNiZZb2P2H6FtF9hUt6+N26PgmPd8DFlUjgyQ8F7nUz?=
 =?us-ascii?Q?7Na+9HBW9wB8omhh8fV3hUO+H3dUQykNB5hz8K8WlKBgKkwglMTmb3lWtmF1?=
 =?us-ascii?Q?sDBrxaciDyBlahtXDVT+/THvORZ6ntfnnQkMpM3b/mWI02ioWIY69j0lOnND?=
 =?us-ascii?Q?5XbG32H6ik7ZEHefTp8b+eWxYg/DyvsMOuIYBchaepH3XT9DSTsmtUvexL36?=
 =?us-ascii?Q?AfIwSabmjsbD2hq2j4unpzitC0BEToMSh1TR//U+mdNIr6gXt20XzXSsq7ms?=
 =?us-ascii?Q?uqxVnbYdv5tInIV57TSXX7l6cy5ffIAF1dzNoB41XIoRW5Vhxpw7B8Bpc8ru?=
 =?us-ascii?Q?CCFoVg9An37uFrV7S+6SOE9CzOUuhHbpWgozeE3EpqbW7iG4KPRKVHMsWT09?=
 =?us-ascii?Q?gDZi4C0V4QRFxwo0rpNpbpUKERqDKsGi7ySabFH2ymElC5ssNHzJVM1ujJnc?=
 =?us-ascii?Q?pQt+jpLThk4mN4p5OKuOmhLJD228mUcuOfSJ7qBkXyPrbMz26NFinOc819R0?=
 =?us-ascii?Q?uqfZJXxqBBNgK5LjcFJAmVpn1Ao9PP0PlrhMaTpB/AbJ8LNc86br5Rz5S2Ig?=
 =?us-ascii?Q?aAOCm0Qb6ev2JGcgbhi1XMc0KDBhQ14ZS2aY0PiVt0N67z4jNG6R7EVaeFJa?=
 =?us-ascii?Q?tF/hd7PNcFjrFez4kv76ggq1LohixuAEUfyi9o6mCGK9j5SEvmSIPGBb0JdS?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dwIH8d2MKV7IDpwDnzW0wdNc/wMbpkRCmuDcuDRTzXMV0S93zS22ZyP7fW22Rv+U0KWTi9cbeTI0OlTCXQrVYTV9uj4PJuN2TETWP4gvuGltgrRIJ8FXWJWOyHgW2+egDtDZe2BK8gKRxpHAWCprzLcJjwpUBHIp96XMewzhlOnZ+6uhd9xfXH8KwnvACJWJdo+Zj73dSX+h1nf9vi4Rvgd3rercIJAKN3uFHsZ9vTm2VvLKCLcnDJPlzskgyaxQC8rK4flOoMEMaWC07gtRC9+Q9VaaE0o2ZZohMe+fYSau6Zsz5aK4/Da0TNJzDwCc8eGkquOKbBmBfZSramOsgFRs1ivMLSzsbt4TrRx5dkDZs8pN5OIwq8xUhJWP3O6Tj/GADCTbCjwYKY2nZmNnAl66XTIpS6wu51J+uQFYwo+PSAn4VBpawvYAlDD2xyiq3HvyzhDwBdm2q7Vw7fSQYuuJrU4S8pEpmbLjrmfhoFFVC6n10EFOkk9Rm7gVqoLbrmZR+552f/OcajtoBisFWfLuczZDTV4NyJeW4XCZ1D+JL/v40e7YfAcAWyVMW4bL5l27lsEPWAWo5ecDIpWbKFftgEWSb8D65PDGygmrl6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d04778e-81ef-4acc-ee65-08dd970b15bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:26:42.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qPLYieL+smi4z1DsXOjAEvn+Mequla4ESWNaERj1+Bz0Ojq8HNFTyobk/j6aRBCIQncEmQGwn8o/tqURtDzzyqCj4e/5HgM2HOmEU14X20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=622 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190181
X-Proofpoint-GUID: v8rR5W4CYmk2A6qqOE0donkmTSVXk7GB
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b85f6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=TkEz_1ESsawaIVgwL8gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: v8rR5W4CYmk2A6qqOE0donkmTSVXk7GB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE4MiBTYWx0ZWRfX3iKtum+dA9Nr BLbepXLqwpSWs5AmdavwNRNGLJtJrgkd2uwRwPEeMe/0Hvii21S+tJa1myFsC21rCYjQGn0BNsQ LczGfCWMaoNHjsVoInUVRpLNj4H10nK0uc6VLnzm8NMSiLtilsC520upRsP0hLPZAdYpBbnP5FX
 KTOzL3lJkZj5xI3/aNDXtA2Tx2nZN0yOnW1MgGMoxlN4JkAV7pHMhFeB6udK3TG2eXpY9+C6r/K w6tVNNhmsn1HzQB5OzO+ofrHYaiY6z8BkUyDl2OIWIOyU2DRHJ80HDSbwG4hlWuKJREwh31Um5N lBBC3PAs22w4ktzphJZwPUIIOwezbBdkPSA7kJiPt9hxw8yzLeernbUCU5iNNn5wzBHJZvUjlDU
 I2WCzKRBpd6imJqCk/DBlfUqWhnO4Z8Se/G5Yn1RqIhmbz2WOfhHQgGpVUL7Jo7f3PE7Vmun

On Mon, May 19, 2025 at 09:11:10PM +0200, David Hildenbrand wrote:
> On 19.05.25 21:02, Lorenzo Stoakes wrote:
> > On Mon, May 19, 2025 at 08:04:22PM +0200, David Hildenbrand wrote:
> > >
> > > > > +/*
> > > > > + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> > > > > + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> > > > > + *
> > > > > + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> > > > > + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> > > > > + *
> > > > > + * If this is not the case, then we set the flag after considering mergeability,
> > > > > + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> > > > > + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> > > > > + * preventing any merge.
> > > >
> > > > Hmmm, so an ordinary MAP_PRIVATE of any file (executable etc.) will get
> > > > VM_MERGEABLE set but not be able to merge?
> > > >
> > > > Probably these are not often expected to be merged ...
> > > >
> > > > Preventing merging should really only happen because of VMA flags that
> > > > are getting set: VM_PFNMAP, VM_MIXEDMAP, VM_DONTEXPAND, VM_IO.
> > > >
> > > >
> > > > I am not 100% sure why we bail out on special mappings: all we have to
> > > > do is reliably identify anon pages, and we should be able to do that.
> > > >
> > > > GUP does currently refuses any VM_PFNMAP | VM_IO, and KSM uses GUP,
> > > > which might need a tweak then (maybe the solution could be to ... not
> > > > use GUP but a folio_walk).
> > >
> > > Oh, someone called "David" already did that. Nice :)
> > >
> > > So we *should* be able to drop
> > >
> > > * VM_PFNMAP: we correctly identify CoWed pages
> > > * VM_MIXEDMAP: we correctly identify CoWed pages
> > > * VM_IO: should not affect CoWed pages
> > > * VM_DONTEXPAND: no idea why that should even matter here
> >
> > I objected in the other thread but now realise I forgot we're talking about
> > MAP_PRIVATE... So we can do the CoW etc. Right.
> >
> > Then we just need to be able to copy the thing on CoW... but what about
> > write-through etc. cache settings? I suppose we don't care once CoW'd...
>
> Yes. It's ordinary kernel-managed memory.

Yeah, it's the CoW'd bit right? So it's fine.

>
> >
> > But is this common enough of a use case to be worth the hassle of checking this
> > is all ok?
>
> The reason I bring it up is because
>
> 1) Just because some drivers do weird mmap() things, we cannot merge any
> MAP_PRIVATE file mappings (except shmem ;) and mmap_prepare).
>
> 2) The whole "early_ksm" checks/handling would go away, making this patch
> significantly simpler :)

OK you're starting to convince me...

Maybe this isn't such a big deal if the KSM code handles it already anwyay.

If you're sure GUP isn't relying on this... it could be an additional patch
like:

'remove VM_SPECIAL limitation, KSM can already handle this'

And probably we _should_ let any insane driver blow up if they change stupid
things they must not change.

>
> --
> Cheers,
>
> David / dhildenb
>

