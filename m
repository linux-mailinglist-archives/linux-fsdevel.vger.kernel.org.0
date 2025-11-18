Return-Path: <linux-fsdevel+bounces-68946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DFEC69D94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7EDDC2E025
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD13587BC;
	Tue, 18 Nov 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyURuJ8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8F2BF012;
	Tue, 18 Nov 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474587; cv=fail; b=Vvhur/PrTpqNj98A2aPW0UwGzwCNeqIdtiersbBQu5NLkYK1pav5Fh/VEuF5U/ouIdhenOC5mrTL9eIy+SJEgYv9QUq9P3FlqO9A/BUNcRU2Ty6wyIU72UP/cZPipLJeQV/DCKeRfrKlSHKVubtOz/OKejW8JR/F5fAO9fnQmOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474587; c=relaxed/simple;
	bh=w2yYNv5jh94rShJojAUHU/S5Hb0WGdRYk3X5qu4CfS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KyASZRgnLBIfarDPsvq8WWwNLYwj9KUqTg4MsFLlwkLxaBzDZV/0TUfYvWvcuXdK24ZrxokZrBBTAwdGyABXLVuNRStGAXSXgCKbguGGLmFa7J3WeMzPOJlI/3cNgcl8nyZocVdycGcH/m1UX/YOx0G5XmC6q73vi5K50nEFSUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyURuJ8G; arc=fail smtp.client-ip=52.101.46.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKGhXCUj9Zta+L8/jzw2uzOdkIfTgmRNLAW/yYcp0me+WeAORZ7LP4HIfsM2knQ7D2cmsGAZUMHR2ZOaKifk6zoQmUe0WJG+TEArdW0s2CR7HcA/28N0wd7pdiaYJx5HE3uAtWLEND636VICQTgoazQels2SBXAz+TCgJ6XwT+gJeEucgCt5C2rQbwA/drfxOsLbIBwloLwOvBiNXCtigfdydY4uiwcOtg3XjSXLj2CxOw6xqyfTjiyBTgmIf0sFTTZwjABBy+Rk/A+EymeuqR3k7J/rGDe/wuu47nlw8We4p6vHBXRlsRSfj9rrMXZ5tpkVHboDkisYuvB1/jUwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC74elaPpRLFLSTGYb/arQb/4NdA12LXcBNi94Z1w7Q=;
 b=CvcbT4LbF1ARCq0DEfY4W283/Wx5S+uU7rkaBDFcJ+uAklO/MXe8vCkNfS+6AnFmMJl7mQFX5GvRmu7RoQIDBQCd3DukAnlsypXh8cDFO87AZ1JE4jJRXxDiPvBLKZolBFJ62I6F7MO//OZo1Q8ZjMCItC2BbrmSxUJlPg4vx6KrecsQpuJtbDM8C8pAdwKG2ekDQNLD7EOlC03iQmOBNKgMt0ZjL4v5qhnWEOG/W0sRQg5zPwXG76r4SxkiO8uwvYzrwfHhjKKMhbPSEly18ZscDoU3o+us2Lv4FMzO/+NsZ6Ybpf/i2twe6uw4EnW5BcjpFIhktF4N2nS8iOH3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC74elaPpRLFLSTGYb/arQb/4NdA12LXcBNi94Z1w7Q=;
 b=YyURuJ8GaLAsYPhRP/tKjJ278RDfrsZz5hYWpETxKEQ4bVC4kgwOoOZaXQsAv/Pt3Rvcn+Xrfi6UtFpDabzBUJC+OPwf7Vj6RUp4Dbbxe9weB/VZbll6J59Wx2ksdfbgNsg/A40ETYNaHXSDvvT5z1ljdtS5INmWwBz5+fnbuGqBvVU30RmLwRuYod/eIlOf8wP+JmJoEXKHCJ79ZNMlJJLUMQjRBbp0pNfsc1BV8ZzrWwQB7o8ltyPAEVrJ6EPtS4FVFwrW/k46xNjX6NwEOZzcf2Vmp0y4VDV9VjndZ6NgCEZfuSgXWAYIbPoyaSKMxQI/IpvDyR4X+BhwBpRIZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:03:01 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 14:03:01 +0000
Date: Tue, 18 Nov 2025 10:03:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
Message-ID: <20251118140300.GK10864@nvidia.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com>
 <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org>
 <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org>
 <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRxWvsdv1dQz8oZ4@kernel.org>
X-ClientProxiedBy: BN9PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:408:f7::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: f77e7518-f1e7-4f78-d946-08de26ab2f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWlt5VgabeNYMrOagy7uJ/QxIqTMMlSI9lSKR7NDZS58FSJehGqF4Gh5XQnv?=
 =?us-ascii?Q?8a2PAHJrNzOiGNAxi9pKVJRny2cR51Czl3Pm9PVffcwRy3a8ahgW3xflHpR6?=
 =?us-ascii?Q?twHfixPx+nZiopNCHtFHG1AAv6ntFhQdCGO4ECi/LcROjyCTz5OGthG5aXxM?=
 =?us-ascii?Q?MutRbst83XCxnqLJG1iLj+PB5Ip11NmaKkRS5ZTnaNMaRDYsdWKjhInRS3aM?=
 =?us-ascii?Q?Wnng7tqW/FYJlgx6HQCD+YhmVzuFgOw21U/bBjy6//seX41ea3tyDmzDkYNT?=
 =?us-ascii?Q?KTMpK8QjKZ2L2Eaf1N1tj2Jz81N0nG7ehJHWQpnFRGuwZtmYaRmPWbuRU0D4?=
 =?us-ascii?Q?naJSxTovOKiVQZx+uwIwmkMkFjyC/W0JnasDrPd6ixH/wno84YuuTmtXxdEH?=
 =?us-ascii?Q?ZM1N8E3zRFruLSJm49b5SBKHS1lM+1mOS31Nd1RtJ6n5Y13jwGTLLw9Qy9Z8?=
 =?us-ascii?Q?trWHMQ3PimFbE6Ci794E2nQE6kDpjzLXRxHBZgEDdxx5f1HTE7hLn+pUJQIB?=
 =?us-ascii?Q?5ykWE/jbjkDkkcUCESjay8DyFNZi+I3c/9w7QyjhtiA9k3LNiJKyKEeRz646?=
 =?us-ascii?Q?795fLteJUCUfAc6D5GvUB6s/In/SKc+u6RrFdp2+mR9KY9KL7SR1Sprmbrsf?=
 =?us-ascii?Q?rXtGbaoqy1LTybFeR7Uw1obVWxBmiOIFUvMs0jmLZkWnXj7KVciEwk2D5rBC?=
 =?us-ascii?Q?VJpLW2Wk/cpYX2ZiNYkJtMNWfLK5zIyLotH815YfjIsslg6HqNksnIkyiLqp?=
 =?us-ascii?Q?ei/+irLqDGEeH9kC39AsroDOldmmSnZi6LybqsDMjmzqAM+RW+84N743fqJy?=
 =?us-ascii?Q?kIYm9QNhRD+NUsc0OYy/N/Q8mQ7h3DD7Yr61qgzKsFDS3+Uvr18L6zIbCmZH?=
 =?us-ascii?Q?ucr8HzOZYlwZ6MioJG+7A21Gyu6Z9UMASWtt0PAarFvWUppMDicRcStNzSgT?=
 =?us-ascii?Q?vK44HSHITrWCNpK7Wuo2zT9094ooJRmNhg/JGDmfTKJ2EKHtsaT+JMWOzEOf?=
 =?us-ascii?Q?XPJBWCP89GUUBTGYYcXaNeUULrOznNWlJGMKf7dcgbz9k4SXHUS6xBdz0ED9?=
 =?us-ascii?Q?5r8lGwp0+wd5zFTmQlTulvOMksDFi3yhBHERKGSMp1G1e2kMpZwpyDu9+V1L?=
 =?us-ascii?Q?UMt2IUQZksoSvnO2lCJwO1n1Nm6Tuq2l2CdIkUWse7uJHZrDVcUlLPTIxj3M?=
 =?us-ascii?Q?QWpcPefcIqjh6ldFExjLzURchyPk1kiJZCgDdCm7Mxwbfxx7fFTDr92M98YF?=
 =?us-ascii?Q?II/iF94Z6I0qJ5ievukfiHdXnHoWtMYpHSxtl5z8mSvWGv7iju5h2z/s/vDK?=
 =?us-ascii?Q?q+NrXa/uhyApcVJ5nVs7ZXK7mMQfD05zMwyGQwPp9d4ZR4+u7VOzomnyT9X+?=
 =?us-ascii?Q?ckUWn52fkwFg4oXVovtYlF6KMr4RnMcbssi+oPZ/BKGx4uVva8Q0a5IziTSQ?=
 =?us-ascii?Q?r9vYFXBzb+YaYf33BRTk/c9aHiXfkaoC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xFJd3ssj7gnK9yxTdtZkc32xShdgIpex6W0QVLesLjxwn29RcUnMXiUKgt6?=
 =?us-ascii?Q?sc351IU+Wn//ocsvCRUCpXI/yUE/eYslWv/NBeAMl5iEwUCoa+IYbdGOzTHc?=
 =?us-ascii?Q?695ciKpE5ecqW0unNY+HDcRFS78uw7/h1XIO/LGF8+X1VD+x/U4oSMjRjF90?=
 =?us-ascii?Q?pm/qLQ3qKai358DOevVfdAquxpW1CAugmUj/byBfq/t6ZZN473j0umqXsO5r?=
 =?us-ascii?Q?7ikPx/uyyg6OP66uStbdtIM/EufPgSEeSLxUkAA3j+PMcvgJI58dhgEPKnY/?=
 =?us-ascii?Q?TR0mxDxc1/gXlrwCQ1FEdiUTd7q5INf7H8jTKcgkqQO7KJkJpfJcD8mIqxHC?=
 =?us-ascii?Q?Au/YqRWH7ejC/NXO1W9IdoW4OWJ/zD16qQODcPV7A2dl7l+OcDSaadtbmKBq?=
 =?us-ascii?Q?+SeCk35+aoqGkQYbaI+Mh/u8GIxqYztT8ED97N++y88kRyS3VrbULUHrXiLf?=
 =?us-ascii?Q?LnFokLUjlgypBaiYQAhhcRorhMCiZqFo21+n6c6k4b/XpjEJl9lJwC0+K94g?=
 =?us-ascii?Q?EqB2ZITF/ZV7bRVnvuiE7RNtv7n/Cw5rhd+v0zOAvlVwraSPRsCtUHtFMF12?=
 =?us-ascii?Q?qaLBdYu/5ECJR3LQhO+5MM8+hOdJJPamSSe+8in4txyTpE03NzJB4pYH8Ay5?=
 =?us-ascii?Q?RGewXtmTd/qxlqK8DCzvUk7dueTWhbh1jGe+q0zjy4lK47wrnE1YowOXNRQ+?=
 =?us-ascii?Q?9tKllN1OVkk9IX5pd3Ec7uYwTqJcYysZSoq7FTwD3PgulUOo4p1tNuppB3NK?=
 =?us-ascii?Q?cRe1QvKbYoddNyVX5CY5RjZSjjXK+50+4306gW8cnI3/e99YQfNEhCrc5sFm?=
 =?us-ascii?Q?fR7VgIMQYSscdEQ74op2CXnmZ3wKuxfD2ZNtg0j82n8YqYJp3MeTn11N6FTv?=
 =?us-ascii?Q?88yPfgpr8kTy1Zj9gnnjnEvTIstiOGspSg4+1E4BMN/tHLCvw0k8lnsvjE0S?=
 =?us-ascii?Q?i/FXHe4zUl2BYOPR76qYTXKTyH3nHr0OhLVyeXUIM2Ohzk3qhmsiLSCdsZdN?=
 =?us-ascii?Q?M9FW0QhmLag3iPjfepoK4wRICe16zHQK75jRZoI3uCwW5Q2/TCg9//1P5FLJ?=
 =?us-ascii?Q?VVJA+GBqdMuCpfK8vfvCpbaCmxhZTQ4GOuAmvWq/2C4F06//oj0CZKH3hKsp?=
 =?us-ascii?Q?V+ruy7qrhoRduNbxgMOXM89pcZlvhMSQR7oh0PLCIpgoXXPEANObHCVx1fke?=
 =?us-ascii?Q?nqDApz4eSadjCurCOPZShKZPZ6XpbP2e/2v5JOuGnh5Ve90ypXSM8FvZzcuG?=
 =?us-ascii?Q?1c+9KGW8F4/2cp/GH981QzGPFjxWcdSg41vGHRbn0Y743KfzN+PgtAJzj6uF?=
 =?us-ascii?Q?D2Y5hBbD0PuOQN4TOyEmTPmlM3+o2meFVyVkvTZRH9MUznfX/rn1cDFrk6jz?=
 =?us-ascii?Q?AF9bbF/DtrpiBicYYVUzhgQzy9MPHOjAiAjIWRTkJ3lbHj5exXFwrdbXL/CT?=
 =?us-ascii?Q?uC/qbJd23E8bR1g6BpXKAiALzGs7tm4pLwdBfi7ws5D97f4tFLwRhmMhStfR?=
 =?us-ascii?Q?YWGok8723XBddpJocSSRDYiZFJkSgUOrE/0KAhenvFsmBfFZYLkb+9pb+KE5?=
 =?us-ascii?Q?mOG+ELOAt8wPI5Po7LM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77e7518-f1e7-4f78-d946-08de26ab2f48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:03:01.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWGmZkkGf7Rc7UPCXzH/r0Mm/RL1OzNxTFfrBdl1l4VGouDMArLy26tMGeTgWFSO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

On Tue, Nov 18, 2025 at 01:21:34PM +0200, Mike Rapoport wrote:
> On Mon, Nov 17, 2025 at 11:22:54PM -0500, Pasha Tatashin wrote:
> > > You can avoid that complexity if you register the device with a different
> > > fops, but that's technicality.
> > >
> > > Your point about treating the incoming FDT as an underlying resource that
> > > failed to initialize makes sense, but nevertheless userspace needs a
> > > reliable way to detect it and parsing dmesg is not something we should rely
> > > on.
> > 
> > I see two solutions:
> > 
> > 1. LUO fails to retrieve the preserved data, the user gets informed by
> > not finding /dev/liveupdate, and studying the dmesg for what has
> > happened (in reality in fleets version mismatches should not be
> > happening, those should be detected in quals).
> > 2. Create a zombie device to return some errno on open, and still
> > study dmesg to understand what really happened.
> 
> User should not study dmesg. We need another solution.
> What's wrong with e.g. ioctl()?

It seems very dangerous to even boot at all if the next kernel doesn't
understand the serialization information..

IMHO I think we should not even be thinking about this, it is up to
the predecessor environment to prevent it from happening. The ideas to
use ELF metadata/etc to allow a pre-flight validation are the right
solution.

If we get into the next kernel and it receives information it cannot
process it should just BUG_ON and die, or some broad equivalent. 
It is a catastrophic orchestration error, and we don't need some fine
grain recovery or userspace visibility. Crash dump the system and
reboot it.

IOW, I would not invest time in this.

Jason

