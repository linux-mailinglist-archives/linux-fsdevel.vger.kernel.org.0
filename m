Return-Path: <linux-fsdevel+bounces-64728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A7BF2D19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6EEA4ED7F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821543328E1;
	Mon, 20 Oct 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V4DcWIQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24813C3CD;
	Mon, 20 Oct 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982932; cv=fail; b=JvkRoCq+r1FsCmn8rNcjy6WTx3giAD6ylKBtwOyOUdWl7gNbQsNKw4qA0i9J3eBi128oz5OxxHXXHdIurUvsxT5P+/Nb1F8ipw2vwV0B1zkEIjxUUOBgWzSrC/8aLeU3BV1xHJbB75PxqCJAlVx9drn4N3HVpvDD4HVy+2zjzFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982932; c=relaxed/simple;
	bh=RVa/b7QnuVFw3snYKfURRiHSCVRz58+TXAsEkCBj+QY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gxbOtnSgPdGQCYjBTwHvQGb8YLGfrC/WQ7VIx/SyeCrVy0XWkzjjkX5VQVu19cDxwEbY75lmzvJaqnj/3+Je/K1buvCWFJyFY63JxBilIi7WKCFhojTXeaxaphFPdGxk6JXH/T/FvQrPAJvWEcB2hbvqVmPQv+tu7qYjDJH4MjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V4DcWIQd; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCUaf7aWgdU+0ht9LIV4YfoIfaH27ThABSmdFZW7LvjkTifryGluMStc92kzkuFi9gInt+riG+hr2eiPb53tdYMmm97q9k82gdMyqPXoCDqlhkA/+nCUMx69YxqZmoUgyxgz6a8yNKbS0GMo7ODsRuOlFIfGKr7xMTSvWAuoITvtUVjHb58MUzBS310NVg0z4vLsF7moCWRDBfBXElBaKb0kl7ST/JxyoioBVZaMGV6QPWcdvwqTkl0JQGQTFHztR9rJF9bPOX/SxStl6QYa5aZfHyWdBphgWQdsSEUUK5+sk50nBf7ehrBvbfcR9943a3SzZT9uaESaMlBfBCa7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vjE7SPpx36V5X+A7Sy0avsEip8LzwqBFCgTL9p28iM=;
 b=FufH511rQIvGOeQ0FEAK//3wLri2/RiFgKN8fzfyFYre3o+Vi8Bd8lpebfN0LTicfNyvqRM5x+/U1wzK83k8ZQwREvXcveFYMmHl/zCvx2P4071qqza2P6WkkzA1U99bzaycBnAPX7n2Aqbll6Ld8sA1Ia7aOV2mZl+pij1BztmMbY5wymStJsXEhR9K1CZTK26SYzYlJfqf2J/Rw+0Zm6NVucgFBJbRmkoWfnbG86sHC+8iWTBqEtEpeCCKyve+LO9N1lI9VnEa3hk383Er4LiogpwBVHq8P5c1k3Pi3LHKLadgME+KdqWkeBJBmYDJrsxrJXcnsPSFtdZLgf0PNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vjE7SPpx36V5X+A7Sy0avsEip8LzwqBFCgTL9p28iM=;
 b=V4DcWIQd0zDBJZuSXA//cylx6YCCNOQXkPL52lo/48pRmRH3zcj6Rmv5GIh1FPzGpRv/2bIRYOlcc92N0unLiepvYDIJZoy94mNuftYNiLPlt6D5zAoSRw+iG4xiTto0U8GOAjL5my86RMO2xwzsdCTy+uzPxvzhsNG8nsEQbOA5cR9clbWYFP7eblr7Nx+E+Ql1XSCoN6zr75idDM0frILZJedORp/vfjlt23EAfs1Jfo1azvhfu9+2tPKMk6EgD506nUTJ4FXNXYF6ASXQ0D3MM2k581TZC997I8msO+SC6A9UnPgz6bDZlgL0sHlM7h1O2BhKtCw9tnEjz3w6pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 17:55:28 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 17:55:28 +0000
Message-ID: <a1cffdbd-ba98-4e24-bbb6-298eba40a11e@nvidia.com>
Date: Mon, 20 Oct 2025 10:55:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 667744ba-e855-4638-fe93-08de1001da4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnJ4S09Oa2NlNUNLQ3lqblJYelQzalF2cDRQSWh6ZGZCS21BR3N1YjJEVCtl?=
 =?utf-8?B?OEplT01idzRlR1Q2aE5pTnBjeXdEcmdtZXc3WWdjMzBhUWJWOHVTajJyRzcz?=
 =?utf-8?B?b09BQWtEa3lVYlVqVkcrSXpBZElnNzRGaDU1OUNnWGkrUGhPZFJpN1Azb0gv?=
 =?utf-8?B?ell6b1RBWDExWm9VSGQwelZKYVB4aFZBQXJDUUtSOTlUUm8rUXhjbFg2aUFP?=
 =?utf-8?B?Qm5TVURJNHdPNWE5ZWRvVjVpbS8wTWZpUU8rczdZT2R4dXNwVGVxSEVTNStY?=
 =?utf-8?B?Yllsb2lmWFpRRXFiS1A5d3d6bjh6RTNEMHFFUnBiMGFSMFJ4WFE0cnhOSHBG?=
 =?utf-8?B?VGgwODRrRkVNYXpWM2kvdEl3QzRTdjBOM2NOZE9FeGZKUCt4QVhvQ2hWV2F4?=
 =?utf-8?B?enFGci85UjlKNW9vT2NZSk96WlFIMThmdTMvMFRJNmI2Rmswcy93V3A1NXpJ?=
 =?utf-8?B?WitwRy85NWl3cVhpNlQwbTBQa2lKRHl0NDhINTd0clBpVi9qNWE3R2dPd2Q0?=
 =?utf-8?B?U0t0OXBCdnVlL240ME9uV2FkSm9zaEw2bm1zM0NvaDIvYm1VVitOTGdkcDBv?=
 =?utf-8?B?cUZKak5GeHV6R2hkM1pLWHlkZEVYa3NER2RBQUlzNFQxRm0vaGUrbVBMQWg1?=
 =?utf-8?B?eGZtaUZLeTFSUi9VVUh0U1BDU1pVRlBpaXY2UWRFcWdpQ2l1Y0llZ1A3TTBI?=
 =?utf-8?B?cHQzY2U4OGc3STJYV3lDMzUxTG5iTFdhRWt0YUlHcm51TkMvNk9qcVErTHow?=
 =?utf-8?B?dmtKbmV1UVBOS25mTEk4eXovZ09La3ZqQjJIM2ZUM1ZTM0N1UFVqN2pOWVpF?=
 =?utf-8?B?b2t6Z0RIN2VydVc2bmhaQXdpY29EUFl0Z3g0VXoreXBBdnNXTmRIckF1WWhk?=
 =?utf-8?B?QnBDYVlQZkJBNGhWalVwUHpiWUJIcEpMZGhPRFg3YVJyVFhqWXQwaUdMekZP?=
 =?utf-8?B?dUFiNy8wQm1HL1pYTmhqSEtkZk40L21ScW4wQUswaXJNTWxxVlJ5aWdpUVUw?=
 =?utf-8?B?QmpsWjk2ZzlmaTZUMmtkbXhSMnIwSU9ucUMyU2JpY1ZKYVl0NlJETUV1MUpy?=
 =?utf-8?B?VitOclkzSUZINmhvTFhicjFvaU9DOVE3VlU2M3Zlb0xoRzc0d2NSeTloNjJ3?=
 =?utf-8?B?SG4ySFg0bjcxNGlVUFVQNjVaRmNvWkxVWWhRQU1ydm1OeTV0RDNZdG9sd3RS?=
 =?utf-8?B?Z0Vpd3ZieTE4ODdpSzdEWTBOYkM4Wkw2cURrSExpcVRsbkVKc3J1eW8wRGZF?=
 =?utf-8?B?Q1kxU1RHS2tJdjgwTFBNVExHTFUycjg0N0kvVmd1R04wQjlwQ1llUE9vSjhw?=
 =?utf-8?B?VEhnOVJzYzZFMzVMeitnejVBSFRsVnBWWmt1alFweHg5NzhPWEtyWFBWQlFP?=
 =?utf-8?B?bUlPYWdFcTNmYzNucVNUMmRrU29Udm1TcFQwaEcwVlV3bXZESDk1V2RvQUlG?=
 =?utf-8?B?VWdSWnZyOWFMcWZEQjhHZTRES2V3V200WjBUbDNjZnB5N2VsM1VFOGFWNDVy?=
 =?utf-8?B?MTM1ek90K3VGVTVCSVpUUjZ4WHl5NzhoYWtUMTNQUWZMTzBYN3BxVDdWT3Jk?=
 =?utf-8?B?YWFDYjJMMnJwck5WK1Y2djh1WjQvUG9vNmpQQXhSVnJGTWw1Y3ZoWGxXUFJZ?=
 =?utf-8?B?R2praFRFUmJBTVJBSzl4UFkwYzV0RjE4Zmcra2Z0aXNPWDhDUnB6UmUrNjNw?=
 =?utf-8?B?SmYxd2ptakllNTZPVStjVjJocndGTndaTllRNGFrOThHWVI3U1J5VWFGbDU3?=
 =?utf-8?B?QlphcU4xc0ZBRGkrUkJCWDdZYWY2NEpBbFJzTEZGSFJYenZzL2dFZ3hlaitr?=
 =?utf-8?B?b0Q5SjNna3c4VTFEZFVuYTdDNDYwRjV0M0F1U29ERm5HeGdQU0IzMVVaMHYv?=
 =?utf-8?B?TVpuSlZFN3BtWDBmd29PbnFDcktUVzVtSkR6Yk1yL3l0bG9VbG5xZUNsZDVO?=
 =?utf-8?Q?f6u995HNfzRTjORaKWc0HQmKtwJR1vLy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UllwZzYwQ0ZNSnh6eldPcm9QRlc0bzFaRlRKc21PVzU5YjVIYkhYZ01HaU5H?=
 =?utf-8?B?d0wvbjh5TkpLUUkxdUM0U3cxWTI2K3hpYjFHSG10NFZ1eEU3RGxReFdzL0Iw?=
 =?utf-8?B?QTRsd3dkRG9lblYzMEY3bFo4SHE4emo0VkJmamJET25nNTdGbS9mc1hrSzhr?=
 =?utf-8?B?SHRDRi93elI0NGpLMnh4T255WUFzUDZXNjY0MHFnZjIwbVRHaUFLRERMZ3FB?=
 =?utf-8?B?VU9tQk53K3o2azdnRHErdWc3WitSYkNLMkdCekFsdmJibTNURHRQejVNZTNw?=
 =?utf-8?B?TmFxaGNNZlJzbUZiZGxuYkJnQWk3T3ZneUFicjRibll2N2RtMkZhZGVuaFhZ?=
 =?utf-8?B?TG5GcHJFRmx4ZEkzczRZRlBmRUcyeXF1M0xrZ2cycGJDSmI0U1JuUkJIUmhX?=
 =?utf-8?B?V2ZzaElTa3BWaktDajU5OWVZeXhselNSdkY1U1ZyWjIzQmJVOTVBMkUxZmVP?=
 =?utf-8?B?N1EyL1hpN2pqUWl2Y09pRytCd0pIRWtVYWkxc2RsUHJIVlB5WkRmM1JJcnp4?=
 =?utf-8?B?K3pvUjR3SGNOanZ6T1FraWVaUlZ0UUhSQ1FrYUpBSjdHMXI1Ky9BNFZDRnBX?=
 =?utf-8?B?dkF0STRsM3hxOGtsUWVUa2hXS004TWU3VDlxUFpTQWg0b2pMVVE1MFFyZjdC?=
 =?utf-8?B?d0ZERkptWTc2dlJSM1JjeDBqbGhwWVpSeFBiS09pT0Zwd0cybUVwaG1EOEUx?=
 =?utf-8?B?eVJ2NjJ0MEdyNHhqMlZVNUpSMmxObjI5T2ZWWWdpSmdNTkFCTExQbElsTWFj?=
 =?utf-8?B?MEpEYk5xdGpmM08xelJTcjBiWkgwQzU0UEJyN2JPY1RsWDZnVXFMNHlIb3dG?=
 =?utf-8?B?bTZSS3dUcHFRWFExQkJQd3h1dTAzWXBNM3Z1L3d5eDMzMnlWUHo4bjk0dVZL?=
 =?utf-8?B?TUdyS1hHcWtoZWZlaE44S3ExOVQ1UGl4UXAyaWtENkVhaTRvWHJBcGhiVW45?=
 =?utf-8?B?ZzJVemJvdTg2M0NveEY2K1BoV2E4aWdIMFI1a3gxRExnRnRTVXdiWUFWR3d4?=
 =?utf-8?B?OU1rbm4vbDh4ZVhEZ1duNXhTMkNXaTZvaS9ReDdnK2x1NDQ5eWFqVzY4N095?=
 =?utf-8?B?L2gyRmc5Y2xONEsyTjg5dHI3dzB0THg4YjkxZjA5U1YwMXBTcHRUZW81ZVQy?=
 =?utf-8?B?WEpyMHozQ1dLSTRjcHJ2ejQ1T0YrSUJWaVF5UnUzVTVLNW5TSSt2VjROV1dW?=
 =?utf-8?B?RFRZNDlLS3drODh4RTFEYnE5eDY5cGZ6R3p6dWVFRUJQRWhhRFQwa2RnTGZP?=
 =?utf-8?B?ZEN1ZVpVZ0IvWmZZbnIvV01XdnFzUDQ2N3JZeVJ0VkhUekpwOXdxTHl6SCth?=
 =?utf-8?B?dllVMGZySUxpQTVGbHg5QS9iM0xrMUtycld6NnVoQ3FwWWVzcVo3OXlFbTYz?=
 =?utf-8?B?TTVzU2g2MmVEaWV1SnB3VUUwWUdHeVpCelF1RTB1YlBBNk9aekVOWFRxOUdj?=
 =?utf-8?B?OCtVYmZmazdyUFZYTzdzcFl1MkFjRGY2TlE2Mm5TZjQ0ckdVeU9XVjhZc0ZJ?=
 =?utf-8?B?eVlXdHBKYmxJL3NMb0Vjdk9vNXNmQ0NjWlkwTnA1b0dueGdSQmRMQjQvK2M3?=
 =?utf-8?B?UWZsVGFnMkJhbUxRWEdFU1ROTDYraE92OW9sdVM4eSt6bFl2ZDAwTEduUnJZ?=
 =?utf-8?B?RHE3amR2ZlRZZkVrVUFYYVF2aHh6cnFRYmltaDU0aUdPWUY0VFYzZ3NsbHMw?=
 =?utf-8?B?UzFrR0k4eDNoV0VLTXRiL2kvc1RqVnN4bEs2RUpxbHJ6RmlkbU9ZdDc3eTVy?=
 =?utf-8?B?STB6YmVicC94NDdFNUxNOGd3U2t0bTVydVlDajNiWDNVdnpiM2VPcXVnNXlP?=
 =?utf-8?B?QXA5ZkNGVllSbzhQaFN1a3JnbmkxM3hkWlNobFpyOVNjUnRKY3NVU3BJa3E1?=
 =?utf-8?B?cDg3TkRiT2JIK3VDTC9udzFhUEZNcEJLTnduMFNyc1pjT2MxbWluRys2VVZz?=
 =?utf-8?B?M2FpY2dodDJzcDlFYnc4dUlJaUtKaEo4MTFmMVprNW5oV1R6ZUNyUDRnOVFv?=
 =?utf-8?B?T0piL3ZGVjNOd3o0SUJsSGNiRnJDVkp5VExyNjZpWlYreFhSdEpTM1JwMkg0?=
 =?utf-8?B?dG5yZ05BazBKUUZFL2g2WjRWMGxObWo0M1pwR0VqVkMvS0dPRWozY05HS0RP?=
 =?utf-8?Q?iGpy230Id+VkkPhGjwy3o7Rma?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667744ba-e855-4638-fe93-08de1001da4b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 17:55:28.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85I8oVteaFpd26JHJwBjWoIK3ISxK4uwrCcmgqT7UdzS1Yx6q5SztlH4EzO+QkXRwsMWeRMmanPw33/d548g0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922

On 10/20/25 8:58 AM, Jan Kara wrote:
> On Mon 20-10-25 15:59:07, Matthew Wilcox wrote:
>> On Mon, Oct 20, 2025 at 03:59:33PM +0200, Jan Kara wrote:
>>> The idea was to bounce buffer the page we are writing back in case we spot
>>> a long-term pin we cannot just wait for - hence bouncing should be rare.
>>> But in this more general setting it is challenging to not bounce buffer for
>>> every IO (in which case you'd be basically at performance of RWF_DONTCACHE
>>> IO or perhaps worse so why bother?). Essentially if you hand out the real
>>> page underlying the buffer for the IO, all other attemps to do IO to that
>>> page have to block - bouncing is no longer an option because even with
>>> bouncing the second IO we could still corrupt data of the first IO once we
>>> copy to the final buffer. And if we'd block waiting for the first IO to
>>> complete, userspace could construct deadlock cycles - like racing IO to
>>> pages A, B with IO to pages B, A. So far I'm not sure about a sane way out
>>> of this...
>>
>> There isn't one.  We might have DMA-mapped this page earlier, and so a
>> device could write to it at any time.  Even if we remove PTE write
>> permissions ...
> 
> True but writes through DMA to the page are guarded by holding a page pin
> these days so we could in theory block getting another page pin or mapping

Do you mean, "setting up to do DMA is guarded by holding a FOLL_LONGTERM
page pin"? Or something else (that's new to me)?


thanks,
John Hubbard

> the page writeably until the pin is released... if we can figure out a
> convincing story for dealing with long-term pins from RDMA and dealing with
> possible deadlocks created by this.
> 
> 								Honza


