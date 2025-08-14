Return-Path: <linux-fsdevel+bounces-57889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E478B2669B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7D86265B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07223009F6;
	Thu, 14 Aug 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V1H8bGP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95E3009CD;
	Thu, 14 Aug 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177119; cv=fail; b=dCdC4l4b0bS2y6gHTurG1LEBthy2j6tKzPDsg/8aukEV4ZrleZsAHkuRbk2/UpRkHESoSSogcJhm1hGhmsCnBh3iWECpAvmNjKoWpVDWOBzz8VYzCSaPwbGf0cQy0TlbBKoHLiHge0t37E9BAO82JdfNtGKCsDCRSfaZr72dQjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177119; c=relaxed/simple;
	bh=p5yAFGVs7kr0oxW1bWroCcoja9YrmdiDukYmj5hS1so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLLavgLfF3Y6yT10fG9TBR/bAjTmOBcT2+gl9IZ+ZpbpsOEcznSZBvvaLTk3WriA7y0g/99wXZR/uK6hv/pvCE8r0vPYFUdrURBCCt147nb75LHj4S666/HNDBiTRFSZbTC/mvTKwTdQ0xelExtiGckO6vnskNPbaZyHM3gPo3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V1H8bGP7; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX5xLlmqhLJm8XQrUtDnjjM9fmsg8IUKVrYCcl0yg4SVa3uzoflLbAnpQ7WX9zh8VN3A+AA+Si45hLiB8R/SK/xtQUJjtx1QLJQtK7h6t9FKYPXk7ZGMBNRIt7rTpXzwP0AvHoJR3+CT0Yajdbg9UvSs1HNvBky4hEMITJH3Id07/VXID9GJ8Czn4njVEpB3E5HV+kkg3vminKgu4OrLF51dLtaWjDXGcEsZTQNZMQIJfw533ERyZwHG0sMWMHpOQExh5GpqVx0wwFkF9pP8xbJqR6rdsREayUDDG94Fj7zg6j8zOKSo1MDQhaT/hMhPuNIdYDbA9QctFYUkavmlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvHCizeAGj48lsyZU42BEID37dtd7IXAvZjIB9veYwc=;
 b=oKsNnWpQDzHCHUE86EsEhWWRQKpnKlDs7rsbKpUZqe+ZuB1gA2zb+HzE0kokiYb/MAh6KSDfcy09EktqKmiqdSAGwaN/ixxly7XmG08kGpL41muhY9EuNFYnfwll2BMm3m1EMflZZQOgIVRJ2iE01Da1655KakDTtaEVAWmwH3q+5J4it9NKR1wIkFOwb1xK3gdFLNllcYJvrCfuUX/v9giyGl1tHruj574Hqeg6RFMcgKLOl67Hyt9Bvi20UenfyJ4ZfshN7p4qeagavjW8ZrmCXGNIcLubORtGK9hAQSjaXg7jwzHsYK6b1nx4sziO4PRfRW9CdALL7E1goPDJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvHCizeAGj48lsyZU42BEID37dtd7IXAvZjIB9veYwc=;
 b=V1H8bGP7F6fGrzICnM8/YR8xr9zqg/AlcBMb/+9Y3akxZw+0KX7geh3P2MGTKtdkPfxO5Cvcu/e5qDxFafz6Ur91j0B3A5mwnoGWKO1ml+2PD3NGnMPBxihjCSZoHlLpypbEG07wuLrlzY02Jz7kC+nXE0OirjABWjGotkYNJnW+IMrzJiCcEIE6nZo8Ye0AUdzfh4FGyjiLafdU95lhLS8KvX4JZaoLX6ICG2V7sJmHdxrd39J+0B0NcUw5dPn1Ev8gT0iEh8oQz9putdAYBW9UdnIeCarHZQnZnsK7V7mW8d/3OpXL7ZqJ3CJPn3NmalG8g48lYZ/7KbY1vuD7nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 13:11:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 13:11:54 +0000
Date: Thu, 14 Aug 2025 10:11:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
Message-ID: <20250814131153.GA802098@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-2-pasha.tatashin@soleen.com>
X-ClientProxiedBy: YT4PR01CA0488.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: affad82c-33a2-4c6b-f16b-08dddb3423b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?geAL4fR7j+em5NJXadljk2ptisRcYskGPiI/IklzYvRdC+ufzkW7dVqsuI//?=
 =?us-ascii?Q?KXdYLy8xyIEQYkgBbV40c+GMR2SW4oTlXbZfSHQ3sKKlEAv/Xd4FEu0CkW7u?=
 =?us-ascii?Q?OGEGDZALIEVAcmolEFEcPlSn1tNBevErFXVTZg8uhW3cL/GJ+YbEm9UhGrP1?=
 =?us-ascii?Q?Yuog0HYmvsp0W+PbFDOn7oI7XqlnV6OMJ4GdKrzmN9N79pFElhtul+dnLVMi?=
 =?us-ascii?Q?iJxs9NceBh8EnR6oa10FDn80Y0k5PNZCU3vp0+ua/gTrQIa7lE7sRbIALnlA?=
 =?us-ascii?Q?vPkrAa3yZgzkrb5hUWIzHc2YKI5hoOTnHF/jUnl/P0MFC2rD2cbUj/kKztEd?=
 =?us-ascii?Q?eVX+a8ZzxTUIiSj3dZJFRvXHk1OoZfQdRo/YULT4NNriQ+61naXLahYbwo5Z?=
 =?us-ascii?Q?1boI30G4L4UbqNsj0N4pKNlk9u3EIdwbyJopWwBj37VHijb26SeS+zJ7eHAj?=
 =?us-ascii?Q?7Psz5J1F673TdnELUEdLG9o9bMNvp/pUVijRX/WAFghV//fUUthC0LUzUZ29?=
 =?us-ascii?Q?Je2Tsub2V1tXZKSSseyxOYyP+GE9lxL1vd3mo+h3J5k04j1oXXDMxV5vRR0u?=
 =?us-ascii?Q?WOJoV/qw12nNzF5hoYOTTfFKp6y341tlJf2+N7r6vUUbXqbWL0rAwF0MVTub?=
 =?us-ascii?Q?iymeIA5QqxJvtdExwWRMT9EXn8duFrdMUx2LHAM94GRV5A8Ab+REKLW4luUr?=
 =?us-ascii?Q?AHb8b48gjBQUGRsauqbwD8+SLNzK72yQVkIXR3Jx/vXOXjeNrLHpYghzhOyx?=
 =?us-ascii?Q?6vQf0rkpb6fqiavxWj8NdjHuSo40GNv6u4fPcFkvrivZ1/OtY1XblzJ++MOC?=
 =?us-ascii?Q?J7GrgjP2Sh5rvJ6MKCGBeohL1weaAogDvwhO0zG2hhUnqICYALdVWnzsqEqG?=
 =?us-ascii?Q?CUtE4xXSIB10FoQUVY3bIHuAG0JTn2kEzcfB4r/2n4MBiG1WLcMcwy32sXQ+?=
 =?us-ascii?Q?AXtt90pa7RTupYMU00eJPyC5LRzIyr7t9WgqryC1wIlOlIDAeYqWk+BZLAjd?=
 =?us-ascii?Q?kN9eM5WHPP/DTxKZ4VoR1NWXPW+NGFqoR+draVZcPpf/VZwdBq/KVPMQ+pCl?=
 =?us-ascii?Q?1pWEbiY4FA6Ty4QXTBrQ71RkB9fViltcPYfRj4LwuTEBOzzkglSEfB4kGl+t?=
 =?us-ascii?Q?3FwaHER35l9xq6Phq0mE1CknotkdPeicwnFe5Dzdjjq/ReSUFi7g2GQc2dAF?=
 =?us-ascii?Q?sgC9zBD2s1Hza4AdCupfMjuCPbsiPW79OZZCf78lBTm3/y/COjNsCyTPjgF5?=
 =?us-ascii?Q?q3DQlo2TPt92mr8smKpIOBnDiE8o0taMrMsjGwLll495yiaHsaw0ThVdYn9A?=
 =?us-ascii?Q?OPnlke8CE5f1gCl+ajiDfmfHrHDGz6s+qxqGLXCOC4ijA0sq9/vDVYvgSwvv?=
 =?us-ascii?Q?5kuyHB4RqdZoOw13JTQCsMi1gcWH8bie/GknSoUX3sP554oj0aZEnpib4H/4?=
 =?us-ascii?Q?ZHgor+4Yhmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YXQHqE5eJmpadpGnTE6Bh02riG453GYgZxS8HKNqw9Bekf4qIgp12ZIi9LDl?=
 =?us-ascii?Q?lYchlI4ct4msYwUILiP6cD7IIsngltdBQjk0N4mBTjNCx5nqgLz/vfoKuABY?=
 =?us-ascii?Q?nrZGt3LYU0doU3xwsDJ5EX2/7DZdkU8twIvq0o0kqpj5xYGnd/fPuFSFMdei?=
 =?us-ascii?Q?VC8NX/QbIXZCeexYpyQFykHrWBKAdEvZzDzj5Mm9flHvj9IDG21yjeWZRUEL?=
 =?us-ascii?Q?XupTgbR28h3p2nOpFUqKhwtD1HWt/i/SOVxFWl1K7DP9Q7ICRfprE5Kjz5W/?=
 =?us-ascii?Q?K9nspjT/Vn9/MHPK5zF3jG+bRqiGuODvTZYnrQvSqPd4MQJpxK4/XhfzZAxj?=
 =?us-ascii?Q?f6d3Z7y+EVwInUZp13SWNtPGfAlR+YP/9SuChrIAHOX2szWisrldLxP7XJ9W?=
 =?us-ascii?Q?7eSoEJIls/NWxiPOoZkp1g6/ZIIur0x+o8YvI2/v5yYwwUxlMtmQneilZgXO?=
 =?us-ascii?Q?BAVx4to/RgrbCrYKOw6DKRUZgre3k4r/7g1qjkvtjICpFOFk0SG8KcTHXuZ4?=
 =?us-ascii?Q?kDQBUMi/xeEAUGvkyv45iJVNZqPty8Pynf1dd8ojvdi8z+p04D0xVgSOUX/n?=
 =?us-ascii?Q?Mmr7V5Z02IFt2xZtJIJAzSZJGpP3by82neAuyHXvi2glKmoXlwlYSDJplkh2?=
 =?us-ascii?Q?uZr7cUG0Rc19BfnGFPY4XFWv24gcT+l/vrgwzLf6jvB/MLWW+sP/M4PYcpr9?=
 =?us-ascii?Q?tsEQnAZLUTIo5Gl2vexUFOkGZt9rOtzpaEDFN6GcBS4dKrZQjKbe9tYcf4Mz?=
 =?us-ascii?Q?KogfY6Q7VrR4oj07vlajhJb2v7Ksq+mF3O8pwewqmzWPvRXF+pAlgGAteKOt?=
 =?us-ascii?Q?E4qFhjxg1S3AhDNC8p2wIdlg2OgF6YPZra4FduL4RE6Z/HyXi/rTd/A8YhWO?=
 =?us-ascii?Q?hkHt9Ngu5eAawFJ3sRchBJ+/19Yh7L/+nQhJ0n8ncSmAsN8C0dL9u7p14SE1?=
 =?us-ascii?Q?f1NRZMtdoTl3Fv/zMlQA69vfv3wfHLYDs+kzmWKKY4stw/sHVcGGVKKVbG6u?=
 =?us-ascii?Q?Qr0hz+p7YWFdHfM+MmIrd1E7VIuHfLPFqu6oNzzcGMlcxDcpnKiZcZVia40/?=
 =?us-ascii?Q?MffA1JCXAPTHZMAkFk8zJRt8uSZvhm9dyvVQ2vWKedFsYvAvcPJuNddElV4r?=
 =?us-ascii?Q?hDSVnPILWfAwYAVJAYni9v6yZDtKwJ8TYEeQbNMgKxeHr4r5g6WdJDh+Ip5Z?=
 =?us-ascii?Q?U2Vb9Mti+9MHw98A+4PyHMoR2sYWewY73YNya7Su+9CfF6CYSRdT4nTJVwAB?=
 =?us-ascii?Q?HZ0xJl29+JnHIjRM+Igl8Uu+VGdwVSagYpcMwOoBOIY+iiIbGRcjSB1YNsSZ?=
 =?us-ascii?Q?SfF07/4/9mbdY8e+Yc0+jucLTiMJZLlT/v7GrIB4fEvHS4FI6DGHy/9tuQce?=
 =?us-ascii?Q?g0TpwYhjO2/0E2anHFNq1Q/Z2pSwceGx6JzZrru9vC9AdvpnVmEySsUdZrjb?=
 =?us-ascii?Q?HXN41nLUw1qOh187Vv6+z/QbapzeJeGlfgPtJJVByNmhS5iDfJyXDMvYQ1Nd?=
 =?us-ascii?Q?Dvi1gWxFYQnjcA3bQ/jOqA8sW05KXWeSC0GWA1dIlRxnQZ1KEt9LblXeqSPE?=
 =?us-ascii?Q?EdRpk1MD0++gJix2Kbg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affad82c-33a2-4c6b-f16b-08dddb3423b4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:11:54.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfSWL2JVFFFJqLaUyrIFM6oITRJCDEQN2+lXwS3v7OrMQOkYMZGxleHO483Q4n6A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968

On Thu, Aug 07, 2025 at 01:44:07AM +0000, Pasha Tatashin wrote:
> -	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
> -	if (IS_ERR(physxa))
> -		return PTR_ERR(physxa);

It is probably better to introduce a function pointer argument to this
xa_load_or_alloc() to do the alloc and init operation than to open
code the thing.

Jason

