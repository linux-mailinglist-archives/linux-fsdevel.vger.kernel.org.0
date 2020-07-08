Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E665D218E07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 19:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGHROw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 13:14:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41337 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725879AbgGHROw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:14:52 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 068HES9I021454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Jul 2020 13:14:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5EA4D420304; Wed,  8 Jul 2020 13:14:28 -0400 (EDT)
Date:   Wed, 8 Jul 2020 13:14:28 -0400
From:   tytso@mit.edu
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4 2/4] fscrypt: add inline encryption support
Message-ID: <20200708171428.GE1627842@mit.edu>
References: <20200702015607.1215430-1-satyat@google.com>
 <20200702015607.1215430-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702015607.1215430-3-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:56:05AM +0000, Satya Tangirala wrote:
> Add support for inline encryption to fs/crypto/.  With "inline
> encryption", the block layer handles the decryption/encryption as part
> of the bio, instead of the filesystem doing the crypto itself via
> Linux's crypto API. This model is needed in order to take advantage of
> the inline encryption hardware present on most modern mobile SoCs.
> 
> To use inline encryption, the filesystem needs to be mounted with
> '-o inlinecrypt'. Blk-crypto will then be used instead of the traditional
> filesystem-layer crypto whenever possible to encrypt the contents
> of any encrypted files in that filesystem. Fscrypt still provides the key
> and IV to use, and the actual ciphertext on-disk is still the same;
> therefore it's testable using the existing fscrypt ciphertext verification
> tests.
> 
> Note that since blk-crypto has a fallback to Linux's crypto API, and
> also supports all the encryption modes currently supported by fscrypt,
> this feature is usable and testable even without actual inline
> encryption hardware.
> 
> Per-filesystem changes will be needed to set encryption contexts when
> submitting bios and to implement the 'inlinecrypt' mount option.  This
> patch just adds the common code.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
