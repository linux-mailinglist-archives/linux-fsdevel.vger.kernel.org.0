Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF674DD470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 06:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiCRFn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 01:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiCRFnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:43:25 -0400
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6032CCA08;
        Thu, 17 Mar 2022 22:42:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7V4qT._1647582119;
Received: from 30.225.24.52(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7V4qT._1647582119)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 13:42:00 +0800
Message-ID: <be2a500d-f8f3-f813-cb9e-04ac1726e22d@linux.alibaba.com>
Date:   Fri, 18 Mar 2022 13:41:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 21/22] erofs: implement fscache-based data readahead
Content-Language: en-US
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-22-jefflexu@linux.alibaba.com>
 <YjLFsCLeEU9glmNf@B-P7TQMD6M-0146.local>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjLFsCLeEU9glmNf@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/17/22 1:22 PM, Gao Xiang wrote:
> On Wed, Mar 16, 2022 at 09:17:22PM +0800, Jeffle Xu wrote:
>> This patch implements fscache-based data readahead. Also registers an
>> individual bdi for each erofs instance to enable readahead.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/erofs/super.c   |   4 ++
>>  2 files changed, 157 insertions(+)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 82c52b6e077e..913ca891deb9 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -10,6 +10,13 @@ struct erofs_fscache_map {
>>  	u64 m_llen;
>>  };
>>  
>> +struct erofs_fscahce_ra_ctx {
> 
> typo,  should be `erofs_fscache_ra_ctx'

Oops. Thanks.


> 
>> +	struct readahead_control *rac;
>> +	struct address_space *mapping;
>> +	loff_t start;
>> +	size_t len, done;
>> +};
>> +
>>  static struct fscache_volume *volume;
>>  
>>  /*
>> @@ -199,12 +206,158 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>>  	return ret;
>>  }
>>  
>> +static inline size_t erofs_fscache_calc_len(struct erofs_fscahce_ra_ctx *ractx,
>> +					    struct erofs_fscache_map *fsmap)
>> +{
>> +	/*
>> +	 * 1) For CHUNK_BASED layout, the output m_la is rounded down to the
>> +	 * nearest chunk boundary, and the output m_llen actually starts from
>> +	 * the start of the containing chunk.
>> +	 * 2) For other cases, the output m_la is equal to o_la.
>> +	 */
>> +	size_t len = fsmap->m_llen - (fsmap->o_la - fsmap->m_la);
>> +
>> +	return min_t(size_t, len, ractx->len - ractx->done);
>> +}
>> +
>> +static inline void erofs_fscache_unlock_pages(struct readahead_control *rac,
>> +					      size_t len)
> 
> Can we convert them into folios in advance? it seems much
> straight-forward to convert these...
> 
> Or I have to convert them later, and it seems unnecessary...

OK I will try to use folio API in the next version.


> 
> 
>> +{
>> +	while (len) {
>> +		struct page *page = readahead_page(rac);
>> +
>> +		SetPageUptodate(page);
>> +		unlock_page(page);
>> +		put_page(page);
>> +
>> +		len -= PAGE_SIZE;
>> +	}
>> +}
>> +
>> +static int erofs_fscache_ra_hole(struct erofs_fscahce_ra_ctx *ractx,
>> +				 struct erofs_fscache_map *fsmap)
>> +{
>> +	struct iov_iter iter;
>> +	loff_t start = ractx->start + ractx->done;
>> +	size_t length = erofs_fscache_calc_len(ractx, fsmap);
>> +
>> +	iov_iter_xarray(&iter, READ, &ractx->mapping->i_pages, start, length);
>> +	iov_iter_zero(length, &iter);
>> +
>> +	erofs_fscache_unlock_pages(ractx->rac, length);
>> +	return length;
>> +}
>> +
>> +static int erofs_fscache_ra_noinline(struct erofs_fscahce_ra_ctx *ractx,
>> +				     struct erofs_fscache_map *fsmap)
>> +{
>> +	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
>> +	loff_t start = ractx->start + ractx->done;
>> +	size_t length = erofs_fscache_calc_len(ractx, fsmap);
>> +	loff_t pstart = fsmap->m_pa + (fsmap->o_la - fsmap->m_la);
>> +	int ret;
>> +
>> +	ret = erofs_fscache_read_pages(cookie, ractx->mapping,
>> +				       start, length, pstart);
>> +	if (!ret) {
>> +		erofs_fscache_unlock_pages(ractx->rac, length);
>> +		ret = length;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int erofs_fscache_ra_inline(struct erofs_fscahce_ra_ctx *ractx,
>> +				   struct erofs_fscache_map *fsmap)
>> +{
> 
> We could fold in this, since it has the only user.

OK, and "struct erofs_fscahce_ra_ctx" is not needed then.

-- 
Thanks,
Jeffle
