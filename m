Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39147A895A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjITQW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 12:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjITQWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:22:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C33AC6;
        Wed, 20 Sep 2023 09:22:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6997CC433C7;
        Wed, 20 Sep 2023 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695226938;
        bh=zqUtIsy1908oUIkv0om6lTekNIepRDXybEdk/VA7TJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+xHhfz+VgkgAK7YjiSKFYBP9+/3lkbcXIegoOxMwnNt1yD4+IDf9MqsUVEbxzald
         xcVHs1sfqoqTJRYaV9O0cZK4AaS5tU6wB2U2Ayzf4ZuGEiFCdwhv3PfuYWIDAmBVX8
         eTfSTgAdDCEoI/4B+oLnlvDzYBOm8wYhmbCPRzPZQ49t91v6+BHghNmTnld+3oTweq
         Lj6mW7w7T9xaPYIX3Qsm3PF4j9DioR3HaiuyElhRSD4fvvObz+/Ri4hhpPpQ9ZkUUj
         WyJBlPXALMOI0ieVPGLQ5WOS1reBHETNWP/9QsnInbmHTzs9rETbpCf5px8m+MUnkZ
         ga+PcltMZoPug==
Date:   Wed, 20 Sep 2023 18:22:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] timestamp fixes
Message-ID: <20230920-fixpunkt-besingen-128f43c16416@brauner>
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
 <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
 <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
 <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
 <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
 <20230919-kranz-entsagen-064754671396@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919-kranz-entsagen-064754671396@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:28:11AM +0200, Christian Brauner wrote:
> > Christian - I'm just going to assume that you'll sort this out and
> > I'll get a new pull request at some point. Holler if you think
> > something else is needed, ok?
> 
> I'll take care of it and will send you a new pull request once
> everything's sorted. Thanks for looking!

In the meantime we had a report that unconditionally enabling
multi-grain timestamps causes a regression for some users workloads.

So, the honest thing is to revert the five commits that introduced the
infrastructure on top of the cleanup we did for v6.6. Jeff and Jan
agreed and we can give it another go for v6.7+. The general improvements
to timestamp handling and related cleanup stand on their.

I'll be putting the reverts into -next now and I'll get you a pull
request by the end of the week. In case you'd rather do it right now
it's already here:

git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc3.vfs.ctime.revert

I'd put something like:

Users reported regressions due to enabling multi-grained timestamps
unconditionally because timestamps appeared stale and could break
compilation. As no clear consensus on a solution has come up and the
discussion has gone back to the drawing board whether we should even
expose this to userspace, revert the infrastructure changes for. If it
isn't code that's here to stay, make it go away.

Sorry for the inconvenience.
Christian
