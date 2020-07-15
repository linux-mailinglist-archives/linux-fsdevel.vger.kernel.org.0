Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8823422107F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 17:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgGOPJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgGOPJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:09:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E862C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 08:09:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so2216932pfu.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fybQni4P+/tPCeHBDEDCYYjDWdheeG5LlXlJ09TDVKE=;
        b=cPq8RT5nNYj9fhy76nHm9PB3+73ArhJb3kArGg4eBmKJVu4C6hP7+2k48MdzzIPVyt
         zg81i3TE2aG4nTFMgkVcwWFfu2WEWsydSlPQkWSOhr6OqN60cfdLcUhQeU9eglxEfgGA
         Deb3MqATlGhpL9T+cygNyeoXoBBJ1VnHqxk2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fybQni4P+/tPCeHBDEDCYYjDWdheeG5LlXlJ09TDVKE=;
        b=M71roBU02yS2ttEeLtKLm9EdLxG5E0JKc4wp3H1LmptDE4t7d/R3nwUN5lj5eEX9TV
         yOfTeCidTn08LFYeH03I/wTmYw6nF7I9MdMXi6t/E4MEsVHTf0H1Zgk4ecNllHOl2n7C
         k8j0qZQ9fIylq3DsDdMte8ak++U2EZXKyj32hIwEkJoZ5sKuEDfvcw3ZQdktst19Nl9z
         dE68gsQmAFkHFyfiHSo1KmVqKKXn4BtdcRV/90DtGfvTHXqMCKJnnr5zho477FMUm6aB
         bMw1lW9aT7QwqnKDt/+9Q5SlXjRnIgcaWm28ylr7D3C+RVvMvPbXCUkdhBzEnvMwQvBT
         zVSA==
X-Gm-Message-State: AOAM530+aOl4Oo2tUYppcalSkS7VHLBJi1WGzT1B+GlKUdaBmatIEXOA
        kXf1BDOAcyUQLmpr5Ik0JxMwHQ==
X-Google-Smtp-Source: ABdhPJyDv+gR301L1/l3fOIRrWF6W77CkdXx9PR9MUdMZexizgTDHor2MnSy/OKJHHuw6nto+bdqYA==
X-Received: by 2002:a63:3151:: with SMTP id x78mr167358pgx.210.1594825752569;
        Wed, 15 Jul 2020 08:09:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10sm13262pjf.3.2020.07.15.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:09:11 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:09:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <202007150801.27B6690@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
 <202007141446.A72A4437C@keescook>
 <20200715064248.GH32470@infradead.org>
 <d6d204c4427b49f6b24ac24bf1082fa4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d204c4427b49f6b24ac24bf1082fa4@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:55:50PM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 15 July 2020 07:43
> > Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
> > 
> > On Tue, Jul 14, 2020 at 02:49:23PM -0700, Kees Cook wrote:
> > > On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> > > > +static int count_strings_kernel(const char *const *argv)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	if (!argv)
> > > > +		return 0;
> > > > +
> > > > +	for (i = 0; argv[i]; ++i) {
> > > > +		if (i >= MAX_ARG_STRINGS)
> > > > +			return -E2BIG;
> > > > +		if (fatal_signal_pending(current))
> > > > +			return -ERESTARTNOHAND;
> > > > +		cond_resched();
> > > > +	}
> > > > +	return i;
> > > > +}
> > >
> > > I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
> > > refactor that too? (And maybe rename it to count_strings_user()?)
> 
> Thinks....
> If you setup env[] and argv[] on the new user stack early in exec processing
> then you may not need any limits at all - except the size of the user stack.
> Even the get_user() loop will hit an invalid address before the counter
> wraps (provided it is unsigned long).

*grumpy noises* Yes, but not in practice (if I'm understanding what you
mean). The expectations of a number of execution environments can be
really odd-ball. I've tried to collect the notes from over the years in
prepare_arg_pages()'s comments, and it mostly boils down to "there has
to be enough room for the exec to start" otherwise the exec ends up in a
hard-to-debug failure state (i.e. past the "point of no return", where you
get no useful information about the cause of the SEGV). So the point has
been to move as many of the setup checks as early as possible and report
about them if they fail. The argv processing is already very early, but
it needs to do the limit checks otherwise it'll just break after the exec
is underway and the process will just SEGV. (And ... some environments
will attempt to dynamically check the size of the argv space by growing
until it sees E2BIG, so we can't just remove it and let those hit SEGV.)

-- 
Kees Cook
