Return-Path: <linux-fsdevel+bounces-16756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB8E8A2341
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8121C21496
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0080F5C82;
	Fri, 12 Apr 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fhW5Usns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701333F7;
	Fri, 12 Apr 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885644; cv=fail; b=bcBAPe/R4d/JA3/9JWGiRkktlG9X6jl38qYYuaISlachhbkTFdD86jOwYWt4DW1zYzPLJPD/uzoOXcqMxToNpH8RfVr3OviJAEAMd20YxdQbrx6Wu0TSBIULSNqYpR4UcRmDaWTSHBEDB/hMOnfwHg9sDkvcyadVw/fmbhjspKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885644; c=relaxed/simple;
	bh=pbGAr3OJqYBN8ev9Wv9dW8DX9EmJ9NnrMXmHLwFgTmY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=fqgKFu2ZQE23eh1RhihpRKzirP3LLtQW3HPbtRMpzZ/D2eliIO1wuCPh6rJAGG7ca3dnBiAqq4rBJr/yi1ERpVZaILSpW4cwJ3kk2MMCp43J+DaUYcKx6DiGyxo7LjFNohCJYaEhGlUz/qATf2R4hpxAnMgfc/jzh8hhSpwoRtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fhW5Usns; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvNM44vHK34gCq1kEMdxTEwAb1Io8mwshZG5fztHbQofyuNkcNjB/3UKD6/PqaPFfQy0EQZF6sa0RQ7hYv6OYtdiWN8wD5PddUmrhdcNaQGNUDEMZYEC0/apPSiExcuZ+pi5J0lUrnahTmjioq6GtXAVjYD20um5Ur2osAHwFuRUQK4CWq7W0BsH8onb4ryzOlQFDxIEd0GUlRyDe4Cw4tHFpn0nfOdry7uE+naK5WKKinjehMAn+KeCXoeGNo4Rl9nM5EHCrvyI5kzLvq4tGhwHv7fh6YQLfFwZYTPPvBbIE9dsnryMagh979WhzEtrXb8upsBwTcKgbCOqiHEN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxkvrIM+iKa0dK34lBZn78uIEVXi+SOQVhBFrz/7NSY=;
 b=oao/heeXHXt+THo0UqoO2qvbBIO9Mx0ehtcYz1PqxYwyi7q5k42F9dQKXPiDWjRE9ushbBAbQJn4Mt9gqTSVWCa/+Qaqid2hUnktzGAOIsY5tmfglkfFr8j0Kg7vZYNfnO7jg8B+Ner+tgQm5fXgco8fZ5QKsoXvXQyum5yJwj/zrEF7t54MZebPFzhpHgXN+5EmGkQRcv7L27eUQjzXQetaJ8dF2sBDHWCspkJ+wSDeAIwMBR1BW24g4JdP9elz8vOmJ42BtDn/AkVatIEIQrWdDk4Xk4zwYgRutc1rn0C5Gi1cm9819HhQaAz9aPwUH4n49e3mr+mU47QWh+IoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxkvrIM+iKa0dK34lBZn78uIEVXi+SOQVhBFrz/7NSY=;
 b=fhW5UsnsfpWkPTe0uT08dx/iNSEbFWErF4j57Nm1pv9iCavdQrVpkgtzHdPjh0S2ylNWfMbcjywuj/NmXxBUrhOOdGB2DIB9GJuLHF2g+Mg5STnXFMbTN9ZoW6bsxy7qaTZu6B+JgyO092Y1MsAoVvv8oi585eRPzvgHpsSnyFwj2BjO0YlBGJGOYSr7lbQPhTR+avH9X/kthvEQ0iAGWHyGFruYIdO79pgZ/HvWVjuyWUnLdNzx7SwAWnW99U7YIh/DilKvjYjzykcUpTCcgrPgPHpUF6HqzURDB/atatAIT+j4SBvY+xAsq2liZ4BGRn2laUeCFgInGaDpQBuvhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Fri, 12 Apr
 2024 01:33:58 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:33:58 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <e4a877d1f77d778a2e820b9df66f6b7422bf2276.1712796818.git-series.apopple@nvidia.com>
 <20240411122530.GQ5383@nvidia.com> <ZhfnnYfqWKZn5Inh@x1n>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
 david@fromorbit.com, dan.j.williams@intel.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 jack@suse.cz, djwong@kernel.org, hch@lst.de, david@redhat.com,
 ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 02/10] mm/hmm: Remove dead check for HugeTLB and FS DAX
Date: Fri, 12 Apr 2024 11:28:47 +1000
In-reply-to: <ZhfnnYfqWKZn5Inh@x1n>
Message-ID: <87wmp35pq6.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0035.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::10) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 741decff-aab6-417a-4234-08dc5a909fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RFL84Dn9y8B3VOL+dLnYr/6eURsqASyOUx7Wnx0J9ZeWS1TCC2tvvIR253Cq1aqPZTvk7bjQKaeqjDJRNVrmstR6wtnc9mEcbQehZ8XfDEKf7rAsHy7Dm/ypWPURpEzyn4+LgqqS3yTRlV/nlV8SQLIfCnnE+KLcTflb7EW8dV6fiYT1ziRSzdcaJVzFHu1Uu7AKA56t/MuSY7IoocALxoH892pV2Mdb7we8vFlRu2rBVIcCiB4ZE2QWFPLYqSYDaoVa6phQr3ULJPtn3z3RA2Vz8xhUsuX/DcZRyZZtZKGiKQBuPwlm7iIx2aYdXfmT0U6WEPnlUMRUtcxH0raU94cNENv5ue5h8G4mYUg7s6Lu/6bN7L9s8RNwWf1yK5YoHWVnChiMDylQ7SH49cgMEoRyta1YPGCKsV81aAJw8RDl0IOO90QuCw8sM1XMGZtbnHPSvhsdnkbaLyOBZOGXeffMYlHh45L89fgc1RZrrmYRFuG7a96QhriVdFkznGfdScNFzciHE7UQ6Eo8GlZJfLqb2z0DdyyVRhv37WgvaG6We1fcuHLpF/DjlNDceZjhQIInr4pSC8MRq+7okE1oW4KiPm3ZeRv+8JXrty5DNXLTNSWBZwa6PFfY8voF+zBo8nIX/BHzbXVmuMkwlHRXst/0P3GX7zJPHQ2TxYcHYDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EulMncKi8RsyDM+2CrUthNiFPNW/Rr6lMSy5L82kupZ4PKl3D3idNYKwi9MB?=
 =?us-ascii?Q?FZI1ivOPaNf2Ekol3U4YSEt0nFWdDzVSAjWR0cIahz6WmEQXfZcXIqQEwmpH?=
 =?us-ascii?Q?8I2rIVcNrTKCM46kpNGcpY48qbSY80DV39BEBoUVr7xRHrUOOd5RX4onqD/U?=
 =?us-ascii?Q?bI6Os1Vd2mmRGmQc4LsnrNpADrU4p2oEQuUOBBsWH71lIZET0jhieyC9Lpn1?=
 =?us-ascii?Q?CtbgHFjkPVmSgBkKPFPbyUW2+c/X8ic5laMX+968YTlqA1MoHSFvbQpWPEr5?=
 =?us-ascii?Q?Oj8GKv/o1l3w93jbSZLnmF4rSXSt2dqzAmMxCXZNixblCgrScbuEIzsboaKA?=
 =?us-ascii?Q?qzyq3jytzoipfNY+UsViY6eOWXtUkCxekGf+1OSl89bhQraowpEnwfLYdT+9?=
 =?us-ascii?Q?jmQPb26jfFi4nTt0TIA4ZZsnsvigQBreFZ7huEy0gYESw2eSEH4qqjLc7Skl?=
 =?us-ascii?Q?a19xys0NMf2IgyI0WFf1EO5pVCghzxeUdZYWv1R2fTum5hPWWhHJPcbvuWiP?=
 =?us-ascii?Q?Y8je0TWlNBP/uTMiikiGVeIe1R6R0Q2f7aJnmuIrjDU2C9OwkFVwaROysxy8?=
 =?us-ascii?Q?NNRC7uuAdJw7fpQS/vAMw9P3XOXTPsJ+EIEct1Bua89JtiLEVvBYsWAWJQHQ?=
 =?us-ascii?Q?H6GDw5s/zdN5VlC7HZD9j4uf6WfqZ4Q9c/auRf7JQ4pS6TiyvmGAJYcL7Q3U?=
 =?us-ascii?Q?Ym4ik5NSsP15AymOslKtD6QzFsVXCxLMTeFCQdDyYo0IDKap+gFcM3FWegq+?=
 =?us-ascii?Q?FKvV1V0sDV4TZJ241BoQMZBmngFpOhi0lLz2+AL/YjleVF4ISNOo0WcNqytT?=
 =?us-ascii?Q?5e7uraucFSUUuI4RPK35tRE9emDRxR35IEkXyFmMXSQtq+9D6peXcCaRlJcj?=
 =?us-ascii?Q?TQQCPX1NC3qSrNEHGbUv3fA0DnJ6+Ux2WaR00lcJY5BKxeg/6og4TzFqsrn3?=
 =?us-ascii?Q?PSW5+XH7O7RrnQGyG5Q3OdnRxdwdOKl6Msu76Ph8jq51eh2DUOBa60hsqc5C?=
 =?us-ascii?Q?ND3vIvhx6cKjN6n6+UkSLc5ItkJoGqWH7WHnMHpIn1hofjkaKEmpzVGhUNtR?=
 =?us-ascii?Q?j2DZ/iY37Rb8xmSuFxGfmufJKJZw/syld3M4mD+6b9AUg59/URl6XzBnvc5S?=
 =?us-ascii?Q?jF0naqMvwFCIuYV1xEPqnjnkjM+FH8v4RYq67TdbgN7fg/W/O6bKHx+JX6za?=
 =?us-ascii?Q?syRiYW/J73gHqKYgi0VT3bvkCm+2INEplxCXYu5lIVI4D2LFo3XW4/ww8uEw?=
 =?us-ascii?Q?JOWaLucmEv7lphCPKTL/BxbrX8jRwBHoVqzaV07VxQ+so+yX8Ay1TCiGGieS?=
 =?us-ascii?Q?RWNsuevAGYEMHfQl8ZgedfBgmESxzfc+gB70XWcCCKa961aNSiA55BSVPXC0?=
 =?us-ascii?Q?2C0v2sD1w8cHrE2ZPLPRQb4Bvcwq30mc3QvCiDzasqSvocsdkoIUKCLu9rwz?=
 =?us-ascii?Q?B3JGfKK0+nIRYHvbADd5kGxNe2M3ePpF6CH8Dc4G8b+goWU3+Ebn59pS33Tn?=
 =?us-ascii?Q?4TeE0lYqBYoYK9OlfahdBdk1P5zOGgysJbelddj1QOsldQBi4UmQ8mvgsDTD?=
 =?us-ascii?Q?lKzLrFwfymj+osRbpepg601nKtJePf7XP+rJRDTI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741decff-aab6-417a-4234-08dc5a909fb1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 01:33:58.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0dQ2EuZn37Zle1IgGj3CbrJq6dQQRgZDBxzjxBoaJ4IjNAufZGQICl05xSVWXJetEoliJqZ0bq6Rh4i+eYWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440


Peter Xu <peterx@redhat.com> writes:

> On Thu, Apr 11, 2024 at 09:25:30AM -0300, Jason Gunthorpe wrote:
>> On Thu, Apr 11, 2024 at 10:57:23AM +1000, Alistair Popple wrote:
>> > pud_huge() returns true only for a HugeTLB page. pud_devmap() is only
>> > used by FS DAX pages. These two things are mutually exclusive so this
>> > code is dead code and can be removed.
>> 
>> I'm not sure this is true.. pud_huge() is mostly a misspelling of pud_leaf()..
>> 
>> > -	if (pud_huge(pud) && pud_devmap(pud)) {
>> 
>> I suspect this should be written as:
>> 
>>    if (pud_leaf(pud) && pud_devmap(pud)) {

Oh that makes a lot more sense. I'd taken the comment for pud_huge() at
face value (ie. that it's a hugetlbfs page) without digging further.

>> In line with Peter's work here:
>> 
>> https://lore.kernel.org/linux-mm/20240321220802.679544-1-peterx@redhat.com/
>
> Just to provide more information for Alistair, this patch already switched
> that over to a _leaf():

Got it, thanks (and apologies for missing my Cc on that).

> https://lore.kernel.org/r/20240318200404.448346-12-peterx@redhat.com
>
> That's in mm-unstable now, so should see that in a rebase.
>
> And btw it's great to see that pxx_devmap() can go away.

Yep, AFAICT pxx_devmap only exists to do this special FS DAX
refcounting. Once that is fixed it can go away.

> Thanks,


