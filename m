Return-Path: <linux-fsdevel+bounces-7949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B133682DB8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82DA1C21BFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27189179BE;
	Mon, 15 Jan 2024 14:40:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80017995;
	Mon, 15 Jan 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W-j1yLV_1705329597;
Received: from 30.27.74.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-j1yLV_1705329597)
          by smtp.aliyun-inc.com;
          Mon, 15 Jan 2024 22:39:59 +0800
Message-ID: <931bcf87-efdf-478f-869b-fcb1260ac1cc@linux.alibaba.com>
Date: Mon, 15 Jan 2024 22:39:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] erofs: Don't use certain internal folio_*()
 functions
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20240115083337.1355191-1-hsiangkao@linux.alibaba.com>
 <ZaU75cT0jx9Ya+6G@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZaU75cT0jx9Ya+6G@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 2024/1/15 22:06, Matthew Wilcox wrote:
> On Mon, Jan 15, 2024 at 04:33:37PM +0800, Gao Xiang wrote:
>> From: David Howells <dhowells@redhat.com>
>>
>> Filesystems should use folio->index and folio->mapping, instead of
>> folio_index(folio), folio_mapping() and folio_file_mapping() since
>> they know that it's in the pagecache.
>>
>> Change this automagically with:
>>
>> perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
>> perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
>> perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/erofs/*.c
>>
>> Reported-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Cc: Chao Yu <chao@kernel.org>
>> Cc: Yue Hu <huyue2@coolpad.com>
>> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
>> Cc: linux-erofs@lists.ozlabs.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Hi folks,
>>
>> I tend to apply this patch upstream since compressed data fscache
>> adaption touches this part too.  If there is no objection, I'm
>> going to take this patch separately for -next shortly..
> 
> Could you change the subject?  It's not that the functions are
> "internal", it's that filesystems don't need to use them because they're
> guaranteed to not see swap pages.  Maybe just s/internal/unnecessary/

Yes, the subject line was inherited from the original one.

Such helpers are useful if the type of a folio is unknown,
let me revise it.

Thanks,
Gao Xiang

