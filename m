Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B721AAB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGIWqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 18:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWqL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:46:11 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 405FE206E2;
        Thu,  9 Jul 2020 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594334771;
        bh=dllc0mNQLui62MxdLGsYVQ0KPlrkGuocjRq3Z70d4xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvDIPC57zh3Q9WVIHSKHkAsCSM6aAI047xfy8fejKV0QhiMZ7VZ8/UwZmuDEAVmTi
         VxJnjd+/iQeXu9RqWowkQxgCnxyVtCOnLm+E1OUsprA9HEDc5V8LrIfscbZjHANAS7
         qITlXpZ46+T3AzBMvAcTLL3qacPrDc6ArNn+VhKw=
Date:   Thu, 9 Jul 2020 15:46:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200709224609.GF3855682@gmail.com>
References: <20200709194751.2579207-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709194751.2579207-1-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 07:47:46PM +0000, Satya Tangirala wrote:
> This patch series adds support for direct I/O with fscrypt using
> blk-crypto. It has been rebased on fscrypt/inline-encryption.

Nit: use fscrypt/master instead.  (Eventually I'll delete the
"inline-encryption" branch.)

> Patch 1 adds two functions to fscrypt that need to be called to determine
> if direct I/O is supported for a request.
> 
> Patches 2 and 3 wire up direct-io and iomap respectively with the functions
> introduced in Patch 1 and set bio crypt contexts on bios when appropriate
> by calling into fscrypt.
> 
> Patches 4 and 5 allow ext4 and f2fs direct I/O to support fscrypt without
> falling back to buffered I/O.
> 
> This patch series was tested by running xfstests with test_dummy_encryption
> with and without the 'inlinecrypt' mount option, and there were no
> meaningful regressions. The only regression was for generic/587 on ext4,
> but that test isn't compatible with test_dummy_encryption in the first
> place, and the test "incorrectly" passes without the 'inlinecrypt' mount
> option - a patch will be sent out to exclude that test when
> test_dummy_encryption is turned on with ext4 (like the other quota related
> tests that use user visible quota files).

Note that xfstests has a check that prevents most of the direct I/O tests from
running when the 'test_dummy_encryption' mount option was specified:

_require_odirect()
{
        if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
                if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
                        _notrun "$FSTYP encryption doesn't support O_DIRECT"
                fi
        fi

We should try changing that check to not skip the test if the 'inlinecrypt'
mount option was also specified.

- Eric
