Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B994CB3CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 01:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiCCAKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 19:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiCCAKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:10:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE310529C;
        Wed,  2 Mar 2022 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8MhDtqQ0Z0PI4RYelBosXGB/3GmmVHxJgRFyiYQ2lIc=; b=VS52RSFjHjFc85YIWiRxYsmK9A
        dGN1hbFmbe0sPau9oYsf7OCqp18ZD3fpDFB5dgAx8RflLluWd71WIhGjFwGSGLzse6IBY0mMBOtbK
        ryzO5+401ecKTbaFYdcRdQzchtcBde+wK/C5x/V7bn+/kF8ZmJ9EwXQNwjIJWJgf5KRa0oE6QdVMx
        b1XWZdlkwmy2ou7FksM3ztEUBNB27sUMRiegzr/htuKjEGBZ6zfHoRFTmRiFQDWr/pEfRtl6DG37c
        DLtOHeZE++Ff2XwzxGsPyZ/+9seGGxN6dCytqEz9FGqfC6E3M188W3iBrXDQPqCYXsFxibexAxra6
        L9lfU+Bg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPXuI-004esY-HK; Wed, 02 Mar 2022 22:57:18 +0000
Date:   Wed, 2 Mar 2022 14:57:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>
Cc:     David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Message-ID: <Yh/2TpJsqjX3PpVS@bombadil.infradead.org>
References: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
 <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
 <1476917.1643724793@warthog.procyon.org.uk>
 <3570401.1646234372@warthog.procyon.org.uk>
 <Yh/nn1yjU1xF9qCG@bombadil.infradead.org>
 <c16dfd08-14f1-bd43-73ca-c1f3e7b3c205@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16dfd08-14f1-bd43-73ca-c1f3e7b3c205@kernel.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 03:05:33PM -0700, Jens Axboe wrote:
> On 3/2/22 2:54 PM, Luis Chamberlain wrote:
> > On Wed, Mar 02, 2022 at 03:19:32PM +0000, David Howells wrote:
> >> Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>
> >>>> It'd be nice to be able to set up a 'configuration transaction' and then
> >>>> do a commit to apply it all in one go.
> >>>
> >>> Can't io-uring cmd effort help here?
> >>
> >> I don't know.  Wouldn't that want to apply each element as a separate thing?
> > 
> > There is nothing to stop us to design an API which starts a
> > transaction / ends. And io-uring cmd supports links so this is all
> > possible in theory, I just don't think anyone has done it before.
> 
> Only thing you're missing there is unroll on failure. It's quite
> possible to have linked operations, but the only recurse is "abort rest
> of chain if one fails".

Yikes. I can see this getting complicated fast. But wouldn't dbs have
already dealt with this somehow?

But yes, my point still stands. io-uring cmd stuff really can be a game
changer on how we deal with new APIs. While unifying arch stuff to make
system calls easier to add, I'm actually thinking, if an async API
is needed, then perhaps we can *curtail* adding new system calls and just
handle these through the io-uring cmd stuff. Of course, so long as your
subsystem deals with file_operations.

> > I mean... io-uring cmd file operation stuff is not even upstream
> > yet...
> 
> Mostly because it hasn't been pushed. Was waiting for a good idea on how
> to handle extended commands, and actually had the epiphany and
> implemented it next week. So a more palatable version should be posted
> soon.

I am more than ecstatic to hear this! I cannot wait!
 
> >> But you might want to do something more akin to a db transaction, where you
> >> start a transaction, read stuff, consider your changes, propose your changes
> >> and then commit - which would mean io_uring wouldn't help.
> > 
> > I think Pavel had some advanced use cases to support that with io-uring
> > cmd work. For instance open a file descriptor and then work on it all
> > in the same chain of commands sent.
> 
> That already exists in the kernel, it's direct descriptors. See:
> 
> https://lwn.net/Articles/863071/
> 
> With that, you can have a chain that does "open file, do X to file, do Y
> to file, etc, close file" in one operation. Links like mentioned above,
> but can pre-make requests that operate on a descriptor that has been
> opened.

Groovy, thanks for the pointer!

  Luis
