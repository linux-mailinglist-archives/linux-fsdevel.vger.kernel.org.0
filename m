Return-Path: <linux-fsdevel+bounces-51107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C96AD2CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517BE170427
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C125D1F3;
	Tue, 10 Jun 2025 04:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C37wp/VM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C37wp/VM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60421322F;
	Tue, 10 Jun 2025 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749530509; cv=fail; b=jW3zeQEiDoG8fidCMQDj7nxrKnSEf1Gd1eDjVLJY7q3nXTESby5ArfDgS/p1SRdIshjnD57CWL8Nm04WcTQVO6NOUqcb9sNqgtnMc7NQCcMZ2+s3kUy3vFLL+LFDnHHaWD8yKWVfxQ4YdpTBMB0Bs5QI5XxC94M9uCXxZiylXFs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749530509; c=relaxed/simple;
	bh=k6a9IZrxC5PGdMK9Pe6Tly2cVM5Jm1td7JufGLMNRo4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7g6cqVvdXudTUaZA+I/mbtkpOL6wLi8xDt35StszJPImb/7s5+8iamqcHSYMAcHGlPGvJbflrqzW4G5XC8imiCp3k60Z8xlctA62kva81lvV2M3mnAJ86UfLfsPq0X/+BsnrO9qKVjHa944zMCNiuqm7Byhuu6iGv8++NCm43o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C37wp/VM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C37wp/VM; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Z0z4HokOFkXGvnkJAPCS05R9YQZGiheRgmwFG71SNtHQ75/F3rWzPx0k96FaKKm7Gyu1ka5n+JI6H3zscloUXzpgOSzcw4sSye3Tz4cxwr5TbSXz1PBIu9z+lVsLHnkQNpF/o2Tv5jJRelNQk7gXSFGcW/tY9xQeUadgOw4Ec1XRZ/2c3WtXdFPvSGIB+qgFEGqKHcacMGCdGkbIEH8LHF4NpvfMtonkl0XA7JPEjvRC3RdpKRlSfOp8xNpOljefqr0/ND3giurHEpml4SrY3UkcYfky6HzaUWDZBQxIyHufcqYpc9ql+TfI7zfjxEkCenhtSBmy02dMQbEZq7hNQw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6a9IZrxC5PGdMK9Pe6Tly2cVM5Jm1td7JufGLMNRo4=;
 b=P9nSHf01eWqFwG7TJFc5K62uujH6+um5UXTIv3ahKZpuDIQcV4xGk6ZOvnu3P/XQu+qmU1T22dS+gMUe2uxoYxml4hX7ctj/jkOc+ewXJXxZjItr0hTwdNR7V5z74ZHkwsxIOvaG27qCJaadaTJLKdVMd+2OEHtueBr74gEI5bsBuCmdSx+59Ddvr+5mHwJQtk3PXLna5ZQglbTJNLuqhsG89M/SO+tZSX+tn12psUUGUqCHUABkK+qOD0BDLo8kR+VuIHuAJURf9YtHB47AqkfOcVohJmCbfmg1astH/yNc0iapP5rMGf/6NgHWxEyHGhKDZeVYubOH5RvtHFbcCQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6a9IZrxC5PGdMK9Pe6Tly2cVM5Jm1td7JufGLMNRo4=;
 b=C37wp/VMBn6d9PsYuIWfZgZa4Hy1XqJdJS/Nt3+Jz4Qcj2TVH4Fb2Pd+hmaJP3hj8JFC2n1+08ZUZFwh5jkj56YYPC2PrOIUWroeFV3ntfPppS4sOS1GnH19ukjymdnKIaCv3ko9CxaqlOPbGvz6PvMTXS9PD7fp1kWON581Miw=
Received: from PR0P264CA0273.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::21) by
 AS2PR08MB8903.eurprd08.prod.outlook.com (2603:10a6:20b:5f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 04:41:42 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:100:1:cafe::e8) by PR0P264CA0273.outlook.office365.com
 (2603:10a6:100:1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 04:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 04:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxybYAZfsFkh7ypPJajv/0LvCjNq7uKOnGYa5SesMvdZ7Mp75d/s6D4BA/Ebu+X5mrAjB1E0RPKUw/YzCVZ355GZzg9tgedEXDBhwhCS/Z+yTMi69gaZlDJ80MOIxQktP98GPQqUnqTIM/WUukhVsI2UjN1q8tI+Pj9NCkutmzF75GcjgWby961P9EWvZkVtMLF+wTyu+86SS+GjXSMUMIjPfKS5OqrUlBWgA1sm72lD4qn+oFy1ePVbGM/O4cuarqGiq+cs3fNjmHA4Us4gWjfhb5oOx83lfPO9Lt9thDZ07F1vpu5elpi0llXU0U+iQkVTb5hq29ODSSPRUXtD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6a9IZrxC5PGdMK9Pe6Tly2cVM5Jm1td7JufGLMNRo4=;
 b=LWGtqnE72snjSGBmgF9vsK17pLZVYuH6AyI4xNHWbGrAiNp1yWgmPYDsNKy2PqaY/94m10NxOBjGD7+s74vT0OpR5hcLCFxA5kqOfai3nI87NVABSEz4y1/53x6X0i2AqcT4hcZZ6HgHaOBSDyLZQP7clbrR8q5C+mE2daoKN3wTR19VzsfXgvhXdTpWNyvZTyXCiC9HgXV6vedV7aKbVCgla45M81zsI7+PSHGppLEMlYU6ZJVhR0+1QJ07dWNebVMHFyqQyORJBl48Mr11h6/nBgvhy65KnTad1VHKAdM5VoNeGXVNE76mg3VaV4I/Uorif+f8sv3Vre7w3trQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6a9IZrxC5PGdMK9Pe6Tly2cVM5Jm1td7JufGLMNRo4=;
 b=C37wp/VMBn6d9PsYuIWfZgZa4Hy1XqJdJS/Nt3+Jz4Qcj2TVH4Fb2Pd+hmaJP3hj8JFC2n1+08ZUZFwh5jkj56YYPC2PrOIUWroeFV3ntfPppS4sOS1GnH19ukjymdnKIaCv3ko9CxaqlOPbGvz6PvMTXS9PD7fp1kWON581Miw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB11026.eurprd08.prod.outlook.com (2603:10a6:150:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 04:41:09 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 04:41:08 +0000
Message-ID: <d289f57c-55dd-40cc-a4bb-8359ee61e8c9@arm.com>
Date: Tue, 10 Jun 2025 10:11:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xarray: Add a BUG_ON() to ensure caller is not sibling
To: akpm@linux-foundation.org, willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com, ziy@nvidia.com, aneesh.kumar@kernel.org
References: <20250604041533.91198-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250604041533.91198-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::6) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB11026:EE_|AM3PEPF0000A794:EE_|AS2PR08MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2ae826-2126-4c52-1d97-08dda7d91858
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MG5uVTBQMXJLQXUxODJLQ0ZQbjZtbC9jcUMyVERxcWJBejVYZEgySXVrMkoz?=
 =?utf-8?B?NlREUTkrN3hjNXNMOFFoVTU5RDhFRUUreHVJL2dDa2xmaHp1ME5tNFpHUnZm?=
 =?utf-8?B?YzEvdVVzdXFaeXpOcWlpL0NScWNIY1FKQkJsYzlQRUg5bWladStCb2NkNm4v?=
 =?utf-8?B?VDFNY3YyVmZZeUdVT2xPdlh6SmhJeVBGc0xCc1djWis2aU5CRnFaZFR5MXA1?=
 =?utf-8?B?d2J5NCtUTzFuVklXVUM4UDJybUlkU1ZKbVBoSnVaT1hlMzE0RUNlK2xnZnR0?=
 =?utf-8?B?K1AxMDd5RnF3Y3ZsQlNhQlBqUisxWXRPMnA1cHRVL0lYc1ZFbnlORHJJaHdM?=
 =?utf-8?B?Ni9ObFMzNGhOWWxQTTlBeVJxNDRZTFZ0WlNrdkRXOFA5ZXdCdEt6eDVxQkty?=
 =?utf-8?B?R2pHa1U2VytVVmg3TWNDNjNENGtzRVFYVEdFRVcrSTBQN0tSRVg0WHgxLzJF?=
 =?utf-8?B?YzIvVkk2QzV5d3d4ZkU1NDJReC9YdmoxUmJhVkdhTU82MzRLYWRmZDh3aGpn?=
 =?utf-8?B?ZGFLNDAzTzQ2QnFzZFE2VVJGU0doMlp2Sk9UWWVOeGNkRC83ZFVvUHZrV2g5?=
 =?utf-8?B?aDZDSG9jR1dIdzFVY1pVYkV1K1h3TURTUCtSQjk3NVhvdGhUL2pCanprOGNu?=
 =?utf-8?B?Q0p5WHdUQ2hhZzZ1MVZPSitCbUppZVYxbHBCNUlJU0ZXQWJiSjdmMkdaZGR5?=
 =?utf-8?B?QmxpaGcvZVpaUXRpeGlMUk1WdHZJOTJkcnlNWVZKWUpDZWJOT05KL3BvVnc2?=
 =?utf-8?B?dEpXZTVMSDRiVFVXWnYzRlYrRiswSTZCT2x6WkowNWc5VldYNnRzWHFrbFZV?=
 =?utf-8?B?K3FKRUhFNkZJTkMvb1dyaWFTV2YrRjNaNzI1S2l1N0tHaGtIVFVrZUt2Z1hh?=
 =?utf-8?B?NG9UM3VYTVNKMkw3NFZxb0Y2eldjQ2lUeWFoMlUvMVRPYnVtUkQ1eDdESXc3?=
 =?utf-8?B?MVpzNG1zWFpENHNrWnJhelRVWklKK3Bxb3N5bUtBR3ZuN3JWRUk3dExJZFVG?=
 =?utf-8?B?bUZCM0VuejNwOG1wM2JwWDQ3THB6M1h0RTFOQXlTRFRON3lyTkRtY0JYelF3?=
 =?utf-8?B?dHZKRjdCdlFGcVFIMXhUUGR2RDh4empxd09YYnNhVVVKVDJMdEp1dFhDNUFx?=
 =?utf-8?B?RnAycHc0ZmtiajVZU2F4RFdWWWd3QnJkem9FdjgyV0QydkljY0t3ZEZlOVRV?=
 =?utf-8?B?NWwxM2F1ZStEcEppWThTN3lqMXFpNENwQ3lqcTJkWnRUYkFET1dsdC9wc25E?=
 =?utf-8?B?bzJQam9XNHl2cWxsZXo1Q0hZTHAvVEdZRmY1MStUWWxVM2xtN3RBa3M0aUNJ?=
 =?utf-8?B?YXdVeHpPUWRkMGJ5c2ZpdG80SFljdzhxNkJTejJEVEQ0Rk1JdDFkakRNcWRI?=
 =?utf-8?B?RlVSRUhWQ0V1bitOSUsyTlV0S0h6YWhjbUtqRHk3QmMweGd0QllNbUVjaFIr?=
 =?utf-8?B?UmFJeUV0UThFNE0xdWtLbk4wZDA5WEhjdVoxUUdCa0RBNXZ1WnNJZ0wwU3cy?=
 =?utf-8?B?R012WFFDS3NlMWpaVkFjQlVPaWllMTlJcFZWcUhTS3pobFVZVUtCanh2U0Ry?=
 =?utf-8?B?ZDBFeGxEaHFITG9idmt4WncvampCZi9yNlNLREpaZFdHK3dUU2t5NTFrc2dF?=
 =?utf-8?B?b1J3d3RUeEQwTEoxVm1CWXZNbXg2UEowcW5CU3NrTFQzVDdCUVhLaVYyRXBi?=
 =?utf-8?B?ekU4YTFwL01RM1lsQlJxRWw3aDRHenJjclZwWFB2OTJodHZucGpGeUd2dzRE?=
 =?utf-8?B?T3ltOTlWMm02eDFwZW5reERUL084SzFOWkp5MXBDN1pCNmlVMDBvOGYvM1hi?=
 =?utf-8?B?UWFyaUtVbnhOb1ZCK215UmI4SWFwd0swUUt5dnpDRFIwV0tYRG9JSVIrRGtt?=
 =?utf-8?B?Y2VhWDBURkhDMmxOb0VPbU9sTW9JUm9pc0R2Skw2NGR2Ymc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11026
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2dd806b3-b959-4e02-d0cc-08dda7d90488
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|14060799003|35042699022|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDltV3Z6MGZiaXhNTEpmUUpRcDU0ZVphQXdNdkRHRHFyZVNETGgzY1pXSGlE?=
 =?utf-8?B?VlVaTU1kSXRteFk2UHRIOFJFWUpUQUxXWTUvZUU5MkVwMk1DeGJscUZXbEtm?=
 =?utf-8?B?QmoxSmRGNFUwMktxM3NydVFpR1lSKzM0SjhaZWUzRW9zSTVGNG1oSFVlOEJz?=
 =?utf-8?B?OUFXYWlBQ1lpeU0yTU9ONVZHV3dZNHhlSytFSVd1Ui8zaklLZWl0RU84Wjkw?=
 =?utf-8?B?aDhJN0theUVQSzFjaldCcW80dlVIMTliRGZ1b3A1Q09iUlhFL1VwbUE2OHUy?=
 =?utf-8?B?M2RZeE9qaVl3dERMdnVxTHBnREVsb1Y2Y2tPNmtKVDQraUtwdGxZRUVNZ2pF?=
 =?utf-8?B?aWJOdEh3MkZtb1UrdFlhUnNtWVFSTzlpQ2ZRVGlwVWNHdHZTYUtSYWQ2MDdX?=
 =?utf-8?B?K1B0ZGFZZjU5WDNRWlBTd203RFF2SzlxVjQyYnBIWkppT042aDZ3YTU1Z2Y1?=
 =?utf-8?B?WldGOXR2N216MCtHWHEyVHh6cVhydnFlTTR3MWFIMEdqcThjRjlaS2xFWCtP?=
 =?utf-8?B?WEZZUTBYSEZOTU9uNmp0TW1wbWVWdG9HR0ZGbmQ4TFlUQzE0czJscWlZVCsv?=
 =?utf-8?B?N3VYdTBXYmVtcjBFdDhMN08ySk8yYmtacmJaSFIzOXBnR1VaWDkrODA0MWFC?=
 =?utf-8?B?NDlnYVdaZDV2WXc2UndnR2djYjhFSlE3ODZkYmVocFBjYUk5WVU4azRqaVdP?=
 =?utf-8?B?dDRsMExJeXF5eVJZWFAwZGVuSWpYZ0R0THRobHdidktYcTF6d2pSNWdIUVZp?=
 =?utf-8?B?Y2xiakRXamRVeEYxL2IxTXFNd1RBamw2K0MrLzhabU1NZEszeW1pcnlDVWQy?=
 =?utf-8?B?UDJPR3RoZG9rbXBDSVFTWnBuM1BOVUdTQXl0OThpM2lDQXBVaUc2dVdHNktC?=
 =?utf-8?B?TVhBRGRINnZOSFdrMlN3TnllTHcwZ2VydndYdUtYcXdLdWFtazJmcjZSUXdY?=
 =?utf-8?B?dkZMd2owem9OZkNjSEduKzRUYU1PRHNaZnZ4NUordnhPNEpTZzJQSEdCRWVU?=
 =?utf-8?B?cmdKcGh5WVpZaDFZbUxjU0ZmUlU5djU0OGV5K012eUs3b20xRHNYajV4cjR0?=
 =?utf-8?B?eGtlT1lmbGVncXd1ZTBrVnE4NlZuQlAzUHM5LzZBR0FtZHpmZnI3VXJHVHBP?=
 =?utf-8?B?dnFsQkVheDU5dmRVUWpVRnNoVGFTMGUrSXp3alBScGVDVVFBMmdCZnNuMWNw?=
 =?utf-8?B?U1QwS1NxRU9jYjB4ZkJ1R201Q0RlV0lMMzljTC9oMS9renlUU0dIdEhjUWwy?=
 =?utf-8?B?T1VVRW5CWjgrOWo1QXlvNFJEazR4ekE5eUExT3FJRVNsc2grTVRNdHN3cUhs?=
 =?utf-8?B?dkk5K0FzMHppd2NnTjEyNEFYcCtIazU3dkJrdXB2MTlIR0htcENkSGdwdjJy?=
 =?utf-8?B?b0IveitqV1R4dzFPcFJYTEljK3d6T1QwRTM1ZkZaZlFnM0dSYXJOL1k4Kzh4?=
 =?utf-8?B?K01yK1FUU2JjaFhGUVB4WTNVc1dhUTZFYVZHd0RoenV5S0U1MEJwSktGZzVZ?=
 =?utf-8?B?Y2dNUURVeW1UQW9kaE9HQkc3Y2dTOFF6OUJqNjk3OXA4UGFuMUhQQWR6Sytp?=
 =?utf-8?B?RU1OSG1iZ2dFV25aWkRuR3d1VU1Cb2Z1MXRhc0hUNGRvc3E3TjFiRGZCV3lX?=
 =?utf-8?B?T2J4MjRuYzFJOHlhN2tLTTZFaUZUUml4N04ySFBKcXY3Z1BQREZZb0VJSmpC?=
 =?utf-8?B?TUNTWUVWTEhFaVJLa1EycXdubWlrcU0yQU5qVklOK0wvYkM2dlZOalI4dDRY?=
 =?utf-8?B?MG1BK3cxMDA1OEdaRVM0L1U0T1VRaFoxYmowdjVTN1pvZ3BRRk0xcWZqZmpC?=
 =?utf-8?B?UXNvcGpkWlZHb3VxZFZVZjM4SWZWSHQ4bld4VmNHNnBCdmJjOFJRaGgweElO?=
 =?utf-8?B?c0RRaktIUzV2eHErSlhINTliNXIwYlVxRlB1QnpKTWV0M0g5STNLdmpFVFVM?=
 =?utf-8?B?ZHhEQ1VTMFYrMk5jaHA5L0FzUDhvNlE1ajc3eGJYdXBPd0dUT1NEOG1sblJQ?=
 =?utf-8?B?VWwwaTdqUGFmYVQ2RzN1TmI1aTB5Tkd5MWFpaEUxalpBU25JTi9uclUzK3Bw?=
 =?utf-8?Q?Kg/znZ?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(14060799003)(35042699022)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 04:41:41.3748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2ae826-2126-4c52-1d97-08dda7d91858
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8903


On 04/06/25 9:45 am, Dev Jain wrote:
> Suppose xas is pointing somewhere near the end of the multi-entry batch.
> Then it may happen that the computed slot already falls beyond the batch,
> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
> order. For example, suppose we have a shift-6 node having an order-9
> entry => 8 - 1 = 7 siblings, so assume the slots are at offset 0 till 7 in
> this node. If xas->xa_offset is 6, then the code will compute order as
> 1 + xas->xa_node->shift = 7. Therefore, the order computation must start
> from the beginning of the multi-slot entries, that is, the non-sibling
> entry. Thus ensure that the caller is aware of this by triggering a BUG
> when the entry is a sibling entry. Note that this BUG_ON() is only
> active while running selftests, so there is no overhead in a running
> kernel.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

Gentle ping, is anything else required from my side.


