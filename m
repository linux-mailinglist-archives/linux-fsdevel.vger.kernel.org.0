Return-Path: <linux-fsdevel+bounces-37375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70949F17E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6081615D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BDA190057;
	Fri, 13 Dec 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sgp7fiyR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YCk9Q1fN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE51DA5F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124589; cv=fail; b=ECwsI4ynsmbfLh+DSE/+wlRcfrxhUcZnMsBQWMD/8qjgSpxSWk7M/vRiwUy1u8AToj2eNX5UqB1Q+QRF4f6u0oLXbogRqzloD+4xB/kujGT6o4/+J968QNTXYAZy+YctSCMp31gi80qfOFQLXCS4vpd2nxphWXzoKS/fu6wZp1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124589; c=relaxed/simple;
	bh=bNZMHhNkD+BylCVBX7MtfvwUttrG99c8m2HLBvLscEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L0lkpBXOE14OOwflNpG+02EtEA007md/hzzDYCA++LFxT8ayBQnYw/IVeJkoUrT8hFTRj8qT8AtIx57idk9ALDNttzHZNt0J+4u4wcoptxzaJPwT+Gyzym/VhuhU0V604bKPDDFY0G8TiJsV/4rtKXPacNesOhmdk2C++1i9TWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sgp7fiyR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YCk9Q1fN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKBpUx002246;
	Fri, 13 Dec 2024 21:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pA0ILCWfRO3x687mnF
	+vS40YgPpK/dvMrRP+5Lg+oIU=; b=Sgp7fiyR0ELwPjxZxFh3WDQyMsnLkjn5yC
	DvTMuOTuPHyLorQSFjjAeT9VjDp6/b0TZ+L9z0tPQn4FgGqYCIlaIWKuKi4LuGQa
	cZJ5R5rXRYuzge5c2ARt5LBi59tIPu7o0WqbEOv0vRJqVXcwmEI1tcb1Au75yf8D
	DP3sJVvg+x6vifEfRjPEs1HlRztOal0OVJaEvjKEiF8Qfau1HGDybLCC8B8Vfcuk
	4z+qBFPCS8nQC4vBKec5Q1h1OCUtNIXWbu6lF5DSxPg+iazGHD4tVcSCCevFN0gp
	mpnI6dBJ4edSXPSL4aFtIf8c+jozZapcWNvF6ein6HiDG5hlDazQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewtef4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:16:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJW7J2008666;
	Fri, 13 Dec 2024 21:16:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcxww2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjsKjBCMJpAfINtaLmcNOQz9bCy3lMPw76oCrtPz/mjOcnHq67OQr+YaOKftShknASBx6xLiKHOPac1IRmjp3cnFrK4+YExuujXcWk0RfEdFQwJfaRM0XnmV2ObvxK8Z6DkUXNX+zXqJJH+qL2xmCM2Jwkh2IQftUBbG7eSnrK+ui0/B+UlUxIdF0ZO0uCQ2D5z38RwYSQrWhfuuVx0qeITbfMpZ7Pxv3WKWNQCxLUO/qJ1ciw7r9Ii/tQREvzJVba46hd1lorSgXIUkK38lmf+9LiE9SBB5dauMfczhqdOUOvzvX/3p/EIZ5Y4wM93gWbDDZAXy5Nas/GFX38La3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA0ILCWfRO3x687mnF+vS40YgPpK/dvMrRP+5Lg+oIU=;
 b=UWIAjcgEcNAVueItlmwEnw2UL2cb0pVtO8SqFI48dbdUclPtp5q7P9IS2VoJ3FUdL3lECOY022O4RKc5VzsKj+5dt9om9HUo9zJGxoIovwrbmrj4ViI+urhLwG4beT/5eMXo3nsMQnD731d0afWO5eRfddH3tWAaHDcLqdornhb52cCQ99gz/+mkIBM/u7lquYIhTEgOXVWQayIv4d2oxJbQWALG74yWgeOMOZP+jsv39AA/rc08fAlFFdLvrUJNLEkJWsuxyRFf68I26Un8sH/tRW3r5oYmM0S+sJOhVI6gXFCUvY2DJSeO7IIJspctxAhCVIfvNgSPo2yk0N/IQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA0ILCWfRO3x687mnF+vS40YgPpK/dvMrRP+5Lg+oIU=;
 b=YCk9Q1fNh8870wdNizN1wzr1FGxqnZaONpJmbmxRGBcIFIiAzc3aIJpJ+Nb52U87+VTyggjdDmLO2hUHmTfR5I0z4jwZHHacWiN48xDVHdqOsg8nBABggbpQVK6FKkcTUr0bx2zzObdUPSzc2MyAcIvSxZovs6GL7vvzPYIWk7g=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 21:16:13 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 21:16:13 +0000
Date: Fri, 13 Dec 2024 16:16:10 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <snresmh32idixvemwjg2bob34nx5jf3a2cm4su5szksoezrpz5@2rfytsaxs4cs>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
 <20241213-filmt-abgrund-fbf7002137fe@brauner>
 <20241213-sequenz-entzwei-d70f9f56490c@brauner>
 <20241213-datieren-spionieren-bbed37f02838@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-datieren-spionieren-bbed37f02838@brauner>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0010.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::23)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 625d449b-fcff-4edf-d256-08dd1bbb5f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+zWa7DVWDbmwe5wtE1+1WVXSqVJCjzzJri64CcxWVBjOwd36Y3cnnGW/cCT?=
 =?us-ascii?Q?5BfBUQ0U/YtiCRTbWCPD7RmhoOjDQYelJhL6o6SxUzVjIr5Hg7lVAldWkmCx?=
 =?us-ascii?Q?PiML1O6J3ObaeSmeG+4LQwHQfGKJeLXJP3grVhS069+ljezszJ4/XFi6iWVj?=
 =?us-ascii?Q?NAHaOH8sSAE/vrrs9KNQ5yfoK0tcXnd87yiHBjw2s0k/P+WWr26LnLDSRHYd?=
 =?us-ascii?Q?SCGqorJ2KmYFkgHQVpOghL/DD6oMGODpVRVK+AzatN2L0P4knnvo6PgGP0t2?=
 =?us-ascii?Q?rztE+y9kRhx5bwABAJKWjWrLdzEgER2/N+Jv+WBuvWqAesYd+f4T6FJgMtYy?=
 =?us-ascii?Q?7YZ5457bGePiJ+HV6trTOKOk7g5hOZQ64JmeFHcEi4MBjtqPlxPGnakFNGqG?=
 =?us-ascii?Q?c8YZ4NXNYryFdRx0X3lP6FsvSprR49ga5wxDmn5eknKhu4bkMP3oQEMkxrGx?=
 =?us-ascii?Q?pDMJLL+6DiM0iFKTA5EQKS3gDG1nGeGPoZqpQ7oHNJmCM41+Kh7nIBFP2Dxx?=
 =?us-ascii?Q?/a3/uixDZ8sNsmmvq6yagVhEpFEh07IJYMl8TMSQhNEcSICwvNwFvEhArMZO?=
 =?us-ascii?Q?BJRuOYky2BeZWqcdg1pbYdnVsS+9mYPn2lf4YtS3e8Jt8zUnOdmYS33tA3GZ?=
 =?us-ascii?Q?5nQW+gkJ2HPSALrfFZQ3wlV7+WOS94T9c7syf4mfwBlGccDP2AldZn4K2UDE?=
 =?us-ascii?Q?aZBu66zOilSItbLYXVtUH1UYOCQPKKl06jBFv1kggAZEQJ0H//uHQoxN+Pau?=
 =?us-ascii?Q?CB/Qtg390yGJvT4agVmw5jFXqaX/ixjJ33s7FRZckO6fRROPvD0EVLGrhNR5?=
 =?us-ascii?Q?DHwovT0Pb3Lyi3YnBak+lDzz2ig78Ehxd+OymoH3faCKixGSzlnezRDtDEmH?=
 =?us-ascii?Q?uBD37ucbbnIeS6ySgAQREz5IgLpAhEkO2zoRPH63GQ4yKt9DxhJhk7wMotLs?=
 =?us-ascii?Q?FpczCv8UCwOcFbcrzLnZAskaIh/0KMgdqXcm2KTs+3DhgmZySXD1rt4H4zdt?=
 =?us-ascii?Q?vUup2vtjI8Vn4rceN9Ftr51lf4RnCBTqYADWHF5h09x2QmRWLBkqHLtsvD8e?=
 =?us-ascii?Q?KEBmcPq10PQiGE7NOd44GlX6vy5/RXp57KaFmhTxBDmMFTgcpaS/DHaMacCR?=
 =?us-ascii?Q?4yK6KWzlIjOR5O/Y6lkA3DJVub8WOuYjtjhT/LeiTliqrMSFnQMZtMoCRmpW?=
 =?us-ascii?Q?TN+DsM47DoLesFg7ylLLv2a7ITTwVhMnWMgjYvWifLO/fNNfrcAnGfne7dZQ?=
 =?us-ascii?Q?qVG6W30oEiBff9dLGMPq+T75PltwVEkbVHSfYdTr1AHrSLvloB4CiSAbf/0v?=
 =?us-ascii?Q?ZF38iYa4Szk3EKkjUVs32zGmmcNFE4xfB7DtYkLtfThZCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rs8qvu7YF3V1wP+XYG3K8peA5sDkXLCLyWjaBGLDfcnHO830KT7b+F8aLU8/?=
 =?us-ascii?Q?FmZ77mdelBuXuBAfPtITfBnXiK0ir1PQN1KLbG3o5H261Kx2DjiPmW4lblPl?=
 =?us-ascii?Q?W8qubnxmp65p05nRcAAdK+jz+9v+wsu2OR9l15UOyJHkvsb3iR4D4uIo4awL?=
 =?us-ascii?Q?szLnwBOxJFEkZZEQ+kOg4LYupXc9E9LycRdTHl6hjX3H2pggD6tsFNuSKPSj?=
 =?us-ascii?Q?kP6kV/QtXVPj3sZz2gRnr020XTdd+fdA2KIUzV6wd1n8Fh0fCbPqjHnUujh3?=
 =?us-ascii?Q?GZJR8OqTw5bd+d4L+zOEoRWYpJlOv8pJ/x3EvMeiM2JoN0N7hv5UbJ+BekeY?=
 =?us-ascii?Q?kqFe4oc24z2nE2OQcqipPEyiovTiWRzJSCnO19uuTe3s1OooL2GT/XmTBSu5?=
 =?us-ascii?Q?PrI3htL0DG0rpm/gXJ9zs3Es9eOeiknlpvs3SmLrGnKxv/4bnPWn8Tqf8vyu?=
 =?us-ascii?Q?Xo0yxUfDPrIjhiQuvpeHYW4H3jCqRQy9RArRRuVpLGg7mUPvw0dm8XBYizVN?=
 =?us-ascii?Q?ZzysWJWXWn8kKsbCdMguPLOLTliPZRiLiCMDyrhnTPtGfuOkxx5rVXbRB5UZ?=
 =?us-ascii?Q?w24svU4dbN+FyfnZlf6TKfEX5PjhfsR57GFH/dlsWjFBWs6RjO7qFWNwNUW0?=
 =?us-ascii?Q?3mEZdha5If32HeRvliywt0gqtOhljteRyZMQ/8MVeIW5EXv1/yFRv54VvzbG?=
 =?us-ascii?Q?cTrdcBKGgqYbPS7RQy++RgzlFYihBSAqaSpQiMunSYejSgpWgyEqArtF71ZC?=
 =?us-ascii?Q?+YBZS0Kj5RE3vSwunzvmHQCJOk+KoDCOI5IchFGgmcBxc2MHqgN/tz9Xmn2N?=
 =?us-ascii?Q?2y+vEK4uCD4MRdYsKFpgl8DJOx+NunFL1ldr1Xpo9jKN4e9niH6h8ZleW3S0?=
 =?us-ascii?Q?wp9DBQWRqd3dQ6EZsPRT33KFG8rNYgDRWGJ6ClVb38rprcvkrrJSl6gw53RG?=
 =?us-ascii?Q?0or2sg0Ca01xtdy2GDpjPmZTl6orjUcS3xnSwxT3Hh1x48NxxBOoU/5GOvzq?=
 =?us-ascii?Q?11+L4DRIVpYctv8ni7vPNqg9H62IwqSJPXvk3n0vT4QxL/rS/4i+DyB5oQwH?=
 =?us-ascii?Q?eJW6AIa+cs6z8dzmtaiCjmUEav59VJn7/4/FBsTRidj/t5KdDZ+VdiBwHBt5?=
 =?us-ascii?Q?vASonzYv381FEV0ZymFe8l++C46w8KrYpeCDioCTJX9vbaLw8wguxybq24Cd?=
 =?us-ascii?Q?Y82hcALBvF+R8HsTrProCGQDe+E4FBt2Ratd/+ass2s4zHdfhN8wA2S44ppK?=
 =?us-ascii?Q?g0MFpt5N7ULSm3t9+2uGw/eY51bqEw1uzMs8tR0NZVagiIHZaCDLXOnH68vs?=
 =?us-ascii?Q?LmVOahaYIym9kzJc+HuPV7hhQbiVgHaTZgGD9buAE3Uyqqemjx4selorVUdM?=
 =?us-ascii?Q?v205SXVgbWfuHXM+zKM5cT8IC+9ZHNwRwJNinoz3jNGNZUhhpsGv9tQSKzc9?=
 =?us-ascii?Q?q8CjRjlQv9x1IxYLHSowGkfefBh05Ht9RocJLn3KdgfC3ZLETar029czB0Kr?=
 =?us-ascii?Q?ak9q6IfzAwTT5LfcrFN40WiC9k/fW9mCqTuH9qTdXMsZOqt1pDGsqV4tItCv?=
 =?us-ascii?Q?YUedBi5xpOmJtJw1sSDFcGdrUh6/JHjfu2mmSfsw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EvAi/vZm/yoC/Wr7Xdq8UXxejL/tw8DFFc/irxT6Go7TkK2Rd6xYTIh6rvI6IvMl24Dz1lnJIkx+qY6fLWMxryAfYkIxFrnxX3/iMzrGb6Yebk/2XeGU8vBgJLVjitWwifohdbL9UoSM9HDCh9tJ526sc2KiHP1RUAUIY+0rHh3yFNGsBiKxm6Vo1sulk69c67ieZQn9dCbk3Vl9PAVsBIpRA2mtu32bct5LCu3DZP0k3zzltInGelvGsXLZj94vBgmgyJFkrIBpBmqbJuczeZGwVSiwid9L87vObOPulyC6oEcu8ic/FfWpXOaWBWOdGET6GLzBllg+2Jgk3aJnijS14rE3azSIobZaHqPYbD2ivc3KUsxWtynD/q5PDUuqC2+H8/7vJJ9uU0B6aX5wEtSapwRqBWcV73e107W1MHGLojmijUU0YOZJemiLVPKsQoFoUmVt2HgO0whkq25lIvf7IhRxDfmvEFdcqXewZrKzc28feuR3mircUG/F3TNxnamHtHCv3jm9ARVsnHPivGqNRqXVsh8WTx9y3CyDtULUj04SGCHdjOjEs1JeETbyWHF4IJMK9L1mW+EYe6vmSgndHbw01zr8HCJ9B/2xb4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625d449b-fcff-4edf-d256-08dd1bbb5f4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 21:16:12.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0g3xbhsx3UXVhzaS2j+gKf8WRekQH9nOnhB03awvScbdiTltuPb5tYOCrbz9hv88sOQdPlJrdN0MgYB1J71Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130150
X-Proofpoint-ORIG-GUID: lRE1zcRfFhxmq9fxkbN_L3e2l7yeGuyC
X-Proofpoint-GUID: lRE1zcRfFhxmq9fxkbN_L3e2l7yeGuyC

* Christian Brauner <brauner@kernel.org> [241213 16:07]:
> On Fri, Dec 13, 2024 at 09:50:56PM +0100, Christian Brauner wrote:
> > On Fri, Dec 13, 2024 at 09:11:04PM +0100, Christian Brauner wrote:
> > > On Fri, Dec 13, 2024 at 08:25:21PM +0100, Christian Brauner wrote:
> > > > On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> > > > > On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > > > > > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > > > > > Yeah, it does. Did you see the patch that is included in the series?
> > > > > > > I've replaced the macro with always inline functions that select the
> > > > > > > lock based on the flag:
> > > > > > > 
> > > > > > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > > > > > {
> > > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > > >                 spin_lock_irq(&mt->ma_lock);
> > > > > > >         else
> > > > > > >                 spin_lock(&mt->ma_lock);
> > > > > > > }
> > > > > > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > > > > > {
> > > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > > >                 spin_unlock_irq(&mt->ma_lock);
> > > > > > >         else
> > > > > > >                 spin_unlock(&mt->ma_lock);
> > > > > > > }
> > > > > > > 
> > > > > > > Does that work for you?
> > > > > > 
> > > > > > See the way the XArray works; we're trying to keep the two APIs as
> > > > > > close as possible.
> > > > > > 
> > > > > > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > > > > > as appropriate.
> > > > > 
> > > > > Say I need:
> > > > > 
> > > > > spin_lock_irqsave(&mt->ma_lock, flags);
> > > > > mas_erase(...);
> > > > > -> mas_nomem()
> > > > >    -> mtree_unlock() // uses spin_unlock();
> > > > >       // allocate
> > > > >    -> mtree_lock() // uses spin_lock();
> > > > > spin_lock_irqrestore(&mt->ma_lock, flags);
> > > > > 
> > > > > So that doesn't work, right? IOW, the maple tree does internal drop and
> > > > > retake locks and they need to match the locks of the outer context.
> > > > > 
> > > > > So, I think I need a way to communicate to mas_*() what type of lock to
> > > > > take, no? Any idea how you would like me to do this in case I'm not
> > > > > wrong?
> > > > 
> > > > My first inclination has been to do it via MA_STATE() and the mas_flag
> > > > value but I'm open to any other ideas.
> > > 
> > > Braino on my part as free_pid() can be called with write_lock_irq() held.
> > 
> > I don't think I can use the maple tree because even an mas_erase()
> > operation may allocate memory and that just makes it rather unpleasant
> > to use in e.g., free_pid(). So I think I'm going to explore using the
> > xarray to get the benefits of ULONG_MAX indices and I see that btrfs is
> > using it already for similar purposes.
> 
> Hm, __xa_alloc_cyclic() doesn't support ULONG_MAX indices. So any ideas
> how I can proceed? Can I use the maple tree to wipe an entry at a given
> index and have the guarantee it won't have to allocate memory?

There are two ways you can do this:
1. preallocate, then store in the locked area.
2. store XA_ZERO_ENTRY and translate that to NULL on reading.


