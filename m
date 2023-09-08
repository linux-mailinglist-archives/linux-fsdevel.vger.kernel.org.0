Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700A67984E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 11:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjIHJiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 05:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjIHJiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:38:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA97111B;
        Fri,  8 Sep 2023 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZUx9P8uq0s7KOnBO9cNPnozV8SPbCPIMugH1f4rHk0Q=; b=3Bf/UtmV/ogMHVqzHNrYqqH2Iz
        2Iunu9/UJa7ir0Xv1wtNqmkcza6q4XK4vHAK12aCpJLki+9InvyjM+88UEo7Vb8FvjOmfx5PEYKST
        ybvrpESgtaM6T/EhJOV95D6luV8AjOQUyIJu1Gcpe6zHYpaw1U8KH+iBNPqMbQNEauxGblnGohx08
        D9QQ2YU7mfx23Hnj9FLF9or+Vq4vFMW9cfFeI8xAlkcBz8m/boL+o908ov9ay1gbxzm4g1GeV6sEC
        Mf9fN75zbNdbrzgOezoqUsMMTIOmVNxPS4US1HT+qeAwRi1F0eVgO+lkBHN2at0Mkox1HKRwqpPgV
        4lPdkTTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeXw2-00DPld-1j;
        Fri, 08 Sep 2023 09:37:54 +0000
Date:   Fri, 8 Sep 2023 02:37:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPrrcpZgJWFfFfEL@infradead.org>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <ZPcsHyWOHGJid82J@infradead.org>
 <20230906000007.ry5rmk35vt57kppx@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906000007.ry5rmk35vt57kppx@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:00:07PM -0400, Kent Overstreet wrote:
> But the reasons bcachefs doesn't use iomap have been discussed at
> length,

Care to send a pointer?

> that code. You were AWOL on those discussions; you consistently say
> "bcachefs should use iomap" and then walk away, so those discussions
> haven't moved forwards.

Well, let's hsave the proper discussion then.  I defintively don't
think "I just walked away", because that's not what I do.  I did give
up on quite a few of discussions with your because they turned from
technical into personal very quick, but I don't even remember that
for this case.

> To recap, besides being more iterator like (passing data structures
> around with iterators,

Which is something you can do with iomap, and we're making use of that
in quite a few places.  Thanks to the work from willy that I helped a
bit with this has been done years ago.  It might or might not make
sense to replace iomap_begin/end with a single iter callback that
can be inlined, but that's not changing anything fundamental.


> bcachefs also hangs a bit more state off the pagecache, due to being
> multi device and also using the same data structure for tracking disk
> reservations (because why make the buffered write paths look that up
> separately?).

I'm not even parsing the sentence.  But as said many times I'm all ear
if we stick to technical questions.  We've added all kinds of
improvements to iomap especially for gfs2 and btrfs, and while it
sometimes took some time we're all better off with that as we're
converging on a model of doing I/O instead of everytone doing something
slightly different.

> 
> > But without that, and without being in linux-next and the VFS maintainer
> > ACK required for I think this is a very bad idea.
> 
> Christain gave his reviewed-by for the dcache patch. Since this patchset
> doesn't change existing code maintained by others aside from that one
> patch, not sure how linux-next is relevant here...

Because file systems really should have a VFS maintainer ACK, just like
block drivers have a block maintainer ACK, or network drivers have a
net maintainer ACK.  Doing this differently for the most complex driver
interface in the kernel doesn't make any sense whatsover. 
