Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3576F0A71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbjD0RCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbjD0RCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:02:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5608619B4;
        Thu, 27 Apr 2023 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=zypDSDQGjqOR/FlsseRpY/ND9Ad0YBH9OoP0qBm0Myo=; b=QBV+c3q+txlofLC38SEyM6DGjo
        fgdhNXdlrM6jbKA7UiS1CCjkz9hRePkAZYj8gJeE5rr+XWV5fnrdjtQl89ZyS2M4f+Ns2qeDsjOWu
        DQ9QA0nFZvqbT8o9/PsALZb4tkcT6evTvH3Nux4zLrs+FR1XF2cqytdBTSdj0cMLOMFN8t8/7DyD5
        N5DDxwqE9Ur4mgBp0P9UBupkJQohFPTzUkCAnuzMEjrhX0rh/WEWz8DE/e+F1MwpEo8SF4sgjAjf0
        SqQsF/a9J+lI+NUQ7nmYpYeID+Catr3ql2fnu2JQYG4Wvl3srqZc/xRZtlk7BYywaUrZjud+staXz
        dfbjUdOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ps50Z-00DDpV-29;
        Thu, 27 Apr 2023 17:02:15 +0000
Date:   Thu, 27 Apr 2023 18:02:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230427170215.GC3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV>
 <20230427073908.GA3390869@ZenIV>
 <CAHk-=whHbXMF142EGVu4=8bi8=JdexBL--d5FK4gx=x+SUgyaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whHbXMF142EGVu4=8bi8=JdexBL--d5FK4gx=x+SUgyaQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 08:21:34AM -0700, Linus Torvalds wrote:
> On Thu, Apr 27, 2023 at 12:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > int delayed_dup(struct file *file, unsigned flags)
> 
> Ok, this is strange. Let me think about it.
> 
> But even without thinking about it, this part I hate:
> 
> >         struct delayed_dup *p = kmalloc(sizeof(struct delayed_dup), GFP_KERNEL);
> 
> Sure, if this is only used in unimportant code where performance
> doesn't matter, doing a kmalloc is fine.
> 
> But if that is the only use, I think this is too subtle an interface.

Still hadn't finished with the zoo...

> Could we instead limit it to "we only have one pending delayed dup",
> and make this all be more like the restart-block thing, and be part of
> struct task_struct?

Interesting...  FWIW, *anything* that wants several descriptors has
special needs - there are some places like that (binder, for one)
and they have rather weird code implementing those.

Just to restate the obvious: this is not applicable for the most frequent
caller - open(2).  For the reasons that have nothing to do with performance.
If opening the file has hard-to-reverse side effects (like directory
modification due to O_CREAT), the things are very different.

What I hope for is a small number of patterns, with clear rules for
choosing the one that is applicable and helpers for each that would
reduce the amount of headache when using it.  And I've no problem
with "this particular pattern is not usable if you are adding more
than one descriptor" - that's not hard to understand and verify.
So I'm fine with doing that for one descriptor only and getting
rid of the allocation.

BTW, another pattern is the same sans the "delayed" part.  I.e.
"here's an opened file, get a descriptor and either attach the
file to it or fput() the damn thing; in any case, file reference
is consumed and descriptor-or-error is returned".  That one is
definitely only for single descriptor case.

In any case, I want to finish the survey of the callers first, just to
see what's there and whether anything is worth nicking.

While we are at it, I want to make close_fd() use a very big red flag.
To the point of grepping for new callers in -next and asking the folks
who introduce those to explain WTF they are doing...
