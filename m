Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16D326DED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgIQOzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 10:55:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:60068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgIQOzi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:55:38 -0400
Received: (qmail 1075 invoked by uid 109); 17 Sep 2020 14:55:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 14:55:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9433 invoked by uid 111); 17 Sep 2020 14:55:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 10:55:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 10:55:23 -0400
From:   Jeff King <peff@peff.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917145523.GB3076467@coredump.intra.peff.net>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
 <20200917140912.GA27653@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917140912.GA27653@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:09:12PM +0200, Christoph Hellwig wrote:

> On Thu, Sep 17, 2020 at 01:28:29PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Change the behavior of core.fsyncObjectFiles to also sync the
> > directory entry. I don't have a case where this broke, just going by
> > paranoia and the fsync(2) manual page's guarantees about its behavior.
> 
> It is not just paranoia, but indeed what is required from the standards
> POV.  At least for many Linux file systems your second fsync will be
> very cheap (basically a NULL syscall) as the log has alredy been forced
> all the way by the first one, but you can't rely on that.

Is it sufficient to fsync() just the surrounding directory? I.e., if I
do:

  mkdir("a");
  mkdir("a/b");
  open("a/b/c", O_WRONLY);

is it enough to fsync() a descriptor pointing to "a/b", or should I
also do "a"?

-Peff
