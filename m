Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7547D4E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 07:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfHAFba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 01:31:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39061 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbfHAFba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:31:30 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x715V9Rn013938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Aug 2019 01:31:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EEE8D4202F5; Thu,  1 Aug 2019 01:31:08 -0400 (EDT)
Date:   Thu, 1 Aug 2019 01:31:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [f2fs-dev] [PATCH v7 07/16] fscrypt: add
 FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
Message-ID: <20190801053108.GD2769@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-8-ebiggers@kernel.org>
 <20190728192417.GG6088@mit.edu>
 <20190729195827.GF169027@gmail.com>
 <20190731183802.GA687@sol.localdomain>
 <20190731233843.GA2769@mit.edu>
 <20190801011140.GB687@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801011140.GB687@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 06:11:40PM -0700, Eric Biggers wrote:
> 
> Well, it's either
> 
> 1a. Remove the user's handle.
> 	OR 
> 1b. Remove all users' handles.  (FSCRYPT_REMOVE_KEY_FLAG_ALL_USERS)
> 
> Then
> 
> 2. If no handles remain, try to evict all inodes that use the key.
> 
> By "purge all keys" do you mean step (2)?  Note that it doesn't require root by
> itself; root is only required to remove other users' handles (1b).

No, I was talking about 1b.  I'd argue that 1a and 1b should be
different ioctl.  1b requires root, and 1a doesn't.

And 1a should just mean, "I don't need to use the encrypted files any
more".  In the PAM passphrase case, when you are just logging out, 1a
is what's needed, and success is just fine.  pam_session won't *care*
whether or not there are other users keeping the key in use.

The problem with "fscrypt lock" is that the non-privileged user sort
of wants to do REMOVE_FLAG_KEY_FLAG_FOR_ALL_USERS, but they doesn't
have the privileges to do it, and they are hoping that removing their
own key removes it the key from the system.  That to me seems to be
the fundamental disconnect.  The "fscrypt unlock" and "fscrypt lock"
commands comes from the v1 key management, and requires root.  It's
the translation to unprivileged mode where "fscrypt lock" seems to
have problems.

> > What about having "fscrypt lock" call FS_IOC_GET_ENCRYPTION_KEY_STATUS
> > and print a warning message saying, "we can't lock it because N other
> > users who have registered a key".  I'd argue fscrypt should do this
> > regardless of whether or not FS_IOC_REMOVE_ENCRYPTION_KEY returns
> > EUSERS or not.
> 
> Shouldn't "fscrypt lock" still remove the user's handle, as opposed to refuse to
> do anything, though?  So it would still need to callh
> FS_IOC_REMOVE_ENCRYPTION_KEY, and could get the status from it rather than also
> needing to call FS_IOC_GET_ENCRYPTION_KEY_STATUS.
> 
> Though, FS_IOC_GET_ENCRYPTION_KEY_STATUS would be needed if we wanted to show
> the specific count of other users.
 
So my perspective is that the ioctl's should have very clean
semantics, and errors should be consistent with how the Unix system
calls and error reporting.

If we need to make "fscrypt lock" and "fscrypt unlock" have semantics
that are more consistent with previous user interface choices, then
fscrypt can use FS_IOC_GET_ENCRYPTION_KEY_STATUS to print the warning
before it calls FS_IOC_REMOVE_ENCRYPTION_KEY --- with "fscrypt purge_keys"
calling something like FS_IOC_REMOVE_ALL_USER_ENCRYPTION_KEYS.

> > It seems to me that the EBUSY and EUSERS errors should be status bits
> > which gets returned to the user in a bitfield --- and if the key has
> > been removed, or the user's claim on the key's existence has been
> > removed, the ioctl returns success.
> > 
> > That way we don't have to deal with the semantic disconnect where some
> > errors don't actually change system state, and other errors that *do*
> > change system state (as in, the key gets removed, or the user's claim
> > on the key gets removed), but still returns than error.
> > 
> 
> Do you mean use a positive return value, or do you mean add an output field to
> the struct passed to the ioctl?

I meant adding an output field.  I see EBUSY and EUSERS as status bits
which *some* use cases might find useful.  Other use cases, such as in
the pam_keys session logout code, we won't care at *all* about those
status reporting (or error codes).  So if EBUSY and EUSERS are
returned as errors, then it adds to complexity of those programs
whichd don't care.  (And even for those that do, it's still a bit more
complex since they has to distinguish between EBUSY, EUSERS, or other
errors --- in fact, *all* programs which use
FS_IOC_REMOVE_ENCRYPTION_KEY will *have* to check for EBUSY and
ESUSERS whether they care or not.)

> Either way note that it doesn't really need to be a bitfield, since you can't
> have both statuses at the same time.  I.e. if there are still other users, we
> couldn't have even gotten to checking for in-use files.

That's actually an implementation detail, though, right?  In theory,
we could check to see if there are any in-use files, independently of
whether there are any users or not.

					- Ted
