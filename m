Return-Path: <linux-fsdevel+bounces-49992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDBAC6ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 19:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B4A169B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588E28DF22;
	Wed, 28 May 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJEoPSyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7D8634A;
	Wed, 28 May 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452374; cv=fail; b=Mzt8hdMpIQCNDS8qEFFszTbYAFyoItJ4B2qKVj+xTT0B1IJ54OdgSr5TJUG82fjVsOKwsMHlyOEcK3h33tRkqpRaTJv4iYOqUjRm5kFLX7f+xz6W8Ewd8aYSOxSJO6GubruiJiOFGslJGtRfQyxoHra5PJJ8Ug7X2rLCbryCcMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452374; c=relaxed/simple;
	bh=tVBi/eWXH7HFlFgqTqmhJi/yunfenchhBiWNutbg80c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rOE4iPIlQO9aJWWa3xyvHaiegBTwG0sQbGAd3XuxtddAVIvXxtl+Qide5aEa/OlP8IbSQcArDgCZHwrh2fgZEy1oPsjSu1VQF22oosvcapbqzY19YDBV+mqFhV+UJQSufvLzTd3aug02jXCb/SspVFQlu+xZ52P3Om2GgOnKuok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJEoPSyg; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOMtn3x2NBMssuqx6APHNmnO6F6hpXYagJC0IJgbE5Dl9vFHtVoNLL0yJjiDd9VWds1UVgVSwfeNQ4762p7APkOGMF5Y8f1x5qDTbs3oWzEiRLTyhfZ7hS8o0V2RdqYV4smbjkTDIJc1miaaPEVDffaz63SWw6vy0yhLhgHegxMea/HZDXeGr0A630OuL1ktpRxPbyzj4jwfvbHB0nAMCdAT5xvZe5I+5mpfoS0AJkGSa/H3HoC4/jv8s8P9zZ35QYWA47lbTzrqRiMU0UNhNXaEFxJ6c81ojNjT2VPFbd4GNU82iyS5D9G2Hz6CErSbQmia6Vu99apzfIL5e88Frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5AdlVQyVe0pGFz34/P36ufL4dwuPqaTw8TchggDhC8=;
 b=AEiFBPyCw6EL8orM45U41lowp+P7VO7bIHvMXbQBUooX3M4GLPocXeAGJaFfwQR5u+u8H6o2wQjiY9doEzs5m68BzxWOKKiiQSeRqABrtlaY/6Ffx5JqDFvUGO4PW2GyqcwujePiuPvfvvb3hC07+hBuC5yl2DzamgCbBEreZSstNRf1TAU0kSqVhePGHhBKxl+65UYdrOHkVusgLpNhNySfNyynZASbxWAlRatDacbZVN/keXEwHoY8Hij8NcrU0WmpeYQimDGBkZxDAGhBa4cgHNkoNYkoXeD7odm0grFjdkaD/2e6BlpgFOz+hkGVio+b97NxRdoLrGsKzddGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5AdlVQyVe0pGFz34/P36ufL4dwuPqaTw8TchggDhC8=;
 b=lJEoPSygHjkbcNIKHV9Chyeel8/BfMerbp6VFBsTi2IphDHzw4TJU8T0ypn0xxDq+YDsfBC6Rpg92NuihXiCqZcCU3h5cl5FkHgnRHnW1QI7YZL8PwcN7bLfuX+5XD6DP08U+E3J+Eze0oRtm/v/xOOn5yM4ftkEm0ZXWyCP8H+4EPoWUrpvkTFKLdGdM692trGxLhIL7x1ytgllaQa9gjz8S4E07hY3PIXROSMo/ZWzTkX02ElPnNS2GQgSmJswaFHQYHU/DXnPqXgszcab/HcPbp8sp2Gs/jGr1QZYshuMuTm9S7oOkNHcK/i/Tn11Lh3FuVMk0QT4Q7sO7pit/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 28 May
 2025 17:12:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:12:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Wed, 28 May 2025 13:12:47 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
In-Reply-To: <20250528113124.87084-1-dev.jain@arm.com>
References: <20250528113124.87084-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013DF8.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:b) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 85537669-11d0-40db-32de-08dd9e0ae01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0xCWDZoYU9DeTduTjlCNWtmR0hlRm01ZkcrMGZOZHdnaDYxT2dwSjRabDdh?=
 =?utf-8?B?UkxiNlZUc1pNcHpPckpzSmthYUFZOGYyQWQrRXdFZkpoLzg0WDhVOGtqUVlP?=
 =?utf-8?B?Q1UreWwyYWRTT1F3dkxnLzlDYUlpUUJQVlFSME1vdEd2Y1AwQlI4YjNMQmJ5?=
 =?utf-8?B?ODVaWGU4ZElkNXdoRzR5Q3pXNmZzcEphN0s2c2F5aXdKMzJQTWhpMjRKQjdv?=
 =?utf-8?B?MWFrbVFvWXJaU2IwdzAwbXhTOWxnUFdtazFrNXpKL2NNUk5Pc3Eyam9pSVBZ?=
 =?utf-8?B?RzNGZElIMnUvdnlWRUJpN1pzT3JBMHRJRGFZQ1NUdU5tVkZLQXV0Q3RWTVNW?=
 =?utf-8?B?TzlQWTJjU3YxK0VQMWlvS1hSOWxiQldYQWtwRWZ4Nkx3N1VHRWFXWWF3OHJX?=
 =?utf-8?B?K1BheUg1UWpaMU5FdFVnWm5SYzNyaktLSXVBRmY0L1U0cFMrWDAyaDhpTVha?=
 =?utf-8?B?Qlc4UkswWDBGYUQ1N2RIYmc5amJFYm9sV21ncDIvOXJ0Vmw0MldkNVhXQ1pm?=
 =?utf-8?B?MDd1Y1NpR0NudEhRclVwTk8zN2ljSWJNN3ZRMVFyRmlSNWRmdldhVFo1Ym9I?=
 =?utf-8?B?NjJZMDh4eE1wRGtPZzkySURxNHBqZ2RxaXEwL1d1UmlhdUlSc3kyazFUdnJk?=
 =?utf-8?B?T2RFWHZMeUJEaWdnZkhabTRkRnEvNFpKN2tUZDFHNWw4VlBhUXJjNVMrY3BF?=
 =?utf-8?B?eFpHMGJUeGFyaGsxczgrK3J0N0M0VFNRYThFN2ZicTJKR2dFTDdBUkRZSEVE?=
 =?utf-8?B?TE5iZVVUanBRb1lmUFhpdHc2MmpaaVBrWkx4b1VVbXdOWFAzSVBNWVpUNDlP?=
 =?utf-8?B?cEhXeDd5ZExGek90SlFwdmw4UzJPQk5UQVV1TVlzWTkvNjB6RXpORm4zc0gx?=
 =?utf-8?B?WkE5d0dOdGtGbmo4SC8yME4venY3SUt0VjhIa1h3TTV2Y0ZzRHgwZ1I1SVlm?=
 =?utf-8?B?ZjFDWmt1S3FxUDB0L1dVRU0rRjRCTnduczVEb3MzK1RiODl0c2l0TndxTVdT?=
 =?utf-8?B?NGgzc2sxMFh3VjZXNnppeVZiV2lHbDR4amhHdXRvVmVqRTdyU3NqT2dWd2JO?=
 =?utf-8?B?WlhmekxrSDZsNnpmNGpCc25vVEx4VkU3VnMrblJUUlBWOE5lTVd6QlJWQS9J?=
 =?utf-8?B?aVF6Y3VYNWVZZ20vRkEzdXlBMHBneHhia3h6QjZaRWRVeEtyRHhGYmwrbHhp?=
 =?utf-8?B?b0lKZHUwK3Q5YVN4SytESkJYSWwxYWs5amdUM1EvdTFTeENnYTZqamhYQmpP?=
 =?utf-8?B?eTIyS3gvVm9ZT2lFRy9VdklTbjFVL2dvWlA5UE10R3FXd09CbnJKNmhmazlj?=
 =?utf-8?B?Y0lTQ1N1ZGs0S2xMSVpvcjlhSzdxbUhxcERnTVlaUXczWUZ1QzBxR21ScEdT?=
 =?utf-8?B?OXNlajJ6WmZiMDA1bkl3dFdZTUdIalREQjkzWDZ3YnNlZXdTSGlKd2ZWK1J1?=
 =?utf-8?B?TDY4elNyaUMvbWEwMWxLZitEQXBjdGJtcXZ3S1dLd1IxNnA4WWZ6TFNlQU5X?=
 =?utf-8?B?NGRCNnNYWTZnN1ZpM2VCYkYrWmUrWDQ0YVpvUVM5YVlYQjBCOFd0dW5Fd2hZ?=
 =?utf-8?B?Tk1scFZsUnc1Z0lZbTFGZTRGNGVCTDZmRWMyVlVpQVdMZUJSd3ZWa0xtb3p0?=
 =?utf-8?B?NjVJZE5VRWVacXNPa3ArSitUZ2gzdXlhZU5lVUd5UVB1VzFaTENwTmRMOUln?=
 =?utf-8?B?SEhHKzJnMERwaU55YXRyVWk1bzNvTXBmT091MDFNWE9DRS9sY01hMWphZVE3?=
 =?utf-8?B?aDVNYURPM0ZSbGhQNUJhQ2JHZ1VneUtjQXF1azQ2YnRQd2hzRCtsMW1DTjdC?=
 =?utf-8?B?TUxaQldZbHBZQ1ozZzIxQXBlOEpJaU5KRFVtbVZLZk5WdlBHd1Y0dSsxK3c2?=
 =?utf-8?B?b3QzSFkraFNLKzcwdXUranAyZ2FqRXl1amdRZUlSOWgwU0JoY21hVDJTT3E4?=
 =?utf-8?Q?UpJG1FROPlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2htQ3I5S2hkN21VYTYrWmMzTzNEUWJXeFNvdkQ0NkpBNWdJbkt6eHl0TnIv?=
 =?utf-8?B?WGtvMjRkSWtkZXdZUndLMnhPMnNjL0p3SmNyUTkyRUVHaXA3N0p0N1dsVzdy?=
 =?utf-8?B?UnRYZU5NVzYwR0k1alVZa2RNci9yYjdicVZ3aTZROXJCMkIyb1VTZTBhRmtq?=
 =?utf-8?B?bGFiNEYvdkp6enhMYTlwWmRCWEp6VTdNSzdVT2phRG9uazFRYnZjTzFYcVp6?=
 =?utf-8?B?eFlSamhMMUMwUEFEclgxWklBYWhxa2JQSFdHckgxZzltVDd6QlhpMnZZVnRI?=
 =?utf-8?B?d0l2K1RBWnhHUnN1L0pVQnkzV0huQVBjNTh4amZQbzkxQ1B3Y0RIR1lKdlU3?=
 =?utf-8?B?d2kwVGVldFpidkZneTV1dk96SEMyMExWOE0wN2NaOEtoOGtNRGxVU04yL0V4?=
 =?utf-8?B?T3I2UFY2SjduY2hnSUlSM2UwczVqWEJxQ2Y1WnNwMC9zTUU2aEYybUxOc3Nu?=
 =?utf-8?B?bU9HdTNMdHEzRDZ3OWc0ZGNmYUxLZnlkYlNNTjl3aFl2cS9MVVlsSUJaWEtY?=
 =?utf-8?B?QWZ4Q0N2Q2hSWnhGKzRhaXVoeHNZZ0dGc003TEsrVm1LY3M5by9JVGhHcDhv?=
 =?utf-8?B?ZEdYZnFKU3NJRlFPaWgwWUo2eWZGdXpWZ1hQemtXRjR3UWxpcTVuQWZQZHRO?=
 =?utf-8?B?UU80dEpqcFgyeDBZUVV1cnFtMW5IUzMxZzFMOGZ3NThWdlVUL1NVVmY2Z2tN?=
 =?utf-8?B?RmN2T3Mvb3ZoSWZ2NVhuTTJpcGwwQ1pFZ3NlQkFXNGJPZGxudXZndm9qQzg4?=
 =?utf-8?B?SWV5eThMZnptaFpBTXIrL1ljcHRCWmRWZVhtY3NES0pTS2k3ZEZJSXhyV2lM?=
 =?utf-8?B?VWlpbDVwSmVTUitScDhSK2NjczI3K25NQTFJWlpNN0crSWpJQjFpOVExVmpq?=
 =?utf-8?B?WGFLY21UQXpoWFNaamU3Qm55VDNhS2xNUXNQaGsyUklaY2xtL3lOclZDQlNG?=
 =?utf-8?B?TlhzTTd4bytXN2k4TDVpRVdVSUNkREQrWE5odUNLMWZ4aDA2QTRpaTNmUkUz?=
 =?utf-8?B?Qk0vZmwvTjF1U3J5M0FkbFBzbHV3alR1UWNPdW03dVJuR0RMZUZPYnlJMUZY?=
 =?utf-8?B?QXBCUFdlOFhUK051YW1leHdFMkx5MlpiY3BteWFDKzNtNm8zVEIxTHFlVU45?=
 =?utf-8?B?WnF3Z3h6NnBSMzh5T29yMXFmRTVWSWhyalRKVm5YNXJOMUNxQ1B0a2JpUzBh?=
 =?utf-8?B?alhEeTcrMHZlSkw1a0RCMHFCblpsSUlnbEF1b1ZRTFNXazhicWtiN2xlVm9K?=
 =?utf-8?B?NjRVWGZRUHpnTjlKU242dzhnNVNCVVB6dFVtdjRUc3ZsQlJ3V3Iyc2I3SGR0?=
 =?utf-8?B?Mmoya3J3SXl6N0V6clNNS0N1aGlPclFITW5sMUZlaWhxcWRqZ081QVhieHBT?=
 =?utf-8?B?NTZaTG9pYjl6bXdLd0FFM0k0dVJsTW9LeWl1YW0waFZ3cU0rNWd3eWpaV3Vp?=
 =?utf-8?B?ZUllckpUU1I1d0ZtaGg4cVhuamJmbkpSbjVJWXVkT0RLZ1FaWjh1amFNTTlz?=
 =?utf-8?B?NWpQSGRlTms2RnpGQllQYlBOY2QyamltWjJoaUY0OGY3WUE0TC9JeGdOaDVP?=
 =?utf-8?B?VDdxcHJ1eUpscFNRaFozekYwenhvMit3RUNLbXNCZnBza2tVTlR6QWswd1BP?=
 =?utf-8?B?R0xIV2MyQmt3RmplZWU2OFlFZTZtMmFDcFRNcHNiVlpRVURZMDRseUtzUG9y?=
 =?utf-8?B?VzIwSzNlQ0k5N09TWXhlcFJqRzMwdkhyeTArNy9yejJ1MloxaGxuK3BORWl2?=
 =?utf-8?B?WjY5MERXZldrTGlYNGd0azFEeGRtdUN0TGh2Wnl4b04yMDdhYWdQMHpTd0N0?=
 =?utf-8?B?NnNjZ0hBbE1ONG9BOUZNbVdDQjQ5YVpDVnVlOG9kOUxGVmM1Ym12OHpqMnR0?=
 =?utf-8?B?Y245K3pDZUlEMmdzeGtKYXFaaWJucUwwY1NQUDR6a29Nekd4ZVVFRTNkS3c2?=
 =?utf-8?B?SHRRc2ZwcXN6YnFTc0NkNnEyZVpiNnVjZXlQSHk0THBOZVFQS0tYVE5rcVpy?=
 =?utf-8?B?NGEwNFlWTHRVTTNvMVJQbCtOVXFuWC9sREtIY0hiU3M1WndoS1YwdVpLak9k?=
 =?utf-8?B?MGEzeUt3ZCtMZkRSclBMSE5HN0FEaWViTncwSnlJazRHdUhSa1crZGZ6S1Zs?=
 =?utf-8?Q?gBap+tC0GkcgbwhXf9Y8aBRrr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85537669-11d0-40db-32de-08dd9e0ae01a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:12:50.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPrnuHYnX3mKSlDroeaKVdz05XD7CdPHeWX9hw1tGnaE36fqOcd+WYyiMyItzM9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

On 28 May 2025, at 7:31, Dev Jain wrote:

> Suppose xas is pointing somewhere near the end of the multi-entry batch.
> Then it may happen that the computed slot already falls beyond the batch,
> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
> order. Thus ensure that the caller is aware of this by triggering a BUG
> when the entry is a sibling entry.

Is it possible to add a test case in lib/test_xarray.c for this?
You can compile the tests with “make -C tools/testing/radix-tree”
and run “./tools/testing/radix-tree/xarray”.

>
> This patch is motivated by code inspection and not a real bug report.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> The patch applies on 6.15 kernel.
>
>  lib/xarray.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 9644b18af18d..0f699766c24f 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1917,6 +1917,8 @@ int xas_get_order(struct xa_state *xas)
>  	if (!xas->xa_node)
>  		return 0;
>
> +	XA_NODE_BUG_ON(xas->xa_node, xa_is_sibling(xa_entry(xas->xa,
> +		       xas->xa_node, xas->xa_offset)));
>  	for (;;) {
>  		unsigned int slot = xas->xa_offset + (1 << order);
>
> -- 
> 2.30.2


Best Regards,
Yan, Zi

