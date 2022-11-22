Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F4633402
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 04:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKVDkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 22:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKVDkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:40:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB527CD8;
        Mon, 21 Nov 2022 19:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VnTub4Y5HXxdbq9kgRXMlJDj14X+1QruDCzpXxBbgMA=; b=jZoeg6TF21XJkuWIBeOBqwSFwR
        S+XahH3FklBRWzEpYuA5k1nY0SXTXfkBvmBxqXuCWsHLq4Tt3mmRX/yFTLtoqX7JhtzCr4v49jWZS
        UMTI5vJAY2AkQ06hwM6FO8AD88bQtStfDSZ7R2H1c2kDJrTbbIvhpwgmUrOtqtBTpEfLv51y+8eVN
        bg8imgaRNgbG3Vyne7YSifIZXRQdfxsih0gA8buipA48uL/ef6WZKGQwmUGt4dMgQWtyT95Kh36jm
        A3hWIW5kpYnWbTEo1JBRfr2oBaVEyqfcQ0NcU4pvxfdGiFEUL541uK+IJpUQAYXFvC2NJp7DNAfMG
        7V3SOPsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxK99-005ts8-U9; Tue, 22 Nov 2022 03:40:31 +0000
Date:   Tue, 22 Nov 2022 03:40:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/5] fs: ext4: initialize fsdata in pagecache_write()
Message-ID: <Y3xEr3hhbYfdei+k@casper.infradead.org>
References: <20221121112134.407362-1-glider@google.com>
 <20221121114840.c407626c13706ff993efabe3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121114840.c407626c13706ff993efabe3@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:48:40AM -0800, Andrew Morton wrote:
> On Mon, 21 Nov 2022 12:21:30 +0100 Alexander Potapenko <glider@google.com> wrote:
> 
> > When aops->write_begin() does not initialize fsdata, KMSAN reports
> > an error passing the latter to aops->write_end().
> > 
> > Fix this by unconditionally initializing fsdata.
> > 
> > ...
> >
> 
> I'm assuming that this is not-a-bug, and that these changes are purely
> workarounds for a KMSAN shortcoming?

It's a weird one.  It used to be not-a-bug.  Then we changed from
std=gnu99 to std=gnu11 or something.  And in the intervening years,
the C standards ctte decided that passing an uninitialised pointer to a
function was UB.  So we start by passing a pointer to the pointer to
->write_begin().  Some ->write_begin functions initialise that pointer;
others don't.  Then we pass the pointer directly to ->write_end.  If
->write_begin initialised the pointer, that's fine, and if not, it's UB.
Of course the ->write_end doesn't use it if the ->write_begin didn't
initialise it, but it's too late because merely calling the function
was UB.  Thanks, Itanium!

