Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3623655E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDTKKP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 06:10:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhDTKKN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:10:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DB31AF1E;
        Tue, 20 Apr 2021 10:09:41 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id d6298104;
        Tue, 20 Apr 2021 10:11:10 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v6 00/20] ceph+fscrypt: context, filename and
 symlink support
References: <20210413175052.163865-1-jlayton@kernel.org>
        <87h7k2murr.fsf@suse.de>
        <e411e914cd2d329e4b0e335968c21ba85f6e89c7.camel@kernel.org>
        <871rb6mfch.fsf@suse.de>
        <13750c0b72dccd84e75179d62e9a9038d6f57371.camel@kernel.org>
Date:   Tue, 20 Apr 2021 11:11:09 +0100
In-Reply-To: <13750c0b72dccd84e75179d62e9a9038d6f57371.camel@kernel.org> (Jeff
        Layton's message of "Mon, 19 Apr 2021 12:28:10 -0400")
Message-ID: <87sg3ll0zm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Mon, 2021-04-19 at 17:03 +0100, Luis Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > On Mon, 2021-04-19 at 11:30 +0100, Luis Henriques wrote:
>> ...
>> > Ouch. That looks like a real bug, alright.
>> > 
>> > Basically when building the path, we occasionally need to fetch the
>> > crypto context for parent inodes and such, and that can cause us to
>> > recurse back into __ceph_getxattr and try to issue another RPC to the
>> > MDS.
>> > 
>> > I'll have to look and see what we can do. Maybe it's safe to drop the
>> > mdsc->mutex while we're building the path? Or maybe this is a good time
>> > to re-think a lot of the really onerous locking in this codepath?
>> > 
>> > I'm open to suggestions here...
>> 
>> Yeah, I couldn't see a good fix at a first glace.  Dropping the mutex
>> while building the path was my initial thought too but it's not easy to
>> proof that's a safe thing to do.
>> 
>
> Indeed. It's an extremely coarse-grained mutex and not at all clear what
> it protects here.
>
>> The other idea I had was to fetch all the needed fscrypt contexts at the
>> end, after building the path.  But I didn't found a way for doing that
>> because to build the path... we need the contexts.
>> 
>> It looks like this leaves us with the locking rethinking option.
>> 
>> /me tries harder to find another way out
>> 
>> Cheers,
>
> The other option I think is to not store the context in an xattr at all,
> and instead make a dedicated field in the inode for it that we can
> ensure is always present for encrypted inodes.  For the most part the
> crypto context is a static thing. The only exception is when we're first
> encrypting an empty dir.
>
> We already have the fscrypt bool in the inodestat, and we're going to
> need another field to hold the real size for files. It may be worthwhile
> to just reconsider the design at that level. Maybe we just need to carve
> out a chunk of fscrypt space in the inode for the client and let it
> manage that however it sees fit.

That's another solution.  Since the initial (naïfe) idea of having a
client-only implementation with fscrypt-agnostic MDSs is long gone, the
design can (still) be fixed to do that.  This will definitely allow to
move forward with the fscrypt implementation.  (But we'll probably be
bitten again with these recursive RPCs in the future!)

Anyway, this is probably the most interesting solution as it also reduces
the need for extra calls to MDS.  And the fscrypt bool in inodestat
probably becomes redundant and can be dropped.

Cheers,
-- 
Luis
