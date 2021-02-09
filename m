Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F3315888
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 22:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhBIVU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 16:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234284AbhBIVMp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:12:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94F4864E85;
        Tue,  9 Feb 2021 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612900543;
        bh=/VVBW/mmIaA9aKxI4f8SyqvwmyZqliL2BhQwvcCvZfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HsE/Kxij+DWxv152OJJcn+tRfjMZQ74BZ/MkOBURXxcAOGGHo+C4qd44rbRSwWhzh
         2YSwczO9yPWYBGDK+li9B2xVV7d0GVnbiuIxDvH9bkQzGbBdEx7BEru5t6O+6Ck1Hb
         V368P9hl5NY4qebU5s1QtbZ59vFE2LzjOXzGH6nU=
Date:   Tue, 9 Feb 2021 11:55:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org
Subject: Re: [PATCHSET v2 0/3] Improve IOCB_NOWAIT O_DIRECT reads
Message-Id: <20210209115542.3e407e306a4f1af29257c8f6@linux-foundation.org>
In-Reply-To: <20210209023008.76263-1-axboe@kernel.dk>
References: <20210209023008.76263-1-axboe@kernel.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  8 Feb 2021 19:30:05 -0700 Jens Axboe <axboe@kernel.dk> wrote:

> Hi,
> 
> For v1, see:
> 
> https://lore.kernel.org/linux-fsdevel/20210208221829.17247-1-axboe@kernel.dk/
> 
> tldr; don't -EAGAIN IOCB_NOWAIT dio reads just because we have page cache
> entries for the given range. This causes unnecessary work from the callers
> side, when the IO could have been issued totally fine without blocking on
> writeback when there is none.
> 

Seems a good idea.  Obviously we'll do more work in the case where some
writeback needs doing, but we'll be doing synchronous writeout in that
case anyway so who cares.

Please remind me what prevents pages from becoming dirty during or
immediately after the filemap_range_needs_writeback() check?  Perhaps
filemap_range_needs_writeback() could have a comment explaining what it
is that keeps its return value true after it has returned it!
