Return-Path: <linux-fsdevel+bounces-50367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78BACB7A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5228EA22F14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF4227E8A;
	Mon,  2 Jun 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kyKtcMR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A82226D19;
	Mon,  2 Jun 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876648; cv=fail; b=ZTw2mlqvDcw09cFNhqtRn4jEpya1xRRDJEnZBUFUTxcpNs/wL7Ps2//dbr8vabwnyasnizepfIvu+xuC1xYCXARyfriw9F7qX+/uY78gR9+0I6ZHzq47THfdozI2KeHFgxXlsdMzz9mP66w0RdcBLIVOnjrHlGu2TMVjN+MD9s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876648; c=relaxed/simple;
	bh=f+Tjl4U2HmJ1UPWNMJGyYTlofAAh25xpvEFPc+MrgV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6OXnOEM0dj42Obzxolhmf8AvLhaIo90NcxDWWjSzSKphLgMAG06YvBQaJQA1692R0m8033ZxG8Q+tCfEZFgTUOnXvY7DisSYd8u2eQGXc4SR1p7Q+jmV8pJvYPoSwGq/l2rUAC+apQdU0ADWNw+WmtRbv/muxPoE/7fUkUQaOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kyKtcMR/; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNKDIzrdcAo4iOtJ6dXEXezU5sUFLsqS9ywFk5sAB1x4hpBPkpTvmCL5VggHP/GVQArhgQdN2mpMeLW7j9GsIp4ZNPchnI6laguJJoY3ZWEkWZaq8k8+P086DLDzaMFjhpFy3jzd9w+pSAvMM2w2b4oBr5zYnK2bEEV4FzbnYaC03Fnd0yPiA9C0lrnml+a1OJB+RrpbNrZwixbqGpqfbKyDHcKNaQsxmiOKwbvrRfPc6XmLkioI4vtw4bLfzmQi+OM4Ydw7vVd92kx3vAcxwFIO9TTDX+5qKewOQblg0mPqRYP3LHHxzCBQKPs50hcHJB7dJKqq4x78nFZ6mdr4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+Tjl4U2HmJ1UPWNMJGyYTlofAAh25xpvEFPc+MrgV0=;
 b=frnY3ayVj2K6GiSxZgSPD61KR0ijfi6dmSREV8QRKWA5OQZbQrh/dJgpskiWikNYrR6UO8qC+kQQjb2N7QtKuFC1cqupi4lOPPyW4NziBSBdP7r4LwAkAwJS2d4q7i3DI5g+WXd7LsCtRp6paLfHymoOMrT9ot3EzxDhB8yWyibm9WEEESHP5Ep9vS5ViHkMZpC98dUrkm7JaM2aQ5bnaMGrQpUSDD9o1kuEJ4c+FG0fZ/TynzVxOQzQPuNeSfMW+29ekipi+GmnOz5C+39cPTEQBqgZYokzGbUSS6exSBbkL4hy3/w/PytqSPmodf5cHTeNO2e837zHFhr1CQOReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+Tjl4U2HmJ1UPWNMJGyYTlofAAh25xpvEFPc+MrgV0=;
 b=kyKtcMR/qJzb2W6mOdYS77Vp4nw0h71w+m/Ra6PJnYukbiZwBSH4SIAfQ+zrNGcl0dxLpq5tcs4XDL+lzGVc5aGFrLD294nJSp+tVVHrtw2PV655VX8ggUJsdsxec+nEyK2SNPhFmONIwBEl3YVnztXvyMlkDMVlZFHGV87NFQqSstbioyEcWrZBOe6/fzhYJGI6ZClAJhIIUBiipge6U2aGvUFccfwrfjqA1J/bz5689sGZb02mt1Zr0C28+lyHNtg9Cvmr/5bm9yOd1AZSAeP4qiwHtUKaywmizfbFCU7gVTXbauhIPwhvQ8rJ1avzahbh+p/14ay2txwrG3yh5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Mon, 2 Jun 2025 15:04:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 15:04:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Mon, 02 Jun 2025 11:03:59 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
In-Reply-To: <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
 <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 979257f2-4d84-4329-44d3-08dda1e6b589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkxCZFIzanFRVGJpRUtOQlppZzNMRTZYT1FpSjhsbHFJby9FR0pTMlpOYW5r?=
 =?utf-8?B?VUJod1dYbUxnQThSenRucVZDemRMRUdLK0hidVdaVEZRUDM0YldRYzJHVWxk?=
 =?utf-8?B?THRRQmtXRlpUQVF4ZXJ3eG01dHR3MEFjUVo0UGxaaGhUQXA5K0tKdy9hZU9t?=
 =?utf-8?B?V3FvNnQ4NHVnb2JmdVcrZmtGaWlQaTBTMU13OHpONkpNcFFJR2h4TUY1M0tS?=
 =?utf-8?B?MHc4Z2laUWxhTEsxV2hOcXNKa25VdkxTbktMVTh6WWNTeXdnWnpNRVdjdGhJ?=
 =?utf-8?B?bG4xR2xoZkJmdUV1TmpCeEVFNmNXQUpvZXJ5S0xwS2JUYkxGUlc0bWZPV3JH?=
 =?utf-8?B?dHVMdEdIUzFKaWgyd29aSWpMSkk3V2NKZDNJa3lwcW90eEpaSHNvMG5rN2tQ?=
 =?utf-8?B?M0l0VTBablNTNUVucUVPakFvNi9zRlNHdjNaSmtvNVJHNE9ZeCtlZ25HeDFF?=
 =?utf-8?B?a2plbURtam9WNnRpUENIQmtBRVZkVnM1VEtjcWYyRjJoK1pjbWNaMUN6ck1F?=
 =?utf-8?B?MXZSWmVmMDQ0OE1sMW4xN1ZNeXFnSEJIVlJWMmU0aEJDdFd6WWJIZzZpeHow?=
 =?utf-8?B?YU92eXhPS2lQajZ3cFRxTnJQVDZ0ai9OOGxHWlY2QkU1S2d1MnVBYXRTNlFO?=
 =?utf-8?B?RHM4MW9tbHFOUW1ydkh3SE5RYlNtM2hTd0x5WVlMQjIyZkMwMHVWRDZZWDlS?=
 =?utf-8?B?aFRQWHYwL1IrR0d1aFQ0emlSMWsyL2xEQ0E1enNGMDVpZUFsQzJZeVh6RnhI?=
 =?utf-8?B?djM3WlJjeGFmMm51TThPRkQ4ejFmNzhLdDlWR0hKNVdLbXN6N2tSclVwZFRQ?=
 =?utf-8?B?eDVJdzBpL1dkQjZOUUgzVzZvdk1uU1lxWndJY0hCTUhMY3FRTG9ML0FYcDRp?=
 =?utf-8?B?a1Z5S1pabnZvMGtvckFVU3JtQnlzRUh3bG9kUVM2STZVTmloOTBGSms4Ky9i?=
 =?utf-8?B?YnBvSVM1bEpJTWZPL3lDNDNYRDZyejBVc09JaXpsZldFdno5WkNoWmFkQTRG?=
 =?utf-8?B?N1U4aWtIWnl4NVZmaTJsMmNTV1Zwd1pjdFVKd1ZIWWpOc2lVdXpFb1pnMGFt?=
 =?utf-8?B?Q01oYkd3aElwbm00bEZtMmZXVDVFd2VITm4ya3VBMzJYOTVGRE5WQkdyRFZj?=
 =?utf-8?B?ZitSZm9mQi8rbzA2NUdnZzRIZDE4UzlRSHZZWTNPMEVZc3BsUjZyQm1aNVFM?=
 =?utf-8?B?eG5lZmRELzFpVWN0Qkl2RnRCYWRIZG9WU1U1NnR0ck1Sb3lGdnh1enVUOXBY?=
 =?utf-8?B?SXpiSVVmajBHY291QllxUzMrSGxXY04wVTQwK0JuOXd1dU9IZnlWZXVkY3RE?=
 =?utf-8?B?MDQ2SC9VRUFrQlUvRlNFZFZROGFhcDVTL1M2TGFYR0pWVE9zamJ4SUxqMFVk?=
 =?utf-8?B?UU1tc1ZkN0hZVEZ6UWxWVTRibFNCMHZVQjJTVTEydk4zN3hkRUkrT1R1NUEy?=
 =?utf-8?B?VGdma1pTajg2bmJHSGZZTVZKUG1aeFBQbUd1N1hPNENJalRMaXY4cGlpTE5j?=
 =?utf-8?B?WjVSQlBuQlN1QUc4dktkMGJHdWFLTzlyVnpKc0lNOEZEcUMwdHlMVzlHWWRH?=
 =?utf-8?B?THhNM1lDM0RiUFBPZU5FSFFnNFNqNGN1QlE1OFQ2VXB4YjNwOUQ4enlwZDQ3?=
 =?utf-8?B?N2pkbUVHY2o5ZTFSVlJBTXU5SFhFcXpBdmRyVEdRUk9hL1E5TitOUCtkYVFx?=
 =?utf-8?B?VmtFZXNqbzllNWZtRDRteWNsSDlUbXh0dHM3ZzdaendoMm9GZVNqM2RWMjZl?=
 =?utf-8?B?c0JYQWhoTitzUHY2bE4xaDh1MXJ3WnhjTzVXZFdYRFpUTWVhKzNkMENPUGha?=
 =?utf-8?B?cEEyOWttbFJJdUJscVVBUUYvRUNnQm9jV2hucld4eml0cTl2bm9RM2JERlh5?=
 =?utf-8?B?QkJxSVF5aGZXWjdrdXNCWEZWMndmdC9ZOFRQZFpzbVNWK0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWVJL2dDbmI3d080VTkwcm5zQm1LZU16SUxVOGZ5YUpsQ0VxSHU2Q1NmOUIy?=
 =?utf-8?B?Wk43aEUyWGFuQU5sYUVZOXovY2hYa1B3S3BPdlhZaVIvY0x6eVhyLzMza0tC?=
 =?utf-8?B?dEhXUmdYOTJaMDlFMU8zQ3RBNGJieWpqOFIvRkd4SFNHeUk5Z1NjTGdzdlhn?=
 =?utf-8?B?VG44cmVabnJpYkhZd0F3aE5HZk1iTG85eVJvdkV2a2NJVE00R25yYWZvQVpS?=
 =?utf-8?B?YVRnTUZJd2ZVQlRGV29VcmxFd3VzbHhEK051OWtXUlhCNG5uYjBDdS9XTTlX?=
 =?utf-8?B?QnRvMk5SQTRobHl3Z0R6Wis3RGhsN1BYM2FVU09YSWtyRzd4VnRCdU9MM2ZW?=
 =?utf-8?B?Mm80Y0h4MEJ3MVZUMkNEQ1RVcWxjazFtZ2JCUzRFQzdKYjZZK09JSG16TUtZ?=
 =?utf-8?B?VldVNS9SOEhvQnFVOWpxZk5zZTJlQ2FqQmU5QkYrY0NYWXgzU21mcDROaUxV?=
 =?utf-8?B?c3dXa2xVSEpDY3VhUzhNR0ZJNWFHa242bzNDd0M0c0I1UHp2TjBicjkzdllG?=
 =?utf-8?B?TFNkaGphaEZTK3pseEZmVSttK0dZZWxoa05aYm9QamNBcUtZUEpCY1pLaWxm?=
 =?utf-8?B?VkZKWExhSDVwR0I1dVJKNDhGamxUN1NZR1U4MzhBT2pUbDJtai9lcWZCSjQ4?=
 =?utf-8?B?WTBPYUFNYmphRGlaZnZTUjhRUWRZVDBxZTdlRThFVkVvUWNycFRTdWxIZkJR?=
 =?utf-8?B?Wmx1WlFPWFN2L0R6SmEvRVExdFBFL05sSHI2amtXN0Y0V0hRTkxMaHdDM0hQ?=
 =?utf-8?B?Q005Y2JhaGdoL09XYVp6VCsvRTJSSk9UTnBYaHpYL0JJRzMrL05UaUMxYitL?=
 =?utf-8?B?Nk95L2V1ck9mcDIzVm9GR0ZrSnBiZ2JXNWZVcUZHZWV6cUludk1PdzB4TitY?=
 =?utf-8?B?NXVkOWNXZU00aFAvNVZqbVFFbXVnNU9mV3hjeHRabkJiODFhbENjNU50YklY?=
 =?utf-8?B?ZlJadGRNdjhRRXYvSzM3SXBwK0FKZ0R5TWp5a1Z0bng5SUUyUFozZkt1b3VJ?=
 =?utf-8?B?dW81dy9aSzNyU0NaYXpyMlhXZkgvcWtQdEEvVWhXaHJYODRkeUhqSDFydGZ2?=
 =?utf-8?B?bmg2WnBlODhraGg1Kzc1THpTRVFHSCtlUDBLeHQwdWtmeE5wSVNxRE9XR3Ru?=
 =?utf-8?B?L1RJbTFLNktPazdnYk85SVNXYThVaGFuQXpFSVNnSHRXbUdDMGZqU3pOSnBC?=
 =?utf-8?B?TjNhbmFDRXNuMWtkY2xlZTEwcmttQyt0VzEzdTlYaWgvZnMrR1U3VGVjSUJq?=
 =?utf-8?B?cFp1NWNTYm11cEVxMDV3N2lZaUpCM0kzQkJtc0d5NExacWFMODk1TG9uakg1?=
 =?utf-8?B?VjMvTzd2bzI5Y3lRL0ZsOTAxeGdQSGhlRDE0N2NBMm9pTkErSlRTMmdDUGV5?=
 =?utf-8?B?b1FieGhjTVZRcXdyWFVURW9abHNxSTNYOHUvQkorYkVrZzQxc0xSS1JQNmVB?=
 =?utf-8?B?ZFhFRHpXUkFvVTE4Z0hBU20rV3JZUTZlaFRNRjdSemZlNHRrT01ISDU0R3JP?=
 =?utf-8?B?Z251b1BSZ0hubFJKb2xIM2FTSmEyTlYzbldRNVRPUUkwT2Joc2hXZ1BwYnRN?=
 =?utf-8?B?U0QyeENCcG1heXZwOTlnb0Z5cXR2MjQ2UnJSWkszcEUveFd1QTRVNDQ1QzVu?=
 =?utf-8?B?dTBhUXRTcjJLUE9TMS9KVmh4MjVoU21LZzhrYm1HRzMyUUtNRUZveTU1a0hO?=
 =?utf-8?B?UEVKZXJKU1UzTVBDYS9JdjZZZ0Z0WHpRbjdIWEZXZFVQaEhyMnpBZzVWYXpx?=
 =?utf-8?B?b2xXNDQ0SVI0R2VSdncrekJ2UDN0VVhQbGdmWC85OGlVcVk1QlUwZzVQYXRQ?=
 =?utf-8?B?WVVuenBmQWdCcjZodGNlVmFGQzlTd2ZnRWhZTnM4QjlpNTVoN3prejExK1dC?=
 =?utf-8?B?MW5WcUF3Z1BrRVVpY004eU9GSSs2dzFvbkRPQUxXSTY5Ym0rdFVmM2M4eVY5?=
 =?utf-8?B?UHJZUERSNFZ4bHpKZ2JaMkZqUVpvRWRMNjAyUksrbThBemFBSFZVcEgxR3lW?=
 =?utf-8?B?NlE1aVp4bStXaHU4eTJ1dzBZdkpBMGxDa2Jxa1Bjb3hZZWFEdVh0VnRoazMv?=
 =?utf-8?B?dWlnTm5SZ2ZtSVg0MDhWMk1QRG5KRmRPSk5XdFYzcUtCNFlWUmdyeWpWYXMy?=
 =?utf-8?Q?/qlEX+7DBFGRYVKIaHgIKUilb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979257f2-4d84-4329-44d3-08dda1e6b589
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:04:01.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPwbvFmKUg9vFVqKhPHuIOayvq5VGfQC8VAqIxnHYIlfhFUYid0AquNLV9mNdBRC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

On 29 May 2025, at 23:44, Dev Jain wrote:

> On 30/05/25 4:17 am, Zi Yan wrote:
>> On 28 May 2025, at 23:17, Dev Jain wrote:
>>
>>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>>
>>>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>>>> Then it may happen that the computed slot already falls beyond the batch,
>>>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>>>> when the entry is a sibling entry.
>>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>>> You can compile the tests with “make -C tools/testing/radix-tree”
>>>> and run “./tools/testing/radix-tree/xarray”.
>>>
>>> Sorry forgot to Cc you.
>>> I can surely do that later, but does this patch look fine?
>> I am not sure the exact situation you are describing, so I asked you
>> to write a test case to demonstrate the issue. :)
>
>
> Suppose we have a shift-6 node having an order-9 entry => 8 - 1 = 7 siblings,
> so assume the slots are at offset 0 till 7 in this node. If xas->xa_offset is 6,
> then the code will compute order as 1 + xas->xa_node->shift = 7. So I mean to
> say that the order computation must start from the beginning of the multi-slot
> entries, that is, the non-sibling entry.

Got it. Thanks for the explanation. It will be great to add this explanation
to the commit log.

I also notice that in the comment of xas_get_order() it says
“Called after xas_load()” and xas_load() returns NULL or an internal
entry for a sibling. So caller is responsible to make sure xas is not pointing
to a sibling entry. It is good to have a check here.

In terms of the patch, we are moving away from BUG()/BUG_ON(), so I wonder
if there is a less disruptive way of handling this. Something like return
-EINVAL instead with modified function comments and adding a comment
at the return -EIVAL saying something like caller needs to pass
a non-sibling entry.

Best Regards,
Yan, Zi

