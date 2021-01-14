Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EF92F6C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 21:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbhANUwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 15:52:43 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:43884 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbhANUwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:52:43 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 15:52:40 EST
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 03E40105E38;
        Fri, 15 Jan 2021 07:51:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l09b0-006Uat-5I; Fri, 15 Jan 2021 07:51:54 +1100
Date:   Fri, 15 Jan 2021 07:51:54 +1100
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
Message-ID: <20210114205154.GL331610@dread.disaster.area>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-38-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220124.837960-38-christian.brauner@ubuntu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=44ec6t6cGFOkeLdKtF4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:01:19PM +0100, Christian Brauner wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Enable idmapped mounts for xfs. This basically just means passing down
> the user_namespace argument from the VFS methods down to where it is
> passed to helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
....
> @@ -654,6 +658,7 @@ xfs_vn_change_ok(
>   */
>  static int
>  xfs_setattr_nonsize(
> +	struct user_namespace	*mnt_userns,
>  	struct xfs_inode	*ip,
>  	struct iattr		*iattr)
>  {
> @@ -813,7 +818,7 @@ xfs_setattr_nonsize(
>  	 * 	     Posix ACL code seems to care about this issue either.
>  	 */
>  	if (mask & ATTR_MODE) {
> -		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
> +		error = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
>  		if (error)
>  			return error;
>  	}
> @@ -868,7 +873,7 @@ xfs_setattr_size(
>  		 * Use the regular setattr path to update the timestamps.
>  		 */
>  		iattr->ia_valid &= ~ATTR_SIZE;
> -		return xfs_setattr_nonsize(ip, iattr);
> +		return xfs_setattr_nonsize(&init_user_ns, ip, iattr);

Shouldn't that be passing mnt_userns?

>  	}
>  
>  	/*
> @@ -1037,6 +1042,7 @@ xfs_setattr_size(
>  
>  int
>  xfs_vn_setattr_size(
> +	struct user_namespace	*mnt_userns,
>  	struct dentry		*dentry,
>  	struct iattr		*iattr)
>  {
> @@ -1045,7 +1051,7 @@ xfs_vn_setattr_size(
>  
>  	trace_xfs_setattr(ip);
>  
> -	error = xfs_vn_change_ok(dentry, iattr);
> +	error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
>  	if (error)
>  		return error;
>  	return xfs_setattr_size(ip, iattr);

And this passing mnt_userns down into xfs_setattr_size()?  Seems
like a bit of a landmine...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
