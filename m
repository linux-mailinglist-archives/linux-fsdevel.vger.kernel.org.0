Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61B5A32A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 01:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiHZXaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 19:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZXaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:30:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF614089;
        Fri, 26 Aug 2022 16:30:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CB3F1F8A3;
        Fri, 26 Aug 2022 23:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661556621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unGSz6GeVrKzu8z4US0hp1I7QAv6QVA+9wpL/58ggnY=;
        b=0V1L2YmY/SO4Hg6/P1+TCnDKpYTJ3zE/ceDi2KTgXj9i8srU6zzib2FxWAHBTIDwIJJyWk
        pVHsBDZz+FxMVfjNzStMMzL+h8LmllqfagPM6usVeIIK/UR38FTBFql0aOLiS9BaltRrmD
        h6mxNDs9mXJcwMx5vxU2xFu1W3+WVg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661556621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unGSz6GeVrKzu8z4US0hp1I7QAv6QVA+9wpL/58ggnY=;
        b=XhFNEspwKY6y966OH86b9J1438bnvK8CLtDVQbBYzTesi9pVDPbR5ETZFt3T0gIqH7gAAg
        U5+qhPjhcPakiIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8332C13421;
        Fri, 26 Aug 2022 23:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cLUvD4pXCWMtdwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 23:30:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "John Stoffel" <john@stoffel.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Daire Byrne" <daire@dneg.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/10 v5] Improve scalability of directory operations
In-reply-to: <25352.56248.283092.213037@quad.stoffel.home>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <25352.56248.283092.213037@quad.stoffel.home>
Date:   Sat, 27 Aug 2022 09:30:13 +1000
Message-id: <166155661379.27490.6823575125331418990@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022, John Stoffel wrote:
> >>>>> "NeilBrown" =3D=3D NeilBrown  <neilb@suse.de> writes:
>=20
> NeilBrown> [I made up "v5" - I haven't been counting]
>=20
> My first comments, but I'm not a serious developer...
>=20
> NeilBrown> VFS currently holds an exclusive lock on the directory while mak=
ing
> NeilBrown> changes: add, remove, rename.
> NeilBrown> When multiple threads make changes in the one directory, the con=
tention
> NeilBrown> can be noticeable.
> NeilBrown> In the case of NFS with a high latency link, this can easily be
> NeilBrown> demonstrated.  NFS doesn't really need VFS locking as the server=
 ensures
> NeilBrown> correctness.
>=20
> NeilBrown> Lustre uses a single(?) directory for object storage, and has pa=
tches
> NeilBrown> for ext4 to support concurrent updates (Lustre accesses ext4 dir=
ectly,
> NeilBrown> not via the VFS).
>=20
> NeilBrown> XFS (it is claimed) doesn't its own locking and doesn't need the=
 VFS to
> NeilBrown> help at all.
>=20
> This sentence makes no sense to me... I assume you meant to say "...does
> it's own locking..."

Thanks - you are correct.  "does its own locking".

>=20
> NeilBrown> This patch series allows filesystems to request a shared lock on
> NeilBrown> directories and provides serialisation on just the affected name=
, not the
> NeilBrown> whole directory.  It changes both the VFS and NFSD to use shared=
 locks
> NeilBrown> when appropriate, and changes NFS to request shared locks.
>=20
> Are there any performance results?  Why wouldn't we just do a shared
> locked across all VFS based filesystems? =20

Daire Byrne has done some tests with NFS clients to an NFS server which
re-exports mounts from another server - so there are a couple of levels
of locking that can be removed.  At lease one of these levels has
significant network latency (100ms or so I think) The results are much
what you would expect.  Many more file creations per second are
possible.  15 creates-per-second up to 121 crates-per-second in one
test.
https://lore.kernel.org/linux-nfs/CAPt2mGNjWXad6e7nSUTu=3D0ez1qU1wBNegrntgHKm=
5hOeBs5gQA@mail.gmail.com/


>=20
> NeilBrown> The central enabling feature is a new dentry flag DCACHE_PAR_UPD=
ATE
> NeilBrown> which acts as a bit-lock.  The ->d_lock spinlock is taken to set=
/clear
> NeilBrown> it, and wait_var_event() is used for waiting.  This flag is set =
on all
> NeilBrown> dentries that are part of a directory update, not just when a sh=
ared
> NeilBrown> lock is taken.
>=20
> NeilBrown> When a shared lock is taken we must use alloc_dentry_parallel() =
which
> NeilBrown> needs a wq which must remain until the update is completed.  To =
make use
> NeilBrown> of concurrent create, kern_path_create() would need to be passed=
 a wq.
> NeilBrown> Rather than the churn required for that, we use exclusive lockin=
g when
> NeilBrown> no wq is provided.
>=20
> Is this a per-operation wq or a per-directory wq?  Can there be issues
> if someone does something silly like having 1,000 directories, all of
> which have multiple processes making parallel changes? =20

It is per-operation though I expect to change that to be taken from a
pool for shared work queues.

Workqueues can be shared quite cheaply.  There is spin-lock contention
when multiple threads add/remove waiters to/from the queues.  Having
more queues in a pool than cores, and randomly selecting queues from the
pool can keep that under control.

If there are dozens of waiter of more, then a wakeup might run more
slowly (and hold the lock for longer), but in this case wakeup should be
rare. =20

Most filesystem operations are uncontended at the name level. e.g. it is
rare that two threads will try to create the same name at the same time,
or one looks up a name that another is unlinking it.  These are the only
times that wakeups would happen, so sharing a pool among all filesystem
accesses is unlikely to be a problem.

>=20
> Does it degrade gracefully if a wq can't be allocated? =20

In the current code, the wq is allocated on the stack.  I'm probably
going to change to a global allocation.  In either case, there is no
risk of allocation failure during a filesystem operation.

Thanks for the questions,
NeilBrown


>=20
> NeilBrown> One interesting consequence of this is that silly-rename becomes=
 a
> NeilBrown> little more complex.  As the directory may not be exclusively lo=
cked,
> NeilBrown> the new silly-name needs to be locked (DCACHE_PAR_UPDATE) as wel=
l.
> NeilBrown> A new LOOKUP_SILLY_RENAME is added which helps implement this us=
ing
> NeilBrown> common code.
>=20
> NeilBrown> While testing I found some odd behaviour that was caused by
> NeilBrown> d_revalidate() racing with rename().  To resolve this I used
> NeilBrown> DCACHE_PAR_UPDATE to ensure they cannot race any more.
>=20
> NeilBrown> Testing, review, or other comments would be most welcome,
>=20
>=20
