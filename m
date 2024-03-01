Return-Path: <linux-fsdevel+bounces-13296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3E886E42D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB8A1C22ADA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C54A6EB69;
	Fri,  1 Mar 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfeFeRf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E256E69E18;
	Fri,  1 Mar 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306482; cv=fail; b=EEEgZQoq+7JuJeNhVDxqnXbUr71LZEd6eTMNTVNI+4E/fsQsYh4eQTJlZvM0Xnhs6xVZYLGayvQ/z5hYTG8fi9T15UBxeC7ngSMz4TRt5QGsTpJhRHTcQpLb/ky2gMZpVeYo1SCGV4m1NGvwkFjEFb79XaNdipOwu5IvH8ObulA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306482; c=relaxed/simple;
	bh=/Bd9SzRX/puTQtifDuMCeuZGB1zgWRhLxxXbe7u7IDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PPgveCnqN6uTe/lj48K6ff949WjGK9kurHRR/d0v7dBWhsnvYoVpNkAf7NejOMjRITvuF7n6NnqgLQlBU5hwNbj+qZAo/M8gBvsEiXyZeOI2hItahZtxLXz2znPd9kL8J6ftwp1r+OR1Woxtzd5FNXdhKwkqo/CKMZYTQT08QrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfeFeRf2; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9Erdmkc2PwwuaFt6+VyRxMfbH2dzmO+eS8QQMCTQI3ULcd4OCVuvphyUAu9eJsDzBKeQ0x3CoWwoUNL1VzAq8CQYd1qD4aF3d0JvSQktBDvepMtJvwP8n3RhC+I93yHGYuH+epehXOajpmNzj8ZaEl8gzlDNn1UROurvvu1LoWhkWEMLOOVjjYJ+vi39NR99KoS9NJ1e7352jqBmHxbW2xhxZWiIGUmM58Um0WFHqUApFfVzMArxRJIIFvfPdcE8cAzhA5SP0Nu/mxtqbEA0w8PT9YHZ2Vdu8Y5sEzF73YIT/xeohEblw+BXgSH+zZDGXLBr2v59QF/8jaXkqG1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7pHyotvhZtWWPF1OhIbvo4DxHzvinTeALrcjhkphh0=;
 b=Xaq3swSzMteWOOE9oewtut6GglA1rqY4IUi/qtfL7YGT3XoP3tmdNTbGJTXj2DucGRGMVckQbx4Kxi3AxwbJa2U1wgiATfnW4XvnfU+plT2YW6B6BKArdjMIgHAPIYB7R9fJRTR+QNkKnunsQMOeQ4SOVgfZ1KD29jkK5Dh6Do3XXtBUZYcBPt9W7v50FjWrC8ym7Q/e6dq5L6mubGVFYk7CuOB1Ze6/ZlcQxuuWaJs2U0mAcKtyNldfvFvd+qRMG1dXN9ZGfL6ZU7znu3eAZ9I8/S6wgvVkq2ZfN+XUVg/rznMd49DDWQclWrimTw84222m+UDofHqMPxQfOYI0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7pHyotvhZtWWPF1OhIbvo4DxHzvinTeALrcjhkphh0=;
 b=lfeFeRf2He14JSIk+A/0vMeS3HyEN8uh20ZC+De/hMDk3UyZZCdl7zdIfFuGkmgMd37ba95tYbvPbVmdHTktT7q/8cSxNvSyTrmJV56UW3YRrRIRriBF1V3bIFXx9nv1Dk0ie24ju2xjMVUsxe96erSADoS9Yr5ICcYtThXXEaCax1T7HM8lpktb5Pwaxa6ZL0iEsOcO422hq2PUgy4UBMY3MTaQXJwlD7gG+u0+raKw6c7YmDxy8KX0e17s0M0QkQzJjTJWs5jc+2my0HrYdFfJbUyzGRyMm5+aAzvPcNDCQwiLQkZah0CxfDdtoi7vTRpt+rLd5DRWbWSW9kb+qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 15:21:17 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 15:21:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>,
 "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Date: Fri, 01 Mar 2024 10:21:10 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <D1EB6EA5-205B-4448-BCE0-1D26F3EB34B6@nvidia.com>
In-Reply-To: <dda99ee0-87a2-482d-bf28-bd5e5a97b46e@sirena.org.uk>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
 <08703C70-DD6E-446A-9ABC-BC2C8E33B8CD@nvidia.com>
 <f7a3d07d-290b-46d6-884e-fa288901c3c6@arm.com>
 <3D5A5D18-0A20-4BB3-B667-0CB5799BA665@nvidia.com>
 <6003865f-2c85-4dd4-9803-6204f9018f50@arm.com>
 <dda99ee0-87a2-482d-bf28-bd5e5a97b46e@sirena.org.uk>
Content-Type: multipart/signed;
 boundary="=_MailMate_E641C6CC-D60B-45F0-983E-9E8525B120B2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:256::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 76acbbe1-99ac-4f31-ee0f-08dc3a033b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iq+jSs+upxx8VxUk0tznzQTA3995dl0//a/kk4S91hqtjzKLCWkv0YnyDrhA70OAFCJYB6rWDINh3uocUWEWCi5hDDbkyZmxGNAGKpzVaTp6S3Rs8e0dkwwDClBOm3KneCB/d2q3IjMjl6QLRtabfsfaxisj1NKc3E41W3ekGTi1CZaGTfebTKNP+5ZgPyyCpfdSvARaE8dwXAs4uCUI5sCoET++eg2EqRqrEA1/G3aIE05zfnzrVjqHl4OEz4FIKmsluQgM31tdsqrXhs3kXxwmw1dNOOrSfBrbywlqz+9RHHQDFhv8fzk/1gZmOjOsN71bdK3Fqhmrftie0CxZJvCx4XFuFJs530Jrsf4ZPMEtIt04YzO4avmq24gvqm7PGyFh+C8thsyp4WsaPI1T8J2CVhj/0Quu1XTbsPOZnjDM4xfopTi/747o0BDemyZWzpqKR4Bx9NujKwlJGcduItlMT+LRXhjDJwSeNeDWo7IkC+tRwFf0eyZcDYiR5d04J+ae8c3eCvrs9vGn6D9z/VVaaCAHTnGb7G4oFl1WovlQu458EumKQ/gxGmtTTN6CJkCDKbOAn4vOl5RMDKsqqfzpwCAHeVrtB1s+fX/588hoFP5GxAUHxGdoT61QrgbgnthOSXznBooUBRkyMzvkDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6C6nidi/TaABiftOhzJ/3eJp0pSjpL0ngs7EK4pod8Ntpeaz/h/s0x7A4EBH?=
 =?us-ascii?Q?wulCxF8fneNIbHRuLkaaP7TrQ3aWs/3uh65StduxbOiaZnH5QUtMLwOek/hV?=
 =?us-ascii?Q?U+LoDa6tgs8OQ22M8zny5Oajvg/0D0kW318y0otOdl61yN03BnTeEGU2Qt4R?=
 =?us-ascii?Q?gF3mguaXxomRCaWZvuMQJaG4URdalbDEZAjAv7H5sMhNhUnrQ/p/faIt4K+6?=
 =?us-ascii?Q?R6BhOFFXjhpzSqQzMH6u+gjV5ClhmMVslHZA3ovboml1BcO4e6a3xLImKRGb?=
 =?us-ascii?Q?824LNmAq/0MNXz0//0aEwEcjaC/3CZgfK9vfBXd76Huueyq8JhOTQH9VQ6+O?=
 =?us-ascii?Q?Hx4+iuCBT7A7CKYZOJZNoXqd9I7ZuEqoP+shxJCMTAkDk3naVFv7S0NBUhGV?=
 =?us-ascii?Q?tSwuUNcUlmZ/ptOy7a4aCkN/vO1yNfd/78TYbs0ow5s4LSshl5jSFeN++4N1?=
 =?us-ascii?Q?i1U7CSMolccQpf2+M6E4GTnB4T6zOqhFpwAdNlyESWTZ/NtodiRGGif8/kI8?=
 =?us-ascii?Q?+97BegPSX/y4Xq647shmnUtyJayKldUbXefRuZmhEMdP6Ba1AgSCxuyY7FUW?=
 =?us-ascii?Q?8cQWtYgicZ7Z4uCZZLP1szhLU4OI5IloLKsxr6Vnko957xAXNXMWFwHp6Jxt?=
 =?us-ascii?Q?KA+6ikwQZem1tGZRKpsrpe2Zv5wbk4bGqZOgpdzrI/iUkgI7HjMF8ATKxhxx?=
 =?us-ascii?Q?oqViV5DHsls2clE8tFMas2CmLku9ve6EJtFAwdQbyp2bz7S2Fj7y2w+zpQkI?=
 =?us-ascii?Q?IwxHYL66lM7fTYBjQym1opNtjueHH51TPu4S3YGJh1MaNbPUXzDU3hhfPTui?=
 =?us-ascii?Q?xQlrbi+qlHOYru4NOkBaBjFdE5aRSiBovKr7tgQ1KbpZ0oGT+/+uL9FDZbqp?=
 =?us-ascii?Q?yxRkSC2+Mfac4Wc5UNY6NflvY+dHKf55M8pPwrssdp8ipVXvBKLGLa/RaOs4?=
 =?us-ascii?Q?5OoYH0XJMBLZaWZiCpmgp+J4UPJ+77ZArry8LsYia2aqbAvsIy1jHqcSIHlX?=
 =?us-ascii?Q?4xzvzN8qwHA+50QtCwOoL3YgrapaehWFeQnqpmgJk11o1X6kMvL14yIOf/5F?=
 =?us-ascii?Q?OGwIcj4XRxUnv0+d5QJGD9KfrOe8WnfI5D8Htmsi+WivvupwV1h33hLwAPPZ?=
 =?us-ascii?Q?72AtGFy5oZixydwJxYnUhLdnjfc/Je/uwupYm3SZLb7iQMduLP0FgyZMmEcM?=
 =?us-ascii?Q?dmEdoijyn9L/dJ8glNsf9M2IF7Lv0vPV2MOATT+7HAogg1fSXFHLyP5FSQgE?=
 =?us-ascii?Q?IhDn0+Sd2yFHqPx5eDRYnvCFjz71tWImNiXtBvqy7tFIKiKNRCB0tkAbdzMo?=
 =?us-ascii?Q?bLvwtT25e0g+iHRJoIiPDY8TbC9mbG4zIY38hqCQtrkomTmgAZCTq9KonPEr?=
 =?us-ascii?Q?JP4DNtZVQgxJrjVD3MgG0AitRKdQGho5zomaiWUh4jw92Lys5nHhmMg0JfOJ?=
 =?us-ascii?Q?io+xgmpONv2NCQCw3/7S+Ln12iQBftKbW3F+22o+0TDuRvAyN28ACxzlS5WF?=
 =?us-ascii?Q?vqa3lUDMXBewMA6vzQFqlSowxT3twkBwTYbRWxbDFKmnQ1gLmNvQOt34psnk?=
 =?us-ascii?Q?6HN8rpd+eiDW7r3qW81iU83sEnw3tYMm5uDnWN2m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76acbbe1-99ac-4f31-ee0f-08dc3a033b60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:21:13.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8s1Guk530pZCb8vrm1LGEa3r6NAu9i64hIbJ3x4IWwmvLblFbeu8ClBisD6GXkN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

--=_MailMate_E641C6CC-D60B-45F0-983E-9E8525B120B2_=
Content-Type: text/plain

On 1 Mar 2024, at 9:27, Mark Brown wrote:

> On Fri, Mar 01, 2024 at 02:18:16PM +0000, Ryan Roberts wrote:
>
>> Although I agree it might be a tall order create and mount an XFS fs in
>> run_vmtests.sh. Perhaps it might be good enough to add an optional param to the
>> test to pass a path when running the test manually, and if that's not provided,
>> just try to create a temp file in the current dir and skip if its not the right
>> sort of fs?
>
> Yeah, if it needs to be a specific kind of on disk filesystem then that
> needs a lot more integration with CI systems (a lot of them run entirely
> from nfsroot by default!).  Being able to specify the location via an
> environment variable would also be good, it could fall back to the
> current directory if one isn't set up.

Sure. lkp creates a XFS image and mount it. I will give it a try. If it is too
hard to do, I will do what Ryan suggested above.

--
Best Regards,
Yan, Zi

--=_MailMate_E641C6CC-D60B-45F0-983E-9E8525B120B2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXh8mYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU14sQAKYQi8sSbnKIs9nvnVnu4v/HZpBn4e4K3BWB
PrGhuZU5ucgjSJpjvN8ajatmlK2JpitWgrXn6m5/Zk3ZZPjdprC3i43fmFMXAf/f
ookaAjLLmKSXy9m9zG2SlYMMLw387q1pMIKfjunrUhH6r7P1RHPAWBqQXerWn7H9
QNkGWHr+v2YzMvJ9ulmkWgm8Il080U9B9wvYhI2FPbxYaEp1PRpJlxmMj+QH4cUs
cVEay0T2TkJF3Ei0nYPea7q+fnJJl1SSsaABMmOe9acAMXTxOaVzPrlMZVwQIaN8
pyUqOOVh7hEAeDB+1JhMjOi/VORdinX37Ar3Xtsgj4k4I6cIk0nC1TL/KfdfK/AN
Q2CDyluzIMFTC3L82x5nez0NZwwoXWM7ieKXThvB29AX7IbsUnYqjv3tPbfzxknP
i/MtvXDki+pgBzpfHxtLw3u7PPXJ4mCdL3wQv7qZQ00xdidrkLFSlksdGaVTUm7q
fZNTjWhwEiT4fH/AMEvXvlcuNGkQnaNMj3ogFspkJWFMqixyXPWgnz5rjCvWyYy8
FYeRKfrykFUgrVRlyvGtmEUCnhXsCIejqiMBYM0OI9sKfnqWLzX/4EvoA0kfCvQ/
/IU3x38FV/fvI/XuQdVtDTDsnRMIpvcUjLUAGq46BTo2VJujBtOdn66R3lSB6gDQ
miUaV0VB
=4pv2
-----END PGP SIGNATURE-----

--=_MailMate_E641C6CC-D60B-45F0-983E-9E8525B120B2_=--

