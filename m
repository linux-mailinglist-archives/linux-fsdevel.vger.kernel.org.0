Return-Path: <linux-fsdevel+bounces-54737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B350AB02833
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 02:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A661582CCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 00:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260129A9;
	Sat, 12 Jul 2025 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhezreEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02419A;
	Sat, 12 Jul 2025 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279077; cv=fail; b=gaEiQHRxn6Q23G4AngeV5vyEHH61VwyBSvoKqERVFXFN57lAjI/9e/kiqLGZPbsm3oHcr1/0ml8J2OD0fAFQllrEUGYg/C9KmFDBn5e5UCCWvpAwz3z92OrzUcF48zsZMU5W1gJbSBLcuTwuKqVcZs1rQaz652dxj++JpnKwmPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279077; c=relaxed/simple;
	bh=HJV6hMNH9xDtTg6ZgnG/TvkflwISsIRoRn7+YutHylA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLfiOMNMjgjbL6zd+Fb00WfF8WV1qZ0voJ/N95uGmgxY0ygQS3Kq6LonwY27k39C88I39Ntmy/4T8ABpFRwpCOACntTjniIaiRc0P5vVo3vbHrRAAMZx19M8gMsl/Dkd6U/L/QCNd51mEmiAHz8YvzRtwgr6RN2jaMh47bip4vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhezreEu; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyhzwEfb+tnCytXutVlcN8Uxs7USBd8wIVBsCGQl1eY/dRW2qcOrrRbcyJ8Eb7F4fH9FrfKwxSpIl02aOV+78/x1EFXZ2wRfjIgCz93wpkYZ+pF/khRtSippFn75gHz0ZzXeBOYGejI96meFWTEOOmswSQdUTCFmm3D6HjnokUcA4kt5sRAKYqMTdlRGRGyUMaVGYC+5tbiTsYIJtX6PUQxa6H0ohPXVrQeTBs+UYTFwNcaDAQPJ+cOiGBprJ71z7hxq9Ojz6ALS4tKLLcp1/7FbF4W88qQRH8WsYxkyMz3qCJF465AvCh+p9fNRHYGms/qKwQtt6MOjd4PkPvagKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5XE3L3KKV8LlCFkk/DWS0W8iLbl9kCj1lzqCpujas8=;
 b=L6oWRmcAraW8ORPuRmTtqIEW4VR0zEtNsn9598l86SOj9Yf09fw0Hf1Rs5bQzHJw1rV06Oy//9sweFhj3DOw05t3DkzfcceFiwMH+4JdU7GEwXOja9GnCQiw1YYhhrldv0krEDwxjfbTCeNUouktlvkMsNLR5E6TiEr7oVudUJn/zitxc80NuAHsdVhfWSW3RITOpSso6sL0eJTD2OGQLDcKckmmTyFm4YEL1DeO7ChFnWPyBEdrHhYdG4Nd3MijyFckIYjilISRbxPHBst+lKwMYUdfG8ZYPJUEpra2XU1uLJZXZywNATikhSBcgadD/IGFBRIhIKgazd0IOFJGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5XE3L3KKV8LlCFkk/DWS0W8iLbl9kCj1lzqCpujas8=;
 b=vhezreEun+5k5dJczjh7Sg3+u3udeye1BsqwmZ0UmQvEaiIyORE/LxMKqsPPWO0sV1ev8KxWPaZMG0g+5bqQnuJoOr3wLymh6lMxvury7YVRnGCY8gge77FTF+Rv5B/sHfNX4WP13lf+uVllPjGfWdaYyg49whNXLNYSX2rHV0I=
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Sat, 12 Jul
 2025 00:11:11 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::fb) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Sat,
 12 Jul 2025 00:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sat, 12 Jul 2025 00:11:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 19:11:10 -0500
Date: Fri, 11 Jul 2025 19:10:55 -0500
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
Message-ID: <20250712001055.3in2lnjz6zljydq2@amd.com>
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com>
 <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com>
 <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
 <20250703041210.uc4ygp4clqw2h6yd@amd.com>
 <CAGtprH9sckYupyU12+nK-ySJjkTgddHmBzrq_4P1Gemck5TGOQ@mail.gmail.com>
 <20250703203944.lhpyzu7elgqmplkl@amd.com>
 <CAGtprH9_zS=QMW9y8krZ5Hq5jTL3Y9v0iVxxUY2+vSe9Mz83Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH9_zS=QMW9y8krZ5Hq5jTL3Y9v0iVxxUY2+vSe9Mz83Tw@mail.gmail.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fb42ba-e6a6-4906-6407-08ddc0d89ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTIyU1hVd2hCSGg5SmUvR3BIdHRzSU9BMmdRWnUzS2JEcTVOT2V2S0x4NE5X?=
 =?utf-8?B?ai9OZ2lHcWx3R2NCTnFDS3pvcys4NUdENkw5dlQ3YThvSzllS0pZNys2bm85?=
 =?utf-8?B?WUh1ckN3dk1saHErVjlldXJIbDJIdzlndi9ISjA0dCt6TDNiM3ZDaDFZMnJK?=
 =?utf-8?B?SXJMUDAvNThEK3BWVlM3eEdraS9JemlxTjhRMk9vMTNWZlY0Z0phdVd5T3Y0?=
 =?utf-8?B?azV0UitVdlJlRmpQWUVOTVdObmZDZ3NaaUp0WWV2L0dTUEdHWXR1bDVaeFFx?=
 =?utf-8?B?RVJaaFFuV3QxLzBkaDdDaEM1WFdwekNHM1YzMGY5alIxS2NXQml5MUo2VG5E?=
 =?utf-8?B?MkEyTkhzVHpPOFQyWWlDekxqZklpWWNxS3JWNkpWbklKL3BYckd2Yy9XTEJ4?=
 =?utf-8?B?dTMyNXFocUlTRGtOTGF5alBCb0x2bTJOaFgwSnNNdzRhcnRjSWVucWk2a0tw?=
 =?utf-8?B?WmN4L3ptTGlKVXZ5ZHZyM3kxTUdKWWdPSWZTV043NUdTTnNldHhoZkNsaFEv?=
 =?utf-8?B?WkNKY2RYNms5VXZJNWpTSzQzRUt5UnlQRDNneVlIdnBqalpjRjJxM2ZsVmVL?=
 =?utf-8?B?MDdyUlV0S1BQbWJVRjdybjVCOHN4TGc1Zit6UnRuTmpHNDIzQmsrTkE3MDdD?=
 =?utf-8?B?Rk9sOU9qNDlzemZhbUgrODVKYThYRktka2t5TWhPa1E3OE9BdkJORUpZdlBF?=
 =?utf-8?B?cDkvYWJZZ3ZZMi9YUTN1aGNCZkcveHllTksyTFd1SG4vNGpPL1NjM05SZ04z?=
 =?utf-8?B?RHFZYWJBOWREN2o4bE9JREptam1iL2F6TG82NWd5MlBlVFQxRllDVE1Tbm5t?=
 =?utf-8?B?Yk5HcVFxcStzbnd5WjF0VXhaVmtpcHA0SE4xMjdnaEpFbWlQYlB0MDdsZGRU?=
 =?utf-8?B?QlZrdU9XSVk3RXRlb1NsMlE1cjc1MFYydlp2TUJCa2dMZ2k3UklrdHBxMytK?=
 =?utf-8?B?UjZFQVVlWk9Rek04WFFVVVBQYTFlSy9zRmRYNnhnL3JVTVMvTG9wNUdwdlAv?=
 =?utf-8?B?QUZLajFmL1N4K0hYYTZUNExEZVJHYVE0dDNOYkVKUURqN2t4NVAvT2pxVmln?=
 =?utf-8?B?T3pCWjk4M2JIZXJhVGJuaFF3WFpxM0p4alhhWDhtbWRCMVlNYXlqSUN6dVZG?=
 =?utf-8?B?ei9SNnhUYnNsTTlPOW04UFBMaG5rL2JFMDh0SzZ3QUIvWVRqaGNhUGFGUzhm?=
 =?utf-8?B?cFhqYVlydjViSzRXUGJPMzFYK2ZuL1NDMXJWU1c5Zi9XRVhmYlZEMExDVGxk?=
 =?utf-8?B?Q3RFQ2FmQm0zU3BrY3hGL0Y2NzltTUFXRUFmQXhCQXBJdkhqWEQyQlBCeWth?=
 =?utf-8?B?WEx0dTRhR201ZXZPeU90ZDI0SGdlNEdlQmlpUTJySkV0QmJ2OEc1WUJUckVr?=
 =?utf-8?B?dlROYkhqMjJvYjNybi94cEY4bG1XaU01V20xamkvTTZ5QyttT282SW9kY0Na?=
 =?utf-8?B?TVZ3bmU0VUZCMjhBUm9xTkJoNWV0cG04c1JpNXF0M1ZMZGpKZU1kYkR2WGN0?=
 =?utf-8?B?NE9pQ2lzN0lPNTE0Ry9yZk9wZXpHdHhWZkpUdkdIMTYrcVZURU1iVFBnL0VC?=
 =?utf-8?B?OEo3cDRNTkNvY0VneDQvKytnU2l0NytDTjdYSDQvLzRQNUMyam5wWTNkRUFV?=
 =?utf-8?B?eHI0U1huNG5OYW9kbXNNWG8vbDhpSEZoeVlIbnhXMjZQQzllamFZKytoOEJu?=
 =?utf-8?B?M1puRXhJcEVKdnpLbzVyZmFLZGRoQnZRdWNETStpZm5xL2NEbGNQczJGSUYr?=
 =?utf-8?B?RDE5SlhXMjNDTnpXWlg5M0R3d3IyQm91WHNBR1A2ZVg2QjYweGZtTE1XNHpB?=
 =?utf-8?B?NHdMOHRhSmJrNjVEREdDSTRaWkR1Vi8xQTJTUzU2cFJJWHcyajVhTTFpSlVB?=
 =?utf-8?B?dVcvTjRoN1NUWWMzMDVlS0Y2bUZHak5UTWZMY3gzaDRwa2htUkQ0UGthOTk2?=
 =?utf-8?B?N2VPYlRKSXlEMDljNjJtajJxSGJOYWMvdWdKb1MxQ05CYmNHQWtRZlc2RlVj?=
 =?utf-8?B?eDR0YmJWUmdXZFhGWXNVK1R5UUtCeksvWEkzNkJGemVoRktNVXJoa1Uzbnpi?=
 =?utf-8?Q?vGgEkQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 00:11:11.2270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fb42ba-e6a6-4906-6407-08ddc0d89ba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

On Mon, Jul 07, 2025 at 07:55:01AM -0700, Vishal Annapurve wrote:
> On Thu, Jul 3, 2025 at 1:41 PM Michael Roth <michael.roth@amd.com> wrote:
> > > > > > >
> > > > > > > Because shared pages are split once any memory is allocated, having a
> > > > > > > way to INIT_PRIVATE could avoid the split and then merge on
> > > > > > > conversion. I feel that is enough value to have this config flag, what
> > > > > > > do you think?
> > > > > > >
> > > > > > > I guess we could also have userspace be careful not to do any allocation
> > > > > > > before converting.
> > > >
> > > > (Re-visiting this with the assumption that we *don't* intend to use mmap() to
> > > > populate memory (in which case you can pretty much ignore my previous
> > > > response))
> > >
> > > I am assuming in-place conversion with huge page backing for the
> > > discussion below.
> > >
> > > Looks like there are three scenarios/usecases we are discussing here:
> > > 1) Pre-allocating guest_memfd file offsets
> > >    - Userspace can use fallocate to do this for hugepages by keeping
> > > the file ranges marked private.
> > > 2) Prefaulting guest EPT/NPT entries
> > > 3) Populating initial guest payload into guest_memfd memory
> > >    - Userspace can mark certain ranges as shared, populate the
> > > contents and convert the ranges back to private. So mmap will come in
> > > handy here.
> > >
> > > >
> > > > I'm still not sure where the INIT_PRIVATE flag comes into play. For SNP,
> > > > userspace already defaults to marking everything private pretty close to
> > > > guest_memfd creation time, so the potential for allocations to occur
> > > > in-between seems small, but worth confirming.
> > >
> > > Ok, I am not much worried about whether the INIT_PRIVATE flag gets
> > > supported or not, but more about the default setting that different
> > > CVMs start with. To me, it looks like all CVMs should start as
> > > everything private by default and if there is a way to bake that
> > > configuration during guest_memfd creation time that would be good to
> > > have instead of doing "create and convert" operations and there is a
> > > fairly low cost to support this flag.
> > >
> > > >
> > > > But I know in the past there was a desire to ensure TDX/SNP could
> > > > support pre-allocating guest_memfd memory (and even pre-faulting via
> > > > KVM_PRE_FAULT_MEMORY), but I think that could still work right? The
> > > > fallocate() handling could still avoid the split if the whole hugepage
> > > > is private, though there is a bit more potential for that fallocate()
> > > > to happen before userspace does the "manually" shared->private
> > > > conversion. I'll double-check on that aspect, but otherwise, is there
> > > > still any other need for it?
> > >
> > > This usecase of being able to preallocate should still work with
> > > in-place conversion assuming all ranges are private before
> > > pre-population.
> >
> > Ok, I think I was missing that the merge logic here will then restore it
> > to 1GB before the guest starts, so the folio isn't permanently split if
> > we do the mmap() and that gives us more flexibility on how we can use
> > it.
> >
> > I was thinking we needed to avoid the split from the start by avoiding
> > paths like mmap() which might trigger the split. I was trying to avoid
> > any merge->unsplit logic in the THP case (or unsplit in general), in
> > which case we'd get permanent splits via the mmap() approach, but for
> > 2MB that's probably not a big deal.
> 
> After initial payload population, during its runtime guest can cause
> different hugepages to get split which can remain split even after
> guest converts them back to private. For THP there may not be much
> benefit of merging those pages together specially if NPT/EPT entries
> can't be promoted back to hugepage mapping and there is no memory
> penalty as THP doesn't use HVO.
> 
> Wishful thinking on my part: It would be great to figure out a way to
> promote these pagetable entries without relying on the guest, if
> possible with ABI updates, as I think the host should have some
> control over EPT/NPT granularities even for Confidential VMs. Along

I'm not sure how much it would buy us. For example, for a 2MB hugetlb
SNP guest boot with 16GB of memory I see 622 2MB hugepages getting
split, but only about 30 or so of those get merged back to 2MB folios
during guest run-time. These are presumably the set of 2MB regions we
could promote back up, but it's not much given that we wouldn't expect
that value to grow proportionally for larger guests: it's really
separate things like the number of vCPUs (for shared GHCB pages), number
of virtio buffers, etc. that end up determining the upper bound on how
many pages might get split due to 4K private->shared conversion, and
these would vary all that much from get to get outside maybe vCPU
count.

For 1GB hugetlb I see about 6 1GB pages get split, and only 2 get merged
during run-time and would be candidates for promotion.

This could be greatly improved from the guest side by using
higher-order allocations to create pools of shared memory that could
then be used to reduce the number of splits caused by doing
private->shared conversions on random ranges of malloc'd memory,
and this could be done even without special promotion support on the
host for pretty much the entirety of guest memory. The idea there would
be to just making optimized guests avoid the splits completely, rather
than relying on the limited subset that hardware can optimize without
guest cooperation.

> the similar lines, it would be great to have "page struct"-less memory
> working for Confidential VMs, which should greatly reduce the toil
> with merge/split operations and will render the conversions mostly to
> be pagetable manipulations.

FWIW, I did some profiling of split/merge vs. overall conversion time
(by that I mean all cycles spent within kvm_gmem_convert_execute_work()),
and while split/merge does take quite a few more cycles than your
average conversion operation (~100x more), the total cycles spent
splitting/merging ended up being about 7% of the total cycles spent
handling conversions (1043938460 cycles in this case).

For 1GB, a split/merge take >1000x more than a normal conversion
operation (46475980 cycles vs 320 in this sample), but it's probably 
still not too bad vs the overall conversion path, and as mentioned above
it only happens about 6x for 16GB SNP guest so I don't think split/merge
overhead is a huge deal for current guests, especially if we work toward
optimizing guest-side usage of shared memory in the future. (There is
potential for this to crater performance for a very poorly-optimized
guest however but I think the guest should bear some burden for that
sort of thing: e.g. flipping the same page back-and-forth between
shared/private vs. caching it for continued usage as shared page in the
guest driver path isn't something we should put too much effort into
optimizing.)

> 
> That being said, memory split and merge seem to be relatively
> lightweight for THP (with no memory allocation/freeing) and reusing
> the memory files after reboot of the guest VM will require pages to be
> merged to start with a clean slate. One possible option is to always
> merge as early as possible, second option is to invent a new UAPI to
> do it on demand.
> 
> For 1G pages, even if we go with 1G -> 2M -> 4K split stages, page
> splits result in higher memory usage with HVO around and it becomes
> useful to merge them back as early as possible as guest proceeds to
> convert subranges of different hugepages over its lifetime. Merging
> pages as early as possible also allows reusing of memory files during
> the next reboot without having to invent a new UAPI.
> 
> Caveats with "merge as early as possible":
> - Shared to private conversions will be slower for hugetlb pages.
>    * Counter argument: These conversions are already slow as we need
> safe refcounts to reach on the ranges getting converted.
> - If guests convert a particular range often then extra merge/split
> operations will result in overhead.
>    * Counter argument: Since conversions are anyways slow, it's
> beneficial for guests to avoid such a scenario and keep back and forth
> conversions as less frequent as possible.

Fair enough. I'm not seeing any major reason not to do things this way,
as the overhead doesn't seem to be very significant for the common case.

(even though, as noted above, the amount of hugetlb pages we actually end
up merging at guest run-time seems to be fairly small, but maybe there
are scenarios where this will have a bigger impact, and it certainly helps
to have it there for the pre-boot merges.)

-Mike

