Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069C62E9D86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhADSz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 13:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbhADSz6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:55:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48B2121D1B;
        Mon,  4 Jan 2021 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609786517;
        bh=MpFc3N5sadh45HXZYPKekhePp7BQUpn3XZfR02GWyfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucvmp3lUBV56HNYQtbhj2Qbgf7LWzLtjhc9G0GFdCGTefXE76a6rgCaUF1wLwDwMH
         ojryTtKX9sQavzDnaXkztQ658g6CV2CzJo8WYW+Ui/rhdxiLt12gvhA9gvEghLFCHG
         828NFWjf6PVM+eoy+9mtf5syGUcsbrfpKaSKrr0z3XH3x76oqXnRh5CMpUaSF8sKwE
         7IRIguR0lOlYN2M3kKm+b8P6yOfm0hmN+yZz+NnmiN/hVOgr/9BmphrMuR1YBt9bWG
         zusE8QL4VRm/6X3fc/DdW/fLB1n6W+SRvQ1Nzr/R/8U88edLi5S8Y/ojsp5TXoi5c9
         58WYprSuKZyWw==
Date:   Mon, 4 Jan 2021 10:55:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vfs: don't unnecessarily clone write access for
 writable fds
Message-ID: <X/Nkk4rlS43W90TV@sol.localdomain>
References: <20200922164418.119184-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922164418.119184-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:44:18AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> There's no need for mnt_want_write_file() to increment mnt_writers when
> the file is already open for writing, provided that
> mnt_drop_write_file() is changed to conditionally decrement it.
> 
> We seem to have ended up in the current situation because
> mnt_want_write_file() used to be paired with mnt_drop_write(), due to
> mnt_drop_write_file() not having been added yet.  So originally
> mnt_want_write_file() had to always increment mnt_writers.
> 
> But later mnt_drop_write_file() was added, and all callers of
> mnt_want_write_file() were paired with it.  This makes the compatibility
> between mnt_want_write_file() and mnt_drop_write() no longer necessary.
> 
> Therefore, make __mnt_want_write_file() and __mnt_drop_write_file() skip
> incrementing mnt_writers on files already open for writing.  This
> removes the only caller of mnt_clone_write(), so remove that too.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v3: added note to porting file.
> v2: keep the check for emergency r/o remounts.
> 
>  Documentation/filesystems/porting.rst |  7 ++++
>  fs/namespace.c                        | 53 ++++++++++-----------------
>  include/linux/mount.h                 |  1 -
>  3 files changed, 27 insertions(+), 34 deletions(-)

Ping.
