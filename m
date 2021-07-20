Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453CE3CFE69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhGTPRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240510AbhGTOhQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 160BC60BBB;
        Tue, 20 Jul 2021 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626794252;
        bh=LtjPryF5wQ+xbt8V4dRvkcVmj+HVQ3+YnBKjwD6ZnZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ej0xHGEHA2478zU7X6ZJ6wQtMml81/PK3gzs2kynQQbFxwA4cRIYlr5JoLwHFq61N
         kL6nNiKsbUvN2RkvRPPiKppvpu9YNJsW28LzfwgduA87qbRnWHPMUG40PvSdvnxO2o
         4PRE51ENn5DrcS5asbNlvG5H3wW6q8d9ucu2wBe0zJmqorMpd37QkaJOt5G35rrog2
         qIzpu47nfzNUQhXBiYpvrX+jLwXyl6sRMBUdt1KlLO8D6o5oMwCG3ehnvEkAeISnQm
         vrhBkCvECcc3RbfsMAwuDCCzLj7sCOEhrZlZ/Tk/Rtt6tMmJKgO8uFExcuq7Cw+ERI
         jctuzM8Vw77+Q==
Date:   Tue, 20 Jul 2021 18:17:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YPbpBv30NqeQPqPK@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YParbk8LxhrZMExc@kernel.org>
 <YPbEax52N7OBQCZp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPbEax52N7OBQCZp@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:41:15PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 20, 2021 at 01:54:38PM +0300, Mike Rapoport wrote:
> > Most of the changelogs (at least at the first patches) mention reduction of
> > the kernel size for your configuration on x86. I wonder, what happens if
> > you build the kernel with "non-distro" configuration, e.g. defconfig or
> > tiny.config?
> 
> I did an allnoconfig build and that reduced in size by ~2KiB.
> 
> > Also, what is the difference on !x86 builds?
> 
> I don't generally do non-x86 builds ... feel free to compare for
> yourself!

I did allnoconfig and defconfig for arm64 and powerpc.

All execpt arm64::defconfig show decrease by ~1KiB, while arm64::defconfig
was actually increased by ~500 bytes.

I didn't dig into objdumps yet.

I also tried to build arm but it failed with:

  CC      fs/remap_range.o
fs/remap_range.c: In function 'vfs_dedupe_file_range_compare':
fs/remap_range.c:250:3: error: implicit declaration of function 'flush_dcache_folio'; did you mean 'flush_cache_louis'? [-Werror=implicit-function-declaration]
  250 |   flush_dcache_folio(src_folio);
      |   ^~~~~~~~~~~~~~~~~~
      |   flush_cache_louis
cc1: some warnings being treated as errors


> I imagine it'll be 2-4 instructions per call to
> compound_head().  ie something like:
> 
> 	load page into reg S
> 	load reg S + 8 into reg T
> 	test bottom bit of reg T
> 	cond-move reg T - 1 to reg S
> becomes
> 	load folio into reg S
> 
> the exact spelling of those instructions will vary from architecture to
> architecture; some will take more instructions than others.  Possibly it
> means we end up using one fewer register and so reducing the number of
> registers spilled to the stack.  Probably not, though.

-- 
Sincerely yours,
Mike.
