Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8116C799F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 22:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfG2U3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 16:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfG2U3z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:29:55 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FB620679;
        Mon, 29 Jul 2019 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564432194;
        bh=7LK4u/xXVtAq5xQMkemCjB4sBIVdQGteWvKYNQ+TBCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPew4TPf3PkKUXWtCLWWIQsryuZDmRsZW9HWBPCFmul6GOPKrMhWsOP2j0s6E1587
         pPpWGjXg0oLEblY9YgIrbRyuoJDVlQC0LdMHo0X3YE5xtPBbo3Oz6TZzJnytmQbINO
         1di8FZ/AmOwFvTEDEuqxMDphn/LIvGf9Grr0aIA8=
Date:   Mon, 29 Jul 2019 13:29:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 09/16] fscrypt: add an HKDF-SHA512 implementation
Message-ID: <20190729202951.GG169027@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-10-ebiggers@kernel.org>
 <20190728193949.GI6088@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728193949.GI6088@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 28, 2019 at 03:39:49PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 26, 2019 at 03:41:34PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add an implementation of HKDF (RFC 5869) to fscrypt, for the purpose of
> > deriving additional key material from the fscrypt master keys for v2
> > encryption policies.  HKDF is a key derivation function built on top of
> > HMAC.  We choose SHA-512 for the underlying unkeyed hash, and use an
> > "hmac(sha512)" transform allocated from the crypto API.
> > 
> > We'll be using this to replace the AES-ECB based KDF currently used to
> > derive the per-file encryption keys.  While the AES-ECB based KDF is
> > believed to meet the original security requirements, it is nonstandard
> > and has problems that don't exist in modern KDFs such as HKDF:
> > 
> > 1. It's reversible.  Given a derived key and nonce, an attacker can
> >    easily compute the master key.  This is okay if the master key and
> >    derived keys are equally hard to compromise, but now we'd like to be
> >    more robust against threats such as a derived key being compromised
> >    through a timing attack, or a derived key for an in-use file being
> >    compromised after the master key has already been removed.
> > 
> > 2. It doesn't evenly distribute the entropy from the master key; each 16
> >    input bytes only affects the corresponding 16 output bytes.
> > 
> > 3. It isn't easily extensible to deriving other values or keys, such as
> >    a public hash for securely identifying the key, or per-mode keys.
> >    Per-mode keys will be immediately useful for Adiantum encryption, for
> >    which fscrypt currently uses the master key directly, introducing
> >    unnecessary usage constraints.  Per-mode keys will also be useful for
> >    hardware inline encryption, which is currently being worked on.
> > 
> > HKDF solves all the above problems.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Unless I missed something there's nothing here which is fscrypt
> specific.  Granted that it's somewhat unlikely that someone would want
> to implement (the very bloated) IKE from IPSEC in the kernel, I wonder
> if there might be other users of HKDF, and whether this would be
> better placed in lib/ or crypto/ instead of fs/crypto?
> 

This is standard HKDF-SHA512; only the choice of parameters is fscrypt-specific.
So it could indeed use a common implementation of HKDF if one were available.

However, I don't think there are any other HKDF users in the kernel currently.
Also, while there was a patch to support HKDF via the crypto_rng API, there was
no consensus about whether this was actually the best way to add KDF support:
https://lore.kernel.org/linux-crypto/2423373.Zd5ThvQH5g@positron.chronox.de

So for now, to avoid unnecessarily blocking this patchset I think we should just
go with this implementation in fs/crypto/.  It can always be changed later, once
we decide on the best way to add KDFs to the crypto API.

[To be clear: this patch already uses "hmac(sha512)" from the crypto API.  It's
only the actual HKDF part that we're talking about here.

Also, its correctness is tested by the ciphertext verification xfstests.]

- Eric
