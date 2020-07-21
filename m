Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5285922742F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 02:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgGUA4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 20:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGUA4E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:56:04 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCA0C2080D;
        Tue, 21 Jul 2020 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595292963;
        bh=dljJpfGPFFNj0wv4WYv/v3SWoi1fAf+MTy7pRYnyY7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejU8ZkFJrLiVoGTmDI5vINlnpExbViy7d42Uic8QH7oIDcehBxc7Xjc7fPHoEdxnp
         zFQ8luDXtsqZ6dhgmGuNI1zE295r46BjEni3RQj/MX42KOpQE0ENNWACO4S8D3mPN8
         N093bypT+wf9P/NEFxk1k2jmPoWzo0dvJXrS3+7c=
Date:   Mon, 20 Jul 2020 17:56:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 0/7] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200721005602.GE7464@sol.localdomain>
References: <20200720233739.824943-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720233739.824943-1-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:37:32PM +0000, Satya Tangirala wrote:
> This patch series adds support for direct I/O with fscrypt using
> blk-crypto. It has been rebased on fscrypt/master.
> 
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
> Patches 6 and 7 update the fscrypt documentation for inline encryption
> support and direct I/O. The documentation now notes the required conditions
> for inline encryption and direct I/O on encrypted files.
> 
> This patch series was tested by running xfstests with test_dummy_encryption
> with and without the 'inlinecrypt' mount option, and there were no
> meaningful regressions. One regression was for generic/587 on ext4,
> but that test isn't compatible with test_dummy_encryption in the first
> place, and the test "incorrectly" passes without the 'inlinecrypt' mount
> option - a patch will be sent out to exclude that test when
> test_dummy_encryption is turned on with ext4 (like the other quota related
> tests that use user visible quota files). The other regression was for
> generic/252 on ext4, which does direct I/O with a buffer aligned to the
> block device's blocksize, but not necessarily aligned to the filesystem's
> block size, which direct I/O with fscrypt requires.
> 

This patch series looks good to me now.  Can the ext4, f2fs, and iomap
maintainers take a look?

- Eric
