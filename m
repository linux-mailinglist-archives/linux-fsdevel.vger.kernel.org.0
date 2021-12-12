Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B63471D1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 22:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhLLVDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 16:03:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56388 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhLLVDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:03:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49AAACE0BAC;
        Sun, 12 Dec 2021 21:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209F2C341C8;
        Sun, 12 Dec 2021 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639343009;
        bh=D52nBoIAnUUGNhUalk6JF3ay5W0ObfB82aZbhWZvVxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYGN5qxecKoxLh6SR43P0zbP+NP3geKSpm/26dMjb2EHQQcAmPJfuk9cvM368OaTp
         WXOSK4a1KQGhkZpII9CXlAWf6pvjn3MEpvFwnWMEN9a/cIS8rDU4eeqnC92iuMz9ds
         65rcr8ddnrlX5TO7jy320WQ8yo8+YiqziiIYBNxAd+0Jk++/q9+MznhPSTP3iL/hbs
         6g8XS9t2ATdaaLGIcaKtzDMV7tPZ0F9fOdVDueUQOEEeFfQCYvEsyqEAjXYgXV/ZfM
         4RCpTsbmJBZ6GnM4+X/l/rjvq2YGyGMarog2m2nrBI4bSwOifcMrbSqiBlJCkzQ3gL
         mD8TNAMMnUzmg==
Date:   Sun, 12 Dec 2021 13:03:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/36] fscrypt: uninline and export fscrypt_require_key
Message-ID: <YbZjn0Gla+ugIEk0@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
 <20211209153647.58953-6-jlayton@kernel.org>
 <YbOuhUalMBuTGAGI@sol.localdomain>
 <8c90912c5fd01a713688b1d2523ffe47df747513.camel@kernel.org>
 <YbZT6kXlrVO5doMT@sol.localdomain>
 <cd3ce02be39e073f4a6d0846d2da1ee312e118e0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd3ce02be39e073f4a6d0846d2da1ee312e118e0.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 12, 2021 at 03:38:29PM -0500, Jeff Layton wrote:
> On Sun, 2021-12-12 at 11:56 -0800, Eric Biggers wrote:
> > On Fri, Dec 10, 2021 at 03:40:20PM -0500, Jeff Layton wrote:
> > > On Fri, 2021-12-10 at 11:46 -0800, Eric Biggers wrote:
> > > > On Thu, Dec 09, 2021 at 10:36:16AM -0500, Jeff Layton wrote:
> > > > > ceph_atomic_open needs to be able to call this.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/crypto/fscrypt_private.h | 26 --------------------------
> > > > >  fs/crypto/keysetup.c        | 27 +++++++++++++++++++++++++++
> > > > >  include/linux/fscrypt.h     |  5 +++++
> > > > >  3 files changed, 32 insertions(+), 26 deletions(-)
> > > > 
> > > > What is the use case for this, more precisely?  I've been trying to keep
> > > > filesystems using helper functions like fscrypt_prepare_*() and
> > > > fscrypt_file_open() rather than setting up encryption keys directly, which is a
> > > > bit too low-level to be doing outside of fs/crypto/.
> > > > 
> > > > Perhaps fscrypt_file_open() is what you're looking for here?
> > > 
> > > That doesn't really help because we don't have the inode for the file
> > > yet at the point where we need the key.
> > > 
> > > atomic_open basically does a lookup+open. You give it a directory inode
> > > and a dentry, and it issues an open request by filename. If it gets back
> > > ENOENT then we know that the thing is a negative dentry.
> > > 
> > > In the lookup path, I used __fscrypt_prepare_readdir. This situation is
> > > a bit similar so I might be able to use that instead. OTOH, that doesn't
> > > fail when you don't have the key, and if you don't, there's not a lot of
> > > point in going any further here.
> > 
> > So you're requiring the key on a directory to do a lookup in that directory?
> > Normally that's not required, as files can be looked up by no-key name.  Why is
> > the atomic_open case different? 
> > 
> > The file inode's key is needed to open it, of
> > course, but the directory inode's key shouldn't be needed.  In practice you'll
> > tend to have the key for both or neither inode, but that's not guaranteed.
> > 
> 
> We're issuing an open request to the server without looking up the inode
> first. In order to do that open request, we need to encode a filename
> into the request, and to do that we need the encryption key.

But how is it different from a regular lookup?  Those try to set up the
directory's key, but if it's unavailable, the name being looked up is treated as
a no-key name.  Take a look at fscrypt_prepare_lookup().

- Eric
