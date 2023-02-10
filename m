Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DA69288D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 21:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjBJUnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 15:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjBJUnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:43:15 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900447070A
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 12:43:13 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31AKguqB016352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 15:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676061778; bh=pdTppfBFbu942mayOz5ovqBKLYyjLl+xg3ENsgaZyAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GUUyc8wRKs/V5GBvzJ5p2NX5/KKjt4ybnyWOZJrIadSFzQPd91yS5hql4QOpEHXy+
         K8hQMkSpOsy2/8BucH35Ob+AQ8t3AHdl2ftpK2bNZQq92zbZESq5K4z7fltsyj2ZyI
         aTPonDLDK5zoBwKT8UniDuE8kBTz96AJn2HZhuK8RYCyMzfRGTnFHYeZdCuQLyl3NR
         SNjCxFS6jbINL5PmOS2uIU2bQOw804vCOg4RWkHiQncuCvbt8HRzxavNDoJ9Lgn8BW
         W9667OBJt+wev8dUiyJ2/7bdEzu6SpXixivcp3klpWsuYvYXiITooyX+tmt2rYYpmp
         JFJumg2/SUghA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BCE0315C340F; Fri, 10 Feb 2023 15:42:56 -0500 (EST)
Date:   Fri, 10 Feb 2023 15:42:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sebastien Buisson <sbuisson.work@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: Backup/restore of fscrypt files and directories
Message-ID: <Y+asUDeRFGpig+wG@mit.edu>
References: <03a87391-1b19-de2d-5c18-581c1d0c47ca@gmail.com>
 <Y+P3wumJK/znOKgl@gmail.com>
 <0eaf08a8-ddec-5158-ab2b-ae7e3e1bab9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eaf08a8-ddec-5158-ab2b-ae7e3e1bab9b@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 02:44:22PM +0100, Sebastien Buisson wrote:
> As for symlinks, you are right I need to dig further. I think at least the
> security.encdata xattr would need an additional field to hold the ciphertext
> symlink target.

So I'd caution you against the concept of using the security.encdata
xattr.  In propose, it's being used in two different ways.  The first
way is as a system call / ioctl like way, and that's something which
is very much frowned upon, at least by many in the Kernel community.
The red flag here is when you say that the xattr isn't actually stored
on disk, but rather is created on the fly when the xattr is fetched.
If you need to fetch information from the kernel that's not stored as
part of the on-disk format, then use an ioctl or a system call.  Don't
try to turn the xattr interface into a system call / ioctl extension
like thing.

The other way you're using the encdata is that you're presuming that
this is how you'd store the information in the tar format.  And how we
fetch information from the kernel, and how it is stored as an exchange
format, should be decoupled as much as possible.

In the case of a tar archive, the symlink target is normally stored in
the data block of the tar archive.  In the case where the symlink is
encrypted, why should that change?  We aren't storing the encrypted
data in a different location, such as the encdata xattr; why should
that be different in the case of the symlink target?

Now, how you *fetch* the encrypted symlink target might be different,
such as how we fetch the contents of an unencrypted data file (via the
read system call) and how we fetch an unencrypted symlink target (via
the readlink system call) are different.

> > A description of the use cases of this feature would also be helpful.
> > Historically, people have said they needed this feature when they really didn't.
> 
> There is really a need for backup/restore at the file system level. For
> instance, in case of storage failure, we would want to restore files to a
> newly formatted device, in a finner granularity that cannot be achieved with
> a backup/restore at the device level, or because that would allow changing
> formatting options. Also, it particularly makes sense to have per-directory
> backups, as the block devices are getting larger and larger.
> 
> The ability to backup and restore encrypted files is interesting in annother
> use case: moving files between file systems and systems without the need to
> decrypt then re-encrypt.

The use case of being able to restore files without needing to decrypt
and re-encrypt is quite different from the use case where you want to
be able to backup the files without needing encryption keys present,
but the encryption keys *are* needed at restore time is quite
different --- and the latter is quite a bit easier.

For example, some of encryption modes which use the inode number as
part of the IV, could be handled if keys are needed at restore time;
but it would be quite a bit harder, if not impossible, if you want to
be able restore the ecrypted files without doing a decrypt/re-encrypt
pass.

Can you give more details about why you are interested in implementing
this?  Does your company have a more specific business justification
for wanting to invest in this work?  If so, can you say more about it?

The reason why I ask is because very often fscrypt gets used in
integrated solutions, where the encryption/decryption engine is done
in-line between the general purpose CPU and the storage device.  In
some cases, the users' encryption keys might be stored in a something
like ARM TrustZone or in some other specialized trusted key manager
where even the kernel running in the general purpose hardware won't
have access to *any* of the keys.  It's for that reason that we have
some of these alternate modes where the inode number is used as part
of the IV, as opposed to the more traditional scheme where the user's
key is used to derive a file-specific subkey.

One of the original use cases for fscrypt was for Android and ChromeOS
devices.  And for those devices the state tends to be synchronized
across multiple devices, including web browsers.  So the state ends up
getting saved, unencrypted, in an application specific format, so you
can recover very quickly with no data loss, even if the device gets
lost or destroyed[1]. 

[1] https://www.youtube.com/watch?v=lm-Vnx58UYo

It was for this reason that ultimately, we decided that there really
wasn't a need to back up the data in an encrypted form, since for the
use case that our company was interested in addressing, well over 90%
of the state was of necesity already being backed up in an unencrypted
format.  So it was easier to just backup remaining bits of state, and
if we need decrypt, then re-encrypt in a key which is derived from the
user's login password before it is sent up to the cloud server.

You may be trying to solve the problem in the most general way
possible, but sometimes that's not the best solution, especially once
time to market and cost/complexity of implementation is taken into
account.  As Linus Torvalds stated earlier today, when talking about
splice(2) vs sendfile(2):

   "... this is also very much an example of how "generic" may be
   something that is revered in computer science, but is often a
   *horrible* thing in reality....

   Special cases are often much simpler and easier, and sometimes the
   special cases are all you actually want." [2]

[2] https://lore.kernel.org/all/CAHk-=wip9xx367bfCV8xaF9Oaw4DZ6edF9Ojv10XoxJ-iUBwhA@mail.gmail.com/

> In the case of hard links, I do not know how tar for instance handles this
> for normal files. Do you have any ideas?

   "Tar stores hardlinks in the tarball by storing the first file (of
   a group of hardlinked files); the subsequent hard links to it are
   indicated by a special record. When untarring, encountering this
   record causes tar to create a hard link in the destination
   filesystem." [3]

[3] https://forums.whirlpool.net.au/archive/2787890

Why are you assuming that tar is the best format to use for storing
encrypted files?  It's going to require special extensions to the tar
format, which means it won't necessarily be interoperable across
different tar implementations.  (For example, the hard link support is
specific to GNU tar.)

Does your requirements (and this is why a more detailed explanation of
your use case would be helpful) require supporting hard links?  If it
doesn't and you don't mind storing N copies of the file in the tar
archive file, and not restoring the hard links when the tar file is
unpacked, then life is much simpler.  Which is why it's important to
be very clear about use cases and requirements before trying to design
a solution.

Cheers,

					- Ted
