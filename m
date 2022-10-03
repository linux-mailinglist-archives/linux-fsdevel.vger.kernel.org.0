Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEF95F3968
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJCW46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJCW45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:56:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCAB31373;
        Mon,  3 Oct 2022 15:56:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC70821902;
        Mon,  3 Oct 2022 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664837813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1nQZ58TJ+GEmzZcpyTOK5ayREv1t5fIjSbrNpFEZ4o=;
        b=yimo5/6EB/XmhspbZuEjyIRw3HYb3bw8toqAtzev2eUQkTn/03jPZw7eZ/PQk4+m4i7XKR
        /P7hp7Rh9MPX3ISKaj08hoFSFB5nZGLSrQZAQ0tf7AriKJ34pb0PaXqYz68VYIIXSXFXHU
        A8NmMmj/VcMLYYmVhJTBBt+nwRVmZBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664837813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1nQZ58TJ+GEmzZcpyTOK5ayREv1t5fIjSbrNpFEZ4o=;
        b=jrlkmi0B7QBCeHc3w4JoJ77FztOga2B/4GULpyIMCqDJyJ85OhF+N3KBk6kStvshIiqYZK
        R0gpizHBYQ/QCNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E65291332F;
        Mon,  3 Oct 2022 22:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id geubJ65oO2NBDwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 22:56:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 8/9] vfs: update times after copying data in
 __generic_file_write_iter
In-reply-to: <CAOQ4uxi6pPDexF7Z1wshnpV0kbSKsHUeawaUkhjq4FNGbqWU+A@mail.gmail.com>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-9-jlayton@kernel.org>,
 <CAOQ4uxgofERYwN7AfYFWqQMpQH5y3LV+6UuGfjU29gZXNf7-vQ@mail.gmail.com>,
 <df91b9ec61bc49aa5330714e3319dcea2531953b.camel@kernel.org>,
 <CAOQ4uxi6pPDexF7Z1wshnpV0kbSKsHUeawaUkhjq4FNGbqWU+A@mail.gmail.com>
Date:   Tue, 04 Oct 2022 09:56:42 +1100
Message-id: <166483780286.14457.1388505585556274283@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 04 Oct 2022, Amir Goldstein wrote:
> On Mon, Oct 3, 2022 at 4:01 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Sun, 2022-10-02 at 10:08 +0300, Amir Goldstein wrote:
> > > On Fri, Sep 30, 2022 at 2:30 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > >
> > > > The c/mtime and i_version currently get updated before the data is
> > > > copied (or a DIO write is issued), which is problematic for NFS.
> > > >
> > > > READ+GETATTR can race with a write (even a local one) in such a way as
> > > > to make the client associate the state of the file with the wrong cha=
nge
> > > > attribute. That association can persist indefinitely if the file sees=
 no
> > > > further changes.
> > > >
> > > > Move the setting of times to the bottom of the function in
> > > > __generic_file_write_iter and only update it if something was
> > > > successfully written.
> > > >
> > >
> > > This solution is wrong for several reasons:
> > >
> > > 1. There is still file_update_time() in ->page_mkwrite() so you haven't
> > >     solved the problem completely
> >
> > Right. I don't think there is a way to solve the problem vs. mmap.
> > Userland can write to a writeable mmap'ed page at any time and we'd
> > never know. We have to specifically carve out mmap as an exception here.
> > I'll plan to add something to the manpage patch for this.
> >
> > > 2. The other side of the coin is that post crash state is more likely t=
o end
> > >     up data changes without mtime/ctime change
> > >
> >
> > Is this really something filesystems rely on? I suppose the danger is
> > that some cached data gets written to disk before the write returns and
> > the inode on disk never gets updated.
> >
> > But...isn't that a danger now? Some of the cached data could get written
> > out and the updated inode just never makes it to disk before a crash
> > (AFAIU). I'm not sure that this increases our exposure to that problem.
> >
> >
>=20
> You are correct that that danger exists, but it only exists for overwriting
> to allocated blocks.
>=20
> For writing to new blocks, mtime change is recorded in transaction
> before the block mapping is recorded in transaction so there is no
> danger in this case (before your patch).
>=20
> Also, observing size change without observing mtime change
> after crash seems like a very bad outcome that may be possible
> after your change.
>=20
> These are just a few cases that I could think of, they may be filesystem
> dependent, but my gut feeling is that if you remove the time update before
> the operation, that has been like that forever, a lot of s#!t is going to f=
loat
> for various filesystems and applications.
>=20
> And it is not one of those things that are discovered  during rc or even
> stable kernel testing - they are discovered much later when users start to
> realize their applications got bogged up after crash, so it feels like to me
> like playing with fire.
>=20
> > > If I read the problem description correctly, then a solution that inval=
idates
> > > the NFS cache before AND after the write would be acceptable. Right?
> > > Would an extra i_version bump after the write solve the race?
> > >
> >
> > I based this patch on Neil's assertion that updating the time before an
> > operation was pointless if we were going to do it afterward. The NFS
> > client only really cares about seeing it change after a write.
> >
>=20
> Pointless to NFS client maybe.
> Whether or not this is not changing user behavior for other applications
> is up to you to prove and I doubt that you can prove it because I doubt
> that it is true.
>=20
> > Doing both would be fine from a correctness standpoint, and in most
> > cases, the second would be a no-op anyway since a query would have to
> > race in between the two for that to happen.
> >
> > FWIW, I think we should update the m/ctime and version at the same time.
> > If the version changes, then there is always the potential that a timer
> > tick has occurred. So, that would translate to a second call to
> > file_update_time in here.
> >
> > The downside of bumping the times/version both before and after is that
> > these are hot codepaths, and we'd be adding extra operations there. Even
> > in the case where nothing has changed, we'd have to call
> > inode_needs_update_time a second time for every write. Is that worth the
> > cost?
>=20
> Is there a practical cost for iversion bump AFTER write as I suggested?
> If you NEED m/ctime update AFTER write and iversion update is not enough
> then I did not understand from your commit message why that is.
>=20
> Thanks,
> Amir.
>=20

Maybe we should split i_version updates from ctime updates.

While it isn't true that ctime updates have happened before the write
"forever" it has been true since 2.3.43[1] which is close to forever.

For ctime there doesn't appear to be a strong specification of when the
change happens, so history provides a good case for leaving it before.
For i_version we want to provide clear and unambiguous semantics.
Performing 2 updates makes the specification muddy.

So I would prefer a single update for i_version, performed after the
change becomes visible.  If that means it has to be separate from ctime,
then so be it.

NeilBrown


[1]:  https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/com=
mit/?id=3D636b38438001a00b25f23e38747a91cb8428af29
