Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89D220F9BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbgF3Qrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 12:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgF3Qrc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:47:32 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE04206B6;
        Tue, 30 Jun 2020 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593535651;
        bh=SPqL4E1Wb8DiXConglbiJ9f0pTWiyShFbuJGvYwg4FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUUm0ploIzeASPPBp1of1yMAXdN9YKrBhlba/3QmKAhL/6UOXl1G69OZ4Pj7BfhYY
         7b/Z/DfOeam1LbovRk3PNaeHkAxo0IlGT3owcrfvyBSwM7u1PWqewhHRqe5pwkqUqD
         L+TPDB4GVbwzFJKmPeOtekr9NEFnFs4qs/mUYkEo=
Date:   Tue, 30 Jun 2020 09:47:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 2/4] fscrypt: add inline encryption support
Message-ID: <20200630164730.GB837@sol.localdomain>
References: <20200630121438.891320-1-satyat@google.com>
 <20200630121438.891320-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630121438.891320-3-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:14:36PM +0000, Satya Tangirala via Linux-f2fs-devel wrote:
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

Reviewed-by: Eric Biggers <ebiggers@google.com>
