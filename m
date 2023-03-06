Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA076ABA62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 10:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCFJwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 04:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCFJwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:52:34 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7328023641;
        Mon,  6 Mar 2023 01:52:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h8so9618438plf.10;
        Mon, 06 Mar 2023 01:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wG8c7belK9OM/OT139DOvd0umxDg1Jwx48LfTTUoDq8=;
        b=Bqk84XzlHXdUfL5jaevO/928dBaaKnaQ/6iMPIvzXXK4wXwLhD8T6jH72W2O9clYGr
         w4468W4AUtB14ezm/PNepGojuEiqbA3wwrhczCUmfTyMcUCq/qHaHETuhPdN3sceUATq
         kjFclmdVx8nb3gOomQeOZS2/43S6EDre1NqDWzHyRwePjObcFmiQ6/PyvjUa0vFW1sCB
         +sP9OvcIZ4mDCMQafARVvfE6MvvGiB6YhK8uV8Jw6eaPXHgUboGFoQPrtpYshvuo2KE+
         P54u+DEuJzRaKNJDcsrTj999zPH45FGYMPJVVy33hABYOjS5ASLFiJ1tli7793TEwIy0
         DHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wG8c7belK9OM/OT139DOvd0umxDg1Jwx48LfTTUoDq8=;
        b=cL2AC2iAw6O4HxzbTgvug/CufLH2Nn3dx913oGl+zQ36eR1q7xrR8MmyBfNRQjj0Il
         H9z89tCUcRJiKFTz+CwB0FJADJ2CbXK3M1U0eIUzgILhLwYC5Nswryotyf8eBJhy3ZKT
         YuapAFm7uYZlUBhSz+vwblvZ8MBbShkoFGFcEb7iZfcbpxaAnDt4HJ62w4kHXDL8x91R
         79+b6TQNr5uJWftXdsoVvXElWH8qRnnhFi/jcL/SEpOUYFQxoSPCdON63KhHN7tC2C7n
         iUsxPFjeYllKvw857j7fILF7IIJnRWyCdRy2GybylCk3ZHZ8okfYYQ8LZD1r/c/CTWMR
         TaHA==
X-Gm-Message-State: AO0yUKWFvMzeLPQQHuKZ0hQTEfCtWQAVBhfd74bvHLunP/7AhEgIdmuB
        35rkirXib3Fntfr8CSfzpJjE1m7kW28=
X-Google-Smtp-Source: AK7set/bBdX5zqdpORgqfqafnX6iscVVZGVVNV/7vxmq/Vj9Zf+JCNzxV2mm3lWUKcFbiEvJ7NsuKA==
X-Received: by 2002:a17:903:32d0:b0:19a:a810:542 with SMTP id i16-20020a17090332d000b0019aa8100542mr13107676plr.61.1678096350554;
        Mon, 06 Mar 2023 01:52:30 -0800 (PST)
Received: from rh-tp ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e80400b0019d397b0f18sm6238132plg.214.2023.03.06.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:52:30 -0800 (PST)
Date:   Mon, 06 Mar 2023 20:51:45 +0530
Message-Id: <87r0u129di.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/31] ext4: Convert ext4_block_write_begin() to take a folio
In-Reply-To: <ZAWj4FHczOQwwEbK@casper.infradead.org>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Mar 06, 2023 at 12:21:48PM +0530, Ritesh Harjani wrote:
>> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
>>
>> > All the callers now have a folio, so pass that in and operate on folios.
>> > Removes four calls to compound_head().
>>
>> Why do you say four? Isn't it 3 calls of PageUptodate(page) which
>> removes calls to compound_head()? Which one did I miss?
>>
>> > -	BUG_ON(!PageLocked(page));
>> > +	BUG_ON(!folio_test_locked(folio));
>
> That one ;-)

__PAGEFLAG(Locked, locked, PF_NO_TAIL)

#define __PAGEFLAG(uname, lname, policy)				\
	TESTPAGEFLAG(uname, lname, policy)				\
	__SETPAGEFLAG(uname, lname, policy)				\
	__CLEARPAGEFLAG(uname, lname, policy)

#define TESTPAGEFLAG(uname, lname, policy)				\
static __always_inline bool folio_test_##lname(struct folio *folio)	\
{ return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
static __always_inline int Page##uname(struct page *page)		\
{ return test_bit(PG_##lname, &policy(page, 0)->flags); }

How? PageLocked(page) doesn't do any compount_head() calls no?

-ritesh

>
>> >  	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>> >  		for (i = 0; i < nr_wait; i++) {
>> >  			int err2;
>> >
>> > -			err2 = fscrypt_decrypt_pagecache_blocks(page, blocksize,
>> > -								bh_offset(wait[i]));
>> > +			err2 = fscrypt_decrypt_pagecache_blocks(&folio->page,
>> > +						blocksize, bh_offset(wait[i]));
>>
>> folio_decrypt_pagecache_blocks() takes folio as it's argument now.
>>
>> Other than that it looks good to me. Please feel free to add -
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> Thanks.  I'll refresh this patchset next week.

Sure. Thanks!
