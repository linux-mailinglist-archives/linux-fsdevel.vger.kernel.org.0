Return-Path: <linux-fsdevel+bounces-50070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B52FAC7EFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 15:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D064E8031
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD9226D1C;
	Thu, 29 May 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OkbyKRgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012055.outbound.protection.outlook.com [52.101.126.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C2BE49;
	Thu, 29 May 2025 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526357; cv=fail; b=YWXRK/UxgUSNLXfbI2llqDv5qYbyl75GrvgLimG1pkKV7bjx9qa3UZ5jk0g/rtW9HIj7xOzCnQc7AovlHcL+kUipdJ3BEetf4MW1smAUAN4gp5Gd3BEkf9nGqB9/naN+aybbubndl6oI4ubhUiItc2Lbh+xMsqs2kJxl66c/HgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526357; c=relaxed/simple;
	bh=UpOwIK6gjbNWwQQZ/oztXy05DaHe+Z+uiRiz8Z6Txq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cq0SPt11TH0zfTkEpwDEJIkCEBaAydRHliAImsjUSEE8pcl9DaYCIFBb4tOEtRViR/EBqk+Msqo7b7KdNLbjFpvcP4729LvLd0vKe0oSQAGVTdmSGmEqQH5WC0YhlkH2uJoXRDH5lxVugdQfaCOCPjHeWeC56mNxbpXOTp3FzKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OkbyKRgJ; arc=fail smtp.client-ip=52.101.126.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS2pHRmz1penpPdIXdGyCtcWYFb/SxF9jeu+/zMk5Zwp4QCT3L++07sSft9p/LaZK16LgFFyz24IRVC5PYXxNQwq6tVPPganN8SRdRpQiOo0ZB4B2zF5dRfjezOmn2Q76NiIZywZxY1xo4Ynp42vG9i3y21iRR0OVsJkUfOkq8pknUpYKNTmrc21LPsBKolqWtnn/57yOGXjv3ybnrisKF0wLW724GEfHvUzXuzdOtnUxhglA07ImcaII1y6kziOaiPzjo6dgRHLzYu5qV7NrDQkkm3miqnLzQqjc4xv0KKSASyLXy85ynTRvN5SbhqduJMgJ7sLhNGp5rO1uF+vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpOwIK6gjbNWwQQZ/oztXy05DaHe+Z+uiRiz8Z6Txq0=;
 b=UCnMXJpUG6R5YVb1kw2dDoShMriAxAlYd+fKYdn62rN1Ewua/dYRsL4nYMkr2khEZBFtIyWiyBHpYArUdk/rMsm8b6Zo5LRFB/5rMitFPWncghVP0TIPGItKfMQIp220Y0V2QcfcsxRWyzYK6p1bcwsDQeHohRpGPLUKOS13CSdtsJZifNDzQSEFT6FbXmHDwM/ItX4ycFBXy0gf8RWoy09pgvInI7VAfjad8Bnyn5eVZ/T0pnSXYxAafaPaYmMnEgO7fRiHkt/wGrhNFI1o+KDGM+AZ0lxFHeYlJ/JKwhCd9+BX5Us5xjdgxm58WfFk0rBRuFLdv/jFXtouK5j+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpOwIK6gjbNWwQQZ/oztXy05DaHe+Z+uiRiz8Z6Txq0=;
 b=OkbyKRgJPvmIv4QxxPpOmoqhtGDlSOzDcNHy+bp4A2Tt61jl23J0/xQYOUcdXmIaT3k4qBzrLzY7Nh++VxBVm9oeIiGPQwvjJFis/y6/so47Puvzx8HohxMLxLUWIFbPb2UgbqpCvpbTiU6Acaut6GchFZmjVUVn5H/3BeDesOY0m7W9H/UJCfzORsqzmBZJLkk3wF9m8lHBRwdht7hBnyAYB4/xDB569rDI4JCdM8enY85YgOFEzdmN2zWHtjSAYg007LfV1ewI1PTl8GU38SN8GsHyXyVgoRfAt7PSTTLt9PDIimnI9olvZN5UDnDaP4tADsVuNHtoQjg5L+s04Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 13:45:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 13:45:51 +0000
From: Yangtao Li <frank.li@vivo.com>
To: frank.li@vivo.com
Cc: code@tyhicks.com,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Subject: [PATCH] ecryptfs: make splice write available again
Date: Thu, 29 May 2025 08:06:28 -0600
Message-Id: <20250529140628.2297560-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831033505.23178-1-frank.li@vivo.com>
References: <20220831033505.23178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e3569c-4d91-4b25-5349-08dd9eb71fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CG5cBDm369fpPrSrdkfq0KiVPsrK1zbq/g69rTBwGOHerL2LNRe12LsfRQfL?=
 =?us-ascii?Q?2Lqxb1Zbhimtb03+LPyPbUL4APt0/JckT/u+6VvaHJJ6qHsqowdiMFZI6i73?=
 =?us-ascii?Q?jqU5NmWdkVeM9uvk6K2dE2nCHzxlJ54/ntSd9HKYFlXF7doVy8g7RR5XPmKN?=
 =?us-ascii?Q?mSXMaHT2qJpoQoop+jEzXipODdrPmx8MnNPLMbVyJwKm3vshSJ2UuG4ERTuE?=
 =?us-ascii?Q?lF0Fq3KlTBM3ip6NhcpXKsOXCU3ZrasM5h8sfCqqzvc8IjnJ3Tp8LXey2y5z?=
 =?us-ascii?Q?CMzblShMRsXnKOA0dtRtx3zxUyXR8tjnBWHWLyEdQNKLvjzeZb+hnLRY1WJx?=
 =?us-ascii?Q?BKcU1SCVIBbWFiBHowz61niEorJ/XthdJ3tgMgjTLnDJomGUSkU2PMN+Z5f0?=
 =?us-ascii?Q?xYvkixXfkXz9I1q2lPbgfqOk2GqF/I2hbIbhw+HsDkWDi6goJRoppDtnvabm?=
 =?us-ascii?Q?57hYSFpTv2LSxOKptE5kJnp/V2W+I7557CECPt/s8P1oyRBGuQAoY2o7y9ki?=
 =?us-ascii?Q?BbnTL7ZtAQUHT8uQhEY2CMh491Bkpk1+VabxniiekC4zbW3rLdZV9mZCudMX?=
 =?us-ascii?Q?KMGWdNiRo2P86534I9t6XinoV5WpcOaodYKwf9WB7es+VjMaxV2RW0GsInFm?=
 =?us-ascii?Q?vcxc9VnRf0KRnZjnbHEqzouO90P1Gd5HPd1AFgeV/iFxko9tMvKtqgboRhoG?=
 =?us-ascii?Q?paH/zo4DtHjXUynAvOEdnb7BHx50F7+HqgKGVpzkdxKP6LT1T841MQC0t+Sb?=
 =?us-ascii?Q?AFOQcBSzozz9GEejUQ+T41Z91YwRl0GeFmJtQJWaZVs7Pu6kYXMq4JCCYVhX?=
 =?us-ascii?Q?dR9EKQOf3JFVrY1b6GzctKv6l2P/EnJ1wjteTg1KRseaLzQbterjyUkzZ7cS?=
 =?us-ascii?Q?+UilDEJGQ/E/ReGnN4ffXakCiVghAUmHJX6L8I2Vh8Roq+8zcFD7m/OQ237r?=
 =?us-ascii?Q?QzDt9PWDi30BpjkQo4QjED5sY/dq+EsRhQ81aEhezxqm1BfHP9c1EAFmeG5z?=
 =?us-ascii?Q?bHvGUb1YdPs8NMIsE68d5jQJJMhecSTXEEwfeoogdcXCPbs5ToMB5ADweBbP?=
 =?us-ascii?Q?U739uY9S7Um79Lid/hHW9W3ZhUxoKZnQQNdfYmoL6IeJNyfPRthub/V0al+l?=
 =?us-ascii?Q?7LCYH9TKexlgOGwURcVMjZJPyGbcXDnFiR11Y4s1TN9KAEPVMBew9Xp/GFW5?=
 =?us-ascii?Q?vekL/9rNcF+ddJ1RqH/HTSu7DKVezQQrnI1TY+cK+YB9VeXQyyB7ANcFoqy/?=
 =?us-ascii?Q?NJ8PQl1JYB8U8ekTYbU4VCDFqZFycQ2OjurJo9vu1R7dKxocQ74kjtx+UHNi?=
 =?us-ascii?Q?tnsxYrI0/kbTZyzUnoYZdCTcip5V2pY1yXwFzUeS467bSyLSpK7npaW3cqrK?=
 =?us-ascii?Q?51at1FO0NDQOPWp4do3rZ+vAH79gnPRYiGCC2fcPqFmfH0knMkJGw5Ag34/S?=
 =?us-ascii?Q?iqAJZxjnqkdXLOsGOqB021z4fUEZ3jDM3XA+EqOrR2Bj3XYkpgBtnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ppzx6QCaAPQXA1Iq/TfGdemjUa7A5aHUylNvy1NHbGzPEDEaMRIi9B/PVXh9?=
 =?us-ascii?Q?AuwKLJm/b2IrKPXF+tkj2GZ82Ig1StFdmBzN/y669fZ19DM6RZt3KGcGL7qW?=
 =?us-ascii?Q?c4XFIYOppmyrOVOsDgtrZGR5xmp/TdJvcm8OM32MFpz6TcGirtkw8hyrFYUw?=
 =?us-ascii?Q?DQaS9DLVjXaJV7d6I12Q+AYvvG7frwZD3j5oT4j7vzEiPLrhMxKuYNOGvgvC?=
 =?us-ascii?Q?bAJpycRARf/VOTT4PHteaYkLE2fFXVU3D5uMQG1Yc0gIOWXYNxMDgD19VN+G?=
 =?us-ascii?Q?7cxE2NV3NkfunDha9OKXLlN/qXOuQnud0aJ/EKv0w0/ozMu+Xxbsa+O0DiTv?=
 =?us-ascii?Q?C/J0CPeij7akOc5bSco866+Xl3IhjKAhD5v4AabjM2jzotAsi9CKhg5W9uF8?=
 =?us-ascii?Q?P1fWiQKRaQFLABjgB2Wp3CpXOeGng15E8B16U71nhEDNApGpj9HBHvWGiW7p?=
 =?us-ascii?Q?4+IjZyIrk7gQvYc9y+KolGFUpujE5nk8sMIjCOISfBcNxdzQkpAM/TKLQuya?=
 =?us-ascii?Q?sYug0eClQtgXNgQrBpaAlnkyDKGpv4XJ3ksSe3+BQPgeZVzn3Y9qt9Pg1YaC?=
 =?us-ascii?Q?KNFcM2fZV+7O+OMDcroPsgadIyQs3M0k3r9F4R+F83hozDiZXUOJIubHmnVY?=
 =?us-ascii?Q?nxMAXXdHMBGUiQj4A5TJ9wjRHdIBGGz+qyHUWuQi4m6Tmla2I2o/YT3Lyh/Z?=
 =?us-ascii?Q?ZnPsLAgvAKSCJfpJJKvvKKf3tLFlZ8R7ehMl2UwhtUYwkgwhQYN4MvtLJRNy?=
 =?us-ascii?Q?Ynn8bn4xrNafM4Ot4FqeXmqj0Z0NubGV3Eswc3nqV2LBrCKgRTH0x7pjlmY3?=
 =?us-ascii?Q?SCcBCcj3zFokaQAkEj+oOVz4By01ShAhz8o7Nsper7tcBh3vdxMDC+ejMKSt?=
 =?us-ascii?Q?3TjdRHtHTIclEidNPWFDWMtJ9Yr18o3ldlQlt4VGFEjqR/vvzQifSvGQ0jbG?=
 =?us-ascii?Q?7WUbvR5qOXUNNBeg6P97YAe9exSGSZovxPfuMWYHDthzjr7+rzl9f3fkjlbS?=
 =?us-ascii?Q?K2wXzdd/V4fmDm9EP8iZzmBqXZgMmOJKEPyZoQsGF8wg1Z63YQy4uW2GFxCe?=
 =?us-ascii?Q?ka/WV0HjLzYrC0cdilAlVPO/OMLQVeIiCfX7gxcSM0s2YBbLEQOYMaPhVoPG?=
 =?us-ascii?Q?i0bYv0GFQlNvTFgJf0Vdp1VIDCdzKjn3jpWXXkppsbompjh63XStpF21AnBe?=
 =?us-ascii?Q?J7Yi3xDN0H24e3JlfgnmRle3t1A+1T8Jhy6BRSQ0HpMeTYk9EUhERQQGQOFC?=
 =?us-ascii?Q?MX5pYbtP2ImFPCiMf8SHTaWuPXUp6L1b+4RGvhD2zr8xecTohYr/orcPNEFf?=
 =?us-ascii?Q?FX7svrn2SUTIQlDqlylLyhxlpBvtD8OFCXo2QG38S6zglfLH9KUZIWvUmN16?=
 =?us-ascii?Q?gtdXN9H04xB8QibeiP9aE+DhDzR9OZ3vA4mrsLvFe/R+QtsYRG2qzqGes5gD?=
 =?us-ascii?Q?zwiPyboQJ+SMq1QV5Bic2oRzO2RReU68YRdUBtQkOaRCNWz2BrKRb0j44E+t?=
 =?us-ascii?Q?jM+tVTU9oXLsxLsNxVDz33Ezxgbokw9GKPUF8cQRKMk234GK7rZuf/VpzWMc?=
 =?us-ascii?Q?ighHN4tyoHAw+5Y0yVwU8SB8sd5nWbVZ0XUIHOJZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e3569c-4d91-4b25-5349-08dd9eb71fee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 13:45:51.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OveEQxITifNRjD6Y5uSG9+L8Mt6MO0oPjgPKJuc8Dl01pws2Rsj4QC8bXBCmPuxLW6/TlgMQIRVRwyHUMMLlyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034

ping......

+cc linux-fsdevel

Is anyone actually maintaining ecryptfs currently?

