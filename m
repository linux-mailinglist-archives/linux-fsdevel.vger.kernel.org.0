Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BBA55F320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 04:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiF2CHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 22:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF2CHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:07:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293131506
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 19:07:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71C1C21EAF;
        Wed, 29 Jun 2022 02:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656468431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YM5kdckk31CXnoyZKaHPmyyZLTRX7jHEzJAKxKUQzso=;
        b=hdl3GMPYQzIxAnvZmNnD0UwCRNISLZ7Eu+CHloXNC/rqXQTMg9Ux+PaK0JW4F8d16B1Z4g
        9aNKbKxpZ9z2DpsFwdPGmU7gDZfK1oCa3BTXgUzQP/WX8dI7FUXHDy4C+ncXhKr2wn0RE2
        PY2s8EcosmGqZqrS+iTxsU5eU0CHcdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656468431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YM5kdckk31CXnoyZKaHPmyyZLTRX7jHEzJAKxKUQzso=;
        b=44V6cMqEU1SHgndsw4lsZ+zW22IxW0/o6ffSJeZKDzEWC3GAENYIisOc65sId755NvtWY5
        mSZVaauImWy2mLBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFD5C13322;
        Wed, 29 Jun 2022 02:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3axXHs2zu2IJXgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 29 Jun 2022 02:07:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "James Yonan" <james@openvpn.net>,
        "Amir Goldstein" <amir73il@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
In-reply-to: <20220629014323.GM1098723@dread.disaster.area>
References: <20220627221107.176495-1-james@openvpn.net>,
 <Yrs7lh6hG44ERoiM@ZenIV>,
 <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>,
 <03ee39fa-7cfd-5155-3559-99ec8c8a2d32@openvpn.net>,
 <20220629014323.GM1098723@dread.disaster.area>
Date:   Wed, 29 Jun 2022 12:07:04 +1000
Message-id: <165646842481.15378.14054777682756518611@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jun 2022, Dave Chinner wrote:
> On Tue, Jun 28, 2022 at 05:19:12PM -0600, James Yonan wrote:
> > On 6/28/22 12:34, Amir Goldstein wrote:
> > > On Tue, Jun 28, 2022 at 8:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > On Mon, Jun 27, 2022 at 04:11:07PM -0600, James Yonan wrote:
> > > >=20
> > > > >            && d_is_positive(new_dentry)
> > > > >            && timespec64_compare(&d_backing_inode(old_dentry)->i_mt=
ime,
> > > > >                                  &d_backing_inode(new_dentry)->i_mt=
ime) <=3D 0)
> > > > >                goto exit5;
> > > > >=20
> > > > > It's pretty cool in a way that a new atomic file operation can even=
 be
> > > > > implemented in just 5 lines of code, and it's thanks to the existing
> > > > > locking infrastructure around file rename/move that these operations
> > > > > become almost trivial.  Unfortunately, every fs must approve a new
> > > > > renameat2() flag, so it bloats the patch a bit.
> > > > How is it atomic and what's to stabilize ->i_mtime in that test?
> > > > Confused...
> > > Good point.
> > > RENAME_EXCHANGE_WITH_NEWER would have been better
> > > in that regard.
> > >=20
> > > And you'd have to check in vfs_rename() after lock_two_nondirectories()
> >=20
> > So I mean atomic in the sense that you are comparing the old and new mtim=
es
> > inside the lock_rename/unlock_rename critical section in do_renameat2(), =
so
>=20
> mtime is not stable during rename, even with the inode locked. e.g. a
> write page fault occurring concurrently with rename will change
> mtime, and so which inode is "newer" can change during the rename
> syscall...

I don't think that is really important for the proposed use case.
In any case where you might be using this new rename flag, the target
file wouldn't be open for write, so the mtime wouldn't change.
The atomicity is really wanted to make sure the file at the destination
name is still the one that was expected (I think).

So I think it would be reasonable for the rename to fail if the target
file (or even "either file") is open for write.  Can that change while
the inode is locked?

It would be nice if renameat2 took a third fd so we could say "only
rename if <this> is the target file", but it doesn't.

NeilBrown
