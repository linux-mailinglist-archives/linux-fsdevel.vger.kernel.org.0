Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97B9242E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHLSdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 14:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHLSdk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:33:40 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF8C061383;
        Wed, 12 Aug 2020 11:33:40 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5vZ0-00EEH8-Kk; Wed, 12 Aug 2020 18:33:26 +0000
Date:   Wed, 12 Aug 2020 19:33:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
Message-ID: <20200812183326.GU1236603@ZenIV.linux.org.uk>
References: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk>
 <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
 <20200812163347.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegv8MTnO9YAiFUJPjr3ryeT82=KWHUpLFmgRNOcQfeS17w@mail.gmail.com>
 <20200812173911.GT1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812173911.GT1236603@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 06:39:11PM +0100, Al Viro wrote:
> On Wed, Aug 12, 2020 at 07:16:37PM +0200, Miklos Szeredi wrote:
> > On Wed, Aug 12, 2020 at 6:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Wed, Aug 12, 2020 at 05:13:14PM +0200, Miklos Szeredi wrote:
> > 
> > > > Why does it have to have a struct mount?  It does not have to use
> > > > dentry/mount based path lookup.
> > >
> > > What the fuck?  So we suddenly get an additional class of objects
> > > serving as kinda-sorta analogues of dentries *AND* now struct file
> > > might refer to that instead of a dentry/mount pair - all on the VFS
> > > level?  And so do all the syscalls you want to allow for such "pathnames"?
> > 
> > The only syscall I'd want to allow is open, everything else would be
> > on the open files themselves.
> > 
> > file->f_path can refer to an anon mount/inode, the real object is
> > referred to by file->private_data.
> > 
> > The change to namei.c would be on the order of ~10 lines.  No other
> > parts of the VFS would be affected.
> 
> If some of the things you open are directories (and you *have* said that
> directories will be among those just upthread, and used references to
> readdir() as argument in favour of your approach elsewhere in the thread),
> you will have to do something about fchdir().  And that's the least of
> the issues.

BTW, what would such opened files look like from /proc/*/fd/* POV?  And
what would happen if you walk _through_ that symlink, with e.g. ".."
following it?  Or with names of those attributes, for that matter...
What about a normal open() of such a sucker?  It won't know where to
look for your ->private_data...

FWIW, you keep refering to regularity of this stuff from the syscall
POV, but it looks like you have no real idea of what subset of the
things available for normal descriptors will be available for those.
