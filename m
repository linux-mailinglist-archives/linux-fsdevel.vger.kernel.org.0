Return-Path: <linux-fsdevel+bounces-49452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811AABC7A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441351B64968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414A02101AF;
	Mon, 19 May 2025 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UCndD29c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IMtip1Le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573F1E8342;
	Mon, 19 May 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682085; cv=fail; b=JlO7FiDBtGKknaAEP9UcPXVL+jcH6UYYNdB6m9V9rp0uYA6mO7JgtNlcv68PTjWliM4/XjWdMy7KESv8qvTu5Z3k13jE/aVaEHY3mJwep6l7ryA9Yr7STy3I59xjUC19O2jzO7DS/0+0iXqPENyNb7im0To9IbHsI08rXKQZ61w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682085; c=relaxed/simple;
	bh=fqSRBnPloALhy3d5tRaBauooT7KG7OgMLWqubq2kP0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pqCVIen5H0+GPcDPN5/uSqp83S131Gg5yHBmLHerZwRhpgEn7ZVtB/HOlzqV2jvPGxxzsJkTlfg+mvUTSQdGRAZ/8Vcdzmv34BN3W5m2ywShUNxWh7w5seQ1NzNlYeMuMKXnAkvalN7qTqjk2FbW2saO4Czt2J3XC4ZdV8GPg6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UCndD29c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IMtip1Le; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMr9r028863;
	Mon, 19 May 2025 19:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SjAAxC6y1v6etzw5va
	J9ywl4CuZ5ldyOma2T80AXuDw=; b=UCndD29c5DDOJFDzyFkI2hDbNLMxRrZRf1
	mPsdvC7pu7OZvyUEPmyS3ZZdMAs0XZRpBtmQvm+LXj8r2l8cEx2VkqM7do1L2GaI
	QFXvuRjb7Z+uY50WSBXS9rULPrxTR2/bhiuwhOYNbm28gu3Z8Lhdmi6isFsJuMVH
	nrDyL9Lqqanf1dW1lM4LyDP/epfKVckyvduEnSCRgcKzEtVcmYZ5PN4Y/3/Rccay
	E2D9PNEgrqQcMBTJi+2BPDuT4rqaLI5sZglc8ZJg1vrnpW9uok5AUQyNFBdi2MBb
	pyLUZar9hTIiaRb/vCZp5QLVNqozIRuo0HYjWVMig72NrP+Oih9Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuqsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:14:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIoqvo017527;
	Mon, 19 May 2025 19:14:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7b8n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpjU5NPiqHe41gL63KlZQDMclET8dunj/Mbm3eeAZoLdviQuzoZDaJNjLGj2yyOxIu6mjgCFDyO2EfIdtPMWYEE/Aq/jpLb6x7t0oR93RKLquPqP8hDNcGYZGObm/tx0z7obPOe2fakuJRdtij9+rQuR5DicXSBwoES0mJF6xwUAlJGEhCPWf65TJUj1aSvxC9Rv9jSSWL1I5+qpgQgR539TxGffVcnlOpEnkUhYxm7m4eYecG1xorRK/aajtHWXJUtHPp9j+Y7Gp2k8RzKnZqO6IM6RV8CHZc568+BaH0WO2ehpZINZ94Y9Yf8VN09Y+czs3DWfLxu4DYDT0cYf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjAAxC6y1v6etzw5vaJ9ywl4CuZ5ldyOma2T80AXuDw=;
 b=nvSjcx1Han8wYr6vPcZw5epMgoQh01gyx5M4NyMdt3qxrkQLHmdLRJKWVIvxj8eSOksBs/LlQVVKo9aYRLMpJnoQStrvmUggH0SUwMcFaQEjh+BSgNiUIx9W2jAbMJOLOtlFtkrKfUmqVAesbE3hhK/a1qEuHTSDYtTEc25ceGnMADdg7cdhUfth5F6abzdltz7RTx5Ixs4yPkrlSNdyMIrQqUAlrJXQebEklmC/wtsSrTlqGAFrhnxLI6x//uMjEAgzKjA6w6gGH2mXVs09nnkalcwvIK5/1bySkcxtXTnmAgRLNLAGy2wy+E/auJbPBrsNciqxZjRJBiPrQ5C6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjAAxC6y1v6etzw5vaJ9ywl4CuZ5ldyOma2T80AXuDw=;
 b=IMtip1LeF4OWm4Wa3ieXDgXXRQR0AKhA/9CNmzSUBE8VC8SIVSopt96pMXbknZYBDZzs1O38PhRFWIbHfboKu3e42tsWgKmIpYNIh9oE9wiQ/nMpmGqvoXO18T3QOv1ECKI7zT97YzShtY8UoJ81X9aIk6i1DbF1WLDqd1tXt5A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PR10MB7927.namprd10.prod.outlook.com (2603:10b6:0:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.25; Mon, 19 May 2025 19:14:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 19:14:19 +0000
Date: Mon, 19 May 2025 20:14:17 +0100
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
Message-ID: <fed73be7-6f34-48b9-a9c9-2fe5ad46f5ba@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
 <2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
 <e2910260-8deb-44ce-b6c9-376b4917ecea@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2910260-8deb-44ce-b6c9-376b4917ecea@redhat.com>
X-ClientProxiedBy: LO4P123CA0120.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3720c4-547c-4afb-f0a1-08dd97095ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7w8AaYOEMX64Jg5naEWcHPF9td22YUXPfwdCpecY7J4bghmup2Tkh/5SMfM?=
 =?us-ascii?Q?lxzPGK0wh8Cft6skegXgbeGkk3ok+yxs5ytHjJYp7QcKUQfjLRzFC4YAaj9B?=
 =?us-ascii?Q?cTRYNLFh5OU4btKN2x7FQplK8oTHPtt+3tfGo2Kx8YWnUPWA6LRS2UafzYpE?=
 =?us-ascii?Q?7JM5G69pogwcNrHt6jvOyvoJM/Y039EyxitOERcDXmyuluwc39mDemeLHr63?=
 =?us-ascii?Q?1S6Q4JCIVZQIhXE3VMHEEzLdg9N+ih178OIxIavUN02YR7qU0jj9iUNRGusR?=
 =?us-ascii?Q?kIbH7YXqOY8IuRpaRukw5dKYhO+8/9cuAwRPT7kzpkJAuAIt14mtZQ+nQCsT?=
 =?us-ascii?Q?JQHJrFC3yphWK8IqjL2WQDYUEgHvfewnBoOLHMXpQG8ktVUxqD0o1LdKOH79?=
 =?us-ascii?Q?rrcnDB8Un8wia+pUWHzkCI37oTVf8jWSAaW9a2qQRIXHANmVf4bukX+PIN1u?=
 =?us-ascii?Q?ywTqEPrQvXrNmtMOnbxo52TI3EG9VMnr/7WjwHzDxwTNvA/cvTkEPORnrz1d?=
 =?us-ascii?Q?jIWJwLqQ14zoTmmHZrF5zv+aSDj9nFQTCfV4uRptAg7YuGAleTflDRAwOOyt?=
 =?us-ascii?Q?hdnuIRnm+pLcyd4k2Yn8OL6HqxmzEoZ+vbtNnTgeT1GdUQ3YpuCsl82zv+He?=
 =?us-ascii?Q?sbxzlhDp497IZJQ31BQt82sSQOok0bwLH8AgSNg+KmtYtBcao5dyiEiKWmzf?=
 =?us-ascii?Q?McOH+aYHeeLnpjapsWqGmhx+Ped3oeZI2qeFR+IrGbkUPHFa6blqJBe0KzV+?=
 =?us-ascii?Q?pGkmH3DMdOqajH0e0lLnIfhWIOsuXjwpyE+uCpPjlabwBmoi5Vbpddpp0p67?=
 =?us-ascii?Q?NmO57OIjhEoePq1FUXT2/Z3M0MzA6kRNxtIUspdNQ5E5kAaSK/16yo10MG7N?=
 =?us-ascii?Q?uSImUqVT9sHSYVvcmGdA6CMU9sEVRz88O4IfYoVrR/REyLgcg6p3Q3s0E3uh?=
 =?us-ascii?Q?3XNCOdzBnflEBiHeKxMzOb0uVnBiZcqUth/k64fsa/5kcOoxDB9ptnBV7V5H?=
 =?us-ascii?Q?+Gdxgf7EbTXd4zTisxAGk5nyr/aiZMUvJ8Kw53duPHHCnytgUvziYwOcRnTJ?=
 =?us-ascii?Q?ktp78nuNA9HZMOHFwtpU7iqLRqAGsjx05q7Ndnl9NEuJ7s+fhS/bY35UOiE6?=
 =?us-ascii?Q?I/sV2d3Fh3lbJyFcnJcPPetMyM6OezcGmoU8Iv8l2Hx+T7cvdV2M3W6Oz/sT?=
 =?us-ascii?Q?EUM1rdVb/qdjfUpu46XM5tPnDqr6j2tOwJTETJpYv2ISlkdma/ahEz9DwLtK?=
 =?us-ascii?Q?8ZKGoI5iQkHWX8fUXpvoBQB5P9+fecziH9VU55FnFabbkM7f91JM+gMlsgCT?=
 =?us-ascii?Q?bqpMWaftDMOOjg7XR0Q7v60YEK2Wtfd68U6bwfxiJUhVHWRs1hA0dG5Zmqtj?=
 =?us-ascii?Q?AS2SAcRRSLW2xLyqZkd3brDPNys4afldE5iy/G14ANpvqZnSYPA1tM0PFjtG?=
 =?us-ascii?Q?jwVkFgDco+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIR+zlNWwHxQhcYu3msu6q5+LopIkdJXOtjErMrgy9Q9UwHw6BRjoXT/krvB?=
 =?us-ascii?Q?DpPovnVKxbbM5TMvreUF8XwqD0/h3i/jyy4xRkn4K5G+YJYHVYmFIlX608W7?=
 =?us-ascii?Q?qKZ8QK3S3EHqVVp+H1kefs/lPkEXLusLMCcU7UvYrXlqWl3FSE8kUarYF2EH?=
 =?us-ascii?Q?lvHgVUuxfK9Pt+DhPqngS7X3wcDQVaqYSz3ZJAvIJu6lH6JgPPgfjmMHN/oS?=
 =?us-ascii?Q?iqifyXuZUAwqFuwsR9zE+HCT88dVITI2GYm7ZjOwTFsjS1lG5TWp9IX42Amu?=
 =?us-ascii?Q?BMD3yzunFSNwghWRaGN797fJGmTkA14Xw9C5NrahahfkQBYMQOL0VlvmrOa/?=
 =?us-ascii?Q?uTP5zxLy/WDRLJgPiDrBwT90r0r5SZbn30Y+zMr1LIqT9wFjpKMk5xPHeNJ9?=
 =?us-ascii?Q?C9vtDi7r0KZTsHCQRXF5Gl39DFoPWYaEpE7iTmJ7761Ion/eTZNXD02x++Lu?=
 =?us-ascii?Q?nR+gBh8Amuw4ug0+RF74jUjbqeR8Kr4FFVBWfmlGq9k2Tohw1c5qIR+wwxBR?=
 =?us-ascii?Q?PqzmIbIofaAo9SENplJaio2ccs+FTyenMmJ6ULpAtsvNMjTxGsrK4Bwtt9yw?=
 =?us-ascii?Q?UChF/LZ9n+ewpurkI8DbxIEjBMs5uRjlB9W6i6FQrHuPVstXE9ket8pdTUuS?=
 =?us-ascii?Q?JOMSANCTVUVjFqG9o0ZJEGD0X9IujZf92f7H7ELHQDgRa/+ePPJVURs7C65Y?=
 =?us-ascii?Q?g+Noywn1p86Ru4OjnQB6ifNQrh318RhPInP5Z2Keli1AqiWnDw/4Povo5g+T?=
 =?us-ascii?Q?KZDjleruj9cuJ9BtdjnFV3ge9s+2fPH4M+gt9hkRdVZB8QwLvIgG9LW9TO7c?=
 =?us-ascii?Q?OSxOr7KH8VWLR/kUF1ui65UVkM7foc8DQKGkR28/iMsQOU3Ms4WWdcZOBUb4?=
 =?us-ascii?Q?AMmRqp8u0m0zPvYijM2mbTOs/7Wdyjh7cP9Cdt4Db/O3fgdtpuUbuHriFk++?=
 =?us-ascii?Q?2bR1bPpD7th9NpMMUG5mgXzgVMiW8+jnDpkvNTK+hPMaiD/ANaWtoefRIHs9?=
 =?us-ascii?Q?Qw9r1DxtvUT3Z8BMt86sKksjgElRq94pw5ieaOQ8eoEvSxNLi9D8EnAFNtd5?=
 =?us-ascii?Q?Rk/zyMLlBr6/NajcnpkfL8HGn6kEDZPH6a246WXMC6I3UTVumEDoQeoJ+qlb?=
 =?us-ascii?Q?nIk/BRqyAaaOkfYppP/MzQkKcHqOMzolrV9Q7qnCQwqLpQKfJxquIg5E4iaj?=
 =?us-ascii?Q?DFHICPf367XIgDZ55z4RFgYfHsxBPv8k7nKTj6DaXJUA2k96LDkzaEUOhkQL?=
 =?us-ascii?Q?2Y0pRM9i0hMgmQ9eRS2uObg3AbNuBVB7KPdaRHa7I8BxVQZCMjqhtK4DfuXi?=
 =?us-ascii?Q?BeIhi/egZZRmxJgGjf/pwpzOyEzXjv5pPe5OXvGJd+izJk5Qgk4aA9M0lKg3?=
 =?us-ascii?Q?syBi2G70txSYudEmYfz8PpSxPejEWaThW8nDMFsq94obX/p5V7vzNdYRF6F4?=
 =?us-ascii?Q?37XOsjomgw3T68eNuGKh7un0gNC3G0xI5QeFX86cEAxivodvu94cQew3mVBU?=
 =?us-ascii?Q?V7uV7A35zNxnNPlguTxzB8MB1P9mhHTkOod0d40IFNdlN0aj7jnRng3Tuh2P?=
 =?us-ascii?Q?Jx2CpwCH/tCybA2Ms8ueHurXUr0aWBNpSR7bSeHEMv7hiHwVEfHGGXcKtull?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ps/nbPm1fmrftcqJGaq96Fv6Yf9WIb9OgBSkIOSUE4OCR9RSv1Q/3d9AfK0FoqTmCapvsycYkt+fvvteuCKjycEdfh6Xb98hmdh854WallNuXz37EVJNwcRQdQV+hLXVtAM+Ld+MVAKBoD4rY3HPjQMbabA0AgNf7D+LbveC3Ncp2ixMtAF9AX6UDXEnupLaxXBDV/kl7L/Zp33By2Rdb4MxLI6a9IiRIANcVP0pBXCQqW9cKHrl3NvtchowhNMTnxTdi8fGJojkTI0z5VuZWlgInhH9hrm/EZEeOKyocONrgyq05JG91OjM9VwJV9ZXSppPIikbKWfWcfZZITJsBX+Ruuv7T2kUO6qwMCs6gkCwDROmIXdwbEPwRaIxyONO6UgcWzjPVUFHJZN9mAaiIb3Xlw2lsEnLpI4kwNkc7FZTqjDjKHgdVRgJPPAqcQXnlu6fec0G5siUqUTU5yHtHoRYdg0oFQTHmKfVv0E3HcT6g02T1Qru7ILVlhfrryHOLYCiR5MBY0PENJazf/cddoEcdHimujVrpU/obdGSwIix4uZhI6sEfoFCDqXuTTPEs7NFigNnbJqm3V8xDXnd+gv7ewXTMy1vwDBfbNU1otY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3720c4-547c-4afb-f0a1-08dd97095ac0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:14:19.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dl0+Z4escHbUGypXLTaCGy4vNkt5BsyITDw/VhP1NxobdtcRFlGRx/0kAu1M4N3Z/axjS1el1DXgczpxanla01Ya1dQRYz0+zPj9zEP64B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190179
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b830f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=ZcNp3vR2eavZmEt38PkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: 6CHPcrLj3cgh2rwNIn40WvUpVMqXd2FA
X-Proofpoint-ORIG-GUID: 6CHPcrLj3cgh2rwNIn40WvUpVMqXd2FA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3OSBTYWx0ZWRfX2KdcPgl6YMlv OX7EQb7TvyEllltmlSeAvcHpRoCdcW5Jj3sry19i9oMqThESIF+v6ylcNjub4+x0SmCc0O89UOL qJ1GfmzswDVWrmtKgYUwXeRkavw5uISk4mC22GfLRjWnm4CLmMUQ3SvrqFDV6u/cfW/+rL7+pZr
 sVHMy2mr5eu4EwdGcU/9nnMIZ/wolvAoJu6QZ24b/M11L51EpJNTeUh8L2nxIv/Qte3Pe81MiHJ OwXT71x6eRzGmyNzwepdSRrDSEY1GA3nkJRP2p1slIoJBdh7AzwYQH53ys4rdS8Pbyck0D6XZXx djx9Gg7pzezpKxZW+eO+hi8ML1Mnp1pn3tDWVp4+hvmmwgcwnj1hLq9nMqqwl4TbT6m3SfAwvGM
 e4y8q9P1RZocHSm8YfFbuE29TEcxYLyQmRH4bjnZzJsniUhZ6z0xrftPcUt5lrAEn571LKkr

On Mon, May 19, 2025 at 08:59:32PM +0200, David Hildenbrand wrote:
> > >
> > > I am not 100% sure why we bail out on special mappings: all we have to do is
> > > reliably identify anon pages, and we should be able to do that.
> >
> > But they map e.g. kernel memory (at least for VM_PFNMAP, purely and by
> > implication really VM_IO), it wouldn't make sense for KSM to be asked to
> > try to merge these right?
> >
> > And of course no underlying struct page to pin, no reference counting
> > either, so I think you'd end up in trouble potentially here wouldn't you?
> > And how would the CoW work?
>
> KSM only operates on anonymous pages. It cannot de-duplicate anything else.
> (therefore, only MAP_PRIVATE applies)

Yes I had this realisation see my reply to your reply :)

I mean is MAP_PRIVATE of a VM_PFNMAP really that common?...

>
> Anything else (no struct page, not a CoW anon folio in such a mapping) is
> skipped.
>
> Take a look at scan_get_next_rmap_item() where we do
>
> folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> if (folio) {
> 	if (!folio_is_zone_device(folio) &&
> 	    folio_test_anon(folio)) {
> 		folio_get(folio);
> 		tmp_page = fw.page;
> 	}
> 	folio_walk_end(&fw, vma)
> }
>
>
> Before I changed that code, we were using GUP. And GUP just always refuses
> VM_IO|VM_PFNMAP because it cannot handle it properly.

OK so it boils down to doing KSM _on the already CoW'd_ MAP_PRIVATE mapping?

But hang on, how do we discover this? vm_normal_page() will screw this up right?
As VM_SPECIAL will be set...

OK now I'm not sure I understand how MAP_PRIVATE-mapped VM_PFNMAP mappings work
:)))

>
> > >
> > > So, assuming we could remove the VM_PFNMAP | VM_IO | VM_DONTEXPAND |
> > > VM_MIXEDMAP constraint from vma_ksm_compatible(), could we simplify?
> >
> > Well I question removing this constraint for above reasons.
> >
> > At any rate, even if we _could_ this feels like a bigger change that we
> > should come later.
>
> "bigger" -- it might just be removing these 4 flags from the check ;)
>
> I'll dig a bit more.

Right, but doing so would be out of scope here don't you think?

I'd rather not delay fixing this bug on this basis ideally, esp. as easy to
adjust later.

I suggest we put this in as-is (or close to it anyway) and then if we remove the
flags we can change this...

As I said in other reply, .mmap() means the driver can do literally anything
they want (which is _hateful_), so we'd really want to have some confidence they
didn't do something so crazy, unless we were happy to just let that possibly
explode.

>
> --
> Cheers,
>
> David / dhildenb
>

