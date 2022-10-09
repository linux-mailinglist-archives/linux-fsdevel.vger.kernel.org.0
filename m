Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD35F8D1A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJISVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJISVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:21:34 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224DE1EC58;
        Sun,  9 Oct 2022 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+AaABv0hnIsqqTipsqFB7AVqiOczhOfVeqHTIhhaPVY=; b=iVMv0UR9j1bsWPk6t8l844mGtC
        YJPYSoBKRpDjz0PG1/SAEo8M7RFrsiMRxiJs/e6mof9kCbZ5lw/ENf1uOx64KXM4iGZlqk6K72M1Y
        cRckbxMxS6OwS3ejmhNX8tNERFqm+r2JOcZy4Y5fXq4eMy3tfGEs1n1ogHyGwqZIL1c+sd5AS5qkX
        tyyjV4O7RKZAVCnsMaN8MK0Shxr03FzFcjYHA5YNZAD7wqs3gMoaGbIa2L03Ry9BB5oVnfllhgBUe
        YNFppwUex9IQ9A3ZrZOypol+ev//WAryemRHnWDileixTL29sMcl3epXtisCjCLy6GCMtffYhCn2k
        sxC51rvg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ohavX-008xAc-0a;
        Sun, 09 Oct 2022 18:21:27 +0000
Date:   Sun, 9 Oct 2022 19:21:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: A field in files_struct has been used without initialization
Message-ID: <Y0MRJ8scLUZyeC4V@ZenIV>
References: <20221006104439.46235-1-abd.masalkhi@gmail.com>
 <20221006105728.47115-1-abd.masalkhi@gmail.com>
 <Y0B6+0MLZI/nv1aC@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0B6+0MLZI/nv1aC@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 07, 2022 at 08:16:11PM +0100, Al Viro wrote:

> array of pointers (from first kvmalloc() in alloc_fdtable()): contains file pointers
> array of unsigned long (from the second kmvalloc() there): hosts the bitmaps
> fdtable (allocated in alloc_fdtable()):
> 	open_fds		points to the beginning of bitmap-hosting array
> 	close_on_exec		points to the middle third of the same array
> 	full_fd_bits		points to the last third of the same array

Rereading that... a bit of clarification: the wording would seem to imply
that these 3 bitmaps are of equal size; they are not - the third one is
smaller.

If fdt->max_fds (table capacity) is equal to N, we have
	* N struct file pointers in fdt->fd[]
	* N bits in fdt->open_fds[] (i.e. N/BITS_PER_LONG unsigned long)
	* N bits in fdt->close_on_exec[] (ditto)
	* N/BITS_PER_LONG bits in fdt->full_fd_bits[]

The meaning of bitmaps:
	bit k set in open_fds[] - descriptor k is in use
	bit k set in close_on_exec[] - descriptor k is to be closed on exec()
	bit k set in full_fd_bits[] - all descriptors covered by open_fds[k]
(i.e. BITS_PER_LONG of them,, starting from k * BITS_PER_LONG) are in use.
In other words, "don't even bother looking for clear bits in open_fds[k];
there won't be any".

->full_fd_bits[] is there purely as a way to speed finding unused descriptors,
along with ->next_fd.  Some processes have an obscene amount of opened
descriptors and linear search through the mostly full bitmap can get painful.
E.g. 4 millions of descriptors would mean half megabyte worth of bitmap
(in ->open_fds[]).  Cheaper to search through 8Kb of ->full_fd_bits, then
check one 64bit word in ->open_fds[]; kinder on the cache as well...
