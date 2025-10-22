Return-Path: <linux-fsdevel+bounces-65213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44FBFE2B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF7B1A0243A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE2B2FABED;
	Wed, 22 Oct 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tz14tQ2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4302F549F;
	Wed, 22 Oct 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164952; cv=fail; b=MHLUwizMSCgij4eVZDze51LmxudUVQlsbK3pW62BxgxPC7kKnlcIBrhYKqP9VEOHY9usOZmw08/TuHK+aB3utPCmu7n17SUcE916CYJgGRD4T7IqmXlqIf9dxFiwnW5jceyUaFoSYRtnqU8XioIh+bOS87YEY1wXo65zjp0+7w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164952; c=relaxed/simple;
	bh=EtQ6FRDFTb//uQj0IxG/CP2EqDOeIuGwxMgAuytF2Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFxR9LzzIwNq9yL2p2aM9nEXB4XWNps7p4rpFx30alzwKyuqWEw8FGvdr0zwxVwNwgsuxKim3Wp/s7wtjlEhuiR0xGdaVaTfLP1ps+xAH0jNhIFze6IYhvguxP9HB12CocV2ox16UBxNj7fgs1xvMaHMdA8E8fysRg1zNksao6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tz14tQ2F; arc=fail smtp.client-ip=52.101.46.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfpMBKVS8LDyUYiAA57hR266QqYgxuDuScRdjXUB6WXQ3kbzvCVMqbTxFdjYDbmHngBn8YGt2YnLjiCoqUvPHZ0x3jQS6iP1jLTlI5tX9xDIXt79K8ki1HIHLC4/J9u+YtTiIu59XDz/9phgnqMVhBLFoalNTEY1Jr1TvuL4Rn1X45rycyoCLn14uPFC+oCRfRlvTgJktbXvlhVfQ1FkSFddHfztXZKDqTlnglEZ8vP/yvReoGVe/BKJIMVvKP/r3sfLVtB6sKIYTTKLCks1pba84UJxZgyyGpN5cmxyZ2nn5v9w8kHJPixNII/W1JgiWxYm8hZ4z46TtVAv6gmtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSXjHM/TMmXXJmZBgJVUDzm3lFdRwIcZxTO26Jem2hU=;
 b=iwIc+yZ79npg4vnCaRa65ly6q85uugtBCnvs3UATkIO6zYJq1RBm3ijrNkzywBHrfr/pV40GV6ppJhyEe5vQrSS9U2w7aXS5MbR6JyMCsa0+eyXQa3/k/Y4IAX16dvnGE6ZJFILbf/7qcMQlwIjfGXpQv+LeFZ4WSlnNI1d3tg3Za5Yw/65I5rJf6M7fhqFvNcv126WvVuZtnYvhC5oKy4yM9a0R8q4lFRw3KcW7OYGY96TW8NjpZeB3jH/oytoEzwhpTBeYQ/8pNUtdISVCqcNE+7pzsAua+CQkCt/3ouQXeKnqAKliuvQ9X3lLgNv+ymCq4dBiXX5GQABtwwiQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSXjHM/TMmXXJmZBgJVUDzm3lFdRwIcZxTO26Jem2hU=;
 b=Tz14tQ2FMxBQbcj4y7ZnjjHZOknZleUoGPWgeVYdVO88qqaozoNyU0dpIt9f/CSTKpW0QPDeSvj4HhN2y7ghtvamzHXb23PoGFPEbP3HeJlZPY3VYsQZLD4MjV/rVMoCnkEs49Sce6HQAtJg/KBS4dEwDc3H7WPEXnhtQNFeJ7alXMUSlPpRLcG6yEIPaTdO77lbVtJlHro06KFjkbMT8nz8maJmWECjK68LPpYIfJUSFXySb7T6rhjDkok5cfxuND0d6Wy6dAmP2pim2K/O2Ha3qeA3LfQ2UFnoK+9YG+xyhGn4xUTV81n12tQxSRlwoPQS7Uvh9xJcyP07h1CagA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 20:29:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:29:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linmiaohe@huawei.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 akpm@linux-foundation.org, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] mm/memory-failure: improve large block size folio
 handling.
Date: Wed, 22 Oct 2025 16:29:04 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <3A152581-3A99-4610-B16E-1A34A3039E55@nvidia.com>
In-Reply-To: <6279a5b3-cb00-49d0-8521-b7b9dfdee2a8@redhat.com>
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-4-ziy@nvidia.com>
 <6279a5b3-cb00-49d0-8521-b7b9dfdee2a8@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 00837a4e-e1e7-4dee-22a6-08de11a9a610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Uzz6qGVda+Vyy86GO45oO9LpvCp2HgFuvBFiaMKgb2US4R3R2Mz/UB7VUaa?=
 =?us-ascii?Q?CRPA9ATn8y+hAA1yzsI/uLcEcY1P/Pa6FGuE4rKtLn+JGRNPV9idrosMhdaS?=
 =?us-ascii?Q?KQzAlCPj7qYW6PUz2fivKJg0dJGrAQ/tobMyghb5j32OW3gqnwjbJQiqPPL4?=
 =?us-ascii?Q?/D66NEu0RceS71mfw2u0GvVnjsLVV5Jvvi4g6C9SVi02z9W75psH90aNJmtq?=
 =?us-ascii?Q?jREAF08Rf8MTWR67gbImSKWT0ZnCtb2nZHwxQ5B5ukemZcgFUZWFfZFqXODI?=
 =?us-ascii?Q?DaR3ZYyRgxa0WsvAzLDdb9vGVrhh+YFRS6SVZ7spuVp0CtJan5T+mbmdkuQZ?=
 =?us-ascii?Q?hI/NChU+09Cy8osbJhpDNQwnnLHqt2BmdG5Z2ibahPu+cgJ7ddwBWFICAqT3?=
 =?us-ascii?Q?qHuksDOQzrNiVXpN1FKkDB4+q+OeWF8qMxWGQAT6liQqbAxdgFHUOz4ma+90?=
 =?us-ascii?Q?OjWN2qISVuxNV4T8o46st2pbIanLISC0oPs2+XrjDqADD5qUqpajo/aQ7zFE?=
 =?us-ascii?Q?wPiPy86vkf2M1gmdLSKRwImJksWImREvlsi/LZ0uK6qKZlorJRqv3Y0h8mXg?=
 =?us-ascii?Q?g2FF7pVuqglTWKDlf72W4xhw+a/1MiGzPPNE6GKm8IcB+Fl25ecl8JIcEB2q?=
 =?us-ascii?Q?Yi8vb7Rc8VqD4YdjTFYc9ao6VYvd7o/rllIeHVGyt3UTZNg4zuFkzbQYLgDd?=
 =?us-ascii?Q?BOUwj3H8cB1V7cIfAwfr/0euSpnueD3sN7Xt4NIkYCNQMJQbslKI/RJshpWD?=
 =?us-ascii?Q?OBDKiPeaLCuDyiv9GK7LbQlrhanN4vPy8W6ePrGUL2/3cJdWIg5nmbTITRiQ?=
 =?us-ascii?Q?8tkODWnRBdKwWW0dsIPXVDHEQr+jiMdN4p2cS8JSEOVtCU9TDKXDrQCOUUQd?=
 =?us-ascii?Q?yBfug56tFbx9a5ZgM4y8TRRNObb4KvfALgV3m145ONGtORPQ3+WPjar9Jn15?=
 =?us-ascii?Q?brUcACNNCBSXU6XhD7Frk+NfToajxJbgsR/aVXYieAPvR67i3pcAWmPjCJ1P?=
 =?us-ascii?Q?2+rMPDsN4cSxZQpt2bSsKfzP9Y9FA9XS3E3x0p7vnXaIxOf4vCQB0sQs7eC4?=
 =?us-ascii?Q?xF9i/0+FRNVVvQtr1HbGqdgIUA44Nre9bYapB06AQdilYIrb9H01SyuLcToL?=
 =?us-ascii?Q?/PwzUr8LJgThAOLs6u10ma1pvLLPw3Ql/nIinQfSAPenXpBCKaUTPSadb48b?=
 =?us-ascii?Q?YHJN0+Chq1rziKl9pWI/wgzJ4TxuyoBI6Z5O5qClDfO/36ZBzon1IX/AsMpu?=
 =?us-ascii?Q?bcoZRCUFLW6LgNJhvSepcyShigWRqYJiLYff+ue6ti6Xf15IoeMPGLkS1xO+?=
 =?us-ascii?Q?J7kWAb+Fk+qv/CHWWxSnEJtgPYQLDZXRA9yicXH3QsZfQvm5nOe8Kb03GOll?=
 =?us-ascii?Q?oeLvX2YCNDM451wkYlUQDZNUJmxfMhzV5+pytaIQBUrugtZhXWUoY839r7mF?=
 =?us-ascii?Q?vZIxPhuhJjcHCZBNsjlokX0+HX+LlVzL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvzXxF+esu1T9kBK4fEpdEdTYT88kjmK1Jp9HVNZTSoEudrU07f/21Om/0hd?=
 =?us-ascii?Q?W9hI5wjQ8cD7jQko9hnFeEUBfNVmG/DhOAjIHPSsYPEp5nlVDW9OkwgUhKB9?=
 =?us-ascii?Q?iDoPNqdXBF3e0zyOel1Kq1SNykvRVb9L2INWGUjCxx9/kYfl9Rjpkapyk17Q?=
 =?us-ascii?Q?c+20FLVY/8meZF7gjSBJDF9vCUOXrHDNO+KW6FLF61ujMOCiLQb7KaFfyyVH?=
 =?us-ascii?Q?fXulwiHEECc01e1gyjlLmX9TL/dd+dZa2o/hRfkKeUCBCIhrscHPjOs4E1HV?=
 =?us-ascii?Q?SXhHWd7bg8PBqQh2v844P+PicEpJmCIWeusoe2FZI+OLm0Px3JDDLABdihcy?=
 =?us-ascii?Q?OUogB7lu9FqJ4s9O27pFsABcTFCRscNqhpUK2dbRhRNeT5b6wjPWUFvCBV7T?=
 =?us-ascii?Q?HTGgxVX3oDkHkXNyNkyXyrVv0Bo/6W7af/juHQK6gDbWBDeW7U0jBrZSApLr?=
 =?us-ascii?Q?X0u+Dg2RsefW1PM/SBvvGGhIqvOAfu0BdVEllC68nrlC6IeUhbsUiBjU3rW+?=
 =?us-ascii?Q?+Qp/f2mWd6cnom4Dbb1eYBJTUFxcBl4z88CiBL3JzjPVXqKsgLHA8ZzWZo1h?=
 =?us-ascii?Q?VgJo1zMoYrL21MRkg7ISfk8oNgO5DGCAzxegjpeqIwtN2S8ESP1VbuTxfiAD?=
 =?us-ascii?Q?+1ggf3vA+gwPqiI70Tfd7X6aa9kkeJlv8cXJqf9hp6UnraFDc9LEJEkbOaq0?=
 =?us-ascii?Q?S+OweTgrvYWwrf+DB2az8efvsjMqErA6o5IRXQLU5LIPUinCbev+Qw/RA9fx?=
 =?us-ascii?Q?RNOLqoOAQ/IpEQVaUFnbO5Ay6M7/SlMTtxYzjCr1sgMIeA6+sxok2HKuZfzz?=
 =?us-ascii?Q?+vjEuosslsE8ymRRZfPwIJCSnyR3+a0I8u29KXm1bLF8gYPpFMvOIYCP45HD?=
 =?us-ascii?Q?9q24cvoM5ZA5LTLQWGHBO0sAPdMl5WqiT+Avf1Z6W9UJDJDA71shffnP5nKA?=
 =?us-ascii?Q?MGiCQCyJiQ0dyqTAJITHE8eklZlVrYbQ3GM4k64U+8j0mX8ZHR+T+n3sp8at?=
 =?us-ascii?Q?o/BNwBRXeBkenF6ofeu3TjlDzpuqlwHghnYxYFTvz5XGxPUMlzkZDy0hDm3+?=
 =?us-ascii?Q?rYylb6YGK/bUY9Rs6OnvyKNtagILFYJp1++WfPjv30jxpRvtwjHz8SUh9CBP?=
 =?us-ascii?Q?Zg2udZMdmpMPQUDJFjuoUOZqCdVSXk1JPYtJjq4M0N6865GvVm7IOxfLcFt0?=
 =?us-ascii?Q?WzXDJhIVm5aluXTm0ZGJuooexspQT1cSI447M046HSDC0loKNthQrBHheJQ4?=
 =?us-ascii?Q?4Yk/boNRzD5qcTsOHvn81m/DDlDuG0iifwUyvzlPAmwaO+8PMlRZ+69ti2UH?=
 =?us-ascii?Q?eHLX6Ijf562+4G3PuuMaiKS1uaiPVy7YuzkuoyGIPhjTMFh/KnTtKy8+29s3?=
 =?us-ascii?Q?N5bL4Y+BSXbP3+89vFwae8wsRRi6yjCbmPwKZ+mlszp3XtB62vB6F4uaVTC/?=
 =?us-ascii?Q?OcAAjInD4xvtMSviIDfktkS9EKSHWRJrUVwpW9/9R9SgBKnFt24sN1mKTCoA?=
 =?us-ascii?Q?KEGwTbNG40c19jSv8pEMcD0eJvNFb2cggJm+qAW7O5YwJv+t5TH81Q8EArYB?=
 =?us-ascii?Q?qxDgbSdpU0/M3NGp52QRZxcf85m9zUwXbqPAlC8w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00837a4e-e1e7-4dee-22a6-08de11a9a610
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:29:06.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDa5e3geIOHrNxfXRwLa+MA7GoS/0lcoVROSsu71MIeJ142Xr/g3ct2pY6lDngqF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194

On 22 Oct 2025, at 16:17, David Hildenbrand wrote:

> On 22.10.25 05:35, Zi Yan wrote:
>
> Subject: I'd drop the trailing "."
>
>> Large block size (LBS) folios cannot be split to order-0 folios but
>> min_order_for_folio(). Current split fails directly, but that is not
>> optimal. Split the folio to min_order_for_folio(), so that, after spli=
t,
>> only the folio containing the poisoned page becomes unusable instead.
>>
>> For soft offline, do not split the large folio if its min_order_for_fo=
lio()
>> is not 0. Since the folio is still accessible from userspace and prema=
ture
>> split might lead to potential performance loss.
>>
>> Suggested-by: Jane Chu <jane.chu@oracle.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> This is not a fix, correct? Because the fix for the issue we saw was se=
nt out separately.

No. It is just an optimization.

>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   mm/memory-failure.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index f698df156bf8..40687b7aa8be 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long p=
fn, struct page *p,
>>    * there is still more to do, hence the page refcount we took earlie=
r
>>    * is still needed.
>>    */
>> -static int try_to_split_thp_page(struct page *page, bool release)
>> +static int try_to_split_thp_page(struct page *page, unsigned int new_=
order,
>> +		bool release)
>>   {
>>   	int ret;
>>    	lock_page(page);
>> -	ret =3D split_huge_page(page);
>> +	ret =3D split_huge_page_to_order(page, new_order);
>>   	unlock_page(page);
>>    	if (ret && release)
>> @@ -2280,6 +2281,9 @@ int memory_failure(unsigned long pfn, int flags)=

>>   	folio_unlock(folio);
>>    	if (folio_test_large(folio)) {
>> +		int new_order =3D min_order_for_split(folio);
>
> could be const

Sure.
>
>> +		int err;
>> +
>>   		/*
>>   		 * The flag must be set after the refcount is bumped
>>   		 * otherwise it may race with THP split.
>> @@ -2294,7 +2298,15 @@ int memory_failure(unsigned long pfn, int flags=
)
>>   		 * page is a valid handlable page.
>>   		 */
>>   		folio_set_has_hwpoisoned(folio);
>> -		if (try_to_split_thp_page(p, false) < 0) {
>> +		err =3D try_to_split_thp_page(p, new_order, /* release=3D */ false)=
;
>> +		/*
>> +		 * If the folio cannot be split to order-0, kill the process,
>> +		 * but split the folio anyway to minimize the amount of unusable
>> +		 * pages.
>
> You could briefly explain here that the remainder of memory failure han=
dling code cannot deal with large folios, which is why we treat it just l=
ike failed split.

Sure. Will add.


--
Best Regards,
Yan, Zi

