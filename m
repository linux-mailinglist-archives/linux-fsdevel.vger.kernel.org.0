Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE89368216D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 02:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjAaBiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 20:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjAaBiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:38:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40906FF1F;
        Mon, 30 Jan 2023 17:38:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8921B81717;
        Tue, 31 Jan 2023 01:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78657C433D2;
        Tue, 31 Jan 2023 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675129087;
        bh=p8rjZ2ZSEPjYMVeONqI71+TRmPhpzTGSPlp4lOd32CA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y/W/VgyPoIN7rq7iQdpEymtUzWijQCBPF7nQ0mGuJ30YgqpxR0PAhTF2F+7UIQ5a5
         0R6JGhsLcfIUL3gN8VND2m2ekcJKgr9qgqRu1kDv64fS7ZyebkakVRB3y+Ss2H9JXd
         A5NdeE2+sl2/qwp+KizR97BsNauedXaU7aKZF6+VQwtJ4vBwXA/lB8wSkfe8KvgwhQ
         +SFODQYnJh1jaBZGM2efvWXbqawpiwLeGlhc+fbzcDUWy/H0bkO97pfp8N6W73I2Rp
         7P4LX/yk2QrY8jtRxMmSrvsf8UZbFvXl3wWywHniBYuXOSg34ByMOQoQ7M3KcI86lh
         HurKPywxWOMLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 624EDC04E36;
        Tue, 31 Jan 2023 01:38:07 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Fix incorrect mixing of wake/wait and missing barriers
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3425804.1675083883@warthog.procyon.org.uk>
References: <3425804.1675083883@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3425804.1675083883@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20230130
X-PR-Tracked-Commit-Id: 3288666c72568fe1cc7f5c5ae33dfd3ab18004c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22b8077d0fcec86c6ed0e0fce9f7e7e5a4c2d56a
Message-Id: <167512908739.24036.4996707554388866402.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Jan 2023 01:38:07 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, David Howells <dhowells@redhat.com>,
        Hou Tao <houtao@huaweicloud.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com,
        linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 30 Jan 2023 13:04:43 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20230130

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22b8077d0fcec86c6ed0e0fce9f7e7e5a4c2d56a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
