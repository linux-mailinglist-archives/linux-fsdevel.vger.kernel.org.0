Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489722632F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgIIQCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 12:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbgIIQCo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:02:44 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1DF220639;
        Wed,  9 Sep 2020 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599667363;
        bh=seCU8tczToRVtjlghBPadKiY1ANUJARi5MpBwKtkOrs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l3dJJng1IEbc/4R0jO8SpNnv5bTxSWbD9EMbz9OE3Sv6xkSNAURk2+Ztweg21mQ+G
         Fskr3JUJgxmEHUdO65S3PUmb8TYmMjIjiwEFLNkt7xQxXrufpcaB0ZHXYjjbeUGeLs
         pJNBbpa0bt1BT+BYSgHWE0M59mlgBdFqv0wczeLA=
Message-ID: <f83c73a44627da462928eb8ebd69e7425cddba26.camel@kernel.org>
Subject: Re: [RFC PATCH v2 06/18] fscrypt: move nokey_name conversion to
 separate function and export it
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Date:   Wed, 09 Sep 2020 12:02:41 -0400
In-Reply-To: <20200908225303.GC3760467@gmail.com>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-7-jlayton@kernel.org>
         <20200908035522.GG68127@sol.localdomain>
         <a4b61098eaacca55e5f455b7c7df05dbc4839d3d.camel@kernel.org>
         <20200908225303.GC3760467@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-09-08 at 15:53 -0700, Eric Biggers wrote:
> On Tue, Sep 08, 2020 at 08:50:04AM -0400, Jeff Layton wrote:
> > > > +EXPORT_SYMBOL(fscrypt_encode_nokey_name);
> > > 
> > > Why does this need to be exported?
> > > 
> > > There's no user of this function introduced in this patchset.
> > > 
> > > - Eric
> > 
> > Yeah, I probably should have dropped this from the series for now as
> > nothing uses it yet, but eventually we may need this. I did a fairly
> > detailed writeup of the problem here:
> > 
> >     https://tracker.ceph.com/issues/47162
> > 
> > Basically, we still need to allow clients to look up dentries in the MDS
> > even when they don't have the key.
> > 
> > There are a couple of different approaches, but the simplest is to just
> > have the client always store long dentry names using the nokey_name, and
> > then keep the full name in a new field in the dentry representation that
> > is sent across the wire.
> > 
> > This requires some changes to the Ceph MDS (which is what that tracker
> > bug is about), and will mean enshrining the nokey name in perpetuity.
> > We're still looking at this for now though, and we're open to other
> > approaches if you've got any to suggest.
> 
> The (persistent) directory entries have to include the full ciphertext
> filenames.  If they only included the no-key names, then it wouldn't always be
> possible to translate them back into the original plaintext filenames.
> 
> It's also required that the filesystem can find a specific directory entry given
> its corresponding no-key name.  For a network filesystem, that can be done
> either on the client (request all filenames in the directory, then check all of
> them...), or on the server (give it the no-key name and have it do the matching;
> it would need to know the specifics of how the no-key names work).
> 
> The no-key names aren't currently stable, and it would be nice to keep them that
> way since we might want to improve how they work later.  But if you need to
> stabilize a version of the no-key name format for use in the ceph protocol so
> that the server can do the matching, it would be possible to do that.  It
> wouldn't even necessarily have to be what fscrypt currently uses; e.g. if it
> were to simplify things a lot for you to simply use SHA-256(ciphertext_name)
> instead of the current 'struct fscrypt_nokey_name', you could do that.
> 

(cc'ing Xiubo since he's working on the MDS part)

We probably will need to make a stable representation. I think the nokey
name scheme as it stands would be fine for this purpose, particularly as
the representation is only different for really long filenames. We'd
only need to carry an alternate name for dentries with names longer than
~150 chars, and those are somewhat rare.

Much of this depends on the MDS though, and I'm a lot less familiar with
that part. So for now, no need to do anything. We'll reach out once we
have a more solid plan of how we want to handle this.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

