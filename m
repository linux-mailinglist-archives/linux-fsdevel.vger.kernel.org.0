Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2088978335
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 04:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfG2CAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 22:00:45 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58615 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726216AbfG2CAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 22:00:45 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6T20BFl005802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 22:00:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0C9074202F5; Sun, 28 Jul 2019 22:00:10 -0400 (EDT)
Date:   Sun, 28 Jul 2019 22:00:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 16/16] fscrypt: document the new ioctls and policy
 version
Message-ID: <20190729020009.GA3863@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-17-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-17-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:41PM -0700, Eric Biggers wrote:
> +- The kernel cannot magically wipe copies of the master key(s) that
> +  userspace might have as well.  Therefore, userspace must wipe all
> +  copies of the master key(s) it makes as well.  Naturally, the same
> +  also applies to all higher levels in the key hierarchy.  Userspace
> +  should also follow other security precautions such as mlock()ing
> +  memory containing keys to prevent it from being swapped out.

Normally, shouldn't userspace have wiped all copies of the master key
after they have called ADD_KEY?  Why should they be left hanging
around?  Waiting until REMOVE_KEY to remove other copies of the master
key seems.... late.

> +- In general, decrypted contents and filenames in the kernel VFS
> +  caches are freed but not wiped.  Therefore, portions thereof may be
> +  recoverable from freed memory, even after the corresponding key(s)
> +  were wiped.  To partially solve this, you can set
> +  CONFIG_PAGE_POISONING=y in your kernel config and add page_poison=1
> +  to your kernel command line.  However, this has a performance cost.

... and even this won't help if you have swap configured....

> +v1 encryption policies have some weaknesses with respect to online
> +attacks:
> +
> +- There is no verification that the provided master key is correct.
> +  Consequently, malicious users can associate the wrong key with
> +  encrypted files, even files to which they have only read-only
> +  access.

Yes, but they won't be able to trick other users into using that
incorrect key.  With the old interface, it gets written into the
user's session keyring, which won't get used by another user.  And
with the newer interface, only root is allowed to set v1 key.

> +Master keys should be pseudorandom, i.e. indistinguishable from random
> +bytestrings of the same length.  This implies that users **must not**
> +directly use a password as a master key, zero-pad a shorter key, or
> +repeat a shorter key.

These paragraphs starts a bit funny, since we first say "should" in
the first sentence, and then it's followed up by "**must not**" in the
second sentence.  Basically, they *could* do this, but it would just
weaken the security of the system significantly.

At the very least, we should explain the basis of the recommendation.

> +The KDF used for a particular master key differs depending on whether
> +the key is used for v1 encryption policies or for v2 encryption
> +policies.  Users **must not** use the same key for both v1 and v2
> +encryption policies.

"Must not" seems a bit strong.  If they do, and a v1 per-file key and
nonce leaks out, then the encryption key will be compromised.  So the
strength of the key will be limited by the weaknesses of the v1
scheme.  But it's not like using a that was originally meant for v1,
and then using it for v2, causes any additional weakness.  Right?

    	       	      	  	 - Ted
