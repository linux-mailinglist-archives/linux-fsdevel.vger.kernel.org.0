Return-Path: <linux-fsdevel+bounces-50050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9731AAC7C7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51AE3A660C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217328E58B;
	Thu, 29 May 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N0TzYQnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05C28E564;
	Thu, 29 May 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517303; cv=fail; b=ho+Pxd5+u44HdS7bkZCHhuU3EGewjTVC/+tTd3/QXi9/NQAZfEcvs8534RGTnoUa+YkhNAJVnyhgA0I9BicogNo/v92ybjGK+Gngl4qLdAL0NYVM6xQbo5Lts8tK09XSwdPqZNTvKBrd372k8QIWbYkFmb+jqFxLu+9LEPfPSYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517303; c=relaxed/simple;
	bh=PgVdMAIF6gVvg/mNq0D7csWFfjwtL0zNHm5BKcMz068=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2mOmmPc9MwB0X8BHVx6CjCcUzNYZ6ViTZYakIn0Tk+LgZLeulaUxpM6H7/2qWxOquYzJLtG2stRSr3tg4cDf46dRYnoucyLu5cGTdk1E5peri41bUQIEHUN/T54/vHENVkb4bvBVFHuaSyrpAuPVLTza+roYlHDO2Aqny9uyMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N0TzYQnH; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nssw1au7y+ZaRL6Ac7hdBmmGVniV8etYSU8hHvtUUYWEdFeL4CjAQfBXM/hFpd34PUt8RYosxi58Z4q0UKis2Z4bJhtyXuqx2Okv7e+0csHQ49BtgSwpneo4Sw2BfRU1jjLIGAC7BPygQ85j4IwV6pr+Y6aYURPDC3kFYuNF5HHMfh3VBMvu+78OB3+7VQP0V0bfCnBDadXg9wkcpcYsGwaqyBRKUkG7DoahIUM1NS27j3eLQxjuW/GJlBL7bJgVedCVtbUuEwuLBnVUBUzLgB47RI/SpAvsUJi0TI890IGWNcRxN0FAH4znL82xtbxCiek2NVaU4F7f0b3iaEvTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InUMxcWFYENvyAsEMxZBD4/PC7HDd81Bekjquf0eFGA=;
 b=jveGL4/nh0N1THukDgFqjnrihnLt5Xv4YLVwm5M71LbUDLndh29/s31d4KD8fRlIPzC0DMB/39O+J2A+FHPZDk9AB4AjAPK9pRnY+Pgm6tlDtVP/NcOdPqWc21374H8UOCoYqSiBMNisoWGLxBrb+nijISJpKN+VuRmc1+7u66xmOveG4GyiVLxVWHPA2qITZbdlIZW6nsojybXa9tkGWwS5b/yZzU+a+vTonjGFch0MI7NP2RHxJvQHpD8FtuK/pNnfGwVK6OKGDQ7HM/Sxhbnhd9k34JaZmCzTLDu5kEQGUuC+gG0ToLfPx3ml/kZWPIIfmc9wiPs0dG02DbmL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InUMxcWFYENvyAsEMxZBD4/PC7HDd81Bekjquf0eFGA=;
 b=N0TzYQnHVUg575e9ucBhQltL01HJI9eOdgRAf7Oj8Rdnc+oh3l8gbxhgs0QhvtedJCfMZ2r/3cji4G+2P4DAfltWm0o23c3EiRnfiopZ2OgrIPk/G+rUnselSvppZ/lyrpJ0dsUu6GnWoytaOkWJJevWIlniuX3zUSmFkqW8v68=
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 11:14:59 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::dd) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Thu,
 29 May 2025 11:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 11:14:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 06:14:57 -0500
Date: Thu, 29 May 2025 00:42:27 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
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
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>,
	<vannapurve@google.com>, <vbabka@suse.cz>, <viro@zeniv.linux.org.uk>,
	<vkuznets@redhat.com>, <wei.w.wang@intel.com>, <will@kernel.org>,
	<willy@infradead.org>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
Message-ID: <20250529054227.hh2f4jmyqf6igd3i@amd.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 5440d9b0-6370-496b-26f6-08dd9ea20c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?motQQ34fj6NA3sCW92uLvTxVVegx+bHCj3U4kylWIpruU5m4Xp5mBZIvXvYO?=
 =?us-ascii?Q?xsHU3eEMGyibkfNTirQR9TAWeeWnG5snBCmmsDXicL7qmqgmPQ003ZLkbmCS?=
 =?us-ascii?Q?MFdutxfMCZyzVtmgUmlddb0UAgeOuOIkm+5VbCT1C7FB+Iex3QGE/4+gr9vT?=
 =?us-ascii?Q?/F8ALDxZn2aiXyURpkFlcOSOgVZAzplqdWf8epGMeYCh7KK/Mg3VQDsDdGo+?=
 =?us-ascii?Q?qKMmP5RWh26uO4eoRUEdsKzeEiyrNWce1Tzp92wPTKpkbP3giMKobGjrSCbg?=
 =?us-ascii?Q?cCkNtuscpGZU9wD53o4/L+xtRIwMJAezxmxkz9tdA2sUtzB73F9359lQuRNU?=
 =?us-ascii?Q?2y8mMZoL1gD8hcgpa/vRjoINhpMFxZfsIi2Qj83d1W4V5NdW5zU2o2yS7Si4?=
 =?us-ascii?Q?eBdBZTK71nzN7NjeJL3u1eTfvCsNiwcTSmM/tjlP9ifvnU+UuDoeV+ILTBFR?=
 =?us-ascii?Q?XgJM1FwSH0SjoTXAYiwhnmu/CiYLfyWRprzyrgMkC9FLmg4cvQS4V5m0JVSK?=
 =?us-ascii?Q?xRu02aDWFJs4UrTUd48Zw3H/EUM1zVMepXhNbZtqUlZt2Q3UPzKfE+Ku+ZXK?=
 =?us-ascii?Q?81FNQWR9bHGoA+noY9gv9aMbpz09PX97/l2BrNieq6Wefj2t7uX6RQ8I4Sqt?=
 =?us-ascii?Q?UT436nOYMsGJxavGEZN7pYIEEvTnH2FoZKr1+DMIlvnafnyuIfFPBIcIDSYv?=
 =?us-ascii?Q?mIaYjh9cU3qkD860t+8/hrmfuOcpY+Tns93r79+awO4OsGYjsYRHW9WLIDy5?=
 =?us-ascii?Q?6/jxPqj2K9HkNpKptGBGeSE4nZNB9wKJewvUNTAif/LmhCpjVNbiH+MwI/5O?=
 =?us-ascii?Q?mCN+0RrorHYIcKdaMvNmGEoMD7RYIaCYVHe7lPVZTTQhxnZBaW1KDEAupZ2U?=
 =?us-ascii?Q?DOHNPHNsecbA4QF8oJ0jxEpiHfdmSxY3wNlrcndrDMdvuM+WoozVSWEALyiM?=
 =?us-ascii?Q?IOzLJ+TRzOukEERz9KaXRn5Yki4q2L6vVGNDHOfQgqoRjZ0f9371ZLflQJzt?=
 =?us-ascii?Q?tWcn6vlE0Ra10Mulc115CSeWO4G+FJ8DMZen8YExlyZ7/TSESpbp8zvoyXtT?=
 =?us-ascii?Q?K0CJx920/nIJuL9NNY3dQPZXFWoQMQcBGJfbDPVoTOi0OxglCK7cM73EVtzp?=
 =?us-ascii?Q?+ERmwd5nWpa/aWBV37r+ISrqbZeq8+9/z614m9qyrZw7VDKB8bYowKVMeey+?=
 =?us-ascii?Q?oT88ESgp63pr2++vU6Yz9xvKrDC5GAnWb90in6soMj2wPjOy4fOAuY89g+44?=
 =?us-ascii?Q?gyLv1Vz34X1MGfq/2GMr9eqJocn+NsVEnG6h1a7XwbJkp9Y7cJOGlPnZNbNh?=
 =?us-ascii?Q?pw4AlehsXSk7KME8aAmqhBnjY/dcBnOpOBZqOoPaeWF/tkXuvnzWatzGgjgx?=
 =?us-ascii?Q?j8/lVGythVWiloMz78RnQdxACImyk9GpHYX5r4m1raczGWjRo//teRdG4GMJ?=
 =?us-ascii?Q?/wrHyDPyXbR5nCu/KNjiKQKoRWZP7UcA4TTvhHwMGa5YDBP2rz9X2V0+wJWF?=
 =?us-ascii?Q?MqoT/RYrU8cNV/CiN6ljSqdhNT414wdw0KXzFpanmyJMhhlBELwLO7i66w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 11:14:58.3749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5440d9b0-6370-496b-26f6-08dd9ea20c54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> Track guest_memfd memory's shareability status within the inode as
> opposed to the file, since it is property of the guest_memfd's memory
> contents.
> 
> Shareability is a property of the memory and is indexed using the
> page's index in the inode. Because shareability is the memory's
> property, it is stored within guest_memfd instead of within KVM, like
> in kvm->mem_attr_array.
> 
> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
> retained to allow VMs to only use guest_memfd for private memory and
> some other memory for shared memory.
> 
> Not all use cases require guest_memfd() to be shared with the host
> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
> private to the guest, and therefore not mappable by the
> host. Otherwise, memory is shared until explicitly converted to
> private.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
> ---
>  Documentation/virt/kvm/api.rst |   5 ++
>  include/uapi/linux/kvm.h       |   2 +
>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
>  3 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 86f74ce7f12a..f609337ae1c2 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
>  This is validated when the guest_memfd instance is bound to the VM.
>  
> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
> +will initialize the memory for the guest_memfd as guest-only and not faultable
> +by the host.
> +

KVM_CAP_GMEM_CONVERSION doesn't get introduced until later, so it seems
like this flag should be deferred until that patch is in place. Is it
really needed at that point though? Userspace would be able to set the
initial state via KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls.

The mtree contents seems to get stored in the same manner in either case so
performance-wise only the overhead of a few userspace<->kernel switches
would be saved. Are there any other reasons?

Otherwise, maybe just settle on SHARED as a documented default (since at
least non-CoCo VMs would be able to reliably benefit) and let
CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
granularity makes sense for the architecture/guest configuration.

>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
>  
>  4.143 KVM_PRE_FAULT_MEMORY
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4cc824a3a7c9..d7df312479aa 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>  
>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> +
>  #define GUEST_MEMFD_FLAG_SUPPORT_SHARED	(1UL << 0)
> +#define GUEST_MEMFD_FLAG_INIT_PRIVATE	(1UL << 1)
>  
>  struct kvm_create_guest_memfd {
>  	__u64 size;
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 239d0f13dcc1..590932499eba 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/kvm_host.h>
> +#include <linux/maple_tree.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
>  
> @@ -17,6 +18,24 @@ struct kvm_gmem {
>  	struct list_head entry;
>  };
>  
> +struct kvm_gmem_inode_private {
> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +	struct maple_tree shareability;
> +#endif
> +};
> +
> +enum shareability {
> +	SHAREABILITY_GUEST = 1,	/* Only the guest can map (fault) folios in this range. */
> +	SHAREABILITY_ALL = 2,	/* Both guest and host can fault folios in this range. */
> +};
> +
> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
> +
> +static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
> +{
> +	return inode->i_mapping->i_private_data;
> +}
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
>  	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
>  }
>  
> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +
> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_private *private,
> +				      loff_t size, u64 flags)
> +{
> +	enum shareability m;
> +	pgoff_t last;
> +
> +	last = (size >> PAGE_SHIFT) - 1;
> +	m = flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST :
> +						    SHAREABILITY_ALL;
> +	return mtree_store_range(&private->shareability, 0, last, xa_mk_value(m),
> +				 GFP_KERNEL);

One really nice thing about using a maple tree is that it should get rid
of a fairly significant startup delay for SNP/TDX when the entire xarray gets
initialized with private attribute entries via KVM_SET_MEMORY_ATTRIBUTES
(which is the current QEMU default behavior).

I'd originally advocated for sticking with the xarray implementation Fuad was
using until we'd determined we really need it for HugeTLB support, but I'm
sort of thinking it's already justified just based on the above.

Maybe it would make sense for KVM memory attributes too?

> +}
> +
> +static enum shareability kvm_gmem_shareability_get(struct inode *inode,
> +						 pgoff_t index)
> +{
> +	struct maple_tree *mt;
> +	void *entry;
> +
> +	mt = &kvm_gmem_private(inode)->shareability;
> +	entry = mtree_load(mt, index);
> +	WARN(!entry,
> +	     "Shareability should always be defined for all indices in inode.");
> +
> +	return xa_to_value(entry);
> +}
> +
> +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> +{
> +	if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
> +		return ERR_PTR(-EACCES);
> +
> +	return kvm_gmem_get_folio(inode, index);
> +}
> +
> +#else
> +
> +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> +{
> +	return 0;
> +}
> +
> +static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> +{
> +	WARN_ONCE("Unexpected call to get shared folio.")
> +	return NULL;
> +}
> +
> +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				    pgoff_t index, struct folio *folio)
>  {
> @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
>  
>  	filemap_invalidate_lock_shared(inode->i_mapping);
>  
> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +	folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
>  	if (IS_ERR(folio)) {
>  		int err = PTR_ERR(folio);
>  
> @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
>  	.fallocate	= kvm_gmem_fallocate,
>  };
>  
> +static void kvm_gmem_free_inode(struct inode *inode)
> +{
> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> +
> +	kfree(private);
> +
> +	free_inode_nonrcu(inode);
> +}
> +
> +static void kvm_gmem_destroy_inode(struct inode *inode)
> +{
> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> +
> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +	/*
> +	 * mtree_destroy() can't be used within rcu callback, hence can't be
> +	 * done in ->free_inode().
> +	 */
> +	if (private)
> +		mtree_destroy(&private->shareability);
> +#endif
> +}
> +
>  static const struct super_operations kvm_gmem_super_operations = {
>  	.statfs		= simple_statfs,
> +	.destroy_inode	= kvm_gmem_destroy_inode,
> +	.free_inode	= kvm_gmem_free_inode,
>  };
>  
>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
>  static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>  						      loff_t size, u64 flags)
>  {
> +	struct kvm_gmem_inode_private *private;
>  	struct inode *inode;
> +	int err;
>  
>  	inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
>  	if (IS_ERR(inode))
>  		return inode;
>  
> +	err = -ENOMEM;
> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
> +	if (!private)
> +		goto out;
> +
> +	mt_init(&private->shareability);
> +	inode->i_mapping->i_private_data = private;
> +
> +	err = kvm_gmem_shareability_setup(private, size, flags);
> +	if (err)
> +		goto out;
> +
>  	inode->i_private = (void *)(unsigned long)flags;
>  	inode->i_op = &kvm_gmem_iops;
>  	inode->i_mapping->a_ops = &kvm_gmem_aops;
> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>  
>  	return inode;
> +
> +out:
> +	iput(inode);
> +
> +	return ERR_PTR(err);
>  }
>  
>  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  	if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
>  		valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
>  
> +	if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
> +		valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
> +
>  	if (flags & ~valid_flags)
>  		return -EINVAL;
>  
> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (!file)
>  		return -EFAULT;
>  
> +	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +

I like the idea of using a write-lock/read-lock to protect write/read access
to shareability state (though maybe not necessarily re-using filemap's
invalidate lock), it's simple and still allows concurrent faulting in of gmem
pages. One issue on the SNP side (which also came up in one of the gmem calls)
is if we introduce support for tracking preparedness as discussed (e.g. via a
new SHAREABILITY_GUEST_PREPARED state) the
SHAREABILITY_GUEST->SHAREABILITY_GUEST_PREPARED transition would occur at
fault-time, and so would need to take the write-lock and no longer allow for
concurrent fault-handling.

I was originally planning on introducing a new rw_semaphore with similar
semantics to the rw_lock that Fuad previously had in his restricted mmap
series[1] (and simiar semantics to filemap invalidate lock here). The main
difference, to handle setting SHAREABILITY_GUEST_PREPARED within fault paths,
was that in the case of a folio being present for an index, the folio lock would
also need to be held in order to update the shareability state. Because
of that, fault paths (which will always either have or allocate folio
basically) can rely on the folio lock to guard shareability state in a more
granular way and so can avoid a global write lock.

They would still need to hold the read lock to access the tree however.
Or more specifically, any paths that could allocate a folio need to take
a read lock so there isn't a TOCTOU situation where shareability is
being updated for an index for which a folio hasn't been allocated, but
then just afterward the folio gets faulted in/allocated while the
shareability state is already being updated which the understand that
there was no folio around that needed locking.

I had a branch with in-place conversion support for SNP[2] that added this
lock reworking on top of Fuad's series along with preparation tracking,
but I'm now planning to rebase that on top of the patches from this
series that Sean mentioned[3] earlier:

  KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
  KVM: Query guest_memfd for private/shared status
  KVM: guest_memfd: Skip LRU for guest_memfd folios
  KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
  KVM: guest_memfd: Introduce and use shareability to guard faulting
  KVM: guest_memfd: Make guest mem use guest mem inodes instead of anonymous inodes

but figured I'd mention it here in case there are other things to consider on
the locking front.

Definitely agree with Sean though that it would be nice to start identifying a
common base of patches for the in-place conversion enablement for SNP, TDX, and
pKVM so the APIs/interfaces for hugepages can be handled separately.

-Mike

[1] https://lore.kernel.org/kvm/20250328153133.3504118-1-tabba@google.com/
[2] https://github.com/mdroth/linux/commits/mmap-swprot-v10-snp0-wip2/
[3] https://lore.kernel.org/kvm/aC86OsU2HSFZkJP6@google.com/

>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
>  	if (IS_ERR(folio)) {
>  		r = PTR_ERR(folio);
> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		*page = folio_file_page(folio, index);
>  	else
>  		folio_put(folio);
> -
>  out:
> +	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>  	fput(file);
>  	return r;
>  }
> -- 
> 2.49.0.1045.g170613ef41-goog
> 

