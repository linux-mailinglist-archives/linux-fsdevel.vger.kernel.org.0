Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B56EFDD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbjDZXH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 19:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjDZXHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059BE2694;
        Wed, 26 Apr 2023 16:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B97363998;
        Wed, 26 Apr 2023 23:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA025C4339C;
        Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682550440;
        bh=71/XsA8gAmo1yutYZ1cS0twFrW61Rssu2AmOx0Z5eqs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LCsCJGnd35MidYfxnMlF2ceb389n1B9U+KnzrgVKwgz5bAx1JzOufQeZ/SGRGVkkX
         AkwL7o7IUXB84i3Vrp+2dYvTEB2raGyt1bPfIePkPzimyVl0QF0nykjXoFPdK/iGyF
         xmS+0hcVEEqQ/mzOQIEuWBo+aNi0OdLZoD2sU5j7TMMHl0xiWsv3YDVAgdm/lv4bBl
         2hkD0FnZL1h9SA7ETWRkHuT5vigtQxRgpaiySgxZcycuzc9OCObp4SvRjW6CqNYxGL
         A85Yr6YutIEXIGmgBh1OeDzgtzNYHzp8kT1wAHqE0jDNsJNShVauqRfHNLAzt5GYDW
         hhMvyD5bq6lZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B47F5E270D8;
        Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 00/10] acl: drop posix acl handlers from xattr
 handlers
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168255044073.16014.8337870090900748986.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Apr 2023 23:07:20 +0000
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-unionfs@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        sforshee@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner (Microsoft) <brauner@kernel.org>:

On Wed, 01 Feb 2023 14:14:51 +0100 you wrote:
> Hey everyone,
> 
> After we finished the introduction of the new posix acl api last cycle
> we still left the generic POSIX ACL xattr handlers around in the
> filesystems xattr handlers for two reasons:
> 
> (1) Because a few filesystems rely on the ->list() method of the generic
>     POSIX ACL xattr handlers in their ->listxattr() inode operation.
> (2) POSIX ACLs are only available if IOP_XATTR is raised. The IOP_XATTR
>     flag is raised in inode_init_always() based on whether the
>     sb->s_xattr pointer is non-NULL. IOW, the registered xattr handlers
>     of the filesystem are used to raise IOP_XATTR.
>     If we were to remove the generic POSIX ACL xattr handlers from all
>     filesystems we would risk regressing filesystems that only implement
>     POSIX ACL support and no other xattrs (nfs3 comes to mind).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,05/10] fs: simplify ->listxattr() implementation
    https://git.kernel.org/jaegeuk/f2fs/c/a5488f29835c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


