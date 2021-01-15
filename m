Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFDB2F80A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbhAOQYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 11:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhAOQYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:24:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2766C0613C1;
        Fri, 15 Jan 2021 08:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EUWYO0kUNOPL0+8rq+jqNdckkmjaAICmJuUUQfapnmg=; b=JYVtCComagNhb7hqCp7+K8cypw
        3uzb/XWKSiI2wd079jfEh54E6UXbFNCkIXVtdMz85yoJmiYJ9S2w+4QoKhU1MSjyIOqb1p214g57v
        OYst5auFjT2CF13mk3P4uIRmdte6st+AwYPpwos0v4T/lMifmY9WrdQQJ/mDBdVXp56iuYGKsQtWe
        O2pK8U4clVUk2Sb9MeZFm3JHZxeH3A33eY9EJJ0tIyij6zOm4YqyFbZOyr+g0qLdX/iyHinGps0g6
        AsBdYcDqwjotOAlFnNds/nv+o8gK+6xKbVC4xJsqmvstk6kUedtXelBk3y7JipjaWC7Ly0vyoHz+5
        /kQvaNBw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l0RsA-0099BH-9Q; Fri, 15 Jan 2021 16:22:55 +0000
Date:   Fri, 15 Jan 2021 16:22:50 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        St?phane Graber <stgraber@ubuntu.com>,
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
Message-ID: <20210115162250.GA2179337@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-38-christian.brauner@ubuntu.com>
 <20210114205154.GL331610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114205154.GL331610@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 07:51:54AM +1100, Dave Chinner wrote:
> > @@ -813,7 +818,7 @@ xfs_setattr_nonsize(
> >  	 * 	     Posix ACL code seems to care about this issue either.
> >  	 */
> >  	if (mask & ATTR_MODE) {
> > -		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
> > +		error = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
> >  		if (error)
> >  			return error;
> >  	}
> > @@ -868,7 +873,7 @@ xfs_setattr_size(
> >  		 * Use the regular setattr path to update the timestamps.
> >  		 */
> >  		iattr->ia_valid &= ~ATTR_SIZE;
> > -		return xfs_setattr_nonsize(ip, iattr);
> > +		return xfs_setattr_nonsize(&init_user_ns, ip, iattr);
> 
> Shouldn't that be passing mnt_userns?

As Christian already explained we an't hit this with anything related
to uids/gids, the only thing that will be updated are the timestamps,
as also mentioned in the comment that only makes it partially into the
diff context.

> >  	trace_xfs_setattr(ip);
> >  
> > -	error = xfs_vn_change_ok(dentry, iattr);
> > +	error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
> >  	if (error)
> >  		return error;
> >  	return xfs_setattr_size(ip, iattr);
> 
> And this passing mnt_userns down into xfs_setattr_size()?  Seems
> like a bit of a landmine...

That being said we could just pass down the argument, even if it doesn't
make much sense for the size update.
