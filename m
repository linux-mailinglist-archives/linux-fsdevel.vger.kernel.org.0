Return-Path: <linux-fsdevel+bounces-36376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68C9E2A57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FAC285F67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F5201006;
	Tue,  3 Dec 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C0nKvadF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENpe6prf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AE1FCF72;
	Tue,  3 Dec 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249162; cv=fail; b=oMJYSQRkPaRRDUaCWpPJmFO4Yq906agt8xAueA21BJR9TZRsoNXfMJox3wdmsgb41M1l11kU2nI3jH9mpQxSD57GDb41xiwn1Afuw/TEqPde7vTzi0ZO1vOX1F0bvP7vFOrRNl8eT6DXcEtYGXpGx8Io4dC5CpF7+ZVWOghtxSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249162; c=relaxed/simple;
	bh=S1B/Mml5yLlchv1TpVuq1OEvpxY88r+OaxSQMZEBufs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aese9UZLC5YYgStpqJz+AQMGTa/hUrsAh/C/1SjQs5+eewMsqF8DMW4WLmZb2L6mCIDjRjYZ9XQMeBmRcH4TknOWBbQb1raHCaDD1LXHGYk9G9ZfGrQf+DTzMgfvPy9cUpVl69XqxNuN6rXHaJU88vxQDYtUb7TE1BR09A3ArmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C0nKvadF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ENpe6prf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtcAA030390;
	Tue, 3 Dec 2024 18:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LQR0MlY3DN6I9QkGWPkfUs2y6O6Dm9f9JD8+KM54Z/Q=; b=
	C0nKvadFInBxmb6ZM3RJe9ZhpohZkepq5I2NnZ1zaa48qKslFcVRy6CX0qtpL5GN
	1x6K1bIS59DKKAOTP/iil4fS3SGQQk6EU3KoWbPgLWZruxz2ImFPNIhL8xtJNaEg
	jBkQQ0vkoKM5vg5rSsEDY7Zp1rseITyNuiGX95J/P1mIKDr1a0Wc7vJQnZsKLCSV
	/UXe6CbvGnUU63TNPeQbqX8UsAJxzUpUB9YvefunsU7Y7JJZT982IjHFHqPqbiVV
	QE4M/plLugxZcFnkjoF4D2Vn/BS7A0plsAlCbD1qqhhJZdMUjBKbF0k6eUFf2/dh
	H+nbxO2zj+SOirCGlwW5QA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas6n4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3GT4YD031378;
	Tue, 3 Dec 2024 18:05:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836u8ge7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtPp/KaZFwbhcjZeAKoPgv6nFIjTXyyrcpYQypcQcE0vHMTY0txNxo1Un0dhyDhe4tnhtMhwyI6w87/fu0A80rYMfWTGFCc101GYpvF8vgE1e7L4mqfQ/EpHtpODSYchjPq8Rf40KP2KK/7p7n8budjm9SPMCTe8rKLEZl3DjN/7qc89ut5klAaMRdJKfqLMGrCgAUZH2lIRfTk+UKbINHVercRHMDtOUwNQoktE9N9jKSuHuRn77F/GrIOPZmKyYrOjU3oLnqD6tiqVVM3x7rAvuUObMgJVoZNvy3lFUp5OeTspWPyvT/ScDsE7yWJHO2lWOlnqxURlQY9q2QLFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQR0MlY3DN6I9QkGWPkfUs2y6O6Dm9f9JD8+KM54Z/Q=;
 b=WEiRIEfUEc7sO3hkscx1FWrGGQiFwSZr3Am4kRpLIF2GSiiTPkQV/JJlcXzXaWHsYdZqh0x6o8mJC9gnCyVEVVe7beWtbeS687qHxtL1ZcUOHROJ4nRQtBxH28DXEIFtf973e4h/Y2DXwiXODj0yZLbbVeDm41EGwaQgxr0BI0cW0kTRTNzUWh3hoQF41jPDL4HHDjUIpLGo1GwXdolkrMJRZ/3NtrR1YLbioeG6s7vtmwqrHJgULuuFOgVkOUiFRBav/ZQzOTINZd1+LKwpg3KtMk2h29xezS5xBinL1qNouEKH7TVN0VaQIV0UAWC+IrDptzwWlVWcg7moa9UyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQR0MlY3DN6I9QkGWPkfUs2y6O6Dm9f9JD8+KM54Z/Q=;
 b=ENpe6prfQjcivjCc0eV4TaRgeootnb34VnJ353KWPhsrDW9lfNO4XcRaEWTTJQdacTSEtM/84tw1GSIKoUxxVTblUk7nv0DV5FrgKpeK+Mzoaeld9EQIVaxjngKv2zLZ1Myb6G+EC08wiZGs7pkJp8T0oIbVVYCOy/LaDiOG0yk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6762.namprd10.prod.outlook.com (2603:10b6:610:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 18:05:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:05:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm/vma: move unmapped_area() internals to mm/vma.c
Date: Tue,  3 Dec 2024 18:05:09 +0000
Message-ID: <53a57a52a64ea54e9d129d2e2abca3a538022379.1733248985.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f13595-baee-447d-8a23-08dd13c5146f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICsVShJ5xoO5eb7w5vOEl2LgVGvh+fELOWx7haX0pVg7hcK/DgiUEYqH8Pan?=
 =?us-ascii?Q?WD8tDq1HObhdjQ3/n7equWnJJb0AuH1hw3E1TdYp68mdEzioUvsRJz5k2DMk?=
 =?us-ascii?Q?vpbCjKzN3medIQ3nh9+SEDa9lhBXoEzg1JGAKxiJ/G6Z+T8nTkveCqG+fOt0?=
 =?us-ascii?Q?TJQzWgOP8tVX8Ud15vQ1O5DJ52OeFv93iGtwy+ALGQ4rcHRHnQbzrcAGGlw2?=
 =?us-ascii?Q?/mHsQWokCd7d5MfZjWMjCLq7DKamKk7Lfc1EI735Wt4g0vQkCgFiQR5ZxEcA?=
 =?us-ascii?Q?IGArMaoKx0ZhAO+JTxeNZWi2PNmI1rdKusiYp9/kJYX13Q/x2tKpG6n5RcEK?=
 =?us-ascii?Q?9mmFDUAluox+KDmWojZLYxojCgjaflZfULvIUnlRGcl8pcOPUspbawDtsqsx?=
 =?us-ascii?Q?xKZ1v211JaGqcUZupTEGrAyKb1MZD10kIQ6nXP9m+8w57mfsIp9CVHpho7lT?=
 =?us-ascii?Q?eL/yHAxVkJSJ7ZodAXemx8H7MboVcrb+oN9DonMxYuf35yRd4iBZhXGZWbAS?=
 =?us-ascii?Q?Xqrtuwl1ktopUkeZCcg5UHWnQP4oFUK/GXSJot8Et+Plrh/xA1hxY9qyceTd?=
 =?us-ascii?Q?q29QljcdqbDnZbGPDMSWY8dusRk/qOrEytEyrRnYQM8qwcKqCtzYdYMfbjK7?=
 =?us-ascii?Q?jp7Ddo+9xMySuw1y4X95jPsx9mNjnSeeE2pL1Em4IkQUtD7TDgkQIaUsJJnU?=
 =?us-ascii?Q?GRvPv9DupHqyXTI7wfxbaCI1Gk/uHOGf9uiAXNKnJNy3Fx0EdbklBUIOYVGg?=
 =?us-ascii?Q?qaYcdz2i2kx+VuHs9PmaEstnXeZgAHdgJl9eZajkdWEoBvxB9BFt855nHRoB?=
 =?us-ascii?Q?NkoY73lOq3h9dLFulXj+lkk+MTJ4Rbi6HLT6kq/ZSCkM7P2XFscb/J7+cZHE?=
 =?us-ascii?Q?JdWWxomnTc5YPZw/W7dcfkxxFkLeOGlkj3Wrlb3A6SMzc4oEszl1tnxjGKaw?=
 =?us-ascii?Q?gyJ4xyipbcj/yaQ801Ku0Ib4+RYOY7KhgwcI6/y667U2kZn8LlXxA02pZBEc?=
 =?us-ascii?Q?jel1hhsYmIaZgPXWRD1xgBxr/+PDsstSYrQg3qz6r4jr31NophK2Hf2rRQ0A?=
 =?us-ascii?Q?EWvWYnjsBLvItAwxPIyuoBGr9B+pOUj6TcPDe5PpliOGeNzvXPnHk/hEOmfP?=
 =?us-ascii?Q?uCq5FeqxyWG+VWOZeO6QspLkF5aETheETt1QUII3X1Ab4J8S8HlCgTDOgwQ8?=
 =?us-ascii?Q?14MDz5QDfIUU8WIXVgGfm+iHGZeSRoFDerUXKW7w48zaw4H2/FPUArdQLxP+?=
 =?us-ascii?Q?0gYc3C0zvxdINHRNedIKgfX/ro/f1f1fPLK4WyN8zIHFAAqczeUsdC3NnotM?=
 =?us-ascii?Q?xgsRDygcqKLuBuMXO5bT+AcnYQ+vQjFHhLjXknNKAPRZJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmhS/KZyXdT25548PPgG+650iJteWwkaISXzbcH0ARddxPdGop/IyH6E2A08?=
 =?us-ascii?Q?fI47zM5kTTocfYKwyXcLkYIS+8DWGuIUID6jQUzIfjSNO1E0LdZ5bPlde66b?=
 =?us-ascii?Q?NNinGTSlQR9Ebe8vC+B73HOBJ7vMpsYfG4paYdHosFqqibcbaQloWqMQTPZL?=
 =?us-ascii?Q?/6+vhMcMnwuwfADT4hOYdoLpjGwi281mYujphAMUC+kmWdO/P0v3iRcVexir?=
 =?us-ascii?Q?a8TLSoPnXrPO/OhXtUDhV+YhCFePBS1uAQ5nTpaXRWKOHxQh9PyUqipr3r2J?=
 =?us-ascii?Q?Z0dsOScma0ZE92GDh1MlfVufgUg6L2TFSEQ3vs8KztgUufi6MKLl28VQlKUd?=
 =?us-ascii?Q?dyGDizVQ60jj+4y1++gWncWgqxVMZ5OduqiD7eTtBr58Fv4omMjcyMnrkcLh?=
 =?us-ascii?Q?Vq12z+iDlLQRF8fsrl2h+8UX1OXCcUQcFCpateqYL5S9/h1BPR3R1uAnPH4I?=
 =?us-ascii?Q?WEyvu12isI/6DE5zUqdXJArkJwb56w7HYconknCfCu4RcKqjkjWWwMrAshHn?=
 =?us-ascii?Q?+TczWf7g9xvrRgeGifJmuI/YNoY/PWjmpcR2bEAGsJ+ezUqNIT7SCg+qqZyD?=
 =?us-ascii?Q?JZxzR6UbDSGGtfWZjwzVTn72PDrnthmoZjP4NpvttINN5Mz8Jacd89VhN+Es?=
 =?us-ascii?Q?Z6RtRZeXXr2GOKk595UsfUBgl7nGtbKprmx171cjs9nh2AscLax1vFA/NcPP?=
 =?us-ascii?Q?f6/ZiKD9kOwwhzmz8l80iP5N7YDag4xPHMvLamyiVzDWZrvlt/i+ySm6S7O7?=
 =?us-ascii?Q?OAELKurE3Sie0k5xjEXuqrPl/+DpOWhnw7XfQ1lQx8JmqGa378Vw+mvtSMKI?=
 =?us-ascii?Q?HXWXimDITI81Gu6XOyUTpxjwiMa6f3d4WsnydVxGhPFM3pdRxT6jxshmOdJE?=
 =?us-ascii?Q?1LzD2uXArUvVjawD/YBWhsJ8UFEA2Gb0rhsVpgPyMs7FJzklMKtYN9FR1AEP?=
 =?us-ascii?Q?NhzO/7wXHoqk4zh921L4k/nJGJZF3dW/5rkRrbeBSmES9ATdTYJdVFsqbMQ7?=
 =?us-ascii?Q?jiN7mAF5WT1w4OCNn/1ZL5KJ+Z6Ui3cOynhZTIEbF5FBWfPvM9mv+pctY345?=
 =?us-ascii?Q?ZCfnF90QXIF96Xsmuy4XaCG8Pgh9430UndV/m9T6s3JEGg0IIibPQ7zV3b2G?=
 =?us-ascii?Q?K/ke3tfhVct+VPNBPLkQJ+z836GmfCF+Ab8F/FE3ZitVjK0vqyjdtRLUWjcf?=
 =?us-ascii?Q?QCaELmrdklNXkrCMX2pMtUrVrO71GwPA85YiVxmzuGgdVg3tjXBaQ1wI09gh?=
 =?us-ascii?Q?V3+9R0c3QaBdfoXIXkt/hCorVogDkYQhlOK2XMs/kUJpM7szCgUPAyqzPtJG?=
 =?us-ascii?Q?pE6g2wj3vNrYM1jyVV2zIZJSm0EQsDDeQqMWEmes7m4C7WnqI2IOLkPkAsqw?=
 =?us-ascii?Q?9/B6RpBsSr0zhxL8zU9mVyKdgAxqHDftvXbVstSlCBeofUgkKUyPTeZaVIaS?=
 =?us-ascii?Q?N09amQIZhMpvRs5uf4DvbHQkEXp/sw57bmbo5dIzzPSOu6o/UeUDTirHzNzz?=
 =?us-ascii?Q?0FbR1zIAe9eb3OYvYR6r6k0yZ8jqlGRGEh75qIurn3axiClb1CXHfIihUlO1?=
 =?us-ascii?Q?WsINIpDzWQ0dWT7QpLOBL+eZJIK1kG7f3Z6CJr6ZFyobw8JYo3Svrhn+DM79?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IDa02bT/8L4pMa9RphvG3AcyV3WhdtfzZYoX6gFrPNbpdXt02tZPPGCAmPNVKBrCwbeBy4t8ucewK9IBgEswy50eJqGw5EhwSVO6nlQPMxygb+PYZIkIaxjCJFzfV5d9Xqbz0UH0TZr5CFENuxwCCLPxk2U7+jInMGT0lHn3ck1IXvqlk+9RgCn7DCEHL5r6c9Q8Xu25gksY4Y8KP7S3mwSaKWk/5zmMMw+eL5dHo1ZxYA6DmIexDB1jayAS2FLlF2mpGDkcE4ggYba/kdWwU/mxanU0EsOUvqXi860c42JOVYJUP3Xt68t8DvdhQlg9B8EqkGHZPL5YmFvOoxuQ1HwH02PB6vr4afETNWLVs+B8FaQuziQUB6n6Ot/SJ913bL3XB1VHtPS7xzjKgYLl6YLNCbk1XO5dkxAL/b50Poqvzsnx7dQEPl+ILJ9w5b5hgIiQIeS+hMjoRaAhdjhl8OfbExJ96CjGK0jqhxKn2l/McxVy1NwDQDU9qGLouIu02Sxx0Haqu2GIHfaMLFduiti60vz4O09fbUnTUMhmoFx0RcnY1L4Dp9J2TNaSEXwWo56EwwhyzNI2THjqnk5eHeFZ+rsvkFJ+3gmNKSBiVoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f13595-baee-447d-8a23-08dd13c5146f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:05:33.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvQIeyqxOPpalGPvGV43fntbeAvTG4oB8C8pvpBDQqb55Rn+BDFpKrf38GDECq5qc3tbIRXVuzEEEule+iWk+clfJQjwTYokTJjuVIw09yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_06,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030151
X-Proofpoint-GUID: qndHoWZXSMVnuKX_pkRmQP1wbk7I9NP1
X-Proofpoint-ORIG-GUID: qndHoWZXSMVnuKX_pkRmQP1wbk7I9NP1

We want to be able to unit test the unmapped area logic, so move it to
mm/vma.c. The wrappers which invoke this remain in place in mm/mmap.c.

In addition, naturally, update the existing test code to enable this to be
compiled in userland.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c                        | 109 -------------------------------
 mm/vma.c                         | 109 +++++++++++++++++++++++++++++++
 mm/vma.h                         |   3 +
 tools/testing/vma/vma.c          |   6 ++
 tools/testing/vma/vma_internal.h |  59 +++++++++++++++++
 5 files changed, 177 insertions(+), 109 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 93188ef46dae..f053de1d6fae 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -580,115 +580,6 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
 }
 #endif /* __ARCH_WANT_SYS_OLD_MMAP */
 
-/**
- * unmapped_area() - Find an area between the low_limit and the high_limit with
- * the correct alignment and offset, all from @info. Note: current->mm is used
- * for the search.
- *
- * @info: The unmapped area information including the range [low_limit -
- * high_limit), the alignment offset and mask.
- *
- * Return: A memory address or -ENOMEM.
- */
-static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
-{
-	unsigned long length, gap;
-	unsigned long low_limit, high_limit;
-	struct vm_area_struct *tmp;
-	VMA_ITERATOR(vmi, current->mm, 0);
-
-	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask + info->start_gap;
-	if (length < info->length)
-		return -ENOMEM;
-
-	low_limit = info->low_limit;
-	if (low_limit < mmap_min_addr)
-		low_limit = mmap_min_addr;
-	high_limit = info->high_limit;
-retry:
-	if (vma_iter_area_lowest(&vmi, low_limit, high_limit, length))
-		return -ENOMEM;
-
-	/*
-	 * Adjust for the gap first so it doesn't interfere with the
-	 * later alignment. The first step is the minimum needed to
-	 * fulill the start gap, the next steps is the minimum to align
-	 * that. It is the minimum needed to fulill both.
-	 */
-	gap = vma_iter_addr(&vmi) + info->start_gap;
-	gap += (info->align_offset - gap) & info->align_mask;
-	tmp = vma_next(&vmi);
-	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
-		if (vm_start_gap(tmp) < gap + length - 1) {
-			low_limit = tmp->vm_end;
-			vma_iter_reset(&vmi);
-			goto retry;
-		}
-	} else {
-		tmp = vma_prev(&vmi);
-		if (tmp && vm_end_gap(tmp) > gap) {
-			low_limit = vm_end_gap(tmp);
-			vma_iter_reset(&vmi);
-			goto retry;
-		}
-	}
-
-	return gap;
-}
-
-/**
- * unmapped_area_topdown() - Find an area between the low_limit and the
- * high_limit with the correct alignment and offset at the highest available
- * address, all from @info. Note: current->mm is used for the search.
- *
- * @info: The unmapped area information including the range [low_limit -
- * high_limit), the alignment offset and mask.
- *
- * Return: A memory address or -ENOMEM.
- */
-static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
-{
-	unsigned long length, gap, gap_end;
-	unsigned long low_limit, high_limit;
-	struct vm_area_struct *tmp;
-	VMA_ITERATOR(vmi, current->mm, 0);
-
-	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask + info->start_gap;
-	if (length < info->length)
-		return -ENOMEM;
-
-	low_limit = info->low_limit;
-	if (low_limit < mmap_min_addr)
-		low_limit = mmap_min_addr;
-	high_limit = info->high_limit;
-retry:
-	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
-		return -ENOMEM;
-
-	gap = vma_iter_end(&vmi) - info->length;
-	gap -= (gap - info->align_offset) & info->align_mask;
-	gap_end = vma_iter_end(&vmi);
-	tmp = vma_next(&vmi);
-	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
-		if (vm_start_gap(tmp) < gap_end) {
-			high_limit = vm_start_gap(tmp);
-			vma_iter_reset(&vmi);
-			goto retry;
-		}
-	} else {
-		tmp = vma_prev(&vmi);
-		if (tmp && vm_end_gap(tmp) > gap) {
-			high_limit = tmp->vm_start;
-			vma_iter_reset(&vmi);
-			goto retry;
-		}
-	}
-
-	return gap;
-}
-
 /*
  * Determine if the allocation needs to ensure that there is no
  * existing mapping within it's guard gaps, for use as start_gap.
diff --git a/mm/vma.c b/mm/vma.c
index 9955b5332ca2..50c0c9c443d2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2560,3 +2560,112 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
 }
+
+/**
+ * unmapped_area() - Find an area between the low_limit and the high_limit with
+ * the correct alignment and offset, all from @info. Note: current->mm is used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range [low_limit -
+ * high_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
+unsigned long unmapped_area(struct vm_unmapped_area_info *info)
+{
+	unsigned long length, gap;
+	unsigned long low_limit, high_limit;
+	struct vm_area_struct *tmp;
+	VMA_ITERATOR(vmi, current->mm, 0);
+
+	/* Adjust search length to account for worst case alignment overhead */
+	length = info->length + info->align_mask + info->start_gap;
+	if (length < info->length)
+		return -ENOMEM;
+
+	low_limit = info->low_limit;
+	if (low_limit < mmap_min_addr)
+		low_limit = mmap_min_addr;
+	high_limit = info->high_limit;
+retry:
+	if (vma_iter_area_lowest(&vmi, low_limit, high_limit, length))
+		return -ENOMEM;
+
+	/*
+	 * Adjust for the gap first so it doesn't interfere with the
+	 * later alignment. The first step is the minimum needed to
+	 * fulill the start gap, the next steps is the minimum to align
+	 * that. It is the minimum needed to fulill both.
+	 */
+	gap = vma_iter_addr(&vmi) + info->start_gap;
+	gap += (info->align_offset - gap) & info->align_mask;
+	tmp = vma_next(&vmi);
+	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
+		if (vm_start_gap(tmp) < gap + length - 1) {
+			low_limit = tmp->vm_end;
+			vma_iter_reset(&vmi);
+			goto retry;
+		}
+	} else {
+		tmp = vma_prev(&vmi);
+		if (tmp && vm_end_gap(tmp) > gap) {
+			low_limit = vm_end_gap(tmp);
+			vma_iter_reset(&vmi);
+			goto retry;
+		}
+	}
+
+	return gap;
+}
+
+/**
+ * unmapped_area_topdown() - Find an area between the low_limit and the
+ * high_limit with the correct alignment and offset at the highest available
+ * address, all from @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range [low_limit -
+ * high_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
+unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
+{
+	unsigned long length, gap, gap_end;
+	unsigned long low_limit, high_limit;
+	struct vm_area_struct *tmp;
+	VMA_ITERATOR(vmi, current->mm, 0);
+
+	/* Adjust search length to account for worst case alignment overhead */
+	length = info->length + info->align_mask + info->start_gap;
+	if (length < info->length)
+		return -ENOMEM;
+
+	low_limit = info->low_limit;
+	if (low_limit < mmap_min_addr)
+		low_limit = mmap_min_addr;
+	high_limit = info->high_limit;
+retry:
+	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
+		return -ENOMEM;
+
+	gap = vma_iter_end(&vmi) - info->length;
+	gap -= (gap - info->align_offset) & info->align_mask;
+	gap_end = vma_iter_end(&vmi);
+	tmp = vma_next(&vmi);
+	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
+		if (vm_start_gap(tmp) < gap_end) {
+			high_limit = vm_start_gap(tmp);
+			vma_iter_reset(&vmi);
+			goto retry;
+		}
+	} else {
+		tmp = vma_prev(&vmi);
+		if (tmp && vm_end_gap(tmp) > gap) {
+			high_limit = tmp->vm_start;
+			vma_iter_reset(&vmi);
+			goto retry;
+		}
+	}
+
+	return gap;
+}
diff --git a/mm/vma.h b/mm/vma.h
index 83a15d3a8285..c60f37d89eb1 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -250,6 +250,9 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 		 unsigned long addr, unsigned long request, unsigned long flags);
 
+unsigned long unmapped_area(struct vm_unmapped_area_info *info);
+unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 8fab5e13c7c3..39ee61e55634 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -18,6 +18,12 @@ static bool fail_prealloc;
 #define vma_iter_prealloc(vmi, vma)					\
 	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
 
+#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
+
+unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
+
 /*
  * Directly import the VMA implementation here. Our vma_internal.h wrapper
  * provides userland-equivalent functionality for everything vma.c uses.
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 7c3c15135c5b..6ad8bd8edaad 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -27,6 +27,15 @@
 #include <linux/rbtree.h>
 #include <linux/rwsem.h>
 
+extern unsigned long stack_guard_gap;
+#ifdef CONFIG_MMU
+extern unsigned long mmap_min_addr;
+extern unsigned long dac_mmap_min_addr;
+#else
+#define mmap_min_addr		0UL
+#define dac_mmap_min_addr	0UL
+#endif
+
 #define VM_WARN_ON(_expr) (WARN_ON(_expr))
 #define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
 #define VM_BUG_ON(_expr) (BUG_ON(_expr))
@@ -52,6 +61,8 @@
 #define VM_STACK	VM_GROWSDOWN
 #define VM_SHADOW_STACK	VM_NONE
 #define VM_SOFTDIRTY	0
+#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
+#define VM_GROWSUP	VM_NONE
 
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
@@ -66,6 +77,8 @@
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
+#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
+
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
@@ -395,6 +408,17 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+struct vm_unmapped_area_info {
+#define VM_UNMAPPED_AREA_TOPDOWN 1
+	unsigned long flags;
+	unsigned long length;
+	unsigned long low_limit;
+	unsigned long high_limit;
+	unsigned long align_mask;
+	unsigned long align_offset;
+	unsigned long start_gap;
+};
+
 static inline void vma_iter_invalidate(struct vma_iterator *vmi)
 {
 	mas_pause(&vmi->mas);
@@ -1055,4 +1079,39 @@ static inline int mmap_file(struct file *, struct vm_area_struct *)
 	return 0;
 }
 
+static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_GROWSDOWN)
+		return stack_guard_gap;
+
+	/* See reasoning around the VM_SHADOW_STACK definition */
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return PAGE_SIZE;
+
+	return 0;
+}
+
+static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
+{
+	unsigned long gap = stack_guard_start_gap(vma);
+	unsigned long vm_start = vma->vm_start;
+
+	vm_start -= gap;
+	if (vm_start > vma->vm_start)
+		vm_start = 0;
+	return vm_start;
+}
+
+static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
+{
+	unsigned long vm_end = vma->vm_end;
+
+	if (vma->vm_flags & VM_GROWSUP) {
+		vm_end += stack_guard_gap;
+		if (vm_end < vma->vm_end)
+			vm_end = -PAGE_SIZE;
+	}
+	return vm_end;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.47.1


