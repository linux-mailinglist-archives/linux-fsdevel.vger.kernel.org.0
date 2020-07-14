Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4B220032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 23:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGNVlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGNVlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:41:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1437C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so30225pjt.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVz0yoqE7nbKLxEfE0Ni6YZf8hVnVv/lZnqHDwHd9EI=;
        b=d2/Gu/BmUNB5aqve7jAShkkdGjL9w8kucpLcU7onUISWOA1mEYKDfwakrLbMq+FLcv
         m0luqWY1m/cPBVHnz3QKPRILQXGtjXZfWHubOLuYJtO3zgaijkhqOiEDpIpkqipJixUJ
         aKgOIaNB2Nd6SJXbuWDUosoe/bMhO5LT++RmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVz0yoqE7nbKLxEfE0Ni6YZf8hVnVv/lZnqHDwHd9EI=;
        b=Eo0KqHH1ERfo9x6yXc9aPG/SAZhPiRpZMEUOaKBwZ4wmKeTOxGJff12jHIhA+HGYsb
         nbnO7mQHhsHSQecRuvh3vYYnY2QV2kJUkJZquMBBf9UTA247bAQvqtlZy7KonvRMq/dg
         gFrUYCNnpxoDtLodTQBD+ULB5nO68M1IsaTfa9iMDVr7irS02PCWFEMKk541mVJQpb0+
         nroxYhQk62cc2mFqug1mJ+WRzvnU1T+E/hBqsTD0HqfeLuaPNjPEc3g7pcvJdjMnEV44
         7wKDElbDX8vwIq0ydgscLN/34tuBVBaQBaOBNvfewb1/ViAOD8F2aPwJBtCxrF/FcSF9
         X3/Q==
X-Gm-Message-State: AOAM53342vLEDJp/wSyprMv1hjUyQojJnyHN9fx60E1n0kOBah5PvjZM
        sD4/yZsCBOwXcJBCGveLz4+owQ==
X-Google-Smtp-Source: ABdhPJxhN/Y39BnxM0uRcYuZZMzDRRwoDiA3Y/6MHYVyzHW1tffbpD9XK/UIV8xeYgDAxt4YVSdZhw==
X-Received: by 2002:a17:90b:3010:: with SMTP id hg16mr6773703pjb.69.1594762867408;
        Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm113755pfq.197.2020.07.14.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:41:06 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:41:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/7] exec: Factor bprm_stack_limits out of
 prepare_arg_pages
Message-ID: <202007141441.C612C34E7@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87365u6x60.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87365u6x60.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:31:03AM -0500, Eric W. Biederman wrote:
> 
> In preparation for implementiong kernel_execve (which will take kernel
> pointers not userspace pointers) factor out bprm_stack_limits out of
> prepare_arg_pages.  This separates the counting which depends upon the
> getting data from userspace from the calculations of the stack limits
> which is usable in kernel_execve.
> 
> The remove prepare_args_pages and compute bprm->argc and bprm->envc
> directly in do_execveat_common, before bprm_stack_limits is called.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
