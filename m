Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C843E222D89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGPVQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 17:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgGPVQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:16:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA7C08C5DB
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 14:16:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a23so2676578pfk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lmZBQbjqMeBLnSI9FVD3UqngzNA1tgpRunHRVfsAN4E=;
        b=jrlSSu3doUVtC/cF6fPEixkmZ7d3kTAXWl4iNsSM4I6YoEFL+12kpcB6R9QQdqWsrL
         tXF4IFkuk15RdtqH+h3KXuu4gjR6RZUWVUL2RXcBy7kHTyR41Iagp8SO/Nhhy6hRv9LC
         SJF0MSnv27iK1CLHjM8qOEZHVhyaIK8raTTYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lmZBQbjqMeBLnSI9FVD3UqngzNA1tgpRunHRVfsAN4E=;
        b=iFB44AODD40BeS1Si5VWIvF1SpSNv4CzQqliyEb+al4I0c5xJ4+FXxGjcIdqLmS5WB
         Ppptlvivtlro22jaVN0FrkEX2TUcwmwBYS0LSq6o0TeVjGRwnGNiM2xF7pq9g0lFfAAC
         HfhCb7AXl+q/QWN8QGyNMTVB/tUdxgPopZfsjIY9Kq89wvS612POGb+kCuy9C5Lgr+HF
         ieWH8Ika32TiqzijD+1kdvSu+Lc20+FPCpCW6LTUP+7gAetnFRLLuL29floNh9IBqraP
         tAZQPKEckx9Xx5uCQigI8Bsc2LQQCBLmdczjCS5RIX5rSzrE0MJ+svnbLZ3DCDungHbl
         ujdw==
X-Gm-Message-State: AOAM533JhlT3iRBWLQjB6kPaMch3kWUg+YOVp6WGtmY85SlKh15u/yme
        TBdhRQhodFldHJL7I99aaMFMWg==
X-Google-Smtp-Source: ABdhPJxx6Jf69e3T4HfcHOftkZ9Viu9RPr7fEyeFqrBzPYqKcb2Yk/GKdggH4BwCHYsK3kDOz6WVQw==
X-Received: by 2002:a63:c947:: with SMTP id y7mr5734755pgg.357.1594934171026;
        Thu, 16 Jul 2020 14:16:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a30sm5752036pfr.87.2020.07.16.14.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:16:09 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:16:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
Message-ID: <202007161415.10D015477@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
 <20200710220411.GR12769@casper.infradead.org>
 <128120ca-7465-e041-7481-4c5d53f639dd@broadcom.com>
 <202007101543.912633AA73@keescook>
 <9ba08503-e515-6761-63de-a3b611720b1b@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ba08503-e515-6761-63de-a3b611720b1b@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:35:17PM -0700, Scott Branden wrote:
> On 2020-07-10 3:44 p.m., Kees Cook wrote:
> > On Fri, Jul 10, 2020 at 03:10:25PM -0700, Scott Branden wrote:
> > > 
> > > On 2020-07-10 3:04 p.m., Matthew Wilcox wrote:
> > > > On Fri, Jul 10, 2020 at 02:00:32PM -0700, Scott Branden wrote:
> > > > > > @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > > > > >     		goto out;
> > > > > >     	}
> > > > > > -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> > > > > > -		*buf = vmalloc(i_size);
> > > > > > +	if (!*buf)
> > > > > The assumption that *buf is always NULL when id !=
> > > > > READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
> > > > > I get unhandled page faults due to this change on boot.
> > > > Did it give you a stack backtrace?
> > > Yes, but there's no requirement that *buf need to be NULL when calling this
> > > function.
> > > To fix my particular crash I added the following locally:
> > > 
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -3989,7 +3989,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char
> > > __user *, uargs, int, flags)
> > >   {
> > >       struct load_info info = { };
> > >       loff_t size;
> > > -    void *hdr;
> > > +    void *hdr = NULL;
> > >       int err;
> > > 
> > >       err = may_init_module();
> > Thanks for the diagnosis and fix! I haven't had time to cycle back
> > around to this series yet. Hopefully soon. :)
> > 
> In order to assist in your patchset I have combined it with my patch series
> here:
> https://github.com/sbranden/linux/tree/kernel_read_file_for_kees
> 
> Please let me know if this matches your expectations for my patches or if
> there is something else I need to change.

Thanks! I was working on the next revision of this last night, and I'm
trying to get through today's email to finish it. I'll take a look!

-- 
Kees Cook
