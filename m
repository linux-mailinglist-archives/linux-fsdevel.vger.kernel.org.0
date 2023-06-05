Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A37231CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFEVAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjFEVAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:00:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECDCEE;
        Mon,  5 Jun 2023 14:00:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-651e298be3fso5109246b3a.2;
        Mon, 05 Jun 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685998821; x=1688590821;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3D1bEV/U/6A619cFAemxcFrXv0QKf9sew8/f/mCHhY=;
        b=U2C0vvZkl+qUPGdLXx1lGOR8cgTAS7LUMInnAwCw7KS26B8TRNIPw4YNWZk3m6xi48
         pjkMqjEvZlev5fy/p2hH1qa76DWzgkEqmm4G1eNr6YKEb7gTznDJSaiVBuW3YppCr2dj
         P2sPDx0/2ONaM8CitMFmWh2OdiKeFPF/BjHTpG4Ktk66uisMHmV6Ccda3w3mo3cDVxLW
         GHPukb0zrcESKEKw1FhEfafCnA+MqcVaQyOcDt4z+kuGFo3mVWipMuuOG6TCmPTXld26
         bbaGg19RipJaV8cypGq82UUJsA8K+EPbiBqAtygF/w8jsGNB7uKDeshUfJdAzqkw4EZe
         HdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685998821; x=1688590821;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3D1bEV/U/6A619cFAemxcFrXv0QKf9sew8/f/mCHhY=;
        b=SDmqANBzE7ZBgP0oV84fg3hdxzjDJwTdrWOVHFtZOB+ZnYcbRBYJo3fK2cS7/K6c+P
         s9sEO5GZC5ELd+XGsAeR3lsJMgDkr8sYDXudD8RLRubOde9ix9fJcEQDuqQkppaEuRUL
         ymKm+l7swSRgnWcqdJqi4io85QQzYZoURRSOkoZR5ZmpOh4hUgMwYicjvKPq2sgI4Irg
         ZSqfYi6OCUliX8u06ImvR/s3zhp3/axnrQB4x8scrBz14Ay1nMGXag+LRJl4cY61HDQB
         XmQJmWBHFTHtKRcHt1N+j068imNYBtqE5BM5/KLQAs7g9rsTKaKowPGHR36p6B9vQX7z
         AOOA==
X-Gm-Message-State: AC+VfDz5TDlRdrLnHzaLW/U5NEmY418QDjiD75Y2JHY9batClgCSA2iu
        NoR0R3SJnjdo2vcRWE/xcXA=
X-Google-Smtp-Source: ACHHUZ73y5INDsjN2U8hE1IdgQw41E7Y0LUoU6ByDUliVQF8ticrBiaRfylG+LO6+Zukzjp7rNlYQA==
X-Received: by 2002:a05:6a00:1897:b0:65b:38b2:8d4b with SMTP id x23-20020a056a00189700b0065b38b28d4bmr991077pfh.29.1685998821104;
        Mon, 05 Jun 2023 14:00:21 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78d95000000b0064ceb16a1a2sm5507469pfr.182.2023.06.05.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 14:00:20 -0700 (PDT)
Date:   Tue, 06 Jun 2023 02:30:16 +0530
Message-Id: <87pm69k4kf.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
In-Reply-To: <CAHc6FU7xZaDAnmQ5UhO=MCnW_nGV2WNs93=PTAoVWCYuSCnrAQ@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

> On Mon, Jun 5, 2023 at 12:55 PM Ritesh Harjani (IBM)
> <ritesh.list@gmail.com> wrote:
>> We would eventually use iomap_iop_** function naming by the rest of the
>> buffered-io iomap code. This patch update function arguments and naming
>> from iomap_set_range_uptodate() -> iomap_iop_set_range_uptodate().
>> iop_set_range_uptodate() then becomes an accessor function used by
>> iomap_iop_** functions.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/buffered-io.c | 111 +++++++++++++++++++++++------------------
>>  1 file changed, 63 insertions(+), 48 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 6fffda355c45..136f57ccd0be 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -24,14 +24,14 @@
>>  #define IOEND_BATCH_SIZE       4096
>>
>>  /*
>> - * Structure allocated for each folio when block size < folio size
>> - * to track sub-folio uptodate status and I/O completions.
>> + * Structure allocated for each folio to track per-block uptodate state
>> + * and I/O completions.
>>   */
>>  struct iomap_page {
>>         atomic_t                read_bytes_pending;
>>         atomic_t                write_bytes_pending;
>> -       spinlock_t              uptodate_lock;
>> -       unsigned long           uptodate[];
>> +       spinlock_t              state_lock;
>> +       unsigned long           state[];
>>  };
>>
>>  static inline struct iomap_page *to_iomap_page(struct folio *folio)
>> @@ -43,6 +43,48 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>>
>>  static struct bio_set iomap_ioend_bioset;
>>
>> +static bool iop_test_full_uptodate(struct folio *folio)
>> +{
>> +       struct iomap_page *iop = to_iomap_page(folio);
>> +       struct inode *inode = folio->mapping->host;
>> +
>> +       return bitmap_full(iop->state, i_blocks_per_folio(inode, folio));
>> +}
>
> Can this be called iop_test_fully_uptodate(), please?
>

IMHO, iop_test_full_uptodate() looks fine. It goes similar to
bitmap_full() function.

>> +
>> +static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
>> +{
>> +       struct iomap_page *iop = to_iomap_page(folio);
>> +
>> +       return test_bit(block, iop->state);
>> +}
>> +
>> +static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
>> +                                  size_t off, size_t len)
>> +{
>> +       struct iomap_page *iop = to_iomap_page(folio);
>
> Note that to_iomap_page() does folio_test_private() followed by
> folio_get_private(), which doesn't really make sense in places where
> we know that iop is defined. Maybe we want to split that up.
>

I think in mm we have PG_Private flag which gets set as a pageflag.
So folio_test_private() actually checks whether we have PG_Private flag
set or not ( I guess it could be to overload folio->private use).

For file folio, maybe can we directly return folio_get_private(folio)
from to_iomap_page(folio) ?

>> +       unsigned int first_blk = off >> inode->i_blkbits;
>> +       unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +       unsigned int nr_blks = last_blk - first_blk + 1;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&iop->state_lock, flags);
>> +       bitmap_set(iop->state, first_blk, nr_blks);
>> +       if (iop_test_full_uptodate(folio))
>> +               folio_mark_uptodate(folio);
>> +       spin_unlock_irqrestore(&iop->state_lock, flags);
>> +}
>> +
>> +static void iomap_iop_set_range_uptodate(struct inode *inode,
>> +               struct folio *folio, size_t off, size_t len)
>> +{
>> +       struct iomap_page *iop = to_iomap_page(folio);
>> +
>> +       if (iop)
>> +               iop_set_range_uptodate(inode, folio, off, len);
>> +       else
>> +               folio_mark_uptodate(folio);
>> +}
>
> This patch passes the inode into iomap_iop_set_range_uptodate() and
> removes the iop argument. Can this be done in a separate patch,
> please?
>
> We have a few places like the above, where we look up the iop without
> using it. Would a function like folio_has_iop() make more sense?
>

Just realized that we should also rename
to_iomap_page(folio) -> iomap_get_iop(folio).

For your comment, we can use that as -

+static void iomap_iop_set_range_uptodate(struct inode *inode,
+               struct folio *folio, size_t off, size_t len)
+{
+       if (iomap_get_iop(folio))
+               iop_set_range_uptodate(inode, folio, off, len);
+       else
+               folio_mark_uptodate(folio);
+}


Does this looks ok?

-ritesh
