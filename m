Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE0475874
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 13:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbhLOMLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 07:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbhLOMLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:11:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39569C061574;
        Wed, 15 Dec 2021 04:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05EC2B81ED1;
        Wed, 15 Dec 2021 12:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6CFC34605;
        Wed, 15 Dec 2021 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639570256;
        bh=RUr2R2zU0BWumOqZBbhXVTmdCKIDr4qHf3j10+W3QmM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OqFHBZyEoazb+Gv7D4V1YwgVXhuE7g9cxLd6bp4b9z3JflMjMuQOtFU+2b5KZzb6G
         3ioeinBgK35Dj8t4772vh3ndr367x2vVM3iqpPT2oAinYW05jJvyzm3EMYimqq3Ys8
         olo4a24SI6jxvkcemZMDA3Fr/ydl0NjfVhxcCIFnC5uf6gDvrQ5ogGvf6CUgXMbJ5J
         oBrAYYowXwSl8Ve8v9k4V8vobWw1bETOGz+Fzl8CCLU+gTYUNDSsEKVlQsiNfcHEdx
         kOzlE8b2/sYt5VI8FiCWDAIz76SXZxIY2TI7wdtAicmtkznE95qlmlKOnYsiFUou98
         ugpuqqyq2HEWw==
Message-ID: <5603ce7c61d9c741cc7c5188424505539cc8ba65.camel@kernel.org>
Subject: Re: [PATCH 05/36] fscrypt: uninline and export fscrypt_require_key
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 15 Dec 2021 07:10:55 -0500
In-Reply-To: <YbZjn0Gla+ugIEk0@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
         <20211209153647.58953-6-jlayton@kernel.org>
         <YbOuhUalMBuTGAGI@sol.localdomain>
         <8c90912c5fd01a713688b1d2523ffe47df747513.camel@kernel.org>
         <YbZT6kXlrVO5doMT@sol.localdomain>
         <cd3ce02be39e073f4a6d0846d2da1ee312e118e0.camel@kernel.org>
         <YbZjn0Gla+ugIEk0@sol.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-12-12 at 13:03 -0800, Eric Biggers wrote:
> On Sun, Dec 12, 2021 at 03:38:29PM -0500, Jeff Layton wrote:
> > On Sun, 2021-12-12 at 11:56 -0800, Eric Biggers wrote:
> > > On Fri, Dec 10, 2021 at 03:40:20PM -0500, Jeff Layton wrote:
> > > > On Fri, 2021-12-10 at 11:46 -0800, Eric Biggers wrote:
> > > > > On Thu, Dec 09, 2021 at 10:36:16AM -0500, Jeff Layton wrote:
> > > > > > ceph_atomic_open needs to be able to call this.
> > > > > > 
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > >  fs/crypto/fscrypt_private.h | 26 --------------------------
> > > > > >  fs/crypto/keysetup.c        | 27 +++++++++++++++++++++++++++
> > > > > >  include/linux/fscrypt.h     |  5 +++++
> > > > > >  3 files changed, 32 insertions(+), 26 deletions(-)
> > > > > 
> > > > > What is the use case for this, more precisely?  I've been trying to keep
> > > > > filesystems using helper functions like fscrypt_prepare_*() and
> > > > > fscrypt_file_open() rather than setting up encryption keys directly, which is a
> > > > > bit too low-level to be doing outside of fs/crypto/.
> > > > > 
> > > > > Perhaps fscrypt_file_open() is what you're looking for here?
> > > > 
> > > > That doesn't really help because we don't have the inode for the file
> > > > yet at the point where we need the key.
> > > > 
> > > > atomic_open basically does a lookup+open. You give it a directory inode
> > > > and a dentry, and it issues an open request by filename. If it gets back
> > > > ENOENT then we know that the thing is a negative dentry.
> > > > 
> > > > In the lookup path, I used __fscrypt_prepare_readdir. This situation is
> > > > a bit similar so I might be able to use that instead. OTOH, that doesn't
> > > > fail when you don't have the key, and if you don't, there's not a lot of
> > > > point in going any further here.
> > > 
> > > So you're requiring the key on a directory to do a lookup in that directory?
> > > Normally that's not required, as files can be looked up by no-key name.  Why is
> > > the atomic_open case different? 
> > > 
> > > The file inode's key is needed to open it, of
> > > course, but the directory inode's key shouldn't be needed.  In practice you'll
> > > tend to have the key for both or neither inode, but that's not guaranteed.
> > > 
> > 
> > We're issuing an open request to the server without looking up the inode
> > first. In order to do that open request, we need to encode a filename
> > into the request, and to do that we need the encryption key.
> 
> But how is it different from a regular lookup?  Those try to set up the
> directory's key, but if it's unavailable, the name being looked up is treated as
> a no-key name.  Take a look at fscrypt_prepare_lookup().
> 

Ok. After looking at this some more, I think you're right. I don't
really need this call in atomic_open at all. I'll plan to just drop this
patch from the series.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
