Return-Path: <linux-fsdevel+bounces-31948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E999E210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47351284609
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A111E5717;
	Tue, 15 Oct 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKwZeqZf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d0TRRTyB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A31E282B;
	Tue, 15 Oct 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982942; cv=fail; b=Ehuj0Qg4zdO+1PQ5VEXCj3jSvRpsBN1OOJu1cotLfUhLSiQW1Z9kYM/27OwO3dsJ1JnR2fc/OVXmSrjOlJvYMP4/OyosgBE61/0nlLhyokxE3PBj+oCUZ/yPamRRsPFRuIz1uQq6lN+GJulMe5PEDk0S7rYNQkILdl1/TwZAOyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982942; c=relaxed/simple;
	bh=3X6DJPSUEKcZCwy7yqUUBhkUVjg+/1c4hSZ2FRoWwls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROHJdeZXmYzuRD5sEyWR4oI5MzAKJpq2v+z9Q/OvmbcZTtTWcKyajqQy6AHAh4Mji/TAepYy9biqkVrVvWKsdzIgN65T0MirnA3yuzvniu4XAVY5v8H2YUyGscuTqBhDkh/ij4WKunnDrsNdyLnzgaanYlSG7iJSb/73nj0g//A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKwZeqZf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d0TRRTyB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6G9VH003405;
	Tue, 15 Oct 2024 09:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L4N3as9Q+VWUsT4A8loGuGqUn7/qQQ0MakGNzOMVgOk=; b=
	oKwZeqZfMh1TGYRNMsPhjO3wH7JpA0OYN7u8qt9P1EOWfzcSdaTYhf0RzxFJAJOU
	Hu50uxklMeA4Qbd84Xy7KxmKrRv0eFZtSuZLjIozhshKfZmVWc3ALzdOtB5hDUTI
	Pm2XbMLFohB8pQRBTzgiHQ2+rOf89aNY8Pxc6O4sViISBpTqXbcYvjw5FYtTwK5f
	OmGPYdOhxzeGIqxmgKK9PyO425kuhP1ZaP5uQbaBkGmmWISjO0ZAM3Q4GYH2VdZ+
	Gsgy5++Z6qGhub/ski9AjXt41n3vsuST8PnRVdB+mmY1TRTdkOeLr36eoHxR4r1f
	/HfOobw7ulZRwfUluezeug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcftwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7XxXv026388;
	Tue, 15 Oct 2024 09:02:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj754ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHyo/nlH0kUjtpZc9qA+75VEEH4BG7k2vjrjKsUngdvvCgg0R4RBd/zBPzgzh4QUAlipR9YchY1vh+47E1mD+qVYryKHmf27NJkUMVsH7Q3Y60I3XeVSJhb2MKn5z2AJ2q9O+TiegPV5gSFXEJM5uOP6Uf/2vtB5AALaj15jBBmYBxK6s8vsieOs6tIRQsAh77kDzdrTJGcFUVtTFtZGmNL0S6aEAKyGcGHlDwO6+7qAtYr6NrwDjrm9r/nXPFldsK0gjnnkw0v+rZUDv/8nIEJBbCnTRLFDiVPGQLdHQXiCIAQU4MxQfTWCgm+zEUE+vXUDR6bbGK5QuMu8ugDgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4N3as9Q+VWUsT4A8loGuGqUn7/qQQ0MakGNzOMVgOk=;
 b=Jy3FE2LK7OQyzWQW2xLnCtNM/awVLD/SieAbhdzuRWFsvM93noEKq+g/lxib+Kt6xT161mb3dwa9772JB8l4QWnTMxpl78/7uLnOAuNJ+mlYWrpdKZDG2CXCvqohBAAcHPSqElTPEHPAOqFCkm7MDMqIqn7BwnqEEli1fRQe3flFpxGYqtRmh7vLn+GjFwjLnvHO5CIOSIXsZ58bdMDxsXGf4Z1BwSPgq6zpKLXAbx4jPKKChQoFoy4sGGTrXxDfCxNzvo8KM71UJcoD05C7u1/BVqJMHMHRZpVSilwJXqvP0d22yZtsIrl6pF2aYpqF/VD6L+N12MwrzejQEeRO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4N3as9Q+VWUsT4A8loGuGqUn7/qQQ0MakGNzOMVgOk=;
 b=d0TRRTyB11efm6elhSUjVo9b2E6aQGAcy3FEK5d+eYVjsiwF7ECbXy5BcPetr3QhEnn3zCUOYxH/9mdQq3rPfRcuzTl0r2DzP5gar4MYMJruAtLiCDl9f92pnTVY3pNWijdfXDk+jMtTPBMZXsi3kEYMo1pAt9A6iUmmNrumU2g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:01:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:01:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 5/7] xfs: Support atomic write for statx
Date: Tue, 15 Oct 2024 09:01:40 +0000
Message-Id: <20241015090142.3189518-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241015090142.3189518-1-john.g.garry@oracle.com>
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:408:fe::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9667dd-e374-4c4f-75cb-08dcecf8070c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?guiy+HLFcsENXNtyPve6nAS8nAGIMIfb6exns1WG57FIvnNlQxvaeGZyRjAJ?=
 =?us-ascii?Q?PYsAQPYpbtr9SKK0G2sbX6J/EmLmVOu00GxyBuRptDOGZrMRifmlRZFZuzej?=
 =?us-ascii?Q?4yCDhbSvilaYtqWdm5vBkQXwG6VymO3FKXFxFExO6vSOvOK7pinwGEok0m5t?=
 =?us-ascii?Q?APeMY3e2ErNfk2KuoxnYzzPsbLWJP3afLioqsEGxMk74xYOsktAbHNEH52qu?=
 =?us-ascii?Q?NgHB8I1hNeiCTzMMUd/Bx9tdWx7T0PFZxUEkVaLYW9hGkZYUtChkW3NzN0fg?=
 =?us-ascii?Q?Zp8yyIx4Mx5o/JMCCPrBKeVO248n6JD3j0dPBlu3m4fZ1UUPP9P9lyuNb3EY?=
 =?us-ascii?Q?mSd9wqDYEAZF08Mq7KauL8kbhN0sP0vRcVUv5Ycz7lBqheHLqenlEbMihtlJ?=
 =?us-ascii?Q?Qj37Kbl4PlBtXwLqONMWmsResUaDr4xXsV4I8V8DeJnuliwUcmDAxs2Dja/3?=
 =?us-ascii?Q?xtNJsPyzjPKT3wID0ruWYvqxLPCp/G8zn4CK6nCAMZlN//Q38Q1j/YFiVtkx?=
 =?us-ascii?Q?/n6JRfgjxuilPox6BdecaVnMr2S7h4SLG0zSYLTHNoGyWGxOHHzBnTL2020m?=
 =?us-ascii?Q?UJqDzi1fCcRS6FmBuMdPqrsAhw/72DGWBtA0kGwGbg5RZIguoHRTDf+AgCBC?=
 =?us-ascii?Q?AMiAc16/3lHqtGSrwLFoMwqvwoF6plxoTu0AQOD/0q7a5iJQcUdK2AYOZZJp?=
 =?us-ascii?Q?G25OEJm0nWm5vPXALiWX9lo2aWeq9tGs7QcAXibSnowkv1Qf8ZO+ZO5X76pz?=
 =?us-ascii?Q?Fvc5laqIUtMTs76Pk9FAfPqvzjz3I4s9TzsucHGuZoGoghPWM3dTIrNNgPfo?=
 =?us-ascii?Q?EB2ti3EA5GhJbI1Bw61xgrhtYimO3g20AzYPs+i8o+FDspgLKIgYLJa4S5CM?=
 =?us-ascii?Q?6EM0sreWS8aGIaU5dcD53lfSuVZGEqX/NYCSCD4nZHJStwcoDQcELju9tKn0?=
 =?us-ascii?Q?VDxcHzT8gzOoEvSw0sr4OOGyGFqyGA6WErPVyGTc+rZRsHhCGczcpjyaMN1A?=
 =?us-ascii?Q?edGYt0BIkqxgjiLkkF1wMyTLJPrEMPGXnqg3EtG3+9QtMnZv2/NQlxJ8Tqnk?=
 =?us-ascii?Q?6h7Tw4ONUjORFSe1O8Pw0kaC0TLF6tjHlgN7iTp0eVRwM7E/k+mharfifPAa?=
 =?us-ascii?Q?cKaDfgVeGqL2oZJiozUarJh7G5JhR702g7IrPvt+eLnfi+2u1Purl3pkmWTm?=
 =?us-ascii?Q?1xstKIm2V0D3Sh8r3awvy22mu0N+/Sc9NPxNaQLwQVb73wYwOFbpY/6xHxxD?=
 =?us-ascii?Q?gUDDkoFPSZCE4ndhs7aEtrE1Z+5W6Em364A/Jmmk5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zcy54dnOcBi2lOOhTFqMpx6iMrpz9O0Dh05C19tAq6KQukEV7+b2nvTXHkMo?=
 =?us-ascii?Q?oN6hFOG5jCeQZpEiA89h6NWKgb++QnXFCM9yKlhEaTWMUMDkwf+AQ6sWH8Oq?=
 =?us-ascii?Q?djJ7F0jwk0wih3cykYq/61Zdv6LaYBPRYTmQpdz5tAxqz+HPHAh8c80zS/Lg?=
 =?us-ascii?Q?ozlYg1QDjtqKvadYLkTE20b/+mcZYnIPP+GazpgrSoAIpqwFyWs0qsn8fspa?=
 =?us-ascii?Q?RA4henki/SzBAl3JF885qyri9VA/rHZxfAD8GMGcFzUTqevj57rKHCnN9bFG?=
 =?us-ascii?Q?HQYU/tWN8Be80TyvPjA2DIZGZHyiHSkN/QEl4NzEk6q4NJ3S9AFZtdJPYL9+?=
 =?us-ascii?Q?7wRGshNBwOn1K+iluj61OgTExbKeLnTrxfDrFYv4shGgZyTU0m9HInOMLRdB?=
 =?us-ascii?Q?4pRzpX7DA2MTb6uTdEcJk6HTDw9TR9BwCYivBZfRYrjqj5ItsfD1DhR5e260?=
 =?us-ascii?Q?zu75ocygE7GQeTqfunKOpn3M7eprdxNZMw6l+0s66EZwz5Ej2yNtwrbBcN68?=
 =?us-ascii?Q?7CMXRij3obGkrXzBQgtON9Xx+Ba+uv83OYFSJ6DET1Mu2o8tzoPuvCSdZKpr?=
 =?us-ascii?Q?ykl85TRZhEhO4rabMkVn6kAwsdQrYCuYtHfEtuvlanJs/hkoSacD5TX7BFoW?=
 =?us-ascii?Q?h578nl0JeRg8ab5j19MlQkwknVbvVQ9Tprjyua8zpEBKCJrhoybPGtHKM1Zd?=
 =?us-ascii?Q?PTXYEOUbIGlw3p67LXs4NTIDOMEhNd2fzphZswjCfNaRY0K0tjGkFqFpiTa1?=
 =?us-ascii?Q?cc4J/oE37c4jziR1MfNnOTOF5AVU4ADXvnlvO78Qf/5yvUTIsik2MUnyeYwM?=
 =?us-ascii?Q?SQYZ6bpmEZJAQ50woCoCQDkEDbpS9gG11YEJhFyASmbFcORpbKVp5EunZDv6?=
 =?us-ascii?Q?On2+vFBwd9QRenJTP1lXD26V22Yy8Yi8gvG5Su+N23PgfhduXW2Ayt8T5zRi?=
 =?us-ascii?Q?W+w4J3QZPNpWtjt3yvHlepMXDVYpL53vTHU2EfJcbOUGE+4BkTkjKK4XkgVH?=
 =?us-ascii?Q?FloLpJeTFhQIowUkgm8fUdMLJHNTKe9EQymFs2YmHdUunGMrnuflWsAFY143?=
 =?us-ascii?Q?WWEs8xAJKjaJU7UsqmraAGR1cvcwWE/+54fLkvO9bbwMlEQERGxoarC4ePOk?=
 =?us-ascii?Q?E3gy2uBvQptPIsu4aqIH+gZGm9WEKET5dh4ap7eEBaBpVAo4FfuNoWKk18pg?=
 =?us-ascii?Q?eKTCzXbvpAY9ZUMfIhHMS5y87GVpfU/v0G7nxjPCcqnQCPhv3efuKbQk+iPH?=
 =?us-ascii?Q?LFLpAXQ5eHKj2FinZXrBkGC7Jvkg3/XkRfRvxdj85lsTbXzYBFW9rrHojLEC?=
 =?us-ascii?Q?sZfufA68R9hCYQbRDFpOIgGpPfnKhwQFuUTxqjR192bVQo4pdkErY0rTdDNo?=
 =?us-ascii?Q?YVlaqNlvYy/1Bacl5eQZYqHFCJwuCyfl0QBR9IjbYt4SJeQ2oOs6KKed/oQc?=
 =?us-ascii?Q?lasJFMx3U0MuLNUv9HVORiuqtEZmRfPJI3m/rkWoyFzHyBJGuyiLuK9XHlRe?=
 =?us-ascii?Q?nxfn/iGY3E1u21Fywqm0ZdTqg6d3NXcctQQUMCEJ3dxzh1mwP4tv1iFogAU6?=
 =?us-ascii?Q?p5+NLlTsIc/k4yLx4A64yFNW/W0t7H3AxZbAui3j0B0K7Bq+JbTsdvJsTfNR?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5/IBgxUVSUrR1fWYj0V/dmOk26MHU9QRp8T/jpNmWCPrKxRwOtwYe2Vzveb96ImdJGJgPSvrEyyxxY7Qw9G7mKrqAofjEHaDdqUSH9BtJOGCaZSKqu/xLvU6ola5lYRAaoSSuKPLLNS6sGkOarRO/2ZFm5uHMdlA73dkCMVryadaiWo1StMkVR1NRQKetDNIV92/TU5xkAZydGslcz6J/DnvGD1XXEcQpJGrogSPGitYYiB6gXXOxb6wLdBgoc/eQTqA6C0/MlJ6YKDZJWv+3F+LpWb7JDhDNTgSif/cn79mczOSXfENwGZIwFBoLrTbneaMQyaFIBWCiSpVsRvPsn5yCn928DoQPZOLDKnF5F0tN7NWELM6NaPEpzIHTbX0+tZMvVuuCchfhk7nJIQCweigl9ibvNwwPwRDOjs7vSC9Vr8Fz2HisgUHYULbnEOsBDuZBEQlmgIfQbhqIZR8kp7tJ07V2V1N+/e/7l7ftZUXnh9aPRfIG0H/IHXSmBQAWGyawgPXXiaYEP6zrk5LrEuriKy4i0jeSYFqhSeapn9H5zWLMZBzjEjWwkx4bGCv9EwD8RQssu4pOHbeN0h4FLiVjMLhClcPXwJU9DOGOzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9667dd-e374-4c4f-75cb-08dcecf8070c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:01:59.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwHDM4SYMWJ4/hFfvv4OoB5ZYlPbIYGaT3fKaD2DoSWx9BUMC5WKln1iFQtwdsC4buksXzo7YHTHkWWR5BYUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150060
X-Proofpoint-GUID: c5gg5Rr8n71HYZOpxwt4br7S_32Qpkl5
X-Proofpoint-ORIG-GUID: c5gg5Rr8n71HYZOpxwt4br7S_32Qpkl5

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size. As for
max, we limit also at FS block size, as there is no current method to
guarantee extent alignment or granularity for regular files.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   |  7 +++++++
 fs/xfs/xfs_buf.h   |  3 +++
 fs/xfs/xfs_inode.h | 15 +++++++++++++++
 fs/xfs/xfs_iops.c  | 25 +++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..e279e5e139ff 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2115,6 +2115,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
+
+		btp->bt_bdev_awu_min = queue_atomic_write_unit_min_bytes(q);
+		btp->bt_bdev_awu_max = queue_atomic_write_unit_max_bytes(q);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 209a389f2abc..2be28bd01087 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,9 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	/* Atomic write unit values */
+	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 97ed912306fd..73009a25a119 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -327,6 +327,21 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
+static inline bool
+xfs_inode_can_atomicwrite(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
+		return false;
+	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
+		return false;
+
+	return true;
+}
+
 /*
  * In-core inode flags.
  */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ee79cf161312..919fbcb4b72a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -570,6 +570,23 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = sbp->sb_blocksize;
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -643,6 +660,14 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min,
+					&unit_max);
+			generic_fill_statx_atomic_writes(stat,
+					unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1


