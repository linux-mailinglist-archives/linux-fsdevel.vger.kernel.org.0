Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C83250AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 23:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHXVeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 17:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXVeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:34:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEBC061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 14:34:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so115583pjb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1tnpKW7SHCizMw+fZdCtttaAxvwdsazIWa+I3GOIDbQ=;
        b=noMvtxOvblvwbso9maWzdJFFc/KaWD81FdFKeDs6SaXthU4PU0ga/A4MNUOGNvWqfv
         3sDhMzhuaqFCWMJiKzVwdM7sFQJvgGgc7hxkDnIAQXkC14/wubgH7KkUaHOuvijsFjwa
         T1eu0/+KytUdhNib5E1Z6uouzLS3hrHt93VWmgAbDYAgKfu3XBJnrzCXLa5X2/BSXL08
         pkynH1R7Z2bxxG1lwtgAxV01TjLR6ncnEJ+rRwH9O23H8Vb5XOwL9OcY56m2ezVPL0Ff
         37BwjdZ3JSSGgVqQUxXKgRgWnVlkMJpjg19X0rRBj5Zp62CMpo+9EDOuuZaaII/uOSs0
         7s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1tnpKW7SHCizMw+fZdCtttaAxvwdsazIWa+I3GOIDbQ=;
        b=tRUGGUUitR7dgs8/lAHki9LNLA7HgjYZNfMh471H31dAQiyOxdsU0f5BiZ2rDv6rWC
         slRxFMxVaGfzPOPwUBYgFG6meKs0NWOKalb7rXRD2t/zAEuaN6dPARoaKEqFAmCBvgHo
         Qr3EbWOqqoHnRByX7Z+CL82QWZwMyNrCCTs1mlReyuQ6Tg7ghOWComh6ZN6y/UV4BE9o
         SQqEfGUgBEAnoO3bEJBSNwTDXcq2s7hEE7y3AQvzeXAMW22fZiS+Ch2ooRM1ToNpAXip
         O6qH2ZAYPEmDMsnWoBeXTulGnZmtDofkPvT6WQJIxTLvHmJYe/kQteoB8XXOaQQ27bJm
         hU/g==
X-Gm-Message-State: AOAM533qBLgG3D0bpRYLzAB6h1ZjvpUaU3AN9sIDoNijKeLqatI0g4vV
        SBwbSpnkQfuEunafujFn09/HTg==
X-Google-Smtp-Source: ABdhPJwi0nAbK2y27XN+QKjwlR7l/Haagt6Oz9cRRnPFfNhVHD2C+vgQPajfU6HCQdhI0P721qO+2A==
X-Received: by 2002:a17:90a:468d:: with SMTP id z13mr956178pjf.105.1598304855160;
        Mon, 24 Aug 2020 14:34:15 -0700 (PDT)
Received: from exodia.localdomain ([2620:10d:c090:400::5:8d5d])
        by smtp.gmail.com with ESMTPSA id k5sm11004022pgk.78.2020.08.24.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:34:14 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:34:12 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/9] btrfs: send: avoid copying file data
Message-ID: <20200824213412.GE197795@exodia.localdomain>
References: <cover.1597994106.git.osandov@osandov.com>
 <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
 <CAL3q7H5s3OgdNWH-7snH0cpPb2euQKB8pJN0oeO-rdh=8LB6jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5s3OgdNWH-7snH0cpPb2euQKB8pJN0oeO-rdh=8LB6jA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:29:30PM +0100, Filipe Manana wrote:
> On Fri, Aug 21, 2020 at 8:42 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > send_write() currently copies from the page cache to sctx->read_buf, and
> > then from sctx->read_buf to sctx->send_buf. Similarly, send_hole()
> > zeroes sctx->read_buf and then copies from sctx->read_buf to
> > sctx->send_buf. However, if we write the TLV header manually, we can
> > copy to sctx->send_buf directly and get rid of sctx->read_buf.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Looks good, and it passed some long duration tests with both full and
> incremental sends here (with and without compression, no-holes, etc).
> Only one minor thing below, but it's really subjective and doesn't
> make much of a difference.
> 
> Thanks.
> 
> > ---
> >  fs/btrfs/send.c | 65 +++++++++++++++++++++++++++++--------------------
> >  fs/btrfs/send.h |  1 -
> >  2 files changed, 39 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 8af5e867e4ca..e70f5ceb3261 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -122,8 +122,6 @@ struct send_ctx {
> >
> >         struct file_ra_state ra;
> >
> > -       char *read_buf;
> > -
> >         /*
> >          * We process inodes by their increasing order, so if before an
> >          * incremental send we reverse the parent/child relationship of
> > @@ -4794,7 +4792,25 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
> >         return ret;
> >  }
> >
> > -static int fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
> > +static u64 max_send_read_size(struct send_ctx *sctx)
> 
> We could make this inline, since it's so small and trivial, and
> constify the argument too.

Good point, fixed. Thanks, Filipe!
