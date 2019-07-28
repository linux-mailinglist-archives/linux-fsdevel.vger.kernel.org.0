Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984B0781B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 23:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfG1VSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 17:18:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35341 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726252AbfG1VSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 17:18:05 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6SLHVFd011138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 17:17:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5DD5D4202F5; Sun, 28 Jul 2019 17:17:30 -0400 (EDT)
Date:   Sun, 28 Jul 2019 17:17:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 10/16] fscrypt: v2 encryption policy support
Message-ID: <20190728211730.GK6088@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-11-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-11-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:35PM -0700, Eric Biggers wrote:
> @@ -319,6 +329,31 @@ int fscrypt_ioctl_add_key(struct file *filp, void __user *_uarg)
>  	if (!capable(CAP_SYS_ADMIN))
>  		goto out_wipe_secret;
>  
> +	if (arg.key_spec.type != FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR) {

This should be "== FSCRYPT_KEY_SPEC_TYPE_INDENTIFIER" instead.  That's
because you use the identifier part of the union:

> +		/* Calculate the key identifier and return it to userspace. */
> +		err = fscrypt_hkdf_expand(&secret.hkdf,
> +					  HKDF_CONTEXT_KEY_IDENTIFIER,
> +					  NULL, 0, arg.key_spec.u.identifier,

If we ever add a new key specifier type, and alternative in the union,
this is going to come back to bite us.

> +	if (policy->version == FSCRYPT_POLICY_V1) {
> +		/*
> +		 * The original encryption policy version provided no way of
> +		 * verifying that the correct master key was supplied, which was
> +		 * insecure in scenarios where multiple users have access to the
> +		 * same encrypted files (even just read-only access).

Which scenario do you have in mind?  With read-only access, Alice can
fetch the encryption policy for a directory, and introduce a key with
the same descriptor, but the "wrong" key, but that's only going to
affect Alice's use of the key.  It won't affect what key is used by
Bob, since Alice doesn't have write access to Bob's keyrings.

If what you mean is the risk when there is a single global
filesystem-specific keyring, where Alice could introduce a "wrong" key
identified with a specific descriptor, then sure, Alice could trick
Bob into encrypting his data with the wrong key (one known to Alice).
But we don't allow keys usable by V1 policies to be used in the
filesystem-specific keyring, do we?

						- Ted
