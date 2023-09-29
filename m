Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A87B2F14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjI2JU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2JU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:20:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E019F;
        Fri, 29 Sep 2023 02:20:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD19C433C8;
        Fri, 29 Sep 2023 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695979255;
        bh=ixqemPBH+Yg3YxK8N4iZBEZPhv5OujAqEu9rexAdDbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIMtzk+H6WnoeyiP7YtkRG5RIlr6lMjdgpmFCmotRRSzhFSHDrnxt4AxfFTAxNYqn
         wNuolRwkNNjaj2CqIEO2Ie20qub2K2zBxKnWbIpQ2RVPPri/JcDTBUxel/gwj6UlJj
         xxWoeeQ2Y+AkyS8iwQ+klD7M9fIFbRNKcvqgRpKJu8JT2kTIaiEQGlBhanuf23D7KU
         i6kLzgntHi9U0Q+ISvpVhh0l0dqtgxmN7fdvREQem0GoGwxHaoa1ICU9Ndida6u2Hf
         TymisZxBVP1BDxajl2hVFG0NtME0Ljg8T4VZxEnr3dttIGRQOUUtNt3Stra5W8ZQDt
         lyjU/Koh6J4vQ==
Date:   Fri, 29 Sep 2023 11:20:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
References: <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
 <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f>
 <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner>
 <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> But yes, that protection would be broken by SLAB_TYPESAFE_BY_RCU,
> since then the "f_count is zero" is no longer a final thing.

I've tried coming up with a patch that is simple enough so the pattern
is easy to follow and then converting all places to rely on a pattern
that combine lookup_fd_rcu() or similar with get_file_rcu(). The obvious
thing is that we'll force a few places to now always acquire a reference
when they don't really need one right now and that already may cause
performance issues.

We also can't fully get rid of plain get_file_rcu() uses itself because
of users such as mm->exe_file. They don't go from one of the rcu fdtable
lookup helpers to the struct file obviously. They rcu replace the file
pointer in their struct ofc so we could change get_file_rcu() to take a
struct file __rcu **f and then comparing that the passed in pointer
hasn't changed before we managed to do atomic_long_inc_not_zero(). Which
afaict should work for such cases.

But overall we would introduce a fairly big and at the same time subtle
semantic change. The idea is pretty neat and it was fun to do but I'm
just not convinced we should do it given how ubiquitous struct file is
used and now to make the semanics even more special by allowing
refcounts.

I've kept your original release_empty_file() proposal in vfs.misc which
I think is a really nice change.

Let me know if you all passionately disagree. ;)
