Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2549377471D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjHHTJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjHHTJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47B12FA38;
        Tue,  8 Aug 2023 09:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B7D62424;
        Tue,  8 Aug 2023 08:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAD3C433C8;
        Tue,  8 Aug 2023 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691482389;
        bh=y9XQVThjRdhnGyExHEkcXNTzSHvlo6PxeDKLk8WgPzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIPAb16r3NVZMlvqlGWqbF1dusRG9lwMbTXvdQAlXGLm//GPyvpBG25v/bx6MbmcA
         EB5+aUg7di9BV2xC9Dt5ZrkA54aFLOU8M9G27QaQ9QI9ZIDGtJoJqUuCJdxkSSi3gG
         s09IBVgT0lEGBvOoHK138BVBgFJM0d6oKcgCBhER3bMFtypKwUDC836pyCY7vr0r98
         2sZ0YgYqIRHNA5+rib+iM3VPLZSKt4RdLTP4DByxgxGOzrDR5/OLxeJgIDNiI0+92h
         aIE1GtTc6G5DinMaG64cC6Kp4lHyTU27k+eVHLJXMV3eLKo+O/MQjrqW++MWil8h+z
         c1uGwyLLBIhZQ==
Date:   Tue, 8 Aug 2023 10:13:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
Message-ID: <20230808-eingaben-lumpen-e3d227386e23@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
 <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Are there any real world gains if close(2) is the only place this
> optimization can be applied?  Is the added maintenance burden worth the
> speed up?

Tbh, none of this patch makes me exited.

It adds two new exports of filp_close_sync() and close_fd_sync() without
any users. That's not something we do and we also shouldn't encourage
random drivers to switch to sync behavior.

That rseq thing is completely orthogonal and maybe that needs to be
fixed and you can go and convince the glibc people to do it.

And making filp_close() fully sync again is also really not great.
Simplicity wins out and if all codepaths share the same behavior we're
better off then having parts use task work and other parts just not.

Yes, we just did re-added the f_pos optimization because it may have had
an impact. And that makes more sense because that was something we had
changed just a few days/weeks before.

But this is over 10 year old behavior and this micro benchmarking isn't
a strong selling point imho. We could make close(2) go sync, sure. But
I'm skeptical even about this without real-world data or from a proper
testsuite.

(There's also a stray sysctl_fput_sync there which is scary to think that
we'd ever allow a sysctl that allows userspace to control how we close
fds.)

> Unless you can find some real world performance gains this looks like
> a bad idea.

I agree.
