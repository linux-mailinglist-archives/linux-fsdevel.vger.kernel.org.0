Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A0793ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbjIFOb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 10:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjIFOb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:31:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE610E9;
        Wed,  6 Sep 2023 07:31:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F3C433C7;
        Wed,  6 Sep 2023 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694010712;
        bh=lqwRoGRrdfz7YoHtgBbfxMLJqv1Ylb4aaDcCFeoTFTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjm//87lSAMaKc6Q+bSxdfvEpA8YSPHjaGgBi3Tzb26cg9QeBv/AhZgG+S91ld+x9
         9hNQXyKtPiX8IOB2GoM+SRE6/xSDIweymM/sw3SWJSNFQzumSRlzndYz90VLfukTkw
         33ciYuzWzBIyAVXNlJ4SDQihpN3S6sNIFrZrV+3M+zHejC9VsSJZSLgTQsbMpKGqjN
         QqZA2Cfn/wQ8CXTz7Z3WMQW1hhwWPRL0I30xjUzvSxXDq97qMkm0+ADviGgyvCsFLF
         bJZpNNRD8/Qm0EgbclSMaToihG9VDXzc+oed35J4FpUUrfragu4+05j+EMe3o/ZgMd
         NRZKTmjGd73Ug==
From:   Christian Brauner <brauner@kernel.org>
To:     djwong@kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: handle error conditions more gracefully in iomap_to_bh
Date:   Wed,  6 Sep 2023 16:31:45 +0200
Message-Id: <20230906-orangen-kurios-99d82ff11449@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905124120.325518-1-hch@lst.de>
References: <20230905124120.325518-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org; h=from:subject:message-id; bh=lqwRoGRrdfz7YoHtgBbfxMLJqv1Ylb4aaDcCFeoTFTw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT86PU6VzZrlv2iwuuq5+bMUHE0P7c5NzZxwpWDccbKt7ZO rROv6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIPBcjw9LqyPLcpFPBd/re1x1Ib8 jcfUJpncxshU13JMOSK9wu6jMy/D2rcPJNfc2vtmTB8+eWZHXNzm8ovLl0X9vG2S2p07w+cQMA
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

On Tue, 05 Sep 2023 14:41:20 +0200, Christoph Hellwig wrote:
> iomap_to_bh currently BUG()s when the passed in block number is not
> in the iomap.  For file systems that have proper synchronization this
> should never happen and so far hasn't in mainline, but for block devices
> size changes aren't fully synchronized against ongoing I/O.  Instead
> of BUG()ing in this case, return -EIO to the caller, which already has
> proper error handling.  While we're at it, also return -EIO for an
> unknown iomap state instead of returning garbage.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] iomap: handle error conditions more gracefully in iomap_to_bh
      https://git.kernel.org/vfs/vfs/c/6f71eda85ab8
