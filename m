Return-Path: <linux-fsdevel+bounces-50076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8EAC8003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3761C03944
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E022B8CF;
	Thu, 29 May 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TpcuWGO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75621D6DC5;
	Thu, 29 May 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531451; cv=fail; b=h+LYYVZdl4Fk5HnQ1CqlBUeG8Id3ig+42rpfp0YSe39SIiUUDYQMOrlTnxQnIR+DOyeybntYsRG1J4DazndOi9GFg1JMd6s4VSZu5sXRjL+uLRwVgwoAgimqLMJM1x/+TdiqlfRqf5W9Wp7OmpDXqLl3i2sy614xkaIGmJa1Btw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531451; c=relaxed/simple;
	bh=eS24spqsQhgiCwEmo2tVrLv7e5fZ3DX47A7iPG94BCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJOIJHSInudAPv6n+rMFDrdSY0JRWyWSNOwIe5BspwLBnlQwSg0CaStpLv3TY85IK7MfHkQh+PRu28q/tFXk80284NBGkrq/0F8t2OWcJ3ZNS3UMpG41yJOVVftor1H6cD1i2eQGPajFUUFR8uN0cqCNoHdxwY6T5pMC0gRy0sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TpcuWGO4; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG8EE60E65ual2NgMV0C840uKLW22ufst0Y+qk/MPosIAlbX/palEpva/QYOL3k3ffPmk9hb7bzK6TL7Zp05QWnkiNdK/6SNueAu6557ur2vTKanQhZdw5DuUt4iybQoNH8GPVlJ0RiOLgopfBqNwfZwUmrCv9sYYMMWUfTVrstWzXu1kqO+Q/YYRLckjrEvA5JwjV5QWteiorkO4q5YjFZ42yzHObwgSU43syIHwLI8r46SyfKw9gjUhVJjtViUc4rGIkb7ekxBc69gh78tlPp0ZKPG2XA5Vzaclp5KqhJrn0YYS4ncw+QpMhCiYJYEFdmjnY60fnsCRNJ0POzXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG5+JIEBFdH0dcB05285CjnGDUr3XJEEMVAwWXvu2FQ=;
 b=toWsOprj3ZCCJN8EGfOkO5eZiJ4k4GlEPbiN4sFVuOFfooOfrHKVhAcp2BuWvQnF4Htaz2H8tMVUkDA/u4lEy0EW+a7sZON927x84ZSoMiaELwamoURwZvGCBc5Szx6bBR0+PDOr2fR/8sQ6m6fcmlXw/nx2uWQZ7cbTt7JMwwuHWoDkJ60FZaQ+c3nc+SapFsnW9qaqbA/C12fXsYJ1uykJPxm5jk2CzEmqO+/6uaBI87a1MYh+d2PIoCjN1kUANbFd5r2yke7A50RBoB74hg30SeeUTHIQE3Gu1bHkjD0+YPIHWgJ7maz48YG8kCxqe4RYYOYlCCpK7XNPYMfRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG5+JIEBFdH0dcB05285CjnGDUr3XJEEMVAwWXvu2FQ=;
 b=TpcuWGO4D9ACtvP9zjyxCx+Ehvzc2Hu/kPJrxSF9rgLBkbSWvP3++cO2cizfNnsgxRI7EGA0cWp9bv19tsOAFuJT2K6f9Wdn8+E0KrjhNIlNby9lRfvxM2rEJkP72ahQli8vdHhLviWvg4TG86YO1u15SX1jaRyb8ve3X0CRogI+aCWLhpRNza7oeDPFPLf/I+oO4pMI3NahJcyHzviMolEjTSB3B8uIVJjinEpMb2eDgTmdh5Br8KPiYgEPH85AV7LPQwmfy5zBcJwRy9CZ4pPfAbiD+U6WYq2BICh8HkdW1QXk+9hqjWFx1nRZREDtz1Y2GC4XNiD6T8HeFCV73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 29 May
 2025 15:10:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 15:10:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: huge_memory: disallow hugepages if the
 system-wide THP sysfs settings are disabled
Date: Thu, 29 May 2025 11:10:42 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <33577DDE-D88E-44F9-9B91-7AA46EACCCE8@nvidia.com>
In-Reply-To: <d97a9e359ae914e788867b263bb9737afcd3d59d.1748506520.git.baolin.wang@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <d97a9e359ae914e788867b263bb9737afcd3d59d.1748506520.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LV3P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c74235-e95f-417c-41bf-08dd9ec2fcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cE0pxXiJ7HtvMsxJDRaBar9rsPxvYAGhT9L2URP3487oYUGig1pJ//N6kIxY?=
 =?us-ascii?Q?NCtf9ZpAqfelWtx6Na5uyd30Hxyp0Ypr6oU/8W+0vgmaQvO/NOjAKZ/9aS6J?=
 =?us-ascii?Q?lspBGq0datkyJNRJbqVH7+4X3NKzjpPtgjV0evbZlXsvbnKZSFpT2EWXtUVU?=
 =?us-ascii?Q?scyVmPWZHOHa65+Z6wfF3pRJzoBZ7H0tJCJg6Oy1XSTTkKmFXPNy621FeBG7?=
 =?us-ascii?Q?mvXXXn7zIm8vSLCI63CIlf77LgbNUxcZ06t426R61+IQzzEQ7F1XlocenDUN?=
 =?us-ascii?Q?MFD5G/U0r4qxKypFzyxFucFStSHfyzicbOBhj5M+Yg2qaKlVLoG4w4aAR3hO?=
 =?us-ascii?Q?0qUBDYILZvMQkwix79r2RLx8T2ehOzGw3ZCQgOkzWVbaf4aLJO+hf0+uFpJd?=
 =?us-ascii?Q?4t7/HSg1upqIlp6jhZpKOQATpp8TW1AsLWitYA4uUbaKRVeWkNUGLmZjOIjp?=
 =?us-ascii?Q?2cRsSzgrALKet1LPBqbZCo9tAJAJFKceIsgsnFk5v/M8BQJ2mRIj5XKoESkL?=
 =?us-ascii?Q?RzTjvoCli+huXKAkHvW1bQ9xeGoePP1+QJh3V2PTzVyIL8TlM/sC8n173fOP?=
 =?us-ascii?Q?0M0hUciS08byy4FSwCYtCWDCgPxGORN0v7v0UsF2K146F8DQbmmHEc9q3dqW?=
 =?us-ascii?Q?7Nns+cYrLFFuuz/LnMXXDrkXwbFlSsv1V0RKeNXms7kuSzeUj9F2jJL+elYu?=
 =?us-ascii?Q?wYwLBmKD8Hy8gPJbd0ffUCFuM1REx3nRn7e7IgbH5eKCSiDB4yMcF9yTFZso?=
 =?us-ascii?Q?SgDfU3x+pB1mC4wf7eFQg0umRDN9SvK/n6W2b2/N6qE8xiWJgo0ysY0+l4XW?=
 =?us-ascii?Q?/Ls5h4lPG6avlbj17xXEPPYbDKdXDiqJ5OyygEFs2ATnRWJckrXNnrc2+FQS?=
 =?us-ascii?Q?j63ez8BtvPB3ZNJDq+xrpisgK2A3x3l6SooOAP+bkhTjYLGGrlQGElgBJJ5J?=
 =?us-ascii?Q?TMEWjB+FKhTM1Ij5AnlKAHnP+HYIWCjfbSh7ya2v9AFZ7KZiVnYSQDubcqJK?=
 =?us-ascii?Q?yXHASDeTTtzwFlzKpQmIPZ7StC8N8v5jg/S7nN/UCtJgzoiWF4yzmOqXV0Zg?=
 =?us-ascii?Q?0ZFfNb9qmKygPQ/ufmS5s0SPaodHn3bw3I8kV3yCcKpRn0ub+z+Vhi9F+DNL?=
 =?us-ascii?Q?4sNLoGBHD1h1ytpmBMdjXj5iBYbAFa44DppD8Sh75MOjwACgLetP9zUnU0Zz?=
 =?us-ascii?Q?tv4WW4qOKsz2FtfVZ/kg3wous4mpZqwi26GjVfEM15a5MhgCTNJKPA7UsIl6?=
 =?us-ascii?Q?vLJUu94eiqrXoT/ctm/bl0j22p/ClnzmTIw9e/oObec5h30zBXSk/dDmyLu8?=
 =?us-ascii?Q?4y0n0PGxTD/zByGLuLvTCq5CSeITBIAkYYK+MXaKKpzWkeB8NWz4JD53nupc?=
 =?us-ascii?Q?fwiZvQek6TS9DP5YqQtDt8u0cjN6avll4cIfzhIvItPpes8j4dW9NAJQBxs4?=
 =?us-ascii?Q?peW8+scDKc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bIETvSkelJJg+lvjiBBsf+k4FTSYzN8+ZMB6P0VlHpym+NWRgKGrzU0qpbjt?=
 =?us-ascii?Q?liMMEsAFbvF1aAvREepK+bzggI1QlXvYW045MTKsT6ZK9WJ4GpEs8BVJ77sN?=
 =?us-ascii?Q?D8a9J3B6wWsdTl6NIwWKLCUoANwd34t9qDVMiWMnN65Lo887tci8p28QuzDT?=
 =?us-ascii?Q?QZlzraNWduryTNPzd947KKeqmG/nr1ooO6ijzC8T9TXWdSeaPxgQ2J1v2oay?=
 =?us-ascii?Q?HGa8RO+7jxHxX3wUIHsMW5BPMBqDorp/NjvamwEI7faEx1vlTB0t7W20Rd42?=
 =?us-ascii?Q?wCrpcT8lauuU2D+QCIMoo3oxU4BlYOvsE06u2IJLHcPrWxt+YpWveZKVQAmn?=
 =?us-ascii?Q?Lp+HpfKGGzrYHT3TA6dGmzHLnOGIlovGuYFNPOcx6hYn/V7D6fYuMBy7/L+F?=
 =?us-ascii?Q?KeKnQUgbyHuv22gBo6aDZKtPqVILTApYjyUYIpszJVOzRst43aIlbzdQzmnv?=
 =?us-ascii?Q?x8b0lf2j/FSgxvZ43o4vlQ8MV5cCsq5gvawe4oLPnHL4deHRejl5YkMy6SOA?=
 =?us-ascii?Q?lfXWvt4ncxfjKfpNRe9GY3i/cdUyqnzrftkXGYPd3pgRmjyw7iBHjoceyBjC?=
 =?us-ascii?Q?6JzKiSsSkOxg9eKQVXGy9ctTH3Txk23CycIvTEU9MaybLas52Kv2U3FuENkz?=
 =?us-ascii?Q?FiqJGOu7O3YAMbLGzCX9RlfsKEJ0oT3nqqLrNcRBS6hdOWuM4g0mit0BhpgW?=
 =?us-ascii?Q?DSULVUBgfnwoI9B57nFZ3m1fGHcKRiQuQgiiV5/Ry3wwEacVwKkKTOf4Xt5V?=
 =?us-ascii?Q?lUBe6xzwwQjmS3qng6uZueNtfmf8du2ZF2CHf1mMlSpRWGIRV3Cu+g5XEty8?=
 =?us-ascii?Q?gxx06sW17c62maNEUqoAaSdMiWz1Edil0e0zkbVH6joEgg9hIeItrTmrx7ij?=
 =?us-ascii?Q?I3y01Aq65ou6zEwUOKBHTNNKLqXNjwYWV+SQg7cwVRAZsAb/Gcdx+OYDI6Tn?=
 =?us-ascii?Q?zQSnFqhQ82+SEFkS6RuELCCREmOFq51hFJw4RDaSq4uNfRVFwaiIRFMlARPm?=
 =?us-ascii?Q?zyi6NNf9SgWTVEluxP/F/g5YMknCLphjm6w0HM+bbsnMDya7GY0W5N/qoNvJ?=
 =?us-ascii?Q?GX7/0PvySIb+D+TX3QpoCkQ4ijJ+3tRjZhaB+64yrvJ/eI4O5KC7MAt6OeaE?=
 =?us-ascii?Q?lFRPx2Dm6Mp+NPKqiXf79n8qeLBe8XAlNp8Bnqbv3sHfZdocDNvtCcYPHdIT?=
 =?us-ascii?Q?2Ra7qPg1MvywcDRdMB4ZLqaA1nJIK4PWZHG06Yudl/j9BbGX9eTWmQGJCQAB?=
 =?us-ascii?Q?WzGOYb5nhBJvtvf1Akp9BO6M/YyCn+rXgEwVVNVhFkYNR+rhHwbh4aWOnrIN?=
 =?us-ascii?Q?b0ObFcQFaDva3KnVXLtF9HbOSzN+lOxMqn5uwCCV68GhziskYB7pbylvHMex?=
 =?us-ascii?Q?8eS/QgAkzf+wK9nSDFJCiosk+P89gB9+YZziLSJ84CCxfcrHWBg5EY46rL+c?=
 =?us-ascii?Q?77t8kkD+D7Htz93nO7tlB+kZAoscEyRCoheU2hdEJQvk8p6O44Nkv4xNCtt5?=
 =?us-ascii?Q?rlxG9cQescUKVnAYUwhn4ayJf0bk6YYT7buCXipoYIoGJ2Lu4g2hkUtBNykN?=
 =?us-ascii?Q?cYxM3bfU4+VgR5jhdCHjo7Y/uhIjS/GaJY47Wml3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c74235-e95f-417c-41bf-08dd9ec2fcf5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:10:46.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrWDpJmeW/WWBymVtZLsR74kjiEVd0+vnGmlzj3pkwrQDLIFH3rQBbVjK+jmgEit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366

On 29 May 2025, at 4:23, Baolin Wang wrote:

> The MADV_COLLAPSE will ignore the system-wide Anon THP sysfs settings, =
which
> means that even though we have disabled the Anon THP configuration, MAD=
V_COLLAPSE
> will still attempt to collapse into a Anon THP. This violates the rule =
we have
> agreed upon: never means never.
>
> To address this issue, should check whether the Anon THP configuration =
is disabled
> in thp_vma_allowable_orders(), even when the TVA_ENFORCE_SYSFS flag is =
set.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/huge_mm.h | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2f190c90192d..199ddc9f04a1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -287,20 +287,35 @@ unsigned long thp_vma_allowable_orders(struct vm_=
area_struct *vma,
>  				       unsigned long orders)
>  {
>  	/* Optimization to check if required orders are enabled early. */
> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> -		unsigned long mask =3D READ_ONCE(huge_anon_orders_always);
> +	if (vma_is_anonymous(vma)) {
> +		unsigned long always =3D READ_ONCE(huge_anon_orders_always);
> +		unsigned long madvise =3D READ_ONCE(huge_anon_orders_madvise);
> +		unsigned long inherit =3D READ_ONCE(huge_anon_orders_inherit);
> +		unsigned long mask =3D always | madvise;
> +
> +		/*
> +		 * If the system-wide THP/mTHP sysfs settings are disabled,
> +		 * then we should never allow hugepages.
> +		 */
> +		if (!(mask & orders) && !(hugepage_global_enabled() && (inherit & or=
ders)))

Can you explain the logic here? Is it equivalent to:
1. if THP is set to always, always_mask & orders =3D=3D 0, or
2. if THP if set to madvise, madvise_mask & order =3D=3D 0, or
3. if THP is set to inherit, inherit_mask & order =3D=3D 0?

I cannot figure out why (always | madvise) & orders does not check
THP enablement case, but inherit & orders checks hugepage_global_enabled(=
).

Thanks.

> +			return 0;
> +
> +		if (!(tva_flags & TVA_ENFORCE_SYSFS))
> +			goto skip;
>
> +		mask =3D always;
>  		if (vm_flags & VM_HUGEPAGE)
> -			mask |=3D READ_ONCE(huge_anon_orders_madvise);
> +			mask |=3D madvise;
>  		if (hugepage_global_always() ||
>  		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
> -			mask |=3D READ_ONCE(huge_anon_orders_inherit);
> +			mask |=3D inherit;
>
>  		orders &=3D mask;
>  		if (!orders)
>  			return 0;
>  	}
>
> +skip:
>  	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>  }
>
> -- =

> 2.43.5


Best Regards,
Yan, Zi

