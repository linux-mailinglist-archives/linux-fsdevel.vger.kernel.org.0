Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B656392DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 01:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKZAwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 19:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKZAwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:52:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F82180C;
        Fri, 25 Nov 2022 16:52:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE1D5609AD;
        Sat, 26 Nov 2022 00:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB43C433C1;
        Sat, 26 Nov 2022 00:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669423963;
        bh=23uMlPI2b38Pk/HLBQWrKukbXUGQaLxTVt8eFQGlz7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nq0wbB1Ta+GNBrk92HU880jJ1B+pW/zAYuF6oHY1q0MOvSeihnjz3NQGV6k04hazX
         zDPH1hYvHSC7SfMZLvIjEa/x5BR7N9QBZyYx/LysiISrLxUfev2xL6P36uld/pvIhv
         mDW0selFgwz0Pnwx17PG2ARdv+guOVKnQ/RgQlnY=
Date:   Fri, 25 Nov 2022 16:52:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com
Subject: Re: [PATCH] filemap: Fix some misleading comments
Message-Id: <20221125165242.a33918e30cc9dc70750ed95f@linux-foundation.org>
In-Reply-To: <20221125070959.49027-1-zhangjiachen.jaycee@bytedance.com>
References: <20221125070959.49027-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 25 Nov 2022 15:09:59 +0800 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com> wrote:

> The users of filemap_write_and_wait_range() and file_write_and_wait_range()
> interfaces should set the lend parameter to LLONG_MAX, rather than -1, to
> indicate they want to writeback to the very end-of-file, as several kernel
> code paths are checking the 'wbc->range_end == LLONG_MAX' conditions.

Unclear.  LLONG_MAX differs from -1 on 64-bit and differs differently
on 32-bit.

> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -661,7 +661,8 @@ EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
>   * Write out and wait upon file offsets lstart->lend, inclusive.
>   *
>   * Note that @lend is inclusive (describes the last byte to be written) so
> - * that this function can be used to write to the very end-of-file (end = -1).
> + * that this function can be used to write to the very end-of-file (@lend =
> + * LLONG_MAX).
>   *

The write(2) manpage says "According to POSIX.1, if count is greater
than SSIZE_MAX, the result is implementation-defined; see NOTES for the
upper limit on Linux." And filemap_fdatawrite_wbc() enforces LONG_MAX,
which differs from LLONG_MAX on 32-bit.

I suspect more research is needed here.
