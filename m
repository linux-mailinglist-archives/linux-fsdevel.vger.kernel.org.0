Return-Path: <linux-fsdevel+bounces-57027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA577B1E07C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 04:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E8D720865
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918416F288;
	Fri,  8 Aug 2025 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PV1lIamc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013001.outbound.protection.outlook.com [52.101.127.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB42F30;
	Fri,  8 Aug 2025 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619184; cv=fail; b=doCVa2+oxLjY9vgQzBPVNFIe6RltwUAYI6LnJfDYDtOQ/WNrAYJzlB2h3PBkRiK4BjxvaQPSOHPDcoyD2+0ItLrboZ+psuaGWykBAIDCBMD/a2PLOiyzw/cuvRo/pAbmzKhB7jN12a/jIVPZ5Jf0gMCZtQmcS0CjcZ1zXPfiXXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619184; c=relaxed/simple;
	bh=fYchabpVANjQocXdLsiFkLKn2+bu9cbRRrhxTScdOIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CTTUaEPgx26EDz2S7728dkOKpS5Lai+Ex5zcK7fCuPIolpX2g15j86BvJZMOR77NoURDcBfVKPFLJVXrXr25zjCwfQgkyCmo40cKYQita5BRA1+YaVa66mSoFnT+qxseAnw3rjH2Ee/sdTLN1jjfbwFdKLFgCKr2JI4C13jdfhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PV1lIamc; arc=fail smtp.client-ip=52.101.127.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ08yMraOGEzGiY3NqT/0P5AL8Qm6giF2oh4wQuNsLsKzvuBNCAauJxW57J5Iuy0D13tu7SgU6YmZoWTw8k+uAJLILUdytHD3o4fLwCbUpY6O6txE+kWyh97YRgfuqUg3RRB7Li8kWt444mdZFTMQDmmq9nQjMAt/vj0uWBX9xA2R3EMpTRTVkwikYoxf1gfNpZQ1lDqjImfhX+PV5/LQU4fWV+ZvDZZCAuJMF3px5bd0u7ZsmiK3mOJdzZeUYOd0/GbCjeY4luLSuY294WH5/tvLsyncLz4E4qQGVNtWOD2JsFZ0McXWSPyLVYBYRFNf7J6JnJkyfNhzQXvCyUABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I0EJLh0TUrOGMXjJkqzI3+7M7YSawIYdtxWZUOcOrE=;
 b=O8C7zFGWHuphxyN6yRDrsf8a+CxOduZerl/kopRgEkH9/1S5b/Yw/gFbQ0q25LFkiwh677pkWkBlHxc5K57DBc+oKl/PPIUgmV35jqRvMFMpUCxDm5rxy+xtgyp28pQ0pibmfiRTMz+Godr4d8MUGJ0NQlWenCeYViXq4pfK5c5s8NTGoBqyRRcEohUbHv//tedqu6KlUwmiRZlFoKjVcmz8ZphZfW956fqPMrmWB/BRRuZ6xO00MrkutVVUgIrroYjCu/RkSxm4zSlXORKFD1TdLw6uPXqdWcMf9YSYlOE8HDHSy0TKl5nhCwGVqpyPpUPs/EXhP+jKBkLfVFoPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I0EJLh0TUrOGMXjJkqzI3+7M7YSawIYdtxWZUOcOrE=;
 b=PV1lIamcKHMja1jJoKABTUTJiBFRBP/MD8r3VnEjVEKhahRKmdQlGZIPicwFM/f1EWmoIiyJiNT5KC7Qwc2spk/ZB1xZlGOC/GLNiFHGS4IT4J3EOS+1EYLixJivEjBqo7yDE6lTBJ+jxTFqYrim+jrV2Qju3Scl17eSYGc8u1gujR86B0E3VSzMEVh1Wsri1LHW6pCOdMrQZCDvaV2ipRpxfx0eiDDX4CRx/Gai3Dx6uDwVgJqdEuOqeXEH/5+k/HFkVXSH0IxLOPEzuH6vyb04mxOKy5UZ20p0Ho13f8Z/EsWMTVQTv/kUt8ee6CB07V2XOhYE2RJOYUWJdCbfgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by KL1PR0601MB5535.apcprd06.prod.outlook.com (2603:1096:820:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 02:12:58 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%7]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 02:12:58 +0000
Message-ID: <2cf7ebe5-db81-4aca-9c70-65e712f69835@vivo.com>
Date: Fri, 8 Aug 2025 10:12:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] jbd2: Add TASK_FREEZABLE to kjournald2 thread
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250730014708.1516-1-daijunbing@vivo.com>
 <20250730014708.1516-6-daijunbing@vivo.com>
 <uj22sykbnhfsbk7abj3rdul46uko5vvhq425kdbtkzsw5l5kqa@ixs245eozsfe>
From: daijunbing <daijunbing@vivo.com>
In-Reply-To: <uj22sykbnhfsbk7abj3rdul46uko5vvhq425kdbtkzsw5l5kqa@ixs245eozsfe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To TYSPR06MB6921.apcprd06.prod.outlook.com
 (2603:1096:400:468::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6921:EE_|KL1PR0601MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd41334-07a5-4c5e-52ba-08ddd62117c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0VqaWFGTHJqZFRKOXJiNVloYnB3N0MrU01IcGNtQ3F2c3pyd2Q5UkNXWDZ4?=
 =?utf-8?B?bDJOZjFyNHBuSThJY0JaL0VJR1o4L05JWnVXWlFSVm5vN3JNWUF1c000Tkgz?=
 =?utf-8?B?aFJOQzk5V2NzZEtwNWhrb0c3TldVNGtOZnVMTzlqdHFhRXdvR3lwbG5HUHdw?=
 =?utf-8?B?RytwVVVIdjRGNnNFRTd4ajN0WUpyZVZ4RVI5TkFDRXVQbFJUOUxkZmxsanJX?=
 =?utf-8?B?Uit6ZzNNUVpGT01GNnA5cnFIVWw2Z2V4RFRKQ0J2a1p2VElSa3FqTE44Q0pG?=
 =?utf-8?B?Z25YMVRncFFjN0pHUXdKVkNlNmlEbER5bEUrMHVaaTJVbVFWR0Y0WUVTdFFi?=
 =?utf-8?B?Z0MxQzM4YXE4SUFuOFRWaTg0NWxnSlB0Y1h6QnMwcVZaaWFPTWhqNWptdlE3?=
 =?utf-8?B?ZnlQMU8rOHBFNzRCUmswZzRhT1J5SW80enlXVzNTOG1JWWxXZVpxMWFjNHZQ?=
 =?utf-8?B?Y0JrOVpOLytsaGVwNG1Tbnl0SlhpNHNnN203MjZ5djkxalg3K0VqeFI1NHhU?=
 =?utf-8?B?a1hEejRuYjR1djRMUVZoaUdmNFBNcW1uQVFkQjh6akt2N0UremZlK1FzQ0FQ?=
 =?utf-8?B?TWU0YytzWHFpOGtlTFVpUmpLNTEzb2lTSkw5dWg4UVEzUUJHUG9mUUh3LzNm?=
 =?utf-8?B?V0pBZXBob093a3VHem1wQXo5ZG92bVpMdllMTGNLRnBjMTZ0ZXhLcVhGcUhG?=
 =?utf-8?B?QzNWdkFPeUY4alMrak9sUVJYYjFZL0wwNFpOV25rWG1HMnVxdHo3U2trSDhk?=
 =?utf-8?B?ek1BdXFZM0dNZTZOMGJsUis3Mk5Ub1U4aG1nT1FtVHZaMXVnVThMbVFJOUpY?=
 =?utf-8?B?Y1YrMlpTU1p2VFdXdi9mVUxEaXJqUVltbWtUdHUrSjhHaHF1cEZBNk9JeXls?=
 =?utf-8?B?SE4zcWkrUmpPWkxwcmFKT3FTdkFpNkxnUjlEQVNXU1hyZmRaZmhoSFBnOUEy?=
 =?utf-8?B?M1FGU2pibytnNHlqeFdDMW1zZnNqUW5CQzRLbFF1U201VGlxaExia1liRzly?=
 =?utf-8?B?K2EyZlVnUi9UaGVrQVByZGVjZkdoZTAzbVdwMXBYd1dTNkNwTk9ybDNFNGhs?=
 =?utf-8?B?TDJKQmtzeGxqcXpjaXRrU3lvRm5kdmhMbmV6LzNKMGVqQXFaNFFuMGw3OTlk?=
 =?utf-8?B?b3NhUHprc2ZTQUg1QkgyVDQrM3FZTWtIWktmRWJVN2Q3a2VYQVNRRERwcmcw?=
 =?utf-8?B?UnlDMm5LTGJTaVRUemY1SmpMa2s4dUkxTjFuTFE0bmxiNHRnKzMyeXpDY21C?=
 =?utf-8?B?NStiZ1l1T3ZIL2Z4ZThaN3RZOHY3YURRZVgrYUVZL0o2RTlZc2EwTTVRQTRv?=
 =?utf-8?B?OGlQSHBIcmJJQVFKZS9KQU1lNTFGeVhEbHNrRXFMU25VaEsxZ1VpTjF1djUy?=
 =?utf-8?B?R3VxWkFFa0VYREk2WHRiRFNtanpwZEh4NkJaenBpQU55V3Bqa0k2UUJuOVVu?=
 =?utf-8?B?Vkg2L21tQ21PMzdEckRpanBXbVN5OHEwM29jeVhPY2tkbmdkMVlhYnFDa29P?=
 =?utf-8?B?VWdsSmtjTGpWNmJVVkdqRXE3UlAzekppbVBNSm5VblVmMGdJRnlmMjM3VXg1?=
 =?utf-8?B?cWRCZ3JTeU0ySE5acVBvNVpQaWt4cGs3UWFmOWxma3Y4UnZWMjFnMW5xaXNz?=
 =?utf-8?B?YkYzbUpuQk1uZjhDVTRUUWNPcW9QbUNEUTdEUldOWGhIU1dJWmdhaW5OT1RS?=
 =?utf-8?B?VGR2WGFmZnp3OFhkU3BqQXNOU0puR0o4cjBZMEJ1TWFSejBLM244KzJVZXBm?=
 =?utf-8?B?WEFROG1abG1VOXg0V3oxa2Q4bTJ2Q3NUNlVHaEsxdlY3d1dFMDJlcHQwY2Ru?=
 =?utf-8?B?SEdLWVVCcTk0TGRoMUxlRE1PRHZjK3ZnNWtwS1VxUmlQL2FXRWR0SDFoLzAw?=
 =?utf-8?B?aktJalV2WElmbmtVN0haTFpCTnRvaFlrdmlEbzBvNExYWWpsMFRnSjVEZy93?=
 =?utf-8?Q?z2PYktOiNbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU94aTFzNlQxN3pESzFzeU44YnpYR2hSVjhmZTNYbHZvaWw1OEFvWE4yL24y?=
 =?utf-8?B?Ylp3MWdGNmZEQ2dMTWx2My93UHdsNEFueW9KNWFPMiszcVB2bG1KR0k4R3pl?=
 =?utf-8?B?aW92Z0tTRmkyQzJ4NERhakFQWHVCU29nc0RtcnRVRHVzTk9IY2dHVGQvbGJ1?=
 =?utf-8?B?Lzk0ay9YNTE0QWZ3eTJCdFY5N3hFbGZlWFphWExlS256UXVuOGdDanhHc2Jk?=
 =?utf-8?B?bGEvYWx3TlVMbG91dnFvMVRYaGdlbktaMXl1TlZrMTVnV3dXM2pmcGxNZEpx?=
 =?utf-8?B?M2lGN0FXL0Z5QzBONnQ5YzJZVzF5VmhNQ3J1WUJJOGJJMkludFBENFhQN1Fl?=
 =?utf-8?B?MHpMaU5PNG9PQjF0dmRGZTdDaFRvdjFpVHJVenpDQVlDSmtjVUR1dW9vQnJi?=
 =?utf-8?B?SmpZVW9hbE5vaEVhbGV0RkdyUThiT3RCSWVUZGpVMURuUkdZVHFZSGsxSEph?=
 =?utf-8?B?eXVVVzcwODY0Y0gwL0pIZTY0NjRRdklkS2VZNDBaOXAzOTI2ZWtZemx5NnJn?=
 =?utf-8?B?Z1lydlZycnFBYWNRa2Z5YjQ0V0p4eWhmSHlHcnBFdm1QMmM3OGhzT3l4UUFX?=
 =?utf-8?B?dlViN0RtOUx3cC9qdjlJSWVLZW8zL1JuVnBKWDZLM0E3cDZOWVBzSW95WkZC?=
 =?utf-8?B?eUtsaDNZZEtIL3kvRzZZa1BXd0tMSi9pY1NzUVJlWk9PL0hCcGFBT05pWG9n?=
 =?utf-8?B?cCtFSjFsczNYeEM0bnJrdC9yUkNpSmlKZ250dmtNeDBpQUoxK3pEYlBzSm1l?=
 =?utf-8?B?clNFcVovTWd4TENUclp5b3RwZElEempqSUdIRXd1aDF3c1pPSm1NSERlNWEy?=
 =?utf-8?B?cktYZHFGcXZKVFZYeG41MXRZQUV2ODNQQTdrMVQyZURSTVBjd1NJR0ZhK0pl?=
 =?utf-8?B?clFodWFzZWd2MDZJbHNYYUdEV1ViU2lPWFJtRHNiUGpjZW5CL0x1bTBjaS9B?=
 =?utf-8?B?UlJQZUh5ZFBrby8rZE4wVGJNQVVuZURyRTRQZnZiVnB4cUtwQUdQQnR1U0Qz?=
 =?utf-8?B?YnpKRklmUUN6dXpEZnBka3EveEFFeGRwNWZEd245ZDJsdWNyUUthWVQvT0ZT?=
 =?utf-8?B?dUhxN0ROUFpycVB2R0M4ckg1eTc0MnBOcDc1VGtjMVc5bkRqLzlzeWhLeXZu?=
 =?utf-8?B?Q2FDOXBBelYyVmRRcnVNU3RRU2JvekFYNEUvK1gwa2pHc3ViMnlKbldPWnc5?=
 =?utf-8?B?dzdWN2dCVlo1cEtXQzVMZmdjTUJZUEZhL2Q1U2pmdllJb05Ga2ZkSzRsUDB4?=
 =?utf-8?B?TTF0TzVqb1I2R2k5UTRxbGJydWFqdXpCK0tRa255OFNObHF1TUJVd1BCOUIx?=
 =?utf-8?B?WlVsVjlVNnE3d1hUbWJHbWVZcjYrVUF6TzRNZHFBYVFpMUtqSExueUdUMGsx?=
 =?utf-8?B?U25aVWhBMkw0VTFHeWFEMFNTNmVONFpPTFFHeDNFQWViTTF2YjdXbzRIU2pt?=
 =?utf-8?B?aXAwVUd5THIxcnJ5eDFmOHZWdEdUOFdHcEVVcDUrZDBuWDk5d0crVWxxZWNl?=
 =?utf-8?B?VmFaU1FMNlJScEdTV3FBc1d5amFBOXJ4S3NlSWhKcHkxd3h3L0VSaWRYYUlh?=
 =?utf-8?B?MWozWlVVTDNRNjY2SG5USG9UNVlrMVA3VjlIb2FGaHh5QldDN3RZbXFIYTR0?=
 =?utf-8?B?V3pDLzRHMk1ST0YzY3FKU0JHRVdTOHo1aStmdnJwN0VJWVovMzFSYlg0cVh4?=
 =?utf-8?B?Rm1rTGxmN1JNYlcvMFBWQndQZ2xrb21ZYm5zbnFjVURzTERzbHhqeWY1MlBH?=
 =?utf-8?B?WTN2K21ldHFETWZ2TkRLWlozUWkyUnFkMWNtVTMzNUZTVzJGS1ZKRDhBYVRx?=
 =?utf-8?B?QXVtSXFYZEl0dDM1bmFvRHB3RHpmdERUbGpwemdNTkdmTG42cXdjdmRWVGRJ?=
 =?utf-8?B?UXJqN1AyQUtnTElKdjQ4c3NMdjRlMFFEQ2RYTjR1eHNRaHQ5ZUR3TjhkcGZ5?=
 =?utf-8?B?ZDVOQlZEcUNMWGpxaVZSVmRyQUQwOGN6S0x6eGc5SlY3dXJMRFVLS3ZNTzV3?=
 =?utf-8?B?N1pUd0RQa0lEdXBVZ25YNjNMQ0J5elBzdDdFSStYcXBZT0pwTnlCalhXVFUr?=
 =?utf-8?B?NGlUYXFHZ0U1SWZlYmNGM3JEcStlMUZueml3S3lveWQ4UWhwSmJWWk9XWEtK?=
 =?utf-8?Q?8vJl42/feBtXPQ0xgtejO9gv8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd41334-07a5-4c5e-52ba-08ddd62117c1
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 02:12:57.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMOdV4wbq7sd2WW9GbO6lQI/WDNdSIyuTmcUBWVB2sm8PqGXAcJ4xR9rNxkp4dl8d2hsNhg6a2ZobBCGi0KDyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5535



在 2025/7/30 18:52, Jan Kara 写道:
> On Wed 30-07-25 09:47:06, Dai Junbing wrote:
>> Set the TASK_FREEZABLE flag when the kjournald2 kernel thread sleeps
>> during journal commit operations. This prevents premature wakeups
>> during system suspend/resume cycles, avoiding unnecessary CPU wakeups
>> and power consumption.
>>
>> in this case, the original code:
>>
>> 	prepare_to_wait(&journal->j_wait_commit, &wait,
>>                 	 TASK_INTERRUPTIBLE);
>> 	if (journal->j_commit_sequence != journal->j_commit_request)
>>          	should_sleep = 0;
>>
>> 	transaction = journal->j_running_transaction;
>> 	if (transaction && time_after_eq(jiffies, transaction->t_expires))
>>          	should_sleep = 0;
>> 	......
>> 	......
>> 	if (should_sleep) {
>>          	write_unlock(&journal->j_state_lock);
>>          	schedule();
>>          	write_lock(&journal->j_state_lock);
>> 	}
>>
>> is functionally equivalent to the more concise:
>>
>> 	write_unlock(&journal->j_state_lock);
>> 	wait_event_freezable_exclusive(&journal->j_wait_commit,
>>          	journal->j_commit_sequence == journal->j_commit_request ||
>>          	(journal->j_running_transaction &&
>>           	time_after_eq(jiffies, transaction->t_expires)) ||
>>          	(journal->j_flags & JBD2_UNMOUNT));
>> 	write_lock(&journal->j_state_lock);
> 
> This would be actually wrong because you cannot safely do some of the
> dereferences without holding j_state_lock. Luckily you didn't modify the
> existing code in the patch, just the changelog is bogus so please fix it.

Thank you for pointing this out. I'll make the corresponding changelog 
updates.

> 
>> Signed-off-by: Dai Junbing <daijunbing@vivo.com>
>> ---
>>   fs/jbd2/journal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index d480b94117cd..9a1def9f730b 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -222,7 +222,7 @@ static int kjournald2(void *arg)
>>   		DEFINE_WAIT(wait);
>>   
>>   		prepare_to_wait(&journal->j_wait_commit, &wait,
>> -				TASK_INTERRUPTIBLE);
>> +				TASK_INTERRUPTIBLE | TASK_FREEZABLE);
> 
> So this looks fine but I have one question. There's code like:
> 
>          if (freezing(current)) {
>                  /*
>                   * The simpler the better. Flushing journal isn't a
>                   * good idea, because that depends on threads that may
>                   * be already stopped.
>                   */
>                  jbd2_debug(1, "Now suspending kjournald2\n");
>                  write_unlock(&journal->j_state_lock);
>                  try_to_freeze();
>                  write_lock(&journal->j_state_lock);
> 
> a few lines above. Is it still needed after your change? I guess that
> probably yes (e.g. when the freeze attempt happens while kjournald still
> performs some work then the later schedule in TASK_FREEZABLE state doesn't
> necessarily freeze the kthread). But getting a confirmation would be nice.

I agree with your perspective.
While cleaner implementations may exist,I haven't made changes due to 
uncertainty about the alternatives>
> 								Honza
> 
>>   		transaction = journal->j_running_transaction;
>>   		if (transaction == NULL ||
>>   		    time_before(jiffies, transaction->t_expires)) {
>> -- 
>> 2.25.1
>>


