Return-Path: <linux-fsdevel+bounces-15360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49488C985
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 17:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C701C62BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA131798A;
	Tue, 26 Mar 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maODXszE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256F4C65;
	Tue, 26 Mar 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471133; cv=fail; b=BHB3sxFlN9BBcxKLvGGjeLwWpl3jRr6NFtGhdSMJ4bbAYLGs+ay1f5QoW0w6RwR7DzxNOf0uhnOLzJYRePlK783bP7pydjXGzQUd0cCpMY09bBa5E+1hlApgsWar3Ow2GG/gGIqpoQUePDzrG8bq6wgQ2AuA837loDK8Atg0H2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471133; c=relaxed/simple;
	bh=9GI/2QwL1QF4BlMAInPTCBmRPTzr0T+4LFR1VP9RPGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ds5Y6/GIHX/wsNfHNrvMCQxq/NxxEYhKQBgUo6JZ20KIOhFfZB1l84vqm7kVMapD+zlzS4HSmeCLlt6BHJ0TDrNPZCOorc1KBfn2eTfZUQR5oMo+BiVh2X9OGLQS2frf0GupNymiOicNhQKf+3SQarFtKt3WmyHzgIvOBEAelUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maODXszE; arc=fail smtp.client-ip=40.107.243.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6cRr45iDAUc4ZWA8BW/T/LWPW/5l0TirpLxyPXRj5gGgo8Pc+5T8D8GreEO4QeJF476g12hO7unYWdSBByZWd3fieU+EUe6oDcuomS0JHo1RIzsg16FS3BFen4Fb+cObo1bqnZt2kkUQwxkS0JSohmzYpvthlgI+4kJ9FmGdl+fEiyQqQaKknXv76LCLjYvrk4QqNEtIie6pG8qFgPghIZPzJmFVPsuJTVYWVWl/GNlR9q364Ly148for4/b/J/Sh0LeMDvz3fzWK8Ed64kwwEaYIOl4zwyD5Wxz0iRihcs3txVrW1xm2H2zIuA9TuGrfyyo4cD3ifQHvMgz+BNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArU877++NHriwCkgospQwj7hObMjfQ/GxS0q0Cwr25Y=;
 b=h7QHiBRT0I6EUurzhmc/5X+ehG9nl21ub8aUoOutY+Xx8b4gBMTWpdyltrLYkAYstSqUivXEGeK1drWFaQYmyurZHEkqlG1P9JOle7Z7gD5flhkV5Sc1MDSzHArdWs3hFdrBPM1w+cx7O/vA9SnIqmHTwnncclHfVvNb5KJox7Fl3PAv1qmunkqyzHW/+GIF8urh9MJjisrNq8r+WvrGFvTKa8CPp96DoEQjKD1q7QTSAsMe90Chl2+4pYc70QSVw6yKRPaItOX9tISsR3k2LIo+1PeL1nllVB5EnYV3LB0Eqg2eUQUKWE8r+5ysmxYu35KTgRy39NAW6BBlgvLxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArU877++NHriwCkgospQwj7hObMjfQ/GxS0q0Cwr25Y=;
 b=maODXszEtoPRk8SsiorA77nyEEbUVUocBhDfRQE/OBqI6My3lMJPgDxE8Z/Cg1JymJYLvUMwYCXfAJZHGoAEysrybR/aSmZTwqSqBj8d3eUzMrvhEs3WwiioP9G6t880w0dTiDJvIH3P++G3buy8bNXlm4bjG/nO92nZTGS8oSjbNawS9nsu60zD+fPl3vC6epJVQoi9BjG4Hp8wfF0Yw9Ju3mDS5AvoBX3tzTlofzuXs2YqZIrHTIyYe+VK1CNceo+bhHyK/J0YsBLl6yYbnW2PHP/RpPArMaV9s0Js3nmZQ+o6D/qXMOOnsUAY7zhb5q1cEyv5Ky2zVOtVDyt2rQ==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 16:38:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:38:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gost.dev@samsung.com, chandan.babu@oracle.com,
 hare@suse.de, mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@fromorbit.com, akpm@linux-foundation.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 07/11] mm: do not split a folio if it has minimum folio
 order requirement
Date: Tue, 26 Mar 2024 12:38:38 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <35B8EDE2-60FB-4376-98BC-DF79C43F1B68@nvidia.com>
In-Reply-To: <c0c777d9-8393-47f0-b5c3-1617c3a7b3ba@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-8-kernel@pankajraghav.com>
 <ZgHLHNYdK-kU3UAi@casper.infradead.org>
 <muprk3zff7dsn3futp3by3t6bxuy5m62rpylmrp77ss3kay24k@wx4fn7uw7y6r>
 <EE249FE8-2FE9-4BB0-B27A-6202F93B6C12@nvidia.com>
 <c0c777d9-8393-47f0-b5c3-1617c3a7b3ba@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F26EA42E-76E9-4ABA-944B-D33F85A7FB4C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB5667:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7EqKgd9/g4B30MW1i7cYnA7LdPxhVzq0EFu6oCG9ih34hOjAfLOx1UsMR8I4IQRjsTQG2fz9PHVASK3lCAXh1V4a/XvA7lMh6mmeCkDIa5KVJVoR+Lrrt86kATxL0wy7Jb6P+LtnLBOwmwxDy5Jd2x9TfYwpnMawMBVd318czr1Aw28Hac7/fCbLX8SqPGmWuxEG8qi+ol6FY43t3qg3dzobYJG7Z1b96fbAUUumG7ZChdHe11ZEtg2mI033rOXBVuYzdaPmF9/96WuRzAhy0qdLlq0ym680CgoI4FOQSUBbeJxmLV0gA+GM3O/73Pl8/LVRZY7uaqof0/yI6miattFBPIyO1WkZsOo1TOuAuOIuxGtixNfSAZWUiBAkEefuqtup4193OrZhHOAzhmGLw5taVRzsRWsoBtQJYwDRo+gPn8hiVXzmmIqJdDAJ/NlLgmxibLtwbImQBKK8QCyJG761eFC6t3op3VMvNmo+M0sA/KiNtym5/Fz7U0aqZMhCC50XbvyQcnJEN/3rx0j3p3FiHrIb0TXLWknS7B3FgL9Chb0iB6L+xfV0sQxX9fQ/nppwvJSHgO23I5S1g8Vsecofxw+TY5/4BHksNwEtvBq7EhIB3PBEEnAJUMRMu6bZn37hKG8GXwEHqSZGFRc6vTQ7p3Bltx/cXWPCOgPU5+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fybVH8zCGeiIJPCBszMSDpdYDSBZqOALkww+hp/AdMsRriVnMaF254btSYaZ?=
 =?us-ascii?Q?2t5Ykcq+h1M2kytIBKzIaX3GM6ovd2G6jkuYeITiU10f0GvJOn0DxTgxtqgv?=
 =?us-ascii?Q?BQOxtdhBZW3S4DA7ZiBJCppaWQTQHjQ8OYWEBxhM2qR4/Sob8I9s5WvEB+up?=
 =?us-ascii?Q?X3RDFBuEdIQ3Ve3St/VGWmzJ27ERhCJ8eQyJrPGsH96GXwOReZNQleIbScVv?=
 =?us-ascii?Q?6+psmGlqd6+bzTH7ykHkViOazDXLUL5+dRcReAvsuLkJvu4fLnNk1Y31I1n7?=
 =?us-ascii?Q?ryXssqQnlkBOllM116qgToTI7PSO/T/YF5r2mG6M5CnqZWZEIys5cYt9Zqbq?=
 =?us-ascii?Q?/IGim8tzZlYATyIn5IXGqmKxopq6gYkOjmF1rJjTedCyCgFH3lrjVeMqNNly?=
 =?us-ascii?Q?g45UTS59JnC6GtspYI0B2Kn+2OtMOOOuFKEU6hSs3/HN3kqeCLYDUW5bNya9?=
 =?us-ascii?Q?oTzeR1a8qBG2I7sw/XO7i7FhY/72mPmqj3/FK7UKZHfZukcQXo9jgIt4aC/p?=
 =?us-ascii?Q?UJ3amNpzA9rEpQdzRldXNbf5n77y66Tk8R4DlZwls6N53yqtmJUsqhH5MOdd?=
 =?us-ascii?Q?lueuLJ8+QyGNqA9cYCX4MmMhAc+h0zHIMveRXRi4wnjjX7PHeYhqK050NILg?=
 =?us-ascii?Q?V74O5SIlBo0UF309RbDxKRpttOrLjeJJ8A6L6+Z0lpvx//QXg1KZG0CNWcec?=
 =?us-ascii?Q?NJX1h4IPQwAQp+fMjBRlEAgMsBKSH9Q2pXltyJ1Os+yd1Z7tDLNaTsswmFa9?=
 =?us-ascii?Q?gO3vGhmBLYwzJ4exz56EE4M3taGEodqdXpDRKwWerVjPsJxofKjsy5NuryIp?=
 =?us-ascii?Q?g9cc1R7eH4AvFzqEeGfJkrJcDkUHrnNDa2qL2Z+5d6htWpkJUwqwkg21KuCE?=
 =?us-ascii?Q?7pHxvNObhjGg0AP0ZZJGNlBzqu6hRt/S5hEXwTvlwKLyPM5G11u/grE4yEcD?=
 =?us-ascii?Q?V+O5enoe0hPGhjNKREnc3LAt7QcY1XX/dKvSZWFx2ohPh97tfAcQzHtBNnKu?=
 =?us-ascii?Q?6KRNgKaRaBtLzfChQmN9y3vW5c+zfuy++S25EsdpeqPyMHO2s6qpx0WP55pD?=
 =?us-ascii?Q?ivzL/JJ+WUesD8MtoUjF1tcfui1NolpbaldsH5z7UqaG097A1boe4ja9/LgM?=
 =?us-ascii?Q?my8+gfzbi+Bj/Fzu3k/WAALymbZb2GGRDMPsQhRmywhF3Z2CailiQr2aFNdU?=
 =?us-ascii?Q?eOIOHdwMafz/nd21arjw3SMtDYEKCvFgvi1IoVWujEYN9z94Y5m+ltfaAt0A?=
 =?us-ascii?Q?k/yt1OKTN59uvBek0X6Q8GB3+VSQ2CUAtPZX6nLBHWLcpUamv7VszmX6Fe+C?=
 =?us-ascii?Q?04WjtWn8fKL9vC3/6+Im5W/2+0oy1DT6mvtzEN2i+yuEIvRzObZW2aNCsYkF?=
 =?us-ascii?Q?Q5vH3KpSs1GIObLlFt18rNcQcfcJiJxf+N9s7MKFa0XcoBNLcAgnhftbTbnx?=
 =?us-ascii?Q?JqMtNBDnxn+1KfdqO8cOtJgsDDd3kD0BO7J7I5OlCaMIlWW1BlHmLgRxVORZ?=
 =?us-ascii?Q?eBeC1OPUjDHMfvYnCg67wo0RLC/JkfiWdsqRsHkU3P2wA2eSNgGKbDwIC3Us?=
 =?us-ascii?Q?gvjA48Hjl0VT2baBgAWBONMvTXBoSsM+p2oyxgc/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c590e2-d619-43f5-3894-08dc4db331ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 16:38:41.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SaUYopmsu4PaK7A2CjKi9iE7adrCxnOBW5QLTttcnsaHh2bzLS45cSpHL812Mt/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

--=_MailMate_F26EA42E-76E9-4ABA-944B-D33F85A7FB4C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Mar 2024, at 12:33, Pankaj Raghav wrote:

> On 26/03/2024 17:23, Zi Yan wrote:
>> On 26 Mar 2024, at 12:10, Pankaj Raghav (Samsung) wrote:
>>
>>> On Mon, Mar 25, 2024 at 07:06:04PM +0000, Matthew Wilcox wrote:
>>>> On Wed, Mar 13, 2024 at 06:02:49PM +0100, Pankaj Raghav (Samsung) wr=
ote:
>>>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>>>
>>>>> As we don't have a way to split a folio to a any given lower folio
>>>>> order yet, avoid splitting the folio in split_huge_page_to_list() i=
f it
>>>>> has a minimum folio order requirement.
>>>>
>>>> FYI, Zi Yan's patch to do that is now in Andrew's tree.
>>>> c010d47f107f609b9f4d6a103b6dfc53889049e9 in current linux-next (date=
d
>>>> Feb 26)
>>>
>>> Yes, I started playing with the patches but I am getting a race condi=
tion
>>> resulting in a null-ptr-deref for which I don't have a good answer fo=
r
>>> yet.
>>>
>>> @zi yan Did you encounter any issue like this when you were testing?
>>>
>>> I did the following change (just a prototype) instead of this patch:
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 9859aa4f7553..63ee7b6ed03d 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3041,6 +3041,10 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
>>>  {
>>>         struct folio *folio =3D page_folio(page);
>>>         struct deferred_split *ds_queue =3D get_deferred_split_queue(=
folio);
>>> +       unsigned int mapping_min_order =3D mapping_min_folio_order(fo=
lio->mapping);
>>
>> I am not sure if this is right. Since folio can be anonymous and folio=
->mapping
>> does not point to struct address_space.
>>
>>> +
>>> +       if (!folio_test_anon(folio))
>
> Hmm, but I update the new_order only if it is not anonymous. Do you thi=
nk it is still
> wrong?

For anonymous folio, folio->mapping has last bit set and point to a possi=
ble struct anon_vma. I do not know what ->flag will be or if it is access=
ible in that case.
See: https://elixir.bootlin.com/linux/latest/source/include/linux/page-fl=
ags.h#L608

--
Best Regards,
Yan, Zi

--=_MailMate_F26EA42E-76E9-4ABA-944B-D33F85A7FB4C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYC+g4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUjW4P/1bIufbo8IwzNsp+7LAjRPiog7nMvmIjLT0G
VFsf9ZwhL1Jh/exR3duGwsTb3W4mJiuiIkC+GlZB1Vx9bzW9IPBb+jpEFk/VBm5w
0hTAC8/8fcnXgQSRbJwb7wOEZP84on2dQFudh9b/wIJAFboXc8Y6X0Atr9crFbWp
ZeRHrt+jXhkmZkdzIBwIFg2YA1j1kY+MsmlAFY+N8C6Svs1rNkCcx7UlZAjM8sMA
TcUDR2v9D9f3ozeWx/uiaQd7oek+i29WqypCCIWGYB8TvnpKxixGbgarU0aa/8sn
/VKIfydyWkwM1f6z05FqvvwlQsg1iVTXVbcGOBbtfl1OhFnXQQ+coJaSKPjwdQWI
9N4QTmwPd163MOingNG2C7yXI30NRGhM/UW/ABRUjZayjcezqzixr4KJbLAn/xVD
BYp5T4YtZUoNlUkX7kXADIq0/YJ+DhGaW2O0tutjWdRGQ22jGYjpATdBQUqfST0J
/gAL5uAusx9znytbAErLDxzHAlTbuXJs4X46SxhB50J98vG9MIc+SsR3IQhbzsJl
QbdBlyZQy6URae/kePbTn4zuX4YykPvM+l9pfBIMNPmDrJZGR+oOMHQVRIqtJsy8
AQAQ8keL0dlzDBd9Oz6ystSA2EzT3pHBg38GhXwwsm5aL+S0lD8TPlooBVkHuSma
z+XOW/lW
=CSUv
-----END PGP SIGNATURE-----

--=_MailMate_F26EA42E-76E9-4ABA-944B-D33F85A7FB4C_=--

