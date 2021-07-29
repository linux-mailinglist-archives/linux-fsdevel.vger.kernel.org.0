Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1603D9A17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 02:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhG2A2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 20:28:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50038 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhG2A2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:28:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93C9722305;
        Thu, 29 Jul 2021 00:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627518528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/+FeFYNqyKJR72zTgHgBvjmu1iMzo4ikFzned3cHKw=;
        b=Vn8PB50JCHsww87su5TaRlPcYxZ6FYbGuvjVLjMneTG1e1RAEHtdDTM0hauvqXUfwAaA0H
        m6Aw/IgQ3PQFCrOiYnlXQEjmuKMMdHipzeQs1Zq/Pj0w48p9gwOn+61/guY2MqUOn/awLa
        SPwvCSlhStVoc8vSOEXSComEy3LZJ8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627518528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/+FeFYNqyKJR72zTgHgBvjmu1iMzo4ikFzned3cHKw=;
        b=QNudFvSon7m5IeyThiCJxZ2pOK4ftpUGRrDFkCK4yi3lvUFu9md7ByXCzpgccgX5zNnPuj
        FYgvJMj+yxdjJoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C1F413ADC;
        Thu, 29 Jul 2021 00:28:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j9PONjz2AWHwewAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 29 Jul 2021 00:28:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Linux Btrfs" <linux-btrfs@vger.kernel.org>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
In-reply-to: <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546554.32498.9309110546560807513.stgit@noble.brown>,
 <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com>
Date:   Thu, 29 Jul 2021 10:28:42 +1000
Message-id: <162751852209.21659.13294658501847453542@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jul 2021, Amir Goldstein wrote:
> On Wed, Jul 28, 2021 at 1:44 AM NeilBrown <neilb@suse.de> wrote:
> >
> > When a filesystem has internal mounts, it controls the filehandles
> > across all those mounts (subvols) in the filesystem.  So it is useful to
> > be able to look up a filehandle again one mount, and get a result which
> > is in a different mount (part of the same overall file system).
> >
> > This patch makes that possible by changing export_decode_fh() and
> > export_decode_fh_raw() to take a vfsmount pointer by reference, and
> > possibly change the vfsmount pointed to before returning.
> >
> > The core of the change is in reconnect_path() which now not only checks
> > that the dentry is fully connected, but also that the vfsmnt reported
> > has the same 'dev' (reported by vfs_getattr) as the dentry.
> > If it doesn't, we walk up the dparent() chain to find the highest place
> > where the dev changes without there being a mount point, and trigger an
> > automount there.
> >
> > As no filesystems yet provide local-mounts, this does not yet change any
> > behaviour.
> >
> > In exportfs_decode_fh_raw() we previously tested for DCACHE_DISCONNECT
> > before calling reconnect_path().  That test is dropped.  It was only a
> > minor optimisation and is now inconvenient.
> >
> > The change in overlayfs needs more careful thought than I have yet given
> > it.
> 
> Just note that overlayfs does not support following auto mounts in layers.
> See ovl_dentry_weird(). ovl_lookup() fails if it finds such a dentry.
> So I think you need to make sure that the vfsmount was not crossed
> when decoding an overlayfs real fh.

Sounds sensible - thanks.
Does this mean that my change would cause problems for people using
overlayfs with a btrfs lower layer?

> 
> Apart from that, I think that your new feature should be opt-in w.r.t
> the exportfs_decode_fh() vfs api and that overlayfs should not opt-in
> for the cross mount decode.

I did consider making it opt-in, but it is easy enough for the caller
to ignore the changed vfsmount, and only one (of 4) callers that it
really makes a difference for.

I will review the overlayfs in light of these comments.
Thanks,
NeilBrown
