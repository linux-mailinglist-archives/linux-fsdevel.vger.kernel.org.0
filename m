Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD97B1E8979
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgE2VGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgE2VGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 17:06:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922BEC03E969
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 14:06:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p21so483030pgm.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p/Ov8sL4DrAiZu38/tMtDPHCSaLR76xmY23DLMflZaw=;
        b=M2zfIhsKul4HQv2VnAJO+u/iqfebyos6KWaRuwPJ56zlnFgHqQ29FsB3gZUCGMif/b
         Keic6ZWRzMUhkiTfftlD4aXXP6WYNcSt183Lo0Wc3aGOSjxFtY9gkQJiAa9abPA7dC5D
         i6Oi9BA/aAlbsvlXin3WuiduzcXkmaaq/8D8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p/Ov8sL4DrAiZu38/tMtDPHCSaLR76xmY23DLMflZaw=;
        b=gxpaCvctnpiPZtH+ZV96yDCUUjyJX/EYfcq7hee53ZUtb2vkwBh3iJV8B5PVG55NYq
         w9OTVxi8mr4gHE69qhBsKakc4Zfq8xvsL7b0eO/I7bcIr8XS7woCcHDbGZO/dnV0jx4a
         hfmzuek8THfuA8EmxM6Hg/+5ydAPkJ/ld9O7Ym41vnZdSkvwO5/SD06i2rdKylvV6aGT
         g9ENh8Uuw5bNiHYlN8MVapkqGreEXnjE9JWm7hNwxumXXoDjcYUiuKv1aKKogjSn02k4
         ahfESrsfKxsQkuS5LTR55EDKc+2DX6JNxK9EO1vpV0bt1lyyF+1n+eNnQnNXyUlztpVO
         8TzQ==
X-Gm-Message-State: AOAM531ZjDm68b4HafDLsbybeBjwZVLLqrvR39I//ZEvju/9FHILffBz
        QUdB6EFuGyMK6EFlaQpyqPP5Sw==
X-Google-Smtp-Source: ABdhPJwGu0pY6JmkeZog/Tcw6O+49RsdbgBWT17tFEvI6bgf84KZEZVHvszc2DWwldNkFL/whW+jmw==
X-Received: by 2002:a62:8487:: with SMTP id k129mr7726912pfd.296.1590786396090;
        Fri, 29 May 2020 14:06:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm8067695pfg.22.2020.05.29.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:06:35 -0700 (PDT)
Date:   Fri, 29 May 2020 14:06:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/2] exec: Add a per bprm->file version of per_clear
Message-ID: <202005291403.BCDBFA7D1@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
 <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
 <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:46:40AM -0500, Eric W. Biederman wrote:
> 
> There is a small bug in the code that recomputes parts of bprm->cred
> for every bprm->file.  The code never recomputes the part of
> clear_dangerous_personality_flags it is responsible for.
> 
> Which means that in practice if someone creates a sgid script
> the interpreter will not be able to use any of:
> 	READ_IMPLIES_EXEC
> 	ADDR_NO_RANDOMIZE
> 	ADDR_COMPAT_LAYOUT
> 	MMAP_PAGE_ZERO.
> 
> This accentially clearing of personality flags probably does
> not matter in practice because no one has complained
> but it does make the code more difficult to understand.
> 
> Further remaining bug compatible prevents the recomputation from being
> removed and replaced by simply computing bprm->cred once from the
> final bprm->file.
> 
> Making this change removes the last behavior difference between
> computing bprm->creds from the final file and recomputing
> bprm->cred several times.  Which allows this behavior change
> to be justified for it's own reasons, and for any but hunts
> looking into why the behavior changed to wind up here instead
> of in the code that will follow that computes bprm->cred
> from the final bprm->file.
> 
> This small logic bug appears to have existed since the code
> started clearing dangerous personality bits.
> 
> History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yup, this looks good. Pointless nit because it's removed in the next
patch, but pf_per_clear is following the same behavioral pattern as
active_secureexec, it could be named active_per_clear, but since this
already been bikeshed in v1, it's fine! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

I wish we had more robust execve tests. :(

-- 
Kees Cook
