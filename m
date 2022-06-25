Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B4E55ACD3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiFYVxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 17:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFYVxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 17:53:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621D563F8;
        Sat, 25 Jun 2022 14:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2C8B80B9C;
        Sat, 25 Jun 2022 21:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1621FC341C7;
        Sat, 25 Jun 2022 21:53:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DB7tW2U8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656193983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKgAtScbcJVejOZiW8xqU/Ld19QPfyfBKgOILBLEhyU=;
        b=DB7tW2U8wVslyXk4lJaqLKlA8M0CGWuWAQwoC+hvCFQzgcJNnK+LOGLnQnfCOT6j87oNFC
        LZlYoPTSCRseKwSo4uwCJi2OFEWgzOu1QfTjIq49JZvqpkue64nlF3r1YqDkp8RbBMAm31
        Bf+Kl5BcisB6cADSCHUDrJiC52MoeD0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b248e437 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 21:53:03 +0000 (UTC)
Date:   Sat, 25 Jun 2022 23:53:00 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fs: remove no_llseek
Message-ID: <YreDvG7go6e5m1ox@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-7-Jason@zx2c4.com>
 <YrcJKtZQLDvRgX7P@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrcJKtZQLDvRgX7P@infradead.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Sat, Jun 25, 2022 at 06:10:02AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 25, 2022 at 01:01:13PM +0200, Jason A. Donenfeld wrote:
> > Now that all callers of ->llseek are going through vfs_llseek(), we
> > don't gain anything by keeping no_llseek around. Nothing compares it or
> > calls it.
> 
> Shouldn't this and the checks for no_llseek simply be merged into patch
> 2?

I'd done that at first, but Al had suggested it be a separate commit in
<https://lore.kernel.org/lkml/YrYxOC5dgCKBHwVE@ZenIV/>, when he mentions
"next commit would", so I did how he asked.

> 
> > +	if ((file->f_mode & FMODE_LSEEK) && file->f_op->llseek)
> > +		return file->f_op->llseek(file, offset, whence);
> > +	return -ESPIPE;
> 
> No function change, but in general checking for the error condition
> in the branch tends to be more readable.  i.e.:
> 
> 	if (!(file->f_mode & FMODE_LSEEK) || !file->f_op->llseek)
> 		return -ESPIPE;
> 	return file->f_op->llseek(file, offset, whence);
> 

I thought about this kind of reverse: what is the acceptable condition
in which one may call ->llseek? Easier to express it that way than in
the inverse. But if you really want, I can change it around if there's a
v3 with other changes (which at the moment doesn't seem like there's
going to be).

Jason
