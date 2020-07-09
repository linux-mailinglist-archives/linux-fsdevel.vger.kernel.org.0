Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4221AA81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 00:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGIWag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 18:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWag (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:30:36 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8540B2070E;
        Thu,  9 Jul 2020 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594333835;
        bh=Dpn69SR1yUFPn66W7Fbbk1lCZ1fQTf5VGLdHh2L6pHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+WR+Y2LanZRhq8MC5xduHojOk8O3+XkAMqrAcK0GJHm1Uegqx4r0qOxZTCnB4eo+
         8Pz68buk00ixvCYM+O7sDEZwr/AFjVyiAAk7rL6gakndlg3018/druWwbuN6YlXRPs
         fEjJFYMNpIrs+615pkKDogPMr21H+id2N31Liccg=
Date:   Thu, 9 Jul 2020 15:30:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/5] ext4: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200709223034.GE3855682@gmail.com>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709194751.2579207-5-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 07:47:50PM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up ext4 with fscrypt direct I/O support.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

This commit message could use some more details.  I think it should clarify that
the direct I/O support is limited to cases where the filesystem has been mounted
with '-o inlinecrypt' and CONFIG_BLK_INLINE_ENCRYPTION has been enabled, along
with CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK if hardware support isn't present.

As-is, it sounds a bit over-promising.

Likewise for f2fs.

We need to properly document this too.  At the very least, in the fscrypt patch,
Documentation/filesystems/fscrypt.rst needs to be updated because it currently
says "Direct I/O is not supported on encrypted files."

fscrypt.rst could also use some information about inline encryption.  Currently
inline encryption for fscrypt is only documented in the ext4 and f2fs
documentation in the context of the inlinecrypt mount option.  (Though, this
suggestion applies even without direct I/O support.)

- Eric
