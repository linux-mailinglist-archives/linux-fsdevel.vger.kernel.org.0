Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588F03D51FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 05:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhGZDSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 23:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhGZDSh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F48460E78;
        Mon, 26 Jul 2021 03:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627271946;
        bh=S2M7O/hWRwUTq7mbz2jtiILfGuQ8RGSgKtCdk8rgMuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsfM/EqjBD7gxSof38fX80XYdi8aaah/mVKkEx455k8XQV81FIQODx7ckwDiWSAKZ
         7Khpzk20Zo0beRXkf7hS2YFZnjS52bXw/0T98a8QHTaZk7pSn5c1LE0wwkMfEByZ7j
         5oiD/LCKLV5g89VMNUdEXkdEX2101ssUUd9OwsUpAFcMI2mxUIPZybbHFor+bqTUqA
         CCkj0InOg6KFQHOkQJJthsAFo5fhpEQ9b6SKIBdkBErPouUNQP8UzkHGIL/HwVOymg
         s6MEDaL839H63/B595h4GQguvJyDjVWD2wf7/vYj+N8gN+4pCgjAaV9yHeA/xiuWTO
         zR9ObgiG5njPg==
Date:   Sun, 25 Jul 2021 20:59:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fscrypt: align Base64 encoding with RFC 4648 base64url
Message-ID: <YP4zCXWV2N1Ys+lh@sol.localdomain>
References: <20210718000125.59701-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718000125.59701-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 07:01:25PM -0500, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fscrypt uses a Base64 encoding to encode no-key filenames (the filenames
> that are presented to userspace when a directory is listed without its
> encryption key).  There are many variants of Base64, but the most common
> ones are specified by RFC 4648.  fscrypt can't use the regular RFC 4648
> "base64" variant because "base64" uses the '/' character, which isn't
> allowed in filenames.  However, RFC 4648 also specifies a "base64url"
> variant for use in URLs and filenames.  "base64url" is less common than
> "base64", but it's still implemented in many programming libraries.
> 
> Unfortunately, what fscrypt actually uses is a custom Base64 variant
> that differs from "base64url" in several ways:
> 
> - The binary data is divided into 6-bit chunks differently.
> 
> - Values 62 and 63 are encoded with '+' and ',' instead of '-' and '_'.
> 
> - '='-padding isn't used.  This isn't a problem per se, as the padding
>   isn't technically necessary, and RFC 4648 doesn't strictly require it.
>   But it needs to be properly documented.
> 
> There have been two attempts to copy the fscrypt Base64 code into lib/
> (https://lkml.kernel.org/r/20200821182813.52570-6-jlayton@kernel.org and
> https://lkml.kernel.org/r/20210716110428.9727-5-hare@suse.de), and both
> have been caught up by the fscrypt Base64 variant being nonstandard and
> not properly documented.  Also, the planned use of the fscrypt Base64
> code in the CephFS storage back-end will prevent it from being changed
> later (whereas currently it can still be changed), so we need to choose
> an encoding that we're happy with before it's too late.
> 
> Therefore, switch the fscrypt Base64 variant to base64url, in order to
> align more closely with RFC 4648 and other implementations and uses of
> Base64.  However, I opted not to implement '='-padding, as '='-padding
> adds complexity, is unnecessary, and isn't required by the RFC.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/filesystems/fscrypt.rst |  10 +--
>  fs/crypto/fname.c                     | 106 ++++++++++++++++----------
>  2 files changed, 70 insertions(+), 46 deletions(-)

Applied to fscrypt.git#master for 5.15.

- Eric
