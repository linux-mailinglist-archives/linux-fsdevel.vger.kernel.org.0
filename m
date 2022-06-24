Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF3559F65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiFXRR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiFXRRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:17:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E628567E75;
        Fri, 24 Jun 2022 10:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0D45B8297D;
        Fri, 24 Jun 2022 17:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9950C34114;
        Fri, 24 Jun 2022 17:17:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GJkuRbC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656091037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWJhsmY99R6xPElhBk3eQIdjXufyBgaNoiOVVlDSqQc=;
        b=GJkuRbC84Ih86xJDJiDPJX0T+zBx8i0TE00tRZ5e3JL1AZRoMPk09cD2D6gqQSCiO4GJWu
        iy8GEDZztfzDf1wEQaDQxeXkmyX3HDGadzpBCuPjigY+azfRmRQZd0inGY0OgIGqIOH/A2
        qwDS1fQ7/vT8xavyBpJhrr/aAVfWWhs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3df34f7b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 17:17:16 +0000 (UTC)
Date:   Fri, 24 Jun 2022 19:17:13 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: clear FMODE_LSEEK if no llseek function
Message-ID: <YrXxmWyJgRX6y5GK@zx2c4.com>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-4-Jason@zx2c4.com>
 <YrXuk+zOt4xFRDMI@ZenIV>
 <YrXvvVtB0XIgnt0P@zx2c4.com>
 <YrXwuf3lw/I1H64q@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrXwuf3lw/I1H64q@ZenIV>
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

On Fri, Jun 24, 2022 at 06:13:29PM +0100, Al Viro wrote:
> On Fri, Jun 24, 2022 at 07:09:17PM +0200, Jason A. Donenfeld wrote:
> > Hi Al,
> > 
> > On Fri, Jun 24, 2022 at 06:04:19PM +0100, Al Viro wrote:
> > > On Fri, Jun 24, 2022 at 06:56:28PM +0200, Jason A. Donenfeld wrote:
> > > > This helps unify a longstanding wart where FMODE_LSEEK hasn't been
> > > > uniformly unset when it should be.
> > > > 
> > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > > ---
> > > >  fs/file_table.c | 2 ++
> > > >  fs/open.c       | 2 ++
> > > >  2 files changed, 4 insertions(+)
> > > > 
> > > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > > index 5424e3a8df5f..15700b2e1b53 100644
> > > > --- a/fs/file_table.c
> > > > +++ b/fs/file_table.c
> > > > @@ -241,6 +241,8 @@ static struct file *alloc_file(const struct path *path, int flags,
> > > >  	if ((file->f_mode & FMODE_WRITE) &&
> > > >  	     likely(fop->write || fop->write_iter))
> > > >  		file->f_mode |= FMODE_CAN_WRITE;
> > > > +	if ((file->f_mode & FMODE_LSEEK) && !file->f_op->llseek)
> > > > +		file->f_mode &= ~FMODE_LSEEK;
> > > 
> > > 	Where would FMODE_LSEEK come from in this one?  ->f_mode is set
> > > (in __alloc_file()) to OPEN_FMODE(flags); that does deal with FMODE_READ
> > > and FMODE_WRITE, but FMODE_LSEEK will be clear...
> > 
> > >From the `int flags` parameter of the function. That's an O flag not an
> > F flag, though, so I assume you mean that it's impossible to get LSEEK
> > there in practice? If so, I'll drop this hunk.
> 
> 	if (file->f_op->llseek)
> 		file->f_mode |= FMODE_LSEEK;
> 
> you want it to match what came in file_operations...

Oh, right. It's the opposite situation as open.c. I'll do it like that
for a v2 of the series.

Jason
