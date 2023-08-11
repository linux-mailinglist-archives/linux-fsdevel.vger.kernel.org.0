Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6634D778658
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 06:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHKEDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 00:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjHKEDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:03:19 -0400
Received: from out-81.mta1.migadu.com (out-81.mta1.migadu.com [IPv6:2001:41d0:203:375::51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCAC18B
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 21:03:18 -0700 (PDT)
Date:   Fri, 11 Aug 2023 00:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691726596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d39PtX8SWS7h1N0/fxVUJ2+xJ78W8r12Vyn4jEVrWxg=;
        b=bAJi/cyiHJjK6oL6Lz2twYj69M1Lo19Lp9v5Uagasmwl9MYbCuhpkHKWyH22sTbItSsTLB
        MuyPgk1VKMdLi+su96w6+qDClpwMX2+GfwI+kHOV0sHxeFTD+6nHboRF+6tiSe3w4W1TdG
        MFDBjzrIJaz90eQCMLkFO2/wUmGzmWM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811040310.c3q6nml6ukwtw3j5@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810223942.GG11336@frogsfrogsfrogs>
 <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:47:22PM -0700, Linus Torvalds wrote:
> So I might be barking up entirely the wrong tree.

Yeah, I think you are, it sounds like you're describing an entirely
different sort of race.

The issue here is just that killing off a process should release all the
references it holds, and if we kill off all processes accessing a
filesystem we should be able to unmount it - but in this case we can't,
because fputs() are being delayed asynchronously.

delayed_fput() from AIO turned out to not be an issue in my testing, for
reasons that are unclear to me; flush_delayed_fput() certainly isn't
called in any relevant codepaths. The code _looks_ buggy to me, but I
wasn't able to trigger the bug with AIO.

io_uring adds its own layer of indirect asynchronous reference holding,
and that's why the issue crops up there - but io_uring isn't using
delayed_fput() either.

The patch I posted was to make sure the file ref doesn't outlive the
task - I honestly don't know what you and Jens don't like about that
approach (obviously, adding task->ref gets and puts to fastpaths is a
nonstarter, but that's fixable as mentioned).
