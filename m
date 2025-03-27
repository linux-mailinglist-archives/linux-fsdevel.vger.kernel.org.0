Return-Path: <linux-fsdevel+bounces-45142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4477A73554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BEE3B81D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1BA14B07A;
	Thu, 27 Mar 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXQGbffG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F735957
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087906; cv=fail; b=TSk6DfV5dkXQwYjNdbTp9PYGXLMxVOXbJu2AbQDSMoPPENlzLQVGgo+Hxnpt/fkqkVFLr6onw2cP5tK1wlqiSuPRsdofWxtF5GYvm7tXdow9G4prZpInEgFw9y7UAOLLwEPRFiZHhhqLWTBROa6S3yu1WUB3sqbTsasgRHsDRoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087906; c=relaxed/simple;
	bh=8Y3nSBpnfMFgphyFWBj7U/tJlLanqGHkxh6K8ksSKnk=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=B9pcwpKfj8Wc8hMvceHcZsQtgsAEeiI2U3XBRo439WgcuqM+6+i0F6mdykoaO1t4LVTNnvlZLaDu2JOBJUF03znuk/fi8/VGcEZ76dn/Lv4HY3182HCeT6/jMzUjw0Wkc/6h2UUrGngO7ioKhfqibQNbQhMTJ5B8Wx2JMlhtjXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXQGbffG; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMWuSLO+fUDSzAV5JtMzT+JfLGxB8fO2VmpbwQk2l+4utnsCoQcIJLNM9eZ0CSf+1L30Gm6QWtxd0fMbr5cnNcwPR7NVtocb1paXzpteMaheHMUek2Y5l/5/Te82ZQ8/ghijSZx+6nkMCMOpCP9J7VpnKO7LdOxOvM4DTPrraX1KdfCAyNy9LzmXxBP6zDoMC5XKdv9avh2PU6lp7fCV/NyftQrxmwsiKl73idEHl/GC0HIjHsKzbdPMR6jsnI6mp9AqYQfee2YlFxhk2vPznnpb4sTwA+TbEU4lIEA1q0S1hbYthvObCIAcoW3p9wDzI7XxDGicCRCYAK3PUTqLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3rjfxKvTGNyZmr0JlnzB6OO81Yqouqob3AiuXmTPHI=;
 b=SNWLkl61BbzRrO3JXtTPEwWGUxoQeL+14uHRk96umYXVGJoFm0TqS4vNT12usyBTnBtbRNYfw5Q8Hq0mKX5qNFbaCgjwSPzGi6N0gK3zKIyXVV2GLJy7GqoGJr9UaYVW6ZI9aHmkeX3BNKIPd52TVXawQ/baeiknVMsCTlQYIVMTd74NYvFng9XsJOeghq+ALSReXcJZYmt33PiKO9ZmN9kyq4dr7JhZgY3o2ZIJRFxIsnLOM+bD3YSkG4Gj77yH4ZpN6COyB/j4qCIBpwwLkKHwcdyx+K/7DA9ACup9hU6CCllh/0LyNRIisHtAX9d+F9cgejZDpaKcy2z55Du96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3rjfxKvTGNyZmr0JlnzB6OO81Yqouqob3AiuXmTPHI=;
 b=UXQGbffGpIdw4nruoFF7LypjFuNNNmlY1z5KEXxxLrR7qAJjW+4IpSksoSA9AB1wtQMfFu6r4DJZL2NgNEZId3wavffSDm0JUBM4EFzPjv4CE7kx+xibJBOeP+3L3k03iHnUPf995d71k+KBGXf2s5PRQ6ENpFx6D/K9zHUQJO6UFAAuLSkWI7tI7Iq44E4eJDqVAP3SXVmMPd6gQi6mnZGiX1uYNd0XoerWIKasjLHsY2emFJS90d3bGrXLaCj8TwQdMMlo0nrVkCw1UIYp7Zycv3E22ChoULcbtVfAyVowlR2uPPX1ovcBhti/vGt1q1m03qif7eWxi/+FR+QkoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 15:04:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 15:04:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Mar 2025 11:04:57 -0400
Message-Id: <D8R539L45F9P.3PIKZ5DUGGVS8@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 06/11] migrate: Remove call to ->writepage
Cc: <linux-mm@kvack.org>, <intel-gfx@lists.freedesktop.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 <linux-fsdevel@vger.kernel.org>, "David Hildenbrand" <david@redhat.com>,
 "Joanne Koong" <joannelkoong@gmail.com>
X-Mailer: aerc 0.20.0
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-7-willy@infradead.org>
In-Reply-To: <20250307135414.2987755-7-willy@infradead.org>
X-ClientProxiedBy: BN8PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:408:70::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 1669543f-b35d-4332-937e-08dd6d40be5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWVHS0lFZlpROG1xUjczekowSk9XcHRZQ090OHhFTjdxc3NmY2xOQ1ZQeGhy?=
 =?utf-8?B?QVJzYWVoMndXcC91bVkyUzUrTFZUMDhGTUg2VmV3NUNwNTNoaFRyWnF2MlV3?=
 =?utf-8?B?YnJsZGRFTlFzVStvWjVKWXN0ZEZoK0hUdlB3T3Y0YlN5bzM5ZUdNclBVRjRL?=
 =?utf-8?B?azcvSTFIMGtLbElvQVFvaE10WHRIbDB1bW9tWTZrUUdFVzM3R2tEcjR2K3FB?=
 =?utf-8?B?V2dpUTZZUk9UdFVCdDJHOW1SL0JoNEpJOUQyQ2pyU2NCeFpUU1lSaVNRNE1F?=
 =?utf-8?B?RHNocnJodTJ6eFN0bGtIakZpQzZuWjI4WjhaZExOeDF5U1VGSTZtbVNtalFs?=
 =?utf-8?B?SGEyMkkweTQvTlVBbzVuaGN1N3IyZytxQ0pNY1FPVXY3am9MKzRsRGJsdFNU?=
 =?utf-8?B?YkM5TEpGWWdiNHRxcTV4QjQwa2FvTk42UlB6Y05kTUJLUHE4WDM1MkEyUEQy?=
 =?utf-8?B?NExRSEZJYXJkbmF6WE0wR3JadVArSURCTUJQRWRqWkM5RHgzaGxUaStnK2Ft?=
 =?utf-8?B?ZTBSSVY5a2VybWZXT01HK2tWSHNrN3lUa2FoVHg1WGxFckR5cjlKeVN5K1Fv?=
 =?utf-8?B?dzBmZWI3ejJXL0RZcDMzeHhYT3JhZGpiU0RsdFMzMjdQVWIwRjFkN0plNjIy?=
 =?utf-8?B?emdUN1FCTGVHSWdkbnRiaFQ0VW1Cay9NV0txUmZrLzRhOXpUN2pFemJqeHJw?=
 =?utf-8?B?U21IZlc3MHI3Z1RRaWpOejVESzRhampodndEMHZKVmZrUmR6S2dvZjJXajRn?=
 =?utf-8?B?K1BqdXNmYlVaKzgydE9nWm5lTjlEZ2RvQm0vN3RVRVBnWWZhWjVHekFNOFpC?=
 =?utf-8?B?U2tlUmFNc0FvdHhIaTFNN012dE5aOVlnaXB1Uk11ejl5WVVVWDNMRHBLQ3pH?=
 =?utf-8?B?T3pYcFJDak1nRUJIclppWG05MU1TZDc3L0x0d1piOExPWU4xU2lRa0MvSS9p?=
 =?utf-8?B?STBtcGNsUVF1cmdheHhGa2FCSWRPdW4wVWVQMmcrUnNOall2a3I5NWp1SndD?=
 =?utf-8?B?N3VkUWxZSmxzK0pnRzRJclh2OUQvNHZ5UnNsWGFrT3F1NDlqR1BGdmE1TGth?=
 =?utf-8?B?L3lZdjdNYjd6SmlPc1ZlTVg2N3A3UE9mcXJuT1ZDaytxNkZKMG84akE5Mzh0?=
 =?utf-8?B?MGZTdjAyUmk2ZXhJaGlhSUJOaDVmRDBiU1lPK1JxTnEvMTloZHozazk1d3Jx?=
 =?utf-8?B?ZitNZ0tnWlhZZ2FPY00vbkZCbFlsN0VYUkFtUUpPREM2OHh2WGU5N3pxUmVj?=
 =?utf-8?B?V1ZrNlIySUJwcTNQVkRRKzIwSGxSNXFjSDlKQ1MvUDBuQXk5QmVDelZteTlB?=
 =?utf-8?B?VGZxYVRpK1dRMWRXelZ1bHZFa2tSdzcxT1hVL1JWWUd4NEVieHh4Nk1ZY21t?=
 =?utf-8?B?Rm5DYThkOGpEWVhseU5hZDd3Q0hwdnAzSUJ0enJqN0tYOXR5Y2lHM2FYMnZa?=
 =?utf-8?B?c3Y5ZVgyb0gxK3VMZnV3WVYwcFdQTXlhaXBIT3pnTDhHZVZIMGkwZzVTYkR3?=
 =?utf-8?B?eEw5SnM5UkRzR3BhY080a3UxZnYxWHpNYmN4cjYybFI4YjNkZVBCeG1CNWRm?=
 =?utf-8?B?bDVjbGR0TERnM3JXb3ZqWWJNYUdyaVp0WkxISERzZE5JekkwODY3VjZqZDdt?=
 =?utf-8?B?L24yRzI4RFpDamZPbVcwdkYwSnpMa0xmMW0zbGpZeU9YNExUSWlFSUxUcXBU?=
 =?utf-8?B?OFV4YUhIajdpU2NYSlpIUXNzSDhRVzBKMkRlN1daUFZmV3REMUwzZWVxbS93?=
 =?utf-8?B?bXhFWVU0VTNBcW5DUnlrUHZaaGdHbTROTU9zOUIvTHFidEl5Z2RTa1hDRVll?=
 =?utf-8?B?Y2VrczNUT2Jza2hPMzhTU01ualgvejNENjkrNzFvbVlFSk92WTRsY3F0OVRR?=
 =?utf-8?Q?aejiXRbHDuXIZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGdaMWx3YWl5NGZHV3k0RGp5UU94d0RVT2V4SHUvRGFMRnErVUVGR1o3R0NP?=
 =?utf-8?B?MHlvQ04vT204YklPK3Y3MW5QOGNUVFJBWXV5MzFXU0J0dWJ6dnBDcUsxd1Vo?=
 =?utf-8?B?dFROZTlZRU5ybnA0YlgwLzU5clR4K2poeU9jR0l0Tlk5N1psZFJqbEl3RHNR?=
 =?utf-8?B?V09QRlphYXRiMHhMS3dtMkFRSG1SV0lscm5xS0tyODZPQmsyVXZZcUdmQkY3?=
 =?utf-8?B?cVpDL3BKMFhVM0JKTHlsZ0p2Tmdpak1GRkxnbE80aG9IaHJMOERQOHdaQyts?=
 =?utf-8?B?ZCtRMGxrckRVVGJRUVVocEhKSTczVmliTTlzSnRQeGZjRE4wa1lxcVBWUno2?=
 =?utf-8?B?VFJ1ZVIzYWJRSVVuWk5xVElOMTk5NmhKVHZXYk9SaVprRjBQS281dCtNTnpH?=
 =?utf-8?B?QVlBMk5YVDB3NUZLTUluakFjSUNqbndLbGx0UFFBaC94RDJtWGI3czdGM08z?=
 =?utf-8?B?azFEbkpiUWlPYlVsV1k4U0cxKytQMWNUeVlVYW1EUG9KUUJOMUhEejVPb2to?=
 =?utf-8?B?K0lvM04vcVVzaElvRWE3bFhNS1VCWk5PRkVKUlprS2E3QmVHQm9MZnNOMFY4?=
 =?utf-8?B?ODhGQXZYY0V1YjJUdEdqYnJVUlU3a0NEREkyTkZlenhOTnFJVGowVFVPTUpQ?=
 =?utf-8?B?OER6eUNrS0dNMVUyNDZseXovb1FiMCtOTno0RWR1b2VZMm9wbkoyY3VIV3VR?=
 =?utf-8?B?TXg1ZHVMaFJLTmw1NVBSMDVVRUxTc005aHd4K2ZMUlAwWUN2UmhGaklUT3ha?=
 =?utf-8?B?Qk5ZWFpxNzVvd3paOG1YSktsQmN1dkE0OUk1UlRHSDRrc3UwekRNczdJendP?=
 =?utf-8?B?cDVQNFNCd0dJY1p2RDdMZWF4eXdDaXFIenVHYkNCQ2FhL3BnK2hCdWlHRjZD?=
 =?utf-8?B?YkhKRFlmNXppZ2FwbWpxZXN1UlAxaitBNFh6ZjhVWVI4U0kvTVdnb21RVDB0?=
 =?utf-8?B?SFlvM1V0dHFmV05jK0g2OEhpeFFQSXBuWlgvcnBVdEtwcGRjVU4rdmFYejMv?=
 =?utf-8?B?M2hJOGQybzFoRGJZSEN2UjlpL0c5eHN0eUJFeU9RSlZOMFRCUGkrc3kwWmU3?=
 =?utf-8?B?YUlMNmlvckV4TzBHNW56NG80Tm5lVjdSdm5xMnl3b1E2bm1LN1h0Y01td3o1?=
 =?utf-8?B?TXRwV1ZjWW5xRHF0K3Vnb1dub0tMMUtMbUJUVlpwWE8vVCtaaVFQVHlib0ll?=
 =?utf-8?B?THhEWnBlbnovK1dFT0laK2gxWWZZVERkTmVvZTg5YW1JVmdUQXlxZWU2YVlj?=
 =?utf-8?B?UmFOK3h4NmpMZ3RLaU5kbXpsS25oZWpXZnpJWGRlSmhWUE5RWVJINGhJTVBp?=
 =?utf-8?B?MVZiSkh6d1ZlRjllVFhTUTg2NFQ3TUdlV3NSWUprZDRZTy9lamU5NSsrQWxr?=
 =?utf-8?B?azlncjh2WC9KMHE0dVBTWjJ5QVhoVVNHN1FWZ2RzQ3ZuV2p6Qmw0U1FkL2sr?=
 =?utf-8?B?UmtxL3BHa212R0VsOE1CZXFKbklpQlIwL0hIRHFsUU1XL3VrWVgrb21qMlB1?=
 =?utf-8?B?YXl0aW43WitEOHBPZW4zeGNFNXE3WUxxZXdNZ3ByVnpyeE5Ub3ZxTDNiblla?=
 =?utf-8?B?cVpnMVg1TDY5YXNjMjM5dmVDZVFqSjFWa05GcE13QWRIRTVTMXJWMXJaa0NB?=
 =?utf-8?B?ZUs3MVdKWTljblNUWXYrelJsUGR4WXVRYkhXdzBqUzRpb0FsTW90SEhBY1F4?=
 =?utf-8?B?MEZKYXlJTWFPV3lSK0kxWlBGSnI0STd1MkxtcTl2MVB5RU5GUUlEVTNpM1dI?=
 =?utf-8?B?cEZLY1hNNWsxWFR2NDBTdFVRYXBNS0w2U2dmTWVSRG9pVzQzMDdJVlZzSGdB?=
 =?utf-8?B?V3dQSEVQQ3JSdGZkVk9TQzhORC9HT3lDa25FQm83R2gvSTB5aFFDOXU2cXJF?=
 =?utf-8?B?ZjhJMEc4UjFWalE1Y2F4eXFMZk4zZnBmeHR3dk1vZXJzdGRYd1U5TTE0ZUhJ?=
 =?utf-8?B?d2VjWGlxaTZMYzdPc2VRNTlkM1dZdXcrUCtCUERHQXEzYTBLbjNwTk1kMTVX?=
 =?utf-8?B?MTBXcXNDV0RCYXloTjBTSmdwR1h3TkpmNGQyMjBUT0FKUFE4ZldBRUZpcGgx?=
 =?utf-8?B?OVlRQnZkMHBRQVdaKytQM0dzdUN3NE5ZdjNTK3dsSDRaWUVVMXFsbDNWZHJG?=
 =?utf-8?Q?2ikeGK7ZOcJh4RFZmM2/UA5iS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1669543f-b35d-4332-937e-08dd6d40be5f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:04:59.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfDdrVVyYNXE3FWbcETtAJQ72XE36+MNchPJ6bR6WwTaFK2UYubhY8mW58KkdPKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230

On Fri Mar 7, 2025 at 8:54 AM EST, Matthew Wilcox (Oracle) wrote:
> The writepage callback is going away; filesystems must implement
> migrate_folio or else dirty folios will not be migratable.

What is the impact of this? Are there any filesystem that has
a_ops->writepage() without migrate_folio()? I wonder if it could make
the un-migratable problem worse[1] when such FS exists.

[1] https://lore.kernel.org/linux-mm/882b566c-34d6-4e68-9447-6c74a0693f18@r=
edhat.com/

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/migrate.c | 57 ++++------------------------------------------------
>  1 file changed, 4 insertions(+), 53 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c0adea67cd62..3d1d9d49fb8e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -944,67 +944,18 @@ int filemap_migrate_folio(struct address_space *map=
ping,
>  }
>  EXPORT_SYMBOL_GPL(filemap_migrate_folio);
> =20
> -/*
> - * Writeback a folio to clean the dirty state
> - */
> -static int writeout(struct address_space *mapping, struct folio *folio)
> -{
> -	struct writeback_control wbc =3D {
> -		.sync_mode =3D WB_SYNC_NONE,
> -		.nr_to_write =3D 1,
> -		.range_start =3D 0,
> -		.range_end =3D LLONG_MAX,
> -		.for_reclaim =3D 1
> -	};
> -	int rc;
> -
> -	if (!mapping->a_ops->writepage)
> -		/* No write method for the address space */
> -		return -EINVAL;
> -
> -	if (!folio_clear_dirty_for_io(folio))
> -		/* Someone else already triggered a write */
> -		return -EAGAIN;
> -
> -	/*
> -	 * A dirty folio may imply that the underlying filesystem has
> -	 * the folio on some queue. So the folio must be clean for
> -	 * migration. Writeout may mean we lose the lock and the
> -	 * folio state is no longer what we checked for earlier.
> -	 * At this point we know that the migration attempt cannot
> -	 * be successful.
> -	 */
> -	remove_migration_ptes(folio, folio, 0);
> -
> -	rc =3D mapping->a_ops->writepage(&folio->page, &wbc);
> -
> -	if (rc !=3D AOP_WRITEPAGE_ACTIVATE)
> -		/* unlocked. Relock */
> -		folio_lock(folio);
> -
> -	return (rc < 0) ? -EIO : -EAGAIN;
> -}
> -
>  /*
>   * Default handling if a filesystem does not provide a migration functio=
n.
>   */
>  static int fallback_migrate_folio(struct address_space *mapping,
>  		struct folio *dst, struct folio *src, enum migrate_mode mode)
>  {
> -	if (folio_test_dirty(src)) {
> -		/* Only writeback folios in full synchronous migration */
> -		switch (mode) {
> -		case MIGRATE_SYNC:
> -			break;
> -		default:
> -			return -EBUSY;
> -		}
> -		return writeout(mapping, src);
> -	}

Now fallback_migrate_folio() no longer writes out page for FS, so it is
the responsibilty of migrate_folio()?

+Joanne, since she is touching the above code in the FUSE temp page removal
patchset.

> +	if (folio_test_dirty(src))
> +		return -EBUSY;
> =20
>  	/*
> -	 * Buffers may be managed in a filesystem specific way.
> -	 * We must have no buffers or drop them.
> +	 * Filesystem may have private data at folio->private that we
> +	 * can't migrate automatically.
>  	 */
>  	if (!filemap_release_folio(src, GFP_KERNEL))
>  		return mode =3D=3D MIGRATE_SYNC ? -EAGAIN : -EBUSY;


--=20
Best Regards,
Yan, Zi


