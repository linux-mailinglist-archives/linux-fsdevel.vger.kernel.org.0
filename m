Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911CA789DEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjH0Mpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjH0MpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 08:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B813D;
        Sun, 27 Aug 2023 05:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 922CE611EE;
        Sun, 27 Aug 2023 12:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CDCC433C7;
        Sun, 27 Aug 2023 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693140316;
        bh=I4BzmJKtGwUNX8XAtTYMNV+M9Exu3kFE6GER6lqQcJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTmcg1ZQm1ZEQ4zULBQr3TwW98lcytB8ltae4wDbn8N/wC2ioKMoz32xUa5i+z0aU
         U+WTKP0uMSj+4nbjMelPg3iPZb7RwTcWrefMaTqbvZgJSHF1kkI4FokTwssLeTFqq6
         aC50uHdvA6NRP/cN6vuB1lOXcTvnlvmtJsbq0/qXNT1P33P84Nf6HKdfydXjWt7e/x
         okTrwFV8ScAdBksyENmHrGr/bUqAgUS5Xvb0KPDG+5hupcoBxvObfMbzMqUOmJ40n2
         Xs1l2rKvh3sNSkE4M2bjfO7hf6n2nHXWJlB7nycyQrAe03zV9ULaQhdCCic+/mHC6M
         JfHFwYEn4oDUw==
Date:   Sun, 27 Aug 2023 20:45:12 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
Message-ID: <20230827124512.23qnfe3keedrf4a2@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
 <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
 <a93ba004a46177c213159878a51c7378536f33ad.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a93ba004a46177c213159878a51c7378536f33ad.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:02:40AM -0400, Jeff Layton wrote:
> On Fri, 2023-08-25 at 22:11 +0800, Zorro Lang wrote:
> > On Thu, Aug 24, 2023 at 12:44:18PM -0400, Jeff Layton wrote:
> > > This test requires being able to set file capabilities which some
> > > filesystems (namely NFS) do not support. Add a _require_setcap test
> > > and only run it on filesystems that pass it.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  common/rc         | 13 +++++++++++++
> > >  tests/generic/513 |  1 +
> > >  2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 5c4429ed0425..33e74d20c28b 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5048,6 +5048,19 @@ _require_mknod()
> > >  	rm -f $TEST_DIR/$seq.null
> > >  }
> > >  
> > > +_require_setcap()
> > > +{
> > > +	local testfile=$TEST_DIR/setcaptest.$$
> > > +
> > > +	touch $testfile
> > > +	$SETCAP_PROG "cap_sys_module=p" $testfile > $testfile.out 2>&1
> > 
> > Actually we talked about the capabilities checking helper last year, as below:
> > 
> > https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mailbox/
> > 
> > As you bring this discussion back, how about the _require_capabilities() in
> > above link?
> > 
> 
> I was testing a similar patch, but your version looks better. Should I
> drop mine and you re-post yours?

Actually we decided to use `_require_attrs security`, rather than a new
_require_capabilities() helper. We need a chance/requirement to add
that helper (when a test case really need it).

So I hope know is `_require_attrs security` enough for you? Or you really
need a specific _require_capabilities helper?

Thanks,
Zorro

> 
> Thanks,
> --
> Jeff Layton <jlayton@kernel.org>
> 
