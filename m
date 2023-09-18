Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772EF7A4809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbjIRLLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbjIRLLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8C910D;
        Mon, 18 Sep 2023 04:10:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B296C433C9;
        Mon, 18 Sep 2023 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695035452;
        bh=t4u9weEcU05tiCQZcO4ri79Q/oWC3HqbRm0iN4SD9L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pd9TclALgBvfnLdjY+o6R65r70fP8uxfzTtwqZd8nUYqQmdP4V2Z4iGO3WqgSfamQ
         bOZZIWYMMr8AyMqYM80EXqXCOEFpyFLSALUTiyjiO0H9/TG8Re6cuDH2VQZGE/SXRM
         orLiOypRJmiNSrB6mSoPpQNbD08UjizVisJ4Ln4Tvhze2mmtfzsAx1AlYYhivQXc5m
         igow9F1iKHd3HBEtazVvwOSVtpcIfd3NwCzPH8oY/OYSP/YoK5ld2MzVK6EfOMuTwT
         qhoXB+t9w7b7Ls4pw5anAAMxHP541aCdlRxiUVQwb6FQCygqrpHwxbPHTPijVP5qri
         goQN3WtKB+72g==
From:   Christian Brauner <brauner@kernel.org>
To:     Chunhai Guo <guochunhai@vivo.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] fs-writeback: do not requeue a clean inode having skipped pages
Date:   Mon, 18 Sep 2023 13:10:29 +0200
Message-Id: <20230918-mantel-hochachtung-6987b937ac66@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916045131.957929-1-guochunhai@vivo.com>
References: <20230916045131.957929-1-guochunhai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=brauner@kernel.org; h=from:subject:message-id; bh=t4u9weEcU05tiCQZcO4ri79Q/oWC3HqbRm0iN4SD9L4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRyGIi0PpWY/DlTSWW1ZVo2m1/iJ9YOQbNtPmLMypuLr77K eFXdUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBE2N0aGHRZ7Jv/5+ufOH62mcO9Tj6 N+3Pec9TYifZm1wLS7Uow6zxkZph++HbX+8HJ9uc9vTMUvf/E4Wy4r+0xGatFi6a7pumpHmAE=
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

On Fri, 15 Sep 2023 22:51:31 -0600, Chunhai Guo wrote:
> When writing back an inode and performing an fsync on it concurrently, a
> deadlock issue may arise as shown below. In each writeback iteration, a
> clean inode is requeued to the wb->b_dirty queue due to non-zero
> pages_skipped, without anything actually being written. This causes an
> infinite loop and prevents the plug from being flushed, resulting in a
> deadlock. We now avoid requeuing the clean inode to prevent this issue.
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

[1/1] fs-writeback: do not requeue a clean inode having skipped pages
      https://git.kernel.org/vfs/vfs/c/3d744ef7ea7a
