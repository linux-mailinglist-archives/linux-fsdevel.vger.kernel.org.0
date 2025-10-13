Return-Path: <linux-fsdevel+bounces-63999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE85BD5648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11BD188E548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121462C0F7E;
	Mon, 13 Oct 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDn0mz0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB32C08D4;
	Mon, 13 Oct 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375492; cv=fail; b=fs3aR16qS/SLXoOusM0AAft6nHEo929IDxKpQvnqbVDCX93sj3PLviduth3zqrpn0+Ts5eSedOqz7Nc7UvuqA08Rrmz7TvzX4RlzWz2JH3EsVzecczDmjH/aTk90MCANobdJ6GebLFqUyouaTrIw5wkIR84fmBzmCgmqUmW6+Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375492; c=relaxed/simple;
	bh=em39exKJ7jZsV7XS0r+rD7tf6tgFfbnSGHn2PSCwB0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dx2FMHRpU89KanQ5tWjgJgt7/npDKAXpJ0rqKEu1G025bYwECMmX0ZaOh309smD5Ck2SToyOOSgSNQvcT2j2W2I5mjILQEjGo4DW+S61NlS8n26ijXpALTzhwAUvH3j0ctsRcyn6ojpZDD6jZihwWhhulxxGJCB7PODcucx1KDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDn0mz0U; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tk4GdmEMm5EEAtdRiQJQKyFAfrQ74+iU3tE/VGgBTyWKJ63rRVHZR56yLZ7JC6+2eT1me36UrNro43coa6uZOzmcEKW2CCEAkdIaOxY3ysMj7XTymhZSLjFBEg8pSHetsTyovEamKv4064nYwI2Ihtwho07aszRLbY7lGObBPuGKLpXHv5Apsqp/GeYr5UiF0D6Ylu58+K9xBscy79/7gbr7ND1XVvJ0Cydo4fra02zTZdgHRfVFtnwhB62eDxuS8piKL0gKMsa/zCOklvgc5AtKi7SgV0HxkB8rfDN4k5lwPZ0sawM60ucxERlEKnewTiWFsVkpHUCSPU+1yCwDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em39exKJ7jZsV7XS0r+rD7tf6tgFfbnSGHn2PSCwB0k=;
 b=ftsrID29Y9qRx6KGwlgza1It1MY1oMiv7RKQxdYV4y37RKGdFYGoRkcPLa4iitCKSvVnq8dTYL1RpbZAd98iUgnFFhsGaI1oMVL1GjqWfFOS28wIfyNKtqitVocdA7wVq1FlT4VALZXlFnPaVO87taKf4XKj4gzbPfL5cPoITETnCQB1kdpaQA0ey0BloQDY9ptO0Og8O20mhz4HENeEdZTk0sM1eFQVbrnFlLVb5f+Ogj/9rkQ+tl7moErqWuNPqx0vHVpT1ftG0PCn5gsTfHLGH/kEUak3aGyx4ZSe18OYU2pu/gIpnGDfbCMPZQZZUIXgUCwu+js3ZynPMiaI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em39exKJ7jZsV7XS0r+rD7tf6tgFfbnSGHn2PSCwB0k=;
 b=cDn0mz0U6Uo+heBTr1Ek6L7+PhmBFWZzT4507M+cS/VjrRFfd+tVMh+1ZUmf2yfnaNBJCswmtHIPkXb3gxPX1jkDxmWvztWCUcLWfas1zGji61A71OLtVxeFELHiz965Ib/VrwlfOyrSEt2ryAtylS0+kseEGXXHik2NmtlQUxF36XmD6lhsUuYqk3A2O4VE1D9DlGzSJe+Ocn7NAI28ytfmxhz/FD28mxDieUcK87KcHB+tIe3vmFgIgLXVQiya24Ap/afHNOtEfLCzUwTlsjLebkYp838mOZUOp0O10ZepPtf4BVDjjrTfIicB5R+tPJvrtD3PMECpp+jRGyc/PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 17:11:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:11:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Mon, 13 Oct 2025 13:11:25 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F6C18E5B-F39A-4E3D-BCF4-0DA6C1ADB206@nvidia.com>
In-Reply-To: <aOlKK0b2Ht8FrDXS@bombadil.infradead.org>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
 <aOlKK0b2Ht8FrDXS@bombadil.infradead.org>
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
X-MS-Office365-Filtering-Correlation-Id: 74ec1ad9-5768-4989-4055-08de0a7b8bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Efa05MuyKNKLEoWqTBTVIGGFXoZbBX7KSc7MICpMByRh8QNmpSS6zxhx623A?=
 =?us-ascii?Q?4DIUm1HsUJQbMFT2OxdbwL5hkkJhf7gmuOXz+22mN4lAp9jN3zJi+sl/qHqR?=
 =?us-ascii?Q?7MPWBdtRU6p6/EJPRwKnB+8w5rILLBIUpOf+Bwn2/a39T2vMcT2WiX83bLK+?=
 =?us-ascii?Q?0fUXYj5ps532fiCm9JPF8dUot4hatIOr5pgwPqdr0aDy7b4ZQaxFKI675+n8?=
 =?us-ascii?Q?tk0EhAyuod0IZ+/NEKvu79NArjA05HmtQ/kiVcDkPkWIjkiEUvMS8EDEFFwQ?=
 =?us-ascii?Q?EP2Yp4N7C7yzol+4YkNyfP3zhLsxb8KwTXwdHesnFV/P8aUksm5ia0jBDZau?=
 =?us-ascii?Q?y1/KRVY2HP1Im0v7RpoFYIAPk8cCvHm62Np4LdQyUPWekJ4FjJ0L8tuOdz7c?=
 =?us-ascii?Q?qgAfrgQhKCUEKARzyC00LVY0jITkKD9W4MdfveC+pkNRZ1vzQFZs6uVc3KOZ?=
 =?us-ascii?Q?BTfmPE+/YwkDtUW2NIR0iN7QVAf6ajjllqBtwH24Iv0xLG6zIESH4DReKg9l?=
 =?us-ascii?Q?i/1HXVsHrKUfrN2kbXP/+e0qnN2+c46yJDgynN0+55evO6u+UJq8+eQfNzgg?=
 =?us-ascii?Q?PnhDgt7D3m7OqSas0TEzDt4Bjap3yertjqdbpSvVdwClCiXgoeu6pcAj5Icn?=
 =?us-ascii?Q?u64R2RaTXSdN64gOJ2yheKZ0NO2UVC5+I+O3onzEutlwzhV4IIHT4XJGadSv?=
 =?us-ascii?Q?YwoSLuOlptQEvfte0+2wBbV/i8yjKXp88HlBAY4OZPzP5UErV1oThRTnLuI3?=
 =?us-ascii?Q?ZQFbTN5I9xiRvM8u3Nm7PrnK3FcJtyfXlCpD/xvGUTLwGpef0vruYY50MeV9?=
 =?us-ascii?Q?i7mlXPYKZ16Ni1ZIcy82W0VqLAnni+flUIYfbetfs9tSTX84yuH4pEyNjF7L?=
 =?us-ascii?Q?QAjKhpesjgxaO37cjFv53EHjEAPQ2Whm/FliBiVjfYNk+UaSfclMVV91oR0b?=
 =?us-ascii?Q?MK7Yw0Jz+j0iv3//WsVyXbLABfPhrJS6HATm3Oa0WxRa29uX9HKlPrXPlPTv?=
 =?us-ascii?Q?45nsWSFpIX1yEvRqu/DWBitwyifvA9sxk884ITfTjmCUwlNu2K8FFNSIBlMy?=
 =?us-ascii?Q?4HkAlwnbiDNQr/aodS3venYZWNWxEBQcbZHO2RbSGYgz+w5nSPgROsWFPx/q?=
 =?us-ascii?Q?N3elIykHWaNuOmw1HXPMqvR8FSlHUcmR7ajQpnpugEZKBnDLxeriUycIbBWR?=
 =?us-ascii?Q?LYR0v0YOmYmQSKmgT5mDTvCMePHlPwAxOu2FaxL7qzIWuwqdCpv9WKbA4ee5?=
 =?us-ascii?Q?Zi95nGLf7ySgHP9kkdpoHqO9WxdJaVAsA4RY0C/CRA1RJ9G1jZvPlzVpk0bU?=
 =?us-ascii?Q?PZoL/Ms5RRSL4CCmGY0eL5Vd0KuGpALdqewnJEPt8u4l14bUjRf6dz5cB52Q?=
 =?us-ascii?Q?jt8mMbGLkaoGAwp/avIywc41F+by6C76WkbbXTMEEc2TgC44nDBCBPAXeQ2F?=
 =?us-ascii?Q?eC0PUvpYLMhxBE+wvo/nomgp60jLuLgm7/8Ujw4DqsiFL/6T5WtZQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTeOf+XLrqY6tCVPkhV4xeDLnoFtf0wg5cQVDTHjsKjlRyyNRK39hXCVu4W1?=
 =?us-ascii?Q?kqIerqN/WVf0w2lQhZ29wSSmZKTJp8UCmqtgW4Tocl1PQGNTX0Xl39Dy2PEa?=
 =?us-ascii?Q?tWb3StFN1DixRD8znjutsO76Vn7ayEcvcw9vuzJlCegN+zULI8Hly9Cqeqa9?=
 =?us-ascii?Q?VYXdO2ZJVOPih9znzNZDKntHy/bN1B6Fftgl9PxGayjTW1tXlnq0Q+T6xQTM?=
 =?us-ascii?Q?t9+iw/0gFN8h7p8MBMDVGR+I5wNBL8Pa9r2Ib1tXGUivfD7okK70cMKNVYac?=
 =?us-ascii?Q?M04cD5HuPa5MQ8y99dN0Yh76RS6gkqS5S8AYeUVGkbO1VsvzTiwvBQmIFsaV?=
 =?us-ascii?Q?1jzyef15IdHBEZ8QkikiWyjtswe7rdAah7gqMUoMlFcxRFcovEU8c0UDR/DC?=
 =?us-ascii?Q?OjZip1oKofICktyxuzasWW10RPd0KCA7/2JXVULo1hEUMXrCo3glaY1IUUYA?=
 =?us-ascii?Q?hJmPB30NmrKR38N1Rxbrg/D8eo+DkR1OQ5Av97h6Ya99Kiv+gppxwcfQEyNU?=
 =?us-ascii?Q?KzOGNkhC2lNH1jgOXXWqiTKkYRgV++xVW0yTEAqaloxlQ7ja4BC6DNu3Rr9+?=
 =?us-ascii?Q?QvDfUZCJnt7I5LeVEyhlvRRxUyq/njzw21Tak99PWbb1DoBBm7eTIVqKGj6A?=
 =?us-ascii?Q?UXosLYnyzmG15MWO3jxIjxG7NftBANLCgU0v7gd+rXeR8TRwp5+xWkXtNt8s?=
 =?us-ascii?Q?VWek9Jdr4uV/ROAf9f6We3s1DdmKunm5yDS0szxZuTvWokcPDYaqhlBrz/f3?=
 =?us-ascii?Q?RXsS2b1VLWT8htIxprYu7FGbsyN6Lh/5eB2zcrO+dRYBpANkCxMgMCLuBxdG?=
 =?us-ascii?Q?Bs22LDuv5nwj/7IankMIgSk207QXOhpW2IptNOJA1xSDMBqP7xFLNmnfGGzP?=
 =?us-ascii?Q?eVL9uY2mmxpaHVAuhjRw4cHouu8q1LPVcWUiddTSXpVhUunO36G2/1RuXPQe?=
 =?us-ascii?Q?J2qvs+gOiZJrNMGLeVklBixYaNSzJzNnbLArboH57N62RzDNhaUwlXs1gJeG?=
 =?us-ascii?Q?4RRZPf2EoqAtUOIU/FJUbTkTMmZ+UMGFOY+fSGGI770v7uiOfZKiUQ/3L9LD?=
 =?us-ascii?Q?kKEH7pqDERvaJzALeDPgIO8xPSx+vO8rO0IdWjGd9M0WrWpuJ3RJU5kMZopW?=
 =?us-ascii?Q?9gChdzNhMyb8A6P/a8PWVWZsUdyd0rD6f1j3kKXWZtYsWaLTqvRKU/OHLJM9?=
 =?us-ascii?Q?ZgWyuFgydMHRYbEiYkkJUFzAYqeX5XiPcSDskd2dM8O6G6xKe2MiP4nfqcV3?=
 =?us-ascii?Q?+itnOdLGgmQv4cCPfBon2vw3Vocbm2TSl66arVVYFFIoPPybS8Jbi4krwJ4n?=
 =?us-ascii?Q?tocdNC/ypBJ7NkcpYZ6j0D8yELwwTpXNNqRmxSwthxQ8wxqE/FBdfGGyqK7u?=
 =?us-ascii?Q?YRYliGvmpDNbok6nCAYPLLRL0rhed8e5Yl/Vpv/XUW2FvnRqzirnv4geG8mv?=
 =?us-ascii?Q?oNzSFNymTa3rr2SDOBQ5ZzJ4kiRRV8YPISh94V46ftwYnB9oUpXdeZDC1LDm?=
 =?us-ascii?Q?wN4ljyfbttzPcpQl8d90rk5hEvMnEMyI9EO+l6bVhzmgUAQhZGYjTOvDpcZC?=
 =?us-ascii?Q?NN5OufKAWyE9yO5T0iGGz3uKLRi6HIC0crmtm6Iz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ec1ad9-5768-4989-4055-08de0a7b8bd9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:11:27.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKt6HqhsiqgjEdu9KjTZ0j1dLOoYaJtXIY9F7aBoocZNnD1qHvz2faJs4KdSKkHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

On 10 Oct 2025, at 14:02, Luis Chamberlain wrote:

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
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks.

--
Best Regards,
Yan, Zi

