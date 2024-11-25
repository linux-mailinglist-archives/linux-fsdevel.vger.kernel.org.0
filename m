Return-Path: <linux-fsdevel+bounces-35837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9A9D897B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 16:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC431689D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D281B4122;
	Mon, 25 Nov 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kiZv00Gs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lr40ago+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6714E2E8;
	Mon, 25 Nov 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549115; cv=fail; b=lfEkdPW+ol024VPKM7BUxpLc/IE1lZ1+RHaqBg8yOGPQsViA96zEByy0sClhnTgqDfPeZNOsjd7Jq33wWiktgznENjwMG9iZjGlOp5oLL3aTctxMELN7YTEsKkHUADMg0D17+ACPKpL21no8Phkj6/F97qxArwoQBbBuMWwk3Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549115; c=relaxed/simple;
	bh=Qc7/+xDfVufbDfuFRAevAZrTvYbzg8O8PBTkiyg37SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FhlHopWAP/MWE27M9K6vyGlVIWCNWpxXR95QhiQ0vuGJ8aWJi2kb2Bdv30evxveCOCOsqQFg4HOzzrzoI8mvod18z5lc/ObDrqgYv7JpDxoANrFPfeQdKmHvmkKhYei7gEMNtvrkBPMw3efNgGM/WdE8yx4Q2zqIzgU196JRv9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kiZv00Gs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lr40ago+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFUFbW032627;
	Mon, 25 Nov 2024 15:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=rg07o/TxcV/LmeS0Ak
	upp8HB1+qacQxnF7jM8YAne4E=; b=kiZv00GshhhRPrBu9xy6e2DU/6acJZ5PfY
	AAXUD3dtQZIQ2WLtP8pOeMMCsfKaFpwqS1PScb0sbgHk1+sEWslRJYVxNXfuW0/m
	2GB22X+gM1bqyDH2vXcXn54yFnj2z1R+VL9FOBNTZBIhaqcgA4jD0RtpdCuCA67b
	om667RiqPoQI+/Beb/dNXZynSXKeiO2LaT9u/oyD3GyI3Z/CRiBwXQqB241uZkbS
	Y55rAmVsmoRxx4PnxsYT6AKbFR9hfU6iX+1PNf0/P9yfK8IoFaJgpzGOAgZF2LnY
	Wq2PPbsQO0wlHxp4vrjh+FUNlk/h3FZyyc19WsLeQDAAryMkPgTQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43385ukdgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:38:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APEkQOY023446;
	Mon, 25 Nov 2024 15:38:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g7nu64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0Qs4YEWXB8zhOMXbs/76Zo2pBJ0imfhEX0tLfKInu/MOasecboF0lXkjsZ2SOd3SleyONhn8GOE4gNzcpGOVBYLVQeVC+nqZ9aXSOHNNg0bzMj0f2DR26jKW4TOOCOUpjz4OnYSxH27MjFWa8wp5WMoWjjbuaFRC5t5PWyt6Z1LOvbGBGNafrYLgj6tL7vHaKHDmR3AGHhCvPJhQhVa7EooxRcuoDNjWGw4W/v+bJy2cQ+CFZ56+p7m6fuSsrlgx+YMPqe9zyy6cfi/HiDC+uDHnXz9PqDd9Ne/clqRGRzaDavxyCpl8+a6oWDgu441v7I8vFPudZHyZIHGmL2aWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg07o/TxcV/LmeS0Akupp8HB1+qacQxnF7jM8YAne4E=;
 b=wQCE9RQ4RJshjvan5Rb/0RvAi10AcN0awsS5OaKXhQBSPhsEQrCCl4lpwNEv1w7/gD81M0BHBPokA1ZFpNgdHafPxXmkD6qGLX4M5eJz4ZH8fmbhLYBqTta+ZtAVfLnSsA7+J0w6CDnRuGJGYRqjksSAliQOuVA0wqcgBg3xkghxP0cW9CGcXAUSqXDECegJqQ8ikDOBervsS1qyaNuKHPJlliI621Rf0QrNFnxK/d8kH+LzWTNphL5zX7RewmC7DwF6zXk6ozWIGTN+ftY/L4tRxH6s/z6pMnqLF+16PPkH3uZKmmp0Ol0g06Vyr7gJ0htxAw83zIy2PTmQlQCMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg07o/TxcV/LmeS0Akupp8HB1+qacQxnF7jM8YAne4E=;
 b=lr40ago+9TRcKZcolV9bLaDHitel47xdxvVxuSmgN13eMUh7TxUTsIyD5bBWhaJv1B2YmMQKfmDg/mTATNbXkKLsi2YlSQStOX93fg+sYY4ltejVRfdHJ3b3A8LOpFgwSqmrGsFh7ZIWVTE4KEprFDrS0JbCoH5ttRLWctTDRPc=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 15:37:56 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:37:56 +0000
Date: Mon, 25 Nov 2024 10:37:53 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/29] cred: rework {override,revert}_creds()
Message-ID: <Z0SZ0T3UovP+gOwV@tissot.1015granger.net>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
X-ClientProxiedBy: CH3P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::30) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 91917889-176f-4274-f7d3-08dd0d672224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vOLFhWAuggNJ1rdvD9Q+5EO1v2tzeGPCIQas7ydfhqqDckhZVcKUiXBt2j1?=
 =?us-ascii?Q?8E70J7dqK4kwuDfZTIaCyyOpmNp6gC2mdJ9lUGZp47yZa1ffRKF2WoIS15/t?=
 =?us-ascii?Q?4L0jIJ/SSHLZTjv6J2Bwr+xA3Em89rq3Vt68gkhH9VnDM8GmAsu6LlrH9OU0?=
 =?us-ascii?Q?KHNVTWWOufDpVWgfUa+8gwI96gpFO8cXNxIH5D30dNygLMjrDy8YeIK1j4jS?=
 =?us-ascii?Q?hIcCKgdoHRWjey6Lu+Ldv+XFmTE6jE4Rn9XHbrqmRZVNJZMwmsTqRKp3UE1w?=
 =?us-ascii?Q?UkwlzDy93Ih8jauN+8qWVMXwoZp6IuT+ROjcUqKVAzwOnVHhcmtLEuHTf+7+?=
 =?us-ascii?Q?fMK2EeJ/trVbMeUN47P6HqB9hOWVl56PS50QpRsgXS+c4hJaXYIGRlGEoE+R?=
 =?us-ascii?Q?OGplKhQ3oLsI+vsPA+ziXGjCwLLZxWoSSAMSzd/OtSO0oe5emkoZegosO393?=
 =?us-ascii?Q?Bw4zaQVJJju7wV+JpC8UL+l8DkQI0M9T52kOvVH/HSgpBFdT0fuTbwaJ3gEz?=
 =?us-ascii?Q?gRbF92KW8ByGqo+Bu9VKKBL7EbVi2otjB3ZPn7A1zdjN3S0t5+tNe6JNL13o?=
 =?us-ascii?Q?y5bV6sDZEidV17/uGPBFUOGXuwG6NmOXeZii3g+HUFWV3nIOqic8l0XTVdX8?=
 =?us-ascii?Q?Bvc6dwcqCsQ34S2GtD+j8gc9vmycdrtPigA0TIO+0KQJm7C8ptI4k6GBfNRE?=
 =?us-ascii?Q?anab7az8xNF+U9CwmWIS/yqfIuLkSyTeyQT3e9Y0eA9WBoD6KrtGF0McEIvl?=
 =?us-ascii?Q?sce2YQ2/fDROPt7gxLxfqbYhxRVK5Y2XdyteJ46h07KO+RlpI/MU/+YBDc+P?=
 =?us-ascii?Q?ewYT4DYt1kwRZ7FiK+unYmo0vuyKKtbZ5/l8FkMyo+yI7NEWuY4Km0O34dZV?=
 =?us-ascii?Q?qbfjlJ0K4pSyWgfnbvZ//CI417518YQ8hjBDHQYIY2AnwuciuL9B7gTPu49G?=
 =?us-ascii?Q?fwFSU7+bYcJejbDPOGbtGgRlAqoMiLwhE9qsYC9tB2r+V7n/nVAD2iBTmzfk?=
 =?us-ascii?Q?9cLXT2mWTpw9+por/lBOXDokiNCG5QShmBTQjieQMwtAnXXQyhd436XWNlJX?=
 =?us-ascii?Q?e4dA4lAFdYHoRnavvsaSbL+wqr+fTPwHP9Wbwf2QUpqDI11GKtGH9gHcJLQf?=
 =?us-ascii?Q?Keg8nU/vNnaRUKAg2tCtDMcZCTzoZTZgNibEyYMmO2K0pRGA6J4FTSmbaUO9?=
 =?us-ascii?Q?wSSKt8lSQejfITKGWkxSF4VBbZgQNpUFAEr8AIuYIOmvDziHqWBB7/bJmAki?=
 =?us-ascii?Q?/p625pYwsP1lnwjv9maEX/qmRzk4Ip4bfqFst5JGhXlbwcqq1i4xAT2SVIVK?=
 =?us-ascii?Q?y8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slxaNaQjTmknx6kBCJcPlXh6Z3Ov1xpa17o4HI+5Hu4RgYZAt3Tkue7Nx+/X?=
 =?us-ascii?Q?RUqNYn+HMNS2wUcLO2Z/20M/Ea6/KHkz6hmutU/7eCnG9Dir7QRw0ouEpQAl?=
 =?us-ascii?Q?jUzUygJlmXwP1VktYRyBFmir2qP2nruXaNGWx8FjJ11GFB4IhU2u/L5G6ILI?=
 =?us-ascii?Q?O7GQY3sRv1XCABCVxoIyXUGqqdggmmXdt5yXo5dPG8KsVbAxY5n+XQjX6f/N?=
 =?us-ascii?Q?ZTg8J1VG3ZlVRw3DsKkAw0S8o21Zz/XBs94CM+oZKd5tmskt2RFXl7v804Rz?=
 =?us-ascii?Q?kj1XZfY4v+LLPy5a7SN5q+6o50MBCB/ai2CDProNg3uQPkhEEaf/p0NcgaMD?=
 =?us-ascii?Q?Gpqpf+0eyZRnxzDBoU/mfDoCPWPkDqITn+bHjNsXbPmbOAxX5/r2lHmFSakS?=
 =?us-ascii?Q?Oth2YgJ8vWY1hdUgGEgJoDHmHK37DMDDNk9hzZ2xpKWNC4NAgZv+t2mMILff?=
 =?us-ascii?Q?BbFdbQ5WS+KKaEdNmezmy52I5z6TkItBBAizFI0+BXeVcG83coKXlAvnatIp?=
 =?us-ascii?Q?RmNUsiPFoAdSS40iezRFRaaIqSQCsSxpePNxFOxuLf02akVNxmwd6oJ/s8fH?=
 =?us-ascii?Q?32GmBqPvq7RjrEcBadQ1k2hayQ2c18hYO9OEIyn+hYSMhaqy5HG/5FtgS1mL?=
 =?us-ascii?Q?hMzDk9sn8TzQxjlRff15jWgEdsfh7zKDU8Ul2CNa1EiyjdMIfom3hM6iN8aY?=
 =?us-ascii?Q?QR4b0PpZ4LdBwGBFb8LVuI1zoLuexDGg5EVCzpchVeiQTq4TZvtmiR0Q1xTT?=
 =?us-ascii?Q?HOcFe3M+txsmD6V3b6baRxCsuojuodH79E0X2TAxH2x84SynU9Sl3JXcqOR1?=
 =?us-ascii?Q?+vSgn87fZLHiUswcfuWGl4yyvM8LgmMyjd6owzGT+htD8ChU0GrkTVpH76/Y?=
 =?us-ascii?Q?RzClHSbn4XLR53uj1MKTtTmyjXhyKZi1DrL0NY9+bAF9PBVxQ9O2XmtkXP52?=
 =?us-ascii?Q?zuTuQAqqAc1qVDaaQqp29OwwSAPvushFO2FEcyUmchfvtziY73y35QfoF3ze?=
 =?us-ascii?Q?yZXZnY0kpKnJtFrUdP7YaOMir5l4fxN4rBOvuiF0wjAyRFmrzYfvUZq6uZfK?=
 =?us-ascii?Q?sBSkHGLeIa5zH0Sid6qqQomiPUO4iVoTLS+RL/tugz68ASvgODODw7p+mzLR?=
 =?us-ascii?Q?uJgVDrD9xdaKc8k2e3xMJ6Qq59xFo1SqfuehzHdCkgAzZpsXrsJBx+pR5pP4?=
 =?us-ascii?Q?hoyTd+OuF//+6qa4cB0QN6i46wMdZPAb2aqzTvOTgUvmQc9QFHoIyLpxc4le?=
 =?us-ascii?Q?QmBa9U9d7ULMTda+mZOlXUzhISHSMq9l+VCJL02PebJBwQqi1FpNzyfZO/oQ?=
 =?us-ascii?Q?a4BtcpmGx+oP8EoyS6UdJu6rqnkNRwsYUNE9lRJ8VY5/1NB5RoWYpPTLIaxL?=
 =?us-ascii?Q?CFi8FLq4WDptBg5x51SLvnomRIdXF3hMTUQVOo7kd4c7ivSABfDmYgcboEnu?=
 =?us-ascii?Q?FPGINqty/X298xhZwoulphnMqmfxs+kj404nRmMHfqMJGXStO+hKSIlCUpsK?=
 =?us-ascii?Q?fHw1nMLogehvErSOOe8H6F6rUXdjd3Wej8cOgi/zZjGB0Jmg7SAM3M8glYkL?=
 =?us-ascii?Q?jDM5cmKoH0ZrinJow7DrCZtx5Gi4faVaQXXV+tNO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kxXCWI5HAMQLgnediDfg754OYcypu03Llvl11tLgkAhuMvh7vQgXJ6bX8VFvzxyb/WdheI0IQqG5aIvc3quG2QgS/D533wZEphrwteg0QBdSBrZ0LTlzxhzKGUETZATByzf8yXQt+nyObV739EGe7R9sMWCbsEi48aWvaYStsqsWwFWv9nDK4/W87QDs0tXTNc6zuj2CWAwCAHHVOUG1eOQ3kQnRbM96eLCupXGAMn7Aa+LFk/bM8YrW+oPUQgc3LVMjUZZK1Oe9nVQHAZfu0vijsui1eVT7W3sWaLVShoi0vmJDtgLGNkfa1HxYW8qF1NuQvmjNuesf1IZsL9mWpS47BQeSF7hHqxstfcgBBwQ3Mc5s1JQ95tuteBthLAMRZvvjlbXdtgvDcb4UHyeL0a20REomHT/9d0qtzF6FVmPo7z6saGm5hF2I3pFkq6R2YM46LA9G0+iMRGv1g6oKyl4jmO7E/kZtDxdEcxKzNt3tdNc+bD5qrzYTg7TfAIOtU8EoaneibyufVMm3nfA3pjXiS3dF7kpV92XGxwhe4Y7bRMBKzUsA+OOdf9BmReajcTyGNcsZ9YuYOcS0k7QB351pAS4sn24SCO0F7gr9Zws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91917889-176f-4274-f7d3-08dd0d672224
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:37:56.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a/kFai6YPewr1sAEPzkIveD2P8f3Oee0FcTe2dEOC8HWw+HkEd9aJOSYwAzHS9rnBaBLCztu+Ih1vWsYxJ6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_10,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250131
X-Proofpoint-GUID: iJscsozRU_JUCkcOVgtOivrBLI_tLV7h
X-Proofpoint-ORIG-GUID: iJscsozRU_JUCkcOVgtOivrBLI_tLV7h

On Mon, Nov 25, 2024 at 03:09:56PM +0100, Christian Brauner wrote:
> For the v6.13 cycle we switched overlayfs to a variant of
> override_creds() that doesn't take an extra reference. To this end I
> suggested introducing {override,revert}_creds_light() which overlayfs
> could use.
> 
> This seems to work rather well. This series follow Linus advice and
> unifies the separate helpers and simply makes {override,revert}_creds()
> do what {override,revert}_creds_light() currently does. Caller's that
> really need the extra reference count can take it manually.
> 
> ---
> Changes in v2:
> - Remove confusion around dangling pointer.
> - Use the revert_creds(old) + put_cred(new) pattern instead of
>   put_cred(revert_creds(old)).
> - Fill in missing justifications in various commit message why not using
>   a separate reference count is safe.
> - Make get_new_cred() argument const to easily use it during the
>   conversion.
> - Get rid of get_new_cred() completely at the end of the series.
> - Link to v1: https://lore.kernel.org/r/20241124-work-cred-v1-0-f352241c3970@kernel.org
> 
> ---
> Christian Brauner (29):
>       tree-wide: s/override_creds()/override_creds_light(get_new_cred())/g
>       cred: return old creds from revert_creds_light()
>       tree-wide: s/revert_creds()/put_cred(revert_creds_light())/g
>       cred: remove old {override,revert}_creds() helpers
>       tree-wide: s/override_creds_light()/override_creds()/g
>       tree-wide: s/revert_creds_light()/revert_creds()/g
>       firmware: avoid pointless reference count bump
>       sev-dev: avoid pointless cred reference count bump
>       target_core_configfs: avoid pointless cred reference count bump
>       aio: avoid pointless cred reference count bump
>       binfmt_misc: avoid pointless cred reference count bump
>       coredump: avoid pointless cred reference count bump
>       nfs/localio: avoid pointless cred reference count bumps
>       nfs/nfs4idmap: avoid pointless reference count bump
>       nfs/nfs4recover: avoid pointless cred reference count bump
>       nfsfh: avoid pointless cred reference count bump
>       open: avoid pointless cred reference count bump
>       ovl: avoid pointless cred reference count bump
>       cifs: avoid pointless cred reference count bump
>       cifs: avoid pointless cred reference count bump
>       smb: avoid pointless cred reference count bump
>       io_uring: avoid pointless cred reference count bump
>       acct: avoid pointless reference count bump
>       cgroup: avoid pointless cred reference count bump
>       trace: avoid pointless cred reference count bump
>       dns_resolver: avoid pointless cred reference count bump
>       cachefiles: avoid pointless cred reference count bump
>       nfsd: avoid pointless cred reference count bump
>       cred: remove unused get_new_cred()
> 
>  Documentation/security/credentials.rst |  5 ----
>  drivers/crypto/ccp/sev-dev.c           |  2 +-
>  fs/backing-file.c                      | 20 +++++++-------
>  fs/nfsd/auth.c                         |  3 +-
>  fs/nfsd/filecache.c                    |  2 +-
>  fs/nfsd/nfs4recover.c                  |  3 +-
>  fs/nfsd/nfsfh.c                        |  1 -
>  fs/open.c                              | 11 ++------
>  fs/overlayfs/dir.c                     |  4 +--
>  fs/overlayfs/util.c                    |  4 +--
>  fs/smb/server/smb_common.c             | 10 ++-----
>  include/linux/cred.h                   | 26 ++++--------------
>  kernel/cred.c                          | 50 ----------------------------------
>  13 files changed, 27 insertions(+), 114 deletions(-)
> ---
> base-commit: e7675238b9bf4db0b872d5dbcd53efa31914c98f
> change-id: 20241124-work-cred-349b65450082
> 
> 

For the patches that touch fs/nfsd/*:

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

