Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BA26C6CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgIPSE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbgIPSE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:04:26 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1120E20838;
        Wed, 16 Sep 2020 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600279465;
        bh=xJS8bPEEzxIt3ZjkikKCGLtOohy45MZMRzV6dz3m3b8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e+49THwolO6g3wzGTt6OBOVR3JXdItJWthPKOZfFdScwIDkc55FVIcM66ZZIUNplU
         7rZmybUdaj0BoSny8JgemMWzZq3nam4rkIcnDXqUSBEZRZvaeHxitPMM9tUOCD43Jx
         7f6KF6cUDTBuBrsRrhijn806hEVHi45QX9Xyk/Zk=
Message-ID: <a96c5d949556cc43e80858a166f2e837268bb079.camel@kernel.org>
Subject: Re: [RFC PATCH v3 12/16] ceph: add encrypted fname handling to
 ceph_mdsc_build_path
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Date:   Wed, 16 Sep 2020 14:04:23 -0400
In-Reply-To: <20200916173603.GA4373@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-13-jlayton@kernel.org>
         <20200915014159.GK899@sol.localdomain>
         <bd9257732cfd98ee30ccc151125d21d6955d6f66.camel@kernel.org>
         <20200916173603.GA4373@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-16 at 10:36 -0700, Eric Biggers wrote:
> On Wed, Sep 16, 2020 at 08:30:01AM -0400, Jeff Layton wrote:
> > It sounds like we'll probably need to stabilize some version of the
> > nokey name so that we can allow the MDS to look them up. Would it be a
> > problem for us to use the current version of the nokey name format for
> > this, or would it be better to come up with some other distinct format
> > for this?
> > 
> 
> You could use the current version, with the dirhash field changed from u32 to
> __le32 so that it doesn't depend on CPU endianness.  But you should also
> consider using just base64(SHA256(filename)).  The SHA256(filename) approach
> wouldn't include a dirhash, and it would handle short filenames less
> efficiently.  However, it would be simpler.  Would it be any easier for you?
> 
> I'm not sure which would be better from a fs/crypto/ perspective.  For *now*, it
> would be easier if you just used the current 'struct fscrypt_nokey_name'.
> However, anything you use would be set in stone, whereas as-is the format can be
> changed at any time.  In fact, we changed it recently; see commit edc440e3d27f.
> 
> If we happen to change the nokey name in the future for local filesystems (say,
> to use BLAKE2 instead of SHA256, or to support longer dirhashes), then it would
> be easier if the stable format were just SHA256(filename).
> 
> It's not a huge deal though.  So if e.g. you like that the current format avoids
> the cryptographic hash for the vast majority of filenames, and if you're fine
> with the slightly increased complexity, you can just use it.
> 

The problem with using a different scheme from the presentation format
is this:

Suppose I don't have the key for a directory and do a readdir() in
there, and get back a nokey name with the hash at the end. A little
while later, the dentry gets evicted from the cache.

Userland then comes back and wants to do something with that dentry
(maybe an unlink or stat). Now I have to look it up. At that point, I
don't really have a way to resolve that on the client [1]. I have to ask
the server to do it. What do I ask it to look up?

Storing the stable format as a full SHA256 hash of the name is
problematic as I don't think we can convert the nokey name to it
directly (can we?).

If we store the current nokey format (or some variant of it that doesn't
include the dirhash fields) then we should be able to look up the
dentry, even when we don't have complete dir contents.
-- 
Jeff Layton <jlayton@kernel.org>

[1]: ok, technically we could do a readdir in the directory and try to
match the nokey name by deriving them from the full crypttext, but
that's potentially _very_ expensive if the dir is large.



