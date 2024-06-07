Return-Path: <linux-fsdevel+bounces-21275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D46900D31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 22:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC841F2866E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700D1552EF;
	Fri,  7 Jun 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q4yupmIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11241154429;
	Fri,  7 Jun 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793473; cv=fail; b=MywN5iIJJCuNNh68/RkgyjGc2hZacte1zDNrwbGUI9nBxchdtDmaI0B1Tw+3JJIlQTP6KSopw966ehTI87GsGCY3apwLblBqS9x4R7bIW0YOuQ0l1Uy0DXTPE+RHFphpc/sFZ5SgP41gCgixj6PCTjeuHLXKHpbTHGJq9100qQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793473; c=relaxed/simple;
	bh=p1nM4qs4z0fKLAVKp8URbvDC4lL/XHeIXgyr4OAXlB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GO/DGtMWHfERxXslcB8kMUEVgVrhUtqHxC35lXfb9mZn1MieXHhPxGSSuVaTECLFB7/69ALzWZa0XvLvZM8jQgoqV17mEK4SAaPSDzXzSVOy4zjenKETbE2m4cv1RjUTuLlhIy1b5YRZa3sKC//+BLAVwax3Uuc37XK0bEjy9JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q4yupmIP; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1XZmggr550S3XfWUj5LcXhIJNrw8DqGxjUl9DibxRM2aAsE7HeyFja3nFmoL4jZf0EL1Zias3ohNWhjFZISfyFTiORGXVCDpMn1yfxfNnpvsJIFzniCpTL1TK1hWswyc0bVe81aU3dMynJvvc73LsaE6o+mPnvwD0HXGB82KYoQOHcOcRUH2JLoxXoGs6gxq8ZX8ARiqR6SD5c8ltlLyRKxfSPW4mRbiMo/u+R4BpLLR8pJRjPa7aIHW63erqBOmVpeRj1loaar811eRRhuDSMGLEdEQkEIxF+pxmK306UjNB4tJ7AqoSC4VzqQO39tZI8iJdt3LDS6NgmO7uxlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63K2WRUnghLfbvVyasQJdPQGNO0UQZjvc2wTsSf5aqk=;
 b=R4KgrzgyToEknF1ES0svdvcyBRJ6/B3dceDuy6l7eNsVXPQVRBkYSj5HHW7wsDr8arBunPXjnpQf/u+EFZ5Ml3UZsAYgFCxfS8ORpx2+LZIogkwA7kNbtLuSxtd8yzb3TIiXb5Z7P4ynS1QKz8KRz7UMD9Ow/iLBjrVREStjIAm0oqdK2QdBf7JbZKWfWUxATvI3FZpy1BQlsDayM+1e6smsgQNszWQpLgF51DsztGDqUyo4AQkbNCKz8R7yPl9SNmfPBmipMqkR7/soH+vbatiaXgBzlXA3kJGU4Z4Z4irmToOUetjNurnEJU4QyTmVSfH6u+wvTEgl9cGQ5gDKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63K2WRUnghLfbvVyasQJdPQGNO0UQZjvc2wTsSf5aqk=;
 b=Q4yupmIPtAKHGD0S6e0QCZ5msEHQhNXBFmEIGDzri2Peak6Th144Hua17C7+lDSY7AnRthqAHx4LFGG5IAwNEwEddRVoQt05KyTPM7Wdmm2IkN+jk2ZdYG13h5gpdZNldSyIiGWpoM2mES8w8cikpxv2R/MlOoDqZcodmLr56pwX3x3mlEuwI+cC2Qhggdwbf7Jl3e9VlARXRZx6yottk7zRxgJaMBybo11mKzh3tBaZMQv9CHsEn3DhYEZb+66oSt4nwKgvtP5T7InT+NhJ2GKT3xtc/julCO7GeFLZmrmfFNhY4K0C+M6xvFCjs9fro22mJGdyXBjco3riRRHN5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 20:51:07 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 20:51:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, willy@infradead.org
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
 brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
 linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
 yang@os.amperecomputing.com, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
 cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
Date: Fri, 07 Jun 2024 16:51:04 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <45567EBA-5856-4BBC-8C02-EAE03A676B94@nvidia.com>
In-Reply-To: <20240607203026.zj3akxdjeykchnnf@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-6-kernel@pankajraghav.com>
 <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>
 <20240607203026.zj3akxdjeykchnnf@quentin>
Content-Type: multipart/signed;
 boundary="=_MailMate_06406E61-B432-4EC8-A71E-9C23CFD2670B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5849a208-deb8-43fd-3d82-08dc87338e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6eGxYzdgSmblg57Jl+ZJr0Fq4NcBBBAHUWg3sXO5BmzpIjVEpA5hCX0O/E0?=
 =?us-ascii?Q?pQ9Q2eTD8UNOlEiuCqs3y6GTnm97696qO389c74n526MYBb6JHJmP53qcB7A?=
 =?us-ascii?Q?nEhrBF6r6Ci3vfaOqzRjvFtJhx9opZQ3Ps4IqvSryhGxyno3UglP/3+xOTiq?=
 =?us-ascii?Q?/joLlaSiFAfMYUXNn2u2tICALG2ClW6YujsA60TMj/uVf4wBiKlhTaOf56e/?=
 =?us-ascii?Q?G5OrmpwczDt2f4rkK+KpGmMBOrueolOW34/8wn++g9GUJ3cZ2O+FD7gww+Ey?=
 =?us-ascii?Q?TiX4z0UnabbV8vRNUlY99HG4rHVN2GdaKd+FRr9h8Ihhtdhs67pUqdmRWzLI?=
 =?us-ascii?Q?0epK1QcZFcexcSo/+KsW8svL1kF6+ofOjmkSTvbZP/WzNkrIjMrC5vDvGpVB?=
 =?us-ascii?Q?OHeRJho4rZyuBW3L7J2T9rqt6PoMz6UgvvRnSrS5FW22M/OpJ+5EGMgnttgQ?=
 =?us-ascii?Q?4THK5cExS4oezUhfngE+S8ZNzfloqJjX1uOtX1jwH5jjVU+qp5tu3wkMeUqg?=
 =?us-ascii?Q?reEfsQUGQ1JezxBiV7KzfqX8cS1tfbCBMuBS2q+Kjv4SlEyFtAdiEh35N5SC?=
 =?us-ascii?Q?vDS35qpsroZKJk7yrwhT/QGbGwm17rwMJNIwYSauKM5duIpvCbeDpO9JE4iq?=
 =?us-ascii?Q?oMcnRxh7MfwICfGi23ot2w/jDC8AV+Kzt/60fdkqO4QVFEdzbNPQvS0ACXnJ?=
 =?us-ascii?Q?ijDk6eoll83MCH1Aw/KAFM8EqZ//AxC9We1bGEoBHjMl7AwY2ZYSYbXJtqm6?=
 =?us-ascii?Q?shJMYS3KhPnTN3OpBSJMWDxhXHDBXBj1+XmMtYhwC44OoaFU9b66tMkostCV?=
 =?us-ascii?Q?CTedAREPcQNRzpdPzYSJd7BrC3dMmfP3cR3kJ+mm18Z5v7jImNUSYY9N0vZf?=
 =?us-ascii?Q?d/Tudwmr1we43JNU/ZfLcjDZwX97T6DvYrNoxorWl98uOWj6P3Qx9S19pQ0S?=
 =?us-ascii?Q?MfFb8mfz/oEN9qswRTtuxEhzHbyMQTzLV19kCME7nZW32PisglC1lew8wJhi?=
 =?us-ascii?Q?ap1BBpjze6lL/JJnCpI2u3rISjdQGmpq0iU6sCE7PYk21KYNhQqrnq0wEfoI?=
 =?us-ascii?Q?oWeMSvzv0ZyDK5zdsR0K+8ZuNUJ9m/Z81ZZQeDk/eNj7QpDRlbIR3lZgtN0E?=
 =?us-ascii?Q?KuHWeEUt5yC/gG0isxVKQ3j5DeAP0o+dIWf2aBl9b87wa5gtfn98joQBscao?=
 =?us-ascii?Q?Wii7tkhzlSlFJFT4QPMU3+4ybPaUl2N0vpQpd5vjNPfFbI+4/IFfYjOqXbuW?=
 =?us-ascii?Q?1b497BVHTkPRw0rICzoPNfRWQc+P4mn1skzk4QQps0wi9dKfLpebkasLAoUp?=
 =?us-ascii?Q?fFamT2sd693UeR9Uh02O+9iR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83zIBuxpfKz0e15DjIZZpsQ8zmnibiGnmPbk1XtMjh9IGl8XZeFksrvBaS3o?=
 =?us-ascii?Q?hMDbttzMx23rHt2hrhrMoTbjOzc/cv10K4kWsqBgkl/IlHY4bNQMVN7fhkeD?=
 =?us-ascii?Q?haa2b0F8QIDJr7uTqkIfcMkk/T3I44I5iyif2x5LuEC/sHqmRp1b8s1+avgQ?=
 =?us-ascii?Q?LAGzAxzgFlOD08SyTvjiHxqgrijhDz8f6v5nkzbV6pAGQgvePgASFUSSykto?=
 =?us-ascii?Q?wrRs6gZ2ACpN6GXc9bjjQjKDsoRQgJ/ZD4SQjH4qhkev+g3ChdNkTpgKe5lQ?=
 =?us-ascii?Q?OWYGC81tcGEK8Nf6LJMpeIMb6Gh0OlBOzrFYaXETFkKbw0wV2DvGcPc8hvUV?=
 =?us-ascii?Q?8HQjMcN0tT5M3SLm2Gj3MB9PPT01IZ/bYLKaR78dWjxo0PwJ3MC73Qs6daI7?=
 =?us-ascii?Q?C+IHH82fxbfCIabMKrAPxE4fQZZkXl2WY3pT5TkVStGn6n2T4xtGdsRdfwGS?=
 =?us-ascii?Q?vwjmf7jgu9RNlkO/lOJJVKogDJJdfK71we32UU9ZSAJrU92oxRU5I6eucpGS?=
 =?us-ascii?Q?aPbv7wOpTx56l6Mq5ps8ZZvCnMIITRkstsra6LhGXxVSsUOZ3SdaB1BXznVs?=
 =?us-ascii?Q?qHlAmvT3n4igQscSIht4qTfrS6jhsrzcrogfaAHkJTbJ0Oaa5K1YLhXOhKHX?=
 =?us-ascii?Q?zMeJDW1HQCl/hUoovs0mfD1f8gd5kvKVomiOXE2NRKATTsBIdut7pMPVt3FC?=
 =?us-ascii?Q?4cJ9QK/dH2DwpdSwZFL+SUqCEDEYS1w1N/rW+Vj94UHQScsoa9cX6k1Bnh7G?=
 =?us-ascii?Q?KJ1do3ae1echSViMDNs2WmMa7TQiRNbcjCG+00Pv1Flql2xWd0A/dkwxMBWK?=
 =?us-ascii?Q?i4DmIoIggFpbxarjLQtOAiosLTJH+dTZtW5/dBdPe0eu0hlOSX5fj5afK7fA?=
 =?us-ascii?Q?SsN/xK2LsEcrxE48x5GW3yHsNHdJkj8sGu5NJ1TRyVhNCfXgpe2qABxiG9Xp?=
 =?us-ascii?Q?q3KPXHOs3gNLCq4X53dGBiC5NcJA4JZtCDLkKO9KyizeUfHKPKDTI9OXlvwf?=
 =?us-ascii?Q?0P2G9PxGG/9LmiwUYUDkZg3BBaLOh/Z2hXbWhHZA+MnPOkVpGTkK4kHCsA3t?=
 =?us-ascii?Q?o80kqukm6AUskMijJBU1NwgGGe8WEnB0voNXol0ByPZgyUObXvsVWGEE5TvF?=
 =?us-ascii?Q?Qs570nhEGU45l7hEi02TYBrGqRnlfv+6CgLw3K369Lk8Qg+7afN65OSDqufs?=
 =?us-ascii?Q?K1/D57uwJaf+S3QTtKTh7P9PTB/sq5Ou2T/UxxqwRbclWH/gJr7dJRELz3W6?=
 =?us-ascii?Q?STlVEmgF7g1XiZ/9XdQXkW+eUMNoJZ+uAZW72LKzbNNLoTbs6N4lfKPZ4+rl?=
 =?us-ascii?Q?iLLNVD7pVGlHEd54JHqAhsL1Jvoby68LSWY+2hfe1g2A8otGfr8HAoGHnczx?=
 =?us-ascii?Q?bPqOBeyRdGE+grYAfjK3jeRr2HsvzOkYjKxAe46Q/GbqinV3IbxuLmOA76AB?=
 =?us-ascii?Q?eAvqgXKC6L30/HpPuudpV28AlmzUSRmnqRH+1B8Wq7cw2a9qD9EutKSnypMX?=
 =?us-ascii?Q?lviOwEbKEu6NcKmuTcM4v3qv0+s3o680bGYPVqwYAMeXYHX+L6oixhzcO5Fc?=
 =?us-ascii?Q?lHxAg3MSzSSfaNK59WUtb7YUbUwkHP7JwILZBuWc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5849a208-deb8-43fd-3d82-08dc87338e02
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 20:51:07.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oV2oDU+4OzASooMAX+E0AFUbreFJy3gJgt4q2i1fRsI20qRgCaug1S2FkbjFoZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

--=_MailMate_06406E61-B432-4EC8-A71E-9C23CFD2670B_=
Content-Type: text/plain

On 7 Jun 2024, at 16:30, Pankaj Raghav (Samsung) wrote:

> On Fri, Jun 07, 2024 at 12:58:33PM -0400, Zi Yan wrote:
>> Hi Pankaj,
>>
>> Can you use ziy@nvidia.com instead of zi.yan@sent.com? Since I just use the latter
>> to send patches. Thanks.
>
> Got it!
>
>>
>> On 7 Jun 2024, at 10:58, Pankaj Raghav (Samsung) wrote:
>>
>>> From: Luis Chamberlain <mcgrof@kernel.org>
>>>
>>> split_folio() and split_folio_to_list() assume order 0, to support
>>> minorder for non-anonymous folios, we must expand these to check the
>>> folio mapping order and use that.
>>>
>>> Set new_order to be at least minimum folio order if it is set in
>>> split_huge_page_to_list() so that we can maintain minimum folio order
>>> requirement in the page cache.
>>>
>>> Update the debugfs write files used for testing to ensure the order
>>> is respected as well. We simply enforce the min order when a file
>>> mapping is used.
>>>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>>  include/linux/huge_mm.h | 14 ++++++++---
>>>  mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++++++++++---
>>>  2 files changed, 61 insertions(+), 8 deletions(-)
>>>
>>
>> <snip>
>>
>>>
>>> +int split_folio_to_list(struct folio *folio, struct list_head *list)
>>> +{
>>> +	unsigned int min_order = 0;
>>> +
>>> +	if (!folio_test_anon(folio)) {
>>> +		if (!folio->mapping) {
>>> +			count_vm_event(THP_SPLIT_PAGE_FAILED);
>>
>> You should only increase this counter when the input folio is a THP, namely
>> folio_test_pmd_mappable(folio) is true. For other large folios, we will
>> need a separate counter. Something like MTHP_STAT_FILE_SPLIT_FAILED.
>> See enum mthp_stat_item in include/linux/huge_mm.h.
>>
> Hmm, but we don't have mTHP support for non-anonymous memory right? In
> that case it won't be applicable for file backed memory?

Large folio support in page cache precedes mTHP (large anonymous folio),
thanks to willy's work. mTHP is more like a subset of large folio.
There is no specific counters for page cache large folio. If you think
it is worth tracking folios with orders between 0 and 9 (exclusive),
you can add counters. Matthew, what is your take on this?


--
Best Regards,
Yan, Zi

--=_MailMate_06406E61-B432-4EC8-A71E-9C23CFD2670B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZjcrgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUi8AP/RQivTaSeweJeUuW2/s2USFRvFpVT0LV8XoX
U6g3p/4T0l3/lcczl6q24qGw4AGcYel6OHZsqS3QcV1nMyK1lvqawdwqvUm2o+Go
n4+gFi+/tbuO9yXAGn4WF854dE/dM7vpqjPNEODnFHhWOi4kD6wEPUTz+hHmlgVE
CpA9Urk1U+mvuI3YegpUh5PapZpusZlDNp5hopoG03p8ssMDAfDqhtS9XPKCZRz2
lUHIWj2UaqodZx/dwrSzRMrMzmRdYUa95BVDlBkfQW85LKlpdh6e27muIMQTQCR6
ZnkiUFXhYgirMJ7f+snH7MvXaSZ++wFNiDbC3ofyy0OKaJPccqTi9uVodSJnRgyu
ufJUkxDEXjnevdbZ0QW8zrJ+KAmaSBatVfUjrt6ni5QDSfnKQ02LH6nTLy7zp9Np
5gQWOWSIoNn14TkY0P9+QlnQxTZ+/SjHb3La4TgOZtP7ImM4dfqenaSJ8uuMvLjc
d5fbCwzdq6ptTQ+Z+LVmYI1dCjDB4iDHHqSs7WtaNmBJ22btc+TVgZzfdkAMzprQ
p9xtZCZw8kIB/BnCMHEWC/kXKvPSNAiYpGMS3kqnZI/XCcJY3ppCch7EOqS8dLnL
K6bbOWIZj/WdDoiict/Jdl5JDK6qPYJfdRCw6rBcAVC/SCEEJ2F+0F1n62YHBVKG
wUFNwaec
=j0MH
-----END PGP SIGNATURE-----

--=_MailMate_06406E61-B432-4EC8-A71E-9C23CFD2670B_=--

