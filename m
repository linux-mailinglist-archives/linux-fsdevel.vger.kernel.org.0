Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1812A3EF51B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhHQVkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:40:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43664 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbhHQVkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:40:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D98E422004;
        Tue, 17 Aug 2021 21:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629236379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BjI4jkMUklSPtukK3yN1feQccpHPUmNABgo6WBtU7s=;
        b=Svk2Yud092I0CIJqjITJqUrNNE+wegjRQyvCYLy3AHp30S7giHBHYYe6vwi6s0cZDe9u2X
        GRzz22v6hEV7InHMbGsgKCCEo5Cx88XWK0jll/lIxHQVaBGp4G/SPyDsZVXd209yCu4JOv
        gpsIPS5j/43xWUcknsRZXe4tgdz6jgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629236379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BjI4jkMUklSPtukK3yN1feQccpHPUmNABgo6WBtU7s=;
        b=x1SC0yBGBzMuDYvKU6t02dqk1xmnm3sLdOr/8fiTr9qvOQvtLKEAuPIFKVv1HHvto7Qwoi
        AlLnEgn6tx5ln/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7423913A77;
        Tue, 17 Aug 2021 21:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uaXUDJgsHGESMwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 17 Aug 2021 21:39:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     kreijack@inwind.it
Cc:     "Roman Mamedov" <rm@romanrm.net>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <d8d67284-8d53-ed97-f387-81b27d17fdde@inwind.it>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it>,
 <20210816003505.7b3e9861@natsu>,
 <ee167ffe-ad11-ea95-1bd5-c43f273b345a@libero.it>,
 <162906443866.1695.6446438554332029261@noble.neil.brown.name>,
 <d8d67284-8d53-ed97-f387-81b27d17fdde@inwind.it>
Date:   Wed, 18 Aug 2021 07:39:31 +1000
Message-id: <162923637125.9892.2416104366790758503@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Aug 2021, kreijack@inwind.it wrote:
> On 8/15/21 11:53 PM, NeilBrown wrote:
> > On Mon, 16 Aug 2021, kreijack@inwind.it wrote:
> >> On 8/15/21 9:35 PM, Roman Mamedov wrote:

> >>
> >> However looking at the 'exports' man page, it seems that NFS has already=
 an
> >> option to cover these cases: 'crossmnt'.
> >>
> >> If NFSd detects a "child" filesystem (i.e. a filesystem mounted inside a=
n already
> >> exported one) and the "parent" filesystem is marked as 'crossmnt',  the =
client mount
> >> the parent AND the child filesystem with two separate mounts, so there i=
s not problem of inode collision.
> >=20
> > As you acknowledged, you haven't read the whole back-story.  Maybe you
> > should.
> >=20
> > https://lore.kernel.org/linux-nfs/20210613115313.BC59.409509F4@e16-tech.c=
om/
> > https://lore.kernel.org/linux-nfs/162848123483.25823.15844774651164477866=
.stgit@noble.brown/
> > https://lore.kernel.org/linux-btrfs/162742539595.32498.136879243661557375=
75.stgit@noble.brown/
> >=20
> > The flow of conversation does sometimes jump between threads.
> >=20
> > I'm very happy to respond you questions after you've absorbed all that.
>=20
> Hi Neil,
>=20
> I read the other threads.  And I still have the opinion that the nfsd
> crossmnt behavior should be a good solution for the btrfs subvolumes.=20

Thanks for reading it all.  Let me join the dots for you.

"crossmnt" doesn't currently work because "subvolumes" aren't mount
points.

We could change btrfs so that subvolumes *are* mountpoints.  They would
have to be automounts.  I posted patches to do that.  They were broadly
rejected because people have many thousands of submounts that are
concurrently active and so /proc/mounts would be multiple megabytes is
size and working with it would become impractical.  Also, non-privileged
users can create subvols, and may want the path names to remain private.
But these subvols would appear in the mount table and so would no longer
be private.

Alternately we could change the "crossmnt" functionality to treat a
change of st_dev as though it were a mount point.  I posted patches to
do this too.  This hits the same sort of problems in a different way.
If NFSD reports that is has crossed a "mount" by providing a different
filesystem-id to the client, then the client will create a new mount
point which will appear in /proc/mounts.  It might be less likely that
many thousands of subvolumes are accessed over NFS than locally, but it
is still entirely possible.  I don't want the NFS client to suffer a
problem that btrfs doesn't impose locally.  And 'private' subvolumes
could again appear on a public list if they were accessed via NFS.

Thanks,
NeilBrown
