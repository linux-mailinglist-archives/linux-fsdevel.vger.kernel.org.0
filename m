Return-Path: <linux-fsdevel+bounces-42019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE6A3AC8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C6918936FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97701DE3D6;
	Tue, 18 Feb 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YxJNsa54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEB19CC17;
	Tue, 18 Feb 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921442; cv=fail; b=eOxe7DF0OwJLWRJbcTY/WVLS4Gf/NYGmrGFC7pdet2Z2TQhB9mnEB+Dsr2TGJ2VknMg2qGEOl54MfYHg/FHQjBBG+ohvrJxYeEI483JL5w1E5iwDpkwc6pODB32FQjXOsNPlNTmLlMi0kcK6yOSOus9vWkr2rHb0Msaw8eHHB8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921442; c=relaxed/simple;
	bh=EvAqQJBTFphhjM2px4l1VpbcjMSuEROtfIMPIlyEm1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TSrn7M4mx3MJLQ/neJrkXWo6am/Hjv0b+Zoopfj0oFpFj9Kysaeo2mNo4lHQlFOOPj0Aq2qUEa88+adogsuuYrYA1yuZ+t7RcfFQGWFu0zbm9rKbbfj0Kw8GBOwb9C6f1fK+HPxcojPAQwdTIBrH/05Gm6HY+6Wcr9gJw6o1bG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YxJNsa54; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sdalyx0fOmu3Y7bqHq1me5Y9l4Gn8ZvxkPybia+7Gn80peSCktX8XyeGO90cGG7dkJ7IH5N/9onehhWqv/w0RexbERtj8VJZNRtMFsbOw0YEHfJ7faI9uiChVJwj2p0euG1qb/Hi1ei/fCO0Qt7UOfzb6VbTdY8eL2kuEosB7QNLYkI6bRr7eD9o2CHGS2WZLLFxDWTLmWqSKPmVzUFOW1+vvQFWqZ1LKrEWV6a4IkwW+Ms/ZJTHQW4TLclMwb7oFfSj2Qn4X8sz/b8C8DGgob0qnaKyhRONsUCzngNHmNpTeevDFSpVVfLG0HLjc2e7xk4ntt4dUUmqINHzSW5L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/XyJ/5W8cVygXYbZ0B/91iqdi7aL/7aKRbIbKxcsbM=;
 b=P6XdkBAHFmMf2InrZ5MMovAnPniTpvmJWPvJihFXmcgPnGPAsKNzDiIHiHPmnzxQV3wjr+MtHE47J8n87BAnzYPRTzWCfc7T0ljhCcb8P0Ch6LOBKOV3eASApCjDdGphUeibYnKHDq/9fILOXF2cS6G6/+24rEX+RmTk+2J9aRhhCw8QofhplewuCzZdKJzdDnychNhLht9v5Iptfy5Mnb3F4PuXgazjI2Ret+Qw8vLuS0iit78jLSS89R0+pKcV2u96dnF5Xjj2wMFkkoD4xWH+Fs48jGqUt0C2RemUtUuBOtmrt5mrQt/AfaU8qXOzUbvRDLRtC/SefS4GeM47Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/XyJ/5W8cVygXYbZ0B/91iqdi7aL/7aKRbIbKxcsbM=;
 b=YxJNsa54cUwCQuJiCsZxElCE59BV99j6elyXtO2ATFQwTBwWZ+r68+Epm/Aeca3a1yz4B9KGlxjIkzTzLeMaSVwrqEmO9LpkNUUDsYnV+yJ32PzETNJEi55l7hNBp1RDKTcEAOHB/ovN9Hls0NwX43zHbwScTQ8Zak7CvJmakZnoDL4YA2+ec4LGKZZ2+H5ok6bxEvd5jOeGm6GGLn0I9MD3986TsXbs4VZ6OHo11ahRWD1qRaHX4BfnKFJwzbtYVWaVjuPjEdKLuySnXy3vi7E7KrunpUEwzMglIFA4nOXRlVO6BuUqWtyHC9PR4HTS+XMb/JFMxC7Fog1GPnXJMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Tue, 18 Feb
 2025 23:30:36 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:30:36 +0000
Date: Wed, 19 Feb 2025 10:30:29 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, Alison Schofield <alison.schofield@intel.com>, 
	lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, 
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, 
	mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com, 
	ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu, 
	linmiaohe@huawei.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, 
	kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v8 19/20] fs/dax: Properly refcount fs dax pages
Message-ID: <jf6hr2uzyz76axd62v6czy3wzcuu4eb7ydow5mznehfuiwhqq3@2q7easkxhdp4>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
 <b33a5b2e03ffb6dbcfade84788acdd91d10fbc51.1739850794.git-series.apopple@nvidia.com>
 <cb29f96f-f222-4c94-9c67-c2d4bffeb654@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb29f96f-f222-4c94-9c67-c2d4bffeb654@redhat.com>
X-ClientProxiedBy: SY5PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: f144e0c2-c18e-42a0-a963-08dd50743ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B8Bg1YJLTPRDgKHtsLsN1NEeXyhR0EsIArOhprAvM+b9ZKTkLgW10lmcysoj?=
 =?us-ascii?Q?MPZCaFMAY6TXGzhQn0vWFYx4QNa/wMKYP9c4FzqnymiZOzKJKO0mpWDBe3X/?=
 =?us-ascii?Q?LGFjDwCVKgiwpgTy3CsZIRmQGWdiSzwtORcwTyOmSrxgyBQdgTkEPBBWUhpt?=
 =?us-ascii?Q?YHw1o3qBPiMKn89CMNz9EPUfgv31EG8CKQBw/7QyexnYzEz5rGGumFg+eaNo?=
 =?us-ascii?Q?AnltLP8JfzMtC4BPyqQivZ+qGHj/NRsML+2env1B1+Vpz3CaePaeeRuE837a?=
 =?us-ascii?Q?CarHI7xKHHFHq3hXd509yj9QebQkL5E3JfOXYQM2HoZgS/Vqm7FgF0sFyp5A?=
 =?us-ascii?Q?yjdn0jm2GBFTPi0MMBtvL9FsCQnA91TCbP9yjXQ5Sf7DBYuZsMAyJpCV9+Ab?=
 =?us-ascii?Q?uSKyr/wK6BVFK/fNYTm1LEDLD6Pus6gnff/418vq+VY1RSPRdos6CDs8d8KB?=
 =?us-ascii?Q?Gg+6PlzmkS499Xo5bwCMRpzFFInKU/CFuFmTVWX+tE5U7/r9hYxXgpPpuHy4?=
 =?us-ascii?Q?Ua/U6FQgzREoTqgdPmwJ0GLFTzBaxHERXg8DCgX3WRK/W/ZpaWLPpMSrLqLn?=
 =?us-ascii?Q?b8kl6vu2A8ntejzHEHUe094cwJalEskcL5QYvaPpE91EyOUuGc3pWWXwEuxD?=
 =?us-ascii?Q?6BxgZBpdB/tAoTkmjzgDh/+xoHyLpKIcx1Fz+5VdkJEPi7g9qrmtxmkHa8TV?=
 =?us-ascii?Q?1i11/27p8T6J1pbzgsVd9jZJiJ7n7ZQYfmuE5blTbPn6eaR5Y5lcB+ZJB9R3?=
 =?us-ascii?Q?//+Sad2L9+dgYEm2wjHXaGnQygwDlLu28tN8fMiXalUy06dWvKTveS/Thxwa?=
 =?us-ascii?Q?2VdK/sTcs89aBiZuRv2VvLzl269ng/ZIr+HCxkIrmRpbjCxn8jKQF/PZkhpp?=
 =?us-ascii?Q?VOtes5AC4dARSRoWtW6Aye/QUigsnnWzd4w7AztkrUmoFCkMO5eWQiZmLtzU?=
 =?us-ascii?Q?bGTUgOKStWzjXsnYgolohzpCIw3Ed2pDlEovoQAnWWm864REZ0q5vyeBuEZX?=
 =?us-ascii?Q?iNcEVW62stsZyL7s/k+KIW1QeBE75ddefnYERigL6biloUHYJ/w19W+YkjiL?=
 =?us-ascii?Q?YgJjU7Jp5W5+FRBaVwpr/cvdk5RnQrbL1w8YvAKuE3idSVY/x6/8gnQ8dNdL?=
 =?us-ascii?Q?Pa8o/UGaI2CMFbTg97f4BRiSa6vzlwxDWHuB75XyHOhkDA1bnA0ESCQuF5ie?=
 =?us-ascii?Q?TBK+6m4wMc43y5iKHK2o1HUNuwZguTIuMRSgXtDJhy5iFkuzbsaWOgjqoGtL?=
 =?us-ascii?Q?hDtwVs8zpYN64923KIHQGEgQuHewDZ5JE9VpDUDRKr3y9GNTnLLTv7oqDwJ7?=
 =?us-ascii?Q?V0ucPe34vpNvKj/GINMm/w19Qxz71tbj6/Y+M/BgyQEuMdho1asttv291g4V?=
 =?us-ascii?Q?2Dc9lgfc0D7/+3ICp5nppC+3xkRo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFZ1WnU71rH2mPJwtoKq7rs7IsJILwQ5zuEDAA9BESk6eJzy08JyrAFY2l3J?=
 =?us-ascii?Q?dTUZ60x5biq1VUU53HbajjnanCevOB1HrGfzyNkJ4NCO4q59WF4c8X0ltrZt?=
 =?us-ascii?Q?Lel78JG8eRK+4q9myh/GjvdVy31ws7euchMkLIqptqG2FGjT3OmGGfwhJGpu?=
 =?us-ascii?Q?SRYK2BkBq2paK8Xe+/7eJpdWmKdnRP9dWdCTrDf1gGqbvtaXf6tWvAYS3BJ3?=
 =?us-ascii?Q?mPNRV4yE46Lr2b1E8J3fRQ1Jhvqsr1gfRDMR4TMXqNPSuUgzA7mea0xy3lFK?=
 =?us-ascii?Q?GRyPxYs24y5fnW7X/YRJkk0LiCNC3usd1dhnKzPSyTxx3PzZ6odU7YulOuMz?=
 =?us-ascii?Q?kAkNplXOB7rhBKYat/vm9/T2UmZzmpTfucMe4zh8oaMxexRRQi/2VxZJjFwt?=
 =?us-ascii?Q?4MENi8s3qhO8j31qeb3leSmFK2jQkbau18iuD//6Xq8368WQf40IUD8N+xPE?=
 =?us-ascii?Q?SIETt7KfIM8IwABYVpVq+1JjHGt8WBGWyX+yhHJN4rhLtFjHJmHbPyWkE+ll?=
 =?us-ascii?Q?h2YAv8vbs/IEjPagCItp0PCo9QRXeTnGsW1Dz6aY9dFr473+mKENJCyLmMms?=
 =?us-ascii?Q?DsYWm1pYFjFbCz5ElH+Y6rgqwF/e4EppkfaxFjVYcDMqnf++sZMwlVnJRo7z?=
 =?us-ascii?Q?K9361uGgZPdh7lVlbPB6d+61ELBm/yH2RPjF8X2T7DotKWcxmVAIFOmc7KME?=
 =?us-ascii?Q?PxN2gWB5qqRj5Qxv6YX7ZdMsh3Oz7NZEeoDC6nXTCQiUly++AvSrtDKktJbf?=
 =?us-ascii?Q?KItmja2RrIL7LrROy7v2PC2andQns6P4iDORQcgdxgACS63oMuyccmzQYa4E?=
 =?us-ascii?Q?xfkgq+Ee8VjUjmaQt3MDbSeCUKjglMzANR4hybvtVCJJl5x+uBGQdBprrmO8?=
 =?us-ascii?Q?OLeBPmMe7A9KAsTqTy7nFxYOLimcgWCcgSKzR9pF34PbaYSbK0LzeAHV8pXd?=
 =?us-ascii?Q?UgZVitiFy0rpdAnnp/qX/jxehsh4PJ4k1XJyrfq0emmD2e4HTJ7tRYCfXFWD?=
 =?us-ascii?Q?0xZF2fYqScVuWJcW3+gWYTt+np1d1jOHEN6FFiqwYol1HgVdZep9rV22wPxk?=
 =?us-ascii?Q?OVl3+ebrHPcbPoeXGMETiUsMuV94QlQX86MF78VnB7ltNXV00EAVmGvvuF91?=
 =?us-ascii?Q?W5tH111L9pWimpPrssS9yxOXsvaC8NEZjz65YAjqx38zwKGyU6AbnnHTHPTO?=
 =?us-ascii?Q?aszRF94U4NHABfKtNGHJ6CrU/A3FxirSy8ox9qXHfnAaA1Y/IWwzFy7pyLu/?=
 =?us-ascii?Q?aUOECZmjefYgrDtmjEVIIvaahbOShCG5ZkazHOMGwW35XeDGZ3hmRUssoetp?=
 =?us-ascii?Q?LmQPx5ebK570yr0fhETc68omSjvJw6mUEwW4KAH/Q8B8zFx//d+0fmhX6e72?=
 =?us-ascii?Q?NCTWmhkul+9t6IuQZ6nTS6eMEIEpQGaj59fPXK3+2Q5KW9dtd0lTVb8RX6Pn?=
 =?us-ascii?Q?LJntTm7g4egElGaZgV2KMTkKVLkLh29QBDq49/jziYS5nGvbqSQijP7nTJoa?=
 =?us-ascii?Q?CHfzU9lBhpnVb49dbH42LMVAUkKG+60cTXbNuNEWJ5aBGvZPWV2pGSRQAs0k?=
 =?us-ascii?Q?ptPdoRhDpJDKGaFojvO9mNTIGb3byAdMX9KUZKyU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f144e0c2-c18e-42a0-a963-08dd50743ee5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:30:36.1511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAopfzQAHOOceK1PA9oRQjU3aGEjspGPSTQSEvuns34urOdrhYOOxmOaHKnMl+UicCxF7QVcKSbvjxdYCyp8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

On Tue, Feb 18, 2025 at 12:37:28PM +0100, David Hildenbrand wrote:
> On 18.02.25 04:55, Alistair Popple wrote:
> > Currently fs dax pages are considered free when the refcount drops to
> > one and their refcounts are not increased when mapped via PTEs or
> > decreased when unmapped. This requires special logic in mm paths to
> > detect that these pages should not be properly refcounted, and to
> > detect when the refcount drops to one instead of zero.
> > 
> > On the other hand get_user_pages(), etc. will properly refcount fs dax
> > pages by taking a reference and dropping it when the page is
> > unpinned.
> > 
> > Tracking this special behaviour requires extra PTE bits
> > (eg. pte_devmap) and introduces rules that are potentially confusing
> > and specific to FS DAX pages. To fix this, and to possibly allow
> > removal of the special PTE bits in future, convert the fs dax page
> > refcounts to be zero based and instead take a reference on the page
> > each time it is mapped as is currently the case for normal pages.
> > 
> > This may also allow a future clean-up to remove the pgmap refcounting
> > that is currently done in mm/gup.c.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> A couple of nits (sorry that I didn't manage to review the whole thing the
> last time, I am a slow reviewer ...).

No problem. I appreciate your indepth review comments.

> Likely that can all be adjsuted on
> top, no need for a full resend IMHO.
> 
> > index 6674540..cf96f3d 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
> >   	return xa_to_value(entry) >> DAX_SHIFT;
> >   }
> > +static struct folio *dax_to_folio(void *entry)
> > +{
> > +	return page_folio(pfn_to_page(dax_to_pfn(entry)));
> 
> Nit: return pfn_folio(dax_to_pfn(entry));
> 
> > +}
> > +
> 
> [...]
> 
> > -static inline unsigned long dax_folio_share_put(struct folio *folio)
> > +static inline unsigned long dax_folio_put(struct folio *folio)
> >   {
> > -	return --folio->page.share;
> > +	unsigned long ref;
> > +	int order, i;
> > +
> > +	if (!dax_folio_is_shared(folio))
> > +		ref = 0;
> > +	else
> > +		ref = --folio->share;
> > +
> 
> out of interest, what synchronizes access to folio->share?

Actually that's an excellent question as I hadn't looked too closely at this
given I wasn't changing the overall flow with regards to synchronization, merely
representation of the "shared" state. So I don't have a good answer for you off
the top of my head - Dan maybe you can shed some light here?

> > +	if (ref)
> > +		return ref;
> > +
> > +	folio->mapping = NULL;
> > +	order = folio_order(folio);
> > +	if (!order)
> > +		return 0;
> > +
> > +	for (i = 0; i < (1UL << order); i++) {
> > +		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> > +		struct page *page = folio_page(folio, i);
> > +		struct folio *new_folio = (struct folio *)page;
> > +
> > +		ClearPageHead(page);
> > +		clear_compound_head(page);
> > +
> > +		new_folio->mapping = NULL;
> > +		/*
> > +		 * Reset pgmap which was over-written by
> > +		 * prep_compound_page().
> > +		 */
> > +		new_folio->pgmap = pgmap;
> > +		new_folio->share = 0;
> > +		WARN_ON_ONCE(folio_ref_count(new_folio));
> > +	}
> > +
> > +	return ref;
> > +}
> > +
> > +static void dax_folio_init(void *entry)
> > +{
> > +	struct folio *folio = dax_to_folio(entry);
> > +	int order = dax_entry_order(entry);
> > +
> > +	/*
> > +	 * Folio should have been split back to order-0 pages in
> > +	 * dax_folio_put() when they were removed from their
> > +	 * final mapping.
> > +	 */
> > +	WARN_ON_ONCE(folio_order(folio));
> > +
> > +	if (order > 0) {
> > +		prep_compound_page(&folio->page, order);
> > +		if (order > 1)
> > +			INIT_LIST_HEAD(&folio->_deferred_list);
> 
> Nit: prep_compound_page() -> prep_compound_head() should be taking care of
> initializing all folio fields already, so this very likely can be dropped.

Thanks. That's only the case for >= v6.10, so I guess I started this patch
series before then.

> > +		WARN_ON_ONCE(folio_ref_count(folio));
> > +	}
> >   }
> 
> 
> [...]
> 
> 
> >   }
> > @@ -1808,7 +1843,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
> >   	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
> >   	bool write = iter->flags & IOMAP_WRITE;
> >   	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> > -	int err = 0;
> > +	struct folio *folio;
> > +	int ret, err = 0;
> >   	pfn_t pfn;
> >   	void *kaddr;
> > @@ -1840,17 +1876,19 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
> >   			return dax_fault_return(err);
> >   	}
> > +	folio = dax_to_folio(*entry);
> >   	if (dax_fault_is_synchronous(iter, vmf->vma))
> >   		return dax_fault_synchronous_pfnp(pfnp, pfn);
> > -	/* insert PMD pfn */
> > +	folio_ref_inc(folio);
> 
> Why is that not a folio_get() ? Could the refcount be 0? Might deserve a
> comment then.

Right, refcount is most likely 0 as this is when the folio is allocated for uses
other than by the owning driver of the page.

> >   	if (pmd)
> > -		return vmf_insert_pfn_pmd(vmf, pfn, write);
> > +		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)),
> > +					write);
> > +	else
> > +		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
> > +	folio_put(folio);
> > -	/* insert PTE pfn */
> > -	if (write)
> > -		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> > -	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> > +	return ret;
> >   }
> >   static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > @@ -2089,6 +2127,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
> >   {
> >   	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> >   	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
> > +	struct folio *folio;
> >   	void *entry;
> >   	vm_fault_t ret;
> > @@ -2106,14 +2145,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
> >   	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
> >   	dax_lock_entry(&xas, entry);
> >   	xas_unlock_irq(&xas);
> > +	folio = pfn_folio(pfn_t_to_pfn(pfn));
> > +	folio_ref_inc(folio);
> 
> Same thought.

Yes, will add a comment, either as a respin or a fixup depending what Andrew prefers.

> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 2333c30..dcc9fcd 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -209,7 +209,7 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> 
> [...]
> 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d189826..1a0d6a8 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2225,7 +2225,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >   						tlb->fullmm);
> >   	arch_check_zapped_pmd(vma, orig_pmd);
> >   	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> > -	if (vma_is_special_huge(vma)) {
> > +	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
> 
> I wonder if we actually want to remove the vma_is_dax() check from
> vma_is_special_huge(), and instead add it to the remaining callers of
> vma_is_special_huge() that still need it -- if any need it.
> 
> Did we sanity-check which callers of vma_is_special_huge() still need it? Is
> there still reason to have that DAX check in vma_is_special_huge()?

If by "we" you mean "me" then yes :) There are still a few callers of it, mainly
for page splitting.

> But vma_is_special_huge() is rather confusing from me ... the whole
> vma_is_special_huge() thing should probably be removed. That's a cleanup for
> another day, though.

But after double checking I have come to the same conclusion as you - it should
be removed. I will add that to my ever growing clean-up series that can go on
top of this one.

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

