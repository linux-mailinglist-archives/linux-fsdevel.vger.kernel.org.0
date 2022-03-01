Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E434C90EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiCAQxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 11:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiCAQxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:53:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1AE45042;
        Tue,  1 Mar 2022 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XvdDnpf7vdy2hpW1NYECaNHggy+FOtZ7HAq1aN/zD6Q=; b=Pm/mug0K31YdaE7cJWNIg7eChN
        JwHAGr57sfjK4YVGPV62SRqR1p3FYalAzySCo+oCKfavqfvT8sReD/6V8Bhi3/+8KYMY19QRleDqn
        d6rHLRs0ujznZfg06u91cHgMgED4giyVE/8yhgd/wtsiBxFc/hJLEEeMdl1oiMviDH+bAAENEizAl
        AF+bQ2F35So7sdsHEypbaCfTcEzfbaiSptvfqKXwYyjc4UNZJn3XCjS2a+r0oE4VdiEGrWOdjC9Ws
        A8pv4W1iJ918Y0V+lm5QiQPoSxuKnhqvyb3bhjK4MrHuRfbjhjzHmZtgvWIk+KmKeNupFSxcXMxFx
        ZZ8xE9lA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP5kK-0000UV-Fl; Tue, 01 Mar 2022 16:53:08 +0000
Date:   Tue, 1 Mar 2022 08:53:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Message-ID: <Yh5PdGxnnVru2/go@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
 <1476917.1643724793@warthog.procyon.org.uk>
 <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
 <3136665a674acd1c1cc18f12802684bf82fc8e36.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3136665a674acd1c1cc18f12802684bf82fc8e36.camel@HansenPartnership.com>
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

On Tue, Mar 01, 2022 at 11:47:56AM -0500, James Bottomley wrote:
> On Mon, 2022-02-28 at 16:45 -0800, Luis Chamberlain wrote:
> > On Tue, Feb 01, 2022 at 02:13:13PM +0000, David Howells wrote:
> > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > 
> > > > If the ioctl debate goes against ioctls, I think configfd would
> > > > present
> > > > a more palatable alternative to netlink everywhere.
> > > 
> > > It'd be nice to be able to set up a 'configuration transaction' and
> > > then do a
> > > commit to apply it all in one go.
> > 
> > Can't io-uring cmd effort help here?
> 
> What io-uring cmd effort? 

The file operations version is the latest posted effort:

https://lore.kernel.org/linux-nvme/20210317221027.366780-1-axboe@kernel.dk/

> The one to add nvme completions?

Um, I would not call it that at all, but rather nvme passthrough. But
yes that is possible. But so are many other things, not just ioctls,
which is why I've been suggesting I think it does a disservice to the
efforto just say its useful for ioctl over io-uring. Anything with
a file_operations can tackle on cmd suport using io-uring as a
train.

> If it's
> the completions one, then the configfs interface currently doesn't have
> an event notifier, which is what the completions patch set seems to
> require.  On the other hand configfd is key/value for get/set with an
> atomic activate using an fd, so it stands to reason epoll support could
> be added for events on the fd ... we'd just have to define a retrieval
> key for an indicator to say which events are ready.

It sounds like it could use it.

  Luis
