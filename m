Return-Path: <linux-fsdevel+bounces-22932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B5923CD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D851C22125
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152CA15B97C;
	Tue,  2 Jul 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kjm28P0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A181DFD8;
	Tue,  2 Jul 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921003; cv=fail; b=ZGjnvEBwRY/E5opHDd8rc6j+GrT8b1emFDuqQZLjQUmeLGPPugoXvPVAe4go2veNsv3KGlfz4srz2HHrE5k/id/VzaYyIpP8pAeGM6WdpxxWuXHxZf1MmVyd53rH+XRhefzrMFoF58VLyLh8ygeeI7dOog/mHIbD2OlWMETPfhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921003; c=relaxed/simple;
	bh=ZPrrGPf4dTj5Sx2jhFugR5ElWYqD9+Bc5rMDfICSgYs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=n9AjsnZLTYDhnVEEHLbnmbqnUO+9SNpdntHl0/m2jYDWjsZBo3zq6ES/ArR/kxj3czFLjqCRSWTjQBHlIgDZvVwE1KnwGrGnmMD1/C7POY34JdBn29Ee7Z5FjUNHRaKJu+QQchaEQDKjQSHQH8czy4sBEWvP7ThD3hNZ1BJmyLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kjm28P0/; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkfebbH3ukpwfInBxvWHOZ4yaR4QiGsz5YD+TwdffuWtebT/6M/3jfUkRTf3KrsWdn5oeL9Twh25BqijaF9zF/TADK4zr3xpz1DKK+dYHWrjtYh4hHjURu+/CUTIP7lOr02DsC7SBHhimeffjFxmaZrLq+uWZ57oaHmJglC2fznTsddiDgZVccM8SmDKGpqa0Hw12QtrYiUUNjS02dQkQTiClqgxvDfwsYeZTeBPL9O7xZm1yo53qMIVbedbb/aR5moTtyDPwQ7DmKw7Ihek8AtaPfoqsQInT9CleW4WnsemEIKSZ+J7+PpbMTUSfxF/CNxf58Abzx6beRmvvK306g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1KbED5THrpirmsv1R7vn2AOb9iz7vv/cyzdABAaC4E=;
 b=ewxgLeKh7tdX5re09BmMSAIWNZ6OXHqvRUZrbtcpcFR46FCLspbkTeD2HJrBYQfBU2QDuSh5SaNpVAHUNuEPNpCwLcC8aJbCvjryZvBMX1zvsvZjqPi9/CvbqXJC7CsTVBQk9Zs0JnKk8XM4Mdv46yyBQafL2xRC1orNFY6M9dUj+erpQZl753tuYquv4zfuxeUeXEY2d0w/Y4GqJwWf4j/NYl2AORj2pm1UtmsNhMgPZmVWS927gWRBkOP+PCxUR32q8PnuUTZYgzsYZ4Xt+MzkeVc7sQMyveHCDjI70ZeOxEbJpHqBMuK1jWQgWMyLltRDJ7zLv+xqpAvgFAuE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1KbED5THrpirmsv1R7vn2AOb9iz7vv/cyzdABAaC4E=;
 b=Kjm28P0/bD+1TA70CQyFAyo9eTWiANdH3gjMnT0JYyt8Oy3N5dy6DE7svzvQf1cR5ToNboyeDAiDi/ol5u+VxE6MqwqOQnu4OKlv+gYvF1Rcj3PS5ICVws+9rq4BplBAqRO5t1h2wJ2gConrcMp/wJbXqevpVlTHSZVHcJbqaSTJGTrouDhSeWemv0B11kU3+uMZGIZiGEubwaXItCThJlQhdBlovjsJN9POsQ56EQwHBJavFSvf59op9l9M2WDrpSxuj8ne7I9h5goBIOZ1RC8stMKRAZsdkjo3WwsUH1FqarsgUVdCRVVAc6TCfk3/pMi3XKtEucgbEdndxm++Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.33; Tue, 2 Jul 2024 11:49:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 11:49:58 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>
 <cf572c69-a754-4d41-b9c4-7a079b25b3c3@redhat.com>
 <874j98gjfg.fsf@nvdebian.thelocal>
 <0b549ff0-b0b6-4fc8-aa6f-0d76157575b3@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 07/13] huge_memory: Allow mappings of PUD sized pages
Date: Tue, 02 Jul 2024 21:30:19 +1000
In-reply-to: <0b549ff0-b0b6-4fc8-aa6f-0d76157575b3@redhat.com>
Message-ID: <87wmm4f1y6.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0023.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::33) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8b46c4-7b4b-4533-0d42-08dc9a8d18ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8pGyRgVp07woggVV+SrTDqhScTw3FfUxxrtQFwCIusLZGYkJiGqUaBKGHUv?=
 =?us-ascii?Q?aNxg16rHMrY/EmfAjm+zygsQ8XDQD0MCbsKcP5P1klWGDE5jx9h6t0YYC8S5?=
 =?us-ascii?Q?u0s0LQC/pP3OPrOh1q3BUxU+H7VLPSUnNsvFDsyAeampY5nUljwVzHI+CyEP?=
 =?us-ascii?Q?rSZRRSSW1mbXe97xzpC+a5CtO+YygohKgvJ0MZI41YghlKngDIezu4sVjmGX?=
 =?us-ascii?Q?VI/B68my8Mn35VlblT6tnspe0Kep6cUrAVdUtYf0ko8UqfDxoQu9R/7UHzuY?=
 =?us-ascii?Q?8HJaHkiaea/EhaCmKwglfzEV2d392MdFz2G7zMqBPD986K7VjZKdiGp6uaMk?=
 =?us-ascii?Q?PWhqoqsmnUy3tbkzoqvVOzHX8VRYO8s+99RsFpmF0wkVIZBpE4xyJTUurSbn?=
 =?us-ascii?Q?x9UfrmJqxuPcYkKY7tt55z6zTk0D8S4cIhW47yB47vat6RAe1VJLRISQ3kVa?=
 =?us-ascii?Q?N71tKSfpTcvwmshFyzSJMSfwH7AVD4zO6MIYFRzG92cM5jWbGwP6eAmVRNIv?=
 =?us-ascii?Q?Azl9pTGMChFFMJljvpu9dMQdxrYORPJXYjvtdwU8W723s6GdFatmM1OqjzHA?=
 =?us-ascii?Q?wD0UVuAJ5w18P2WdBHXMkSXwf5baJ03iaJ+d7XEyUdS3Z4qJ5boApaGiLRSU?=
 =?us-ascii?Q?IiuP49q+u9rlQwQjgeNxjC/pq2DDNOfeUUHtxY5XkWC+4Hfk8BlAwncfhYDy?=
 =?us-ascii?Q?B4oLFHMoVkIfxPx+Y5Ak4DVx3fmvy1DOV+q4+sq7VZXDIDOIf/rnIrdQg/JN?=
 =?us-ascii?Q?7101zntU6UNBNVOe6m8ns1GnkgAyeET/nW9DkJ/1xHa1pRLtG27OycayUzs9?=
 =?us-ascii?Q?7DM40mTNVvua80GoBgehuI9zczHd6xRM7DSJ+xlMkV9D/1RXL8tzux4aMAei?=
 =?us-ascii?Q?EGguzTjy8zu2NTdoMpfXYJrDEIr+PBnwuF+IkWy+KbKAifMFA2tO7BFFzJbI?=
 =?us-ascii?Q?iwlJUxqkbW/Oa+YO3PXtjtDO9+4XV3Dg4nStVn/BFvzyTaMSRjhrar6UdOhy?=
 =?us-ascii?Q?+uiZXG2q+yLxfpjF2+mTfxOSW0Vw6wrmvfeU9uJzOR59HBZFiDaR4UGxCcfn?=
 =?us-ascii?Q?r5N9Cq8kO03qR3fMHzJMAPFVRuzGjrKDXgWWbEhnOleDC6l+ewWzVeeQCI/w?=
 =?us-ascii?Q?+o0gKBiT863wtfdQ2tnGJ3TihZcIyKOMc1XjXEl9uZX9U3fJtEf+ffrpaYHP?=
 =?us-ascii?Q?IWasghkt65X0f0cgXlrnQFKZG5aOqOcfEDzjHJ/bh0HQdgW+8xr1/ELgo+ZC?=
 =?us-ascii?Q?Kkb3ZspGWYYbpe5x74WJdxYB9Aa/caNC8gQ2+0A94OuyNCRbzCTzOC4OWdqG?=
 =?us-ascii?Q?yA4EjB3lmxx/sz3x/qYrVfnOsBk40OLZ7wiUMWkocC8Q4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B8E+kf1l7HbH1kvNBc0cvdbqepxxD0hAIq1yeSJhaSGlIxqzrji5SdQf70NV?=
 =?us-ascii?Q?rbfyhx+rpoSCyMz+pbFtRyHSXf5b9sDq8xn8HNciXvFZXd7kROGQ6ahfM2E+?=
 =?us-ascii?Q?0icI0HjRM5SgpK2uZtAQi2y6CKNYb/MgGJIKOR/QKY96ggKSDKk9W8+Svve4?=
 =?us-ascii?Q?zspd5jYuzWV/1vR144G4MObrPvMmgO4/Bd6gx8ptDbaPf76yH5bKdR2s9dwH?=
 =?us-ascii?Q?RtZSvbfUvMFeYfNSPUIgae6o+NfV8Z1tbdjVuX2Lex4vDGQVV03AtYOEv2YZ?=
 =?us-ascii?Q?59txyHNmYAWIKd42YwUxUdEDfn6KfjIP3iMfxSrqr+PnrqSgR+UdVVg9uxRh?=
 =?us-ascii?Q?6FgTGptmo9aG633SIRy3l/fHXW1WWVktdJLA9dpQSkRgKIc/837pAZ5e09M9?=
 =?us-ascii?Q?FKAS3W4KyHJyjbVei71Cfm9/AsIXzpAKDhXmHZczrtszWhmt/yR0t1CzMMCy?=
 =?us-ascii?Q?myyCgsdZtj0X52gn/1Ygszixduy39bjYeayVoHTBi4TlhzjcXmA9k5IB8voY?=
 =?us-ascii?Q?RMbwqtMxwvBMWEV2i/c4KWkY0BQBM+zNHUZR43xCA0iBBrsSNOUsm5cmmlNW?=
 =?us-ascii?Q?rMid8Hl/k1e4gt1QDeRWY9mvF7HrtZL9uyEAtGbzPXsbh8kKhhrmBzPdVFC/?=
 =?us-ascii?Q?xSlsPYcnPaXYMDo/lllCVSr4gE21kpoU+6qgBuIQoVZoJ5g6touQWG4+79wA?=
 =?us-ascii?Q?N3tINV3bGhcBKR2Rraf0FNCmRaPs/+wJNFyzTAvEaPXvOQ9ScaNgnH+QXAsk?=
 =?us-ascii?Q?6yYWRpciWRIeJitnbB31ltQ2KY01Q/DKOp0+E3t9VOjzLozppGjLghRONjWm?=
 =?us-ascii?Q?hix3SduGk6Y41J57SZ48hszGOlfcLlsHW4ADqDBP4dAj3Mp0H9l78MgY1Gmx?=
 =?us-ascii?Q?rAeUU1e9vToZ2kPKfjw3331UwkSG29w8bkTDpOCESeU2NQZOAeKoZtQeG60/?=
 =?us-ascii?Q?aqVY2wazYpMosOYtTudAi1Axg5cT8kKZwpZhP9gUqevkI8Ogs/uZ1RGQsMUD?=
 =?us-ascii?Q?yputUsJzfb6ddKldPA6df4IXyMsnnUTdBtonjQUAkPGnXu6YAZv8sQKCD2P1?=
 =?us-ascii?Q?7d7roMmmc3/DiybvTVI46knb8iUI4zs2kO8ngyyxdBIBCg0g6s7NwcyYag/f?=
 =?us-ascii?Q?9ZKrFhzFcJtg0iPG/OmNgOSU7HjVyCMDUHxsbla7arKadaV/fLSdNhnpxPKm?=
 =?us-ascii?Q?PIyko/zaZdNw9lN8r3K+SlqCcDXjjiSLfLHwdPfzZOiSQq5ZN96p18BKZQLJ?=
 =?us-ascii?Q?9a6P4DATw+woYXQmSQOay2T5BPtj6TO49L23M9kGM21ed/kXdkfOFe25HVig?=
 =?us-ascii?Q?S6F2riRQI1hJSCM6vjBzSal47Byi7OZFPc2lP3dI7MogrpzO5AW1M0BmAeR7?=
 =?us-ascii?Q?sJnQGkea8VkI5NunKUivKaiGJhVHLW37mJ4zK2Plzn6ha9m4lWuee8GjGSu2?=
 =?us-ascii?Q?GHx3wbeqpuUUFFhfBPb9EEKUOSVVxkuXtT8RMJ5l0qZhXptUz4DqCo2IEdlk?=
 =?us-ascii?Q?YbZZ82OFurF4U40zrv4UbZWISIBg554P5pREAxZ7bQSDVwP50CFwXP+M6c4h?=
 =?us-ascii?Q?LR8JcIdoT0j3f1T7z3jMv94bcG5YRhLHAYSAesRq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8b46c4-7b4b-4533-0d42-08dc9a8d18ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:49:58.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpZJa/uSPnJe45caaPQpmxR9Vu8NrJRJ3CCgnjHboiNI6OswmJlEXp3TXyqmzUGFFwwL73nKVlKIsm5TUbVKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388


David Hildenbrand <david@redhat.com> writes:

> On 02.07.24 12:19, Alistair Popple wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 27.06.24 02:54, Alistair Popple wrote:
>>>> Currently DAX folio/page reference counts are managed differently to
>>>> normal pages. To allow these to be managed the same as normal pages
>>>> introduce dax_insert_pfn_pud. This will map the entire PUD-sized folio
>>>> and take references as it would for a normally mapped page.
>>>> This is distinct from the current mechanism, vmf_insert_pfn_pud,
>>>> which
>>>> simply inserts a special devmap PUD entry into the page table without
>>>> holding a reference to the page for the mapping.
>>>
>>> Do we really have to involve mapcounts/rmap for daxfs pages at this
>>> point? Or is this only "to make it look more like other pages" ?
>> The aim of the series is make FS DAX and other ZONE_DEVICE pages
>> look
>> like other pages, at least with regards to the way they are refcounted.
>> At the moment they are not refcounted - instead their refcounts are
>> basically statically initialised to one and there are all these special
>> cases and functions requiring magic PTE bits (pXX_devmap) to do the
>> special DAX reference counting. This then adds some cruft to manage
>> pgmap references and to catch the 2->1 page refcount transition. All
>> this just goes away if we manage the page references the same as other
>> pages (and indeed we already manage DEVICE_PRIVATE and COHERENT pages
>> the same as normal pages).
>> So I think to make this work we at least need the mapcounts.
>> 
>
> We only really need the mapcounts if we intend to do something like
> folio_mapcount() == folio_ref_count() to detect unexpected folio
> references, and if we have to have things like folio_mapped()
> working. For now that was not required, that's why I am asking.

Oh I see, thanks for pointing that out. In that case I agree, we don't
need the mapcounts. As you say we don't currently need to detect
unexpect references for FS DAX and this series doesn't seek to introduce
any new behviour/features.

> Background also being that in a distant future folios will be
> decoupled more from other compound pages, and only folios (or "struct
> anon_folio" / "struct file_folio") would even have mapcounts.
>
> For example, most stuff we map (and refcount!) via vm_insert_page()
> really must stop involving mapcounts. These won't be "ordinary"
> mapcount-tracked folios in the future, they are simply some refcounted
> pages some ordinary driver allocated.

Ok, so for FS DAX we should take a reference on the folio for the
mapping but not a mapcount?

> For FS-DAX, if we'll be using the same "struct file_folio" approach as
> for ordinary pageache memory, then this is the right thing to do here.
>
>
>>> I'm asking this because:
>>>
>>> (A) We don't support mixing PUD+PMD mappings yet. I have plans to change
>>>      that in the future, but for now you can only map using a single PUD
>>>      or by PTEs. I suspect that's good enoug for now for dax fs?
>> Yep, that's all we support.
>> 
>>> (B) As long as we have subpage mapcounts, this prevents vmemmap
>>>      optimizations [1]. Is that only used for device-dax for now and are
>>>      there no plans to make use of that for fs-dax?
>> I don't have any plans to. This is purely focussed on refcounting
>> pages
>> "like normal" so we can get rid of all the DAX special casing.
>> 
>>> (C) We managed without so far :)
>> Indeed, although Christoph has asked repeatedly ([1], [2] and likely
>> others) that this gets fixed and I finally got sick of it coming up
>> everytime I need to touch something with ZONE_DEVICE pages :)
>> Also it removes the need for people to understand the special DAX
>> page
>> recounting scheme and ends up removing a bunch of cruft as a bonus:
>>   59 files changed, 485 insertions(+), 869 deletions(-)
>
> I'm not challenging the refcounting scheme. I'm purely asking about
> mapcount handling, which is something related but different.

Got it, thanks. I hadn't quite picked up on the mapcount vs. refcount
distinction you were asking about.

>> And that's before I clean up all the pgmap reference handling. It
>> also
>> removes the pXX_trans_huge and pXX_leaf distinction. So we managed, but
>> things could be better IMHO.
>> 
>
> Again, all nice things.
>
>>> Having that said, with folio->_large_mapcount things like
>>> folio_mapcount() are no longer terribly slow once we weould PTE-map a
>>> PUD-sized folio.
>>>
>>> Also, all ZONE_DEVICE pages should currently be marked PG_reserved,
>>> translating to "don't touch the memmap". I think we might want to
>>> tackle that first.
>
> Missed to add a pointer to [2].
>
>> Ok. I'm keen to get this series finished and I don't quite get the
>> connection here, what needs to change there?
>
> include/linux/page-flags.h
>
> "PG_reserved is set for special pages. The "struct page" of such a
> page should in general not be touched (e.g. set dirty) except by its
> owner. Pages marked as PG_reserved include:
>
> ...
>
> - Device memory (e.g. PMEM, DAX, HMM)
> "
>
> I think we already entered that domain with other ZONE_DEVICE pages
> being returned from vm_normal_folio(), unfortunately. But that really
> must be cleaned up for these pages to not look special anymore.
>
> Agreed that it likely is something that is not blocking this series.

Great. I'd like to see that cleaned up a little too or at least made
more understandable. The first time I looked at this it took a
suprising amount of time to figure out what constituted a "normal"
page so I'd be happy to help. This series does, in a small way, clean
that up by removing the pte_devmap special case.

