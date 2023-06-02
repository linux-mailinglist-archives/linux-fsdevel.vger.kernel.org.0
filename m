Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6FE72028D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjFBNF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFBNFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0223919A;
        Fri,  2 Jun 2023 06:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E0060E9B;
        Fri,  2 Jun 2023 13:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF4CC433EF;
        Fri,  2 Jun 2023 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685711123;
        bh=FoLf4aQs97gm4dA2dA1/lRECoc6PX0rzzxDCa+caZUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3L9J89xcNwCE+rxAScjDifxLtgAxv8t9BoM5Xhk4XvpaFrlVwmwe/nRfAM22L3+X
         XrN9659E4ud6B5SaFKM6eEA2LuH8cFhnPcnWU28M7Pwz86HnIuaXuyxqWAxKCv8kfC
         Xeq7+W9pUNN55z2ojEeSHyE6GN3oAIFfXdN3V87jC+95xoQR+eCpNZvaXluAVOsBzr
         ZzDDWUdy+IvGMweeF+2spO/T4D4XrsifffSa4Xu9WV1+bN/O9l7FruMkkZInjC/KVz
         0jTCmBJkQPl157w41nbfW1ff2cvk6H7qYUNhhhdJyKi1UQRdrc/59kD8RprGQOz9Cw
         uN9C/Y8AVnUHA==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 0/6] fs: Fix directory corruption when moving directories
Date:   Fri,  2 Jun 2023 15:05:13 +0200
Message-Id: <20230602-abmelden-zarte-405e2540fde2@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601104525.27897-1-jack@suse.cz>
References: <20230601104525.27897-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=brauner@kernel.org; h=from:subject:message-id; bh=gVTr7b6YTyap3no0CaHa00viaTffglxt+9+3v0nau7E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRUvvjhf0rqyYLwTIY/DpkV615xcK7muXkvJse+eMpZrwvi V+2lO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC7sjwz/bJ/5b02Y3zmw4Wp3u+EM 6Pv3lqr57+n9RFkR85jy14/IHhr/DUaw/SgpZYTS9MelVieGz77sJc5hllQS1RPcseVgnLsAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 01 Jun 2023 12:58:20 +0200, Jan Kara wrote:
> this patch set fixes a problem with cross directory renames originally reported
> in [1]. To quickly sum it up some filesystems (so far we know at least about
> ext4, udf, f2fs, ocfs2, likely also reiserfs, gfs2 and others) need to lock the
> directory when it is being renamed into another directory. This is because we
> need to update the parent pointer in the directory in that case and if that
> races with other operation on the directory (in particular a conversion from
> one directory format into another), bad things can happen.
> 
> [...]

I've picked this up to get it into -next. I've folded the following fix
for the missing { into [4/6].

---

Applied to the vfs.rename.locking branch of the vfs/vfs.git tree.
Patches in the vfs.rename.locking branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rename.locking

[1/6] ext4: Remove ext4 locking of moved directory
      https://git.kernel.org/vfs/vfs/c/3658840cd363
[2/6] Revert "udf: Protect rename against modification of moved directory"
      https://git.kernel.org/vfs/vfs/c/7517ce5dc4d6
[3/6] Revert "f2fs: fix potential corruption when moving a directory"
      https://git.kernel.org/vfs/vfs/c/cde3c9d7e2a3
[4/6] fs: Establish locking order for unrelated directories
      https://git.kernel.org/vfs/vfs/c/f23ce7571853
[5/6] fs: Lock moved directories
      https://git.kernel.org/vfs/vfs/c/28eceeda130f
[6/6] fs: Restrict lock_two_nondirectories() to non-directory inodes
      https://git.kernel.org/vfs/vfs/c/afb4adc7c3ef
