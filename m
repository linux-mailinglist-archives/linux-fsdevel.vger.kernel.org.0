Return-Path: <linux-fsdevel+bounces-53848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE7AF8206
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 22:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2747AC3C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6042BDC01;
	Thu,  3 Jul 2025 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QSsDEo6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA91C68A6;
	Thu,  3 Jul 2025 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575270; cv=fail; b=mGPbF165QkyTDngPY/50Y7ihgq06w7iyAL1TJI858ODRqH52U2SwJ4kchqKld9chXwJbDrMPTyRWz4GWjKmCty6qr62Qmm6loTZPyx5CFyQvdvDUnHLip8shmLNbwMPaMPdmK9ncouTMvdlZBz9RyYwcRAwb+MDnfo1sMmSEtjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575270; c=relaxed/simple;
	bh=WIVCSYE2DbsZbh3yBU5g5vhyIEelee05N4UleCVrwcw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdsTwLa03CqS6zRFh3HjVDBw4+KRXZG2FaWKnKmWn1fKhGZt2SkRvakcWO660Ih7mhJSICu40mXEdjpN3/pZvCQaPi+CYsXXKCOKPqtn/vIP9ciz5GD2hdQJEw+FTea4IXjKcBS5wVYO2mMJw5ZUrernBb1jbHor7/llK7al99A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSsDEo6x; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loZPR+HKacQA6JF/C983uQiI4EfL4euS3YsgMYn/s5eue9Cj1AKJ6wx48F1F5TCZup30MBvUCF997F8lSYWMAaJ80pNiFNcExmM8OQ8+9jUfwwUrpS2WFn4Cz8RhQZxLtRRRBvmQBms5RjrpCpl+wQjKBbbywYLVIuoOaxXKyC87LzUY0Frtwv0UGm/PJYHOjdEUHsQiDEY//LulGp2Pxw1CMj1wozFaMuf7z0dzYRw3FVSnVOR2dpaTmje8TlOV0QP6LPx4f/FXQY+wgBfXRnttYCIax7rPCVXKQpaAqIJI0e/Jq9d8imB8KFK+sLiCpBzhKEQGcM6ljCj++FaztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI+Wxp+ZLZWMGIIffQvLPzVoMjr8b09yGpH8Fpen6FI=;
 b=aqmDwcR7cNzwpBOXASxeg1mv6IX6PnfbuepfO2Wx49zf9h/TrIHPWBmtWFVrikpTPqavStugmtmv326wJr+zQ6OtTw8UbojGEVuuQT/YKTKozn5M6Auc30NtHDMPcXXGuuwQOJ3yVb8ZBRiZcmdELU9viAFD0j3WCWqR0weelTrXQd+87M8h50z7maUAH4eC+nDZ0it2UL81isPac+vlOJo9Wr0kWseA2wOxHPWVRYUmO8Ok9p+1MhGc3L+qpPlEIHl7lAdwWNvxEi8l5dLEZreZMbrmNwt7ub2TfadiFfX0/fmRvrU3/F1HYIRQFCT4OmMxjcZqapYTgNG3ZJxrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI+Wxp+ZLZWMGIIffQvLPzVoMjr8b09yGpH8Fpen6FI=;
 b=QSsDEo6xLb5QgkAGP7tcGhHp11qAHpWAEkNBYrskyQzmWq6WeboYUNSyjpUsrZxYPR6oWDAcE9+t58eodX00ikcgwXmmNdgyoi3sca1uJYByyIiJPkEnJyCFkmTe+pOZD/eChpW5eJaWxfQBMJde0boAdkAUaAUxSKxIBdT3RuM=
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 3 Jul
 2025 20:41:04 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::93) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 20:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 20:41:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 15:41:03 -0500
Date: Thu, 3 Jul 2025 15:39:44 -0500
From: Michael Roth <michael.roth@amd.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<mpe@ellerman.id.au>, <muchun.song@linux.dev>, <nikunj@amd.com>,
	<nsaenz@amazon.es>, <oliver.upton@linux.dev>, <palmer@dabbelt.com>,
	<pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>, <pbonzini@redhat.com>,
	<pdurrant@amazon.co.uk>, <peterx@redhat.com>, <pgonda@google.com>,
	<pvorel@suse.cz>, <qperret@google.com>, <quic_cvanscha@quicinc.com>,
	<quic_eberman@quicinc.com>, <quic_mnalajal@quicinc.com>,
	<quic_pderrin@quicinc.com>, <quic_pheragu@quicinc.com>,
	<quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
	<richard.weiyang@gmail.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>, <tabba@google.com>,
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yan.y.zhao@intel.com>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
Message-ID: <20250703203944.lhpyzu7elgqmplkl@amd.com>
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com>
 <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com>
 <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
 <20250703041210.uc4ygp4clqw2h6yd@amd.com>
 <CAGtprH9sckYupyU12+nK-ySJjkTgddHmBzrq_4P1Gemck5TGOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH9sckYupyU12+nK-ySJjkTgddHmBzrq_4P1Gemck5TGOQ@mail.gmail.com>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abfab8b-01b0-404d-d50c-08ddba71ee05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWpGVUJ2UDhJUm5Jd08xUnVCZjk1MGF6R0hWQ0pjbkFKZk5hanhZNVVUckN5?=
 =?utf-8?B?TXJ0N1BmQkE4aFlINkNndXBBU0V5Y0tOUXYyb0hzZkNCNnQ3aUo2alVjWUM0?=
 =?utf-8?B?VkdCbUhOZ3RzTVdubDFTQW5ONXFkZFVaUUJJWnpNbVc4bWNjSzJMNmltSW5D?=
 =?utf-8?B?c2duRlo2MTU4aUEvS083VlNBbHpiZ2lkS3FWVFdESlYzNk90NTF5NlovZHpW?=
 =?utf-8?B?cXpHT043SFR4bnpIQ3hRRXV2S0tKYXcyNmVISkFFOWhtMUd4SU82VmlZb3RH?=
 =?utf-8?B?M3RmdGJoL1l2aXdrSXAvMXphbGVXcjZwVTZLQ2FTbWZVRXZTOFNpaGFNT3p4?=
 =?utf-8?B?dUg5a2IvSGZRWm9oNm9pWFZKVHY4Qmo3eEJBT3pMckZQZzF6dlpFbmpvT2tq?=
 =?utf-8?B?WDJCVGdKTS91enY4NW01MTdnbklCbk1VOGh2UXFZZ1c5S3pYZklnaWl1NUdh?=
 =?utf-8?B?VmowTW1LNlpVRW5vbHUxZ2NNT3p5T1k2UXVFZTVXU0FQNGxwODczYVNCMXA4?=
 =?utf-8?B?anh4eXZiSWVrUWh2UmpBUFVjS1psMzByWllsNzhEUXl6RWo4VDNGUUV2bmM4?=
 =?utf-8?B?WkRWVzlkSWFyUmhIL1JZek1kaEVwZmxFWStnUkZXeDIvNG9iNHBxNWZ0NGhE?=
 =?utf-8?B?ODNMNmh6OXUyQzE4T0xTMzZrMWxBajF1d05wdzRPSFRjOGovczdqemVoMDBJ?=
 =?utf-8?B?SjRQK243NzFvRE9qY3dJZkx6MmpIZXhWb08rMForQ2hzRFdJcGp6TG8yM3JB?=
 =?utf-8?B?WVZjWkNYRU4xcE1QcUxrWHBzVmd0ZVp4bVFqbTRRNnFsem90U3AxZnppK1BW?=
 =?utf-8?B?amdIakYyVUpNMGhTUkZxZ002WVRTNEcyWnNUYlNxREt3WVdNMmwycnBnMEF5?=
 =?utf-8?B?OHlwaU9mWkE3VCtHRDF6WHR6ekNXdGxXamFvSXFVa2pBOUxtclliQTFJdS84?=
 =?utf-8?B?K243dGJxRitvcmtnQXJMYXdGU3g4YmFBaE1RQTU5STEzTStnVlVRbFhEYzUv?=
 =?utf-8?B?QlJSRWVxMm54YWhPVk5VeEpzTFphc093eHJ3UVZyNkRaakcvTkJsTjN1QTNK?=
 =?utf-8?B?VXJnV3lVOEZsOUdBbzJrcFRyQjFjMDhIZXVRM3hsZEZ6MklHL0RMMTFqTVcr?=
 =?utf-8?B?REF2dlZxZTFuUGJZQ2ZOY3RTeU1OT3Z0N3pWU2VnZUhRZzd6SEhOYU1ZRWN1?=
 =?utf-8?B?V2xoMlhSTWc2VmlXSktWRm80MXBOZ0RMYkZYcHVrYTdmTU13QzlWMVVWSXpr?=
 =?utf-8?B?cWRCNyt4MTZSUVJIcTlEd1ZmNGI0WEhDKzh6UDF4U1RJUURTeVFvSGZteEJp?=
 =?utf-8?B?TjR1amJZV1E0YU9oVCt6eGVYM2lLTGw2VnNpbnd2Y0h4RjNUVFg2R2FQMGVr?=
 =?utf-8?B?aS9WRlpGdnV1cEVqUzdGQkxmaU54K0FZUUZOSjUyRGlqQTZCZk10M0pLUGVC?=
 =?utf-8?B?N1pZWVZpVFlJYkJrTWQxY1B0dXAzaDFRZ3lmYjdhNlFPRHN2ais3M1pQL3B1?=
 =?utf-8?B?Vm5scUJoWjdEWlljcVRUMWsyOEtZTmVXem1kYzArNlRJREpTWVFvTlB0b2dl?=
 =?utf-8?B?T3FjV1FoNGpvWWsvOEIyYW9BaW94THc5dWdDMlc0WFAvTGRMQ3RiSDJZRys1?=
 =?utf-8?B?Rno4L2JWdFNDbTNuUkhGQXpWdHAySFExU0IvY2YrTU9ZZVF2YzVXSm1IQXhJ?=
 =?utf-8?B?QWEzdVJEaWdpejZNS0ZZbjBkWXFqeVk4WVVDTlhKWDZWdmNOTnphTzBSVTJI?=
 =?utf-8?B?N3lXcG9wc01sNEV3Rm5BOTN0dW81UXp0aUQ4cTFEVE5WM0tLUWN6KzdQUEt0?=
 =?utf-8?B?cGxWOERxSmZ0ME5pQkwrTFQ0YldmSmFCNGIrRDlkRmd1bmRId2IrNzNhamh1?=
 =?utf-8?B?d215TFlxY1A4cE11d0FRTnovWlJ5dWcwRHdBYlBBSHo3ZGh3dlJXR21nUlh0?=
 =?utf-8?B?OSt5L2tFaG0rT0FyNEJwSXRtTDJKaHRoQkJGTjYrZjlEVHE0b3R4a05tYW9U?=
 =?utf-8?B?QVJjZzBUaTE0SU9RNmFTa2FCKzRsUlA5aGNFRS82MGxuYThmRCtYcGkwa2Iv?=
 =?utf-8?Q?btCHln?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 20:41:04.1763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abfab8b-01b0-404d-d50c-08ddba71ee05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On Wed, Jul 02, 2025 at 10:10:36PM -0700, Vishal Annapurve wrote:
> On Wed, Jul 2, 2025 at 9:12 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > On Wed, Jul 02, 2025 at 05:46:23PM -0700, Vishal Annapurve wrote:
> > > On Wed, Jul 2, 2025 at 4:25 PM Michael Roth <michael.roth@amd.com> wrote:
> > > >
> > > > On Wed, Jun 11, 2025 at 02:51:38PM -0700, Ackerley Tng wrote:
> > > > > Michael Roth <michael.roth@amd.com> writes:
> > > > >
> > > > > > On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> > > > > >> Track guest_memfd memory's shareability status within the inode as
> > > > > >> opposed to the file, since it is property of the guest_memfd's memory
> > > > > >> contents.
> > > > > >>
> > > > > >> Shareability is a property of the memory and is indexed using the
> > > > > >> page's index in the inode. Because shareability is the memory's
> > > > > >> property, it is stored within guest_memfd instead of within KVM, like
> > > > > >> in kvm->mem_attr_array.
> > > > > >>
> > > > > >> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
> > > > > >> retained to allow VMs to only use guest_memfd for private memory and
> > > > > >> some other memory for shared memory.
> > > > > >>
> > > > > >> Not all use cases require guest_memfd() to be shared with the host
> > > > > >> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
> > > > > >> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
> > > > > >> private to the guest, and therefore not mappable by the
> > > > > >> host. Otherwise, memory is shared until explicitly converted to
> > > > > >> private.
> > > > > >>
> > > > > >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > > > >> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> > > > > >> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > > > > >> Co-developed-by: Fuad Tabba <tabba@google.com>
> > > > > >> Signed-off-by: Fuad Tabba <tabba@google.com>
> > > > > >> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
> > > > > >> ---
> > > > > >>  Documentation/virt/kvm/api.rst |   5 ++
> > > > > >>  include/uapi/linux/kvm.h       |   2 +
> > > > > >>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
> > > > > >>  3 files changed, 129 insertions(+), 2 deletions(-)
> > > > > >>
> > > > > >> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > > > >> index 86f74ce7f12a..f609337ae1c2 100644
> > > > > >> --- a/Documentation/virt/kvm/api.rst
> > > > > >> +++ b/Documentation/virt/kvm/api.rst
> > > > > >> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
> > > > > >>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
> > > > > >>  This is validated when the guest_memfd instance is bound to the VM.
> > > > > >>
> > > > > >> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
> > > > > >> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
> > > > > >> +will initialize the memory for the guest_memfd as guest-only and not faultable
> > > > > >> +by the host.
> > > > > >> +
> > > > > >
> > > > > > KVM_CAP_GMEM_CONVERSION doesn't get introduced until later, so it seems
> > > > > > like this flag should be deferred until that patch is in place. Is it
> > > > > > really needed at that point though? Userspace would be able to set the
> > > > > > initial state via KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls.
> > > > > >
> > > > >
> > > > > I can move this change to the later patch. Thanks! Will fix in the next
> > > > > revision.
> > > > >
> > > > > > The mtree contents seems to get stored in the same manner in either case so
> > > > > > performance-wise only the overhead of a few userspace<->kernel switches
> > > > > > would be saved. Are there any other reasons?
> > > > > >
> > > > > > Otherwise, maybe just settle on SHARED as a documented default (since at
> > > > > > least non-CoCo VMs would be able to reliably benefit) and let
> > > > > > CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
> > > > > > granularity makes sense for the architecture/guest configuration.
> > > > > >
> > > > >
> > > > > Because shared pages are split once any memory is allocated, having a
> > > > > way to INIT_PRIVATE could avoid the split and then merge on
> > > > > conversion. I feel that is enough value to have this config flag, what
> > > > > do you think?
> > > > >
> > > > > I guess we could also have userspace be careful not to do any allocation
> > > > > before converting.
> >
> > (Re-visiting this with the assumption that we *don't* intend to use mmap() to
> > populate memory (in which case you can pretty much ignore my previous
> > response))
> 
> I am assuming in-place conversion with huge page backing for the
> discussion below.
> 
> Looks like there are three scenarios/usecases we are discussing here:
> 1) Pre-allocating guest_memfd file offsets
>    - Userspace can use fallocate to do this for hugepages by keeping
> the file ranges marked private.
> 2) Prefaulting guest EPT/NPT entries
> 3) Populating initial guest payload into guest_memfd memory
>    - Userspace can mark certain ranges as shared, populate the
> contents and convert the ranges back to private. So mmap will come in
> handy here.
> 
> >
> > I'm still not sure where the INIT_PRIVATE flag comes into play. For SNP,
> > userspace already defaults to marking everything private pretty close to
> > guest_memfd creation time, so the potential for allocations to occur
> > in-between seems small, but worth confirming.
> 
> Ok, I am not much worried about whether the INIT_PRIVATE flag gets
> supported or not, but more about the default setting that different
> CVMs start with. To me, it looks like all CVMs should start as
> everything private by default and if there is a way to bake that
> configuration during guest_memfd creation time that would be good to
> have instead of doing "create and convert" operations and there is a
> fairly low cost to support this flag.
> 
> >
> > But I know in the past there was a desire to ensure TDX/SNP could
> > support pre-allocating guest_memfd memory (and even pre-faulting via
> > KVM_PRE_FAULT_MEMORY), but I think that could still work right? The
> > fallocate() handling could still avoid the split if the whole hugepage
> > is private, though there is a bit more potential for that fallocate()
> > to happen before userspace does the "manually" shared->private
> > conversion. I'll double-check on that aspect, but otherwise, is there
> > still any other need for it?
> 
> This usecase of being able to preallocate should still work with
> in-place conversion assuming all ranges are private before
> pre-population.

Ok, I think I was missing that the merge logic here will then restore it
to 1GB before the guest starts, so the folio isn't permanently split if
we do the mmap() and that gives us more flexibility on how we can use
it.

I was thinking we needed to avoid the split from the start by avoiding
paths like mmap() which might trigger the split. I was trying to avoid
any merge->unsplit logic in the THP case (or unsplit in general), in
which case we'd get permanent splits via the mmap() approach, but for
2MB that's probably not a big deal.

> 
> >
> > > >
> > > > I assume we do want to support things like preallocating guest memory so
> > > > not sure this approach is feasible to avoid splits.
> > > >
> > > > But I feel like we might be working around a deeper issue here, which is
> > > > that we are pre-emptively splitting anything that *could* be mapped into
> > > > userspace (i.e. allocated+shared/mixed), rather than splitting when
> > > > necessary.
> > > >
> > > > I know that was the plan laid out in the guest_memfd calls, but I've run
> > > > into a couple instances that have me thinking we should revisit this.
> > > >
> > > > 1) Some of the recent guest_memfd seems to be gravitating towards having
> > > >    userspace populate/initialize guest memory payload prior to boot via
> > > >    mmap()'ing the shared guest_memfd pages so things work the same as
> > > >    they would for initialized normal VM memory payload (rather than
> > > >    relying on back-channels in the kernel to user data into guest_memfd
> > > >    pages).
> > > >
> > > >    When you do this though, for an SNP guest at least, that memory
> > > >    acceptance is done in chunks of 4MB (with accept_memory=lazy), and
> > > >    because that will put each 1GB page into an allocated+mixed state,
> > >
> > > I would like your help in understanding why we need to start
> > > guest_memfd ranges as shared for SNP guests. guest_memfd ranges being
> > > private simply should mean that certain ranges are not faultable by
> > > the userspace.
> >
> > It's seeming like I probably misremembered, but I thought there was a
> > discussion on guest_memfd call a month (or so?) ago about whether to
> > continue to use backchannels to populate guest_memfd pages prior to
> > launch. It was in the context of whether to keep using kvm_gmem_populate()
> > for populating guest_memfd pages by copying them in from separate
> > userspace buffer vs. simply populating them directly from userspace.
> > I thought we were leaning on the latter since it was simpler all-around,
> > which is great for SNP since that is already how it populates memory: by
> > writing to it from userspace, which kvm_gmem_populate() then copies into
> > guest_memfd pages. With shared gmem support, we just skip the latter now
> > in the kernel rather needing changes to how userspace handles things in
> > that regard. But maybe that was just wishful thinking :)
> 
> You remember it correctly and that's how userspace should pre-populate
> guest memory contents with in-place conversion support available.
> Userspace can simply do the following scheme as an example:
> 1) Create guest_memfd with the INIT_PRIVATE flag or if we decide to
> not go that way, create a guest_memfd file and set all ranges as
> private.
> 2) Preallocate the guest_memfd ranges.
> 3) Convert the needed ranges to shared, populate the initial guest
> payload and then convert those ranges back to private.
> 
> Important point here is that guest_memfd ranges can be marked as
> private before pre-allocating guest_memfd ranges.

Got it, and then the merge logic triggers so you get the 1GB back before
guest launch. That seems reasonable. I was only thinking of the merge
logic in the context of a running guest and it didn't seem all that useful
in that regard, but it makes perfect sense for the above sort of scenario.

Thanks,

Mike

> 
> >
> > But you raise some very compelling points on why this might not be a
> > good idea even if that was how that discussion went.
> >
> > >
> > > Will following work?
> > > 1) Userspace starts all guest_memfd ranges as private.
> > > 2) During early guest boot it starts issuing PSC requests for
> > > converting memory from shared to private
> > >     -> KVM forwards this request to userspace
> > >     -> Userspace checks that the pages are already private and simply
> > > does nothing.
> > > 3) Pvalidate from guest on that memory will result in guest_memfd
> > > offset query which will cause the RMP table entries to actually get
> > > populated.
> >
> > That would work, but there will need to be changes on userspace to deal
> > with how SNP populates memory pre-boot just like normal VMs do. We will
> > instead need to copy that data into separate buffers, and pass those in
> > as the buffer hva instead of the shared hva corresponding to that GPA.
> 
> Initial guest memory payload generally carries a much smaller
> footprint so I ignored that detail in the above sequence. As I said
> above, userspace should be able to use guest_memfd ranges to directly
> populate contents by converting those ranges to shared.
> 
> >
> > But that seems reasonable if it avoids so many other problems.
> >
> > >
> > > >    we end up splitting every 1GB to 4K and the guest can't even
> > > >    accept/PVALIDATE it 2MB at that point even if userspace doesn't touch
> > > >    anything in the range. As some point the guest will convert/accept
> > > >    the entire range, at which point we could merge, but for SNP we'd
> > > >    need guest cooperation to actually use a higher-granularity in stage2
> > > >    page tables at that point since RMP entries are effectively all split
> > > >    to 4K.
> > > >
> > > >    I understand the intent is to default to private where this wouldn't
> > > >    be an issue, and we could punt to userspace to deal with it, but it
> > > >    feels like an artificial restriction to place on userspace. And if we
> > > >    do want to allow/expect guest_memfd contents to be initialized pre-boot
> > > >    just like normal memory, then userspace would need to jump through
> > > >    some hoops:
> > > >
> > > >    - if defaulting to private: add hooks to convert each range that's being
> > > >      modified to a shared state prior to writing to it
> > >
> > > Why is that a problem?
> >
> > These were only problems if we went the above-mentioned way of
> > populating memory pre-boot via mmap() instead of other backchannels. If
> > we don't do that, then both these things cease to be problems. Sounds goods
> > to me. :)
> 
> I think there wouldn't be a problem even if we pre-populated memory
> pre-boot via mmap(). Using mmap() seems a preferable option to me.
> 

