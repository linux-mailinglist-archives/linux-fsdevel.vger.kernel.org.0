Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D695B7DAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 01:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIMXwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 19:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIMXwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:52:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273E55AA34
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 16:52:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BD053445A;
        Tue, 13 Sep 2022 23:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663113162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAg9P1baUpWzyAM6ZRT7r1NDYeLha8V1E6EyQekHdT0=;
        b=PGuxkUkhbF/XdgosVks2f5eF3JFFahgkwPRAXuIiTybi85jOAVpqPjDRbE2xGi3gEUUM6Y
        BtY2ZBjYhBXp4G3+l5jjcnjTxcVTZAfhCahIACa6emYBo0VpVPi/HZHruZKJYv8qPizE6k
        QgTVTjKv2gmNXHRD+UxtR6nTcFGLzr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663113162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAg9P1baUpWzyAM6ZRT7r1NDYeLha8V1E6EyQekHdT0=;
        b=Wbn9CHQ4bfjnoqGdGEWB0YRKGUIygpM5H91a+fMYxUpbhpI85WNERe1gZlS7TVDd2PgAaE
        QKvXBp4IVo7EGKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3E5913AB5;
        Tue, 13 Sep 2022 23:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SjM1KcgXIWNvbQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 13 Sep 2022 23:52:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Miklos Szeredi" <mszeredi@redhat.com>,
        "Xavier Roche" <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
In-reply-to: <YyATCgxi9Ovi8mYv@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>,
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>,
 <YyATCgxi9Ovi8mYv@ZenIV>
Date:   Wed, 14 Sep 2022 09:52:37 +1000
Message-id: <166311315747.20483.5039023553379547679@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Sep 2022, Al Viro wrote:
> On Tue, Sep 13, 2022 at 02:41:51PM +1000, NeilBrown wrote:
> > On Mon, 21 Feb 2022, Miklos Szeredi wrote:
> > > There has been a longstanding race condition between rename(2) and link=
(2),
> > > when those operations are done in parallel:
> > >=20
> > > 1. Moving a file to an existing target file (eg. mv file target)
> > > 2. Creating a link from the target file to a third file (eg. ln target
> > >    link)
> > >=20
> > > By the time vfs_link() locks the target inode, it might already be unli=
nked
> > > by rename.  This results in vfs_link() returning -ENOENT in order to
> > > prevent linking to already unlinked files.  This check was introduced in
> > > v2.6.39 by commit aae8a97d3ec3 ("fs: Don't allow to create hardlink for
> > > deleted file").
> > >=20
> > > This breaks apparent atomicity of rename(2), which is described in
> > > standards and the man page:
> > >=20
> > >     "If newpath already exists, it will be atomically replaced, so that
> > >      there is no point at which another process attempting to access
> > >      newpath will find it missing."
> > >=20
> > > The simplest fix is to exclude renames for the complete link operation.
> >=20
> > Alternately, lock the "from" directory as well as the "to" directory.
> > That would mean using lock_rename() and generally copying the structure
> > of do_renameat2() into do_linkat()
>=20
> Ever done cp -al?  Cross-directory renames are relatively rare; cross-direc=
tory
> links can be fairly heavy on some payloads, and you'll get ->s_vfs_rename_m=
utex
> held a _lot_.

As long as the approach is correct, it might be a good starting point
for optimisation.

We only need s_vfs_rename_mutex for link() so that we can reliably
determine any parent/child relationship to get correct lock ordering to
avoid deadlocks.  So if we use trylock on the second lock and succeed
then we don't need the mutex at all.
e.g.
 - lookup the parents of both paths.
 - lock the "to" directory.
 - if the "from" directory is the same, or if a trylock of the from
   directory succeeds, then we have the locks and can perform the
   last component lookup and perform the link without racing with
   rename.=20
 - if the trylock fails, we drop the lock on "to" and use lock_rename().
   We drop the s_vfs_rename_mutex immediately after lock_rename()
   so after the vfs_link() we just unlock both parent directories.

That should avoid the mutex is most cases including "cp -al"

Holding the "from" parent locked means that NFS could safely access the
parent and basename, and send the lookup to the server to reduce the
risk of a rename on one client racing with a link on another client.
NFS doesn't guarantee that would still work (ops in a compound are not
atomic) but it could still help.  And the NFS server is *prevented* from
making the lookup and link atomic.

NeilBrown
