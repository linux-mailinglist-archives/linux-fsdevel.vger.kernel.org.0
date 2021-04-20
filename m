Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38B365CAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhDTPwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 11:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232835AbhDTPwl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB2D61003;
        Tue, 20 Apr 2021 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618933929;
        bh=/9RTrlVPmficjxGArbdNAYfmgxMyr7ATcSTXhbbHiIE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uGmEWDazCC/j77pAB4CUd1BwGvnHSfWNk1cwVbYH1MYKI+5OiWL1t7+CipKyBXILX
         B4gpGxdwET1IdALTdfGFQfhsdNpnlpfazKSQLx8Fhyj5qgl3Hn3N4xbnCB68xs3nSl
         UeeiH238vHp1DXH5I+ugWvaJRl2kEsyF6Vwt4N5BqHHm/HH4qLPuon/9vhkvszM4ym
         c5OPtOKdIhWzd65piG8AHChiXfNp6OlLq3whVmBRjOSoxrGk+l8ovQW1zj9Q12fsFr
         cuMrmncdrXyOYkKgGg6OFs0V66Y4iM9ZxrE0TUMrC92wCBHr3CjP2NQPFmZe1eu26D
         raQJOXtSNQalw==
Message-ID: <53d5bebb28c1e0cd354a336a56bf103d5e3a6344.camel@kernel.org>
Subject: Re: [RFC PATCH v6 00/20] ceph+fscrypt: context, filename and
 symlink support
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Tue, 20 Apr 2021 11:52:07 -0400
In-Reply-To: <87sg3ll0zm.fsf@suse.de>
References: <20210413175052.163865-1-jlayton@kernel.org>
         <87h7k2murr.fsf@suse.de>
         <e411e914cd2d329e4b0e335968c21ba85f6e89c7.camel@kernel.org>
         <871rb6mfch.fsf@suse.de>
         <13750c0b72dccd84e75179d62e9a9038d6f57371.camel@kernel.org>
         <87sg3ll0zm.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-20 at 11:11 +0100, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > On Mon, 2021-04-19 at 17:03 +0100, Luis Henriques wrote:
> > > Jeff Layton <jlayton@kernel.org> writes:
> > > 
> > > > On Mon, 2021-04-19 at 11:30 +0100, Luis Henriques wrote:
> > > ...
> > > > Ouch. That looks like a real bug, alright.
> > > > 
> > > > Basically when building the path, we occasionally need to fetch the
> > > > crypto context for parent inodes and such, and that can cause us to
> > > > recurse back into __ceph_getxattr and try to issue another RPC to the
> > > > MDS.
> > > > 
> > > > I'll have to look and see what we can do. Maybe it's safe to drop the
> > > > mdsc->mutex while we're building the path? Or maybe this is a good time
> > > > to re-think a lot of the really onerous locking in this codepath?
> > > > 
> > > > I'm open to suggestions here...
> > > 
> > > Yeah, I couldn't see a good fix at a first glace.  Dropping the mutex
> > > while building the path was my initial thought too but it's not easy to
> > > proof that's a safe thing to do.
> > > 
> > 
> > Indeed. It's an extremely coarse-grained mutex and not at all clear what
> > it protects here.
> > 
> > > The other idea I had was to fetch all the needed fscrypt contexts at the
> > > end, after building the path.  But I didn't found a way for doing that
> > > because to build the path... we need the contexts.
> > > 
> > > It looks like this leaves us with the locking rethinking option.
> > > 
> > > /me tries harder to find another way out
> > > 
> > > Cheers,
> > 
> > The other option I think is to not store the context in an xattr at all,
> > and instead make a dedicated field in the inode for it that we can
> > ensure is always present for encrypted inodes.  For the most part the
> > crypto context is a static thing. The only exception is when we're first
> > encrypting an empty dir.
> > 
> > We already have the fscrypt bool in the inodestat, and we're going to
> > need another field to hold the real size for files. It may be worthwhile
> > to just reconsider the design at that level. Maybe we just need to carve
> > out a chunk of fscrypt space in the inode for the client and let it
> > manage that however it sees fit.
> 
> That's another solution.  Since the initial (naïfe) idea of having a
> client-only implementation with fscrypt-agnostic MDSs is long gone, the
> design can (still) be fixed to do that.  This will definitely allow to
> move forward with the fscrypt implementation.  (But we'll probably be
> bitten again with these recursive RPCs in the future!)
> 
> Anyway, this is probably the most interesting solution as it also reduces
> the need for extra calls to MDS.  And the fscrypt bool in inodestat
> probably becomes redundant and can be dropped.
> 

We probably can't drop the bool from the protocol, as it's now in a
released version (Pacific).

What we can do is drop tracking the bool internally in the MDS, and just
set that to true if the fscrypt blob isn't zero-length.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

