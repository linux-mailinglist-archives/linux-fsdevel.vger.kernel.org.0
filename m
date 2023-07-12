Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97475118E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 21:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGLT5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjGLT53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:57:29 -0400
Received: from out-28.mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29971FE9
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:57:26 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689191844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pQ5GL/ruOH1khi5jRBa14gHeuf7KP4TvEzBD/9wQ7w=;
        b=Jvog2XhfpDQCttYJ3ePh2K4q1Z3NQkF2qHd2jAQhO6A2jJTJIA8CRsQ0JjwZgQ5JRUEtMr
        vAdLaN+BYho339/avYYi/zm6jNMVGRQqpQdKOuHvEIYYjQgx/duPC0Bz5PSOLQHCb54n26
        9jIk8zTxZoxxn+flTQBybZu20W/ScNs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        djwong@kernel.org, dchinner@redhat.com, sandeen@redhat.com,
        willy@infradead.org, josef@toxicpanda.com, tytso@mit.edu,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230712195719.y4msidsr7suu55gl@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <202307121241.8295B924F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307121241.8295B924F@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:48:31PM -0700, Kees Cook wrote:
> On Tue, Jul 11, 2023 at 10:54:59PM -0400, Kent Overstreet wrote:
> >  - Prereq patch series has been pruned down a bit more; also Mike
> >    Snitzer suggested putting those patches in their own branch:
> > 
> >    https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-prereqs
> > 
> >    "iov_iter: copy_folio_from_iter_atomic()" was dropped and replaced
> >    with willy's "iov_iter: Handle compound highmem pages in
> >    copy_page_from_iter_atomic()"; he said he'd try to send this for -rc4
> >    since it's technically a bug fix; in the meantime, it'll be getting
> >    more testing from my users.
> > 
> >    The two lockdep patches have been dropped for now; the
> >    bcachefs-for-upstream branch is switched back to
> >    lockdep_set_novalidate_class() for btree node locks. 
> > 
> >    six locks, mean and variance have been moved into fs/bcachefs/ for
> >    now; this means there's a new prereq patch to export
> >    osq_(lock|unlock)
> > 
> >    The remaining prereq patches are pretty trivial, with the exception
> >    of "block: Don't block on s_umount from __invalidate_super()". I
> >    would like to get a reviewed-by for that patch, and it wouldn't hurt
> >    for others.
> > 
> >    previously posting:
> >    https://lore.kernel.org/linux-bcachefs/20230509165657.1735798-1-kent.overstreet@linux.dev/T/#m34397a4d39f5988cc0b635e29f70a6170927746f
> 
> Can you send these prereqs out again, with maintainers CCed
> appropriately? (I think some feedback from the prior revision needs to
> be addressed first, though. For example, __flatten already exists, etc.)

Thanks for pointing that out, I knew it was in the pipeline :)

Will do...
