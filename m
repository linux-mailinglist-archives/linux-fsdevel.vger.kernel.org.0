Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6B7985B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbjIHKW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbjIHKWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:22:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32102114;
        Fri,  8 Sep 2023 03:21:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98E171FD74;
        Fri,  8 Sep 2023 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694168414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHN3xfOjSN7msOotMbXVATC0m3J8u3hzQBfy6gdfcY0=;
        b=eYVYa34tDLRQWRMo1PVRkzYwd36FhRujgnd3mnpE+yoctMC3WVnCvSUOtHZPGGVi4hL6dh
        1NsgJ6pJ2XREplIdGSYbu/zmBuk6uH1BIBpPSw/N4TFm1Q/A6i77AnTWWrLPgRDp5xXVLd
        g/+5X7NNLg5NFp6br0dxJy0h/xwji64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694168414;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHN3xfOjSN7msOotMbXVATC0m3J8u3hzQBfy6gdfcY0=;
        b=aBd629a13wa8umr+2+r2I/XdiwZ4QEcoDHYx3h6VawMxeM0Q8HXfbCLWifSlNrPy8E+tH0
        ZZmhoFyQBP7XjlAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89FAD131FD;
        Fri,  8 Sep 2023 10:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jqaKIV71+mSgcQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 08 Sep 2023 10:20:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 267B6A0774; Fri,  8 Sep 2023 12:20:14 +0200 (CEST)
Date:   Fri, 8 Sep 2023 12:20:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zdenek Kabelac <zkabelac@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230908102014.xgtcf5wth2l2cwup@quack3>
References: <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
 <20230908073244.wyriwwxahd3im2rw@quack3>
 <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-09-23 11:29:40, Zdenek Kabelac wrote:
> Dne 08. 09. 23 v 9:32 Jan Kara napsal(a):
> > On Thu 07-09-23 14:04:51, Mikulas Patocka wrote:
> > > 
> > > On Thu, 7 Sep 2023, Christian Brauner wrote:
> > > 
> > > > > I think we've got too deep down into "how to fix things" but I'm not 100%
> > > > We did.
> > > > 
> > > > > sure what the "bug" actually is. In the initial posting Mikulas writes "the
> > > > > kernel writes to the filesystem after unmount successfully returned" - is
> > > > > that really such a big issue?
> > > I think it's an issue if the administrator writes a script that unmounts a
> > > filesystem and then copies the underyling block device somewhere. Or a
> > > script that unmounts a filesystem and runs fsck afterwards. Or a script
> > > that unmounts a filesystem and runs mkfs on the same block device.
> > Well, e.g. e2fsprogs use O_EXCL open so they will detect that the filesystem
> > hasn't been unmounted properly and complain. Which is exactly what should
> > IMHO happen.
> > 
> > > > > Anybody else can open the device and write to it as well. Or even
> > > > > mount the device again. So userspace that relies on this is kind of
> > > > > flaky anyway (and always has been).
> > > It's admin's responsibility to make sure that the filesystem is not
> > > mounted multiple times when he touches the underlying block device after
> > > unmount.
> > What I wanted to suggest is that we should provide means how to make sure
> > block device is not being modified and educate admins and tool authors
> > about them. Because just doing "umount /dev/sda1" and thinking this means
> > that /dev/sda1 is unused now simply is not enough in today's world for
> > multiple reasons and we cannot solve it just in the kernel.
> > 
> 
> /me just wondering how do you then imagine i.e. safe removal of USB drive
> when user shall not expect unmount really unmounts filesystem?

Well, currently you click some "Eject / safely remove / whatever" button
and then you get a "wait" dialog until everything is done after which
you're told the stick is safe to remove. What I imagine is that the "wait"
dialog needs to be there while there are any (or exclusive at minimum) openers
of the device. Not until umount(2) syscall has returned. And yes, the
kernel doesn't quite make that easy - the best you can currently probably
do is to try opening the device with O_EXCL and if that fails, you know
there's some other exclusive open.

> IMHO  - unmount should detect some very suspicious state of block device if
> it cannot correctly proceed - i.e. reporting 'warning/error' on such
> commands...

You seem to be concentrated too much on the simple case of a desktop with
an USB stick you just copy data to & from. :) The trouble is, as Al wrote
elsewhere in this thread that filesystem unmount can be for example a
result of exit(2) or close(2) system call if you setup things in a nasty
way. Do you want exit(2) to fail because the block device is frozen?
Umount(2) has to work for all its users and changing the behavior has nasty
corner-cases. So does the current behavior, I agree, but improving
situation for one usecase while breaking another usecase isn't really a way
forward...

> Main problem is - if the 'unmount' is successful in this case - the last
> connection userspace had to this fileystem is lost - and user cannot get rid
> of such filesystem anymore for a system.

Well, the filesystem (struct superblock to be exact) is invisible in
/proc/mounts (or whatever), that is true. But it is still very much
associated with that block device and if you do 'mount <device>
<mntpoint>', you'll get it back. But yes, the filesystem will not go away
until all references to it are dropped and you cannot easily find who holds
those references and how to get rid of them.

> I'd likely propose in this particular state of unmounting of a frozen
> filesystem to just proceed - and drop the frozen state together with release
> filesystem and never issue any ioctl from such filelsystem to the device
> below - so it would not be a 100% valid unmount - but since the freeze
> should be nearly equivalent of having a proper 'unmount' being done -  it
> shoudn't be causing any harm either - and  all resources associated could 
> be 'released.  IMHO it's correct to 'drop' frozen state for filesystem
> that is not going to exist anymore  (assuming it's the last  such user)

This option was also discussed in the past and it has nasty consequences as
well. Cleanly shutting down a filesystem usually needs to write to the
underlying device so either you allow the filesystem to write to the device
on umount breaking assumptions of the user who froze the fs or you'd have
to implement a special handling for this case for every filesystem to avoid
the writes (and put up with the fact that the filesystem will appear as
uncleanly shutdown on the next mount). Not particularly nice either...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
