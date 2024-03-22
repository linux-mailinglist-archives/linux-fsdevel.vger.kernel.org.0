Return-Path: <linux-fsdevel+bounces-15038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B688644A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 01:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AF82826C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 00:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98575A48;
	Fri, 22 Mar 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YlL0RuO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F2637
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066613; cv=fail; b=MWoupbcCHwxvdDsbkef1e2pI8A4gOJqtrZL5ZM93oRn+BoVzsBUmyweRnx5gAYj3a7uM2MnrzuHf5gCuacAO2aFdNmeAOqO9fFD47JZvve5WRkmqd2v4mYwrAdpGfoDMxcDrwJNPygDR3ZD/l8NZwjHVdNY3sn5Pb/NaJM0KZRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066613; c=relaxed/simple;
	bh=s0fTYAUDj/35DDZOayIB5Y3o8+uYXIHgCJ4fQA9magg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=Udw7pFYjr0+zcBq+KTyETGyTliFDpoPIrQ5aD66CCNx2ljcj9erqiKw4puXuJXBwjvHRLJhT5KSUdaKQM2DK5w41xoJCYWDLNa8uyvpLGq3uBhc4mvZR3ynJ5i4UQufkj1lbgyLX6fPcFYoLQUPezU1X9DXg7wtEgfOe+F/fNWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YlL0RuO8; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy0hoW8jW8Hew4KC+XpwsBswIFP5kNB9kPuI0OVK6eqZ1XsMwLsIz989fwOz57WiW+pYB37cZ8/CbgTIudkn1iaeJnM/Qpd1xX/Ocv5Jm79zHDMbtgLkHC3sAa8tqgqwdxmMvFYOeyq0nD4fclHIL45Hrmh7k04+O0gP1EVRh9VRwVWntc2NlMPnnrGpPiAO17AKlGBxLN/ynXq4/XX/WJdLe8lsLMrnrmaoyvVjyVaCrMeBFjm/baIG3asmJLlp/8ZoIqUDZp3r30XqL2dVtu1VJsWJUpkVRFXVQuK7L1x0ME6xKVtKvi8MoVPNsgHEGUWx4YmFaMgGm4V8in6Ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peSGCTNN4d0KB/c9m5SUtHQjzyZArizj4p6xYWRHa0Q=;
 b=LJ7cwYB/aMFdB1Rf7Pq2MesP81+bxXR3WRbslmR7acwYiNI+POXh7stLNgLckbaCSyYsE0wJ9rGkzcCGWxNuLl2AySdcQo2/ySC7Yj0vryn+Edv6R6cB9+Vw0BlcN/jlZXnUJBqVdPmLsTxv8l17Hv3H6bnaS6SEZ/xh5ZxEzlF5G1F80SvdHOPE2Ilqe5ys7QFi5SV6/m4t94Mu70qOES0rw7LvqTyzpvrOV+gIgJYc9A/YuySC74TZzWcfZV7Dca212mCznvSK6mKEaxMtUfSnktQ7gAJMB+mpPoSpFeU834sEpeGowPFgix+KxCXjShRmQaZ6UbP5KANIE47EtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peSGCTNN4d0KB/c9m5SUtHQjzyZArizj4p6xYWRHa0Q=;
 b=YlL0RuO88VRiCDxGc5gMjZ1r09Lus1kgj9AI/WPVq6aK0aiidJ1vHJ0oYSNTHqPDPU/z7QijdM+1eKPWLii8drQPKz8x7zkKEsHqtzAnYqBlwaHUslkZUy83pVCBAyCRsdA7zEgRnYzanr/JfgJjP3rrA8PRE2X6dgz7wSugNwlu3XqRwAB6NUfNsTF3JNZG22VyVxvHyQA449yQijeZIuDyyti81hdoXhBNeYYT/hTiEb/SXsWkPiPkmTZvhi1qTCzWVYoE4d0LU0XC6cpx/BfuRcOjFGzjr3tdYPQnGuJxFK2hY3Szjyp3VUqt1xyqGZMC67sHv/tEhJiogu7oCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Fri, 22 Mar
 2024 00:16:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 00:16:46 +0000
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
 <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y1ad776c.fsf@nvdebian.thelocal> <878r2c6t99.fsf@nvdebian.thelocal>
 <65fbcdaf2042f_aa222948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, jhubbard@nvidia.com, rcampbell@nvidia.com,
 willy@infradead.org, jgg@nvidia.com, david@fromorbit.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com
Subject: Re: ZONE_DEVICE refcounting
Date: Fri, 22 Mar 2024 11:01:25 +1100
In-reply-to: <65fbcdaf2042f_aa222948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <874jcz6ryu.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: d8604ae2-d875-4444-4791-08dc4a055c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UkSXcPV4Fne6yRtIao7SKjaoKMtFsl+/TDZB708bcZdLMosLno1lGzb/4R4LVEIAqw6gOluYPbhOuR3YVfcyH8q2DWlhFb5fho5mgg+CgZn1zz/J3NpvdpQ4OZXwb/ZZbEBImXXCIIUl/dEN4Boo9onrXrVuey7Z7ehN3FNf/QE+QIPEA2r4Ah5yIGqHYnNI6gLAXT8gNtj1KGRcoR7OWK86lr05SP13tXKimyVgrTE8RpOmVKf35q2ckA1UpFWHjis5rfufv8qRJl874VEzO32XH0XWiWcZ9ZG7U1S0Mm/5uksDPXJMIq4oXG9LKA2Yj0OFTnQGT/Wv3v1hQnor8AhR/zdq7Fn3GEmiBky4AmwioIpyMvTah+DjIX8H6IHOhvvkAUcJUaTYrb4IX7HVuPFeMi9l2wfbXBbAHMaAmNzxB0hdyycnyZY9ITWMPrVOx3QYIBOB9I8oq48GOVS5+xmFj2jXQYCzujF3GPv+41X13EHENiQUR8aLH5bQh3H1oKDL2NvWgAO3/Foymhde6+qhfwlWXsnOTq9MPtkeRi1R4xkSmU8KIkJR7ylb6eC5aVrniIk06ovvPKRuedNemIxAcijybeVi22wOxPlGHyJ4ocau5pk5ft5EnLwFh3md/e1kFRjf2Iw0crYzGgojaXtVi/5SfcUuMGwu0m5rJ58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2u79CtH6XNZ3ZRsKbjX/ct8UgofZ1U/RI+CVfLB/XvtKtuq1P88dNbCHxuei?=
 =?us-ascii?Q?Z8ADyAioqBf5Nz7k74fxeKqv74ceWM2JzAfaVyuxSHXI7y8HkmP/8j1gMOUY?=
 =?us-ascii?Q?isJ6JJckoFY/37gUCbIUGs+cHThUF2KzGztCQ51mHcf2/CJ7dSUbRWpEPkLs?=
 =?us-ascii?Q?NKGmtb85hJZU84GGykLCR5cOT4mdHdLoihseWb5ExeX8B3AyU074qDa9Bu5h?=
 =?us-ascii?Q?t111VGjJlw9xSm1nbQsL+mKTG7n6xlh4H8h7gdKiI1imyFm1K4OLu6bWOKvC?=
 =?us-ascii?Q?YY3FG3pMtysZ2X6wfFaPS8BPScXsqjJgtCNXCld/z+WzWvdaBv6IKXSq17MM?=
 =?us-ascii?Q?LWW9msQ14TevXbs06nE/SEl7fIq+mjFfOK1VwcIBjc6bTMpTxqGkbVtPq560?=
 =?us-ascii?Q?a3y0UrqZBhyn/krnewuDa1ABWLUF8Xl7K57fk0r3wR2UTP6XpSipWZkNCBDN?=
 =?us-ascii?Q?llUzAw18gFOyVgL0xP5qWiGHPEEwzlP1PgQX8O/wzfTsVrRwh0Opvp8D5JkL?=
 =?us-ascii?Q?8fuwIUSLxdpLJKkTflmgEnhiu38RWgOFXdr7VneVgPtyBBfrp9ruXkxP7CVF?=
 =?us-ascii?Q?QjGj3NsVDORTJWs7+LrZIUZHTRIXtXPDMNea1Zn0hk3mM2a+/XSlDWTztlaW?=
 =?us-ascii?Q?ROC1NIKX23M8i8NENqiFnfrcOxs0cnM6j83Q8WXNwte6WX3ogw1h26z09t8K?=
 =?us-ascii?Q?EyI4jnEZ9MniBn67LhCb+W9yLPSYazdOtURh4yXPD0r5BOHF+BsxANI7dPpo?=
 =?us-ascii?Q?L2oEWub3MfbKs112dlXHUwvDtX+qbD5KInRcqarTsQyQMEeq6PQRj5YAAdrq?=
 =?us-ascii?Q?DK8L6Lm4WnyZfNa6oyzw/nN6rnSy/RMThLRpfJ0AplEjqnNCilplxzolwuF7?=
 =?us-ascii?Q?mngVdRquiXiniz9sME5zRY4MVvT8F8zrR/AZHMi0mJxRuy8e8NehOascg+jF?=
 =?us-ascii?Q?4J8QmXDFfrXE7dGXWm6ow1CWFHLH4KxqZZMi9MN95tTmgMaozkuBK+ay2Mwb?=
 =?us-ascii?Q?A+8GQD3Gq6y398i30u+dcNZSqMSYeZciabhsJ7csh301wnnGie1ho1Ill6id?=
 =?us-ascii?Q?jxV+KtUq45wTKJK+fMwz+6ZWmX1/Eif5yGmDIxJXzibRmAHlU56+960k9UID?=
 =?us-ascii?Q?JpKK4WLwU/qMXeAy6uvyz6oqHVyAeHOxOWtNDuF6ztzyuMvr98LyXcU4Cdmn?=
 =?us-ascii?Q?rIufVlNe3jy98LpnG+U7coPHUTQY/R6w1b3flqGFDHJPMKO7mhnYmMR4+3L9?=
 =?us-ascii?Q?kg89LpR4FQgPlGqoZ+SEUlN68XpsqKWAAlcAvQpjYqGHONEU3LbA5J64qU4Y?=
 =?us-ascii?Q?luLlSqSuvZKLEQGyRIFNZvmrDtGzJ/ZtjFbTPVpq4k0jg4B7o0xycmMItDRV?=
 =?us-ascii?Q?ezfAWjSoWA+Myzt0Ridfk7nvbAmaG2y9L6ojwjal0dyCACLdR439t9WUr5B1?=
 =?us-ascii?Q?NYtJ1vORlkmj89Y65F5DyneK///RaX75AbXbKTS4SiDbstPTP+Lw40S22TCs?=
 =?us-ascii?Q?Vc204uLcNw5xPexDRBmbWB27yLu7/g4OjwqCbumA2UUEJ9IR96XdpS0gvYeL?=
 =?us-ascii?Q?pbQuEQhptdROxygXwUGfW6F3YIfNRLgF7lORrPAc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8604ae2-d875-4444-4791-08dc4a055c38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 00:16:46.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Nu0Q4o9sNDXPEgnLlfg0zlQURgBxEVs8ahkCjKJSfefjCvEzLkrXxuApowgMyxfhL+9jtnf5YQ9UqqxTo0f0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> 
>> Alistair Popple <apopple@nvidia.com> writes:
>> 
>> > Dan Williams <dan.j.williams@intel.com> writes:
>> >
>> >> Alistair Popple wrote:
>> >
>> > I also noticed folio_anon() is not safe to call on a FS DAX page due to
>> > sharing PAGE_MAPPING_DAX_SHARED.
>> 
>> Also it feels like I could be missing something here. AFAICT the
>> page->mapping and page->index fields can't actually be used outside of
>> fs/dax because they are overloaded for the shared case. Therefore
>> setting/clearing them could be skipped and the only reason for doing so
>> is so dax_associate_entry()/dax_disassociate_entry() can generate
>> warnings which should never occur anyway. So all that code is
>> functionally unnecessary.
>
> What do you mean outside of fs/dax, do you literally mean outside of
> fs/dax.c, or the devdax case (i.e. dax without fs-entanglements)?

Only the cases fs dax pages might need it. ie. Not devdax which I
haven't looked at closely yet.

> Memory
> failure needs ->mapping and ->index to rmap dax pages. See
> mm/memory-failure.c::__add_to_kill() and
> mm/memory-failure.c::__add_to_kill_fsdax() where that latter one is for
> cases where the fs needs has signed up to react to dax page failure.

How does that work for reflink/shared pages which overwrite
page->mapping and page->index? Eg. in __add_to_kill() if *p is a shared fs
dax page then p->mapping == PAGE_MAPPING_DAX_SHARED and
page_address_in_vma(vma, p) will probably crash.

Thanks.

