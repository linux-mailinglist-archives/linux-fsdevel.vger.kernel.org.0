Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977D74C8194
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 04:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiCADRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 22:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiCADRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:17:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E031ADAD
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 19:17:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso1017885pjb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 19:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D9x16hpYQdFpeB624xXKo/5BvFgV4Od1VIdDfB4dqJQ=;
        b=ly9WvSk6zUpjZVEFos11qbu1AHRjIws7KxqN6MNQ24+lQp4PAD94zNW9mUHv0byc9Z
         h2rOcqDlSnHTmBxtDIUgoesRu+anF0AmmCArmrOZIPizxDYoz58hdvnKpC0xGzO9CSlE
         U47YviJOVqkJ/pZyezz5dr6rNIkTdtWBo3+MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9x16hpYQdFpeB624xXKo/5BvFgV4Od1VIdDfB4dqJQ=;
        b=iJGZKCjTL1MiA8O9znAqgpcQuutJzKUIb0MeU+L83uI4tMj2dhUDJqFQ0BdtylLkMS
         N86nyTXlHBgdUo+QFVKimCpwJ+WjJF0qn8CMIg0+PrQt7WqfQ+FpLjzv4dxzEaLW2mv+
         9YTMNtQYkI5fQcSJfVIaDBEWilIsLr71IB1fsSoSvoYqyYySZWsNNV3tR6YRAelL7uW6
         2SsLmwX9aca3d74sw9Pz+hD0QM9zRTRm14eVtobUGauqRmqQaADg8XQNus6f22ZxIU+Y
         tA+5PIfTa7VjK6RwrAnPNXmZ57So6aYel0wPY3cfBbKlNstYlrFyFjcjrOgPN5M4fA2X
         FZWA==
X-Gm-Message-State: AOAM530LwAq6TQDEhx2QsyRAkhclocCJzBaZuCvL3V3M581w+au5FXNw
        yJnc5EMbQyvIuHdXZQA1uT3d3Q==
X-Google-Smtp-Source: ABdhPJyb0hp0sFIkfnr3V26CkkYMbl8AVw0UqnZQpd+BwVdHpRBFAEALSMG8jVi8fZskBxpwyHv6Iw==
X-Received: by 2002:a17:90a:6001:b0:1bb:83e8:1694 with SMTP id y1-20020a17090a600100b001bb83e81694mr19893304pji.127.1646104629348;
        Mon, 28 Feb 2022 19:17:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm14527808pfh.46.2022.02.28.19.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 19:17:09 -0800 (PST)
Date:   Mon, 28 Feb 2022 19:17:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
Message-ID: <202202281915.3479AB42@keescook>
References: <20220224054332.1852813-1-keescook@chromium.org>
 <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
 <202202232208.B416701@keescook>
 <20220224091550.2b7e8784@gandalf.local.home>
 <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 05:48:27PM -0800, Daniel Latypov wrote:
> On Thu, Feb 24, 2022 at 6:15 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 23 Feb 2022 22:13:25 -0800
> > Kees Cook <keescook@chromium.org> wrote:
> >
> > > Steven, I want to do fancy live-patch kind or things to replace functions,
> > > but it doesn't need to be particularly fancy because KUnit tests (usually)
> > > run single-threaded, etc. It looks like kprobes could almost do it, but
> > > I don't see a way to have it _avoid_ making a function call.
> >
> >
> > // This is called just before the hijacked function is called
> > static void notrace my_tramp(unsigned long ip, unsigned long parent_ip,
> >                              struct ftrace_ops *ops,
> >                              struct ftrace_regs *fregs)
> > {
> >         int bit;
> >
> >         bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >         if (WARN_ON_ONCE(bit < 0))
> >                 return;
> >
> >         /*
> >          * This uses the live kernel patching arch code to now return
> >          * to new_function() instead of the one that was called.
> >          * If you want to do a lookup, you can look at the "ip"
> >          * which will give you the function you are about to replace.
> >          * Note, it may not be equal to the function address,
> >          * but for that, you can have this:
> >          *   ip = ftrace_location(function_ip);
> >          * which will give the ip that is passed here.
> >          */
> >         klp_arch_set_pc(fregs, new_function);
> 
> Ahah!
> This was the missing bit.
> 
> David and I both got so excited by this we prototyped experimental
> APIs around this over the weekend.
> He also prototyped a more intrusive alternative to using ftrace and
> kernel livepatch since they don't work on all arches, like UML.

Yay! That's excellent. I didn't have time to try this myself, so I'm
delighted to see y'all got it working. Nice!

> We're splitting up responsibility and will each submit RFCs to the
> list in the coming days.
> I'll send the ftrace one based on this.
> He'll send his alternative one as well.
> I think we'll end up having both approaches as they both have their usecases.
> 
> It'll take some iteration to bikeshed stuff like names and make them
> more consistent with each other.
> I've posted my working copy on Gerrit for now, if people want to take
> a look: https://kunit-review.googlesource.com/c/linux/+/5109

Great! I'll go comment on it there.

-- 
Kees Cook
