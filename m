Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161D42C286E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgKXNkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:40:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54109 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388372AbgKXNku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:40:50 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1khYYf-00013C-20; Tue, 24 Nov 2020 13:40:37 +0000
Date:   Tue, 24 Nov 2020 14:40:35 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        Christoph Hellwig <hch@infradead.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        selinux@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 07/39] mount: attach mappings to mounts
Message-ID: <20201124134035.2l36avuaqp6gxyum@wittgenstein>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-8-christian.brauner@ubuntu.com>
 <20201123154719.GD4025434@cisco>
 <20201123162428.GA24807@cisco>
 <20201124123035.hbv4sstyoucht7xp@wittgenstein>
 <20201124133740.GA52954@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124133740.GA52954@cisco>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 08:37:40AM -0500, Tycho Andersen wrote:
> On Tue, Nov 24, 2020 at 01:30:35PM +0100, Christian Brauner wrote:
> > On Mon, Nov 23, 2020 at 11:24:28AM -0500, Tycho Andersen wrote:
> > > On Mon, Nov 23, 2020 at 10:47:19AM -0500, Tycho Andersen wrote:
> > > > On Sun, Nov 15, 2020 at 11:36:46AM +0100, Christian Brauner wrote:
> > > > > +static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
> > > > > +{
> > > > > +	return mnt->mnt_user_ns;
> > > > > +}
> > > > 
> > > > I think you might want a READ_ONCE() here. Right now it seems ok, since the
> > > > mnt_user_ns can't change, but if we ever allow it to change (and I see you have
> > > > a idmapped_mounts_wip_v2_allow_to_change_idmapping branch on your public tree
> > > > :D), the pattern of,
> > > > 
> > > >         user_ns = mnt_user_ns(path->mnt);
> > > >         if (mnt_idmapped(path->mnt)) {
> > > >                 uid = kuid_from_mnt(user_ns, uid);
> > > >                 gid = kgid_from_mnt(user_ns, gid);
> > > >         }
> > > > 
> > > > could race.
> > > 
> > > Actually, isn't a race possible now?
> > > 
> > > kuid_from_mnt(mnt_user_ns(path->mnt) /* &init_user_ns */);
> > > WRITE_ONCE(mnt->mnt.mnt_user_ns, user_ns);
> > > WRITE_ONCE(m->mnt.mnt_flags, flags);
> > > kgid_from_mnt(mnt_user_ns(path->mnt) /* the right user ns */);
> > > 
> > > So maybe it should be:
> > > 
> > >          if (mnt_idmapped(path->mnt)) {
> > >                  barrier();
> > >                  user_ns = mnt_user_ns(path->mnt);
> > >                  uid = kuid_from_mnt(user_ns, uid);
> > >                  gid = kgid_from_mnt(user_ns, gid);
> > >          }
> > > 
> > > since there's no data dependency between mnt_idmapped() and
> > > mnt_user_ns()?
> > 
> > I think I had something to handle this case in another branch of mine.
> > The READ_ONCE() you mentioned in another patch I had originally dropped
> > because I wasn't sure whether it works on pointers but after talking to
> > Jann and David it seems that it handles pointers fine.
> > Let me take a look and fix it in the next version. I just finished
> > porting the test suite to xfstests as Christoph requested and I'm
> > looking at this now.
> 
> Another way would be to just have mnt_idmapped() test
> mnt_user_ns() != &init_user_ns instead of the flags; then I think you
> get the data dependency and thus correct ordering for free.

I indeed dropped mnt_idmapped() which is unnecessary. :)
I think we should still use smp_store_release() in mnt_user_ns() paired
with smp_load_acquire() in do_idmap_mount() thought.

Christian
