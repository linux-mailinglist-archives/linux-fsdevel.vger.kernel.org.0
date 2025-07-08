Return-Path: <linux-fsdevel+bounces-54231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA584AFC4C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEF177690
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343229AB11;
	Tue,  8 Jul 2025 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fy1ezfnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE838385;
	Tue,  8 Jul 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961361; cv=fail; b=IVuVfHx8XnDKyLMLkGirAt6NX43xbX61VNWAPkEMqoZMZ/DXRyJIl1tFikLT5pxjGCUdbnBR3+4FEsOBh6aVi3kyaw5lz+zdh7uIRCNc2p0EBUKxvj/g1UV9Cst7eMrc2mvB9qqvl6U2WofvYnmh2FeUZcE7NnIYyD97qrZgbh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961361; c=relaxed/simple;
	bh=Zu0x4XMFJrCOIBGR9v6FmQyFkshPx8E+jmhazg0C1Gs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TJUN4wpuNrH9G05oaVzntXGNcD3MzQ0orwkD4Y3FHq6dwTqoSYPgAlK6KRfX+YLcCeG9vDKf/NIlQEDe/7b8WLLfadBOPOw84H6ubuZuqrs+FLrsDaVzSJNOrJFyYhNmUrfEN1GrmtGnv96GHJ90rRje6+gLA7V54n41RlIruGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fy1ezfnY; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JggFBgDb8Q38/qUDzt7CYGW2MfnmvIgqohdZqKATtEfWpgN0I4B9qUfXB9ZLH4Gmcj+lCILRpG/WupvPXEunhyyBcH1IzJ4c3SunLyenT4MwreAy+RniNaVXd+Zs93icdDvi7u1zHMLEtgS+xIlbe5Z9oR7SwwJlnJxqthbsEU3EB5Du1p3gqsxUu3EYRQZ+69krdwjjQx2G28KppeJXHg2q9f2rmmfgzllH0q5G4sW4Nvh3kCrVtlai0+Hf5KZbWM21iHnHy1IhHQy9UacfDlUCC7I9+6z5sHnPLsccvgzEfPM/JG28R21hThwEF9U1UXR6sORMW39cfl5A8jl1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St7Jrf2bI6I1B+jLP26dsT8M20yF6Fcn8ZegrVetC8s=;
 b=FPUh5zGefZWyZ7LFbjt35wUb0TFOE9JdzY8nZX209gZfM8CIe//YFDqa/rrX7o3YIw/AtRcTjjWU2GsiBKMJjU1HgdCyuDjfyqYS9kX7B6821rTgoWwAKgKM6hsQnl7STVpiyt3oKLiHdD717oe5xOCgNUxX7SWnwfk4oFysHYO5BEu7hGffIg7H9CyxsY51aufDsmEGYFXAMate4T9qgWKnkprRg/R+0r7ahmkcBvHR1hgbrmPx6VEPGMjaDkmxjldIFwvu8bhrGXaXJPCJnQM6cLnDZDI/l7neFiBa+f2KBPXHF7mipoRUFqKhPcBpTRJfr0oVs0A3IEnbHLQG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St7Jrf2bI6I1B+jLP26dsT8M20yF6Fcn8ZegrVetC8s=;
 b=fy1ezfnYz6pHP6tGI8E5aCZPsWoQbSjHqUsnglojpdRYLLGImH6aOC7bGl57fY8hfkERmB65fYAjCxj/9BuE3f5udNL1ku9+Q6J4WF4xEfe6Zd3wbDtRf9cTNPodd840fKWgDtyo9Oblookc2cE794CKjCfZTAGjZuaZXjdffEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by CYXPR12MB9279.namprd12.prod.outlook.com
 (2603:10b6:930:d5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 07:55:57 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Tue, 8 Jul 2025
 07:55:57 +0000
Message-ID: <7e59a27d-8393-48b4-9c44-800499498afb@amd.com>
Date: Tue, 8 Jul 2025 13:25:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
To: Vlastimil Babka <vbabka@suse.cz>, Matthias Maennich
 <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
 <20250708-export_modules-v1-2-fbf7a282d23f@suse.cz>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250708-export_modules-v1-2-fbf7a282d23f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::33) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ef2444-480f-40d5-6376-08ddbdf4df1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejJXUmg3QjVCeFZwc3MrdmhUL1JRNzB2VW1pUFg2anpvRnliQ3NIR1dkdWhu?=
 =?utf-8?B?WFloSlBVZjBIOVZlelB4SC9JY2tXMGk1cXQwbnRpOU05N0hRNHZydkdueksw?=
 =?utf-8?B?NGwvUnNsQldZQ2NPTnpsZWlVZ2gvS1liMVRoSnBhSDJLR2NLR01WbE5rQzJY?=
 =?utf-8?B?VlVaSEREVlIrbjRGWHZVTFVpMzdwWXdpaXJodkxVVXVyaHptcFc4OFJ4K1pI?=
 =?utf-8?B?aEFMUDRGaitnTlRYVkV6bFVwdmU4QlRRb1l0ajhtUlc4elVQU3cvU0xtUkgx?=
 =?utf-8?B?WStrQTNNMVZXUnlQeXIyWlM0eVdtWnFjTFpFbmN4Vk9MNnprUlUyRVZNOVFR?=
 =?utf-8?B?cFprL0FGV2FNTnorc0dJVGZiMnZaTDFjRm80L1lTdEpqL0hNRWZ2cnE4UEhp?=
 =?utf-8?B?bWE3S1BXUlNUbXpKOGVOUzRUdE1YaTljNk90aVhLd2d2SUo1SnRiOXIxM2NB?=
 =?utf-8?B?V3U5TVQ0ZnV0TnJDSjA1TklEcDFtVmQ4NFEyODRlaXRHVmdQQTkrclloWjM4?=
 =?utf-8?B?THZ1d2UzdWhKS1hkZGJjdXdaOU1rUzRMLzdJT2NUZDlQeGx5enRPQzY1dnlx?=
 =?utf-8?B?VndHVU54Z3B3YUI3TStibTdkZzZiTXVpRjFiQTFzUGR5QU1CbU0wY0RQTXd2?=
 =?utf-8?B?dkRxa3cwT2hxOWZ6MjVkTm8zZ2o3Y05hT05vall5TGRMd1h6SS9zTWRPL0g1?=
 =?utf-8?B?VDQrOGx5ZUFrR1ZYRUZSMHo2Yml0RlRYMnZScHVkT2krMkVDTkFzUkY3Z0RV?=
 =?utf-8?B?cVdpYll1V01kc2ZHWE9wUExKdUoybXAwZDZBVjZVT3NsRTlFNFJ0b3BXL09m?=
 =?utf-8?B?SFByTFhROW5CZlRweVUzMS9TOGJBOHlhRVhOTFBqeTZxSjM4TXZQWTMzUy96?=
 =?utf-8?B?QUw3UXFpYXNFYkk1Vk9qSmZSNmJmaEx5b1Y5MnJjYUJyVjRTZTA0bjdBUW9z?=
 =?utf-8?B?a2VyLzhIc3lVK0dPK3hiUVFsalFZa3ZxSC9ZcmUyMzhsbW4rSVV6VTgrMG80?=
 =?utf-8?B?enBHZFA4QWpIUUxXWG5ZcGxpdWpCSWRudGJveFZ1cnlWOHFFSEhzNEtGeVU5?=
 =?utf-8?B?OGkxL213UkRLVndkZS92Wk44cnpiWEo2YUJzZWlCMWlSR082a2Z4Nkd0MWFj?=
 =?utf-8?B?MFZUY0Z5anRSVGVSVFZ1cEFJK2p2Y2VhTlJtUS9GNFRQZGV4OXpvTThBNzFN?=
 =?utf-8?B?MzYwNlpweWtsekpBeGhNRFQwK2hudVZ5b29CZi9aN1dPbDB6UWU1czdtWm5t?=
 =?utf-8?B?ZzlLT0UwSmExandZOFNPQk52MlBFb25qY2hVMTJ5VjFMNGY1NkJOK05OQVJx?=
 =?utf-8?B?WjMwZ1pQUjFuMjc3cHY3MmE5YVFaU09RZS9NVUNFdkN6OFpVNXNTcHFBK1FT?=
 =?utf-8?B?M3pndndwbUk2K3V1NFZkdTBRb1VYTE84cEppZTcrbFVNMXFDSHZGQ1N2ZExD?=
 =?utf-8?B?bTVhalFTY283emZmSXY2N3M1eVduZmplaXpIS1Q1ZHNzR0haT2pHRGhMM2xl?=
 =?utf-8?B?UHgvWE1PYzBEZ09kSG5BUjFpU3RCUitFMVE5U2FieXQ4SVA4WlUxS0xmUWNj?=
 =?utf-8?B?YVlYenNJVUVucXMxZ1c1RzNFK01iWXE1Ym9QSFZUMGxwNWJqZzE3MjNVR1lp?=
 =?utf-8?B?cmtiZ3JPWHZwRDN2T3Bxc0YwS0ZEMklUYUJOYWRUMUlDc3RLekR5TVB4OFE3?=
 =?utf-8?B?MU5tZW5TSU1YYWRPT04wcGhOcStSdkFldll1NUlydkNiZXJWWG82MVJuWnVS?=
 =?utf-8?B?aWRJeEhodTFsb3JweEkyeWVlN1lsemwxcEJxQVNPWm5BSytoYXRUclQweGor?=
 =?utf-8?B?WTZvMDZpZ1NONkhSV0ViMjMzcXd3eERDRTZkMEgxRmlETFR4Y1NDVmdSaW55?=
 =?utf-8?B?TVBpNFlBYnhJU0RhK1JTVC9yWDlGWFpxVmEyVXdBTmpKY0Z3dmhBU0FOK1BX?=
 =?utf-8?B?ZERJSWZtNkRUajVvRDkyQ3pGQXVLSThnTWJtdTBaR2xtazEyVGJTZFBGRVNI?=
 =?utf-8?B?bUJtdGtkR2F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHVTUU5haDg5K01pQ1RuWTlNMytpalVqY3ZHNmdpZit0MXZUVTJHSXBMcVFV?=
 =?utf-8?B?cm53S3VtK3ozZzYyTmE2TUVxWExLeWF5WkpLM2FpTkhOVDVTVkVFNFNYakZE?=
 =?utf-8?B?Q3A3TXlTVUdGaDhZc0U1MzErUXlkbXI0OFpReHV4Ykx2WUJDUHFkWTBhNkZB?=
 =?utf-8?B?S0w1NUl4WWFIdGR5RkFGQitLcEp3Mm8wMSs1MTVxNldpYjFyRk56SXJaVjNG?=
 =?utf-8?B?eVVnajZLMXg2SG9vYmhmUUJSblRHTHBaR2ROS21IL0RnL3QzQWxFY1dvR3Jm?=
 =?utf-8?B?R1gvUHQ4OUdGTFpCRGsyWDlWdzhHdUJoUFViU1RVTUxROHMzQzkvNDgza3FI?=
 =?utf-8?B?dWdnZkd4dHhOdHlSQVd5TUVzNlltZWNWdG9HZmpBUUpmMHQvaU0rNEVPYWNC?=
 =?utf-8?B?T2R4Y0NHWUpKQ1hKUWRBRno2NEgwckhadkhja1ozNkx1OFRhaGtha1N6bnVn?=
 =?utf-8?B?dk1XbWhZQUpuYTZEUXNVRVA1eE9sWEJndEFZd0g4SlNQYm9WMUVJMjJITlJS?=
 =?utf-8?B?c3cvdEdlTzFYQlRmMnpLS09uNk5mbXoxeEhXOGhOMXFsY0M3Y0ZYNGpDWUQ5?=
 =?utf-8?B?WTdYQzBlNFYwMVBYMEE3MmU4bzVYNTRNOWxDWmlHbUpOcTBDRGRlSjd6QXlN?=
 =?utf-8?B?MlQ1SXovOExBTmpUbUFyblZtZm5qTW5Mb3R3Q3hKSzFVSWp4RDlIeUhwVDNO?=
 =?utf-8?B?YnE0TWp4QU45bUdsYTEyWlNYNzk1TlMvRjZJTHAwb3lGaWY4d3o0WWpCWGRS?=
 =?utf-8?B?Q2lPQk41V2FDZVV2YTBmUkVlYUoycFdVVE8wOTNIMnhwNEhxNmRJVGc5MzZn?=
 =?utf-8?B?d21VUGlVbGdTQTNBUW43QUhWZWZNeTVSRGRtRUhqOWRiUXkvdmVYNjRudWJY?=
 =?utf-8?B?OEdtRjE3SGROUFhaejQ1aWt4ZUJyZTM2cnVLQlM3VEEvRDdQR0tFeXZFc0Fq?=
 =?utf-8?B?T0wxMEtuQkVrMWd1S3NLai9VSkdBS2lOckh0aVRVVVc5OUN5ZjkvMjFua3dT?=
 =?utf-8?B?NEtSREZ2cnB1ZkJ5elo5UnRjeGdKSUZRUlpCUUtQdDUxVFRJaFB1ekVmQkxo?=
 =?utf-8?B?SkVNUFBjaTF0N0RCak1KRTQxSjFvNDVOalRNenpsZ0JlVTlaellCYm9yMld2?=
 =?utf-8?B?RXozSVprZGZTVHp3OFJkWG1qZXZTV3hwS2xxQVpRYklKTi9adU9RY1VnekpV?=
 =?utf-8?B?Z290dDZUQi9jQ0VtRmozYVh6dzl1OEdYelE3WVBuMEhmam9Ha0pPYjZjbmhx?=
 =?utf-8?B?c0N1R3Y5cEtSLzY4Qkp1WVhiclA1NHIycDhNbXNHUGJGc2V6OThUbFZOMm1R?=
 =?utf-8?B?eDJIZ0lhY0p4VmEzcm9YSjNQYUJCVnk3azE4aCtkVjh3NHUwWXhieEdabEY0?=
 =?utf-8?B?bHk1SXBJOW5BazBhSGVJSEhBVjgvQWVyZ3VtcDV6WUZyOEhDMzZiMUdDSlJI?=
 =?utf-8?B?SndiZXl6TW5pTzRyN3RsT2wrMVRQdTBVeWxDQVlvYjk2dW85UDZTUXYzUGh6?=
 =?utf-8?B?bmt1RnpqSFF1NW04MWJnV1RwYlI3RCt6SDFIREFTSVkxWVZndFE3VzBIRFBo?=
 =?utf-8?B?M3l3R2FnUzhMVkNOVUZWM3djQmNFVXVPd1h6V0d6Y1RJU1BRUFJjZDFJQUZw?=
 =?utf-8?B?WG5WSU1PYytja3ByanZXK3ZrcE14NXFuZ0RRNVp3eDZadUcxMWlHZUJtWllJ?=
 =?utf-8?B?ZE5lV2pjT2Y5UmR6YzVYMVZvYUt4MnVHN0o5ajN1cS8rRlY1M1hWNWJNYVpt?=
 =?utf-8?B?YUd6ZE1kaVhEUnQvVkI0c0RQYVQrTWd2VFFQYWdVNHZqdnB1Ujc0c0VkQUUw?=
 =?utf-8?B?WEJibUUzNy9CRmZRTTJjWjFYbXFBSUNjSnFoS2NxUCtoQkF5VUlORFlCL045?=
 =?utf-8?B?T3BqQlhVZmVNa1JMVmljb2NFL3dZcUZiUUk1bk5jQmkrdDZTQzZ2RmJtN2t3?=
 =?utf-8?B?eW9kTVBnNUhpOXcyc2hCNDdUS0hjeFlUaURNS0dFZnV3Ti8xdnlJcWVJTTR3?=
 =?utf-8?B?ZTVJOXpnZTJ5WllNcDNVQi9td2VvZlgwUEdFYzZ5VzJzQ1hRMXpMUjA1WE1Z?=
 =?utf-8?B?SFJFTWkvUk45c3RzUFpjcE53dzY3K2t4RDlyNzBNMkUyNTlpamNPN2NGM3N3?=
 =?utf-8?Q?8jRM8QoylVEWderfVHpLVaaOx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ef2444-480f-40d5-6376-08ddbdf4df1f
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:55:57.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LD/GN60/CB0kDWSMvOKqy1Q8qkK01Cuutrz7X0Y92ZTl5UeNKoSIWpEwRZiwaAU9e/DMQRrUkEPxr+nAlciNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279



On 7/8/2025 12:58 PM, Vlastimil Babka wrote:
> With module namespace access restricted to in-tree modules, the GPL
> requirement becomes implied. Drop it from the name of the export helper.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  Documentation/core-api/symbol-namespaces.rst | 6 +++---
>  fs/anon_inodes.c                             | 2 +-
>  include/linux/export.h                       | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
> index dc228ac738a5cdc49cc736c29170ca96df6a28dc..aafbc0469cd6a4b76225e0e96a86025de512008e 100644
> --- a/Documentation/core-api/symbol-namespaces.rst
> +++ b/Documentation/core-api/symbol-namespaces.rst
> @@ -76,8 +76,8 @@ A second option to define the default namespace is directly in the compilation
>  within the corresponding compilation unit before the #include for
>  <linux/export.h>. Typically it's placed before the first #include statement.
>  
> -Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
> ------------------------------------------------
> +Using the EXPORT_SYMBOL_FOR_MODULES() macro
> +-------------------------------------------
>  
>  Symbols exported using this macro are put into a module namespace. This
>  namespace cannot be imported.
> @@ -88,7 +88,7 @@ Simple tail-globs are supported.
>  
>  For example::
>  
> -  EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
> +  EXPORT_SYMBOL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
>  
>  will limit usage of this symbol to in-tree modules whoes name matches the given
>  patterns.
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 1d847a939f29a41356af3f12e5f61372ec2fb550..180a458fc4f74249d674ec3c6e01277df1d9e743 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -129,7 +129,7 @@ struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *n
>  	}
>  	return inode;
>  }
> -EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
> +EXPORT_SYMBOL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
>  
>  static struct file *__anon_inode_getfile(const char *name,
>  					 const struct file_operations *fops,
> diff --git a/include/linux/export.h b/include/linux/export.h
> index f35d03b4113b19798036d2993d67eb932ad8ce6f..a686fd0ba406509da5f397e3a415d05c5a051c0d 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -91,6 +91,6 @@
>  #define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", ns)
>  #define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "GPL", ns)
>  
> -#define EXPORT_SYMBOL_GPL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
> +#define EXPORT_SYMBOL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
>  
>  #endif /* _LINUX_EXPORT_H */
> 

LGTM!

Reviewed-by: Shivank Garg <shivankg@amd.com>

Thanks,
Shivank

