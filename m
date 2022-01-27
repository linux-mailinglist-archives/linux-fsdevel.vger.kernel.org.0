Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B749D676
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 01:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiA0AAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 19:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiA0AAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:00:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D0C06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso5825830pjv.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DwrekoWwD7S8yj0PWXXec9UCQ3/KKV/tBb2QonKO67w=;
        b=B7sSz9g57GHF8TphX5iKf/ReceRtURdiZA257rxyFhPEJ2GeUmj34TjbX8UnzDaFUs
         Dn0/XCD9N5x9fawmkAjfCNtft7zD8ix2w2zLHJ6jpbeC07CPW2SGrexilsMvkZwju4hc
         IuISRG/sx1OpZo7RhodjbGyfx+DdIdhX/G9IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DwrekoWwD7S8yj0PWXXec9UCQ3/KKV/tBb2QonKO67w=;
        b=4WrDv+5/hNt68x1549RcGzyH+2ixeleclS65dYKwY5xWqUJpBrSimNmroDLRmsMBbI
         va3wjhjNFu9f3bf/V0MoOBkx3CFqHKhWMlq2gE3tITlo+46EPZtzZFVdVqtTm/aFA1S6
         57ATquqQNJEdpmG5YFcwfyxShdKM2S0lS+tUz0kw9vOkQQ5lP2Y3cmPTwMvdeWhQu8lO
         xb3gsom/pyi1Hp0J113gew5RRdwdH55QQq+NzT21FlgxVCGggxzMp2CygLFt9ozSPgJr
         V3CsjvhDTBQN4Q0MV5pUH/c6eiGkXmbs+O3YpBZVTwf0YZaNdfNUBvRquVuiZpQ9px+O
         jzjQ==
X-Gm-Message-State: AOAM5333ytA/qSd/rtmKCItubjvC41ilzEYrWafP/KtrTDbMpPGD0Kn8
        XoZJWFNTjqxSZpJMmxVe+qYiRg==
X-Google-Smtp-Source: ABdhPJydBVK1iwsHQRv5UqG9Dei82q+wALz8ZjL9Brp25yjLU800blqVmmdsxJY+Kw5WRFzjAwpSwA==
X-Received: by 2002:a17:902:c409:: with SMTP id k9mr1083833plk.132.1643241601975;
        Wed, 26 Jan 2022 16:00:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q17sm3265766pfk.108.2022.01.26.16.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:00:01 -0800 (PST)
Date:   Wed, 26 Jan 2022 16:00:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     ariadne@dereferenced.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Message-ID: <202201261558.DAA974162@keescook>
References: <YfFigbwhImLQqQsQ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFigbwhImLQqQsQ@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 06:02:25PM +0300, Alexey Dobriyan wrote:
> >	execve("...", NULL, NULL);
> 
> I personally wrote a program which relies on execve(NULL) to succeed.
> It wasn't an exploit, it was test program against IMA-like kernel
> "only whitelisted executables can run" feature.
> 
> Test copies and "corrupts" itself by appending \0 to the end, then tries
> to reexec itself with execve("/proc/self/exe", NULL, NULL);
> main() if run with argc==0 exits with specific error code.
> 
> Appending \0 breaks checksum so working kernel protection scheme must
> not allow it, therefore if execve(NULL) succeeded, than the parent
> process doing test hard fails.
> 
> Also appending \0 doesn't break ELF structure. In other words,
> if executable A is working (and it is working because it is running)
> then A||\0 is valid executable as well and will run too.
> 
> This is independent from filesystem layout, libc, kernel, dynamic
> libraries, compile options and what not.
> 
> Now QNX doesn't allow execve(NULL) and I don't remember if I changed it
> to the next simplest variant and I don't work anymore at that company,
> so I can't check :^)
> 
> 	execve("/proc/self/exe", (char*[]){"Alexey", NULL}, NULL);

One of the various suggestions was to inject { path, NULL } when argc=0.

Given that execve(path, NULL, ...) is being used at least a little,
hopefully there is nothing that depends on argc==0... :P

-- 
Kees Cook
