Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF13DE20D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhHBV7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 17:59:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhHBV7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:59:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7233621F68;
        Mon,  2 Aug 2021 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627941576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lp1YmsAUDjMCSoUwGiOv4dNDjiNBqO2e3l5iyJOtwI=;
        b=G+qqZgwBD79C33ihRBKP3j3wS2SPXPal/8ftrmbaKG/2uI/XtSLdQxoPwq661R02bvIR71
        it4cbL57Va2buHrvUFqwCZ0/d/UjP7dIbK618LqK9glKYx8uirI/TV/wux33mE2V7rai42
        WYhJFXVuJatrua0nAmXALPshj3WcP4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627941576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lp1YmsAUDjMCSoUwGiOv4dNDjiNBqO2e3l5iyJOtwI=;
        b=fvxn/1Q9Tq0QZzMBn8yVjDrKGJZzfRWzg2dTAqh4lWuyYGfRKfMFFM4QlDF0v0i9NhBzX4
        0+nfquitzItZxnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4558513CB3;
        Mon,  2 Aug 2021 21:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ORlNAMVqCGF4DAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 Aug 2021 21:59:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
In-reply-to: <20210802215059.GF6890@fieldses.org>
References: <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>,
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>,
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>,
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>,
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>,
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>,
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>,
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>,
 <20210802123930.GA6890@fieldses.org>,
 <162793864421.32159.6348977485257143426@noble.neil.brown.name>,
 <20210802215059.GF6890@fieldses.org>
Date:   Tue, 03 Aug 2021 07:59:30 +1000
Message-id: <162794157037.32159.9608382458264702109@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 03 Aug 2021, J. Bruce Fields wrote:
> On Tue, Aug 03, 2021 at 07:10:44AM +1000, NeilBrown wrote:
> > On Mon, 02 Aug 2021, J. Bruce Fields wrote:
> > > On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> > > > For btrfs, the "location" is root.objectid ++ file.objectid.  I think
> > > > the inode should become (file.objectid ^ swab64(root.objectid)).  This
> > > > will provide numbers that are unique until you get very large subvols,
> > > > and very many subvols.
> > > 
> > > If you snapshot a filesystem, I'd expect, at least by default, that
> > > inodes in the snapshot to stay the same as in the snapshotted
> > > filesystem.
> > 
> > As I said: we need to challenge and revise user-space (and meat-space)
> > expectations. 
> 
> The example that came to mind is people that export a snapshot, then
> replace it with an updated snapshot, and expect that to be transparent
> to clients.
> 
> Our client will error out with ESTALE if it notices an inode number
> changed out from under it.

Will it?  If the inode number changed, then the filehandle would change.
Unless the filesystem were exported with subtreecheck, the old filehandle
would continue to work (unless the old snapshot was deleted).  File-name
lookups from the root would find new files...

"replace with an updated snapshot" is no different from "replace with an
updated directory tree".  If you delete the old tree, then
currently-open files will break.  If you don't you get a reasonably
clean transition.

> 
> I don't know if there are other such cases.  It seems like surprising
> behavior to me, though.

If you refuse to risk breaking anything, then you cannot make progress.
Providing people can choose when things break, and have advanced
warning, they often cope remarkable well.

Thanks,
NeilBrown


> 
> --b.
> 
> > In btrfs, you DO NOT snapshot a FILESYSTEM.  Rather, you effectively
> > create a 'reflink' for a subtree (only works on subtrees that have been
> > correctly created with the poorly named "btrfs subvolume" command).
> > 
> > As with any reflink, the original has the same inode number that it did
> > before, the new version has a different inode number (though in current
> > BTRFS, half of the inode number is hidden from user-space, so it looks
> > like the inode number hasn't changed).
> 
> 
