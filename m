Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9968AC0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 02:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfHMAj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 20:39:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40163 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726453AbfHMAj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:39:56 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7D0dcO9023746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 20:39:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B8C504218EF; Mon, 12 Aug 2019 20:39:37 -0400 (EDT)
Date:   Mon, 12 Aug 2019 20:39:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v8 13/20] fscrypt: v2 encryption policy support
Message-ID: <20190813003937.GK28705@mit.edu>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-14-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805162521.90882-14-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:25:14AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a new fscrypt policy version, "v2".  It has the following changes
> from the original policy version, which we call "v1" (*):
> 
> - Master keys (the user-provided encryption keys) are only ever used as
>   input to HKDF-SHA512.  This is more flexible and less error-prone, and
>   it avoids the quirks and limitations of the AES-128-ECB based KDF.
>   Three classes of cryptographically isolated subkeys are defined:
> 
>     - Per-file keys, like used in v1 policies except for the new KDF.
> 
>     - Per-mode keys.  These implement the semantics of the DIRECT_KEY
>       flag, which for v1 policies made the master key be used directly.
>       These are also planned to be used for inline encryption when
>       support for it is added.
> 
>     - Key identifiers (see below).
> 
> - Each master key is identified by a 16-byte master_key_identifier,
>   which is derived from the key itself using HKDF-SHA512.  This prevents
>   users from associating the wrong key with an encrypted file or
>   directory.  This was easily possible with v1 policies, which
>   identified the key by an arbitrary 8-byte master_key_descriptor.
> 
> - The key must be provided in the filesystem-level keyring, not in a
>   process-subscribed keyring.
> 
> The following UAPI additions are made:
> 
> - The existing ioctl FS_IOC_SET_ENCRYPTION_POLICY can now be passed a
>   fscrypt_policy_v2 to set a v2 encryption policy.  It's disambiguated
>   from fscrypt_policy/fscrypt_policy_v1 by the version code prefix.
> 
> - A new ioctl FS_IOC_GET_ENCRYPTION_POLICY_EX is added.  It allows
>   getting the v1 or v2 encryption policy of an encrypted file or
>   directory.  The existing FS_IOC_GET_ENCRYPTION_POLICY ioctl could not
>   be used because it did not have a way for userspace to indicate which
>   policy structure is expected.  The new ioctl includes a size field, so
>   it is extensible to future fscrypt policy versions.
> 
> - The ioctls FS_IOC_ADD_ENCRYPTION_KEY, FS_IOC_REMOVE_ENCRYPTION_KEY,
>   and FS_IOC_GET_ENCRYPTION_KEY_STATUS now support managing keys for v2
>   encryption policies.  Such keys are kept logically separate from keys
>   for v1 encryption policies, and are identified by 'identifier' rather
>   than by 'descriptor'.  The 'identifier' need not be provided when
>   adding a key, since the kernel will calculate it anyway.
> 
> This patch temporarily keeps adding/removing v2 policy keys behind the
> same permission check done for adding/removing v1 policy keys:
> capable(CAP_SYS_ADMIN).  However, the next patch will carefully take
> advantage of the cryptographically secure master_key_identifier to allow
> non-root users to add/remove v2 policy keys, thus providing a full
> replacement for v1 policies.
> 
> (*) Actually, in the API fscrypt_policy::version is 0 while on-disk
>     fscrypt_context::format is 1.  But I believe it makes the most sense
>     to advance both to '2' to have them be in sync, and to consider the
>     numbering to start at 1 except for the API quirk.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
