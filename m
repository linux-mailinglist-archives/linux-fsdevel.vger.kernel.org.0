Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCCE6EFE10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 01:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjDZXmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 19:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbjDZXmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230472684
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 16:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE50A61C5B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 23:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0621AC433EF;
        Wed, 26 Apr 2023 23:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682552522;
        bh=C5KQ7vzpBxcUOFH/2EXsgfvS3DyI2zJAA2Qs2OssPek=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=tccpkzogLScpv+VYVQ09nxbo9zz1EMmP97ljzaKqMwptL9xK5fZpe/BDXzCFuj9Cy
         yfuSYnf/8ikr+fZU1/x1zm54lfDJAUBGcPARXS4fhK/qWiorpp3WG+rmXI7mJybDuf
         kMbo10LaS1n6ojjKrBxBvJ61U0uO0x9QK5zaKN8dLnQugL/ASMuRwpLC+W48nYwejl
         a2tflCDrjrQzo+1qreqe/AD4D0opf0q9zVispM09Ffz9JVb0ITkfbIXQRWLEGbzlvu
         kJM02/qRDWBdfnu9fNGkVpYqvo7Z2kkW0vXSC3m4SvvSckDFfvm3ErAi5w9YHgat53
         wMvGPEOMM3Fug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D59EEE5FFC9;
        Wed, 26 Apr 2023 23:42:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     bugs@lists.linux.dev, willy@infradead.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Message-ID: <20230426-b217366c6-4f880518247a@bugzilla.kernel.org>
In-Reply-To: <ZEl34WthS8UNJnNd@casper.infradead.org>
References: <ZEl34WthS8UNJnNd@casper.infradead.org>
Subject: Re: large pause when opening file descriptor which is power of 2
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Wed, 26 Apr 2023 23:42:01 +0000 (UTC)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_FROM_NAME_TO_DOMAIN,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

phemmer+kernel writes via Kernel.org Bugzilla:

(In reply to Bugbot from comment #1)
> Matthew Wilcox <willy@infradead.org> writes:
> 
> On Wed, Apr 26, 2023 at 05:58:06PM +0000, Kernel.org Bugbot wrote:
> > When running a threaded program, and opening a file descriptor that
> > is a power of 2 (starting at 64), the call takes a very long time to
> > complete. Normally such a call takes less than 2us. However with this
> > issue, I've seen the call take up to around 50ms. Additionally this only
> > happens the first time, and not subsequent times that file descriptor is
> > used. I'm guessing there might be some expansion of some internal data
> > structures going on. But I cannot see why this process would take so long.
> 
> Because we allocate a new block of memory and then memcpy() the old
> block of memory into it.  This isn't surprising behaviour to me.
> I don't think there's much we can do to change it (Allocating a
> segmented array of file descriptors has previously been vetoed by
> people who have programs with a million file descriptors).  Is it
> causing you problems?

Yes. I'm using using sockets for IPC. Specifically haproxy with its SPOE protocol. Low latency is important. Normally a call (including optional connect if a new connection is needed) will easily complete in under 100us. So I want to set a timeout of 1ms to avoid blocking traffic. However because this issue effectively randomly pops up, that 1ms timeout is too low, and the issue can actually impact multiple in-flight requests because haproxy tries to share that one IPC connection for them all. But if I raise the timeout (and I'd have to raise it to something like 100ms, as I've seen delays up to 47ms in just light testing), then I run the risk of significantly impacting traffic if there is a legitimate slowdown. While a low timeout and the occasional failure is probably the better of the two options, I'd prefer not to fail at all.

View: https://bugzilla.kernel.org/show_bug.cgi?id=217366#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

