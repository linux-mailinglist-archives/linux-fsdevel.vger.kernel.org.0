Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E95BD580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 22:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiISUC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 16:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiISUCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:02:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C748EA7
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 13:02:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b75so645139pfb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=eXOyFyEzKdpniG5U/G+Dwx8iZBCxSfFUM/Yw73mc+so=;
        b=ZlzZ84XF8ZFDq70FjCYSSmOLDhZeLkHYK4bUuKiFjK50Eo6AZzVjif2v7zvvKVOTOv
         SuDuMxamu9LbPcESelBkSAjw5LssTVjFXWWZ490uIULYHfDkZPzwnFaHcHhlGO8bVSH/
         U32wY7Cn4gV/VB/Dqlvcby+ZUv7RPspDGimHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eXOyFyEzKdpniG5U/G+Dwx8iZBCxSfFUM/Yw73mc+so=;
        b=fSdyV0kjJ9RFkG6qyDy+FUTh/XocylSiwWxlwqvzTZGKEp/HT6m7zGddKKlb87vELa
         rpt+f2z7aokwdQZ3NhtewlFxMadSgJOo0TdoNDkD9qQdyrT6ehtCLIVuEu7UnD9nB1IV
         hvvqVZqMX7NKHR0BkoRODW9R2ynkJom7NaT+VRtiXiKa1ZN9vZzC0L3lIaS6sU+I9Shf
         fyCuKDuJsBg1wMxzMNJTKFZVn+jFKhRoi+M49zGbuq83wxonbVctOEs/fd2ieI2WjIFH
         xseqgsOn0PHANsfFNHk6fSuYlMciQWQTJ/iJHzn0Z/NQ9kJmHbIJDDUCj55X+NpWVZ/k
         SCOQ==
X-Gm-Message-State: ACrzQf30Bha7Ik6/RyUTH0z09WtNBKy9Q8QU3hI1UZgj7mlYUkJ1PbyI
        NlpTgZRgFoRHrXIyz21EeDkHuQ==
X-Google-Smtp-Source: AMsMyM6U70M8NWqkoA6aAkbcsmk1Br3IMj+BnnvH8aMlRSS4P44R+pMDuyh1o2jpsQuXF9hD0H2Okg==
X-Received: by 2002:a62:fb18:0:b0:548:9dff:89da with SMTP id x24-20020a62fb18000000b005489dff89damr20518686pfm.23.1663617773359;
        Mon, 19 Sep 2022 13:02:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11-20020a62f80b000000b0053e85a4a2c9sm9446500pfh.5.2022.09.19.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:02:52 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:02:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202209191256.893576D4@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202209160727.5FC78B735@keescook>
 <YyTY+OaClK+JHCOw@localhost>
 <202209161637.9EDAF6B18@keescook>
 <YyUZ0NHfFF+eVe24@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUZ0NHfFF+eVe24@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 17, 2022 at 01:50:24AM +0100, Josh Triplett wrote:
> On Fri, Sep 16, 2022 at 05:11:18PM -0700, Kees Cook wrote:
> > I don't like the idea of penalizing the _succeeding_ case, though, which
> > happens if we do the path walk twice. So, I went and refactoring the setup
> > order, moving the do_open_execat() up into alloc_bprm() instead of where
> > it was in bprm_exec(). The result makes it so it is, as you observed,
> > before the mm creation and generally expensive argument copying. The
> > difference to your patch seems to only be the allocation of the file
> > table entry, but avoids the double lookup, so I'm hoping the result is
> > actually even faster.
> 
> Thanks for giving this a try; I'd wondered how feasible it would be to
> just do one lookup.
> 
> However, on the same test system with the same test setup, with your
> refactor it seems to go slower:
> fork/execvpe: 38087ns
> fork/execve:  33758ns
> 
> For comparison, the previous numbers (which I re-confirmed):
> 
> Without fast-path:
> fork/execvpe: 49876ns
> fork/execve:  32773ns
> 
> With my original separate-lookup fast-path:
> fork/execvpe: 36890ns
> fork/execve:  31551ns

Hmm, this shows as slower in the *normal* case, which I find rather
surprising -- it's the same work, just reordered.

Can you post a URL to your tests? I'd like to reproduce this and maybe
throw perf at it as well.

> I tried several runs of each, and I seem to get reasonably consistent
> results.
> 
> My test program just creates a pipe once, then loops on
> clock_gettime/fork/execvpe/read, with the spawned child process doing
> clock_gettime/write/exit (in asm to minimize overhead). The test PATH is
> PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:. with
> the test program in the current directory.

I'm also curious about less synthetic testing. It'd be nice to see real
workloads with these changes, etc.

-- 
Kees Cook
