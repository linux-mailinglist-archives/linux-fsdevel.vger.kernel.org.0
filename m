Return-Path: <linux-fsdevel+bounces-16674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD98A1496
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D16C1F23D59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207914D6E1;
	Thu, 11 Apr 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dCtpO4UJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518014B081;
	Thu, 11 Apr 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838337; cv=fail; b=ehKuszNhRoCqdrOlHsEVp5CCiWKPk7Qn5jL/VFLbytLv2qXi4f1vpuwPCZMjVEyx7lTMKYsGOg4CEsGVXvUY7z5JWAxIvxvxs3cYKaKAfIBoo3WADLoQvrn3Yan6IQq+0rro5eW936ghyioz+oBP+RYqv6G5L0SWg9C33mK75Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838337; c=relaxed/simple;
	bh=1XrBaKSy/Y9JiK1yi92aofKH93MvxCqvPi5GHK4vCyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8TXrubBdzlUZd8Yn9zVdZalTyWbCq0I8Xj+2HSRcsKd/pELTwy0dDwnq5CwNbLeqLzyN5KdLlrXlDT4DmWzPDqU5wAKX7tzP7pV/VSWp4AO9beDaH8q8LwkwzQnzIua0KJRnspiv0v2F1pnJsZoVWNzH6VrpulKsg2FuHpO+2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dCtpO4UJ; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvbqQ2zLf9bzC8rp7KUaidbLXIoVZF3ERYNLFhWIKONZg1Mqzj/s5Ti1ycqFlRIJj0fvivvn9yK9zMnBeJs4+mSadbiO5LuH3ieEQwjTpZdzTVX2HMpuqF6qNS7KWaRPhO+ITggHGHecAQ56XZGzXB9t+S4jkHW6JX3WLYaOdp3FPxGCQJAvI07sLYa1s39hBC2PmIyCrWRrY1GLlfNCv/Va1Vx/Q3Rvow30mEYQGVIbQDNsLRdsFbxn9zfDzQCU8yfjnn81XO0I2UBKt9QB7t6FoBlsrWqygTBO+bpzueuT+a0APY56Hu3jM9Ir1elNSf0FfqXVzhVUG5A/iITNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ficEjny52fzs0IMfRfVTOVPLqPakGktR5kcEbGvV30s=;
 b=ZUGqHT6VVfwbXcDp9b1NAVZDCulF3fx9SiWd+VviCC4csnmlH6+E72sTn5t1DDEvGBPMT58RwvqxUVi+A/wTh2WgkOE34NOSxdPVkU6VA2y5ilpxqFVOvtz6Z+OMPfLuvupgT8nrBP+VTQLv+fBw1iwPEVhhQnFtaZyZMtopsErjr1+IR6ngudicfOfpeLSp9Li0hi7bcaM1BdhzOhaAZF7KNMUTIuFd10TMMD4QEcGyMiqazTC1DeSUsswH+mEhxPnkhSzJA6SzJOtWWLJJFWSjjLvnWQqFOMB347Ti2qYSbHJ6G+z4HyE7uCzZZdRICdlvmY4gqnlCAhT4TJUj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ficEjny52fzs0IMfRfVTOVPLqPakGktR5kcEbGvV30s=;
 b=dCtpO4UJEc7/JE0P4BuG9LWXLkrhCjqk10+27SEjsWcRqpvUM3DnoFrK+Ou8xOGBVBxIhMAYPqzDc4mkB6kbn6lfFW9lm8j/ukTkwmw9x8K1s0Pp1mbGUXGU0iEivCkJ8L7Xd7YKaAy3YWhqOt0Are1G7fUm0gawOzAdS+al4OptA6CFRXcDrYtqKuilXKSOw+3UOM9L0i22P/VcLwnK5HHPfs/Os09MlREH2d8us1x5NSHo/URqPHXRAnnNi3d4U0Fv5dwv0qWUAWSSBUYs0z74AzXYk+Fj/b6IlpQr/ddNsF5gtNlEdlMtMsyQdJxaXbpxq5oS15gfCFiWAQT16w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 12:25:31 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:25:31 +0000
Date: Thu, 11 Apr 2024 09:25:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 02/10] mm/hmm: Remove dead check for HugeTLB and FS DAX
Message-ID: <20240411122530.GQ5383@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <e4a877d1f77d778a2e820b9df66f6b7422bf2276.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a877d1f77d778a2e820b9df66f6b7422bf2276.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:160::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: bc053445-de45-4a9b-58a3-08dc5a227ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bP3j3/4B4+6ZFPhPBDbLSYXOJTOAv51xdrpEH6frWb0umDnWU8lKKb2QzKWBS2qHT3Zu65XOwh4AK090I43DFiZXWfy5KyvA7rLF4zvHdtHp01WqzjRCgeqoO/4Bb619rv1E79elL8W4VsObntZmFoSpW6pAyA9lA0DHU0um9gZRF5LltIlzqqlQP0/sLrEVa1Pb0LhvVNeAo5x+VsYEWMBQhc5O5yMiJZkcNCbtuqprLvH2vc5KlwtKh6BLQ3s5SWe+FQs7lc1iIQinQUaSOjMk2znKAsWCHYnTCRatupyU6QlIIGWq3mbPvgYL/cIHeE/k2OZeOq1KHEx+FLhvA7KLWUMy5AX0hkHgsBqM4BjbbeSxHE4o9fpc05eBMyXtaINq12vWIUAbARKKtCHLw/s4eHnv62ZjN0K605mBrfMPMrfyuQxoD4V6vvwdo5zjvcF7CPCuawGiYqcg+VA4F1A4ysT6GdRaSLWmb0FojZzgxbv+fpvSx1p/xaJpmxeAUXeiL/4Hm1Lu60gHsHvAYyk3KWL1LdI/0bKOMG5eVjnD4kPSv4c63szN3DzZvgGMx5tuoyl3IoQiwgb07/vhLy+H33RlaPSh3NifcNvpTVog3VyizQJKxdAgJY9vlEZzqWvht4+0HnA+G8WbUPZtLsb7SkxeFW1jP7gEtFiO36Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LAoaX6MAKUWG7RHQNFz/KIM0RUU9f/UhiiH27Tl0Cth5RYz9J1aSnLqt/O/?=
 =?us-ascii?Q?MM2jVH5ad9DaFZfvDGvQrjzp9G525HwYtn7Hxg3s+pAJpXDMXRp2WGWlgB+z?=
 =?us-ascii?Q?tIpKAL6EyQd+EkenP1KSqPYE+y139Fx7sdY0I/0XPM8gzD2ZnaDGEuQ6NYMu?=
 =?us-ascii?Q?0Unrm7hjwVvpdAbX/WIM0504OHGYaUMgLWV/0mf6EDpY+FhW5U94R8Dk18wd?=
 =?us-ascii?Q?AGnJ1JkwciLnny1hAzdRW096Gp8yVOyZ/iWvzKWDuacdtDh8X3meYf/H46DV?=
 =?us-ascii?Q?wOPKP0HFgw6K6VBqStx7v/7anZh/P3ry3M9lqQBPPJ+L4si2+n1yaC9yvC2E?=
 =?us-ascii?Q?+yldcQJlcNDssNIhTyEqdY7k+148x43gdCvm9QGiPOvzF05eI9vFlRYUMdp5?=
 =?us-ascii?Q?xnHIpqhg19MnFDLYLOF6dVn6we3MHYtJfvFys7XbcfGYMXP/NrkMNuLzZxX5?=
 =?us-ascii?Q?1/Whwfz0EfNxw9/111GsOK2cNU0tqiyBSXFCLhPSryEJqJmuBk6JA66njT1Z?=
 =?us-ascii?Q?FLv7CeIhvevMh7WP5aa6FxFJkeGM6PYtuSEn3MoCu20XIatPCD08AaXRByqg?=
 =?us-ascii?Q?cSeq7tGCkf8eUQMN7SNmIz1vTtb9HsBCcpLSvHdat08VwzX383uNHTOHzu+f?=
 =?us-ascii?Q?QwQ7qJ2u/QKXjeqcMiAJj+0qrDC6y4kFJmkqL7czljhKYUTArNj981vAFekm?=
 =?us-ascii?Q?G39b3MAc9jH3+fkej000i9p1DVIKHyCee+UWwK05J7s6/ieU7ABJ0PZbuBG9?=
 =?us-ascii?Q?aAujn9SBrnF6hAGuEfRcFySO3s6WYP7f18zNuXTvzwPdafRiqv6mw+nHfHDp?=
 =?us-ascii?Q?Z3Tphl/0RD83QvhwgU6fShezGTbRg/YccxX/eTjk/oF+HcJk6cT3RU/RT211?=
 =?us-ascii?Q?g0+cBxG1asV7816EjC7DtDucgU7MygUGI+8QPQIS1Fb+gvqtZOdIawnUPnRP?=
 =?us-ascii?Q?ObCMddAKhkWT2jYiZwL/baVrrkBUaGZ2bcWRzEZRgDN01ehLc2XiNzle/Dea?=
 =?us-ascii?Q?vNx+F93Ub4FsAIqrIHDcwTGdfYQ7TQ0WHefKZIJsyt15eWaM/hkqFORE3HcC?=
 =?us-ascii?Q?heZlMOmmk8LWHUEEwpdJ0o/Q2yf1TIn1JBOq8U3qC/5JTe+QNquV4n/AEbxB?=
 =?us-ascii?Q?TzUJooRueQItZEOSeSE/bpKn/Yja4OuMZ1TjXOAguMV4MPuFcdlrBI+H9C76?=
 =?us-ascii?Q?ah9iOaxPpaE2Mi+p/1Q9YX6ef/MjNkojIdO7PgCHWKaByn8NFdN0qwDf7ngs?=
 =?us-ascii?Q?lnLEwQdgn02RI8m+CGFadORl6+5tfEsB8xDNoT550V1BplZfDWiT3kaX07FH?=
 =?us-ascii?Q?6bPVzuOYjZYlpFpIdrVrMMhpPSZqaKv3qetsrvaJoyag4/yPytOtzPXfutvW?=
 =?us-ascii?Q?Mh0vAK7iIBotNmK7VPTrv9cX7/Rhu9nQn0+zEq1cbFojQ2+ZSHnELbl4b3tl?=
 =?us-ascii?Q?yMT74n/Azwy/hiARYiTnSfPZBKDb4gRyHuMOx3LyaB31Ju1x8TXD6HTYke+9?=
 =?us-ascii?Q?1mhjDAU5+ENeHTFQVpE8AmUm+BkHODvXmDvES3IRRrcqFBKtqdbwskZR7G19?=
 =?us-ascii?Q?ttQAbpAumbBNDULTtQI4pmSNc5z2RHOWSfZiBYtY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc053445-de45-4a9b-58a3-08dc5a227ae3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:25:31.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUYDJOCEJla0TXK9HQlvWt7Q+Tpxqz5kOBu1PPVezglagM8OLMDcFSnP1Nh07tyO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

On Thu, Apr 11, 2024 at 10:57:23AM +1000, Alistair Popple wrote:
> pud_huge() returns true only for a HugeTLB page. pud_devmap() is only
> used by FS DAX pages. These two things are mutually exclusive so this
> code is dead code and can be removed.

I'm not sure this is true.. pud_huge() is mostly a misspelling of pud_leaf()..

> -	if (pud_huge(pud) && pud_devmap(pud)) {

I suspect this should be written as:

   if (pud_leaf(pud) && pud_devmap(pud)) {

In line with Peter's work here:

https://lore.kernel.org/linux-mm/20240321220802.679544-1-peterx@redhat.com/

Jason

