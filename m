Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC177BCF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjHNP17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjHNP1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:27:54 -0400
Received: from out-107.mta1.migadu.com (out-107.mta1.migadu.com [95.215.58.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BE10CC
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 08:27:52 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692026871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMYORv8Y9XEGu31gtq5gaYrN9ZtgzhVQ+gaavBaQ44c=;
        b=hKfCxac/WF7kG6ADzngwi9WNzlNQVEpiU12YtJENuEQN/GmJnxLgW4LBWvMFBtOSEJ4Df1
        46qz/gEbIQHa4fcloHtw9WG8J9U47Dqo87aHJ5XoQjWLs2zaN0rXWhID0WD6yI+p/hzjUP
        TPbqWBK/gh6DC92jW8NdWrt6of70ag4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230814152746.x5l737r5ed6mmkdm@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
 <20230811132141.qxppoculzs5amawn@moria.home.lan>
 <20230814-sekte-asche-5dcf68ec21ba@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-sekte-asche-5dcf68ec21ba@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:21:22AM +0200, Christian Brauner wrote:
> On Fri, Aug 11, 2023 at 09:21:41AM -0400, Kent Overstreet wrote:
> > On Fri, Aug 11, 2023 at 12:54:42PM +0200, Christian Brauner wrote:
> > > > I don't want to do that to Christian either, I think highly of the work
> > > > he's been doing and I don't want to be adding to his frustration. So I
> > > > apologize for loosing my cool earlier; a lot of that was frustration
> > > > from other threads spilling over.
> > > > 
> > > > But: if he's going to be raising objections, I need to know what his
> > > > concerns are if we're going to get anywhere. Raising objections without
> > > > saying what the concerns are shuts down discussion; I don't think it's
> > > > unreasonable to ask people not to do that, and to try and stay focused
> > > > on the code.
> > > 
> > > The technical aspects were made clear off-list and I believe multiple
> > > times on-list by now. Any VFS and block related patches are to be
> > > reviewed and accepted before bcachefs gets merged.
> > 
> > Here's the one VFS patch in the series - could we at least get an ack
> > for this? It's a new helper, just breaks the existing d_tmpfile() up
> > into two functions - I hope we can at least agree that this patch
> > shouldn't be controversial?
> > 
> > -->--
> > Subject: [PATCH] fs: factor out d_mark_tmpfile()
> > 
> > New helper for bcachefs - bcachefs doesn't want the
> > inode_dec_link_count() call that d_tmpfile does, it handles i_nlink on
> > its own atomically with other btree updates
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: linux-fsdevel@vger.kernel.org
> 
> Yep, that looks good,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks, much appreciated
