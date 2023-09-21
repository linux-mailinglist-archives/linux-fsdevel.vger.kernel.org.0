Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7A7AA256
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjIUVPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjIUVPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7193E7C;
        Thu, 21 Sep 2023 10:01:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8679C4E76D;
        Thu, 21 Sep 2023 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695310783;
        bh=uYVlm/OIEaOutBVNTPIBA236dBBtpUyrHH0HN4wLzhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGR2l/W03hla20JYdlkq7EekmlH6p8kGp50LSS2LZD5MUCmiEcrw8gM2lM2v+LJBl
         AMAUlDvrAd1/yhItY6tksPCOMxjMW5MBM0I8D8teAZjlMuAn6qxslEJSy+wOheJN67
         eodx5UJmeELkSf+1xLXh2SR5qEHHC5zBLNX3x/MC/ImehMH7VIhbLedjMq2NbjdAdG
         hWsTlJ1ZTA2RtfN2pUdtYOhFa49HG5Q5zePRiXdV3CHCkWsHaWT1hwZ4qzXqEA+DOo
         tBb17rokUAnO17IQRxVLwXow+7/OrJ6vRhfRYXJj2J0zPU/Z3Cajq/HUJpW5Q5E522
         aNC+b+T3rpgCg==
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, howells@redhat.com
Subject: Re: [PATCH 1/4] pipe: reduce padding in struct pipe_inode_info
Date:   Thu, 21 Sep 2023 17:39:36 +0200
Message-Id: <20230921-witzig-magen-54a20bb51111@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075755.1378787-1-max.kellermann@ionos.com>
References: <20230921075755.1378787-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=brauner@kernel.org; h=from:subject:message-id; bh=uYVlm/OIEaOutBVNTPIBA236dBBtpUyrHH0HN4wLzhw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTyJC9/uetGWdDsvTEzwrdzKVVtYUxO1mCKNnktIHtas6O3 9+LJjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlwVzL8szdYEtwRvszyV1IK3z7WV6 Xr/G8FK0YpPXZJ/bfY48OMBQx/OBNbeIRdnm/fEHLqi1pqhGPW/RUCfT4bz/1oFoj0PxzMCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sep 2023 09:57:52 +0200, Max Kellermann wrote:
> This has no effect on 64 bit because there are 10 32-bit integers
> surrounding the two bools, but on 32 bit architectures, this reduces
> the struct size by 4 bytes by merging the two bools into one word.
> 
> 

I've massaged the last commit a bit and moved that bit into a helper
instead of indentorama in pipe_write(). keyutils watchqueue tests and
LTP pipe and watch queue tests pass without regressions.

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

[1/4] pipe: reduce padding in struct pipe_inode_info
      https://git.kernel.org/vfs/vfs/c/5ba6d9b6d526
[2/4] fs/pipe: move check to pipe_has_watch_queue()
      https://git.kernel.org/vfs/vfs/c/7084dde72592
[3/4] fs/pipe: remove unnecessary spinlock from pipe_write()
      https://git.kernel.org/vfs/vfs/c/b9e8c77cad52
[4/4] fs/pipe: use spinlock in pipe_read() only if there is a watch_queue
      https://git.kernel.org/vfs/vfs/c/4c280825d39c
