Return-Path: <linux-fsdevel+bounces-52923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356ECAE87FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0F4680816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BB2D9EE2;
	Wed, 25 Jun 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n3SmLE+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D12D8DC6;
	Wed, 25 Jun 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865000; cv=fail; b=LyC5SzQMZk00EnYZ2FYbEWpCBKD81pX+i891gH9tQRSoXTticP9uePoZy+CrFp+fvEJ9OWjlWTx61nVRB2+7tbkpDzSj+zX4qooS8a/6iHka9qSmSKLQl53DGcEt7bTn/dogcOxulQ/png+eOoikvkrsNv7NMHwpiRo3cLnwHYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865000; c=relaxed/simple;
	bh=lPaX6VwuPLlgm3ehDIThskH3vqgq7ZBbXeYwtrmNM7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eKkffrw0hJ9tqGM6WhqzpYGToQ00kAZOsFqB6JHXqhJdiJw5GZYBIx1qE+cbAdKdeBetNvlhvzmdIdloh5gzBRc7WgpOt+QqPCWdSb1B0v07SAVzMXAmcR9/7/XCOkBpT7DKXAv2Vgv/IR2kBMXXey//FXxcKIrqcsFz5yoBnoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n3SmLE+o; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3zXH8Ua9c7w0zwhYY76dBq5sbagQHfJw9GJhZvG5lv9RvnlatjHM7qV9vbdrH8pfRoAFsZTdu1K74Q+zjpEGmEvKtsbr9wetjb++rFCC5aiRV7EI6dRass1ASOP5aC3mn5T+57wj0wM4bKjNnkHE2TNAQZsD9M5snfQYViKQsFB6YGAQ2bUlysEPuJNVT5go4uACvbRgJA841mkBL+yTrMyBUDU99TXxbfz6Gmfv1cu3DZcZcQ+LnORESX4AeKePgCmjitYP3SGmMlQp37VVpDNIx9z2UPYuxeNDPAoWDFDwhIprIlgtpRLnWisD3feb91FNe8A8jJYGHk36zNNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXzScJU2rC2Bu7kFjsnYIPv5iXyNZuw0u2TTTmebMZU=;
 b=uevbc/OR0j0uqNqn1iJ8U/MAw6sMSYXRKv0ysA3XCrWz65rhBmEgpQEmJ+JPxjOFDCxMp+oZU5ksXtUB+k63zbDDA2fkXCQtHnoJVwNw4jL22n0Mxac18RCnSTxD/c/xw2ijyMB1/yRqXX0NYLujjEfWE8iSuDLKl51fuvRc0NX4ABOojPLb3hAfM9hjNUKyKociCayXWmzhjkGGQz2hjbKwNsYjKXU0VZQULWPY3ZOLLhn2AqB4AZSL4QNwxZzVLzLxEZT4tnGm+7kU8qrMAyqfbSDuw+x+zdsF/k3Mb96VMGgmVgm4M7rCKEqOIFPkB9HR/7rQq1B+adolzyFnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXzScJU2rC2Bu7kFjsnYIPv5iXyNZuw0u2TTTmebMZU=;
 b=n3SmLE+ob0CunAdNNS2YaS9FIsqOd9r7Dc1EAzwXPAGyB2aR6srA8dLI+raAO8QYcB3cLk2b4TCTJDLSlZCMok5TurkpCarn5TEUz+QTREKWLjV2keHjNi4vuFvV23YIRXoNrWE41sXkzGD9k7bbOJf9ZSdeuM/lbIx8EBAn8zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 25 Jun
 2025 15:23:14 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8857.022; Wed, 25 Jun 2025
 15:23:14 +0000
Date: Wed, 25 Jun 2025 17:23:04 +0200
From: Robert Richter <rrichter@amd.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH v4 1/7] cxl/region: Avoid null pointer dereference in
 is_cxl_region()
Message-ID: <aFwUWPZo3skIU_mn@rric.localdomain>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-2-Smita.KoralahalliChannabasappa@amd.com>
 <3464d8cb-e53c-4e6b-b810-49e51c98e902@intel.com>
 <e13cace9-1ab3-4c22-88f7-0d020423c430@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13cace9-1ab3-4c22-88f7-0d020423c430@amd.com>
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 136b2265-84cd-4372-fd81-08ddb3fc3414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ax4PZT6PhM940qCnniohFVRnSngWpyegif6hHH6gUdP/7ThfAKMiIbdzlEMb?=
 =?us-ascii?Q?uMs+rQFT8zcUnRUVokHihu6C4bquAhdt4wrvYEEoP4Tb7KLBjiDSJVfqZyH8?=
 =?us-ascii?Q?wRkWNt1wGe0z01MgvNliZV1+HGI1v+U9xTTajjBBNqcFkdNu5xp6kJreRtSm?=
 =?us-ascii?Q?twLBckOjwI3ft8W3AK5gYGZhBKMeppwnPVEuCauyB1V4VI1b/yU905ruw+rZ?=
 =?us-ascii?Q?KyYW/NgRps80Zzwj1OSC3nKnfv4VE2d0l/H7J+UTbWHQKoOImMPKuUNkBpNE?=
 =?us-ascii?Q?kxcU+kx6XKfoENI9wFLRex9Fp7SkFwTUx0uGJ4sSBFnKEglX3wnTFshDtLgL?=
 =?us-ascii?Q?7pLRpZ9CvN1/cpZOQkU53hbfdUq3HC+irhbJ5TPYAsN7W4L/jpeUqTs2qZl9?=
 =?us-ascii?Q?1sPuf/DwPpxCBdE2FJbnlNFjz6wqYTfda61yInyVE2UVytIbk6+CjSPUeUez?=
 =?us-ascii?Q?lpPwGo/8TmULc+6vKdmaB9c5b7ZQuNtikJ1NLl8+Cfs1xLmah9/WA+1wbcUB?=
 =?us-ascii?Q?JikOJbkMH+f/r3B1PeQRF3zQ3G5SZC3pe+3L6qvajhsEhd3ddUf/nrJcg68Z?=
 =?us-ascii?Q?OrFbV7K+rySONAZPbHV5cAo13xYl1PIyn4Qn8GLXVRG4zY4Mfn26tTxSGBJR?=
 =?us-ascii?Q?OAW2PnLs3HqSN4GzwSQKyV3/0f3j2VpwciJKkUEDu/I62v/YpsDogUbRmeNO?=
 =?us-ascii?Q?9DzWWu7pxeJFTyIlMH73ORZLnr6WMzYctAJ/LAX1sHaGNuZG1yuFkWoncook?=
 =?us-ascii?Q?CIwBuiItgR/NdJAX6MA7gN9h94b1s6RPmfCN58wLGQdOhEc+0G/pydiXNefP?=
 =?us-ascii?Q?oanLCS5b18CEJSFErhGSdNV754Fqeqy+jAKjrnJZeIdP/dLFRKDzmel1n7m/?=
 =?us-ascii?Q?pl0uWbVosnOgQNZb/iTPcEt6SAAUjqBlGnJnos1iBbrHJuNZfRYkyKeLp0j3?=
 =?us-ascii?Q?2H7RyD60LfHOhPFPW13D4DKDCbYcdeM5rmd6/TfRWTux+kPDgUuHjP9cS9wE?=
 =?us-ascii?Q?XGoME8AAbkcd+pv4TrXQLQ2AbasJHxvfR0TChEB3rPm7dgQraVRlPiybA4Yx?=
 =?us-ascii?Q?WwL1IUqk1zgedeuqCMjBgz9CT6ztz5wkdjxqzdYlVjPkX3LaeR1UU7Y8sD0I?=
 =?us-ascii?Q?Gcz6Xwvjh3F/PME/8+3N60k3vZPTFhXwPNw4Bf58fPIPqss+2WO3fYgE0MeG?=
 =?us-ascii?Q?lAg774VYFNPvhXQXzB/pBajzFpAAQmlZeUy3x3ToFUiHwjepp6ZyZWUrN9AT?=
 =?us-ascii?Q?03X6vWHH4GxP4LMF3tYj2YmearIFCxYrvfGmtxB4C62DCFvx6fMVVEPGR211?=
 =?us-ascii?Q?mxzMIYA7N9eU9XW/WqAD4k/1YeXvatC9SOvM6aV5QOdFoZQ4h93pI8FZd5Ir?=
 =?us-ascii?Q?XVWPrenXvCcHW60ng2152z39QO1H9VLOEMomLtYVgV7XhiyQs05bkrcJbKEt?=
 =?us-ascii?Q?TDCL+8CTKiY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YNE1HUwZjubwLwZyQkvzyFTLN1ABJHIdHuI+POXynoxGbE2Rxmxv3Q1wbVN?=
 =?us-ascii?Q?6Gp4iowAClpwKNhRyWTGQvvXYYfEzBsnkUNb6sUWuKtEw0HbIRVAwHmYTXSQ?=
 =?us-ascii?Q?nELiQLZionK3w0mpm2m9oeCqgVZdQUsvMf1UWcpYywceAoBquj8NWjbKRNjm?=
 =?us-ascii?Q?onS4geYQASR4WSsD4Kvvre2S6spchIaLOHJP3+a+lyTnswe6iKY3RVocj6zu?=
 =?us-ascii?Q?zx+pJuE65u0dO4yTLVjpt+OQeULHgPI9lkwUTjgE2IpoxHVKZsGXMl6j6555?=
 =?us-ascii?Q?PuG5KAS5m1g9FGkydxQsWRFfjVPltb1kRvdzVkkOZrS6ClunJQ87osI+PxMe?=
 =?us-ascii?Q?ug9aW9d18U0aMj9f/ldJM6iG3RXLRf4lEgGs/2Rezj8xmhogMnUu6ksxfpVr?=
 =?us-ascii?Q?zvPo0E+DmxBP2EgkZPOp9rrO3aBMI6ObDG/xwxdiRs/PZNY/1jvRpe20c5O7?=
 =?us-ascii?Q?dttj8a1R5NrhKyhE7XlQn83/67P+OeCyrJ8npYwMEWcxf4GxGLZKHNNYBugD?=
 =?us-ascii?Q?XeCytS+u1Fjh3OiOmpiDVF987uFiyZ3s9VRXlz8IcwUqrjl/BwOuGVR3JmiV?=
 =?us-ascii?Q?GP0JPUxpTis8Y8pG6vGRqSPk8V9/1VyemP+5Y7lxL5uFH3tHNya3dTWjnLnt?=
 =?us-ascii?Q?N6zANn8/k/5XlWLty0VmC8XGoEUOtV5G/8zfjVFcM9BJR9Iveyl2j3N/Qj2b?=
 =?us-ascii?Q?aWGGVhfi5aZtFU9KRbgiGVWF2IQF3pWI33oSv+vSY9b/ClvLaDo0rtPjNR85?=
 =?us-ascii?Q?xtdbIAG+FfM14JAK6Dh+uB1g6xM1LzFBlMyoelHEDx3Dbe2mzQFGhsb3rwwu?=
 =?us-ascii?Q?aiFrIXYwFIZyv4f7/9mJUqhjnrE+w7FhUKDN8a0LwDE16tTOq05sIXZcs1Da?=
 =?us-ascii?Q?t+YHsIStntg2SFSrIKHavT3rwwltH+Z2gpuZSx4mTKgQNbDSIbc4lgGXs4qN?=
 =?us-ascii?Q?ldAv3VUBVUlvSkj7rqPmTftvN9CMoWh9A/F6oQVvUKlI9IwSjZ3gyDaJalrU?=
 =?us-ascii?Q?0ZXHnn7uPQlX++wcAMqi3CkaLkKdFK7UoQlLUjBVLD0y5TNkzeEFNTQjqf0A?=
 =?us-ascii?Q?/RKlKpCVZMZ6HwKpHLkAeXfWXe5DAxcCn4Y2AGeoLAjcBtI8GCe52rDiJzL1?=
 =?us-ascii?Q?WdW4+TXqLLTBV4foZq3307x5QaihD9G+WVwFI2U46IAN6NvPM7Pn8x1q2Ot5?=
 =?us-ascii?Q?60gdBNJfr4KbOvAxXjeBeinRGNU6/yPyo/qJL3kLhTZVmfuOlxIXKHh+cRjg?=
 =?us-ascii?Q?OA1p8ayrYzkD7vRr60IomNneERX9HCEk2iVqDZHWEyosQ1o+urLiltI6flUC?=
 =?us-ascii?Q?rAO43GUlC9rfkYKSJl2Dklu4HqTr39+FSgauQCjN4oIifb+cWuxvHXdafXKZ?=
 =?us-ascii?Q?0usMNrwu9gDjc0NKs4ShmwyisMRRKsxI2ysmV8ap4VNlBXwXWVPSUUn7PdjO?=
 =?us-ascii?Q?HNOlxOsWBP40XxzOgehM03vQeR59c7cR0EZBsaDHFpzBEkErFM5JNTCEw9+i?=
 =?us-ascii?Q?ARfaKv+0B7frso5gN9jDmqrB9MWGP8DnYAEGBU4odZd5bYZ2qPAiljYXfCeK?=
 =?us-ascii?Q?tWBag2Cd/TP856YkF2IVWeZtDEFL1oitvP9Cm2Jn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136b2265-84cd-4372-fd81-08ddb3fc3414
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 15:23:14.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0hhnL8LUWXC5mxb1Pv3/ppr9RS9h9o2bD7jT8LEO6F0NiyP0eqtA9ChfZTRiF7exs9Km5EPLaC7efJA/J+gfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625

On 04.06.25 14:56:22, Nathan Fontenot wrote:
> On 6/3/2025 6:49 PM, Dave Jiang wrote:
> > 
> > 
> > On 6/3/25 3:19 PM, Smita Koralahalli wrote:
> >> Add a NULL check in is_cxl_region() to prevent potential null pointer
> >> dereference if a caller passes a NULL device. This change ensures the
> >> function safely returns false instead of triggering undefined behavior
> >> when dev is NULL.
> > 
> > Don't think this change is necessary. The code paths should not be hitting any NULL region devices unless it's a programming error.
> 
> I originally added this to the patchset during some initial development to handle possible
> NULL dev pointers when updating soft reserve resources, see cxl_region_softreserv_update()
> in patch 5/7.
> 
> In the current form of the that routine it appears we shouldn't execute the while loop
> if dev is NULL so this could get from the patch set.

With the suggested change to use bus_for_each_dev() in patch #5 this
patch should be dropped.

-Robert

