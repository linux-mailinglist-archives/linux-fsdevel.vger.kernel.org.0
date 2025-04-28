Return-Path: <linux-fsdevel+bounces-47537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB666A9F955
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020B11A85FCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 19:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B87294A1F;
	Mon, 28 Apr 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X5FThJj7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QvtA5Lx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B01C5D46;
	Mon, 28 Apr 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868044; cv=fail; b=K5g9dXvIDL4l+S2smfS5ie/c1unOP4ZlA6OrmRA/kcsj+o/nuU+yArcVDHAVM9jANYe+e5Emofi+1LqE+AWwCOAm8dsb6hswgIMjhOxBaMzMqWfRebKwLp34l9T96//QTPr8EArmst9R2TJsMw4k3Q/xgFKFU3ycB8YTUybwGXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868044; c=relaxed/simple;
	bh=kPR4RhCkAsZYLaw/zoVDvgImhiBBCpPFuNN9/OLXbP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oI+jyEe2iKQSYS3/vWSqGQI5gPXt4U0F0vF2Tljg6bB82JmCnrX+4X0nzxcDtPzznBKiCETHz11u3J/kNsnzSrdjhU+KgE7bsjY2qhr1BLh/KqD2ba9SmZUeCH16gKwGx/IIauClALWA3ArFK3wt3KWXzKkZD9BfbwLfisR6+Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X5FThJj7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QvtA5Lx9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SJ2Pcj016195;
	Mon, 28 Apr 2025 19:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qv2mq9Vnyddj0VWruV
	G8k6fFoP+E5H7mAa7kKcez46o=; b=X5FThJj7lO6+pa5MrSDzbUanlvKkzVj+Jv
	/Z+s5gNhahvT6YOjgTTXlydFNiiRRDovkNoC2n4pkYx4Lk0hUrLFazOPHs6gS32R
	THg4d4TvHxs/sbhIIN0H+qOkdjNqMVH1NeN9576Z4Ww3maLKDbG05C/oif2AGwV8
	7Iftev8j1sFZAx66ZSNToVpI3NywgXIMtQQZITTMLrfg3WLwNzJ6Vbt/D+zoVYnk
	AlmytxZNf1dsEvZvs1ws33jHlaZcREqSkY57GRm2WMsxgiA/+VTSAC8lz9dHQeVt
	+ydx8ycbc53X0M9vbreKI3Dsy38dLeTLaRPH4apgHEP55r9M1SXA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46affng1h0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:20:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIV4Wx011314;
	Mon, 28 Apr 2025 19:12:26 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010003.outbound.protection.outlook.com [40.93.13.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx9c77h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:12:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxzlpArxRXP+KbakH0xFrOIJfXu1U8ulasFeUNXpdcKwXzMDJycvS5FmtORai7vy4gHyjVFhIpGZZpufh1Qt93jdtwdY8zf7231QV2yRQoLUWCau0sH657+Dk0TjyIk00i4mQXLwaYCasYifvOvkecEipoYRQ5c6tzzzeP03Zepl3RpXrpWr7Nth+9gisL3NtXcT7pGe/cZnA/ZyWnXzWHyopgUFIFh8IFLSKwGwF7at4AT78ll7qDvbmM7UP0OIilOjT/htc8JlWghlHqc6uRBNzApkDItdQ2YEu3UtYMV3xKD8wiJ2j2nJNbYQRoUPFD8d9NpHmjJ+x8WI5Ivt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv2mq9Vnyddj0VWruVG8k6fFoP+E5H7mAa7kKcez46o=;
 b=Ud/jkhrf/MRHVpE7okRa0w9yEq0KPflKgThPXZtW0xfl3YYWjjKZPPUw1pe9FE+Ip9bpJanQ7IIYMKVQH7oktU3CIZ4ieSkV6WcAnxg97swnQrlzsTo1vrkA9iYJ3BRDF77CKMXM5WUWohFtudI9OzOoeX32XxNIvzAuylx9kO4uYNYfdxXH80FRKtu+UBSreLTFujXHt/m262ts26Ym/H3Cm6zIvsktfEJLDHM40MzqHomTxqDhISxBqhHD79/SWx+RWAPuSpbqIm8FrJthBiYxYY8UAVVCWjRn2LKfLbrxxce10yK3g2xclVgsDzWDd7ktgel1FhyfznKNrPsXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv2mq9Vnyddj0VWruVG8k6fFoP+E5H7mAa7kKcez46o=;
 b=QvtA5Lx9DdwCLe045RvX1dml4o9koGOFgoKTWXzz+GyyfYCfT51FsGSToDjzprsAE/FqrR4Lop3yotLTfBKrSUiVdK4GTkMQjHmbatoUuKKIz5PwFApDJQ77mVhFCuNQEX1zqYlMnI1obInvlQSsB74Y/GUPQsDDqUbFUT65DPI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4227.namprd10.prod.outlook.com (2603:10b6:a03:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 19:12:22 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 19:12:22 +0000
Date: Mon, 28 Apr 2025 15:12:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm
 VMA functionality
Message-ID: <p7nijnmkjljnevxdizul2iczzk33pk7o6rjahzm6wceldfpaom@jdj7o4zszgex>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0434.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e0f230-cba9-48e4-28d2-08dd86889ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cw8GQ2LHIb8VophKVGnYz62kDCRGCMUgL6d9GjIgfSsowX0o3+0zLJpLQa8k?=
 =?us-ascii?Q?OI67tjP8PROa0jBRl2NJcfnaKlTZBxkgIJECKxHvyHYxy2szLrXOIlAizGPX?=
 =?us-ascii?Q?IdF94zagLMVq0TnchQbQYalkbogpbGuPermyPHHbc8pVWkyv55g0mllB0/qQ?=
 =?us-ascii?Q?eVyEgaGUT1iVOYZllLPFZnnz3rjyLulWaL/w0PpTX1HlpiFLeUvZ6tu4lW9w?=
 =?us-ascii?Q?IPJk4QvWyGoWsyJ9jTk2BnHoKHh0llPMlNj6bJ3p9EzPAWtUSZyjAci5izql?=
 =?us-ascii?Q?l/WgvGIW+Dr54Bqg0fA8oy8itbNBCQGBvt8Wi5o2L1Kqt1n8OzWPbzdQMTI4?=
 =?us-ascii?Q?x7gYxNmKHLGxirZvXt1HTnPRUzJtiIXNa5qLSaQd5Hx+8cn5GrGzGHukFwhz?=
 =?us-ascii?Q?nvXjLV0qdfM9+3ouogQ2vJpIgHiIWuPOsqehjrnDylxJ8pdREdavBP7URwUS?=
 =?us-ascii?Q?mGrolWqsROIeGs6akKqo2fH4psNNr3xMLUN5tyh6w/I4vcZ6GapD479NYF7v?=
 =?us-ascii?Q?Rb0uuEpalF8D47vVT9rp6vU3e1tD3ACaswbQ5TqMhXmmhCdL9hwoF3iSB6RA?=
 =?us-ascii?Q?oSkGu+2qWY4I/3dqsDMuDNvnDX4kHJfsbVQ2j4KQq36zAe0yzLACxrHJ0pCc?=
 =?us-ascii?Q?9lwH8PcBX8Vm8TFw6ZldcuYHxlyfryxTr6jakGykCycRNv8lz310Xa0eWI+F?=
 =?us-ascii?Q?O0DpSXJY8NaKBlP1p4RsksojeignA7pzjVkby5fOvafqUiPQ54npDixVqhgf?=
 =?us-ascii?Q?pua0FPktwElFIAyWi3Zf+pJ8WJPsQZ3T/Y66ZfRIaPtus5m2bAL9z9JPsAoz?=
 =?us-ascii?Q?HFgo0gzTXjGL9YVeThd1OQh2SUPmNVY19JXQEjPlrMFELNI7zsog0mS+spH/?=
 =?us-ascii?Q?Ygb26CqLpMHER71ruRvuFti5PaoeTvpL7fqzhq/aVzycQ3IEJsZuNS3py0+d?=
 =?us-ascii?Q?xiHXxXyb4Sjw8sO10ckTN2KmePqztOnmRw1ZPWTKSxbth9BFEeotg2G9nb5F?=
 =?us-ascii?Q?/8Si0cUnwHfG/cnlLO7trnnRLuevtDEgg8yqDd142tFv7VcFyPFxmBEkxWqp?=
 =?us-ascii?Q?luqY/hhGq7lRgji4oBRDj6AGXFc5u2zWaldda0kH4Sipy0e2us1xqDKzyOXU?=
 =?us-ascii?Q?xOlQJQrViWwf83w47rDQgUO/Fprmwn5sRjZxV5+9NC7RJWFWj+EuXUUEehl2?=
 =?us-ascii?Q?ewELMKnWFW1c+vA4d4BT9Ja3HMqXgkoDGrdh6xSS9lZT+XDjsJefspk5t/Kj?=
 =?us-ascii?Q?rr4Dfyar1OnvfLcFPYpE2AIVZYGcHfLof5Gn+B5+H8BfNOTzJy9h9H54Iqew?=
 =?us-ascii?Q?HSCN6lsXAloMZV3HxcXzttiSRCq355PpQKwA0US8bcxeIyc1rNMqsfqDyF5J?=
 =?us-ascii?Q?BVmtQAScOHqLSm9jSk1H7JGtg6xOpIygR1yUaL7FU2p6D+6CuwDm6mHTqJ1b?=
 =?us-ascii?Q?CpAfKN7xT/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMmEHPpn6Xpl3CrTbYacEaeMDTPi9YB0jcR0DHfcFa1K96XhY60pNx2HMjc9?=
 =?us-ascii?Q?O1d+A5LjxI2iI5sZQ03lNwtMV7LlcfHKDugkoi4ZlD1wGjLnrO5JFLWa0ilR?=
 =?us-ascii?Q?DerAf4kyZ2Uz+0DNH1fNgKY9Cx2A402IS5ZqCqTlELqxxULcGYNAJHxwkCB5?=
 =?us-ascii?Q?N7kReYBoCpyYTVMUI32Ltp+bphwh17LrHMWoNaGKhBsvGrkkIA+oe/RKB7hs?=
 =?us-ascii?Q?aWrUgRjcv21fFR55QzkhpKGiBXynhK2aTVx6jHznzJla/NG0IpiDp07eCEXQ?=
 =?us-ascii?Q?SMpXqJpCp1RyO1EBHJTyzdNbWb3L5Lsb3m2FgweMA4WVDCPKaospnn3Rxg8P?=
 =?us-ascii?Q?zKS67pCcjOjYIN+3Wzs+nIhbkR0Z7mPWCKxQMZ2p2sHVcjJdIvBuVH/sZVeh?=
 =?us-ascii?Q?ZXWQw1cJCwICYTsWwHdMx2tEm5fl4nmimj86x7+hMGqerzytiBE4lqRY4YWy?=
 =?us-ascii?Q?hUDpJJPf3rYQEmAaPaLqiBsmcstj+k66MNg6jpv55IfH15taDU0dwpvn4vzW?=
 =?us-ascii?Q?U0fATM2bM1WvMIYhnDMiowDdIhoHlkTRQd6zlEOOYloX/T3eo/N6ZOwvVPWm?=
 =?us-ascii?Q?N1KhR4zfxHa0P1SBdJgwGFoA1QubcVChmdPoMHvSaV8VKGjum7uVgK3efu8q?=
 =?us-ascii?Q?XzmFRbwOk9o7UbbfyXeoVhnWIuzCeCwD3sQ9+Y5bb+1Jve7VasyyrtP2xhBS?=
 =?us-ascii?Q?JhSbQEnM26diL8HUJ8oyfj9zpOpCdrNzaBma6rZBCO4qobftVueymFaA7Wrx?=
 =?us-ascii?Q?y0KCFjilzu6K0kfaJPN33F97XEA7qSRIGIU/ypBB1DyE08syyLHUIVsCxn4s?=
 =?us-ascii?Q?P0WEXMXuvV18y1F8mUvgd+YinC9DFMy4Ci17GP7NAB1u7oUFzwGq3SHi7dsE?=
 =?us-ascii?Q?Pa/l9xCnsHRi1EboAzu8vqb+7bhYthUR1Es6tkJqOLXpvALotAiqkgdSGBCl?=
 =?us-ascii?Q?F3JpQrIOIG33BMYt+lazDghZtbO/+bJoWpmevpazTezwID90YLGV6DH1Nhi6?=
 =?us-ascii?Q?TbTSI6l4GNj8lHSAETUsNHYtlb4i9Q7cKrMTESboJ07Wny8x3Gvn7z1J0Jtk?=
 =?us-ascii?Q?GDOqujbHfKLpv9edrB2JFrBxaLyab07q0ngpuF1Up6/vXC0j27+CcWsLEwkQ?=
 =?us-ascii?Q?twD8j6h8ltA3OHl/95Rj9lP5tnuVFmM4mMi3WWDgNKJBlNsbnnx0hTOCB1i3?=
 =?us-ascii?Q?8VwUP350IQ2Z/G0rlW82/qmxaD6Ki4M1mdoK4CBMh4z7mOHs8vRRpoR1Kx+w?=
 =?us-ascii?Q?Qo+5zOMStpOPy6Ma1UHvOZJUzoGmPv3QfQ9zJMDtPrxoaLYrqfaGYRFuW0hy?=
 =?us-ascii?Q?jNQT+QMKpvmN2H2EjQbJi0gfW+RMGfO4cleiPB9Tie3eqo62b5Eq7ICqFf9y?=
 =?us-ascii?Q?xeR+ukQMBHIDQ9Db45nQICARgJRzIc9VyHyj3vhNR3jgBdy1nnqymc/syaRW?=
 =?us-ascii?Q?pTyQvutsBu3JVHAQgpIqVIj6okKzjiI9KIfaIEsMCN/upOqfz4z5K8LQxXvs?=
 =?us-ascii?Q?juzAnws+tbrZ7J8hazzN+6/ARh0CE6H8FZkTQsQMDon21yA3MTm1kLAxAPd2?=
 =?us-ascii?Q?ZwxhTsj312iinrB7s6RYbCLpVTXYGrHfOGL9ICfX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xkTxtqysX9+KDMUu/MSv4ukgerzjwl628TODtSCeC4MJld3Rw4ylitOYDHsBXBOLgB79LGuIOZvTsJZaoBdcBzIt1y+hXetRLs6FPyYj3/7+/WKEOmmMKZVHPHF6HCNW2yFfbEo8z7IkBKx8bWYczw//toXByalHYkA/u3EJQ7NbZ6itJxkbS4fIesE3Flcjg+UGjied1otAnGker23hlRYPD2m9krolIhbtU5lMPT6U8mDW5+p4/l0r1i1+MO2w4/LGH1TZVbd4eBnc/5IcwIZW14sjoTThAU/tIFql2Gc7O87eypad9OfNdgN+xAzPCDGwhaLRjGztri08llYiubWSlPKDTkA07FxAN/syQ8EOXr+UJLRiRD1D4K/DFrcshQCrsqCAoJ5Z7YQsuWVMWU5xsEsEhRia7RbjYxJvjqfntdrVHAp2+Hfo4kXrMPn3dAN1bNya0fgZ2dCCvxFFQnfhWoe9isHMthl+VvDR1rlVGfGW99Rtjjgg5J2IaMkGmi7mrmfSD0WksYak/9DDC2cH+L/0iRUFha0E5ZThBePjU9HhlDE4Ub2E0ihV+Qwwl5vI6dQvoucf50MKaJXigSyBoZto/On5zCBUlmK7hs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e0f230-cba9-48e4-28d2-08dd86889ac2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:12:22.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaSYCdgsVa0y6UPBh8um5v1SvNPnEgcZxwr+D72ItG7pQEl31lXDcmMA3XVt4Yz4+FODGgl6T5HVbbJFR3c7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280154
X-Proofpoint-GUID: cvSyRRMZV2bWQCJ6zv854NQim2p4AZ24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1NSBTYWx0ZWRfX5NT/S/QPcoOD u4TzglGVJPKoiImS7h8Uhx16ZCL6GABfxqeqAa1EBSCokrni3V7e9xnaO5CcIholpReZG19Xi8Q 7xSdWQsJ6xsCixCHvUjzRHQhPjQlvfUqQx7e6Zg79jt3by0c00n2Wp/f+/82VNJ6TgJn9/gtysA
 XjD606RUdYVcn6E9X6v4h8E8QI07yxzHIBy/c1MajFFYWdEKKGrFTEGkhp3CGAX8OCG6Cm/PUKi O4BNlYSFLighBTAqwSWLhtpBBksNO/spYptABg7b2nPkjQarBfDluEFqp1ultj2DfWPKbTYCeQ3 0RJ2oaaq0eBrk7/hOIhe3o/obTrcdGZQyv8QU6Ls9eEEPjjwcR+6y34WtfCTn275Fl3sl5dO116 6NW5q5Ws
X-Proofpoint-ORIG-GUID: cvSyRRMZV2bWQCJ6zv854NQim2p4AZ24

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> There is functionality that overlaps the exec and memory mapping
> subsystems. While it properly belongs in mm, it is important that exec
> maintainers maintain oversight of this functionality correctly.
> 
> We can establish both goals by adding a new mm/vma_exec.c file which
> contains these 'glue' functions, and have fs/exec.c import them.
> 
> As a part of this change, to ensure that proper oversight is achieved, add
> the file to both the MEMORY MAPPING and EXEC & BINFMT API, ELF sections.
> 
> scripts/get_maintainer.pl can correctly handle files in multiple entries
> and this neatly handles the cross-over.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS                      |  2 +
>  fs/exec.c                        |  3 ++
>  include/linux/mm.h               |  1 -
>  mm/Makefile                      |  2 +-
>  mm/mmap.c                        | 83 ----------------------------
>  mm/vma.h                         |  5 ++
>  mm/vma_exec.c                    | 92 ++++++++++++++++++++++++++++++++
>  tools/testing/vma/Makefile       |  2 +-
>  tools/testing/vma/vma.c          |  1 +
>  tools/testing/vma/vma_internal.h | 40 ++++++++++++++
>  10 files changed, 145 insertions(+), 86 deletions(-)
>  create mode 100644 mm/vma_exec.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f5ee0390cdee..1ee1c22e6e36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8830,6 +8830,7 @@ F:	include/linux/elf.h
>  F:	include/uapi/linux/auxvec.h
>  F:	include/uapi/linux/binfmts.h
>  F:	include/uapi/linux/elf.h
> +F:	mm/vma_exec.c
>  F:	tools/testing/selftests/exec/
>  N:	asm/elf.h
>  N:	binfmt
> @@ -15654,6 +15655,7 @@ F:	mm/mremap.c
>  F:	mm/mseal.c
>  F:	mm/vma.c
>  F:	mm/vma.h
> +F:	mm/vma_exec.c
>  F:	mm/vma_internal.h
>  F:	tools/testing/selftests/mm/merge.c
>  F:	tools/testing/vma/
> diff --git a/fs/exec.c b/fs/exec.c
> index 8e4ea5f1e64c..477bc3f2e966 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -78,6 +78,9 @@
>  
>  #include <trace/events/sched.h>
>  
> +/* For vma exec functions. */
> +#include "../mm/internal.h"
> +
>  static int bprm_creds_from_file(struct linux_binprm *bprm);
>  
>  int suid_dumpable = 0;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 21dd110b6655..4fc361df9ad7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3223,7 +3223,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
>  extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
>  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
>  extern void exit_mmap(struct mm_struct *);
> -int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
>  bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
>  				 unsigned long addr, bool write);
>  
> diff --git a/mm/Makefile b/mm/Makefile
> index 9d7e5b5bb694..15a901bb431a 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -37,7 +37,7 @@ mmu-y			:= nommu.o
>  mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
>  			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
>  			   msync.o page_vma_mapped.o pagewalk.o \
> -			   pgtable-generic.o rmap.o vmalloc.o vma.o
> +			   pgtable-generic.o rmap.o vmalloc.o vma.o vma_exec.o
>  
>  
>  ifdef CONFIG_CROSS_MEMORY_ATTACH
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bd210aaf7ebd..1794bf6f4dc0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1717,89 +1717,6 @@ static int __meminit init_reserve_notifier(void)
>  }
>  subsys_initcall(init_reserve_notifier);
>  
> -/*
> - * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
> - * this VMA and its relocated range, which will now reside at [vma->vm_start -
> - * shift, vma->vm_end - shift).
> - *
> - * This function is almost certainly NOT what you want for anything other than
> - * early executable temporary stack relocation.
> - */
> -int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> -{
> -	/*
> -	 * The process proceeds as follows:
> -	 *
> -	 * 1) Use shift to calculate the new vma endpoints.
> -	 * 2) Extend vma to cover both the old and new ranges.  This ensures the
> -	 *    arguments passed to subsequent functions are consistent.
> -	 * 3) Move vma's page tables to the new range.
> -	 * 4) Free up any cleared pgd range.
> -	 * 5) Shrink the vma to cover only the new range.
> -	 */
> -
> -	struct mm_struct *mm = vma->vm_mm;
> -	unsigned long old_start = vma->vm_start;
> -	unsigned long old_end = vma->vm_end;
> -	unsigned long length = old_end - old_start;
> -	unsigned long new_start = old_start - shift;
> -	unsigned long new_end = old_end - shift;
> -	VMA_ITERATOR(vmi, mm, new_start);
> -	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
> -	struct vm_area_struct *next;
> -	struct mmu_gather tlb;
> -	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> -
> -	BUG_ON(new_start > new_end);
> -
> -	/*
> -	 * ensure there are no vmas between where we want to go
> -	 * and where we are
> -	 */
> -	if (vma != vma_next(&vmi))
> -		return -EFAULT;
> -
> -	vma_iter_prev_range(&vmi);
> -	/*
> -	 * cover the whole range: [new_start, old_end)
> -	 */
> -	vmg.middle = vma;
> -	if (vma_expand(&vmg))
> -		return -ENOMEM;
> -
> -	/*
> -	 * move the page tables downwards, on failure we rely on
> -	 * process cleanup to remove whatever mess we made.
> -	 */
> -	pmc.for_stack = true;
> -	if (length != move_page_tables(&pmc))
> -		return -ENOMEM;
> -
> -	tlb_gather_mmu(&tlb, mm);
> -	next = vma_next(&vmi);
> -	if (new_end > old_start) {
> -		/*
> -		 * when the old and new regions overlap clear from new_end.
> -		 */
> -		free_pgd_range(&tlb, new_end, old_end, new_end,
> -			next ? next->vm_start : USER_PGTABLES_CEILING);
> -	} else {
> -		/*
> -		 * otherwise, clean from old_start; this is done to not touch
> -		 * the address space in [new_end, old_start) some architectures
> -		 * have constraints on va-space that make this illegal (IA64) -
> -		 * for the others its just a little faster.
> -		 */
> -		free_pgd_range(&tlb, old_start, old_end, new_end,
> -			next ? next->vm_start : USER_PGTABLES_CEILING);
> -	}
> -	tlb_finish_mmu(&tlb);
> -
> -	vma_prev(&vmi);
> -	/* Shrink the vma to just the new range */
> -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> -}
> -
>  #ifdef CONFIG_MMU
>  /*
>   * Obtain a read lock on mm->mmap_lock, if the specified address is below the
> diff --git a/mm/vma.h b/mm/vma.h
> index 149926e8a6d1..1ce3e18f01b7 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -548,4 +548,9 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
>  
>  int __vm_munmap(unsigned long start, size_t len, bool unlock);
>  
> +/* vma_exec.h */
> +#ifdef CONFIG_MMU
> +int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> +#endif
> +
>  #endif	/* __MM_VMA_H */
> diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> new file mode 100644
> index 000000000000..6736ae37f748
> --- /dev/null
> +++ b/mm/vma_exec.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Functions explicitly implemented for exec functionality which however are
> + * explicitly VMA-only logic.
> + */
> +
> +#include "vma_internal.h"
> +#include "vma.h"
> +
> +/*
> + * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
> + * this VMA and its relocated range, which will now reside at [vma->vm_start -
> + * shift, vma->vm_end - shift).
> + *
> + * This function is almost certainly NOT what you want for anything other than
> + * early executable temporary stack relocation.
> + */
> +int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> +{
> +	/*
> +	 * The process proceeds as follows:
> +	 *
> +	 * 1) Use shift to calculate the new vma endpoints.
> +	 * 2) Extend vma to cover both the old and new ranges.  This ensures the
> +	 *    arguments passed to subsequent functions are consistent.
> +	 * 3) Move vma's page tables to the new range.
> +	 * 4) Free up any cleared pgd range.
> +	 * 5) Shrink the vma to cover only the new range.
> +	 */
> +
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long old_start = vma->vm_start;
> +	unsigned long old_end = vma->vm_end;
> +	unsigned long length = old_end - old_start;
> +	unsigned long new_start = old_start - shift;
> +	unsigned long new_end = old_end - shift;
> +	VMA_ITERATOR(vmi, mm, new_start);
> +	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
> +	struct vm_area_struct *next;
> +	struct mmu_gather tlb;
> +	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> +
> +	BUG_ON(new_start > new_end);
> +
> +	/*
> +	 * ensure there are no vmas between where we want to go
> +	 * and where we are
> +	 */
> +	if (vma != vma_next(&vmi))
> +		return -EFAULT;
> +
> +	vma_iter_prev_range(&vmi);
> +	/*
> +	 * cover the whole range: [new_start, old_end)
> +	 */
> +	vmg.middle = vma;
> +	if (vma_expand(&vmg))
> +		return -ENOMEM;
> +
> +	/*
> +	 * move the page tables downwards, on failure we rely on
> +	 * process cleanup to remove whatever mess we made.
> +	 */
> +	pmc.for_stack = true;
> +	if (length != move_page_tables(&pmc))
> +		return -ENOMEM;
> +
> +	tlb_gather_mmu(&tlb, mm);
> +	next = vma_next(&vmi);
> +	if (new_end > old_start) {
> +		/*
> +		 * when the old and new regions overlap clear from new_end.
> +		 */
> +		free_pgd_range(&tlb, new_end, old_end, new_end,
> +			next ? next->vm_start : USER_PGTABLES_CEILING);
> +	} else {
> +		/*
> +		 * otherwise, clean from old_start; this is done to not touch
> +		 * the address space in [new_end, old_start) some architectures
> +		 * have constraints on va-space that make this illegal (IA64) -
> +		 * for the others its just a little faster.
> +		 */
> +		free_pgd_range(&tlb, old_start, old_end, new_end,
> +			next ? next->vm_start : USER_PGTABLES_CEILING);
> +	}
> +	tlb_finish_mmu(&tlb);
> +
> +	vma_prev(&vmi);
> +	/* Shrink the vma to just the new range */
> +	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> +}
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index 860fd2311dcc..624040fcf193 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -9,7 +9,7 @@ include ../shared/shared.mk
>  OFILES = $(SHARED_OFILES) vma.o maple-shim.o
>  TARGETS = vma
>  
> -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
> +vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c ../../../mm/vma.h
>  
>  vma:	$(OFILES)
>  	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 7cfd6e31db10..5832ae5d797d 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -28,6 +28,7 @@ unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
>   * Directly import the VMA implementation here. Our vma_internal.h wrapper
>   * provides userland-equivalent functionality for everything vma.c uses.
>   */
> +#include "../../../mm/vma_exec.c"
>  #include "../../../mm/vma.c"
>  
>  const struct vm_operations_struct vma_dummy_vm_ops;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 572ab2cea763..0df19ca0000a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -421,6 +421,28 @@ struct vm_unmapped_area_info {
>  	unsigned long start_gap;
>  };
>  
> +struct pagetable_move_control {
> +	struct vm_area_struct *old; /* Source VMA. */
> +	struct vm_area_struct *new; /* Destination VMA. */
> +	unsigned long old_addr; /* Address from which the move begins. */
> +	unsigned long old_end; /* Exclusive address at which old range ends. */
> +	unsigned long new_addr; /* Address to move page tables to. */
> +	unsigned long len_in; /* Bytes to remap specified by user. */
> +
> +	bool need_rmap_locks; /* Do rmap locks need to be taken? */
> +	bool for_stack; /* Is this an early temp stack being moved? */
> +};
> +
> +#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
> +	struct pagetable_move_control name = {				\
> +		.old = old_,						\
> +		.new = new_,						\
> +		.old_addr = old_addr_,					\
> +		.old_end = (old_addr_) + (len_),			\
> +		.new_addr = new_addr_,					\
> +		.len_in = len_,						\
> +	}
> +
>  static inline void vma_iter_invalidate(struct vma_iterator *vmi)
>  {
>  	mas_pause(&vmi->mas);
> @@ -1240,4 +1262,22 @@ static inline int mapping_map_writable(struct address_space *mapping)
>  	return 0;
>  }
>  
> +static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)
> +{
> +	(void)pmc;
> +
> +	return 0;
> +}
> +
> +static inline void free_pgd_range(struct mmu_gather *tlb,
> +			unsigned long addr, unsigned long end,
> +			unsigned long floor, unsigned long ceiling)
> +{
> +	(void)tlb;
> +	(void)addr;
> +	(void)end;
> +	(void)floor;
> +	(void)ceiling;
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> -- 
> 2.49.0
> 

