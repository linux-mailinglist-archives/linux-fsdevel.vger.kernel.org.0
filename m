Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43A2BAAC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 14:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgKTNDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 08:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgKTNDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:03:49 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FAAC0613CF;
        Fri, 20 Nov 2020 05:03:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x13so2875869wmj.1;
        Fri, 20 Nov 2020 05:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NYTpwREQamQvYxt2BcflS2qxkG0W7gCppxHqtL9LvZw=;
        b=G/jEODQ/hentXCU7u4oCGLTodXuASCzu9mQaaGhh25y5OHgLMnsZuJDNXfk1IMqEog
         mheSzgqJOZbP1i4L8hZVNvdFObFKizKa60tyrGs/PdfSSMfsiHJi1RE0Sv8mzCdyQpbJ
         AB7sWZldO+0EtwweO80FMs5ESWbv6kpOG0AtBASgrA19N76ycFQ9zjukSUPa4h6d6wZq
         3V7xIuvtrPzIThJJysKP+JW4MIK7a7+eseXQSUOvA+okfL8oUnH46IH8uit288x/LS5g
         MlU/Va9mpdZx1v8ksFas9VlZy3M/jGSnlz5kLJKAHuI7uCKG1WOIMIUBUeE8ix5KGX2q
         Uicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NYTpwREQamQvYxt2BcflS2qxkG0W7gCppxHqtL9LvZw=;
        b=XM4C7CPSDyGigfWe/dmAETiAeqxjyA7NtF7vsns4grYXVxojRjZT9g9QsuFqUmueQG
         oPZIl7H7PV4hDk8ZXNyZw9CPIo5GiNEBvCBhIxTs9ZdjbL030KgtaloszvvFBinQ4ZFl
         Timbmw8EfbnWXMQBVO9FFzpVE/DiLG4Thz3rfwVkLi8Bfbzc4AWzeZLfAIDTizQ1jek0
         FS6Mmy9U0b6NfmUAru34QlSxQGNYLOVv7sgu9dm8v9ETxUOy2brHBp/o51QBG5N7abCj
         JfVLly9sgkR/riIAw+ZsOutdFIP25pES1D4LuZHx0xKV3mh0vpEZi8i1uQMJ0W/NXbWd
         rheA==
X-Gm-Message-State: AOAM533V7Gz6KUMb/yp9JoO1EaKEyhMBcgrToBskwbNuYVOX5euGmooc
        QWMcbBjXgK9FY6b7ybKDcik3bkQ/1XQ803GH
X-Google-Smtp-Source: ABdhPJy+w1QFQ7CBNeO7/anKL/Kjy6ri5kVxra3cJu7dTzdXNBkldwp/Bw+z1X+ROxWbv7M0ewNtSg==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr4554566wme.42.1605877425626;
        Fri, 20 Nov 2020 05:03:45 -0800 (PST)
Received: from [192.168.1.13] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id i10sm5337446wrs.22.2020.11.20.05.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 05:03:44 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120022200.GB333150@T590>
 <e70a3c05-a968-7802-df81-0529eaa7f7b4@gmail.com>
 <20201120025457.GM29991@casper.infradead.org>
 <20201120081429.GA30801@infradead.org>
 <20201120123931.GN29991@casper.infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <c14607c3-2fdd-4acf-e379-a8cde461c753@gmail.com>
Date:   Fri, 20 Nov 2020 13:00:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201120123931.GN29991@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/11/2020 12:39, Matthew Wilcox wrote:
> On Fri, Nov 20, 2020 at 08:14:29AM +0000, Christoph Hellwig wrote:
>> On Fri, Nov 20, 2020 at 02:54:57AM +0000, Matthew Wilcox wrote:
>>> On Fri, Nov 20, 2020 at 02:25:08AM +0000, Pavel Begunkov wrote:
>>>> On 20/11/2020 02:22, Ming Lei wrote:
>>>>> iov_iter_npages(bvec) still can be improved a bit by the following way:
>>>>
>>>> Yep, was doing exactly that, +a couple of other places that are in my way.
>>>
>>> Are you optimising the right thing here?  Assuming you're looking at
>>> the one in do_blockdev_direct_IO(), wouldn't we be better off figuring
>>> out how to copy the bvecs directly from the iov_iter into the bio
>>> rather than calling dio_bio_add_page() for each page?
>>
>> Which is most effectively done by stopping to to use *blockdev_direct_IO
>> and switching to iomap instead :)
> 
> But iomap still calls iov_iter_npages().  So maybe we need something like
> this ...

Yep, all that are not mutually exclusive optimisations.
Why `return 1`? It seems to be used later in bio_alloc(nr_pages)

> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 933f234d5bec..1c5a802a45d9 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -250,7 +250,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	orig_count = iov_iter_count(dio->submit.iter);
>  	iov_iter_truncate(dio->submit.iter, length);
>  
> -	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +	nr_pages = bio_iov_iter_npages(dio->submit.iter);
>  	if (nr_pages <= 0) {
>  		ret = nr_pages;
>  		goto out;
> @@ -308,7 +308,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		dio->size += n;
>  		copied += n;
>  
> -		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +		nr_pages = bio_iov_iter_npages(dio->submit.iter);
>  		iomap_dio_submit_bio(dio, iomap, bio, pos);
>  		pos += n;
>  	} while (nr_pages);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c6d765382926..86cc74f84b30 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -10,6 +10,7 @@
>  #include <linux/ioprio.h>
>  /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
>  #include <linux/blk_types.h>
> +#include <linux/uio.h>
>  
>  #define BIO_DEBUG
>  
> @@ -447,6 +448,16 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  void __bio_add_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int off);
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
> +
> +static inline int bio_iov_iter_npages(const struct iov_iter *i)
> +{
> +	if (!iov_iter_count(i))
> +		return 0;
> +	if (iov_iter_is_bvec(i))
> +		return 1;
> +	return iov_iter_npages(i, BIO_MAX_PAGES);
> +}
> +
>  void bio_release_pages(struct bio *bio, bool mark_dirty);
>  extern void bio_set_pages_dirty(struct bio *bio);
>  extern void bio_check_pages_dirty(struct bio *bio);
> 

-- 
Pavel Begunkov
