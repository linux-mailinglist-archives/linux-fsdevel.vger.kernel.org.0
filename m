Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964565A326D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 01:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbiHZXNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 19:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345436AbiHZXNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:13:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81048E9A82;
        Fri, 26 Aug 2022 16:13:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 366F81F96A;
        Fri, 26 Aug 2022 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661555617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xt0Q4IRVHSzXSXE2NSGFAeVOXbQKTW+E51j3iUdKPtg=;
        b=wMmrxaNN6VNTFLsm4mw3dSbErGnHcZtR+8ztDC39dGs2zT7yu2s9U8uedPts4TwrtRdvh5
        lRx6ylVLtvwaj3FjRseKU5FK7DaQCK3V3opkzxHFkj2OGVHE3fbSGRe9O9eVDKegiidXP0
        m/FG8h1TFYUFUDNB+s0yVN3wzfr0zmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661555617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xt0Q4IRVHSzXSXE2NSGFAeVOXbQKTW+E51j3iUdKPtg=;
        b=vnrUFOTy/JEzMPNZ+BsjtyYMeBxAgbaU5yMyZ2A30Fk/3oHXvkHqitNvAUi5DDNHvGdR3T
        JakEYX62pgpdq0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A61813421;
        Fri, 26 Aug 2022 23:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id riq6DZ5TCWOCcgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 23:13:34 +0000
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
Subject: Re: [PATCH 10/10] NFS: support parallel updates in the one directory.
In-reply-to: <25352.59221.528023.534884@quad.stoffel.home>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984378.25420.4023980607067991846.stgit@noble.brown>,
 <25352.59221.528023.534884@quad.stoffel.home>
Date:   Sat, 27 Aug 2022 09:13:31 +1000
Message-id: <166155561138.27490.7464518594320056247@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022, John Stoffel wrote:
> >>>>> "NeilBrown" =3D=3D NeilBrown  <neilb@suse.de> writes:
>=20
> NeilBrown> NFS can easily support parallel updates as the locking is done o=
n the
> NeilBrown> server, so this patch enables parallel updates for NFS.
>=20
> Just curious, how is this handled if I have a server with an EXT#
> filesystem which is exported via NFS to multiple clients.  If those
> NFS clients are doing lots of changes in a single directory, I can see
> how the NFS server handles that, but what about if at the same time
> someone does multiple changes on the server in that EXT# behind the
> NFSd's back, how are the conflicts handled?

Currently, an exclusive lock is taken by the VFS or NFSD before any
create request gets the the EXT# filesystem.  That doesn't change (yet).

When multiple NFS clients try the create files in a directory, the nfsd
threads handling those requests will be serialized by the exclusive
lock.

Before the patch, if there were multiple threads on a single NFS client,
then they are all serialized on the client, and then again on the
server.
With my patch, the threads on the one client are NOT serialized, but
once the requests get to the server they will be.  So an exclusive lock
is only held of a smaller part of the total time.

>=20
> It would seem that this all really needs to purely happen at the VFS
> layer, but I'm probably missing something.

Serialization has to happen somewhere.  It doesn't have to be at the VFS
layer.  Doing locking at the VFS layer is easy and slow.  Doing it deep
in the filesystem is difficult and fast.  This exercise is really just
pushing locking deeper into the filesystem.

>=20
> I ask this because my home server exports /home to a couple of other
> systems via NFS, but I still work in /home on the server. =20
>=20

Thanks,
NeilBrown
