Return-Path: <linux-fsdevel+bounces-37768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A594B9F705B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 23:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E40418944E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7B1FCFE4;
	Wed, 18 Dec 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UiEzp8jT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2431DDC2A;
	Wed, 18 Dec 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562544; cv=fail; b=hivs/3rCtOhJLdb94Vx7JgioSqBKxjcknoKjbmj74y3r3Co/VMGaqvGajYGsLoa8c68p1uEIMAb7QsRd91jItDP+E2zmJmwBJGhBheWtZEqo1Mla8jVXi3wMHBOTpmPKpcJCizWiu7fGDpSDuLHn6UC+2hgTIrrqakBR/RMEP9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562544; c=relaxed/simple;
	bh=PBlDfo8NcckzdIgo/99/Up7IYmDFo4DQJbETj2JVdZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XM1EpsNM6kLxL+9gYw0Molsw5Txz2x5qOIAiWh4mfO9yYWNPz4hDrEVEPGoQNZstHs3rvB3hcnd8I3PeAODpf8hFqJTMCJAmGBfCNOl1NO1CGveNegnBQkKbpHcoJg3uY6upOYpeRIEX8t7v6NkYoP41stp9eHeexE+Wyegdclg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UiEzp8jT; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmBf2uusV53pG3WWPMi9bBv9E5iUBmmGp4Pjn5FV7Z0XK8nvRZEXCe/xnNedWA0/L5UV+r4gC0tYAGPyngXngw1g0YWi6zXxEozlDDY9O80fp5TVd9DpJAP0Se0JAWlJ6+ec1exyIjcI0dxvjVMFtdnQrQVkH+DYnDtCMUs+u4SywV/ZZ5veLmP1OCe2pKwkwyY2u/yfIDeRGK9OV+XKzMI5TJp81C7SwskavwfEDwQtqF8jIQ/vxXou8zXeVD8LiPfZu159nzSZYf95jRzxkJe1fId2IZcHcRg3CKEvhQxn+8Ke7WC1HNg03qeEDg0EhCiQEogvFB0U+6hyFCk/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFMuWIeVPk2S7pzDXIHJe6MRm23ZCeaFGwzeTzwTLiY=;
 b=M59iaemGCeM3TfYX+vVfD/r/IIwhWVQLPKi6nhumGcw/KBe2wkt2A1svVCRwoWMmv7fmluAAn/ThB6GfKm6yw+CgFDvrEQaXbyJNMqZfE7B7op5JBSFfmObqlTbLyaoNCL8NFoQoN1iMo0bgDujbCwMj0g/hbX2zBTqW+URk+0AqYLWAvdF3qMl6u5fbFI3sHIFNXW4+e92PMV9EF0iJ9pZwL9YdozITfJ5v4WAamGD6CI14Is9nrtxJ0E8vntW1tFLwRNeXh+VIcK+WcmigylXVN72KDPBL/F3k6MVkAWm4Z/IPjkzMUHU0UpYdPJiJlOggWc0SL3poy2EkzyDjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFMuWIeVPk2S7pzDXIHJe6MRm23ZCeaFGwzeTzwTLiY=;
 b=UiEzp8jT5fu45A/Ato4QAlsYtegBpSGUbHXJVnWVrtX9DhZntXwBsweZpbxE4sV0CKZfn4vhq40D8Bwhgwy6E4BwTxNbDQgnygaxoeaI7jS0NSPx5vZqGFbNadtfBDrEiv9F60K7bou3FKpSizjS2mrnwR7C2Mm/TRVr9K1R/XBvhV9oTEtKSpXuIcPW8aWveNvGJH+UwfqAjLCY/sXW5HpQn6t9tPgyLpryComSlXUTNw0pixTNFHoViSK6St9p6vQL3YXOlVKlUQJXzHliLG7tJFd91n5zxsNGcmxnwHOm7kL4Zza5rnnK9zXjHNkjeFg2VChGxJNJ7L9Bc7WuNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 22:55:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 22:55:39 +0000
Date: Thu, 19 Dec 2024 09:55:35 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH v4 14/25] rmap: Add support for PUD sized mappings to rmap
Message-ID: <volhyxjxlbsflldgs36ghzartel2tu625ubz3kfed2gdwrsamt@cpfsfhdpc4rp>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <7f739c9e9f0a25cafb76a482e31e632c8f72102e.1734407924.git-series.apopple@nvidia.com>
 <4b5768b7-96e0-4864-9dbe-88fd1f0e87b8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5768b7-96e0-4864-9dbe-88fd1f0e87b8@redhat.com>
X-ClientProxiedBy: SY5P282CA0035.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0a1be9-88d6-42b2-ce62-08dd1fb717d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BebgaXS0OUPFiAAoEsQhZX/rRpPIHLB0uFRiBlPdjE+6etbzCAq9l//pZh5X?=
 =?us-ascii?Q?jWmvgnBgx/9R49BEE+/67SG8EdsP03eqgZY9Znb7y3zfRnDtTbryjTg/F27/?=
 =?us-ascii?Q?qJRHB8rYFu8Rqbu5ekDMsDM9DSd1JbxrBzkzdT64n/klTLXt5YLdBlq0ryQd?=
 =?us-ascii?Q?nTi0mVo+gp4mgf6TJcEwi654D24u4oErmX3GG9JByv3jxzp3IfPBbuBMPFr0?=
 =?us-ascii?Q?c1W7smSWaEMQTUHi9lsF9l/rm5Ck2in9eq3jksmq1sAfEmX0vHqEs49uaujS?=
 =?us-ascii?Q?COHRskgweDHTU9MadF2OCBQwwKU4yv/g1UXgNpZ9mhrPh74afC49q3zmNQ6O?=
 =?us-ascii?Q?kGz9wnFDXMoavWKFqxEDLNY41jCVRfzSC4zXUhwuVZyOQsUxSz8TvxS4GV9u?=
 =?us-ascii?Q?nTkcd3TlXzzz802u/qnBPc10zWgosdMXN859ThCJlohltD3YV3xh4Pjsj5XO?=
 =?us-ascii?Q?l5OCf93As1oLY6YQ2hE5ah4oVPM0JGJYDpn/2ZbchhZJj51d9V14zdALb4sw?=
 =?us-ascii?Q?exgqSshVgU9BwZYg8QN8yHs/0l6kepL+RNAmatW1jAomi3ZSJp1kAKUe22cK?=
 =?us-ascii?Q?Z60TImZ4UlG71YpsewWdEgqnP5GxEKrWK9gkM5B+mIVltLYTQStr3Cn4kOld?=
 =?us-ascii?Q?EjmIqlYFAMwZ2vyEzuHVHTxAzcKZq7D+R2DDmF6cGB7aNtUbPw2AjvwU3Ib7?=
 =?us-ascii?Q?Hs6T6TIy9GXMaK71nNEEfdI3+sC/FhXpxWi7FOetXi9Hsr5xhzE+fBidnu88?=
 =?us-ascii?Q?Aj8MmIrrwuy1mRf2TSroYGZ8Dtd3WqCSiQRYtKhchBT/QWExTOwbI4bEk2jK?=
 =?us-ascii?Q?fqiI+BN0PfbTndWmeVfI8wKhYSvpRSY6RJAs71HUFsx3l2pdfDDsNYrdKA27?=
 =?us-ascii?Q?/4vnIVwRyw9bEB658v+2zpoFpJ9a9A7pq1vPLezrrVcLm6XUcQtmFiK0Xodz?=
 =?us-ascii?Q?gydWP0fD2anseg7Dh3KxZy7GItwHM4CmNdWABz0bH7kFnvCjUIKyGbEEU6bm?=
 =?us-ascii?Q?L/wRq3yy7knEx5Yk/8wTk6k/hYl97fRNdYDZoKt7N9boO9TWcNkO4HkZrP5a?=
 =?us-ascii?Q?DRWCgh8+rs8NVnU5yokzVE62jbvlyNvqdrT/yOoiS00IVSOweWl5l9s+7eBP?=
 =?us-ascii?Q?GFwD9Um6IXJWit4AbfmqglvdFg3V7Rm6n+S6Wx0SVIthw3/L+yKJMkl7PAvU?=
 =?us-ascii?Q?FiPAHmY6YuK7mUviRAVkH+Ty/2tqptCHban5YUDHAsUyGcZMMSjh61f9iOI0?=
 =?us-ascii?Q?NUatIkYdon56CcR/MpRl3JgCoC+sGqrsl2eWD4GmAgyd2BQJU/MJhADugUEx?=
 =?us-ascii?Q?xiTSTzHsMaT44o/9t3eAU1Op5sB037xu63kTx9HpVMe6f1hhrl4Keo0O4/oN?=
 =?us-ascii?Q?TvOK0j+81GNzMswlE6wYoQyPVkuu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RokkYCS9X9ofB8/bulve+U6n4VVDedHgulPHCBXoccyB8snmSyRwZPLPhiyI?=
 =?us-ascii?Q?eTOQzRLV/X2GK1cR8eu0/eHiC8s8De8kwgrtgn/V43eMfTb3o5sBLfEft4rI?=
 =?us-ascii?Q?NG8XJgQVNZ9EGqU7y3ClnfZ5y1YO/14bLUOJ+bAoX4jymLW0qS3EZO+0t18Z?=
 =?us-ascii?Q?OsYjZ8YVcowiZed0AQ/d85/vIZErIhgjG/mk3Zl87e3r53hTIm/vxpD3TC5d?=
 =?us-ascii?Q?lxThEjP2UkLTFtVKCo1l8XoypwX9THFjAmF01RbkzcQx9xwYzvVNn8KMzB2v?=
 =?us-ascii?Q?CYucJec5osqvd+9EZV94pMg06YkTU0Vr504TVyiJjL5BJc4FsMWuICHwzDnv?=
 =?us-ascii?Q?uv/E0UfHbxRw3F238imnrOkYJVleh5QQbISzA237O14+n9t98U6ukQ7A9r7X?=
 =?us-ascii?Q?eP7xv9vyCyXY6Lc354+XEMSoI9dSSF8OpqpVBO8QVL+YeeXjFjmAGVSg4UFq?=
 =?us-ascii?Q?u9wIoGyHL86e2TTKKvjwv+Wqb+Gg+FXp1YTcM2URrIOTXWB8bmHZ5ZkeoO6q?=
 =?us-ascii?Q?PomwpaK7LFqhV8aisVmB8CsZRqFutWrStsqc9qZ2c31hVx8S/vCgJsX3HC7m?=
 =?us-ascii?Q?Mh7EPIvssLJDEdc6PM3tt5+3QXaYl0M9uNgv9UafES8iW2bRM5eELvLW+mC/?=
 =?us-ascii?Q?Sv06sw0YkQBLyyNbdJhi4OSdf/PSpGhDUTZZq9VLg8tGYaggQMIS1XryaC0Y?=
 =?us-ascii?Q?/M4xKYdUPKPIO1bkL2ncUCFUE4AUPUdPWsVL5NN703m1V+IHddAlxWwzYrpr?=
 =?us-ascii?Q?wzqPtiZMxJWng1WV8c3+TBNKV6lrRKQsV2Bik1wVRUQ4Er7wlY1XIvi3TwCb?=
 =?us-ascii?Q?qYtJnKSsSyRH+AAqp+jEsDchM138ceguHqXzSHkEigT72vBSzhWNU9C4EN1N?=
 =?us-ascii?Q?iW3BYgv6EfVqnVUl73t6LbtyAclI4P2C9iIiviEMf1oeEtu5WUMZuDCCyOXG?=
 =?us-ascii?Q?xrQ0LmYQuoAEadGnKTXz/vXqNdCqpNIH2AIQxRpnHIkfUnfUlhnzcCAFp/nG?=
 =?us-ascii?Q?5V+wGg0t8pmERD93Mx4SVXMOa9Ujq+yYfnCoYEtleX2dYqPyZiEnR1ojyxFc?=
 =?us-ascii?Q?dToJcVZEVHxH6V2lvG6W8+s8UYiT3XWHziyUWc6Mi2rvEAmMjf+g7HOZr7NT?=
 =?us-ascii?Q?eH1pV/sESau+JH1T7VsSnvEXyGHxsedIGnPcjFXdsdanOtDxcOWrxxFWERCV?=
 =?us-ascii?Q?ekPdVwEIpT3HD0H7aFRVqCzDVODaN1UQaqhSyEVOVS46H9A6nO6Hd1VVmJPu?=
 =?us-ascii?Q?87pXwECh0W1MtuZzSfBVOwoyZjn+DksieoE5jRQcJ7i0wK7I7YeIkeg1bi1E?=
 =?us-ascii?Q?s2lV09ofVYcFDtYKJZE9rAfy+sSAbWYPqV2ikdCLCIEpBsYHpkrAQsbWzSei?=
 =?us-ascii?Q?M7Do/ShickWlPSjtjb8GsSy9t5OPdTGOpFfBXEuSdx8EWQCxi3ctTxF5EjFc?=
 =?us-ascii?Q?7QsZ8LOk9LX1BeghwbOn9/iWVBk4zo5ezHWkCT6LeEPSy7jMzlsJyMmCPon9?=
 =?us-ascii?Q?8jCBItdCtsr741sas9fSl/LnCgZRtPNO8n35MgD5d0BEAMphnzmx2/qvymeX?=
 =?us-ascii?Q?iHIBLF0gutiZAbOH5MN+PeJ1R4bjNnVvElFV8WNP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0a1be9-88d6-42b2-ce62-08dd1fb717d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 22:55:39.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvf0BkQk9R2EJvKLO5UzeeuxtmQYV6ZiH+VKcyOmZSSuf9Up3oHiHBxWKWmgxFdt0Wz4fSQHNThcb0IdmOPwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

On Tue, Dec 17, 2024 at 11:27:13PM +0100, David Hildenbrand wrote:
> On 17.12.24 06:12, Alistair Popple wrote:
> > The rmap doesn't currently support adding a PUD mapping of a
> > folio. This patch adds support for entire PUD mappings of folios,
> > primarily to allow for more standard refcounting of device DAX
> > folios. Currently DAX is the only user of this and it doesn't require
> > support for partially mapped PUD-sized folios so we don't support for
> > that for now.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > 
> > ---
> > 
> > David - Thanks for your previous comments, I'm less familiar with the
> > rmap code so I would appreciate you taking another look. In particular
> > I haven't added a stat for PUD mapped folios as it seemed like
> > overkill for just the device DAX case but let me know if you think
> > otherwise.
> > 
> > Changes for v4:
> > 
> >   - New for v4, split out rmap changes as suggested by David.
> > ---
> >   include/linux/rmap.h | 15 ++++++++++++-
> >   mm/rmap.c            | 56 +++++++++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 71 insertions(+)
> > 
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index 683a040..7043914 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
> >   enum rmap_level {
> >   	RMAP_LEVEL_PTE = 0,
> >   	RMAP_LEVEL_PMD,
> > +	RMAP_LEVEL_PUD,
> >   };
> >   static inline void __folio_rmap_sanity_checks(const struct folio *folio,
> > @@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
> >   		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
> >   		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
> >   		break;
> > +	case RMAP_LEVEL_PUD:
> > +		/*
> > +		 * Assume that we are creating * a single "entire" mapping of the
> > +		 * folio.
> > +		 */
> > +		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
> > +		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
> > +		break;
> >   	default:
> >   		VM_WARN_ON_ONCE(true);
> >   	}
> > @@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
> >   	folio_add_file_rmap_ptes(folio, page, 1, vma)
> >   void folio_add_file_rmap_pmd(struct folio *, struct page *,
> >   		struct vm_area_struct *);
> > +void folio_add_file_rmap_pud(struct folio *, struct page *,
> > +		struct vm_area_struct *);
> >   void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
> >   		struct vm_area_struct *);
> >   #define folio_remove_rmap_pte(folio, page, vma) \
> >   	folio_remove_rmap_ptes(folio, page, 1, vma)
> >   void folio_remove_rmap_pmd(struct folio *, struct page *,
> >   		struct vm_area_struct *);
> > +void folio_remove_rmap_pud(struct folio *, struct page *,
> > +		struct vm_area_struct *);
> >   void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
> >   		unsigned long address, rmap_t flags);
> > @@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
> >   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
> >   		break;
> >   	case RMAP_LEVEL_PMD:
> > +	case RMAP_LEVEL_PUD:
> >   		atomic_inc(&folio->_entire_mapcount);
> >   		atomic_inc(&folio->_large_mapcount);
> >   		break;
> > @@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
> >   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
> >   		break;
> >   	case RMAP_LEVEL_PMD:
> > +	case RMAP_LEVEL_PUD:
> >   		if (PageAnonExclusive(page)) {
> >   			if (unlikely(maybe_pinned))
> >   				return -EBUSY;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index c6c4d4e..39d0439 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1203,6 +1203,11 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
> >   		}
> >   		atomic_inc(&folio->_large_mapcount);
> >   		break;
> > +	case RMAP_LEVEL_PUD:
> > +		/* We only support entire mappings of PUD sized folios in rmap */
> > +		atomic_inc(&folio->_entire_mapcount);
> > +		atomic_inc(&folio->_large_mapcount);
> > +		break;
> 
> 
> This way you don't account the pages at all as mapped, whereby PTE-mapping it
> would? And IIRC, these PUD-sized pages can be either mapped using PTEs or
> using a single PUD.

Oh good point. I was thinking that because we don't account PUD mappings today
that it would be fine to ignore them. But of course this series means we start
accounting them if mapped with PTEs so agree we should be consistent.
 
> I suspect what you want is to

Yes, I think so. Thanks for the hint. I will be out over the Christmas break but
will do a respin to incorporate this before then.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index c6c4d4ea29a7e..1477028d3a176 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1187,12 +1187,19 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>                 atomic_add(orig_nr_pages, &folio->_large_mapcount);
>                 break;
>         case RMAP_LEVEL_PMD:
> +       case RMAP_LEVEL_PUD:
>                 first = atomic_inc_and_test(&folio->_entire_mapcount);
>                 if (first) {
>                         nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
>                         if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
> -                               *nr_pmdmapped = folio_nr_pages(folio);
> -                               nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
> +                               nr_pages = folio_nr_pages(folio);
> +                               /*
> +                                * We only track PMD mappings of PMD-sized
> +                                * folios separately.
> +                                */
> +                               if (level == RMAP_LEVEL_PMD)
> +                                       *nr_pmdmapped = nr_pages;
> +                               nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
>                                 /* Raced ahead of a remove and another add? */
>                                 if (unlikely(nr < 0))
>                                         nr = 0;
> 
> Similar on the removal path.
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

