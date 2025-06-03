Return-Path: <linux-fsdevel+bounces-50505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B56ACCAA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8434B18882D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DD23D286;
	Tue,  3 Jun 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BOgOnPjd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10862C325E;
	Tue,  3 Jun 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966132; cv=fail; b=XmJr3BJMCs1IkUgMRLqEAVu4khpUSOB6Mj0LJBQ4uj9wNo08yOb+Xlym2jghZkxYumxdqpbb/OUQEHd5CkPFOJvbkA8AdowFcOI/UJea5m54L3hoQ1HZEevos2a9nuckPqLhmnorZZRoGVWdJ/icKQnrBOC0DjJxQzGSEX+x2rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966132; c=relaxed/simple;
	bh=VDxxOvzqiRZI4C7sO+ClFmRGC/euLva5tpQ1xWqDnrQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vd75ynByHUpS2ACDbnelms5zqfoU4oYmuQDNgth2t3KZhQp3kntDZC9YphswpbY7A1y8pXCGaeDottWXQyNePLQGNojxvsSCDXwKn3n1hAM2dDJAEYStD40JqdITvNDJH3mevoAi3qhr1mLDB623z9OIvsGj4APelDvefgqwKXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BOgOnPjd; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFLd7ZpknsVQOYfl4tX+ognWG51EIh6WJ7KD2Adp3NIq2DaSj7z/giN3bU1DfuqPskOrxATRdtbgz7GwRheoTislh7KhQGQk/A8Y41JiUnNGwnhaPbgeu4kuCapq/UDpGVFbwJ0DX/Oe9eK89uQw8RqntHKcQBoR1/esf0vVUvYlYcx7oOiEkyxP3Ie8kmSYMSrW7sU5k2aBsVkmMw4601cl7GLhjMVkni+rbK172OZvaJsI3ZjSwzmp1TiL8SPStrXj2EW9x27oI1JnUUBcTvykOOmK1L3cua0BLbQBYbTQUkTKdFeQD6HktrlK9wSuXjHGRli89W9wjciORyfBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhN6OtR2DNkChZ4eUPzc0cWptaMdyaPqDpYFDNhkZY8=;
 b=zN52+M/cWcw/LBYM/h46RxkHiA1z3W6wSkMm8HqqoW9AnfygEVhp8pF9EcEbAshISLObDxBcZUXCtJun+L98A8Jv8LKiozyLM94Fy0uXDWOqJpoHNdFd2Z4pylAn/BpIVPBHoLCSxmlAr+LNvQauFzZXLetH/SzdnHoiEvGXXY5BsosnqtSQtcqU6lRXPYZc6/uurMfRmQLq9Ds20gIxu8ppYEF/geOcLgez3vPP03JVBeWDTUjXR+Gr84wc97lo6UrVSsEEBHNHCfk3puT99NGv8yLOfIGv83FWWcT1UbtZVuH7w+2PPZtZVby/4WcwqCXXxmvHUWnOlYpKtmBupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhN6OtR2DNkChZ4eUPzc0cWptaMdyaPqDpYFDNhkZY8=;
 b=BOgOnPjdUZbB5N/isifqnNUJqdKCH3ymyewceKt+fG8ycdfANF6UKOd6u8c0n7GFtjqKpbbjMVvD1a1Lr1qIf4KMXSsh7MobeXFO/caUnWtL1MRnVT0FpPqYxvj7eXldXLDUN2ZdbD9fvS9VTKlNpK1KuoxsrvTH//EkKUszrRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 15:55:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 15:55:26 +0000
Message-ID: <d1937343-5fc3-4450-b31a-d45b6f5cfc16@amd.com>
Date: Tue, 3 Jun 2025 17:55:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
To: Christoph Hellwig <hch@infradead.org>
Cc: wangtao <tao.wangtao@honor.com>, sumit.semwal@linaro.org,
 kraxel@redhat.com, vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
 amir73il@gmail.com, benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, jack@suse.cz,
 baolin.wang@linux.alibaba.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, bintian.wang@honor.com, yipengxiang@honor.com,
 liulu.liu@honor.com, feng.han@honor.com
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <924ac01f-b86b-4a03-b563-878fa7736712@amd.com>
 <aD8Gi9ShWDEYqWjB@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aD8Gi9ShWDEYqWjB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f79322-bfe4-4a53-e8b6-08dda2b70e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW9lUmpWMk9LQWVqZVdpK0QzSWFPQ1BXNGJVN0hERWo2NkRES3R5TUJFRnFs?=
 =?utf-8?B?NXhJK2VHWHlOY1R3M0FkMStLVVgrZjJjU3E5bmJJZ3hmNnBhZ3N0ZGIxZWxN?=
 =?utf-8?B?WGpqRnZTVDROaXBLUVphZFBEMkRQSUR3YTVKRWMzbWdKUW5oR3MvMDBHdktD?=
 =?utf-8?B?M1ArcVBQUCtRSktFL05FdlFLbjhJZWdHSVZDa3dETFVjb3l3WkYyVFZrZ0JU?=
 =?utf-8?B?dXpRWGhtYVBNdTJFMTZrYTQvWlpidGNEMTBGYXB2SmsrUGtyVm9TZUQwZ1Z0?=
 =?utf-8?B?bUFiMmhLaklLUWh1YUg0MjdGM0R2azdDeld3bEtWcld4dWRFNGIwM292c0Mr?=
 =?utf-8?B?WjFsZWxUdHMxZWhJZDZKekp3RHhJVVc3aUFpdTlWYjd6aHBJLzhNc2Z4Qzgr?=
 =?utf-8?B?S1RtRzExRjFoak90K0hEN0FHNXJzbTEzRWhId29qNnVRU09nNFo0MGlETFYw?=
 =?utf-8?B?R2NCM05CZHdIVnFvVEI1alFKdWZ0WDBPUkVKZEdrMm5mU3IzMmFLQTdVOGVI?=
 =?utf-8?B?OU5XbXVRYjJrMFd1a3ZHeVBrMnBydys0cjRCNmd3ekhNdWJLQ2F6eW1GSHp0?=
 =?utf-8?B?VTVHWXRjQ1AvMCtWUy9SWElDYmkrVE0wUW5FUzl5Ly9LenRoTG1WV0tRclo4?=
 =?utf-8?B?VkY0MElxSHNjK0xha2ZsSmdUNGdyWHI2UDFHOFR2em5uMmxTL0E5dmVJR01U?=
 =?utf-8?B?RVZZRTBybFZYZ0FSVG1ueWVLTDBOUGpLZ3BQQXNVOUI5WkY1akJPTVNnUncx?=
 =?utf-8?B?WUdQRzIvSXdpaTlIdWNCM3o5S2N3ZFlUdGMxRjk3WTZReStWMTBveGR2aE11?=
 =?utf-8?B?ZCswdTdBWFU3elZ2UERFVjlnOUtsR1FLVkNFa3F4dyswK0JjMDdGcWYzY0JT?=
 =?utf-8?B?L0trdmtQNWdtYlg2V3c0VVRlMWpnRmJnbk0zY1hyL3BhUTd3K0pXY21JSDJJ?=
 =?utf-8?B?MDhTS3RucHl1S2l1YW1UNFUxOHptd0o5YzlyVTZsSkJlWW9pbmtMcTl5QTRw?=
 =?utf-8?B?b3RNYkgvTlhCdmlSRzVGS0tmMzZzWklDQTVyclF5Mjl4ZnJhaE4ybklveHRS?=
 =?utf-8?B?cmhFeCtob213ZmhXcFFaaDFHN2ZrWFIvakNwRkVKcU1VLzl5T3g0dHBkNHJl?=
 =?utf-8?B?aERFT0Y4VU1EODlRVlBjeEpMaEdhdzdjQml1WW9PckZwYjNYWUlWblc1MFhH?=
 =?utf-8?B?dzBvaE50bkZPMnpXT2UyM0RUK0NXY055TEFnQzM1QzhVTXlHSjN4dFphOXNH?=
 =?utf-8?B?b2s3bmxyRERmamV2TGsxVE1ITE9raXBUQmpvbCs4WjRMc2dQUUJqWUhUNnll?=
 =?utf-8?B?aG5TOWtEYzBoTTNFeXYyUmRpUWlRbTQrVjFhQjFBZlRXNlhybHcybENSUXVL?=
 =?utf-8?B?T2xuL1JDZmJqeW5zTjN2V0QxQnlmNkZjNUNnbnRwZk90b3RNWVBOR0J5Q3VB?=
 =?utf-8?B?aG9NR084S1ByVU5rbEsvNDRXY0c4TzVKTkMyMHh1ZVhLUVZsdkpZREJXeVhY?=
 =?utf-8?B?amM5N3F3a29xY2xhRzJ0UlIxL25MamVDTFJ1V1djNWIvaGl1Q0F5OU4yVjRw?=
 =?utf-8?B?QzNqVDlONWhrRHJ1eS9GRGlqenRJbEJ6RnJ0SkJ3TWVCMkxHUkZjZkRadTk5?=
 =?utf-8?B?NHMyNlpUQUNWL3ZQOFFhYmtYU3Qydk5xa3JkcWRIWDhxYXlzNStFekk4YXFs?=
 =?utf-8?B?eU13SFNCaXZqZy9tZlJlSHk1RjNJaDFSM2ZwUWtHcWpWbDRpaVhCbi9VNUhm?=
 =?utf-8?B?TjNYQlM5SStGcVhDNFlzWU9ROGorSGtNc0VaSGc4VVhxUGx1TExqUWhnMlpk?=
 =?utf-8?B?TUhiRUJ3WEQ4K1V3V1Fya0RPcU13MmJHZGljRmVySGw4RXBCMVNxTEJUMUdj?=
 =?utf-8?B?K0ZKRXBlbkpuSmU2eHo0cFoySTNjY2V3WGNMbkNxZENDUG5XZENndWh1ZE11?=
 =?utf-8?Q?XE3tZgrUPL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnZjdzdCVmdwSTRYNkg4emVRTFJQYkM3SE03emJMVkdocElxSlZzTjVnU2lv?=
 =?utf-8?B?Szh4dlFyRURMbGRvZnZHOTN2S1V3NVBZd29EcVFpYkRVWFRRNk5LampQTDM5?=
 =?utf-8?B?WE5RaWxVS0NNM3NMWWRVRFFoU004aHl0VzdNdm9CKzlKNUh1VEwybWtmdU1q?=
 =?utf-8?B?SlZ6L2tuZ2I0SGdqSTJUYVpYbGlEd0ZGSHlQMTJTanlsTWhVM1NpTHA5TGVa?=
 =?utf-8?B?UWY2cXJyUHRzQkpJeWNrRU5RMzJIV1pBR0o4MXhGRHdvZXVyRmc2SHY1anFk?=
 =?utf-8?B?SnRpOXpOclRueHUxTExndTNZNEN2c2FnRXFXVHcvWlBUeFhMR21XMnkzbk45?=
 =?utf-8?B?VXhpU0d5YVI0NUFXd0YrMU9UTXlXVmhYUUxOQkRIeCs5WkUzVllyTUltMjQ2?=
 =?utf-8?B?bVhxb2VpRUx2MUZNZTBjWEFkUmE3Z1o3d0J3cm9TeE5XUG9JNWZqTHV5MEtk?=
 =?utf-8?B?MkpWSnBxRVJ6L1cxKzM5SzR1dHlPNWcyczZuM2VzdTFIWHR5UmpJS1U1Q0hL?=
 =?utf-8?B?b08wMUMxZFRic083NnlPU0xkZHJrRy90cGtlcHBXQXBzcVUyRVl1MTRnNkdi?=
 =?utf-8?B?VlRyYWwxMHJKVUV5bkdZV05EcE9xbUxKTlNUL3k3OHNNV3hGUDVrcGtMeDE5?=
 =?utf-8?B?TWxVU2ZlWFVoc2YxSEpuWkZEZUx4U0MzQVRLTTRpckJ6cmdsUWV3RGJMNVZl?=
 =?utf-8?B?UldQTVRXTGJzUDd5R1BybTducW1EMVU4SUxSL2kyK0Vqc0xnSmlSc3FEeklJ?=
 =?utf-8?B?OENBalBySHF6Wk9NWUgrbENmZ3JEOTBPZFhZejBrLzFMWFFyUU8xOWxxMERv?=
 =?utf-8?B?VVFHZ0RGYTlJMXhLdG9Jb2xra2ZWQWhKUHRvT0JtRUd4VzgvOXI0N01YZzBI?=
 =?utf-8?B?aVQxSU04Mi9heEFyeE1sdTVQbVZ0d1lWVHJqWmZxUG1Dd0JmNVhRMlZ2eitx?=
 =?utf-8?B?eUZ0b2ZJWGJOOFh2Y09rUHE3Mk9uWUttNW1qWDBTMzdZeEhyRzJydnE5WUFB?=
 =?utf-8?B?TVNpRGFtalJXQkx1ZmR0TkM3TjhGcjN6d29ubmgyNzRPam55RFZlTjNYQnAy?=
 =?utf-8?B?amlxajV6YTRvTDIwMG1vV25LUVRFOVBwTExkN0pQRHQ5Y3pKWmRhcEZ4VExp?=
 =?utf-8?B?ekFqd3VoNmZTWVVOblZ6ZEVOVkNTcFFWazV3V05jSm5FVDhBVW9TRmkwSFNL?=
 =?utf-8?B?bUt4aUUxNDlRWG9WNllNclBLNFBSNVl5RE1lWjBZSXl2Q3haT0tvTW5RWDls?=
 =?utf-8?B?cHJ5c1gxamJEQk40THFYSC9JeGtYeTRyWkZRdlFscWJzUlk4UWFENUJWZEZx?=
 =?utf-8?B?czZWQ3lZdm5RazFReThtL1g2OWlROGp2aFJyNnR1cnVSRm1qUkU3MzBBTmt0?=
 =?utf-8?B?b1dEbUxUL21zSGxsN2ZtNnBNWGNwd2V4dXhlK1ArYTh5dEoxY29wdy8xcWpo?=
 =?utf-8?B?T0dhZGxRUWJkUXE4WVhyakhNQS9OeE13VkNOa1A4Z0g3V0p1OGNEVG5TU084?=
 =?utf-8?B?cFVMM0sxUTM1YWE1VnZCTVhBcDVmMklxZHpJZ1RnODhoYjM0VzBKdFBWb0x4?=
 =?utf-8?B?ZjlRUEU5VEMzMWtIQ2VUUDltVXhmM1dDcExSR3NxaUFWWi9TWnk0eHpUeEZv?=
 =?utf-8?B?b015aGhDRk8zdUZQbk5UVG5USVgzSDBLWlBtODcwYnowTHRPMmZKcEtBTGtp?=
 =?utf-8?B?R2hxRmNwWVN5cjZ5QTA1eFFpTElMcVJZWlZkMTJGL3FwUmEzK1VPZWdwZ0xo?=
 =?utf-8?B?c0d3Qm9jc3dxWTNmclZQRFZIV0xLb0ZxalNYL3BabURKcGpwVW9mUWV2SUwr?=
 =?utf-8?B?bGZpaXc2dWlMY1FJNDJNejJOcnpBdEVpaVIwcFFQRUt1eGFwMjdaSUY3Ni9K?=
 =?utf-8?B?SThUeFBBNjcrMUl5ZUR1REVZUDFvWHlnN2xEZmdEWDJXcVhBOXZsVEJiOFdV?=
 =?utf-8?B?aXRmeCtpbm9YNFZpVjVqZjRTWkJ3dDRaWE9BVDQvR09rN0JJMm80VW5LNy9E?=
 =?utf-8?B?TDAxUVNHdXQ0ZlQ3cWtvdk9YV2pQUDd5Y0VtVEphK0dWV3hyS1p4VjE5VDly?=
 =?utf-8?B?V01zUENhd1UweU9uemxCTXA1bWdEQVdMbGQyUnhJVUZuREpYVmdmbmtrcFZ1?=
 =?utf-8?Q?x7stdCFXvanN8Nj27UMyNFubU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f79322-bfe4-4a53-e8b6-08dda2b70e6e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:55:26.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03/WtGQEDuoBjhlEc7sz18vTVCp82IvYY4QrdQrBjk657IEKpTT6ef2pcW5kstwp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406

On 6/3/25 16:28, Christoph Hellwig wrote:
> On Tue, Jun 03, 2025 at 04:18:22PM +0200, Christian König wrote:
>>> Does it matter compared to the I/O in this case?
>>
>> It unfortunately does, see the numbers on patch 3 and 4.
> 
> That's kinda weird.  Why does the page table lookup tage so much
> time compared to normal I/O?

I have absolutely no idea. It's rather surprising for me as well.

The user seems to have a rather slow CPU paired with fast I/O, but it still looks rather fishy to me.

Additional to that allocating memory through memfd_create() is *much* slower on that box than through dma-buf-heaps (which basically just uses GFP and an array).

We have seen something similar with customers systems which we couldn't explain so far.

>> My question is rather if it's ok to call f_op->write_iter() and 
>> f_op->read_iter() with pages allocated by alloc_pages(), e.g.
>> where drivers potentially ignore the page count and just re-use pages
>> as they like?
> 
> read_iter and write_iter with ITER_BVEC just use the pages as source
> and destination of the I/O.  They must not touch the refcounts or
> do anything fancy with them.  Various places in the kernel rely on
> that.

Perfect, thanks for that info.

Regards,
Christian.

