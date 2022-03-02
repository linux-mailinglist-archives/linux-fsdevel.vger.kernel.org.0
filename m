Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FE4CB19D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 22:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbiCBVz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 16:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbiCBVz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:55:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A55E157;
        Wed,  2 Mar 2022 13:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7rX4o9EM6uFE9/DuHSnF6DB4twUKeWjJp2uS92kofWA=; b=dRHNzPcklEs2ve+szqEBcb/ycb
        BEHarmotf9Q6HzP/2jTn5sSGFDym2k2vjXJA13pyjQ9rwHVcSXXEAvLCmDnrVd/diBZsgxEyCRz8s
        qBHjnQ3Z75qWg0jykUN7hFerkph1zfAqzisxJshHeNP8ON3CpazbBxT9qF19/eTdi61O0vCpW5msh
        66qa3oTArhyXUyuoWe+yVHDGRWk77Z6ka+bHe2BEyXMZSUf0CjFF6Oh089vDJfpaWYZ5qEdUJSJ3y
        23s4eH/lpU/Jtl3w77+4Ebw1eRBXQg5MnM1LagVue0cLpG+hAUg5EouSXEBfJXUMYO5TcVZSS3y3a
        TqPInUKA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPWvf-004RAG-2A; Wed, 02 Mar 2022 21:54:39 +0000
Date:   Wed, 2 Mar 2022 13:54:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Message-ID: <Yh/nn1yjU1xF9qCG@bombadil.infradead.org>
References: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
 <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
 <1476917.1643724793@warthog.procyon.org.uk>
 <3570401.1646234372@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3570401.1646234372@warthog.procyon.org.uk>
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

On Wed, Mar 02, 2022 at 03:19:32PM +0000, David Howells wrote:
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > > It'd be nice to be able to set up a 'configuration transaction' and then
> > > do a commit to apply it all in one go.
> > 
> > Can't io-uring cmd effort help here?
> 
> I don't know.  Wouldn't that want to apply each element as a separate thing?

There is nothing to stop us to design an API which starts a transaction / ends.
And io-uring cmd supports links so this is all possible in theory, I just don't
think anyone has done it before.

I mean... io-uring cmd file operation stuff is not even upstream yet...

> But you might want to do something more akin to a db transaction, where you
> start a transaction, read stuff, consider your changes, propose your changes
> and then commit - which would mean io_uring wouldn't help.

I think Pavel had some advanced use cases to support that with io-uring
cmd work. For instance open a file descriptor and then work on it all
in the same chain of commands sent.

  Luis
