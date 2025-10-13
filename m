Return-Path: <linux-fsdevel+bounces-64000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A21BD5738
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F3684FAEF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656222C0F79;
	Mon, 13 Oct 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jJO+XDjY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF72BE7DC;
	Mon, 13 Oct 2025 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375502; cv=fail; b=JQ9LHe0azI6F/0T+RFrYjj63X45YnKAKqIwkQ2NmrETgf6MK3TfzRX0HnUxUbc7veZvmUnURbD2iNzC9kmdTEKEREdEPQTzXInR5eNmS3z2S6M09gNbej9GPR600Mr1qsNN8EA4o9XRGY2zhzpCi9s/hDKXyIWJ1OsAJf4XlHQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375502; c=relaxed/simple;
	bh=6SjKgO7O8DRgaJxrYqgMIrWX9rneYZ9bA0ElKlgMRqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3/FALSbU8btsWM9YPAWS8UXGTjJ6/AOk97cxjrdtN8pkTM7vB+J++eCzlwzrK5vsY5STm8jGCMoHKXiBfx41Y5j3Wu1kBwzQAmtZBx8EwJjtZAKlyMaxwdNvYDfA8pPH95IY5+2lA3YcMCg0+TPwtjswIQ97rK2MaCVD3/kd4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jJO+XDjY; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTCBGjnDLQ1yEIRqGZTbCgphvdSL6iOJIuRnh+SNdNeeV2fJRvjaXzvDtynC5qQJCB4YKaZB+VohamAvvbMHwCCqZJbk63xWqvoAmAEIPeHcpHb/cnA4o0JR64aYyil9BCJZ9ISuH0p2cq93GprTJiXbuYtt4JshphhgWwirNDvITw7SCyx2Wow4S2hImhdol1VEL6+BkVtiuUxrtLlLLAAHmYF2AsDIYdEm4V9Mgcu46NlB1rFeqaP8wGTeMMINR/3vMi0XtBA2Ykn9vXZrUUwMe/XuURILEpJsKrz8qSg05ekLNXZDMQ+XTDUKHA3EsDXY60ayGzm60RjexpLFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SjKgO7O8DRgaJxrYqgMIrWX9rneYZ9bA0ElKlgMRqE=;
 b=CsL8DhgIVQ0ND5LRkWq5UuSEQclyfN6dCoBE5Q9iuXfhEQYeaEoF0vcEjJhQ1vVkN7PNSTgsuanXfdtVdyoCnCXo5qQwCI3s4BOA3rdEdjghLGGxNxSM+jmxBJGh/SsDrqsAsdo+gM8f014BeUU1lGIVY3tWLTN29oOoz51fL3s2SLihyBF5FFUAgHjz2oQKAj8MKqS3cntcq/vibmBCwgcJCjVarXybfaG+t3X6GOuZJZEl9PGaNlCFYWQeUbixfYvpUZ6rur7HNJX1PFwMpPLqVcDLP/myW64/W85rmKqk3/dL2GKjCk6xHfmeDh1Bo/XT0bboY7Ul/u9iU2O6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SjKgO7O8DRgaJxrYqgMIrWX9rneYZ9bA0ElKlgMRqE=;
 b=jJO+XDjYbDVl7ASAFBx635LXgbATrekbkAkDSBrpHxTv/7s9ZtknEUE2Q51iiQjJIn1ZhDrrF62ANIUEsi5/QZcRvjzNNCLmfeOrnkc/GbPKWdzawLUgoZ+9upyE3TmwfEtXBgm4M4XphT1qnhdOnq50bbzcuBneL6nfl8nynHBLgDfXQygYE3/vv53VHJrJeUnP3rqeMPDWIerEzleHeCGCH1/+EVrhSYcsj2ecSnYlnsK24QY96HRdmtZivpEMJpc3zxkXs5TtDsVnZ1DVb0BFsn8oXjJyY19GxJig1XnnNXkALyMOdLwAqzrESnB6C98QtVyh52CTa5q7KG+nng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 17:11:37 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:11:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Mon, 13 Oct 2025 13:11:35 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <FB244ACA-0356-41AB-9735-D98B0452CEE9@nvidia.com>
In-Reply-To: <e64diq7jjemybcwr2kgmfrp7xxj6osfdnjmpozilhyjjrt4g6m@brocsk7dnbgp>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
 <e64diq7jjemybcwr2kgmfrp7xxj6osfdnjmpozilhyjjrt4g6m@brocsk7dnbgp>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:23a::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cfe654-0e32-4487-4dcd-08de0a7b917c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IkWq2Mrsy3fDUEhcI5MwOKYHpVHPJC9t1hb6S1saBYLK+XaK1GpXWAvnVxEP?=
 =?us-ascii?Q?LE1ZxzhzSsLnanzCodagnmwTtvGaYj18LtlVJ+zq+aC/Xs6MzeC/Uap3ez9O?=
 =?us-ascii?Q?JTMP9UNMKM5rjwr2dX8h83ec8PKDzPJZc5Jg5O9uDxulEBJp6ThvAH0r2zb+?=
 =?us-ascii?Q?QaFF7p0SY+HnUrsuJpAMMTWxtSqnjZbTlk1gS4oMrkvfKyZcojf1aVwZHUTl?=
 =?us-ascii?Q?dB379klu4tQAj+q3/ulDoG7TUYmrEiB7HQsXrYiEfgxpG3bkk8pM+x7/CTL+?=
 =?us-ascii?Q?rqW5c4pWLMBnFrASOYEdGNOsDCZW6PZ1SZ6DOF6rBpAPi7rvkvpA/LQW2e2q?=
 =?us-ascii?Q?k1dUZr3Kv4fJtzyeoGpnjEG37GjPVXQ694Ii/xFhR2eMVSq03YP4/PMB8lk5?=
 =?us-ascii?Q?/PowiOK2gdX8nUKZzdjJGtdxq//+ilAMpxsQDlqpNayMQcmtByVoVWF7/qvg?=
 =?us-ascii?Q?rT9wGLukPE9qHrBrJGSBKkVUfbFCf7eR4n9zHz2Bim4bRyBC7MMnV2aWEsim?=
 =?us-ascii?Q?ufrIeoy+53kd00ZGsSXs0Cu0K93gOHXpedGyfhjlBcqGdtwoIAq6V286QHS6?=
 =?us-ascii?Q?k60djHjmqfVThyXOwupzM84r2P3N2eWXCFjrGfQ9eUhkKIkJDFcQgMC+FciO?=
 =?us-ascii?Q?eeWq853k/qZsVx6Cx9hjjZ4MyT3WI3nL45YDwtCVpkOMsKlIDRiou3zSF1/K?=
 =?us-ascii?Q?TrlPXqRSrzSGFHhvnzU/jijUuHkmsxTaIkdw87lwwQYNy1slJr0EUm8UMc5J?=
 =?us-ascii?Q?cW7scmXSjoC3F2WwsI39DPQlJlwxjQ55vsfJg4AGyERHDfiOAzYLkIPj8h+d?=
 =?us-ascii?Q?PVLjgtMFhHKFkqXU42XHiAqHKemfpI2nle9zEc9PnaRWmfo9tYNkw9RwDHmv?=
 =?us-ascii?Q?RBlPNB3NaLh235Qp6/vkj8fV330uOk1g54gGrhDBt2ifJu08NGd6Q4nM66x3?=
 =?us-ascii?Q?HUvj646CpTaYwl0GkG0n7XqYr9Y3dWbKvObRrwVv5k4PdCkBgarXc2Ofz3f3?=
 =?us-ascii?Q?FB0kLq4y/zF8DnpXftl4csA9urdJJMzoJBw7yi03HhbpE80QuzMAjXZR+a7D?=
 =?us-ascii?Q?DfyK+vCmCWlWJTkDevZFKMEwDQjWNVHP03djV5n48Iq4O0b9obt+mVKSaXMU?=
 =?us-ascii?Q?BL21Zpb+d8FD2nvm1mTCzEevwuh9Oay9ADlVIxj2PeTigTqsoTkf6KRV9VkB?=
 =?us-ascii?Q?LhUlqdP/C9iZFMG5bfQzkymxUDSkvfLDivcZRa8ie9HPnldmS9sPcKL/zsR1?=
 =?us-ascii?Q?4xNlhG6EofxY+SqPhUNpnZ2NttJAYJskSU+9XYA+RCkWgA8gKOBXQVy+4XVN?=
 =?us-ascii?Q?cMmUURmY5PG6LAtnVvI/bMumZsLqcRpjhJeuNQIlpGP29lhdL9UTcVltlt7S?=
 =?us-ascii?Q?DBb8Rq1hvA43iX4+TyzKETZFb3xk3Dn+3odY5+z/CQB4tNxpVHBc5FxFuiGt?=
 =?us-ascii?Q?/+iruqrsMzCBbXfAUzco08hznhxSRMiCEYrt7Aveb2M3MbUV187tOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANBbBko1SdqKxR/tJ1sBKZvj13X7Arx50TMvnvyWNynDps4JoKRLYSlJA8e7?=
 =?us-ascii?Q?5E8A/A3WoxQfq1mE12CeH/D6tFNmjs2WvjBM0XPJmUTOUJuqTROB5sMku5eu?=
 =?us-ascii?Q?WFMtPt4uf1d3jKY7kXtOT0BjTEGSMlm8+X2z14q+W/Dc+jhTRse3/BDTIOws?=
 =?us-ascii?Q?FTZus9Ti0pUXOIiLpWvE4gaPvB5EWec9GPv+YiSL/gK1PzzeA8y5t5X1b34i?=
 =?us-ascii?Q?fHp/7AXz39FBxF60FPk58o0tEosZYY5ejSAUIowjk8vfgDnbpvWZ7EygsUHR?=
 =?us-ascii?Q?rAtrDeo0/0wh/tNZDXpB6WkEKBPXqhuXScrxbNkvplDMl2c46i42Et4MP+MF?=
 =?us-ascii?Q?5YKKwK5bvjP98qVjxeRHR67SMD41TR6VVapcgCWvBULbTdl6yMC0+OP8m4dA?=
 =?us-ascii?Q?5AYo4suv5Gp4GOsgDtbRk2jcv26IGciUGZSt4xjIJmtrnCgWXAEw9U1WKRMs?=
 =?us-ascii?Q?sgdQQ9T/qWYrdoRgFBMzq2rqXb+6E7iDz6nc8nydWS6Nqh7MlRO0PkAAedpt?=
 =?us-ascii?Q?rGzwlrbPeB6z3iA1S7j3vJh5om1Tat39JvYqOxQEqjIcUTb6J6DfLQPyCg/2?=
 =?us-ascii?Q?hr5V2DUYu3TNJlqbqTMCRO/qmgff6BWibmSjzL2bbrmyGG6f0WVQLRehRxwp?=
 =?us-ascii?Q?Nf9h2Fa5a8UEAH+O/bswNqQd/6PUNi9CQGsEG7yFWsGuQSmMPWz0+b8Iluqq?=
 =?us-ascii?Q?KSJkptdtBCb8wbIQ8eTIYOr2gB1x4z/tvJlgU8Xmm7/S+fSk2zD2LtSBWp6l?=
 =?us-ascii?Q?o6R1FwTbJ5fCTVIQhKbkf/Zuvtcbs8bE4KBNQ3njC/0vOsS64CIWdiRKzwE8?=
 =?us-ascii?Q?M7UkeQT5YPtZBjh4cli2CuOcQZoklZjioZX2NZHaxs8vldfGg4XrJcAAZ3j9?=
 =?us-ascii?Q?VOxLUlvlMQBWn0lrDXdPdNuS9Fd3Ccs0zkVK8dHW6ffoy9zLx7ItHVKzr3S+?=
 =?us-ascii?Q?Dmw4KKWdT772rtorV2CTK1ZPmbQw909+n1HlS3yHTq9w1LTP5QcG4jEdwSby?=
 =?us-ascii?Q?zKKUr7RWeyQHDaR1BZMp6q6dZoAqN8RShitnCbZ/+SH7BRkG84QUCduXRtqt?=
 =?us-ascii?Q?vEfamAaaUaOIq0k/GlRiE+AWo412iHlqtgDMZkw5JtZ61hj3VSxDd6Rv+SN/?=
 =?us-ascii?Q?KX/+pVlbDQHYZdGvU7n9bWZVyDF8zqmPeRXceWbsrhQ/e6GUdFZnMbps4oLg?=
 =?us-ascii?Q?3w2r3aNpXjgfg07GNclhNE5kcvPQt7E5no44AWNc9gxWBrfBq93/MusXRTYG?=
 =?us-ascii?Q?fII5GvYdlqG1SwvFdaxlyw1qt/CaaQT6ewBBROWRE4Fxkt4G3kKrdmqsHmu3?=
 =?us-ascii?Q?FU8KM7W8Hf0VUGtqFbrw6LXEhGjU0Myl1Fq5iF/x0uqJjAp986vK4haqhxla?=
 =?us-ascii?Q?RFGrKkx2QjF70ZKHmPoFlV1RLn7SNOAzdNIwsTG6hz0KxoCGzQrPtO4KNg/T?=
 =?us-ascii?Q?cwB0nBT4UkiSkuRxVeXz8MdmkdgjNSXcppKGtgQJi/muvbdKXY/1JeJkwW+a?=
 =?us-ascii?Q?JybylydP31cVymkM+l01YKNOC1K6Ky9zhJoDCcpo480/vGhPeQ+MLjI1WgEH?=
 =?us-ascii?Q?6QPmlR+g6keZdY7jSNr/0bkBSTB7ihLhwVCKAfG9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cfe654-0e32-4487-4dcd-08de0a7b917c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:11:37.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BZwRA1bGz0X3J2Qn43ADOliQw/cgWFH7sGTMXDV/hn5gE6ObZ6pT4X7DL/b3LU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

On 12 Oct 2025, at 4:24, Pankaj Raghav (Samsung) wrote:

> On Fri, Oct 10, 2025 at 01:39:05PM -0400, Zi Yan wrote:
>> Page cache folios from a file system that support large block size (LB=
S)
>> can have minimal folio order greater than 0, thus a high order folio m=
ight
>> not be able to be split down to order-0. Commit e220917fa507 ("mm: spl=
it a
>> folio in minimum folio order chunks") bumps the target order of
>> split_huge_page*() to the minimum allowed order when splitting a LBS f=
olio.
>> This causes confusion for some split_huge_page*() callers like memory
>> failure handling code, since they expect after-split folios all have
>> order-0 when split succeeds but in really get min_order_for_split() or=
der
>> folios.
>>
>> Fix it by failing a split if the folio cannot be split to the target o=
rder.
>>
>> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks"=
)
>> [The test poisons LBS folios, which cannot be split to order-0 folios,=
 and
>> also tries to poison all memory. The non split LBS folios take more me=
mory
>> than the test anticipated, leading to OOM. The patch fixed the kernel
>> warning and the test needs some change to avoid OOM.]
>> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@g=
oogle.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
> LGTM with the suggested changes to the !CONFIG_THP try_folio_split().
>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

Thanks.

--
Best Regards,
Yan, Zi

