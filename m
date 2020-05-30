Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA061E8DF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 07:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgE3FO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgE3FO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 01:14:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE8C08C5CB
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 22:14:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g5so806096pfm.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7S20FztB4K8bcmYO9k53Hoe+v+Wmx6EAuufw39WkQKo=;
        b=foUL+loVA7P01QUxP2qwibaPTEQxpnA3eZ91PRZJqkVbM88euK96+Xf0EgTCxrXOci
         nKNPsdxXbKexE0qIFzfdKF9DxnAk99PU7DzCH87U+Fg7ZO/1jAtxK/hEek9V6+b5aDdi
         rkqM5E8kfurGboZYnL9362P5gipTWx+8LR+Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7S20FztB4K8bcmYO9k53Hoe+v+Wmx6EAuufw39WkQKo=;
        b=D4u06PRqJv2e/rCk4FsBraDznsJ5TgupG4rYQvb/1ZhUK/qlvocARcXNWJahqFUi7T
         Z1SWJQh2skcKbVhz6qUwXmxUR8gf3PG8ohnW2udJeReUDksba51azHVFcZwVyJdRqbHP
         WG4g7AwRO7HsuhI0v3J0W7BDT7dbczugmYcOlxN1r3uVvrDc/4mETokN0DAf9+CzHIWa
         F3mKWY7yybR12ZL1YGI1bM5w3/pR0OYh9E64y7HMD469h6rKOg1m1Dm0qhyV5C4N7FZ/
         EDugQ7t+Dc0CDH/OpJQLTbVC84Io40Hh6SOq9997SZqdF1iJB6a93MDtOtyz0mQY0k13
         AJBA==
X-Gm-Message-State: AOAM530nMYqL+H4JvO+RsjzcwTg/TAKF1iO5o4H0RvljAWh5jH9y+7nH
        bxG3WgsetCURNmGw+mkSgI7tXA==
X-Google-Smtp-Source: ABdhPJwvtIjtj0ltHPZ9EqnzDRVa9H0aDcK9aBn/3aWYzwFSWqn/xilsKXXDpnc8qxo8J6r4JVCmNQ==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr11321164pgd.412.1590815695910;
        Fri, 29 May 2020 22:14:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iq13sm939612pjb.48.2020.05.29.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 22:14:54 -0700 (PDT)
Date:   Fri, 29 May 2020 22:14:53 -0700
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
Message-ID: <202005292212.021D7D1FF5@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
 <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
 <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
 <202005291403.BCDBFA7D1@keescook>
 <87k10unm0h.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k10unm0h.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 10:23:58PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > I wish we had more robust execve tests. :(
> 
> I think you have more skill at writing automated tests than I do.  So
> feel free to write some.

Yeah, my limiting factor is available time. No worries; I didn't mean
it as a request to you -- it was more a commiseration. :)

-- 
Kees Cook
