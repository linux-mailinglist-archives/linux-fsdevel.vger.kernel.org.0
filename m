Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44903DA691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhG2OiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 10:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237035AbhG2OiK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8B6A60FD7;
        Thu, 29 Jul 2021 14:38:03 +0000 (UTC)
Date:   Thu, 29 Jul 2021 16:38:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11] btrfs: use automount to bind-mount all subvol
 roots.
Message-ID: <20210729143801.k2zq7qm3pm2h4wzx@wittgenstein>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546558.32498.1901201501617899416.stgit@noble.brown>
 <20210728131213.pgu3r4m4ulozrcav@wittgenstein>
 <162751940386.21659.17682627731630829061@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162751940386.21659.17682627731630829061@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 10:43:23AM +1000, NeilBrown wrote:
> On Wed, 28 Jul 2021, Christian Brauner wrote:
> > 
> > Hey Neil,
> > 
> > Sorry if this is a stupid question but wouldn't you want to copy the
> > mount properties from path->mnt here? Couldn't you otherwise use this to
> > e.g. suddenly expose a dentry on a read-only mount as read-write?
> 
> There are no stupid questions, and this is a particularly non-stupid
> one!
> 
> I hadn't considered that, but having examined the code I see that it
> is already handled.
> The vfsmount that d_automount returns is passed to finish_automount(),
> which hands it to do_add_mount() together with the mnt_flags for the
> parent vfsmount (plus MNT_SHRINKABLE).
> do_add_mount() sets up the mnt_flags of the new vfsmount.
> In fact, the d_automount interface has no control of these flags at all.
> Whatever it sets will be over-written by do_add_mount.

Ah, interesting thank you very much, Neil. I seemed to have overlooked
this yesterday.

If btrfs makes use of automounts the way you envisioned to expose
subvolumes and also will support idmapped mounts (see [1]) we need to
teach do_add_mount() to also take the idmapped mount into account. So
you'd need something like (entirely untested):

diff --git a/fs/namespace.c b/fs/namespace.c
index ab4174a3c802..921f6396c36d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2811,6 +2811,11 @@ static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
                return -EINVAL;

        newmnt->mnt.mnt_flags = mnt_flags;
+
+       newmnt->mnt.mnt_userns = path->mnt;
+       if (newmnt->mnt.mnt_userns != &init_user_ns)
+               newmnt->mnt.mnt_userns = get_user_ns(newmnt->mnt.mnt_userns);
+
        return graft_tree(newmnt, parent, mp);
 }

[1]: https://lore.kernel.org/linux-btrfs/20210727104900.829215-1-brauner@kernel.org/T/#mca601363b435e81c89d8ca4f09134faa5c227e6d
