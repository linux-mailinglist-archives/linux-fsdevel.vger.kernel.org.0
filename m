Return-Path: <linux-fsdevel+bounces-43363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084FBA54DB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D291896CA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370EA1632FE;
	Thu,  6 Mar 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="MIMQVhvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AF14F9FF;
	Thu,  6 Mar 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271246; cv=fail; b=lSNyqgqLlKsaz0HhQzjbSyLiqyVg/VJIACKEhdxZzlnuDsWronLJSUWRKR6UXAiD4H9vdLXSNIhU25jN7P6lZ6+sQzKXU6449K0g9eGAeej9fJoaj6zENTwIP06Y59D8gFlfH1LoNSH2a55Olu3Ukwn3DXofYrRYzPfDAlw25CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271246; c=relaxed/simple;
	bh=ReNlllr7jD6HjhxEFMr3UEQUdd6BuWPGFkiD+fA5kVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=IygdfKGG5mLvQzcZq72nIDF6Vxkmz9svIjzU933Fmf89NWMp8Kli3ULOSROXL+tuL/xfspi1+AtIlj/et/zB9Vu7mIjqsLWsdsFqCO4+ehVhYf4VcFm8a4wWKci6U1jVtcQZTSzixqNfptHmdc1WoZtguzd/nEIGTAusT312JVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=MIMQVhvQ; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD7bv8SMfnbr00+XdTXWEnETUNAzeyVWfHjGA4LLeEdbhv8RiQQpdcrNkzDP5JvYf3dinJiTL+yYvGNpcHzKcR+s5Ad5ep4ib+62iDVHrBcbhiJ3Ln495VVj3tykAjHF89Kxxf8vXx5Y72ejUvkP+AH7D52ohV5HrVS6wLsy4VarWNknCFxxh6euIJCHGgMkFrcQIdJ8iwPhHnTNpvLjqo9AmmwTg8PznIJGPEmGxxxFPIVDappvWq/m9NIH5kcK8aYvwqu+I0aw3U869bCAu5zADq8FTgQdpUGLIIl/VSDUEBDEmM8GauycRmXzEort69cEvRN8SABtQGxViatHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D+fNWxMGYbs40FrqidwR8C+IQjb3JNJ4Ybp9B8O8Vo=;
 b=yTtBa+co+LcEXv+UFzBN4Menk4jPzhqWRSWFYWgMlrP2f64SBS0T6qnSRkMksC+x1O9UpAwyJNHvrei6299tvFvT3o9Qa+H0qBHPFAinFZ/+IOYF98bYH/oYqGEPPUNqVzUnpR8wgtoCFC747AcOeiW57Ep8O2uxPTga0jXuM82jA6DF3RPw5YP42BMpZYjWOrs0MBdwKg0n0pDmwu8Lg1JIoBipdJ15a3YdwCSSaZpLA9426M1zuJng8h3kcpCwT+49eqk1jzFaS2MYc6+GgRxyBwoiysy3n0Y6lH8dlVYkvwY7wdAAKHT9Zm7nnaRPTNun+YkTjjDlTEW+7aqFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D+fNWxMGYbs40FrqidwR8C+IQjb3JNJ4Ybp9B8O8Vo=;
 b=MIMQVhvQSI8dtV1J88n3q30AVhBXdf7CzImHQwY2E7mGoTcApi5QdQI67YeNHjHZPE4XZ5HGxaqCp8kLkm4yiFSjVttSKBFE99W10pbqVKpYsUNd4tKegTudWzLZ9oxoL1J0VjesJ9V12Em2rJRg2TFEgbAXROEFV4/yNkwF5rY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DB9PR10MB5642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:27:17 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:27:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Miklos Szeredi <miklos@szeredi.hu>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Hugh
 Dickins <hughd@google.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Jan Kara
 <jack@suse.cz>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,  Mateusz
 Guzik <mjguzik@gmail.com>,  "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
  Neeraj.Upadhyay@amd.com,  Ananth.narayan@amd.com,  Swapnil Sapkal
 <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 3/3] treewide: pipe: Convert all references to
 pipe->{head,tail,max_usage,ring_size} to unsigned short
In-Reply-To: <20250306123245.GE19868@redhat.com> (Oleg Nesterov's message of
	"Thu, 6 Mar 2025 13:32:46 +0100")
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
	<20250306113924.20004-1-kprateek.nayak@amd.com>
	<20250306113924.20004-4-kprateek.nayak@amd.com>
	<20250306123245.GE19868@redhat.com>
Date: Thu, 06 Mar 2025 15:27:16 +0100
Message-ID: <87v7sm44l7.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DB9PR10MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: a41b13a1-3c2f-40e1-1412-08dd5cbaff34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XeRcYAHB70mbbAQsTL/5WTkwLaWre842tFWkDcuRBlZDnB7vQVML2UmxHVK?=
 =?us-ascii?Q?z6uJZRShGiYlE/kdNPaW4rhidUTpECqhY7OMj6fArl57ZHQhwKcPkn/UjNHl?=
 =?us-ascii?Q?P/weQePaHz7goUkY1bajn0n/ks/Ns45ydQkGdBaadDPZyk8GGH6TzTc0olKL?=
 =?us-ascii?Q?zBZMYknb5YTuRIf+aQBAPeR+rtxxvHwhFTMqvPU+RBLw2cr7I7+U1XOCq0vd?=
 =?us-ascii?Q?VzkS4ct6exsgFYYM2/QUJgceT3bFwJ6LcK4OSoPVyQ2Lvx4wdZzwCGpeiUFF?=
 =?us-ascii?Q?eLHDmjefZV6xk2cBa5zZixZgtQ5p/TmCl/3tjEnYc0yYyA2aLIIurAC9YOqT?=
 =?us-ascii?Q?LtzDS7C0pBG0+KfAEu9qUF91sHnWosZkgXkszfO2Ne4kwlYLWqrJhFQntI4W?=
 =?us-ascii?Q?tnLq7HG0N1xt6MttARi6AEjYtaBydwM9HcmUmV8QSbmaOswjrlxFZOWALYhh?=
 =?us-ascii?Q?r7WRR8Vh6PxJHWg80pugjF4i2MaojxhCSlc/7GbXD0o8r313qwtbWiDlaj9E?=
 =?us-ascii?Q?mvhj2tJcOU+ovtU3oNaS/4eAXri28qCyMvAYGcc95D52eVAlJWPeFrqrEdyO?=
 =?us-ascii?Q?EOLtPXesutsF8dw5IEsSodELaaCuHU2eYwfYP1IGMjdJQ8JHKCLASKcG0601?=
 =?us-ascii?Q?mbJfncauxtf1bP5x3AM+yikrVcYMDM6KsDZ6/VCxWT/xOTNHw63zl1C4cM4w?=
 =?us-ascii?Q?rKbxJBw2aF/IW50vM8e4CXcKEcr7ghJbtWr9O9kYsLlyXZzD/2BjSilUjZuw?=
 =?us-ascii?Q?xjQ5Ee/3CeAMYNvVhOBnrRlJGsY7ZWVoy4cu89fP7fOAW6lv2KXbofbGZv2g?=
 =?us-ascii?Q?FqWOf30D85pdBkyOZK5bAapUxxwN8MlypbLEZxmXwa7y1Zsp5iJ7M/mHl4bW?=
 =?us-ascii?Q?N5H6G5lY8OANbSSCaIzRZnDq63/6T8wIZKV73FVTQTYp9TjMtZBcz/FRsRq3?=
 =?us-ascii?Q?6VQgSpTFaKrGBWF2eniB9IloR1TtYCDiVigwUGvQEwqWn8curhiTEHGclNah?=
 =?us-ascii?Q?mdyT34DNtr9ROnb2C9xodt8k+/B69zwfiu4l1eSb/UebNlrUcuYvK3K6GfS8?=
 =?us-ascii?Q?ex96sisw6paDnyB7ualkt74XMqKVfi20rnrJH3mGq//sYDIZdESZRlp55cLp?=
 =?us-ascii?Q?21sSuaS/J8kYpte4zZQzZEcD1Rd2RnMbe/ZYwQsu6i7h32G7nx2C3+yMMloX?=
 =?us-ascii?Q?id+IjN6I3q+1MBEJdJCK+Pdz1AunPfky1cLrUIAPop+UF/8EOIQs0cEmg1mt?=
 =?us-ascii?Q?3eHM6+QyS6249Gs+xq+0TV+vs366O8s65CR3/KrMTcbbfjRn2N5MoBpFwaAm?=
 =?us-ascii?Q?KlDe81JZMPsgVE6oib/Hb6+rUI1x1DMHF+cTLowAbhl8xD6CngSOnpfuQDQO?=
 =?us-ascii?Q?gnjOH7AzC//PdF/XNBe9bppweJbD1UQd04v/gxLXv/TACN/+8lOxVjBznc9V?=
 =?us-ascii?Q?H7LgFYHFTVf5JceXGfTuN/7msYvatxpO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/isMP2ltZ0loMVf3tbPSH63q6hEMZSqq/bbMQ/Icf3yN7WpsnemEDkB8mTFQ?=
 =?us-ascii?Q?ppxsvXF+Ebfkydr2VAFcnct4HfflTakEabSr/8ydmY7HMDQtuNDEM6sOKqRn?=
 =?us-ascii?Q?vilGrgeIfdudT/T3dv98I8SI7kam+2YNecfKXL3R5otNG5+cvw6W26rkuq+u?=
 =?us-ascii?Q?tAXmFZCrQcO2nXxKh1WDn7kRNl5baqDtfR98PKxoTdVI6dNBstqYPQPFJZFI?=
 =?us-ascii?Q?GKbVue4JNVPcu0KHSAehOY1tKrwaYvU+qDAIzrW1tLn+rGdN5fWP0+u/cAKG?=
 =?us-ascii?Q?fhLhJbH2q/UeB1S96XBuBx9R/i848idIvBKN7eLEGs50okML1e5Srn+2ueq5?=
 =?us-ascii?Q?OBXZKnae+9UMjM9GupK1LT9FH1CUiCrGkye0xN7ynSUq5NHdBXPlWS90IdrA?=
 =?us-ascii?Q?8an4cAyzcc52st6muxd6ixZbmGt9nI8480ZBsybZh2fZIrtMw36zaqq/Uto6?=
 =?us-ascii?Q?Ld3qBVwaYnsmRxfcH3dIHnZRQ7HNVKlXlJ2kBLySKYcoHle4rohchCg089aX?=
 =?us-ascii?Q?BgQs1JL/q75wwIYlm5BxIr7Z4a3jCVEBzvj2kKy55jT842lpJa6WjC1lcqay?=
 =?us-ascii?Q?VWPo3Xu0WL2wVQ4w77/GXR2r6H4w9JaOZIhZectFU0VrVbM7vvKxpPKnNAon?=
 =?us-ascii?Q?XuJ1mu8vaQEU+FmDRZ4zhNwiGEtTOgqfUFSZpyRNK8M1qudYGw9MAKgq3kVk?=
 =?us-ascii?Q?yBNnOd8U6/ORcxTUbhbUSr8hzvzsyAQWmCl9SfGl6WWiGEpoBihfozJBIXw0?=
 =?us-ascii?Q?yqte/vxpbIfpysVOdRCfQZJKKG1l/EPX8Ma1ezPq3P4FCcNkITZFBw4eUSee?=
 =?us-ascii?Q?31KZRIstH0xP1uOkfVjJs9K8X9bGmfQj71X7iEzlemCFeNamzGEsJ/VuqJ/3?=
 =?us-ascii?Q?TveBfvAawBB2Kf4gMbNxUlVX/5KGmP7oyzR/uTmGL5l+VajvUgUbAP9E+i2u?=
 =?us-ascii?Q?mW+Kj5Xl8iwpDx4sUz2hNSt59ExVGIkedvXmfCJtwk6h5KS3fs3NWla29R5J?=
 =?us-ascii?Q?QcOybSOQ5dhsUdk4G3hqorPn6hsl+dsBXdc9xFpQhBqDr8BPrJTA3OJhy8y1?=
 =?us-ascii?Q?TmbRwEBDlRwNRGOM9H/KZPzPmBEk6kniMWJysNfSrJUHp6qVPjds3vYrIzjY?=
 =?us-ascii?Q?sNfMxGpG+EH186b6htzKMS309bCm0Jos8YCtWuXZIGEiGtpYH6lZVyMDWOho?=
 =?us-ascii?Q?8XMbaqL1DRYcupaedIsup0yX4NParEmVRE0HpF4ByLdlR1qFT7/51D69Jpa+?=
 =?us-ascii?Q?4SklLGtQt/++jJUEl1q3vUD1IOEjn8Ix9udyk0fjYCwn+AQKafM24LfcKTE0?=
 =?us-ascii?Q?BbGUxAyNQ2PDDqAWLpWsPvxAaqsSc3rjP7Pj1UN+/U5LTMCmz43gdMOVVaWl?=
 =?us-ascii?Q?9IFQNeQX9i8Q2yOMXA7MZFCRh/MvSjTQ26Lckthj1xh4Wsba3i3cmoJbMV92?=
 =?us-ascii?Q?ELVWu61GAaQCE3rjxdVIXumWVjHrGWCCeirsqsHnzBZ4NP6gALsm6HlFkUqe?=
 =?us-ascii?Q?lS2+Aww7KeWeaIYvTWHlA5BvgBtETVzRcIiheZ/xFVWvWgN+qvdTTrjZzUNp?=
 =?us-ascii?Q?PT48M/F5mjj9CjNDLTLNkO2I+x+S0XAebpeqY0VkCJKIyr+JHGQtIKVPWFYs?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a41b13a1-3c2f-40e1-1412-08dd5cbaff34
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:27:17.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MUc6xa8y3QVUwpRW2UEpFPTNZkgzKuBP5aKEHRxzLsk8iGEkXWPfOmHl51p83YaMM7ESttUPzmZittCujr6EhRnw5AtYVtzHXXYdo2kSn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5642

On Thu, Mar 06 2025, Oleg Nesterov <oleg@redhat.com> wrote:

> On 03/06, K Prateek Nayak wrote:
>>
>> @@ -272,9 +272,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>  	 */
>>  	for (;;) {
>>  		/* Read ->head with a barrier vs post_one_notification() */
>> -		unsigned int head = smp_load_acquire(&pipe->head);
>> -		unsigned int tail = pipe->tail;
>> -		unsigned int mask = pipe->ring_size - 1;
>> +		unsigned short head = smp_load_acquire(&pipe->head);
>> +		unsigned short tail = pipe->tail;
>> +		unsigned short mask = pipe->ring_size - 1;
>
> I dunno... but if we do this, perhaps we should
> s/unsigned int/pipe_index_t instead?
>
> At least this would be more grep friendly.

Agreed. Also, while using u16 on all arches may be good for now to make
sure everything is updated, it may also be that it ends up causing
suboptimal code gen for 64 bit architectures, so even if we do change
pipe_index_t now, perhaps we'd want to change it back to "half a ulong"
at some point in the future.

Rasmus

