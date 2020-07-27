Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711D722F585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgG0QiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbgG0QiW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:38:22 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C6B20729;
        Mon, 27 Jul 2020 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595867902;
        bh=c5eT5k11z1+CS85OE5I4gSjQlV7ygf3FjoF9oxLpRMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsmG70EFO0Xk7VnJqu5etQ5rAiSv75DK06bQvyYv+PKhPMp1qfqnS6omgE0sBtJwL
         El6ORUUQeMuqPbPX0PxioKkQ6+lj0j1qGL+YWnhuYLnUnlWMrAsq0ocatwnjlVwm0n
         12trzm+Ou4H+PIqNUs8r/jIbo99Jt+GizD78QPDY=
Date:   Mon, 27 Jul 2020 09:38:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH 0/5] fscrypt, fs-verity: one-time init fixes
Message-ID: <20200727163820.GC1138@sol.localdomain>
References: <20200721225920.114347-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721225920.114347-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 03:59:15PM -0700, Eric Biggers wrote:
> This series fixes up some cases in fs/crypto/ and fs/verity/ where
> "one-time init" is implemented using READ_ONCE() instead of
> smp_load_acquire() but it's not obviously correct.
> 
> One case is fixed by using a better approach that removes the need to
> initialize anything.  The others are fixed by upgrading READ_ONCE() to
> smp_load_acquire().  I've also improved the comments.
> 
> This is motivated by the discussions at 
> https://lkml.kernel.org/linux-fsdevel/20200713033330.205104-1-ebiggers@kernel.org/T/#u
> and
> https://lkml.kernel.org/linux-fsdevel/20200717044427.68747-1-ebiggers@kernel.org/T/#u
> 
> These fixes are improvements over the status quo, so I'd prefer to apply
> them now, without waiting for any potential new generic one-time-init
> macros (which based on the latest discussion, won't be flexible enough
> to handle most of these cases anyway).
> 
> Eric Biggers (5):
>   fscrypt: switch fscrypt_do_sha256() to use the SHA-256 library
>   fscrypt: use smp_load_acquire() for fscrypt_prepared_key
>   fscrypt: use smp_load_acquire() for ->s_master_keys
>   fscrypt: use smp_load_acquire() for ->i_crypt_info
>   fs-verity: use smp_load_acquire() for ->i_verity_info
> 
>  fs/crypto/Kconfig           |  2 +-
>  fs/crypto/fname.c           | 41 +++++++++----------------------------
>  fs/crypto/fscrypt_private.h | 15 ++++++++------
>  fs/crypto/inline_crypt.c    |  6 ++++--
>  fs/crypto/keyring.c         | 15 +++++++++++---
>  fs/crypto/keysetup.c        | 18 +++++++++++++---
>  fs/crypto/policy.c          |  4 ++--
>  fs/verity/open.c            | 15 +++++++++++---
>  include/linux/fscrypt.h     | 29 +++++++++++++++++++++-----
>  include/linux/fsverity.h    |  9 ++++++--
>  10 files changed, 96 insertions(+), 58 deletions(-)

Patches 1-4 applied to fscrypt.git#master for 5.9.
Patch 5 applied to fscrypt.git#fsverity for 5.9.

- Eric
