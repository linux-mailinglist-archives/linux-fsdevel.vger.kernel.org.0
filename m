Return-Path: <linux-fsdevel+bounces-56676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD6B1A88D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912AD18A11EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0D28B408;
	Mon,  4 Aug 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVD/3u3j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cG0VOUwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9594220F25;
	Mon,  4 Aug 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327997; cv=fail; b=VBYuqHaaNEZa6++/KNIzSbpT0+MwAxPkkcmz2E47PFeVtWZ2+X39DQ1viuHIAMa0OysEMmrwYkiED2pnkeybRDjdhA9NHZmKZtPD6PppE8Gxh17Q3TUcrPSmdOeprXrCDy1+i7B7L1ba2Hp+rvl4SPdiuu/X2Nydi43xGNf1v3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327997; c=relaxed/simple;
	bh=pNax3dDbb83xycjVHn5mOHaYfo274kXyDzYB6nyuE2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uhFm6a+643HxWxpBNIKuJzpN4HP1dPp0oEyNGroJorG7+zqEuDxIwo4SHkl+B+K8O4kGyS7yjok65yKkjw/nzGhnTcjZawuei3gGpKrOQw2V9w3pZJ4SmIWixEt5VNZ1dhK+88vu5jfOhct2ID8d6Dx3nDK9MXwyUlwJ1/Wjyao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVD/3u3j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cG0VOUwN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6Wdi018171;
	Mon, 4 Aug 2025 17:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VDfU/cujHmdpe7nx8Z
	JIOHVGt+UjDZNsvwWluSqD2w8=; b=eVD/3u3joYbs6btmFO4vsRhRF9KE1tEIka
	BR+lCtFGbDIQE0hqbIkFa1vF9dE0jxO6FVtBB9+V6zha+AKIZPdZ6SDMAJA1W2Rr
	0gFKjZeiUBPQyNtiF3X3MQz50ubvdkCLYnLvvYmRnCkDc79VwWAhXU7yJHpKWnmZ
	mJJKvO2LZvZqqvkU9rNFx0Vc/aXNH0GxY3TL3zz27bkVNtsF7vDxDG3mTNVZR3oe
	SL6qtGYmRBaTEqAZJQZ1+yolSp+V5E1BB9Wp+CmeYjyC/cwLKoi+JHdJJsuaXoBP
	dKMGN4/OWhf4RnE/9FaX7GAnaE7ja5Au8KCBexvL82/fP1V8j+wQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489aqfk3j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 17:18:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574Gbseo015053;
	Mon, 4 Aug 2025 17:18:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q0xsn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 17:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU+IrcMPbLDZJccIPLlv+Tq4ups4WcAVS9+d68KMnYuvr1aW4Jt2w1VLJR3GXA6a5cg3VXaaofasTAllDgC/YCewo0Qbx7ebVm/P7ye/N3A+qJ+vNfpFMrD3+sn02IL7osPl1Z8E6EhD8/O+MHnOyFKQDxVi+os+CSTcszHK3rBaCzz0aVAkXtzVcIcrlk5Rd181Db3MM8AtareJeYIlinnJdUsfCcbnoOOdC/iXACpjZVjQnPYmP4uaaLDfa/Ak2EzW+m+Ih1PYVFtwvAKQ5SpYlc2Vd8xQBr7xTbmWTKLqL0J6mOxgrbr+BCQo4MCYK3PgljTYmjQrPX3wLnMd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDfU/cujHmdpe7nx8ZJIOHVGt+UjDZNsvwWluSqD2w8=;
 b=JgejCZP+qOczhgUaEoQ10EMQdMe8EIomJ2HmRjF4eV/DfiSk3O9LuYecl7YKieqXx4oKh1nQRXN9dB0JBlgSsPzn6AhQKRJW0jRLpID7L8b3mDsb2JO//5eDqRQyad6Zjm4/lgRC6p7wrLhvw7XNwpjzmXRyPfyQoAtkka1HSS8PNQqW4X87glYYUZ+k36LxQrYsp7FzpWUQlsJ3kiBr1Ra1KZtACyvFLA4/vtxVjRGWa9OcgFIzi30fhivqvDCJp+/KylBRwGtHP80Dpk0tn5z5tV+H1i3QhGB615FuJbklK11gDI+MQaStx77D56Ti+GJ8N+BFPA/+NUj3kbxyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDfU/cujHmdpe7nx8ZJIOHVGt+UjDZNsvwWluSqD2w8=;
 b=cG0VOUwN9io7Fmotae0xfycuPfXbnP0DWl0q75k4VWhVra7j6wkXGeZsVtQEb9PV/AZ5pir3FOYnIGDLg9bWtrBvqyPt8p24EcyS0UOjY1fCmYugQnPNOZkyouSUcX0zl5vpv/R4uEbJGAuqA1w676DtAea9Vzada+uatt03Ve0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB8209.namprd10.prod.outlook.com (2603:10b6:208:463::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 17:18:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 17:18:48 +0000
Date: Mon, 4 Aug 2025 18:18:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
        linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
Message-ID: <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: a57c93ea-43cf-4a21-0bf1-08ddd37af95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OE+troyfhubT8+QhleXtyQTjcJtHnIpFqWLaVGDs7+GnV/0aAmMtdDFLDOl+?=
 =?us-ascii?Q?xK0bK9z3H99Tm5w9+ebcmEZpK67yBiPmutZ+Q/HsJ7GKBPegkBF3b4htjypC?=
 =?us-ascii?Q?6reAd01ZpVU8QeGN9PA/JiQZW6mBZ1MzyThI2aBrtXN77xlqKxe56EhHigBY?=
 =?us-ascii?Q?1gxCM2TdYTTBRR8d4nHYcduEhXm04iiTVF0F+j8oBk5kem/5jeA/HFFl4trT?=
 =?us-ascii?Q?vKC+QMRqiUjK3X6YTJ24JrqQr06wHHfCFIsMGaKtaCNkyDxoJ5qIHcfywfaN?=
 =?us-ascii?Q?IDJ7eY37Tqc3Hj7jdsPt5wnv6ShWyVJ6IiyV4gtnBIX8yKA6Rcw0PEVETSZ9?=
 =?us-ascii?Q?YSwX+NU+QLa0CvPnFwYQy4s0e+xbv/5pU/WLLGX+adTHXSKS/ug1sx+VfcA6?=
 =?us-ascii?Q?FsRfSIXHi1XixWJIr1V+ao4wdI2cH0iIV1gSVPE+1d0YqvVyhc81nn/szNiZ?=
 =?us-ascii?Q?GmxDFnrnUMP7QkYIJQ7ShW9YtJwBFmwj4r/h0+xZstZE2m+ypq4BgaUwZTIY?=
 =?us-ascii?Q?9p5Zygkw43DSJj4K+/gyGUWpIkEDi0sfsMuQ3SuPAz6+fPMFLMJjE2G4Dn0R?=
 =?us-ascii?Q?qugor7c/IF93yQbA3VJhucCvH1VhvEYEn50Dv2x3Kkfo+xmYh+nSLtIhWt/U?=
 =?us-ascii?Q?j+AIC1ejEW3tR5zSjAbQL8c9O0k7ktBQyxEoZXIVIER7E2ov7eoZkHgbIMrZ?=
 =?us-ascii?Q?Kk9ze7b8C53eELkhPrZ9txvbbpcHrglGU1YQMKvgt3un3a5+xkg0Ou3Jc4tD?=
 =?us-ascii?Q?VCftTS+w/A0fTIbo4Yc5WLJgTbSIvrjNrZyM0qZXEKzfUPPSdd8FSJFAVn/u?=
 =?us-ascii?Q?xaS0U5+N87hEUpB/KpbAy4iHStzu9NSpvYyl42MAK6V5VVhgTeFTjnkpbYBU?=
 =?us-ascii?Q?PeLrm+lZpNkfjXOchyCT/yw+H/5DulS2C1U0oxkqCzWRCjf+SogM1KnXRNcr?=
 =?us-ascii?Q?G4muZpviIXLFkupZUzOFZ9oFDCyL65NOIYXUxG5Cxaw3cFE1qH/RKQwD4U93?=
 =?us-ascii?Q?QDzhnBkAv6ji07zlNyhoQhAFt7CjcLn6b5gXbpUUe2V1aAYXjJPHOdAyvD4v?=
 =?us-ascii?Q?LDt8tIw4ZmDoenPZWpS9IXag1dbAaez57q1mTYEH+YCGQJbQHGmmtGKB1LlG?=
 =?us-ascii?Q?wVBvRaXdguo61NKq4bMDFGhP3uWRnLIgOpOzeWkILWiyjtMLi4mHPwdm1aos?=
 =?us-ascii?Q?oJJq88ONBds/6t1ol+FbzazNbX2Zg7snDWcNIicV7t+y4AjZE/92hl5Z5wXA?=
 =?us-ascii?Q?m5rH4BKPe218p3ecqQjauTzf+FxTsXndGdhJYZC3O3OkuiZwqZXdseXdql3r?=
 =?us-ascii?Q?vVS/tktlCn+i50lS04ZFxv+nvHNpD5B9fgda6tQKNvB8229DXgyEIlCxhrNx?=
 =?us-ascii?Q?3TmMQZyt6mGYYErNBVrv0TE9t29usdCZYC+mzhWQLkgdfQpGMsKc+Ho8ZnDH?=
 =?us-ascii?Q?MZcGT57mMwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H0/2mrLY5wnZLmBHmPzOMXHvPKkBe50lXqlX0RkZJwuUSFxVThFSN18/4CJ0?=
 =?us-ascii?Q?VUV5lB+FXUg74mwOBLwzYpXoFS/4my8F0HYmcD9YbctKmXAGxs5AT9JNCA1H?=
 =?us-ascii?Q?Dghj42jr8NRIu8zzNmr8c+VJcDM+ZnqgQofcrxEvOKOAlfLi1iyJ9VTzkjC5?=
 =?us-ascii?Q?Rbn4f1+o4YBLPLn17swPeG7aQpbh9UEXi1tOhjqnRU9JeNDXUZB50qCO9jdP?=
 =?us-ascii?Q?1GT10cNTcU6/kesuz7rVCyTmYJ9x4EVDn/zc/thtKfTKQbprDcEvAj83MoCc?=
 =?us-ascii?Q?brtmkN41rlIGq6I7ZPCjD8jbS+nJdhSOk4PdRKQiNzr1jjghVkwZ7StNZiGr?=
 =?us-ascii?Q?r+X24ixdoOnk/rNIrEzY8uoVrvkA9EwixEofHD9wW7JMdzlFO9zk8v4QwtpK?=
 =?us-ascii?Q?qdS2fd+HvMx6gGx0Vu7YRHQEMcu+QTp6upcy+rwRDN/B5RRm9fzDqIG/F478?=
 =?us-ascii?Q?7BozLGA1RB8j4y2g5DxDYbLhLorBgGvtyBT3P9bP6jw6BW0W34ZvrVE3wlRG?=
 =?us-ascii?Q?QJKD8iAKmSfNkhiZsfofgwc/YWEcp+ITibsEQZT/iRIgy0LI3HFHXEj8BiRD?=
 =?us-ascii?Q?MYCgp57rQgh4DPS8LVP6+BjzRbwP1s9oeBt4/DDjScmN3KimrX6wub3Pgv6Y?=
 =?us-ascii?Q?Mmeacxe8EdR0CcCwxaga028cgw3BjaB4F53jGK6LIoKtAfnKayMS2V6xlVsP?=
 =?us-ascii?Q?rrauP/zIkjiME6COgq6nLXSHfsN10lRidIQma8hFPlxXvfbdxNKKS7GIic/J?=
 =?us-ascii?Q?hf7ljzohP736kzakMrO2uFOuqC6/Z70A27oTg0WMrTkCrE1qhA7sK3PIvZza?=
 =?us-ascii?Q?9ny+MB6hFV/sGL1G0XMnuPADRXSRiO5RYP2gycosYmrsfsTDQ0AJ8OElUJv4?=
 =?us-ascii?Q?CtCckW8blQAhw2mLuvy3PMca2KmDqUsNM+TEz9k1FN9ttkRSV1MlYi/ESnab?=
 =?us-ascii?Q?/srRtRydCJjQ/3gZTp7761CFnVqKwSRad+06auy4mtHAiVgHlJ4Xk/nO09Wd?=
 =?us-ascii?Q?SsqaPD26G0PX03dxM3jr1MID6NZMJ1VVtS32TEhfOt73T4fMC7wtMFShlygA?=
 =?us-ascii?Q?1D6xshWd++ECHTLgyC7z2czLLQF5q4yd807tnZNe9gq9SzaX4w+JA9iqtvnq?=
 =?us-ascii?Q?CQoMRTaR0goGeCyu8aV7Xqz7+FZ4+hi7CE44iYb0TLnWzrLOUsZYehGucaXo?=
 =?us-ascii?Q?hTKQYmrqS+uHnVvFVFmvMJOzYcTW4BEoFUarBrqbiXz2kFM0/AYOQM7SbT3k?=
 =?us-ascii?Q?3X65slePtePqJpttSRELCpNusqSFrBprLFseqN5IYclI/Iksfup3WeVnhUoU?=
 =?us-ascii?Q?vLBUJ3DcnN1Nin0Q6BUIqMZMLhXCssxsaGhBVwg6iVx71eKsYlih4CYrBve+?=
 =?us-ascii?Q?QzceEjRq8ZhBTxvKTZVPiSRDw92/y85/LjXwzLNJJ/pTdskUAFTnGbWrx1lP?=
 =?us-ascii?Q?Dg4W3UcxwvFqGT5cWOTzyBUhyaY1OF4vuZpKbGxk2IaK/nRx74kXm25kHF99?=
 =?us-ascii?Q?gw7PwsHbKwKP8W29VpTjkYeNnRoqafIcZwlBR3Z5xaHQyDPTsC7Gszyjz5dM?=
 =?us-ascii?Q?anOM1rVdBq7SwPfU8LOWdDQTGDrg9sU3O6QD2UMDtiOtAm3FdrvvJyvaTzQ4?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wsRdUZBMLHHlqBj29zsVo1aGx6do7uMQOtRtChpzwstvlUKq+OFhfPm6tKofS7i+4Wpr6PHwZNyIXo9fjLpq4k2RWckkiIcu9vy6zonhYsK9WBEYbpi/AIUiPVF83zNiHPEC7ZWloxyTM1DKC4Xqy+6RPcgF2GYiWCKcVQ5IJZ7mCH0A3OASBCYkjt9KZC6NMxZ5pa9jnqQcg3F3A0MbhgH/lHwGhzd4Z5BmrPctValpnB3yK9H5um3UFc3sP479DxId5CuccDcwhEz7u7gRU+QDXgX8TFNdxbJmlyfB+frMpqfoh3EJMY7oBO/Qh79NjyyZADK0EcjNrUhjCAeUJCuhzq8hFUZLx17WCMwqc/zpJLUoHAMC7oMTsIDLP5eRdTh8cbxn9XrqJfOfhhEV8N7vON52FLSuOTIdpxKqJfGzjwE18Llk1m8p8MP790+oMFtqclouEiSPS7BrrCzY59vByOd9rT0I/vz89k4DsnM41cxmpTMFlogOLGeAutXMzCXN4g+KmTJ6y0PNolip7HCB6rLL5mOO6fdI1u8H+KZDIpqhu3VkRP9o9Kt1fUvVL5k4a6gu18LIjsWXcoD74p68IShotucG0QAOPlCC6xU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57c93ea-43cf-4a21-0bf1-08ddd37af95f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 17:18:48.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pw3C+xQ9XRHd8eOcPdVEz1cZteOWCID7VZEpq7yWVltqm0vuy07t7p3M0+/7RpjxHE80kvc8cmK/OQ9qFs/K1VvhUSsgOK7cMrKF3xUzxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040098
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=6890eb7b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=8kLLf2FT8XCgebjRI7IA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12066
X-Proofpoint-GUID: XdtM9egek3MIW1wfg8zMtQRcN_sRmL7l
X-Proofpoint-ORIG-GUID: XdtM9egek3MIW1wfg8zMtQRcN_sRmL7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5NyBTYWx0ZWRfX/lr4Jtozd4os
 Llw9BwYOXIPzG/xMv85KJ3xSPxbgXaTtHEom3iGYly3KJ63sOgZ+wHDDC+t7oFXmamg11UIYBfc
 6wF9QfY/giCOOml6Cg8R2+3iO6mizGpj9zGhBHxNGUt63LLaXc0408wKWYXe1yrW5PKO+92e1Pc
 cvi5srzhCMHsoFeVLaBlNyL2okTTgx6zjEhFNkt/K7WjFaRYm4uwwdnr6oo7cw+ROX5eiJu0PG9
 /DJwRBNaEpqg50Zhh/AW6Tr0v/o2GbRpLLN7qoJ9x/dI+epzL1eBkkc/8Aj12QntZavDq7OENcc
 QSdaZJ4sWe0VtCpDblLvc0vvY8H+dbjLzOZrunE7EDY5b6GZ+3j96g+hTNYIDXSXBCNa8RIMwbm
 F+zGKEHSHt95fhnINuFgtHaCujjRmHYBmZ26kwuaaQ+Kt7YbzVxxjxtmHyWSMdUxKR+xpbas

On Mon, Aug 04, 2025 at 07:07:06PM +0200, David Hildenbrand wrote:
> > Yeah I really don't like this. This seems overly complicated and too
> > fiddly. Also if I want a static PMD, do I want to wait a minute for next
> > attempt?
> >
> > Also doing things this way we might end up:
> >
> > 0. Enabling CONFIG_STATIC_HUGE_ZERO_FOLIO
> > 1. Not doing anything that needs a static PMD for a while + get fragmentation.
> > 2. Do something that needs it - oops can't get order-9 page, and waiting 60
> >     seconds between attempts
> > 3. This is silent so you think you have it switched on but are actually getting
> >     bad performance.
> >
> > I appreciate wanting to reuse this code, but we need to find a way to do this
> > really really early, and get rid of this arbitrary time out. It's very aribtrary
> > and we have no easy way of tracing how this might behave under workload.
> >
> > Also we end up pinning an order-9 page either way, so no harm in getting it
> > first thing?
>
> What we could do, to avoid messing with memblock and two ways of initializing a huge zero folio early, and just disable the shrinker.

Nice, I like this approach!

>
> Downside is that the page is really static (not just when actually used at least once). I like it:

Well I'm not sure this is a downside :P

User is explicitly enabling an option that says 'I'm cool to lose an order-9
page for this'.

>
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0ce86e14ab5e1..8e2aa18873098 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -153,6 +153,7 @@ config X86
>  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>  	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>  	select ARCH_WANTS_THP_SWAP		if X86_64
> +	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
>  	select ARCH_HAS_PARANOID_L1D_FLUSH
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select BUILDTIME_TABLE_SORT
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b7..ccfa5c95f14b1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -495,6 +495,17 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
>  void mm_put_huge_zero_folio(struct mm_struct *mm);
> +static inline struct folio *get_static_huge_zero_folio(void)
> +{
> +	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> +		return NULL;
> +
> +	if (unlikely(!huge_zero_folio))
> +		return NULL;
> +
> +	return huge_zero_folio;
> +}
> +
>  static inline bool thp_migration_supported(void)
>  {
>  	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> @@ -685,6 +696,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
>  {
>  	return 0;
>  }
> +
> +static inline struct folio *get_static_huge_zero_folio(void)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  static inline int split_folio_to_list_to_order(struct folio *folio,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e443fe8cd6cf2..366a6d2d771e3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -823,6 +823,27 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARCH_WANTS_THP_SWAP
>  	def_bool n
> +config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
> +	def_bool n
> +
> +config STATIC_HUGE_ZERO_FOLIO
> +	bool "Allocate a PMD sized folio for zeroing"
> +	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO && TRANSPARENT_HUGEPAGE
> +	help
> +	  Without this config enabled, the huge zero folio is allocated on
> +	  demand and freed under memory pressure once no longer in use.
> +	  To detect remaining users reliably, references to the huge zero folio
> +	  must be tracked precisely, so it is commonly only available for mapping
> +	  it into user page tables.
> +
> +	  With this config enabled, the huge zero folio can also be used
> +	  for other purposes that do not implement precise reference counting:
> +	  it is allocated statically and never freed, allowing for more
> +	  wide-spread use, for example, when performing I/O similar to the
> +	  traditional shared zeropage.
> +
> +	  Not suitable for memory constrained systems.
> +
>  config MM_ID
>  	def_bool n
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ff06dee213eb2..f65ba3e6f0824 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
>  	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
>  	shrinker_register(huge_zero_folio_shrinker);
> -	deferred_split_shrinker->count_objects = deferred_split_count;
> -	deferred_split_shrinker->scan_objects = deferred_split_scan;
> -	shrinker_register(deferred_split_shrinker);
> +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
> +		if (!get_huge_zero_folio())
> +			pr_warn("Allocating static huge zero folio failed\n");
> +	} else {
> +		deferred_split_shrinker->count_objects = deferred_split_count;
> +		deferred_split_shrinker->scan_objects = deferred_split_scan;
> +		shrinker_register(deferred_split_shrinker);
> +	}
>  	return 0;
>  }
> --
> 2.50.1
>
>
> Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
> then have a user-selectable option.
>
> Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?

Yeah, though I guess we probably need to make it need CONFIG_MMU if so?
Probably don't want to provide it if it might somehow break things?

I guess we could keep it as long as CONFIG_STATIC_HUGE_ZERO_FOLIO depend on
something sensible like CONFIG_MMU maybe 64-bit too?

Anyway this approach looks generally good!

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

