Return-Path: <linux-fsdevel+bounces-63997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DB5BD56DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB9B3507A35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA12C08BA;
	Mon, 13 Oct 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SRamRhnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DE22AE65;
	Mon, 13 Oct 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375244; cv=fail; b=Bn3QElHNL/uguAi/9WNf2WS3yqVzEYPVgbZRLeR7qwEcFQu3nVRbY1nTEPmQeA4iR3e1GRg3jjrBXJ/Dti3NNOl2d3NXNkgQFcmnlVd9qOvo08IzbjBKSPKRyVNXpoZCkgSsxjbLQywGEkWa9rMk5MlNVpfkNIfe1eK4kT5j2MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375244; c=relaxed/simple;
	bh=LIVtt2oaW9XYidQFDWDxoBzdw8gcfSFrIoJnaRy86kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZF9t2rqu3tmSFRGQz9k+Ku4wCldJ3iiRyp72/K2JoSwWqt8XTS03rbeIHBxqDACLICyEkWnBdDgrn+Qs+/USIAImkip4Yw9smXeZ2dCDMk9UkINIz7DC4LbZXCCijbY585XcgmkDGuGDtJJpooUT3zeU85h1vvKy7aC5gZkfrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SRamRhnc; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD5LbfErF0v1VCVVIqo1I1xsXoIi4si86LCVKf7gBHTVmAEKqMj2TS5nYZrO9WY5LcVg0876d57mQ9OtupmB+MBa8xKbcZjz5OxAtNAc1lbKfjiIFsDhbOtp/+lnIbS/WMXH9l9GTCLpUQUTW96YsNffWr5RS8UglkTiGhWnVzCKlKQmsuC6kjJD/ijqHVhrgi/KNMw8PSKkt9197MkMDrDtIPUYrsLI7N4aI+dZk71V/BRIwZXS7vEDPGDLdQ6o0FWx0BanV98QoR2N/CqzI09hroIOI6Rm1O9+GIb8BP4y2pfRMJkN/Hli7mMGyEpXsQdvQsChchKANn41pWXSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2BgZ3J+ufVa2wH5HrOcRQGz9xxDVvs/7jvqA6GuJ14=;
 b=Ew3iBdUW0ZuCiZ/ImdLYJ87Zyuj0q8CE8lAiG2FY12w7kBfEkXN+poUURIeWSWEk1ZKtJ29mei9s/3Cp+nLhuzDU/vP8buSQiQAvNu9kFC0Ep8gKp1rw4aFf0RTCb+shFw9OUq4MvCsxitbRuLY1efdwE/d5kkrBFCzN7OQPNZ9i1BOe0HAc75xrfWppWF/NIbSM/JKQrO/biVi3Ink6rKw3cYZOVd02oP2R55kuqdGms5pbrq2Emc+v/TfAyTsAb5TcDYsqcZmz3QDl4bUPrBaAyrhZu65Btt5FXJe87vrkNTWgvdPIcN4VQh9dTK1D+yk7KG6yqEb6tSUfN6+e2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2BgZ3J+ufVa2wH5HrOcRQGz9xxDVvs/7jvqA6GuJ14=;
 b=SRamRhncwX1ePWPz3rMNEygQBBDpRwovnNrt6y4oPA+wB5TExktrHKiTb7CABhXf2wO5CmXGhkgza0+REAKLKTFeL7+C8K1GayH6FGnH7nGs3640hZWQsoWq4Lm7sawd4LSACtu3gpPndlpAtdDEMXxHXQqhLZKvNE5MljnULvyC3r3s+GZK12YYiUUwEpakxBKcC7xLDu+ssV9BWGge2hDxvASB7luyF9pLau+p2NCEXXSpoYPEVfU/FjVodz1ZuqJgAIAxHxCiw9PPUuWadbH66dUt1t33+Jsa9KRTWeWMcyTOl0479wtLBX5cAp06B+nMTyxknVa8KyosiUxuHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 17:07:20 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:07:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
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
Date: Mon, 13 Oct 2025 13:07:18 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C852B1E3-483A-46A6-ABFD-0B1CEA9BBB15@nvidia.com>
In-Reply-To: <20251012004150.sujjmfkleibhvlxl@master>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
 <20251012004150.sujjmfkleibhvlxl@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:408:f5::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c260046-a048-493d-4c0c-08de0a7af821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cyAHKOpfmMVg7qk84S8phKj+HEQXlJHRR5Ef7fWmQdtDvJt63lTwU9tuxTAp?=
 =?us-ascii?Q?wWTY90PUiFgBGMSEzUx9Du3oUNx3Jbz7wfod1NlLpFqcDOW4dqWyc3olTFIi?=
 =?us-ascii?Q?0RSmPz4JRmM2wHy7WUMLqUO9gBRhhW6cm1LlbKCH+fJW3ARjL0WNaJD68maZ?=
 =?us-ascii?Q?zMnI4wM4D7/2LO4+PuJsIlAbOaS5ONTizE38P9M8evazOI0rZG3I88Exjxu+?=
 =?us-ascii?Q?uzPg609q7rqVm3iSYEPK7JMrDcLNIHA5+PTZvllUeYp9tlcACgczeJwr0I74?=
 =?us-ascii?Q?rZIAmSZStxwQZ/IqmOil89Qo1lxggOH4TnpmGpCNkfp2ZkrN2Vc9RiTLwbjV?=
 =?us-ascii?Q?FQAJSx3KDYwNOFas2Epg5rrWPqTEQnmTFCzaKKHGdNJGzHygFHSFEeHcWO7m?=
 =?us-ascii?Q?jycy7B4laKNv0/3kbAoHAWsbRzVMn7aHFWgq3GcuMULhep4suSJ3bmlQsn+S?=
 =?us-ascii?Q?ZJjsSFqXO840jSNj1KvBHosfhqUhf0wqH6tQB9SoiMgTpHiSs55eW4LfyEWj?=
 =?us-ascii?Q?moWKyc0zzYxKbRElpwxrWpOrHp+mwSXxufd6nV+qDjzzM/zXkBKuY/F85bdE?=
 =?us-ascii?Q?5T7qCLoFFh13k4cPDBn7BKVB9FPbfDu4hV8+z2yTp3MT2ZICYmjC13tsdRom?=
 =?us-ascii?Q?17wQ21UxtG457AMJrKcSrJiyLAoEnvtiMhglpFvlQiWNX5zGluagEhTtrU29?=
 =?us-ascii?Q?LjvYkPKktsKmwVfzHvaCy4jx/7HP3mGM8J1YyYFMI0GQ80vNja8sqmsHLIyB?=
 =?us-ascii?Q?frCde1N7aJdoONJjGTnFg0X3pDbuJb2Xxt/3i70pMqQhHwF+RhSBVPpLlop8?=
 =?us-ascii?Q?ImWy7RRMygIUMywO06M92K4ZsnYl4kfUj/Qvn+lxtE7wWVZvN9p8652frvlV?=
 =?us-ascii?Q?/YXmOnoJp4N55UBC3/mC3DCv9i21h1Zp7ABkHdfuoE/z4R2pXzt2xnmg7jd0?=
 =?us-ascii?Q?LRg87a3Pis3ChDGqKEvGwKzje71UIlwnH0nSJyYcAiMkxCe+F+V7cEJE0QwE?=
 =?us-ascii?Q?CH1v+Lq1Jf3b2noL1x4hTeSPcNZDnN5nEawBumMmnfhmPh1p42PKyT54B6uZ?=
 =?us-ascii?Q?w3eZM2CwFFOTAKi7KAOdN4WclCAn4PBkZ/AtVwtVjT7kwkbAIqAB+KF6/O0/?=
 =?us-ascii?Q?ktEQUNXePy/VuCAmh7eA5wfkB8ECC8qzDkCNFFa3G9EOSXF2x/UoFAL2k+AO?=
 =?us-ascii?Q?72DvVJG3PqnU23KAQp1H7rERRPi7Yj/gOXWC1giX9rpdiitCG4N5Bywu/4qN?=
 =?us-ascii?Q?+PgZ0u1uUxh4nbS44uzuXGq0IQ47uQFcFRngtCDcHDcmvsdTx7Ri7k2Pgvbh?=
 =?us-ascii?Q?NGdPUk0TdFw7ByYcmgKXu6N2FBqJ/CsM679Otmjj+prUaB8aJtUHxq2qa2Qu?=
 =?us-ascii?Q?S1qV1M5l5TQhdFL1FisL7kzpmY1zPQOlPI6ki09l3C6iVovyiFTsORwdIJAt?=
 =?us-ascii?Q?PzGYrKWS2v9tbKA2J/cCLoyMh1rbt5j3+hU2MzvKZq+7o6EnCkeQRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9LoabQyicONF5ljfcBPDPxjxNipSr4gK1uoCDTlhdHTeuKk27/Qr2zIHAl1?=
 =?us-ascii?Q?gBPkl8zyJIBLedkNvJD5FGqYdOxxxsC+DDNaQEB6y2+hX99dSdCnh7+DCAOM?=
 =?us-ascii?Q?VBOER0sNwsMmOK5q2RhWBoqtWK+jIcMfFTFJkh7Cl3LYr+sjwfNYjXJAa6Da?=
 =?us-ascii?Q?n2y4P1pclmhv6u0UDCjtPtndBANM48k/MxjhNLQ7BRRc+EDmfeSmXvxUAf8p?=
 =?us-ascii?Q?tbtx95W3S2I6DypJ+XCa3A4HXQoNO35hgbgP5OV1pGao84TO/Ev7zOIgOjce?=
 =?us-ascii?Q?PpRRzW+x0QRZoi8Fb44ltdj21jQU9SJvZFmbGSUiWcyHlsTOA4Ya2bazm2ed?=
 =?us-ascii?Q?+WPam9fW/a+y7BbXstMCZiLkjRPNbir3esmPSbgxgvYKuXJv5pb1RI9IZvpH?=
 =?us-ascii?Q?8JzXzHpc/plgLUcJ7nmBqepEIONV/WmhzT+eTwbi9FtKVPG5UMFjdrHn0xeA?=
 =?us-ascii?Q?kkIB7LbSh6uNwHJGluKOZP9C6xIhqU3CdkRZiaXSnWoS+0/gCpwF/LHWrB/Z?=
 =?us-ascii?Q?sMtV1vGX9itOsMeSljQASmJHvOCi8tgviH1NB+3+HvOVoB+/zTJiBc9UPmlx?=
 =?us-ascii?Q?OWVQhYSYUklJPubQfTl0CVQSWZnDj19ARNkWA2Bb8bMZifjmU9tfaLFMbgZE?=
 =?us-ascii?Q?qRg2X1fRkwZ8Kf4l7R+L9+rbL+lYGh6UvShADUbVJ84z3Q0x1jmy0Q4bcW7B?=
 =?us-ascii?Q?iNc0byCjL2GHjPXF9nulHEg9jZvOWSy+pLNX1p3aqAol0LtdxHaXsAhUDF3J?=
 =?us-ascii?Q?V/99gxaSenNjWrpEzbAZyTnTD1G5kKa8togNjdZabu7ha0MfYPZCF326ngKi?=
 =?us-ascii?Q?X3s2r12KrId6zDwWDa1BmkBXS11/WzRDtW1Opgw+Nwc4oAPOm+5Jk66AKdAK?=
 =?us-ascii?Q?oItc0iV+fpLSTVQSbr6XZ7GpBZN2yjHOB2gcyhwaf0SYRDVPkSo8MJlKc2ST?=
 =?us-ascii?Q?jjZiFj3FbQWRSlZ/7wGvy8LXelQmGPkh14ep2va/jA1BqKrGR7cCXwUlizJ9?=
 =?us-ascii?Q?wKoPal0WAwio/yKWpbgtOBUQieU/Dj96ltjOQdKWEVV81mL23RkZnzGGXhdW?=
 =?us-ascii?Q?ag5vYLIqKqnsQOJfCExylAThUlR4ezmFVk88/NGjHR+9k52We7Arx8uPNf1G?=
 =?us-ascii?Q?skxhLpZoDWz0xFwj9CNhuOCubSkS4XHOtU9nFQ0mnUicCfINVb0/Zqwog23X?=
 =?us-ascii?Q?gA6g8RGOxrUzbmrRrSX1+cYAcnOqA0QSXMo0HCHNrbj+LUPwjFfgla/9Wty2?=
 =?us-ascii?Q?DAHpizUMdfpHGScOCsAU14myCNkNqYmwMWBKi3BxVfubXDSgpKBkxi5Ehjtw?=
 =?us-ascii?Q?No4k0iles4gvT2b0bxihJbJT4ALDwHNHc1x1vH6w+KQSvtb1UK2yPsb+1Qn7?=
 =?us-ascii?Q?QitfTfxIxdpAVLOSHCUti5PoudGt9GT642R9CHPyIhDug08k4orG0iwblZq8?=
 =?us-ascii?Q?mIQ/cF/wN+7roxpF6yeGh2LVsHf9URxU24bQbI6gttKvJagNBjNAcGtp1PKF?=
 =?us-ascii?Q?jslekeociOreSHOMeTSdIeGxfzU1OOsEtaFO3oL91QATtayLTQC4ZVEqklL8?=
 =?us-ascii?Q?CqY4x4QZ6YHxYucaapzJe28i+RnCbsC6YIujpUhZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c260046-a048-493d-4c0c-08de0a7af821
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:07:19.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQqJhlsaFCaA3DbnThiJdAjYAf4QEgrmzkJ0WJjDkWR29x7zSzWZ4ZW4mjJGLnhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

On 11 Oct 2025, at 20:41, Wei Yang wrote:

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
>> include/linux/huge_mm.h | 28 +++++-----------------------
>> mm/huge_memory.c        |  9 +--------
>> mm/truncate.c           |  6 ++++--
>> 3 files changed, 10 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 8eec7a2a977b..9950cda1526a 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -394,34 +394,16 @@ static inline int split_huge_page_to_list_to_ord=
er(struct page *page, struct lis
>>  * Return: 0: split is successful, otherwise split failed.
>>  */
>
> It is better to update the document of try_folio_split()
Sure. Will do.
--
Best Regards,
Yan, Zi

