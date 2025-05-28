Return-Path: <linux-fsdevel+bounces-49950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6228AC62CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6D34A5A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 07:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D6824468B;
	Wed, 28 May 2025 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="raQ/VlWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14C2063E7;
	Wed, 28 May 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416684; cv=fail; b=lYDvu2IKjbTecMAp3P7Tdu56rDYO37+MBDSKLBQiqvw1rG1RuFR3+rjdzJMVhAHvzoFO1MaT5vsTx9Wae/Dn432sIE5vSy88UOrtuD57F1lCVk9niibUOFIuPezvG2sU1UgtufAScyKUrE+Ikif9om1rMIFAc4xi4PwZ+mcwVzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416684; c=relaxed/simple;
	bh=tdaVb+VjmWFvim2B2CkJ3r/whqhfzluBUr2BppC0m3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKvXGZInNATl7X9l1p7Aza/DnhmT+iDDwQn6j9qHwEIqvhnPpiWGzF23DQWirdxl7+B/X3BEPDD5gy/fTr/QvDQOwTK7D+hGqV2u22NMWXw+S3rrW8tbbp30zNPquZSRrR2V6+crfJOwRcqKprjpYwZ+gAG9XAu8ky+IaEMXXVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=raQ/VlWn; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o79hU8UTV3Pd+iFGMtm6k0dNHgSRNBCHXEAjoUtZ1avHz7xVHBl+KwY1M9wQBBLJq3HWOEnXVM1ZhJYTMT1c3LjuRcEJaL7KFN1Rsx2tv1ZJimvfBpN5wm/2z2Ou2N4yeF4zgYp4h+AhXhMC1Jjc76cZYvc0ReuCMzHnYbOy2QM/sYeHm9ei/oVmGRXc33dHf2TV75xXqXQxutz50roRi+Jc2iFnWGtZ1f+x8cFllH6TqR8oYM2QknvDeeX3wcwlbw4hdoo4MRr9XVpBoKFNe57tiVU12dD5yuYgjoArKwvIPa5NUGeJ4c86Z+fi6g6L4nYxb7l4KnZ2tMrfbcCxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQRLFftrApMuTBzrkojJ9sC54RnC1jlngoGXEbOzTvE=;
 b=lC9d58Q+3ObBHuJxQfF0q0KvZpbuNji7fl72YIb0zDKDmyArVWldbS4iaey00nGfnom50AAX/+Sq7zpDDJ7J+NddpsA64aLo7E4nHhc0nSexA65oMOZTZfCaeK07wFwbUL/SF/a+1S0GzbJX8aVTlc60lborjqpIHYb7qqdXaPAF5ahVdVIIZhwHFcir387Vc5kWIQRpb0SwSRzl4lcE1d4ddhhdiZOdNPo99joW3INSao/vkjN1fGiIWzHCjqSEn2m1fmvxDgk+2Q5nVt5s3yfDe/ix8nBIJfYnqrIKfx/DoSCl9a1T9F1XgGOWp8Bl0arhGi3Wg7d6lIzQh9c0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQRLFftrApMuTBzrkojJ9sC54RnC1jlngoGXEbOzTvE=;
 b=raQ/VlWnd0DZihLaRQqMxbr4kjKPCkA7JDgx8OKVRvHW5UBn8gUi6vAAykp7VunCZy/0GCDcxBDrbcM0gEFI/au0gzdZ0vlevPdmE2X7nJiBiaWLxZYd2/ou7WHZA/TDScMiv4JvhmLAxMc0bQcTYnB60GwRefmbecFHQgDD9PeEWWlD8rLpXq7c6pqQU3JNpORFNixPIT4fMrUNlAXZ+eZPPNDE2g+HX3g2QJOu8K5gRhGmgVRWt15Xf/Ci1NPZOtvSAeKf1MVp+SXyvaO0RE7XhLEC5HPiksKSBpsC0wPK04eZEF3Op5JmG5ZrEM6/YuOdXoTWI5TTHvc4w2YyDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 07:17:59 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:17:58 +0000
Date: Wed, 28 May 2025 17:17:54 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, willy@infradead.org, linux-kernel@vger.kernel.org, 
	Alison Schofield <alison.schofield@intel.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Ted Ts'o <tytso@mit.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] fs/dax: Fix "don't skip locked entries when scanning
 entries"
Message-ID: <czfeedp3c5nqdvdobdb72sugxh5ld6evvcof2vwxsajvzyotnv@vo2uka7wqlkv>
References: <20250523043749.1460780-1-apopple@nvidia.com>
 <683632b425dc2_3e701009c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683632b425dc2_3e701009c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: CH2PR14CA0034.namprd14.prod.outlook.com
 (2603:10b6:610:56::14) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 18492f7c-8a73-4b6b-9174-08dd9db7c5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjYIS1xBYKeZCTmRQG8USUO2deR8++cjr1iuuZcHNJ57tpWjodk7ZnF70bmV?=
 =?us-ascii?Q?rj1MRMp9IOz1axjrfYsWP44Y5kgO4000VUJpOiFCLoVL6zzWW5CaLZWXQOd4?=
 =?us-ascii?Q?+g1GnUrJGXC7i/nCCzzeV1JSaaZIOkUhngtwo84nixWUeNK4XAOgKzy/d6R5?=
 =?us-ascii?Q?kG28ge37r4JlZFBF0aRccrg3AO05J4WMSkhi7++p5nZcQZtld8YWb4da+BiQ?=
 =?us-ascii?Q?K0HSVFo+wEYU7r1Lx0VjlrEVHT5zAhtS/voqTYTlwHz09NioMhC0VnbpE1kz?=
 =?us-ascii?Q?JBy9oWg0hwxQ+vGirHZCUSvSm/M52+tJS5fWCCs7K6oHCzT8XzqIvaI7ZJee?=
 =?us-ascii?Q?Uul+BiDIdWWRG5ukoDJIpktZQyfTMx1lNg/uH5qjxFuyM/OZ11+2ETZSXBoT?=
 =?us-ascii?Q?7q7Y3omlR4oeT05YGWnNQ0f4jcpZwDG+uqhdHR0+RYdEg+8cTZAXDmuYleLJ?=
 =?us-ascii?Q?LmMzbdC29FA+ql8o1eKtwhdAnbiUZSwjJt8fHuCsq9ta0nmsLghiTZftxNRu?=
 =?us-ascii?Q?PUQgFKPlQeJ65M8RFQynahEcWUMV94w6Dsc1+bRuiuy00eifUNaEk2/xNe/U?=
 =?us-ascii?Q?bqbeUXRULsxX/GMr6DXRxIXFdsFmaAbFAJvrRoqyijDutzdSUc/K0J8Kcfz1?=
 =?us-ascii?Q?s+tYvkx8LJZCczhyG4u5ZXrjIQrQWFu/n3zwZPos1vOat250uzMHsRLu4Ct9?=
 =?us-ascii?Q?XSm6kM745L/SJbAYL2orbZLZ1W4wuae/d8kQFVX83JcDJS0LmGdTYJRbEtOZ?=
 =?us-ascii?Q?MEkCI3UWw/LojB4QRDCh7TTE2ATGHDFRkE3fjVlOi5L/eDI73o1YpqxqKE/E?=
 =?us-ascii?Q?xFJ8W8lYlWmw4/mT0QPvgDtUA32prDk+Tvee+NvlpbGq9TuAcIWfQ0zZWPIM?=
 =?us-ascii?Q?1KrR+zBG3GWH/38bZ/fH9q5dg8hPPgYIvpLeROXknUaHjYi5yqdl40pE4Ras?=
 =?us-ascii?Q?MhM2Vrg1XYxANdey7YowzhPApI5w601gZJFaAWV/wqVQIZWar8kdJVVCBJhO?=
 =?us-ascii?Q?pU3NoYtNUwGqmLbMIVKt8um+GRQFr4R+Khqr1RbNKs0eYeKQTkMVw47zxxEd?=
 =?us-ascii?Q?meM4BaqydB4aY7OyOoIw8LxTloUIMPE9/FsUnx9U5RtrZtjvLZaZKwzwAJ7p?=
 =?us-ascii?Q?rOEMJCop/hRPxDOj6pDF1uakvoHHvo3qd7QxQu/PN91skx5eC4DwMgOoBDZR?=
 =?us-ascii?Q?OjMybZTJh4wjvuVNWiAtxQPPX8PwL67wXdrDUnKwRv4Ipu+2hJB9vOYavh4J?=
 =?us-ascii?Q?Dbiy9z6/64Hok/+OHZucsBDB6Dn9pawYyE8sHH/bH/X8dMHLfxE+Z3Ke2c7H?=
 =?us-ascii?Q?SYm5A6u2njDpfS+Gg4hITz0W+qXgNXr2100bjm2X2CW4d+NHph35KpRJQ01n?=
 =?us-ascii?Q?cuo8xNEeRkzTw5LrWHWuadN//JPOEfIwixP4ErpfZTccGIc3EglcJ2bC5jHj?=
 =?us-ascii?Q?jU5MDA7EMt0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wkT71FYQ2/qMZZoaaH2HniXYk/rIia+OiU9wo0RmorFUM+d5FQRuCZBo3v66?=
 =?us-ascii?Q?iTJeBlr7neKU+r6XntQNSIgnv8JxyKv02nqfcHJtByDQlBm0v9Lu/9BrcG8h?=
 =?us-ascii?Q?OvD0brv3HAsEPmvTrB23pSeZTTPXtEndYoE3vL91FIasu2Qd9NtTQrZB9hGp?=
 =?us-ascii?Q?VGxG91FdAbrtgGBmFDiJCXnzxv99qCI/y73G0jLTYCK2QyMnj2SnWghBwLPv?=
 =?us-ascii?Q?Xe6Dk1A2QJ40sppKDueoXeWNgS5YRSe0JzrnnT6KhOMHqKaQ4Ost2gOumdzk?=
 =?us-ascii?Q?1NsdYOPbGqW6Z/2u4o/0Cbrwww7NXJ++0u6Iz01Liu9tSBN2nzGuvBEZifym?=
 =?us-ascii?Q?G6VKGqxQDWs6liwsqOg3jkkm+gqfV7IIBRHkkmK8zfWtxceCc/ep6AkbW3Z2?=
 =?us-ascii?Q?uXqfacdwzwqwGdUu0GxZQosO9OzhjXRMmyIToS1+xHxDN6vp2Lf7BaNTnRJ1?=
 =?us-ascii?Q?ehjdbf1mXFixiddVin5FdkITr48I82aVaAfej28w8/EZU/qklhh6GcYX9kOV?=
 =?us-ascii?Q?irrt36HvkzaTmlhf5CxRlLeKO6w59TBAYPsQax8XLIq49Pkpx+tWux5PJmHD?=
 =?us-ascii?Q?lRLJX5Ib5YTpqlAJPFxaU8zhFj2j9ANCyczX2MCr+xGcgh66Y3dXd6LPrTz4?=
 =?us-ascii?Q?SpQUkkt2YSiUtbNRBMVWJN5l045XICNdsfZTG3+K+AxiJrowhJKM7jzq4Ng0?=
 =?us-ascii?Q?mRGxQmbxkTWVamfrvIbfabJDE9NNS9U4hVNzOJah13XI+qHINHpaa0vEkRJT?=
 =?us-ascii?Q?O+WHflhg4FxP5o61mQRKd99ZgDh/MLA/zNafdKazSwqVNuIeUGRK92AcfFzI?=
 =?us-ascii?Q?w3p8YbuR+Rt1YfEFw2VNC0J23WXYTF+Ro0pJ1YSNNjoJKNYQrfu3XcBHHRct?=
 =?us-ascii?Q?Xw4wZHO4yWaqzqU//68ATBbdWrIY0dldEApW5qp7vsME+AkXN1YUCNhwOMHQ?=
 =?us-ascii?Q?2Y6J3pihm2CRf1dMrjq2kSJwR2OjBo7SvGFhDUXBINcic8gajc4YRzyL4O65?=
 =?us-ascii?Q?rk7/1UlC3LOgMbcTuCpORHAleJJdAZuA/4PSwA5CA0cbP2FMgHXyB+YTkUDt?=
 =?us-ascii?Q?LnjwE3YIJPns3nKrZqwh32WmgM1CCz2k1jGxLpd52mtGKJJXPVFne9MYB/2i?=
 =?us-ascii?Q?Do7XyE5LZYQ2tRoLyxOZv6Tzsb8I6HjtJ1QXkFwqCtoTbZOv50nRyPHHwJqY?=
 =?us-ascii?Q?P/4LrxRwK68hWteJA4qCxPik4fSVluB5cuyDsazZ+tpKp2O0uAsqCMBYIlJN?=
 =?us-ascii?Q?rwU7qisaYRzs5MWhtpe5HI0eTEYBZdrQkui662KBeiFAKG8odNX6uHWkHX7o?=
 =?us-ascii?Q?W9kDMFcEkY2UH3NGhgu7aoDZPx5rPHBYFPqcDd3xgAcd261iyHzlQStIfPnB?=
 =?us-ascii?Q?HhiMCbAUrvqqG0aljTqCOdwQtEV4QvRsPO64GL/26tgU7bvylfF8fXkr2Sqf?=
 =?us-ascii?Q?7sfglOVLmnxZ3FHrms5zJhcsCQaT26kNoMcOVD6Tjqz59IxB18GRyMbtg7VY?=
 =?us-ascii?Q?paoiUd4g3LStF53m0ortL/h2I62Rgx2Ecc/oQsduJMIDcIfU6hGUnGVV8aix?=
 =?us-ascii?Q?4ynWXKMvk+KXKnqAxdeuZIPbhmha/+9uKJ/pnNts?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18492f7c-8a73-4b6b-9174-08dd9db7c5dd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:17:58.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj1DzMQw0IpNZHONCYkyZAFqkMx+Jhtn4H5G+yIUTYe4p7b0cDX+9UTgk51fJFdvgZl95/1cihBgS9Y9dZshbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816

On Tue, May 27, 2025 at 02:46:28PM -0700, Dan Williams wrote:
> Alistair Popple wrote:
> > Commit 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning
> > entries") introduced a new function, wait_entry_unlocked_exclusive(),
> > which waits for the current entry to become unlocked without advancing
> > the XArray iterator state.
> > 
> > Waiting for the entry to become unlocked requires dropping the XArray
> > lock. This requires calling xas_pause() prior to dropping the lock
> > which leaves the xas in a suitable state for the next iteration. However
> > this has the side-effect of advancing the xas state to the next index.
> > Normally this isn't an issue because xas_for_each() contains code to
> > detect this state and thus avoid advancing the index a second time on
> > the next loop iteration.
> > 
> > However both callers of and wait_entry_unlocked_exclusive() itself
> > subsequently use the xas state to reload the entry. As xas_pause()
> > updated the state to the next index this will cause the current entry
> > which is being waited on to be skipped. This caused the following
> > warning to fire intermittently when running xftest generic/068 on an XFS
> > filesystem with FS DAX enabled:
> > 
> > [   35.067397] ------------[ cut here ]------------
> > [   35.068229] WARNING: CPU: 21 PID: 1640 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0xd8/0x1e0
> [..]
> > 
> > Fix this by using xas_reset() instead, which is equivalent in
> > implementation to xas_pause() but does not advance the XArray state.
> > 
> > Fixes: 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning entries")
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> [..]
> > 
> > Hi Andrew,
> > 
> > Apologies for finding this so late in the cycle. This is a very
> > intermittent issue for me, and it seems it was only exposed by a recent
> > upgrade to my test machine/setup. The user visible impact is the same
> > as for the original commit this fixes. That is possible file data
> > corruption if a device has a FS DAX page pinned for DMA.
> > 
> > So in other words it means my original fix was not 100% effective.
> > The issue that commit fixed has existed for a long time without being
> > reported, so not sure if this is worth trying to get into v6.15 or not.
> > 
> > Either way I figured it would be best to send this ASAP, which means I
> > am still waiting for a complete xfstest run to complete (although the
> > failing test does now pass cleanly).
> > ---
> >  fs/dax.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 676303419e9e..f8d8b1afd232 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -257,7 +257,7 @@ static void *wait_entry_unlocked_exclusive(struct xa_state *xas, void *entry)
> >  		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
> >  		prepare_to_wait_exclusive(wq, &ewait.wait,
> >  					TASK_UNINTERRUPTIBLE);
> > -		xas_pause(xas);
> > +		xas_reset(xas);
> >  		xas_unlock_irq(xas);
> >  		schedule();
> >  		finish_wait(wq, &ewait.wait);
> 
> This looks super-subtle, but so did the original fix commit 6be3e21d25ca
> ("fs/dax: don't skip locked entries when scanning entries"). The
> resolution is the same to make sure the xarray state does not mistakenly
> advance when the lock is dropped.

Yes, the XArray iterator code is super subtle. The fact it took at least two
engineers three attempts which were also reviewed to get this (hopefully!) right
suggests it's certainly not obvious.

That said I don't have any good suggestions for making it better other than
renaming functions which will create a lot of churn.

> You can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!

