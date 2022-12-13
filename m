Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE2864B226
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 10:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiLMJUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 04:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiLMJTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:19:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C132BFB;
        Tue, 13 Dec 2022 01:19:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6951B810DF;
        Tue, 13 Dec 2022 09:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32500C433EF;
        Tue, 13 Dec 2022 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670923182;
        bh=tFne0xthz+EtxoclkKpYRT/JOXwYWJ7gjsUvH8OM7I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnKMSZqDUBWL1JuPMZAxngIXaWqyoSy7c8zHUtL5eMi3GJCFdcMx6cOvWDS9sqaQC
         6x5/dlLuZoEZNx0fECKM+Bn4+deLKKKUsRY0cMVCOq/cGNaFyFwjMHtX19/wsSfgFM
         X4rsXRLfQqP5rpBa9cA2m+fJUZVt0Xz4BGfTQbdj6AlWomQ2fLEPrLQP612/90aPkJ
         ZsHyW06fy9OK85cbAhuy4FepC4R223CVZQpWgZbP54vWFmPhEefWrDzvGWI6iCBIPq
         m1BUbPTzi6S2JYJPn7OXinZ6pHLUv3zxF2QDujq1QDbfITvZV5axMRb4YyPke8SbkB
         1PgYg7rNDqPAA==
Date:   Tue, 13 Dec 2022 10:19:37 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfsuid updates for v6.2
Message-ID: <20221213091937.dmshin7hd6hqsliq@wittgenstein>
References: <20221212123348.169903-1-brauner@kernel.org>
 <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 12, 2022 at 07:28:59PM -0800, Linus Torvalds wrote:
> On Mon, Dec 12, 2022 at 4:34 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > This pull request converts all remaining places that still make use of non-type
> > safe idmapping helpers to rely on the new type safe vfs{g,u}id based helpers.
> > Afterwards it removes all the old non-type safe helpers.
> 
> So I've pulled this, but I'm not entirely happy about some of those
> crazy helpers.
> 
> In particular, the whole "ordering" helpers are really not something
> that should be used in general, I feel. I'm talking about
> vfsuid_gt_kuid() and friends - it's an entirely insane operation and
> makes no sense at all.

Oh yes, I very much agree.

> 
> Yes, yes, I understand why they exist (those crazy IMA rules), but I

I would've really liked to have avoided their existence altogether but I
have no clear idea what ima is doing with these comparisons. And
everytime we do wider scoped vfs work I spend about 1 or 2 good weeks in
security/ just to understand what all the various security modules do,
audit callchains and then come up with something that doesn't break half
of them. And often this means unpleasant compromises in the vfs layer
which I really don't like.

And just to be clear, I don't want to be on of those "LSMs are bad"
people. I do really think they provide additional value.
But I think it's fair to acknowledge that the hook infrastructure with
multiple LSMs makes the vfs and developers pay when reworking codepaths.

And the fact that some things that are LSM-like (ima etc.) have separate
hooks doesn't help either.

> feel that those functions *really* shouldn't be exposed to anybody
> else.
> 
> IOW, making those insane functions available in <linux/idmapping.h>
> really seems wrong to me. They are crazy special cases, and I think
> they should exist purely in that crazy ima_security file.
> 
> Again - I've pulled this, but I'm hoping to see a future commit that
> limits that craziness to the only user, in the hope that this disease
> will never spread.

Let me see what I can do about this. Hopefully I can still find
something during the merge window.
