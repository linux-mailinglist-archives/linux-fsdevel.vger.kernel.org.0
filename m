Return-Path: <linux-fsdevel+bounces-54040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22AAFA9DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 04:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D11793B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 02:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B431C5F10;
	Mon,  7 Jul 2025 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F0KCHpk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94128371;
	Mon,  7 Jul 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856503; cv=fail; b=u0JILokpaGpQIIY8MKEI9doDiCTqZ3MQIn3AgfqobnCmJjGgpv7hR6AC3o/8dyc6NfhJdiBnR4omhFmbSkJpwfmdvztco0TrqAzHnwKEIS9sWBDLNaSRgPdFC5ohyJOzUbHtcvOMFt2l9qfYGiHRvom0aoVNzlQ0OK6Vrvet8f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856503; c=relaxed/simple;
	bh=tc+C51Tv3CGYBYXTd3IL56fnlJvzb4HwWUENhGwzxTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ESQmolbBM+gR6C/evG2g7ZEznLCU1kSb+h+gaiJyX8t5bEviPXzXMliavGeHqaP709RUBpsbaCBF3ERFK0TNm75GumKBrVWL8CGIacg8N54efObMF8aXomHoZAIDqZIBtxYZ92qt4PzDnZRxKtY2PmC2qH73LIscQ8t66gZuvLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F0KCHpk4; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdCWHyQK23gElbIgNyOW3C2fqOCW1oiQBvDk5Vb1USDAgwYSNw4+2WAMmaZgkGAP7OhLmiFvdWqzmSt7zDvZqrv63dBm2rwCx2sbj0uNeoIbC7tX00nXXKX9Lrjdbh0XUk4EYdGHwhsTPRMbRwHYRj4o0PjQmQMccd+btUrfevz++fziSHAgeTVAnbBa/Zb++k71TG57NzsPWd30+xlCt7JZ9jD2Gs1dQRPc61m+9qygEQaeyPrGD6r285Y1YlIwlcXVTMp0qUpBToYjvOK9VU9miU5JNMmQM7H142+9dN1tRRM9y7HYeE/kjIsL6pHUxtGtdQbrpmStK9g+dH+hXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqME9v+A4zQD31H0N3RQFvWcPnIh+C+00R4y4vAiSIQ=;
 b=gP8WLvRlDQ28C6DefFnCY/fNdgz+jXXk04K/zVmj60KeU+EoD72/GHVvllIcJACngcgYLbcBiiOWqjREdk0MCzUTLPBU+ZKUZs+dcaYMDOAjSNA1gbO2RbLDnbfTqzEeETTFjKnywqXBrZrZaDDYlaBBr7IRxJyDeub4HqsoOSrBDEHdpQ0WxRPmLXMiL3mYcB85NGZK+0vPUomnBUot3q49tBVQdrkLFmkeVDTddkEZi6UeqCqnALLbocaJfZ3URvsi70rcQzLuVDVhI4WeAXz4ZjcGi5+bt/fjBKHIPfbqq2Agk3bYFwIOdNjBR0DL9QfXCybuo6jYwz86R2r95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqME9v+A4zQD31H0N3RQFvWcPnIh+C+00R4y4vAiSIQ=;
 b=F0KCHpk4VyQS7pI3WSHM5AVLQPU3HZkAhRmIqlGSMpf+WFmagC3tcRpxPbl17ce85/jcSyl2EoJoA/gFr5/a42QYbD8HgEXuz8DtCM+734WLfC4z0TrokDHZUjRfftk/QdhM9f+gt1Ln/hhuXYWQteUvORLbvnGY2Ew9jraa2O5eLk9BbljKZmX8Zs6W7Ie1nddv9pT2UOP7WCiRNwEwj348P57hYiEJf4KQYMskx2CJ1LIc1tnPRQXfSHXpy+adQT6EH2kf5OWMpew3W9yKtwdFi890tkAYH6sVgC55/SYXnH1tDnF/y2EHu9VOlHKm6i2+DjDbXiSvsfEGs/PF/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 02:48:19 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 02:48:18 +0000
Date: Mon, 7 Jul 2025 12:48:12 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH RFC 04/14] mm/huge_memory: move more common code into
 insert_pmd()
Message-ID: <q4efnowrbxbmuoimuzpeamhf6f5uddi4oz6xf3yiukvacdqjyr@gl2mh4cnn2tx>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-5-david@redhat.com>
 <aFVsU9-ZhZ9Ai53a@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFVsU9-ZhZ9Ai53a@localhost.localdomain>
X-ClientProxiedBy: SYCPR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:10:31::30) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6460b0-5444-40aa-2975-08ddbd00ba6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5zsKccGD9SeUym6ezVPcM5urdgF8k/+aozeh6B1yVDK/hBdP2DWxeqLRslrk?=
 =?us-ascii?Q?e37SSYoA51wkQUJTir93ht8q5klTXfUbE5elJtdvUZo6hsT61mjkaVUx++e8?=
 =?us-ascii?Q?P5bc9VWamCIkjvgM1Jt7GHjG06Q2j8JoaNn/MAiKJmR4KDHU3Qwe04H2T80r?=
 =?us-ascii?Q?7j3aPvKeqVfY2Y3hoFMLHQvu4CgJZlhFUSgb/ltnY9YZdu9ixfCPWFckOO7W?=
 =?us-ascii?Q?IWb9pW4frQ5cXg5YVMmXZ8N1oem6DKC+dAeMUqrI0kPMnDeNr7uegAmeIWWq?=
 =?us-ascii?Q?+Or6QQdoDJm4yTEvbzOFn1PW0JkInbg3SKFkoYnS13RJbWV7WEe/QBtyVgJz?=
 =?us-ascii?Q?m6oZ/6Pp2920kQ1kj1jDF9J+3FgxO2W0vXBn4IYJS6IUJlvB2UG6sACc+nin?=
 =?us-ascii?Q?oMeUNknWUD/BMs4eUMFO82/5zlsAtfhUwvr0JeYUoisvgLqw8oIbpTJcgeN/?=
 =?us-ascii?Q?nztpWb+Kv/p+HDbydGKNt/Q48j5O0GHO70XgiNZhzQib77h7x45B8FuQXx5T?=
 =?us-ascii?Q?t8k8yL3gx2rVbSRBl/wA0ZyjgHbelCab6sLq7OU5aruzAE+IAW8qoZvvGIRe?=
 =?us-ascii?Q?sLQiki6uN2nqaTTBmY0A1Ah4TkK84hzkEYvXXOcX3TENtapu76h05jQ9owvY?=
 =?us-ascii?Q?PDAYpYihJWn1zbF7POujKf0Ijd0xVLdw9sJcFzchH9GFxDC/yJoIpyGE12zL?=
 =?us-ascii?Q?WcGn2IzxY4ZfT2QefvB/cbpdRb5rvZGWeRDLC8LkutSrTi1Zs3YY2iel/Xx4?=
 =?us-ascii?Q?tple7lAkNh4xs/l66Ce4zN7C+y/jqZM3zBE53imjCZ4ld8PD//Nk7lU0h2lf?=
 =?us-ascii?Q?5txqtvv6Flwq9kvQrtxKVk/Ck9kgUMCFOOS9qidDl7mns8D5gdFILfzkZODB?=
 =?us-ascii?Q?48g5rJhW2tKrbYTXsuvi5X6bEpyiOUAj1lmAJqdEakHST72OIqH3+gxXJXpR?=
 =?us-ascii?Q?avVEUcsou3m/g4YM/OP6rj36Gne0X1WD161holV74WlgX7D85jFNdO6C1qxy?=
 =?us-ascii?Q?OgJ0+Sff8aakIaZnbsB0vynP0Ir3G1OYNf6g3YVctuB6St70k3wzEtOUZj4d?=
 =?us-ascii?Q?IpokG91/h3WlqDi3UQXiQ8IjNiOUUlrHT4AExqEORk68lv9Bs0fiRb+9Fcja?=
 =?us-ascii?Q?VelnGE8gXqu8hw53lsqwIZjJm3DDEspeh4HOyptwoimTBICb4TuaKsRKgwHZ?=
 =?us-ascii?Q?iEpbR3MNqdry56dv99OkZrj4/4D5FwL0Nxxobr35W1N+KrD1JzWR2xKgj0HX?=
 =?us-ascii?Q?LacScpAgKO4xSSgNuQRkTfcjVvCHMTKWj9K4yclnMuX3pT0EXgMHKvo70+ae?=
 =?us-ascii?Q?0c/x0AOTRIIa0ljzM0siT4VC3zu2bSVYCkvz/FzWzfDllmjsCP2LOEK3UC+J?=
 =?us-ascii?Q?+Upma2AwnqVRLnJBAPPgBhGZM1XgY+5x1agMp6oofv4YEnQo8bOsCt0i5iUe?=
 =?us-ascii?Q?h9Vyj4T6m0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4D3J2YH/Fn/zFDMvRzFba/DtY0l2R+qeJZg2dorSS2cpPKy4MDX9qUDEBqz?=
 =?us-ascii?Q?PvzdGXABR+Qclu03hOZpRHegsZXQE+n2Xkrt29SGg9tHktK4jliN1OLwvwUC?=
 =?us-ascii?Q?alMuxTWahmt3gCdmS5CcACHYOw5yfxVWjHskZJxzI1bY7/SBgSUjygCq5Zxr?=
 =?us-ascii?Q?R5qjwssRiSzp1/XmypmszLULRhHtGED5mux0ZoTOq6aYzbB2ekaQ+amW36sd?=
 =?us-ascii?Q?CUHqVHUGhc5jckE9PiimVzuM2OkOqt+xXTHht0YhTTjTMs5Zl2MGwf6Cbob4?=
 =?us-ascii?Q?MX4250lARO3+hNr4b53Ub8YzLbWsykyIOn9vEX4K5CAYHps9ITyXGbVphVWZ?=
 =?us-ascii?Q?a2WOApfdkXFg0G2FyuGiOtiHlVB87RF8OpvyXM3tsxm9K9SKLKk7I50Y249m?=
 =?us-ascii?Q?Qv+1TCfusNH5CFz8Y3ynth/W0S809FVOWiOSbzqbFFb822CJzcPlBQ7f+oyH?=
 =?us-ascii?Q?hbGMgbQrcGiEMTg62huFlUgReeTG6xtdy2m9G0l+6O0DpOhrmxflQDnYJaFh?=
 =?us-ascii?Q?MzUjaYjwP6RlSGWS+LayTchCh0kCrCygIODcUCUeFe5FUPQ34E/yxj4iLeLf?=
 =?us-ascii?Q?6wuQnGro2QkYgLaVubLeCCAX33kuQZKdIqda1MP8GCLnsns/CqOTG/Wd80Da?=
 =?us-ascii?Q?M6xHz0jd/5AZ7tnqnVomZbm59U4UtULIHOHwCq0cbLYuT+5dZSqw+lC5iC0A?=
 =?us-ascii?Q?Jkfrg1J9U8sXodMUW9MIns1gaoPB1qiLNJW+UQa/olU6wopshbn3ql+FjiRn?=
 =?us-ascii?Q?vAAiMqRu+KtAMZdypUi/2PUYflPvBUnJPsEfdXS0Tt3A/KOFQMYi6tZrr5/p?=
 =?us-ascii?Q?DnnitUDLfjJ3awVK/RkFO4KAqJXVYntw3x2V4s/CwvxPwq4+KS3Wjly9o23i?=
 =?us-ascii?Q?mRvm4GrNYFqywA0ycdBGF6e72plEwNgmES4clctRTK2jFm5gj7m+CZCJSz3F?=
 =?us-ascii?Q?f8KnytpMVlTMhu/Gt+xZMSYrIdmiQ3/Lx2FebdlwztYeqAFM9iW35kBn5kUz?=
 =?us-ascii?Q?VF0fR0cjykXhaZfI28LAQZOACTH+kzlH6qiZ5A4nTF1lkaHyFpiAObvlHRaQ?=
 =?us-ascii?Q?8K47VMy5s7S7qsximtzsodt0walDTXltEdaBZsflovaGcNZ4Xi8rvVPlziJv?=
 =?us-ascii?Q?sQEx798As/OJlUa/9cUGo9eqLOe8EqtqZcgRO3mQOkhZJOhgEHzFEfF6g3Ys?=
 =?us-ascii?Q?yh2W/u7vbkCxUqlGkd1fc28WaYICSeRYKxenXebSlGGwlSA1wsCyqa9KmPCf?=
 =?us-ascii?Q?3FyQ7rQEu/PX+Ynzms6aRoMO5p1yTKK+F67wkVJs02zZl86yi/63GK8pX8F6?=
 =?us-ascii?Q?aAEZu+OLI7VEesAM2L0Luaie8QtrTGEAkv5Qxg4ZQfeZ0tP4uUlDWjgrDuxg?=
 =?us-ascii?Q?Ct0n+GuGZgoUbbhLOETrtCk0SWocw/F/YmQSSrGhQ9Ln3OimQg9/uoj+cWaT?=
 =?us-ascii?Q?EG661/OqJMLRjSm6WKXu+xE2btf72K1ku6iKjp5LPYZ6btdY7sb6yq61cD7F?=
 =?us-ascii?Q?cTDn/yzyXXCJabPZt9yMf3tOcc7dE/4iVJycnRO8UQi4D6HOeDS//JHkrf4G?=
 =?us-ascii?Q?qtylKbG7cZ2m2j7X8bPqYKUWa5+PUqUVqQZUoGtH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6460b0-5444-40aa-2975-08ddbd00ba6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 02:48:18.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I75/enYc6jOwVSM3/ZH3WnVkxpMFtKveRX/FTLXJTnZuS2v18HtaKLucDEFcGWQkouZlfVlJ9nXMB0/H1b4VpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

On Fri, Jun 20, 2025 at 04:12:35PM +0200, Oscar Salvador wrote:
> On Tue, Jun 17, 2025 at 05:43:35PM +0200, David Hildenbrand wrote:
> > Let's clean it all further up.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> I was thinking maybe we want to pass 'struct vm_fault' directly to insert_pmd(),
> and retrieve the fields in there, but since you have to retrieve some in
> insert_pfn_pmd().. maybe not.

Where practical I quite like having callers retrieve context struct fields
rather than passing the whole struct down. It makes it very obvious what
elements insert_pmd() cares about (in this case one of about fourteen fields).

Anyway looks good, thanks:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> -- 
> Oscar Salvador
> SUSE Labs

