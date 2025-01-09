Return-Path: <linux-fsdevel+bounces-38702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102FA06D81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 06:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F8A166510
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 05:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083B2144DD;
	Thu,  9 Jan 2025 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QAR699Wh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D780214227;
	Thu,  9 Jan 2025 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736400090; cv=fail; b=uwsHtMc6NsPtwUug62fcACoQCxO4q9vlJ3LNHQWK9dxInpmEfRjc+EA4xaDEfqlSUwq6AhdDVt3DrKAQkGTicv+Yp61ZihbkMGCmgUwiqFY/E4YL9uFiMySRchq4T+oB3w4Qrf766vm8dEtiG2OifqX9EK3L2oo/ffk2l7dxj6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736400090; c=relaxed/simple;
	bh=Ij275s+YylaHeXU/jD22jDigy58s3GYuJN8TGK/md8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YLKXo7Zj58fHPNMSlMDstrlaRcqPMHy7aXJcTsMUi+ucmPQxps6lN7LwkK8FxmaVGtHB1B5mZfN2pS6i+BVK75h1VQADPjb0ZwKAt1z7U/hRzmycEzEZvA2WO15Y4E2oGAugAMselRoMtfzNuceW3c2sWY9fGym1v0GStWNd7O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QAR699Wh; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZYWVRsDZvnaE15i+WdR7DPXhKNIM02G8c6P7JKBXAYReYWkXgAfhw6WD6Fnaiql16Tzc6RGXVku0CR7pVy1tjwUpDpQcc6qPvrCJBCyJGQiTvk4bjiyCPYcwFMJ532e+WnGM0FMIdszrj4LlXgJyhDD1kbBuUO8qf0Z+UNWUnP8ld3JoPg7KRpHezEZe7K5V6fpFkCX38uBoJyXaR0CPEIPr4qJU2/Zbvgq6xTQXgikvpsvScpR7llcxpoEPq413iK74HebLV3iqV747vH1I3bZ5oCOZjI1Rhglhm3MyHIYDy9BRj61zcncRp3g8I8MBK6mpztTdbFFOnUDZjnANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTCBmi/kvh3XtA5GDyyga99oIp549Lf+iTb+rNkRVSo=;
 b=L2szTpwNDMVnw93p+0YlPPRKlittNBMee14oxLIWtnTsoSx1XUBqExeU0lFsX5e/jbTNC/kVjNh0wDYDxilFrPnPX5bKAfSvzFYqRXtnv8tSn4iGbf41oqYJlVl5GLVYDfzzahpyUH199Z3cKdjhz8qaxSsJzDWx/IwK+1E+oULEphrAn17DcGq5NIieUTOewPtUvPv5Uy0CyhkuyGBK4BMH1PIOCYLEPn+8egyNr2A/hvgKK9re6cUEpRX4lON2RTs80EKi82vZVvXRJnfSi2eDJ4St0zv+ZvYx/tnLjlte6dPfTnP3vX/ja/APpCM6MQorWPn+k6HASAgRduqh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTCBmi/kvh3XtA5GDyyga99oIp549Lf+iTb+rNkRVSo=;
 b=QAR699WhgPk31ueNEcp6WRehTcCMwNxYktj7zP/6b/fAJtW/qkaUA4EINB3E6+HrihZDAFBSitr5SGCyITA6cql4juxt838F9m5hV+daTZwoIz/MzaCTl2sO2Y7pPtvJaLJR1Hm51H4N1G+JOmr4O1tGvcgMRaWsD4u2GzyGfLgyutmj5rmhhRXyj7xuIAXHyebn7YvOO+S8aOQkV7YIEy0bW9+3WYDim5o1RM4+3LNTkNjMdaJC4UEpNY81NvsE4WRRdCJlEMuYePV48v0QMUD4CfMVP1/aRHaYeeJ6kZwBgMwWckXEAVm+U48gG/JTUdHKTTM2iYbCwdq9etIrDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Thu, 9 Jan 2025 05:21:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 05:21:24 +0000
Date: Thu, 9 Jan 2025 16:21:20 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH v5 03/25] fs/dax: Don't skip locked entries when scanning
 entries
Message-ID: <jt2ro6pedtqbyicarbhlkvjjnhtgciq3terqmz6o3i3hsmq55q@b3dsd2cvvs3j>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
 <6d25aaaadc853ffb759d538392ff48ed108e3d50.1736221254.git-series.apopple@nvidia.com>
 <677f013c1466_f58f29466@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <677f013c1466_f58f29466@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY4P282CA0006.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdf8732-9838-4f45-1996-08dd306d75f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I71Ei/Cdq1DLOHOP/eK/nHSyVxCNwf7+LgIna/ScK+MqdljDH4E5WzSvDzeH?=
 =?us-ascii?Q?2P8jHBJRLlGSSAtvzFgAs/4eFTuL5TEraNZkI8ehMMpE2/xPFxCiFN0q2Y3m?=
 =?us-ascii?Q?t4KzolmBWqgrWbYzr5vfvEYs/62p4CZ220xIWdkOStOeX7ls+67KTsTQ/7X0?=
 =?us-ascii?Q?ShPibNIhI2+R0ZQSQvhlTGukYprEFC5Ddkc+oSS00ZB8SMhwqRFdoDqxMOUx?=
 =?us-ascii?Q?Mt77fYDlIvhix2DW0PKrA4oamxBIal8XaZKVgIffYPgIMVe7qSkl+b9su5/9?=
 =?us-ascii?Q?MCq7zOyx7C/r6JakFIm6/weKytXRxcRUBgp/6DSIpAL6lJWpRZGeZbJn8UMA?=
 =?us-ascii?Q?uX4cj3h6enDLZzCcp21hnGiOX0jZJLRPB3ZFWaZWR43WOzQ5tQ9nRWHzUe54?=
 =?us-ascii?Q?RQ9KlJITUirqse3gfP50DB6oVkGQubq4TLMF+r6YeL8B5rl1cKaLgMzsCkgR?=
 =?us-ascii?Q?S5lZZxBe6CgKcVpk70QPMGoe/SY6Z8VI+g8NzcyhBknQMqmX2lb56x4bBaU5?=
 =?us-ascii?Q?lX0sHxFmUDSuWlq+bd98useEMGAu3G78O3MpuXz4o00F6WUDkYrLuvPP6qXP?=
 =?us-ascii?Q?GnFV4mu+q5LCrsKrtrXFtuvKwCCxFKN3YV9TqBjJM/MW4w6kfaxn9a4AZQpy?=
 =?us-ascii?Q?d22i3pnyb1M1PQXpZMO9uPi18clfhNmm2+MQLehH8GfQu57plK6IyTqhEAXb?=
 =?us-ascii?Q?xEOwCyH5ilN/jRLJIGiDjoi8CBXcCUxY0ZF+FRwy23OsA12hZf7Yuw9tKLah?=
 =?us-ascii?Q?xroYnhVbrB9jGQALbw7uE5U4eBS5A4sErpKaSo5rkD7TxOx0WOQ/TOwooit/?=
 =?us-ascii?Q?J81+FRfnKcpR+dEJOfuNeAwjkJHVsxiMI0mNMnqX7rZG01ITpC0o5xakwRVJ?=
 =?us-ascii?Q?VBx9LsaZsV8zDGnJn9F52GkdGGLSz+6QTbjUz4o75QpsPJCXeKbyEsk1g8DV?=
 =?us-ascii?Q?zxKwPdX6QCVsUTVtbzRLzj4ocE1oYdPfLo7Gm6IqIu5KTQvsixkEzkXKWPfP?=
 =?us-ascii?Q?QLPwzgu4NR5gzqi9SLn3vOUDZeyGOkvBuP7aAoijleElf8UmqER2aQPVJWxf?=
 =?us-ascii?Q?GdLBQiDSo11wLEOXd4qXSaiZgN7pLLHFdXmeYYACK97Ql/oOwJsChxFTJDHe?=
 =?us-ascii?Q?4s49EgYkfY0cnnpigZz+q5cMlwD+ptXbBNboYJGZnBSlEHUc04GqjosDl0ZK?=
 =?us-ascii?Q?fnRmKG2PrrhLJFqkgcAkYRt0bWfjvGEduJUcEZ/Mi2UEu8abDiNaeSnd+Yup?=
 =?us-ascii?Q?98GznbiSuVZVnYucaHnfZkhuUJ2BVQWhRzHLtMS1sT8JkbARwbYV3i4hsAyA?=
 =?us-ascii?Q?VxDOeX73HqaMlE0eecTd7UJJEPm8QPD12BDXfzce1KNxFW4moGrHR5OSpzba?=
 =?us-ascii?Q?hjgF+8E1Hkmniusy6S3EkudvYK81?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eU/HjspxFbwKGY05Qv9vtiwcku7K5063oUy5mjzL8vsljIXIoqAbQMLpPad?=
 =?us-ascii?Q?OYV3seXU4GsiaSwcdhpK1pXBFozgVuS1hIHsEBKvpGZ/xgYcMLX+TgYpeCUE?=
 =?us-ascii?Q?Ly5/ytm4rgC1GADQ28yJ8j6k+jzXJeC9WlWjgBsvt9wAzKBsNhPO1wLW09hv?=
 =?us-ascii?Q?G9keJaNBZP4ksOYaFmqdZkPC0bfipXKxuKggIeen1+OfnQ7yG9CMHbcxcdRx?=
 =?us-ascii?Q?Hf9JlMkf8kpnr50/ZHb9uEljzWVsVsdv13Y6YjXbD2SD5dSh7i0LCMCx9B/O?=
 =?us-ascii?Q?iwhGFla+Ht795TaFynAjepgnCu8E/Abdt74xorZkpwv8+rPxAYNA+4p8FhfF?=
 =?us-ascii?Q?34wzZy8u2brblMG5TKixi4lo5aMvRW941R/ObIYpiaVO4hfGbzdU5nVHz48q?=
 =?us-ascii?Q?QWT3HWh9cJ0FWchcAbU19AJibAeetkNYbUiSMhb8vpEcXjuIwVJ+rSqlsIQ5?=
 =?us-ascii?Q?B8Zfc31Cu0MXrUuTsoTObruZms9jIJF0dGah9D59P0V6CY9bbyxs5jlOSQTW?=
 =?us-ascii?Q?zEgyxRJrm2wo956IXmA9nwLHLcQKjPdXd+smHWEAt1EAJeCGUNNAYIsYfLyM?=
 =?us-ascii?Q?gbNR0qcSPouRe7TcTH5ktowzG9gzamIApkCLQMmDFKQLxgnW6xpBtoAPJ2lD?=
 =?us-ascii?Q?EMUh6pocqdyciI4f/Gfnvv69iOGh5/k8lfN1ONW02aBYCMQe690mqaSKnR+n?=
 =?us-ascii?Q?CEqzWP2kDdchxzF61zm0o9EK8ttZOEv3UZgBR9zZUbG7ygsI2RhYj3VlAc80?=
 =?us-ascii?Q?jeuijRV3C7CGzfSNuGe9LD6yLj9FqJbQRcpyQX5WpgLsVjgxANirFs+ptCfQ?=
 =?us-ascii?Q?IVdcPtntd23RtWRHVhmfxIusESjO0IHbiavMhMd/KAj9u2+Y1H9aT0N8ujmb?=
 =?us-ascii?Q?J0ypWsRwbk1funiD2lpDZQwx4JlX6nPHmimLpRWWf3GKIoD9cb7rT7AqnY0g?=
 =?us-ascii?Q?9ZTUHdltWZODuUYZg1nRAEUcxJUV6D78UzqM7lbEiNthwOfYjyWg9sFASBHY?=
 =?us-ascii?Q?L5fwS8DlDMo2H6OEqx/oeiw5Dc+rx/8aJHaUO8KjqWk8aKoZfmF4uImHFjwk?=
 =?us-ascii?Q?Kkh6+h4J4QMfa7jMZOLhbOwzvhzXjdM1txFPZm7AxZBQ6yYh2QlE4atvuFqh?=
 =?us-ascii?Q?AhiYUNSNYgZxDdLiEEZ9wQlv4ccSdgYgHHAkx7G8CJ2XHqLXanQM4l8W8Ihd?=
 =?us-ascii?Q?i6QhLLB4IuoYQMxxZlGd2164p204pyKvFe6+2X86vysequjptCPqNwKb2u5K?=
 =?us-ascii?Q?XcoGIlPAeFYHnAyS3RkKwVqxbefqpiJDDhOuPG/mVw6F+t8aWaJw8/KLySwS?=
 =?us-ascii?Q?Pyvg/7jplfuybxwZjtljcXYoOj5kyj7vkFLpQujexditY4RXFv51KQlzidOs?=
 =?us-ascii?Q?cIGdjX0xLrMVPy9thF2OuMsX2jznzJPlyHM/qGmzsadFBmSPIxapS2jaaw95?=
 =?us-ascii?Q?i9MmDWsYXgaqNBhz6A5td59OdrCMHg0pYkPDTtNe2gfoK2JNhu5NTSWz38HB?=
 =?us-ascii?Q?J1ypR0GTPJnlyg7Rsei8Xs8LYe08UfKNve8V+1KX/Mq9MVxB39fnS9jWd0oV?=
 =?us-ascii?Q?AX28SHMWWQw8d+B9Oq5Dyt+31OghqiBSweNwzP8v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdf8732-9838-4f45-1996-08dd306d75f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 05:21:24.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJrJ2/Ps3/MwLobx46KnN6lsz/uH3EUw/jyKevKddJ/4n4NrS+hsljjjn5Ajmi6Pc+ZbZnUvRWHf0WvPEWAcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

On Wed, Jan 08, 2025 at 02:50:36PM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > Several functions internal to FS DAX use the following pattern when
> > trying to obtain an unlocked entry:
> > 
> >     xas_for_each(&xas, entry, end_idx) {
> > 	if (dax_is_locked(entry))
> > 	    entry = get_unlocked_entry(&xas, 0);
> > 
> > This is problematic because get_unlocked_entry() will get the next
> > present entry in the range, and the next entry may not be
> > locked. Therefore any processing of the original locked entry will be
> > skipped. This can cause dax_layout_busy_page_range() to miss DMA-busy
> > pages in the range, leading file systems to free blocks whilst DMA
> > operations are ongoing which can lead to file system corruption.
> > 
> > Instead callers from within a xas_for_each() loop should be waiting
> > for the current entry to be unlocked without advancing the XArray
> > state so a new function is introduced to wait.
> 
> Oh wow, good eye!
> 
> Did this trip up an xfstest, or did you see this purely by inspection?

Oh this was a "fun" one to track down :-)

The other half of the story is in "fs/dax: Always remove DAX page-cache entries
when breaking layouts".

With just that patch applied xfstest triggered the new WARN_ON_ONCE in
truncate_folio_batch_exceptionals(). That made no sense, because that patch
makes breaking layouts also remove the DAX page-cache entries. Therefore no DAX
page-cache entries should be found in truncate_folio_batch_exceptionals() which
is now more of a sanity check.

However due to the bug addressed by this patch DAX page-cache entries which
should have been deleted as part of breaking layouts were being observed in
truncate_folio_batch_exceptionals().

Prior to this series nothing would have noticed these being skipped because
dax_delete_mapping_entry() doesn't check if the page is DMA idle. I believe this
could lead to filesystem corruption if the locked entry was DMA-busy because the
filesystem would assume the page was DMA-idle and therefore the underlying block
free to be reallocated.

However writing a test to actually prove this is tricky, and I didn't get time
to do so.

> > Also while we are here rename get_unlocked_entry() to
> > get_next_unlocked_entry() to make it clear that it may advance the
> > iterator state.
> 
> Outside of the above clarification of how found / end user effect you
> can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

