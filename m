Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF54C7DB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 23:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiB1Wt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiB1Wt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:49:57 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D956205;
        Mon, 28 Feb 2022 14:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N84eiNEGWUnYQBvwc4j1m51WpG/MRoVLQ9pXsoAKJhndp6fFPRitHl7b4iq3nqtfVGwXUQyaN/sftxWOJRi17J7MtyH35JiSeyR99bwLnHbxJWLaWasO0AdjodS9M/vfto3/w1EwqqVD+uOifjdptYgmsb7LuvD2g/TulwB1BAtFq39gMrlxsenDuQj2kDz9DlGZnIxa73SA9TP7u17l/GNh4ewTY/36RVeDWVdYFW6T7ks/fEZrT2E50nd1x/FYBFNtc8q+bsBRA7M+FqnxDE3Znd7NfMv8Q9vPE7PObMvU8WSjsSbpmM3bk1n2p1O0cJJdAFx13EooO6K8H1tOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuqRabi9lpLuspid5GUJ60pcD0deIPUJxE8Rbwc8iys=;
 b=gS2bcSsB62wLHSPeXB2CoSoTivxCy5szs0SWjocMtm7pZZ6nS+cFSDK0VsxaeY9hmsGuPTsRL7Pkz4OH07VPZkYMt3XQegWMbWaXO/LoqPOpWNEcFJLm/IgJ4+OwxwHLQBDx+sxN7jvyZ3/fRXAkNZCZZgi5Ljni6YtFp9HWKGg/aTx2C9CLaNhtLhkR7R0eSZHMdTdCGcbb75CENsywHDo6lfNMA27sz04WZvqyFU7Xt2qPZUQnKx7q3nkk97uww7uDb7az1ce1KrMmZ+w+gfmvOuheC4HMcFbYhEKgIok9rJCybpyuecdxxwlQrNmaGiVYgVF2sDRSlarlSi9q6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuqRabi9lpLuspid5GUJ60pcD0deIPUJxE8Rbwc8iys=;
 b=O/F01zlFBMZCV6l0qvlHVXpr4ayYW6Bd56QJEAiDGMDeFSFcM7v2HlC1KI0fkeO9Hw1YZwKacCSy4AneAuhQ/zgEIPCDb3MOGWSrEdyIidSNvo8DHVpm+sEmEa4UTzan5CUx+AU/igjGjPviUx87BaNA83pbbXVjbPI2ApSjtd4cWlOKhJQWB82zlNTJ4/UfsIuRKWLPoAJI1FuA7rRKSwz30XF8bKQJPeeWIf9V9ylvZPOZOlGmPhyCjIO61/6DxwvqDz2GiEhqxFleyb0RVrdemLvmbEb/UY7IPycJRNoFKIQcJPigHjdrPAAbS28wpxGNfKNSHh1ZSD2zUv+p4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 22:49:13 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 22:49:13 +0000
Message-ID: <0c5bcd23-607f-2ef9-daa0-11557c9f8e8f@nvidia.com>
Date:   Mon, 28 Feb 2022 14:49:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/6] iov_iter: new iov_iter_pin_pages*(), for FOLL_PIN
 pages
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, jhubbard.send.patches@gmail.com,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-3-jhubbard@nvidia.com>
 <06469550-a679-145f-b16e-2f1ffc0b07af@kernel.dk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <06469550-a679-145f-b16e-2f1ffc0b07af@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 881226c2-a71b-4fbe-ad9e-08d9fb0c8a8d
X-MS-TrafficTypeDiagnostic: LV2PR12MB5943:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB59435124B8E475C4A9BB2E31A8019@LV2PR12MB5943.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLlxyC8aF2x+DnMRH38YDkptM8D/D+neYlkS4AijVyKYLnQ+nheZWdx0bRrk1idL0x/5HtCWBn0OX0E6GilPaYS+0Wz82XdArIQTTOJnhxdbsy4kJpa+QiyUsZ+61Ypr8W3hXC+rH/nZoukcS9YQanqdxhYdWmpHTtby3f4D/XdOVi18s/bfTQIA+eZFIMVcntRqrA1tXNSYfByEtqmnmD1wxXL+TK3qlE9h1G8Z0AWYWbye4mVFuhsW+P8zRxsB3oU34DqNY4IRIHVbu6tbs28WUtnyH2WPGeh+6fnrLFE2uN1xbBq9CDE+PdZMnPADApMTow3AdgFbOVjWDcJuOKjuLPl5Cd/UcNGVP+k2bslE1Hmjk82d74r0qVho/BFiatuGVDkc3XWaU5Q0OYjxX5jz7VfrWPcgkD5IEE9hzxG/4P0YEJmFyzMJD+t7Xg48HLRfNqCEkG1vBRoLnJ9YKD5Ud/uUVvHn/D+XrDqcCFDquSFiiTIfSeAi2PgI3/JKA1yIpxQesby4Kvf1B5Xdm13E7MeYskwk9Ib12iy8VAGl/z4J2Em7evKysKPKs4P0G7RkQlIeuX99+NXWmLmjs9whFnJ+EVXlyERqarGHfPDfLUIx1GIYXL1Ih+a6bLDGbodrlYDuU7iE6Plu082C77Ezs6fH82nNx7t4Wzs60egiqf4M6t7C6rERZCzWaGuRKLDApi/t8tLhf3YhN0hRQ6FZTWqtchoBC2xFqT2x9YfBxkncEKHZMb+RTv3d2EUHSLpmnhU8gtDyFDU2t6fO0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(6486002)(66476007)(8676002)(110136005)(4326008)(508600001)(31686004)(66946007)(8936002)(5660300002)(7416002)(2616005)(36756003)(53546011)(316002)(6636002)(6506007)(6512007)(2906002)(921005)(186003)(38100700002)(26005)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFYRUt6ZGJjaEdyV1M3dEdJaUN0TVdUMHFoTWJWa2ljMUlVaXVqVlVXczRN?=
 =?utf-8?B?eUhySjlpbCtoY2dRTUtlL0tsZGhnci9NUk43a2xMLzlENlFoZzdBTkNCYVA0?=
 =?utf-8?B?amFuOXc3N3pHeGE5dTVGcUZ2Tm44NnlGUEczUHBzUkFpMFFFV25TRnErTkN2?=
 =?utf-8?B?SVp3LzB5QnhxZDJCQmVycmN6M3ozbnVBUjNVOSt5L094WUZOSU1rSHlUVThs?=
 =?utf-8?B?aEFaa0xVdFFMcE16cUNJS0ZONTFGamV0NVN0NUdFS3hIbU5OVHcxWkJyRHFT?=
 =?utf-8?B?YzZUL0JDb01nMlVVeEgvNi9MMzZXcEFzMWlvTWZ2ajhSQ05qS3NIZ3VYS1Fj?=
 =?utf-8?B?c0Mwek4rT3N5U3c0czM3ZnpCNnFieXQ2MEFaaEFsMHVtQkdvbm5XUFJVODMz?=
 =?utf-8?B?VWJFNWhMWHdZcFdvUC9MaDduQi84Yk5PMlRDVnJoQkJWdFdLditKazJma042?=
 =?utf-8?B?SWtyalM5QnhWMFI4TGhJU1lZV003ZDhtbURvMlkyMVpreU15MTN3RHAwVHU5?=
 =?utf-8?B?Yks0aHI4WHNTdTA0eldRRzF5VDk5dU43aUNyU1lkUXUzcEc5MnFGaXZHNGM5?=
 =?utf-8?B?TlplelhJVGpmTVdLSnRxZ3ZIWnB4LzBiVndtdEtkUEVCSnA3UDcrNjAxdmNX?=
 =?utf-8?B?MmVlVGU0TWo5VkNzUi9JTTVycGFDUHZUZVBQSHVHVmREbDlIaFltTGVkS1Ba?=
 =?utf-8?B?RDk1UWJMYXVyV0Izamp0dzgxNVRYQ0J2ZFNZbjJ0M3RUT2RQc3BEMGxJaXh4?=
 =?utf-8?B?Y0FWNmRoNVpjQy9qTDRlUlFkZVFsNEJUVEprcjJkOGVucThrZ1JodzNYdC9S?=
 =?utf-8?B?WkxIQnpuMHd3ZHdpNjRmdFJTKzVmLzFXOVBzL0xxRWl6RGRMQnlhaDNxdG9r?=
 =?utf-8?B?UVZSRHZkSThDUVhheERpeTZ2eVVJcGI2L3IyMzVkR1V3SXRTaTVxdzE1L05p?=
 =?utf-8?B?dXJMSXUxZWlReis3bmhic3VPQ2ZINUFKdm1JNGxUU3hFRGJWV2o5M3RKUTlE?=
 =?utf-8?B?VGVIVGxsSCtBcjFqUHYraGJCQWgyR2E5OWxqbkZjdFRDQXNVd2MwYnd3and5?=
 =?utf-8?B?RFpnelNHKzJXekJ5L05tbjNBY3lQMm1HWHp5WjZDMzFXWFg1U3lCOThWNE1Q?=
 =?utf-8?B?MFNSUGN6bHYxNUxabmNVY3FuZjcvRWV1cXBYaVlDRmcrMDVva3VkaXVzOW51?=
 =?utf-8?B?cEt3ZENQV1VzUnNVZEhWdzIyMWtWVmE0d1NFdm9jOHdVQzJsS1FUanFsT1FO?=
 =?utf-8?B?dmFGT2RKc1V5U05Vb0JLdGNGeCtFTURvTkRuVzB4d21VZGRGSThGeFg5eVlE?=
 =?utf-8?B?Q09FY01abk1xa0dIeXRRa3VCVjFIcWxqRWgxSlJidWwrK3VjUHE1bi9TbDhB?=
 =?utf-8?B?UDd2dDI5WXlCSVNJYzUyVGdBaW1xMDE5eVhyKzljUTV2S1pnY3ZtZ0FtY0gz?=
 =?utf-8?B?QVBzQWI3bjdxTFhkdmhocjZoeXpvNlhtR3FpVGJteE45WWJHQit4enlTL016?=
 =?utf-8?B?VVFmSk1HT3pSQ0U3V2ZwQTBrYkpVaUFpRjFzRFNvOUh5SHpWSDJyRHRSN2Jz?=
 =?utf-8?B?WkZmdmlwTkdZUGMvUVNlaGk2MmI1alZ1Z3FZVnB4amEwb1JCQmVQcXNDQ2NU?=
 =?utf-8?B?UHJwaFh0U0hRSEsyekJvQU9lNVUxd2tFM2V3Yjl6MWtvancrSlpiSC9BVjND?=
 =?utf-8?B?WVpGcWFJY2g2MXdtQTRpcUlaN1NlT3lWeTZvODVQQlhKVHc1a1dYUlFrZnpS?=
 =?utf-8?B?L1BqOW1Jb0hXT01jL2F5WXhRYmwvbnJ1NklqWWRJb2xrUHRPT0dDN3JDS2Vy?=
 =?utf-8?B?SDlXWFdDR08zeHJzWEp1VG1yNlJsL01Lc25uRmdTMzBLV05zb0pZTk9QcHdY?=
 =?utf-8?B?ZW9TRlhXSlpiK2JYZjkxTUpjUjJCSU9jRjB1S2VaYXluRHBxWVJmcjRmSW95?=
 =?utf-8?B?b05aMDN1OTNjVHptM09YbFJjbzNWUnNBTEhEcE5DdXBBd2dqb1crYkxqN0t2?=
 =?utf-8?B?OWJUaHI1Sk1vZzIwajZKUW9DbXp5SEFvd0J2Uk54QmRwamI3MzdVSWZuVU9y?=
 =?utf-8?B?cDByTzg1UDRJa0ZsZ3FXdnNIcndnUjRPRzBmMzlwZ2VGQnhkZlpEeTVta3pK?=
 =?utf-8?B?ZkRkeXBlMFUrcXJMVDF2N1lFMFRyaFdDRlVhUmYwYU5BNHVvbU9kOVFZanNY?=
 =?utf-8?Q?b5DR/IGUJJBHJKce+J5Km+U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881226c2-a71b-4fbe-ad9e-08d9fb0c8a8d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 22:49:13.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYMAeJRBB42T8RdwLoaq7ql/fqrOMNVJ0MeYzX0z97TKEWCfI7MKk5v2TI9qu0S2R/4+a569kVcPpMTGLxvKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/22 13:57, Jens Axboe wrote:
>> +ssize_t iov_iter_pin_pages(struct iov_iter *i,
>> +		   struct page **pages, size_t maxsize, unsigned int maxpages,
>> +		   size_t *start)
>> +{
>> +	size_t len;
>> +	int n, res;
>> +
>> +	if (maxsize > i->count)
>> +		maxsize = i->count;
>> +	if (!maxsize)
>> +		return 0;
>> +
>> +	WARN_ON_ONCE(!iter_is_iovec(i));
>> +
>> +	if (likely(iter_is_iovec(i))) {
>> +		unsigned int gup_flags = 0;
>> +		unsigned long addr;
>> +
>> +		if (iov_iter_rw(i) != WRITE)
>> +			gup_flags |= FOLL_WRITE;
>> +		if (i->nofault)
>> +			gup_flags |= FOLL_NOFAULT;
>> +
>> +		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
>> +		n = DIV_ROUND_UP(len, PAGE_SIZE);
>> +		res = pin_user_pages_fast(addr, n, gup_flags, pages);
>> +		if (unlikely(res <= 0))
>> +			return res;
>> +		return (res == n ? len : res * PAGE_SIZE) - *start;
> 
> Trying to be clever like that just makes the code a lot less readable. I
> should not have to reason about a return value. Same in the other
> function.
> 

Here is a differential patch on top of this one, and only showing one of
the two routines. How does this direction look to you?


diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e64e8e4edd0c..8e96f1e9ebc6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1588,7 +1588,17 @@ ssize_t iov_iter_pin_pages(struct iov_iter *i,
  		res = pin_user_pages_fast(addr, n, gup_flags, pages);
  		if (unlikely(res <= 0))
  			return res;
-		return (res == n ? len : res * PAGE_SIZE) - *start;
+
+		/* Cap len at the number of pages that were actually pinned: */
+		if (res < n)
+			len = res * PAGE_SIZE;
+
+		/*
+		 * The return value is the amount pinned in bytes that the
+		 * caller will actually use. So, reduce it by the offset into
+		 * the first page:
+		 */
+		return len - *start;
  	}

  	return -EFAULT;

thanks,
-- 
John Hubbard
NVIDIA
