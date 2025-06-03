Return-Path: <linux-fsdevel+bounces-50415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC1ACBF89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7116C3A621A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA21F2B8D;
	Tue,  3 Jun 2025 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QpGePR6M";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QpGePR6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F122C326F;
	Tue,  3 Jun 2025 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928261; cv=fail; b=hlIOwxIDJPdkfR0b0lieghCJBqgNt4wUCXjl0V5yCVu1mPKeTdtQX0xRDYlyR3J8eoy2ekiCyLe21WHphWULkfvS3rPBxyAY4VSgUSDF9bI5f4dInyYr/966/sgxDeX9IhhfeetwEWXuutqtaPtKXqYWerKd+bEddRQB4A+G7YA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928261; c=relaxed/simple;
	bh=iRyDOIrEMbjDwjkNTZm9lh9GPkQ6vme9WdzNVWw5cGQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPoWH5cFPEICr8BMayyqgd0617SFBYIlNwxjKwVDGwRvwpb2Z1VCK3jrpMS5koMQ4SasQnKG59KaWsulcBmi8fzV1P8wXV7Ifw9jabgU9W4hO89MrKLNBsvO1B5tOGQgJBykUWhjTrd/raHMq5TpGqJDR8Ga2ecbjj0Cek+GudA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QpGePR6M; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QpGePR6M; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HUDFywUcBNzhHU0P1//NPytTOg8ejh6wMGjLp9iNzgPx7DFaBXR/nqV4EBnDjZaRUbgD93FOlhOHEXJkma4fzISmLv33Dbs49obYaz/YDwstEQoWTcJGiS8UURkdfJd7SF0GM/eiKuwyWbpLNdqTxKQVrbRqGm+AaJOXrvPb3zhefmaZu+sn6i1oECsQilB3hJBDrwlQc+BHDIeKCUMjAch4wmk/x4Exq6lHnbMCiSOeSdumGyDWRPU2BodAIXMHKjo2W3xshc3hXRqS1QE1rHwKsh8elahoVnZaleDiy9lWcRtJWLseQm5jK/WJuBRWnNvFMiRZzO+ycc6hVx1HZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRyDOIrEMbjDwjkNTZm9lh9GPkQ6vme9WdzNVWw5cGQ=;
 b=ZoCTcBEt22ovwkZNR/Fc/OkmQM52FYD2wH9WY8laTNIecqC6JHwSoVyqH8unECAaoSG49zZRRgt22vkScspG6ouAjUyl0Y1D71nG+ft9uBq4TJuuHbpxPoNQHVBSrNoEkaARtPGXGCDVNtaG9YpEuAH1+gz2b2PXwgHctOspEZYDUqrS9C5zRDkchlPiehlWXpTu/esjgHBwgMpo87f0WXnaW3PJU+PkXKZmE2xflpcMnHI/7ifQtWMq13oXecv3IBX34HWyXb1kAAYvbi22TulxMUWv/oNUMXTNKfIlSdY1ls/4YhacxrgUJTXPMwvInQHSm1hWOXqtNw2/5jW9aA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRyDOIrEMbjDwjkNTZm9lh9GPkQ6vme9WdzNVWw5cGQ=;
 b=QpGePR6MDWJ9DOsXOKbrPLZzvhGdIaJHlVsMMI6vLT52Ir2FFma5Nhm4e8TxMxJKTxXSzAqglGCbj9X2u5BspPMnzEfB6Q5DVLbIqRhPmiJlmYyUxoIYxsF7hZAPp0eQXATZ2OQzWW2Hwk5WpmpAIxjDpuwSJ4RzdDcluAEMB9M=
Received: from DU2PR04CA0274.eurprd04.prod.outlook.com (2603:10a6:10:28c::9)
 by DBBPR08MB10555.eurprd08.prod.outlook.com (2603:10a6:10:53b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 05:24:12 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::67) by DU2PR04CA0274.outlook.office365.com
 (2603:10a6:10:28c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Tue,
 3 Jun 2025 05:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 05:24:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii7+i35qQpnNsWjwou7drCIwBEipSMOR+xN0OReYzYBMfyB6bCT4E3bo8H8Rws72/vAOmctS8P3l+urmzyG9rz27oyBkqa09gR3mMjNGVhyjxlef/3dwKDdYZDXCef+IGwuLReaW65k3T9Q+pjxWYC0/bUPOG6gSl/b67kKzssX2rQdGnBB02lftRsVF6uM9rLNuB0PBOrV6NKtziVAtWD1//bhIL/hRXTkP/SELDBDEwP8WQWOs4GnHcpYAdfbILfI4l76ov0oqsaAngrwY5v199//f2gxPfZR8HSc6nY9r3OdHaH1gPJFlg2ALFbmkgdIkGEK7Eld0yktTXWM0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRyDOIrEMbjDwjkNTZm9lh9GPkQ6vme9WdzNVWw5cGQ=;
 b=esL66VXylu795CK6ZxhD9FSx2txZC2awXPHAyPZSmlwM+PUMoetOThDTp+wyJVJeUhnmAcZMkdKHKnw+iWup/GE7nyoxz23JZNTFIDolZjL4KkmhLhi+7JeBvbwRv5zMS0nEhj9DJrFvU2TAn/rJAdMH9JY9bv0oDmuWMKcdm7M0thfxYAy9IUxX2OYchR5VGN46wISpK5TcE39ksu3TXg24sYXe3ABnffm8RFK+t6VqLMa1QDon0p1G3MMXV+Jxra4ofjTCNhiLDSAuhPksMjcYUSRL/hFHWsu4BRchzUAViM7MESaAFFLUYS4rh4B4tKvTZd8afzce7bBvhKyTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRyDOIrEMbjDwjkNTZm9lh9GPkQ6vme9WdzNVWw5cGQ=;
 b=QpGePR6MDWJ9DOsXOKbrPLZzvhGdIaJHlVsMMI6vLT52Ir2FFma5Nhm4e8TxMxJKTxXSzAqglGCbj9X2u5BspPMnzEfB6Q5DVLbIqRhPmiJlmYyUxoIYxsF7hZAPp0eQXATZ2OQzWW2Hwk5WpmpAIxjDpuwSJ4RzdDcluAEMB9M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PAWPR08MB9445.eurprd08.prod.outlook.com (2603:10a6:102:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 05:23:37 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 05:23:36 +0000
Message-ID: <a3311974-30ae-42b6-9f26-45e769a67522@arm.com>
Date: Tue, 3 Jun 2025 10:53:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
 <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
 <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PAWPR08MB9445:EE_|DU6PEPF0000B61F:EE_|DBBPR08MB10555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6311143f-dd3b-4b44-9939-08dda25edf18
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?d0wvUDJ2SUExbjBRTS9jRnVic3c5Qi9zUjl2TVNFdnc2OEYzVDlteWNySlhO?=
 =?utf-8?B?M1JWMHQ0bXg1OGptRkl0eTJCL2l3dHBZbGdnQTQzcHZ4WWN1LzNlSHhjei9O?=
 =?utf-8?B?SkNGSFY0ampGTFJUQjVoTFVDSm5zOXNPZS9ESUZrOWZuT0pqTjl1aXV2VTk1?=
 =?utf-8?B?czdRWmJPTlFQa1ZydHNLTStBLzRkKys0bkFYZSs5SzRBeVU2V1lqWDRmNGxn?=
 =?utf-8?B?Vy9ncGNNVmRLMm8ySS9IamlyVEx5T3FVOWw2Y21kTTNkU0dHdndoZU5BYk1T?=
 =?utf-8?B?eTBKbjhNUXlsUTRVdVU2WnBKdmk3dGRXOE5yWVROQlcvS0pYa2JqUHZ0bFli?=
 =?utf-8?B?OEZJNXRMM3U4UDlJTWxHeDNjR1BVdTNvZjVYYkl3QmgxRTdGckFRNmFvRlFj?=
 =?utf-8?B?TnNOcWZpNFlGMzA0NDd6dVVneFZnWER2OE5PbzR0amlsazVhWGtGMEF0dysr?=
 =?utf-8?B?TS96QklqZVRnS1hDNUhCWUlKUks4R1NObGQrbU9QY3NpV3pCU2ZLVTdZa2hE?=
 =?utf-8?B?TDNXdXlvT1BreUl5MjFkY1ZoRE1JcXVodXpYeU82OUxLUU5pR1NjQ2FkTG5x?=
 =?utf-8?B?UGtNYVkzNzU2VER6K2UyZ0ErTzNZMmVEeVd6aWF2blBHbEt1eHpIeGlJR2t5?=
 =?utf-8?B?enhnR0lYR0o0UkxkTzBoRW1xemFxT1hXMlFlazZrOXdhTFgvYy9DZkVXNFE3?=
 =?utf-8?B?UUJFcjl2cUo5alZGa09jaG5qeEl3dHpPbytiTC9COWUwbU5Bem1FejdEM3V1?=
 =?utf-8?B?d2tuR0Y2dEx6SnNnb1pvZFFwQVIySC8zNmVWVGpWcWJKUXhxNEh6eWtZYVpr?=
 =?utf-8?B?Z3IrR05zdlk3OFBEdy8xZHAzNCszRlY2MHFxdnQzZkdBR1dvZ21BUVhMbWdi?=
 =?utf-8?B?dm1iQjdsSDJBME9XTlVzOG9TWUhWU2FoMHB5dEJkbGprTFp2VWZmL0s5UmhM?=
 =?utf-8?B?ekprbTRkVUlYQjUxd1pVb0FReVY1VGY2Z2dyWXg4MjVJSldxV2YvT0djUFVX?=
 =?utf-8?B?eXV6akx4dkE3dG11RUtDaDVxekgxSXNkNW5iTVFXS3pkMTBFUTlva2NTWDFt?=
 =?utf-8?B?anFraXFZVlRUMUg4L3BxcGtjeXplWWNXM1ZucTVseTlNQ0hIeTNpNTdGYW8w?=
 =?utf-8?B?MjNVSzB6Y0VlR29RWTZiWC9WZTFPUXZQNGNkd0Vyb3ZhVHdnMWVzYkl3UllC?=
 =?utf-8?B?RHlIbjJycERxMkh3V0RTWHRtUXY5cFZwcTNKTjhxMzEvUmE2Um4yL2ZWTktW?=
 =?utf-8?B?eEU1T3BWRWRXUlFMb0ZOWWZJeDZoTGpNUEVMTDFOYXhEazJ0cjVWYkc2bmVT?=
 =?utf-8?B?bmV4cU9wOHpqQnlrNXJjKzNoTjBpbnY2WHVQYWF6ZjQvMFlLdTY0SEVLTCtC?=
 =?utf-8?B?SXpMeUhzaHNRQk42RXl2YU9iWHVObEFJLzFYQXl0QlM2cUoyam82VWxHc1Fs?=
 =?utf-8?B?eU1uZDl1MmhycTJRYXV1MmpHOWpmK05HUFdINlRlaGhSeFNFWHJMV1ppeStB?=
 =?utf-8?B?TlJ6TkhvZndCcnQrQlI4Unk4anV5WlBUNWRhRXFOOVV1YVg2QUtjTDg1aFlV?=
 =?utf-8?B?c3lycFhLNk9Gd1NMSjBvVFRDYlp4TTh4OW81QnVJNmJHOUo0UXZFYm9PM3pT?=
 =?utf-8?B?bXkvY3FtSDJqdXFyM2NjN3ZydWRtMkZOeFJ2ODg0Wkp1MDRNVnZFakxMNzF2?=
 =?utf-8?B?dzE2eXhUZFMwT3pxRm1MWS9DL3U5L0dUNzQ3U08wSm42RytSM2pvTDRMem9F?=
 =?utf-8?B?RmtBV003YW9kN0hiNmZTd1ZsczlaUEFQNFBNSWJYeW9ITjQvd3R6K2RoN3kv?=
 =?utf-8?B?Q2pnV3RjbzZEdkhwMk82emc5OTBqR3hyQzUxSFl0YTdEQTJqOFY4RVBxTDND?=
 =?utf-8?B?N3ZZSVBvVWJ2YlorWVl3ZFBHcm45UytYZGI4T3QrOTRCQ1Q5N2RFbVRhampa?=
 =?utf-8?Q?YFadMpCceVY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9445
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	709e846f-bcb1-4452-ac63-08dda25eca84
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OURhVjR5SHo5TjFOclJlWkRVUElOL3VZdEJ6c21BS1dkekVyQTkxYkdZSDhx?=
 =?utf-8?B?ZUx4R1ZzNFQrbDBqRVdmejY4VHVXK1RvdmhNSlNGWVh3UkZXa3FydmYvL0My?=
 =?utf-8?B?cXhxWmcwNW11VFhPODBqNjlZV0NDTHJHU205UjMvV3hnR0RjWjFBVSsxQjRW?=
 =?utf-8?B?dGNTbGIxQ2VjZ0NseWZ3VUxvdmFMTDdzbmNVR1RnYUUvbjFtSUFVeDZldFpG?=
 =?utf-8?B?MGErdUJYYWhkdk5FU2xEZEZXNzZmNzVWZGp4bnNzelNhMlRTeXBoQ2xLeVBX?=
 =?utf-8?B?VGR0MENQTWwwdXhyS3cvd1NmZE1xSE12RE5GOHJXa1FMa1VlcCtjbzdxRkRm?=
 =?utf-8?B?bHpQWTh5V0ZtM1pPVHJOblBBaHdub21QR1ViSGJ0emFFN2VEQldEcDk5L3ls?=
 =?utf-8?B?OHQvSDJaL0o2dkN0KytJdElyVUtDMm1XZEZubWNnNWlWSmUyWG9NM29JU21Q?=
 =?utf-8?B?R3J3TU1qNFBSclJZZ05QZHFEeE15WWZlVlNaYjRFdGJEYUJUU1lXL0JCQ3Vw?=
 =?utf-8?B?bkNnQVVxdHgxTjBsdmV6SzczVGNYNC85YnNKSHc0Tk9nUjIvR3BGV3krbUt4?=
 =?utf-8?B?UTNyMlNkUkZUR0xJZ3g1Q3dSTE9DK0R3YmhDSWpFNnhWRnFZOUtlN1gwZmVi?=
 =?utf-8?B?Zi90MFNabjdZSjNTWlhPQnN4N1lCa3kvVEwybmRKMnpMUGcvdXEzL0FrRDFs?=
 =?utf-8?B?YXlKSC94UGVUa2NnMDJUMzdNMHBKeUUxUzRWYVNXUHpMSGx6VHVwM3lWbUNv?=
 =?utf-8?B?Q0NYMzd6UjlNZDYySEtTdVlvR3JLNUh0cFFWTXEzZ05lQnl1YXZTY3J4aWRM?=
 =?utf-8?B?M3haSU1laGQ3dmxmMy8yNmMxbDRuZEN4Skh2dHRaWFFRWkRkY1BHL0xtSFE2?=
 =?utf-8?B?QW5uc0RBTU9KU0ZlN3krTi9DMWJyMG0xU0gyaEVjWlUrRGpqMzViZDcwMnVH?=
 =?utf-8?B?SnpOMEN0ck1wTjRXRVVLMFNVTzltcm1uVktIbVV5WUIwZVYvb1FpRk1Od0dK?=
 =?utf-8?B?YTFtTzJJT0oyYldGS1lMbkx3c25la2MybGJLSkdlamJTdE84elFyeVJ5aEZo?=
 =?utf-8?B?QkhOSTRQYnpBaGNYREdqamhZZVRrV0ttQk5hVTB2ZUlvRTlWY0h1YWNWdi92?=
 =?utf-8?B?ZmV3OGk5Vlo5SDJ1bkNUWi9RcTFFUFZ2emJKNUFCZVJDR1NwM2xlWERQQnA4?=
 =?utf-8?B?Z3QxTHZhNHBwVUVDeHBFcE85cEJWS1RENk1lNTNwdjhuZUZ2OU52NnZKcWlt?=
 =?utf-8?B?cm9iYjE5dVhZbjVWUThKeDB5a0EvQXlRZXNKc2V6dWJtRFZNdzlBSXBncnlE?=
 =?utf-8?B?aDhiZlFzTzdKVWlQZ3h6L1ZHUStwa2xKNWM3L2N2UzVaL1Z3TGhJdndUckdQ?=
 =?utf-8?B?VkVoWWZYbGlZSFV6Q3RCa1kzcHh6d1ZvR0VqTjAwZ2RtZnRWS1Qzd2o1ZU13?=
 =?utf-8?B?NHZkclZyYThDY3Z2bWp6YU9hbERaSVlGYWFoUkVqUGcrZ1BONmYrek40TW5D?=
 =?utf-8?B?WFM2c05VQnh1eXkreWtNaEVtZGRFelZWYWQ3emlpbndaTEc5QjRWZ3N4NCtp?=
 =?utf-8?B?T1ZmSHN3RzlKd1FSOFloL0dteEhrc1pOc1hlYis0cTFsbnpuU21Cb0VKU2Vh?=
 =?utf-8?B?cTM1QzhaMVBhZVBVZ1B5SmRxVWk2TkRKd3Y5VXBsTUVOTmdPUk9UdlZGdmVK?=
 =?utf-8?B?REpUL05NTklta0VUTmdZRVluU1UzalJjT0lmL0JhZkhITjJCeE1rSTdmRDE2?=
 =?utf-8?B?Y2ZxaXQxTmhqU1k4TU9vQm5MY0ZsRTgvZ0FZRVZ6aHNlQVVuT1dxN0svcWNO?=
 =?utf-8?B?ZXAyZjVycnJqQmxlemlzaWtlMjZmMzBDdjhsb2xQRXhCU2VaY2k5MURTbStI?=
 =?utf-8?B?aWNiUmNZTElKakViQXNqZ21vck9BU0t4dkxzc2RmUmRJSnEvR2NUTW5Sd3NN?=
 =?utf-8?B?N0tJL05sU0YvMmgzSTNZeVc5Z1ZETHNxRmNOb210aEFFeE50dXJvaUpFaW4r?=
 =?utf-8?B?TlV3NEJZYXA4aWFaTG56MlpoU0xoNEZGZTlxVlFjWFlTSHRoWnA4dGZtSUti?=
 =?utf-8?Q?DoZT1+?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 05:24:10.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311143f-dd3b-4b44-9939-08dda25edf18
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10555


On 02/06/25 8:33 pm, Zi Yan wrote:
> On 29 May 2025, at 23:44, Dev Jain wrote:
>
>> On 30/05/25 4:17 am, Zi Yan wrote:
>>> On 28 May 2025, at 23:17, Dev Jain wrote:
>>>
>>>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>>>
>>>>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>>>>> Then it may happen that the computed slot already falls beyond the batch,
>>>>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>>>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>>>>> when the entry is a sibling entry.
>>>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>>>> You can compile the tests with “make -C tools/testing/radix-tree”
>>>>> and run “./tools/testing/radix-tree/xarray”.
>>>> Sorry forgot to Cc you.
>>>> I can surely do that later, but does this patch look fine?
>>> I am not sure the exact situation you are describing, so I asked you
>>> to write a test case to demonstrate the issue. :)
>>
>> Suppose we have a shift-6 node having an order-9 entry => 8 - 1 = 7 siblings,
>> so assume the slots are at offset 0 till 7 in this node. If xas->xa_offset is 6,
>> then the code will compute order as 1 + xas->xa_node->shift = 7. So I mean to
>> say that the order computation must start from the beginning of the multi-slot
>> entries, that is, the non-sibling entry.
> Got it. Thanks for the explanation. It will be great to add this explanation
> to the commit log.
>
> I also notice that in the comment of xas_get_order() it says
> “Called after xas_load()” and xas_load() returns NULL or an internal
> entry for a sibling. So caller is responsible to make sure xas is not pointing
> to a sibling entry. It is good to have a check here.
>
> In terms of the patch, we are moving away from BUG()/BUG_ON(), so I wonder
> if there is a less disruptive way of handling this. Something like return
> -EINVAL instead with modified function comments and adding a comment
> at the return -EIVAL saying something like caller needs to pass
> a non-sibling entry.

What's the reason for moving away from BUG_ON()? I would think that it is
better that we don't have any overhead without the relevant debug config.
Also, returning any negative return value seems more disruptive :) we will
have to change all the callers to handle that, and in turn, handle that
for their callers, and so on.

>
> Best Regards,
> Yan, Zi

