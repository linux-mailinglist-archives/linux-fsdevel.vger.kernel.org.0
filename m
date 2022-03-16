Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF04DA898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 03:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351467AbiCPCtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 22:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiCPCtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:49:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25328BF65
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:48:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t2so1944927pfj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VEjMUxikC5c2N/1mDp5apiWJgO+0KneP5geVjKUCm/c=;
        b=Sfk8Zv6ImcdViWjE/jqLY3Rz2H6Kuwl24swdtM6ZbReefQTrgCe55TfG8ko1Cv1VW8
         hEaL+XS1fzmObSueOuh4gmkYaBX/6Bvdwax//V0/RtWRSYCtUludbx/hHl8kZlKcTpJy
         jrzNkSzA9XfMNO6N0TnmPNnlsOjqc9+xXBXLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEjMUxikC5c2N/1mDp5apiWJgO+0KneP5geVjKUCm/c=;
        b=l1g6XclxgJqHpxZwiuiRmRFP3r+0ZfAPemTJX8F1VOJc8WtYTvbkwyRZEK81T7en8e
         E6jOYaFksxYYLf3WZCBOyW1l6K9DR6CfA8CKbBwC5YpWg8aEWCJOSWuLg2YB1AJq49Jt
         xAZpBsMR0Kle621OjQLVhwpzo5PJIj5ezCFQDj5KWjykxAm4lEXQbT6O38ocLmhHsHES
         hm6CbRqwWfC/nKhshqswShoEnStB50X6KKRZF6wD8k1m5WkKEo8BhUNoJI5ftzh7Lj2E
         rsMX4Z6wOA9nYsHk2g4zM3STOmBYrxQgFWUAEVAloXjwI08XRKWmj3Ix3MGskZLJ7unX
         BVFg==
X-Gm-Message-State: AOAM5321+jx2Y6gNCITTI8Zaq0Ly7qfYY5NRVB8BqH6Z16K/NJVHybhZ
        7q9kStcnm3Jv8iwRh3Z5rz74Bg==
X-Google-Smtp-Source: ABdhPJxIAmZOdaBx6oEg40uGn9u8aGZEfDalrJGlGNchOrj64K5ZbVuuMp2iwEVVQmvPG1/aj1q1qA==
X-Received: by 2002:a63:464d:0:b0:380:f8fd:50c5 with SMTP id v13-20020a63464d000000b00380f8fd50c5mr23325446pgk.475.1647398886492;
        Tue, 15 Mar 2022 19:48:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6-20020a056a0008c600b004f667b8a6b6sm519438pfu.193.2022.03.15.19.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:48:06 -0700 (PDT)
Date:   Tue, 15 Mar 2022 19:48:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 3/3] elf: Don't write past end of notes for regset gap
Message-ID: <202203151946.0ECF6FC@keescook>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
 <20220315201706.7576-4-rick.p.edgecombe@intel.com>
 <202203151329.0483BED@keescook>
 <983f20076ae02f0b33d4609b19cb22ab379174f1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983f20076ae02f0b33d4609b19cb22ab379174f1.camel@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:48:29PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-03-15 at 13:37 -0700, Kees Cook wrote:
> > >        /*
> > >         * Each other regset might generate a note too.  For each
> > > regset
> > > -      * that has no core_note_type or is inactive, we leave t-
> > > >notes[i]
> > > -      * all zero and we'll know to skip writing it later.
> > > +      * that has no core_note_type or is inactive, skip it.
> > >         */
> > > -     for (i = 1; i < view->n; ++i) {
> > > -             const struct user_regset *regset = &view->regsets[i];
> > > +     note_iter = 1;
> > > +     for (view_iter = 1; view_iter < view->n; ++view_iter) {
> > > +             const struct user_regset *regset = &view-
> > > >regsets[view_iter];
> > >                int note_type = regset->core_note_type;
> > >                bool is_fpreg = note_type == NT_PRFPREG;
> > >                void *data;
> > > @@ -1800,10 +1800,11 @@ static int fill_thread_core_info(struct
> > > elf_thread_core_info *t,
> > >                if (is_fpreg)
> > >                        SET_PR_FPVALID(&t->prstatus);
> > >   
> > 
> > info->thread_notes contains the count. Since fill_thread_core_info()
> > passes a info member by reference, it might make sense to just pass
> > info
> > itself, then the size can be written and a bounds-check can be added
> > here:
> > 
> >                 if (WARN_ON_ONCE(i >= info->thread_notes))
> >                         continue;
> 
> Hi Kees,
> 
> Thanks for the quick response.
> 
> Are you saying in addition to utilizing the allocation better, also
> catch if the allocation is still too small? Or do this check instead of
> the change in how to utilize the array, and then maintain the
> restriction on having gaps in the regsets?

What I want is to have writers of dynamically-sized arrays able to do
the bounds check in the same place the write happens, so passing "info"
makes sense to me.

-- 
Kees Cook
