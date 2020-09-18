Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7727085D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 23:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIRVfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIRVfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:35:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E025C0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 14:35:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so3859630pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OsXO9Vng0uZ8zdPlCQEPUkvMN685QAvewZuZv3id6Vk=;
        b=Qm/FmtT5Dnyrxf4BCgQpgqbDw7sS/zTtWsVgCPYD/Z8fGcfQ5xbRlGReuouD+SHCd9
         dZJK4vmeSlLB9LbvCFrufdgXKAOEcR0Sj+Z6M4GjiMmOMsAqZazgwvwTj14O7ZQgEo98
         fFyktTytinUg2oHTwmTXsDyGhM3irl/3gs0Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OsXO9Vng0uZ8zdPlCQEPUkvMN685QAvewZuZv3id6Vk=;
        b=McwkZTtQcOvqe5JmFYxFVmtSK621TgpIpcRb/gkFbBU9QQpGBcasynO/OLm2O+SxWM
         CVdF6+JYOlCLWirOdU/Q+4DABQeKgdcTa2bMD7/sosaJrWog3FaLnw5iyfUWvkAPPfrq
         c0UGT8weH5UlVYBtaLFwecUz7lq4UVICLNXuv4p2G2ClvLhzMdCEr3lZoHyclz2inZMV
         embKpjMpY3soQsySm+3NjOKUqPgoPrEoXBtPj0jbbBlvkryC8wpwa9pZ3ZCF6/Y/JZEp
         lrlDjhVmZ7rfudXQfuYkyraiCgoVgbpRrVux3qeQTCB5lnt7pX8WH14u79esdNh6p2Ji
         0Feg==
X-Gm-Message-State: AOAM533jZh3YPPtxrrXW/BiA5jjETV0iWDqdgFA0bvlAx/LygmD0bZav
        MM7hPPlNSspjW0F+GKsRLEGsrg==
X-Google-Smtp-Source: ABdhPJyK4NrndRd3u8+tWx5b+nRCti5n/xaxbJJsCKhy+21AIJjWUWUQo+BNLBjVu3tDwrR5itradw==
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr14965929pje.140.1600464914535;
        Fri, 18 Sep 2020 14:35:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19sm4097785pfj.25.2020.09.18.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:35:13 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:35:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     kernel-hardening@lists.openwall.com, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] security/fbfam: Mitigate a fork brute force
 attack
Message-ID: <202009181433.EAF237C36@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-7-keescook@chromium.org>
 <202009101649.2A0BF95@keescook>
 <20200918152116.GB3229@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918152116.GB3229@ubuntu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:02:16PM +0200, John Wood wrote:
> On Thu, Sep 10, 2020 at 04:56:19PM -0700, Kees Cook wrote:
> > On Thu, Sep 10, 2020 at 01:21:07PM -0700, Kees Cook wrote:
> > > +		pr_warn("fbfam: Offending process with PID %d killed\n",
> > > +			p->pid);
> >
> > I'd make this ratelimited (along with Jann's suggestions).
> 
> Sorry, but I don't understand what you mean with "make this ratelimited".
> A clarification would be greatly appreciated.

Ah! Yes, sorry for not being more clear. There are ratelimit helpers for
the pr_*() family of functions, e.g.:

	pr_warn_ratelimited("brute: Offending process with PID...

-- 
Kees Cook
