Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA7751858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 07:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGMFwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjGMFv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:51:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A71718;
        Wed, 12 Jul 2023 22:51:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so370022a12.1;
        Wed, 12 Jul 2023 22:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689227517; x=1691819517;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F+jKxarmB/x7tKAglR4hSDAerknpfvj6URQRcs+uwoo=;
        b=fNe0dZBn1bKwIHmzjF1nVak/lhlb2vwhlYG/yGAoNx9RbQrQWZ1ib2LDOIaKgz1Jtm
         rdKOMUUS5gOEezANr79/MnIt7BnWIiwcoqX+a0YukadbGBSlVA5ip0di40HdACPLRkMO
         426SaXxd8l5ubMRYNc33FUe/YcoKJCCmzgCsMf1TnXWosyRru93Ex+bzPcbleY279DP3
         ai/W94tNNkZO7F3ywu5X48Ktqtmik/pWMSgTCd3c2k3G7s/jALMIbxCylqslGOH+V7Ri
         txrRjVXZFjCUCHMV4hIt4Vp3R7tcKw3g4kMmK3Szd9rAgceihtnF96w0d30avPc+LBRX
         Eayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689227517; x=1691819517;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+jKxarmB/x7tKAglR4hSDAerknpfvj6URQRcs+uwoo=;
        b=auoSNt6/JMugYcEl8z4dOBrOJriyBT4bYAv38b4ZxO6fHconYnIUEe+aWiw9i35O3u
         Y1GC+VaYGOy4hF8NyeAUCntqdsqPCYlCB2gB0U+cO5onh8MI4bacKPFWXDMcJata/ept
         Y3LUQI1QOGfYwY3xmN13s2gE31stM+9VtLvmw4MmAkAA+IGOV6mKbWinS34P+D+qSe3b
         5sN614r4518b3byETD8mPb5PrGeWsMmbA9i88hFllrvQ7dh8ZcrpC5/nNcbRX48qq3QZ
         NTQzPm8hIWFLY2L1aSYN/MLJlu+WwLj+5IQXAAJcJ14Deo5OdJ8DFCsKCWaeJNw85Jsx
         0RIg==
X-Gm-Message-State: ABy/qLa6UkhvtpWQhDIcxH0eGQrWnn6A8/3Wavm8+3R1CQJRrLI2yO/g
        xh8+zZHNl1bNyo8U+aY3E/Y=
X-Google-Smtp-Source: APBJJlHGxu+jf9STwYkD5J4sl97aYqiSKcQr44IBIXtoE1RYPgIII/wug1O/lHgSlQF2otxPkz/nQQ==
X-Received: by 2002:a05:6a20:8f17:b0:12f:b9aa:ffc4 with SMTP id b23-20020a056a208f1700b0012fb9aaffc4mr668203pzk.28.1689227517198;
        Wed, 12 Jul 2023 22:51:57 -0700 (PDT)
Received: from dw-tp (175.101.8.98.static.excellmedia.net. [175.101.8.98])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902988a00b001b89045ff03sm4918985plp.233.2023.07.12.22.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:51:56 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:21:51 +0530
Message-Id: <87v8eo7408.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 5/9] iomap: Remove unnecessary test from iomap_release_folio()
In-Reply-To: <20230713053331.GG11476@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Thu, Jul 13, 2023 at 10:55:20AM +0530, Ritesh Harjani wrote:
>> "Darrick J. Wong" <djwong@kernel.org> writes:
>> 
>> > [add ritesh]
>> >
>> > On Mon, Jul 10, 2023 at 02:02:49PM +0100, Matthew Wilcox (Oracle) wrote:
>> >> The check for the folio being under writeback is unnecessary; the caller
>> >> has checked this and the folio is locked, so the folio cannot be under
>> >> writeback at this point.
>> >> 
>> >> The comment is somewhat misleading in that it talks about one specific
>> >> situation in which we can see a dirty folio.  There are others, so change
>> >> the comment to explain why we can't release the iomap_page.
>> >> 
>> >> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> >> ---
>> >>  fs/iomap/buffered-io.c | 9 ++++-----
>> >>  1 file changed, 4 insertions(+), 5 deletions(-)
>> >> 
>> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> >> index 1cb905140528..7aa3009f907f 100644
>> >> --- a/fs/iomap/buffered-io.c
>> >> +++ b/fs/iomap/buffered-io.c
>> >> @@ -483,12 +483,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
>> >>  			folio_size(folio));
>> >>  
>> >>  	/*
>> >> -	 * mm accommodates an old ext3 case where clean folios might
>> >> -	 * not have had the dirty bit cleared.  Thus, it can send actual
>> >> -	 * dirty folios to ->release_folio() via shrink_active_list();
>> >> -	 * skip those here.
>> >> +	 * If the folio is dirty, we refuse to release our metadata because
>> >> +	 * it may be partially dirty.  Once we track per-block dirty state,
>> >> +	 * we can release the metadata if every block is dirty.
>> >
>> > Ritesh: I'm assuming that implementing this will be part of your v12 series?
>> 
>> No, if it's any optimization, then I think we can take it up later too,
>
> <nod>

Thanks! 

>
>> not in v12 please (I have been doing some extensive testing of current series).
>> Also let me understand it a bit more.
>> 
>> @willy,
>> Is this what you are suggesting? So this is mainly to free up some
>> memory for iomap_folio_state structure then right?
>
> I think it's also to break up compound folios to free base pages or
> other reasons.
>
> https://lore.kernel.org/linux-xfs/20230713044326.GI108251@frogsfrogsfrogs/T/#mc83fe929d57e9aa3c1834232389cad0d62b66e7b
>
>> But then whenever we are doing a writeback, we anyway would be
>> allocating iomap_folio_state() and marking all the bits dirty. Isn't it
>> sub-optimal then?  
>> 
>> @@ -489,8 +489,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
>>          * it may be partially dirty.  Once we track per-block dirty state,
>>          * we can release the metadata if every block is dirty.
>>          */
>> -       if (folio_test_dirty(folio))
>> +       if (folio_test_dirty(folio)) {
>> +               if (ifs_is_fully_dirty(folio, ifs))
>> +                       iomap_page_release(folio);
>>                 return false;
>> +       }
>
> I think it's more that we *dont* break up partially dirty folios:
>
> 	/*
> 	 * Folio is partially dirty, do not throw away the state or
> 	 * split the folio.
> 	 */
> 	if (folio_test_dirty(folio) && !ifs_is_fully_dirty(folio, ifs))
> 		return false;
>
> 	/* No more private state tracking, ok to split folio. */
> 	iomap_page_release(folio);
> 	return true;
>

Aah got it. If the folio is dirty and all it's blocks are also dirty
then we can release the metadata and return true. This will allow the MM
to split the folio, right.

Let me test it then. Currently ifs_is_fully_dirty() will walk and test
all the bits for dirtiness. However, splitting the folio might not be
the fast path, so I am assuming it shouldn't have any performance
implication.


> But breaking up fully dirty folios is now possible, since the mm can
> mark all the basepages dirty.

Thanks. Got it.

-ritesh

>
> --D
>
