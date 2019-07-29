Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22B479A35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 22:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfG2Uqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 16:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbfG2Uqb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:46:31 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6B0206A2;
        Mon, 29 Jul 2019 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564433190;
        bh=DNMh2YRc0dQISTUq/gkVxZiJ3MfUwE+LBvvMLd0sx0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K79oGysDbp1R9KcVqj1mKpfGB23D0dx9KzJwL1URFJI/8PotFaTXB1QXv/9jPmJ5e
         cd4dzd2ixOf8QsiHSDEd5r1iJBny2qYoC0vd1z0wpsTIbfCpr52p94FTMkHI78oJ2t
         NisulN2mchZN4cYXAX27Nu925MXHkVW50WusaYRo=
Date:   Mon, 29 Jul 2019 13:46:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 10/16] fscrypt: v2 encryption policy support
Message-ID: <20190729204627.GH169027@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-11-ebiggers@kernel.org>
 <20190728211730.GK6088@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728211730.GK6088@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 28, 2019 at 05:17:30PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 26, 2019 at 03:41:35PM -0700, Eric Biggers wrote:
> > @@ -319,6 +329,31 @@ int fscrypt_ioctl_add_key(struct file *filp, void __user *_uarg)
> >  	if (!capable(CAP_SYS_ADMIN))
> >  		goto out_wipe_secret;
> >  
> > +	if (arg.key_spec.type != FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR) {
> 
> This should be "== FSCRYPT_KEY_SPEC_TYPE_INDENTIFIER" instead.  That's
> because you use the identifier part of the union:
> 
> > +		/* Calculate the key identifier and return it to userspace. */
> > +		err = fscrypt_hkdf_expand(&secret.hkdf,
> > +					  HKDF_CONTEXT_KEY_IDENTIFIER,
> > +					  NULL, 0, arg.key_spec.u.identifier,
> 
> If we ever add a new key specifier type, and alternative in the union,
> this is going to come back to bite us.

Well, I did it this way because the next patch changes the code to:

	if (arg.key_spec.type == FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR) {
		...
	} else {
		...
	}

We already validated that it's either TYPE_DESCRIPTOR or TYPE_IDENTIFIER.

But I guess to be more clear I'll just make it handle the default case again.

	switch (arg.key_spec.type) {
	case FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR:
		...
		break;
	case FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER:
		...
		break;
	default:
		err = -EINVAL;
		break;
	}

> 
> > +	if (policy->version == FSCRYPT_POLICY_V1) {
> > +		/*
> > +		 * The original encryption policy version provided no way of
> > +		 * verifying that the correct master key was supplied, which was
> > +		 * insecure in scenarios where multiple users have access to the
> > +		 * same encrypted files (even just read-only access).
> 
> Which scenario do you have in mind?  With read-only access, Alice can
> fetch the encryption policy for a directory, and introduce a key with
> the same descriptor, but the "wrong" key, but that's only going to
> affect Alice's use of the key.  It won't affect what key is used by
> Bob, since Alice doesn't have write access to Bob's keyrings.
> 
> If what you mean is the risk when there is a single global
> filesystem-specific keyring, where Alice could introduce a "wrong" key
> identified with a specific descriptor, then sure, Alice could trick
> Bob into encrypting his data with the wrong key (one known to Alice).
> But we don't allow keys usable by V1 policies to be used in the
> filesystem-specific keyring, do we?
> 

The scenario is that Alice lists the directory with the wrong key, then Bob
lists the directory too and gets the wrong filenames.  This happens because the
inode, fscrypt_info, dentry cache, page cache, etc. are the same for everyone.
Bob's key is never looked up because the inode already has a key cached.

This also applies to regular files and symlinks.

- Eric
