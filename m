Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F221DA0D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgESTRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgESTRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:17:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F8DC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:17:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so103053pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CsLYnYmAxC5Xy4I4JEJhi41vLOVU5Tcj0+at/iBshw8=;
        b=n3BbAEd80W8lORyrkRONNmSZiGMzOjpMD3ADndrO0zMLPlQydwwiQ8oXeCnDAn/Q4P
         1Oc4ou7ylcYhsHVoqZs3gZJKLlWq46KsssfA98OM0KsdkN1X62LVSYwnxtMj7FXKmVpE
         dE/eaXUC1cT0/siXuAoodyKwNGf87YRwcGm7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CsLYnYmAxC5Xy4I4JEJhi41vLOVU5Tcj0+at/iBshw8=;
        b=Oao8UXyjjKAEB4dN788AQYZ50ao8c8P4qnTV9BAAf9qTq8P2w6lJDbH8Id+z93xT8U
         USazPnNDADvUWGwzQVKHtPit8SEpp1lRhySJtnegu/WTbDRmcAQf+A3UrYEkT/7Pwsbp
         AmD+ogLml9JbnESHQGwAzlHny8A5HFQ6oTA1bwNhFi5SHIyZnKHjnvqE1zI4dWzxp92z
         oX8sXBn3YblA65goLVYG6aKMXM72URzy0JCubqreWyjpIpKQXfvMcni1Oh9HoKQ431LR
         47iWyySrZCBVNDidsjAiA1WbFgjrYqekuFGQXOJ42B7V6H65a5JRwu+0z0ihWEnhx4J+
         rsBg==
X-Gm-Message-State: AOAM530IxDNsl5ye4pg4MK/OI61wKPiTM2E1LeKlY4USu+fYTduZngNZ
        zgIntOaeQpRXehj8wMNwRZQCgw==
X-Google-Smtp-Source: ABdhPJyMhPkn1gDlZzWhyVnv/6GBdXDyZQzWixqnyRptAvlgDysqIUDH2d9/u4UJDalf1qBfZMd6Tw==
X-Received: by 2002:a17:902:c487:: with SMTP id n7mr912097plx.316.1589915869555;
        Tue, 19 May 2020 12:17:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b137sm216926pfb.110.2020.05.19.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:17:48 -0700 (PDT)
Date:   Tue, 19 May 2020 12:17:47 -0700
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
Subject: Re: [PATCH v2 4/8] exec: Allow load_misc_binary to call
 prepare_binfmt unconditionally
Message-ID: <202005191215.5411A2D1@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87imgszrwo.fsf_-_@x220.int.ebiederm.org>
 <202005191122.0A1FD07@keescook>
 <87sgfvoi8d.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgfvoi8d.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 02:08:34PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, May 18, 2020 at 07:31:51PM -0500, Eric W. Biederman wrote:
> >> [...]
> >> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> >> index 8605ab4a0f89..dbb5614d62a2 100644
> >> --- a/include/linux/binfmts.h
> >> +++ b/include/linux/binfmts.h
> >> @@ -26,6 +26,8 @@ struct linux_binprm {
> >>  	unsigned long p; /* current top of mem */
> >>  	unsigned long argmin; /* rlimit marker for copy_strings() */
> >>  	unsigned int
> >> +		/* It is safe to use the creds of a script (see binfmt_misc) */
> >> +		preserve_creds:1,
> >
> > How about:
> >
> > 		/*
> > 		 * A binfmt handler will set this to True before calling
> > 		 * prepare_binprm() if it is safe to reuse the previous
> > 		 * credentials, based on bprm->file (see binfmt_misc).
> > 		 */
> 
> I think that is more words saying less.
> 
> While I agree it might be better.  I don't see what your comment adds to
> the understanding.  What do you see my comment not saying that is important?

I think your comment is aimed at the consumer of preserve_creds (i.e.
the fs/exec.c code), whereas I think the comment should be directed at
a binfmt author, who wants to answer the question "why would I set this
flag?" Though I strongly hope we never have new binfmts. ;)

-- 
Kees Cook
