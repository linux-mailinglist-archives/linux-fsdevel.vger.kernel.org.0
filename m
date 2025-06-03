Return-Path: <linux-fsdevel+bounces-50450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A30ACC64F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C7A3A2DEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE588146A66;
	Tue,  3 Jun 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eAHsPzbw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903538B;
	Tue,  3 Jun 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953084; cv=fail; b=pFvtXs53CQdPKkcHd643FdvHNvgytU4jKYZKu/x32SLvtPabTCTMVuo9ZXwnLsbCUomFM64IcNUKdbiQFCe2Gh/xwL9VaEAcIuSt3NJ1YIX5CQTeeBO17DALgvCfbEu+ERuU2GkIZ938Vt3US7o2nNP3x/FL11eP78x+KqXN8uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953084; c=relaxed/simple;
	bh=QryNpCHcEVK5Pikrg+DjeQ1HlLMSpmf7Goql6QNSN/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKRpnwl6INWseUT1ylShwycl2OL84iqeRm1y1cPgzokG5X+0Dli/eyyaru1BUHr5rZNO8uk0GDPEIhhJsXeQLi0exHwt02YFG/BRjRyGqTbRwYiwHOz0Cf3WIL6P34BrR45UjGkPj5gHzO8H/HETF5GMMuNM3fpOvYF+tWffX5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eAHsPzbw; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0y+Wqv6ACvTBi84KYjFzDMgcl4ICV0Uj0ArZhXNM17OXfFD64azibjons+7DOv3wD4ncIjdsUuHQjULgCLfgLR484/w5PKFC7hWq2gVpM/y6UodkBEDxsKTr2U6WnZ5a5U2fU8vu/EK24OHB9McZkoTV9Gbz7nL1CGwEPwS3aoB8uFTu97sEurGF4LtcUyNR0DamLnQH/tinK6dRqIDDL/x6Ms2nLulHM2qbQDqkxm3M9/+lSxeqU8JFKz1MygR55p53uFxGzDkxVDGIb8mKluGMWgdN/xeqTgE/VEO2lfJnDN6RDbHgsQm3blA0dYXarZ1GiZC9PArbd/DG2XikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QryNpCHcEVK5Pikrg+DjeQ1HlLMSpmf7Goql6QNSN/U=;
 b=HZUKREbwTQoXIMjQFV+MmTpdHyrBmXYIwTG9CMIQaoTq7bmKeH20rg6T67mBj08PexjpqLRhgAAzIraDWsM2Q9iLIuEKsBcrwqUc3OXOceXy4weyhIu+KraUkgP7V16acZtiDTkr8Qg95QXtuZSEdtq2XJxh/xCXaFGO6yP+7zIvyWE9bjhaPPpsuB7p648OmDKbgp9Nf9KcCFX0QVwL2O63f5WId4AL72rtUCZZkZ1Ge+oUnUr1q6WYiY8ajP0LdpE9Qtzi6ShFPqWwZyH/iZfcooo8zK4w6wrhcsu5Y/n3EzL3sSvB7ip+PwsHq+eshUgqOzsn+wj5ZjiZen7TGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QryNpCHcEVK5Pikrg+DjeQ1HlLMSpmf7Goql6QNSN/U=;
 b=eAHsPzbwdri/HTG8klnW8gNomSy8sBu0ZDmT8oZmecoU0u8IMq4Ra4Y29TKHIRnaAY0lRoAGm+5/1znLk7yqjXfVJQiJeqZdC95u2ICdPyOGrPaaBxpYchPvOSUjBqLWCfYoxsjW1abn9rJj8uzyfyXHzoWpXyGARXxS8ogvoktHzQO8phGtIWpx8t0uozWeb+m0bcer8H2+JL0ZNjka8yMi67iA9y99Us8NPVkl7YHDYjJoJuT5vaNX8o8HpKf6rmIq27BJlRY8+ao55s6mWWq/OMPrYQJV3m81dhgZJPWQUpjQDtw2/QqEvECoylQWldD0CvcnUY0XiS8Pk4NGmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 12:17:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 12:17:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Tue, 03 Jun 2025 08:17:57 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <D5EDD20A-03A2-4CEA-884F-D1E48875222B@nvidia.com>
In-Reply-To: <053ae9ec-1113-4ed8-9625-adf382070bc5@redhat.com>
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
 <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
 <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
 <a3311974-30ae-42b6-9f26-45e769a67522@arm.com>
 <053ae9ec-1113-4ed8-9625-adf382070bc5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0042.prod.exchangelabs.com
 (2603:10b6:208:25::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 272ef8b4-f74c-430f-fcac-08dda298ae21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGdJZkYxdmd1REVTdHdBOWNYdmlkVGpHNm5NWlRiWmlvV0swMXdPQWhwTE1T?=
 =?utf-8?B?UmhqbytzbktkWHgrcm85MytRQXBJemZrMnEyc2R0NGVINzhHcUFYMkNKTlFi?=
 =?utf-8?B?UnAxa3NjRno4OS9NVGF1cWV6eW5xWXlONVJZUU1jbmNBa0FpTU9JMlp5RHdw?=
 =?utf-8?B?V0svelhSL2tqc3J4eFNKYXlSN3ozaVpvWGtWeW94ZldsVUNoZmdpS3VTZldP?=
 =?utf-8?B?M1ZRZXl2ZFFTOWlZc250R1N4Q1VlTUpmZmw0S2cyWjNncVVhaCtPZXJuZkZ5?=
 =?utf-8?B?OW1lYjAwMXVCNWp3eGRRdnFpZTQ5KzhkSm5OaURtR0hBempUNnJOV0pQWmR2?=
 =?utf-8?B?cTRjVHJqYWJLYklia1ZHS3dMbWlBSHlUdDQ0bElhdFJYNFZkTkNnTFJKdWtx?=
 =?utf-8?B?a0dMME9vZElGTWV2ZEZ6aCsvenVDQkNha25GR2JNSlV4Njd1TFpnMWExWVpK?=
 =?utf-8?B?dzZXZE5wbHFFbWR4TU5MZ0hTZHlwaVVkdllIR2MwNVlwMWlwN3hWdFFOR3Jk?=
 =?utf-8?B?eWNBTlgybmFGWjRLdmg0TWpYenJ4eDBPT1FDTUlBZmFXV01uRGw0dnE0ZG9C?=
 =?utf-8?B?YXl3MVZnWlMzL0RVSXkweXVKNnBjU1FHaDlxL0l0S0lWQTlNRG5CUjE4NXZB?=
 =?utf-8?B?ZmVtQlZyQTFrbXdyKzVzdVIzYnpkNzVNQ3FKWWZmb0NwWG5MaWN6RDNEemNS?=
 =?utf-8?B?ZGU0Y3FCbTJhOGtMUkU5QXl2V2xGb2ZJYlB1YmppVHdQemRiNGFBWVI2V0Nn?=
 =?utf-8?B?U3R3ZjZuSkQ1V3RCQndrWjA2NEg4TWo2bW9ZS3RlZXpyOHZKbThuNGEwdWpP?=
 =?utf-8?B?VUpwd0ZmMEVhZERwd0V4cWVzYzdDTUVaSDJLNDVMQ3VsVXgrd1E3RnFiUGFx?=
 =?utf-8?B?cEMxVGlHUkxpcVVpMThVVU1jcEtpSFNhNmNoUjMwZ2VpK2RoeXc3ZFBrRnJs?=
 =?utf-8?B?N21KekZlcllUbENXRndjTklsZHRzWEtrNXRWWkg0NFBKMmg4cmNLcnVvUDkx?=
 =?utf-8?B?ejVTRE1XRHhjME5JbWF5NE9jeEdiQXFuV0l0emRIUExmeW1hU0RlbytUTGJS?=
 =?utf-8?B?blVaTFBOeGxHL0RoL0lnZWxEUjVSQ014MjFUaEtBTlRJL2ZGUndSSnI5U2I0?=
 =?utf-8?B?VjdwbDQ1cG94Ykl5elhaMDJQWms0R1FjclFFNm1TbmRpelp6OFNjQlZwR2I2?=
 =?utf-8?B?NEwxQUtOcXFZRzRjRUFiUEU4OFREWEI2RVIzV1JodTBtM3VFRHBlbXZMK3Y1?=
 =?utf-8?B?a0NpRm5tajUvMkh2SjNQUE5tcDNNc0tCNm9vMEt3QnZCWmF2Wk1TN0RGUExY?=
 =?utf-8?B?QWZzZk5PSGxDVnhHcnUxNlg4ZHBsWnJwSi8wVTlBZG5tOUYyd0RIWllLN1Bw?=
 =?utf-8?B?TEtHVHd6Q3g1S0pQMVRKZkFLdVVwZ2x0YXNjSFUxM2FVMU0xRGpnT3FXc2NO?=
 =?utf-8?B?cnNwcDI0QnI0VVlFZ05XdHI5Yk5ydU0wb2g0clhCcHZldDNqVjlCK1dmdFR0?=
 =?utf-8?B?c2tleDgwNEswdXFHd1NrNTQ1UWRTNUlxNXFnanQ0RTlOaHAxQjJrSmYwTzF3?=
 =?utf-8?B?TUZNRUpzQTVSK0JrUEVVY092dVdWRHA2bFRVajJsWXJ0ZFZiYXlsUlBRYWZ1?=
 =?utf-8?B?eTFuNVBBWTRqa1NQci9HVHlSRmVhd3lIbnZGZzZkL2lPanA4UXArUFZTUFpj?=
 =?utf-8?B?NDRHdlRWZjhrekZkN0tMM25LcmJzZTBFanRCTFMyNCtJUEI0bGF1Z1VvZkNr?=
 =?utf-8?B?YjhXbWoxbjE3Ti9ldEV2SmNnOTF0OWhVSWF3byttQkhVK3ZET05SSkdWd1pP?=
 =?utf-8?B?d2s2M29ZWVRIV0R0QldxVWJJdVcyeFdkYmN1aEdrVUZZWGlQOFJTOHpaQk8w?=
 =?utf-8?B?VlVFYWRxNFM4RTNLSlIxVzNyU0t2VDI2KzFSSkE1Q0h1S21OYUlWUFBueWhD?=
 =?utf-8?Q?3SkfMG9kwoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU43Vks4ODhQMHpVaVNpQWIwWnAyNVl6UFd3WEZnS3JsN2NaaHJUMWxEWlNx?=
 =?utf-8?B?cE1relhDc3AxYWhpWlZkMEJDQVFlNXBIQlVMbVhmUHpVNHp6WGJ5bEtaWW1X?=
 =?utf-8?B?OEZLMUNxVWNjUHB1NEc1NjJzQ2JURmZaTklvekVJVGZTdklaWkk4Vk1kRlBN?=
 =?utf-8?B?dk1BNjUrcHBXZ0VZaTRXVjcra291Wld6Y1phVmlmR3c1TndKRUZyc0FGcFFl?=
 =?utf-8?B?NmZJVUhrTjd4bDVVV1lISmVTbms4Wi9ENitWbE85bHRCNHNxK2UxSGlOTGpj?=
 =?utf-8?B?Tmg3U2hMenh4KzNTQ0hOY2dIOE9BTndTT3BrblFNODQ2SUp5N3VzNnBSdVc1?=
 =?utf-8?B?UHFnZ1N1b080L0lMMnRIR3Jib3F2Wkd2NU5mYlZJbTYzQzY2aG1uTTFlYndQ?=
 =?utf-8?B?YmcxY2I4L0NiUVBqcGpEcThRMEZZWFNEYmMzTjl0STFxYnkrT0NqbVZQaC9n?=
 =?utf-8?B?bFJFNUlaeXorL3hCWU8wS1Y3cGp3UzJTb2htMm9DTFpySkF1VUtIMlp1ZlFk?=
 =?utf-8?B?WlBmTGQ1UW5oZzFSYUlGWUczSGw4aU41cVRhVE1kSUZ5cERab2hyZ3ljKzE4?=
 =?utf-8?B?THd1US90RHMwVnp4blU0V0Y0YWhJYXBOSm9INko0dGZmRlgwVVpQZzZMMlhS?=
 =?utf-8?B?dU9FZ0JXV1dQYTlmeTAzK0twSElMNWxPM0hDeFB6Mys3MW00UFh6MG5EV1J3?=
 =?utf-8?B?YkNsZ2hxVnRWcWpXSkZzY1JQbDVEejFrRjBycnhqdkZOTHFBeFBsSlVxemJC?=
 =?utf-8?B?OUNFR01sc2JBR1ZDZ3prQ1ZHc1EyV0lTMWNIRDFNbmFxZ3lvd0NZZEhkMEgr?=
 =?utf-8?B?cHVlcERnS3gyTDVnYTQxWEVPVngzM3JuMnM3aGlVQVlEcWRlQWxPM0FNM1p2?=
 =?utf-8?B?MllpZk42bENDaDFFejNacnc4a2svTllDTlRzRVhjcjQ2QzRrYTU3RVBqa0t4?=
 =?utf-8?B?eUFjak9yK1ZhUTdnL2RwQ21jNC9nZVZkUGsyVlo5eGY5dHQ4RndWUVFYR2xW?=
 =?utf-8?B?eE5zOVVwd2lFMVdVV3NHQnZzUHpiTlZFOU9PdHJpTVZlaWFydGl6NmZ0WHJ1?=
 =?utf-8?B?UTNBc291Wms5NjFiRjBmUnBMSHNGL0dSZ1FYYjljaExJZ3ZlK3IwOC9TS056?=
 =?utf-8?B?dUFCeHowZXdrMTVKZmk2MWdHdVdMOWE4ZU9sM1hEWHU2alBtK3dWSlFJNWFF?=
 =?utf-8?B?YTJ1bVNEUWc2N0p2aWFOTTcxUFhES0NScmN1NFJtZHZpK2Q4bHJHZVJ4OTZL?=
 =?utf-8?B?Q1BSL1BSM2Y1Rjh2Qit4cjZ0bFBWenFONGJlMjVERnVSOTVvU1BQNGQrQ2hu?=
 =?utf-8?B?VGdXYmJyZWE0bmdXOVBtbGd4VmN4UWxmQmNqYVltdGlBNTI3L08rQzdsNEFZ?=
 =?utf-8?B?andEdE5YMitvYTdFOW9uTi9MUzYzdzYvTlppTFVKcDFGanl1TjVrcFlwQUVL?=
 =?utf-8?B?eXZrL1hjMmYzM01zeUFUanYrTXEwODJwQ0Z6c1ZXZ2EyMklCcHZrSDBXOGxx?=
 =?utf-8?B?NUQ2ckZMTEtvc1M2QXBMWFdpdkp2WkRqTnRmTzg0akoyQkhGWFV2YVhZbVlj?=
 =?utf-8?B?TUlVaFhBSFdqbW9OTmZZdW9vT1QvbEhmTmt4RTJWaWZYKzNmTjZtVUE0bnU4?=
 =?utf-8?B?YXY5RlV2WkMxSG84SjZqWTNhZ0QwUWNuM2tCbEJXbHB5MDBVQkJTcDk4MHQ4?=
 =?utf-8?B?RVMrQWZLbVlmRkEyOU02cXlmc3FobXZlLzdnYWNqa2U3U1dQT0dRMVZXMGtq?=
 =?utf-8?B?QkFhd1RUc2dwQjlQRSttMWNnRjViZnhDcW5xT2dRZWNmTmN3cFZKWllHenhR?=
 =?utf-8?B?Wjk0RHRSSEY4Y2trTDFnQnl2MGpTZ202a05mVEY0bEx4cVhFZWdWa09uSWRt?=
 =?utf-8?B?Nks1TFJETTFyTzN2cjJTMTdDdktCd3RIMUljTTZ2enhDeGlqZVNQTEZISStl?=
 =?utf-8?B?aCt2YjN6ZENVL2dvOGpnN0tjbVBaTUU1cjRVSXRDeVRNVU9aWWlrSnYzQ0dq?=
 =?utf-8?B?b1pjdFFNQ0tlaS9VVmFoMEs5dEpyeWpEaDRrMCs0U3ZhVkVNeEZyTnk3Y0N4?=
 =?utf-8?B?U25ZUk9aK2IyZG81QkNvdjFRSXFXSU9pWU16ZkVvRzdaYjI3QkpQWVlsQ1lv?=
 =?utf-8?Q?GcVbV8paKDWpZ6S2nOG4RcSZs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272ef8b4-f74c-430f-fcac-08dda298ae21
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:17:59.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nT/J4AIGHNXLlVcZwzcwVbbXWKPL91rqHdbcIfKndgtwhyWQaw51uoH0tHwSFkv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027

On 3 Jun 2025, at 3:58, David Hildenbrand wrote:

> On 03.06.25 07:23, Dev Jain wrote:
>>
>> On 02/06/25 8:33 pm, Zi Yan wrote:
>>> On 29 May 2025, at 23:44, Dev Jain wrote:
>>>
>>>> On 30/05/25 4:17 am, Zi Yan wrote:
>>>>> On 28 May 2025, at 23:17, Dev Jain wrote:
>>>>>
>>>>>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>>>>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>>>>>
>>>>>>>> Suppose xas is pointing somewhere near the end of the multi-entry =
batch.
>>>>>>>> Then it may happen that the computed slot already falls beyond the=
 batch,
>>>>>>>> thus breaking the loop due to !xa_is_sibling(), and computing the =
wrong
>>>>>>>> order. Thus ensure that the caller is aware of this by triggering =
a BUG
>>>>>>>> when the entry is a sibling entry.
>>>>>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>>>>>> You can compile the tests with =E2=80=9Cmake -C tools/testing/radix=
-tree=E2=80=9D
>>>>>>> and run =E2=80=9C./tools/testing/radix-tree/xarray=E2=80=9D.
>>>>>> Sorry forgot to Cc you.
>>>>>> I can surely do that later, but does this patch look fine?
>>>>> I am not sure the exact situation you are describing, so I asked you
>>>>> to write a test case to demonstrate the issue. :)
>>>>
>>>> Suppose we have a shift-6 node having an order-9 entry =3D> 8 - 1 =3D =
7 siblings,
>>>> so assume the slots are at offset 0 till 7 in this node. If xas->xa_of=
fset is 6,
>>>> then the code will compute order as 1 + xas->xa_node->shift =3D 7. So =
I mean to
>>>> say that the order computation must start from the beginning of the mu=
lti-slot
>>>> entries, that is, the non-sibling entry.
>>> Got it. Thanks for the explanation. It will be great to add this explan=
ation
>>> to the commit log.
>>>
>>> I also notice that in the comment of xas_get_order() it says
>>> =E2=80=9CCalled after xas_load()=E2=80=9D and xas_load() returns NULL o=
r an internal
>>> entry for a sibling. So caller is responsible to make sure xas is not p=
ointing
>>> to a sibling entry. It is good to have a check here.
>>>
>>> In terms of the patch, we are moving away from BUG()/BUG_ON(), so I won=
der
>>> if there is a less disruptive way of handling this. Something like retu=
rn
>>> -EINVAL instead with modified function comments and adding a comment
>>> at the return -EIVAL saying something like caller needs to pass
>>> a non-sibling entry.
>>
>> What's the reason for moving away from BUG_ON()?
>
> BUG_ON is in general a bad thing. See Documentation/process/coding-style.=
rst and the history on the related changes for details.
>
> Here, it is less critical than it looks.
>
> XA_NODE_BUG_ON is only active with XA_DEBUG.
>
> And XA_DEBUG is only defined in
>
> tools/testing/shared/xarray-shared.h:#define XA_DEBUG
>
> So IIUC, it's only active in selftests, and completely inactive in any ke=
rnel builds.

Oh, I missed that. But that also means this patch becomes a nop in kernel
builds.

Best Regards,
Yan, Zi

