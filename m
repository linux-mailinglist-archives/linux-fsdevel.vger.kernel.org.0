Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7586E722A41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 17:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjFEPHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 11:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjFEPHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC36EA;
        Mon,  5 Jun 2023 08:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 584F061D0A;
        Mon,  5 Jun 2023 15:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C5BC4339B;
        Mon,  5 Jun 2023 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685977664;
        bh=zmoA4oHWgg1re2UyvCi+eWlKJrDMOpb/Pib6CUUaio0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJDbzNm7m2hUEWE9GTOJlB4OJlWzsB6kcl47F3+bvlG5GOrvzBQvv6vCjxTxUZbLP
         +66lqihQ+VlpDKn54aczCWRS3aLtdRbV7bbud8vFxQLhqQBvIo5fRfv+0gbwhtoix5
         WRm3eRVz3bNG71gVrQzfWkFdtCa1r7OGFX6xnM2fNyMuo985jsj/6Y8/s1Z8ZZwz1Y
         etW5awKTvpfL1FMYvW2l5Sqgt2pkaB9yNuKnvtPc1T4LhDEDZAgTUK8zxm1WsHInHc
         9DqceGgghM/XLWNCefu/Bqy6C35uXK53GQJhKIMnb073SOEEq+hnt5ChD7BSyQK0dA
         XItc+siWmgxQg==
Date:   Mon, 5 Jun 2023 08:07:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/7] doc: Correct the description of ->release_folio
Message-ID: <20230605150744.GJ72241@frogsfrogsfrogs>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-3-willy@infradead.org>
 <20230604175548.GA72241@frogsfrogsfrogs>
 <ZHzvzzvoQGmIaO6n@casper.infradead.org>
 <20230604203306.GB72267@frogsfrogsfrogs>
 <ZH3fCy+J+oLDTTkf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH3fCy+J+oLDTTkf@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:11:39PM +0100, Matthew Wilcox wrote:
> On Sun, Jun 04, 2023 at 01:33:06PM -0700, Darrick J. Wong wrote:
> > On Sun, Jun 04, 2023 at 09:10:55PM +0100, Matthew Wilcox wrote:
> > > On Sun, Jun 04, 2023 at 10:55:48AM -0700, Darrick J. Wong wrote:
> > > > On Fri, Jun 02, 2023 at 11:24:39PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > > -->release_folio() is called when the kernel is about to try to drop the
> > > > > -buffers from the folio in preparation for freeing it.  It returns false to
> > > > > -indicate that the buffers are (or may be) freeable.  If ->release_folio is
> > > > > -NULL, the kernel assumes that the fs has no private interest in the buffers.
> > > > > +->release_folio() is called when the MM wants to make a change to the
> > > > > +folio that would invalidate the filesystem's private data.  For example,
> > > > > +it may be about to be removed from the address_space or split.  The folio
> > > > > +is locked and not under writeback.  It may be dirty.  The gfp parameter is
> > > > > +not usually used for allocation, but rather to indicate what the filesystem
> > > > > +may do to attempt to free the private data.  The filesystem may
> > > > > +return false to indicate that the folio's private data cannot be freed.
> > > > > +If it returns true, it should have already removed the private data from
> > > > > +the folio.  If a filesystem does not provide a ->release_folio method,
> > > > > +the kernel will call try_to_free_buffers().
> > > > 
> > > > the MM?  Since you changed that above... :)
> > > > 
> > > > With that nit fixed,
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Well, is it the MM?  At this point, the decision is made by
> > > filemap_release_folio(), which is the VFS, in my opinion ;-)
> > 
> > It's in mm/filemap.c, which I think makes it squarely the pagecache/mm,
> > not the vfs.
> 
> Changed this to:
> 
> If a filesystem does not provide a ->release_folio method,
> the pagecache will assume that private data is buffer_heads and call
> try_to_free_buffers().

Holy schism resolved;
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

