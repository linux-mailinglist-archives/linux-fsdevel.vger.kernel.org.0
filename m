Return-Path: <linux-fsdevel+bounces-65625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8885DC092A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 17:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65381B24D1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C05302758;
	Sat, 25 Oct 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nkgMfLde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537B1917CD;
	Sat, 25 Oct 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406227; cv=fail; b=msL3vw8r1/s2ivKl20FDJamECq+isPPwzq2PsIcMSDtjuivsv1FIGYtQo7yoFAHlYi8POvUcfQQm60c/My9Wu/bFPimnfiLfnbVWqrvQZXsZU2ph09x2v/oypaMSdnzw0mfzvH2y/4R7Vsq1wjPuhG1p3VxdubPEmtvG4oeEhJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406227; c=relaxed/simple;
	bh=2M509BMrrknYqP7v46Vg9ejpbNTQHfG9hgIxm1Dj114=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3LCuupczIVfgn/2Jocgyc19Priwdwmif6D+SIHReOFgGzzL2jHdeKD9W6sQKoL88mWIxrBarKYC+jEF40rekTqzODCjMoJ6L/VtIiJS+JfdnvdjvgSJKOvlhG7qcDJAtq5UEPMbrqdVd5TS/9kQ1rGVMmTl9eF07xh1w2y1Yik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nkgMfLde; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFEZYWvtAupDN+/HpEVF0BwjNx/SnyVKm+yQQ4une8ogQ13zy6ReSeKmGAPY/HZ8sOXejM7iH6qKXsGLBYHec2z195c+N2AS6wnNyD05gyyEIaAR2YWF59ZvOITsioQZxCCZKOnFX3cNEgZals23zJKgWEhT/nW0hqg9B50a8xtHRbDlES+8cHc9czw5uqK3YcwpfveWl//0WXurlX0bB05dkO1x9bQD5z4JbsBuO1rPzPowxmySqm1Xo3vjafqOJ82j/0EawJJJCH+vo0iWBW8QeCtVt4Ag8Rr+9c7JMdlBAh4qCFV+spYTTDRZWEhG+B8QYKpz5E1ImPwgYb83yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlDALx22rg5kBC5Yu6IHhE1BtpvxwKS4sxS7ws/CqTQ=;
 b=SMy1IYSjRQo8bnJtqtBZxBI14vtmCL2bLxeOkW7g0CukkdbAzLQo5hRNw7rgL0CN1cTybsiKrD+ASN+rQ4OEVQ76k+n/1KSgjFgg5lTF3VB8tA8Jbb5XHax9b+BPgkX8Af/JQfcB+V8R92mKG8v6M+Hjkg0M8KOPXwjBvXR67BmO4RI2IPYJfus7PGgynHPpH7YISgl/HIuLxNQpC0waVs33V+by2PHUGvMBu3a9m/NzsaF8g43zEcDLHsHGeYxw84o5gEpsW9gjcH5oqIutsNt8eswBzJgh3odmm2Q2wbYB7gaZHPdq2bqJxAV30jvj7DYQTxa2msbNMYhhv437cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlDALx22rg5kBC5Yu6IHhE1BtpvxwKS4sxS7ws/CqTQ=;
 b=nkgMfLdetAnmeUNxS46kdlR5NpPrMfNZzEiIRhpaUY8a42cYrnx5wEpLVOG8bfLm/nU6cb9MW1FdeSI7nZO5/cabRPrkWLrdAsavrrq3AvYnoKtVzqBM5eGNMMTLjT2ffHnQ1AUk+KFRNs0M0f4a5TffhPKIw/To65B3uYQOie3uqeo2dUlmgPZL2LKlgI0moitVIryYxp1IJ6HgXbG08TgAewCq8lxToTDEytKIofufrPTU2+Yz7okNKUC8c643EwNdhfWJ1VGrd1gOYdxS9OFPIWxW5vHVy7Uo4Qk1K7C0igVLrXtRqx1ODSc7mnJqHHSaY5WP8hfKCAZxCKtO2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sat, 25 Oct
 2025 15:30:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 15:30:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio
 is split to >0 order
Date: Sat, 25 Oct 2025 11:30:19 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <60D65915-5FF5-4ECA-A52F-8B9FE8F714F4@nvidia.com>
In-Reply-To: <298f1a0c-a265-4b0c-a5a0-7f916878dcc7@lucifer.local>
References: <20251023030521.473097-1-ziy@nvidia.com>
 <298f1a0c-a265-4b0c-a5a0-7f916878dcc7@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR01CA0012.prod.exchangelabs.com (2603:10b6:208:71::25)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: febccf0c-3965-4055-b31d-08de13db6971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/v8C6rj9Xmh0X5XZZwmUQKRgbqbvjjD4J8mDJsb/r0fj23w55YqhBYa4n/Eq?=
 =?us-ascii?Q?36xXlo3QqmS3v+yGhH2l8N8EuoPWbdfpIeTPZr86SuRCdN/+h55pPzrQEYss?=
 =?us-ascii?Q?mfGzLSNo+ertUJ37OgZIbk0yF+eAI6dZ7h7VFaE1Dz8qYE3/q9MqLsBN+ulG?=
 =?us-ascii?Q?czRbfRW9WFKXLnJ3fG7/6bGyfhcflKz1i2I4OHZphgYU+gTH1HrCaqOkCjtv?=
 =?us-ascii?Q?3VzFEK17f8RSIKMD/s8IpQUZwT4cPA/xy1oKmdCvxF2tqL+8UCnd3oepAdpG?=
 =?us-ascii?Q?pAeN0NG5xL+tYR44yf2EKKQIsczhnfx25QaKqu+TiSR+I1knCNd19NlOJL87?=
 =?us-ascii?Q?jjZS2526xkYJMgh1W+t6ax3EUoHMLxNhUiRySb2zzn4gSZK8zzMfmHtmjh5i?=
 =?us-ascii?Q?2T3GD164oMO6Sg0RVs8u/DCGf7oDwSed+PTsfYFem+0ZMheUXUoXKvNlEwsS?=
 =?us-ascii?Q?HmnREgFVjpXyQgvGx5sawOVpF216KCYuNwY/NmT6Nyb48Jgv8kHdU/vaC2iX?=
 =?us-ascii?Q?JlKBL+4/jgld2gTCdgT5J9rruDAye9KKNx7egNjpPubXxw6ORxxLpX5j7rI5?=
 =?us-ascii?Q?UrbpsP2wmJ7ngKoVT+4bHKUtURWFhUsENMBbngh/3MmUVG76LnOKElI939VX?=
 =?us-ascii?Q?9TSefA3Ly8ETD9vIZH1qsm60yZ6K/uwPPlklWYI8z+cUce9k7uh/XOXV197T?=
 =?us-ascii?Q?u1hU1vutczz/n3h0hnVFZACehSPvoRJBVb1GBX3jQPK5GTTtXD/vTS00L6Qp?=
 =?us-ascii?Q?Rlha+Vqx2sQA2eCXRuLklR6P0E/fuFg68xPlQh1vc9S5tDbAiPVOdnmKHI71?=
 =?us-ascii?Q?ni4m3o+MecvU/IM8Iuzt8Ka5Wt6lslb2MA/7mEs63zWgS65bFvn4M0OO2PKy?=
 =?us-ascii?Q?+RsFGPTfVSRXTg9r325tIeXlW0s11q5O2zhyPcVCDcKzS8/2l68YSuu1PMJz?=
 =?us-ascii?Q?zf7GLf8rehgQLA4Sxc7w96mWb1l5/Fh3BiiC/3r2/RQ3r/EwF9twd8HGL+DX?=
 =?us-ascii?Q?JnQmV/DAx7kjoLv3HRPgxUbGR+7ojGBx0j1kanvlurE5vboCWJblYmJlI6wk?=
 =?us-ascii?Q?uCEVKffYhHfwGaqhz4y/3nmCnRkqfUsPEvmJMSbpOKKu3rbUYyX6Y4KDGP5w?=
 =?us-ascii?Q?LNWq/s77iPc5Ww/enjGPvVsWeY9psYqOh4WLDiHxuNg9bxmpbv3kIJ9IqnG6?=
 =?us-ascii?Q?NxRAmAw4GMzxAt6BH9vqfWZ8BOoyVBOm1Esy+kTqMwf3jcNQfaa+U7JVv0AJ?=
 =?us-ascii?Q?Vg6zZnUCqBuCUp7Znxk5bo80raV8N6rwlDCPiDYde2kqeGB0gm+DDrMeG19U?=
 =?us-ascii?Q?rjBd/3z3ajMJw/PgAuFzrpJJstIvY8peiDZFDA/l+jBUGCTJayTQlsho9KEG?=
 =?us-ascii?Q?JLDoAgXfs93NHaHxdpZ/js2vDz5YPK51FEWE8kGF56W+2LBZc62ZHoa3rFy6?=
 =?us-ascii?Q?D97Q6uPgNkXGCHiQYuR1uWSIaleWAzsI7qoU7V8gXoe63yaApA7axw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hGPzmAUh8XSWOpn5tfBz7BVHojhVlOVCrhMeJCpUi2y1iQbwUzUNb+M1OCc?=
 =?us-ascii?Q?sVj1PUyjxclWSj+iL0ip3+b38qr4jtsY0J7qzmF+pI2I5bPr0PfimvVkDBbd?=
 =?us-ascii?Q?Z2dOCpQdomXAakD9/aw74to930mthn6iHKBiGEI4V56WUz/ECmg8sQXbbe47?=
 =?us-ascii?Q?xqEKADub5ZQq9mK1AMP66XLaeWA9OY/pFcx4Y99F3vCiQToZLCZWAWQIMJmP?=
 =?us-ascii?Q?FMd4aOprox8TaYotpHFiWs35rE4nX4l3Sid3bbP6sSjsLIQbBukPoEuhMXbH?=
 =?us-ascii?Q?B/E2B20LloQ7mwt5WBUVutQUyJRq5phvrgXxMgqUyMMz9NE93IChN4IgJFG9?=
 =?us-ascii?Q?/owtuERsDTySF8oQ6Dc6kHOve6lVhUjTkqz0m9Km9pZuhD+ZqoHDagtqKNku?=
 =?us-ascii?Q?m/T47XdUAc0WsFTab6Suem43v10+0ov9an2hK8PLZCc4XDhSnQojrIflm4jU?=
 =?us-ascii?Q?LELiCdoQ+WpPgk99IerxR3C+LTjFW+cLmyPOhGdGEoOFBARc7uARFbuexnBo?=
 =?us-ascii?Q?ssGx0rtfbEgi+uhSgYMyTEeUlKiWdAday6DRBUaTnYy4XuSN+Rx8uopN8xPN?=
 =?us-ascii?Q?9NfW5MSMuhThdFtyu101ZGv5WMmvbuWH+oODeczk8VCetEZ/isfc389TKKlO?=
 =?us-ascii?Q?k0NA28MQsUlOn0O/BlGcgpQPrs2U608vMINfYJDEY10fuJED/2wfzqnHYQKm?=
 =?us-ascii?Q?RJ1Y2PeLRcrVJwtG966O6PZwFA84h5ME8bN1aahOvIijyPlPj6UD8URmw5Cc?=
 =?us-ascii?Q?7U+kGF0e7wtVJbriP2G6tnlx0nU3DxnN5A8mkQLWnJYRT6+yHhQ3NZeRmRlO?=
 =?us-ascii?Q?5SUT5priYXOlgqj9sx3pxOHjE4D0LCv7v+yRLuBilNsjVtRPDRFAmCFszLaq?=
 =?us-ascii?Q?eLNoF6d/QBXm8edMFbbVF6XNU64APPxiX2QsLCpQagoP+kOpWhSHBeSdtUtB?=
 =?us-ascii?Q?3JmuDUZ7uOR3iUoE8yrBWK0Eb7300/Nt3P7v8mFFENf/ArB3KQqKHI6GPcQ6?=
 =?us-ascii?Q?yiXr0Er3Q7H7nq84lBwRnMAtmSsvEslxO/cNbPVAfdLfW8Nxajs+8ET00ARY?=
 =?us-ascii?Q?0bOdfz0xFSKjetzZ0w4PgSkz0Tl6MoCL04Ao/NSH2r+OMyyOboym5/SF/vpG?=
 =?us-ascii?Q?95AF2DAjPUYbpAT6cMEfhTfO8K9L8a/EgVI+d2MWRA3b0K0GnHTDxmQaj/VJ?=
 =?us-ascii?Q?exIi0VC/UgC1+gg2lWa1P1p07RU3/N7kLROwbMZCBFhhhjuN31QlFmS0jmLz?=
 =?us-ascii?Q?gJdVDs+2mKUyS3q42yu7NnKQB+O+2VKPHxGucO+MCEjv22GNzhEpoZP94h9q?=
 =?us-ascii?Q?f+29SDGb4gtQs+PK3J+8WrRq6qQ3C25QYQhxpIao7uMLhYlO0ijvB5WcdFQ4?=
 =?us-ascii?Q?qJUh20JuldeEjQR1mwCmd0cWID5SRgPsybRWJ+VBXqmFfJ9Qz6ws1LmqL54+?=
 =?us-ascii?Q?oUrYX+fI+lcMMPGwf1CX6k7TGZuTtydPzp+AyUOUfl78Mz4yY9QQulm8IKps?=
 =?us-ascii?Q?majK4mimcuFIfzJUk2MkypYOjaf09/7PaftZTu0Sgr3U7yGdKjZ3euAjOPRW?=
 =?us-ascii?Q?SM9fgzISU4glr2CgBJ1qTFzGcwL/k6JiL817pdBF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febccf0c-3965-4055-b31d-08de13db6971
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 15:30:22.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs7F1wksT+mmDL//Wm7jOt/O0Em4xZIcpRt613N2rYccjVUjey0Rh4U4NSG66zb2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

On 24 Oct 2025, at 11:44, Lorenzo Stoakes wrote:

> On Wed, Oct 22, 2025 at 11:05:21PM -0400, Zi Yan wrote:
>> folio split clears PG_has_hwpoisoned, but the flag should be preserved=
 in
>> after-split folios containing pages with PG_hwpoisoned flag if the fol=
io is
>> split to >0 order folios. Scan all pages in a to-be-split folio to
>> determine which after-split folios need the flag.
>>
>> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned =
to
>> avoid the scan and set it on all after-split folios, but resulting fal=
se
>> positive has undesirable negative impact. To remove false positive, ca=
ller
>> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() nee=
ds to
>> do the scan. That might be causing a hassle for current and future cal=
lers
>> and more costly than doing the scan in the split code. More details ar=
e
>> discussed in [1].
>>
>> This issue can be exposed via:
>> 1. splitting a has_hwpoisoned folio to >0 order from debugfs interface=
;
>> 2. truncating part of a has_hwpoisoned folio in
>>    truncate_inode_partial_folio().
>>
>> And later accesses to a hwpoisoned page could be possible due to the
>> missing has_hwpoisoned folio flag. This will lead to MCE errors.
>>
>> Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=3DcpRXrSrJ=
9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order page=
s")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> This seems reasonable to me and is a good spot (thanks!), so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
>> ---
>> From V3[1]:
>>
>> 1. Separated from the original series;
>> 2. Added Fixes tag and cc'd stable;
>> 3. Simplified page_range_has_hwpoisoned();
>> 4. Renamed check_poisoned_pages to handle_hwpoison, made it const, and=

>>    shorten the statement;
>> 5. Removed poisoned_new_folio variable and checked the condition
>>    directly.
>>
>> [1] https://lore.kernel.org/all/20251022033531.389351-2-ziy@nvidia.com=
/
>>
>>  mm/huge_memory.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index fc65ec3393d2..5215bb6aecfc 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3455,6 +3455,14 @@ bool can_split_folio(struct folio *folio, int c=
aller_pins, int *pextra_pins)
>>  					caller_pins;
>>  }
>>
>> +static bool page_range_has_hwpoisoned(struct page *page, long nr_page=
s)
>> +{
>> +	for (; nr_pages; page++, nr_pages--)
>> +		if (PageHWPoison(page))
>> +			return true;
>> +	return false;
>> +}
>> +
>>  /*
>>   * It splits @folio into @new_order folios and copies the @folio meta=
data to
>>   * all the resulting folios.
>> @@ -3462,17 +3470,24 @@ bool can_split_folio(struct folio *folio, int =
caller_pins, int *pextra_pins)
>>  static void __split_folio_to_order(struct folio *folio, int old_order=
,
>>  		int new_order)
>>  {
>> +	/* Scan poisoned pages when split a poisoned folio to large folios *=
/
>> +	const bool handle_hwpoison =3D folio_test_has_hwpoisoned(folio) && n=
ew_order;
>
> OK was going to mention has_hwpoisoned is FOLIO_SECOND_PAGE but looks l=
ike you
> already deal with that :)

Right. And has_hwpoisoned is only set for large folios.

>
>>  	long new_nr_pages =3D 1 << new_order;
>>  	long nr_pages =3D 1 << old_order;
>>  	long i;
>>
>> +	folio_clear_has_hwpoisoned(folio);
>
> OK so we start by clearing the HW poisoned flag for the folio as a whol=
e, which
> amounts to &folio->page[1] (which must be a tail page of course as new_=
order
> tested above).
>
> No other pages in the range should have this flag set as is a folio thi=
ng only.
>
> But this, in practice, sets the has_hwpoisoned flag for the first split=
 folio...

handle_hwpoison is only true when after-split folios are large (new_order=
 not 0).
All folio has_hwpoisoned set code is guarded by handle_hwpoison.

>
>> +
>> +	/* Check first new_nr_pages since the loop below skips them */
>> +	if (handle_hwpoison &&
>> +	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
>> +		folio_set_has_hwpoisoned(folio);
>>  	/*
>>  	 * Skip the first new_nr_pages, since the new folio from them have a=
ll
>>  	 * the flags from the original folio.
>>  	 */
>>  	for (i =3D new_nr_pages; i < nr_pages; i +=3D new_nr_pages) {
>>  		struct page *new_head =3D &folio->page + i;
>> -
>
> NIT: Why are we removing this newline?

It is a newline between two declarations.

>
>>  		/*
>>  		 * Careful: new_folio is not a "real" folio before we cleared PageT=
ail.
>>  		 * Don't pass it around before clear_compound_head().
>> @@ -3514,6 +3529,10 @@ static void __split_folio_to_order(struct folio=
 *folio, int old_order,
>>  				 (1L << PG_dirty) |
>>  				 LRU_GEN_MASK | LRU_REFS_MASK));
>>
>> +		if (handle_hwpoison &&
>> +		    page_range_has_hwpoisoned(new_head, new_nr_pages))
>> +			folio_set_has_hwpoisoned(new_folio);
>> +
>
> ...We then, for each folio which will be split, we check again and prop=
agate to
> each based on pages in range.

Yes, but this loop only goes [new_nr_pages, nr_pages), so the code above =
is
needed for [0, new_nr_pages). The loop is done in this way to avoid redun=
dant
work, flag and compound head setting, for [0, new_nr_pages) pages and the=

original folio, since there is no change between the original values and
after-split values.

>
>>  		new_folio->mapping =3D folio->mapping;
>>  		new_folio->index =3D folio->index + i;
>>
>> @@ -3600,8 +3619,6 @@ static int __split_unmapped_folio(struct folio *=
folio, int new_order,
>>  	int start_order =3D uniform_split ? new_order : old_order - 1;
>>  	int split_order;
>>
>> -	folio_clear_has_hwpoisoned(folio);
>> -
>>  	/*
>>  	 * split to new_order one order at a time. For uniform split,
>>  	 * folio is split to new_order directly.
>> --
>> 2.51.0
>>


--
Best Regards,
Yan, Zi

