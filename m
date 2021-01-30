Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46D30940E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 11:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhA3KJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 05:09:36 -0500
Received: from mail.hallyn.com ([178.63.66.53]:45820 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhA3CJD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 21:09:03 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id D174C9AC; Fri, 29 Jan 2021 20:06:52 -0600 (CST)
Date:   Fri, 29 Jan 2021 20:06:52 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
Message-ID: <20210130020652.GB7163@mail.hallyn.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
 <20210119162204.2081137-3-mszeredi@redhat.com>
 <8735yw8k7a.fsf@x220.int.ebiederm.org>
 <20210128165852.GA20974@mail.hallyn.com>
 <87o8h8x1a6.fsf@x220.int.ebiederm.org>
 <20210129154839.GC1130@mail.hallyn.com>
 <87im7fuzdq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im7fuzdq.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 04:55:29PM -0600, Eric W. Biederman wrote:
> "Serge E. Hallyn" <serge@hallyn.com> writes:
> 
> > On Thu, Jan 28, 2021 at 02:19:13PM -0600, Eric W. Biederman wrote:
> >> "Serge E. Hallyn" <serge@hallyn.com> writes:
> >> 
> >> > On Tue, Jan 19, 2021 at 07:34:49PM -0600, Eric W. Biederman wrote:
> >> >> Miklos Szeredi <mszeredi@redhat.com> writes:
> >> >> 
> >> >> > If a capability is stored on disk in v2 format cap_inode_getsecurity() will
> >> >> > currently return in v2 format unconditionally.
> >> >> >
> >> >> > This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
> >> >> > and so the same conversions performed on it.
> >> >> >
> >> >> > If the rootid cannot be mapped v3 is returned unconverted.  Fix this so
> >> >> > that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
> >> >> > user namespace in case of v2) cannot be mapped in the current user
> >> >> > namespace.
> >> >> 
> >> >> This looks like a good cleanup.
> >> >
> >> > Sorry, I'm not following.  Why is this a good cleanup?  Why should
> >> > the xattr be shown as faked v3 in this case?
> >> 
> >> If the reader is in &init_user_ns.  If the filesystem was mounted in a
> >> user namespace.   Then the reader looses the information that the
> >
> > Can you be more precise about "filesystem was mounted in a user namespace"?
> > Is this a FUSE thing, the fs is marked as being mounted in a non-init userns?
> > If that's a possible case, then yes that must be represented as v3.  Using
> > is_v2header() may be the simpler way to check for that, but the more accurate
> > check would be "is it v2 header and mounted by init_user_ns".
> 
> I think the filesystems current relevant are fuse,overlayfs,ramfs,tmpfs.
> 
> > Basically yes, in as many cases as possible we want to just give a v2
> > cap because more userspace knows what to do with that, but a non-init-userns
> > mounted fs which provides a v2 fscap should have it represented as v3 cap
> > with rootid being the kuid that owns the userns.
> 
> That is the case we that is being fixed in the patch.
> 
> > Or am I still thinking wrongly?  Wouldn't be entirely surprised :)
> 
> No you got it.

So then can we make faking a v3 gated on whether
    sb->s_user_ns != &init_user_ns ?

