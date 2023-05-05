Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210466F7B7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 05:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjEED2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 23:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjEED2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 23:28:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C777583CF;
        Thu,  4 May 2023 20:28:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b67a26069so1532898b3a.0;
        Thu, 04 May 2023 20:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683257316; x=1685849316;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QAl25Tbn3zuxFLWYzBgF7YklGwHxXzgnCYDivvpUsw=;
        b=G8Q4T4ajI9RWOv44avsjQuPTR7/HrN8redfnOkV0ohos0yTbm0snOkRUWVrYxElXBi
         EPzSIVn7crhngWzBY/y5qZRyNSbS6eiBB7hRSCaHtrB1xabnxGRwz18ksrtvvPm3xZhQ
         +TJw5GZoYUTQJq4uyBR5VU9fae3sArIlTenpPdzTaGnfyXFOwKGQWIEq5b0kCATLDGBC
         bbeAGX9SwTLzOzW4+0zYk1dww/6m1ojy0Bk5zdkxZ6wceBQ8hxewR7Xdrckhvk29wyCB
         vDYmQtd/RErU2w49QGWcEE3rvKNCS4lAOwoQ1sobFZGqVgr8xzbfb+Ni5qMu0OFPlAY8
         Lb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683257316; x=1685849316;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QAl25Tbn3zuxFLWYzBgF7YklGwHxXzgnCYDivvpUsw=;
        b=iyVdjt1gKV/xiCQuZIsdgnmD0F+hfyqzwn8TjQYlfQL6tToybVIZKjg53TRgWUwsGz
         M2LhHgtv+CGRNG9MvxJ0ytV/axxL9dbl5dXIjFukqltweot6KS8BuiT+KXl2Q0i/StEE
         n/9Kh4Q/y2jiHvjmjjoo3XnF3BP4lNBFi7TB8fm0hnMgclzIs1o+oQOCNjANKIwMT9Nc
         0gb5sCLnOgWfd0URPWtZGnXkpFmpkiXal4jKVoDnH8KC3o6EkE+HHreSH6KmCPXo/brg
         2hjtlxM/wRkAxB1GBnWLTQ+q7jP2D7JkeTXGX44cxgwrNLbMvJ4iY5fKQS7JESfom514
         abKg==
X-Gm-Message-State: AC+VfDxgCMQi89Iz427ux6fAURAVx2CHDuunNFu7AQxWpgC90YTkg0CX
        gixaYj4xXaOLHQt83FOC4cE=
X-Google-Smtp-Source: ACHHUZ4Sa4AZBU7I4HnLrFgaT9ZrgVLeCsbH3LPnu6kTuq9JNy+LcEdSgsNms+F26VQD5cOa0j2omQ==
X-Received: by 2002:a05:6a00:1808:b0:643:a155:5d72 with SMTP id y8-20020a056a00180800b00643a1555d72mr538290pfa.22.1683257316106;
        Thu, 04 May 2023 20:28:36 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:80ba:4cb4:7226:d064:79aa])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b0063799398eb9sm473758pfn.58.2023.05.04.20.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 20:28:35 -0700 (PDT)
Date:   Fri, 05 May 2023 08:57:53 +0530
Message-Id: <87zg6j1mpy.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv4 3/3] iomap: Support subpage size dirty tracking to improve write performance
In-Reply-To: <ZFPJGDqfcUtI4ptO@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, May 04, 2023 at 08:21:09PM +0530, Ritesh Harjani (IBM) wrote:
>> @@ -90,12 +116,21 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>>  	else
>>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>>
>> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
>> +	/*
>> +	 * iop->state tracks two sets of state flags when the
>> +	 * filesystem block size is smaller than the folio size.
>> +	 * The first state tracks per-filesystem block uptodate
>> +	 * and the second tracks per-filesystem block dirty
>> +	 * state.
>> +	 */
>
> "per-filesystem"?  I think you mean "per-block (uptodate|block) state".
> Using "per-block" naming throughout this patchset might help readability.
> It's currently an awkward mix of "subpage", "sub-page" and "sub-folio".
and subfolio to add.

Yes, I agree it got all mixed up in the comments.
Let me stick to sub-folio (which was what we were using earlier [1])

[1]: https://lore.kernel.org/all/20211216210715.3801857-5-willy@infradead.org/

> It also feels like you're adding a comment to every non-mechanical change
> you make, which isn't necessarily helpful.  Changelog, sure, but
> sometimes your comments simply re-state what your change is doing.
>

Sure, I will keep that in mind for next rev to remove unwanted comments.

>> -static void iomap_iop_set_range_uptodate(struct folio *folio,
>> -		struct iomap_page *iop, size_t off, size_t len)
>> +static void iomap_iop_set_range(struct folio *folio, struct iomap_page *iop,
>> +		size_t off, size_t len, enum iop_state state)
>>  {
>>  	struct inode *inode = folio->mapping->host;
>> -	unsigned first = off >> inode->i_blkbits;
>> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = (off >> inode->i_blkbits);
>> +	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>>  	unsigned long flags;
>> -	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
>>
>> -	spin_lock_irqsave(&iop->state_lock, flags);
>> -	iop_set_range_uptodate(iop, first, last - first + 1, nr_blocks);
>> -	if (iop_uptodate_full(iop, nr_blocks))
>> -		folio_mark_uptodate(folio);
>> -	spin_unlock_irqrestore(&iop->state_lock, flags);
>> +	switch (state) {
>> +	case IOP_STATE_UPDATE:
>> +		if (!iop) {
>> +			folio_mark_uptodate(folio);
>> +			return;
>> +		}
>> +		spin_lock_irqsave(&iop->state_lock, flags);
>> +		iop_set_range_uptodate(iop, first_blk, nr_blks, blks_per_folio);
>> +		if (iop_uptodate_full(iop, blks_per_folio))
>> +			folio_mark_uptodate(folio);
>> +		spin_unlock_irqrestore(&iop->state_lock, flags);
>> +		break;
>> +	case IOP_STATE_DIRTY:
>> +		if (!iop)
>> +			return;
>> +		spin_lock_irqsave(&iop->state_lock, flags);
>> +		iop_set_range_dirty(iop, first_blk, nr_blks, blks_per_folio);
>> +		spin_unlock_irqrestore(&iop->state_lock, flags);
>> +		break;
>> +	}
>>  }
>
> I can't believe this is what Dave wanted you to do.  iomap_iop_set_range()
> should be the low-level helper called by iop_set_range_uptodate() and
> iop_set_range_dirty(), not the other way around.

Ok, I see the confusion, I think if we make
iomap_iop_set_range() to iomap_set_range(), then that should be good.
Then it becomes iomap_set_range() calling
iop_set_range_update() & iop_set_range_dirty() as the lower level helper routines.

Based on the the existing code, I believe this ^^^^ is how the heirarchy
should look like. Does it look good then? If yes, I will simply drop the
"_iop" part in the next rev.

<Relevant function list>
    iop_set_range_uptodate
    iop_clear_range_uptodate
    iop_test_uptodate
    iop_uptodate_full
    iop_set_range_dirty
    iop_clear_range_dirty
    iop_test_dirty
    iomap_page_create
    iomap_page_release
    iomap_iop_set_range -> iomap_set_range()
    iomap_iop_clear_range  -> iomap_clear_range()

-ritesh
