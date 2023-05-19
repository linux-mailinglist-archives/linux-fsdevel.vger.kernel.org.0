Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162BB709569
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjESKwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 06:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjESKwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 06:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B497A192
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 03:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A37A65673
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 10:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655FAC433D2;
        Fri, 19 May 2023 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684493531;
        bh=/v84OOWogMzxwAPPo1Lb1tB1SIYHcs9Fx1rZ53zIfrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qps9qe+0NQBOWm9wwg29ehs0SOd0mpSTTSdd4Z79mPzF0tReOw/KmDod822XsfWOR
         41LwOvDfyLtkSmtY22sczae6Wc3TZaPxcg5sbBacN/DQBD8R40kcvL2VolvhQBEwOu
         S8NuKGGRuN9OE4TLdctswnMLSW7OYqEPb5eH3xPqthjeTSf1ffcXkS4FzgrNQSu1iB
         geR1+VBKC8891hdBHPERSaDAXQs0kPUYd9wx6uW7w1BX6HPmNstDTBgR4fyFaiOerW
         WAs7zZJU0CW7i9QeF6R2QgzydGLtKFlOdH/MlEZ1kqYzB12R7r/V9xGNxDncZaLWbA
         skz6r/fesFbuw==
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] fs: allow to mount beneath top mount
Date:   Fri, 19 May 2023 12:52:00 +0200
Message-Id: <20230519-aromen-zeugnis-5554bbb56ec1@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
References: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=brauner@kernel.org; h=from:subject:message-id; bh=/v84OOWogMzxwAPPo1Lb1tB1SIYHcs9Fx1rZ53zIfrw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSkh5xZI28VvN+tNT892iCx8O/x/e92bRTXbKz1fGyi9aVG ZvuGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8eMDIsCxu6qXtez4tOXXwVvDPTa f0jjz6Kpl/SWL/X84XdYtS7S4zMtxt7Ko0nyT7ZuvailkTTbcKrjgRs63O4/yZGQ9UDWZtesYCAA==
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

On Wed, 03 May 2023 13:18:38 +0200, Christian Brauner wrote:
> Changes in v4:
> * Refuse MOVE_MOUNT_BENEATH in more cases.
> * Fix documentation of __lookup_mnt().
> * The sample program to test all of this got reworked:
>   https://github.com/brauner/move-mount-beneath
> 
> Various distributions are adding or are in the process of adding support
> for system extensions and in the future configuration extensions through
> various tools. A more detailed explanation on system and configuration
> extensions can be found on the manpage which is listed below at [1].
> 
> [...]

I'd like to see v4 get some -next exposure since this has been sitting
on the list for a while.

Applied to the v6.5/vfs.mount branch of the vfs/vfs.git tree.
Patches in the v6.5/vfs.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: v6.5/vfs.mount

[1/4] fs: add path_mounted()
      https://git.kernel.org/vfs/vfs/c/78aa08a8cab6
[2/4] fs: properly document __lookup_mnt()
      https://git.kernel.org/vfs/vfs/c/104026c2e49f
[3/4] fs: use a for loop when locking a mount
      https://git.kernel.org/vfs/vfs/c/64f44b27ae91
[4/4] fs: allow to mount beneath top mount
      https://git.kernel.org/vfs/vfs/c/6ac392815628
