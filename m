Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90875FA42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGXO4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGXO4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD110C3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1665611E6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 14:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E79C433C8;
        Mon, 24 Jul 2023 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690210561;
        bh=BAfHK+QBUUpFVBgK3WCIZr1DJ+9vk8rdRPxciuagDKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZNRbXuysjSGI8yfnlx5+NikE+lk5/02mfXxiVn1LDE8oRCkoRIfwvk5zSgg86vAw
         XnSzk728bJI7Qn3djor5ypCvPdfrcoTwdIf6lfwE1cQfhlHgdxiTixZYUhzTIfTWYW
         Z7rt2Zt6cExDq/9o6sSMFBderSrP2OjZWe3LwibJpPo+nYOs18u0TLwWPCJt5D+w98
         0ytdXsREWJXICrnEmwIWsgrjHt4WmTUNztbB/I+XyRrWLKtxfMX8F4iLR80XzCHRW1
         O+npe1rx7JtyNk6mdJpOpq5VZEMKB0g3zwpawCJDnwOIM/jNTpFP4Zn0MiRxhU6vkg
         wIrD4y4t5sxfQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] libfs: Add a lock class for the offset map's xa_lock
Date:   Mon, 24 Jul 2023 16:55:53 +0200
Message-Id: <20230724-erfolg-bauhof-f459b0ef9daf@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <169020933088.160441.9405180953116076087.stgit@manet.1015granger.net>
References:  <169020933088.160441.9405180953116076087.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=brauner@kernel.org; h=from:subject:message-id; bh=BAfHK+QBUUpFVBgK3WCIZr1DJ+9vk8rdRPxciuagDKU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTsm/B5/exm2f9LP+1bXdp6bld/6f2jgSnpi0/xzUszNL26 6I0oX0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEBP8zMuxeKmQbU8Oo+8AtLWnyB/ 678+Pq90xvia+fKKMx1aZRaibDP0U9j3cHvi3RYtFJcDPNfPU/dtWSltjtJn9qmjhsNzX+5AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 10:43:57 -0400, Chuck Lever wrote:
> Tie the dynamically-allocated xarray locks into a single class so
> contention on the directory offset xarrays can be observed.
> 
> 

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

[1/1] libfs: Add a lock class for the offset map's xa_lock
      https://git.kernel.org/vfs/vfs/c/fc66c4c9dc90
