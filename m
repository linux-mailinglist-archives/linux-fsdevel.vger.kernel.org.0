Return-Path: <linux-fsdevel+bounces-56258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9323B1510F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502C87AB8BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21309223335;
	Tue, 29 Jul 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YSuDEWe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5631CAA65;
	Tue, 29 Jul 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805705; cv=fail; b=Zt5U4dXI1xccdL3fqRsmZ5lYu6G4+kmvcdHK4SQ829p529g3PkW4397RryAsjFuBAomjte69KMpgUYN5AqRur6tPtLWucr+6/ZXs05enGEO0dHQxsN5efeiG3JexWTZ4Ibt6LN71XHiaVAGRPYEgYfqjUC6CHxvUbGDBy1l9Kq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805705; c=relaxed/simple;
	bh=NltHIJ57Mtt919IYlZqBJssafrQe+e2+Z8MsuUSjQa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZB0yixP2q0+9jJFxQbNuoObI0Qo/iXJgo1xgbqrP4VkVSO2f7LEdZBDsnuU2Ji7Jfr+Ec1cyTlY2034UWnRCH7GldVLgt06BwYc332vSkqZNYFUeWWKnaXaCdH3tW+ZaTRkE8LKfv/6e8ydoQuKnkbW2Th2kF6ZO6yAj7f15PlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YSuDEWe9; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4GfMfOGahqgjcilcD0nRseVdxVhGfIAAiSEEThcdCfY5XyQNM4MsT34B5ceHOXOGLybessNTn6eKYnbE0Ubsp/GzKx1nfiXCYHKi/9Au3IkWmmQTzmY6L2oohjUrU6+BZFfBobgQufFJF0rlD7NxuXMr9l+PJN2DGFlnts/oR+opZ5Y1bXkqg0ZrPXobUWEcoszAQNbDBoWmxsyyPOtYstvxMdmPDAb3MCiIj7UgtAmbSAvD/jsVtpPZnumwmJ37Ph1XWMytr7PjgzxSZml9uMnFQkSXFPphRDqpbVoJLSyPAdlhe7WGSWscefkspxMI6hwQam4KHnHbT3pk+swIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9qKqHZDJcJVfiAK/2/YOt6paMHG9ktFbefyUqugiPw=;
 b=PbXtSowIy/DwvxRue2Ftm8+twPNrtSnj7Bw7/PUpovvZZU+s0hwvw2ivlsXexah9dIMgqaziad5ibNvktENGOGBHbIoiXgADcunsMi8h8R18kVbsTSahY8X0uUyQn84lOQQiMDSEUuV5/ja1xEO4YwbXlSiAReZdzUh8C55QJpUhprc4flkpH/VJtG2ZwggoktHwl3848jYoi0eZ+wEKfVmyYRlImejsICF01rp157NmS21PlUlM8FgDeK1gzdWan+ZGQNPXhULtMycgloCIf4t/Uw466VLLCnN5j8hLGBKXuDDpYNWzBnK5Y4pYdJBAKfuVYb3LXPLMVa5H8EddKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9qKqHZDJcJVfiAK/2/YOt6paMHG9ktFbefyUqugiPw=;
 b=YSuDEWe97U5AoWgTJWcpuLJNyhmwZ5TLIG5om5ve4tyv9siAThtZYXO4CArdqqidRzyU3Zq+rGSd13gdDVkV2Bfu2GAYpf5/Ad9pQiAv/rKFMTkAdPFb+Ksx6N4edSqhvYSSyBOTUe103dTkk57jea5b6d4OHflqaeE9SdiDKhUwDI/6361uAD0egz/0KDu4xRbRAm+XVLmxnupwmREEJVf+e4eKcNUuOxmih8tVNK7Ekq2gM1Rkc7jYl6w0pOtNAG1BFBTBAmlYnVkLDC6Ea5hjpUWQSf1A12Nz28ngvkDEW61yvelahdah401yc6s4yTU9F4ZW+sY7mCJW/6uZzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 16:14:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 16:14:52 +0000
Date: Tue, 29 Jul 2025 13:14:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
Message-ID: <20250729161450.GM36037@nvidia.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144649.1696299-32-pasha.tatashin@soleen.com>
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3b6d90-8227-43e7-86c1-08ddcebb0c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q43NiE3Aw2Yj7gBJIFDF4Uehm6VahR0Gtri0zmsBNXr5Ydqrt/GULOPKhye+?=
 =?us-ascii?Q?8D96xd/oLd4QRpKKbYJZwU/UtkPL/n1m2eBwq9SBLNkXKVnODP3U9S746nVz?=
 =?us-ascii?Q?IEqZEbFlKKCJfAYKuL4Gn/LDVeuqsENZNnCGgmZCydh6b61QneuO3PSclKiP?=
 =?us-ascii?Q?lJHXVh6iixEncqTcTUqpkY4aRx4z08yGxzmSFbDIiGLTjdNpDPOw5xftwIyA?=
 =?us-ascii?Q?ayiHrZqfI8ho9vKFUJDk93Ne/EbhQ0xEXjfRbcPOO/nKjFoVjY6pIhPo0DKs?=
 =?us-ascii?Q?j4+JzcTJP8a6Paj9CBCcO47AvvFqzQ20hVNtY0NfKqEHumLznTORKdwIDcSS?=
 =?us-ascii?Q?HVvJeK3j7kfDSsauQyV2mNnAGE1lcSD3Wt9iE8hcVlIA2nWYAOvmKcD3cJUR?=
 =?us-ascii?Q?dBuzGndLSc4vqqzlJNwzEQnVRXA/Ol158Q23wR2+VBEkVcQGnDDb2JcXLAP+?=
 =?us-ascii?Q?tltFoz7VX4ppe1yExp4LYIIKcvHc+W46w4b/JITYCHGXMk+r9k1jjdKOnOTV?=
 =?us-ascii?Q?IlfmetS6BE95OzGYeSrTkcS54QHvlcSkFsCM5MYo1rcEXcZ3FRwJS/0+LVt9?=
 =?us-ascii?Q?KkZ8SDsJAhenOstk10QNbjpgvT6yko55/1QiJfcDp2iN9gx0bYqsj4XmOyKf?=
 =?us-ascii?Q?EhJWWn4HLoikkX0JrWyBBeExwoCVyJSnfUSyL7UjnnFfLPiO1KgtjyOtIBJH?=
 =?us-ascii?Q?TxOpvCiXcAkkC2gpMQioY2JVaToQS2iqJcRRD6fTCRY3s2FAc9+eCAoSZU4T?=
 =?us-ascii?Q?uPl+LOIYKQFmm9nQBkjbPvSA8SibLAmS/kF37SXJgeONDu1cvjf9EqQtxfRr?=
 =?us-ascii?Q?FgZduLIidIh4EjThfcVuj3z7vlXZmENXxcBzi+jjHufiV7NrAe1zgPLYyPEM?=
 =?us-ascii?Q?AKSUJAvwGhetsgC4INF00+IGrRAmAcjh3rWSEfM4kUbsjPwiix0fsAKcs5x+?=
 =?us-ascii?Q?e3GHIOO5y6cIiPfVQ7ABm8o+8Ed32Gzyit9v1lqZ+1WrREGKP4c14F1p62+G?=
 =?us-ascii?Q?MPf5xL4p3tLP/svNL4dsTbnNElYJ4pw/edBOnOrn+SBCa9GE6KAWO/FXyhJA?=
 =?us-ascii?Q?jivwAzUpyvRUiWRBNOL0k99OvxRJ4i8x9Hx0po+DcqT5JTMBkb1GmLAdDY3l?=
 =?us-ascii?Q?NjLHbI6NGY9DCoeljtKr/7DON/Od9tm+AwJC5YUlCPuYxnvwE2oIsUEnR9uC?=
 =?us-ascii?Q?yYibiERjfRqSfCWf27FuArcB2d2L2VYlDR+xrjnM2Y2OO/jumEof0o0SUb0r?=
 =?us-ascii?Q?gUEWi9IL0XavguYB20ww1/UzCByHDujtIvFyNPdT+HTxxBkv0H84s0rGqeQq?=
 =?us-ascii?Q?39btJXtGRWliD+r5G4CCJUtDgBNV0sHPhPZ+PHuF01Lo3m13DV9IG7sbE/yV?=
 =?us-ascii?Q?WvJA5GDc+eI8SS09l57RJDKUBnheCwnkOCarUG0x9w7u/9U8Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLU0WElHHLWhUFv537evEve3ujT/2eJyWXyGVufqPO8BQi6SrUeYRmhE39Ye?=
 =?us-ascii?Q?SR0bIz0lNbwCdc6hqyvZAPKte7ulgapbiIRWClz1lq9B37AmY3w2RlXHgxNG?=
 =?us-ascii?Q?kGUrCFS/54N04459/dSObOUW9/8NqbampVQj3NUSHs3NIY4wkx4bRZrPZfFy?=
 =?us-ascii?Q?lYrtrjy4q29ZlU4iiXvVsfbdehqOvjcFF5Z5AJUtTo8AdZRtE92dtTjs2+/f?=
 =?us-ascii?Q?NSdDsx18CE3ZQO2sYzbBjUFD+phLGdg30lf7sFGVY0TRuyZ+e5tfoTeL//y8?=
 =?us-ascii?Q?LEIVYOcvDpJGJZDG8dLv5YhKoHIgJNj4YRNqcs0EyXfkMA61xd+v6s88SmjW?=
 =?us-ascii?Q?JoHnlvz9FXsdwEH7n7tkjrwJTkO6Jkeq7/cRTzzBAzE+vsK5oHZ94yBsGiOz?=
 =?us-ascii?Q?UiZWZSOHaBa+YD2hkbsu/rNUsCwI2e4LnIj62+0JkNjrbkWJHRjey7FfVDSy?=
 =?us-ascii?Q?AMg0OlSBLQae1oSNSx2AlhdzJuC8dg5GQ5w+9yp4Rst+v26D1v8jI7unXN9S?=
 =?us-ascii?Q?Z/fFPRnZyt18x9yGmk69GLEeZsA+NeMGIv/5VGtiv+Tdsb8T6p3yTTIXP/VW?=
 =?us-ascii?Q?O63Anj1kqsUz9ZdM3uWRLjg1T2Soe+8rfLIJkKw+u+figFqte1s701iXjb7S?=
 =?us-ascii?Q?D0ICoP9i8g3si/x95mGZKKvQdVr/xP3U4fo+dQmoqVJBMi77/mmqFZ1pbPxH?=
 =?us-ascii?Q?vtJ27dc9Tox1PWpr9P4sb/ZiTW0eRGoDC41vM10RcvX7v5GInFU6H7GQ9Jev?=
 =?us-ascii?Q?h17WEAmN0I6yGUL3UrhvP/YYy4DZTZwGSMbOxF9LtUKF22Nv1DBcRqR/2v5T?=
 =?us-ascii?Q?tufGXT5n6lLQnB1XVGO3mCMsLzUMgeRQPFrcwT9N6r6EJuM1qm4KabxOTQRc?=
 =?us-ascii?Q?1LxmqPPDHEjNHHTrmrXUWT/fOL0nHz+XsbB5jWjPAmoxYO4LE6jiLcku3EZ5?=
 =?us-ascii?Q?XfgZmAfELCfij+673PIVZJ68qpK4i+ot5qZcoaaLSj3zbxV0tAlDtVXb+Va/?=
 =?us-ascii?Q?dab6zDTfeyKEhOou0KUTz/KPrTCZ3z5fz5oBzpfdjrJLQOR0+DLW6EcNLbhU?=
 =?us-ascii?Q?VXoW75x7L3f1UGBCo+UvGPEWIpyQtFJU/Yr/CM5GYkR993Brfsjk1n3jh6OE?=
 =?us-ascii?Q?Q0M5szF3h6luK/f8e5z4X7UXvMGQ+hdW5V35itGJa6D+9AElucEqWGLN2D8p?=
 =?us-ascii?Q?OYXvhptgAvyIvog1dPgisyynVybSDBcl5CjThA3I1tGjmoQrEArXhjh9uE5p?=
 =?us-ascii?Q?le8osWympCEQBFG20cY5OtCIz4RxuN3IIvZHeaCmNlf/nG4jNqeDfCbpragu?=
 =?us-ascii?Q?eWckxnE7Tlrz1F+CkBruwSWUUp9yi+QsLjegaU1PuKsWeP5D0Vu4P3f2VgyF?=
 =?us-ascii?Q?V5lAc5lslY/D8asH7x+0n6DXnNSxBZMVz9wpPUHl7aEBuBtS/SLRb1bO96bv?=
 =?us-ascii?Q?cOnSeJemeTobmLliAWeK+zApxp6koDXFb3mtgf8qaBxK0SYY05JKv1sYgVcT?=
 =?us-ascii?Q?hkmSC0j5VTVseye8W6mNsfZ0vuWOburDqEp/LqYlyBnJjMUK0h65ars5QvN3?=
 =?us-ascii?Q?mS2Bxco2xMcB5dY+jlU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3b6d90-8227-43e7-86c1-08ddcebb0c48
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 16:14:51.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx855FEugsLjWd8jD+DHhLtOzytw+KMmRoqwkOnVz+sisqdyE9bQne71//Tt020N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

On Wed, Jul 23, 2025 at 02:46:44PM +0000, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> luoctl is a utility to interact with the LUO state machine. It currently
> supports viewing and change the current state of LUO. This can be used
> by scripts, tools, or developers to control LUO state during the live
> update process.
>
> Example usage:
> 
>     $ luoctl state
>     normal
>     $ luoctl prepare
>     $ luoctl state
>     prepared
>     $ luoctl cancel
>     $ luoctl state
>     normal
> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  tools/lib/luo/Makefile       |   6 +-
>  tools/lib/luo/cli/.gitignore |   1 +
>  tools/lib/luo/cli/Makefile   |  18 ++++
>  tools/lib/luo/cli/luoctl.c   | 178 +++++++++++++++++++++++++++++++++++
>  4 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/luo/cli/.gitignore
>  create mode 100644 tools/lib/luo/cli/Makefile
>  create mode 100644 tools/lib/luo/cli/luoctl.c

In the calls I thought the plan had changed to put libluo in its own
repository?

There is nothing tightly linked to the kernel here, I think it would
be easier on everyone to not add ordinary libraries to the kernel
tree.

Jason

