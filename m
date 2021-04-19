Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1980364ACE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 21:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbhDSTyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 15:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238012AbhDSTyt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:54:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBCA261260;
        Mon, 19 Apr 2021 19:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618862058;
        bh=EnWyV5/HKeUsnWrosGTQbWaebc74KqZkeXyv0uWI3Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETsGNXXhc7gzUmLmFJKLNMJRwmRRUCwr9KXRcjSkMVmz8lEJuaUxD+jWgBiXVLrmg
         xp31Ez0prhag4CG7Z3O7uYNeQgL42Myy30xkQMLv3BBrYIA6icz1oOZDlOWtwoXm8/
         0juSCKfzBh2/dNk69kLuhOvdEVlo0+v0WlHn6k+beNLhNDtCyoYE/CsCiBjWUhfvlX
         kM41z8ozI5ub8FpdRT/zoj+zWSP5pFsuNrTmsXItHqQzwYB1oPbaY2g7AiCqm1M7Bx
         fQzI0YCSxZ+SvSVO6z0D40C+yQXqC85M0W0awPvgcE8WxGKbdK8j/m07FXyO1b6RZm
         DBdpL4lojDg3Q==
Date:   Mon, 19 Apr 2021 12:54:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Luis Henriques <lhenriques@suse.de>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v6 20/20] ceph: add fscrypt ioctls
Message-ID: <YH3f6YQ7cxWCVb+b@gmail.com>
References: <20210413175052.163865-1-jlayton@kernel.org>
 <20210413175052.163865-21-jlayton@kernel.org>
 <87lf9emvqv.fsf@suse.de>
 <f6fa8d02d31099a688ae97450143aa0eed4b73f8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fa8d02d31099a688ae97450143aa0eed4b73f8.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 08:19:59AM -0400, Jeff Layton wrote:
> On Mon, 2021-04-19 at 11:09 +0100, Luis Henriques wrote:
> > Hi Jeff!
> > 
> > Jeff Layton <jlayton@kernel.org> writes:
> > <...>
> > > +
> > > +	case FS_IOC_ADD_ENCRYPTION_KEY:
> > > +		ret = vet_mds_for_fscrypt(file);
> > > +		if (ret)
> > > +			return ret;
> > > +		atomic_inc(&ci->i_shared_gen);
> > 
> > After spending some (well... a lot, actually) time looking at the MDS code
> > to try to figure out my bug, I'm back at this point in the kernel client
> > code.  I understand that this code is trying to invalidate the directory
> > dentries here.  However, I just found that the directory we get at this
> > point is the filesystem root directory, and not the directory we're trying
> > to unlock.
> > 
> > So, I still don't fully understand the issue I'm seeing, but I believe the
> > code above is assuming 'ci' is the inode being unlocked, which isn't
> > correct.
> > 
> > (Note: I haven't checked if there are other ioctls getting the FS root.)
> > 
> > Cheers,
> 
> 
> Oh, interesting. That was my assumption. I'll have to take a look more
> closely at what effect that might have then.
> 

FS_IOC_ADD_ENCRYPTION_KEY, FS_IOC_REMOVE_ENCRYPTION_KEY,
FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS, and FS_IOC_GET_ENCRYPTION_KEY_STATUS can
all be executed on any file or directory on the filesystem (but preferably on
the root directory) because they are operations on the filesystem, not on any
specific file or directory.  They deal with encryption keys, which can protect
any number of encrypted directories (even 0 or a large number) and/or even loose
encrypted files that got moved into an unencrypted directory.

Note that this is all described in the documentation
(https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html).
If the documentation is unclear please suggest improvements to it.

Also, there shouldn't be any need for FS_IOC_ADD_ENCRYPTION_KEY to invalidate
dentries itself because that is the point of fscrypt_d_revalidate(); the
invalidation happens on-demand later.

- Eric
