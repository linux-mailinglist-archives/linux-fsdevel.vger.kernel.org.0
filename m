Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD0A7986DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 14:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbjIHMLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIHMLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A11BC5;
        Fri,  8 Sep 2023 05:10:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244CCC433C7;
        Fri,  8 Sep 2023 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694175057;
        bh=Bcoj13+cz0u1U4GDbfHGOuXDRti5AxLN+icNUe95riI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdzvxuvfB7d+lKywj5FB2AT/GXBkvYmtrM8YzwlU9Gvyrza9y+xDgis0F9B0tUeG5
         Q3eF01uN86KVOV8NivGOEYMFJbGuh+9E1MA/6qpk9gMI4Ady4VwhO5X9fsfoj7LL7I
         T9vdahmt9i48ZiAfXaVjBEZzuWc/Cxd54Z11aVVDGuL3qyBIMKTM1oUKHq98309J83
         Ks04exhjD/JjzBvf3hshz7fvBL8PjwF1c5b0upfn6ZdWgzClNxn/kPTA6XOzXRdg54
         6OxgKuYoYl6eYMUW+KY/QjGLywEqeQ9uqTGknAfWTpYGoes1MzCqkygvNz8qQagYi9
         x3yjcpXLNpidQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] fs: fixes for multigrain ctime code
Date:   Fri,  8 Sep 2023 14:10:37 +0200
Message-Id: <20230908-gegolten-wagen-49d5559cfdb3@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
References: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=brauner@kernel.org; h=from:subject:message-id; bh=Bcoj13+cz0u1U4GDbfHGOuXDRti5AxLN+icNUe95riI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT85jfdPeftjK9ap7doLOMJOyv2zfekibZOOVfo6yX7fTP6 XAOsOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS+pOR4eSCSQtrtj1cXf1PkvfL1r aF8bX8k3645wS51DHKS0WtamL4Z1LYtMz6XgpXwdmj0zLnfngSPZnVKVzZ/E6fqB7/FPcQXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 07 Sep 2023 12:33:46 -0400, Jeff Layton wrote:
> The kernel test robot noted some test failures with the LTP mount03 test
> on tmpfs. From the test output, it looked like the atime had gone
> backward.
> 
> One way this could happen would be for tmpfs to get a new inode from the
> slab that had a ctime that appeared to be in the future.
> inode_update_ctime_current would just return that time and then the
> mtime and atime would be set to the same value. Then later, the atime
> gets overwritten by "now" which is still lower than the garbage ctime
> value.
> 
> [...]

Picked up so we can get some -next testing. Hopefully that test thing can
verify the fix.

---

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[1/2] fs: initialize inode->__i_ctime to the epoch
      https://git.kernel.org/vfs/vfs/c/7651a330dcbd
[2/2] fs: don't update the atime if existing atime is newer than "now"
      https://git.kernel.org/vfs/vfs/c/4c950d80d98d
