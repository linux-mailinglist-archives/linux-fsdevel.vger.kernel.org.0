Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356050A121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387268AbiDUNuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiDUNuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E299A37AB6
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 06:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF7F61D2E
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 13:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6278CC385A1;
        Thu, 21 Apr 2022 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650548850;
        bh=iAYjYNa1EqUHhXFJtykogGCvqJkeL34BouXoKCfn50w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZ0x7qAl5Hpg4ZxJZuEeLetuml8VbtUnYYEWpxrDpuXPc1uhNzqSOw/AL0fZcD8/N
         0ARJ20WnRFdnyS9sstX4V0Ve2EQxKB8PHp6wPLYF+HNA+Kdop+PvfaL2k9EaSS2LNQ
         FJWVmo5pR0aTxoY0HVNF0iRMT7KFXKprky84rlkHNcFgmkQAQpOuG+egdKYESRYLRq
         mr+XnsynU9LWygYeJBP+sT3oAcbBweid+hyuhJye+3gYtlDrp/3zj7smSIqHrI55+b
         HXlH2eA5D3rGSk0c7XzjbLw098I1c3b4YMjEm+IGPAN78IKv2tgBTBvKKD2POrZoQv
         /T4cbIf+cr1bQ==
Date:   Thu, 21 Apr 2022 15:47:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Hillf Danton <hdanton@sina.com>, fweisbec@gmail.com,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de,
        syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com,
        syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: unset MNT_WRITE_HOLD on failure
Message-ID: <20220421134725.fdxt2rff4b7csuks@wittgenstein>
References: <00000000000080e10e05dd043247@google.com>
 <20220420131925.2464685-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420131925.2464685-1-brauner@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:19:25PM +0200, Christian Brauner wrote:
> After mnt_hold_writers() has been called we will always have set MNT_WRITE_HOLD
> and consequently we always need to pair mnt_hold_writers() with
> mnt_unhold_writers(). After the recent cleanup in [1] where Al switched from a
> do-while to a for loop the cleanup currently fails to unset MNT_WRITE_HOLD for
> the first mount that was changed. Fix this and make sure that the first mount
> will be cleaned up and add some comments to make it more obvious.
> 
> Reported-by: syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com
> Reported-by: syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com
> Fixes: e257039f0fc7 ("mount_setattr(): clean the control flow and calling conventions") [1]
> Link: https://lore.kernel.org/lkml/0000000000007cc21d05dd0432b8@google.com
> Link: https://lore.kernel.org/lkml/00000000000080e10e05dd043247@google.com
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> This should fix the syzbot issue. This is only relevant for making a
> mount or mount tree read-only:
> 1. successul recursive read-only mount tree change:
>    Cleanup loop isn't executed.
> 2. failed recursive read-only mount tree change:
>    m will point to the mount we failed to handle. The cleanup loop will
>    run until p == m and then terminate.
> 3. successful single read-only mount change:
>    Cleanup loop won't be executed.
> 4. failed single read-only mount change:
>    m will point to mnt and the cleanup loop will terminate if p == m.
> I don't think there's any other weird corner cases since we now that
> MNT_WRITE_HOLD can only have been set by us as it requires
> lock_mount_hash() which we hold. So unconditionally unsetting it is
> fine. But please make sure to take a close look at the changed loop.
> ---

Unless I hear objections I'll route this upstream before -rc4 to get
this fixed because it's pretty trivial to trigger this.
