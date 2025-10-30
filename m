Return-Path: <linux-fsdevel+bounces-66502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680FC214E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19B5402E7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C72DA779;
	Thu, 30 Oct 2025 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X5vONgJ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EXtA9u+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670D2E6CDA;
	Thu, 30 Oct 2025 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842695; cv=fail; b=XCAHe0sZHAN/Gf6SnYov4C/UgpNj7GfmUCiXXo8cDK62/2+xIsXd+k4i3ZudPJW+ysQ50+P5adhtPDGW9Z9urxbKgSG4b7N4zMTsXoJBY/GP6/8jHi+wk2Eteq/dB9gV36VzUjpxVE144dQrKhQTOXOceaYsjmYO5/4OWoJRt3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842695; c=relaxed/simple;
	bh=fd9p+LZvkb5bf6cGrJTRMr/Ot5QDN86u0iMBhVkl4u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YYUSjBKyIgU3qVVR3bgXLq9XMkkwV4h4OQDS0t4yb1BbHQrYDNtnObho9RrT+N2rnJdNGcJlUXvaM0Mu2k4heWO4ENwMwwwE8vSncjTORHM5N28rBIS8RnaWzxCFSzgjEebwyMR6FUKcHpD3F3DxgRMnWX2M+5HbSC3IJqgBQ+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X5vONgJ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EXtA9u+3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UFsXMA002052;
	Thu, 30 Oct 2025 16:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fd9p+LZvkb5bf6cGrJ
	TRMr/Ot5QDN86u0iMBhVkl4u0=; b=X5vONgJ3n1YKARLYW8KC8DtPKwOUZjE79W
	EEMC6hmuBJ6gMhBL/bkpVReko/JxuExClX0XRbFcMcIiKGAPAl3gtnhbuzD9NJ0e
	UPuZX27Hic2N2TkxHcB/3MeAstjzXK+75+x0X+XJKHdVZ3vikY8Udf5p7VFymqr2
	fRsUkwhpOI+nZe4oTvOq4N1Jqp8y9DKFcokqnRpn1fhQARgRfqyIAMLsMJY6bB31
	XpyDkPF2ByC5LUkLUm/JpHidVPKfoNboRgDDXU3iA5lowopLqiF46/5dOPA2K4EN
	FTTyhmf434YK70XsJyns4ZLHQNE8gTjPyaz9jr5aY/MuyvQJ8T/Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4b2qg4w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 16:44:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGLmtu034068;
	Thu, 30 Oct 2025 16:44:05 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edm0b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 16:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoH46PaeECQEqwbfHmNiKG6pFolb4ClW8tH/IYj/D2INz6ldvW5ZdQ1C7+zjIepeUAgeRCnFdKZm95lnYu6foOX9xvco9xrIUzUbx619jjkyiF3g4w4m+6N/+obHuUguy9WSg9xA9rbbxH17n5xXCoO/WIokNXnpUfJgjJnww3V28K6BX6rzOT6PWJoGvCbgyVU7z1arhjNANfNUalt+bLGA8GaGvNEE7g5pk8G7ecO5fOJ+MwerxxuLl+iJt5nHg2+imuldege/6i/FdKf3BptPwmQHGIC8PlnoiZt21wlZZrDJArVas2NSg28UUTr/Nj7YodX8ZfoKRCIJbxosiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd9p+LZvkb5bf6cGrJTRMr/Ot5QDN86u0iMBhVkl4u0=;
 b=PDtllTZ3ZBPLxP32HR9zM58rtdBMXJ1QXAfLzGxSwWkMefGAWkwJ/omR4+JePNuKF8onNsfHSAqvREGll98E28aI3sB1yEt99dywXDM6KsJan9CeRQRIuAGstxTzsPG7MaqVMVTa7qGt7kOwmSS4nSDRWqKWFdPL1ZF64Xjlcx8FF//Ik4s4TG09TDw4CcG8xttW9aHwYdVrRr4FGWM+g8NjC7hX6CdZ7Z9C0hOGX/U6t+ESkDePrfuYPcmSfvHCWk9zYliGcQAJimhV3AWWjPoxHfuMKiQsQBP137bUH20I5W8CyqAryYe0Q47vL4ys2BBXW4WeMa0vhsjFYEUcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd9p+LZvkb5bf6cGrJTRMr/Ot5QDN86u0iMBhVkl4u0=;
 b=EXtA9u+3XLYnvDzum4oN4EZztQ4qU3aWAQDus4L93Hcg0i0AtQosnmAFJq4ERfKSIiiWg5dQm5oWEBnqV+P8yVUUbG5rLb9vFrAhr0dpQfKZffKN9TZGlQLuNbzpx2OgaTyUzGhhUYNI+/oFc9XSVt5l3qUpBV01x8uN4VH/CLM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8516.namprd10.prod.outlook.com (2603:10b6:208:57d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 16:44:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 16:43:59 +0000
Date: Thu, 30 Oct 2025 16:43:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
 <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
X-ClientProxiedBy: LO4P123CA0473.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7e2ee4-492d-43b6-fc41-08de17d38699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iibl83KRTuEYSrnIrMsmuVssYNH7CYpTvUw8hB6lRXignkjmH7S4RqCwYjex?=
 =?us-ascii?Q?b+YI4ymnoPp9wlttCLGaZUCqqb8rnOk1kQfYpXRloSxrB8Jrnjm+YvA0+zw8?=
 =?us-ascii?Q?jdELUUmNUqkLrByw6uHpJrkc4dwQLPuYzdfUl0Cm4SOcKAkWOQRWiJsqIrjQ?=
 =?us-ascii?Q?Y7GXUg/yOwfR4Cgf89d47tHN3nrBKiDKPzsZ4j4S8w8p7A6lD2KXtlsj6X/i?=
 =?us-ascii?Q?UdlpqG/w39JMVVqP9b7RNb+pt7KDiqeSXm2rR5eyXwW/Xkj8ZuBHjd2IRjhz?=
 =?us-ascii?Q?cmWnu6KnP022OShtzLbYm86Aq94KgjEQ0rllXR+qFusNtSRa1Gcd+wy4V2m9?=
 =?us-ascii?Q?9ghBxxxsdeAWPKP4QhLqvlZwf9d+dFOZxnmvk5v/SPu4LuAGmAKDFrKhsqdy?=
 =?us-ascii?Q?DAtN1lb0V1ndSQFm75WRpAc0zR/aDAzF+/kx9Wy2BtfPW62H/TmPOBGRDjLH?=
 =?us-ascii?Q?S1P/VWLfPuVKBPBlNy/BDOrmjmzwUaaSx/VDsP+72hbLWdk3KCNZVYurSvpu?=
 =?us-ascii?Q?r4xxzWs6uiWoz/VC0rewz/5snPIZKJ6DLQ9MFbfleBsohX/xG/OfR9+dUZSz?=
 =?us-ascii?Q?Qst21lm82nIr9GVop17Acoue55CItstFGNwb9Gg2FECyJxSKp03DYYgpmeue?=
 =?us-ascii?Q?jpX5uj66IMRpVhEtl+pYP/WUugZnv9uDKaJUw1SSAbN5w10aMT4ugFTTSNcv?=
 =?us-ascii?Q?+G30bnNdKQQ1HIReHn67yfd+WYqZ4/27K2fR9b+nXmusuUHNGU0/PTTB8jl4?=
 =?us-ascii?Q?kRMwrvLnrjwrSd/Ifn9+AFx33P6Tt49G+zB4K9whdvwzyoiOrV8ddy++N+1p?=
 =?us-ascii?Q?gqf35tGM/XTbssiZ7cuxMyfFG0JPJwM1il7ChqEHI02ISdak9RF+DATb8Wco?=
 =?us-ascii?Q?AfSAkQ/bZtThScWJyxIWB6JQ4IJDjbFdD7R5MkG6zTN+Q/gE/jGKwn/KOf9S?=
 =?us-ascii?Q?saGWlQ4t2y+xHr9q1aVaw3DQzBK28sFAr8oxWXQf1aJGhT1Q6tQlnu2gJxcf?=
 =?us-ascii?Q?lXxTFsGmJbK52lcbSXvxe1UQZ7IJ/hnbA76uNb5/Bwb5fdPyIIlE5e28jEjK?=
 =?us-ascii?Q?2Q12AlDdZrgnyHz3ucgB6+X9chPc8jNtua4t8067Ypg3dRS9q2YEoMdAJKWO?=
 =?us-ascii?Q?A/AuiZyCt6KOZaSHWKPVFQH62e+avf+mX0vHvoyZJIDZcrQFYPVMgFeht+3O?=
 =?us-ascii?Q?0DlnDEjCG9/vx7NSNOPaA4qXQGK2uajKY5jYgV5Auu9/UqhqTIhqPRw8baRW?=
 =?us-ascii?Q?JuQL5sWB9F+TNctT5VOSz9/VWSFIzLo9oVHYf8Q28jdlNwtZTpHVGXaNk2PU?=
 =?us-ascii?Q?IerPlPC4w6x57zcF3yClYN8YZzhkjCvqonJhkSkOMs9bjz052n4h+QYwz5B1?=
 =?us-ascii?Q?wqQJtfZ4JsUL6CMDvwHsV826i7/4rVkzSEQj4WxrVrqyIJG3pMY3VOecY/op?=
 =?us-ascii?Q?nfEsOjsIOWNunL5CbSiS2TYymjUDU42V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wGSppetnz9/IkY7y6jQGRij6mZrOYK8gWGRD3+rKFaG/KpirqWX/Ws+WdjyL?=
 =?us-ascii?Q?qX7C19R3GGMnxbtU6+3FlIOfoVEikeNc5D7jTM4E64hEr5ipPXI1jrsv8U+O?=
 =?us-ascii?Q?ctmCaSk8cev7p+BRL8H/W+WhSNGOlrol4fAIfTMAK9cPLToxYGTg4GxBT/eq?=
 =?us-ascii?Q?tJR3ipNRRGx7d621IzXkSG00gtOqBcHBktF/h5M187ShQxSNOlw0qgvtW0ed?=
 =?us-ascii?Q?cmhn755Fatri22aHvwgAL56pnXe9HT2Pl8/Tqj0dHLLx6wVd4Edrf1UFhz0E?=
 =?us-ascii?Q?zsEAPhe0XgR+cNO/llcU+fxitoo0PUROqxEPJRl2eb3037YaWv6fyqrFpiqe?=
 =?us-ascii?Q?4ym9DMvc4yz/Ac02rl5PCtk37sptk5pPUzE08thwC4Q2FXMKlWjHSwcGz9cL?=
 =?us-ascii?Q?zoGdPV5XnrGaYsSZgp7W2k5Wq/pdtZAkoAjuemeld3aKGhNlXJ//6ff9Wijt?=
 =?us-ascii?Q?oqybulG2zkukcoaZOOOHkCFvWKtzFIo+ivRxiuTZ1jurYQ1p8Efy139u85dD?=
 =?us-ascii?Q?oOpKI2lFTUCTTlgxjDbIXfBtlYcj/9u8HEg2FEQPxbnoAMBHiwp80uvGDfJS?=
 =?us-ascii?Q?I27V+clkuMbsU22BDpp0qd3Y8iJpR52KY5NDMKtAPBLySCK4zz8/C1i315Wa?=
 =?us-ascii?Q?UaZiBjBr/ChcftlfF3a3iWrvj8gqZkarewYo5H5HyHckkQx1QaMGOr9FSbB8?=
 =?us-ascii?Q?pP0HTPge6MpukW0ZQj6LUgFKGVzZDvTzXSml9v4w150WVhLPay3Ox9wWDMXL?=
 =?us-ascii?Q?5MjQWV4pBWHQfqtp98p+CCGN/clz89/ngKma9DwJWySnKk84oCJv10Y/2yvo?=
 =?us-ascii?Q?Qa4egQ/jzw+flOO0tKDeV7I32P0g/DF9vlhb/NHtxugou6b//JpdygJcSsuv?=
 =?us-ascii?Q?QDguB3oLP/uQaAi94LP4L9b0MwY6WhRbyjZ/hz2IGRo5lquQhqBgm8au2ysp?=
 =?us-ascii?Q?1bis+kaCV1ohsuMdbNMOBYhl1XtkOY9/E6E/OIDFUGkcE6CvvFbtM8kiTVus?=
 =?us-ascii?Q?q/7lcKpAo/tuNO9+myeGUeDKMP5A6TtjEppj5j+fQNelgXwUGNaZzHKAdMgE?=
 =?us-ascii?Q?yPC79FvzRYPevOR0sM7wMi5DcNa/lregc+bsbagIAW/GQCkFcBYBVRLg5Jsh?=
 =?us-ascii?Q?EHVu6Ta6wRBd5hu3FXtK1t/HwbN7NhX+tQWKmtM9q7PaxcC6H3CjmQW5h5CE?=
 =?us-ascii?Q?3s2UCby394hXbTrHwuIuOLwoTc60fCHWBW1aUWS8ZOaZHeIEiKtYDET8U4Qq?=
 =?us-ascii?Q?pg+vbxmG0FdFNlHxyVg99nARrnfnJJkgj5ecZD7ktATuvUq1E7kuwX8IFEti?=
 =?us-ascii?Q?eNH1RVj7TUNwB+SU0R6GyvIPaYndUhaarEQL3RDObkiDUNM81sSCHF/nd5OS?=
 =?us-ascii?Q?5XETFxTHgUGbsxGo6vgwHcmkyMwXfTq1DKm9E5Nbpr/deApD6u8GBMdt2Ukg?=
 =?us-ascii?Q?vc6kHoPokaWTN9ywU9LGsHNYSagGNuY5yAZk7Zw2zs24I4vb3sbaIiVFpvot?=
 =?us-ascii?Q?jBsA2skddRl7j5qfbqqyhme+WvXFW9RV0uXemwEx02HW/BSzafiIXXjTsM5I?=
 =?us-ascii?Q?134U+V6Ebnl8SjFsxRZEp5653+5jMENjfOz7EZ/L3usqW24kuGhbxR5CX+bS?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3KoGhKGHAiaIE2SPUk9Xa5BRL1kVpt9TRncVEA0zsLbXUUYe73r9dAW9aTGgF81N2LNnzGTABZx/Zd152epjxCIMEUDfO+MdFnP3aryzLSZ64sKOy2UteFI3jC7If10wNi3ssCqHDN8oB+AsUd3HqrkCAUVtekd+NPDuCeInKlUNAcr7V8DTqN3qQWoVcqqFBLEbRLQtUe3Iv9iAkARtNqhU+BeChNnE3d3GNTal4v0s/ZSuM7bt+G9HXcDdBVEanyQn9eeDR3+qJMbiKIdsJg5D5mkZFWAYDQrCxCSSIhG6WyEhvPGkGdBtGser3XvqSzW614V5snJFO9hDc7pgzOmw4DGYkeSVww3kg4VK934tm14lwrqqYbUUUdzVFhrGx1ZUfDu7JKjjLs3+Z59nL1AE9FaVZVXTY+VBDpa7ja4ZNAxkVuGy1asdibPLbXnfklcrGz7AuKSkKZ57ygnLSXQJ7fxOnXEDaAQdpSmw2GTYx4lYOmPO47VCrltd4oosBBpeUxNR4rlXuBJxJWiZb4FefDDDchqeiOQn/NxRIYEyjXXuPlk3/eTV/zf1YgDGFqmOxOJA7dY/uGrzj8vsgZh+lH1/OX/d5p1f0RCSW3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7e2ee4-492d-43b6-fc41-08de17d38699
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:43:59.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reDnLhiNouJHkVSBU1WxMZ2C1RzvycRGqfhRn296YqfKzRTBnw3DOwAnT+HzujX8Jw+YBy2SljFxKmFj19bAgFxCarRZC6wR0jND7h+BtRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300138
X-Authority-Analysis: v=2.4 cv=MYVhep/f c=1 sm=1 tr=0 ts=690395d6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T5IFE8nSnVq3Yj-IeCkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEzMCBTYWx0ZWRfXwN0HgDCtOPuW
 vDC2KuCP6RgO7ZzXwL3qkxMpj6NL0B10TeFwiWxwlXDN2iOfLRNepKLk0nuAYrwkapB746OH+le
 4vTuQEXOSGH0aR845t6Jy3bMCj+irZ3Pne5pbCLKFnl7/yBS2nrnaRzpwZX8jw7qs7YhjFnc2Dy
 SJNGml3RZxakE7oRiHmxBO65GteJiSwD79FaT4rNNWThXmMZxUY741hRSApwtrCRKj3hGLqo8qX
 vvlzrKw4CqFKMxgjMYk137sPtfBg4UwLmTzRd2eCXcaBrn8V8bqEAe6Jy5nQ4sUiJ1gkiMWdF93
 fddxZc4yJYB8ioWVBiIU/FFuJZ+S+PrPVjrAGN7Nj87cn7XshoTv1WYXZOWePioutVrKHynUHIP
 TwqdvNttFbpBcYTSKJ/Nnn822UvO80DvMu2hAo7zs+RqnOhMbWM=
X-Proofpoint-ORIG-GUID: -23-ZMy76qWmtx4BbXml7mbGwT1GXMLV
X-Proofpoint-GUID: -23-ZMy76qWmtx4BbXml7mbGwT1GXMLV

On Thu, Oct 30, 2025 at 04:31:56PM +0000, Pedro Falcato wrote:
> On Thu, Oct 30, 2025 at 04:23:58PM +0000, Lorenzo Stoakes wrote:
> > On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
> > > On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
> > > > Currently, if a user needs to determine if guard regions are present in a
> > > > range, they have to scan all VMAs (or have knowledge of which ones might
> > > > have guard regions).
> > > >
> > > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > > > operation at a virtual address level.
> > > >
> > > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > > > that guard regions exist in ranges.
> > > >
> > > > This patch remedies the situation by establishing a new VMA flag,
> > > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > > > uncertain because we cannot reasonably determine whether a
> > > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > > > additionally VMAs may change across merge/split).
> > > >
> > > > We utilise 0x800 for this flag which makes it available to 32-bit
> > > > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > > > bee reused yet.
> > > >
> > > > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> > > > lock (and also VMA write lock) whereas previously it did not, but this
> > > > seems a reasonable overhead.
> > >
> > > Do you though? Could it be possible to simply atomically set the flag with
> > > the read lock held? This would make it so we can't split the VMA (and tightly
> >
> > VMA flags are not accessed atomically so no I don't think we can do that in any
> > workable way.
> >
>
> FWIW I think you could work it as an atomic flag and treat those races as benign
> (this one, at least).

It's not benign as we need to ensure that page tables are correctly propagated
on fork.

>
> > I also don't think it's at all necessary, see below.
> >
> > > define what "may have a guard page"), but it sounds much better than introducing
> > > lock contention. I don't think it is reasonable to add a write lock to a feature
> > > that may be used by such things as thread stack allocation, malloc, etc.
> >
> > What lock contention? It's per-VMA so the contention is limited to the VMA in
> > question, and only over the span of time you are setting the gaurd region.
>
> Don't we always need to take the mmap write lock when grabbing a VMA write
> lock as well?

Yup. But at the same time you're doing the kind of operations that'd use this
you'd already be taking the lock anyway.

You don't hold it for long and you won't be doing this any more often than you'd
be doing other write operations, which you're also not going to be holding up
faults on other VMAs either (they can access other VMAs despite mmap write lock
being held), so I don't think there's ay issue here.

>
> > When allocating thread stacks you'll be mapping things into memory which... take
> > the write lock. malloc() if it goes to the kernel will also take the write lock.
> >
>
> But yes, good point, you're already serializing anyway. I don't think this is
> a big deal.

Indeed

>
> > So I think you're overly worried about an operation that a. isn't going to be
> > something that happens all that often, b. when it does, it's at a time when
> > you'd be taking write locks anyway and c. won't contend important stuff like
> > page faults for any VMA other than the one having the the guard region
> > installed.
>
> Yep, thanks.

No problemo, you can get yourself into sticky situations with lock contention
but I think this is not one! :)

>
> --
> Pedro

Cheers, Lorenzo

