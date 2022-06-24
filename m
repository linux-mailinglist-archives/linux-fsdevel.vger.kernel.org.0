Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621B559F64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiFXRJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiFXRJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F951E42;
        Fri, 24 Jun 2022 10:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94DD76225C;
        Fri, 24 Jun 2022 17:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CCEC34114;
        Fri, 24 Jun 2022 17:09:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GRCkiDNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656090561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEFxaXOpm47YuvNIIydx/V+Sc+BnS54ItZCrlbSUgmE=;
        b=GRCkiDNjHvmlVq5o/W20lp1q4DRqpnzFVmV8PPMcKy7NWKh56uAQZGvwRJ/TiX7SAvb+Af
        hJk7ARl+DvNfbYnJPgM1UeIph9ra9+QNhga1yLa0mqDOP1Ih5bDHgDQXhrq5TuCAS2ONLw
        oZ7VwemFnwIU/foXGGkZqqEg4b5rPsw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 569f60d8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 17:09:20 +0000 (UTC)
Date:   Fri, 24 Jun 2022 19:09:17 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: clear FMODE_LSEEK if no llseek function
Message-ID: <YrXvvVtB0XIgnt0P@zx2c4.com>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-4-Jason@zx2c4.com>
 <YrXuk+zOt4xFRDMI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrXuk+zOt4xFRDMI@ZenIV>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Fri, Jun 24, 2022 at 06:04:19PM +0100, Al Viro wrote:
> On Fri, Jun 24, 2022 at 06:56:28PM +0200, Jason A. Donenfeld wrote:
> > This helps unify a longstanding wart where FMODE_LSEEK hasn't been
> > uniformly unset when it should be.
> > 
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  fs/file_table.c | 2 ++
> >  fs/open.c       | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 5424e3a8df5f..15700b2e1b53 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -241,6 +241,8 @@ static struct file *alloc_file(const struct path *path, int flags,
> >  	if ((file->f_mode & FMODE_WRITE) &&
> >  	     likely(fop->write || fop->write_iter))
> >  		file->f_mode |= FMODE_CAN_WRITE;
> > +	if ((file->f_mode & FMODE_LSEEK) && !file->f_op->llseek)
> > +		file->f_mode &= ~FMODE_LSEEK;
> 
> 	Where would FMODE_LSEEK come from in this one?  ->f_mode is set
> (in __alloc_file()) to OPEN_FMODE(flags); that does deal with FMODE_READ
> and FMODE_WRITE, but FMODE_LSEEK will be clear...

From the `int flags` parameter of the function. That's an O flag not an
F flag, though, so I assume you mean that it's impossible to get LSEEK
there in practice? If so, I'll drop this hunk.

Jason
