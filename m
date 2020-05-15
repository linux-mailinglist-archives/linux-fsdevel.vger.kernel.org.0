Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35DA1D5AA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEOUVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:21:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44007 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEOUVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:21:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id k22so1356063pls.10;
        Fri, 15 May 2020 13:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aSUN+6mJpWuP6Of+IJbDE1swWmWrU0mZkmJ837Io9Jc=;
        b=TqjWOIPpNm7Q9QgzYwTdZzvOnu/rbVVbf5scL5/dzTt5x0basnk7htPeqZbYyHAMwN
         zRg8HudCqRFdGigUQosebddz+ci5Tv0BWJvHgHoTaNeo7KzsQ4vqS47zZpYzuoJbHeK8
         g9vVcYRxW5vXP5ToJBvwT3CVuVsmLlkuS2kH7Oyg0blbTPuMgMFi2mvBG94WRw3hmO6k
         A+TdBEkfybb+0d5O8fJ8rrmA9jGyfxk/SfAKLC06hr6+bv0CcpK9yb7gjZjPqmzX9sQ+
         kOxySfPlpOXXyQ5KFa2mu59N2XDiGCjSY/dsJ79IM0Muwvl18L1q9enj5SdS2wzH3kp0
         raVg==
X-Gm-Message-State: AOAM531VXGcLQcCJLJuQp495AUdYXEJRcRfAk4nzT1RWvqZV8VV73GhP
        hTz+AcTV/Y18LxaouykLGpMJjSy4yV8=
X-Google-Smtp-Source: ABdhPJzDKstdoEAfNtdPXwb/uILqnTT69eTIYpdZ5GurBwer3cFOtdawny/GPsI7kVqMwlRo4sJv+A==
X-Received: by 2002:a17:90b:3887:: with SMTP id mu7mr5128138pjb.168.1589574089350;
        Fri, 15 May 2020 13:21:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r2sm2621097pfq.194.2020.05.15.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:21:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D608240246; Fri, 15 May 2020 20:21:26 +0000 (UTC)
Date:   Fri, 15 May 2020 20:21:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, yzaikin@google.com,
        adobriyan@gmail.com, mingo@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        bauerman@linux.ibm.com, gregkh@linuxfoundation.org,
        skhan@linuxfoundation.org, dvyukov@google.com,
        svens@stackframe.org, joel@joelfernandes.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 1/4] hung_task: Move hung_task sysctl interface to
 hung_task_sysctl.c
Message-ID: <20200515202126.GY11244@42.do-not-panic.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
 <202005150103.6DD6F07@keescook>
 <b72e0721-d08a-0fef-f55d-eb854483d04f@huawei.com>
 <202005150902.9293E99B8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005150902.9293E99B8@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 09:03:54AM -0700, Kees Cook wrote:
> On Fri, May 15, 2020 at 04:56:34PM +0800, Xiaoming Ni wrote:
> > On 2020/5/15 16:04, Kees Cook wrote:
> > > On Fri, May 15, 2020 at 12:33:41PM +0800, Xiaoming Ni wrote:
> > > > Move hung_task sysctl interface to hung_task_sysctl.c.
> > > > Use register_sysctl() to register the sysctl interface to avoid
> > > > merge conflicts when different features modify sysctl.c at the same time.
> > > > 
> > > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > > ---
> > > >   include/linux/sched/sysctl.h |  8 +----
> > > >   kernel/Makefile              |  4 ++-
> > > >   kernel/hung_task.c           |  6 ++--
> > > >   kernel/hung_task.h           | 21 ++++++++++++
> > > >   kernel/hung_task_sysctl.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++
> > > 
> > > Why a separate file? That ends up needing changes to Makefile, the
> > > creation of a new header file, etc. Why not just put it all into
> > > hung_task.c directly?
> > > 
> > > -Kees
> > > 
> > But Luis Chamberlain's suggestion is to put the hung_task sysctl code in a
> > separate file. Details are in https://lkml.org/lkml/2020/5/13/762.
> > I am a little confused, not sure which way is better.
> 
> Ah, yes, I see now. Luis, I disagree with your recommendation here -- I
> think complicating the Makefile is much less intuitive than just
> wrapping this code in an #ifdef block in the existing .c file.

That's fine, sorry for the trouble Xiaoming.

  Luis
