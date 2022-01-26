Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7A49C529
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 09:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiAZIV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 03:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiAZIV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:21:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66E6C06161C;
        Wed, 26 Jan 2022 00:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1741260E75;
        Wed, 26 Jan 2022 08:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B749C340E7;
        Wed, 26 Jan 2022 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643185317;
        bh=FiLRbzqolbwucvqe3jOU5MhCq30iSskHTZaWdzIdR8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdQmxraJzvvl4JTVAMdJRJFis4o9l/t0YxYwcPx49zZt+xjtXiJXXq7RWrIWRLufK
         +WyKTkSUj+7QtPGMgWR4A/v28ZeWce2+BwZZ3td9rrfby0w/2+x83pLNFmJZwuPjLt
         R5BKbe6E4UOZq+zZyeMne0VuAeLKISi1DWU932HGCYFobaimplwIdm/JxF7sAxO8zS
         rkXQnCznMbpGF+0ASN7B85+G+vxb2M7m4F9xHxS9+wzup75o7jKbiBSYnkkMtgAO8z
         tSYaDIthpeOhEJI/9w3CUvNWq4kB5Czx32vKdIKYsx0aL7S+IcjGVRNhb5Ii0/wdVd
         BNsxgX+6QOOeQ==
Date:   Wed, 26 Jan 2022 09:21:53 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCHSET 0/4] vfs: actually return fs errors from ->sync_fs
Message-ID: <20220126082153.mz5prdistkkvc6bc@wittgenstein>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164316348940.2600168.17153575889519271710.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 06:18:09PM -0800, Darrick J. Wong wrote:
> Hi all,
> 
> While auditing the VFS code, I noticed that while ->sync_fs is allowed
> to return error codes to reflect some sort of internal filesystem error,
> none of the callers actually check the return value.  Back when this
> callout was introduced for sync_filesystem in 2.5 this didn't matter

(Also, it looks like that most(/none?) of the filesystems that
implemented ->sync_fs around 2.5/2.6 (ext3, jfs, jffs2, reiserfs etc.)
actually did return an error?
In fact, 5.8 seems to be the first kernel to report other errors than
-EBADF since commit 735e4ae5ba28 ("vfs: track per-sb writeback errors
and report them to syncfs"?)
