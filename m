Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49010356B89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhDGLub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 07:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhDGLub (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AED926139B;
        Wed,  7 Apr 2021 11:50:18 +0000 (UTC)
Date:   Wed, 7 Apr 2021 13:50:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH v2 2/2] cachefiles: extend ro check to private mount
Message-ID: <20210407115015.v4pbuxbplrqscmu7@wittgenstein>
References: <20210407090208.876920-1-brauner@kernel.org>
 <20210407090208.876920-2-brauner@kernel.org>
 <CAOQ4uxijmfgbYiZ231ndRYKyrYOcgqQAz4wqZeRje7-Had22fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxijmfgbYiZ231ndRYKyrYOcgqQAz4wqZeRje7-Had22fw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:30:19PM +0300, Amir Goldstein wrote:
> On Wed, Apr 7, 2021 at 12:02 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > So far cachefiles only verified that the superblock wasn't read-only but
> > didn't check whether the mount was. This made sense when we did not use
> > a private mount because the read-only state could change at any point.
> >
> > Now that we have a private mount and mount properties can't change
> > behind our back extend the read-only check to include the vfsmount.
> >
> > The __mnt_is_readonly() helper will check both the mount and the
> > superblock.  Note that before we checked root->d_sb and now we check
> > mnt->mnt_sb but since we have a matching <vfsmount, dentry> pair here
> > this is only syntactical change, not a semantic one.
> >
> > Here's how this works:
> >
> > mount -o ro --bind /var/cache/fscache/ /var/cache/fscache/
> >
> > systemctl start cachefilesd
> >   Job for cachefilesd.service failed because the control process exited with error code.
> >   See "systemctl status cachefilesd.service" and "journalctl -xe" for details.
> >
> > dmesg | grep CacheFiles
> >   [    2.922514] CacheFiles: Loaded
> >   [  272.206907] CacheFiles: Failed to register: -30
> >
> > errno 30
> >   EROFS 30 Read-only file system
> >
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: linux-cachefs@redhat.com
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > patch introduced
> > ---
> >  fs/cachefiles/bind.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
> > index bbace3e51f52..cb8dd9ecc090 100644
> > --- a/fs/cachefiles/bind.c
> > +++ b/fs/cachefiles/bind.c
> > @@ -141,8 +141,13 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
> >             !root->d_sb->s_op->sync_fs)
> >                 goto error_unsupported;
> >
> > +       /*
> > +        * Verify our mount and superblock aren't read-only.
> > +        * Note, while our private mount is guaranteed to not change anymore
> > +        * the superblock may still go read-only later.
> > +        */
> >         ret = -EROFS;
> > -       if (sb_rdonly(root->d_sb))
> > +       if (__mnt_is_readonly(cache->mnt))
> >                 goto error_unsupported;
> >
> 
> I suppose ovl_get_upper() and ecryptfs_mount() could use a similar fix?
> I can post the ovl fix myself.

Likely. Note that I still need to port ecryptfs. I hope to get a port
ready for review soon!

Thanks!
Christian
