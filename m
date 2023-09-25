Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476B47AD816
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjIYMe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:34:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B2C0;
        Mon, 25 Sep 2023 05:34:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CF1C433C8;
        Mon, 25 Sep 2023 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695645259;
        bh=J10rv6bwcTutOdorIcDRobiFGuFoRoy6Xp7WZz1xess=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKodcEXRYh+o0SNKQyZ8FgXZg9GWdMnNBb5H+KR/sefu8wF/OfnPLqKkM6kKbrF5e
         PZv8/KIqipItoRw0jjQTZpRaAPb+DdI6aBLCfYBXi0KGLaXLx3NTzLT0sIV7UNkX2u
         Ami8N9SDcJJdsoaTIam7bpnyZrb28ez1auYVMvOSj0mAjNCLPY85quBxR3ZRe9xUlG
         HbguRxmRI7pYysI4BWAOxV1uOCsLJjf1Q89UPysZaKfa/UztP4qwgyn0R6ybCm7QCZ
         MBxP/nY/03OnvzS4VinL5Q5YZu2CPEl39TZwqB9HOqifDYJOhWq0FzpR92vRRogL3f
         xZhpvqllQ9Udg==
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v7 00/12] iov_iter: Convert the iterator macros into inline funcs
Date:   Mon, 25 Sep 2023 14:34:05 +0200
Message-Id: <20230925-zugetan-abhaken-8edd66ed06a7@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925120309.1731676-1-dhowells@redhat.com>
References: <20230925120309.1731676-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706; i=brauner@kernel.org; h=from:subject:message-id; bh=J10rv6bwcTutOdorIcDRobiFGuFoRoy6Xp7WZz1xess=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQK1hmHvPzoGPKx7qV/gLKL5G1Xu5nvRaWuGPHOjJ94O+PO 2m+nOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZym53hf/yXFaacTd13BbbPcXgjKf DuyJ0T0RVNa64c/i/7J1xty15Ghnnaub/z18qWMW+/u85tLlPsFZ3v+brXoz93TOfc9v+DBycA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 25 Sep 2023 13:02:57 +0100, David Howells wrote:
> Could you take these patches into the block tree or the fs tree?  The
> patches convert the iov_iter iteration macros to be inline functions.
> 
>  (1) Remove last_offset from iov_iter as it was only used by ITER_PIPE.
> 
>  (2) Add a __user tag on copy_mc_to_user()'s dst argument on x86 to match
>      that on powerpc and get rid of a sparse warning.
> 
> [...]

I'm giving you vfs.iov_iter as a stable (no rebases) branch so you can
put fixes on top. Please let me know if someone else needs to take this.

---

Applied to the vfs.iov_iter branch of the vfs/vfs.git tree.
Patches in the vfs.iov_iter branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iov_iter

[01/12] iov_iter: Remove last_offset from iov_iter as it was for ITER_PIPE
        https://git.kernel.org/vfs/vfs/c/581beb4fe37d
[02/12] iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()
        https://git.kernel.org/vfs/vfs/c/066baf92bed9
[03/12] sound: Fix snd_pcm_readv()/writev() to use iov access functions
        https://git.kernel.org/vfs/vfs/c/1fcb71282e73
[04/12] infiniband: Use user_backed_iter() to see if iterator is UBUF/IOVEC
        https://git.kernel.org/vfs/vfs/c/7ebc540b3524
[05/12] iov_iter: Renumber ITER_* constants
        https://git.kernel.org/vfs/vfs/c/7d9e44a6ad8a
[06/12] iov_iter: Derive user-backedness from the iterator type
        https://git.kernel.org/vfs/vfs/c/f1b4cb650b9a
[07/12] iov_iter: Convert iterate*() to inline funcs
        https://git.kernel.org/vfs/vfs/c/f1982740f5e7
[08/12] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
        https://git.kernel.org/vfs/vfs/c/51edcc92222f
[09/12] iov_iter, net: Move csum_and_copy_to/from_iter() to net/
        https://git.kernel.org/vfs/vfs/c/ef6fdd780dd4
[10/12] iov_iter, net: Fold in csum_and_memcpy()
        https://git.kernel.org/vfs/vfs/c/0837c6c20a4c
[11/12] iov_iter, net: Merge csum_and_copy_from_iter{,_full}() together
        https://git.kernel.org/vfs/vfs/c/921203282d82
[12/12] iov_iter, net: Move hash_and_copy_to_iter() to net/
        https://git.kernel.org/vfs/vfs/c/d7a22f309096
