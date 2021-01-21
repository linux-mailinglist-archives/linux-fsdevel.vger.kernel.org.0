Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413E72FF240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbhAURny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbhAURnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:43:47 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD50C06174A;
        Thu, 21 Jan 2021 09:43:07 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 76FF46E97; Thu, 21 Jan 2021 12:43:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 76FF46E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611250986;
        bh=PB+xzpEUfQlsg5w3ytd7m/NvmGA9LS0ZccMgPVPs9ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaZx3mg2hPpbFINECvqd0XPYdFb2ROMgzcamiqBmYnLl1LUmy4whb8tvaFgHJKxlD
         dUW8rxyyJ/S0Q1+gsFu+/N5RyNNq0XImHaTJoc+Og2Qizwf1z86MrkLh6xVxL7Dh5S
         WFc/Bjuyiw0ymgARs6vnuzUiUo+toU1sUvZ/pfH4=
Date:   Thu, 21 Jan 2021 12:43:06 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/25] Network fs helper library & fscache kiocb API
Message-ID: <20210121174306.GB20964@fieldses.org>
References: <20210121164645.GA20964@fieldses.org>
 <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
 <1794286.1611248577@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1794286.1611248577@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 05:02:57PM +0000, David Howells wrote:
> J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> > On Wed, Jan 20, 2021 at 10:21:24PM +0000, David Howells wrote:
> > >      Note that this uses SEEK_HOLE/SEEK_DATA to locate the data available
> > >      to be read from the cache.  Whilst this is an improvement from the
> > >      bmap interface, it still has a problem with regard to a modern
> > >      extent-based filesystem inserting or removing bridging blocks of
> > >      zeros.
> > 
> > What are the consequences from the point of view of a user?
> 
> The cache can get both false positive and false negative results on checks for
> the presence of data because an extent-based filesystem can, at will, insert
> or remove blocks of contiguous zeros to make the extents easier to encode
> (ie. bridge them or split them).
> 
> A false-positive means that you get a block of zeros in the middle of your
> file that very probably shouldn't be there (ie. file corruption); a
> false-negative means that we go and reload the missing chunk from the server.
> 
> The problem exists in cachefiles whether we use bmap or we use
> SEEK_HOLE/SEEK_DATA.  The only way round it is to keep track of what data is
> present independently of backing filesystem's metadata.
> 
> To this end, it shouldn't (mis)behave differently than the code already there
> - except that it handles better the case in which the backing filesystem
> blocksize != PAGE_SIZE (which may not be relevant on an extent-based
> filesystem anyway if it packs parts of different files together in a single
> block) because the current implementation only bmaps the first block in a page
> and doesn't probe for the rest.
> 
> Fixing this requires a much bigger overhaul of cachefiles than this patchset
> performs.

That sounds like "sometimes you may get file corruption and there's
nothing you can do about it".  But I know people actually use fscache,
so it must be reliable at least for some use cases.

Is it that those "bridging" blocks only show up in certain corner cases
that users can arrange to avoid?  Or that it's OK as long as you use
certain specific file systems whose behavior goes beyond what's
technically required by the bamp or seek interfaces?

--b.

> 
> Also, it works towards getting rid of this use of bmap, but that's not user
> visible.
> 
> David
