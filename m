Return-Path: <linux-fsdevel+bounces-53115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B96AEA746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 21:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450CC17F752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5152EE960;
	Thu, 26 Jun 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wxwm9AfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADE1FDE31;
	Thu, 26 Jun 2025 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967180; cv=fail; b=SpKOFgCjlaBQRPV7VLNou2yMXM25whvD1pfE0NlPvcrGzGVZQmL8v1O0iXGbRjR6S1z5X8sRgXdDV7plGf2qTzKl+ETDUjpMTk9u93uoTAIotaphK57GDjFD2Qd0t1xPIW2g86y78DxVc1dz5495HhVg1Dx6x5MANbjXXVvSf7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967180; c=relaxed/simple;
	bh=TQEK2x9h7EXz4BO2wZpyfSN1NdYHanTFKpFjeITlSp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jm8D9oC4/gBfaxFeK88o8VPv0cPtYCQ5InlEeArooN2bJLtOfvhI+th0KlPeRXboaKz00+Eg0Fjq6XQGME3i2sFji/VrbwqDDy0Rr4AQP56Bg6yRMUiVvki4TEfrjmJ39mTa0WCE2KzAKTzJXStvNko25uSA7PdVp23WR8u0j7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wxwm9AfZ; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyBi3PUWd4CvuCdw4GB4VLFU7NmSNGb+pclhwu2qgmu0GHgRlqYZi8ONWtp0ThX54BbrPFovzwNBp4rldAdxvS0cd80vgUkv5RrdZhgMy80I17UgnUhLI5HT1dDN6C0DW3z1DCYpWwNeAAJMi6XhIIo4zqLB6vczF/x7eb6cpuW50mrmiFXmj6dMeFvQRo4LWr6vZP4Iygl1aLvWwQMuaZNNoZXzF2OFMQEEDD2TalbOacaUui1Gv1zazBOP0hfNxrj7hUrMVcGXlGyQmGpGeLCz9fp/oq5Gs75+yINVyYgtqAdAUXYJqXf9yy5QoiYMJAVHlOqwSiQUnRjS96greg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VozaPxBaRi+mjURQZ6b012lDUl/IDzmyxRss9vw+8dk=;
 b=bY9KdpUy+V1nzCrx7a2B8TAHcMow8MHMwbJy3xxDLGhkb/RMjo2D0tG8Kyf8ofSH6AI3q8TlJGf8WrSqzea7YZ/EoHpjwEy5TtGIVOBu1S3cZQDIB+z6scMFHSxTcPX5qrrVOGMFanJo7MDBPqonPtVuR1ufLeKu2bjh1e8ylEi2hNZvopIQNcMlFIIid7CK6kW4bStpS9fb97K4NSERMDjxBsRhQtXircj0w8o9K+Ej2VF+io7COOw3/a1b7OeAZWa72RMNgNOafHU2uUjvV38Wo3rAIfASAs5xWTnSFKY7VfrQwWhqlnudlcogZWT4lmjUPwCqmBGk5T0DL5mU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VozaPxBaRi+mjURQZ6b012lDUl/IDzmyxRss9vw+8dk=;
 b=wxwm9AfZ3beC6was7voeC0UOIzBKsUb3cEPySgwjgoY3u5/4G98635+2HMmMWvN1XPRtCoAz3dB3XGE76gc6eIW4J22wSLJbLxEeu0f0AqunXr7qMjBEwfEofEcdWuzBc393kBLBkA7XWKf3Si7xa8VUdq+0uuAU6+55eqylkT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by PH0PR12MB8173.namprd12.prod.outlook.com
 (2603:10b6:510:296::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 19:46:16 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Thu, 26 Jun 2025
 19:46:16 +0000
Message-ID: <3fdab328-dda3-4685-b5a9-3aba2a40621c@amd.com>
Date: Fri, 27 Jun 2025 01:16:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
 akpm@linux-foundation.org, brauner@kernel.org, paul@paul-moore.com,
 rppt@kernel.org, viro@zeniv.linux.org.uk
Cc: seanjc@google.com, willy@infradead.org, pbonzini@redhat.com,
 tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250620070328.803704-3-shivankg@amd.com>
 <f2a205a5-aca9-4788-88ff-bfb3283610c5@redhat.com>
 <3114d54f-ed7c-4c68-9d32-53ce04175556@amd.com>
 <39f95eb9-c494-4967-8d4d-9768200637f4@suse.cz>
 <568cba54-dd42-45e9-be0f-53569811f2e9@suse.cz>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <568cba54-dd42-45e9-be0f-53569811f2e9@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::22) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: a45163bf-6c69-4a30-72e9-08ddb4ea1cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDZVS1pTc0pJZnVERTlQMmVtdjV0bmdiRmc2aUlCdzZFYUt1TmpjMENaTy9p?=
 =?utf-8?B?bDk3dXl6Tm9Ud0pXV0hhSzN0MnpHM2d1RGNYNmY4SzZ2enZ3VUUyVjZvR0Zv?=
 =?utf-8?B?Y29EL1NjMnlDeG1sVVY1bGV2Y3ZReGR6Y09Zbyt0R2d5K1dCVHBHU1o2eFdj?=
 =?utf-8?B?MHIrYWs3TmNXNTJtTXV1ZDNqRm9yTzNnVnZ5TlZQekcwVk9VaFpLY1V3VkxW?=
 =?utf-8?B?dFFQZTJCNWthdVVJWGtXUWIxT2ZCUmhuUGZRQkgvV2x3cWppZVN5RlZqa0Z4?=
 =?utf-8?B?Q1A3RzVFSVN0QXhmZXBUYmkwa2xibUNSNm5TODlYUXFQZnFicXpFOFRrZUQ2?=
 =?utf-8?B?YnBrdzlKMlRFT252akpsZlJmeS9sSWpsTmtlNUVMMDJrcXROdE9DbnpLNEx3?=
 =?utf-8?B?ZEFhSkNkVlQ4bTZQQzRNNUZjWDJ1eFRWci8xWDRzVFQ0c01MUkdRZURTNXBN?=
 =?utf-8?B?Q3pXTUYwaVR3VjBQalJXWGhkKytxeVFpd2p1VFJZYUM5cHFRbDg2cVh3WDNw?=
 =?utf-8?B?R0wwTnlpdk83OXFrckg0eXlsVlhYQk5HcFJJZ1Y0YUtqUkx2OFRjZVlZU0pV?=
 =?utf-8?B?K1VsUEtRYzA0aEcra1ZDZUorODZJYzVNQ2xFL0F2N0N4R1g0YkErb29PNloz?=
 =?utf-8?B?Y3o3QXZQUmVhMmU2Mmw0dVcrMTRZa28rYmZkaEtKekhJemMxcURDeEduWng1?=
 =?utf-8?B?VEZ2UVJyb21pZnRrbVhoRS85NWJCUXFYbWM0OW5CWVJJZU9lZDRXK0pIb1k3?=
 =?utf-8?B?TEFOWkFzQjl2QUlheStwYXdOdWoyT2tpK01Wdm1EcDhlUTlLK1RKc2ZxM1hr?=
 =?utf-8?B?MnkzNXdWMkFlRTZqZDdFUXJ2SENvUW9kVkJvN284TkVaOGgzbmUzL1hKNFBI?=
 =?utf-8?B?Ny9OdXhPLzg3YkNSZXR0QUF4ZjFWUzBUWnJpb0lBcVprQ1ZRb1NSVnFuTC9p?=
 =?utf-8?B?dmdRSFZxUWp1UW1ZbjRQQUVSUTlISkt4MXhZMVk5d3dUUnFqTEVIblhkOVpv?=
 =?utf-8?B?dEdHR0dHTFBXUGNDRDVXM1ZsL0ZodGJMOFB0Q1BTSkYyKytRRlovaVJ2aEZF?=
 =?utf-8?B?eDFzcWtRVVk2U0pZUG13SFJlYWNFQmxrSVVTelEycFBWK01qZEQ4dHRNbWkv?=
 =?utf-8?B?U2tCWHJzaExZYTBwdzVnc280OXRaWEN6QkEycGlmTmtJMnFpU1JsUUJPd1hx?=
 =?utf-8?B?RUNSSkZLcDB6cWw4TWwrT2NqRUNPeUswTWlGVS83aHJoV0EwRUxsNWp5b0Z6?=
 =?utf-8?B?TVRlRGpZVkZ4QzM4L3phbUxTUHVUdlhJdmdSRUU2VTZCUlZIamR3NHpYOThl?=
 =?utf-8?B?eEdhcUt5SUxrazY0Nm4waGFYTVFlMFByZ2Y5QzBBRkVCbXdVSWpsNFd3Wlpx?=
 =?utf-8?B?MCt4aGo3WU5tdCtZdDNKaUJXeE1nc1hlUzZxeVJEaHJGR0grR0FzZTZjV0hV?=
 =?utf-8?B?ZU5xNzN2TUxvV05xOTZPaEdzSXUwQWhPN2RxYkhDQlpqYmdvd2lSOXVyMlN3?=
 =?utf-8?B?QStzNDU5dWVOR29NRVByNnh5eVdKQ01pMUhyaHc3Y0ROdElpemU4blNGTXdG?=
 =?utf-8?B?RDIrSW5sN3ZuR1BpVDErSnNMVStYV3ZPdWE4OEl3WG5OSmdoUzllS0FmKzR0?=
 =?utf-8?B?Rm1ncDJqYjdxc1NWNnNGN2pSa0RMWjVNQThWeHN5Sm1LeUNPWW13cTVwdnVp?=
 =?utf-8?B?Vlpwb3pxbU14citrOUU0OXlmUHp1SksrdDlLMUxlNEF2QzZKVTRvOUtudkFQ?=
 =?utf-8?B?bmZlQVJRZDJoNGdHTElDZDRyK1hmeXh0QmpCMWJROU1ldFFmbTlCTnFyN3FI?=
 =?utf-8?B?eWRXK0F0L2JQa1JvN2pFcCtnWGYybE1ZS1Q3YTJJQ0taS3pSczFuaGVCdHJ2?=
 =?utf-8?B?MzhnQW9IT0pFWFVQMFNkbWdXSVcwK0UzeEdtdTBpMnYrQW1zUGMzZHdnNmRK?=
 =?utf-8?Q?wZ2rnOinhOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG95N0EveGpCY3ZtcmhjZ0h5N2dpbStLbS93WXdoaTdWQmhBb0QrZHlRNitz?=
 =?utf-8?B?ckFpd0EvMmFDU3kreWtmSzd5eCtobis2cDBDYis3SkhZRU9DR1ZZVFVaQ0dC?=
 =?utf-8?B?bHdSYWI3anM1UnJPNENtSU4xVEI4SGpUUTY1Z0tZQ0dBM1FmK3duNTlwZjBM?=
 =?utf-8?B?bUc1clF0ejhwSVFpVFhIYmJ4cDc2MWlybHVpSnBocDlXSnpiRW5TOXRWVURE?=
 =?utf-8?B?bGRXenBBNmxPT01HNG5sZWt2cUJkd3pwa2Vmb3dHK0kzbWpLZ1JnYW91aWtO?=
 =?utf-8?B?UXEyMXB0aDRzN2hxWkpyOVV4NG1sSEJTbFhEQTVDWExHQ0lpUzl4cmVJaGZa?=
 =?utf-8?B?NndCUXozM01xMDVQR1VBY0t3VzlKNTBhUE9JUjdHYmpzWjZxVzlzZDZ0UWZq?=
 =?utf-8?B?cDQ0dHZxTTZ2bW43cHd6ZmRJNEh4Vmszd2loNWdjM25pS2RUR0xuR0NBa0g1?=
 =?utf-8?B?TXVsRTRKY3VrKzZMNmdUQU0vUlZCWlZlcUNyaG9tVC9oekVxdUVUWmVkVWZh?=
 =?utf-8?B?L3luTzdLTjVqcWVXZi9xMkhSYldZNEJ6WUZ0S0xSNGFtUEp5VjVhdHdTSDVL?=
 =?utf-8?B?cUxkKy9aQzRHZzBUWDdZYVI4WHpmTEU1RnJWK1Z1VmwwODc4UGZHaWdNMlNG?=
 =?utf-8?B?QXMyYlRxMmtGcGUvNXhMaVl4YytJVUh3VWJha2QvdVlNQjBaQUxHc2xQWmQ4?=
 =?utf-8?B?aFBkVjNZaTBFdGNRV1VtRGhWK2pndVlTeDFCSWFHRnhsUWhOTUMrYzV3M2s5?=
 =?utf-8?B?Slp1YkVnSU9xMHVqdzlHTlNkbUlySS9WK2VzSkhwUmxZNW1GS1Fkc3NYaHY3?=
 =?utf-8?B?SkQ0a0dBYkVuajZHb2g0Z1VDdGY2RmFpZXE5bHc0M1lhUFMxWTBTL0Z1bmZ4?=
 =?utf-8?B?Um5nbWN6RFFkRHNsNEsvZjRLaDVFMW1yRnRJVkhkRXF1SHJaNUJHcm5ybmxD?=
 =?utf-8?B?QmtqdjRBRm95L3dRY1RTMmFLY0dTMWtxVlpzNWRJb2JzQTNLcEJDOUNCa0FH?=
 =?utf-8?B?YUVRNkNnTGY5MWpDVlYyVnZuUTZVQkpZd2JkRFk4MFBOMHZiU3puR3BKMCtT?=
 =?utf-8?B?SkF1MlJJbzV6RVVCemllb3hRWjk4T1Vwei9OWnRucUtXNXo1WStWM3lrK0Jw?=
 =?utf-8?B?cTJOd1pHd3BxTGROYWVPeitvb25lK29uNjhFSzh5K1hXUGozSi9ZWk00TWVY?=
 =?utf-8?B?a1FuUWJKalhoMTA2YkYrY3lkNnZYVEp4djRhWktYMHVZUG9lc0hma0haaG1W?=
 =?utf-8?B?aWFLTGJmZGtycWNIV2xWTXN6S2xpOW9WbjROWC9tYWJaMjNHczhjcW42ZVF3?=
 =?utf-8?B?VXIrSEE2ckM5cldkQk1yWTM3SUYxV0FUb0tMYVlYZ3RJYzFkVERETmpveC9z?=
 =?utf-8?B?ZHJTSDJGcVVyZFF0OHBGbFZoWWFGdFRVZ2xZQlNUaXpiNkk0TGpXNDZxeWVV?=
 =?utf-8?B?SWticE5CTUIxVXpSbm4zTVRTYkRSVzZ2djB4Q01kY2c5c1ZMbllZSnN1TTNG?=
 =?utf-8?B?U2RzV1I5OXpnVjJla1RYZjN2NWFoeWQxNDZDZFVRcmowYlBFNU9hRFlDTDRI?=
 =?utf-8?B?d3FvZHI3VjVvUWJOVi9RY0ZpQzVZdDBJbUpuUHdKZzk5L3pxYStqazBKeGor?=
 =?utf-8?B?VGRqbDJIajhtZW9RZTlqN2RJQU5LQU9hcWxRVDlmMlovcXlCaGhVZ2RiWWdO?=
 =?utf-8?B?V1o1ZGNNTVZDSUZpL2FISWc1RWhvY0EzYnA2ZVBzZEJPQ3MvSncwMHBNRS9o?=
 =?utf-8?B?QlY1WmlUR0hKQjZnY29RY0hVOXVNVGRldVEzdis0Mkl4OTFZQlU5VG9SOFYr?=
 =?utf-8?B?dkNobUU5MW5RYlVlcWVBZllJNkE2NWRCZXdUKzlsUFU1bFJuYWVjVU5Fb09T?=
 =?utf-8?B?bnJRZEhlbU9jeGFNWTBIZ0ZKaE4wNE80Y21nb0FvcHNXcFB5R1UySStBQW9v?=
 =?utf-8?B?WU5UUm5aWjBqcWpzNXkyMUZMelRsQnc1Z1AyQTB2Y1JtV2VOdjFzeGVoanVK?=
 =?utf-8?B?T0x6SWxsQ1dEcEpveXJJb040eDNkUzJzRFNMSUtXYW5FRnhWVm0wdGcxcGFk?=
 =?utf-8?B?MzZaMkxmY080SkRjUjN5TlIvNFVmaFBkSmNEeU05dFRsa28xNHUwaFRrcmNY?=
 =?utf-8?Q?0tfzpaoscVGLesAioUt3+hKqj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45163bf-6c69-4a30-72e9-08ddb4ea1cd0
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:46:16.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwjvse6qviVF7ugmtlEFPr/pSn9QT8sC6rH7k4wKodr/L0RyNobuDLShsX2uq0tlWXnb4MHl0WbdwDfm25zSJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173



On 6/23/2025 7:58 PM, Vlastimil Babka wrote:
> On 6/23/25 16:13, Vlastimil Babka wrote:
>> On 6/23/25 16:08, Shivank Garg wrote:
>>>
>>>
>>>>
>>>> In general, LGTM, but I think the actual fix should be separated from exporting it for guest_memfd purposes?
>>>>
>>>> Also makes backporting easier, when EXPORT_SYMBOL_GPL_FOR_MODULES does not exist yet ...
>>>>
>>> I agree. I did not think about backporting conflicts when sending the patch.
>>>
>>> Christian, I can send it as 2 separate patches to make it easier?
>>
>> The proper way is to send the fix without the export, and then add the
>> export only when adding its user.
> 
> Note: AFAIU either way the new user would be depending on a patch in a vfs
> tree (maybe scheduled for an 6.16 rc and not the next merge window?) if
> that's an issue for the development.

Thanks Vlastimil.

I have sent a revised patch [1] without EXPORT. The EXPORT can be added later through
the KVM tree with the guest_memfd changes. Hopefully, anon_inode_make_secure_inode() change
will be merged by then.

Christian, could you please replace the current patch with V3 [1]? And Would you also
be willing to provide your Acked-by when EXPORT_SYMBOL_GPL_FOR_MODULES change addition
is submitted later?

Thank you for the patience and review :)

[1] https://lore.kernel.org/all/20250626191425.9645-5-shivankg@amd.com

Best Regards,
Shivank


