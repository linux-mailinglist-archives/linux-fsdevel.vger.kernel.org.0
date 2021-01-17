Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25962F9561
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 22:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbhAQVHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 16:07:24 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:44711 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbhAQVHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 16:07:22 -0500
Received: from dread.disaster.area (pa49-181-54-82.pa.nsw.optusnet.com.au [49.181.54.82])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id AB1B4D5ED06;
        Mon, 18 Jan 2021 08:06:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l1FFd-0011Hk-2N; Mon, 18 Jan 2021 08:06:21 +1100
Date:   Mon, 18 Jan 2021 08:06:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 37/42] xfs: support idmapped mounts
Message-ID: <20210117210621.GA78941@dread.disaster.area>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-38-christian.brauner@ubuntu.com>
 <20210114205154.GL331610@dread.disaster.area>
 <20210114221048.ppf2pfuxrjak4kvm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114221048.ppf2pfuxrjak4kvm@wittgenstein>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=NAd5MxazP4FGoF8nXO8esw==:117 a=NAd5MxazP4FGoF8nXO8esw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=QsOiS33c3F2EFrvaDEcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:10:48PM +0100, Christian Brauner wrote:
> On Fri, Jan 15, 2021 at 07:51:54AM +1100, Dave Chinner wrote:
> > On Tue, Jan 12, 2021 at 11:01:19PM +0100, Christian Brauner wrote:
> > > From: Christoph Hellwig <hch@lst.de>
> > > 
> > > Enable idmapped mounts for xfs. This basically just means passing down
> > > the user_namespace argument from the VFS methods down to where it is
> > > passed to helper.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ....
> > > @@ -654,6 +658,7 @@ xfs_vn_change_ok(
> > >   */
> > >  static int
> > >  xfs_setattr_nonsize(
> > > +	struct user_namespace	*mnt_userns,
> > >  	struct xfs_inode	*ip,
> > >  	struct iattr		*iattr)
> > >  {
> > > @@ -813,7 +818,7 @@ xfs_setattr_nonsize(
> > >  	 * 	     Posix ACL code seems to care about this issue either.
> > >  	 */
> > >  	if (mask & ATTR_MODE) {
> > > -		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
> > > +		error = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
> > >  		if (error)
> > >  			return error;
> > >  	}
> > > @@ -868,7 +873,7 @@ xfs_setattr_size(
> > >  		 * Use the regular setattr path to update the timestamps.
> > >  		 */
> > >  		iattr->ia_valid &= ~ATTR_SIZE;
> > > -		return xfs_setattr_nonsize(ip, iattr);
> > > +		return xfs_setattr_nonsize(&init_user_ns, ip, iattr);
> > 
> > Shouldn't that be passing mnt_userns?
> 
> Hey Dave,
> 
> Thanks for taking a look.
> 
> This is the time updating codepath.

Yes, I understand the code path, that's why I asked the question and
commented that it's a landmine. That is, if in future we ever need
to do anything that is is in any way namespace related in the
truncate path, the wrong thing will happen because we are passing
the wrong namespace into that function.

Please just pass down the correct namespace for the operation even
though we don't currently require it for the operations being
performed in that path.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
