Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719C174600A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGCPov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 11:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCPou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3EC2;
        Mon,  3 Jul 2023 08:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08EAD60C99;
        Mon,  3 Jul 2023 15:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE0C433C7;
        Mon,  3 Jul 2023 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688399088;
        bh=l0DvOL//USi2lqvRXSzMngtGqd5DmqlrA9BY0bMWvHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGjjc3nh/maweUxqtW5ytHIKQqicf4tPzLpdutzP//U4t/Rf+bicM1Ee8zmp7NXiN
         svZU3pec+Vvv5UjedwGopBFkgNxYsGwFxW8vJ8lk3/i68JoIV2j5sQa58FS9WQil3C
         HMol9tR+CxyQy+NjLAVlArXdB09bnEic8ygZXN99MTKCAjB0LyLOhA7xWHwD4zgi3/
         L9pJv2c0rdPwA12B3bGKsZ7rtNuyBtseJ9ouT0W23+z+DcR7C5fPwYa0pd5PouyhSC
         36/9rJpInWSHt/f7cPUjfMIRQlA2FipRf+bqV4o4QHybAXByVVj283bxUwh8Z9bwGY
         LT+IHipJRWdfg==
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?q?Ahelenia_Ziemia=C5=84ska_=3Cnabijaczleweli=40nabijaczleweli=2E?=@vger.kernel.org,
        =?utf-8?q?xyz=3E?=@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] fanotify accounting for fs/splice.c
Date:   Mon,  3 Jul 2023 17:44:15 +0200
Message-Id: <20230703-heilkraft-wohlbefinden-1f293bd90cf3@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=brauner@kernel.org; h=from:subject:message-id; bh=l0DvOL//USi2lqvRXSzMngtGqd5DmqlrA9BY0bMWvHg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQserNj1mHze3OnrVtvO9PQSe7GbLUVp1qNRFQWs9ddWhag e2TelI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ+EszMly96Ckenbb36vGVvDmx/r orP6z5YLf1dOviG+6n5c2mbljL8L/YpId59eEfgUlndkrJ/Vgue3i3Qt/6t61dBhpekRNvT+YCAA==
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

On Mon, 03 Jul 2023 16:42:05 +0200, Ahelenia Ziemiańska wrote:
> Previously: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> 
> In short:
>   * most read/write APIs generate ACCESS/MODIFY for the read/written file(s)
>   * except the [vm]splice/tee family
>     (actually, since 6.4, splice itself /does/ generate events but only
>      for the non-pipes being spliced from/to; this commit is Fixes:ed)
>   * userspace that registers (i|fa)notify on pipes usually relies on it
>     actually working (coreutils tail -f is the primo example)
>   * it's sub-optimal when someone with a magic syscall can fill up a
>     pipe simultaneously ensuring it will never get serviced
> 
> [...]

Fixed the missing single-line-{} after multi-line-{} style problem that
Amir mentioned.

---

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

[1/3] splice: always fsnotify_access(in), fsnotify_modify(out) on success
      https://git.kernel.org/vfs/vfs/c/cade9d70ce70
[2/3] splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
      https://git.kernel.org/vfs/vfs/c/6aa55b7b85b5
[3/3] splice: fsnotify_access(in), fsnotify_modify(out) on success in tee
      https://git.kernel.org/vfs/vfs/c/6e7556086b19
