Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB2F704A32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjEPKMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 06:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjEPKMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 06:12:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D025173B;
        Tue, 16 May 2023 03:12:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64395e741fcso14403700b3a.2;
        Tue, 16 May 2023 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684231969; x=1686823969;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Rl9Yab0oXCcv+38p3G1it35hZ5LaYIG7f0d6pQ0fpM=;
        b=k66pYUa7HVLcpp4MoTezbIb1UQBbGKWeQp4X16VJYvamdi5ZYWC3C6/3LHj+iE0XYa
         tdp8TAsYeya/A1i2SRU1JVZRcWeDg2Wt4Ljb3IvRlGWY0pxUrUx9xLXWm3/x8WssOoSE
         vfJizStm1BxjHnavX9gIBxhHkeEQ1tF+/qyy60pUxB7HgPHcB5UkA2Nzfb8Sc1fjFuGu
         aFsoCBWuiQdNA10m6C3hDDwWrL+njlgkcXZLO+NJTQu78jVpwmBNOAiOiDaiUUg/0/EJ
         WnNPOM5nSis1lUTH8h7qcf47l1cLN8LX/qKmRzghxPao6+gR7UaDMhM//JLkiRw7T8PV
         Y6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231969; x=1686823969;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Rl9Yab0oXCcv+38p3G1it35hZ5LaYIG7f0d6pQ0fpM=;
        b=SalgpdYiD2HIZpsFgPzc3//YiIqzfPSi0ed7FuOBLOE3wpQoGAPnGQrErrY/hLDNwy
         JjO8Az45ydNngg6xgc6vxdcQ5NSLmViejrP0X8hMzwJz+Pvdmnxdqq/E6QBukwiuanI8
         InO+2PxFeG3yhwy/P9Ul1wTa2XZcZZ35KysoMtWfB1wuCA3WE8V9XmtWUJXrej1c5GYi
         A7wVY8RGPsA1NBLZbU7ITS+OQXH/2uXAtW+A3F5SnVY5Ln4XC8kdcWaUYdABfb9RxqIT
         P4Bgxi7aWOADpI2jp/scDaENqmrRyfRghCubUYg0h5DN89XYmO/kw5NaRyiPO9bc4uaB
         4MSQ==
X-Gm-Message-State: AC+VfDy520MA68/lbDTCLjO/nugkcWQHlr1EIRnGPzBZ3FJP1sBJyf9h
        HiLQkkky+m26CUndH8CGWW45iEDB3dU=
X-Google-Smtp-Source: ACHHUZ7RrRRXHuUJdmViRgYu1zrEKYIdOz0z1JKUeY+PIDKIXcs8ct6ucBXv8UUz/H3dOyfeWtdxYA==
X-Received: by 2002:a05:6a00:17a3:b0:636:f5f4:5308 with SMTP id s35-20020a056a0017a300b00636f5f45308mr51472351pfg.7.1684231968920;
        Tue, 16 May 2023 03:12:48 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b00636c4bd7c8bsm13086082pfv.43.2023.05.16.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 03:12:48 -0700 (PDT)
Date:   Tue, 16 May 2023 15:42:29 +0530
Message-Id: <87fs7wlh4i.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 2/5] iomap: Refactor iop_set_range_uptodate() function
In-Reply-To: <ZGJLKdJeNzAtjSZb@bfoster>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Brian Foster <bfoster@redhat.com> writes:

> On Mon, May 08, 2023 at 12:57:57AM +0530, Ritesh Harjani (IBM) wrote:
>> This patch moves up and combine the definitions of two functions
>> (iomap_iop_set_range_uptodate() & iomap_set_range_uptodate()) into
>> iop_set_range_uptodate() & refactors it's arguments a bit.
>>
>> No functionality change in this patch.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>
> Hi Ritesh,
>
> I just have a few random and nitty comments/questions on the series..
>

Thanks a lot for reviewing.


>>  fs/iomap/buffered-io.c | 57 ++++++++++++++++++++----------------------
>>  1 file changed, 27 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index cbd945d96584..e732581dc2d4 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -43,6 +43,27 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>>
>>  static struct bio_set iomap_ioend_bioset;
>>
>> +static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
>> +				   size_t off, size_t len)
>> +{
>
> Any particular reason this now takes the inode as a param now instead of
> continuing to use the folio?
>

Mainly for blkbits (or blocksize) and blocks_per_folio.
Earlier we were explicitly passing this info, but with recent comments,
I felt the api make sense to have inode and folio (given that we want to
work on blocksize, blocks_per_folio and folio).

-ritesh

> Brian
>
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	unsigned int first_blk = off >> inode->i_blkbits;
>> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	if (iop) {
>> +		spin_lock_irqsave(&iop->uptodate_lock, flags);
>> +		bitmap_set(iop->uptodate, first_blk, nr_blks);
>> +		if (bitmap_full(iop->uptodate,
>> +				i_blocks_per_folio(inode, folio)))
>> +			folio_mark_uptodate(folio);
>> +		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>> +	} else {
>> +		folio_mark_uptodate(folio);
>> +	}
>> +}
>> +
>>  static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
>>  				    unsigned int flags)
>>  {
>> @@ -145,30 +166,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>>  	*lenp = plen;
>>  }
>>
>> -static void iomap_iop_set_range_uptodate(struct folio *folio,
>> -		struct iomap_page *iop, size_t off, size_t len)
>> -{
>> -	struct inode *inode = folio->mapping->host;
>> -	unsigned first = off >> inode->i_blkbits;
>> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
>> -	unsigned long flags;
>> -
>> -	spin_lock_irqsave(&iop->uptodate_lock, flags);
>> -	bitmap_set(iop->uptodate, first, last - first + 1);
>> -	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
>> -		folio_mark_uptodate(folio);
>> -	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>> -}
>> -
>> -static void iomap_set_range_uptodate(struct folio *folio,
>> -		struct iomap_page *iop, size_t off, size_t len)
>> -{
>> -	if (iop)
>> -		iomap_iop_set_range_uptodate(folio, iop, off, len);
>> -	else
>> -		folio_mark_uptodate(folio);
>> -}
>> -
>>  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>>  		size_t len, int error)
>>  {
>> @@ -178,7 +175,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>>  		folio_clear_uptodate(folio);
>>  		folio_set_error(folio);
>>  	} else {
>> -		iomap_set_range_uptodate(folio, iop, offset, len);
>> +		iop_set_range_uptodate(folio->mapping->host, folio, offset,
>> +				       len);
>>  	}
>>
>>  	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
>> @@ -240,7 +238,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>>  	memcpy(addr, iomap->inline_data, size);
>>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
>>  	kunmap_local(addr);
>> -	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
>> +	iop_set_range_uptodate(iter->inode, folio, offset, PAGE_SIZE - poff);
>>  	return 0;
>>  }
>>
>> @@ -277,7 +275,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>>
>>  	if (iomap_block_needs_zeroing(iter, pos)) {
>>  		folio_zero_range(folio, poff, plen);
>> -		iomap_set_range_uptodate(folio, iop, poff, plen);
>> +		iop_set_range_uptodate(iter->inode, folio, poff, plen);
>>  		goto done;
>>  	}
>>
>> @@ -598,7 +596,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>  			if (status)
>>  				return status;
>>  		}
>> -		iomap_set_range_uptodate(folio, iop, poff, plen);
>> +		iop_set_range_uptodate(iter->inode, folio, poff, plen);
>>  	} while ((block_start += plen) < block_end);
>>
>>  	return 0;
>> @@ -705,7 +703,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>>  		size_t copied, struct folio *folio)
>>  {
>> -	struct iomap_page *iop = to_iomap_page(folio);
>>  	flush_dcache_folio(folio);
>>
>>  	/*
>> @@ -721,7 +718,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>>  	 */
>>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>>  		return 0;
>> -	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
>> +	iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos), len);
>>  	filemap_dirty_folio(inode->i_mapping, folio);
>>  	return copied;
>>  }
>> --
>> 2.39.2
>>
