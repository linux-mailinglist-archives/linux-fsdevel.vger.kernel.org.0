Return-Path: <linux-fsdevel+bounces-65409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F87C04CDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524D41AE009B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E32EC0AB;
	Fri, 24 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pR8ma1dV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SiTCmjBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C32EA75D;
	Fri, 24 Oct 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291808; cv=fail; b=O7F3I/SIcQzTTAnba0OUUo6Mi4mjGLRTP3rI0if1+hUe3A6wl6u8VWYjckr8Nex6W1LDeFT+meZT3sZZr50DSAHqM8oGQu7FvjTWJjmn5tuxbTKw3eRQb5RxUBw8oticyDzpiKG8kBneesV0Z83na68RwcB6/OpiFQPeNjX9/+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291808; c=relaxed/simple;
	bh=El8T30aOBq+Us0pTbWg/3iJpWuz0lqL5bTGjbDxaAck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ouj92X0W/T+6pOGFEyZYflyLlUNi0Z+iTCyhO4JdBuJnzI6f/vrh8B0JAeMFdoOdwpKWDO5oLfLL9A5ba/KR57qyvSnjhR2SatFPFJx84yU93LjwVG6ezXAWsZrvAlAKP72AMKUqLlGqxP4HIn69s6C1TYLiql8UfEWP5ZNEMV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pR8ma1dV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SiTCmjBg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NO2Y029133;
	Fri, 24 Oct 2025 07:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PZIf4iwlsRTuR1TUuVn87GVYdvfE10OBNGyBDmXDRTs=; b=
	pR8ma1dVIOsYNCwQIf0ubLupLG1Rz03T/3U4P4MkdG8BYttWV1Sij/KC0tuUg5ky
	L8Yeq8z2V94ArVoWZ9Arlcbhf2fiHMEjsAsVALV5Ag+x+W+ocVliZNIKI0Zxs+XP
	Xwil1M5WZW+h9KxfVMD3tjUPGBT/G2Qt34O+Y0/aCgXo3EU1h0UfAEYZVFdYYH81
	1r/enF0o/3tTZrbtGfrjGd0Sge9Q47+pqTQchTuqCjhDvUSaMdTJ+BtfVmJ8uHjr
	blnQ3LvqmoFBB4KWTGaJs5LhCQGRsjqHC0Tz1f98o8DVhz3xUw0MpGMqwBbKynCc
	G0+PLpBSYBQ3fudIkd0OgQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0v4jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5cSMG035805;
	Fri, 24 Oct 2025 07:42:24 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm583-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7iF8VR4bh5b1qWCdAQH25o80Uzfz7l56lHJ8md4TEp43prxvLl41sIl4MsfCclkl8/41yW+053Sf63dmJl29Ou2ByI0TmBXBMEo/SSMne5iKkSGXLI4eNna1YtstzjZovXWNZyI07KbvGZYAoK2IzMoKQE4MCUxiss97y02lgNOF87xbw7U1g/lAtQ48lzPOPYBsERABt6jQGVedKGiwHgpLHSPxWQn07NKcofRVfUQbciiJtB3dlOUK7rLE6Vp98QIZMGmcn4THYN/u5qdX5Mz9oGBZDdwfj82OFRzWj8LbfW7WigtLZRECmS+veHxS6/xZL/kGvx3U4OtiejLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZIf4iwlsRTuR1TUuVn87GVYdvfE10OBNGyBDmXDRTs=;
 b=FoC14kE9K6G3iIn3BWAtIJJnPXm8730nmFqBA1A7Y+O5Bw6Bf+dVKWgwwqSGwVgQVZIH/FVEd3daRpjcyXFNFd/ETUeqMsT8RPD7XE9ud4juA3NQ2bxbzFDXNhO2HFc63x9pJallxtkyZsSIH57rigu/9WehgThkpFP06t9E1UIa1l92C6SCT5ZO3qqQMcKfj/NmGL4Wa9KmdLByIPNaVUAWiZZr+HoQSmzB2S6MFmCQTIqT+yMuEt/Q0yXMP85aeAokTzUMaYKV8oRnjeCBzkqAxz1kebAsvqoIfp9meAGtzUnJR8abVPCDxk9Mcm3v0ybQ8k8HbG0tSZ+6Ug29Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZIf4iwlsRTuR1TUuVn87GVYdvfE10OBNGyBDmXDRTs=;
 b=SiTCmjBgR5/oy7w1IXSzYOPZnrm4G5Ag5P3g6LZC7eqWYZCBZsLkXUWNyvju8tmkUJJoOqD/m48QiPa9gzzeoEvg+zN6fA/nOcHtWRoL92o6GdMOozKBuCG+ia5L1rpn28NcclEuajXj8G3PdYPLrq9WVDOgPsGDGKpUNiVBJpA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:42:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:42:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 12/12] mm: provide is_swap_entry() and use it
Date: Fri, 24 Oct 2025 08:41:28 +0100
Message-ID: <e436ad067f7dee8cb1295aa881a4857207b2835e.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0066.eurprd03.prod.outlook.com (2603:10a6:208::43)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: bb927ff2-0f16-4ab0-8643-08de12d0dcca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V/GnxFDlhpgCp0Kp7pjJuTHK3eqVX1HDt1CvfYKRS4d3NU5db8dJjv0w93++?=
 =?us-ascii?Q?1tSd/3cDSh2hx4XzDaK6CmLHf++hIO9GSukAN+GS8Qlm96Bhwod8jXGL9g/H?=
 =?us-ascii?Q?FheP2b6r5tCHJmXLZuafxEcnCBb8GuAeOUWJRX+jorq+gpUxyn2vB8ZKJp/u?=
 =?us-ascii?Q?tqdQQIFJP57fZP3XSOMonFjah89W9112jHKeU3yBEVuAJZfh3vL6ATPzI7nB?=
 =?us-ascii?Q?7arLnU3odqgs8FQd8zKdsUP8VbUBwWJFHZIgVFIU28oVzbtkFGiCYklJz6jf?=
 =?us-ascii?Q?QOuTvsYP+SvpGk4EPPwc122zAPYJL+/+mLL+jHlzE1iyN/65SKzfPvxe8Vrt?=
 =?us-ascii?Q?Vt2dXvqmEDfhsKBQPbYPd7oPRn+60hqV6wSp+mdQWtUlaPFa/7I++ilNoQko?=
 =?us-ascii?Q?iDw1tBASwLyo4BWLk4QWnr4SJkbup600FlW+mrgXXM6ETLPRTosVqw71BB/L?=
 =?us-ascii?Q?6NrEKPJDShKTMoIqO+UMszbjxjfGKxHlaWXApRemDrHfo2jRawxJjsoYrpD1?=
 =?us-ascii?Q?1Ygz3ju3wVvRtZ47q5h8ec8XHGh6jc+OKgkW3lo5ocvQzoDYZ3eUvUQda8To?=
 =?us-ascii?Q?c820PpLia18Idp2Qs+11amyl0CvVuZNhJNoyITe1Y7BwX0gX1QhJDAxpMEeR?=
 =?us-ascii?Q?NG3IurlyeUI0Eo5jhvk2TUIoKqT4BP2eWySJoaHuO5ECgrJGlPC0AJsNsLS7?=
 =?us-ascii?Q?Fy522ZzxD6FE+626mGGPEJa0caEok5FGyRfIouFbAwZcP7j8IDv9Tu4OC25g?=
 =?us-ascii?Q?qiFWr2jPbU1fhVQxa3SlkgwFN8tRRebSBpLch2bdrhGQX0G8w41FMdI9HMY0?=
 =?us-ascii?Q?nxSs2vJedHYxIOuqJh5PQshblacqSF2sEAZQfOuSdV0R4hssTC3+cHj0pNio?=
 =?us-ascii?Q?S7puqq2hCJfdPpElIavduA3LaMBWsBWooVxtq90ojqeOUmO6s48obHwXWhTs?=
 =?us-ascii?Q?TJ+bdrwiT1xzclVd2j5QeMbBT8OmbGclF/96jsDXbIl2PBCaJT/UsTvswbZJ?=
 =?us-ascii?Q?Sv2yrErG3f5okbvK1LtEj/iBfl8RvSBeLJeZaZ+IXGo5S8Z31zyBcioLPZbl?=
 =?us-ascii?Q?BnV1JjhUOK7litCvF8kOD6HyDnLmrSvivGH5FOnRBUE0rZd/M5DXlc9QiVVv?=
 =?us-ascii?Q?FE3VRaK9drUwtRY59WGQFp9BW5yhsKa/khI4XI8SY1Z4iSDIJrKcD9taVXKQ?=
 =?us-ascii?Q?6EfZJ/L9K8lu3gd0fA8mUE+pQrcA8OYoV/5ja9LR8YTT0QESKcdBybKuIF8P?=
 =?us-ascii?Q?R/qa/Fc+Tjm/m77KvsSuVhE6nQ5Ko4xqUPbTWgdj/U6jYfHR+hPFRUaVrbq+?=
 =?us-ascii?Q?XZ6PuN44A/EKTGPGbMY7Rjdgp2ksNHN9DADddC0Kb00utQtX3OVYIDJbAmhw?=
 =?us-ascii?Q?GzrpfhywddEMmdDoemiCx3fqdil+gE290QjNRBbZr3xy8Zj+jqKYVbCMcsbq?=
 =?us-ascii?Q?8tuWAaI0JlsPkyH4TvbnG+/0nX9kHZ+P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3KLTgfIPEG7NS8j6jRIrELk5Bpm9KI/1QBDCykpS88BEf0dIfrIPahnyZo/M?=
 =?us-ascii?Q?Fn9AKfVLO1l17ZUJ9RymmIvNvUw0/IVJm0JHK6dhjBsCjnTn1EzYQOa9hGHr?=
 =?us-ascii?Q?orYNEub/kVRK2n2VrYPlTf2bdTWSgDfWBqsk4HPj5MdlRjP2jEvw0xojgTLh?=
 =?us-ascii?Q?kLRexZPe1K3sdAMAdiJvLBPp2zGyzD6QmB+vzG7rDTikgB1Y7A+Uqa6/lV/k?=
 =?us-ascii?Q?oIhM7szgHdcFZMQQo8TGDMSmjYFdXj/VaBXV/EYYTairhLWwIH4GLnOB7HYz?=
 =?us-ascii?Q?KYlz+rnFD7Cu97DabKUeZ/yARWR4QL4OKFB8pYFzI+GBiJG4EW1tmyfRpNsm?=
 =?us-ascii?Q?qfz1w1IEwkr5iotUMGV52RskPLk3hjQtqPtGyaPV5qB/i2ieFuVAP3JOyWbC?=
 =?us-ascii?Q?zSkGXkDTeXPRkv1HrWlX0/SjmhkahgWUucbPzGPh9QA308iH9GfH/vA6T5Uc?=
 =?us-ascii?Q?lWRGUf3753qK8k0QZA8FPCvzypnPK2ebyrtw5gKprc0ZATWTA7lvBZ1hdgTl?=
 =?us-ascii?Q?8xTvEkE+YWvNx6KJ5yvqRa6Qu1E+bl3rooTkhWX057vKuc8DgKVzPmx3ZIHd?=
 =?us-ascii?Q?p2MNTXyyI3odS4WciScziMZlpbAJkoi/+1XLWzj5qpqqAqznEKBKn6wdlysC?=
 =?us-ascii?Q?6Sv/FQR+27eOBUS/SrHSe70fJek76qAWc1skr+w6sHJoHyHV2Ota4Noviu4c?=
 =?us-ascii?Q?3hegTvK2m3fzzsk+4aj4uB5bCes1aBHitioM2XYShD4O4CpMyRu6AyKAACes?=
 =?us-ascii?Q?fVv3Z5QjeyVap2j/YxoUSRwQG3cmzc2gtdfatgzMTPmyUsxoh0CExQqbASMR?=
 =?us-ascii?Q?VGyRVS7C65uuCB1GIpsVaVyzrao11oIl6Dxb5xrYM2t0JG830AMJPQkp4V0z?=
 =?us-ascii?Q?pkgyyE2ASA6UpKG5gLMTtNic3kSg7GtrIKdMwCChMbYvryVexEclf4CURins?=
 =?us-ascii?Q?M4XIVmxx436rb51xXsneV9G4z/BFUcowqVY358/R/YnYy5hDRJxvJsJNvE6E?=
 =?us-ascii?Q?NvTsVXXrbQR5EWlrk7wa6HAtB9OQt/WOjVZpg3abJUhVmrQ0nNweIEMgyTdc?=
 =?us-ascii?Q?bmhVaJtBWk3QwilvSf6EDOOtFHV4+WsHTR81gz8ZgI4AvK+OFTpYK0RQkbEo?=
 =?us-ascii?Q?mgYaCeUMMYoDQ6ixgh4mGqGeGTwncAakvlqiKg9E1GKBAmv2mLFUTLLHLKUT?=
 =?us-ascii?Q?hWcUb+Ib/fW1aLKhOE5Ypu5sTg4TJkzh5sYb2xAHW6+wFwSduYUxCsBlK7ZT?=
 =?us-ascii?Q?bgInA6uWIVgIu4wh/Y6haazc3J2y1Vpk6Rn754OaMQfuPzMjLDAOkBy8eWVs?=
 =?us-ascii?Q?GwPXdo2RtZbIILaqiF37PKpm9qVVFwwW6KOAeGVPUXGEnAAkDhC1Eln5OalI?=
 =?us-ascii?Q?NZDRLJrdDLZhgTTidf26ayDYGfvh+uP2K/0wFWAmjFXynp95eXdcEZYo40mp?=
 =?us-ascii?Q?KA3I0iwtSovdYxHpvlhC0EGKezxF3f8+zs5/DhiQwBaCMDLHAHx7TboH8kuE?=
 =?us-ascii?Q?WeRhGld5FoBBTPAHBnAqmG0ABgut+vVvTS22AlidiUo0mNCZFBfetkajqdYE?=
 =?us-ascii?Q?9+qvx2s/oPNCgXo/jiQ74DRyiJBRGWNfKFZXYk5wEGNIatSUC0iJ8wy4wMQk?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nZjsstAXD54pliqC/0035YtLN3kPEZGafbG+B/rl4/f+rVr64MEOVBElJNV5EjaT8g5t0YHm9GN0AILkRFbF1rVs6JPt5kMSRGpIbD6fC5Hloc3Yg/3OP5QDFbDvtJwPFdVIyfbHpNl+WnG4JDhOpBOplmBM9dWU/NpUKj7aXaI2FpVBtkiqBFh0b7ALXvxYX9/V58bNRjUEXYli9b237ZAloDJisWFNO96CsdlNDe+Gqr7NurTJA/p+2KI0Z9zYgTbDsx6Ezw71KZ0ysl5YBiuM0OGCEt7AT5p+fF+UcRZyo55TACMkj2631oyv408EezHnBbS11NF3BCNK4W3x1U2BlkWUJGzGIw3JKk/1JY4nZGa+09N8ImFfcPI9IVguWy3TMyUFVkeaepV0eTt10MaRw0i3iVCHoNWYH+EZR6UaizGwY1+4wivWtvm2832xdOAQ2F/VUoQSjcrbLMZ7l5HvaaSTJVb+F2p65EXSGuu3k8/LBlgPJzRmbm/uXk05+qQYcWizvr+ckOwS02pEGKT34DqjsTWPCAPPzEts+BUiQViUZ4SMEY/vzooC3nkZuHvwl1DQzGDrMN6D+Z9wMHdjuaHKzGRNsCvljKUyTSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb927ff2-0f16-4ab0-8643-08de12d0dcca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:42:20.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qicx68hm6KdEPmtjxhi/Zjkz2ngtYMayFahLb/g0S2/DNVap+5QcZ3G5vQBOvSooZGZ6nGc1nam6HKNObEoCB9xzAtBppBGcEtfO3IjA5nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-ORIG-GUID: naydow1zWbuWHjnXnw8aDB_nXUnhTcCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX10fivsBy2/bB
 6RMy2zho4r39umkoYsBv8bTn2HyLJCKfJuauRDWLELGM54yUZsBqDAImJ+VXfTd2CfryaTBR9mp
 xkqJ4zQe4I/ILgLZ8AfBvZh7vsl72wNVgeCPAu4XVKnV5RjL7HscZcH/uXL8+03TrMIJVFcLuOm
 e7AzdoGtdxVb027GN0+2XIAd5wuMj/SZbKM31FDDnXVMaQWTEQ4PT3275skgeeqeb01g/v44sBS
 B/0DCLYykTrCHOQhNeLgJJQoY7TWOwaDLc3N+5wIAPgkHMGtRUkXUleBw5x78R1wGNUt/9VLjbp
 X5P6nB+B2FQbp/o3jNCxZeWxQssUTMt/R/b3KUVrKkJyrXZUgHI5HL8HlYlYuFfvEJ6oIxQuw+3
 gx4Q3ZPczSvFkHO5ifbqrS+kFug11F4hWfoUNX07swcZmHMoZ6g=
X-Proofpoint-GUID: naydow1zWbuWHjnXnw8aDB_nXUnhTcCu
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fb2de1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=8AgD5g9lTelieRX7BsgA:9 cc=ntf awl=host:12091

Previously we have been in the insane situation where people check whether
we are in fact dealing with a swap entry by negating non_swap_entry() - so
determining if a swap entry is an entry for swap by checking that it's not
a not swap entry.

This is really rather sub-optimal, so rather than engaging in this dance,
and now we've eliminated confusing is_swap_pte() and is_swap_pmd() helpers,
and renamed non-swap entries to non-present entries, we are well placed to
introduce a new helper.

We therefore introduce is_swap_entry() for this purpose which simply
determines if a swp_entry_t value encodes an actual swap entry, and update
relevant callers to use this instead.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/mm/gmap_helpers.c |  2 +-
 arch/s390/mm/pgtable.c      |  2 +-
 fs/proc/task_mmu.c          |  2 +-
 include/linux/swapops.h     | 15 +++++++++++++++
 mm/madvise.c                |  2 +-
 mm/memory.c                 |  4 ++--
 6 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 2c41276a34c5..222a26d09cbb 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -28,7 +28,7 @@
  */
 static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 {
-	if (!is_non_present_entry(entry))
+	if (is_swap_entry(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
 	else if (is_migration_entry(entry))
 		dec_mm_counter(mm, mm_counter(pfn_swap_entry_folio(entry)));
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0c795f3c324f..a15befcf6a8c 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -685,7 +685,7 @@ void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep)
 
 static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 {
-	if (!is_non_present_entry(entry))
+	if (is_swap_entry(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
 	else if (is_migration_entry(entry)) {
 		struct folio *folio = pfn_swap_entry_folio(entry);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 28f30e01e504..d62fdae57dce 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1022,7 +1022,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	} else {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
-		if (!is_non_present_entry(swpent)) {
+		if (is_swap_entry(swpent)) {
 			int mapcount;
 
 			mss->swap += PAGE_SIZE;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index fb463d75fa90..c96c31671230 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -661,6 +661,21 @@ static inline bool is_non_present_entry(swp_entry_t entry)
 	return swp_type(entry) >= MAX_SWAPFILES;
 }
 
+/**
+ * is_swap_entry() - Determines if this is a swap entry.
+ * @entry: The entry to examine.
+ *
+ * Determines whether data encoded in non-present leaf page tables is a
+ * swap entry and NOT a migration entry, device private entry, market
+ * entry, etc.
+ *
+ * Returns true if it is a swap entry, otherwise false.
+ */
+static inline bool is_swap_entry(swp_entry_t entry)
+{
+	return !is_non_present_entry(entry);
+}
+
 static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
 {
 	return is_pmd_migration_entry(pmd) || is_pmd_device_private_entry(pmd);
diff --git a/mm/madvise.c b/mm/madvise.c
index a259dae2b899..4bf098986cb4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -690,7 +690,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			swp_entry_t entry;
 
 			entry = pte_to_swp_entry(ptent);
-			if (!is_non_present_entry(entry)) {
+			if (is_swap_entry(entry)) {
 				max_nr = (end - addr) / PAGE_SIZE;
 				nr = swap_pte_batch(pte, max_nr, ptent);
 				nr_swap -= nr;
diff --git a/mm/memory.c b/mm/memory.c
index 8968ba0b076f..4f4179eb70c0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -931,7 +931,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
-	if (likely(!is_non_present_entry(entry))) {
+	if (likely(is_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
 
@@ -1739,7 +1739,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		rss[mm_counter(folio)]--;
 		folio_remove_rmap_pte(folio, page, vma);
 		folio_put(folio);
-	} else if (!is_non_present_entry(entry)) {
+	} else if (is_swap_entry(entry)) {
 		/* Genuine swap entries, hence a private anon pages */
 		if (!should_zap_cows(details))
 			return 1;
-- 
2.51.0


