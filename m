Return-Path: <linux-fsdevel+bounces-63998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB0BD55FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6151218A30D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161872C0307;
	Mon, 13 Oct 2025 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Twshfs4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913F2BE638;
	Mon, 13 Oct 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375326; cv=fail; b=Sn+3l03Xr27uAAg/FjO8wS1BeEzy3MWw/F8XSwyX5f6MMS10TmVUNlANNlejR9jspEVJpTpbrBzbZW75WZo8KtdF/ymX91frTrcza5krDfpBtWnoiQ3SisRKfQPnHYoq9qzUzPBLzZgbTlLT0+hkWlHO4KP4DKz5a9UuiHtiuSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375326; c=relaxed/simple;
	bh=s8tx2OALM3vnV0XHmejIH6lGCfQc3kD1cm8aAID1D9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GeAd4YAIFerJZFyyV/iiIfa/V1k1iFzeJChCkez5JdgJDpJGDv/8Ey5aKhJh02fz5MsLXDSE8sfNdAjHdjEfN9cSzou0Vc6ZCgsXZbF22Z+BKARtJUtrA2W015p0ML32SRwXBt/GLtGeYGQcfskVHt9c3CLrD9gjyJO10AVTG70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Twshfs4e; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+UbBHE7grE9r8IbQRLWE1TUskK2ZTJy5ybjq5fwMRDyws/ZbJK6PFUT7T8tPnLlDfOUIhpO6SHgmZa4HWliSw6ZOCf1qslrLwiAv4b9xVcYjwQw1/t3VW4hNxz9x/B0LYioHUSGjjQJCY6h1uojjXj6Q2BDS1gawEF63hSKNr2N7ldX33Xn7N0qgQBOg2ze7fxkFUwCdTKh8Lezn0DPVw7zg1MLetJnvJPT3cuqDTZg75/CRx4COXrJQXyIb37qObBpzq2kO8g4OfhIV7L8pxjgatiM0aaWR/4igoSXxm6PUUZiFGFNjnMD8I7/pkFgE66RCflQM2YofRfaj/hzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEybL5wqSYdwBJSikoq7TQOmHOBJ3B3P3+QkFs0CbXM=;
 b=AWsjYaPh3Cjk2SjD7utk52nQr8tXiUDSOtOMGKybqbdZd3A1tJJDlZCp40YZB580GHJfG1EgZk0JfAYGokVKsAjtmEXUnfCGyqpyU1gTkjtt9FvHAahLHUd1RnQNduXdTW1dKoAHFwk9KmqTcAjcx30R2cgufOk+HcVMNG60To0HfAlzvf+ZGgDw9fAvm8bjUVqQ6Lb3iLPAr8/V4hTDJuEUhS92romkwqXngH2Clmj1SKFXSz8S5nm63hlyzzkSSn0fi2FmZaO5DC1o9+TWqCjiS98+TYafMSeVpt/8LUS1bf1UYFK0K8edwGmwBYnK/aRNC4uwzKEj39wziu7NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEybL5wqSYdwBJSikoq7TQOmHOBJ3B3P3+QkFs0CbXM=;
 b=Twshfs4ecXR5NZWetYzZ4BcBsqkgEITzGvOAVrzeqe9HNtG/+g70nk6cFQfXadM1qrZxDYdZv6v6RsZ5DW2lvu+nX8Dyff4RGThPENrcNqNZkaUCeMDjupJWsckbcMXIxCcVFTufwE+0wg/gfjc6IleGm/m4hIAlTPidPtUJak6fRcssDyAVZpdCnE5ZdnCTB2g2SxKxa0RdgvQ+BXYvzl0Med3HkCw6XWLMknGhxSsn8loZPNeB7Kbodor/LuVXke/6xkxWfL93h9zIL3QHwJf8YgHIwhp6TbWZ2Altc3OlGBZM+r+O1QzdSs/xAaFDfNWPGrcuQOtPhOTldOTmYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 17:08:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:08:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: kernel test robot <lkp@intel.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, oe-kbuild-all@lists.linux.dev,
 akpm@linux-foundation.org, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/memory-failure: improve large block size folio
 handling.
Date: Mon, 13 Oct 2025 13:08:39 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <CAB0F919-DB00-4599-A3BD-293E13063221@nvidia.com>
In-Reply-To: <202510111805.rg0AewVk-lkp@intel.com>
References: <20251010173906.3128789-3-ziy@nvidia.com>
 <202510111805.rg0AewVk-lkp@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:91::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df8fe2b-9f91-476e-cef1-08de0a7b28e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0Az85Di6KCk1f0AnXMEM6tVN2CCkeYwiKFvOjhJsTH+MfxCxC9++NNH4q7a?=
 =?us-ascii?Q?Pq08jOp4Y6J3u7qT9zCc4bl6Ovds2tx5MPdXTkAs6ESOHSHWpyPLf6P4E75K?=
 =?us-ascii?Q?K25oSc6I57splRBJweEtHy8T6DI5Ax2ksmIwBHT/zkacFZI8+gR7K+qIM2Pf?=
 =?us-ascii?Q?tI6msWcDepehgQ1GF8DIsloPo2I7MYKCQuz0UERikisPkhe02Udn4cjnVmnD?=
 =?us-ascii?Q?a4LTdGNovdJJLLvNHnC1DPaaK3Epuk5KUqQ+SPLguYFbLeLu4RWcqP0oLPLE?=
 =?us-ascii?Q?TvDp3R78JnioCt8MVuSIwI838dmlHz+HrFu91yPgQMt1/vwKnXSaxsVDJj+9?=
 =?us-ascii?Q?GnIpya9K5AKGNNHbgnDH+Ozo/TLbonAE5oJ9NcvtOiA74Lwr4xsua1Sm08oi?=
 =?us-ascii?Q?xz5gMCB1yAWqA+pyymJ9lLypCYlU3H/rhHcYVNWuGwhGgg8qSUoAUX+irLWi?=
 =?us-ascii?Q?0Jbza0JRpO1gNKrS5UOOM+bKsDNbZHpVIe8Wp0WUBqpCJQlKPsjHcPM0enBK?=
 =?us-ascii?Q?MX88oVgkj0m7GPIuOrsSDRB3p3Cb0iTRXx9FHSnwuRDMZqtPN8zf1mam8m0M?=
 =?us-ascii?Q?+wdiztS+WomOZ4rwBQG8iJXcOUaO/Aj0J7YbNn8zSShmGIzJhjpfPVCSvwfR?=
 =?us-ascii?Q?8MljfdkKzJidAhOKcFxBqkcWyYsLMHjglyoIE09XyOU+rWINIeQP6jGNW5Ay?=
 =?us-ascii?Q?Jd8KUH7RaBEahcRa9A9a+2mXMhPZZtT/lsJ/dcDuX4Mxi0LwpP+Ar9TLn1yh?=
 =?us-ascii?Q?o4jT4qZk886hUbysBLzMFMW0QHNppht1/GQOHO23P/oXTGE03fB9cFe30f9Y?=
 =?us-ascii?Q?LNxLays2evIB1yn35cq7LSSIXll1jU/FRNKa1wgL5pxah4Tv6TXE2/ioXvsc?=
 =?us-ascii?Q?waDZN6uSbJewlAC1K8vc3D2smg8p1mliPiWP7mXvqzY48pmHrvNOUSQFvdVP?=
 =?us-ascii?Q?3cFu0vy0z2zqNWCH41rhTNVm7EqbP3rCUO0kpR0bsdroi4stZoZ4TMxoURGf?=
 =?us-ascii?Q?QtJ8S7aJf+LZn75VbNAlbHKt9Hxj3FbQBMeIhQ0fpCXnrZIxkqegM8+pdFcv?=
 =?us-ascii?Q?WnVcNVZ/yG/iclGVd/EQzoE9QYbFHCxRWxutu79e57xY6RiCCzN0gGORjsB8?=
 =?us-ascii?Q?/CKrkHkJNbbEHHa2UfgZq69VmRGQQLacTQD5py2yfF9iBWHfe6TJXJu1hHCX?=
 =?us-ascii?Q?u4CWxG3iNS7dcThOlkQ8AxCpICKee6Ja00neR14Dnvd8Yaow24ZPsdugk7BW?=
 =?us-ascii?Q?p/wgqFNKBn4W8S4Yk4puQz8GDSWwC+LbbRFA1idP6STUlCwnbV/mG5RpKxcL?=
 =?us-ascii?Q?HNy6YqsgO5XGwT7JKDB31dsQLicqZWPjW0ctirmp5vWaJDfCDRbyzUoWBsDd?=
 =?us-ascii?Q?okRlNVeoi6XAKy9D5GW6wBH1ebA1X12rsisN7PumJnfcNVFiSAATCTQ6P7WZ?=
 =?us-ascii?Q?4btA/wu+Kd+gLENNUEQBBX1CNVZszI9NccWJt9sX4kNswsRkg8Rn6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uoKd1syMVR1CNGg3zpAS5GPxOIEASx+J7O8/qKlQje5DuurvUOqra6JALNlo?=
 =?us-ascii?Q?aF4x4b84cRQ9R5YIJ1tgmWm4XSYvqJsvJoE5J3i+S4QOapLieOn1ivuqqH36?=
 =?us-ascii?Q?e1sFpGV8HTU4Eh7BC2OuMwMVQhgwTJvXIqLE/lRIpzgR+M0H+0agSIbZWrq1?=
 =?us-ascii?Q?ADC/RNWaI2vDHzjU54LpcXi9Li1EwUaeX8tfY2+qJJWEMFx20Ok8cSdjY2oR?=
 =?us-ascii?Q?7jiXYNhI1Asu7uXFqmN0YASxsJB3hXHvqJTRe9YSVut/r6HU3Gm4FlFBStGi?=
 =?us-ascii?Q?ICHB1NPdB3QlVAx/gR7h6e2xpeEKPyBCuYN6vR7UCYr8i4kMUHnktyicBPtn?=
 =?us-ascii?Q?RK4dzpY75/Gs5xmG8ZEoU/emGJQ2w2f3yC8bQsTIWApEnxeMYvkwoUjzc/X8?=
 =?us-ascii?Q?ITejE1kBDjuYaTfvgdJgm6bCQhsBXwlB82tt5eMC8IR4jFVXIWb9/IED20qx?=
 =?us-ascii?Q?VCPzyCqgJYc8BcA+iiMle5phbRZIiri9yu2ymrj4fz6W5lonjIyC2+afluO8?=
 =?us-ascii?Q?0yKVxh8P1/1btqwkcMBKfnRJ4hl1xXLqG2r5DgoDdU/nSV6RsGwjcf83lWoz?=
 =?us-ascii?Q?GNE1ND0XV5d2C/QSYG0dNAqwhlZVATT429dw3r+oPZ+oiMPQrqxZvLJrQg4v?=
 =?us-ascii?Q?AoKh1H3YTl5w3jeGyBQ8DeqFIE/ylEqL7tgMTNEdKwCIG5bymZCZcG1Wwqyz?=
 =?us-ascii?Q?vhRwE/fEdb6VlW4ovO9YNd+rHX+IufZyPLkViqsYND0GkSZ/tzSU+/m30EOg?=
 =?us-ascii?Q?4R+1Le8B2NmIUKXMR9tnBG1yGaZizxtLuW6BPFkm5fm6bG8V/Xd11YjNcE86?=
 =?us-ascii?Q?2bjS5Xdh1ULoc5eMtRX/xeMFxSIUNWIDtdcerI/SAyLOZYe7K+XJRNgHx0Yq?=
 =?us-ascii?Q?84ORxK/rdVCI/TYvjcikMz5CTNppYPZQX9nJeaRi8SgREFYZwBPg+Kh5g22g?=
 =?us-ascii?Q?m/1pWh0ekSLGDfKf28HacIYCRIyXYt9+IYgGuDxPr/zED3fJeNv5NE7TTGqc?=
 =?us-ascii?Q?ywWAnsC+HaPV9zuJFXJ5ZHDoTUYpJ4QL2ODowTS7kZSi2v2p7s/+094u/tgf?=
 =?us-ascii?Q?mszhxHztjRnP35bqekhR+HOm1cxfPU4QMumU7KaPYtQIIy2Iv29PH+WEwsy+?=
 =?us-ascii?Q?6OOLThQ07TIPe79BYhN6QwM2GXZ8Ic/3UwPu5SKaI7+V4CofnWaUbeIq0gy6?=
 =?us-ascii?Q?yly1WJA6QHaf0ZRn509MXQRFQjhTrRG2t6rT6b5sB7GvwaUhaqOw8CWj/pHD?=
 =?us-ascii?Q?1VXfUXVNOclldNSnHjMSqIVnmyA92fEbhjpqfjNUUd+j8wMjn6p6X9gidVGg?=
 =?us-ascii?Q?aTcDrHMI2C6n8Q3nIApp35hedFOjeGFfKdfY22HE15pt1eibIIow1QPQPprq?=
 =?us-ascii?Q?xseW64w+jNm8fqFWZzOJ4fT5MgGeg2weoRH2llA3T/lxK3JqK6gzpo1Axgrm?=
 =?us-ascii?Q?g07jU0JeBbrmSL/zACvxR8Y6lvt3oZq+BkEkOv0PTz6NRfvYOGlq32wJfCLb?=
 =?us-ascii?Q?0Idh63yqu2JAZpyvp96oZ6SnMvRUeKajBZbrGlUtyp98usvR7RdVDKW40pzt?=
 =?us-ascii?Q?gPnYiKbAC7+F4QfuYVmVVUfKOkTs/AQly8Yvdjox?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df8fe2b-9f91-476e-cef1-08de0a7b28e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:08:41.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mj4E/kZTtimL9iuFEPIU7qGnpVgCqT34jEOkhcuy2Ae+UGmY6kSeVzNjSAm0mzYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

On 11 Oct 2025, at 6:23, kernel test robot wrote:

> Hi Zi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.17 next-20251010]
> [cannot apply to akpm-mm/mm-everything]
> [If your patch is applied to the wrong git tree, kindly drop us a note.=

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-huge_m=
emory-do-not-change-split_huge_page-target-order-silently/20251011-014145=

> base:   linus/master
> patch link:    https://lore.kernel.org/r/20251010173906.3128789-3-ziy%4=
0nvidia.com
> patch subject: [PATCH 2/2] mm/memory-failure: improve large block size =
folio handling.
> config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20=
251011/202510111805.rg0AewVk-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20251011/202510111805.rg0AewVk-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510111805.rg0AewVk-l=
kp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    mm/memory-failure.c: In function 'memory_failure':
>>> mm/memory-failure.c:2278:33: error: implicit declaration of function =
'min_order_for_split' [-Wimplicit-function-declaration]
>     2278 |                 int new_order =3D min_order_for_split(folio)=
;
>          |                                 ^~~~~~~~~~~~~~~~~~~
>

min_order_for_split() is missing in the !CONFIG_TRANSPARENT_HUGEPAGE case=
=2E Will add one
to get rid of this error.

Thanks.


--
Best Regards,
Yan, Zi

