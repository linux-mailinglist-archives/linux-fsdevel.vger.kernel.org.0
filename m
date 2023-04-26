Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA36EF9AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 19:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjDZR6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjDZR6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8C618B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 10:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2085361904
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 17:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71801C433EF;
        Wed, 26 Apr 2023 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682531886;
        bh=tVZbMSemN2F1tYckFRvb2LOwtsDh3IXVvewzf3UdhzU=;
        h=From:To:Subject:Date:From;
        b=A45HMDx9Ozq5vGRJT9thY+vdfWpHGxmThU0fYs2rhqOPimmMrOrzwegdlKgzgkSGY
         hHfwXlNJhwDSj5y7t8O4FHL1AxEd+61WUYBGP/FhO6IyCP/8Tl+tgza/vEKHjxGIeJ
         LcHkn7MrHStTx9iqwWL+UGdHX+mIrQjy2COhayfcqTCss8TovPH0aTDOR9YqmCchOc
         msMISwHe0kIFdNyUBaX5WoujGWH5aZhIplIiJAuDxEpWpXfLpnFaXU/BY7t9zPORE7
         HK/lBZFs/IcnAFfKvLphiBWwA0s6O5ynHIu6P/pObEOv7uW+liYts3Y7/CeAC7nf1x
         gD+qHrV2wPuvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51305E5FFC8;
        Wed, 26 Apr 2023 17:58:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, bugs@lists.linux.dev
Message-ID: <20230426-b217366c0-53b6841a1f9a@bugzilla.kernel.org>
Subject: large pause when opening file descriptor which is power of 2
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Wed, 26 Apr 2023 17:58:06 +0000 (UTC)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_FROM_NAME_TO_DOMAIN,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

phemmer+kernel added an attachment on Kernel.org Bugzilla:

Created attachment 304186
issue demonstration code

When running a threaded program, and opening a file descriptor that is a power of 2 (starting at 64), the call takes a very long time to complete. Normally such a call takes less than 2us. However with this issue, I've seen the call take up to around 50ms. Additionally this only happens the first time, and not subsequent times that file descriptor is used. I'm guessing there might be some expansion of some internal data structures going on. But I cannot see why this process would take so long.

Attached is a simple program that can reproduce the issue. The following is example output:

...
FD=62 duration=2695
FD=63 duration=2726
FD=64 duration=12565293
FD=64 duration=3837 (second attempt)
FD=65 duration=1523
FD=66 duration=1533
...
FD=126 duration=1463
FD=127 duration=1402
FD=128 duration=24755063
FD=128 duration=3186 (second attempt)
FD=129 duration=1433
FD=130 duration=1413
...
FD=254 duration=1363
FD=255 duration=1493
FD=256 duration=7602777
FD=256 duration=1573 (second attempt)
FD=257 duration=1392
FD=258 duration=1363
...

I've reproduced the issue on systems running multiple different 4.19 kernels, and on a system running 6.2.8

File: fd_pause.c (text/x-csrc)
Size: 970.00 B
Link: https://bugzilla.kernel.org/attachment.cgi?id=304186
---
issue demonstration code

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

