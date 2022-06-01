Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2457653AD5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 21:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiFATa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFATa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 15:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5717C680;
        Wed,  1 Jun 2022 12:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F536142A;
        Wed,  1 Jun 2022 19:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E1C385A5;
        Wed,  1 Jun 2022 19:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654110324;
        bh=1akgIpnS2NMCsmFJbLar27DOGlMkxA6OTpRa8L7NgqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAHPkwQoedaM3ngPVtr3rQzGJm7crFgKZL7JKmcerqQITeveugqI65Pgy7SHkw5ry
         pyvIKGfOZfWDyGq8yy1ADRgaHkrScmQDQgRN/BxA7f9of5Ln/0XIKpQLo07V/r+JaF
         1M7AX4fdB+1t6FIhvpzqgH2gchz6NgfXcVph7kEQE0kHBaMwaYMpuW3TiyMDFCFB7V
         7bfuE9+4KuqYerzjijJOOuRbt082aqK+tnFo++iugwwVuLLADkQTn9kD/iVetN6PHa
         5BN62FnYLWrkP8/zroJoWBOXsWCST3ZFEumpscWLgqLWndRYTxlgmyIHJT5qxMnfhN
         x0qmMUvT/WbBQ==
Date:   Wed, 1 Jun 2022 21:05:17 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [RFC PATCH 2/4] sysctl: ipc: Do not use dynamic memory
Message-ID: <Ype4bRsuT6zBzPrA@example.org>
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org>
 <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
 <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com>
 <Ypeu97GDg6mNiKQ8@example.org>
 <CAHk-=wgBeQafNgw6DNUwM4vvw4snb83Tb65m_QH9XSic2JSJaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBeQafNgw6DNUwM4vvw4snb83Tb65m_QH9XSic2JSJaQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:34:18AM -0700, Linus Torvalds wrote:
> On Wed, Jun 1, 2022 at 11:25 AM Alexey Gladkov <legion@kernel.org> wrote:
> >
> > I'm not sure how to get rid of ctl_table since net sysctls are heavily
> > dependent on it.
> 
> I don't actually think it's worth getting rid of entirely, because
> there's just a lot of simple cases where it "JustWorks(tm)" and having
> just that table entry describe all the semantics is not wrong at all.
> 
> The name may suck, but hey, it's not a big deal. Changing it now would
> be more pain than it's worth.
> 
> No, I was more thinking that things that already need more
> infrastructure than that simple static ctl_table entry might be better
> off trying to migrate to your new "proper read op" model, and having
> more of that dynamic behavior in the read op.

This was part of my plan. I wanted to step by step try migrating other
sysctls to use open/read/write where it makes sense.

To be honest, it was Eric Biederman who came up with the idea to separate
open, read and write. I am very grateful to him.

> The whole "create dynamic ctl_table entries on the fly" model works,
> but it's kind of ugly.
> 
> Anyway, I think all of this is "I think there is more room for cleanup
> in this area", and maybe we'll never have enough motivation to
> actually do that.
> 
> Your patches seem to fix the extant issue with the ipc namespace, and
> the truly disgusting parts (although maybe there are other truly
> disgusting things hiding - I didn't go look for them).

I also hope to try and fix the f_cred issue.

-- 
Rgrds, legion

