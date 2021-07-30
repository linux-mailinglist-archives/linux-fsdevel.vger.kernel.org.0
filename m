Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81E3DB48D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhG3HeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:34:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhG3HeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:34:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7101C2221B;
        Fri, 30 Jul 2021 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627630440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAlYon3Hac3rWdBYEYV2hMROstwba47XrP47jS8wCi4=;
        b=SdhxMV1gWcR7BdbTd2862pVouJNBan3hj7HS5s2ySjCoisJPui7qWLGWyMdplVtPjKpKEa
        FoUcYtrPGJjWua9N4CDF0vNAI53E0TkB3xEVrKOF40C1jU09hKHdFrussdVXvQ+kfwCArp
        obvj2uQsS+gLeJtVgCZFZ1gont39l0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627630440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAlYon3Hac3rWdBYEYV2hMROstwba47XrP47jS8wCi4=;
        b=wSFZlcCix7g5plUAnscf8jyoBu7lmVOq9IhgR5I/70g5Sp5Oy1PcFBl+Ar4TSl36oYuge+
        JbS1ti6LcFhfERBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8F6213BF9;
        Fri, 30 Jul 2021 07:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0wDdGmSrA2G3GAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 07:33:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/11] VFS: show correct dev num in mountinfo
In-reply-to: <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546548.32498.10889023150565429936.stgit@noble.brown>,
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>,
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>,
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>,
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>,
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
Date:   Fri, 30 Jul 2021 17:33:53 +1000
Message-id: <162763043341.21659.15645923585962859662@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Fri, 30 Jul 2021, Miklos Szeredi wrote:
> On Fri, 30 Jul 2021 at 08:13, NeilBrown <neilb@suse.de> wrote:
> >
> > On Fri, 30 Jul 2021, Miklos Szeredi wrote:
> > > On Fri, 30 Jul 2021 at 07:28, NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > On Fri, 30 Jul 2021, Al Viro wrote:
> > > > > On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > > > > > /proc/$PID/mountinfo contains a field for the device number of the
> > > > > > filesystem at each mount.
> > > > > >
> > > > > > This is taken from the superblock ->s_dev field, which is correct=
 for
> > > > > > every filesystem except btrfs.  A btrfs filesystem can contain mu=
ltiple
> > > > > > subvols which each have a different device number.  If (a directo=
ry
> > > > > > within) one of these subvols is mounted, the device number report=
ed in
> > > > > > mountinfo will be different from the device number reported by st=
at().
> > > > > >
> > > > > > This confuses some libraries and tools such as, historically, fin=
dmnt.
> > > > > > Current findmnt seems to cope with the strangeness.
> > > > > >
> > > > > > So instead of using ->s_dev, call vfs_getattr_nosec() and use the=
 ->dev
> > > > > > provided.  As there is no STATX flag to ask for the device number=
, we
> > > > > > pass a request mask for zero, and also ask the filesystem to avoid
> > > > > > syncing with any remote service.
> > > > >
> > > > > Hard NAK.  You are putting IO (potentially - network IO, with no up=
per
> > > > > limit on the completion time) under namespace_sem.
> > > >
> > > > Why would IO be generated? The inode must already be in cache because=
 it
> > > > is mounted, and STATX_DONT_SYNC is passed.  If a filesystem did IO in
> > > > those circumstances, it would be broken.
> > >
> > > STATX_DONT_SYNC is a hint, and while some network fs do honor it, not a=
ll do.
> > >
> >
> > That's ... unfortunate.  Rather seems to spoil the whole point of having
> > a flag like that.  Maybe it should have been called
> >    "STATX_SYNC_OR_SYNC_NOT_THERE_IS_NO_GUARANTEE"
>=20
> And I guess just about every filesystem would need to be fixed to
> prevent starting I/O on STATX_DONT_SYNC, as block I/O could just as
> well generate network traffic.

Certainly I think that would be appropriate.  If the information simply
isn't available EWOULDBLOCK could be returned.

>=20
> Probably much easier fix btrfs to use some sort of subvolume structure
> that the VFS knows about.  I think there's been talk about that for a
> long time, not sure where it got stalled.

An easy fix for this particular patch is to add a super_operation which
provides the devno to show in /proc/self/mountinfo.  There are already a
number of show_foo super_operations to show other content.

But I'm curious about your reference to "some sort of subvolume
structure that the VFS knows about".  Do you have any references, or can
you suggest a search term I could try?

Thanks,
NeilBrown
