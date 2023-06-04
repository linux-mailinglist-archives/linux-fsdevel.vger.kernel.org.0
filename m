Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6859C721B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 01:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjFDXjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 19:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjFDXjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 19:39:03 -0400
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB16D3
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 16:39:01 -0700 (PDT)
Date:   Sun, 4 Jun 2023 19:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685921939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVV3yjs4kWVzhhx/jsq5Z0tB6otLGDTtFTIwSZr9j+c=;
        b=EOPfTYA3F0a6RtdIdrmU5x9GpdaD6sOglMygl8F8JDqYWn5YKqJ+qIBCx/PBPzs6o9eQ2Q
        TJceDQRJN5rMDhWkZzIrWm86IANSXMx70+67IJKQi4vEw0y/0CCqfTQECaPC+qREXDsRwR
        7T2Bc/Po+zaMlhPBmIS6HPT4RG3jWFk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Message-ID: <ZH0gjyuBgYzqhZh7@moria.home.lan>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
 <ZHEaKQH22Uxk9jPK@moria.home.lan>
 <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
 <ZHYfGvPJFONm58dA@moria.home.lan>
 <2a56b6d4-5f24-9738-ec83-cefb20998c8c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a56b6d4-5f24-9738-ec83-cefb20998c8c@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 10:50:55AM -0600, Jens Axboe wrote:
> Sorry typo, I meant text. Just checked stack and it looks identical, but
> things like blk-map grows ~6% more text, and bio ~3%. Didn't check all
> of them, but at least those two are consistent across x86-64 and
> aarch64. Ditto on the data front. Need to take a closer look at where
> exactly that is coming from, and what that looks like.

A good chunk of that is because I added warnings and assertions for
e.g. running past the end of the bvec array. These bugs are rare and
shouldn't happen with normal iterator usage (e.g. the bio_for_each_*
macros), but I'd like to keep them as a debug mode thing.

But we don't yet have CONFIG_BLOCK_DEBUG - perhaps we should.

With those out, I see a code size decrease in bio.c, which makes sense -
gcc ought to be able to generate slightly better code when it's dealing
with pure values, provided everything is inlined and there's no aliasing
considerations.

Onto blk-map.c:

bio_copy_kern_endio_read() increases in code size, but if I change
memcpy_from_bvec() to take the bvec by val instead of by ref it's
basically the same code size. There's no disadvantage to changing
memcpy_from_bvec() to pass by val.

bio_copy_(to|from)_iter() is a wtf, though - gcc is now spilling the
constructed bvec to the stack; my best guess is it's a register pressure
thing (but we shouldn't be short registers here!).

So, since the fastpath stuff in bio.c gets smaller and blk-map.c is not
exactly fastpath stuff I'm not inclined to fight with gcc on this one -
let me know if that works for you.

Branch is updated - I split out the new assertions into a separate patch
that adds CONFIG_BLK_DEBUG, and another patch for mempcy_(to|from)_bio()
for a small code size decrease.

https://evilpiepirate.org/git/bcachefs.git/log/?h=block-for-bcachefs
or
git pull http://evilpiepirate.org/git/bcachefs.git block-for-bcachefs
