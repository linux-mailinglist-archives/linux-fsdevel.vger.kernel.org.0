Return-Path: <linux-fsdevel+bounces-14945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE367881C21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 06:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EB92828AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 05:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A3831A8F;
	Thu, 21 Mar 2024 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XSc9mMWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A012BAFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999406; cv=fail; b=nvZ3wgzWmkFlCNGueHW1rTafTs/x/2VGoyGiotK8a1zSEWb2+kz4frglGXTrhuw6PI6eAkIxsVIpe5vvYQ8QbwBLnQe4/0GiZCngmk1qrVVnn4zsKfjQKqax5Lodgbio96FGGc698y7GoDd3IBIwLA3+urwTApW+CR4uYFBEtnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999406; c=relaxed/simple;
	bh=tL8f0NdQ/gxHeVJXXd5Hp3ZQYdaL8P9/IoiRtZ4kzLI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=d3Ji6MBTAV0eZI/T8IALw4qooqN4X7OQJVEJ2yr5l/C4Dm28WTCylixjsY7PwfUdme9XSZWVofiHzo4LkEleWFTJMeIOj4OI7ZJI4CptObOUKkBv2TFbVtNOUNcBTvnZc8qCdyIX/eZstSQ81+licUf6wMFyDQMmS+p5dii55WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XSc9mMWz; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKmEhnv1hyDDBLlnlzPK7LSJpiqLLXS/X7uGTj9GwbNld3mXc5tQZkfSrv/T/h7pcq0PREohc7uHZa8jYzalLvnTBW1zRa0tsQq65+Uw4y38SbkY+JJJwwHQVH+i9gkH5TMf//zaVVG4ccaimYbpQX5vdlFbfcud4141YCWYQLL5TK8QrbgzS21PWsQEAmE/6m2nOmgGN1mg2mTMGGsKEyOzmAPY/iN0LnPk5P50NG29WCZNoWhRfgCRQmC/UA/CyicFk/W8POP47lORkXEcm7hcE7CuLX4OXlniDWpF+5RSRlKNwJxg6smGLnX/lINW9wgBSOMh9PBfOS0Bkfl0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL8f0NdQ/gxHeVJXXd5Hp3ZQYdaL8P9/IoiRtZ4kzLI=;
 b=oO92o5tr+1VIBboJnJH75dAj+qfqKr4YhtiyZhJcmoh0Di7GFWLIdT18UNPTTjEAL9fskUuFBVZM58YOVNdmqJRSsasGRLhGWCt1OsDrGeXLXgR7DPf/HiPbxDO+ArB7/KolCq5BGRgKf+QdWQGFH5dIJLT8BLPvEjfGnndnJB0zlTgUYvkwQlibYPuKnrx26fZw7HKEn+GCqtTvg+b5osRs7FNUhdjjPXh9qRcrvrporNonCpfyjMK+JVW4mSoWjkEl/ni1q9vfdbLtrp/0SqdnIiSUpfwsn+jSJ5E66K0kxWo2n5CBVXGuZ5EbvnBm/YtGUrwH7LZiURNkIXpXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL8f0NdQ/gxHeVJXXd5Hp3ZQYdaL8P9/IoiRtZ4kzLI=;
 b=XSc9mMWzdGM2uFY47yBkXa6hqDoCtHvPKI+1HaB+VVy1/9m0+/AnQBgtzFJOFB8/QA45ARBmURziyDvPoum6dJ6DDM8JkxsUUKu6PtMksA3Wlv80BCqP3LtEZWjse3V4eYF9IxJMwJTF0q+gYwVGeSYfugAH4JLtvdjGF4kgPT8IVCuQiFiO2RBeDJjDm1eYGS6u9mv5cSsA1qEN9BqFQm+tXoIbJVCnSxwCFUsIipO54ar5nhgoswjKIOISkd/KJBHgKmXLyN+gBehmDAeR4wuuhEAR/sPQtI02C76I5gL+P8wXyAgJiX7ful3e1IRKC6bowjf280I13i6AV1LvtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Thu, 21 Mar
 2024 05:36:39 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 05:36:39 +0000
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
 <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y1ad776c.fsf@nvdebian.thelocal>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
 jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
 jgg@nvidia.com, david@fromorbit.com, linux-fsdevel@vger.kernel.org,
 jack@suse.cz, djwong@kernel.org, hch@lst.de, david@redhat.com,
 ruansy.fnst@fujitsu.com
Subject: Re: ZONE_DEVICE refcounting
Date: Thu, 21 Mar 2024 16:26:42 +1100
In-reply-to: <87y1ad776c.fsf@nvdebian.thelocal>
Message-ID: <878r2c6t99.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0028.ausprd01.prod.outlook.com (2603:10c6:1:1::16)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 5903b82b-9ec4-4703-ef8b-08dc4968e1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K+Cc+8ckvhBVh5EuJ9238DTfj7476lRrTFMBNRRxhOyE1e3uFpZzmUyFJolf2/m7JMJqIlqBuof9oaXcvK303glgVbqiz7zR6ncu4v5jJVo3Rbz2hnwf5e6ZR09SVQNWH5uLIQ65kUxqhtirhKCPVaaJT74hgSPOAo5ZFfi7KJwdsdFl0AaVb5WxHpt/yJniGQyZ0afXaZreKsgpBP6XUj6aoEj0vflj/XPZFpuRcZ7GKVTIZL2u+sTpVeNHrpSm8jp6F8XLWy4FaFj+7375xOXzpeTiyUkK/wZ93Gt3pAoMgmTG8KXqzo9Roka5etiqoDeu10+TlFA97TGsEgKMXpNAcQBy91SQLhsTGoREeKlfmUrineuzg1vpOEzZVg8YR0l5MPnlHSMz8+P/NSlW0YjG7l4rfMjuZ3JXkj3wrxNxwX6OBmZpWvUd7Gpci1jmGlPdVBj8VUF9s7uN1EC9txaaBt3p/yCuLZRSp+YZPsZ0kPAUqBpJMcoyx7CuFV0ljybvKTB3YV4B7vyvf7c3n2/un4J6gwdE6ifp1Mi9q3GKs1FROoqxrJFJ7Wb9vw9UGgW1+DsGtmaAhrFaV59Sez9YjGd5h1Oud3zKEWyR6jFr/zVRwKR1bHKuaZlNucYUQle50f+z0BXatlNja16j7tEfcYXEwq7PGKvTDC/5d7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8aucb4PdyA16uu+isy9YnAF/1aJqAd0xos0FLx8bbtPWqd6wHQL9iVU41LMr?=
 =?us-ascii?Q?V63UKw7gz4ZjLzbi4AKkYAMUScwwB8nTB1qySB8PiKjxtL5ic38totDtTmAg?=
 =?us-ascii?Q?AfPcFd4l6e/qdxdqTWuxYn4kAyzm4ridAdEQU/Pt2W1sxLSTxhMDFx440pvN?=
 =?us-ascii?Q?c/fO82M4MGTvWjfmAqtVgPK5oLv++2+H6224DnVQy4TtgRRgd1gKlbCw/7Uu?=
 =?us-ascii?Q?9eFJi2KGBafAsXHVkij+T+OgU7xc151EasYMmD3Pb+wCJyEGptFB+jAYcxHI?=
 =?us-ascii?Q?xOa1ioYublJb359VefeUJFVLFswzyPpDacoUCkd7T6D/ilR+TKcKnPQVNIJh?=
 =?us-ascii?Q?ymzB10jSyRtUmx2ptQOywgvP6FksT/w/toNPjYmnVsfmAEX4f+vVAygd+/Y/?=
 =?us-ascii?Q?TE7NxQ8n7DgAoX8/+7ZWgalbuJQlNu8KF1IoResBxe6iS/tIZtae/qeJJtU3?=
 =?us-ascii?Q?HPYjRDm7+RIkvsWl4h1z4e5SWkzkhGBlETOv3WX+5LWCrZEDUss6BQJDOkwW?=
 =?us-ascii?Q?MYySWHVa9cg0TCH3xXJdOHj+hz4cNA8fINdsRJ8/hzOr7gSYVSyKfUnsP5o4?=
 =?us-ascii?Q?Pd7Va1IXiCdtPhLCzXfidsEldt2Wu2jLRVdisp+jmLDJkYSXDvMfXb0OFIe+?=
 =?us-ascii?Q?ry21upPI7vPM28Y3OYWoOIWx9lOg3+BsUo15/IoAqSmSeCZo/ja5PJeLjo/r?=
 =?us-ascii?Q?4nhNpDfkd7Cf+6bm69VHl3xIVtKIxHrJo66gVJaePq1TTGPp5jYVhI8fWfFD?=
 =?us-ascii?Q?fRp+FPnza6pigl18xHWK2nmnhlFXG1gIlSo2JJfI5GMwmCBoXmT0bYgWGGsB?=
 =?us-ascii?Q?IyJdQayMbVmyW1mvyWrkml9004o4X7VOtyP4mb6fVDcix11RO8OtvQBThlMw?=
 =?us-ascii?Q?qrNR3zrlSVI1OifqmItD7SkimM34bwa+L4kWmPJT9cZBN/FOMeOdhoXhVjip?=
 =?us-ascii?Q?xHB7ERX7Ynr1WUKUfi6bV5dkIbJvOZAnx5HhFoakIZHoiTPZfw08RjMkfCvG?=
 =?us-ascii?Q?qB7cfpY5wXMiB+ASrdJFg9cTeMVMQ31/uYW8WePJSsPBea7tPJfd4UcO1j9V?=
 =?us-ascii?Q?SFnLsAArsrkd8vqFSOmRzqfexRfXrWIg2457sJn1dFATWOXwp2DRBd0oJf7c?=
 =?us-ascii?Q?cBb5EO5mJFxl3d0GhIeGrOHQUHFGeeFplu+lzGREKS5qckCuLbbKiUKw6uFJ?=
 =?us-ascii?Q?QN8aGONOURfoPwmEJJS2XU7rAIw2nuEfxse0XYcjqkgnH1tRZpQMj4O3P2ww?=
 =?us-ascii?Q?/ZQuRbpQLLxCBEE04/xl5JEy/tuOKePEPf0fhbXlyIjvavztFdZ4+uD6BOdX?=
 =?us-ascii?Q?UrIZtvvbnt+uGS2uvzhNXHMjCe8FfMNd9lrA24GAOfEBAxVz8ob9qhd4SM6C?=
 =?us-ascii?Q?ADsgtgulHFrMl2SawgVTX3UwPal9buhI00FeuyaaqnNGTwh8c8/hgdPl0ewO?=
 =?us-ascii?Q?MEm/bhYt6CXd7rRSo/zsxBdpVxHLkuDqRnS0RkDEElvmSLWOXddUrwErdnkm?=
 =?us-ascii?Q?GGwstsaY3uPUSHR2sP0ZkQIglWMZ9drPp8MLJxhQ3LIqUa4MDEsLqeofSFfL?=
 =?us-ascii?Q?1RZRK6y7cuvmMzTtSiDh98EvMUv3DouQwooX09Ui?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5903b82b-9ec4-4703-ef8b-08dc4968e1d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 05:36:39.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qhXRjIXcZDjCVRBQu9ugbvQaXEs8y5FjDI8sE81UyBpv/Hzk0NcWJYh69rFwM7nhuLf1kvjmssSSoZr8BmKhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365


Alistair Popple <apopple@nvidia.com> writes:

> Dan Williams <dan.j.williams@intel.com> writes:
>
>> Alistair Popple wrote:
>
> I also noticed folio_anon() is not safe to call on a FS DAX page due to
> sharing PAGE_MAPPING_DAX_SHARED.

Also it feels like I could be missing something here. AFAICT the
page->mapping and page->index fields can't actually be used outside of
fs/dax because they are overloaded for the shared case. Therefore
setting/clearing them could be skipped and the only reason for doing so
is so dax_associate_entry()/dax_disassociate_entry() can generate
warnings which should never occur anyway. So all that code is
functionally unnecessary.

I guess that makes sense because DAX pages aren't in the pagecache or
LRU and therefore nothing tries to look them up via the normal
rmap. Does that sounds about right or did I miss something?

 - Alistair

