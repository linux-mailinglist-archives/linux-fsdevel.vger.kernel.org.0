Return-Path: <linux-fsdevel+bounces-52142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB346ADFA52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A13417EB02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAED17C21E;
	Thu, 19 Jun 2025 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qrSl0Iuf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B9152DE7;
	Thu, 19 Jun 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750293705; cv=fail; b=JXd4ppJTT+9/mOQolBuwtPVLNqcdcjg52D56wVKILKkIRe46OwBINVWGMKERu8TF4b7QFaNY/zpFaRzfzcu7f2j5S0QhDiBGEWd27QMNwOIA5G51retmGGREhApxxAzhbIO+btEHI7S5pFGgKVrQHUAaga2d63my0ZiZXIEpJZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750293705; c=relaxed/simple;
	bh=W7xh3dRw0IJJ5yKjR0iMr/+XDdhbPd9XJ6/iIqH3s64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B30etif7vRq1/53UCmqeSOYCD0nnMimXOCkeL+TPOApkei89D4WcUCHt3B75efRDaVBIJ5/fuk4sLqNbYZs/k0aMEk5fo5oeu0w2URjQVXys67tZDZXPyO/xueOpNfBslWd8mE9wUCuii7zDSJEHE9qOLi/lTxlB6ZmA9hyeyEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qrSl0Iuf; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui0dDiHWQ4B83sLohfbyz0t9lkO5t9UCIgDp4mu+A09n7JfHNASeTxthu15libS3kiGB85GVHe6Z7nUwiTCMJTQmln0/0j8pjEAwRsX3agwooWrQZzSdOB4sY/eQorD7kwXgQYRWby5qXigWk2uMs+PD+/GiTfrUBGj0tdefhVnaum/TULuOcZY+IxLQBLBbAbPXoNNe7/U+wBN9wRhg7rSuwRIQuCLn09ORxTw84Iu6LiGeaAEHf/U4CY3FmZ7sa4LYlmMp+NunKCBgCSgnFkeja1kZ47wUcjIavX06Tez9RyyXv2MZDSU1KtnycSG6/gbbxx47/N821lol88ujxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRlzqkTydM6SNii5dBh2dvD9J8DDJqQwFzUxGEbHsa0=;
 b=fIGAsAIYHInzBucf9eCV+l+tsHU4PfnoIai9IiLjrdOrdlrBgQ7/b/oDso/yzq+sW/9wROk0Oj9Wo/GuuMzM5ddtLxpLjYS3S9P2jDg7C001D94Kw9NZkTjeiLVKnsRVBTGJxg8KUkknsiD9pDlJYnH30nkI8voX5HXVTttzNwws0tdT/TyHsOR8AoxclDaThSyPkV80WdaM+7XtDt9K/TQoxdiOOlNtbO+izPVRuAlWRWId9mhzTVnNHJ1+ouoXMQPrSdq8iRJBf5kLXeaIwP/Hf3bnevRqJnc0hEH4wjFdZov69NpOxZuDmPZUCa0yQ7G4KFY6YP6mR6hVUII5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRlzqkTydM6SNii5dBh2dvD9J8DDJqQwFzUxGEbHsa0=;
 b=qrSl0IufcbbxKjUjt5RoQNov/TZGg94C9wkX4mc0pop+fAu5WdRfibvRqf9XUCMOoJCDyFEyp+SjMEZ73kHVnhfS591LpoysgbZhyogUSdtAigks0DIr8ulKGgxmFF/fNHj6a0U7/D+l7fj80IwztTIT5Ascwrvq1Wg3vx6B1g48ivgtG3RcI3gt3DeFHxr7y8MTLzw6+pHvb0bLKQxdmuOyoqJUhjTDDeXRfDQjtoRdI46KtqXVLw4O6xl65dVDMMpyY7b6QA96p2tvbZBLU7ao53QxOuokz3jPE0SwSZb50itYTwlk6PS6LZHlCiu7QBW7alCd581xEkHamjNu3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 00:41:40 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 00:41:40 +0000
Date: Thu, 19 Jun 2025 10:41:34 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, 
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com, 
	lorenzo.stoakes@oracle.com, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, John@groves.net, m.szyprowski@samsung.com
Subject: Re: [PATCH v2 02/14] mm: Filter zone device pages returned from
 folio_walk_start()
Message-ID: <5vxfjvgl5qu6n5qzru62mmk6saudeslt5f6fu4luhuezf6lh2p@dhz65hzro27h>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <11dd5b70546ec67593a4bf79f087b113f15d6bb1.1750075065.git-series.apopple@nvidia.com>
 <6afc2e67-3ecb-41a5-9c8f-00ecd64f035a@redhat.com>
 <b67f8dea-dc22-4c83-a71f-f5a2ecc8a8d7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67f8dea-dc22-4c83-a71f-f5a2ecc8a8d7@redhat.com>
X-ClientProxiedBy: SY5P282CA0097.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::7) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 615f7ef9-c92b-4adf-5cdd-08ddaeca0dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1R1FTHy6TStft9DyrmAoYI+bubnzGBmcfQ706HNOSCAcegatG7wxbXBxA7ZF?=
 =?us-ascii?Q?cZoYVI0lfiQVn//I2QFUaGiapD/tUZxhFIDuobtjOd1VlY3J9ye8pxAdIpeC?=
 =?us-ascii?Q?44EboM9t42w09xhO7ZxgxhfX5D3zeN5PeiroOeti9e6yKRXc0MPibrdzuWU6?=
 =?us-ascii?Q?zctAC6ttd3gs4GZaJfFGQHSqrDbG85/KmgwL9HuNu9S9mZsWBMIV2yorKif9?=
 =?us-ascii?Q?ZdcNHUNqEwKi+pIVSFKxkDEvRGeaeliY3c4CoNorsNXEYWrUg3+2kQiTfrK2?=
 =?us-ascii?Q?nEuJy7Ilo5LOFJRZryPqsiGzdh5kSnzHaccJuxOVWtJAJGQ9BUlflAi92VL/?=
 =?us-ascii?Q?IuS13Xm2Uv2nTS/rmTAMjnSmYaJw9F4WqFqL2hkHBNbDH80957END0fB7zgr?=
 =?us-ascii?Q?wzO/lyLi0O5E6vMu8Wy/q3KvOUJRyJqxHy3SlnUSk0An8w03Vpbth/sYNWX6?=
 =?us-ascii?Q?qqSOEFPsht4r75vHr7z1wqXxo0cbhfT1mMuYOTPAh3vU4p1ljlqfCUIilNk+?=
 =?us-ascii?Q?XOSNxqRBXBzjl+JnKnzshoXyxN7BF3BdFt7+cHy/x9wyzra0cpQ3EHMqQX45?=
 =?us-ascii?Q?wwzmx1VfZ5cPEQSxvx7pCqYxQJt4LhDMY3adaj6bAzr+5qozFg7O3H/MjUy5?=
 =?us-ascii?Q?hRNN1zbWXkhvklH30W4DLIBQrSj3O719ocDOhu3MVXepaH2pxa/8hEUedlE/?=
 =?us-ascii?Q?YugAKdR1v5c+C4JeiWI3MDi4QTnInNi6IwH3jV1TNp5oEDsO4Pcv05oOC5IQ?=
 =?us-ascii?Q?7zfVzMcshtNlmEhvJX0lAfmhrWsggJMWTQgC4pOmmENdWRDyiidSQHLFYLuN?=
 =?us-ascii?Q?a4vOnKAlX/UEkrvKUAb0jzNP7+yTR3AnPQX8srZ4LHcg67pdA4Ds4H1/YG+D?=
 =?us-ascii?Q?Ay+JYOUF/vVgHRunCoAQXGF9wAMzf7q43kJaCOreg526NFhIsXENsWdr3AMr?=
 =?us-ascii?Q?0vygMoSgKZ5SUXK7eRUsP4x+HE4zoUg4ji5m0JXJwRDoIhuD8X5rrWrlsTe+?=
 =?us-ascii?Q?+neyJZwrvorerZHtQ6kEDpcGT6QxOOhjBgL3RP4znPYAY/SU/nBEGj8ZXGy2?=
 =?us-ascii?Q?SSz4UCzbJMfy2PkA5AcN5Ax2/rNZY+OlVA4eEvj0IW1N5Tt3qGPinc3H7bTf?=
 =?us-ascii?Q?KwlGEvDCYbf07smlmQuRjBNlkvC//95H8SvJ2F4x44m5WabArD2x7CHVgfWd?=
 =?us-ascii?Q?e6Gky72d80mRlPAl53EuNGm2B/hGFX3HOt/iXeDe2A+DuQnJy199Ez3VczaM?=
 =?us-ascii?Q?iN82hPUlPPV+Z1qJOdH1iV2sYAbPCqczX5ksrNn5h9PmHmVLbzSorKGY/G90?=
 =?us-ascii?Q?qBZvknvRhGG9Q5Yyr57xYAAHKbaITEr7ea1vW3++lsGAtKiRtPkvAyb3JDAi?=
 =?us-ascii?Q?BAvnKtg1dJmHql/uaQtKkOeSo3f3BY8mefv2+ZsBBHTlrR/6YD/fq/FWIRhZ?=
 =?us-ascii?Q?iNvxQjP+2iE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HwXrLq7Hzr6LUA8gi5u+hx+e4ANBsaMzJWL0DZJ6/+sdwbhF0VuHl4zgRict?=
 =?us-ascii?Q?uL2CDhHlmv4v8ZU2UaAE6IEmb8RYUDesXtsCXd01ExAM/GojhgYOaJLvcqcx?=
 =?us-ascii?Q?Pw23FBwxuBUiyCRF+oq5S9P8Mr4VT0OQe8ku/y44grNxjlKAprnml7+7S5AP?=
 =?us-ascii?Q?18w3teNEYsnJk97kWTNuH34RB9DO4HStlszRh8Hjh9yQbqyrZ2VQSVoEd/Gr?=
 =?us-ascii?Q?eT8EolsJ1tHTUDHWiQHk5xQ2gVrz5TDzsqPwLSZuxKxD8571SgM2TwGzrWh5?=
 =?us-ascii?Q?SYCSwMocc9TjuaQckRrB5k/+Dz11b82e5EGZqCq61Gszb1ZmVj8qS9aPA9o5?=
 =?us-ascii?Q?n3lgYdXnV1x5yPqYEDqW5cLOgtO9d3cCir3Clwp3OVG0fIqiHehhc8bL6+wW?=
 =?us-ascii?Q?Zhd6iUoOBzDCuYB+mkeoU7cERX5yA+AlIfsBK987gEJnJw8EUqISEvHCxjyJ?=
 =?us-ascii?Q?OmEwaPLH22/64cE5tCH9vf9Be7/WP1upLNNYxfl0kUa8tBnqB9D96VnjTeF3?=
 =?us-ascii?Q?geUdxgcLqpfmQqq6NiF0D5zr3+4mtqS5oqPGbi/Sr6pjWYos/TD4ayGHvaAz?=
 =?us-ascii?Q?5H9+sh24PxGbqRVuxPsJlNSBQePtWkvVHKswAC7BY5RaYs+8LPHc6Qapre7p?=
 =?us-ascii?Q?Q4t0CGlsu4zOT2d0FbAEA2sSTSpH9ssQK5wU5YFl7u42HQzBg2aC3eYh5xaa?=
 =?us-ascii?Q?IABlgQHIDN86KhjI9S3cmJdlWUubwKSNATZfaH7yQCoavQYEe3FehfvFl+dr?=
 =?us-ascii?Q?SftR23s+oMb5v+5aZXYh8bAmqaqHFLa1Dn62ebYlYBglaEkvORvQbr2yX/vo?=
 =?us-ascii?Q?M9jrx2wwSwWAw8kD2OG3st1YIXPoeE84ZYVNzaVEg9gAW2h0wxVvlWePGaNN?=
 =?us-ascii?Q?lTCXaR3BUnbBpGyZ1rXbvanbQko2SNY4P85sjsMEihKNb9GSHOrfL5OfIMTP?=
 =?us-ascii?Q?PC2VH07S9S9c6ky0KAwZ1g9OVXH21wShC4mYaStcDdePu462LylLEyPYwiPZ?=
 =?us-ascii?Q?eDJQg0W2YloYPhV8OXXLa3Kw8sHkEEnUVap2DOYX1iN1LBNC6h+5ZFTx7X88?=
 =?us-ascii?Q?atSbRhXdQUs2PC9GxSOT8sP7zqf7t6XCinqNO89Zt6MpeJ/W57ioyg6a0fGF?=
 =?us-ascii?Q?Q0nyawkmNxrkzk5miry54vhWfAT0+6UtsCNIfEkBtMEotqwWJ9aQ22JVGKrs?=
 =?us-ascii?Q?Y3x0TB3SaJC4EWSj4oWW4zzhSCvqv53cmAQBOa+0xNT+vpb9SLqeueM4xG1C?=
 =?us-ascii?Q?bvmPPi8juEQ52ornj1AMzs8dUvvuBbCR7Ls3DbKt3+em8sKO3qrsJNFbt+Bg?=
 =?us-ascii?Q?+7bYT2x/X3QVjqJ9AmIYPuQF9DV0bCRIe/h9ItwYAKgWvAPYA0nxHWtizqgi?=
 =?us-ascii?Q?jOv8eVSsyMhSMIuZyeaVTkVu4JHgUOFxNxddTKSfIBbBLqBQaT2o9xV9UK0c?=
 =?us-ascii?Q?V7qk616x6k6tgc9JCjXeybD9n/OENNk3DzJoKiJYbJhmByKqrQCIsxnnxxrO?=
 =?us-ascii?Q?rjGw1XHRDDZk6rpK2OSj7eDyPrvTAE52HqK9QlXL/7qU9ms9VhnkeZYRaMcH?=
 =?us-ascii?Q?gI/QeHtgpOG7ETrKX8P/8iTx+S0ZRMfGDHp0WuXs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615f7ef9-c92b-4adf-5cdd-08ddaeca0dc2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 00:41:39.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16b0Q8jT3qpWEQt6p4/95YWilrUUdjmh9BWAwcSj1YsqG1YlME3ti5BrKWmVrPwtHU1KPzVcmk6od3seXA8L5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On Tue, Jun 17, 2025 at 11:30:20AM +0200, David Hildenbrand wrote:
> On 17.06.25 11:25, David Hildenbrand wrote:
> > On 16.06.25 13:58, Alistair Popple wrote:
> > > Previously dax pages were skipped by the pagewalk code as pud_special() or
> > > vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
> > > refcounted normally that is no longer the case, so the pagewalk code will
> > > start returning them.
> > > 
> > > Most callers already explicitly filter for DAX or zone device pages so
> > > don't need updating. However some don't, so add checks to those callers.
> > > 
> > > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > > 
> > > ---
> > > 
> > > Changes since v1:
> > > 
> > >    - Dropped "mm/pagewalk: Skip dax pages in pagewalk" and replaced it
> > >      with this new patch for v2
> > > 
> > >    - As suggested by David and Jason we can filter the folios in the
> > >      callers instead of doing it in folio_start_walk(). Most callers
> > >      already do this (see below).
> > > 
> > > I audited all callers of folio_walk_start() and found the following:
> > > 
> > > mm/ksm.c:
> > > 
> > > break_ksm() - doesn't need to filter zone_device pages because the can
> > > never be KSM pages.
> > > 
> > > get_mergeable_page() - already filters out zone_device pages.
> > > scan_get_next_rmap_iterm() - already filters out zone_device_pages.
> > > 
> > > mm/huge_memory.c:
> > > 
> > > split_huge_pages_pid() - already checks for DAX with
> > > vma_not_suitable_for_thp_split()
> > > 
> > > mm/rmap.c:
> > > 
> > > make_device_exclusive() - only works on anonymous pages, although
> > > there'd be no issue with finding a DAX page even if support was extended
> > > to file-backed pages.
> > > 
> > > mm/migrate.c:
> > > 
> > > add_folio_for_migration() - already checks the vma with vma_migratable()
> > > do_pages_stat_array() - explicitly checks for zone_device folios
> > > 
> > > kernel/event/uprobes.c:
> > > 
> > > uprobe_write_opcode() - only works on anonymous pages, not sure if
> > > zone_device could ever work so add an explicit check
> > > 
> > > arch/s390/mm/fault.c:
> > > 
> > > do_secure_storage_access() - not sure so be conservative and add a check
> > > 
> > > arch/s390/kernel/uv.c:
> > > 
> > > make_hva_secure() - not sure so be conservative and add a check
> > > ---
> > >    arch/s390/kernel/uv.c   | 2 +-
> > >    arch/s390/mm/fault.c    | 2 +-
> > >    kernel/events/uprobes.c | 2 +-
> > >    3 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > > index b99478e..55aa280 100644
> > > --- a/arch/s390/kernel/uv.c
> > > +++ b/arch/s390/kernel/uv.c
> > > @@ -424,7 +424,7 @@ int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header
> > >    		return -EFAULT;
> > >    	}
> > >    	folio = folio_walk_start(&fw, vma, hva, 0);
> > > -	if (!folio) {
> > > +	if (!folio || folio_is_zone_device(folio)) {
> > >    		mmap_read_unlock(mm);
> > >    		return -ENXIO;
> > >    	}
> > > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > > index e1ad05b..df1a067 100644
> > > --- a/arch/s390/mm/fault.c
> > > +++ b/arch/s390/mm/fault.c
> > > @@ -449,7 +449,7 @@ void do_secure_storage_access(struct pt_regs *regs)
> > >    		if (!vma)
> > >    			return handle_fault_error(regs, SEGV_MAPERR);
> > >    		folio = folio_walk_start(&fw, vma, addr, 0);
> > > -		if (!folio) {
> > > +		if (!folio || folio_is_zone_device(folio)) {
> > >    			mmap_read_unlock(mm);
> > >    			return;
> > >    		}
> > 
> > Curious, does s390 even support ZONE_DEVICE and could trigger this?

In thoery yes. Now that we don't need the DEVMAP PTE bit someone could enable
ZONE_DEVICE on s390 as it supports the rest of the prerequisites AFAICT:

config ZONE_DEVICE
        bool "Device memory (pmem, HMM, etc...) hotplug support"
        depends on MEMORY_HOTPLUG
        depends on MEMORY_HOTREMOVE
        depends on SPARSEMEM_VMEMMAP
 
> Ah, I see you raised this above. Even if it could be triggered (which I
> don't think), I wonder if there would actually be a problem with zone_device
> folios in here?

Yes, I'm not sure either - it seems unlikely but I know nothing about how secure
storage works on s390 so was trying to be be conservative.

> I think these two can be dropped for now

Ok.

> > I wonder if __uprobe_write_opcode() would just work with anon device folios?
> >
> > We only modify page content, and conditionally zap the page. Would there 
> > be a problem with anon device folios?

The two main types of anon device folios I know of are DEVICE_COHERENT
and DEVICE_PRIVATE. I doubt it would be a problem for the former, but it
would definitely be a problem for the latter as the actual page content is
unaddressable from the CPU.

So we could probably make the check specific to DEVICE_PRIVATE, although it's
hard to imagine anyone caring about uprobes from DEVICE_COHERENT memory.

> -- 
> Cheers,
> 
> David / dhildenb
> 

