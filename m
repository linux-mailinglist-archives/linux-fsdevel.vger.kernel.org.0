Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C101E4D2408
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 23:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350603AbiCHWN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 17:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350601AbiCHWN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:13:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69983337A
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 14:12:55 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o26so318586pgb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bkKtesSrq7QqPtPRsrv5MP5UVhIFuJzVkEWr+6F4jZg=;
        b=HB7Qh4AtVpk8d37bKeerp0qFPsowgSyoNUGO3LpWmMZyfhC0KY2vF+/9yFB3whMWqV
         r6ygdwoC5f3KyA6nBZBdysI+OaD0+1ZMeKlMNQMyoVYqJrw7jHy0RmxmooM5aq4XJh/k
         7px/K05dn+P2MGUsxJHuEwW0DQyufasrdA/CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bkKtesSrq7QqPtPRsrv5MP5UVhIFuJzVkEWr+6F4jZg=;
        b=VwV164ZcrQVcRxE7a2SQJe1r2VZgdZwn6yjrsJqHuBWC076S2MdB1/dLX/3+GFKGHd
         VARVWYoZHGL1+46ZQ2Vyca7OXusIIqKcddiQ0d63B/05ZAfW04RjOKodGRDR4CPoV5so
         j5EnJEcG8mfm11ZpNTPreMzk1Gl7VNq3Ez0DWI8QQDGOGLCWnBKA21RqwihLHw79fetZ
         AVVRKov+JV0zNBhBAPvGRi93q8FnQU4w4JsaONThmBn3rJ7mhSVac+q+0abNxhwqwN+7
         LfWFpOVejS1LRs0lmDFme8YSmdAjGcSgp+cSp45CiijmPBS+KN44wUXUBtZXYzaDMbPQ
         HgYA==
X-Gm-Message-State: AOAM5312NvhZfRA37mg4xmZr5KUsluS7bIV7gIbknGdZttO6E1iCq3SP
        8AZzRO5Ex1BQgAFNQFy0n/3rxA==
X-Google-Smtp-Source: ABdhPJxAagA58tSNDoUZKDWEzQaeBwAsi4rPzMdnA3AIz7iJkUTWHfbJDFjsTEW6XG4sdCX9pvm2qg==
X-Received: by 2002:aa7:8256:0:b0:4e0:78ad:eb81 with SMTP id e22-20020aa78256000000b004e078adeb81mr20546718pfn.30.1646777575321;
        Tue, 08 Mar 2022 14:12:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00194900b004e1583f88a2sm66527pfk.0.2022.03.08.14.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:12:55 -0800 (PST)
Date:   Tue, 8 Mar 2022 14:12:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Daniel Latypov <dlatypov@google.com>,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Introduce KUnit test
Message-ID: <202203081408.0B0FC34C@keescook>
References: <20220304044831.962450-1-keescook@chromium.org>
 <YifJqN+5ju4kHQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YifJqN+5ju4kHQ2y@localhost.localdomain>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:24:56AM +0300, Alexey Dobriyan wrote:
> On Thu, Mar 03, 2022 at 08:48:31PM -0800, Kees Cook wrote:
> > Adds simple KUnit test for some binfmt_elf internals: specifically a
> > regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
> > fix overflow in total mapping size calculation").
> 
> > +	/* No headers, no size. */
> > +	KUNIT_EXPECT_EQ(test, total_mapping_size(NULL, 0), 0);
> 
> This is meaningless test. This whole function only makes sense
> if program headers are read and loading process advances far enough
> so that pointer is not NULL.

I think it's important to start adding incremental unit testing to core
kernel APIs. This is a case of adding a regression test for a specific
misbehavior. This is good, but in addition, testing should check any other
corner cases as well. Yes, the above EXPECT line is total nonsense, and
it makes sure that nonsense actually reports back the expected failure
state "0".

> Are we going to mock every single function in the kernel?
> Disgusting.

I'm not really interested in a slippery slope debate, but honestly, if we
_could_ mock everything in the kernel and create unit tests for everything
in the kernel, then yes, we should. It's certainly not feasible, but at
least _getting started_ on unit testing execve is worth it.

-- 
Kees Cook
