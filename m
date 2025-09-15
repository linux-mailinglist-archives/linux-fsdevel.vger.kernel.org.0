Return-Path: <linux-fsdevel+bounces-61395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0AB57C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E389A189E792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F2B30EF87;
	Mon, 15 Sep 2025 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVqFp5y3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF172F99B5;
	Mon, 15 Sep 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941911; cv=fail; b=I6LrneJcsE4WHiV2kiOCjAVqyYVg1hwKqY+60ded18Es9zdBlFAfG23r1L6XNdg9Al3CJijm4vHAlkNw56oXRS1NBJ6sdIEga4law7mPjhJvjwDg/ZoFQkcigufuADKK/n+ZkiR+zQyhOfHyrFkcWdGSAQh8CcG8L5F1WLmlYJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941911; c=relaxed/simple;
	bh=jWvA/LvaQELPd/VFGW1LI7hmmVVa8xb9XI2Pg8jfni4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dXxxOSv94JpV0YHhAdX6MVivFMYdjiCHVwWMokL4Way3Iu1LMeaSvbUSpBs2pKQjaVJZVSovJakdcPuD0uXRZ4FfBFJZ5lHP/XSiU7wlqCi12U6jcLpxnspynIBtdrqAxewrMCnd55EKoGn+9oqcy+5c4YHqKv6IKNmQjRwdiK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVqFp5y3; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEkukaV9dWdYlGYACJfwPUv8aT8rf9VzkipmE6XrXnJrW2foTRsZ6VjQeascmjZddMglRpESn/B7udLukfAkJk7MEECWPVBNz18vhYrKnouQKM6Q+BV+Eo+cbKjUgzMOutlJLzQke2ncwDCdtIHNFwTyZE18gAR+/EgAJJwR/sJpwKvgQ9bzDPCoPGpewNDNNlaKUgF8DpkW5SSYpfSnbzrRA8xeY8TSS4vu8I4SI2FpvMsE3AvHSEHMNHxT+PAIy34mAwp522nQMlRzb15jv6fZ3qMP5sn3pZuPUVuyLWJh+UF2re/YHP8Xz7ewTB5lSDWrR7krPO6BjQHKYc2LeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5FAocx9qzl2nBgyJDZFuTLoX3Jt1ZtCO1BToWqTd6I=;
 b=BCoGEyOr08OElk1yUVia1tSuMkXzZDWGuhX0HRuvyofSEbspXMPuKDEeixlmNNNHNEC5UM6ZVj1zboyn5XmO8n//yLy5MWB9+ekcZQ2KRR8Hi4ACBrdVGAyDUTvr8AMdo2rHF4a+S6udWAF2UtssMgnylAKf4a4X04T8U2Q/TZ0vv/VRtAQ19b9cM8atFAOR6oc3kwiB4rW1lMK1mrUH18vKv5DO6+H7Rviw8ohqr0jxX9A3mLu2UtKINdAuQqDLSIaa8lUxoZtZGbpoUW8faKEDLiy6yk+3dfXQaEN/zEVx0GKXNp8+kBljaL+PKTmlhuHmy+pG5tvzHckKYC1kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5FAocx9qzl2nBgyJDZFuTLoX3Jt1ZtCO1BToWqTd6I=;
 b=XVqFp5y3JK52SycRSgkg7BeZKyEXS0/zoIGXUo1lTUVeWyTaTJveWzmrqdS7V+/UP70GgnOiUEFBA+NCRpn7Jln1Fj0a0PevJmSysciinPSlcEyEdE2r70YUkLsAmhOUdUONXnrZhKbdTjLlWZvFpYZcet0fluZeTmQxfDLD2Wyb5Ki0ARxxMldXTdqbt0UG2UDvP74DFxpqO/JxLgz3cZABvp+UrPe64MChNBOaOml/cK95dQZGddogwc8AzjnjmqXCHXXImWBchUtKGtO/ssam7GIa/MQWPaV/zwGmSL9XJcZk0Ymn/8NtIUyKO1ByWpg47BemtzJFZ7GhmSbroQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:11:45 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:11:44 +0000
Date: Mon, 15 Sep 2025 10:11:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	ntfs3@lists.linux.dev, kexec@lists.infradead.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <20250915131142.GI1024672@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121112.GC1024672@nvidia.com>
 <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
 <20250915124259.GF1024672@nvidia.com>
 <5be340e8-353a-4cde-8770-136a515f326a@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be340e8-353a-4cde-8770-136a515f326a@lucifer.local>
X-ClientProxiedBy: YT3PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::21) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 708710a6-b90b-45a9-c956-08ddf4596b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9koqRD9AzRR6S4AySeWb6Akwl+RuPa/25iCSfjk0Dv0k7EkFp6Vjc0BNoDxA?=
 =?us-ascii?Q?U1CWd4XiPlWHy36pV7Nth97fO+5Tylq3uNWkjk6CyRSCJlrzWIxHYCxG5pKw?=
 =?us-ascii?Q?VZ4I2MDma5rcfpJFO3148A39jX9oMqFt0+QHOOvSxLYBaXrezXP5ceYJe2qt?=
 =?us-ascii?Q?jZm96u5ziCAZY/eRzPzDuY8ih1Qa0Tt9FyfaEhoR89sdMK3OnONu8QzT86Hq?=
 =?us-ascii?Q?PuzvghxP3lAaO/YtSLTRJ2haXC8fXk5TxbT/K5g787LU23eGy1zECY3mx0VR?=
 =?us-ascii?Q?7tYGvAdrwf2CKj5KNlJ2aJkUEh4S6uF8EE7fyrrEwDMBJhITnCRwD+qhtuYP?=
 =?us-ascii?Q?QloLbgZw1G4/OcY2hln9dbWwuaERCyqjlxq+eKlwUHAL1XmETumaTwaY+TZ1?=
 =?us-ascii?Q?j2VgVuopv+IZKKce2NQfS3GuS24tuVOlLnDl5t9jJhQeVUM/URSEPw0gQAoz?=
 =?us-ascii?Q?/WEsIrx38EvMKo4FE0eXiXd6zKlqbjKVvS68VKewjTOPjUFT+gb2O7v388jv?=
 =?us-ascii?Q?AV8PWUpZg1ULcHn2z30MBszoUehhZapDHHX67C0RZUViACLqOkTRYh/Po6A6?=
 =?us-ascii?Q?Hh45mrQOzCCkEMuAacRobfe7EldcOSdv6SE1vdqnsl9zAfRJM0jv8r828/LE?=
 =?us-ascii?Q?Afn1eyEVlGPe/Dph2kzxDUI3mhZpfNL8J6kAtDnuIrornajsYlw4ZDIIPcud?=
 =?us-ascii?Q?4HBzsB6N1AiZN4Ga6uplweokNIuHMp5q1NXtH2sZfZtw62xnhl0+8USNkDoL?=
 =?us-ascii?Q?v6i+rPeNBzoPYP4QnuEFtWM43DMTEeSUUp8dU/C8qkqY1dKps2jMiCH5O8LJ?=
 =?us-ascii?Q?g4fOvZGk8PkLTjhnSH8lboWpdS4Ug71kneICvny1M3Wepo989ztGECJauqRf?=
 =?us-ascii?Q?+f1Db8dN/zpR9W42GbY5+BrMlNH2SXHfRJu16jyabzI11MD6S53NyNAZ/BRk?=
 =?us-ascii?Q?aQoTk+ZH+zzkKtTf9pjLtqZzEVh7QwccuxG8U3oAbguVFlYH2o4GkQFWaCmy?=
 =?us-ascii?Q?JuR5ONeimFcWR78YeGbMY5w5gFVBp5NaNg2T7TYg5QOiuNUAwgLzf5hCXrbP?=
 =?us-ascii?Q?X4mxlVqMKRwFm0itxP9irJ6hXBCL2U1OJuL4d6U4ucMC6eM9g+vKQTTXlaO8?=
 =?us-ascii?Q?nudC+eelK/fsWNtYMGSwxAhWe9+JIYiB6+MfXS3D1G+c3hJqEUzKlOwIs2LU?=
 =?us-ascii?Q?/nKhL+yDNrwxX2smulREO59TOLoP0nUl0nKxVK69ziWVxbKHPMP4ZtpA25/r?=
 =?us-ascii?Q?8bL0xVwF75oSklpF8gDMx1yDg4NiDxAM8k1N+WhkBSnx/9ZymOKLWbcBbvBQ?=
 =?us-ascii?Q?aQOfXh6Qy4jjOY9NGZL/5hM4wgzZGbvPZZVBTfxPJVHuC+L10NSt0pRk5aPk?=
 =?us-ascii?Q?ZqWmHnadIXic6erzxo9BcUvZ/E31oPFNpy+e32oiHt0C6pUqRipFytOoezR7?=
 =?us-ascii?Q?9gR55hE5PQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ME4HzCajAOXx0ZX7EyyLd5RHfF8oqX42T6cE2R7BMue9xRIOafc8iNCrxNjV?=
 =?us-ascii?Q?5vG5GbDm7dFO5GdrqIZ8unRvRY7YDGMkxAU0Fe/fABjx3mnvtwnamv2hm/G/?=
 =?us-ascii?Q?2fEyQpA8kPLbUid+0vLjWUnfkThWQ36NEt+RwV9VKvEXi42oRb4zvWGzyyqW?=
 =?us-ascii?Q?Gg618VFQhfwRvqlHailHOTDJsOiqwzSoCQHPoU7umd75mQIARaiRJMkYvKLx?=
 =?us-ascii?Q?oV2+jxkDQ/QWopg5Jlx3NoB6AIhodY1+QIhVyTeK6PzN/jvtwxMWeAjJGrJO?=
 =?us-ascii?Q?5JiBlGhy8TQAVvc0JX5JUNUBij4WwFAs6KlESOBDf5HBaqXqTSkD1ND5HTaC?=
 =?us-ascii?Q?jdbMlPfl2r9SQIV5dZrs3BlTV+TpFhTTquEAWoOTBJnDZd/3t2a6ytFA2Sz2?=
 =?us-ascii?Q?3EJUx/7/SW24xB2V0VyxpGoOnwyOZbOOZpHsJ5It4IPxv3OM2Uqr2kwwVJlr?=
 =?us-ascii?Q?KjxTjGsKgyknvSoATBpyiKTB0wFGVmketL1pg1IsWojwKZcG/U3r9IJtFgOQ?=
 =?us-ascii?Q?8tyyIGAOFcnA92nSzbC3xG6Kr/waqbAlr8y2NE+tnUjZq9HveP+yRYN7xTyM?=
 =?us-ascii?Q?7hahnaDnnoA0TCuoRCjfqrEK+Bydc/VuGgEesIAKycMBgiIsnucbxDDZXjmu?=
 =?us-ascii?Q?Rxj1Wyiu60WBG8louC1OuW6AcT3ak+qcrsX0dpMT+enArsZ3/tIRUoBqzz1D?=
 =?us-ascii?Q?XWjG78BWsUdIBzsjTjTgLrXIl8squMRxaQlU/BPX+9YPtuKk9yzAUsfPP69Y?=
 =?us-ascii?Q?gbmKgEow+9EZvtGoMnvpblmVApl4i2dbozUD5w99iAmBm+glxBw3b0tlIVER?=
 =?us-ascii?Q?/bmTEFXIE8yAebQdU+Y8+ztco30BF/JT/9NkYZgk5lfLh+5mGpIPan9j60pu?=
 =?us-ascii?Q?C9G4d+knPGgiPWcetO9iwg87BR7kigHY3gex0vTcqogkGSeoaM56RzAnvnHp?=
 =?us-ascii?Q?Km/FQL6evbO7hJTCEXJId08z5uaN27UxHUMNTKEjcTCwX70EgiTAOcMnSz/I?=
 =?us-ascii?Q?5RAkl451cTU70Xz52NynWYXnA65rVl+vEiOTOYpHjKuS4UChFKNJFujeDUU6?=
 =?us-ascii?Q?i6WIhy7ETMRvjGLBAyaCfW+GW0K2knE1QFhV92hPdbngL+9SZ5g7fdG5AJ6q?=
 =?us-ascii?Q?OX9m1nZEJMC/vIvqkCzR0jKYqM2Fqak0MWwUoMjjJgcMn0yCjicYcm1XtwU0?=
 =?us-ascii?Q?9grk8VGEN/kann/hs0SofUWWUE5VYe6BFQfIkHm5KUwMzs+DOdcAqoOHWxCa?=
 =?us-ascii?Q?KV3iayOvehvNDBkU7XBmDUatXta0PGBkzk8SYik8RRaDfGKJT/A0uZgUxv79?=
 =?us-ascii?Q?Y9jlq8anD+AQSWpxFyuoVAgezF1wQWJjt3bEZTdWsbtw9i51ptj5s1SGxWTT?=
 =?us-ascii?Q?UxcNoHWlTMlSw6XhbV+haw1cslwRHEG68XDtiHSeOjZPT+BWMbWxvHkz26yt?=
 =?us-ascii?Q?J4Q145rgwHhBLog8ff3t1fxXuyowaAg9P4xWkpHwZ+f3Vqof3UX1hEF5lyzQ?=
 =?us-ascii?Q?iUkqLvMAtIgEmLNSuiT5KCgUuKdKcMZst9a6Iz2dIwwC8X/CGdVm+jSoVn1O?=
 =?us-ascii?Q?khAM5W4GBbSyJUQLIfU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708710a6-b90b-45a9-c956-08ddf4596b13
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:11:44.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9ReDV4PkYt20kbwYORhZwWuwB0tMw+3sd/Gj6EsFeDp+trQP4jV0XV5RXaaqGYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

On Mon, Sep 15, 2025 at 01:54:05PM +0100, Lorenzo Stoakes wrote:
> > Just mark the functions as manipulating the action using the 'action'
> > in the fuction name.
> 
> Because now sub-callers that partially map using one method and partially map
> using another now need to have a desc too that they have to 'just know' which
> fields to update or artificially set up.

Huh? There is only on desc->action, how can you have more than one
action with this scheme?

One action is the right thing anyhow, we can't meaningfully mix
different action types in the same VMA. That's nonsense.

You may need more flexible ways to get the address lists down the road
because not every driver will be contiguous, but that should still be
one action.

> The vmcore case does something like this.

vmcore is a true MIXEDMAP, it isn't doing two actions. These mixedmap
helpers just aren't good for what mixedmap needs.. Mixed map need a
list of physical pfns with a bit indicating if they are "special" or
not. If you do it with a callback or a kmalloc allocation it doesn't
matter.

vmcore would then populate that list with its mixture of special and
non-sepcial memory and do a single mixedmem action.

I think this series should drop the mixedmem stuff, it is the most
complicated action type. A vmalloc_user action is better for kcov.

And maybe that is just a comment overall. This would be nicer if each
series focused on adding one action with a three-four mmap users
converted to use it as an example case.

Eg there are not that many places calling vmalloc_user(), a single
series could convert alot of them.

If you did it this way we'd discover that there are already
helpers for vmalloc_user():

	return remap_vmalloc_range(vma, mdev_state->memblk, 0);

And kcov looks buggy to not be using it already. The above gets the
VMA type right and doesn't force mixedmap :)

Then the series goals are a bit better we can actually fully convert
and remove things like remap_vmalloc_range() in single series. That
looks feasible to me.

Jason

