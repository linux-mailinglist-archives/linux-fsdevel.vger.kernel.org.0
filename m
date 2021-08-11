Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3D3E9AC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhHKWNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 18:13:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhHKWNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:13:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C89C71FEF2;
        Wed, 11 Aug 2021 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628720008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeGzUTvoCN8Wlt5hyL5qJ6Nm2upHl5bZr9FlYzW5TQ0=;
        b=yIgC1og83IS8ikDuUa+qhuKWoRiaFZpJQmCJxxkDPM8DsMrrvq5GROc6puqtu3oDd3jOTq
        DwVI/+GcUIDgt2Jfxdv8k904Utq59utZDQWjNG+amg5vxH2zsmMUVfk35LCfJyJFB8PEbU
        eIDLG5MRhGprNTj4px4r0NpIl3c+TQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628720008;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeGzUTvoCN8Wlt5hyL5qJ6Nm2upHl5bZr9FlYzW5TQ0=;
        b=8W2baWzFIFgDvTP8YHv8VfmQD59nHIEjVMGlpp67VhTsoI5tbZnt9ZATQRtUnjXKW4mSse
        tDnOxeGJjByd16DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBC4A13AE6;
        Wed, 11 Aug 2021 22:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C9QcKoZLFGHxKwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 11 Aug 2021 22:13:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
        linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/4] Attempt to make progress with btrfs dev number
 strangeness.
In-reply-to: <e6496956-0df3-6232-eecb-5209b28ca790@toxicpanda.com>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>,
 <e6496956-0df3-6232-eecb-5209b28ca790@toxicpanda.com>
Date:   Thu, 12 Aug 2021 08:13:23 +1000
Message-id: <162872000356.22261.854151210687377005@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 Aug 2021, Josef Bacik wrote:
>=20
> I think this is a step in the right direction, but I want to figure out a w=
ay to=20
> accomplish this without magical mount points that users must be aware of.

magic mount *options* ???

>=20
> I think the stat() st_dev ship as sailed, we're stuck with that.  However=20
> Christoph does have a valid point where it breaks the various info spit out=
 by=20
> /proc.  You've done a good job with the treeid here, but it still makes it =

> impossible for somebody to map the st_dev back to the correct mount.

The ship might have sailed, but it is not water tight.  And as the world
it round, it can still come back to bite us from behind.
Anything can be transitioned away from, whether it is devfs or 32-bit
time or giving different device numbers to different file-trees.

The linkage between device number and and filesystem is quite strong.
We could modified all of /proc and /sys/ and audit and whatever else to
report the fake device number, but we cannot get the fake device number
into the mount table (without making the mount table unmanageablely
large). =20
And if subtrees aren't in the mount-table for the NFS server, I don't
think they should be in the mount-table of the NFS client.  So we cannot
export them to NFS.

I understand your dislike for mount options.  An alternative with
different costs and benefits would be to introduce a new filesystem type
- btrfs2 or maybe betrfs.  This would provide numdevs=3D1 semantics and do
whatever we decided was best with inode numbers.  How much would you
hate that?

>=20
> I think we aren't going to solve that problem, at least not with stat().  I=
=20
> think with statx() spitting out treeid we have given userspace a way to=20
> differentiate subvolumes, and so we should fix statx() to spit out the the =
super=20
> block device, that way new userspace things can do their appropriate lookup=
 if=20
> they so choose.

I don't think we should normalize having multiple devnums per filesystem
by encoding it in statx().  It *would* make sense to add a btrfs ioctl
which reports the real device number of a file.  Tools that really need
to work with btrfs could use that, but it would always be obvious that
it was an exception.

>=20
> This leaves the problem of nfsd.  Can you just integrate this new treeid in=
to=20
> nfsd, and use that to either change the ino within nfsd itself, or do somet=
hing=20
> similar to what your first patchset did and generate a fsid based on the tr=
eeid?

I would only want nfsd to change the inode number.  I no longer think it
is acceptable for nfsd to report different device number (as I mention
above).
I would want the new inode number to be explicitly provided by the
filesystem.  Whether that is a new export_operation or a new field in
'struct kstat' doesn't really bother me.  I'd *prefer* it to be st_ino,
but I can live without that.

On the topic of inode numbers....  I've recently learned that btrfs
never reuses inode (objectid) numbers (except possibly after an
unmount).  Equally it doesn't re-use subvol numbers.  How much does this
contribute to the 64 bits not being enough for subtree+inode?

It would be nice if we could be comfortable limiting the objectid number
to 40 bits and the root.objectid (filetree) number to 24 bits, and
combine them into a 64bit inode number.

If we added a inode number reuse scheme that was suitably performant,
would that make this possible?  That would remove the need for a treeid,
and allow us to use project-id to identify subtrees.

>=20
> Mount options are messy, and are just going to lead to distro's turning the=
m on=20
> without understanding what's going on and then we have to support them fore=
ver.=20
>   I want to get this fixed in a way that we all hate the least with as litt=
le=20
> opportunity for confused users to make bad decisions.  Thanks,

Hence my question: how much do you hate creating a new filesystem type
to fix the problems?

Thanks,
NeilBrown
