Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C135F7DC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGTQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJGTQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:16:26 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3A248CC;
        Fri,  7 Oct 2022 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Y+vRoIyoltNuN+rr5FhUbGNtlxBK+mU+zg/3qDDD2s=; b=I5nLEo9TfrcWAP4gQMYKY/+gnk
        zwVsDA9nCptU7un07+UPkzG7VAnBXWX0yqOZu6mkiqOJTaQZxp8/tTlFPCFjhpP2lKIKGKIZ5aZT0
        wJTkzYo9r8iG+ptoEV3fNBykcXjHnFH1qCEo1falxAYrQukqQX6+UJ9MjGFrMUm0l7EmvhFxh6LvD
        OYRDYsdvBoanicC94Lv1iq4KLIFdLD4891WWT0dB2HKXDHVHh8AwGTO3V+kORxsMdQy6DCpqzP24z
        TJcNXK6/8h9CI+yyoKXJ6U3y61nh2BlYJ8/+Aa5aTJas5xQDkUgLf7gA5KRKfbNkKoAhU3UezsfeW
        pTidbOuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ogspP-008Lg9-2Y;
        Fri, 07 Oct 2022 19:16:11 +0000
Date:   Fri, 7 Oct 2022 20:16:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: A field in files_struct has been used without initialization
Message-ID: <Y0B6+0MLZI/nv1aC@ZenIV>
References: <20221006104439.46235-1-abd.masalkhi@gmail.com>
 <20221006105728.47115-1-abd.masalkhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006105728.47115-1-abd.masalkhi@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:57:28PM +0200, Abd-Alrhman Masalkhi wrote:
> > new_fdt->close_on_exec itself has not been initialized, is it intended
> > to be like this.
> 
> I meant:
> 
> newf->close_on_exec_init itself has not been initialized ...

Huh? close_on_exec_init is an array, and this assignment stores the address
of its first (and only) element into newf->fdtab.close_on_exec.  So it's
basically
	newf->fdtab.close_on_exec = &newf->close_on_exec_init[0];

->fdtab and ->close_on_exec_init are to be used only if we need no more than
BITS_PER_LONG descriptors.  It's common enough to make avoiding a separate
allocation (and separate cacheline on following the pointer chain) worth
the trouble.

Note that we do not use newf->fdtab directly - we use newf->fdt.

What happens here is
        new_fdt = &newf->fdtab;
	...
	set newf->fdtab contents for the case we need few descriptors

	if we need more
		allocate a separate struct fdtable, bitmaps, etc.
		set the contents of that separate fdtable
		new_fdt = that new fdtable

	copy bitmaps into whatever new_fdt->close_on_exec and
	new_fdt->open_fds are pointing at.

	copy file pointers into whatever new_fdt->fd[] points at.

	set newf->fdt to new_fdt.

The value of newf->close_on_exec_init is simply newf + known constant.
It needs no initialization at all.  The *contents* of the array
it points to is used only if new_fdt remains pointing to newf->fdtab;
in that case it's initialized by
	copy_fd_bitmaps(new_fdt, old_fdt, open_files);

IOW, for few-descriptors case we end up with

newf:
	fdt			points to newf->fdtab
	fdtab.close_on_exec	points to newf->close_on_exec_init[0]
	fdtab.full_fd_bits	points to newf->full_fd_bits_init[0]
	fdtab.open_fds		points to newf->open_fds_init[0]
	fdtab.fd		points to newf->fd_array[0]
	fdtab.max_fds		max capacity; will be BITS_PER_LONG
	close_on_exec_init[0]	hosts the close_on_exec bitmap
	full_fd_bits_init[0]	hosts the full_fd_bits bitmap
	open_fds_init[0]	hosts the open_fds bitmap
	fd_array[]		contains file pointers (BITS_PER_LONG of them)

For more-than-a-few-descriptors case we have

array of pointers (from first kvmalloc() in alloc_fdtable()): contains file pointers
array of unsigned long (from the second kmvalloc() there): hosts the bitmaps
fdtable (allocated in alloc_fdtable()):
	open_fds		points to the beginning of bitmap-hosting array
	close_on_exec		points to the middle third of the same array
	full_fd_bits		points to the last third of the same array
	fd			points to array of struct file pointers.
	max_fds			max capacity, matches the sizes of arrays.
newf:
	fdt			points to fdtable
	fdtab, ..._init and fd_array 	unused

Might be useful to take a piece of paper and draw the picture,
I really don't want to bother with ASCII graphics for that...
