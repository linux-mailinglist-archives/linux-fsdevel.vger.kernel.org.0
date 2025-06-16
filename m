Return-Path: <linux-fsdevel+bounces-51818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AFDADBBE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 23:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C073AE771
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C85218ACC;
	Mon, 16 Jun 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7CLtAEH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dUaUIAzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65B136349;
	Mon, 16 Jun 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109095; cv=fail; b=aNz9wDzWjcGvElG6Jl5Z0QuCVpmKRtSiM6hFTkaGzTcmKpdbLbVRagRMFuFGOM1kjgknqjPmoafYfW+5WJk6Xvu1CobGeVrxCsbzuZRCxmzjrDMQPvmcVIUWUJ/htFDrcTc6Jf7peRWUvnEgnElHltxoczqDUvx5fS0L++/tkTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109095; c=relaxed/simple;
	bh=DbVhjv+5eExdjqAbz564WpyKf90yBhECHV7Y8JjvDtE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=fQzZP97b3oclOHj4gGGREYNiKjWBUTQhS45riIhlJOvVDab5aYfyBtqUyc0duK5X3yadJPTTdnFl91FhXdf5MeK0m0QZxyGFEmpulN3irZMj3Q7Sk8uPC1P84OTqxlOeoj8m0PTqT1VW1lIF6FzEDLaf4P7WBTUSeSJqtgjL528=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T7CLtAEH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dUaUIAzF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuTLc017630;
	Mon, 16 Jun 2025 21:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PI5tQCedXu185WZ4sE
	I1DGmvutp109avtxno0CqpksU=; b=T7CLtAEH1nQxqOLW1TC8/yZIK2dD7GVUy9
	5Bg6dst5kdAPhuoHO0jkaiMBWvWYlu/jK44HYtBbU2+c63fBsi2DvD4lpIFjDMpp
	JpitSVhgRKZVaHvtoDB86EvLnH386K138RcMR2kKCa1UgMiA8EGtNrVNewAzmI0V
	GA5bpxFYfKcF1cYEyfz/e3K/dLsX4JJFk+qtTsbRpPBfGF7x0hB7aYQuL1GXWX8a
	hfiDUh5lw+a9PSLOZPpgZTEZsuT8SlAf9pQDVO8AhQaaNncaPgVQLh0a6PYRSM1s
	zv0MyO94/T9WyDAW/AaPGeblzCx70N8uqbBMaSpKYWEyYE7DroYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4m26f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 21:24:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GLNdAV031638;
	Mon, 16 Jun 2025 21:24:48 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh870ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 21:24:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o090IbrqsfM96oIENJt9/jDow+iEt+z0VNHzcd+0qvumc01Vw4cxcrb8LJtOu1Kxsvrk4TvxGdeA7LkasIL4hyPnAE2I5gc4By38StEHJzvOZitipfErb3Vi84ewhjJSZrTtg4in3thb3rwdr4+C5YEGz333StNC+ZfHDeVd0xFnmO8wDoaoL8JL2/D9/m+IjHtbmMIAf4leO09L7jHL7S1uOmqqBwN2x3P6R7ugeDL7AJlT8RnWLU2nso/D5Uey5BpBiZyh2gFoFSVPGSgqYpp9zILuI2Vibfkxq7tuMJ1zHwmJflayJoSq8ezPHRvXNnD8xTcQoAmDCuheckW9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI5tQCedXu185WZ4sEI1DGmvutp109avtxno0CqpksU=;
 b=t0tSMF8dvcw4LXAWJtdeX03A8lvgChLIsjlZ/zXHTswTL+Znsam9brTWAc2bm6C7movmea2ki0+XLrJoxZU+/cGMM6gLaABjJHdHVF2q/+6jwLHulEicGq6TstGtSPFUfUlLnq6ooKMkAUH94wk+sKo6wITbPnFH86zBBP3NZdyzEnIjBDd6VpNVCDg1moaBO/Ravy2OR9DVUHEr++9PSobMnC9sa/+/PwUNbEf5XHksCSscgnbvY5H0bmyDlGHmpjj1Zo03GB8VcZUZl4nZz06Gt0utrIeVhcLS3sT2tBY7DiuIOMJP5s2PnXRjU2uGcDFDXW+VfL6bvp7UsH48Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI5tQCedXu185WZ4sEI1DGmvutp109avtxno0CqpksU=;
 b=dUaUIAzFl38F+5jmE5D9YjNWePChrcQcuHN/TrgywMmwdIABaI8LTthf1C1dlVwBKZHq5jiQ5x9uA812aHZ0vffTlEC+aR6oXjqQeizOCnfgjT24nwVlCxyKTwnVyBNHw3Ts0hJFs434H6FS6299wG41rzKvcqdPAKOncT2z76o=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA0PR10MB7135.namprd10.prod.outlook.com (2603:10b6:208:401::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 21:24:46 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 21:24:46 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250616062856.1629897-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Mon, 16 Jun 2025 15:28:56 +0900")
Organization: Oracle Corporation
Message-ID: <yq1zfe7xv9s.fsf@ca-mkp.ca.oracle.com>
References: <20250616062856.1629897-1-dlemoal@kernel.org>
Date: Mon, 16 Jun 2025 17:24:43 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0709.namprd03.prod.outlook.com
 (2603:10b6:408:ef::24) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA0PR10MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f7e793-ac2f-43e1-b2ab-08ddad1c3753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GN78rNEkjLsLBMx4QIcimplzCUT9LznQ0XZ9fxsmPlKWLQpM/ljY4dCXmPHN?=
 =?us-ascii?Q?qq8ldfrCCiLEonICzfH/+9i2rpUEKuLxu7PAJYU+KJOenlQBzqnDLaER1AAm?=
 =?us-ascii?Q?5hM7bgFceLD4999JRrxunnG/4UZB08RtGfxHNd0vbMulXo1rY9+MwABIR8k3?=
 =?us-ascii?Q?gXj8q/8ih8Dl+1kkcfIvl8A4Ik8vIw/3qzNsR857y9EeydDREQ10iXKdMvRK?=
 =?us-ascii?Q?Mz0Dgy5XSW8zld3Pw+wWtdTF9isphlC7cwlSMf2L6kjpxvPVtCTis4G6/2Rk?=
 =?us-ascii?Q?Jn8AfOVur6Ks5jIn4jaWNJTLPyPQSVUrHC9kHxD8yyt0eERwmL6nPjcY0WIq?=
 =?us-ascii?Q?LqsYprxywNVvJQuJU226nsKMzobGRV/OUWXlRGU2le6inLRfPJoXQ7/UdDqw?=
 =?us-ascii?Q?z1qnQNW50umi4EXm7NI+u6Rpf0SoyEJV3Z/TpAsX+EJX2jHbRjOxWSYyDCmj?=
 =?us-ascii?Q?QRuwHmRaB8Mi3nrucB37wBmmlX384ttIgUqClESoY5buXyvXta6OGRAJ/qlK?=
 =?us-ascii?Q?lpCJ2wI0YZUeMaAPCmCOMBQyREUL4aYy40DD++uDoPlaoTgosEeL0dymyJR4?=
 =?us-ascii?Q?12zvmkioMaeOcoqHt+iqO3TCT1WxHPg/W3ygutaxjatvVqJEKv1cs+cy0kFD?=
 =?us-ascii?Q?qq2QMYDRlaZ2upIhUlp9iAkCEXqepAlY8w73dd2Zq1wt4+K+bIZ1YqeIE9Go?=
 =?us-ascii?Q?MSZCMPDajZp0nFTjUppweaRgM8ok5KYtsYeO/nXVlIct/bmqNXEQp4vLxiDc?=
 =?us-ascii?Q?+J2lG3BjYGdb1JKvrpg5+A7jGC+AU8N0UuRgjpC5pCe6M3FLX4CF6l/S6fbe?=
 =?us-ascii?Q?lAKzT6QeqieD8McGv445rWUCH3EkexF9EEZsYYpPpkjxI5VX0spFhG116Rqo?=
 =?us-ascii?Q?xDQIlZmd9s8oC3x+yNueF6hkUaWvyUzmuAAT7mhRAQe2YTp6bBd6ZWtJKceR?=
 =?us-ascii?Q?Pg1qMEUggzOdkolpHkE2GWVQP78EHvdSw08ss2adHensG9sAhg7v3jYMrT2H?=
 =?us-ascii?Q?sKfIg68gJyS2WxjNAXqyZ5hGkltgOJlBOfTlkzgjcHzh0MNYxPMXdOD53u/m?=
 =?us-ascii?Q?deCCE5yxsZhEZgCVOnjlAl1pgC8qzHYLHJ06IbFvvGuwkEHK0bw3Dt/ZG0m9?=
 =?us-ascii?Q?fe37hPjIjjKZT059BXwsp2kN/OegertedeXGQPmzOw24xjzKOWkxOWKZfIy4?=
 =?us-ascii?Q?Lh/fwb3e1q+tm48Q5CeO1Zquc/96ZnGnxfwEhOhAuoKOwhzT3/idrYc/K0zi?=
 =?us-ascii?Q?GYAOQsFSfYVwi6kxvw0C0nMtCFFsUdRnWGiYQ81jg2cPb636mcSWSnA5Om+u?=
 =?us-ascii?Q?TPa0vW+RWSSuXOtEBwHp5fDqJPS5cmiRVt1VPbV8GlUZkFjRQ8/njn/y+6XK?=
 =?us-ascii?Q?CBt7PXsSIREnlWMMnj5tFrxTUPA6snIf3CM8E2c2KPrpmvMjslJZcypC9jEU?=
 =?us-ascii?Q?VZUDUnJlRtM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjmFeT2D2O4yfQKy1/fGUHeH+YtaNXGViUevEtOxvmjnl6r++iDMkotCuBe6?=
 =?us-ascii?Q?u1ddbI7wJw7FcIEIAATKhq2bMbwf0eoEfHW2+k4w+BxsdTGO6N3y6HhH2vkZ?=
 =?us-ascii?Q?6uy+NoAoEqyg2EF853XSZUdOSQyZ7cot3/Oyuu7qnGYxFZFMgyeoJbJP8BfN?=
 =?us-ascii?Q?oDbvUDQSQjNQuylYh8n3dDBgPZsjwvVYlNnYpAf1u9vrLf+BwC0tmleNTNoW?=
 =?us-ascii?Q?KbAE0gM6CFTk8ZdJvKxXJPtUPm9T+to+gV5SD/YGj9jsz0OHGvwN5ns/BAMq?=
 =?us-ascii?Q?n8NSXavokSQKzpX5xGHKqDGS3gPFjGAM/DEeeBuZgNvMpeBa73EXjc6+zRr3?=
 =?us-ascii?Q?ynl/883ON2WWw4nEWQb88lTUZRVOxWIDOxap9nfpd2EvdpBOqYylfSxcp597?=
 =?us-ascii?Q?b4lG4IpcMe3n1eTNYSSnLyZF+dXI3GU17UKcnPTGV6qK58Xh3N61OBcddg9+?=
 =?us-ascii?Q?+M9HbVy7Y9E0N606qwDR1g/eS/VUPEfA4HFt91Gk4Vw72qYd0kmVvEL3hnIe?=
 =?us-ascii?Q?7l/EFtueqebS2X8OV670FmMry3pzJ6KB0jI2f6+yUidKQfCehHAsZEFY1ISV?=
 =?us-ascii?Q?Q3NR9m1JxX7gzA6FcGlspOoOY/o9ypyMyQljXUDYKQtKeogzMKFn8oi7oOcz?=
 =?us-ascii?Q?TK1pEwA1cpnaegVEmK/VhPZmHFkvnX60s0637dc9dcC1yl1rE7TXil7vm3g1?=
 =?us-ascii?Q?jHjJamhDpCn2AjfjOu5o4Z6DZf6RuLNtDix6JACGFqpnnMijYqv5gDP+ASrv?=
 =?us-ascii?Q?IUjBgfwU56KCl5QcvPp/g0eQbAsQ7hRp3ARSCLCUSxBHr0AY1/9XdliN5QSk?=
 =?us-ascii?Q?DaNY2q01wQVbN10LdqnYgqJWLAM6CAGWXpGteBZ/Fcla9SEjd80XrGaCskxi?=
 =?us-ascii?Q?dhzd5wWYDghMruJIzjW5zZ9UvAY2A5388r9WTwFQG7vABAfEiLNnE/xMFimT?=
 =?us-ascii?Q?KgAjFkMbinBl2qcCMPyJFlCpy7MNBhjzffemJNroQJuEGoyTA02P5ZBTc+Mi?=
 =?us-ascii?Q?v8ma+L+j5Nkoqk84DIdqEttfggEL6XaQZ09XRjTTJyqIUxDNCDmksX5xwNOQ?=
 =?us-ascii?Q?omFCjFNsNULSBoyi1IOYNOEAdEccxAAvmJFO3vZDVm6FPW7jGqeRVFINYwqP?=
 =?us-ascii?Q?Dko+rPhT2jeAeLbFdJ3NAeLtLV0w+CU50TtMB5tjgZJZ8CSsGvHoANEyVbJa?=
 =?us-ascii?Q?HRDPPomLfu5atGEoXNWSz2WmQ/GlimrzLn46r5AUIvyKGuNy1m4gkeQa1C7n?=
 =?us-ascii?Q?10d95UKuNKUsv/fBvq6QC5PeVI2ffdsupxGIO2yBapRqIEFdb9Wu8sb3KOJt?=
 =?us-ascii?Q?h3WpY4sz5emOqUQT7s6e1Zt6DdNGZ0tYeJXP770ukXXDo5KBixx8GCPnYw0e?=
 =?us-ascii?Q?Jv1ss+r2kdmyffOtTPZp39vYqSK8QMf8kVtf9eAyWR7Aa4rZh/WUCRHIKFdb?=
 =?us-ascii?Q?DON1KjOButlrrbk5C6RbEukmnOIW8yc3pZVD9uT9Z44DEW/C7z3i2ll8NMSi?=
 =?us-ascii?Q?okTEYv47M3wlyMqRUPp+yoTYDifYNLq1oCJwv1CjXrHXl3BeUUop3OEahIa+?=
 =?us-ascii?Q?AzsaytDI8/tAJpTPkNIevrQio9TIq+MwDL1P+kgoO33duxLkoowo6dk8tSpd?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lnj3M5THGMHC8MDNAPWb0XsztYkCAg38aubvGfxPR5cHU83pghlmz+Yui6+TE8q1rAdCZ33oWJEkItkHcSo5Y2RCdD/haFR+Bcffvhbe1KE2YN46weKx2ixPlkOoof5MS2h2S5qI9APnwSHC5JtIYxX3/GORXQoyZVXI7Wg0xmLZc4OEjmIJS7i8hswYdovhS3uOThEFI5tRDeeDrTAU3FkCHPJxR7q2jqKNOHKeJ0RdAGxBOoxPFqGKEcMtVa9y3DRChyGoEPLvxCTr42VU9nm0sjqx2LVUO2XCQtmGxb8CHWmCaa9mupL1Z6VoqdoJbwqbhJ71NbOiSsp0+dlk2m+NJMOlBJ00GAFmkl5JBy9GQwWMF7z1+tzUnnbeYPTv7JZIgWP5ap2lXnVJ1HGsgGCKy7vM+KIyUODbflSsq2L6tDEzXNNzBf7MLt2UTFIvIebVceYNxJ9nqkyhPLVq3dHsp81FoV3q1/H7CCOqpLiiTRMPVOG65mzf7bP/WkAVAC+eD/2oeWOiJqPabhFjyN6kXoTPtH1DhV/XLaXj+s5zeW25aUPKnsgi/aV8c4jxcaUkOAqae73ZJPyyu+7MEUA9gcolAB9aetrKj8Edw6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f7e793-ac2f-43e1-b2ab-08ddad1c3753
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 21:24:45.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNAdFVSq7PcD5406GQ91vzn2Ku0wtd+60KEFxDj31BA1KhDZfy/he0XV3+Cb7OKWH6YaXXC9OY7ClGoJyHRYiFzNKXdWq/L7O7TKu812ArE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE1MCBTYWx0ZWRfX/YffjvvCW2aH AWFr6i+9kW0OsZYeRtFEbJD7ciJ0plURuCEr0yTOd9+yfjPhsGHTH9EI4OHmcskq6yRWw4GG0hk 0QvXuhfhpll8CBAGbltHJHao8BW41g5stG4aBX6iqp5f1LsZRU6HG/LHhlQArxIInyOFg7HUyY/
 m5NUQ5PjYE4gvj1sbAj4rR0i+Y45FAgcOGVP9vyAEG60vJAzVP7G8gu7Uj2JurKXfz4mCEXE8fv 1h6quqwP1uHw82/Prg3nJHpWEcgdSHCWPKQybhqqQ4wEBBhgO0VqayXIWLMXynuY8BdndvWLS3n A0jBakIuZyxQMJmJBQujCPihY3D8lXA3WvnjiRuA2aSySXqDrNQpKt5BRRjPvnxyIiRF/2j3G9W
 vCTb7BL+HXwiBCr5q8C3FBA1leIoZnFN4IHmtByK00Pcd+3T9jXD8Khmq5dwVQcKMMbWEBgM
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=68508ba1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lRnGstzktxXcfe7_d3cA:9
X-Proofpoint-GUID: AkvUnIvOS0lI18zghK8JA-3owm_1yE-g
X-Proofpoint-ORIG-GUID: AkvUnIvOS0lI18zghK8JA-3owm_1yE-g


Hi Damien!

> Modify blk_apply_bdi_limits() to use a device max_sectors limit to
> calculate the ra_pages field of struct backing_dev_info, when the
> device is a rotational one (BLK_FEAT_ROTATIONAL feature is set).

I much prefer doing it here. I don't think overriding io_opt in SCSI is
appropriate. Applications and filesystems need to be able to determine
whether a SCSI device reports an optimal I/O size or not. Overloading
the queue limit with readahead semantics does not belong in SCSI.

> For a SCSI disk, this defaults to 2560 KB, which significantly improve
> performance for buffered reads.

I believe this number came from a common RAID stripe configuration at
the time. However, it's really not a great default and has caused
problems with many devices that expect a power of two. Personally, I'd
like this default to be something like 2MB or 4MB. MD, DM, and most
hardware RAID devices report their stripe width correctly so the
existing "RAID-friendly" default really shouldn't be needed.

Anyway. That's orthogonal to this particular change...

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

