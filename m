Return-Path: <linux-fsdevel+bounces-47340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F7A9C4D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D087B0821
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7F1C8600;
	Fri, 25 Apr 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QomFLPjm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UhkrimEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C56D22F39B;
	Fri, 25 Apr 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575904; cv=fail; b=o4YxUmpKAqAmMHW+eMzgT8SnT0Xe4vVPOYW6Lr2yxenme0fkUffDiyxW2neDOnYR4CHOpLkzWIB7efJRXp2NvgJf4zACeIEKPBxKkoV7X6QMxZKkF2mZzOmUReUFmphx48Ca0ODrmssgoLKMDOLBZ7YBfIzAwKFhvnV63jkDfjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575904; c=relaxed/simple;
	bh=vukRWvWyOUBAI4bRSYKPVA/ZjXOQp70L1DbOVTvE1zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BTtHXafhg6hl4w8qqwd66YY6tEX05KkkmCHXzWSeHftadOmZ24GW0ARF+Ox+u7pgfiDsyieZCzxduhBIhIsjbP7bxAv+fV3YZ6ugNVMd4B+YKIR0Rc/iDbda5J5MfgsW236m0DshbGV/EA6LaC71eD3ca5yz9hs2FaSpIt6neZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QomFLPjm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UhkrimEy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA2DeD024665;
	Fri, 25 Apr 2025 10:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vukRWvWyOUBAI4bRSY
	KPVA/ZjXOQp70L1DbOVTvE1zE=; b=QomFLPjm3pJxevCzgrlvQQ1wLjwDj2T7Aq
	LCTx8di9lJIVK8NynLH5OiCvzsMvH8fhjk6aMLTcc+EoH1Iew/B12FScaIU84U6p
	pTKH/vghifkjgaqcN9qYxvViPi1txrRZiIfhlBYRgTq+/AVcGk9PBmtCnFt0zPqO
	6eUXx/UZlg7xogw3moCwSdj6EwxYhXC4ZzINWmlXlXvubJmkmYJV84+Ed+YGbB/8
	lowPRk0i+mHbI4RtyZUo6cJzOThVmGftKaZwfTHXsa/rpk7kEXGqKJ9pUZ+JsLzr
	XN6PoMnb6fWiNdWjXp18+wXY+24+Hbxqef4zVJ2SwCU6Ph0R/lrQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46889j80gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:11:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P89Rih025164;
	Fri, 25 Apr 2025 10:11:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012034.outbound.protection.outlook.com [40.93.6.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbt7adu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdMcEvnmMraNSNEZJfImRLQpOQU7Rdjz8LDryMjrWZuUSrrkn30NY4HGjn4xnnIIFVb2cbmmp4hY75RqFuQB5lrkZRGHtc5E8vD8VSNK+xQEpVu0y1qc7+Eu5InbLNDiMlyw7zg6jWTzMHQyig2phQEU5VBxORxEsVUxZ9U92+509Y+IXYEmM/WIApWUvMuV2G71xBEbVSWEtsRDjZr5+8LroB33IbFPEexXTz8PTm/whxQtEFup+2agDRqRKjElH7T0OAnT6wEMTaOWB6H6nIOdwbwsBmAkdUfmnJqI/f/Mn7JKoJog8ZB/M29ZhmLTjH9j9pZv+0l7pUZ+Kqr90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vukRWvWyOUBAI4bRSYKPVA/ZjXOQp70L1DbOVTvE1zE=;
 b=BulQwf6Cs9PrcgRuz2QAW2J1RhH2820S3PQm9zglO7/h1sMcTwy6sXgssbv0KOjlgvs7tzH2B/CVKcxg7ExEnai4Of7yAuj1786UNgj/yNVk3gnkYHoHeYRYWLc7i3bYJEhsWVnTFmFCtjPpak7iZF+rbRnmSak8ohuLolFQNOWpFFlS2loMTF4+qBZEjifHlg0nz8abo/mft8a09CtFvfbTGrfCeJqsK4KcNVZKOwXD9Z+xBgsSBL/cMYUEzqZ+/FUz3t37nqxSk4OsnGhUBcI80oOFBNmHfUioQhBfuQi5lkWpKUOAptSOBa8lNwpG0oY3DLUOMJVSHpxFfVQT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vukRWvWyOUBAI4bRSYKPVA/ZjXOQp70L1DbOVTvE1zE=;
 b=UhkrimEyXO6Gfe02SqUg+EVvCQAduBE7Ip3fo35Yk8zK8CAai89LeZ8qOwtkk4fmczLlab5Ggw600pGfApvozZUVZx8RrF9Ovz7BfsQkrmCo6Y76R2tR1conbwyPeJuguUvXueCgRxd9REdt1qs0hJq1bZsiMIPKJ7P3OQ6QpVM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:11:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:11:21 +0000
Date: Fri, 25 Apr 2025 11:11:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: abstract initial stack setup to mm subsystem
Message-ID: <beee409d-67d7-4754-91af-99b4e193ece2@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <e7b4c979ec056ddc3a8ef909d41cc45148d1056f.1745528282.git.lorenzo.stoakes@oracle.com>
 <57e543a2-4c5a-445e-a3ab-affbea337d93@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e543a2-4c5a-445e-a3ab-affbea337d93@redhat.com>
X-ClientProxiedBy: LO4P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2a21bb-6787-4222-3783-08dd83e1873b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXbRjfpgcEp9WtBz6TcV/WGGnbtvZxhJTvW/KGXDyPcolyCxnbG+UpzP8wWu?=
 =?us-ascii?Q?oP+4ZXLSWsai89UdP5iV6BLJtLVzhcJpiUgJdXd08lSg0+EdFkAvz+oE9SDn?=
 =?us-ascii?Q?5/64V+Vpfes2cLTjEAab+Brcr9nkr6TklMldVEtAUT9HjN1yZRfrxXQT4fce?=
 =?us-ascii?Q?FwpOQbAsz/SxeLL2HxuclcYPe+/IsZRg76jkbAza7N0oBZRH6XK/L1Tu1n7n?=
 =?us-ascii?Q?5XTpB5IbfooHrsFUqySj7qNdqk6OWkqnjujnQonHZpAm2Yzqq9fQc1LcorpD?=
 =?us-ascii?Q?76SVXEdHSdsih9yNJgMr0J+EvD1DfJC11/9J7hjB+AxyJhRxY/DurcS+B8aN?=
 =?us-ascii?Q?+fVduFuRv0yuAekJR30QS/kYtebctqSN+cfibp14C3148vaH21QTE9jhRu8U?=
 =?us-ascii?Q?VAR3Pl/gGcp91XJPVzC8Gu0669KhSjBGnKs/r1xKZdvizUKb2uCs1q7OebgW?=
 =?us-ascii?Q?HOTwXKyCYmgSir1U45AHvIcAromSWkIrJKSGAkA5T1dzuKnMYsWqqUa7fvG0?=
 =?us-ascii?Q?IBDBKOdn9xM2FWuVxek0AAXNNe0YSfzDUf2vfkDWU9tXCQztBLeFXw/606Fu?=
 =?us-ascii?Q?Svmkns77oidXzItJ4L2BpgrC/znkGRqLXSYza1bHBkPCLKq7wTfVI7ZrM86s?=
 =?us-ascii?Q?LnyhwgLJhuXBUSezRqi/96zZmvqNgHwdaQTDKmAB9nQHWICTOu96GlwaJ2ZF?=
 =?us-ascii?Q?kByvQe7CUia4lBsyX7rTil4H7CO5ZNao35oQ//WQH+B+x36twEdFOiEGa5I9?=
 =?us-ascii?Q?Yuyh/JBot49IMvi1hrkOeYjxFnPeAX6IAeMHmg9FMqUl2pBBsER21q73GjKZ?=
 =?us-ascii?Q?GFEICTcOtyBNbWYdtnA7KIwc+rEpnlEaOYqW0mdClEgXZ+Iutiuhxt/uGYEP?=
 =?us-ascii?Q?twVI3ZALkK4ogtgd+jD8BgxZ0e3jWfj0OYkXBSK6bYmxSm2WHGy2oPsmBTH8?=
 =?us-ascii?Q?5YX2tr5+aADekT5SsOheiPefaU/X3ysTdRHFOFlmSg6AjBNLeFWG5L1p5E3h?=
 =?us-ascii?Q?uskOccBQ83rIgHU6dXLL30b8S9ColDJ7kNJBsR4zoEDv3W8RvI6VDUEmd0Zg?=
 =?us-ascii?Q?gEC0OaC7BsYgZS6JL0pK3tQnSaVsTK61FMm03EACWVuyfvmy0lraHtMieCyp?=
 =?us-ascii?Q?0zg/b8GbW3Jp1uMcty2mK4IrzLXa3xd3FBwCH+CnJFlEMy2rDeu6GlpKuZzI?=
 =?us-ascii?Q?wcOXXnhA8yDV5H2ONrU52/4eL/MMIbw9w9ivTkSE6Ckh9ZU4RPJOv4mJDLji?=
 =?us-ascii?Q?KIJIAgn+wkTpGronJ3HrhyfRIAyn24kSpp1NZ5jRQ9AzT3aJt4v0Ri1cl+I0?=
 =?us-ascii?Q?rWqH9+Q6VlF7hwknZtQPGmASwHLW+NqgL+kPFwVp50Xch/Lw183d8HTW0GtV?=
 =?us-ascii?Q?SkJHNggmAPmUQvO23DPig9sOs04HiHh5YKTR5gRi0Rwe7l+j90vhRle5ZeEe?=
 =?us-ascii?Q?33NEZan9t3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQaclazkz3H7+zj0O8CqBaSBDtItkOiEspAnoVzRFQ4egD4s0pxwB684FYiE?=
 =?us-ascii?Q?AMMaXZ+JDXYOF/jcZOFDo8MElHdV1TVwvjlECMmooaWn6MIben9/fMlgHlva?=
 =?us-ascii?Q?g0FGn40kJQ8LnR7pB4ZGi4Rs5aSwR/+8fpagYJ1pFXiyrv9YHTGdrdeYE622?=
 =?us-ascii?Q?yq7q8FKYP25N7wfacWE1ZtIeIlJ+98n2AhYumWpqGiwI0oCtqJjXsrQmvS0o?=
 =?us-ascii?Q?5L8otUSpssTMUPG2ndzRL7GttDKw0mzx7i+rlS9ESHKtlpRtqB0N7lbhDE6q?=
 =?us-ascii?Q?EoIywJUrHgKp3df58Y35ZsRIQ7o/NVR7juaFeH9/RfmGe2FLq/sXA56Mn2ag?=
 =?us-ascii?Q?lK8E9+MVIcQx05FFOSGju4Zdf+6+OeOR3VYqBolunb+TmtJbgQdjRSqJ5muN?=
 =?us-ascii?Q?XImTAEB24eOGxGG4uzy1ghO8Kc8hFZXnaVXrA1Szy9BaMZoCT7i8g00lzgZ5?=
 =?us-ascii?Q?4sU1EuBc3rmOgkreL2O/b+nghEGZ5nWAZ9iC1FtehHuiIAi+3+nBMwXTB7Tf?=
 =?us-ascii?Q?27WSLekK4M9F/V54W6b1a5dwdTKFIyPqU2QO3g9UNQGwg0kQmDxJHGVMiXwY?=
 =?us-ascii?Q?A60CJYJr4QQGRHRtSvgdj0we177Qf7PiPY7DEZ+vcWyzzAQ2wTlbQMpST4GL?=
 =?us-ascii?Q?QjWUdtf+UU0odDc9HTBMV7X0pAOi1zWDl4Hvvxh6U029O23vNwP0novgNUiA?=
 =?us-ascii?Q?hkA4GtQhTzti2w1ysoKDc5Xvj9AdsAfrwb6MOr49hgTDQlzaAEhbFQcQjBkp?=
 =?us-ascii?Q?+lLMH0n0VOA2tr9Rj6vA3XeGzpejbl7WPYlDAfUIxXS5+4nbUwV3KM04bSdu?=
 =?us-ascii?Q?xnMf8+0dXy/m9r96986pBu+OXOS/jC7wIvasJ0Mifs7Al6Z13n/FOteQjeVm?=
 =?us-ascii?Q?lEHKJgIrC6LtP0sn4Yvwy0VFtkvfc6PASxxr0seV1V3z6IwoFF5WszBLatsc?=
 =?us-ascii?Q?75r80GevyVC4AOwBuKa5p+ltsC/20XY+Np/lsMwMG3DYAhyUX/Fwyp73i63d?=
 =?us-ascii?Q?zlhGzPF8yUVtUJK8kpQ4pIVDnU10Xi/Oa2Ga9JoVfq5Xj/8JAUFMD6goxV3V?=
 =?us-ascii?Q?AmbP+ZY2ths9zCHTKyDeSt+WLmEipgIEAPIokn8oGNtG7q1DBSPStSNBsvop?=
 =?us-ascii?Q?MfD7nacTV9uvMLJC3GtH0HDcvMg2u9UDVkf1unMI4GXMncBe10aMtBLJsGUd?=
 =?us-ascii?Q?3l53lJiWZZR/E1dRtIFoKiqpJNSrntvda/epqq4IhBp+yX+UHKBdx/82IGqd?=
 =?us-ascii?Q?HhVBylRLlCWNpF6MT2hAY4A/95O+tQJv8tJPJIP5bqm/ZecGJ6P9leAkgeGd?=
 =?us-ascii?Q?3sLL4JVUrmSsnZaMe0YWlE7A3MdpmWAotIm9oLoJCn3FXgeZ3GzAH+hXlFOw?=
 =?us-ascii?Q?S3DKgJLwfeQjCcaMhZXY3LKEA0HEsbYX3RBB0kRFqjyCfdvMS7lsBbDLuJn6?=
 =?us-ascii?Q?HpPjB6kFzVEMlEyHtdEofPIeG90vmqM8WF2EPcWYQrYujxwYeGIZSLMJ9SIl?=
 =?us-ascii?Q?Vz/utvZPMBiSKS9pSHQWWv2dQTtZVpfsSNvTGOr/WLY+ZR7vqxkChxVzG6VY?=
 =?us-ascii?Q?TU54J9e/bT+ftH2hrAr0wOSyDLNeOEpwvpC97zfzsnlFf6OA9aLvSnONoLVu?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cG3lqgdPL1De7m8B2VJmMaa74t2pg74/+R8Mr3oL1OF7jtPAsM9uZBj5MhWMhdf09pPth/oKFZ6Ugc9mxKpLNpul4AkZ6OdHcUlkLPDFH9zCw8I38RdcpCRC04+0hheYiCYFwIq+TZAL/DHvu2SvytFVQQfZsYrifj+yjpY4OFxPyCiqeWiSMsE31/sC+bqprMRpTRoYb669enxutNNoWucrbGxRNDR+fXJHNYIe0jZziSteKjPtV1LowKizz9AEuvSTqOIurd0XouSgboHixy6sti+z83JmTicdR576pg8UMkIRz00PlN1bxtJwlHxPQDKAMmR8nawO0sXeUbRUzyV6Jw1Cnn1mPLwss4k5b+nEhahtzGRVoGCr4Z04VbrZa99GJN1FvNuPzZ/Hs3OjiZc8lEViCMUpcD8995N6NU58yeGzdLtjMytROdRd8ZWiLK+oMxZn8BxZd0A2XYUkUhBs/lIoXsocX0lzu5YPbzvTJwCVnVuLxk0olOMb+TNOtS5nYc7gWn674hzx2KyNLtAahpYgWwJwRDm5cbCSRwY+FEbRaE6wMnEpTiHKU5Z8A+IR5zDTJ7qF5XyuPm7sCQdYjkOcsFvyqlvm1YipKxY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2a21bb-6787-4222-3783-08dd83e1873b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:11:21.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbL5u3fm1rYz3tRAtqDEYyH4zjzREXcb15bA/hqm9wnXsjBQyW4rGLem66fAJ6mjCzfoMrZtYGwb5bGRh1FXUCMX+zfdq22Yh605XYt27g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX/1WPKnhRE9JL t91vk9MAA0lcinK/fnixElTqTXF/63/lhQy1TreLZwb7Ghc7T5e9T/z6njs4/+rGLbxT7sjn/Ju iBpPAhIwhLuPFf1HyAqclmrX/3nTfFeLYHzFhkMipFw3wQsaqRu47bSiv2JQXcnaMwq2UnE8LB9
 m9eYMnZtExik3/+uX2tKlr4GCTMxFUcju4zXkKrsv+n3FEQgDYpDkUyinirqW2/yWainS2hFjL7 eTeyofJGSfj4DHxzyBd6jSVBdJKlUfqioHwL2UAqDeHMF2NHQ9OTM3lA4kZV+bQ/ayaGOZTrGVo xWsANWDnxV4B/ir7tcy3C9jU8zJPsQXVCfDE5QpfaxeKWxKV6huYBy4Jv5dIGo8ORiwgLZ97nZE I0LCrvLk
X-Proofpoint-GUID: GmSXGLgPfEHSvrMR7s70C2r4WchMX8ry
X-Proofpoint-ORIG-GUID: GmSXGLgPfEHSvrMR7s70C2r4WchMX8ry

On Thu, Apr 24, 2025 at 11:30:35PM +0200, David Hildenbrand wrote:
> On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > There are peculiarities within the kernel where what is very clearly mm
> > code is performed elsewhere arbitrarily.
> >
> > This violates separation of concerns and makes it harder to refactor code
> > to make changes to how fundamental initialisation and operation of mm logic
> > is performed.
> >
> > One such case is the creation of the VMA containing the initial stack upon
> > execve()'ing a new process. This is currently performed in __bprm_mm_init()
> > in fs/exec.c.
> >
> > Abstract this operation to create_init_stack_vma(). This allows us to limit
> > use of vma allocation and free code to fork and mm only.
> >
> > We previously did the same for the step at which we relocate the initial
> > stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> > establishment too.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> ...
>
> > +/*
> > + * Establish the stack VMA in an execve'd process, located temporarily at the
> > + * maximum stack address provided by the architecture.
> > + *
> > + * We later relocate this downwards in relocate_vma_down().
> > + *
> > + * This function is almost certainly NOT what you want for anything other than
> > + * early executable initialisation.
> > + *
> > + * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_p to the
> > + * maximum addressable location in the stack (that is capable of storing a
> > + * system word of data).
> > + *
> > + * on failure, returns an error code.
> > + */
>
> I was about to say, if you already write that much documentation, why not
> turn it into kerneldoc? :) But this function is clearly not intended to have
> more than one caller, so ... :)

Haha yeah, I felt for this case it's probably not necessary, bit of a blurry
line on this but as a one-off thing probably ok :P

>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks! Sorry I forgot to say thanks also to Suren for his tag in other email,
so will say here - also thanks Suren :)

>
> --
> Cheers,
>
> David / dhildenb
>

