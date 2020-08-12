Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719A1242E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLRja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 13:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHLRj2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:39:28 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CFAC061383;
        Wed, 12 Aug 2020 10:39:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5uiV-00ECnX-Nd; Wed, 12 Aug 2020 17:39:12 +0000
Date:   Wed, 12 Aug 2020 18:39:11 +0100
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
Message-ID: <20200812173911.GT1236603@ZenIV.linux.org.uk>
References: <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk>
 <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
 <20200812163347.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegv8MTnO9YAiFUJPjr3ryeT82=KWHUpLFmgRNOcQfeS17w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv8MTnO9YAiFUJPjr3ryeT82=KWHUpLFmgRNOcQfeS17w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 07:16:37PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 12, 2020 at 6:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Aug 12, 2020 at 05:13:14PM +0200, Miklos Szeredi wrote:
> 
> > > Why does it have to have a struct mount?  It does not have to use
> > > dentry/mount based path lookup.
> >
> > What the fuck?  So we suddenly get an additional class of objects
> > serving as kinda-sorta analogues of dentries *AND* now struct file
> > might refer to that instead of a dentry/mount pair - all on the VFS
> > level?  And so do all the syscalls you want to allow for such "pathnames"?
> 
> The only syscall I'd want to allow is open, everything else would be
> on the open files themselves.
> 
> file->f_path can refer to an anon mount/inode, the real object is
> referred to by file->private_data.
> 
> The change to namei.c would be on the order of ~10 lines.  No other
> parts of the VFS would be affected.

If some of the things you open are directories (and you *have* said that
directories will be among those just upthread, and used references to
readdir() as argument in favour of your approach elsewhere in the thread),
you will have to do something about fchdir().  And that's the least of
the issues.

>   Maybe I'm optimistic; we'll
> see...


> Now off to something completely different.  Back on Tuesday.

... after the window closes.  You know, it's really starting to look
like rather nasty tactical games...
