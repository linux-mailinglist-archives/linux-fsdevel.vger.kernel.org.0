Return-Path: <linux-fsdevel+bounces-54665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA56B020A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CD21CA2E1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C912ED163;
	Fri, 11 Jul 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V5THvSVn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V5THvSVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD372ECE9F;
	Fri, 11 Jul 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248517; cv=fail; b=RZbkV/Vcv1O8JJiqBpRGPyg6JObVUXTgYqRy+NBiOawWPtwlXkj337GyQ+AsmO3ENozApo3b723mYJoVx9pA88QP8Ydz0XozwvlpXWmjUyVy626LRGIneTFE6rjSqvRCZhkiggfY8XX9rKozdZDWKB7Iv+gpxfaFE1br9mIq5Sk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248517; c=relaxed/simple;
	bh=76RlXbl3aW4KLoNZpDIshgG3Td7TZdx3MTaYu+EyTFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCUMcahAOfKOyoPj0kaB4SHTb7m6K6DK1iuwW1CKQkT1zgkoysHKdF8HRQyT5E34tkieYoacdURkor9XmxbtPZ2tCihP1dWz4OaLPSVssL7IraNk8wh/ziNKurkIWeFQprrZ7cdYjIvSnPz7Bw9QfHSyJCVGqWRUqMjXHVi5r+0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V5THvSVn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V5THvSVn; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oPyY2Kye7dl1uloUuV4I8NfyqINu/d25hFNPtmU1s0TGmiqdTpPR+mXf6UQjV55xTQIO73LDYH083XAjudQMfkff6U2Jr36qkhv7GoNGQSGbMNeWa8miAft7b5uqjy22x30dlUH0lpzrKnWKUyEvEt68QDvOEoe1DmHv4GAa2LT2BeiTfIErZJBC4cRp7zqLc9zz+oabY4bETXTsAtN+/sJ3nniP00l3naTextXz1j+p/Ib9dvr2iG1XuahV7//PIQ0KSSSwmR9lqaYkkrNPGRDezGF1Ym2ZC/ViIudOUiWLryTXxDUlhGBSEskwihH7Mdv5smZvc8STZPqlBBTmLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRmUJ0l1ysnFmrZAKf6BwxoX3zpW3eSyLNXI9STyuzA=;
 b=YAG8tdJVjE389KjgD0gBcZUJwdCx0yBk4YfxM7+MsSIg10apWIiwhITQpHHHTjUnb6udJAMaQUzUnvQT8sEApra3I3lbrGOI7UqAfM7FshJGVyGyYcfu95U9xpj0ofFuaVA4i4IEfY+AloYwRyNdmdnKn3X+GPdCzvuoVv+UDC76R4MO8tLbqq7uXVY+Gc79rSLH+Ve/G8S0gtAL5lKaOujqiT/oiGsdT1h1llz1kJo/DP5HLsJ1vb2b8CUTCHfH1Yzn2PU0Z6rzbLzaHZ93mPyrJlVSTF+SYRsDucnijCWmTp3zqIN0zISTHKkrLAbJ4HKvOijnZpO+iOd2fjjyMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRmUJ0l1ysnFmrZAKf6BwxoX3zpW3eSyLNXI9STyuzA=;
 b=V5THvSVnJg2qDgVpO5lV8qOtjP82VBxnNd1FFp1ZFguDmErRQ0pJtkdVqtfF5kZJytavs8yRcN+n4EHbNDD2AcnBOe1gJ3J4RcjUVjuJ3+y7eoEt6mBxvRtCNpwSoKJdfDk6DAjuIGQV+7ytsvO0mYLwZ9+1KFmuC6TAIqe15V8=
Received: from DB8P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::11)
 by DB9PR08MB9921.eurprd08.prod.outlook.com (2603:10a6:10:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 15:41:50 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::8a) by DB8P191CA0001.outlook.office365.com
 (2603:10a6:10:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 15:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via
 Frontend Transport; Fri, 11 Jul 2025 15:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0fZJ2ZcxateihReTeTc6fIRpnceb3PDGvZ4f1NhhoP8zLNKgnrHgt3niqUgGP2uAo6CSyW/BalZs4V6HMavC3XWqiBbaPCtpemCx10hgbN6D0IVFGhL6dmEYfjTjcH6MdvOAlCc/ujFVO/s8uHMnllx8Z4TU7wPSWTXJEhFP/NWCRnnElEMJGh9FidRl06v9O+9pxe4JSfNjz/yf6VrcJzNgD/JxoC7/S6cviemDfRb7Cw/LJf8/308j0s8glmpi8TOWcValDlcCMsx5CNaXM/oyZlDPYW7z3kNdgJkN1lbrMVb/c813xw2TtRPK/9u49o29Q28P/xn7HXcg4sTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRmUJ0l1ysnFmrZAKf6BwxoX3zpW3eSyLNXI9STyuzA=;
 b=KJllx7QB6wW4mYZ7DdzNmgz63hQ3duszfpqrArENny65KVeDvPMDqYWHqHi3SIW/3NOJGITDKVW9dQMfAiBf/Y9M5JSJVqzuM5VN1tX7au8wtogqknfUkRMbecsY9BuRgSNPASVOhEsJ+rmgENjqK5+whyzDrxr/96OUDfhHaNxrmCbTROonCJn/8vQCEjH1TgD31wIDdrSpLepjFYiBqNWrPgHkG5jjydTJXwZK6uvRnh00x6jebAuedH0flawP7gidg7o8Om67iOAboxhQqQ0M37WbzSpkV5fJWpdZ1P8QqH1TTxcto3NPx5zMK1hOl+JYzC/fDWBy6B8Z9OiiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRmUJ0l1ysnFmrZAKf6BwxoX3zpW3eSyLNXI9STyuzA=;
 b=V5THvSVnJg2qDgVpO5lV8qOtjP82VBxnNd1FFp1ZFguDmErRQ0pJtkdVqtfF5kZJytavs8yRcN+n4EHbNDD2AcnBOe1gJ3J4RcjUVjuJ3+y7eoEt6mBxvRtCNpwSoKJdfDk6DAjuIGQV+7ytsvO0mYLwZ9+1KFmuC6TAIqe15V8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 by GV2PR08MB9397.eurprd08.prod.outlook.com (2603:10a6:150:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 15:41:14 +0000
Received: from GV2PR08MB8172.eurprd08.prod.outlook.com
 ([fe80::f51a:aaae:c1c9:f3ee]) by GV2PR08MB8172.eurprd08.prod.outlook.com
 ([fe80::f51a:aaae:c1c9:f3ee%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 15:41:14 +0000
Message-ID: <e62f4caf-57dc-445e-be29-aff324e0d444@arm.com>
Date: Fri, 11 Jul 2025 16:41:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] mm/filemap: Allow arch to request folio size for
 exec memory
Content-Language: en-GB
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250609092729.274960-1-ryan.roberts@arm.com>
 <20250609092729.274960-6-ryan.roberts@arm.com>
From: Tao Xu <tao.xu@arm.com>
In-Reply-To: <20250609092729.274960-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To GV2PR08MB8172.eurprd08.prod.outlook.com
 (2603:10a6:150:7c::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV2PR08MB8172:EE_|GV2PR08MB9397:EE_|DU6PEPF0000A7DF:EE_|DB9PR08MB9921:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f1d96e-bdfc-48ca-fc0a-08ddc091733f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|42112799006|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NFhOTWt3WEJCOGQ0REtEUzkrWXh5d09rODN1elNZeS9qalNnNkk0Rk9jUDll?=
 =?utf-8?B?aVBlZWVxbFh0NjRLUGtmWXVQQjJvMUJjWDZqSWNma1pmL3JROW5GMmpzRjVI?=
 =?utf-8?B?RVdGSGZuVDhlSE5mcTBRNXZuck5xTEJJYit2TjViVUYxQmNCOXE0dksyaFRD?=
 =?utf-8?B?ZzFKbW40MXNVZC8xMnBGSFhTY0hyMjlUU0krNElFS3FtQnVKenB5WXpGd25U?=
 =?utf-8?B?TkdjV0Y0ZXU3UFNmYnkwazFaWHlYV2V5bkhjWlg1cGRIY3EwR0NhWkx2bGxT?=
 =?utf-8?B?eXdxV2k1cklaU0RvU0EvSjdWN3NzT1NyS3dIQStIMkdTOFQ5QTl3ZnpFb1FR?=
 =?utf-8?B?UzJPWEJqS2NmMTBoMlc5UnJtRitBZ2k3Nm4yeTUvTVFybk1HOWFWckVPejFr?=
 =?utf-8?B?V3JlVXg1L2J2TEx2UTdXVjJFbmpzaktZbkprWDByVm1naEgyZVJUV3l1aGtU?=
 =?utf-8?B?RTVrbnpWMGN1ZTROUkk2MzAzZEtSQUNzRkdCcXhCK29rVWRXUmcyaytRam8x?=
 =?utf-8?B?d0NkY0M4TTY3UnRUSTMwd3VaeFVGVkNJd0FQTzQrT1VQTmZsOHA3ZVZQek9z?=
 =?utf-8?B?MDd1WE14YzhMN3RvZEFmVHBWdnlCM2t2dnQwdDM3d21GZ01CYzFFblI5dFh5?=
 =?utf-8?B?dDAySUVFTTJYeFFXZWlHYXVpNExQZ2paM1N3QWp4akxPMGVvQk5BWXFHZFdI?=
 =?utf-8?B?bEtrbzZhMXJVcVQ0RGwzSytieENlTHAyb3BNZHpiWTVSeWhETjRnTmhHRFBN?=
 =?utf-8?B?Z2RIRmh1cE0xWWtDRTVLVEh6Y08ySjRYSHo1NHBFaHJXT3JKbHFrbWVZblN1?=
 =?utf-8?B?TjZVMjd1ZEQrV2IyYnIvRnl3bWNoL0RscExRS0NzK0pTSFY1RmVFTzdsVEd6?=
 =?utf-8?B?VUY3YjNMeW4zajdkSHFzK1BNajVnR2NHTVpoV09yR3kvYmRDS3JNVXZ3LzZL?=
 =?utf-8?B?Y3dmYVloMzhRMUtiTWVZcGNyQWh2WjZCQVAvb3drZWRGRkZXeW14aVdZR1Fq?=
 =?utf-8?B?Q0JTeHhOUWpDRmpteXVGQkw2L2ZiODkrNUJtb2taTFZRaGtPS1k0UUhRWFIr?=
 =?utf-8?B?USt4TVBQYnFLTys3RmRvMkNTdTk0aUtiVEw4RXBRZXNFdmhLRFZZSU13VnpG?=
 =?utf-8?B?S1VPNkpzU2lkRlhSMElsblpOOFBmT01IQlZqZkhrVVZ3T2FRZVQ1Y2lWUnNB?=
 =?utf-8?B?Sm9FN29JK2NGOFFyVk10dThwVDVyQzlyMjJBdk5ZZ25JdDdaS3ovdFEzYkFP?=
 =?utf-8?B?Qyt0S0Zxa1VNVk9oWWhyMy85MzN0NTl5UzV6am91eVM2ZzVGYXZCcmhXYURh?=
 =?utf-8?B?ZkI4R3Z0ejd0TDZ4dllmVjFJd0wrMTZKNUI2RDJ0TE5zMkRjbEJjZUhvM0Zr?=
 =?utf-8?B?dE1uMm5EMWhGR00yTDc4SW5iWnd4NC9DaVJWK3I3TEhUUFVOMkgxUXJkNFF3?=
 =?utf-8?B?K1N0S0tWVHhkSFBydWhudGFpSXZnSnJ6YjZBcXdqcmJmRUViNzZZWEhYWXd1?=
 =?utf-8?B?SjFKc3IzeE9RQ3NSSktjVkZwQUYrSktiWnM2R0xrWkhZMGhoK0Fqc0lJS0lU?=
 =?utf-8?B?enF5N1RwMmdPNkpiQmxVNlNqSWlHU2pteGg1NXFDemUxNG5lMzAra3NRdkMr?=
 =?utf-8?B?NGoyVkxPSU40aDFTSStaQVl6RGVWNFNBczJqcGdSQ1ArdFNkdkU4N3ZMdURr?=
 =?utf-8?B?clF0MGdOc3Jkbko3VzZMUDRrTjY0RVY5dlBtOTlNK3JwOExtSXltb0NQSElh?=
 =?utf-8?B?bk1McmJjeEhuSWpYOTlmbzg3TFpCY21sRGlHRHk1ODN0OXNzdllCYTEwQzl4?=
 =?utf-8?B?T2pNZi9WdnlIN0VRbldaMGRybUNianNGVnlESVowdElnREVaT0FwVlp1clNl?=
 =?utf-8?B?LzVEcEFFdmtaMllUSTFvTEdOa0lDeWdibXBDMXJSdk5ZTlN5cjZRL2plSTE4?=
 =?utf-8?B?Uy94QVB2UllWUkFRbm85MzQ2dGdtd2piNEVBU0dmemlaSEUwYTdIUDk4SUlD?=
 =?utf-8?B?eThxTGxCY0FnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8172.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9397
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	52bef9d7-1d3f-46d3-d4e3-08ddc0915db5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|7416014|42112799006|82310400026|36860700013|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emlEZklBNWNXbmRPY1lnNzgzRjAxcEFldTlIZDBwZmgzYzJaU3VYcHU2S1RC?=
 =?utf-8?B?VFNFSTBJL2M4akFqNG4vY3ZyOGFiOGhjQkQ5ZFJkTnQxdW5lbzNLWTJuNVl3?=
 =?utf-8?B?K0Q4a3NjMjhhSHU4U0ZVdlZKU0czM01zNVFUckxEN0ZPY2JVczJXSkVocGY1?=
 =?utf-8?B?MklsOG5YRFAweGcwZ0FVTDEwTjNDZlZZWlBmMURPZ0dJUG1xSEdUYjVabjk2?=
 =?utf-8?B?eThwd0cveUIyZmdxWEVFa2ZRZGFQdGQ2dXNNZ21oRXlHZTZZdlY1a2R5eFE0?=
 =?utf-8?B?QXZWOEhhMUVjTlF5UkR4c1M0eU42cWRMdFpPdVN1dlJUd215RjVjSXUwZCtr?=
 =?utf-8?B?Y2Y0Q20wcmo0M3NvWVpwOUdlY0h6OGE5clNHMUh2NXVHS3A0QnRSYmdzbGg2?=
 =?utf-8?B?UDZidE9OZytheHV6RU80ZzM1QnVkRzN6SG1XcTBkL09BRVBsUmlnbXBOTDFW?=
 =?utf-8?B?RVlSWVRpcnhibStsK0RQblcrTHZkanNNR3RRdnlVMDh2eHhwcFdRYW9teTRR?=
 =?utf-8?B?UFZUclZzdU9WTTg1aERPaTRmL1FFL3lUVXgrRGhVTjk4K29NMm9wWm0zZ0RW?=
 =?utf-8?B?YzlyQVg2YjRGMHR3Nll3WUNIQWM4TzNIeVpVemlabHZFOUJsb2xFSHRuQVVV?=
 =?utf-8?B?UEhhTDh1VUFhRi9jRHBSN0RYRFZKWUlYK0RHOER4NklmVjNzWTlrZTM4VVVY?=
 =?utf-8?B?SktDeTNhQkZ1anNQZVBRcE9kaksxVDNheC8rcjVvMWR0eDY5ZGxTQUp4cW5a?=
 =?utf-8?B?dWhySnppcnNTL3Z5K1ZqQXdJUktDRTcwZmsvWGYvRVVYOVZGVnRqVUM5ZUZv?=
 =?utf-8?B?ZW9HU1lPeWZiTG5iSUFTbk9TR0x5eVgwVHVjVXBnQkwrUVVnWVE3ODVHNWdh?=
 =?utf-8?B?RWVybTEvRWtlUVluR1k4MXRjZS8wZ25VSUhBNTVaUkNtR2F5c0psVmtQQjQ3?=
 =?utf-8?B?RHZFSnNFYWxtb3JYUWdqQUVzaC9yN0ZpMktSVmx3OTF0SmZVWFZxeFFKSElm?=
 =?utf-8?B?UlJEc2l3RlRHODZaYUszL05xc3A2MUtmdXFzM1NXUEZKRlJVQmJLMyt3V2pl?=
 =?utf-8?B?WVpDclAwaGl3SzVzVmJnU3pEVi9SaXpVVVpRUWpSUzc0OWhmTlNYVDJRLyt2?=
 =?utf-8?B?WXJFamowem1KUkV5a0o5aHlqNlF6aXBscVlMZUlKaFl0Y2ZWNUxMTmtNTWtJ?=
 =?utf-8?B?NnZSNzJDcjA4RGNETURTU3pOd0xLZlpaZTR5N3JmSUNrTnpkOG1jd3JhYXcy?=
 =?utf-8?B?U2tocHRhZk90Uzl4L1h0RnczYnllb0NWemR2SHJkanVDQWZzMDNuSTU3T2h0?=
 =?utf-8?B?b05sZjM4L0NnTUIyQjdaaUQ3Wm9keG1zclNUUkJabi96MzBHTGxjVDZKUWcv?=
 =?utf-8?B?cjV2dEwwOFdVUHlwS044ZXlEeWFlemkwNjV2a0NqQjkwdXFzcjhoV2lVNnFu?=
 =?utf-8?B?Q0UwaWpNSEFCWllWK0ZvUXJQZThlaEUzMVJFOVJkWVdNUzlpZ244cUxOV3Ra?=
 =?utf-8?B?NTZYbDFNa3ZXRGNRUUZiWDJOOG53d3JOTktzSUJIZ0hjc0VHS0tzeTIvbzRC?=
 =?utf-8?B?L2llTGtTZjEzVXhpS0FKTE5vVDRlaG0rL3doay9yU0dTUklJWWIvZGNjU2pk?=
 =?utf-8?B?elVycnZ5OGs5WS9keDFveXRGWHB2Y25vcnBuN2pBYWg5Z01nS051cGI4eVlG?=
 =?utf-8?B?bCtPRHRseTdseE02VHNIWkhqV2pKZWlEWUJnK1JmcVZPTFhhamJWMk5WY3ZI?=
 =?utf-8?B?djBRRGRJWGJNUDQxTGZyU1U0ZGdaZnM2MVJ1Q0E3d1QyOWRVaElRZnNUQ3pX?=
 =?utf-8?B?b2FuUnhhQVdQeUZscUlkMnVoQVdQWWwwYzZ1M1ovcVNnS1hJekpiTEl1MXhr?=
 =?utf-8?B?bHMxQ0RENHAxSnJWcDA5NmRDV203SEQ2SE55aDNkS3BSbkhmdHJwZFIzc05M?=
 =?utf-8?B?cnVnc1NKNXpQK3B5cER1NEtwSHhqSjZ3TUJKbzlyMFVUVVExdlFNVG40NVFu?=
 =?utf-8?B?N2VUd2hUV2o2cE85T29HMEZMbGE1UGtlNTVmMWp4UFRTNVJoSEN6a0ZuUlBH?=
 =?utf-8?B?SUtFN3RvekdSVkE5YUQ1N3BhS0RTSlNab0RHZz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(7416014)(42112799006)(82310400026)(36860700013)(35042699022)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:41:49.1759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f1d96e-bdfc-48ca-fc0a-08ddc091733f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9921

On 09/06/2025 10:27, Ryan Roberts wrote:
> Change the readahead config so that if it is being requested for an
> executable mapping, do a synchronous read into a set of folios with an
> arch-specified order and in a naturally aligned manner. We no longer
> center the read on the faulting page but simply align it down to the
> previous natural boundary. Additionally, we don't bother with an
> asynchronous part.
> 
> On arm64 if memory is physically contiguous and naturally aligned to the
> "contpte" size, we can use contpte mappings, which improves utilization
> of the TLB. When paired with the "multi-size THP" feature, this works
> well to reduce dTLB pressure. However iTLB pressure is still high due to
> executable mappings having a low likelihood of being in the required
> folio size and mapping alignment, even when the filesystem supports
> readahead into large folios (e.g. XFS).
> 
> The reason for the low likelihood is that the current readahead
> algorithm starts with an order-0 folio and increases the folio order by
> 2 every time the readahead mark is hit. But most executable memory tends
> to be accessed randomly and so the readahead mark is rarely hit and most
> executable folios remain order-0.
> 
> So let's special-case the read(ahead) logic for executable mappings. The
> trade-off is performance improvement (due to more efficient storage of
> the translations in iTLB) vs potential for making reclaim more difficult
> (due to the folios being larger so if a part of the folio is hot the
> whole thing is considered hot). But executable memory is a small portion
> of the overall system memory so I doubt this will even register from a
> reclaim perspective.
> 
> I've chosen 64K folio size for arm64 which benefits both the 4K and 16K
> base page size configs. Crucially the same amount of data is still read
> (usually 128K) so I'm not expecting any read amplification issues. I
> don't anticipate any write amplification because text is always RO.
> 
> Note that the text region of an ELF file could be populated into the
> page cache for other reasons than taking a fault in a mmapped area. The
> most common case is due to the loader read()ing the header which can be
> shared with the beginning of text. So some text will still remain in
> small folios, but this simple, best effort change provides good
> performance improvements as is.
> 
> Confine this special-case approach to the bounds of the VMA. This
> prevents wasting memory for any padding that might exist in the file
> between sections. Previously the padding would have been contained in
> order-0 folios and would be easy to reclaim. But now it would be part of
> a larger folio so more difficult to reclaim. Solve this by simply not
> reading it into memory in the first place.
> 
> Benchmarking
> ============
> 
> The below shows pgbench and redis benchmarks on Graviton3 arm64 system.
> 
> First, confirmation that this patch causes more text to be contained in
> 64K folios:
> 
> +----------------------+---------------+---------------+---------------+
> | File-backed folios by|  system boot  |    pgbench    |     redis     |
> | size as percentage of+-------+-------+-------+-------+-------+-------+
> | all mapped text mem  |before | after |before | after |before | after |
> +======================+=======+=======+=======+=======+=======+=======+
> | base-page-4kB        |   78% |   30% |   78% |   11% |   73% |   14% |
> | thp-aligned-8kB      |    1% |    0% |    0% |    0% |    1% |    0% |
> | thp-aligned-16kB     |   17% |    4% |   17% |    3% |   20% |    4% |
> | thp-aligned-32kB     |    1% |    1% |    1% |    2% |    1% |    1% |
> | thp-aligned-64kB     |    3% |   63% |    3% |   81% |    4% |   77% |
> | thp-aligned-128kB    |    0% |    1% |    1% |    1% |    1% |    2% |
> | thp-unaligned-64kB   |    0% |    0% |    0% |    1% |    0% |    1% |
> | thp-unaligned-128kB  |    0% |    1% |    0% |    0% |    0% |    0% |
> | thp-partial          |    0% |    0% |    0% |    1% |    0% |    1% |
> +----------------------+-------+-------+-------+-------+-------+-------+
> | cont-aligned-64kB    |    4% |   65% |    4% |   83% |    6% |   79% |
> +----------------------+-------+-------+-------+-------+-------+-------+
> 
> The above shows that for both workloads (each isolated with cgroups) as
> well as the general system state after boot, the amount of text backed
> by 4K and 16K folios reduces and the amount backed by 64K folios
> increases significantly. And the amount of text that is contpte-mapped
> significantly increases (see last row).
> 
> And this is reflected in performance improvement. "(I)" indicates a
> statistically significant improvement. Note TPS and Reqs/sec are rates
> so bigger is better, ms is time so smaller is better:
> 
> +-------------+-------------------------------------------+------------+
> | Benchmark   | Result Class                              | Improvemnt |
> +=============+===========================================+============+
> | pts/pgbench | Scale: 1 Clients: 1 RO (TPS)              |  (I) 3.47% |
> |             | Scale: 1 Clients: 1 RO - Latency (ms)     |     -2.88% |
> |             | Scale: 1 Clients: 250 RO (TPS)            |  (I) 5.02% |
> |             | Scale: 1 Clients: 250 RO - Latency (ms)   | (I) -4.79% |
> |             | Scale: 1 Clients: 1000 RO (TPS)           |  (I) 6.16% |
> |             | Scale: 1 Clients: 1000 RO - Latency (ms)  | (I) -5.82% |
> |             | Scale: 100 Clients: 1 RO (TPS)            |      2.51% |
> |             | Scale: 100 Clients: 1 RO - Latency (ms)   |     -3.51% |
> |             | Scale: 100 Clients: 250 RO (TPS)          |  (I) 4.75% |
> |             | Scale: 100 Clients: 250 RO - Latency (ms) | (I) -4.44% |
> |             | Scale: 100 Clients: 1000 RO (TPS)         |  (I) 6.34% |
> |             | Scale: 100 Clients: 1000 RO - Latency (ms)| (I) -5.95% |
> +-------------+-------------------------------------------+------------+
> | pts/redis   | Test: GET Connections: 50 (Reqs/sec)      |  (I) 3.20% |
> |             | Test: GET Connections: 1000 (Reqs/sec)    |  (I) 2.55% |
> |             | Test: LPOP Connections: 50 (Reqs/sec)     |  (I) 4.59% |
> |             | Test: LPOP Connections: 1000 (Reqs/sec)   |  (I) 4.81% |
> |             | Test: LPUSH Connections: 50 (Reqs/sec)    |  (I) 5.31% |
> |             | Test: LPUSH Connections: 1000 (Reqs/sec)  |  (I) 4.36% |
> |             | Test: SADD Connections: 50 (Reqs/sec)     |  (I) 2.64% |
> |             | Test: SADD Connections: 1000 (Reqs/sec)   |  (I) 4.15% |
> |             | Test: SET Connections: 50 (Reqs/sec)      |  (I) 3.11% |
> |             | Test: SET Connections: 1000 (Reqs/sec)    |  (I) 3.36% |
> +-------------+-------------------------------------------+------------+
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Tested-by: Tao Xu <tao.xu@arm.com>

Observed similar performance optimization and iTLB benefits in mysql 
sysbench on Azure Cobalt-100 arm64 system.

Below shows more .text sections are now backed by 64K folios for the 
52MiB mysqld binary file in XFS, and more in 128K folios when increasing 
the p_align from default 64k to 2M in ELF header:

+----------------------+-------+-------+-------+
|                      |         mysql         |
+----------------------+-------+-------+-------+
|                      |before |     after     |
+----------------------+-------+-------+-------+
|                      |       |    p_align    |
|                      |       |  64k  |   2M  |
+----------------------+-------+-------+-------+
| thp-aligned-8kB      |    1% |    0% |    0% |
| thp-aligned-16kB     |   53% |    0% |    0% |
| thp-aligned-32kB     |    0% |    0% |    0% |
| thp-aligned-64kB     |    3% |   72% |    1% |
| thp-aligned-128kB    |    0% |    0% |   67% |
| thp-partial          |    0% |    0% |    5% |
+----------------------+-------+-------+-------+

The resulting performance improvment is +5.65% in TPS throughput and 
-6.06% in average latency, using 16 local sysbench clients to the mysqld 
running on 32 cores and 12GiB innodb_buffer_pool_size. Corresponding 
iTLB effectiveness benefits can also be observed from perf PMU metrics:

+-------------+--------------------------+------------+
| Benchmark   | Result                   | Improvemnt |
+=============+==========================+============+
| sysbench    | TPS                      |      5.65% |
|             | Latency              (ms)|     -6.06% |
+-------------+--------------------------+------------+
| perf PMU    | l1i_tlb           (M/sec)|     +1.11% |
|             | l2d_tlb           (M/sec)|    -13.01% |
|             | l1i_tlb_refill    (K/sec)|    -46.50% |
|             | itlb_walk         (K/sec)|    -64.03% |
|             | l2d_tlb_refill    (K/sec)|    -33.90% |
|             | l1d_tlb           (M/sec)|     +1.24% |
|             | l1d_tlb_refill    (M/sec)|     +2.23% |
|             | dtlb_walk         (K/sec)|    -20.69% |
|             | IPC                      |     +1.85% |
+-------------+--------------------------+------------+

> ---
>   arch/arm64/include/asm/pgtable.h |  8 ++++++
>   include/linux/pgtable.h          | 11 ++++++++
>   mm/filemap.c                     | 47 ++++++++++++++++++++++++++------
>   3 files changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 88db8a0c0b37..7a7dfdce14b8 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1643,6 +1643,14 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>    */
>   #define arch_wants_old_prefaulted_pte	cpu_has_hw_af
>   
> +/*
> + * Request exec memory is read into pagecache in at least 64K folios. This size
> + * can be contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB
> + * entry), and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base
> + * pages are in use.
> + */
> +#define exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
> +
>   static inline bool pud_sect_supported(void)
>   {
>   	return PAGE_SIZE == SZ_4K;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 0b6e1f781d86..e4a3895c043b 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -456,6 +456,17 @@ static inline bool arch_has_hw_pte_young(void)
>   }
>   #endif
>   
> +#ifndef exec_folio_order
> +/*
> + * Returns preferred minimum folio order for executable file-backed memory. Must
> + * be in range [0, PMD_ORDER). Default to order-0.
> + */
> +static inline unsigned int exec_folio_order(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #ifndef arch_check_zapped_pte
>   static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
>   					 pte_t pte)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4b5c8d69f04c..93fbc2ef232a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3238,8 +3238,11 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   	}
>   #endif
>   
> -	/* If we don't want any read-ahead, don't bother */
> -	if (vm_flags & VM_RAND_READ)
> +	/*
> +	 * If we don't want any read-ahead, don't bother. VM_EXEC case below is
> +	 * already intended for random access.
> +	 */
> +	if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
>   		return fpin;
>   	if (!ra->ra_pages)
>   		return fpin;
> @@ -3262,14 +3265,40 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   	if (mmap_miss > MMAP_LOTSAMISS)
>   		return fpin;
>   
> -	/*
> -	 * mmap read-around
> -	 */
>   	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> -	ra->size = ra->ra_pages;
> -	ra->async_size = ra->ra_pages / 4;
> -	ra->order = 0;
> +	if (vm_flags & VM_EXEC) {
> +		/*
> +		 * Allow arch to request a preferred minimum folio order for
> +		 * executable memory. This can often be beneficial to
> +		 * performance if (e.g.) arm64 can contpte-map the folio.
> +		 * Executable memory rarely benefits from readahead, due to its
> +		 * random access nature, so set async_size to 0.
> +		 *
> +		 * Limit to the boundaries of the VMA to avoid reading in any
> +		 * pad that might exist between sections, which would be a waste
> +		 * of memory.
> +		 */
> +		struct vm_area_struct *vma = vmf->vma;
> +		unsigned long start = vma->vm_pgoff;
> +		unsigned long end = start + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT);
> +		unsigned long ra_end;
> +
> +		ra->order = exec_folio_order();
> +		ra->start = round_down(vmf->pgoff, 1UL << ra->order);
> +		ra->start = max(ra->start, start);
> +		ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
> +		ra_end = min(ra_end, end);
> +		ra->size = ra_end - ra->start;
> +		ra->async_size = 0;
> +	} else {
> +		/*
> +		 * mmap read-around
> +		 */
> +		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +		ra->size = ra->ra_pages;
> +		ra->async_size = ra->ra_pages / 4;
> +		ra->order = 0;
> +	}
>   	ractl._index = ra->start;
>   	page_cache_ra_order(&ractl, ra);
>   	return fpin;


