Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838DB5FA78E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 00:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJJWMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJJWMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:12:30 -0400
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 15:12:24 PDT
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDE037F0B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 15:12:24 -0700 (PDT)
Received: from [192.168.1.11] (lfbn-tou-1-1359-241.w90-89.abo.wanadoo.fr [90.89.169.241])
        by mail.nightmared.fr (Postfix) with ESMTPSA id 7FB5210800DA;
        Mon, 10 Oct 2022 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
        s=docker; t=1665439477;
        bh=2iIxIr6w8Z2fz22wXLcr+gNagDgkbEZ+8dA8qfjcUdY=;
        h=Date:From:To:Cc:Subject;
        b=if1zgzsyTFmdiU3aU6wgssZAKGjOzOdbHv6Lwe96Yd3ia2v5Hrs+d9yr3lDEsIeFu
         CdO7zAXXKSBOp0ivlZwVCBOVw9WLRReh3cYG6MZVAHjPIC2GR3L2r3paAK3glg+tDm
         2fZlarIU9duYz0qJGLhxcBLgk1xCL+Dn8bej/3hgbmxBnafoebqx4pL2Vuzydr/4+G
         cyE16A0fG8wnSehU3xaqIpVtO4sRvDU5nB+/jTwZcqQ3e15pFNvKpjQRh+ALfKcvMy
         ypY97PpvM8Jd9hqkbuVHCvzido7kOwpOvmMEFcz5gVowZqURV7+BxBw+25h1m80ZE2
         WFjmMa30MUGyA==
Message-ID: <bb1fef84-4c4c-d0d2-3422-c96773996a1b@nightmared.fr>
Date:   Tue, 11 Oct 2022 00:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: fr, en-US
From:   Simon Thoby <work.viveris@nightmared.fr>
To:     ebiederm@xmission.com
Cc:     =?UTF-8?Q?CONZELMANN_Fran=c3=a7ois?= 
        <Francois.CONZELMANN@viveris.fr>, simon.thoby@viveris.fr,
        linux-fsdevel@vger.kernel.org
Subject: Enabling unprivileged mounts on fuseblk filesystems
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Eric,

in 2018 you commited to the FS subsystem a patch to enable mounting FUSE filesystems inside user namespaces, for which I am grateful.

That patch (https://lore.kernel.org/all/87tvqqo8w1.fsf_-_@xmission.com/) enabled the FS_USERNS_MOUNT filesystem flag for the "fuse" filesystem type.
To the best of my understanding, this allows any program owning the CAP_SYS_ADMIN privilege inside its user namespace to mount filesystems of that type (unlike the default behavior for filesystems, ~FS_USERNS_MOUNT, that requires owning CAP_SYS_ADMIN inside the "initial" user namespace): https://elixir.bootlin.com/linux/latest/source/fs/super.c#L516.

However that option was not enabled on the "fuseblk" filesystem type.
I discovered this today while trying to use ntfs-3g on a block device inside an unprivileged container.
Looking at it a bit further with a colleague, we realized that programs like fusefat worked because they relied on the "fuse" type, and not "fuselblk".
Which is finally what led me to believe that the lack of the FS_USERNS_MOUNT flag was the culprit.
And indeed, patching ntfs-3g to always use the "fuse" filesystem type instead of the preferred "fuseblk" works reliably, so at least we know some way to bypass that issue.

However, we were curious to know if I missed some rationale that would prevent that flag for being usable on "fuseblk" too?

And if they weren't, would you be opposed to a patch similar to what follows?

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..d17f87531dc8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1839,7 +1839,7 @@ static struct file_system_type fuseblk_fs_type = {
         .init_fs_context = fuse_init_fs_context,
         .parameters     = fuse_fs_parameters,
         .kill_sb        = fuse_kill_sb_blk,
-       .fs_flags       = FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
+       .fs_flags       = FS_REQUIRES_DEV | FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
  };
  MODULE_ALIAS_FS("fuseblk");


Sorry to bother you with this 4 years after the patch ^^

Thanks,
Simon
