Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14828471CD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhLLT4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 14:56:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53576 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhLLT4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:56:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AEC6B80CEB;
        Sun, 12 Dec 2021 19:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C3AC341C6;
        Sun, 12 Dec 2021 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639338988;
        bh=KOGGsx4RyQodW8+IldIXBrgZnYwoVo+AduzdGZRTPBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvQc2t5AcQmbyPKFybvGu6Q8fhChr6cq9XVUi+FD3YnrAq6FBRYQYX72tCyskF1LQ
         RbIUPx26ToPFe6WQsPJPELA71QqxEOvC6EUM+EoKiXRuYxL/LcHqnWMHiGXLhULdtC
         +FnEjZbNg8HJQSmmFbIx0/QchKy0IjBgkJz25+55ix+21dPUgJMeKfxJlUZbrnHRmv
         6X5iif4ZgmZBbLCrWi5RksYEQ6MVhNZ6NiwefP5pYR74c7/DaNP0KUYeRbJMKSgEj0
         i8XkcY6xI5HT9s8VUMZDMMaJDxWyIDRvzeIPumA859HI4G42wz/cKD7d8Mp3pZQof3
         sK8AfFgnp40Bg==
Date:   Sun, 12 Dec 2021 11:56:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/36] fscrypt: uninline and export fscrypt_require_key
Message-ID: <YbZT6kXlrVO5doMT@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
 <20211209153647.58953-6-jlayton@kernel.org>
 <YbOuhUalMBuTGAGI@sol.localdomain>
 <8c90912c5fd01a713688b1d2523ffe47df747513.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c90912c5fd01a713688b1d2523ffe47df747513.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:40:20PM -0500, Jeff Layton wrote:
> On Fri, 2021-12-10 at 11:46 -0800, Eric Biggers wrote:
> > On Thu, Dec 09, 2021 at 10:36:16AM -0500, Jeff Layton wrote:
> > > ceph_atomic_open needs to be able to call this.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/crypto/fscrypt_private.h | 26 --------------------------
> > >  fs/crypto/keysetup.c        | 27 +++++++++++++++++++++++++++
> > >  include/linux/fscrypt.h     |  5 +++++
> > >  3 files changed, 32 insertions(+), 26 deletions(-)
> > 
> > What is the use case for this, more precisely?  I've been trying to keep
> > filesystems using helper functions like fscrypt_prepare_*() and
> > fscrypt_file_open() rather than setting up encryption keys directly, which is a
> > bit too low-level to be doing outside of fs/crypto/.
> > 
> > Perhaps fscrypt_file_open() is what you're looking for here?
> 
> That doesn't really help because we don't have the inode for the file
> yet at the point where we need the key.
> 
> atomic_open basically does a lookup+open. You give it a directory inode
> and a dentry, and it issues an open request by filename. If it gets back
> ENOENT then we know that the thing is a negative dentry.
> 
> In the lookup path, I used __fscrypt_prepare_readdir. This situation is
> a bit similar so I might be able to use that instead. OTOH, that doesn't
> fail when you don't have the key, and if you don't, there's not a lot of
> point in going any further here.

So you're requiring the key on a directory to do a lookup in that directory?
Normally that's not required, as files can be looked up by no-key name.  Why is
the atomic_open case different?  The file inode's key is needed to open it, of
course, but the directory inode's key shouldn't be needed.  In practice you'll
tend to have the key for both or neither inode, but that's not guaranteed.

- Eric
