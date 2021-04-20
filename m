Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A531365574
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhDTJdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 05:33:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhDTJdI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:33:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93284B2DD;
        Tue, 20 Apr 2021 09:32:36 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 3ec5d8ea;
        Tue, 20 Apr 2021 09:34:05 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v6 20/20] ceph: add fscrypt ioctls
References: <20210413175052.163865-1-jlayton@kernel.org>
        <20210413175052.163865-21-jlayton@kernel.org> <87lf9emvqv.fsf@suse.de>
        <f6fa8d02d31099a688ae97450143aa0eed4b73f8.camel@kernel.org>
        <YH3f6YQ7cxWCVb+b@gmail.com>
Date:   Tue, 20 Apr 2021 10:34:04 +0100
In-Reply-To: <YH3f6YQ7cxWCVb+b@gmail.com> (Eric Biggers's message of "Mon, 19
        Apr 2021 12:54:17 -0700")
Message-ID: <87wnsxl2pf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Mon, Apr 19, 2021 at 08:19:59AM -0400, Jeff Layton wrote:
>> On Mon, 2021-04-19 at 11:09 +0100, Luis Henriques wrote:
>> > Hi Jeff!
>> > 
>> > Jeff Layton <jlayton@kernel.org> writes:
>> > <...>
>> > > +
>> > > +	case FS_IOC_ADD_ENCRYPTION_KEY:
>> > > +		ret = vet_mds_for_fscrypt(file);
>> > > +		if (ret)
>> > > +			return ret;
>> > > +		atomic_inc(&ci->i_shared_gen);
>> > 
>> > After spending some (well... a lot, actually) time looking at the MDS code
>> > to try to figure out my bug, I'm back at this point in the kernel client
>> > code.  I understand that this code is trying to invalidate the directory
>> > dentries here.  However, I just found that the directory we get at this
>> > point is the filesystem root directory, and not the directory we're trying
>> > to unlock.
>> > 
>> > So, I still don't fully understand the issue I'm seeing, but I believe the
>> > code above is assuming 'ci' is the inode being unlocked, which isn't
>> > correct.
>> > 
>> > (Note: I haven't checked if there are other ioctls getting the FS root.)
>> > 
>> > Cheers,
>> 
>> 
>> Oh, interesting. That was my assumption. I'll have to take a look more
>> closely at what effect that might have then.
>> 
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

I think the documentation is very clear regarding these ioctls.  I guess I
just need to go refresh my memory as I have read that document long time
ago.  Thanks for reminding me to do that ;-)

Cheers,
-- 
Luis
