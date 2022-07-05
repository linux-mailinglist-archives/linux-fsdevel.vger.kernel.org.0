Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE95567394
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiGEPzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiGEPyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:54:49 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7D7110B;
        Tue,  5 Jul 2022 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KnteNFVb4hLEYiZyDI8cVxZPIL4Feew3hWjDB9DFLpE=; b=hhcpPpPkvtpvpUJOzPDO+fyAPh
        bxejUaXJd6KqIgbbpg7oM3eEAjsCuAakHKoJ5Akem8fJqRf6xHQZNVvxOYK6c7bXYdMrq7PJmfJrt
        5v3mz/Hcg1m0J4H9bI6W672QPpWsh9Jas1Y69Q/ggQheKU2zXI9Mw0cEkesLUqLgFHcG8aknHFzAL
        qeFmkjn9oWxrbK5sp4EKtqMz5saqPOKJtNgf2SMswxWD3v4XU+pQNb0SzOYBr//qHmP8HSO8Dnp49
        F7UmL+ERiYC4Bo6+u/gQxEvPgJkckVF6uxJVpuPdVhYtbfhAAW5jcuNrXtOfUrOeeRL8hbJBGz8+p
        eztBOkYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8ksU-008R3E-6r;
        Tue, 05 Jul 2022 15:54:18 +0000
Date:   Tue, 5 Jul 2022 16:54:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] block: fix leaking page ref on truncated direct io
Message-ID: <YsReqmngB2MLvYrC@ZenIV>
References: <20220705154506.2993693-1-kbusch@fb.com>
 <20220705154506.2993693-3-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705154506.2993693-3-kbusch@fb.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:45:06AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The size being added to a bio from an iov is aligned to a block size
> after the pages were gotten. If the new aligned size truncates the last
> page, its reference was being leaked. Ensure all pages that were not
> added to the bio have their reference released.
> 
> Since this essentially requires doing the same that bio_put_pages(), and
> there was only one caller for that function, this patch makes the
> put_page() loop common for everyone.
> 
> Fixes: b1a000d3b8ec5 ("block: relax direct io memory alignment")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I still very much dislike this.  Background: iov_iter_get_pages should
advance the fucking iterator by the amount it has grabbed.  It's
really much cleaner that way.  So your round-down-then-fuck-off-if-zero
is going to be a clumsy.

Whatever; I can deal with that on top of your patch.  Where would you
have it go wrt tree?  Could you do a branch based at the last of your
original series, so that both Jens and I could pull from it?

One thing I would really like to avoid is having the entire #for-5.20/block
in ancestors of those commits; that would make for a monumental headache
with iov_iter series ;-/
