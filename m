Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9F3ECBA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhHOWSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 18:18:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51972 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOWSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 18:18:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 348D121E94;
        Sun, 15 Aug 2021 22:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629065857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1wlI+cVSKriu9/Tm1fYqhEHCYbhsWFHRYG6z+yGuZ0=;
        b=QslDfLergCm9VW+Zt2k4ANJzPeDE8FhfNmBVLWhu2j/XGU/NFtLnxYrxb+neGHP/oq+hhq
        KmZpreD23Tt0LR5gMulx3MKFMLRs3x5CJBxkPHwh8GzMkLvnSB4lF/HC0wwx5l5w+jY2pl
        4tCB1FknTWn4ViOfJ/a4JmBZHk/qaqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629065857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1wlI+cVSKriu9/Tm1fYqhEHCYbhsWFHRYG6z+yGuZ0=;
        b=bdNOjljsZlRhV7vh7WkSiq36xUoyHBALgoZ/ZB4Tg2Jt5n07A+WD4NytO7Wgt2Rt+7f1aJ
        xCZ9A4mm9NCieZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C271E13AEA;
        Sun, 15 Aug 2021 22:17:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RiP/H32SGWERfwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 15 Aug 2021 22:17:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Roman Mamedov" <rm@romanrm.net>
Cc:     "Goffredo Baroncelli" <kreijack@libero.it>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210816003505.7b3e9861@natsu>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it>,
 <20210816003505.7b3e9861@natsu>
Date:   Mon, 16 Aug 2021 08:17:30 +1000
Message-id: <162906585094.1695.15815972140753474778@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Aug 2021, Roman Mamedov wrote:
>=20
> I wondered a bit myself, what are the downsides of just doing the
> uniquefication inside Btrfs, not leaving that to NFSD?
>=20
> I mean not even adding the extra stat field, just return the inode itself w=
ith
> that already applied. Surely cannot be any worse collision-wise, than
> different subvolumes straight up having the same inode numbers as right now?
>=20
> Or is it a performance concern, always doing more work, for something which
> only NFSD has needed so far.

Any change in behaviour will have unexpected consequences.  I think the
btrfs maintainers perspective is they they don't want to change
behaviour if they don't have to (which is reasonable) and that currently
they don't have to (which probably means that users aren't complaining
loudly enough).

NFS export of BTRFS is already demonstrably broken and users are
complaining loudly enough that I can hear them ....  though I think it
has been broken like this for 10 years, do I wonder that I didn't hear
them before.

If something is perceived as broken, then a behaviour change that
appears to fix it is more easily accepted.

However, having said that I now see that my latest patch is not ideal.
It changes the inode numbers associated with filehandles of objects in
the non-root subvolume.  This will cause the Linux NFS client to treat
the object as 'stale' For most objects this is a transient annoyance.
Reopen the file or restart the process and all should be well again.
However if the inode number of the mount point changes, you will need to
unmount and remount.  That is more somewhat more of an annoyance.

There are a few ways to handle this more gracefully.

1/ We could get btrfs to hand out new filehandles as well as new inode
numbers, but still accept the old filehandles.  Then we could make the
inode number reported be based on the filehandle.  This would be nearly
seamless but rather clumsy to code.  I'm not *very* keen on this idea,
but it is worth keeping in mind.

2/ We could add a btrfs mount option to control whether the uniquifier
was set or not.  This would allow the sysadmin to choose when to manage
any breakage.  I think this is my preference, but Josef has declared an
aversion to mount options.

3/ We could add a module parameter to nfsd to control whether the
uniquifier is merged in.  This again gives the sysadmin control, and it
can be done despite any aversion from btrfs maintainers.  But I'd need
to overcome any aversion from the nfsd maintainers, and I don't know how
strong that would be yet. (A new export option isn't really appropriate.
It is much more work to add an export option than the add a mount option).

I don't know.... maybe I should try harder to like option 1, or at least
verify if it works as expected and see how ugly the code really is.

NeilBrown
