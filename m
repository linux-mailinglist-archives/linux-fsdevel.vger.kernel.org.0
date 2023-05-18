Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B511708C14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 01:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjERXJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjERXJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 19:09:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BE218D;
        Thu, 18 May 2023 16:09:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA2BC6E3;
        Thu, 18 May 2023 23:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA2BC6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684451343; bh=1M5d91X9MObXWb0pgAgYuQeNohJxmU2Ps8GnVyUg/3w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jepeY1C96EP+fR9RyG121qTdDSV3QXN1Z5+jxxnfiNNGC7DCKW5gw7xDz4PnbrzMI
         ww2ex1Yym24pC7VvTol2CGQ092poGEmeRSgxIUy4n+dJ4tC/B5FC4l9xMsyFa7PEu6
         M7ab1tT7uvDSQOQiEjBavSbzeQVDUA5zmPCzSdgvNcVEd84dEsgiGEEukl8H2y1xM5
         y9RDqDAjiJdBcKjMZEYllzN5Pq3bIdR6s7KQhrv3K30nhvKppaEKaW3P9Owls4aOR9
         yABduy2xRUq2Nd4S0vVNc9Hx5RsYpuZVTQ9cjTSLpW9UdxtOYiw1K1h2HyFRgEzN3a
         KrSDco9sso3zg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Luis Chamberlain <mcgrof@kernel.org>, jake@lwn.net,
        hch@infradead.org, djwong@kernel.org, dchinner@redhat.com
Cc:     ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        mcgrof@kernel.org
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
In-Reply-To: <20230518150105.3160445-1-mcgrof@kernel.org>
References: <20230518150105.3160445-1-mcgrof@kernel.org>
Date:   Thu, 18 May 2023 17:09:02 -0600
Message-ID: <87zg61p78x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> To help with iomap adoption / porting I set out the goal to try to
> help improve the iomap documentation and get general guidance for
> filesystem conversions over from buffer-head in time for this year's
> LSFMM. The end results thanks to the review of Darrick, Christoph and
> others is on the kernelnewbies wiki [0].
>
> This brings this forward a relevant subset of that documentation to
> the kernel in kdoc format and also kdoc'ifies the existing documentation
> on iomap.h.

OK, I've had a read through it.  Thanks again for doing it, we
definitely need this.  There are typos and such that Randy has already
pointed out, so I won't bother with those.  My main comment is mainly a
high level one, along with a handful of nits.

My high-level question is: who is the audience for this document?  I'm
guessing it's filesystem developers?  Whoever it is, the document could
benefit from an introductory section, aimed at that audience, saying how
to get *started* with iomap.  What include files do I need?  How do I
provide a set of iomap callbacks and make them visible to the VFS?
Without that sort of stuff, it makes for a rough jumping-in experience.

The nits:

> diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystems/iomap.rst
> new file mode 100644
> index 000000000000..be487030fcff
> --- /dev/null
> +++ b/Documentation/filesystems/iomap.rst
> @@ -0,0 +1,253 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _iomap:

I don't think you use this label anywhere, so it doesn't need to be here.

> +..
> +        Mapping of heading styles within this document:
> +        Heading 1 uses "====" above and below
> +        Heading 2 uses "===="
> +        Heading 3 uses "----"
> +        Heading 4 uses "````"
> +        Heading 5 uses "^^^^"
> +        Heading 6 uses "~~~~"
> +        Heading 7 uses "...."

We have a set of conventions for section headings, nicely documented in
Documentation/doc-guide/sphinx.rst.  This hierarchy doesn't quite match
it, but you don't get far enough into it to hit the differences.  I'd
just take this out.

> +
> +        Sections are manually numbered because apparently that's what everyone
> +        does in the kernel.

The sections are *not* manually numbered, which I think is entirely
fine.  But that makes this comment a bit weird.

> +.. contents:: Table of Contents
> +   :local:
> +
> +=====
> +iomap
> +=====
> +
> +.. kernel-doc:: include/linux/iomap.h
> +
> +A modern block abstraction
> +==========================
> +
> +**iomap** allows filesystems to query storage media for data using *byte
> +ranges*. Since block mapping are provided for a *byte ranges* for cache data in
> +memory, in the page cache, naturally this implies operations on block ranges
> +will also deal with *multipage* operations in the page cache. **Folios** are
> +used to help provide *multipage* operations in memory for the *byte ranges*
> +being worked on.

This text (and the document as a whole) is a bit heavy on the markup.
I'd consider taking some of it out to improve the plain-text readability.

[...]

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e2b836c2e119..ee4b026995ac 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -10,6 +10,30 @@
>  #include <linux/mm_types.h>
>  #include <linux/blkdev.h>
>  
> +/**
> + * DOC: Introduction
> + *
> + * iomap allows filesystems to sequentially iterate over byte addressable block
> + * ranges on an inode and apply operations to it.
> + *
> + * iomap grew out of the need to provide a modern block mapping abstraction for
> + * filesystems with the different IO access methods they support and assisting
> + * the VFS with manipulating files into the page cache. iomap helpers are
> + * provided for each of these mechanisms. However, block mapping is just one of
> + * the features of iomap, given iomap supports DAX IO for filesystems and also
> + * supports such the ``lseek``/``llseek`` ``SEEK_DATA``/``SEEK_HOLE``
> + * interfaces.
> + *
> + * Block mapping provides a mapping between data cached in memory and the
> + * location on persistent storage where that data lives. `LWN has an great
> + * review of the old buffer-heads block-mapping and why they are inefficient
> + * <https://lwn.net/Articles/930173/>`, since the inception of Linux.  Since
> + * **buffer-heads** work on a 512-byte block based paradigm, it creates an
> + * overhead for modern storage media which no longer necessarily works only on
> + * 512-blocks. iomap is flexible providing block ranges in *bytes*. iomap, with
> + * the support of folios, provides a modern replacement for **buffer-heads**.

As much as I love to see LWN references embedded in as many kernel files
as possible, I'm honestly not sure that the iomap documentation needs to
talk about buffer heads at all - except maybe for help in replacing
them.  In particular, I don't think that the documentation needs to
justify iomap's existence; we can look at the commit logs if we need to
remind ourselves of that.

Thanks,

jon
