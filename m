Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AAD26DEFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgIQPDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 11:03:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60092 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbgIQPDL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:03:11 -0400
Received: (qmail 488 invoked by uid 109); 17 Sep 2020 13:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 13:16:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8382 invoked by uid 111); 17 Sep 2020 13:16:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 09:16:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 09:16:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917131605.GC3024501@coredump.intra.peff.net>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917112830.26606-2-avarab@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:28:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change the behavior of core.fsyncObjectFiles to also sync the
> directory entry. I don't have a case where this broke, just going by
> paranoia and the fsync(2) manual page's guarantees about its behavior.

I've also often wondered whether this is necessary. Given the symptom of
"oops, this object is there but with 0 bytes" after a hard crash (power
off, etc), my assumption is that the metadata is being journaled but the
actual data is not. Which would imply this isn't needed, but may just be
revealing my naive view of how filesystems work.

And of course all of my experience is on ext4 (which doubly confuses me,
because my systems typically have data=ordered, which I thought would
solve this). Non-journalling filesystems or other modes likely behave
differently, but if this extra fsync carries a cost, we may want to make
it optional.

>  sha1-file.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

We already fsync pack files, but we don't fsync their directories. If
this is important to do, we should be doing it there, too.

We also don't fsync ref files (nor packed-refs) at all. If fsyncing
files is important for reliability, we should be including those, too.
It may be tempting to say that the important stuff is in objects and the
refs can be salvaged from the commit graph, but my experience says
otherwise. Missing, broken, or mysteriously-rewound refs cause confusing
user-visible behavior, and when compounded with pruning operations like
"git gc" they _do_ result in losing objects.

-Peff
