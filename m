Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAA61E9FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 04:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKGD7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 22:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKGD7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:59:42 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C0C57
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Nov 2022 19:59:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso13319807pjg.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Nov 2022 19:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK5YyOubJwfiTVmlG1/f7tjG17kEPCWvBahIEcz+8l4=;
        b=ZyitcS/3gs3aZQiGqG/Q7GbVOlc1TqzvFtgbdhE/AqyUaP1LLQq7PHRtclmapVQ8vj
         8GKLXAi+Yh/h0uNE8dbF0XQ5AzmseEysJikeo/ZeIDRKV+Il03kMhToc8viko9/AmYul
         zcQ5Eeefg16RBLveRSsNajatDmqhu8tm32z4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK5YyOubJwfiTVmlG1/f7tjG17kEPCWvBahIEcz+8l4=;
        b=jkP/NPkPc4mZaD8/mwWI15QmCy/rzEkBoYYFe++QLNndu9+77EXfqewCOmC3l2mSoL
         LgE8XzhhnwTe8U9czBI1PY3KqSKrf+WyMCrTJW+jC6lNOcEXokzgKMUGM5XID9bl4Mwc
         kkE6wUKmCoEL02TPj1GzYNBTel9lUeoJ62ZdzUmLzYxlQqzKu25NZHVbXqh7ExxWZyHV
         Ve9Ndsr4pnylgG29E6ftQRO5ggUUbDjWBiGPfYPhLbCHPyY3QOMlOTQtTr87aag1mdif
         dZNT9LBr+xMF4ciQa+tjd5MnWTNZH4Na+f0RGyVN8J3e01c29IcSmqBh6Nsfy8kFqGpn
         dVXw==
X-Gm-Message-State: ACrzQf2YpuTlpENCAWcmqsyBDXrFibmI7nTlIJWfx+dnNNGt0/uDmLsH
        5zilcTU7X+LIVz0zbGMVG1XM1w==
X-Google-Smtp-Source: AMsMyM7lkEs6qetTh6BXX437KL+xR0SL7scTZP0rtLfxeDY1BHX12asImU0zz6Ln0CkKhKAchIwV2Q==
X-Received: by 2002:a17:903:1207:b0:185:4042:23d2 with SMTP id l7-20020a170903120700b00185404223d2mr47766328plh.143.1667793581465;
        Sun, 06 Nov 2022 19:59:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709027b8d00b00186c5e8b1d0sm3807639pll.149.2022.11.06.19.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 19:59:41 -0800 (PST)
Date:   Sun, 6 Nov 2022 19:59:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>,
        David Gow <davidgow@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, sam@gentoo.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH] fs/binfmt_elf: Fix memsz > filesz handling
Message-ID: <202211061948.46D3F78@keescook>
References: <20221106021657.1145519-1-pedro.falcato@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106021657.1145519-1-pedro.falcato@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 06, 2022 at 02:16:57AM +0000, Pedro Falcato wrote:
> The old code for ELF interpreter loading could only handle
> 1 memsz > filesz segment. This is incorrect, as evidenced
> by the elf program loading code, which could handle multiple
> such segments.
> 
> This patch fixes memsz > filesz handling for elf interpreters
> and refactors interpreter/program BSS clearing into a common
> codepath.
> 
> This bug was uncovered on builds of ppc64le musl libc with
> llvm lld 15.0.0, since ppc64 does not allocate file space
> for its .plt.
> 
> Cc: Rich Felker <dalias@libc.org>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Thanks for the patch! I need to triple-check this logic, as there have
been some overlapping (or out-of-order) LOAD bugs in the past too, and I
want to make sure we don't accidentally zero things that already got
loaded, etc.

David, has there been any work on adding a way to instantiate
userspace VMAs in a KUnit test? I tried to write this myself, but I
couldn't figure out how to make the userspace memory mappings appear.
Here's my fumbling attempt:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/kunit/usercopy

I really wish KUnit had userspace mapping support -- I have a bunch of
unit tests that need to get built up around checking for regressions
here, etc.

Anyway, I'll test this patch and get it applied and likely backported
to earlier kernels in the next few days.

-Kees

-- 
Kees Cook
