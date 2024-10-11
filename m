Return-Path: <linux-fsdevel+bounces-31690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7199A25B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B301C20D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A7216A19;
	Fri, 11 Oct 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mfEYJIFb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N32P+l1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC22141B7;
	Fri, 11 Oct 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644784; cv=fail; b=ccZ/nVs4FoPLSTO8f05H2UC994yHBsIgEseyTrxQBSX4SU8R0kvZtcvjuCQe9GxqvibwLQ2aYmPVn6BESYbJspcRBX5RAUh1TCV+mski0H52EBqwvkbQvEk554D1wu3Y8kfBOL/89Wbh6Qaj2F5IiSFlMGslTN+j1PcffYjG1sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644784; c=relaxed/simple;
	bh=RyjWIlLNssoQcYShKuFvfQkoNYtuaOLTKbMtOJO3Jmk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YiTFUgkhMs+u0fO/luhGQyklEuEtXUBWS6ipszAYA4xoc/vGoI0AdmEXYc1/6hh2+xOKNVZLHEcYKFS6GND+1PHr4/UO8vw4uUycw5x/XPaX1UTFm0GQO/y3ioLx7yvQkKX2xkHMyPQHgqGuUkeVDVqGHYY3yhawwJ+AfwM3yqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mfEYJIFb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N32P+l1+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8Beeg030628;
	Fri, 11 Oct 2024 11:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=HgPbyjLwfkDCmIhK
	jkAHH1dEUwzqOw1+cfVEyzgdHD4=; b=mfEYJIFbv3i4CelDudxe8ENLRfo3NCaR
	4qTDitevybN1/HgcBZGZVNLk+0oR9ivevmv7TNHu9sw7Bv9jxvpwXDlPD0X1iozV
	aQf7bSkx6ETmxYWFWOiIFUCFjPmcKSwjQByqPHwNgi2xrZpxIyt7Q/s9nH1C4S0L
	he+Mvz2yqVwPYvu/L+DK7eaJ4JQ2GIxCCe3DoXy4VReoanKMyUr2hHpeUe6mrzWk
	5vm8cyYZ21QXPIjxCS7xMoO1C34yilww+Wj5WB+wtV3XdtomXoAeINhcXq2aWbaO
	tcPYF5pDsKNzmb2WI9zb5d9jfF/bNvcpq9fERZnN7KTUaDy8q6dZPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ymknu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8soxA020626;
	Fri, 11 Oct 2024 11:06:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb96ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm+f52jlrNLCHVDIwmww+J8CF96xF6dasmdyx32GgnvKnQR+M75RsKhpj5hyx3fH6GdUfuHdryTCREq8x/VzqBFcC188REJL1mj28NFodo5wNQ/VrG3652luQYuhdLsGOX+GKmI3GqUEUYtOlxY/j62Zk200u4tsSlDc9Lf8MMw61XPa/StIqj8v/4Iv2CPpDc0FvEVIxaKL7DcxDy/D2tG7ffhqWcnQzmvC5IqYR5KSUZ47e+DFWCJEnEY15uZNx+HuLmL4S4yO+mp2Z4Lo+huGgO2L9bwEMr1n3/Y8wBkRG1FxBVa4yWCoCLW1XMhCDdp0UBo7DDqW7iOlPKAWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgPbyjLwfkDCmIhKjkAHH1dEUwzqOw1+cfVEyzgdHD4=;
 b=UXSsfNFGJe3VgrwCHJJEGW1re9yRGoCCsD4hoEBKvVIO+9xxRcDEaHbpCj1w2bujlhx62Zep3f8NMJQnpeqrhZ40/ybh7XNqDue0LMrtp2XJyNpcTzJnUugBWvxxO54D2wBNqE3LiWjKi3Vht0r2+x7YVhU17GJGzsudwgdsVEdxcZW4VtaziyjxgNV9xDCGXAHA9G7K87n93qUJe0Rzny8dLdpNY2JwvbXcBz+XBbOO8R/QampnVmFWBCx27mSTwbMH07HUa0WpXX0oxFbc6BE/D4nP/pq946LtWMKniK1JPH+nM0dj+pHYGN63KDFhJKktxoXUFgzTOoTj8D1mEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgPbyjLwfkDCmIhKjkAHH1dEUwzqOw1+cfVEyzgdHD4=;
 b=N32P+l1+yB/B+RidrJdFT+P1PYJk3KxzisMtllJmJ/8TVbM/YrNOaGOOMRxDPvoNA+JQM5btWkkM8P/A9Gfrolxq3YnQTex+12Au0UJKUozsFG1aexk4Y7LvWo1vFyXr16xvo6/fSAvCMf3pkEUEVn+POFF++So9zg4EuVooo48=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 11:06:04 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 11:06:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] introduce PIDFD_SELF* sentinels
Date: Fri, 11 Oct 2024 12:05:54 +0100
Message-ID: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4dbe57-115d-4adf-2732-08dce9e4b2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92smYy5liFpZ7LSItL0XI9Bv4o6BNvyaDdcBHfBM6latqrhbJ2buMHoatAed?=
 =?us-ascii?Q?l8ORrsfz6KZrMIEzTsALCxhFfeQioR/M27QAnCT60mDrG42Hrg/nw0dLoDcL?=
 =?us-ascii?Q?7mF+yHR+kU2g5tX0pGiRDhCWPewWnMK/I7TXlwSm9vZTZUGYE5qhCj8muw8k?=
 =?us-ascii?Q?ybATF73snnUuNTpDcMkIZVykvOPeBD0cFkCYwzlY64AmLpNkvp3M4TEKXjKq?=
 =?us-ascii?Q?f1GCtx6sL8sK1eb8TBQ+5Q8bZYMiNH7oAyuhCfYKjXaH7KBxKQ5xpBlyB2eh?=
 =?us-ascii?Q?WujO2juwpZep1TOoPNr1pdcQUGqGGeFm723ka4NNzOh7uHn3NuedmYHVAWpr?=
 =?us-ascii?Q?0EqKzflSMCOHOsK/Kg9LkVbUzagJVOCuDmSJ+LmavJpekLkHMGQQosYRBLlK?=
 =?us-ascii?Q?3OXiarHfLHuzeR4Vk673hC7P3coP2ys1rVIZwJF3mqgNjcdFyS1qaLrKXz1g?=
 =?us-ascii?Q?LL/GgsA6qqFAJRCuy92L1QliyWqBwDYdb/xuySibJMUnJB4nO+oIoJ3BI0cW?=
 =?us-ascii?Q?4bPXffYVD+G2Q9WoPC/AOl58Pi7bLreYzqqtGbgIEkTpiMLGQ5prjVZzYoqS?=
 =?us-ascii?Q?Wif86FtwT02Pu/PvtYSlm78i2ZPVHnVkgbsQB+I7ZdRwOKHuXKa+bXutEydd?=
 =?us-ascii?Q?JbvgZiSaAL+MUto8TEml9hE3pZGDnpxAjS3u4N9RIxO2VxDgJ/ca5heZzfPS?=
 =?us-ascii?Q?h+xg7sBACX9BmKhjODGGw2XcIeHdfjBPy76ZbeibJN4sK/Qlgu8tARMeDU7c?=
 =?us-ascii?Q?wIAPMuysB8HFYTvUiucq4B7/QqRpYUs+NlgAz8U9D6jNDk1Di/L8oUF9kUIC?=
 =?us-ascii?Q?S3QLh9DLGvxAAKkL+U338Hshs6t0nV+22PJAaBNv6Z6NZYTSzyoo3KK/C6n2?=
 =?us-ascii?Q?jKAaLLbufJMqKiTKRcrfHHPUKPbUEuuQAlxXVqKM9Rbl7YmMQWVv+RzSW55x?=
 =?us-ascii?Q?4gDfdTiPKMYvL2eu0IWaR+i9lKCNTI2McNNUizm4pt/AaRmHMPCW03XITom8?=
 =?us-ascii?Q?Lqlqwrs4OPU3ZO2KwbvkwxQgFhxxLlO7SfHVjyiNYIfFm7zAHGM1ex77SYwj?=
 =?us-ascii?Q?l2DOLwhsYZ4RsutCM5mDDfEiiAbGVuP2HVbHJFqKwOJCAQVdxXT4HIqtjL5K?=
 =?us-ascii?Q?rBBV6NzxEqDT58HHpYI+0qP52sYFrGP/SwAudPg8SnwewgaXXWgl3x5XrZ/O?=
 =?us-ascii?Q?2SFWF+bLrmJsWocQF+6FbmVgY3EuLV9nALQWM34EdCnvfZPlgLog2q7tqpXg?=
 =?us-ascii?Q?VL0k4OMbLlKrg7NmXZL+dK3yNvO/M03VWU/4zps2N+tuG4iesL3iZwFJxtC5?=
 =?us-ascii?Q?gyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yWoLlTzjbEqn25w8CNgVjrkDGplNbErmbsYvBqVwHl2hRGSldTCcFJx0Ink5?=
 =?us-ascii?Q?l7Sumjsc3qJG+IjzkiO28CH3Ax7tCLDGSypXcG/WGrWUJ+gjejtz/zvCs6gX?=
 =?us-ascii?Q?l4wrSftOl1vdxZUBu+tucYOT1qu2mRB3IVlAukDk27lKEm6RFySCyUmMx+xH?=
 =?us-ascii?Q?TAZZN4ZHMRkc4RwhJEj0pXMAso9tSbptPgz3gixKlcX0+RdtVT6LbK82vcwZ?=
 =?us-ascii?Q?wkSR+B8WuzHd5QpiuWPkVHwd6kQhZ+IaoAMOrHDDSR0MTsYDFbgXmWQ7m9qI?=
 =?us-ascii?Q?PEBukEwQa8rwM0E8V8oU1igCPXyc27OHLd5Rly9qf8fgEgujDacfgpzhZ/jX?=
 =?us-ascii?Q?ILg+gCkrUQ0InStNFzsLbLZDEbapxSS6vgI3IipD1l3JoyDg1IfX8DFNRDJB?=
 =?us-ascii?Q?byQJq96s+4zBN50FZ4ORR8dMLeiXlXEJI3SPye7BsLB2w/kpSq74vFaqQoKE?=
 =?us-ascii?Q?SPBycyDbELckq/898Lh4rDszXCXv5suVnM+k77inwSYcyL6oMUzWxnajL04U?=
 =?us-ascii?Q?pVrW4TMg2PzKcGpccxE+5sWaf36D617S7QEqZc7qcezHTE5MJPDUeusa8c/D?=
 =?us-ascii?Q?ej7It5iNDTeQILWoHaHFurrLhvMGBxTQr46YpzTAgbvKMk9yHB5KnBWjKu1c?=
 =?us-ascii?Q?72nP4my54V65eV4m/E4IpE3TJEVD24zdnX3TgCDj44LCg/pGp7KcVJRnsK+2?=
 =?us-ascii?Q?sXEBJ5XwulKvWXlt7MWxpRegF2AuUb7SPZeeilqLyYKmMdLc7QfjQGlPvlSN?=
 =?us-ascii?Q?NIYmbJfJbfeHLFDW3ssnrdyGz/o1DuQL7J03g5a4nlevvLspBOIHepQspBnA?=
 =?us-ascii?Q?pUfOywyTv6PFGtLwNupP+FR4bnoNvFWK7t9wu2h34fHg5UWjwq15I5q1s/VK?=
 =?us-ascii?Q?+chRQ5K5JD1Kw/c6CLdaKY5LufdqXt47zIAZcZ0hHyLNjrDIYtWqeyr7VmaX?=
 =?us-ascii?Q?vGDoQ+aiBdPrLuu2JPx2Sq+j40cdbS9zD9E3vfb5ITRUuUv/n6U+P0PaP4j4?=
 =?us-ascii?Q?OZUpErdB71F2EoJUthhND14+xDqH78R2GqtUUFRR4ERVR5U863ykiwRZIZfq?=
 =?us-ascii?Q?DSoVFqthZaNVEZ5jbwZm9JaSdYZWYUW2loLbAS8XlrGRAXxUVnnLL4QZ1hBK?=
 =?us-ascii?Q?nVhU9M/NMAnsaar5fei2MKQm5CXHFPAjPjDCTkgnM2qwa9cxbAicwi8tAfc8?=
 =?us-ascii?Q?DDbY1JT8+8/ny4ThxIYAkeS6CNEN+zzwvUGEfbPPbSfBN+eJChFjdL2U9+fH?=
 =?us-ascii?Q?gmyyZFPK6pSf0i1hgAkdyhXSLwRdC7Gv5htk9GZqdboW2Uz3V565WpA3iSim?=
 =?us-ascii?Q?37wD+31y/MuBZaZn9/DVGapKU3ZK6QYliW0FGlz3qzVA2r0KyBictW/wCWB/?=
 =?us-ascii?Q?Ty+z5j+biARgTv1D2PTaj87TPQqhFtdK58EwXavsCCCj6fQJUdFB/Uz06B1Z?=
 =?us-ascii?Q?stcwvAcc6uNvdWq3CprzDWRRYERrxt5DUIhIW6YcRlZZkthSeZHXxy8n2DeI?=
 =?us-ascii?Q?62BtQbrvrBUYhcK7cIh6voi3RLwS2MeLc4uRd1t9uTJwo/FGi4hBxFTGFJT5?=
 =?us-ascii?Q?lVEIFR3OsvauXr7Jofcovfcsp9aN+CzbvQl4Vp6vw+5z6dqTPdUqhq+vLBp7?=
 =?us-ascii?Q?B6Idb3zsQrS8jIYD6dYEN77j1L+xnKNVJoihSMFx9ylI5yrInV+gMLSq5azP?=
 =?us-ascii?Q?mjZZJw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZzZoY7uhYmoNZ52c7nKuto0TfQp7lfk9UBgLghrD2cyCEeFzNudsLNFGZPJIUE0cKXe72QV4CyVpkauCmn/nMS5TccDbth6yKXrmZXSNj1CA4IBkOvq9bJeyhLKn6OadXgj09suUL5YBEQZlrP+TpD6dfrGZp+E52MjFMrBXnSkvMhvBO6RoJk6VPCt/eRGInxpDJvNcpWrRoWQXpwtk2YnYrSyLUlKlKhaaLoJHAOOjLWBsgGOUXIyjR4IUhIdgECKkWm3DKlBdmDHPq8/Y3kHixf0zeR2mpDaWjoeSjDh0mVaOAf4/RQfC7Z4Q9ZQ71mgXhcBvdXsevgeypqwHArK7Pki4cl40w3BOgRkIl0Wgh3bwSsJquVAjAWkst8rB1HqdbaXTMcMkahSzWcJxxmQhg36eQkSPE3pYlU1fQr1Ey6f32FBtrQJBPSWPdIAV9SP1htZbi1Fbvsj6sUVXcYD7J9KDqCASHVrzkFus+vjX4vI6iCcwx3kzUfJmHZvJU40y75q7tKYLGYxsj96lxjWrTWFhmucPY3Ky7hsKUT8yIso8r7Z/8CBuxy3c/BNG4S2qidQAPoq6HWSqrl77szojJOGZDX/NYHp75B/AZ5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4dbe57-115d-4adf-2732-08dce9e4b2a9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:06:03.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwoBm07tmrc6dC2zz93wZA7ryxgzF1ZXwS+H6QReT1Zv30ndL/2X4NcVppSBlGtqT6OXLO9ssi8oK8Q/K9Xhn2iXMs8eNwCOzwuXBSVq/Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110076
X-Proofpoint-ORIG-GUID: itQfmex1KoEK1Stbc1Vw55y--bxvugZN
X-Proofpoint-GUID: itQfmex1KoEK1Stbc1Vw55y--bxvugZN

If you wish to utilise a pidfd interface to refer to the current process or
thread it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process thread.

This series introduces sentinels for this purposes which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

We ensure that pidfd_send_signal() and pidfd_getfd() work correctly, and
assert as much in selftests. All other interfaces except setns() will work
implicitly with this new interface, however it doesn't make sense to test
waitid(P_PIDFD, ...) as waiting on ourselves is a blocking operation.

In the case of setns() we explicitly disallow use of PIDFD_SELF* as it
doesn't make sense to obtain the namespaces of our own process, and it
would require work to implement this functionality there that would be of
no use.

We also do not provide the ability to utilise PIDFD_SELF* in ordinary fd
operations such as open() or poll(), as this would require extensive work
and be of no real use.

v2:
* Fix tests as reported by Shuah.
* Correct RFC version lore link.

Non-RFC v1:
* Removed RFC tag - there seems to be general consensus that this change is
  a good idea, but perhaps some debate to be had on implementation. It
  seems sensible then to move forward with the RFC flag removed.
* Introduced PIDFD_SELF_THREAD, PIDFD_SELF_THREAD_GROUP and their aliases
  PIDFD_SELF and PIDFD_SELF_PROCESS respectively.
* Updated testing accordingly.
https://lore.kernel.org/linux-mm/cover.1728578231.git.lorenzo.stoakes@oracle.com/

RFC version:
https://lore.kernel.org/linux-mm/cover.1727644404.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (3):
  pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
  pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
  selftests: pidfd: add tests for PIDFD_SELF_*

 include/linux/pid.h                           |  43 +++++-
 include/uapi/linux/pidfd.h                    |  15 ++
 kernel/exit.c                                 |   3 +-
 kernel/nsproxy.c                              |   1 +
 kernel/pid.c                                  |  73 ++++++---
 kernel/signal.c                               |  22 +--
 tools/testing/selftests/pidfd/pidfd.h         |   8 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 10 files changed, 341 insertions(+), 52 deletions(-)

--
2.46.2

