Return-Path: <linux-fsdevel+bounces-72957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B785CD0672A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2E73027E10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385432E752;
	Thu,  8 Jan 2026 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/p5WKkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D1328B47
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911819; cv=fail; b=cM9O1cKT08EFyL6e++Eh5536qBa/9aixDm8Z2f2jLfMdwrWO4KkMWgHN/K3RuhX70yqMO1pKHvrFkiHPllmf4XpmRkXAZZejacrNYT+qrII1jQ4mFEPF75XtRBVubJtdnEzWFIpxpCmLYCrSs9ipVZqQKaruYxMlAbbsQHQbDdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911819; c=relaxed/simple;
	bh=g8LAcaTe7j1QHM/cCVy9ykvLSt0NfBP4aUiyt+PBlnM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d5oyzkRDhkUtYA/HLoW4UhOuw/9zzb5LJdd0Y+cmbekD4cY43bfO4bDzIk81Web+JYGHpOKuMlCegYwQfyl+Jxz0BxRBXdjokJUC7UqXeCxUC2fNhIEMmwSNH6IyxdlzC9OV4j5njYDwu1G+97+dFh/192ov78fTFr4qe+X1YtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/p5WKkU; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTp9IUcYuBQMTwWC9SupY8UzO7IYfRBqrySqlZCc5Lo40xPqZlaxu8cO7fsWVnlO2DsX3dFNzFkd7uq9OCz7U7DwYGejkJG98mLf7Sk1f20mHDBvzd1qHcEHMJ5bGmo3QuK5Cxajts+XznsjAY/j4tWq5PdY3DpQvZzR4eRihN/D7ytWWgw2HU9f/XnlDAhEgxzTxbmeODatiP26r2foydoe8r/ff/iS0FT/n+M94oIdy/MvYsROTu9EH2K84nZz3hdoIixSetIWhxl+3P/RcXi1JaSdchUu6iXweqgSNSjkt9/JJiNjkDYL1k+vRuNC8TuMAhH3tRVgXrAxS1PabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8LAcaTe7j1QHM/cCVy9ykvLSt0NfBP4aUiyt+PBlnM=;
 b=Rpb1yZw8xWm8DoKItEuB27UemSyg5r8mg8acV9F5IQ1LVdXCACkq4+6v0eXyswf+ooZqXzIO/w41OTghfzyWcljKk/UuabeWpwLsIZG0YF6iDNX3gRcloUtvf9tweFF4zqd2v8k2gwB06wxdHIa6mAWXDHyh1qSKYZxhExGkAYrr7CZIB9eJ22rgzuEhgwQI0emI0noRai77We17nGlrbiFT0RyDbSl5lyQOAvBaEPb5e4+aUnacYTHLbHSvcxiGgIRyYo3lLzUpXlHjT7KaeD9sC5e4XqEVUrzpetieEksCYxOjezl+jfZiLzZ3u2wlgLofGPxQttsYtazUK2EZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8LAcaTe7j1QHM/cCVy9ykvLSt0NfBP4aUiyt+PBlnM=;
 b=M/p5WKkU4btTraAzGIQ4ctHcjUsEGBAZ4WCU5WzQWlIP7WbPr6zj3gT5xEWhv7TgQ9W8fa8+Pad+jKqIEVnACXxvO+3rlFrep1hopYcz+vGaK5UJW21rOhyK3fsTqav3tXujkQddwR3fUUoJUNCoQ4dsfZbrQ56UxQiAht0ZxO/rUb93uuRXp6WJWAcdZtx7h75O9bbawHbUU6tkYaLFxEU+XE0nZoKu829eZKrq5PeiISM4wTIsfm6HW5/SiXmQRTtXcCXPPXW+H/ttL1Yu2MDGpbNgaJJDR43rTOUwiW0ShAAqqaOdmEFAZBgj+MwayoDB0f9Z1eVOkbbTAod1yw==
Received: from DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 22:36:53 +0000
Received: from DM4PR12MB5102.namprd12.prod.outlook.com
 ([fe80::67dc:55ce:1469:1eed]) by DM4PR12MB5102.namprd12.prod.outlook.com
 ([fe80::67dc:55ce:1469:1eed%3]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 22:36:53 +0000
From: Jim Harris <jiharris@nvidia.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RFC: removing extra lookup in fuse_atomic_open()
Thread-Topic: RFC: removing extra lookup in fuse_atomic_open()
Thread-Index: AQHcgO9JeFbMHrIGIEqdzJgdNoLywA==
Date: Thu, 8 Jan 2026 22:36:53 +0000
Message-ID: <DC1731BD-736B-479B-99EC-FFA34547D898@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5102:EE_|SA1PR12MB8841:EE_
x-ms-office365-filtering-correlation-id: 849f73ed-1968-4c80-2709-08de4f066c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEVBL00yMjM3VE9vN3BVcGlwazNvVVdiM2JyUUtES25ZV1VXbFJsS0JyaUpQ?=
 =?utf-8?B?R0hEeHpISWIxOEpHNXUwQlJoRS8vdFFYL0VSSzQvTHV0dERJOW16M0o0cmV4?=
 =?utf-8?B?emhVblhOOUZvTGJjaURyN3Bockc4MnZBaUFvOGZ5SktjL1M2NjRrZ01rZ3o4?=
 =?utf-8?B?NmJzWWhwbFlHVXg3S3pLc0EvK3FrQWlZOTcwelZ6ZExtNVJZQXc1S2Ezakth?=
 =?utf-8?B?Rm1ZRklkSEd0MFhud09XbVhpTmpETGZhejg0SHBWMU1JQzNVeE5seEt5UGZ1?=
 =?utf-8?B?dEtDRUgwc3JYdGRGVlBTWktJWkpoMGFkUXN3clNGQVFKRzRUbitJVHVCVlRH?=
 =?utf-8?B?L21VTG1mU1A4bG1Ud1E2Syt1MzRhQ1J3NzRudkJyZTZLQUxCMGlRZS9wR0xx?=
 =?utf-8?B?VFoxeithaVVReWx5U2VudlUzSjVsbVNCUFRLYTQ4WVhNeWQrWjZ5LzJCU3BB?=
 =?utf-8?B?VjdNSnFXSjAydEVrb1JqaUFjZXBSSVpvVCsvN3NubjNoYUw5MzNyOVhvNWp2?=
 =?utf-8?B?UloyR2IzL3ZHOFIwNTNJVUxQb2NLZFlRZ0h4Q0M0VGN2QUZ3N1BhTktJRGFi?=
 =?utf-8?B?ZXEzb1lrQ2JvQXN6QXkyWEUydzhEK2t1cXp5TGpXQ3VDaGNvek4xV0Juc0Fj?=
 =?utf-8?B?N3hhYUJnTkcyOGFMbi9lOVRwN0lkTjAvRGxQRWdVWUJrcUJOMGZ1SXZjQU5S?=
 =?utf-8?B?V3ZNRU40LzEwMWppVzJHTWdvbnF6L01lRGhnL1J4bmdjRVNLQ2ViM3pLTkdn?=
 =?utf-8?B?Z3VDNXhkdVRJQmZuNzc4Z2N4QXZSRzYwZU9SdFpIZzczWmdqRENtdlk2b2ls?=
 =?utf-8?B?ZnFhTXozenN4bWJMRHN4Y2lmTEdwR1gvNEJraHA2MXpNK1ArMEMzaURpNHpo?=
 =?utf-8?B?cEdDWWcxOTQ4MUYxM0xjbHBmbk9SWUU5aEV4SkQxMVNWRjlIcERkY0grRmRZ?=
 =?utf-8?B?cVkxQzRTTXhHZW5pV2NmV1liOVdGbVBCeXR0dXVCZ1BCbUdZYUpJc0NORzM0?=
 =?utf-8?B?WDBGQm9sM25JaGtKWkd6WTNwQ0VzWW5TOVBtY0p6NDdEUTN2M09iM2J4b2NJ?=
 =?utf-8?B?Zm9DbS93R1JHY2crSXpJb0VpY1Q2d2RFS25UblJyVDB0ZVpYWUtZckViWFI3?=
 =?utf-8?B?QW8rZlF5cjRkUG5sYzhuVDZuVFY3V1RvK09FY2JBdEJzcGZTMUpJWEpvalJF?=
 =?utf-8?B?bDhnZnhEeXYwV3hHM0FuUmp4QXE0eUtxanVCdU1kZUFFL3NqTXRQMVR4SEhj?=
 =?utf-8?B?SlZRRnd1dlhrendvcHpwV1ZKNXNVbVdjQk5HczllMExBakhNUFU3T2ZJb0RU?=
 =?utf-8?B?T3JOTC9iVGEydmJFWko4dG9yb0t1YU9jN2o4K0tzU2MyQnZleUg4V0JBaHZ0?=
 =?utf-8?B?Ni9WQndRRnEyZnZaWXBUQXp1L1phaGxhTHFkbXUvVHphYUlzSTBZN3dwRjY2?=
 =?utf-8?B?UkxCWFFnZzVnVWljU1FXdUNJT09NeC9CNkxPMk5iTGVmcEQ1blVZZVVvcXFZ?=
 =?utf-8?B?TkFvL3F1ZE1FL01CNWMraEFBdkJ2UU1QckgyL0RxSFNpL0FNWXRNN2twN2Fz?=
 =?utf-8?B?emtSMFhMRWNudThIU0JBcVJsRjlLMDBhR1NmbnkxWkhTU2twcEVBYy9vaGRq?=
 =?utf-8?B?d3NpZnM3WVhmUm5rVUd4STdybGFjYlZKeG1sN0hxUXBXcDgvWmhRMkczUzlD?=
 =?utf-8?B?Nnh5RW1oSnJONEpzNnhPYzFtaW5hR1BHc0tLZy9sZG9IVExuaC9NcGpuT1JR?=
 =?utf-8?B?cVpuVldKcjZwK2dIbHdPYkwwQWpxTEhNQmM0TWw0VVRjVTlHRW52dXhYTEcv?=
 =?utf-8?B?T0oyL0kwOEovZXRhamlvVkZram03UDFta01ncW4wekZMVmNaVytpTzJWMysw?=
 =?utf-8?B?OXdOK2tINEVlVmVIRCs2OGlGcmpXaU9qemFPQ3RwS2s5WkM4TkRQUUFMZDZV?=
 =?utf-8?B?c2RlN05PNTIraXdXTDhrNHRJVlZ4WENhcDJXdUFMTWlreER5amRrMVVlaFJK?=
 =?utf-8?B?ekcyU0FOUWpOcXg2WGllSTdzQzMvRHdvaStUV3V1Y1VXTjhVR3FBbm9Ib3I4?=
 =?utf-8?Q?0WoezC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5102.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHZ4NE5FM2lBSHBHd3pJeG83dFBKaXEwL2YwTlN3VkFGd3VUMW9vcjY0U3BQ?=
 =?utf-8?B?alB2K1lSbWVudUxlenU4NzYrTUE1eFd5R2p1WjBMYlZuZzQwZTNJeFVMWjhl?=
 =?utf-8?B?Z3lPMDJDcnVtcWRac3lnTmdpdmY5MjBqMC9qZ2U1VDJVY3dnWjB1aUVGTVNu?=
 =?utf-8?B?NWIrdzlJT3JRWlVTTTN6U1B1aEtOd3VpWm9VREExd3NmSElkc1dveExlckJw?=
 =?utf-8?B?Z2Vqemt0QXNvRlF1dU5McnlzQkxYZVZUWkZuM3N1SlJ0YXhuaFhBTUxjTTdm?=
 =?utf-8?B?dlNvaWZUeTBhdTRUdE5CeTVIa3pJNDlBMlNrMGlISkZydTg2YnJ6VGQyb1Z1?=
 =?utf-8?B?U003dVV1MU9icTZKSXdSdEtDOThHdVJ4RTdtYkpBQ2QwN2VSK3IzWU5IUnp2?=
 =?utf-8?B?b0pxN04wNFQ2dTJzdlV3ZFNzZDdzVTNvbm8zVkNiZXQrL1dTKzU0cENtR1Jn?=
 =?utf-8?B?Y1BINTZxTkd3K0NTYkZpd1h0aDc1TzZ3VFlXbVZpYTAvYS9NeVkzVnNBQ3JG?=
 =?utf-8?B?Y2xpTUhTM2ZKdlFaOHdHRHF4NXNKVDkwZGJDNE9sQW1DQnJMUDZML1JDRlN2?=
 =?utf-8?B?R01rNytrNGhXZGlrc2VlL2FSM0ExcFRBZlkvRkZvVHV1LzB2QU9lZ1hiQ1Ro?=
 =?utf-8?B?UmZZcythQmJWUTRXRnVpSERJZmlzRWlqUnFMNUtETW1pM2EvU0JCUE9ydVRz?=
 =?utf-8?B?bXBIK0hnTTR2Rlh1WDUzc0Nyd09DOTMwS2FndmZHY05UNlYvTWF2ZU8zbENt?=
 =?utf-8?B?RS9aZzNiVEIwNnlKb0JZdkhtbzBYQ2pBNm1CZXBoRVBEaEZHeUxPVFJFM2lk?=
 =?utf-8?B?Um8rUkkzano5OVhYWlBmNUxCSEtQMnhPdmQ2SmtVdVgra2VHRXlFSU5ZV2Nz?=
 =?utf-8?B?K0dMSm1DdzFKRDlxK0NDMWN2WXNuWnpqYmZBNnFwT3JSdmZjS25jN0RLUStx?=
 =?utf-8?B?bkpVWEhoRlYxWFVIQ3FlUUlFcEpMOWZMc1NXUWcrOW1sY2ZZMnBESW1OclBh?=
 =?utf-8?B?YUQyaEtKYmp6L0F3UHRrVTdnd3JMWXFOZ3ppekloTXhOSGl4TnhnY1Q5YzlU?=
 =?utf-8?B?Vy9rU0kxbytWd3h5d2J0bDAwOGx4REJLQjBERWgvMDlmZGlWa1BzZVhpRFJH?=
 =?utf-8?B?VjVhSmw5WEpINlNlenhuU3VTcFhyZnN2dW5MZGJtQmVvR2YzNjZPSVZTWXdG?=
 =?utf-8?B?bHo0N1lqOVVBaFJ0NFFZVDNFb3FjVDFTbmhQaDZrNys0dU1VTGZmWU04d2lY?=
 =?utf-8?B?WWoyY09CL0N3VlIxU0hlbzRlY3NpU0JKRDdXR1NJV1M4MGxPVTBxNlhJbE1i?=
 =?utf-8?B?U0g3TE91T04rd2gycUJmREh2bDBKTUpkWHBrQlgyR0hXZzJRUjF6U3R4ZnE1?=
 =?utf-8?B?dGhkNUUwODZPNjZvN1U1ZGxwdXpVdlY5aktMSVl2bkZZMDh6UWNxbU9pU0c0?=
 =?utf-8?B?eDhVckc5ZWJXblBwTlAyTmRDejI5Nm12Sm1XV2VSbzdxRGN1eXA0L2pYbkZO?=
 =?utf-8?B?UmpBNGRSTUxubkR6akJpSlBoSzlYTjk5Zmd4UEJETUMxbklzRWtScjVTSDNX?=
 =?utf-8?B?L1pKRTByS2F6czN2SHdSWXNZakNQQVZPUkQ5ZEVWQk9rUnNRL29CMVFaQSsr?=
 =?utf-8?B?RmF0SHRsR3Z0dERYYzFYSTFnQ0F5eUc2LzVxaHY5TE4wcys3RjBBbCtuQjBG?=
 =?utf-8?B?K0g5RjduODYvNnRyKzV5a1h3cDNDb2tUemhIWWdIMWdwSmtNWG5PRmM3cXAx?=
 =?utf-8?B?OEZhcEVIVVpRTHd2UVRld2lqMC8rano2QUpEMVEzOTZ0SGZqZ3dJWDNBdXMr?=
 =?utf-8?B?aDRPcE9GSnBQWDlHS3hvSmJZQ3Rjd1JnZWlZdHRqZ3VNd2xNT0RiWERhZm1u?=
 =?utf-8?B?cUZWaUZtTktxb29mWk5Pa05XME9zQS9RSGJpNjgzbjgvWXhBUER0WTVodElF?=
 =?utf-8?B?eW9BODBxZVhSdWRJSDNBLzM3ZHFob0tYNmkyZDlJR0Q0NlRVV3hpWnRRejRH?=
 =?utf-8?B?QjZEdEtLSmtqaWRHeEdZQTJyUGtwM2dkenh1SEZZWWtrMmxaR1JSNU1TbGgw?=
 =?utf-8?B?RXlldmw1SkdLRmcyLytFa0FnOUQvVWZrc1gwS2FKQXdmM21zUHFQK213NWhO?=
 =?utf-8?B?SXRzbWhtZVp0Sys3ejZnM0hvbkNXWGFVWmk3cWl1dEt3YnpyS3JaRDRPWmgw?=
 =?utf-8?B?aTBRZnBIeW1SWmh2WnlLb3g3NjM3eE9NUU9keGZTc1hNQVBxS2o1OG1MRy9N?=
 =?utf-8?B?TW5uN0RGMDZ5S3RqVHJueWRnRUlNcTN1NURFR29mNHE0NVR2MWpKWkViQU91?=
 =?utf-8?B?UjJXVktGaEFwLy9IQllMM1hkWDRzd3hUMTE4eGtxN0o5elRoRTQzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1BAF91B76D22D4998F921340BFAAA8C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5102.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849f73ed-1968-4c80-2709-08de4f066c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 22:36:53.3130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4rnetB9IJG8n1QruvPFSnrWAisfN/qp2yxEOuXx4sUXf9SakW9eYCFI/2fbDejwG07aAbJzycHXG7qIKQcm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

SGksDQoNCknigJl2ZSBiZWVuIGFuYWx5emluZyBGVVNFIG9wZXJhdGlvbiBjb3VudHMgZm9yIHZh
cmlvdXMgZmlsZSBvcGVyYXRpb25zLCBhbmQNCm5vdGljZWQgdGhhdCBvcGVuKCkgd2l0aCBPX0NS
RUFUIGFsd2F5cyByZXN1bHRzIGluIHR3byBGVVNFIG9wZXJhdGlvbnM6DQpGVVNFX0xPT0tVUCAr
IEZVU0VfQ1JFQVRFLiBJdOKAmXMgbm90IGNsZWFyIHdoYXQgdGhlIEZVU0VfTE9PS1VQDQppcyBh
Y2NvbXBsaXNoaW5nIGluIHRoaXMgY2FzZS4NCg0KSeKAmXZlIGJlZW4gcnVubmluZyB3aXRoIHRo
ZSBwYXRjaCBiZWxvdyBzdWNjZXNzZnVsbHksIGluc3BpcmVkIGJ5IGhvdw0KdGhlIE5GUyBjbGll
bnQgaGFuZGxlcyBhdG9taWNfb3BlbigpIHdpdGggT19DUkVBVCBzZXQuDQoNCklzIHRoaXMgYSBz
dWl0YWJsZSBvcHRpbWl6YXRpb24gdG8gc3VibWl0PyBPciBhcmUgdGhlcmUgcGFydHMgb2YgdGhl
IEZVU0UNCnByb3RvY29sIHRoYXQgSeKAmW0gbWlzc2luZywgd2hlcmUgY2VydGFpbiBGVVNFIGRl
dmljZXMgZGVwZW5kIG9uIHRoaXMNCmV4dHJhIGxvb2t1cD8NCg0KVGhhbmtzLA0KDQpKaW0NCg0K
DQoNCmNvbW1pdCAzMTZiODUxNzk4MmZjMzkzMzU1NGM0NjIwNTEzYTgxOWQ2MDY4NTJmDQpBdXRo
b3I6IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAbnZpZGlhLmNvbT4NCkRhdGU6ICAgV2VkIEphbiA3
IDE5OjM3OjIyIDIwMjYgLTA3MDANCg0KICAgIGZ1c2U6IHNraXAgbG9va3VwIGR1cmluZyBhdG9t
aWNfb3BlbigpIHdoZW4gT19DUkVBVCBpcyBzZXQNCg0KICAgIFdoZW4gT19DUkVBVCBpcyBzZXQs
IHdlIGRvbid0IG5lZWQgdGhlIGxvb2t1cC4gVGhlIGxvb2t1cCBkb2Vzbid0DQogICAgaGFybSBh
bnl0aGluZywgYnV0IGl0J3MgYW4gZXh0cmEgRlVTRSBvcGVyYXRpb24gdGhhdCdzIG5vdCByZXF1
aXJlZC4NCg0KICAgIFNpZ25lZC1vZmYtYnk6IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAbnZpZGlh
LmNvbT4NCg0KZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jDQppbmRl
eCBlY2FlYzBmZWEzYTEuLjY3YjBhYmM0ZDM4NSAxMDA2NDQNCi0tLSBhL2ZzL2Z1c2UvZGlyLmMN
CisrKyBiL2ZzL2Z1c2UvZGlyLmMNCkBAIC03MDIsNyArNzAyLDggQEAgc3RhdGljIGludCBmdXNl
X2NyZWF0ZV9vcGVuKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwN
CiAgICAgICAgICAgICAgICBnb3RvIG91dF9lcnI7DQogICAgICAgIH0NCiAgICAgICAga2ZyZWUo
Zm9yZ2V0KTsNCi0gICAgICAgZF9pbnN0YW50aWF0ZShlbnRyeSwgaW5vZGUpOw0KKyAgICAgICBk
X2Ryb3AoZW50cnkpOw0KKyAgICAgICBkX3NwbGljZV9hbGlhcyhpbm9kZSwgZW50cnkpOw0KICAg
ICAgICBlbnRyeS0+ZF90aW1lID0gZXBvY2g7DQogICAgICAgIGZ1c2VfY2hhbmdlX2VudHJ5X3Rp
bWVvdXQoZW50cnksICZvdXRlbnRyeSk7DQogICAgICAgIGZ1c2VfZGlyX2NoYW5nZWQoZGlyKTsN
CkBAIC03NDMsMTQgKzc0NCwxNCBAQCBzdGF0aWMgaW50IGZ1c2VfYXRvbWljX29wZW4oc3RydWN0
IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmVudHJ5LA0KICAgICAgICBpZiAoZnVzZV9pc19i
YWQoZGlyKSkNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCg0KLSAgICAgICBpZiAoZF9p
bl9sb29rdXAoZW50cnkpKSB7DQotICAgICAgICAgICAgICAgc3RydWN0IGRlbnRyeSAqcmVzID0g
ZnVzZV9sb29rdXAoZGlyLCBlbnRyeSwgMCk7DQotICAgICAgICAgICAgICAgaWYgKHJlcyB8fCBk
X3JlYWxseV9pc19wb3NpdGl2ZShlbnRyeSkpDQotICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gZmluaXNoX25vX29wZW4oZmlsZSwgcmVzKTsNCi0gICAgICAgfQ0KLQ0KLSAgICAgICBpZiAo
IShmbGFncyAmIE9fQ1JFQVQpKQ0KKyAgICAgICBpZiAoIShmbGFncyAmIE9fQ1JFQVQpKSB7DQor
ICAgICAgICAgICAgICAgaWYgKGRfaW5fbG9va3VwKGVudHJ5KSkgew0KKyAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGRlbnRyeSAqcmVzID0gZnVzZV9sb29rdXAoZGlyLCBlbnRyeSwgMCk7
DQorICAgICAgICAgICAgICAgICAgICAgICBpZiAocmVzIHx8IGRfcmVhbGx5X2lzX3Bvc2l0aXZl
KGVudHJ5KSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZpbmlzaF9u
b19vcGVuKGZpbGUsIHJlcyk7DQorICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIHJl
dHVybiBmaW5pc2hfbm9fb3BlbihmaWxlLCBOVUxMKTsNCisgICAgICAgfQ0KDQogICAgICAgIC8q
IE9ubHkgY3JlYXRlcyAqLw0KICAgICAgICBmaWxlLT5mX21vZGUgfD0gRk1PREVfQ1JFQVRFRDs=

