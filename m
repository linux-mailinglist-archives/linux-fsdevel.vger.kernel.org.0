Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE38A085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfHLORT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 10:17:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33943 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726354AbfHLORS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:17:18 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7CEGtiI013115
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 10:16:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7E7C44218EF; Mon, 12 Aug 2019 10:16:55 -0400 (EDT)
Date:   Mon, 12 Aug 2019 10:16:55 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 07/16] fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
Message-ID: <20190812141655.GA11831@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-8-ebiggers@kernel.org>
 <20190728192417.GG6088@mit.edu>
 <20190729195827.GF169027@gmail.com>
 <20190731183802.GA687@sol.localdomain>
 <20190731233843.GA2769@mit.edu>
 <20190801011140.GB687@sol.localdomain>
 <20190801053108.GD2769@mit.edu>
 <20190801220432.GC223822@gmail.com>
 <20190802043827.GA19201@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802043827.GA19201@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 09:38:27PM -0700, Eric Biggers wrote:
> 
> Here's a slightly updated version (I missed removing some stale text):

Apologies for the delaying in getting back.  Thanks, this looks great.

	      	  	      	      	     - Ted

> 
> Removing keys
> -------------
> 
> Two ioctls are available for removing a key that was added by
> `FS_IOC_ADD_ENCRYPTION_KEY`_:
> 
> - `FS_IOC_REMOVE_ENCRYPTION_KEY`_
> - `FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS`_
> 
> These two ioctls differ only in cases where v2 policy keys are added
> or removed by non-root users.
> 
> These ioctls don't work on keys that were added via the legacy
> process-subscribed keyrings mechanism.
> 
> Before using these ioctls, read the `Kernel memory compromise`_
> section for a discussion of the security goals and limitations of
> these ioctls.
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The FS_IOC_REMOVE_ENCRYPTION_KEY ioctl removes a claim to a master
> encryption key from the filesystem, and possibly removes the key
> itself.  It can be executed on any file or directory on the target
> filesystem, but using the filesystem's root directory is recommended.
> It takes in a pointer to a :c:type:`struct fscrypt_remove_key_arg`,
> defined as follows::
> 
>     struct fscrypt_remove_key_arg {
>             struct fscrypt_key_specifier key_spec;
>     #define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY      0x00000001
>     #define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_OTHER_USERS     0x00000002
>             __u32 removal_status_flags;     /* output */
>             __u32 __reserved[5];
>     };
> 
> This structure must be zeroed, then initialized as follows:
> 
> - The key to remove is specified by ``key_spec``:
> 
>     - To remove a key used by v1 encryption policies, set
>       ``key_spec.type`` to FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR and fill
>       in ``key_spec.u.descriptor``.  To remove this type of key, the
>       calling process must have the CAP_SYS_ADMIN capability in the
>       initial user namespace.
> 
>     - To remove a key used by v2 encryption policies, set
>       ``key_spec.type`` to FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER and fill
>       in ``key_spec.u.identifier``.
> 
> For v2 policy keys, this ioctl is usable by non-root users.  However,
> to make this possible, it actually just removes the current user's
> claim to the key, undoing a single call to FS_IOC_ADD_ENCRYPTION_KEY.
> Only after all claims are removed is the key really removed.
> 
> For example, if FS_IOC_ADD_ENCRYPTION_KEY was called with uid 1000,
> then the key will be "claimed" by uid 1000, and
> FS_IOC_REMOVE_ENCRYPTION_KEY will only succeed as uid 1000.  Or, if
> both uids 1000 and 2000 added the key, then for each uid
> FS_IOC_REMOVE_ENCRYPTION_KEY will only remove their own claim.  Only
> once *both* are removed is the key really removed.  (Think of it like
> unlinking a file that may have hard links.)
> 
> If FS_IOC_REMOVE_ENCRYPTION_KEY really removes the key, it will also
> try to "lock" all files that had been unlocked with the key.  It won't
> lock files that are still in-use, so this ioctl is expected to be used
> in cooperation with userspace ensuring that none of the files are
> still open.  However, if necessary, the ioctl can be executed again
> later to retry locking any remaining files.
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY returns 0 if either the key was removed
> (but may still have files remaining to be locked), the user's claim to
> the key was removed, or the key was already removed but had files
> remaining to be the locked so the ioctl retried locking them.  In any
> of these cases, ``removal_status_flags`` is filled in with the
> following informational status flags:
> 
> - ``FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY``: set if some file(s)
>   are still in-use.  Not guaranteed to be set in the case where only
>   the user's claim to the key was removed.
> - ``FSCRYPT_KEY_REMOVAL_STATUS_FLAG_OTHER_USERS``: set if only the
>   user's claim to the key was removed, not the key itself
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY can fail with the following errors:
> 
> - ``EACCES``: The FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR key specifier type
>   was specified, but the caller does not have the CAP_SYS_ADMIN
>   capability in the initial user namespace
> - ``EINVAL``: invalid key specifier type, or reserved bits were set
> - ``ENOKEY``: the key object was not found at all, i.e. it was never
>   added in the first place or was already fully removed including all
>   files locked; or, the user does not have a claim to the key.
> - ``ENOTTY``: this type of filesystem does not implement encryption
> - ``EOPNOTSUPP``: the kernel was not configured with encryption
>   support for this filesystem, or the filesystem superblock has not
>   had encryption enabled on it
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS is exactly the same as
> `FS_IOC_REMOVE_ENCRYPTION_KEY`_, except that for v2 policy keys, the
> ALL_USERS version of the ioctl will remove all users' claims to the
> key, not just the current user's.  I.e., the key itself will always be
> removed, no matter how many users have added it.  This difference is
> only meaningful if non-root users are adding and removing keys.
> 
> Because of this, FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS also requires
> "root", namely the CAP_SYS_ADMIN capability in the initial user
> namespace.  Otherwise it will fail with ``EACCES``.
