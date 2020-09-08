Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64812262342
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 00:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIHWxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 18:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgIHWxF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:53:05 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2D72075A;
        Tue,  8 Sep 2020 22:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599605585;
        bh=Y38dsTx+YYbsFpjTlFiu/TesaJEnrwgsIBBnzPqWxpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXa6t6KjWsxxxSsLvp+dduUaxJwBvY0ZgtWqxkAZiZth8WU7xBHwiWdMZZhMXysmK
         jpEVfyfHj+d8xOPqPP9hpq8Uqlbw+Tgj/9g6nXCEmHc+WmcleslEsVzu9BrLWfQj67
         hPPqRehPTaDt/l1TFQz9a38kSNVZi/RZPOlSmU+k=
Date:   Tue, 8 Sep 2020 15:53:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/18] fscrypt: move nokey_name conversion to
 separate function and export it
Message-ID: <20200908225303.GC3760467@gmail.com>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-7-jlayton@kernel.org>
 <20200908035522.GG68127@sol.localdomain>
 <a4b61098eaacca55e5f455b7c7df05dbc4839d3d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4b61098eaacca55e5f455b7c7df05dbc4839d3d.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:50:04AM -0400, Jeff Layton wrote:
> > > +EXPORT_SYMBOL(fscrypt_encode_nokey_name);
> > 
> > Why does this need to be exported?
> > 
> > There's no user of this function introduced in this patchset.
> > 
> > - Eric
> 
> Yeah, I probably should have dropped this from the series for now as
> nothing uses it yet, but eventually we may need this. I did a fairly
> detailed writeup of the problem here:
> 
>     https://tracker.ceph.com/issues/47162
> 
> Basically, we still need to allow clients to look up dentries in the MDS
> even when they don't have the key.
> 
> There are a couple of different approaches, but the simplest is to just
> have the client always store long dentry names using the nokey_name, and
> then keep the full name in a new field in the dentry representation that
> is sent across the wire.
> 
> This requires some changes to the Ceph MDS (which is what that tracker
> bug is about), and will mean enshrining the nokey name in perpetuity.
> We're still looking at this for now though, and we're open to other
> approaches if you've got any to suggest.

The (persistent) directory entries have to include the full ciphertext
filenames.  If they only included the no-key names, then it wouldn't always be
possible to translate them back into the original plaintext filenames.

It's also required that the filesystem can find a specific directory entry given
its corresponding no-key name.  For a network filesystem, that can be done
either on the client (request all filenames in the directory, then check all of
them...), or on the server (give it the no-key name and have it do the matching;
it would need to know the specifics of how the no-key names work).

The no-key names aren't currently stable, and it would be nice to keep them that
way since we might want to improve how they work later.  But if you need to
stabilize a version of the no-key name format for use in the ceph protocol so
that the server can do the matching, it would be possible to do that.  It
wouldn't even necessarily have to be what fscrypt currently uses; e.g. if it
were to simplify things a lot for you to simply use SHA-256(ciphertext_name)
instead of the current 'struct fscrypt_nokey_name', you could do that.

- Eric
