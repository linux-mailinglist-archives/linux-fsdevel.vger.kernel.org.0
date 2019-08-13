Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBA8ABD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHMAOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 20:14:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35401 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726453AbfHMAOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:14:25 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7D0E7I4017125
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 20:14:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1BBDD4218EF; Mon, 12 Aug 2019 20:14:07 -0400 (EDT)
Date:   Mon, 12 Aug 2019 20:14:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v8 14/20] fscrypt: allow unprivileged users to add/remove
 keys for v2 policies
Message-ID: <20190813001406.GI28705@mit.edu>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-15-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805162521.90882-15-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:25:15AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Allow the FS_IOC_ADD_ENCRYPTION_KEY and FS_IOC_REMOVE_ENCRYPTION_KEY
> ioctls to be used by non-root users to add and remove encryption keys
> from the filesystem-level crypto keyrings, subject to limitations.
> 
> Motivation: while privileged fscrypt key management is sufficient for
> some users (e.g. Android and Chromium OS, where a privileged process
> manages all keys), the old API by design also allows non-root users to
> set up and use encrypted directories, and we don't want to regress on
> that.  Especially, we don't want to force users to continue using the
> old API, running into the visibility mismatch between files and keyrings
> and being unable to "lock" encrypted directories.
> 
> Intuitively, the ioctls have to be privileged since they manipulate
> filesystem-level state.  However, it's actually safe to make them
> unprivileged if we very carefully enforce some specific limitations.
> 
> First, each key must be identified by a cryptographic hash so that a
> user can't add the wrong key for another user's files.  For v2
> encryption policies, we use the key_identifier for this.  v1 policies
> don't have this, so managing keys for them remains privileged.
> 
> Second, each key a user adds is charged to their quota for the keyrings
> service.  Thus, a user can't exhaust memory by adding a huge number of
> keys.  By default each non-root user is allowed up to 200 keys; this can
> be changed using the existing sysctl 'kernel.keys.maxkeys'.
> 
> Third, if multiple users add the same key, we keep track of those users
> of the key (of which there remains a single copy), and won't really
> remove the key, i.e. "lock" the encrypted files, until all those users
> have removed it.  This prevents denial of service attacks that would be
> possible under simpler schemes, such allowing the first user who added a
> key to remove it -- since that could be a malicious user who has
> compromised the key.  Of course, encryption keys should be kept secret,
> but the idea is that using encryption should never be *less* secure than
> not using encryption, even if your key was compromised.
> 
> We tolerate that a user will be unable to really remove a key, i.e.
> unable to "lock" their encrypted files, if another user has added the
> same key.  But in a sense, this is actually a good thing because it will
> avoid providing a false notion of security where a key appears to have
> been removed when actually it's still in memory, available to any
> attacker who compromises the operating system kernel.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good.  I'd probably would have used either "mk_secret_sem" or
"mk->mk_secret_sem" in the comments, instead of "->mk_securet_sem",
but that's just a personal style preference.  Since you consistently
used the latter, I assume that's a deliberate choice, which is fine.

Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

