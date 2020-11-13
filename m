Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6222B1CFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 15:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKMORG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 09:17:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36999 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMORF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:17:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id h6so7183440pgk.4;
        Fri, 13 Nov 2020 06:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=muGv9UA2yOWJO8OBFbyd4k8hs7CA6S1+a06CR/bKjo0=;
        b=a7snw+4SwNswVwSyh8ObbHjccJGc4woMjHl2HUvI66uOyW3Mkp98hqma1Ccz3hZYKu
         BjPL3jDRFnq7M+kJZ81EtJSGSoPxSbJGso8uK0WEqnolwpPo1+uv4BauW6Ir6xRbgX69
         xmsvcmuS+vOapwQAOOKir4HMSgT8ZHW4IVKC+CEazLQnh0OgtVq+M445JCWc4NrP9kGl
         jPplIEIbLTt12bWiHJ0DdLpr7fMItDam+tK8jRXcpAaHhjxq6/8ehEds6RPPLEE1W+Zm
         3z2Mp1RoE/yBASMFmAEsNzfdrZVshII8k1g5eHpr3VH1ZRYd0jnaMko4qDZ1lknaNoy4
         borg==
X-Gm-Message-State: AOAM531aacbHgKIdqi48ByQ6SpRRm4ziRiBLUJMI8FV7l79E4liT4Lvx
        xtvOM1MbE9pKzS+RVNxUVwQ=
X-Google-Smtp-Source: ABdhPJwf+kmdqj5fHCuVENwx3brb/hOK2x7YpCjn9y4whApg85xDwT+NwgTnI+3VzgDEqylCFRsE5Q==
X-Received: by 2002:a05:6a00:c8:b029:18b:b0e:e51 with SMTP id e8-20020a056a0000c8b029018b0b0e0e51mr2143971pfj.37.1605277024230;
        Fri, 13 Nov 2020 06:17:04 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id mt2sm11475078pjb.7.2020.11.13.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:17:03 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3854240715; Fri, 13 Nov 2020 14:17:02 +0000 (UTC)
Date:   Fri, 13 Nov 2020 14:17:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: move local variable in proc_do_large_bitmap() to
 proper scope
Message-ID: <20201113141702.GI4332@42.do-not-panic.com>
References: <20201109071107.22560-1-lukas.bulwahn@gmail.com>
 <e0cf83dc-2978-70ce-aeb2-37873cc81c03@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0cf83dc-2978-70ce-aeb2-37873cc81c03@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:26:37PM -0800, Tom Rix wrote:
> 
> On 11/8/20 11:11 PM, Lukas Bulwahn wrote:
> > make clang-analyzer caught my attention with:
> >
> >   kernel/sysctl.c:1511:4: warning: Value stored to 'first' is never read \
> >   [clang-analyzer-deadcode.DeadStores]
> >                           first = 0;
> >                           ^
> >
> > Commit 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap") introduced
> > proc_do_large_bitmap(), where the variable first is only effectively used
> > when write is false; when write is true, the variable first is only used in
> > a dead assignment.
> >
> > So, simply remove this dead assignment and put the variable in local scope.
> >
> > As compilers will detect this unneeded assignment and optimize this anyway,
> > the resulting object code is identical before and after this change.
> >
> > No functional change. No change to object code.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on v5.10-rc3 and next-20201106
> >
> > Luis, Kees, Iurii, please pick this minor non-urgent clean-up patch.
> >
> >  kernel/sysctl.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index ce75c67572b9..cc274a431d91 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1423,7 +1423,6 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
> >  			 void *buffer, size_t *lenp, loff_t *ppos)
> >  {
> >  	int err = 0;
> > -	bool first = 1;
> >  	size_t left = *lenp;
> >  	unsigned long bitmap_len = table->maxlen;
> >  	unsigned long *bitmap = *(unsigned long **) table->data;
> > @@ -1508,12 +1507,12 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
> >  			}
> >  
> >  			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
> > -			first = 0;
> >  			proc_skip_char(&p, &left, '\n');
> >  		}
> >  		left += skipped;
> >  	} else {
> >  		unsigned long bit_a, bit_b = 0;
> > +		bool first = 1;
> 
> This looks fine, but while you are here how about setting, to match the type
> 
> first = true
> 
> And then only clearing first once
> 
> if (!first)                                                                            
>   proc_put_char(&buffer, &left, ',');
> 
> else
> 
>   first = false
> 
> Instead of at every loop iteraction

Thanks for your patch Lukas!

Agreed, please resend with that change as requested by Tom. And also
please add Andrew Morton <akpm@linux-foundation.org> to your To address.

  Luis
