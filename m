Return-Path: <linux-fsdevel+bounces-5165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDBA808D6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 17:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF5A1F210C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9936146BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="LAtosgVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC09128;
	Thu,  7 Dec 2023 06:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Re3eP664f/0FTxPF/AYhsNpoOw5E+NvyPIL0vTGRSJTdv1vsyT5E3+xf/A9tb80LHRVK5HvoMzBinkK4nPMT6dWbDYTXl1DeMNoO3eV5ZFr6q4wxdiBNw/arBDHbdrEzGplRL2AK0L9sw87JTFMUVdDgbraX77KgZMm/sO54Yu1SpHWrUryMtt2AxFKXajTUomnlg3VwxKCW0nwSAxMf3EwRVY8wwuP3tf4po5ob9haenlitsDxqOMTXteArGBUCEWU4enX2Zhxkk/RAmxztKC7ASXjMN2b4W/bi7ZuKTeO7AnaVT4FaBxL3amfJ3otckmfBXSz4ywzAR420Ga53CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i67kcyKcdobkbYaTd9MF1EeAf3SUZGw/LNZlRB+L08A=;
 b=BstC7+1IDbAovtDi3YOw7hFn7vGd0sbGrXHOqvqyjtOYSDEBFTaGI2Q9UqVRmkiseKmnMy63MA/MyQATOZA7wtHikII++77EVw3EwBl4ECF6PLtasyPzU8vLF079MpX2Mkl9tXQvCXj8fYsAgMkLCnDyM/UpCB75TGW+A2Y2czwR4kG9y2tB2iE/OCMtGiRg4bRDlU7Z5JWegjXy5VfqUxBgTCN8P9e3/GMTepUwR6AHBOe2Nc/3UoCkgooXkzkAYckEF/H2w18/zL0BGKDv+KVjyA50hPZ+NPILGFAMv+0MQRfby4aFxA7WpQoBaJ/WvXXS78QojUYSWepr/+FCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i67kcyKcdobkbYaTd9MF1EeAf3SUZGw/LNZlRB+L08A=;
 b=LAtosgVPz0aZeRsIHEm2qLoWEKdSrNjd9+16rXsyS+WFyoHrmy3jiIVIm9lnpwIZKBZE+esbLpI2zrluAwDUgAz41DFgOR7miZo9+pv1zGlvxtw/B0b9pEyzljxgN0Hmbcr//xT0gjvgmMyQY67jqzxwG9UlYR3nrxk7l8s10V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4175.namprd17.prod.outlook.com (2603:10b6:806:82::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:58:19 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:58:19 +0000
Date: Thu, 7 Dec 2023 09:58:13 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Michal Hocko <mhocko@kernel.org>,
	Tejun Heo <tj@kernel.org>, ying.huang@intel.com,
	Jonathan Corbet <corbet@lwn.net>, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	Peter Zijlstra <peterz@infradead.org>,
	Frank van der Linden <fvdl@google.com>
Subject: Re: [RFC PATCH 07/11] mm/mempolicy: add userland mempolicy arg
 structure
Message-ID: <ZXHdhVeel1dOxlYJ@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
 <20231207002759.51418-8-gregory.price@memverge.com>
 <67fab0f1-e326-4ad8-9def-4d2bd5489b33@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fab0f1-e326-4ad8-9def-4d2bd5489b33@app.fastmail.com>
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: aeba84c5-f709-40da-d709-08dbf734f2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sNuqdicEcHMxEOzw+LNH3f0rQGyP0tFFDNy+qS1o15aS5i/U+EAf9sMqY1gy6OPdytyvZMElBvouqQhH/6EZRKvyZy9zZg6BEItff95zV5H6y8OTxX6M9a2AMBPOvnJKPiV7LcCgvAfaqZW7JLZ2T/j/1nKYYrVQSERdzjgPFjYeyCosTMtQx/khUz9S5QPE9xlUdit1XUlECoW65RyEZRZBm4UVDoXxQxpucOf0P7E/cyf/k+CSPuEZXxW4N5eN4W8Xx/5luE35cSgTN0mWtbItQDc3bM/cw5pZvylfFn71+v91L8pWA6CGsYjCBTghgVH+WslxhshEKCRHKZO+T8PTqJtx84Qm6cP8z5M5HSePphFUE+C7n0RQDzVzZ4TFECWx6IljrucHSwGcZUNCv2wpWF/2U1X9hAhwYLPbIDKNVbrSewmcpfL0InGMWCRu1pXxf2VVp3KxHTyMZjWHdUxnR9H/chPp7awZC5IJF5I84XjKpmyNej/PzM+jEhKNonxy+dzYMW9F7Z4yP2XtEgadyGICtZiWHhLdlBqElv6zZIEcpBfLkWPSppAI4S7d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39850400004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(7406005)(7416002)(66946007)(66476007)(54906003)(66556008)(6916009)(316002)(44832011)(8936002)(4326008)(8676002)(5660300002)(478600001)(6486002)(2906002)(6506007)(6512007)(6666004)(2616005)(36756003)(26005)(41300700001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VHDfYgT7sDTno20H/8W9PXyI59Uq9XEsMgjnJu9ExreIAbDsP54sv+Bda1p?=
 =?us-ascii?Q?5To8UJuWc9QcMol00GSTJAjIGgv/MI0v6LDAlxtuUmB8t4HNEUXGzXFZE4fH?=
 =?us-ascii?Q?zRlPEwmt9HPLt/qygTokQPZ+Hx44jhbzNLRAum0RtYKibcmrplbpnOPFnYS4?=
 =?us-ascii?Q?/Nc5GCgFFD2m+5Z0LSt+0fPqnUsiKT1Ey/ISlLYOMHh7b/8C3M4HIBcNlGMR?=
 =?us-ascii?Q?n4VK35lmBkf21ReaL6sIcIYN5UdodhNarOdBqePa/Sd3GMC2ePVDG53TWIvw?=
 =?us-ascii?Q?rbMiAisSiK0UA7sB7Z3nehZvTmmecKc/L02iCWUALWgJ5zge3xho5Rkf5CVK?=
 =?us-ascii?Q?k+FdgCBeZYH1UaGl/2VtZyI73uDX++IeyqirJHTFRVTX6P1SsGDfWI+O9pyQ?=
 =?us-ascii?Q?81a8gwXuxV8P5CnbHFyd/AqGFyxBweinvmOa5z4Oag6BUhbtwRjPUWQ6WAJr?=
 =?us-ascii?Q?jH2UtGgRh948U8eXFkt9K+K8Kk52x2dakB+PT0EtJ1DV0AsTZtZGlPPBiPnG?=
 =?us-ascii?Q?1eqDiYhUyoMzyqipxCjzZ/EeL3yZJsEr7JU1GaAthiq0AHMd5vva55zX1HGC?=
 =?us-ascii?Q?SMw3eCYi3v34MIhL43r5JsgwkcLH4udwtS8W87/+QYHa4aP33F+P7xzn/XOO?=
 =?us-ascii?Q?W9MaHHMLdg/OBj1+9B70dwjWBOPTo6KxLvKe4Po96MRbRXuJ7CGo2Qe7IN1Q?=
 =?us-ascii?Q?L082LZvtU6h5fRk3d5CsbOss4lPcblpIchn21Bi/lhA5aDohqFC1dYjNllJ2?=
 =?us-ascii?Q?SVsUYSllYWgrFuxMOZjG3Xw9+NV4vhK2OGUI5xJYFoucF8K3NfVG5WkChhNv?=
 =?us-ascii?Q?4adI0k6sOTLNL0iNzhlTqfdixlNkWw1vz96X2vMuIbsqNqOCqLUTXNem/A0O?=
 =?us-ascii?Q?0vBsW8FfbugV+qoGjpveZpQ9kQastDJS/Rcj8TYih/RieUd5u1HCPLfbZT9q?=
 =?us-ascii?Q?C1bqYvFy9p3KA52HL9mq4WB3fDNCs3O7mFxg98pHle05Ia7xbSm0ap7MgB+k?=
 =?us-ascii?Q?WiWGgRE/Nhp60vi6vseLuC/8C/UInJYWc3+yilE6P+raE+jE7nXeLNAbDM2R?=
 =?us-ascii?Q?dB1fnIkNPH6nfu/yl/tAOeeXPLiPw8s8HcLwvI6T874oyrZoGgC9gKAVvih3?=
 =?us-ascii?Q?qiWkn6rZRk/HDXkRUqplCPP0mTZs2rClXo3fjUMzXkjf5AG99nbtgcxgSsf8?=
 =?us-ascii?Q?e7Q8UO3W9CtdxDqscrCo5ybflfyQNhHYOC3LadI3R18tLF4qPlkw0upUJoYK?=
 =?us-ascii?Q?SRbvPzznqWcjS+SynjvfvZod6OFpkjcXBnAZQBlHsse2CKfOKrpzkCrNtsuN?=
 =?us-ascii?Q?zWjMED2GOoHoWKe4cVGO7sGI7FGPlAb2SOW+Cpqv/nQFNYCDYW4/UtG8oxjb?=
 =?us-ascii?Q?AE0FUGI6gipIqs/kPn4c3S3/jbF8VBpeOGoaIrMtp1czKs/pazTIlDwWFHhw?=
 =?us-ascii?Q?1ON1B7bJmQc3WYFCLkSOZa2lezppvhGPM0ibwaP+4KFYNBbdtKJcfUFdxru5?=
 =?us-ascii?Q?1tjVnbOkxohNJVvyuOvxpB6Frq1FPip20FX4rxu/VzjHFM305+mwt3062tXQ?=
 =?us-ascii?Q?o4Z7P+FEKK4QMIwnUn5qaOJ8hIHjRmmT8j9ale2IipPND1ylkE6SQdx7ODTU?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba84c5-f709-40da-d709-08dbf734f2e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:58:19.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wX5lioStHt9yAxYCidYr+uftOYMQIcS9jo5Q0tMMNW6HylLn6KBJ1FKl+TgxcaOKlCLVKUZv4kTta3Gu68iiO3tweVOFxrbwvxEm6bDCQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4175

On Thu, Dec 07, 2023 at 08:13:22AM +0100, Arnd Bergmann wrote:
> On Thu, Dec 7, 2023, at 01:27, Gregory Price wrote:
> > This patch adds the new user-api argument structure intended for
> > set_mempolicy2 and mbind2.
> >
> > struct mpol_args {
> >   /* Basic mempolicy settings */
> >   unsigned short mode;
> >   unsigned short mode_flags;
> >   unsigned long *pol_nodes;
> >   unsigned long pol_maxnodes;
> >
> >   /* get_mempolicy2: policy information (e.g. next interleave node) */
> >   int policy_node;
> >
> >   /* get_mempolicy2: memory range policy */
> >   unsigned long addr;
> >   int addr_node;
> >
> >   /* all operations: policy home node */
> >   unsigned long home_node;
> >
> >   /* mbind2: address ranges to apply the policy */
> >   const struct iovec __user *vec;
> >   size_t vlen;
> > };
> 
> This is not a great structure layout for a system call ABI,
> mostly because it requires adding a compat syscall handler
> to be usable from 32-bit tasks. It would be nice if this
> could be rewritten in a way that uses only fixed-length
> members (__u16, __u32, __aligned_u64), though that does
> require the use of u64_to_user_ptr() to replace the pointers
> and the reverse in userspace.
> 
> Aside from this, you should avoid holes in the data structure.
> On 64-bit architectures, the layout above has holes after
> policy_node and after addr_node.
> 
>       Arnd

doh, clearly i didn't stop to think about alignment. Good eye.
I'll redo this with __u/s members and fix the holes.

Didn't stop to think about compat pointers.  I don't think the
u64_to_user_ptr pattern is offensive, so i'll make that change.
At least I don't see what the other options are beyond compat.

Thanks
~Gregory

