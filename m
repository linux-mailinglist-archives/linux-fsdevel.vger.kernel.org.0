Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2691484C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 03:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiAECaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 21:30:01 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60996 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237084AbiAECaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:30:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V1-XTae_1641349797;
Received: from 30.225.24.102(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V1-XTae_1641349797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 10:29:58 +0800
Message-ID: <58e983fa-f913-d663-9719-0111b9130688@linux.alibaba.com>
Date:   Wed, 5 Jan 2022 10:29:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 13/23] erofs: implement fscache-based data read
Content-Language: en-US
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-14-jefflexu@linux.alibaba.com>
 <YdRcdqIUkqIIw6EP@B-P7TQMD6M-0146.local>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YdRcdqIUkqIIw6EP@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/4/22 10:40 PM, Gao Xiang wrote:
> On Mon, Dec 27, 2021 at 08:54:34PM +0800, Jeffle Xu wrote:
>> This patch implements the data plane of reading data from bootstrap blob
>> file over fscache.
>>
>> Be noted that currently compressed layout is not supported yet.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/erofs/inode.c    |  6 ++-
>>  fs/erofs/internal.h |  1 +
>>  3 files changed, 97 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 325f5663836b..bfcec831d58a 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -65,6 +65,97 @@ struct page *erofs_readpage_from_fscache(struct erofs_cookie_ctx *ctx,
>>  	return page;
>>  }
>>  
>> +static inline void do_copy_page(struct page *from, struct page *to,
>> +				size_t offset, size_t len)
>> +{
>> +	char *vfrom, *vto;
>> +
>> +	vfrom = kmap_atomic(from);
>> +	vto = kmap_atomic(to);
>> +	memcpy(vto, vfrom + offset, len);
>> +	kunmap_atomic(vto);
>> +	kunmap_atomic(vfrom);
>> +}
>> +
>> +static int erofs_fscache_do_readpage(struct file *file, struct page *page)
>> +{
>> +	struct inode *inode = page->mapping->host;
>> +	struct erofs_inode *vi = EROFS_I(inode);
>> +	struct super_block *sb = inode->i_sb;
>> +	struct erofs_map_blocks map;
>> +	erofs_off_t o_la, pa;
>> +	size_t offset, len;
>> +	struct page *ipage;
>> +	int ret;
>> +
>> +	if (erofs_inode_is_data_compressed(vi->datalayout)) {
>> +		erofs_info(sb, "compressed layout not supported yet");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	o_la = page_offset(page);
>> +	map.m_la = o_la;
>> +
>> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>> +		zero_user(page, 0, PAGE_SIZE);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * 1) For FLAT_PLAIN/FLAT_INLINE layout, the output map.m_la shall be
>> +	 * equal to o_la, and the output map.m_pa is exactly the physical
>> +	 * address of o_la.
>> +	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
>> +	 * nearest chunk boundary, and the output map.m_pa is actually the
>> +	 * physical address of this chunk boundary. So we need to recalculate
>> +	 * the actual physical address of o_la.
>> +	 */
>> +	pa = map.m_pa + o_la - map.m_la;
>> +
>> +	ipage = erofs_get_meta_page(sb, erofs_blknr(pa));
>> +	if (IS_ERR(ipage))
>> +		return PTR_ERR(ipage);
>> +
>> +	/*
>> +	 * @offset refers to the page offset inside @ipage.
>> +	 * 1) Except for the inline layout, the offset shall all be 0, and @pa
>> +	 * shall be aligned with EROFS_BLKSIZ in this case. Thus we can
>> +	 * conveniently get the offset from @pa.
>> +	 * 2) While for the inline layout, the offset may be non-zero. Since
>> +	 * currently only flat layout supports inline, we can calculate the
>> +	 * offset from the corresponding physical address.
>> +	 */
>> +	offset = erofs_blkoff(pa);
>> +	len = min_t(u64, map.m_llen, PAGE_SIZE);
>> +
>> +	do_copy_page(ipage, page, offset, len);
> 
> If my understanding is correct, I still have no idea why we need to
> copy data here even if fscache can do direct I/O for us without extra
> efforts.
> 
> I think the only case would be tail-packing inline (which should go
> through metadata path), otherwise, all data is block-aligned. So
> fscache can handle it directly.
> 

Right, only tail packing need special handling here. Would be fixed in
the next version. Thanks.

-- 
Thanks,
Jeffle
