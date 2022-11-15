Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73F628FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 03:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiKOCfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 21:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKOCe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:34:59 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD1C140F0;
        Mon, 14 Nov 2022 18:34:57 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 6C689C01F; Tue, 15 Nov 2022 03:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668479700; bh=nbL/xZDPCL8jmbEEnRtWHyMrAnIAlzzCW9ltmbNEdmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTubEyb88pK+tsFm7mlAIi0fLDfKqvqQliCRntOPeC4bJA7GiR8kUDT7tiQCWJIiS
         u0yKZzPzdUkxqS4ycN4tcYIjo+s5sw92WqHr8NaO7GbCjD3sgqG4vrudrxEhFOrT9f
         +T8bbOugd7Dg7OSLKsblTaJ9E/kMNnh6rnyRX7sIEznZDN5dyWBWm7rjvVYYPfL8Ur
         aGrU8o9oMCKHmT4nvvDedDxlMj92pLGNV+MnictvtnaosvsSfGqroOpH2OV3ziZ/E9
         INWP10dOAk+5o4VIlIZbWsChdcJCuG+0QBDXAaLx8Rp1dTjjERzVmfrvQTLaxM64pK
         r7cxJX4SQt5WQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D917EC009;
        Tue, 15 Nov 2022 03:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668479699; bh=nbL/xZDPCL8jmbEEnRtWHyMrAnIAlzzCW9ltmbNEdmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODuILm6w+muG3YeYXeL/B2w4v4ALouBB7EV1VWeD79EfdWs/VXHiGECni9EG7SqsI
         agXPtCjW3dGG4vr5u/QKL9H6P16bSuKD0imiXCGlAD0h2CLVsb8gZ+zbmNmMIOJRTR
         Wv09VHJNaZty+f1IPSOoZ8PvXKpoig+0zjZjTZ2n4NhZJ2PqeRmn25Xf5lQgrMAo6M
         mxOKmEx83Okrxey+BEMqnxazd9KX0jdhVii/ypx6Z171SAn5mV7jqq5K5IfgQrcRqn
         HlAUbhC42z9d7SAJrThRyyEAOysG0Cja0bVY4Y2pkA+slZ0Jh+0maC+cdYHAkDORZO
         rKrJwJ3Gb50hg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id ea3428a8;
        Tue, 15 Nov 2022 02:34:46 +0000 (UTC)
Date:   Tue, 15 Nov 2022 11:34:31 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, dwysocha@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
Message-ID: <Y3L6t0U89o27gJru@codewreck.org>
References: <Y3Lbul7FZncNVwVZ@codewreck.org>
 <166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk>
 <1457985.1668472862@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1457985.1668472862@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Tue, Nov 15, 2022 at 12:41:02AM +0000:
> Dominique Martinet <asmadeus@codewreck.org> wrote:
> > any harm in setting this if netfs isn't enabled?
> > (just asking because you checked in fs/9p/cache.c above)
> 
> Well, it forces a call to ->release_folio() every time a folio is released, if
> set, rather than just if PG_private/PG_private_2 is set.

Yes, that's what I gathered from your explanation, but I don't
understand what release_folio() actually implies in practice which is
why I asked -- it looked a bit odd that you're checking for
v9inode->netfs.cache in one case and not in the other; especially as all
inodes should go through both v9fs_cache_inode_get_cookie() (when
created) and v9fs_evict_inode() so I was a bit curious.

In the 9p-without-cache case, we're normally not going through page
cache at all, so I guess there won't be any mapping and this will be
free anyway...

> > > -	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
> > > +	if (!filemap_release_folio(folio, 0))
> > 
> > should this (and all others) check for folio_needs_release instead of has_private?
> > filemap_release_folio doesn't check as far as I can see, but perhaps
> > it's already fast and noop for another reason I didn't see.
> 
> Willy suggested merging the checks from folio_has_private() into
> filemap_release_folio():
> 
> 	https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/

Ah, I didn't understand the suggestion in your patch was a separate
patch and didn't follow the link.
It doesn't look like a patch per se, perhaps sending both together would
make sense -- but on top of this change these should indeed be fine,
thanks.

--
Dominique
