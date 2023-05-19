Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71089708F22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 07:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjESFEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 01:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESFEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 01:04:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A27107;
        Thu, 18 May 2023 22:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qoebvRH+5DyCHjL5CguUqheVeTvzmE683d7FksxC+hw=; b=EA5TnpVUmLi0YCsEB8c0Ab7YG4
        RnjV8/iUkUeNeDxrAp6ScISMiCeWddLQAnBAlp0mDcJ7nz4mtHSZs06CaDNGPC+F5U+tyw28k6tK7
        2lcUctBUCd/hcc3cUhHZRDmJ3AY25s0c2j/KQN05/1t9fAQOstJwHySGE0BPzXjVFrW0CFfOVI5oX
        9oTRzG+O1PHfzd3ep6C6mrA8WOJawZMfeE23Y3ID6YnwMTSxVrACjejjv4Kenrow3bY6Nn6Sh02s+
        LSORCBbroHJWVVCWJxd2rvX0+9IoI9/VP/2Oo21Ac4R8iFCtjPdcGiCVhky1OrrXjr8XbanrrXYqp
        Hf1n3wfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzsIF-00F6X5-0s;
        Fri, 19 May 2023 05:04:43 +0000
Date:   Thu, 18 May 2023 22:04:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     corbet@lwn.net, jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
Message-ID: <ZGcDaysYl+w9kV6+@infradead.org>
References: <20230518150105.3160445-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518150105.3160445-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 08:01:05AM -0700, Luis Chamberlain wrote:
> +        Mapping of heading styles within this document:
> +        Heading 1 uses "====" above and below
> +        Heading 2 uses "===="
> +        Heading 3 uses "----"
> +        Heading 4 uses "````"
> +        Heading 5 uses "^^^^"
> +        Heading 6 uses "~~~~"
> +        Heading 7 uses "...."
> +
> +        Sections are manually numbered because apparently that's what everyone

Why are you picking different defaults then the rest of the kernel
documentation?

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

As mentioned you list time this information was circulated this is not
true.  iomap itself has nothing to with blocks, and even less so with
the page cache per se.  It just iterates over ranges of file data and
applies work to it.

> +iomap IO interfaces
> +===================
> +
> +You call **iomap** depending on the type of filesystem operation you are working
> +on. We detail some of these interactions below.

Who is you?

> +
> +iomap for bufferred IO writes
> +-----------------------------
> +
> +You call **iomap** for buffered IO with:
> +
> + * ``iomap_file_buffered_write()`` - for buffered writes
> + * ``iomap_page_mkwrite()`` - when dealing callbacks for
> +    ``struct vm_operations_struct``
> +
> +  * ``struct vm_operations_struct.page_mkwrite()``
> +  * ``struct vm_operations_struct.fault()``
> +  * ``struct vm_operations_struct.huge_fault()``
> +  * ``struct vm_operations_struct`.pfn_mkwrite()``
> +
> +You *may* use buffered writes to also deal with ``fallocate()``:
> +
> + * ``iomap_zero_range()`` on fallocate for zeroing
> + * ``iomap_truncate_page()`` on fallocate for truncation
> +
> +Typically you'd also happen to use these on paths when updating an inode's size.

I'm not really sure what this is trying to explain.  It basically looks
like filler text generated by machine learning algorithms..

The same is true for a large part of this document.

> +A filesystem also needs to call **iomap** when assisting the VFS manipulating a
> +file into the page cache.

A file systsem doesn't _need_ to do anything.  It may chose to do
things, and the iomap based helpers might be useful for that.  But
again, I'm still not getting what this document is even trying to
explain, as "to implement the method foo, use the iomap_foo" isn't
really helping anyone.

> +Converting filesystems from buffer-head to iomap guide
> +======================================================

If you want such a guide, please keep it in a separate file from the
iomap API documentation.  I'd also suggest that you actually try such
a conversion first, as that might help shaping the documentation :)

> +Testing Direct IO
> +=================
> +
> +Other than fstests you can use LTP's dio, however this tests is limited as it
> +does not test stale data.
> +
> +{{{
> +./runltp -f dio -d /mnt1/scratch/tmp/
> +}}}

How does this belong into an iomap documentation?  If LTPs dio is really
all that useful we should import it into xfstests, btw.  I'm not sure it
is, though.

> +We try to document known issues that folks should be aware of with **iomap** here.

Who is "we"?

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
> + */

I really don't want random blurbs and links like this in the main
header.  If you want to ramble in a little howto that's fine, but the
main header is not the place for it.

Also please keep improvements to the header in a separate patch from
adding Documentation/ documents.
