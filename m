Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3C76FD55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 11:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjHDJcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjHDJby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656949F0
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 02:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C888A61F6B
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 09:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EC9C433C7;
        Fri,  4 Aug 2023 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691141500;
        bh=Mh1E9gZiK9ycp6tqPpBjwMzV6kf5/hBORiwfZeKUams=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NId2hSFoUMT5FVkJxAB/hx81gneg8ZMZlA+qtsBa8JAOwsb+l2/bicoPfbmQFEvv+
         WSwJ7CmubK4r7e6pX9iUBDW+L4HQqq6Fh2WDNBxyd9CQlfJnAtU8P26KhcgrAeCkYH
         C0u2xQvOPHQwKD/AnmocyfcR5qkU+eZ2/RBByX0lBg6BAnEQIL69U8pm0Q6c+4DmbV
         Katjg6Q9Xx93HwS8CXjecnYP0tKpfvXBBQ40s7MA5Yv/C9vK9LaGXVQFUml8FYeRLN
         M6F8p5FW5PQEtfH+RKemuiEw5abwxmresJL8w3DWrNuNFBeVGJ63guYFjdLcSxAvSs
         JqvAkiE3kT/Yg==
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Carlos Maiolino <cem@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs] shmem: move spinlock into shmem_recalc_inode() to fix quota support
Date:   Fri,  4 Aug 2023 11:31:33 +0200
Message-Id: <20230804-legalisieren-neukonzeption-97314400abbd@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <29f48045-2cb5-7db-ecf1-72462f1bef5@google.com>
References: <29f48045-2cb5-7db-ecf1-72462f1bef5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=brauner@kernel.org; h=from:subject:message-id; bh=Mh1E9gZiK9ycp6tqPpBjwMzV6kf5/hBORiwfZeKUams=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaScOVqoHGkt6OWyWHlniNOrmtVBiXfclUM7j04LYN5/pkg7 a19XRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETmb2RkmLWC/Xnx/xpji5Kqbal7Tb /Y8b41Xr+3dMrcrVOvd9jPqWBkeKyurnk8++rf8y4XFq1cJSLYbnj3RrDiVH3Vx6E3iy+e5gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 03 Aug 2023 22:46:11 -0700, Hugh Dickins wrote:
> Commit "shmem: fix quota lock nesting in huge hole handling" was not so
> good: Smatch caught shmem_recalc_inode()'s shmem_inode_unacct_blocks()
> descending into quota_send_warning(): where blocking GFP_NOFS is used,
> yet shmem_recalc_inode() is called holding the shmem inode's info->lock.
> 
> Yes, both __dquot_alloc_space() and __dquot_free_space() are commented
> "This operation can block, but only after everything is updated" - when
> calling flush_warnings() at the end - both its print_warning() and its
> quota_send_warning() may block.
> 
> [...]

Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
Patches in the vfs.tmpfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.tmpfs

[1/1] shmem: move spinlock into shmem_recalc_inode() to fix quota support
      https://git.kernel.org/vfs/vfs/c/f384c361c99e
