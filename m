Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA4747741
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGDQxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjGDQxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:53:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7DF1705;
        Tue,  4 Jul 2023 09:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A2EB612F5;
        Tue,  4 Jul 2023 16:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF5DC433C8;
        Tue,  4 Jul 2023 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688489563;
        bh=blKKMeUTGHw6xAs1a/A41CWozlEiyGm2zu/kZghvIT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhBwl0FVTAYODFv8m2/cNfKI8rYpqj85FKMqAWJitDDVrVU7n2WOjFYmvhquhEMml
         ZRhBa9FI4t38L817mpkbxBRbs7XN1iuFmm66fnangNm01gN8IrjftN+iUhl0raAE0u
         cCkgBBUHHNuC4XXYVSaXUR2k7xOjMeDC0QkkZ+tOFwtIL6Op5+1jKw4GnjOCC5BhTv
         MIT1/CNEalbVP7CZzvPoe2SRTHmdqah7INeO5I4KhfCzOEaz2XwNE+WgKMqOzY/kqw
         WP783Lcj/rKHOmE42i/7LliaGm6v6RWxXfsO/yviCJnJmHsf4eeQy0iR7i3ts7Vc2X
         RWSL2ALjtOOkQ==
Date:   Tue, 4 Jul 2023 09:52:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Colin Walters <walters@verbum.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230704165240.GA1851@sol.localdomain>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <0c5384c2-307b-43fc-9ea6-2a194f859e9b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5384c2-307b-43fc-9ea6-2a194f859e9b@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:56:44AM -0400, Colin Walters wrote:
> > +/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
> > +#define BLK_OPEN_BLOCK_WRITES	((__force blk_mode_t)(1 << 5))
> 
> Bikeshed but: I think BLK and BLOCK "stutter" here.  The doc comment already
> uses the term "exclusive" so how about BLK_OPEN_EXCLUSIVE ?  

Yeah, using "block" in two different ways at the same time is confusing.
BLK_OPEN_EXCLUSIVE would probably be good, as would something like
BLK_OPEN_RESTRICT_WRITES.

I can't figure out how to apply this patch series, so I can't really see it in
context though.

- Eric
