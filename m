Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460467219B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 22:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjFDUdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDUdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 16:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F4CE;
        Sun,  4 Jun 2023 13:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD2660909;
        Sun,  4 Jun 2023 20:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B133C433D2;
        Sun,  4 Jun 2023 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685910787;
        bh=dpMu5X3WuHmH6aomIguFl1RA1wHb5tK6Vwkgrxs25NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjMZYcg2XMMGar1jR07+a2MGljtbk2ybJ4YuI7vhFegJwj/uwQuHjPn15uhrclPP5
         DJqW8DSz9yixVJRqGL6qKISvE1OElXVzYcNwgsXFxIHfeHZMLy/0I8UyHABPehxfjx
         lOonL7uhMtkFaFMCxtfY0xic4LvwlcJKJHU91WrKJ26x1H8NGzxI8uFSjIbtn2xoxY
         Mq9lF4b38XXIZZP8lILFb7/618kkXnbn9O6RqCWVSPhYHfl1D/ZhDuY2QbqZDNq+g0
         qro3Y4H+ychflDfAtoZuv68gUKSv5BrfqmZPdP3cWCa1SOev2dvZnkvFuRJ/D2Aotk
         n6xyRqX0asMeQ==
Date:   Sun, 4 Jun 2023 13:33:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/7] doc: Correct the description of ->release_folio
Message-ID: <20230604203306.GB72267@frogsfrogsfrogs>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-3-willy@infradead.org>
 <20230604175548.GA72241@frogsfrogsfrogs>
 <ZHzvzzvoQGmIaO6n@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHzvzzvoQGmIaO6n@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 04, 2023 at 09:10:55PM +0100, Matthew Wilcox wrote:
> On Sun, Jun 04, 2023 at 10:55:48AM -0700, Darrick J. Wong wrote:
> > On Fri, Jun 02, 2023 at 11:24:39PM +0100, Matthew Wilcox (Oracle) wrote:
> > > -->release_folio() is called when the kernel is about to try to drop the
> > > -buffers from the folio in preparation for freeing it.  It returns false to
> > > -indicate that the buffers are (or may be) freeable.  If ->release_folio is
> > > -NULL, the kernel assumes that the fs has no private interest in the buffers.
> > > +->release_folio() is called when the MM wants to make a change to the
> > > +folio that would invalidate the filesystem's private data.  For example,
> > > +it may be about to be removed from the address_space or split.  The folio
> > > +is locked and not under writeback.  It may be dirty.  The gfp parameter is
> > > +not usually used for allocation, but rather to indicate what the filesystem
> > > +may do to attempt to free the private data.  The filesystem may
> > > +return false to indicate that the folio's private data cannot be freed.
> > > +If it returns true, it should have already removed the private data from
> > > +the folio.  If a filesystem does not provide a ->release_folio method,
> > > +the kernel will call try_to_free_buffers().
> > 
> > the MM?  Since you changed that above... :)
> > 
> > With that nit fixed,
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Well, is it the MM?  At this point, the decision is made by
> filemap_release_folio(), which is the VFS, in my opinion ;-)

It's in mm/filemap.c, which I think makes it squarely the pagecache/mm,
not the vfs.

"Yuh better stop your train, rabbit!" etc ;)

> But I'm happy to use "the MM".  Or "the pagecache".

Sounds good to me.

--D
