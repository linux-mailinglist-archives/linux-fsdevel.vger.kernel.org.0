Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40258745FB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGCPXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCPXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:23:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23844E41
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 08:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FB260F9C
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 15:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC8EC433C7;
        Mon,  3 Jul 2023 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688397823;
        bh=gfJmqrHuyo9RYRXr3RF+QAj/y8XRfCY+loe+pacFbfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLYARPgvcLtVBUWjqggYRfRt7rabv/aTCMhHePHZJ6j0BpGMM29FGudXv38sw87CF
         0QaWz2B6Cj/lhcwEvCn9tjcuHrduAPJiCVn4xLiM0eDo3cuotym7sOjZ4fn10562B7
         51y191cwBQJUI2OOq7qyM8rJLRVOEPec5CzQ67a41nSwajJc6480kYEYf4Z1OVjKdH
         3Mp8q8KBeSlox3qxE6nvk7rVZuzV2i6RrKJ+5XfX7sgieRPaPYUEnJ30/lkjixkDXX
         LZFapLcKHi8tqVMbum9ioyEBK1o8bitlr7MXsXHUrik48gOIPjfIoe2x9Z84UZ5XFV
         zJLuckfJOSU1w==
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        hughd@google.com, akpm@linux-foundation.org
Subject: Re: [PATCH v7 0/3] shmemfs stable directory offsets
Date:   Mon,  3 Jul 2023 17:23:07 +0200
Message-Id: <20230703-implementierung-babybett-d8bc420da798@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
References:  <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=brauner@kernel.org; h=from:subject:message-id; bh=gfJmqrHuyo9RYRXr3RF+QAj/y8XRfCY+loe+pacFbfA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsen5p9bt4e5mDOqJvBRS/Oyo/qtiS/D4qlfNlJ/8FFrH3 87YGdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEJIGRYZWw6exJJ/fqP7QrW+a3eM XDXmvFg66NEWX6sdofD3J9tmdkuPa7ODM+aFqs8bqHNzL5YoyVO3N8Lqz8V/WjYpHJdjUVTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jun 2023 13:48:43 -0400, Chuck Lever wrote:
> The following series implements stable directory offsets for
> shmemfs/tmpfs and provides infrastructure for use by other file
> systems that are based on simplefs.
> 
> 
> Changes since v6:
> - Add appropriate documentation
> 
> [...]

I've folded in the mentioned changes to make offset types consistent.
Thanks for adding documentation for the new i_op.

---

Applied to the vfs.readdir branch of the vfs/vfs.git tree.
Patches in the vfs.readdir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.readdir

[1/3] libfs: Add directory operations for stable offsets
      https://git.kernel.org/vfs/vfs/c/7a3472ae9614
[2/3] shmem: Refactor shmem_symlink()
      https://git.kernel.org/vfs/vfs/c/0462391d6d03
[3/3] shmem: stable directory offsets
      https://git.kernel.org/vfs/vfs/c/ddb7bcf8430a
