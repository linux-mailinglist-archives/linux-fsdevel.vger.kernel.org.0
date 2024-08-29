Return-Path: <linux-fsdevel+bounces-27879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B50964A76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195F21C21C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1711B375E;
	Thu, 29 Aug 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJNEr5OE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RB8o0aco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85546B91;
	Thu, 29 Aug 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946462; cv=fail; b=gdqvzAYwITQ9P4QEzNZZrQDQYdvAhEpXF3m0lKQp+lr96DQy0OYvAdhVE3XtU2+j5VBkJtrnngznWKr7xb6WPq8gK/5K+0BHhewIdgS3B/uIQkACiICfomw5YEvIMWIdh1jMbfFThSHUEm7kUG+XjTQ19JxdG2jHbuCNCk4Zr8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946462; c=relaxed/simple;
	bh=h9k1dPToHfuDr5+1cZGghJKuBvGQLDjroVwFQQhXRIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wm6IqaavfIn5TGuew3L1TUUApfDdM72BHmbMn4JfUqzjWla5foFunmg0PpBMYzjeTonNeL40eKGU0RMx2ezQhi4ZbVImTu8YAaJ8Rr+H9VuzCo/06qRI69HCHh6n5R/QjytDuAvJdwFrxJZF67Eh9jiwTE7mFUeu3MI4lfgHHBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CJNEr5OE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RB8o0aco; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFK8Wk032553;
	Thu, 29 Aug 2024 15:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4W5MTQ/d3rXZUDx
	EOWb7xDfyIQQrsr4U+rh2OQc9kVw=; b=CJNEr5OEO/+8zD8YYPDgPTQBFEDliUh
	+IYmvgGkST7x3dh52pXRUHbv/ZN8gLSfp63IFbdEY5H01SWtsYY9GcH4p8JVbjT0
	AO/GzdnBWV3S1GxnAorMm/OgT1RvogApJG8ZK/HkI2dCKarWMYvrITkSJgYTxx0V
	aCKp3bGhGrf53l8myNnI/DCGt3+o4AMhrgrRkTnpqZDCuVG0LDQhrd+kPS7zOCxw
	4LRWCQBtf8MjmL8d5/Au7q6YiR2nmUC90wTN1OSJaesCGjgoR3CkYJm3TmAUrxk4
	Fjl/MdqrSbG4SAoYdO1cO956XoipSNADUCiGoGeO0BWBh3QZU8JNUcw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41arbt0j7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:47:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEck1L020154;
	Thu, 29 Aug 2024 15:47:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8qmxx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:47:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f54LGy06tRO/Opn1rrlnKPD7bkBhMjjTav7tBNXuCXi4uYwgpkrR7nkARMimULD4v8ofL5i/muvfzFUmfwsLGz9I+K5eLV5+AwBWeIkdrcAtwjgMzYfmP9oEMCsnCrjj5Z/Y/BzkckHZFtIJ8viVBpMtq2DcixpBUd9IoLcqYsWMnberE94r4bc//t7/BVb2Z50zxgDpYL3+gtPZhLShgs/qN3QGxqciciY12m4bdJmTExVS9mqTCnhn/CXIU2C4fZzx8xdsu82nPWZPoL9qUT+eE4iK20z67hY1E1ZioEnGRrFmLPSEL0OnjoAcPKYuHRDIUJBvjARXGSmueGGu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W5MTQ/d3rXZUDxEOWb7xDfyIQQrsr4U+rh2OQc9kVw=;
 b=cA+n+1aBoo4XBlnPRkipFLyP1dQy2+8MCyo9R6SYUIwCyZl1pHJ/B+AuVQRAr+k6wdjITVwENARiPQD6msSjG0FKQ/WmgW4354JobeWplNIwhUVLsUpac8F9pWdTGIOirPLt5c5A3gM2saekA7cVaTDrkGz4LdeLsRBAaCGAh3WvrAlSP+BxaB5+n8NPkDC/jS/D6dHjkYYU5eIcPF81LIGPMzNjLecheIMlWD+buWZAys3O1+wpEEu9cOqRxiGP0qaG3AVxKo4g3Zj/oYuor0tJTfOZ/P2UT+NvsJRfUxEFYypACluSckWNK+3zZ+PpJmwpOSIFWa6OtUk2NWUgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W5MTQ/d3rXZUDxEOWb7xDfyIQQrsr4U+rh2OQc9kVw=;
 b=RB8o0acoUCECSfufHEfosQ+qu0b5+BTJgfrNcioyA/sYEDB+hJlPtc3IBZdb2FQp9LCNlJm0xx6dYt6ZeSAFRPKb0Tq2Np41Eh+zHorTjK7nzXb63M84aOIC3eMFFjs6L1gaOZcyJpr+0bbp4SI7t2Um3zZnWXk5Syn0GuYsMHU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB5964.namprd10.prod.outlook.com (2603:10b6:930:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 15:47:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:47:25 +0000
Date: Thu, 29 Aug 2024 11:47:22 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 09/25] nfsd: add nfsd_file_acquire_local()
Message-ID: <ZtCYCgcxFeQZ0XBN@tissot.1015granger.net>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-10-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010424.83693-10-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:610:38::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfe6fce-a64f-4bcd-1a27-08dcc841e116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g2kE5IMsEFz1CGZi+mhZzdYtNHURa0Vh1f+lDzKiB86tsy4V87Eun1lqyCq/?=
 =?us-ascii?Q?hdb+orf9L/E0ojF5faBWEUGxNm7abd2BHEo7Ifd9Iwqqkh1D9sTfE1hBBrNL?=
 =?us-ascii?Q?YoP4znt2xIJEGyeKqVR9/MTBvcWaacf7f2/+T+daF57Hd1JjMkjEHM1Tnl1Q?=
 =?us-ascii?Q?fZbliWxR+bmu0alyoukMpU7QZlRqXJ4BS83gkoLmsxO5XVHqoaIBpm3j1sqM?=
 =?us-ascii?Q?WvV8QepJVnwSMVMJeXvZyMTIcv7H5zRWHfvsuwQSOL6+PZmnvBs1aSV+PgnQ?=
 =?us-ascii?Q?Xt9x2iZPEsvl+IEt6dOY1gXlsWLJLuOL7KEnUUIT58Oi60SY4qozqz7waxnf?=
 =?us-ascii?Q?20TPeSckxHSgBhj6pZszBLfQ+z25NVsm43tZpD/GeAMw344DWoEGUKC0ZHDQ?=
 =?us-ascii?Q?GmHKFH9mGxnqN0DikAdm2mrQaLzCn++9u5aOGDTBO21e/7FB9lVrFzYmidcZ?=
 =?us-ascii?Q?5dD78nmSQm9WHaFvMXRZ5QRsnCDRslQktJJN0tSehjS+n5a4d4D+7CE7xvLs?=
 =?us-ascii?Q?UbyqspVOawg/HHeWyK5xlDeqBEVuUSZZUMdOFHli9gpOaLKSRtsjaxc8wa1B?=
 =?us-ascii?Q?w/h+tkulf7kcBJY1c2pGbCpG2eIQSh86KCPLMq706pkEVGNrNW9lsd1DPdWx?=
 =?us-ascii?Q?X5th175w6bs0B0dcLZnmAawDFNDrCfE+p3h0b/wS41gfM6y2L4UkGQSI/xaU?=
 =?us-ascii?Q?5Jz4wqVoy7uAZrIwhcO1wUic0e13VfNSQAErYAJEpGcCCcAxb3Lm1OEeHKXs?=
 =?us-ascii?Q?X5GStgDtXFDLUeYMoX/SbVdKrQ0MFZENI4x3JYzJ2VNdB2Y3OEsyapn9AADQ?=
 =?us-ascii?Q?WZ5e9+8iIzTvrdH0PIfoEyFTHLjoWIkf5TSj77JcLaOS8XsdwtuYSBes9D/8?=
 =?us-ascii?Q?BlyWYFrmA0lWvYKkDl6mNonPhKcz9gGiZcJePQoUSw5HIswhQyrAE/khc4C3?=
 =?us-ascii?Q?EVYgDfm5NxEb00Y1FFbml4G7+O5rM3wXKQTlDVA2pgPp3XAwow8ZvzJ3V8V7?=
 =?us-ascii?Q?NWLEbOWU8bS4J467l3T6uJ6Kn46dvfdgc6iD4Em5dc2/VSWIfidA0fr9zCH9?=
 =?us-ascii?Q?QeASnnB1VgqhzdCJyDQY51QVAFkmrK5h9Bm83q6m4jh1j05LVvRfseF8MzfF?=
 =?us-ascii?Q?bnZj+mgh2/mqpyf/cNcVIf2YqQi1WMW5RMf9jcSDwFuer29MKTZqen4CgbdG?=
 =?us-ascii?Q?+RhAVF3wXGFt87H1bfVMaf8mN56xlqF1XKQaxsy+a9gnEUINgRrFjO7J7Y5o?=
 =?us-ascii?Q?CMQRwW915Yu19n9GxBiIufe02Nc16zeYZLFslPBm8u9sQvednmZPksbzpbww?=
 =?us-ascii?Q?73cte+Z+xqVlvIYeCV7YqlZPGLJJWcIi0v5Hu0Wn00KB4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5e+ESi1A74w9g2saFlcml8/0AIFFBq3geo6i+at2lBWu44Wo98IToeX7IdVo?=
 =?us-ascii?Q?qR1lCzT49k6vcBXQMQn9CLsul+Z9tfA6EpANqBCOnLsZT2CW5Xn+hmb+uB/6?=
 =?us-ascii?Q?svfGkFYE9hLlStk4mpQYPduof1PnpoaFav80Mcwkr2h/gTN9Zev8tkTcQLoy?=
 =?us-ascii?Q?wd2jeXHdEJs3+RL1rX/ruL3ITmB2dLrDrBM7ifK8Klh4q+L9IWFE5kxU2wbv?=
 =?us-ascii?Q?As7jBrF/IlzHURSUaWRWdERmWMTC5AbH+0HNwkvLsQ6G+tAE8Ss9jAlbGBLd?=
 =?us-ascii?Q?HRm1v/s8nwu8WkPtSiOD/0EcBPC7GzAKuV+Adx/8Vgmo+rwiNVmOLkWLaNeL?=
 =?us-ascii?Q?JUKvstrZnyHe/E+ho2Php4iZi29riBoA4sbszJ1TvK7WvG0bpbWd6hwd/EsS?=
 =?us-ascii?Q?j6CA7vHW7AhzGS11YD4CHgdWQSyWfCOP0534uhMnpji92zSnZDVs5et3EBSN?=
 =?us-ascii?Q?uWz3/e94vDIUKSeR0cBCFB8aiOB3o0tLF0Gr9yT0y0pyj6NsmOUtjjmNP2S9?=
 =?us-ascii?Q?K8g2gAofAbGMJyP9kSixB/5LjVu37O9MZ1Uniz5oLUMAwJ28n05M4S5vZCrm?=
 =?us-ascii?Q?RdIkX+27jvdiuStwwR2Nar4HWQLS1HhckvvQ5re/vBCJNrztCllF5FpVS+RW?=
 =?us-ascii?Q?cDJB7O/e1iqpzEqJbHZ4e7bjGzdVh1vM0MHRPeqqokhKM8qkS7iy6WTiFVyB?=
 =?us-ascii?Q?M1BbLd2ZNWqUk1snfvJRSzXjcLEMZFSrKS6txk397HkPRPRM7bgSHMGCE5CH?=
 =?us-ascii?Q?aBhN0mFYy6LVcs2GPGNnAY3GQY1S0ma41OuuMJk6e2BWXu/jzTKEmcltp5Zi?=
 =?us-ascii?Q?oYjX4GvsnxiGWDlZQcvmb+1ir8HCDdl9oCezFIgCUwDHzd08ryQpupDsxi3t?=
 =?us-ascii?Q?ubc9nLzYWrCQmzbGzpGzEvurVsaM7vgLt0YAm7mtuNVe+qbquYoKMp8VBQO3?=
 =?us-ascii?Q?zJRMtW+XaGRuIfgs+u8znBmjuNc5xeSPGw8fUqeR9h0fc2IjIaI9ie/vcmZr?=
 =?us-ascii?Q?AxF/AURLSUgRW9rrHlWbJ9pMoOo8GHnoJLOTryVScWZX9aUfJXfkscKJ2zXt?=
 =?us-ascii?Q?mF2EdsA1MBs9yAX11h3i5sE4p/4eEYKZ5GwTwRzO86/mj5cTMEoDkm9fx7Uf?=
 =?us-ascii?Q?AxLjQbyw0GjzscjWTHpGYgKZN8qTF/nlVYZdk877o8DvShEnl7ut4kSIsI9J?=
 =?us-ascii?Q?cvxukbQc7QSCZHd3WqzA6+rXMoo1atg2C01YmxoH5IUw5AEv9eNhzoFzyFi+?=
 =?us-ascii?Q?U+1bg/qLxfKnJpsC2/E92Uas+NOalnbkzvF6CYNylSs1m7TFgzVvslQviwwS?=
 =?us-ascii?Q?hS7u/v+MilAYXCnpavY6O0SeuDvyftHd+lsbgcqHEl2jQqfFBDLrzpRAa0dh?=
 =?us-ascii?Q?0E9B3CjX3eRBiuwZ612awjqy07y++mWF6y7OnpAln0QzQ9ay5LIsYP7WIB+X?=
 =?us-ascii?Q?aqBDimMnYa5FCpnYR16f5+LO294//NjTV6bHgEx8ECVEBY5PpsfSJY0hifeK?=
 =?us-ascii?Q?Mvnd2QtQEtq2Uh0v4wS1vRutySVaToj+wHk1CnBGMhEyh2v+tRcvSEgV6rhA?=
 =?us-ascii?Q?kWgh2WUfwtNKEJrXSkFX7OIAXnpEPm71DfeOniohHXHpFB38J7llf2OaBRfW?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4w6hTY2crp7YeqQ1in5F0yH7Bfojjs+RNUPQtwJ/w9dtjTBTyS5jks+CzWQjcbOXE0IqQd5oQa0owo7zHKsbUXM1PwZA5YRfhR9PwwBiiQT6wto9D6EB9cjPvIaiQE1kBOJmEAUFbfloBuxbyW1f4Mt+VaB4CS2EWaz3+uE7Cz8ynzgCCn0iGWLaa8I5XZPKF5JANmxQgvr2M9YyixNivg+LiEk2VDNnF3LNP+1cTDhSm0SPejfmgNJIrsFLbW531ZNDKGK/zv9daNSOPmANwaR0MVLuycQ8nv8/FXPaobmbQG9UVyXfwlREO0/0nge525/w6L3l/SV34JWSF84aOF128xWRnxIy6nxzfIEM3Gv1gfdaCrHHLjTtAUP/LOEp+0UkU2zGZaxVIGhwiYDapLhVtd15IHHnpByzY7iBDRhBBebsp0gfsyeSMXAgyUJ9IfZO+jCf2LHqeqO3hBu/8ClO/kXheHGiu2llj9uMQ2eVqYBMhR94imcZq0y7CVikj2TJle51oqmo67AUDfjUCxgWOSi77iONt9kA8P2klzxnumkJXQ+AFGMZpjMe7BqbW68+KFeyoSFo8HUomUNVb3bsggfEaFRnQ5wWUNfo1yc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfe6fce-a64f-4bcd-1a27-08dcc841e116
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:47:25.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSvaOC9ib1UjKFUkqzBKWiNc5oK35DmFXhEpBIQ622/fE3G8l3Imue1lJC2fPbZuk49o/O/b1scKBGB3/h/Z3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408290110
X-Proofpoint-ORIG-GUID: J9RMfeeMNjlsOH8WcY3d84uhK3_MI2st
X-Proofpoint-GUID: J9RMfeeMNjlsOH8WcY3d84uhK3_MI2st

On Wed, Aug 28, 2024 at 09:04:04PM -0400, Mike Snitzer wrote:
> From: NeilBrown <neilb@suse.de>
> 
> nfsd_file_acquire_local() can be used to look up a file by filehandle
> without having a struct svc_rqst.  This can be used by NFS LOCALIO to
> allow the NFS client to bypass the NFS protocol to directly access a
> file provided by the NFS server which is running in the same kernel.
> 
> In nfsd_file_do_acquire() care is taken to always use fh_verify() if
> rqstp is not NULL (as is the case for non-LOCALIO callers).  Otherwise
> the non-LOCALIO callers will not supply the correct and required
> arguments to __fh_verify (e.g. gssclient isn't passed).
> 
> Introduce fh_verify_local() wrapper around __fh_verify to make it
> clear that LOCALIO is intended caller.
> 
> Also, use GC for nfsd_file returned by nfsd_file_acquire_local.  GC
> offers performance improvements if/when a file is reopened before
> launderette cleans it from the filecache's LRU.
> 
> Suggested-by: Jeff Layton <jlayton@kernel.org> # use filecache's GC
> Signed-off-by: NeilBrown <neilb@suse.de>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 71 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/nfsd/filecache.h |  3 ++
>  fs/nfsd/nfsfh.c     | 39 +++++++++++++++++++++++++
>  fs/nfsd/nfsfh.h     |  2 ++
>  4 files changed, 108 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 9e9d246f993c..2dc72de31f61 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -982,12 +982,14 @@ nfsd_file_is_cached(struct inode *inode)
>  }
>  
>  static __be32
> -nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
> +		     struct svc_cred *cred,
> +		     struct auth_domain *client,
> +		     struct svc_fh *fhp,
>  		     unsigned int may_flags, struct file *file,
>  		     struct nfsd_file **pnf, bool want_gc)
>  {
>  	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
> -	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_file *new, *nf;
>  	bool stale_retry = true;
>  	bool open_retry = true;
> @@ -996,8 +998,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	int ret;
>  
>  retry:
> -	status = fh_verify(rqstp, fhp, S_IFREG,
> -				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	if (rqstp) {
> +		status = fh_verify(rqstp, fhp, S_IFREG,
> +				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	} else {
> +		status = fh_verify_local(net, cred, client, fhp, S_IFREG,
> +					 may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	}
>  	if (status != nfs_ok)
>  		return status;
>  	inode = d_inode(fhp->fh_dentry);
> @@ -1143,7 +1150,8 @@ __be32
>  nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		     unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> +				    fhp, may_flags, NULL, pnf, true);
>  }
>  
>  /**
> @@ -1167,7 +1175,55 @@ __be32
>  nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> +				    fhp, may_flags, NULL, pnf, false);
> +}
> +
> +/**
> + * nfsd_file_acquire_local - Get a struct nfsd_file with an open file for localio
> + * @net: The network namespace in which to perform a lookup
> + * @cred: the user credential with which to validate access
> + * @client: the auth_domain for LOCALIO lookup
> + * @fhp: the NFS filehandle of the file to be opened
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * This file lookup interface provide access to a file given the
> + * filehandle and credential.  No connection-based authorisation
> + * is performed and in that way it is quite different to other
> + * file access mediated by nfsd.  It allows a kernel module such as the NFS
> + * client to reach across network and filesystem namespaces to access
> + * a file.  The security implications of this should be carefully
> + * considered before use.
> + *
> + * The nfsd_file object returned by this API is reference-counted
> + * and garbage-collected. The object is retained for a few
> + * seconds after the final nfsd_file_put() in case the caller
> + * wants to re-use it.
> + *
> + * Return values:
> + *   %nfs_ok - @pnf points to an nfsd_file with its reference
> + *   count boosted.
> + *
> + * On error, an nfsstat value in network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> +			struct auth_domain *client, struct svc_fh *fhp,
> +			unsigned int may_flags, struct nfsd_file **pnf)
> +{
> +	/*
> +	 * Save creds before calling nfsd_file_do_acquire() (which calls
> +	 * nfsd_setuser). Important because caller (LOCALIO) is from
> +	 * client context.
> +	 */
> +	const struct cred *save_cred = get_current_cred();
> +	__be32 beres;
> +
> +	beres = nfsd_file_do_acquire(NULL, net, cred, client,
> +				     fhp, may_flags, NULL, pnf, true);
> +	revert_creds(save_cred);
> +	return beres;
>  }
>  
>  /**
> @@ -1193,7 +1249,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			 unsigned int may_flags, struct file *file,
>  			 struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> +				    fhp, may_flags, file, pnf, false);
>  }
>  
>  /*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 3fbec24eea6c..26ada78b8c1e 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -66,5 +66,8 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct file *file,
>  		  struct nfsd_file **nfp);
> +__be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> +			       struct auth_domain *client, struct svc_fh *fhp,
> +			       unsigned int may_flags, struct nfsd_file **pnf);
>  int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
>  #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 80c06e170e9a..49468e478d23 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -301,6 +301,22 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>  	return error;
>  }
>  
> +/**
> + * __fh_verify - filehandle lookup and access checking
> + * @rqstp: RPC transaction context, or NULL
> + * @net: net namespace in which to perform the export lookup
> + * @cred: RPC user credential
> + * @client: RPC auth domain
> + * @gssclient: RPC GSS auth domain, or NULL
> + * @fhp: filehandle to be verified
> + * @type: expected type of object pointed to by filehandle
> + * @access: type of access needed to object
> + *
> + * This internal API can be used by callers who do not have an RPC
> + * transaction context (ie are not running in an nfsd thread).

This paragraph is incorrect, since fh_verify(), which has a non-NULL
@rqstp, also uses this internal API. Another review isn't needed,
but you should perhaps drop this paragraph before submitting the
final version.


> + *
> + * See fh_verify() for further descriptions of @fhp, @type, and @access.
> + */
>  static __be32
>  __fh_verify(struct svc_rqst *rqstp,
>  	    struct net *net, struct svc_cred *cred,
> @@ -382,6 +398,29 @@ __fh_verify(struct svc_rqst *rqstp,
>  	return error;
>  }
>  
> +/**
> + * fh_verify_local - filehandle lookup and access checking
> + * @net: net namespace in which to perform the export lookup
> + * @cred: RPC user credential
> + * @client: RPC auth domain
> + * @fhp: filehandle to be verified
> + * @type: expected type of object pointed to by filehandle
> + * @access: type of access needed to object
> + *
> + * This API can be used by callers who do not have an RPC
> + * transaction context (ie are not running in an nfsd thread).
> + *
> + * See fh_verify() for further descriptions of @fhp, @type, and @access.
> + */
> +__be32
> +fh_verify_local(struct net *net, struct svc_cred *cred,
> +		struct auth_domain *client, struct svc_fh *fhp,
> +		umode_t type, int access)

Yeah: Unneeded @rqstp parameter is gone. Clean.


> +{
> +	return __fh_verify(NULL, net, cred, client, NULL,
> +			   fhp, type, access);
> +}
> +
>  /**
>   * fh_verify - filehandle lookup and access checking
>   * @rqstp: pointer to current rpc request
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 8d46e203d139..5b7394801dc4 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -217,6 +217,8 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
>   * Function prototypes
>   */
>  __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
> +__be32	fh_verify_local(struct net *, struct svc_cred *, struct auth_domain *,
> +			struct svc_fh *, umode_t, int);
>  __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
>  __be32	fh_update(struct svc_fh *);
>  void	fh_put(struct svc_fh *);
> -- 
> 2.44.0
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

