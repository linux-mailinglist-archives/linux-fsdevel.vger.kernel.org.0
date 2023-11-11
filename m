Return-Path: <linux-fsdevel+bounces-2744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3C7E8918
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 05:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B319B20BAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 04:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215863D4;
	Sat, 11 Nov 2023 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C563AF;
	Sat, 11 Nov 2023 04:02:55 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4D3868;
	Fri, 10 Nov 2023 20:02:51 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vw6AFnB_1699675368;
Received: from 172.17.2.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vw6AFnB_1699675368)
          by smtp.aliyun-inc.com;
          Sat, 11 Nov 2023 12:02:49 +0800
Message-ID: <33d6a487-5913-fefd-2a45-d8d397e6f6ba@linux.alibaba.com>
Date: Sat, 11 Nov 2023 12:02:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
To: Matthew Wilcox <willy@infradead.org>,
 Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <djwong@kernel.org>, gfs2@lists.linux.dev,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20231107212643.3490372-1-willy@infradead.org>
 <20231107212643.3490372-3-willy@infradead.org>
 <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>
 <ZU5jx2QeujE+868t@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZU5jx2QeujE+868t@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/11/11 01:09, Matthew Wilcox wrote:
> On Thu, Nov 09, 2023 at 10:50:45PM +0100, Andreas Gruenbacher wrote:
>> On Tue, Nov 7, 2023 at 10:27 PM Matthew Wilcox (Oracle)
>> <willy@infradead.org> wrote:
>>> +static inline void folio_fill_tail(struct folio *folio, size_t offset,
>>> +               const char *from, size_t len)
>>> +{
>>> +       char *to = kmap_local_folio(folio, offset);
>>> +
>>> +       VM_BUG_ON(offset + len > folio_size(folio));
>>> +
>>> +       if (folio_test_highmem(folio)) {
>>> +               size_t max = PAGE_SIZE - offset_in_page(offset);
>>> +
>>> +               while (len > max) {
>>> +                       memcpy(to, from, max);
>>> +                       kunmap_local(to);
>>> +                       len -= max;
>>> +                       from += max;
>>> +                       offset += max;
>>> +                       max = PAGE_SIZE;
>>> +                       to = kmap_local_folio(folio, offset);
>>> +               }
>>> +       }
>>> +
>>> +       memcpy(to, from, len);
>>> +       to = folio_zero_tail(folio, offset, to);
>>
>> This needs to be:
>>
>> to = folio_zero_tail(folio, offset  + len, to + len);
> 
> Oh, wow, that was stupid of me.  I only ran an xfstests against ext4,
> which doesn't exercise this code, not gfs2 or erofs.  Thanks for
> fixing this up.

Assuming that is for the next cycle (no rush), I will also test
this patch and feedback later since I'm now working on other
stuffs.

Thanks,
Gao Xiang

