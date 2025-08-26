Return-Path: <linux-fsdevel+bounces-59229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B0B36D5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11B77A47F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B860255E40;
	Tue, 26 Aug 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCtxg3ZP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6171E522;
	Tue, 26 Aug 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221220; cv=fail; b=l2zn3UHJKPPEIZpeJ/G0j4utf+KlzDB6t4AukGt+Fk4AUwiOXZ2x8vlYFs5F+yTrYmGC1B7P68H9paKkMFgrovaW10pRMMlZ8KqPK/M6AEKa27Vf7LNeoJbBpO66WLmdfGaAYUukjLxPlux4xs7n/AOC0kcmfvj+Wd/ZXIvK1kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221220; c=relaxed/simple;
	bh=BuL+cvL2MDd9IlDTuU8Z384iTnIIgf4k1sQwqy3ueck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lb2md0tMmrWWd9TxQIh+H/5gjhyfB0RdxJ91IvAE2ex0n9nmQYWm4jLLjODRPynHxxcx4zesVDeOgpqT74WmAOBZVr/YSSkgciv+4KMqTH9kFX1mlGqXa/UvgUH+E6/CAFjMuuVTu02CaYmtZMH8QvPeD0s9KCPOpqMhDnEXQzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCtxg3ZP; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcTM2c8lXITK8Dx7JWN6KZfqHAj2Nl6u1M7qumOZ0ws+uC3bAeQunFlQ/2e6iAieAGwt6mCQhx5j9xGGbqsueLRLoXZ4C9HVtRMCt9dSyJIxvGIxBiEnVMXFzT+1d65h4dEQsgfLmTdLDbwyOq6lhXBkBm5il1AtndpBPMDClBFG5/OSSLUQBqHlo58zJ4yqQcIAgdQNKszJSy73kERqPwrjx8IAF5RHcHlgbGbOqZHcZ/w4BGPuTCnjJY7dQQr6+7H33f3AsvhUf5Dia3ecrY8so2bsPDKsf0+Zd+MaCVgyKGR9KoYK6pPWinkWTJyrNa/Mv9kWv+5MwpPRg66RRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuL+cvL2MDd9IlDTuU8Z384iTnIIgf4k1sQwqy3ueck=;
 b=OLmtltKwubDO2SWswZQ0q64AQQMeqBrYtJZICycnwsSKTpap+TpItBkLy2ZDmcRw3x0tGyWal9vQgtj5BEFIRGZSO3BrypZnBFoaU5/4F8hAKbETtf/G9Cl7Aa9fbKmglWv4ShF2ueXMtXK+ovEQKcbZvTi+ZU61EcjDHegPICt8uMycqgcmgq7h7CNXVqcrkKy4pVT/KVhGGO+TsJSGBJAxg7RQojwqMoMokjPJ2R/Qagn+Ifndf3Pxlo4bQEfq6cjnc/k81tfSQXxnD55Jz/2sKYyLHt6TygE/9PvAqeEWvc4TIhDTxTi0ZFHwrXpBhiBBDis2Z3kwvnB+5/M7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuL+cvL2MDd9IlDTuU8Z384iTnIIgf4k1sQwqy3ueck=;
 b=XCtxg3ZPHNdQVPVOaYIzkd1IVcP+e93h8Pv7G0doKJSFYKPWcqdVu4HgHVxteLj//fFHewifuOoAOIHA+c88ikDJ9bGKoojhFD7k1QqOSFSkLTiN5HGoQA1hd1H08OPuROM2UnYI3V77gsKDnv0tsASMAfhZmshsSL2HZdRQpm//6zffYdNjyD+sz0z+uTM8mJCJpyl8+RNwAaXTL6ErajuvBn4jGChk0Ab711xB2yY30gqf49wuGkHQajHlOFpGw4gn4vFfaqig49J6fFBEmzhR9fZUX8A/awbykEEJi9HUQUfZNVzMIC+cOnUYrx0MtiG6zlKFlaQlNmQEgrm1Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 15:13:30 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:13:30 +0000
Date: Tue, 26 Aug 2025 12:13:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
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
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
Message-ID: <20250826151327.GA2130239@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <mafs0ms7mxly1.fsf@kernel.org>
 <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
 <20250826142406.GE1970008@nvidia.com>
 <CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9bf4ef-26fa-4fdd-8156-08dde4b31d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uM9n7Tyr6W2x5ysgWXrMa4AeGFdVHQATY4w9+HHUdw5yVRVZ5kf3bbZj04qO?=
 =?us-ascii?Q?WENwcGV6P2xTYcqdx1pSg4c2lARJhNpIYl+FUbia/EbOgli3sdn/fETY6o9E?=
 =?us-ascii?Q?xu71ePciwhKaiQ4Fj7SJ2/qQ+eunO2EGFEtdVBl1Ruu/Arf3cD7qgdNE6Pzu?=
 =?us-ascii?Q?rFSEZ9Zc3ZaJUeuDSVsXEwLQ8TXuje//Xra0ec4JFrPuA3EdYcdlSwhaC8wv?=
 =?us-ascii?Q?N3AvZ4ZqHRu0uiTBuIw33aahi5J2P05NVPFcvztMbpgezxM80p85b43JmIn0?=
 =?us-ascii?Q?vJ4DZYUOJ9RKRuX95XE0DnNXvxufvqbFNA6lR99Qpp34i0i4s78C9CYsjTgw?=
 =?us-ascii?Q?/Tp8d7bHWTMetxr3QhUOzy+rDQu+h/tjyHY8dO1c1ny8e+ytMqBTdpjYm3pN?=
 =?us-ascii?Q?scBhGJAxo6hwM0YA/Wr5xbMPSqweTcaqkkMda558MVbxH3Tja89OFRKzMNqx?=
 =?us-ascii?Q?vgTbt3jd4b0jpYw/OKcOnH8ZWzM8vemUZym5hk9WfiqqGSv56kVGF9EXtD1/?=
 =?us-ascii?Q?NT5S2oyg6N3NZCUJhUgbzICyRQc4f8qs1+7jpjsnbdqJa5dSgQ4iwZ+pvMcF?=
 =?us-ascii?Q?gcN3ghpt9usPv8AHnr0orYMvcSWj4H3Ee36bbhECMUKFjlCZHzQPXKAEdUHj?=
 =?us-ascii?Q?CgaBePHnRBd07jCrC+7W9tgrq1GrdNdJs0cFRPKRJ7LF+ABfJCHuVnrRcSyD?=
 =?us-ascii?Q?3XU+1+aQskBr83qwjvi4YjkQDJaK/GorM32p+nfUzPjJW72N2kk4cW3zuJHH?=
 =?us-ascii?Q?AqG6nOHBEA98gHrf/9OSLNoyG9aialay840fghixmPHqHItBy8h5n9EO7Ipp?=
 =?us-ascii?Q?hLw8TRYj7TWWQj/aS8JQP+wqfcys+156ngn0NheO7xSDPV9KIIizqVc+w2x/?=
 =?us-ascii?Q?SAk1qyZ6frvxKPBRF/vxqN2L6h/wIhx9rWs4xBG5WRd+t8NXh2gUv42xr1sQ?=
 =?us-ascii?Q?WKG5rCUbnbsQKP1A/RYfQnDUIp42BFu8vjDsMjiSElkw0jU6U7zAIKduVOtl?=
 =?us-ascii?Q?gx6hd3xCZ2LaQ7u+A2gbqxrh2ZMMM55/J2dfM2m3lLq7WPX2R0tzupAFY9ZU?=
 =?us-ascii?Q?+OtmTMfsOcVC6B9JhypIMOmK1dE/W/Kb8dZrn2qfc+Z/9M5cK2czlQ8dCly0?=
 =?us-ascii?Q?b35psb4RMWHqugZqTA8oArfL59xZg9v+1eZA5VfYBR6/2lwhOrCHpynK3F9K?=
 =?us-ascii?Q?Uq9lUPxowYjLD+oVLk5SbvcuJRPzcByYg6wROmHiVXRNCG3ZPFlj6UVzpm4x?=
 =?us-ascii?Q?wsxqUR4+L+TVV2LEqRAXfb0mS8ost+tal5pfvsqaaucl6syDoo/jveCzkHCt?=
 =?us-ascii?Q?+GixfY9iOx/uhZCi725kF895cHIyJtPlK6TY49fG6NM+QJG6aLBb02X9/Qq9?=
 =?us-ascii?Q?IYAe/BXUtwFmHKzjjK4667YbCC6Bu7V3SJFBICm+VSzaW/A95Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9Wqhfrf1wD5UIFc12C+WxRz+z69LtQF5C95Y1ecq0hiCt0vhXNZl0CQfWRJ?=
 =?us-ascii?Q?pOP9MEqGvSMKolDiU3Hbp/iVyQo9z+NRekVp62Q14VeidCoPrmzEU+lF9KzZ?=
 =?us-ascii?Q?vJpeYAiRh4GdRyvnaBIEdTqlKzW7wqddETK4MvNXzAQJHdNqNBWGnLfPaLNC?=
 =?us-ascii?Q?RyPeeamEiO6piYlyzRLRD+yvDBxYzBHNlg7HZlG/jaI6sSTXUscbFN5BIe6q?=
 =?us-ascii?Q?W+xOekoOxmH3hhjKO+/pLLhT7fxg4+7b2AOKavgbd58NBORYKrMJp2BwDC+K?=
 =?us-ascii?Q?3cQtaQe4HSMVi8nIx7lh0Cbj6Ot9qH8iCBdC4kFhYivUStAydATUniqDh04M?=
 =?us-ascii?Q?sHB0MkGhPgbm3BamFutaiBR+2bFtCfiWlgCKXYKn5aXvVTa4JOLiYCX5cvT7?=
 =?us-ascii?Q?dwO9WKpGyd81FHRXpClfhpv2mET480TRg4j7DZB5QCxJ7Gk1bLmMvlTKY8LG?=
 =?us-ascii?Q?YLFKO9tljqxxXSVZANlyI+/q+TKLk1JrRjLSlYrjXinJHTvSVVh//MvZN3VE?=
 =?us-ascii?Q?OZRCSjqqjY92RuRKGepUlDvMOb7JmyI+wl6OAK/g3MtNcoW0o2A8lFWecQZw?=
 =?us-ascii?Q?BQkmhfEGMClBHW6+t68uHc9NgDnAOABBg6t6DwNIsQudPA2iAdYIe6LFmFea?=
 =?us-ascii?Q?RN5E/x5l6gZHf8kIYDCHtWSwWewUhQxA7TI9/MHfLLlAy+72ngDXnZrTf8hc?=
 =?us-ascii?Q?Cug/69Ic4CACNiZRmjRHSCWwhUJQgnhWxueHr66BLa6mf6TQ6kWGWC2Fc4w7?=
 =?us-ascii?Q?i2DgSaemdawHoe3inx0apUFYfFP3a9mIfhaCogneLCkr0AO4iW4WHoDVHT+c?=
 =?us-ascii?Q?9j+A2zM9Fj2Fg1yJ+aDF5uH8hMK2ofUqUyZuYkEpMOtn0OL6rP3843cwSsgj?=
 =?us-ascii?Q?U1ibc2T50s7paDZsXurWyWYN8ok3by5isfyCQIgEgphHvfivqV6HjZS28WnW?=
 =?us-ascii?Q?ojon1iHla97MD10c5qEM0YWujBYnm1UMw9oESxP6SPgL5xQlgse0lUdl3JNC?=
 =?us-ascii?Q?KeU056yEuqUAPpqbBszymGd890h2JMsYfqV2KbCL7FgGXz6/eurY3QSjFSAZ?=
 =?us-ascii?Q?hhuf258mmRJxXW7Pm73/ZlnzpdbICr++8EPPbML93CoDKJ3O9kMTuuukCCRB?=
 =?us-ascii?Q?Psp8/pTkq+fz+9jRidHZStooxayyHS8G/S1BHUAyrrR+QrEfvqhUZkwVGStd?=
 =?us-ascii?Q?UXqO3A4j6pQyMJmkyb8t0r7dDpgoDJ/g9Y9AHxFeNEul9N2XL2z1mVvMEWUO?=
 =?us-ascii?Q?zkm6AMZp4kv4b28dY9Pz0IlaWIi5z4UTdPMmaNO/zUsLmusBWeBCdr9ydYoU?=
 =?us-ascii?Q?tW3f+npgr8xMaylD/rjICD6zWlgI8XcJKzWvgj1vCab7FXCVltn7326l/Uz+?=
 =?us-ascii?Q?C8mDKGRnATyACkw2/A/hJtXEmRZ3PaRmkb37NfKiw9vBFsDhjz2f5EJKaufw?=
 =?us-ascii?Q?OdqeJPz5ThFIMdZKhVqApRrjtZM/xYMUBZJBkmnsHENwL9Pvp9/cbV8G1npb?=
 =?us-ascii?Q?H/r0P7i8HZu1otcM5o+Ut47TTbhKXq1SgaVwwncubcj3oODuc9kAyU6KE6yy?=
 =?us-ascii?Q?njx3MkO792ZaNNx78g1JimKcDnnzHImUgrgUiD9R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9bf4ef-26fa-4fdd-8156-08dde4b31d3a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:13:30.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rtLPIlxYDTN/mV32B8fO28jUUS01qKkjPGycPX9ziyHfFKxDxvCryPvYSTNDABb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

On Tue, Aug 26, 2025 at 03:02:13PM +0000, Pasha Tatashin wrote:
> I'm trying to understand the drawbacks of the PID-based approach.
> Could you elaborate on why passing a PID in the RESTORE_FD ioctl is
> not a good idea?

It will be a major invasive change all over the place in the kernel
to change things that assume current to do something else. We should
try to avoid this.

> In this flow, the client isn't providing an arbitrary PID; the trusted
> luod agent is providing the PID of a process it has an active
> connection with.

PIDs are wobbly thing, you can never really trust them unless they are
in a pidfd.

> The idea was to let luod handle the session/security story, and the
> kernel handle the core preservation mechanism. Adding sessions to the
> kernel, delegates the management and part of the security model into
> the kernel. I am not sure if it is necessary, what can be cleanly
> managed in userspace should stay in userspace.

session fds were an update imagined to allow the kernel to partition
things the session FD it self could be shared with other processes.

I think in the calls the idea was it was reasonable to start without
sessions fds at all, but in this case we shouldn't be mucking with
pids or current.

Since it seems that is important it should be addressed by issuing the
restore ioctl inside the correct process context, that is a much
easier thing to delegate to the kernel than trying to deal with
spoofing current/etc.

Jason

