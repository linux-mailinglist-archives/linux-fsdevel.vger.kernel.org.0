Return-Path: <linux-fsdevel+bounces-20158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0C8CF125
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896941F21527
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 19:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC7128374;
	Sat, 25 May 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h5VjKQYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2053.outbound.protection.outlook.com [40.92.47.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B94171AF;
	Sat, 25 May 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716666970; cv=fail; b=PNCsbFxq1wfhjkoRqr9olBIRze2g208FFNrKtVxGO3BEp+7lbbyaFTM8ukI+5i/i3aUjHYrLlomstpUUm3B9ynMLfM7izfkzpLFMydcxcf4er8c6YONs71EX0nqHKYhuYcDeDXJhzpvLe8JOmn6x549bEpN7RtE6POFnUH1gbHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716666970; c=relaxed/simple;
	bh=ctgyF2VcEvsTxaxhfcYBangfvhE8tgP+7LFgA4eoazc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RsAelUmZaeSV0Jr5lDlF3DYYlUJhAu3zYlUQbqMG1cp8RD5SwtcXrk4Y1JzLnoxZdczYlfDc/3PAyaLwI6nXwr1phwNRupxO1wzc6p6P6fly7CUwc2T3SuXpMRrNfS7+U6cCUkx1TQbYDRxKkRNyq+G9r7jZByQ3M1IFn+9knOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h5VjKQYf; arc=fail smtp.client-ip=40.92.47.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHX1FkfxaitylIqPYuColA0rgzlM3yb6KEyfPMSzESmgUx+8aLAYJXbbDHXDpzr9mQGFR3hRuoiSowDNwphzwHfPfJdtHVZgZQJx4fibzu/68JqEIhiXuG1Ioki1nTPRuotsd9NDQiaVQy+HfdtNAOiIyScus+6k0OXmO1pLdC+sraXHw24kfA+8uo2TYoLx2HjPwWPsfeIEzZBnDUEM1xlJeJduHDq4d7qV105fUhUFlfDPyEp2OJB9Ei3bPTX+STbw93OKaLR8Rsnu3J6cocN354ysYjxI/C6x/A0ONcxSXBP7eGx2zD9PpLc+UQo0aK4nBERkmmnpmCPbwlzRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFFGHZfSXjUjLGWLTB29119AwgZ7BDKkGImqR3jmaTU=;
 b=Lh0uxCwFS9xBZJ1eAB5+Zph0KgKyAskxOqSeddF4iSmXJ++28nWHOZ/bRDcmp7tW0TAgCITamrTq5zlq73VacwgLeVaKmghZL86yRJ3/iPMMJWe8fH3tfMLeGV+i5P79f2BF2BHBqdB1xoqdgwoNe139rCqZTG//9yLbCUGMd5JGe+0MZnBv/BG4ien/76UTbvey/hQgoUXJKXcfWFCghHrds7yydgrRMOX7VsxW2Bb6yWGxlNgwAMrxrqRSFJXJV/U5oY3tmK/w/Q+luj3zb7Gwrxrvw2Jke3tg1IM5TIIpjJPngM/BWap5M9Zp0bcNEsPNA9kH7buxd7o1zGxTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFFGHZfSXjUjLGWLTB29119AwgZ7BDKkGImqR3jmaTU=;
 b=h5VjKQYfeJXaL7ur7afPmz5MbIy83crOq1krA9iqbUX2GtKxc9HppdSEno0mM+AUUe0XlgO0CWc9ox+RLyP5vYqSxsEe1lLdClMWw9hn7hrqUwyfW5cxycuufCvoMfPvjDJURZ8RIffKE+e4Dd4sJ3izs4SHGM/tc249nqO5rmuPH6fcfU0GUGz1t+cHiOT80iqhMdwtr1/uDoLA+FIH2c8C6EoL93YGN/aoV8SZiF5WkkRggYQ2ha8c7AldATFRZT+VW1f10DqsaexyrqeawrhubEVEyRxtNdOGpneyxO90YM7SrpZYDFf76q1fcjk6IpoRPrcU5VI0541794N/1A==
Received: from BL0PR03MB4161.namprd03.prod.outlook.com (2603:10b6:208:6e::27)
 by MN2PR03MB5295.namprd03.prod.outlook.com (2603:10b6:208:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sat, 25 May
 2024 19:56:04 +0000
Received: from BL0PR03MB4161.namprd03.prod.outlook.com
 ([fe80::c5d3:dd2:eb42:c5d7]) by BL0PR03MB4161.namprd03.prod.outlook.com
 ([fe80::c5d3:dd2:eb42:c5d7%6]) with mapi id 15.20.7611.025; Sat, 25 May 2024
 19:56:04 +0000
From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de,
	gregkh@suse.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>
Subject: Re: [PATCH] libfs: fix implicitly cast in simple_attr_write_xsigned()
Date: Sat, 25 May 2024 19:55:52 +0000
Message-ID:
 <BL0PR03MB41610A9302ADA6A5022A306BADF62@BL0PR03MB4161.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ve1WjD7VnkK03IAOTDzKeXdaYxLFSL7J]
X-ClientProxiedBy: CH0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:610:b3::11) To BL0PR03MB4161.namprd03.prod.outlook.com
 (2603:10b6:208:6e::27)
X-Microsoft-Original-Message-ID:
 <20240525195552.8750-1-jiashengjiangcool@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4161:EE_|MN2PR03MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f7d27e-fffe-4824-31ed-08dc7cf4b2fc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|4295299012|3420499023|3430499023|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	tY0ucaV94BG6iio5V/Hc6VqoU20f4lJdEekWRdvy8XdA+lsrlKP2t0+Q27vPQl6MaxLJDHpp/pENhYI+ywINzIiksvgAtA+OrWPQHbhad7gsMEdU84IlmxHjndq3bNP4/QSSOZpiInCYyEqXvfnJIASpMvONbwDbep61hRqYCWopNIj091NnzTpIcKVjamahsaQFo4UOX7l5MJdZr5HF8cmbiDMajNCoe/KqnApXxlxrkRGDvROJSicbobnYkzji4yn9+dJDfs+dRiThzhQELo11/muEMvw3/z3W3f5rNiesV/EAFCzIA1XQ3g9iFUWiCP1ioqsgMZXFmv+EYLSEIQW9E+fMaOONHJplqEaQWrTQZ5Fzj+yanQRoVYDIIoBMHzroIRl/BTQReuxjQ97jeCsY+8yznJrgkGodCjlZyo7CM/u2y1Y7nj4HGndtqwTTmxWG2nwVoTltkhRzVPu11NxKorBhAxtTyGbx22OeqnYmVi8dFCcVYkufoo/UERvb6xI2VSB9/O310AqxtohC83fy+3hl5Cne0eeVxnq+FwXPXWI5L4NWUjHDF6QAWwrAEE5hAhTeZARHuLQDVvv7TdWcyKkvEoit5H8Uz9NOnAQsbC6VNQDa3WWNecI8rJcT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Vy9FI1VGFkEJewJA4aRy/ifcirjw+QxM557Z5Fli2g1rTY59tYn83g/JJie?=
 =?us-ascii?Q?SvGq9yLbynv7n7ZGPo3JOcVc0mLAIrNDS3Kcp6SX0Ad85wz0zm9RuNDtxY/Q?=
 =?us-ascii?Q?IQll+UyYAUqZKHARYvNWkewZIVB1U4grWfpQD/hYzqBUn+ExS2SfTaM7KEel?=
 =?us-ascii?Q?dHanXklum1ewQ5041VRDfWFcDez8BB/KTIzM90yDajZVH8VC3UrmcnKRL1+1?=
 =?us-ascii?Q?8CVnadv33M50YXFdeO986hGTTTip+0xTWt/S8ZDTcsvOK3WRPldXYGG//Byk?=
 =?us-ascii?Q?uY5hftnd4KXgvUfxuD8DOBUHDv2I1pTucJTkYs+FtGzf30Zh9Wa55qbeMAgK?=
 =?us-ascii?Q?PhxBulyUqYZl53O4milT3vsP+AaEmk3GauHLWUkvnVE2qb4Ijkzorh1hV1Kx?=
 =?us-ascii?Q?KRP0MMp//9i+7TdwwZa6KJwooQFgbfpNKkY30zTrg8OTQ6El8zI0RuMIgbpU?=
 =?us-ascii?Q?20yoX4g9ntZv4tQvC4+0dhjrVjFM8RXr6Py6sEmtFvaeSFYns2t/1fVMyTHS?=
 =?us-ascii?Q?+Bu6xpvAkVFDcHBqf8tY72YQso0PqfiBmUrJ3qw2/3hCFuhGIrO4DDfX6KHk?=
 =?us-ascii?Q?lkqrUUtkrnM0hzdm4z74958WnWVZpX4RI7az2gRZYmborQIGBOkYulQJyQxp?=
 =?us-ascii?Q?bl3P6dXtNS0YjpBrfq9Y3s/s/Lw5i1sFmPgxxpyV/SdzXTbBlyKXLiz5cyLs?=
 =?us-ascii?Q?vyX9k/woYv0TObuyIMGQkkl52R4S9JR0jRrdINJQbixZYjsHM8V5NfzVx4iR?=
 =?us-ascii?Q?emPPhxZiLsF7cfPp1sd/l1/QEnMatxvBa1uwPWSi0eSWymotPbRE4mP1ufLp?=
 =?us-ascii?Q?9ZGnG80Wa0BKH5g3dFQULIQ2SzIHdVcgAEYPXRI4OLFW5lqBwlCIcPfvehNc?=
 =?us-ascii?Q?uy1hRZWXWhfc0rgge5LrZ39WY5DjuCzYdB2yJPt7TfbVBICz+6c8wjAYHCmo?=
 =?us-ascii?Q?oO96RsA17WXRG8fEfJ6lGoIue0TpSk95ou9zQ5YEHXo03mqcRfyjYPFmiIEv?=
 =?us-ascii?Q?FnrJWjn91UgbUcQYSdOPxxMk+0ZWvC+OIsg5mCKvkcB+fRYbx6saYC8dk2cb?=
 =?us-ascii?Q?WY3yCCwZQwEckw9G9/+fklllYZtsb0mEIqQCdSr4mkSfqi7St8lLO3PElB8X?=
 =?us-ascii?Q?WCwnqIOKeGs7bYzBlGbdIbIuMSLEsEeDF4ponu9jDNKusBYAmdrtZo+x/jMb?=
 =?us-ascii?Q?/PzQTP+v4YLnoiJMfdRGCh2gjyuf2DVjyMYkay23Z7OVlN8EfEK1ihKg/2P1?=
 =?us-ascii?Q?Mn2Kumr+O7NlktjhW8qS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f7d27e-fffe-4824-31ed-08dc7cf4b2fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4161.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 19:56:04.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5295

> On Wed, May 15, 2024 at 03:17:25PM +0000, Jiasheng Jiang wrote:
>> Return 0 to indicate failure and return "len" to indicate success.
>> It was hard to distinguish success or failure if "len" equals the error
>> code after the implicit cast.
>> Moreover, eliminating implicit cast is a better practice.
> 
> According to whom?
> 

Programmers can easily overlook implicit casts, leading to unknown
behavior (e.g., this bug).
Converting implicit casts to explicit casts can help prevent future
errors.

> Merits of your ex cathedra claims aside, you do realize that functions
> have calling conventions because they are, well, called, right?
> And changing the value returned in such and such case should be
> accompanied with the corresponding change in the _callers_.
> 
> Al, wondering if somebody had decided to play with LLM...

As the comment shows that "ret = len; /* on success, claim we got the
whole input */", the return value should be checked to determine whether
it equals "len".

Moreover, if "len" is 0, the previous copy_from_user() will fail and
return an error.
Therefore, 0 is an illegal value for "len". Besides, in the linux kernel,
all the callers of simple_attr_write_xsigned() return the return value of
simple_attr_write_xsigned().

-Jiasheng

