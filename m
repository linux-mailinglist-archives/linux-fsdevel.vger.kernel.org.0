Return-Path: <linux-fsdevel+bounces-16796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C898A2DCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5421F21907
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0155C3E;
	Fri, 12 Apr 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwsFpUzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68A5466B;
	Fri, 12 Apr 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922841; cv=fail; b=po2KruM1edv3RZuQmi26sS7msHRZae2VhoZL08ca/DEgckmJmMU3NDobTwta7znHh0G2JvQ7rcWRgdAAEESUzRMeDv1UhuuDvi3RZ+rxGqiLfiSqprMN0P7ZJTGAHArTuemg/LFhFe3n+hePGOAdGGf9rWxlp08dDZfxjUQRsio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922841; c=relaxed/simple;
	bh=F8NXIN3MAAxaPfUWYlPBhhmvQ67k4+NabcisOtRfORg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aN3AWQkAZeeUqOt5Fm+9va/DXF3Udgq8rAPxYAunjRzVoTVVQklYyewwWPkcxcrsiP29YuQSCEgdIcMAHWqrx33rt8J7wLKBYBN8GaTex9/NpoONphmz6ezk8EQsdftzkAYrI+R4jD2lntuEXygR//ZSNZtVl+IooQ2NOKdlIBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwsFpUzN; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWGV5h35MaEgBfX19DLAvccDMR5FZkjQoWtF1xLkGTVwgttoIJf3VQ5IOy9p3rv2pO8zyNy5DzFOHFOqksFaOivCXBckU+d6HQBVKM/c17Bmh5btiwX4MRJ1bvRE1Ft3NdkVBApLNNUgpU8cGgEzH7M2Xph9ywpVfdPIwFZN9w71NLlWvgFXWF6oTWnrdw+wRnDnYp0mr/wxbYV5z3Tb4p50GaFM7xsp3/H0N66N+W+47mmNDSAseRK4KViOH80Ui0qkW3qGJ2Y6DZIBk+8u/JrFAh6XuuiIRFB7nvJqitVtvQTEtQyFivcNJrNPPNrHaN1Xb6CDSfHbd8uzc8mn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8NXIN3MAAxaPfUWYlPBhhmvQ67k4+NabcisOtRfORg=;
 b=lIHU6GRBgSdwSYutBtsql/nN7u6qVkYG/3yXp1Pibc0Td8bNGO1U4sZ9wIPIXIG3y960s7nL+ncJZxT56qmtagXE3jyrc6xsQkWQ0TQLrMNOALyP/Rsex2jAOlH7AuEuYD7+tGBfbFRIPEcoaXgn5MksYTidItCMhJyn617SXTpeSbPiiDOXc1I7AMP2QGynEYWspOG4BHYNNuznAK6lFJcRq7mkAjAwjFDvvMzLnGPTfkmWs88H2/JkswnMkhLpDtURS1xvfzmryENrIYGJAQ9z6mqoWwXti+dwKPkGawT7r+Cmvsdzn07NBXp6rHlhkakktlgmZMAZljrvI2l+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8NXIN3MAAxaPfUWYlPBhhmvQ67k4+NabcisOtRfORg=;
 b=bwsFpUzN6M+n8HavaeD/q1SfLD2M16OKkA8MB3LZTPezoU9cnJakghB30ysr+065KibyWIbc4dCU7QskYrVSAziXi/nMj8Tj0ANoKFPF2CfHNm2mwc4m3po1ua3YF7DPaT2D9S+ruDWjfKkVWaLnJm7Kla+5nrzH79B5pq1IQRI81NdJA//1l3/goHThmlRGbV+hRfungQJtJvJPrWBto+bgwLapiN/c0kMXgMCrRnObF4BTjFNfu/DBJwPsLqb9OmsHEOcF7xEkKqczJv7/+k+23OF+cxG/I3LOBTl2qwzJmEqNKaFkmTLKh9ZSl3X/hUGhhjm6i3OsELYvRhQdVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 11:53:56 +0000
Received: from BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::1395:49dc:c6cc:5295]) by BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::1395:49dc:c6cc:5295%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 11:53:54 +0000
Date: Fri, 12 Apr 2024 08:53:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
	david@fromorbit.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
	willy@infradead.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	djwong@kernel.org, hch@lst.de, david@redhat.com,
	ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	jglisse@redhat.com
Subject: Re: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Message-ID: <20240412115352.GY5383@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87frvr5has.fsf@nvdebian.thelocal>
 <877ch35ahu.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ch35ahu.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To BY5PR12MB3843.namprd12.prod.outlook.com
 (2603:10b6:a03:1a4::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3843:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f4a59b-ca2c-4d03-880a-08dc5ae73a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DMWgNlROWRiTdX6CrwpG/26fl0o0xfCK/tdphcc6JaIOf1gVxW6MOaen+7KlvOzpSShf2olKrmQTcpDfORtsdRD7J7RSKveyFHKa9TKdsnE5htGxf6mL0LdtBV0qqcUIHYHObqkq72VukvHyUypv6UYFvFTtLDXcZPhznmJL1ugThOifitU9DzDe1hrRXfgN2fc5jqzLXspMY3vAf7zcOgVJpRPs+YdXVH80GUtXmQN2w1m/WXJhEFDm4UfyqsqePx6PCLtCvvY0Q5mxyCoZICerkVrCW2LJ0mlYPbPzbY2U3bjTg5ziK/i08I0g0KCQKbdtHIk9izdIPhqAMLffCv+NbDS/RftKZYw08LAQddP+dj3KYCdI+ULLXgLsGkDqXfOaitTFllB97L3tBrsH0lA8l65lHDr1IvbG/GyypE3P57gOKTEEIuPyXz4b+w99GXTKm76P5Z+gR0v3KYwv79UlFg0rEPTOm1FZjMvGRtFI1GL9YJFzNpuLQayjAF7H0+8zQxU/cxeVmocDPFbU0iuibWEAEKBm3Yz7K/fKzpH9bM96ZP5RCtU4m0yN3UOiGgFHE0oQp+mHRwaBR4HotzOu9dZrbtTZMYBbcvek4dIHcVUPjNCQXa7v3uIYxM5UyFQIuzWk3zSA2TIvf3whcqVBaiI7TgEJbjzemU4TjSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tZgwPiZ453RZMGiSewWKAWHuiMT7BAvdUwO4peHX7YOF2jNdjAPidcqm07jY?=
 =?us-ascii?Q?tFJXD3AlLAvRWGY/PLzrhUC+Ld3r9CWUYjpROKgtICD6JShQrD7qs4tH9M6l?=
 =?us-ascii?Q?aUeWxIvto0O5E0AKZx21g59UsSn4eQgMyGq0QHbpPXT4ClgUcL0fO0yNiryK?=
 =?us-ascii?Q?Y9mIO9nMZGahYCTP3dIGMswUVBzVhJ453xskhETk6ij/qmHVUpohz+E4ndV/?=
 =?us-ascii?Q?SfGfG6VbA2O0jGdsk2CcKCW4nVovUmMtzp+ZSL+pHjgrBzVkXqxngla6uw/P?=
 =?us-ascii?Q?qFJH8AZ7hKGfoJ1jhBWDp1mhl/pid8f0X0gzIKUoInj1pjE+s0cqk8ypTpfl?=
 =?us-ascii?Q?CDPXqyCIXwgpHriWhOGM59oJPEqQkWyzfxV0AsBEjP2qnm9b5XtML0bmCmvJ?=
 =?us-ascii?Q?WVeqEsNy1ht09q4K2mZ2fUzW4Zq6ptja/pwfvmbPqXVacRHmHVHaJHihTG72?=
 =?us-ascii?Q?xYsl72Zfcf5TnD/h6VLp+d6HQCM9fU0ZHjQ4k8J+8gXjJO1k68uhRaCYegj2?=
 =?us-ascii?Q?JLu6i5ISAdFN1pbuILLWkdEhKbDN7xb2f/uve6F/+VP+WvXDN3vEsdeYI3pA?=
 =?us-ascii?Q?TW2uHoc00PUCQ4jRzWGQatZdpOgTiIN8uhaSeHsalzAdCRN8X1MQM9D6jbqM?=
 =?us-ascii?Q?4WPMGCVlC4NscvBRvAL5BaRvjCqF6cTCTACYh4K6S1/4wB0WHFxLHwnmXPQl?=
 =?us-ascii?Q?/96Cim4QFRbQqlZrxOvl1ssQOUac5MCf6ikM8/7lgBNBX8/iLV1iH4XyLbir?=
 =?us-ascii?Q?f0YDWbxwXOWtcD5o/ULQaCiZF7njriV/WkOfuaPJp75ufSL+aNgGJyzAH6a2?=
 =?us-ascii?Q?Po/QW5vGZ5nJkh70j0AiRDL86nR8FynrQfI8d0nxQ73XUKztH/yJYkG0PZpN?=
 =?us-ascii?Q?fa24u2vVKYzsusGuhvcMt6a2Qrf+PZEOkYaYDtS5neJNowONkHUPaAy9Tez7?=
 =?us-ascii?Q?IsZt5upceMIPD2aCRb4GxEx9GxXXxJNPcved/r4n2cQg/5ci0+zkPoVFHn5a?=
 =?us-ascii?Q?m5Qk4cqenZhxKMgY3HFfRG2llvE3H1n+dySgXr+y+JNqiXEeHooWgDeXcymq?=
 =?us-ascii?Q?wywM9EhLqF//ApNAU/j4y5sgLWryr9zKuH0A54BXhNHDtpki+c6HGMU7lywK?=
 =?us-ascii?Q?k27cwV5hrFLuBJh5VVEFUsm+V6TpUj1KJRNKYmRMLBUbdyOI9lLwwS1Ag9xA?=
 =?us-ascii?Q?Obi+YhqlgOpOw63+KPjBOqLFVXv0VGTWyXr+qKZorzvFBpc3QqNRQdkcCdQe?=
 =?us-ascii?Q?z87cSYshKpTf3Lhxe3djk7EQwLTMbGSlphtNlMJp6ksH2IW68X/3gRen4vLf?=
 =?us-ascii?Q?NDlx3o7pF6eYezu6VxVicVjoybpoxfyzurkgVgRr7tbiI9vmECKFfotgpABH?=
 =?us-ascii?Q?1N+q4aY48NL4F3b4Yz+8xxMmg4TtlBN11KDS2CYEkelEpyYJAfjnRQkrzkxd?=
 =?us-ascii?Q?Msea/wzyuAMqAj8qmwGN2bzeUvRZtVm8KE0++Xyz9CGZ/2M49GMVtneOHRmo?=
 =?us-ascii?Q?YUikvfrZClSFSCySD2z6Sq8N8TWnV8CscUKGjUgxIl6aBLk1syiiWEI6LWgP?=
 =?us-ascii?Q?pJlyIqGkQ8/YassyLaE4nhr9RbOtxFa7OhPI6VFC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f4a59b-ca2c-4d03-880a-08dc5ae73a3d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 11:53:54.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDRonoeFkAPV6fzP7cJxVwEa8TuNHXmdJeC1ZuJmedRTJdc80fdJV7nP92Nrr/qH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

On Fri, Apr 12, 2024 at 04:55:31PM +1000, Alistair Popple wrote:

> Ok, I think I found the dragons you were talking about earlier for
> device-dax. I completely broke that because as you've already pointed
> out pmd_trans_huge() won't filter out DAX pages. That's fine for FS DAX
> (because the pages are essentially normal pages now anyway), but we
> don't have a PMD equivalent of vm_normal_page() which leads to all sorts
> of issues for DEVDAX.

What about vm_normal_page() depends on the radix level ?

Doesn't DEVDAX memory have struct page too?

> So I will probably have to add something like that unless we only need
> to support large (pmd/pud) mappings of DEVDAX pages on systems with
> CONFIG_ARCH_HAS_PTE_SPECIAL in which case I guess we could just filter
> based on pte_special().

pte_special should only be used by memory without a struct page, is
that what DEVDAX is?

Jason

