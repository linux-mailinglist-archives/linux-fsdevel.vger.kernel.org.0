Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A85D6F3E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjEBHLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 03:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBHLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 03:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A41FC2;
        Tue,  2 May 2023 00:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6A8A61180;
        Tue,  2 May 2023 07:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C5C433D2;
        Tue,  2 May 2023 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683011505;
        bh=iP0pkPRPF2yyWma5T57Jl+IkunllF4npRD1ZDpsaR2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJi7VM57+hCZiS5pBrGaI+NHHdNu1FIF4IW0ha2PSCAiIoxG6tmcNLAbkXg0MA75C
         +VDM+LebMyBRMM8yVmZr7EVissdk0UXryUkZdicKjBqiNXEWwoUQe846hstBOFfKX7
         tzcIJoGi/7wv4eXxMhH96/1ekdQvRQphKUy3EE1UaruvbbDccOOIOHAwtTBA6jUU3v
         GiFL4mFRQqrMIxKAEix6xn+67N5dW1pa3lgg5wvQyPbINHPJ5WF6m0qpvfoO8WyRyf
         lNVLLGG0RL+qkhNkWlY/EZjM6hkeiQJ+pt+3qywul8y9ZcSzIp88HRGZfdbpMrl6ie
         Usm6IR1tKzdPA==
Date:   Tue, 2 May 2023 09:11:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230502-wunsch-stinktier-46d58b6b57d6@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV>
 <20230427073908.GA3390869@ZenIV>
 <CAHk-=whHbXMF142EGVu4=8bi8=JdexBL--d5FK4gx=x+SUgyaQ@mail.gmail.com>
 <20230427170215.GC3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427170215.GC3390869@ZenIV>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 06:02:15PM +0100, Al Viro wrote:
> On Thu, Apr 27, 2023 at 08:21:34AM -0700, Linus Torvalds wrote:
> > On Thu, Apr 27, 2023 at 12:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > int delayed_dup(struct file *file, unsigned flags)
> > 
> > Ok, this is strange. Let me think about it.
> > 
> > But even without thinking about it, this part I hate:
> > 
> > >         struct delayed_dup *p = kmalloc(sizeof(struct delayed_dup), GFP_KERNEL);
> > 
> > Sure, if this is only used in unimportant code where performance
> > doesn't matter, doing a kmalloc is fine.
> > 
> > But if that is the only use, I think this is too subtle an interface.
> 
> Still hadn't finished with the zoo...
> 
> > Could we instead limit it to "we only have one pending delayed dup",
> > and make this all be more like the restart-block thing, and be part of
> > struct task_struct?
> 
> Interesting...  FWIW, *anything* that wants several descriptors has
> special needs - there are some places like that (binder, for one)
> and they have rather weird code implementing those.
> 
> Just to restate the obvious: this is not applicable for the most frequent
> caller - open(2).  For the reasons that have nothing to do with performance.
> If opening the file has hard-to-reverse side effects (like directory
> modification due to O_CREAT), the things are very different.
> 
> What I hope for is a small number of patterns, with clear rules for
> choosing the one that is applicable and helpers for each that would
> reduce the amount of headache when using it.  And I've no problem
> with "this particular pattern is not usable if you are adding more
> than one descriptor" - that's not hard to understand and verify.
> So I'm fine with doing that for one descriptor only and getting
> rid of the allocation.
> 
> BTW, another pattern is the same sans the "delayed" part.  I.e.
> "here's an opened file, get a descriptor and either attach the
> file to it or fput() the damn thing; in any case, file reference
> is consumed and descriptor-or-error is returned".  That one is
> definitely only for single descriptor case.
> 
> In any case, I want to finish the survey of the callers first, just to
> see what's there and whether anything is worth nicking.
> 
> While we are at it, I want to make close_fd() use a very big red flag.
> To the point of grepping for new callers in -next and asking the folks
> who introduce those to explain WTF they are doing...

Yeah, I'd fully support this and would be very nice to have.
