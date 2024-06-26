Return-Path: <linux-fsdevel+bounces-22484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7C917F72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C571C21EC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019317DE1E;
	Wed, 26 Jun 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nU03CrAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEAB13AD11;
	Wed, 26 Jun 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400758; cv=fail; b=Yey89nKP707xuhmmimW64SwtuBWj6YxJxVtkS14GYbEWFkj4lXFZLMCzsF6JlUx6a6Qtv2FZ0G43l610OjlfyoczV7p1e+e9tpxupdg4hoicqXpIOwmx1Ssb/tNbafbj6moksOiwheBeopNwY/A5CKxSMcdtf6T31FXRYkPfd4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400758; c=relaxed/simple;
	bh=5r2g4VT+oaK7m4tretpi7MwTdtZQvpmifk0JQgAozUw=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=E4bma+JfWXyxxneQx29/vjrap24bgWUHun5PGZy72zq+h37vF4VzieIAqKK4sQbHovYozLNs6UCQDaJYntzZtpHfiWdSKVnRC6G96ReiUPTz3tXaXsOn99U4lgtkZYTpCa5j94k1mhY601F5UzEQdaU+K//aBhquR4cSp8aM4Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nU03CrAk; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=db//jm6t5y3lLckvjRdXe13WIPktH90rQz9MOgqB6sdrc3p0Sc/NZABIBy5P5rdVUn+YPeD3+pO9gRdP/cX7nxOCwonSS0QFaHNzja0MJhYXwwXrNhWlALO9iDKbOEMXVWKR5hAQy1UTQEuuzK+XXBruTTjUoUkPsGOcEJr5d0Vg4jun+auOAm/RVYv/FBK7OLzr83V3VIYWXpycATJGx/jJ4h8Zxw8mQCquqQAjetPNl43b55sonmVGEmHc418c7/Gw9WViVtsmCH46ox9WirTvySi7CHjOsk40sAnOX5rU2akFCedOLDjKqa85ZMfLAuGszOz3lnsWiqq0iL64sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq1A5eE9JGkYqNIPjhMbS0E311nvqkD0/z94AtDUG6o=;
 b=G4C7Lw7za2U/3wj+XqJJ6Wpt5gydEQuYY8fNes+8IHsHUS/5gO7L7I8got+0V/FPn43/9wtruF8nJ5dGiQLs89m8zbFronwrL2m+rEDR1M60Bvk6rop1Wjc0xJTwhh3AD7upOiC8URRYM8KU8ku0ohIqIyE3PfdFgddcFPJAcgKL831bDlxMLTJxiWgpwfgAOzdq/Kf/XBLGVya8CKt578eTNFNm9SmWQMUJcHU1yj2xxoo4Ejc5bZ5GoH1r+yUAri6rvzotpmkG4bMp4tB1homrJEhvHOt8IaKSMZnKRy6JRJkq5NNHKhkD+MhCsUSw8iud2walaHKKYiVgQFiL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq1A5eE9JGkYqNIPjhMbS0E311nvqkD0/z94AtDUG6o=;
 b=nU03CrAkSet4PWObOwd60dMnnc4Hy3XjFDFlodaZ0fNq9B9SzWre+dgK+oGQ3bvrFHW8B6ihbOz8YAd8KC7Vv4U4Xn7q23M3PVZnmTFzanoc3Jl4LO06FFOZK29tOooTokz4qW9Lta5cT5kPGFG1JhPXpME2uq8NVTV4eenO0dTd5ivm1v0o5HgbTBDT1+HuyH/yqIC48b9b7qoPysvVVmk5t12lEF/sRxtxSiL8KFTIuk6ukBxC5qlA5nf6V+SKvZNk6vKeQz8P0EmZyyLj/KRWvUtIA8pG4f+39caYTP+pKCenBtRJzwJiBBplqc/uZuLQk1Fbyk7Oiz5hjfSFoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 11:19:13 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:19:12 +0000
Content-Type: multipart/signed;
 boundary=37da5ace343511f7224c33adcd545766c7d9811109edb023769814f7ff3a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 26 Jun 2024 07:19:10 -0400
Message-Id: <D29WP4G2ZWDB.WBZKGKDS93LH@nvidia.com>
Subject: Re: [PATCH 1/2] mm: Constify
 folio_order()/folio_test_pmd_mappable()
Cc: <yang.yang29@zte.com.cn>, <si.hao@zte.com.cn>,
 <akpm@linux-foundation.org>, <baohua@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <peterx@redhat.com>, <ran.xiaokai@zte.com.cn>,
 <ryan.roberts@arm.com>, <svetly.todorov@memverge.com>, <vbabka@suse.cz>,
 <willy@infradead.org>
To: "ran xiaokai" <ranxiaokai627@163.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <D29MAAR3YBI6.3G6PVIR1SJACO@nvidia.com>
 <20240626043010.1156065-1-ranxiaokai627@163.com>
In-Reply-To: <20240626043010.1156065-1-ranxiaokai627@163.com>
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: ca319079-4d61-45b1-64fd-08dc95d1ce88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UW5YWktHSjFqSUJoMUUzYXdXaXVaZHlQVjQ2ZHREREZFRithVXgyVXFCU2Za?=
 =?utf-8?B?NktEQVYrTU1EdTRjNTR4Q2hYQnBuUFYwLzBjK2NoL3lDTGxxbTZsaE5JU1la?=
 =?utf-8?B?MXdLYndHRDRpNU9VSjNYbFBjZXV4L3djNjFpNUJVYnB2cEVYaktTbmlBUFdG?=
 =?utf-8?B?ZThITzJnNC92M0UreFNKQlhRR3N0V1VBdmZyZVA1YUYwUUx3cXhBaitkYndN?=
 =?utf-8?B?UWd1MEVzRmp4M2R3NVNIaHQzTk05cEpTRlp0QmpmNm9Ld0dXUURncXVOYzJK?=
 =?utf-8?B?YXNzVnQ5bVoxdHRnWThFRitSdE1iRmlNYk5OU2E5eW5kQldyakFyeDE2MzNX?=
 =?utf-8?B?MURnVW0wUU9RY1M5REdVMVh2S21hVUhYQlFyOUF1WFJYcnRmdmkyM2MwRnNa?=
 =?utf-8?B?STh0SHFCUjFiaEVLMnYyQ0M2Yk1abU5ma2tJUWh4dlZENVBJQWtaeDBYRWFH?=
 =?utf-8?B?QkQ5OHBZNXJlYTRQdTF1SzNRQ29pTG5pYWtVM3gvUUVMN0J1SmlhaFpQYlZq?=
 =?utf-8?B?em1kWHd5TDNZaXBTNStQdkdyNURwbVNiUjEwdlE3MlBzMnhmOHIxTlYrenlq?=
 =?utf-8?B?ZlEzQkNkSkc0MWVlUk9HbzY4bFdYd2xFeGVjcDc0bk0zb2RqWHhtZlhIQjBy?=
 =?utf-8?B?bFpwV3QvT1NzeGttdXl1Y2p2K3c5b0xtWmQySk1iVDVKMjBWYklxYkxsb08w?=
 =?utf-8?B?dnBBbkhHTkUwYitVNTdKaWpXOXRVRmQzQVkvcitTbGpsQ1NCYzlCSzBEUW55?=
 =?utf-8?B?RGpIVDc5OGhsVWtHanJtOTZIZWsyajlNdkRvYTdjc1M1S0FsbUJWUjJJb0M3?=
 =?utf-8?B?eDRla2dSckJBeGtHS1VpSVJlQmJ2emxqekpNcjRsbzROclIzLzBOVkJMSjRh?=
 =?utf-8?B?em9kWlNFbTUveENWMDdQK09aam5hQkc1a1NLM3NEazBSWGtSd29rNG5HTHFp?=
 =?utf-8?B?cHh0VGZIdDd4bEc2b2ZCWUFDMGtMV2VRNnJlN1liWFhlVEtZWFRPbVNMY0xT?=
 =?utf-8?B?NTAxdWFiQ1o4RU1IODZTYnFsUnhKZ25lTWlEVlluQVlkbVUxVFJxTzhlR1Vw?=
 =?utf-8?B?a2szYTJZYWF6U1lDMVg1dEhobURhWUh0SG1hQ2JGRnZRaGVTYzlSZUlzTGZF?=
 =?utf-8?B?Sm94Vk1RMUNQQ2pUNmt0MGt6T1ArRlp6eVZocVhXbnhVZUhxU1pqYTQ5bXgr?=
 =?utf-8?B?S1pIWTN3dG5lYjFTaHBEK0p4dWpabzZJTnJBYmk4dlUrSDBkcUxuaWF5dDAz?=
 =?utf-8?B?VzNIRkFqMStiMWlPQlkvdmlGNUI1OE01R2cyOStNa3pvNEtuQkhJaTRKdUVo?=
 =?utf-8?B?ekJZTUhwMm43R1hlT2M0Z01keEgzWUlmSzd0d3VTYVUweE5SSEM3Q2VkUEo0?=
 =?utf-8?B?UEo0NWh5YVN2bkdEbEhkTVBqcU9JUEtxM05LUVVObTNpYXhxalQxU1RQMGw4?=
 =?utf-8?B?eXAxVmZxME81Um0rOVVOREJWYXpGY0pFZmNkbXB5MlM4OTlkQUxVbjhkYmVk?=
 =?utf-8?B?SXNEVmljSk9taHVTRFQvSHkrSk92eWtrZ1Z1UXRGRGk0WktQY0ZETGhEOGFm?=
 =?utf-8?B?VnpoYlNRak9kOWZGSU1XZ0VZVGxqUUFmTy8wbnp5eW1ScDJpQ2kwMVV6RGVO?=
 =?utf-8?B?TW1TUXl0VXFpaGJKRFRMdHFEbjFFaHpmUlBiSmdWdktkbVFvQzNhNWFwaFlW?=
 =?utf-8?B?dWlpQVB3Mk1FenFjMlU0ci9UbTVaM0hhL043VU96T3NtN09oOGczZGVMUkNv?=
 =?utf-8?B?NHBtbXB6dUF4Z1NnS0VJTnFvQUhaaWowMmlSS251dkxZM2pnazFCOVU2bklu?=
 =?utf-8?B?WUhkbi9HcE5oWFBvejdBdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnAvZmRVdElPZ0JYZmJGbU5JTEJmL3NqbnJ3dHF5UDRNc3RiS3FuZUNJVmg4?=
 =?utf-8?B?UTlOMjJjY1N6MkdmVE13NzBwZmsrVStZNGhiVDFtaGVuVGN0WGdxL3I4WHVV?=
 =?utf-8?B?eFdvbzlBL1MrV0hUWUF3RVZwN3pmZDVmQ3o3cFZQdFZ3ek8xc3p4M1hSdE0v?=
 =?utf-8?B?eUpUS2NYWG5ObldpeUdZdlVVaGdtQTFnc3pTVzZEcXp3ZXFyUmtvRHRob0Z4?=
 =?utf-8?B?UFlTRFNFUU9tdlpPSEwrT1UxMG15dWlXSkd4ZWRRSytQUnlVYVk0dkJJaGZS?=
 =?utf-8?B?bk5VTHZSbTdvYTlNM2greDNRL3ZLeGFOWlFQNVdGNlZkOHdTcXFqb1lsWGYr?=
 =?utf-8?B?L2JEd245dGhtbG50N2JOVDhoa01RT3I5dkhBZG1RbUEveG44RFRYVGJlWVFG?=
 =?utf-8?B?MDdQNHRDT0lGRWhXZTRmcmdXditUMDZRVWRKSXNTbnlIRk9Tb2phR1o0Y2Jr?=
 =?utf-8?B?R0s0VFZwOWJWY3hqaWwrSTZUOXI1YVo3SCt5M1l4YzliT1I3dFhKWEtGeUc1?=
 =?utf-8?B?Tm0xazU2ZkwwNWhmeVZ6K3dDM0dVdTNCamUvUWN4UERTd2NIZHdPZy91bW5v?=
 =?utf-8?B?T0JRVVlhLzJCNEhoakdPSWVsTTE3ZTZCT2VCbGsrUDhXOVRYS0o2Yk0yZ1Jy?=
 =?utf-8?B?LzZLaitZdXZpb3dmam9ZVWJNaW1jNFp0UnlwcFVGNWlGZTBMNlN0YjdQK01N?=
 =?utf-8?B?WWt3aEhybElUbDJlUVhyY2lmV3Q0WjMvRlpTOTJQUjRLdmo5M21MNk8vYUU5?=
 =?utf-8?B?anB0SkU0SFZkQjZLVjRXQWt2TVhicWkvQTJ5dVYwVkJLbWYzU0lpQlR2MEJE?=
 =?utf-8?B?QVJ5YktWVHZsd1Y1Yk9zZVBVdERuUlBQc0VuK3MvN2NubTg4OHBoN1dGVCto?=
 =?utf-8?B?cGVYNVN2cTgrbDlhVi94VVhJV3YxUVRyVE1ubWlLYjNyZG9qaS91dUdaSkJL?=
 =?utf-8?B?Rm1RbVVzdTZ4ZVY3TUV1U2JwQUJONnJBVVBjdjZDL0ptSXZnQnUzK2xzZnp6?=
 =?utf-8?B?NnA4ME5WaE94ZEgzNENtcU84MFRwSHJGTFR1aWVGZ212bWMyS2s3Unp3MTJY?=
 =?utf-8?B?S2hYZFRNTjZXcnp4bjIycElUQXB0aEpUZVdValdnRjllMXZ1SmZGMUNIbnR5?=
 =?utf-8?B?dXlpcWpGUDBrajZCeS8rMGk5eUt4cFNmRkI2UEMrdHQ2SDVxbEpNMHZsTENo?=
 =?utf-8?B?WmYwQnV1eVNlSXhVdEMwaWhBMm5sRXFKbC8wT2xPUkM2V2VXUkRpQzFsQnFZ?=
 =?utf-8?B?Ny9DbHFJUmdDbFBuY1RRMVVMbjZpeVFqZUk0bCt1ZHBjRy9GQnIzakxqMjgv?=
 =?utf-8?B?ek4waCszOVNlSTM4L0xxNHFOT3ZXUFg5VXllVUtLMzdueERrTm1vT29LUG5C?=
 =?utf-8?B?d0RHR3ZaLzROWDlpTVpCd0xFZmF3blhCVCtOVEU3Ym5zV2REeHpYRmgwdDdR?=
 =?utf-8?B?U2E3QmJyRHQxN25zVmpwUkE1cUVzaE0zRmhFM1NENGtvOGdJQ2xEekcxZTdk?=
 =?utf-8?B?cTduZEdINlBaVHdsZmFLT1BucUkyODNxSEw2eERCVk1NeGpLTW5ITDdqcEVr?=
 =?utf-8?B?b09iRG1mRzdaSXR1RkRudHgyYWJwczRMRjkvYTZwMmJLdUZsM0w1cjFTY0RE?=
 =?utf-8?B?TXhVQkZXakk5ZkswQnR4cUJ5bFVkeDZWWUdyeG9iOGEwcTdYa2hWVEdTbFBO?=
 =?utf-8?B?emdJMVZOUEh3MWVQNmJTWHNOdWcvbGQyVmNmZ291LzczQ1AvelIxckg0c3BO?=
 =?utf-8?B?Z0dVaVJBcnZsazR1dTl0YUN5QzlBYmk4RDBNeEdhOWtXdGVGWFROSWZEaUFV?=
 =?utf-8?B?cytjSHk4cXpZbmR4czBoSEpBWDUyZUNhclZOMWlRdjl5SzJSdFRPQjJpUVhS?=
 =?utf-8?B?TWdwTG44UlFyc1hja1ZyMzlGU1VLcUdkQWhRZlVFV09KK3NyWW84UVNMWVBT?=
 =?utf-8?B?blNaNXNjUTlPRDRhZC96aURxTk0rbzVmRW9aNnZzdHpsRUxDL2tpUmZnNGlY?=
 =?utf-8?B?aEM4QkpNWkJIaE5OK2dnMHJRK0orcXhNR0pvN2VXNVJrQXZib1JTNUloN2pG?=
 =?utf-8?B?bWVHclVGaGt6WVNrMm5kWWRsb0Fzb1MveDF0RXJUQXdDaEVYOGpZSGcxbkFy?=
 =?utf-8?Q?8Qx0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca319079-4d61-45b1-64fd-08dc95d1ce88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:19:12.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRCo1x8AsLV6sLVA7YswD5G3ki73oK3qGW28Rf+F/5fnHlWdC9X8ebhZKYxoAExS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595

--37da5ace343511f7224c33adcd545766c7d9811109edb023769814f7ff3a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jun 26, 2024 at 12:30 AM EDT, ran xiaokai wrote:
> > On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > >
> > > Constify folio_order()/folio_test_pmd_mappable().
> > > No functional changes, just a preparation for the next patch.
> >=20
> > What warning/error are you seeing when you just apply patch 2? I wonder=
 why it
> > did not show up in other places. Thanks.
>
> fs/proc/page.c: In function 'stable_page_flags':
> fs/proc/page.c:152:35: warning: passing argument 1 of 'folio_test_pmd_map=
pable' discards 'const' qualifier from pointer target type [-Wdiscarded-qua=
lifiers]
>   152 |  else if (folio_test_pmd_mappable(folio)) {
>       |                                   ^~~~~
> In file included from include/linux/mm.h:1115,
>                  from include/linux/memblock.h:12,
>                  from fs/proc/page.c:2:
> include/linux/huge_mm.h:380:58: note: expected 'struct folio *' but argum=
ent is of type 'const struct folio *'
>   380 | static inline bool folio_test_pmd_mappable(struct folio *folio)
>
> u64 stable_page_flags(const struct page *page)
> {
> 	const struct folio *folio; // the const definition causes the warning
> 	...

Please include the warning in the commit log to explain the change.

> }
>
> As almost all the folio_test_XXX(flags) have converted to received
> a const parameter, it is Ok to also do this for folio_order()?

Yes.


--37da5ace343511f7224c33adcd545766c7d9811109edb023769814f7ff3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ7+TAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUH2gQAI1wzmMxbD4f31lTY2coexf2YiEJrQ1oXATI
ObaNcxaxWbYq8Z5+An+oxelWthL0w7yD4w3k/ZOokBQwfCMeAdni5tCAuRIf9JAt
7YsB9TBtWXCvOnP9aYQb5CxBAW9bh94wc6pLGnScjzc/IZ1mgOA8V7/Lg1vIGEzj
u6oFD6Kd7BUYJXoxGffAjRRFjpk3NMmIKSjbaqUQowwyr+XHv3fpwF+5Dy4nR9Jv
FxJVHDprfLPqnZe91xB8yq3vtx2ct/VNvs5zvN4JGFaljWks7xPnjzSf5yIpRUzu
zuqSlEQ0dmYG/7aoJ5wr4ioxgEX7H5cA0MjRNu1IhF759aoiihWOfbr6usgnQsc4
eK+rWxsCLBfTfFKpyfQ9RFoCJgOSVoYtIkjSE029dm74bf9l3Xvac+WZSV4LLUAg
gzPF3dm4yPL/qk6kPiJIEDueIhylmbZrpHyXw5wfUiBtedXhOJd0W9DeC04ypuyD
kMi3N+Yko0bKVHj32VrlKr4GkMfoCWqTPzpypx8/Fmj++IGPybFtFBocZ41WK7vp
9YJNRdtgFSWtXcHilqHx1PbrXkD79cMfYvoT67gBQ0q33JurxYG+xdwJKLIwd87J
BrwFEU2UmMSpX5SIiQ05uWa92k6wlmvR6BvKAXhZKf6VcuIBiTfIxUHg4SkWqert
GddTt7mL
=WND4
-----END PGP SIGNATURE-----

--37da5ace343511f7224c33adcd545766c7d9811109edb023769814f7ff3a--

