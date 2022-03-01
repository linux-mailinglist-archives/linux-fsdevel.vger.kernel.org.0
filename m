Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1DB4C92C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiCASR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiCASRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:17:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3665142;
        Tue,  1 Mar 2022 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bA9soa2t3bqmlFiCD2VB2VxGAWJt0UkP7z5XDZp5tGM=; b=La7FI/vT2Te+gJy2TKKu57IPkT
        i7V+hA0DSsBVKi/ZyJ83T+qXHuOPtmiSUhSCxI0rGzgQbHeZYay0F5/VyunJMBuBY9A9CZ1ODUNQO
        t/y2CK4KkT0eGZ+FWweE9u/wG4d9C/jxhAarbZ6gDhRQbJlvubvI4UXcp5G7Dbb+IUE5Tpfxrsopa
        Z9RCAtpp3D8LYg6/QhONP0p+M2k0m14IBOhvCKK2bmuPivmHERdXyB2VIDospdJph6guYOLCgASBX
        6Mu953bgE2fo4JFdK6IgdytGFDdQdJoTQ6ZABtP8jSqifjfbmnNLeDAXr7yP8QMLSU+JUckP8D/sH
        0Y5mSzgg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP73d-0009pB-CE; Tue, 01 Mar 2022 18:17:09 +0000
Date:   Tue, 1 Mar 2022 10:17:09 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Cc:     David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Message-ID: <Yh5jJWAeTVzBx1YB@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
 <1476917.1643724793@warthog.procyon.org.uk>
 <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
 <3136665a674acd1c1cc18f12802684bf82fc8e36.camel@HansenPartnership.com>
 <Yh5PdGxnnVru2/go@bombadil.infradead.org>
 <9735af01b28f73762a947a0794da63ae35bc06e0.camel@HansenPartnership.com>
 <Yh5afaKFt0bmIs96@bombadil.infradead.org>
 <e05606aeeec6b46762596035d1933e8f8fd23406.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05606aeeec6b46762596035d1933e8f8fd23406.camel@HansenPartnership.com>
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

On Tue, Mar 01, 2022 at 01:08:34PM -0500, James Bottomley wrote:
> On Tue, 2022-03-01 at 09:40 -0800, Luis Chamberlain wrote:
> > On Tue, Mar 01, 2022 at 12:14:49PM -0500, James Bottomley wrote:
> > > It looks fairly similar given the iouring syscalls are on an fd
> > > except
> > > that the structure above hash to be defined and becomes an
> > > ABI.  Since
> > > they configfd uses typed key value pairs, i'd argue it's more
> > > generic
> > > and introspectable.
> > 
> > I'm not suggesting using io-uring cmd as a configuration alternative
> > to configfd, I'm suggesting it can be an async *vehicle* for a bunch
> > of configurations one might need to make in the kernel. If we want
> > to reduce system call uses, we may want to allow something like
> > configfd to accept a batch of configuration options as well, as a
> > batcha, and a final commit to process them.
> 
> Well, that's effectively how it does operate.  Configfd like configfs
> is a dedicated fd you open exclusively for the purpose of
> configuration.  You send it the key/value pairs via the action system
> call.  Although the patch sent used "basic" types as values, nothing
> prevents them being composite types that are aggregated, which would be
> an easy mechanism for batching.
> 
> However, I'd like to add a note of caution: just because we *can* do
> batching with the interface doesn't mean we should.  One of the
> benefits of using simple basic types is easy interpretation by things
> like seccomp; the more complex you make the type, the more internal
> knowledge the seccomp/ebpf script needs.

This alone makes a good argument against ioctls.

> So can I ask just how important batching for configuration changes is?

A great question.

I can't personally think of use cases unless you want batch configuration with
IO operations. io-uring stuff does have some link where in this regard,
given some IO ops also may expose new fds for instance, which you may
later want to use for further IO processing... but that seems very
different than just the question of batching for configuration.

> I get that there's some overhead for doing effectively one syscall per
> k/v pair, but configuration operations aren't usually that time
> critical. 

Agreed and I'd like to hear arguments which would suggest otherwise.

> If you're sending passthrough, then I can see you don't want
> a load of syscalls per op, but equally a passthrough is just an opaque
> packet that's likely not introspectable anyway, so it's a single k/v
> pair.

I think it might be fair to detach config / IO calls. Joshi however
might have more to say about if we really would need to mesh the two.

  Luis
