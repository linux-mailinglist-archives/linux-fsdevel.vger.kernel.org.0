Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70B3657D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhDTLqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 07:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhDTLqa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEFA0613B4;
        Tue, 20 Apr 2021 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618919159;
        bh=Q19hZIUoPWyy0AAOTHQ7niqZrttpFzMNViz3CShMRZA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LiHbc8Tl+/srjiQnJJjlXuCfLxAHwKHPZ20hF6WWqnhaZr7Op3+3OuxT18FaNiGKQ
         OGS+C8vgaZZUPplgeVyR9iWzLyyYo9Ki2zToPf4yrUTmxReWgCqkH8Xu6WzxEyfsze
         U2lpzpJeZk/5QTLWeIQfIn0R1aKjcbBxtNZw7CHA1k2T62CD67dE5RCufrSBh/JtE1
         n9zG8bKaGfN2oWPHGL44hURIYJXsbCGtEqzMw/8olS1fImept12c5NHrah2QRRIrH9
         vGXyOHkpQRltAXYJE10djRSV+sEXLTBxa+FwHsIz31xvhQmKY/evXaKb0RLlYi2lMg
         XogV8kzyz4qaA==
Message-ID: <722e3715508fcbeb63082c2c8058350925cd03a2.camel@kernel.org>
Subject: Re: [RFC PATCH v6 20/20] ceph: add fscrypt ioctls
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Luis Henriques <lhenriques@suse.de>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Date:   Tue, 20 Apr 2021 07:45:57 -0400
In-Reply-To: <YH3f6YQ7cxWCVb+b@gmail.com>
References: <20210413175052.163865-1-jlayton@kernel.org>
         <20210413175052.163865-21-jlayton@kernel.org> <87lf9emvqv.fsf@suse.de>
         <f6fa8d02d31099a688ae97450143aa0eed4b73f8.camel@kernel.org>
         <YH3f6YQ7cxWCVb+b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-04-19 at 12:54 -0700, Eric Biggers wrote:
> On Mon, Apr 19, 2021 at 08:19:59AM -0400, Jeff Layton wrote:
> > On Mon, 2021-04-19 at 11:09 +0100, Luis Henriques wrote:
> > > Hi Jeff!
> > > 
> > > Jeff Layton <jlayton@kernel.org> writes:
> > > <...>
> > > > +
> > > > +	case FS_IOC_ADD_ENCRYPTION_KEY:
> > > > +		ret = vet_mds_for_fscrypt(file);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +		atomic_inc(&ci->i_shared_gen);
> > > 
> > > After spending some (well... a lot, actually) time looking at the MDS code
> > > to try to figure out my bug, I'm back at this point in the kernel client
> > > code.  I understand that this code is trying to invalidate the directory
> > > dentries here.  However, I just found that the directory we get at this
> > > point is the filesystem root directory, and not the directory we're trying
> > > to unlock.
> > > 
> > > So, I still don't fully understand the issue I'm seeing, but I believe the
> > > code above is assuming 'ci' is the inode being unlocked, which isn't
> > > correct.
> > > 
> > > (Note: I haven't checked if there are other ioctls getting the FS root.)
> > > 
> > > Cheers,
> > 
> > 
> > Oh, interesting. That was my assumption. I'll have to take a look more
> > closely at what effect that might have then.
> > 
> 
> FS_IOC_ADD_ENCRYPTION_KEY, FS_IOC_REMOVE_ENCRYPTION_KEY,
> FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS, and FS_IOC_GET_ENCRYPTION_KEY_STATUS can
> all be executed on any file or directory on the filesystem (but preferably on
> the root directory) because they are operations on the filesystem, not on any
> specific file or directory.  They deal with encryption keys, which can protect
> any number of encrypted directories (even 0 or a large number) and/or even loose
> encrypted files that got moved into an unencrypted directory.
> 
> Note that this is all described in the documentation
> (https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html).
> If the documentation is unclear please suggest improvements to it.
> 
> Also, there shouldn't be any need for FS_IOC_ADD_ENCRYPTION_KEY to invalidate
> dentries itself because that is the point of fscrypt_d_revalidate(); the
> invalidation happens on-demand later.


Ok, thanks. I'll plan to drop the invalidation from the ioctl codepaths,
and leave it up to fscrypt_d_revalidate to sort out.
-- 
Jeff Layton <jlayton@kernel.org>

