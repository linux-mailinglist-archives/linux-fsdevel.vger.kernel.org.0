Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B4799C34
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbjIJAxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 20:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIJAxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 20:53:21 -0400
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com [IPv6:2001:41d0:203:375::de])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BCCC0
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Sep 2023 17:53:17 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694307194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC3fKpouSPms+ApHMGXr/eBuIznIngfUB5IC93N9aks=;
        b=pjhJWOWwh66EXP2lHGYqFlBdNxrHCXMKtDYMRM6jwUgYqMY2P6e1+v/A+8qo0tK/pESC2I
        xVo7NlI6yB9qwFiJkEelaqdSXMHVjYORy1ZNzU+qIhG/K5xRLiU8oHLozvfrK8u3QEcpAV
        0KiQK1fLqbMFxOnlJ/L5gq/6GPt+Wy0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230910005310.cdjpxkdsdyplb4gf@moria.home.lan>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:20:59PM -0700, Linus Torvalds wrote:
> On Wed, 6 Sept 2023 at 13:02, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And guess what happens when you have (unsigned char)-1? It does *not*
> > cast back to -1.
> 
> Side note: again, this may be one of those "it works in practice",
> because if we have -fshort-enums, I think 'enum
> btree_node_locked_type' in turn ends up being represented as a 'signed
> char', because that's the smallest simple type that can fit all those
> values.
> 
> I don't think gcc ever uses less than that (ie while a six_lock_type
> could fit in two bits, it's still going to be considered at least a
> 8-bit value in practice).
> 
> So we may have 'enum six_lock_type' essentially being 'unsigned char',
> and when the code does
> 
>     mark_btree_node_locked(trans, path, 0, BTREE_NODE_UNLOCKED);
> 
> that BTREE_NODE_UNLOCKED value might actually be 255.
> 
> And then when it's cast to 'enum btree_node_locked_type' in the inline
> function, the 255 will be cast to 'signed char', and we'll end up
> compatible with '(enum btree_node_locked_type)-1' again.
> 
> So it's one of those things that are seriously wrong to do, but might
> generate the expected code anyway.
> 
> Unless the compiler adds any other sanity checks, like UBSAN or
> something, that actually uses the exact range of the enums.
> 
> It could happen even without UBSAN, if the compiler ends up going "I
> can see that the original value came from a 'enum six_lock_type', so I
> know the original value can't be signed, so any comparison with
> BTREE_NODE_UNLOCKED can never be true.
> 
> But again, I suspect that in practice this all just happens to work.
> That doesn't make it right.

No, this was just broken - it should have been
mark_btree_node_unlocked(), we never should've been passing that enum
val there.
