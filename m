Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380EB26E204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgIQRQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:16:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:60296 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgIQRMW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:12:22 -0400
Received: (qmail 2037 invoked by uid 109); 17 Sep 2020 17:12:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 17:12:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10902 invoked by uid 111); 17 Sep 2020 17:12:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 13:12:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 13:12:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917171212.GA3732163@coredump.intra.peff.net>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
 <20200917140912.GA27653@lst.de>
 <20200917145523.GB3076467@coredump.intra.peff.net>
 <20200917145653.GA30972@lst.de>
 <xmqqzh5os9cg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzh5os9cg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:37:19AM -0700, Junio C Hamano wrote:

> > You need to fsync both to be fully compliant, even if just fsyncing b
> > will work for most but not all file systems.  The good news is that
> > for those common file systems the extra fsync of a is almost free.
> 
> Back to Ævar's patch, when creating a new loose object, we do these
> things:
> 
>  1. create temporary file and write the compressed contents to it
>     while computing its object name
> 
>  2. create the fan-out directory under .git/objects/ if needed
> 
>  3. mv temporary file to its final name
> 
> and the patch adds open+fsync+close on the fan-out directory.  In
> the above exchange with Peff, we learned that open+fsync+close needs
> to be done on .git/objects if we created the fan-out directory, too.
> 
> Am I reading the above correctly?

That's my understanding. It gets trickier with refs (which I think we
also ought to consider fsyncing), as we may create arbitrarily deep
hierarchies (so we'd have to keep track of which parts got created, or
just conservatively fsync up the whole hierarchy).

It gets a lot easier if we move to reftables that have a more
predictable file/disk structure.

-Peff
