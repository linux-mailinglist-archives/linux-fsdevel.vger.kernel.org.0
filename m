Return-Path: <linux-fsdevel+bounces-70458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B0C9BF07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55F2D4E374E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CECB2673AA;
	Tue,  2 Dec 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FTJZFX2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A8264619;
	Tue,  2 Dec 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689239; cv=fail; b=kyWpRZqBklZ9M+W+zIojslz667ivt/nyYEx1qLfe+5/B9kUztaKEPEky7+AvjS2s4mnoKOLPgut5PqN8OLrT3IlIcpY7epDEMDe/FyjT2yliX6sQLN0ZBgS+FRWuzJm7m5Ye5Cwkw8xjBgDz3TyL3Rnz9dIPWVXl4G+6jWwpioY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689239; c=relaxed/simple;
	bh=Fc1H7KLXxIdxMels/Bm+xb2d4yb6HOAz1JzNeqsJT28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKCkthHv7Z8q7F6kU4CpfTfjrVb+wxRtEvOse0Q4AbYmA1ADAKdxKuCietQX75YfHeswkereVKteNh+nlc0/2GZkoLXtYMOgwJIi9HHZ4qQaDay+T+Kw7jLIQ7LhRYyuFx2NKNYJtQ9099L/XUTY00M6yzMcdez7hbwNIDPJL84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FTJZFX2d; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/tzt7CoZABraYepWSDG3QZId4/rh9nANHb5SWcjjvrcCYxHkW6dFR0Eqcsjkw2MLGbagB2LfjF/+HWh9mCfsGwsDW0soz930bkSznozI90zqQFl4zElQN04Z9NJXvoKBpLOf8PjiClKEVRRq+PIOznMe6c4gp1nGxXWWwcKxoz29Qa2QzFDaIbFGAqaVyn1noRTPKZECs32nKUcJeeYRxGQ2oLZToe5AwOjg1DlVgLu5VZWISlTaiJiE/1QZ+XpjkqLhT7oF76vfktRW4j74trAxf+R7kJLnMmdgyUi6JxBuO1OnK6saWzi1ThKrNO9Kx6EhPFk5KmiQ4DmaILuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm74YJYnk5wwxOHFanog9/CbuTR4XafiHnR+99D+2kE=;
 b=er+r6xYjcLjQLtMtvS18Uv03Dl57HNEJrxhexBASw3UygGulo7SPSc9WEYZqao4mSDHWHSDIE5K59kNH06WYEYBUn1n+2ccPw6YXMQK/DeWYXSJR51VuOc24PJVldXQbo0HTFq7cpctlY74ZCihWoctrHrSPPAAkrwXpZRJAuuJtiYk5gGIVUjgl7wfexDBspJzOBoIktsA5N1PsMnhQRkmPNpITM9wPWa9S6eWGkVgQbmrMrshiAQdkI0YFHtH+6Sogi2FT9pyaXm0oQ6AQXQYMZdQEV/aDlBvEdBZlWKcnEW1c+Eu5AaxQZ1PPMKWJzANZOOHZxF9lGTf16KSAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm74YJYnk5wwxOHFanog9/CbuTR4XafiHnR+99D+2kE=;
 b=FTJZFX2duWusmMvb3zMmLJjNRSIJAxudKFVUI4k1mo+f3x075JXs4geGuLPTVQFDLcVOC5O071Db78y34HZ5skuhihSPntDffgQWJHI6aX14/p2vFYWVaN7mIcc6rImwNhReEFX4zGGsChlD81Qjkhp2LwCV7ZxFAFTvMLvjaWpo9RdyWsgrF3hbfRBifb9sW8GGuRYfzOAypYVn++lq4ZoVg7N2nsthURo5f4IaCzGf+TEXdsHsfOJOItlAPj2m0B9p9nHTlpDGObvUOQVR1obbUz4tzHdjptkpcQX3K0Ul1sUZUAYoiNRRbPSP6Z2k7r6zoeFqH5FXB1T4OPxhsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Tue, 2 Dec 2025 15:27:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 15:27:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
 mkoutny@suse.com, akpm@linux-foundation.org, vbabka@suse.cz,
 surenb@google.com, jackmanb@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] cgroup: switch to css_is_online() helper
Date: Tue, 02 Dec 2025 10:27:10 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <78BB88AE-E4C7-4AB3-9B66-48D97A92FA0D@nvidia.com>
In-Reply-To: <20251202025747.1658159-1-chenridong@huaweicloud.com>
References: <20251202025747.1658159-1-chenridong@huaweicloud.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0504.namprd03.prod.outlook.com
 (2603:10b6:408:130::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 459fc8ff-de19-47e3-8136-08de31b744cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f14B90fX3qDMrTOi+LyYUhPVHtJyv1MqWgkpzBQq+gmMGAi/5n58bQscbQei?=
 =?us-ascii?Q?Cfo5i8R/k1B7WMULipZ0hANkDruYsbfE4t3zDh26d4YNv4p8Tm5dAhHntipq?=
 =?us-ascii?Q?zWGebTCaJK2nsWd1/7heVdHNWmlnCCS6NcE911GTBA18os2QPeSXKFkO67RI?=
 =?us-ascii?Q?ho2MQo1XV00eFoJ5hXq3xG/OSHtlniDkHQvfUN5eaPgWPlv5BiARkQkBBVaQ?=
 =?us-ascii?Q?zJ8obuHirp+HzmEwZa6g2r256CwmlsmiU8nbemQjIGF1gZQgb1Fwv9yFoOUH?=
 =?us-ascii?Q?sjeSZx8zDZWR/S+V66WqBn4SmoV2lyojAvhqd5hALuAot+gE4N85oF/eByP6?=
 =?us-ascii?Q?2y+VghIRHRBwdQPS20Z7vAMLQL9ivbBw7ugjL62tHDu95bfe2IfX3YalqQd6?=
 =?us-ascii?Q?qdAMtedxQI1RZT+AJ0xOwkHQeq6/1XNPCcijztbkYI1f6XO7HI0/aW2rE2QK?=
 =?us-ascii?Q?ad7MoO7vwAZeN8dLT+sHawzeICZwNMN/d2irlmUUZIXPMYxxT7U17wJCzLkl?=
 =?us-ascii?Q?TPceJfwtpfAKDkBqOM9jbZGL/nisK8tnm0sIB/VwVeC0/iKCeWUWBYP8Mwjm?=
 =?us-ascii?Q?LxfMTkVJ0Fj473NpbEed2Fac9KlC7dkZ2pCSln7j/G0T2ioTY3CO7Y6f5HR3?=
 =?us-ascii?Q?2ZGIUp0xU5Uif9W++Ig2MIzYYatMPcABrtGKgQXBx0rW6mTk2qItfzIeOmSf?=
 =?us-ascii?Q?RlebEoXSz/HIMJmuD2yUwvfzakcP4Q9U6rjmQIXr2G87+ewxs29vuc3j2TnN?=
 =?us-ascii?Q?vljgRm17W12HXhxFWXZd/eZv9y0aS1ppTvvp8x1hooWXZxACBtDi8I0O+hfH?=
 =?us-ascii?Q?A/VzhGIcXHTIuI/I+YlftyAUipKh5/kIhs4JbExJAgYVcxcuRC1Qb8McpwSy?=
 =?us-ascii?Q?4C7Wjox8+KWRIsvK26jQl3Djy4ql0XejKb2fRaEsmmswpvnra0C8Z09IJQ54?=
 =?us-ascii?Q?RelWV4vnpSxy6R7RA9UN1cS9MimNf5D93UfHjtnQbsXQN91Nq4kC9ZKitO2b?=
 =?us-ascii?Q?7y5/mdSglQFzA02Puk1uoBOOYUROZ9qiIpvu71rpENKRzy5j2tHZEs90uaYq?=
 =?us-ascii?Q?rGRHl+IOKW+eE8vbbZKvRD4UQCdiVaa7hdNmQwx2RcbXdbAI58YUenLROIhM?=
 =?us-ascii?Q?V17D1rIPnC3dqf7RfcHdIquQZ6OqA2ODS0T3PLn0RH654ZOTfN1MKgAEyeEv?=
 =?us-ascii?Q?/7T4u06dkMyyqKuxTootAGBCNaKFlmiInPTkb0LJ0PFlIfYhvt425Xxhumnv?=
 =?us-ascii?Q?e9aJXe4dUKNziB2dixcWKNdC6loTHxcf7IXMbViCIvu5XDC8fA6HnJ8kaofK?=
 =?us-ascii?Q?61aM6zlA+CoHSyGCA5zEn6WgQ/Y0qhYXh8S8us9SwzHfPDej05vTEmS9E5vZ?=
 =?us-ascii?Q?+53teGAicPzhE/pSoiKPReE8y9gDKH6YOVIxo5RiERiva2cDXUGz4RwdWYb8?=
 =?us-ascii?Q?2OEUOtOxdRnQh8wBityC7UHuJj5RwQOB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/bh5KOjfWnWOdcCPCHrmMVl5SLPcuvwfYJPfIh3DoYV0X8fOuDuNU8Mw7B53?=
 =?us-ascii?Q?anAoLJrlVLpzPkIU76ryHRgKlnlTXIsjf3gP+b08JpvrrM9w3tajTS16q6qT?=
 =?us-ascii?Q?l6YhBm7b8NwrOHnopDKNzV1zFzjMO1LekT75e/sawD7qPSt44cmqRPjGykER?=
 =?us-ascii?Q?unML9zX1S9MozcKCxZ0K/dqGH1fPF1JpUVuvk8xCFoqWWtHyhvkC2ggc/61q?=
 =?us-ascii?Q?obErGx0w5c5PDG6HxC9qGVzAQXobLF6LpHpsNqpAiiRjrSC5FUsibmeyIyHM?=
 =?us-ascii?Q?pN+LwaITVhsKyPoA3EYC4jHkXG+8/j3jvNosEkADK3D96FYiy6dlwk1JWS89?=
 =?us-ascii?Q?uGwgkrYQc3U7UdsT8mE02jxIQcV6HITMIutKB1AveqR6WdxsME+1MtDLEdjB?=
 =?us-ascii?Q?OGMEYpJO6EvcH9Y3EDmlkHBBLtfjhN8FhKqel8gmML+m1JLqSl+Wj+Dc7anZ?=
 =?us-ascii?Q?CLq/ZOZ/JQRKgPEnXZOMURGJ8dgwKaLHQpi+bjJYB1kVDQNVugUChy2g4fez?=
 =?us-ascii?Q?R7tDNx30rUR0Yq1VqrDXYgm699P0uSPz6rhgRye8uhzGTuaIbjjl7SuY1BGo?=
 =?us-ascii?Q?8Rhg46ZyZ1q/960e6j7gsxiRze1bwgPRq5R2AfchoLvXaejV3EVNiJZI3qQ7?=
 =?us-ascii?Q?R4fbM/kdfVzbA2Ly6c4VZFMMop0POVoXsDozi2k21iUONn6gDbkfw6GL1a5A?=
 =?us-ascii?Q?Bq0x6iqLiWrrk9S2DqKO4DVlKqBAtdB6Y0M/9+beww/WSZxKsZnyQI1UFHos?=
 =?us-ascii?Q?7WmV/FXE0yjhYJBQu1xXTWqm3FooiNukUFBoGbY8eXZOk2zfjkc//DsFqTOG?=
 =?us-ascii?Q?CHTyz4/2GmZJ4EZoHilGO4j9P8CK2ZYDoZFP29Lr7uotK0+CFqzIMECgz2Zm?=
 =?us-ascii?Q?Q8x6iGsGOeuWTkNa2ox+fY+kLOnmkhZvxBA1ut8ACy/dK8TMcDNokTGf5FLW?=
 =?us-ascii?Q?NimKeHuHPtK/VXcO52uSrd2S8cFjtphMT+zAjltegdJAtsP/miNqE9QbvFWi?=
 =?us-ascii?Q?qEfnx3fPJd9b6mTv1LmA8SnoeT5nK97f8Fx40HBkH6MA21kPmkTblVeneHCF?=
 =?us-ascii?Q?yLxPIxWFpy4WFAm+Q29hT7rjCm+XKLj6LVS+9ieLAVY8EYZQOHmqyoXDfuZP?=
 =?us-ascii?Q?9kMeRVikKXV1I3KGmJlTBmY31nWVHoW6sH0kHedMxW6cJwvbO/bvwXoAxVsB?=
 =?us-ascii?Q?ArM0Fk5pLelGW0UAUM6x6pzKJB0LnEctEZWwHtur9OCB2fPUB6n73hm96SZG?=
 =?us-ascii?Q?BvVsQLCUBJori3itrIITtflehOAa6H8TXZ+9SntUSBtBqIhgLx4lvwrUTKov?=
 =?us-ascii?Q?lkF77/sm3+yS+pdaO9HvzL9L8Me4y3GMll55HKiszYLqoqCKMR3brLup45qp?=
 =?us-ascii?Q?RChvk3OvivIxcsVejUHUdIA2u5kFSM5yOf4bJrxeqYgSMVbQAgVVmlu8p6pO?=
 =?us-ascii?Q?JTj+wptp+vkOL2LHqmyQvp0ZtX8lYANgYCZhK1yLtqYe0wje/q0ztAvFzS5W?=
 =?us-ascii?Q?g+BnqSTKbN/gvgkpjMJ9S6XgO2TO+TSFdbfpeIhh3Ho+ofHy4Cj2SkIXyQeA?=
 =?us-ascii?Q?Iqjt+BCJey9NPh1DDCsWFKDeH03ceWNSF9UuHra9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459fc8ff-de19-47e3-8136-08de31b744cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:27:13.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eQlrG+a0kmWiNvJlNEuDOTl9EJL6LOhiDTGCeX9tT7WzbOUi7pSgQtcTPgc2oEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

On 1 Dec 2025, at 21:57, Chen Ridong wrote:

> From: Chen Ridong <chenridong@huawei.com>
>
> Use the new css_is_online() helper that has been introduced to check css
> online state, instead of testing the CSS_ONLINE flag directly. This
> improves readability and centralizes the state check logic.
>
> No functional changes intended.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  fs/fs-writeback.c          | 2 +-
>  include/linux/memcontrol.h | 2 +-
>  kernel/cgroup/cgroup.c     | 4 ++--
>  mm/memcontrol.c            | 2 +-
>  mm/page_owner.c            | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

