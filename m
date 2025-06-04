Return-Path: <linux-fsdevel+bounces-50665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47FACE456
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9443A7CDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87C202961;
	Wed,  4 Jun 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LUYcoqHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95643C17;
	Wed,  4 Jun 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061869; cv=fail; b=EB2hanp6qiegl4TWORykLQyxUxC47LxdKdeMX/r8XKwpsN41WTQca3Dm3CrEPDzPsR1XNzdNp8EdnN5jggf+9A0PSsyvcszN5g0ZWIn2M0Gm/Zf+r53I2tjqD3K2BNiIr5vehgOrJjKVACPsJG6xa/7HLiLaaAImf7K8Krg45xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061869; c=relaxed/simple;
	bh=OOTAktXE/81BO0S5rOee+6mX4oTW/b1myS3MeoBbkIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B42qxhSLJOpNLm8qkBv6O0I3aSu/MX6FefwuwPDgRCZsuRiOCTxSkL7DaR5jnwDmcEYvNTFT7fkyTKUUoNNx7uZhwvyERw1MelCKmfLWN8UGrCGUe1cWYbKTOt/WUBcqxD9uc0b/KSrN+J0rWlIdQ1DyPpVU++g3pffIj4roZVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LUYcoqHY; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOPJDRClKeaFoGhjwi9DBaX1FCnHwzodGjnQyrA12uOHhMISMXUF8xeEHjbsefl7easaqadOufWjWgOS0H5vcD/9svrxoFBAqm/DRQ9KGpAQgP9+QU1yfp372t2uysVmCXYqGFeLGQJbgqQuMauN49cByt/kA0Ui3LLuW61bdu6weM96bqmLGU1ToNgJakp6IpEmY13I9Ktq3ZxIYrixwqOT4h3/NU6tTvFoCQJnB1+wJ3r8g3K+5VGN0yVToIxG0FXZLDYlTysijg471nlimn+Xl+Q+f9viO1RpjvtOoLK1qFAXWkCjlgqksSjZnCNdvJgv6X4vyPjSAKWB+MgJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6WVT7ZonISx8YsH0SDre9TfjJaeOgYI90XiutnTJF8=;
 b=J61/L5p27w+F8wnxd1XrZX4E4YadGT08Yt+Iz+O7B+v2OtBOO5oM2u0bp2w22WpXts0FjrZVmPjhQ01dg3alq/yFxziFtMVzSG1UPYQSu1PySP2LeME9byM4LOw1M1pDrGC80XGxcqC8lxAjeZPcbUax+LZw7vMo0ntN6CV47OM6y1dLtM9kSbMHqjarfFeVBrRCn2A+ofZEvMH+wz76bhQLJffxkYB94ZBe/dbLzllG7ipljWNPgtLiEJrzcOmy4NTD3gwZHw5WhL03moGU2vD5XqkwDO4oE4w9a7VLJ+dfh4vqbUt8rmvvTftETWLpyNPVwci2giGLUESWH9rMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6WVT7ZonISx8YsH0SDre9TfjJaeOgYI90XiutnTJF8=;
 b=LUYcoqHYHZITF5Z2+LowPaibHwna9XE/PT/66oBMT7NoWT4SOm2PpVDy841fB3o+L1tX53fSctSs4MQnV37L5oJPQZVLmVUyKLm7uFhUkU1MYAy+PbDoMsAAscAN86wsqrKDuY6kfx5MfSBW9YC3EePZzvQobwJjTQ4spUWuUdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 18:31:03 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 18:31:03 +0000
Message-ID: <e0d8a32e-d11b-425d-bd4b-3d28add3f5d0@amd.com>
Date: Wed, 4 Jun 2025 11:31:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for
 cxl_pci and cxl_mem probe
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
 <d9435456-9ae8-4fbe-a67b-e557e2787b0c@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <d9435456-9ae8-4fbe-a67b-e557e2787b0c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e074024-f86b-4af2-bb3a-08dda395f630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHMybnAyTC9HcXpxa2tsU0VySmNwZGNrUE9tckFidGgwMnpGV3ByUVVDeWhR?=
 =?utf-8?B?NFhGdE0rdlFxbWVKTy9oMVc4Z1FKK3JjVjJFeGlIZmpTVU5vcThaMjNPZ3VS?=
 =?utf-8?B?OTNFcEdldzRwTE1tZjd4SXBVZ0pzQ1loOGpwYWgybC9zTzhZRXR6MWJNUmha?=
 =?utf-8?B?Z2I2Qy93ekczV1pNUHZlaVl0cW1xbllqV0dTT0FRNU5YaW5sQis4RjM2M0Zp?=
 =?utf-8?B?WHh3THdOWnFxZnY4Q3ZaeVlYSGJRQVI2alVXNTFWMERBSVNPT2pLT2l5Z3BT?=
 =?utf-8?B?RE1qbGtQT044VWlpRFBRN0ZadFV1eVRRRDZIajZkcXBQc0ppcHgremU3YThs?=
 =?utf-8?B?WS9IWUVtUHB5N2NERlBHUzdKTUJMMlUxQkZncTg4VU1zOHVQOHM1bWUxWkJS?=
 =?utf-8?B?a0xOSk5mVlFSaHBTM2F6QTNJNm94MjBSZG9vTTY4TWcySU5PZnFkVFJiRWtk?=
 =?utf-8?B?V25EVVZhVnl2VE0xVmdKMDUxY2ZPZU9PL2pyaUlaa1k4RExzZFNOc2Y5d0pF?=
 =?utf-8?B?aTdQYkMybkJOOW96NmxTUXZQVWFhTXB6NDE4V0YzSUo2UnhBOTNGU1JSWkNI?=
 =?utf-8?B?NWJmMnNCczFqUGd0YUYyYmxwWHV2WHY3Y0Rla3FkeEVXUWFMZG1iRG50N3l0?=
 =?utf-8?B?amorTXZnMHNtSEE1czZkQWpwYy9KdFcvRi9VNWQva2V0M1JNQ3AxM0pwcU44?=
 =?utf-8?B?R3k5QThpUUpyelQ0RU5uT0IxcFE2YUNpOG5xK2tRbi9sNVVybUc3c1EvcG4x?=
 =?utf-8?B?Z1hRazlEeGxKME92ZlBFLzVQcDc5S3hvYTIvRHlPZTZOSWhaMFI1N08vcFFn?=
 =?utf-8?B?akRZWDJzV1M4RFN5NWxqRDRkUlV6MndidGxSdmV6aGNWclJZVDZhdGx1WGt1?=
 =?utf-8?B?M0o0WjErUnYxSGZwOCt4ZnU2QXRpcktiUTFXd01hUDc5ajc3bDlvL2IrOFM5?=
 =?utf-8?B?M0hBZHdiWk9xekVLTzJ3RHdudnNib1ZPVmZQWEpSLzRra1UwSEdyUW80OGNk?=
 =?utf-8?B?a0R6eURRK1lVcUFwclZxenYyZjQ5aitmbTB4VXRoUUZaMHQzQ0VQaU1IaFVQ?=
 =?utf-8?B?Umx5RzdyTHo1MU1lRnV0bFJoMStkRkRDOTRFZGl5TWZ6MWdzem1NejdHQStS?=
 =?utf-8?B?a0V2b05KbUozRkluOUc2azM3R2E4VU5aYkN0MUxuMlNUanF0ckhPSGZmSldk?=
 =?utf-8?B?cjlHeXppR1dpeUNmbC9USDVOZGlWLzlIL09oT2h6U1JNeGgvMFhYQVdNWGt4?=
 =?utf-8?B?ZnRwS2hVbUg4TE8wWFIvbXJKTzFsOUxydGg0a3paTmUyUFBCS0NLS0tuQXdS?=
 =?utf-8?B?TURnNHJxRC8xY3BYbUF5a2hqVmFoUDJWbjFvQkNTRmJWOUtrQ3ZRWGthOTdx?=
 =?utf-8?B?bWhWT0RHYmF1SndmNHE5czBzMGlxc2VhM0lPRzFUY1lFWmNxV0lIMGpkdmNX?=
 =?utf-8?B?REkvTjlWMXdiaTU1dkpHQlVOTnBpK1JjZVV6YnV6Q1JXVWJIL0FMejNmQmxR?=
 =?utf-8?B?L0h6ckJLOGczeDNSMElCMVdoM3ZBSXkydTJ6TjFHVktuRVRQQUs2cHdjcEZN?=
 =?utf-8?B?N3kzMHVwRXI0TVk0bjJmOG1yand6cUxTQjZOSlNPRndqQ2swWFgyTmZpWkZJ?=
 =?utf-8?B?VklIbWdkY1hyS3QzRHhza3J3bDhHMlFvMDl6eUNQTmdjVmk2QUVFcDY3Y2hq?=
 =?utf-8?B?SjdTNTlGM2RaRUhLVkRJZktnSDVtOTUvT2FlK2JybXJHOEEraHZXWVJUTHlV?=
 =?utf-8?B?UUhRYWxmbFM1V0I4amV6dDFVM0RQVWVKb2RiNDJSVWJKc1BtNUUyUHFjNDVL?=
 =?utf-8?B?NkdnZGVqTG03eUR6ZmJ5anc5U2VyRmhvQ05NVnJEV1UwV2xmeGVPc3ZhcWh3?=
 =?utf-8?B?eG5nZ0ZjY0lETTVYaFRuTjBHL0RTNE0xeTZtZXRHS0tvUTZGQmZwRFk5cVli?=
 =?utf-8?Q?t6Uhi0cLjPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3dRL1BLb1hOaDRuL3U2ZHBjNDdDT25lYUtONm5vVXg4SHVJUTdXL3U0UnAw?=
 =?utf-8?B?US9kNFEwQkhyZWJNa1BKV041bUhtVGVSbHF0bUFvTVFHMDhmZ0gwRFdHdjZP?=
 =?utf-8?B?Q1pmbmNOYjY2VWxsSHpFVHFsZlAxbDhQL0VzVVNqcDRwV2hzMHd0OWdaWWJx?=
 =?utf-8?B?Y0tGNHA5WGFMQURCa2lxMUdTMG5VTjUrbjl0UEVKM1JZS0M1SHl6N2NUUmpx?=
 =?utf-8?B?S3NVVVdicldUazVhL2lqN2xqaXV2NXlBNk5BVzhESFRjMkIxKytpcE5ML0g3?=
 =?utf-8?B?L2o2MG1iNWpKakhWKy80aktqVjA3K0RDVnRwQ09nMnFjTlNkMDJTRVR6SkZq?=
 =?utf-8?B?OHNWejRGMmtNV0NzV2NmS3N6UzZJT0tGbzFEUGxyY2xMZVFhbiswUGUyTkVD?=
 =?utf-8?B?NVExM3d3ZnRCVjhnMStwbnBXc1B4MzRZZUhTbHU0WnVkWWwwajhnNU9TSkVD?=
 =?utf-8?B?RExMZU5TWUFXQWxiNE04QUcyRFI5MWdoc0NxK0o1aWltWmhJSCtRY21Xc21H?=
 =?utf-8?B?OG1DYmJ6U1IxaFFSMHIrQmRPeFNORXVoZEtxdFNpRVlZMVJqeW8yaUVVbHBt?=
 =?utf-8?B?NEptOGVHWTRQWVMvdXU0SFBWZnh6cWRJUmtMRHV2bWZvUEt4QUlReXZ0RXFF?=
 =?utf-8?B?SElqZTN4QXFLcCtXdHM3ZE5BUXA1cWQybVQ2Nm9BNmE3MXJTbEt3c3VpU2Er?=
 =?utf-8?B?TzFPZGp0RUl5UFMyNEhCOXlHUGdZakcxSGwzVTBmd2FmQmFUNkRjQUxzd2JU?=
 =?utf-8?B?VHhVR2wrMkZwNGtlUGUraXprWlR4WlNHM0pnNU1NcG4yNVVTSzZlNjA4ekZK?=
 =?utf-8?B?SGYzdmp0T1FJVDEzbE5iNVFqN1dWOHNkemVBN1VKK203azdHc2dYREhvN1RI?=
 =?utf-8?B?Nm5ReHFzRjljZ3dpSDFCNkFsSHM4TnhLNE04dXZpWFJLT3pQUEtlMlgzNkln?=
 =?utf-8?B?eEZmcTdXaUNrc3A0a2Roc0xTTVdJL2tFUzJGYmlDSlZKTEF0RTM4SVI3MDZM?=
 =?utf-8?B?c2Rsem1HMXhWR05iMnc0OWd6dGt1RlY4NWdSYVNVeFBkenZZQWh0K1kzYk1i?=
 =?utf-8?B?aERUZUJiR2R5d0NnWks0a2tlSVB4NGg1RXlJb2pZNDRlUXRxTEd4MGNhQU9k?=
 =?utf-8?B?UlkrUkZia0JaalRGbCtYVFd0YXZqWk1leDZUTXpXdElieWR0dkZVUkcxY2g4?=
 =?utf-8?B?N1RrVTVrU3B5dUJTSDB4SFRaQks0bDJaZ0VyQmtSQ3N3cjdjdXhzMFFkWkor?=
 =?utf-8?B?d244THU2cFlLL0s3cmhVVC9BU0NEOVo5WFIxQkgzbEFRaUtydWJVUlN5TVF0?=
 =?utf-8?B?aDZoZkJRMXNQYTNvcnBUWDZnK3ZnMWFJWGhaY2tkRUZ0c3RpZk0vUTdVSFZ5?=
 =?utf-8?B?SmtZMkkydEtEUk44bGRaeU5zTDB1VmFzN1JnektnZ3dWZmZ3YkI0SUF6OGNh?=
 =?utf-8?B?TlZVTVE1WE9CWmprc0k1SlJrR3MyckFMSG9nNVlIckZFOXBub3JyMFNEcjVH?=
 =?utf-8?B?SnhlQkhpWmk5dWlDVkxKQk1MdlV3RHFVLzJWZkdsaTRWTmt1SVBuaHhwd2NJ?=
 =?utf-8?B?cW80WWJ3Nmhtc0ZSOENITWNuc2NlMXFXVklRNHZLZ0pvQnFKZ0czWmRyRlVK?=
 =?utf-8?B?QUJVejRCeG5VTHp0cXNCRW1HL2JiMGNvRFp6ZHhscnBuNXR2dDFyR1h5YzJV?=
 =?utf-8?B?bGNIa0tCK29zWXFWNktIeVJRb2hhOU1uWjlubFJnZWVJT0pNSC9tbWY3ODBI?=
 =?utf-8?B?MjVKK3Q3Z05VdWlMSWNqMUVTYjBwUER0WmtaeXNnTVdKUnRtN0M4Ymx4ZlA2?=
 =?utf-8?B?RjVEZytHN0VMTXY5NEgrb2p6Z2UyQVRPb21ENFNScURoQXM1UjBSelVqQW84?=
 =?utf-8?B?WGNNQkJNaVJsOHJzTUpIV3YrTGh0L1RwVVk5dDlWRXo1U2FJb2VlalV4STBK?=
 =?utf-8?B?eTBBOGdGbGU3WXFOclpjRElBcG0vckVrTCtZSjNrcGM1cW1Temk2WEJyL045?=
 =?utf-8?B?S24wS1cyaVpiNUFLR3JNMEpGYjZRTERqdXRudjljaHVYRm1PRXhOZWFIWlBB?=
 =?utf-8?B?d3V6TkRIMEpaS0xFLzJ2SDY5VlU0eU1hMlUxdVBnRmsxYTE0ODJKRjUwVHNj?=
 =?utf-8?Q?sPBEPdteG4j6HqQHdNckMwQ0o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e074024-f86b-4af2-bb3a-08dda395f630
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 18:31:03.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4LF33MHAr8oBSKWPH9MufYz0PTJgA+7HjYuS6OFf/2iBRScNV4LJy363ZqlQn0vLBW1OODXeKebNTtsyTdT9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130

On 6/3/2025 4:45 PM, Dave Jiang wrote:
> 
> 
> On 6/3/25 3:19 PM, Smita Koralahalli wrote:
>> Introduce a waitqueue mechanism to coordinate initialization between the
>> cxl_pci and cxl_mem drivers.
>>
>> Launch a background worker from cxl_acpi_probe() that waits for both
>> drivers to complete initialization before invoking wait_for_device_probe().
>> Without this, the probe completion wait could begin prematurely, before
>> the drivers are present, leading to missed updates.
>>
>> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/acpi.c         | 23 +++++++++++++++++++++++
>>   drivers/cxl/core/suspend.c | 21 +++++++++++++++++++++
>>   drivers/cxl/cxl.h          |  2 ++
>>   3 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index cb14829bb9be..978f63b32b41 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -813,6 +813,24 @@ static int pair_cxl_resource(struct device *dev, void *data)
>>   	return 0;
>>   }
>>   
>> +static void cxl_softreserv_mem_work_fn(struct work_struct *work)
>> +{
>> +	/* Wait for cxl_pci and cxl_mem drivers to load */
>> +	cxl_wait_for_pci_mem();
>> +
>> +	/*
>> +	 * Wait for the driver probe routines to complete after cxl_pci
>> +	 * and cxl_mem drivers are loaded.
>> +	 */
>> +	wait_for_device_probe();
>> +}
>> +static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
>> +
>> +static void cxl_softreserv_mem_update(void)
>> +{
>> +	schedule_work(&cxl_sr_work);
>> +}
>> +
>>   static int cxl_acpi_probe(struct platform_device *pdev)
>>   {
>>   	int rc;
>> @@ -887,6 +905,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>>   
>>   	/* In case PCI is scanned before ACPI re-trigger memdev attach */
>>   	cxl_bus_rescan();
>> +
>> +	/* Update SOFT RESERVE resources that intersect with CXL regions */
>> +	cxl_softreserv_mem_update();
>> +
>>   	return 0;
>>   }
>>   
>> @@ -918,6 +940,7 @@ static int __init cxl_acpi_init(void)
>>   
>>   static void __exit cxl_acpi_exit(void)
>>   {
>> +	cancel_work_sync(&cxl_sr_work);
>>   	platform_driver_unregister(&cxl_acpi_driver);
>>   	cxl_bus_drain();
>>   }
>> diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
>> index 72818a2c8ec8..c0d8f70aed56 100644
>> --- a/drivers/cxl/core/suspend.c
>> +++ b/drivers/cxl/core/suspend.c
>> @@ -2,12 +2,15 @@
>>   /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>>   #include <linux/atomic.h>
>>   #include <linux/export.h>
>> +#include <linux/wait.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   
>>   static atomic_t mem_active;
>>   static atomic_t pci_loaded;
>>   
>> +static DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
>> +
>>   bool cxl_mem_active(void)
>>   {
>>   	if (IS_ENABLED(CONFIG_CXL_MEM))
>> @@ -19,6 +22,7 @@ bool cxl_mem_active(void)
>>   void cxl_mem_active_inc(void)
>>   {
>>   	atomic_inc(&mem_active);
>> +	wake_up(&cxl_wait_queue);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, "CXL");
>>   
>> @@ -28,8 +32,25 @@ void cxl_mem_active_dec(void)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, "CXL");
>>   
>> +static bool cxl_pci_loaded(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_CXL_PCI))
>> +		return atomic_read(&pci_loaded) != 0;
>> +
>> +	return false;
>> +}
>> +
>>   void mark_cxl_pci_loaded(void)
>>   {
>>   	atomic_inc(&pci_loaded);
>> +	wake_up(&cxl_wait_queue);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(mark_cxl_pci_loaded, "CXL");
>> +
>> +void cxl_wait_for_pci_mem(void)
>> +{
>> +	if (!wait_event_timeout(cxl_wait_queue, cxl_pci_loaded() &&
>> +				cxl_mem_active(), 30 * HZ))
> 
> I'm trying to understand why cxl_pci_loaded() is needed. cxl_mem_active() goes above 0 when a cxl_mem_probe() instance succeeds. cxl_mem_probe() being triggered implies that an instance of cxl_pci_probe() has been called since cxl_mem_probe() is triggered from devm_cxl_add_memdev() with memdev being added and cxl_mem driver also have been loaded. So does cxl_mem_active() not imply cxl_pci_loaded() and makes it unnecessary?

Yeah you are right. I will remove this check.

Thanks
Smita
> 
> DJ
> 
> 
>> +		pr_debug("Timeout waiting for cxl_pci or cxl_mem probing\n");
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_wait_for_pci_mem, "CXL");
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index a9ab46eb0610..1ba7d39c2991 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -902,6 +902,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>   
>>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>   
>> +void cxl_wait_for_pci_mem(void);
>> +
>>   /*
>>    * Unit test builds overrides this to __weak, find the 'strong' version
>>    * of these symbols in tools/testing/cxl/.
> 


