Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F805A325D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 01:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbiHZXHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 19:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345469AbiHZXHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:07:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C950EA15E;
        Fri, 26 Aug 2022 16:06:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7704F1F9AA;
        Fri, 26 Aug 2022 23:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661555217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9A0c2a3LCJ9HJ4RB1nSEWfMe03bJHyDrZPgEaaTEYc=;
        b=INqbeFj3w2PzH1oF+OZJpFIvoUFqm1RVyKKo5LXy/H0mMWfs+cr4E5Kb521FCR6ButT2HE
        XoxSEZ3kRwmNKABcz3C/2+JUAng99Xo3RjdLJU+w6GNF1NeNcAw7GNGvW7GuON0kkIskNG
        Y4QJTey76ikAMYV2mZo6Pd5ufPf+MV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661555217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9A0c2a3LCJ9HJ4RB1nSEWfMe03bJHyDrZPgEaaTEYc=;
        b=Ck47smO+LzO+yoZ5LmCawuaiW47mp3isxzMgPSMeB7m75ceiKfdcX0prCboyj5Vk3A6Xh+
        iVioxUaSV5z+7kAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F05A013421;
        Fri, 26 Aug 2022 23:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VZZiKg5SCWOhcAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 23:06:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Daire Byrne" <daire@dneg.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
In-reply-to: <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984370.25420.13019217727422217511.stgit@noble.brown>,
 <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
Date:   Sat, 27 Aug 2022 09:06:51 +1000
Message-id: <166155521174.27490.456427475820966571@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022, Linus Torvalds wrote:
> On Thu, Aug 25, 2022 at 7:16 PM NeilBrown <neilb@suse.de> wrote:
> >
> > If a filesystem supports parallel modification in directories, it sets
> > FS_PAR_DIR_UPDATE on the file_system_type.  lookup_open() and the new
> > lookup_hash_update() notice the flag and take a shared lock on the
> > directory, and rely on a lock-bit in d_flags, much like parallel lookup
> > relies on DCACHE_PAR_LOOKUP.
>=20
> Ugh.

Thanks :-) - no, really - thanks for the high-level review!

>=20
> I absolutely believe in the DCACHE_PAR_LOOKUP model, and in "parallel
> updates" being important, but I *despise* locking code like this
>=20
> +       if (wq && IS_PAR_UPDATE(dir))
> +               inode_lock_shared_nested(dir, I_MUTEX_PARENT);
> +       else
> +               inode_lock_nested(dir, I_MUTEX_PARENT);
>=20
> and I really really hope there's some better model for this.
>=20
> That "wq" test in particular is just absolutely disgusting. So now it
> doesn't just depend on whether the directory supports parallel
> updates, now the caller can choose whether to do the parallel thing or
> not, and that's how "create" is different from "rename".

As you note, by the end of the series "create" is not more different
from "rename" than it already is.  I only broke up the patches to make
review more manageable.

The "wq" can be removed.  There are two options.
One is to change every kern_path_create() or user_path_create() caller
to passed in a wq.  Then we can assume that a wq is always available.
There are about a dozen of these calls, so not an enormous change, but
one that I didn't want to think about just yet.  I could add a patch at
the front of the series which did this.

Alternate option is to never pass in a wq for create operation, and use
var_waitqueue() (or something similar) to provide a global shared wait
queue (which is essentially what I am using to wait for
DCACHE_PAR_UPDATE to clear).
The more I think about it, the more I think this is the best way
forward.   Maybe we'll want to increase WAIT_TABLE_BITS ... I wonder how
to measure how much contention there is on these shared queues.

>=20
> And that last difference is, I think, the one that makes me go "No. HELL NO=
".
>=20
> Instead of it being up to the filesystem to say "I can do parallel
> creates, but I need to serialize renames", this whole thing has been
> set up to be about the caller making that decision.

I think that is a misunderstanding.  The caller isn't making a decision
- except the IS_PAR_UPDATE() test which is simply acting on the fs
request.  What you are seeing is a misguided attempt to leave in place
some existing interfaces which assumed exclusive locking and didn't
provide wqs.

>=20
> That's just feels horribly horribly wrong.
>=20
> Yes, I realize that to you that's just a "later patches will do
> renames", but what if it really is a filesystem issue where the
> filesystem can easily handle new names, but needs something else for
> renames because it has various cross-directory issues, perhaps?

Obviously a filesystem can add its own locking - and they will have to,
though at a finer grain that the VFS can do.


>=20
> So I feel this is fundamentally wrong, and this ugliness is a small
> effect of that wrongness.
>=20
> I think we should strive for
>=20
>  (a) make that 'wq' and DCACHE_PAR_LOOKUP bit be unconditional

Agreed (in an earlier version DCACHE_PAR_LOOKUP was optional, but I
realised that you wouldn't like that :-)

>=20
>  (b) aim for the inode lock being taken *after* the _lookup_hash(),
> since the VFS layer side has to be able to handle the concurrency on
> the dcache side anyway

I think you are suggesting that we change ->lookup call to NOT
require i_rwsem be held.  That is not a small change.
I agree that it makes sense in the long term.  Getting there ....  won't
be a quick as I'd hoped.

>=20
>  (c) at that point, the serialization really ends up being about the
> call into the filesystem, and aim to simply move the
> inode_lock{_shared]_nested() into the filesystem so that there's no
> need for a flag and related conditional locking at all.

It might be nice to take a shared lock in VFS, and let the FS upgrade it
to exclusive if needed, but we don't have upgrade_read() ...  maybe it
would be deadlock-prone.

>=20
> Because right now I think the main reason we cannot move the lock into
> the filesystem is literally that we've made the lock cover not just
> the filesystem part, but the "lookup and create dentry" part too.
>=20
> But once you have that "DCACHE_PAR_LOOKUP" bit and the
> d_alloc_parallel() logic to serialize a _particular_ dentry being
> created (as opposed to serializing all the sleeping ops to that
> directly), I really think we should strive to move the locking - that
> no longer helps the VFS dcache layer - closer to the filesystem call
> and eventually into it.
>=20
> Please? I think these patches are "mostly going in the right
> direction", but at the same time I feel like there's some serious
> mis-design going on.

Hmmm....  I'll dig more deeply into ->lookup and see if I can understand
the locking well enough to feel safe removing i_rwsem from it.

Thanks,
NeilBrown
