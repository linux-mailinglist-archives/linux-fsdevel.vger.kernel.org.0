Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F8778141
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 21:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfG1TkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 15:40:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46025 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726108AbfG1TkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:40:09 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6SJdo7V012074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 15:39:52 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C00FF4202F5; Sun, 28 Jul 2019 15:39:49 -0400 (EDT)
Date:   Sun, 28 Jul 2019 15:39:49 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 09/16] fscrypt: add an HKDF-SHA512 implementation
Message-ID: <20190728193949.GI6088@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-10-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-10-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:34PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add an implementation of HKDF (RFC 5869) to fscrypt, for the purpose of
> deriving additional key material from the fscrypt master keys for v2
> encryption policies.  HKDF is a key derivation function built on top of
> HMAC.  We choose SHA-512 for the underlying unkeyed hash, and use an
> "hmac(sha512)" transform allocated from the crypto API.
> 
> We'll be using this to replace the AES-ECB based KDF currently used to
> derive the per-file encryption keys.  While the AES-ECB based KDF is
> believed to meet the original security requirements, it is nonstandard
> and has problems that don't exist in modern KDFs such as HKDF:
> 
> 1. It's reversible.  Given a derived key and nonce, an attacker can
>    easily compute the master key.  This is okay if the master key and
>    derived keys are equally hard to compromise, but now we'd like to be
>    more robust against threats such as a derived key being compromised
>    through a timing attack, or a derived key for an in-use file being
>    compromised after the master key has already been removed.
> 
> 2. It doesn't evenly distribute the entropy from the master key; each 16
>    input bytes only affects the corresponding 16 output bytes.
> 
> 3. It isn't easily extensible to deriving other values or keys, such as
>    a public hash for securely identifying the key, or per-mode keys.
>    Per-mode keys will be immediately useful for Adiantum encryption, for
>    which fscrypt currently uses the master key directly, introducing
>    unnecessary usage constraints.  Per-mode keys will also be useful for
>    hardware inline encryption, which is currently being worked on.
> 
> HKDF solves all the above problems.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Unless I missed something there's nothing here which is fscrypt
specific.  Granted that it's somewhat unlikely that someone would want
to implement (the very bloated) IKE from IPSEC in the kernel, I wonder
if there might be other users of HKDF, and whether this would be
better placed in lib/ or crypto/ instead of fs/crypto?

Other than that, looks good.  Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

