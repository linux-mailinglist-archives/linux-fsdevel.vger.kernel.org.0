Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A892187D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgGHMlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 08:41:51 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37587 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgGHMlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:41:51 -0400
Received: by mail-pj1-f68.google.com with SMTP id o22so1140049pjw.2;
        Wed, 08 Jul 2020 05:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9NsmHNMKtMo6heddAwR0Jo8rbD18ro99vFEXj/9cbns=;
        b=gU5v9fPXEQpDNDazXWVqBd8QqxNIHTLza+/bB592uGJNiZxNKB1il8bRnarzCNHNul
         T5P4mYSRJ7zeYncoL7HwoOWzTibv3ZVbGbgTu4WhkcfsozCCz0UKblIxnufnqVpb1h2Z
         0f/jTm5wG2tSRmSiFpe4sBUJEMVq//UvNIlLZVlCl3jn4yKt1mj6H5Rcvx3QZkwBVxS3
         +4UUj41wG/lKJ5myY1HumBfIaWJ2ZnhKOql9QnZEL2yw4192aSKuWdYoSEYGUt9Mu367
         vWNV1a+uYtM2Du5BhDK4ikua4/0ZD4+/Pu1pVGxXbG6eMCNer4fUZVTpGLoIniJPCSaT
         cxbQ==
X-Gm-Message-State: AOAM531TXk4nuewkAj5vO460c828ivetn/VCkfFbzvSFGVG2kHDoeaRL
        Om6zA+NmuITN0s8KlFQsjs0=
X-Google-Smtp-Source: ABdhPJwELa0l63JqQ1sECDcd+rWg4PVJ50CjKNicqhYyEjnD+tSNYgEHmSQ3lqhAlX4VC2yD5V81Fg==
X-Received: by 2002:a17:90b:190d:: with SMTP id mp13mr9911274pjb.211.1594212110549;
        Wed, 08 Jul 2020 05:41:50 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 204sm14369397pfx.3.2020.07.08.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:41:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BF77C401AE; Wed,  8 Jul 2020 12:41:48 +0000 (UTC)
Date:   Wed, 8 Jul 2020 12:41:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 10/16] exec: Remove do_execve_file
Message-ID: <20200708124148.GP13911@42.do-not-panic.com>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-10-ebiederm@xmission.com>
 <20200708063525.GC4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708063525.GC4332@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 06:35:25AM +0000, Luis Chamberlain wrote:
> On Thu, Jul 02, 2020 at 11:41:34AM -0500, Eric W. Biederman wrote:
> > Now that the last callser has been removed remove this code from exec.
> > 
> > For anyone thinking of resurrecing do_execve_file please note that
> > the code was buggy in several fundamental ways.
> > 
> > - It did not ensure the file it was passed was read-only and that
> >   deny_write_access had been called on it.  Which subtlely breaks
> >   invaniants in exec.
> > 
> > - The caller of do_execve_file was expected to hold and put a
> >   reference to the file, but an extra reference for use by exec was
> >   not taken so that when exec put it's reference to the file an
> >   underflow occured on the file reference count.
> 
> Maybe its my growing love with testing, but I'm going to have to partly
> blame here that we added a new API without any respective testing.
> Granted, I recall this this patch set could have used more wider review
> and a bit more patience... but just mentioning this so we try to avoid
> new api-without-testing with more reason in the future.
> 
> But more importantly, *how* could we have caught this? Or how can we
> catch this sort of stuff better in the future?

Of all the issues you pointed out with do_execve_file(), since upon
review the assumption *by design* was that LSMs/etc would pick up issues
with the file *prior* to processing, I think that this file reference
count issue comes to my attention as the more serious issue which I
wish we could address *first* before this crusade.

So I have to ask, has anyone *really tried* to give a crack at fixing
this refcount issue in a smaller way first? Alexei?

I'm not opposed to the removal of do_execve_file(), however if there
is a reproducible crash / issue with the existing user, this sledge
hammer seems a bit overkill for older kernels.

  Luis
