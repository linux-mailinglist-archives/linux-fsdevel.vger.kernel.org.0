Return-Path: <linux-fsdevel+bounces-69976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F283C8CD73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65054E6988
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78702230D14;
	Thu, 27 Nov 2025 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IpMhOQmx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154630F928;
	Thu, 27 Nov 2025 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764219817; cv=fail; b=JVQkLRsyxTzLxNH7nK3VCIfEBWcnttd0uEP2u1eovJISCUav6DWcd2U7/0gbD8x9FzvVw71XceUHnMgML3MwxocKO3ieafxfRQG6lAcQQe4dpoSKjVVEuteIOc4AQK0N41ENRUEy6w6NVdfMwqMqP6sTEBZ+9lT3cTtPDjyXZXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764219817; c=relaxed/simple;
	bh=oc2FeBQeoYKjmLz9KkTlhKqC0j85/sFoOeupn/we3NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rWkxKPGiwmHOLgqPDidW+/wCWxikzUDOqV/Zq4Bfr0SPGTEGSatGBMpv4aiJtrWwWfg+dWoCUy9wkqOy4X1rUk+3rpSBp63wSYJs5Jx1HkSgc6lly/urbib342fnpX5eZKz7ZjshsGadC2Q6HHeYF3TtRZdyZdxX+bFHgEpwDDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IpMhOQmx; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvEAgXWhQe56VWGUxzOdm6d12cWL8V+YKJlOcZcUI5j1ZpISG7wthDxFb3Q/DsyQGMj9IsklEwa9xprKFsFWUDrXJl+c3h4UFqbfjB1AQ5Kzzly/9wvTs1s97y5t7cVRGGE3atCrUy3FFG8EpTBcS2YLIYaQy9WRN+di/c23UVGqXX73EkBHkcmAAked5BCECy4NdldpgKjIbChd9JpqC97/mrB8z1zQCgPRiDoXAcsIR7vvV8vTgVRBGEMgUPPT8MRiPafdSlCObcCT2Zj7fobaELOHRxx6DuzXLqZm5qneTDuKCx2YFHF+RuPaaZ5+pfC7UbnHm+z8fHIDpPgrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3c0qryEvBfAAGXcWAAqCeFuQcZRFkx/fvS6B26ifKw=;
 b=bTYefnQuEoA+8KYkr0fJpX9cl6bb8axCrfiNOSBUa1F43BS/CCLuTwM3FpA4q37gDTl7tIZa2gDpjxkX+q/t1EKpkR/8dH+wH5VaXtGBkuymkcl9L2TtrsDvmsAUSpSYLv7rn9LypSzK4u2/axcF6oznWFzQd/QhHZ4xDrnPOoA9evBl+L8D+lSymejBJfAfoqWmvTduWFyYLjyAhZkci+Rh2LfwXCjwh1d8fEYAmZHk4jJXyCLBKCGwlLFR3/G5pijgsVFVTJTeFvqhqAvLTCiVm+rH27DjO2a09IKD39pkBe49iVIHxzaMjQJToDuREpsCBMd9hMNCN0Vb3itvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3c0qryEvBfAAGXcWAAqCeFuQcZRFkx/fvS6B26ifKw=;
 b=IpMhOQmxYIE5yW3qG8jOVA/RrbxvppLQvLfcsh1LOM1zny0+MN4Gosr/ygbazRcdUDzko8DtRsd+t24dbeBmmwyFEt8gy+maUMpLKydYt7fAvITY/WDVZ8MEOK/FJ9P8iKV+vw+se8XRkM54vWDouk9AyjCTD821s6mK5U7h60kLIz05CDrNba9ot62Z6YS0hQXl1yI2xLHOUueHhNygmiyJWoMsAYuUQc+f0NlgktFIcN7wsntHpueDx7ztKz4JZ6BkG3CWJVqaU1ngGzF4xS4mKa8xERYY5WNzO/WnT2OXd74soZdhFnjN7yxR2GV9a0qza10Ku1dTpEtbAiXGUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 05:03:29 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 05:03:29 +0000
Date: Thu, 27 Nov 2025 16:03:24 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com, 
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, rientjes@google.com, jackmanb@google.com, 
	cl@gentwo.org, harry.yoo@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, zhengqi.arch@bytedance.com, 
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com, ming.li@zohomail.com, usamaarif642@gmail.com, 
	brauner@kernel.org, oleg@redhat.com, namcao@linutronix.de, escape@linux.alibaba.com, 
	dongjoo.seo1@samsung.com
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
Message-ID: <ti434m4sbveft6jw4zqrzzis47ycjupgiw5csj2wxmcac74xva@xyvx3ebqoqhu>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <aktv2ivkrvtrox6nvcpxsnq6sagxnmj4yymelgkst6pazzpogo@aexnxfcklg75>
 <aSDUl7kU73LJR78g@gourry-fedora-PF4VCD3F>
 <c5enwlaui37lm4uxlsjbuhesy6hfwwqbxzzs77zn7kmsceojv3@f6tquznpmizu>
 <aSR5l_fuONlCws8i@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSR5l_fuONlCws8i@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SY0PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 03459c16-31b4-42ad-a768-08de2d724dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSsu6zZRSgUYapJa7RY0AUowKKn1CoQ3ve9IeA7C+nqYT2e4l5h3VDDemNxe?=
 =?us-ascii?Q?t0BCTPj4KJ1P5bpD54bsbeTdl9yUIBclr1GRQK86CPtdd0Kvq/fESn1NBp2q?=
 =?us-ascii?Q?P9y2222MHYdUDqkqP+DHmU/tXQVF4uscFdzsjwr/F9Ok8ZzUlYgjU+FftE51?=
 =?us-ascii?Q?duC5fMfKXzYw6FUp90QTH7bqBvPLLy5w1AQ2KLgmv6Okqa1FFqx4Qv3UQmDl?=
 =?us-ascii?Q?MUNcheXBOMvMBuQ/BOZWL5BeD/Lw2umAFXnnzuI5aS1hc8Ywx4MieWULpBBe?=
 =?us-ascii?Q?6CUZO91UOVEN8Kjpmqla3/3arseWzZhuBo9yWAx7KzbxGX0IuOBjufAL3KIh?=
 =?us-ascii?Q?npjONYgWfMvaQkzIXiVk+PguG1wP6TG7enhlv54mg+zdEfWPGwbBYHt2U4Mg?=
 =?us-ascii?Q?GJsFWnECd23dNTQnoG13F4fANM+JllLgJfU52g+83hT3y57lKkCQFhgX8VCs?=
 =?us-ascii?Q?8x1sLlfklyEdvypBmIroiScEVmjz5xctcSVvTFzWolAZysN6M0k4OIQD9kKJ?=
 =?us-ascii?Q?kN8zp6+ehgFZkuwOzN26gP/BH+cfqTAaVrL8PX/Z4Ox32tzemsI3lKb9Ex67?=
 =?us-ascii?Q?zg3qrWjcNqGi7bwaDBx19xeoRyaMM8foXft/Z25oq/4TP+LX/+Ju4ndVMUeN?=
 =?us-ascii?Q?PYe491FaxBL6iMSMt/3q4CvHpB8UwRFZWpuwsURzXgWaqHh+u2974fCnokXH?=
 =?us-ascii?Q?IIcE+CDW8scRtE0xzSrPfW/feR/NsabTEKLFaftIMv/A/lMtU3gor9kj7224?=
 =?us-ascii?Q?rH9cjR+JcKaLqcfsaJobyWDIxpJL+nj7NTtWwe+2kaeatnFodm+3EDNKhyfE?=
 =?us-ascii?Q?i4/eAhUzyjCZuaECtGdd8EuJMTum/FnLoqZOjnZpIpMbGemtb5TnXb8Mk4P2?=
 =?us-ascii?Q?ul2zPHZD/wUF81V5iKGN7BHSpFBsfMBsKaDR7qy1vxw/76pw2EFTFbrqyw3q?=
 =?us-ascii?Q?2CThU9GV+D0Afu3m4eTzrvCyGhLqRGWei16SYcAxERIBAprgrOXoYISI6IWm?=
 =?us-ascii?Q?1onGInyhiUpT9U4OiYTiLykMSy28QhO0hSv2quYBbWC7thnXBAIbkDoE69EI?=
 =?us-ascii?Q?UZvtKdvxqtVI6KfZqSIkyIjvqPFvnTMODnStJ+1L9YAB54kwIJPUruorf5oZ?=
 =?us-ascii?Q?az/rkvPlk38C0OWfdZM4PLJHpQLf2k9X5IKnZKD5FQEj585F8H+6ucvhbbCC?=
 =?us-ascii?Q?C7AnAd0S8z4+/XheqIKN7wO8s6HjuA+DxmOQi6AgqLLkDeccfguMUT7GtVtm?=
 =?us-ascii?Q?zRGWXz44NmMCtV2AcrSMPRnNJD8e5zqEP4xPFGUf/ql5iMGNcTzNqRsFeX9n?=
 =?us-ascii?Q?W45LmjsY7CcSYmsPAnj3k30A039ZnKRWOincMhd69iMxqII4zNIj4Dg+TV36?=
 =?us-ascii?Q?VcVdnbK3DWVMzFliL2OEi7rhMdRpnmjOjmPGZBOkbNASNTc44zVLHTV9pVVX?=
 =?us-ascii?Q?L9tDbcAPxLZ3DaRofWeuYvAKSFJqw3Da?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jP+yBg4dqF+Mye4nK2da479/OnfQgLksiiiXenWktANjWnHJmDI5EVP53Vt?=
 =?us-ascii?Q?HOTuzjXyoXYmVVHLq+8QIiWyWqOcl6mei4sOsuYbLO5W4vnuZ/eordpoiEe6?=
 =?us-ascii?Q?Aog+fVf5kQmczi54lKJmybXHGaGzFFqD7FGJnii1HVExFgk2H15iptVuTahi?=
 =?us-ascii?Q?zdQsbhV6vf6y7qv/U+eeRSytVMEoGubPjMXU/xa1qo9jF/AjLVJv/k3tcLWW?=
 =?us-ascii?Q?QjyMYweWruQCOL+epN0BmN+HlEh5RWp+uIk0sbcd1C5Yt9Ay/QLn8tT2raDo?=
 =?us-ascii?Q?CfNPDKotnaOFFRHY+MLZGlaoq5pqEMFYps93aPxEBhP7qoR483nvkXlgZh48?=
 =?us-ascii?Q?//JZfaSO2oc5JsH59l9xQh1l0rfjHJHlRuNIl+Z8Gcp5izCLfMAlIi6tcGdt?=
 =?us-ascii?Q?5CCDqn9H4fwDTGBUHGFR/7QVkSz20YDJtQuNKYViL1Is6M3jC3DGZ6BB8Qa9?=
 =?us-ascii?Q?ljrI2zgOyYjExELhLN9TEL1KKxrD62PtbhPt3ZN18ExB9T6+M9QtM5DRQ8gp?=
 =?us-ascii?Q?KoBGPh6qLcWkymH1pdzvHz514f9pflwfvKblFBtnn1519Vvexhz6SL7WXNpd?=
 =?us-ascii?Q?L8d0OuJ4K+Ta1ocxwza7BpAChJEkIZKgilKC3qw+9GKQnVtF3SON5v1PhGL2?=
 =?us-ascii?Q?K/U6Nktxo88NF0kR2+7NX7qdfs5J2azfupdRPjJv9aixveVncGMkbot/h4Pz?=
 =?us-ascii?Q?UeDSB1ynoI9ksPLcFWErYN1/1KueVsbnCrWlCyDbG9PlPPk5zTL0tqu9ijQg?=
 =?us-ascii?Q?KjmxZKUqJVYlQlt3nWgceeNaKobVuh845QllW++BdH5xvpTC4Iz597iw+upW?=
 =?us-ascii?Q?KFMnzJ5v7O/sGR0fKPKfyDwXECP8BFS5MSlQWawaPNTWaNRhzQhtamb3j9Wk?=
 =?us-ascii?Q?hrEa4gb3JOE3HzllhYzbEGxy8llCsPpvWDsnTbFVZOFZFYB8Rc4ziPNRDPn+?=
 =?us-ascii?Q?dsS6WIKgR3mqo8DM5yLYkN/uFPi43XneMcNAmorh2xas/scwphHFJuNBzo11?=
 =?us-ascii?Q?CjwwQES1OiBTmfaTUVhe/sDU2rB30TufItElB5JW7ixfM2dS9Zah34wXTZOv?=
 =?us-ascii?Q?hvPYQeBbrmtPpKi8ooljeJT6bsWbSUkxQm12trjxfymyqg6yq4SFbLA/f0Zd?=
 =?us-ascii?Q?mTId9DfjOa6PulTesS7D+7eBzVunNo7SYOJa5vRRwGd9FF1vWQ2Cqm6oSo8W?=
 =?us-ascii?Q?eo0YP681iytXa52XNOWfl+w6kX6MX5q2vOJBGoTIvIid3pltXX3N07KnJV02?=
 =?us-ascii?Q?gk/1uuXVGI4ssxiamaxDytlgGpEPuTaBoU5n2f8LCHEmPfvATLK4+wsC9L/7?=
 =?us-ascii?Q?4gFOQIYtttbKdhvMind3pAA7YhkMLcUlpDL6LsX+U8mL4+1PR76+dFJTWQgq?=
 =?us-ascii?Q?UIJvz5ndCH4nkXKycpSScMUTXwVBs1bxJ70dlkRuCOKp2rvGoGDKjFthD4dg?=
 =?us-ascii?Q?XNFf/Pfbja+9NeCFaOGpBClO4+MqT1DsiESbrdpNfAfj9VEywFBmLgda5bWG?=
 =?us-ascii?Q?ibiGLUKbLr4suRLHsRRADVrwhjM5vq8Fhs2HNehrloJA8V67QaZDJyH7aiOJ?=
 =?us-ascii?Q?Ckemqb+uFJkd1dL2Dgp2jFNF+aW5QNeKeWveugcf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03459c16-31b4-42ad-a768-08de2d724dbb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 05:03:29.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kil9ojEnQ5NG2RY+q/8ijuE5PVfOr0pBrPbhN55J1jpzGytsNc3WVJd4su7InqApJe0CYAA2A8OY6JF1XMT2ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028

On 2025-11-25 at 02:28 +1100, Gregory Price <gourry@gourry.net> wrote...
> On Mon, Nov 24, 2025 at 10:09:37AM +1100, Alistair Popple wrote:
> > On 2025-11-22 at 08:07 +1100, Gregory Price <gourry@gourry.net> wrote...
> > > On Tue, Nov 18, 2025 at 06:02:02PM +1100, Alistair Popple wrote:
> > > > 
> > 
> > There are multiple types here (DEVICE_PRIVATE and DEVICE_COHERENT). The former
> > is mostly irrelevant for this discussion but I'm including the descriptions here
> > for completeness.
> > 
> 
> I appreciate you taking the time here.  I'll maybe try to look at
> updating the docs as this evolves.

I believe the DEVICE_PRIVATE bit is documented here
https://www.kernel.org/doc/Documentation/vm/hmm.rst , but if there is anything
there that you think needs improvement I'd be happy to look or review. I'm not
sure if that was updated for DEVICE_COHERENT though.

> > > But I could imagine an (overly simplistic) pattern with SPM Nodes:
> > > 
> > > fd = open("/dev/gpu_mem", ...)
> > > buf = mmap(fd, ...)
> > > buf[0] 
> > >    1) driver takes the fault
> > >    2) driver calls alloc_page(..., gpu_node, GFP_SPM_NODE)
> > >    3) driver manages any special page table masks
> > >       Like marking pages RO/RW to manage ownership.
> > 
> > Of course as an aside this needs to match the CPU PTEs logic (this what
> > hmm_range_fault() is primarily used for).
> >
> 
> This is actually the most interesting part of series for me.  I'm using
> a compressed memory device as a stand-in for a memory type that requires
> special page table entries (RO) to avoid compression ratios tanking
> (resulting, eventually, in a MCE as there's no way to slow things down).
> 
> You can somewhat "Get there from here" through device coherent
> ZONE_DEVICE, but you still don't have access to basic services like
> compaction and reclaim - which you absolutely do want for such a memory
> type (for the same reasons we groom zswap and zram).
> 
> I wonder if we can even re-use the hmm interfaces for SPM nodes to make
> managing special page table policies easier as well.  That seems
> promising.

It might depend on what exactly you're looking to do - HMM is really too parts,
one for mirroring page tables and another for allowing special non-present PTEs
to be setup to map a dummy ZONE_DEVICE struct page that notifies a driver when
the CPU attempts access.

> I said this during LSFMM: Without isolation, "memory policy" is really
> just a suggestion.  What we're describing here is all predicated on
> isolation work, and all of a sudden much clearer examples of managing
> memory on NUMA boundaries starts to make a little more sense.

I very much agree with the views of memory policy that you shared in one of the
other threads. I don't think it is adequate for providing isolation, and agree
the isolation (and degree of isolation) is the interesting bit of the work here,
at least for now.

> 
> > >    4) driver sends the gpu the (mapping_id, pfn, index) information
> > >       so that gpu can map the region in its page tables.
> > 
> > On coherent systems this often just uses HW address translation services
> > (ATS), although I think the specific implementation of how page-tables are
> > mirrored/shared is orthogonal to this.
> >
> 
> Yeah this part is completely foreign to me, I just presume there's some
> way to tell the GPU how to recontruct the virtually contiguous setup.
> That mechanism would be entirely reusable here (I assume).
> 
> > This is roughly how things work with DEVICE_PRIVATE/COHERENT memory today,
> > except in the case of DEVICE_PRIVATE in step (5) above. In that case the page is
> > mapped as a non-present special swap entry that triggers a driver callback due
> > to the lack of cache coherence.
> > 
> 
> Btw, just an aside, Lorenzo is moving to rename these entries to
> softleaf (software-leaf) entries. I think you'll find it welcome.
> https://lore.kernel.org/linux-mm/c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com/
> 
> > > Driver doesn't have to do much in the way of allocationg management.
> > > 
> > > This is probably less compelling since you don't want general purposes
> > > services like reclaim, migration, compaction, tiering - etc.  
> > 
> > On at least some of our systems I'm told we do want this, hence my interest
> > here. Currently we have systems not using DEVICE_COHERENT and instead just
> > onlining everything as normal system managed memory in order to get reclaim
> > and tiering. Of course then people complain that it's managed as normal system
> > memory and non-GPU related things (ie. page-cache) end up in what's viewed as
> > special purpose memory.
> > 
> 
> Ok, so now this gets interesting then.  I don't understand how this
> makes sense (not saying it doesn't, I simply don't understand).
> 
> I would presume that under no circumstance do you want device memory to
> just suddenly disappear without some coordination from the driver.
> 
> Whether it's compaction or reclaim, you have some thread that's going to
> migrate a virtual mapping from HPA(A) to HPA(B) and HPA(B) may or may not
> even map to the same memory device.
> 
> That thread may not even be called in the context of a thread which
> accesses GPU memory (although, I think we could enforce that on top
> of SPM nodes, but devil is in the details).
> 
> Maybe that "all magically works" because of the ATS described above?

Pretty much - both ATS and hmm_range_fault() are, conceptually at least, just
methods of sharing/mirroring the CPU page table to a device. So in your example
above if a thread was to migrate a mapping from one page to another this "black
magic" would keep everything in sync. Eg. For hmm_range_fault() the driver
gets a mmu_notifier callback saying the virtual mapping no longer points to
HPA(A). If it needs to find the new mapping to HPA(B) it can look it up using
hmm_range_fault() and program it's page tables with the new mapping.

At a sufficiently high level ATS is just a HW implemented equivalence of this.

> I suppose this assumes you have some kind of unified memory view between
> host and device memory?  Are there docs here you can point me at that
> might explain this wizardry?  (Sincerely, this is fascinating)

Right - it's all predicated on the host and device sharing the same view of the
virtual address space. I'm not sure of any good docs on this, but I will be at
LPC so would be happy to have a discussion there.

> > > The value is clearly that you get to manage GPU memory like any other
> > > memory, but without worry that other parts of the system will touch it.
> > > 
> > > I'm much more focused on the "I have memory that is otherwise general
> > > purpose, and wants services like reclaim and compaction, but I want
> > > strong controls over how things can land there in the first place".
> > 
> > So maybe there is some overlap here - what I have is memoy that we want managed
> > much like normal memory but with strong controls over what it can be used for
> > (ie. just for tasks utilising the processing element on the accelerator).
> > 
> 
> I think it might be great if we could discuss this a bit more in-depth,
> as i've already been considering very mild refactors to reclaim to
> enable a driver to engage it with an SPM node as the only shrink target.

Absolutely! Looking forward to an in-person discussion.

 - Alistair

> This all becomes much more complicated due to per-memcg LRUs and such.
> 
> All that said, I'm focused on the isolation / allocation pieces first.
> If that can't be agreed upon, the rest isn't worth exploring.
> 
> I do have a mild extension to mempolicy that allows mbind() to hit an
> SPM node as an example as well.  I'll discuss this in the response to
> David's thread, as he had some related questions about the GFP flag.
> 
> ~Gregory
> 

