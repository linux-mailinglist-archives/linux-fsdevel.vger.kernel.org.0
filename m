Return-Path: <linux-fsdevel+bounces-50193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E77F7AC8B1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FD53B90C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABAB231C9F;
	Fri, 30 May 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MvErhWpu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GLgzQ+m+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C5231856;
	Fri, 30 May 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597704; cv=fail; b=pvjHv6BMzqnTsrfE9AJfuNhrKR1YNDrzc9yQaX0E0hDw/yeiYPHQSq8A5Zh9NEeDtnThMQMFj7OUm4jFyw8lclGYh4iqQ6DxKAJw5Ul7oKm5RK98+JxBkZZ1EYDdmrzv2NXBNFwLXyqG2Lulxxek5GDRTW3r0Q4dzLfpL3vUVH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597704; c=relaxed/simple;
	bh=RDWu/ko2MZBRawXwTAO+RsrKGdbqUcHxthtGMo4E41Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hhT1gg1ekhRMBid5Q+HveT0UZryxoGLZEXKcIP1f0qKkOkw5RwJzSvTALEDJ4uFH0KwBgFpx+vM4K4GP08Qs4pfh3hFCVdQMWaUf1MjjR9idl9GR1+kO6VQNXQsjNmvuY9CIjBZBdyTD0AlFOBeO6iNovdNJFyKq7e0sxbRpOrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MvErhWpu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GLgzQ+m+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U6uX5o005875;
	Fri, 30 May 2025 09:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Pnlj08ZOn0iM7uNe8bP45c5Q7whDWBOZbum8CPz0E3o=; b=
	MvErhWpu5ADM0JMfvLhVM+c2RQm92fQrSUMKD9wpikjEPx9nimDUxmtUrjHcMHg+
	F8r/X4B+WRqlAtCigh8ir4F57wlMxCHMTM6tUE1WnxSFG41XsAQ8uP6Jo3GhQYlA
	qdAanpH24be7qHzf3ILPmTf22Pb34BJNyk5k/f+L12MVtU4Tc/JZK968BqeiEyiW
	eIQfN9CFACL/RFa6JvlqmLFuAjyrnxc/a8bwicVh7naQBlazPnJscrxKVw/K5AGR
	vnpp7nLQ6DflqVE7mdtrLWJCgkFEzQpCp0/3xh7TaxnSxb50qaTlLkmjnKlofmqG
	mWYpK3kTFDR1aGG7A86Ebg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcnvud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:33:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54U8lu4w008196;
	Fri, 30 May 2025 09:33:39 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jdt5pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1eHxSFw68sYH5oMm/CCT+Z0HCrV8pZk6T0ZKRbL3cCixpzg0NLb4T/0JMOmvCzj0Qguw+/pNLOLkIAyV61aVgZTWYx8MSQ0boCvnHPuNzCugJNDBYXJkR2xR0XtqACKPB7yvgXoczJn0ZzCGKpS+tdyoHOkFT6r0Bo9l0jb7RvlXvgxY8dzdVhQCLn0IuJTyvPbKFfN48VQ6/lPSyy0+QHuBxppdIHULOAJ7T0mqciSWfwYUtWWhercYLAfaXkNxBr2262ZqpB45Nr/QPoH5485p/guY0b6lblnyuIJD8jcRjVgzliCcS/uSRwJOnR7nhM1J0Xcvq2c7ew4dI/W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pnlj08ZOn0iM7uNe8bP45c5Q7whDWBOZbum8CPz0E3o=;
 b=UGtVOYhzos5AXV5PC0IMhTIvdfO4GOmwVG+H6LgXtrLOENtEQsZcDAYlkmaYTWrNh47YlV3pvLqxAy/IeJFXBnlBhv0U7FZlZardpb+/Tb8ysgZhvsSHeeeFHgZk/ThalWHG6SXNzRzC0HEp/8LHSkcWGksdyVx792py+L4r2hGWrV9xOEcFsx9MDhJ/3IFtl8M9bbiyuBPCuumtVcPCaMXBPHFuX9fSxny67FRnpGM8ENfoeL+TcLJTJELN1vLd+Vn4weQR9fIbQFUJUNHLE0rW/YsJqI+WBnZDsSap1kPCXenXUznTQi9JkuuOM2CNWPdM2iEoqaQffEqlBqwhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pnlj08ZOn0iM7uNe8bP45c5Q7whDWBOZbum8CPz0E3o=;
 b=GLgzQ+m+/WZqiPRc4cCwUEuMQrYKqFKqkvwMvcFRPLFtZq2WiCLrXAVAxD2PfPkRbXrYPqlpINDRjAO7gR2rvbyhyzke9bskCQfBHgUqt61L/o9vHSAjNhAwzHrtuuEZ5dnP/FwKO7Qt3bivYX+3OSiUEKqD8+KRYFaljCf9+90=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8494.namprd10.prod.outlook.com (2603:10b6:208:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 09:33:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 09:33:35 +0000
Date: Fri, 30 May 2025 10:33:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bo Li <libo.gcs85@bytedance.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
        kees@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org, dietmar.eggemann@arm.com, hpa@zytor.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        jannh@google.com, pfalcato@suse.de, riel@surriel.com,
        harry.yoo@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        yinhongbo@bytedance.com, dengliang.1214@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        songmuchun@bytedance.com, yuanzhu@bytedance.com,
        chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
Subject: Re: [RFC v2 00/35] optimize cost of inter-process communication
Message-ID: <8c98c8e0-95e1-4292-8116-79d803962d5f@lucifer.local>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
X-ClientProxiedBy: LO2P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 9000b9bc-7768-43f0-cadb-08dd9f5d0ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFNDSDRHN0ZMdGMzb09wdWRxaDNIeExrMVRKbTFhNGxIUzdlZ3A2VWtrOUlo?=
 =?utf-8?B?WU1OVkZNSWhGQUhaenNDSzFiYzJ5SVc0Y0o2dXg5TG9oSHFhZjc1bUJPY1Ns?=
 =?utf-8?B?RUNrZzlNeWJnNzhqT3ZHT2l4cDcxNXBCMXJmUmp5bUJ6eGhvNHpTOUM5NDZn?=
 =?utf-8?B?VTd5aWFxNlpRTzh1Tm81OVRhTDNGM3ZqY0F4cVRFM1ZFY3Z2WWYrQlhQY0N4?=
 =?utf-8?B?K29tcHhaM1EzQk9jVzhXN1F4MkNpUk5GUERydE04Y3ltMjU5d0dHWUlUSkZN?=
 =?utf-8?B?U2J2d3VCejJ6WHBTRkxDYjNsZnBvWXBOcksvbHBPcDZXcW9HbW9oalNKY0pR?=
 =?utf-8?B?bE9WQ1lGM0ljR3FGR3RTRHgrdnYvU0l6dC9pd0doQyt6ZVRBdFhHVWhXZ0E4?=
 =?utf-8?B?MHkwSTA4QzNDekdJNzRoTGJEYTVTUU10elBCWjJtVGdhVUVmWU9uSTlzeU10?=
 =?utf-8?B?NHVKV2xlWHZxdVROSnVmRWptc0VEbUoxS0c5QWlxcENpdUptSTlmZmZBeFQ3?=
 =?utf-8?B?dWxGVUNtM0l3ZXh0OTFXK2hSalRIdUxHNEQzM291ZUhxUWtUMDVtcHBKaVBz?=
 =?utf-8?B?UEJ4Q2hlSFRCamNpY0xJV0U2M2dsQnM1U0ZubDVLekMvQmZuVzhtQ0FGOUp3?=
 =?utf-8?B?dEUrL1Znc3NHMHVwdmtpaDdYSGo3ZmNZY0xTWkNpYUsvZ0hEMUxLb0VQTnFI?=
 =?utf-8?B?NGZTREp1R3IxNG1yYlg3b2VEVjRaK2IyZVhIVVdtbXcwbW51akg2SFJUWGRJ?=
 =?utf-8?B?cFhWTmFQbEhmVWpvZjA3L3JIcWl0KzdxYWxkaVVWYlV1Z0JPYWhnTDJYUlhs?=
 =?utf-8?B?blRhMTNKY1RYNmt5aWtjWTlEQUlhT3p5bktnQ1JSRThzS3VDU01ubWtCZGl3?=
 =?utf-8?B?ZVJVQUlxLy9WR2R3aUp2UXQ3MTBGeTUxYWhWRTVkREJ3VlJJSm0ydk1PMkRS?=
 =?utf-8?B?KzZCRTFYYW5ocFBickd4ZTZ2N3E5YVNHcVYwRHYvZ0QwbXk0eGNkL0o4bXFX?=
 =?utf-8?B?RFBEbzZraXUrMjlYV1hOb3EvQ1lCNHJjVzdUODFBSWVLVnZXUU1yWGhBL3c4?=
 =?utf-8?B?OEdET1cwZ3hmQmM3NG9vbEVVMFoxMkNTVTVSbVpCTDZoVXBNd0g5ME13TWhO?=
 =?utf-8?B?eHhZSTBGVVlsTzdBQThMdXo3cXdBVTQ3dzVQTVpBNkJRMGRHTWx2VEZJTmds?=
 =?utf-8?B?ZXo2Z1FZMWNQU0wxaFkzR1lvR0lHUEdiejQ5SEFCTGtkek5vOUFOeEpnaTRx?=
 =?utf-8?B?aU0wM0xrb2tucGtyOVIzVE1NVVE4QVNDY0U3S2VEUE1zL3V1N1lMQXI0UnJs?=
 =?utf-8?B?RGFjY0Uzak9BZDBmOTFZZ2FsZjU5M2J4MEsyUkd4cHE3TEhNYnJoaUVrQmVN?=
 =?utf-8?B?a09BYmFhcVF0MS8yMzNpQWFKVDRhZFBIQnVNRmp4Qkp3U0QrNUVDdlBMNkgr?=
 =?utf-8?B?ZHgrWFNzdldzN3djZGtPVlNXOEJJT3EyeDJoUTlrcy9UUFhWcDh2c3pVR2gr?=
 =?utf-8?B?cVVYNnNseU96b0JMNy9nc0JpVjNScXAxaDZIb2R1eFVwbW1kZlQvYlpHMmZ1?=
 =?utf-8?B?bkt6blpuRkxXTXBxb0tRb0crVUYxbytPT1BsTWYyL0JkbGMwSVNtTXlISnVT?=
 =?utf-8?B?aCsreFR4N2cvYkpMY0FscW9FcHJHTjVmMXhjVVQxS2lnNER3NzZmcng3Vjh3?=
 =?utf-8?B?ZXNiV0J2c1RLZDVBT0lqdy8xd2pqeFhvaE9UNHBFSmY0dGRhQXdETElrN0U2?=
 =?utf-8?B?M3ZpTnBYOHZnZDUzTzh3b1VHeWQvWEZsRU4wRk45ZE5XYkUyRGZQZGNQamRF?=
 =?utf-8?B?MG9GakFBWVhSQXM2SUFjUzViVEw1QkQvanVTcDgvMkhuYTU2T3lSc05OTmE5?=
 =?utf-8?B?TFRVeUFqWCtpc3BRdHNGdnpwZ0JNdXNxeXRnOFdRSHlpaWQxRGU5MTNpbU5W?=
 =?utf-8?Q?nl3ISw/dk84=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG54bFFoTklaQjV5ZllQT3piRTBGU0VjalVqNmxIRlh0aVFoREl1dkt5Wit6?=
 =?utf-8?B?bzJ0S0xVS3ppbE9sUGhWcXpWUmVjbnBFdzlZUzQ2YThnL3N0aHQrQS9Rc0RD?=
 =?utf-8?B?RG9EQ2M0cFJaZHJ2K1FqbEp5SnNpbW9LRVlXb0dDV1kxV2RnYy9XUG1EWVIv?=
 =?utf-8?B?SFdMdUxKWElBZ3cxaXg0T3NzcUJXTTFTbUs0L2VtcFRhOWFQSyt6SnJEc2tE?=
 =?utf-8?B?QWxweE1xSXFLbjBIQTlkTkErWlQ0ZXVKK0VHYXBLQTlOZWVSTkJ0ZTd5SEdo?=
 =?utf-8?B?OUJad2lFREY4T0FxOG80ZGZFNUxFZm1oeFA3TFdweENFREtsYm1lWWZNK3Zi?=
 =?utf-8?B?bzdVV0hwU3NsWjNRTk53SDA1ZFU0VlpMNnc4RXo3dmFzdFFVQkh4ZUU5VEdY?=
 =?utf-8?B?SEJmejBreCtRWDlrOHhraHVvUTBMbU5YSHBqeU1kZVowR1ZnckgrSklackdn?=
 =?utf-8?B?Q1RWODB0TGJPOUY2blo5SEk3Qm91eDY2aGdSMjRlcXdXS1lXUWNHeCtVK243?=
 =?utf-8?B?dzJZOTM2ODVZbEpRMktQeVAwblgrQklXWGppekhuY1hrcGk3WFhsQnVOWXVN?=
 =?utf-8?B?djl3YnZETHA3RGZwTzA3VVlCWlRoN29ueDBjd0d4YVRMbW04bVA3dEtkdndJ?=
 =?utf-8?B?R2FYUUpRMHd1dnlyU3MzSVFiaXFPUmhIdlRwaWpiWHlvUzNNSnc3K0ZhK3Nl?=
 =?utf-8?B?bEN3d3RYVlJVTDlPK1FTdEN1WTNQaGVJRHgyNzlzOGtwa3Y4ZVBIaFVHNTY1?=
 =?utf-8?B?YmFJRnErVjNHaTJHYXZCOVpOWFpzRnZCV3doamF6Q094MmNEODJYT0F6ZHBW?=
 =?utf-8?B?YWVXVWhYSGN6ZU9LV0NxZkFlZWlYbWRaVGZqZ0pHaFRhYTkzZkVERzd0V1gy?=
 =?utf-8?B?eW9taExYdzdJNjZmZ0Erbzcva0N0ajEyd2ZTSGR6WUJKK1dwcmY5cStzcTlB?=
 =?utf-8?B?RzJVQlNhMXZpSVREdWhSL1IrUk81UTg4YWI3U1g0M3NwZ2g1ZkNLTUhFNlFC?=
 =?utf-8?B?ZE8wZU5NYURPd04vSUhybkxDTFFaamp6QVV5WVFLUGcweVBGRVBIQWJvWVpG?=
 =?utf-8?B?b0UwZUNhV2lZNnNaendLamlHUTZrcmFEU082R1pKSXE4bUVjdWV5RnEwYnFO?=
 =?utf-8?B?NVVLTENNNTVJSDk2VGZvUXE2aXFHWXAvSFA1NTVsWDRtbHFOTjdqOThVTmFj?=
 =?utf-8?B?VWxJZUtXVVdIcEZBV0lZS0RCN0s1emtWZXFFVWVDaC9FMitzNlZwQVFISEN3?=
 =?utf-8?B?ZW54aU1TM2hHWFl3SmpUdzgxNCtCSkNhQURhS1pUZmUvTHQybUlubC9xbUh4?=
 =?utf-8?B?T0dhZTRQVTNxNFkwMWc5R2doR0h5enppWC9MRFA4M0o2THVvYS9sZkl0UDhh?=
 =?utf-8?B?dGs5SHVjbS8wS0RDYzAvMHlmYkFyd3pSOE5KaldCTEloYkJheCsxRjlpWGdq?=
 =?utf-8?B?dFpVZ002c1VDQWsrRkoyblR5cWZic095QVZOYmNlWHBhcVB3QlgzbXMzRmsr?=
 =?utf-8?B?U0xFQkxMdllUcGVTaTYxbFh5UHErdDFtSUdqSE5tY0tPakZBUW9jdStPVmsw?=
 =?utf-8?B?aS82QTUzSWxSREkyUDFmd3JUSFBNcGwxYzZWaTY0UjVBaGk5eVBFdVBLRWoy?=
 =?utf-8?B?dys2TExUVS9FZjdtamE4OW1oTE12SDExK2VVRW5WNmNqM1YyVTNWcXJkMlRH?=
 =?utf-8?B?VDNhdkdTUWRBZEh5Qys2S0VFVE93YlBNUUtBUTJkRmdmZzNmUlFKMmRISnpQ?=
 =?utf-8?B?RjJYeEkzb0pmL3MwK0k5S3lENnhQcjl5TCsrR2U3RDcrTGVJTU5rODFlMU54?=
 =?utf-8?B?VlJoSURtbDkrbUxjYmF2QnhQZ2RLZGZXRjZ3V2dOVnJocmxjVWwzWDUzQkVU?=
 =?utf-8?B?Z1cwREY5eXlCWWN5YW5aLzBOdWc2ZmZRWjBtVnJSVHVWeXlmNS9GUXRKLzNR?=
 =?utf-8?B?ZkVwMXJhcDdzT3huUUZ0L29WbVcxS0ovV2pidnFQeVlyc3lPMXJJWFlVeTE4?=
 =?utf-8?B?V2hXc0t6SjQ0bTdqU0NzVVNPbGxXTWxLTUcvWXYvbkdMRTNSTk8wazJ0T1FF?=
 =?utf-8?B?TDByQXkzYVlnUGhwUFNwRzZFS0diVkZxUVlyUXBhYTBZZzdyMEJGaXNaTHJ5?=
 =?utf-8?B?Uis5SjQxS2Z5Q25MdnpXTG5WQzl4MDI5YStFZUVybDhlU1pLN0NIUUZUeDZB?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lGEHurlHXFB5DzfCZnMKM1CCLaGCI9/NKfmTbvEWD51UCDC7viRwo17edsJbqE6FmwBfFdkluFS0m+EDIOtn07U+/1bFbjS2EY8TSUxs5CD7lER+L1CX+9fLtl893nm5HOb9+Xk8GJ1vg27UKIG5MYPCoKY3Lo3EN3ZeEkSusLEv1a0ADHALmpQlIxgNIdQlGMGsTGhBryAP3jfecOmz223mFI5tigcRLxRWiigsSmzK3g1DiQ/LOsj14enIs19B20jTtZw+kcCIkX34vjnFiuHT6GsU7Je23xQ6qWjOSmYBp0HIVc+OitWL/LtdzqEjga9WN1g8k6LiEk+SSPv+fQKCk7cD2NXxDooFm+RL9P01Jfrw4F7umIrDumulbsy2ZnhSHxBw1kVbNHiE9cO3Qbr9j0r6U8j0dLxcT5vbbCnI1N3adMBUaJNWd/aAX2mkvej9O2x6Lk0XaAhDIjEc0FPd6IWdMjMMybKDpbeqgpR1xeev7sZtcHqeNhi6lsQ2qNpEL8OijNQ+oDB6TNN7fD9ep0MT1pHEURUKChIh/0Cg1W00dpEFNNDZJgSgrGEIyWnFLXFuzQJDjZzxoTBM0e/4x0CYd02mh2VuoO26fmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9000b9bc-7768-43f0-cadb-08dd9f5d0ca9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:33:35.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /skI3LRfsWC29SNRw4j9pVzaOk2MN80XYg02x+NhNvYbRdB7plAg3T1rkvKWnZwIG4TF/70TQf7mUG91hdjygV/F1tiQS/1JXfZK7QT3j1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505300081
X-Proofpoint-GUID: _xMH1j0yD73JZBr2tkXXeAX7gc_23PBW
X-Proofpoint-ORIG-GUID: _xMH1j0yD73JZBr2tkXXeAX7gc_23PBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA4MSBTYWx0ZWRfX163T0WpfpINj CzmSwQh6lO7xeCkXFYq1SkD8/cn25mbtmBYDqyFUaeY8hGCtBRpk8L5rut+BFpQ9LAba0PkZ1WW I/0qcAiCbk8kuCijhxTme7DhsFmNmAljqdS6Rzs94cauvLKmAkO5guus1RqzJeNCaKsf4W/2DYt
 STgvuzzYPHQ5sCCa/Jd29IpzfUQ2qYABWRsGXy7G/iRtM32caeba4jW/4J9NgRL52NcuQGWQft7 XEXY8OrN7ptMg75A0Ak0EG+8kslAs15sxSbGBbTnnn7eXbaioKESgPuIPzhbIJkMnw4k4Z8iSve xPhYBJw/maFjGmLYlMgWy9uo7hVyJV/f0gcbZhFuYDreNZgXh2iikpahn7yJPC+Mms7wHp0qMCw
 ag/CBBRy6oumL7UlWGaQrk2tp7j9kTxb9l7zffz1EsZF7Qz4QLpyNaNtigkHm+U9gSIb43+c
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=68397b74 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ZQb2-ej06_51c_fjXvYA:9 a=8xWE5lwX36eHxTgC:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

Bo,

You have outstanding feedback on your v1 from me and Dave Hansen. I'm not
quite sure why you're sending a v2 without responding to that.

This isn't how the upstream kernel works...

Thanks, Lorenzo

On Fri, May 30, 2025 at 05:27:28PM +0800, Bo Li wrote:
> Changelog:
>
> v2:
> - Port the RPAL functions to the latest v6.15 kernel.
> - Add a supplementary introduction to the application scenarios and
>   security considerations of RPAL.
>
> link to v1:
> https://lore.kernel.org/lkml/CAP2HCOmAkRVTci0ObtyW=3v6GFOrt9zCn2NwLUbZ+Di49xkBiw@mail.gmail.com/
>
> --------------------------------------------------------------------------
>
> # Introduction
>
> We mainly apply RPAL to the service mesh architecture widely adopted in
> modern cloud-native data centers. Before the rise of the service mesh
> architecture, network functions were usually integrated into monolithic
> applications as libraries, and the main business programs invoked them
> through function calls. However, to facilitate the independent development
> and operation and maintenance of the main business programs and network
> functions, the service mesh removed the network functions from the main
> business programs and made them independent processes (called sidecars).
> Inter-process communication (IPC) is used for interaction between the main
> business program and the sidecar, and the introduced inter-process
> communication has led to a sharp increase in resource consumption in
> cloud-native data centers, and may even occupy more than 10% of the CPU of
> the entire microservice cluster.
>
> To achieve the efficient function call mechanism of the monolithic
> architecture under the service mesh architecture, we introduced the RPAL
> (Running Process As Library) architecture, which implements the sharing of
> the virtual address space of processes and the switching threads in user
> mode. Through the analysis of the service mesh architecture, we found that
> the process memory isolation between the main business program and the
> sidecar is not particularly important because they are split from one
> application and were an integral part of the original monolithic
> application. It is more important for the two processes to be independent
> of each other because they need to be independently developed and
> maintained to ensure the architectural advantages of the service mesh.
> Therefore, RPAL breaks the isolation between processes while preserving the
> independence between them.  We think that RPAL can also be applied to other
> scenarios featuring sidecar-like architectures, such as distributed file
> storage systems in LLM infra.
>
> In RPAL architecture, multiple processes share a virtual address space, so
> this architecture can be regarded as an advanced version of the Linux
> shared memory mechanism:
>
> 1. Traditional shared memory requires two processes to negotiate to ensure
> the mapping of the same piece of memory. In RPAL architecture, two RPAL
> processes still need to reach a consensus before they can successfully
> invoke the relevant system calls of RPAL to share the virtual address
> space.
> 2. Traditional shared memory only shares part of the data. However, in RPAL
> architecture, processes that have established an RPAL communication
> relationship share a virtual address space, and all user memory (such as
> data segments and code segments) of each RPAL process is shared among these
> processes. However, a process cannot access the memory of other processes
> at any time. We use the MPK mechanism to ensure that the memory of other
> processes can only be accessed when special RPAL functions are called.
> Otherwise, a page fault will be triggered.
> 3. In RPAL architecture, to ensure the consistency of the execution context
> of the shared code (such as the stack and thread local storage), we further
> implement the thread context switching in user mode based on the ability to
> share the virtual address space of different processes, enabling the
> threads of different processes to directly perform fast switching in user
> mode without falling into kernel mode for slow switching.
>
> # Background
>
> In traditional inter-process communication (IPC) scenarios, Unix domain
> sockets are commonly used in conjunction with the epoll() family for event
> multiplexing. IPC operations involve system calls on both the data and
> control planes, thereby imposing a non-trivial overhead on the interacting
> processes. Even when shared memory is employed to optimize the data plane,
> two data copies still remain. Specifically, data is initially copied from
> a process's private memory space into the shared memory area, and then it
> is copied from the shared memory into the private memory of another
> process.
>
> This poses a question: Is it possible to reduce the overhead of IPC with
> only minimal modifications at the application level? To address this, we
> observed that the functionality of IPC, which encompasses data transfer
> and invocation of the target thread, is similar to a function call, where
> arguments are passed and the callee function is invoked to process them.
> Inspired by this analogy, we introduce RPAL (Run Process As Library), a
> framework designed to enable one process to invoke another as if making
> a local function call, all without going through the kernel.
>
> # Design
>
> First, let’s formalize RPAL’s core objectives:
>
> 1. Data-plane efficiency: Reduce the number of data copies from two (in the
>    shared memory solution) to one.
> 2. Control-plane optimization: Eliminate the overhead of system calls and
>    kernel's thread switches.
> 3. Application compatibility: Minimize the modifications to existing
>    applications that utilize Unix domain sockets and the epoll() family.
>
> To attain the first objective, processes that use RPAL share the same
> virtual address space. So one process can access another's data directly
> via a data pointer. This means data can be transferred from one process to
> another with just one copy operation.
>
> To meet the second goal, RPAL relies on the shared address space to do
> lightweight context switching in user space, which we call an "RPAL call".
> This allows one process to execute another process's code just like a
> local function call.
>
> To achieve the third target, RPAL stays compatible with the epoll family
> of functions, like epoll_create(), epoll_wait(), and epoll_ctl(). If an
> application uses epoll for IPC, developers can switch to RPAL with just a
> few small changes. For instance, you can just replace epoll_wait() with
> rpal_epoll_wait(). The basic epoll procedure, where a process waits for
> another to write to a monitored descriptor using an epoll file descriptor,
> still works fine with RPAL.
>
> ## Address space sharing
>
> For address space sharing, RPAL partitions the entire userspace virtual
> address space and allocates non-overlapping memory ranges to each process.
> On x86_64 architectures, RPAL uses a memory range size covered by a
> single PUD (Page Upper Directory) entry, which is 512GB. This restricts
> each process’s virtual address space to 512GB on x86_64, sufficient for
> most applications in our scenario. The rationale is straightforward:
> address space sharing can be simply achieved by copying the PUD from one
> process’s page table to another’s. So one process can directly use the
> data pointer to access another's memory.
>
>
>  |------------| <- 0
>  |------------| <- 512 GB
>  |  Process A |
>  |------------| <- 2*512 GB
>  |------------| <- n*512 GB
>  |  Process B |
>  |------------| <- (n+1)*512 GB
>  |------------| <- STACK_TOP
>  |  Kernel    |
>  |------------|
>
> ## RPAL call
>
> We refer to the lightweight userspace context switching mechanism as RPAL
> call. It enables the caller (or sender) thread of one process to directly
> switch to the callee (or receiver) thread of another process.
>
> When Process A’s caller thread initiates an RPAL call to Process B’s
> callee thread, the CPU saves the caller’s context and loads the callee’s
> context. This enables direct userspace control flow transfer from the
> caller to the callee. After the callee finishes data processing, the CPU
> saves Process B’s callee context and switches back to Process A’s caller
> context, completing a full IPC cycle.
>
>
>  |------------|                |---------------------|
>  |  Process A |                |  Process B          |
>  | |-------|  |                | |-------|           |
>  | | caller| --- RPAL call --> | | callee|    handle |
>  | | thread| <------------------ | thread| -> event  |
>  | |-------|  |                | |-------|           |
>  |------------|                |---------------------|
>
> # Security and compatibility with kernel subsystems
>
> ## Memory protection between processes
>
> Since processes using RPAL share the address space, unintended
> cross-process memory access may occur and corrupt the data of another
> process. To mitigate this, we leverage Memory Protection Keys (MPK) on x86
> architectures.
>
> MPK assigns 4 bits in each page table entry to a "protection key", which
> is paired with a userspace register (PKRU). The PKRU register defines
> access permissions for memory regions protected by specific keys (for
> detailed implementation, refer to the kernel documentation "Memory
> Protection Keys"). With MPK, even though the address space is shared
> among processes, cross-process access is restricted: a process can only
> access the memory protected by a key if its PKRU register is configured
> with the corresponding permission. This ensures that processes cannot
> access each other’s memory unless an explicit PKRU configuration is set.
>
> ## Page fault handling and TLB flushing
>
> Due to the shared address space architecture, both page fault handling and
> TLB flushing require careful consideration. For instance, when Process A
> accesses Process B’s memory, a page fault may occur in Process A's
> context, but the faulting address belongs to Process B. In this case, we
> must pass Process B's mm_struct to the page fault handler.
>
> TLB flushing is more complex. When a thread flushes the TLB, since the
> address space is shared, not only other threads in the current process but
> also other processes that share the address space may access the
> corresponding memory (related to the TLB flush). Therefore, the cpuset used
> for TLB flushing should be the union of the mm_cpumasks of all processes
> that share the address space.
>
> ## Lazy switch of kernel context
>
> In RPAL, a mismatch may arise between the user context and the kernel
> context. The RPAL call is designed solely to switch the user context,
> leaving the kernel context unchanged. For instance, when a RPAL call takes
> place, transitioning from caller thread to callee thread, and subsequently
> a system call is initiated within callee thread, the kernel will
> incorrectly utilize the caller's kernel context (such as the kernel stack)
> to process the system call.
>
> To resolve context mismatch issues, a kernel context switch is triggered at
> the kernel entry point when the callee initiates a syscall or an
> exception/interrupt occurs. This mechanism ensures context consistency
> before processing system calls, interrupts, or exceptions. We refer to this
> kernel context switch as a "lazy switch" because it defers the switching
> operation from the traditional thread switch point to the next kernel entry
> point.
>
> Lazy switch should be minimized as much as possible, as it significantly
> degrades performance. We currently utilize RPAL in an RPC framework, in
> which the RPC sender thread relies on the RPAL call to invoke the RPC
> receiver thread entirely in user space. In most cases, the receiver
> thread is free of system calls and the code execution time is relatively
> short. This characteristic effectively reduces the probability of a lazy
> switch occurring.
>
> ## Time slice correction
>
> After an RPAL call, the callee's user mode code executes. However, the
> kernel incorrectly attributes this CPU time to the caller due to the
> unchanged kernel context.
>
> To resolve this, we use the Time Stamp Counter (TSC) register to measure
> CPU time consumed by the callee thread in user space. The kernel then uses
> this user-reported timing data to adjust the CPU accounting for both the
> caller and callee thread, similar to how CPU steal time is implemented.
>
> ## Process recovery
>
> Since processes can access each other’s memory, there is a risk that the
> target process’s memory may become invalid at the access time (e.g., if
> the target process has exited unexpectedly). The kernel must handle such
> cases; otherwise, the accessing process could be terminated due to
> failures originating from another process.
>
> To address this issue, each thread of the process should pre-establish a
> recovery point when accessing the memory of other processes. When such an
> invalid access occurs, the thread traps into the kernel. Inside the page
> fault handler, the kernel restores the user context of the thread to the
> recovery point. This mechanism ensures that processes maintain mutual
> independence, preventing cascading failures caused by cross-process memory
> issues.
>
> # Performance
>
> To quantify the performance improvements driven by RPAL, we measured
> latency both before and after its deployment. Experiments were conducted on
> a server equipped with two Intel(R) Xeon(R) Platinum 8336C CPUs (2.30 GHz)
> and 1 TB of memory. Latency was defined as the duration from when the
> client thread initiates a message to when the server thread is invoked and
> receives it.
>
> During testing, the client transmitted 1 million 32-byte messages, and we
> computed the per-message average latency. The results are as follows:
>
> *****************
> Without RPAL: Message length: 32 bytes, Total TSC cycles: 19616222534,
>  Message count: 1000000, Average latency: 19616 cycles
> With RPAL: Message length: 32 bytes, Total TSC cycles: 1703459326,
>  Message count: 1000000, Average latency: 1703 cycles
> *****************
>
> These results confirm that RPAL delivers substantial latency improvements
> over the current epoll implementation—achieving a 17,913-cycle reduction
> (an ~91.3% improvement) for 32-byte messages.
>
> We have applied RPAL to an RPC framework that is widely used in our data
> center. With RPAL, we have successfully achieved up to 15.5% reduction in
> the CPU utilization of processes in real-world microservice scenario. The
> gains primarily stem from minimizing control plane overhead through the
> utilization of userspace context switches. Additionally, by leveraging
> address space sharing, the number of memory copies is significantly
> reduced.
>
> # Future Work
>
> Currently, RPAL requires the MPK (Memory Protection Key) hardware feature,
> which is supported by a range of Intel CPUs. For AMD architectures, MPK is
> supported only on the latest processor, specifically, 3th Generation AMD
> EPYC™ Processors and subsequent generations. Patch sets that extend RPAL
> support to systems lacking MPK hardware will be provided later.
>
> Accompanying test programs are also provided in the samples/rpal/
> directory. And the user-mode RPAL library, which realizes user-space RPAL
> call, is in the samples/rpal/librpal directory.
>
> We hope to get some community discussions and feedback on RPAL's
> optimization approaches and architecture.
>
> Look forward to your comments.
>
> Bo Li (35):
>   Kbuild: rpal support
>   RPAL: add struct rpal_service
>   RPAL: add service registration interface
>   RPAL: add member to task_struct and mm_struct
>   RPAL: enable virtual address space partitions
>   RPAL: add user interface
>   RPAL: enable shared page mmap
>   RPAL: enable sender/receiver registration
>   RPAL: enable address space sharing
>   RPAL: allow service enable/disable
>   RPAL: add service request/release
>   RPAL: enable service disable notification
>   RPAL: add tlb flushing support
>   RPAL: enable page fault handling
>   RPAL: add sender/receiver state
>   RPAL: add cpu lock interface
>   RPAL: add a mapping between fsbase and tasks
>   sched: pick a specified task
>   RPAL: add lazy switch main logic
>   RPAL: add rpal_ret_from_lazy_switch
>   RPAL: add kernel entry handling for lazy switch
>   RPAL: rebuild receiver state
>   RPAL: resume cpumask when fork
>   RPAL: critical section optimization
>   RPAL: add MPK initialization and interface
>   RPAL: enable MPK support
>   RPAL: add epoll support
>   RPAL: add rpal_uds_fdmap() support
>   RPAL: fix race condition in pkru update
>   RPAL: fix pkru setup when fork
>   RPAL: add receiver waker
>   RPAL: fix unknown nmi on AMD CPU
>   RPAL: enable time slice correction
>   RPAL: enable fast epoll wait
>   samples/rpal: add RPAL samples
>
>  arch/x86/Kbuild                               |    2 +
>  arch/x86/Kconfig                              |    2 +
>  arch/x86/entry/entry_64.S                     |  160 ++
>  arch/x86/events/amd/core.c                    |   14 +
>  arch/x86/include/asm/pgtable.h                |   25 +
>  arch/x86/include/asm/pgtable_types.h          |   11 +
>  arch/x86/include/asm/tlbflush.h               |   10 +
>  arch/x86/kernel/asm-offsets.c                 |    3 +
>  arch/x86/kernel/cpu/common.c                  |    8 +-
>  arch/x86/kernel/fpu/core.c                    |    8 +-
>  arch/x86/kernel/nmi.c                         |   20 +
>  arch/x86/kernel/process.c                     |   25 +-
>  arch/x86/kernel/process_64.c                  |  118 +
>  arch/x86/mm/fault.c                           |  271 ++
>  arch/x86/mm/mmap.c                            |   10 +
>  arch/x86/mm/tlb.c                             |  172 ++
>  arch/x86/rpal/Kconfig                         |   21 +
>  arch/x86/rpal/Makefile                        |    6 +
>  arch/x86/rpal/core.c                          |  477 ++++
>  arch/x86/rpal/internal.h                      |   69 +
>  arch/x86/rpal/mm.c                            |  426 +++
>  arch/x86/rpal/pku.c                           |  196 ++
>  arch/x86/rpal/proc.c                          |  279 ++
>  arch/x86/rpal/service.c                       |  776 ++++++
>  arch/x86/rpal/thread.c                        |  313 +++
>  fs/binfmt_elf.c                               |   98 +-
>  fs/eventpoll.c                                |  320 +++
>  fs/exec.c                                     |   11 +
>  include/linux/mm_types.h                      |    3 +
>  include/linux/rpal.h                          |  633 +++++
>  include/linux/sched.h                         |   21 +
>  init/init_task.c                              |    6 +
>  kernel/exit.c                                 |    5 +
>  kernel/fork.c                                 |   32 +
>  kernel/sched/core.c                           |  676 +++++
>  kernel/sched/fair.c                           |  109 +
>  kernel/sched/sched.h                          |    8 +
>  mm/mmap.c                                     |   16 +
>  mm/mprotect.c                                 |  106 +
>  mm/rmap.c                                     |    4 +
>  mm/vma.c                                      |   18 +
>  samples/rpal/Makefile                         |   17 +
>  samples/rpal/asm_define.c                     |   14 +
>  samples/rpal/client.c                         |  178 ++
>  samples/rpal/librpal/asm_define.h             |    6 +
>  samples/rpal/librpal/asm_x86_64_rpal_call.S   |   57 +
>  samples/rpal/librpal/debug.h                  |   12 +
>  samples/rpal/librpal/fiber.c                  |  119 +
>  samples/rpal/librpal/fiber.h                  |   64 +
>  .../rpal/librpal/jump_x86_64_sysv_elf_gas.S   |   81 +
>  .../rpal/librpal/make_x86_64_sysv_elf_gas.S   |   82 +
>  .../rpal/librpal/ontop_x86_64_sysv_elf_gas.S  |   84 +
>  samples/rpal/librpal/private.h                |  341 +++
>  samples/rpal/librpal/rpal.c                   | 2351 +++++++++++++++++
>  samples/rpal/librpal/rpal.h                   |  149 ++
>  samples/rpal/librpal/rpal_pkru.h              |   78 +
>  samples/rpal/librpal/rpal_queue.c             |  239 ++
>  samples/rpal/librpal/rpal_queue.h             |   55 +
>  samples/rpal/librpal/rpal_x86_64_call_ret.S   |   45 +
>  samples/rpal/offset.sh                        |    5 +
>  samples/rpal/server.c                         |  249 ++
>  61 files changed, 9710 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/rpal/Kconfig
>  create mode 100644 arch/x86/rpal/Makefile
>  create mode 100644 arch/x86/rpal/core.c
>  create mode 100644 arch/x86/rpal/internal.h
>  create mode 100644 arch/x86/rpal/mm.c
>  create mode 100644 arch/x86/rpal/pku.c
>  create mode 100644 arch/x86/rpal/proc.c
>  create mode 100644 arch/x86/rpal/service.c
>  create mode 100644 arch/x86/rpal/thread.c
>  create mode 100644 include/linux/rpal.h
>  create mode 100644 samples/rpal/Makefile
>  create mode 100644 samples/rpal/asm_define.c
>  create mode 100644 samples/rpal/client.c
>  create mode 100644 samples/rpal/librpal/asm_define.h
>  create mode 100644 samples/rpal/librpal/asm_x86_64_rpal_call.S
>  create mode 100644 samples/rpal/librpal/debug.h
>  create mode 100644 samples/rpal/librpal/fiber.c
>  create mode 100644 samples/rpal/librpal/fiber.h
>  create mode 100644 samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S
>  create mode 100644 samples/rpal/librpal/make_x86_64_sysv_elf_gas.S
>  create mode 100644 samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S
>  create mode 100644 samples/rpal/librpal/private.h
>  create mode 100644 samples/rpal/librpal/rpal.c
>  create mode 100644 samples/rpal/librpal/rpal.h
>  create mode 100644 samples/rpal/librpal/rpal_pkru.h
>  create mode 100644 samples/rpal/librpal/rpal_queue.c
>  create mode 100644 samples/rpal/librpal/rpal_queue.h
>  create mode 100644 samples/rpal/librpal/rpal_x86_64_call_ret.S
>  create mode 100755 samples/rpal/offset.sh
>  create mode 100644 samples/rpal/server.c
>
> --
> 2.20.1
>

