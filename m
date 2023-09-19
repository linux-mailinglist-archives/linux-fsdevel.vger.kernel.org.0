Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA87A691F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjISQqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjISQqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:46:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C061190
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qnyFM8oZxwxcynR8dnpHDifcujzy7nq/D9UYSgfAfKY=; b=GK7js2FN4NtqHc7J1Jl/R6IuFG
        z6WqpoFMu5KZ1qQfkt+G4IMjk0TdA3JD7LyBbIP7DVylpTDaS0IqFYjvCOpbJL4wz2bPkr/IBK/x6
        zAMhkcNwRa8gygRIfn0TYpR7hyn/0XgRS6P4Curw8BqIkpGlsqP5QxUkayUbkqGoxasrGHc98pyLf
        /bnhrQ9hOXeRNO10/NSBGMtLm4Y8N8DAFARKLEsNfQzwd2isYgz7QwCKAG8vbiujjY1SOSF2QAAE5
        JUU2lzAXSnDUo/P76LLNuDcLAHRJ6lwCoxX4pK5FMY+TydIBCzPoqWgFAq7RCYo2XKA3URXMU6SzT
        SBRuJYhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qidr0-000gYe-7r; Tue, 19 Sep 2023 16:45:38 +0000
Date:   Tue, 19 Sep 2023 17:45:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZQnQMobKwIbBTL9h@casper.infradead.org>
References: <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area>
 <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
 <ZQj2SgSKOzfKR0e3@dread.disaster.area>
 <ZQku4dvmtO56BvCr@casper.infradead.org>
 <ZQnNiTfXK81ZQGEq@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQnNiTfXK81ZQGEq@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:34:17PM -0400, Theodore Ts'o wrote:
> On Tue, Sep 19, 2023 at 06:17:21AM +0100, Matthew Wilcox wrote:
> > Frustratingly, it looks like buffer_heads were intended to be used as
> > extents; each one has a b_size of its own.  But there's a ridiculous
> > amount of code that assumes that all BHs attached to a folio have the
> > same b_size as each other.
> 
> The primary reason why we need a per-bh b_size is for the benefit of
> non-iomap O_DIRECT code paths.  If that goes away, then we can
> simplify this significantly, since we flush the buffer cache whenever
> we change the blocksize used in the buffer cache; the O_DIRECT bh's
> aren't part of the buffer cache, which is when you might have bh's with
> a b_size of 8200k (when doing a 8200k O_DIRECT read or write).

I must have not explained myself very well.

What I was trying to say was that if the buffer cache actually supported
it, large folios and buffer_heads wouldn't perform horribly together,
unless you had a badly fragmented file.

eg you could allocate a 256kB folio, then ask the filesystem to
create buffer_heads for it, and maybe it would come back with a list
of four buffer_heads, the first representing the extent from 0-32kB,
the second 32kB-164kB, the third 164kB-252kB and the fourth 252kB-256kB.
Wherever there were physical discontiguities in the file.

Then there would be only four buffer_heads to scan in order to determine
whether the entire folio was uptodate/dirty/written-back/etc.  It's still
O(n^2) but don't underestimate the power of reducing N to a small number.

Possibly we'd want to change buffer_heads a little to support tracking
dirtiness on a finer granularity than per-extent (just as Ritesh
recently did to iomap).  But there is a path to happiness here that
doesn't involve switching everything to iomap.  If I try to do it, I
know I'll break everything while doing it ...
