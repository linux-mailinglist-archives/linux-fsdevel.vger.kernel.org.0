Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2CD340940
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhCRPwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCRPvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:51:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13973C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 08:51:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m3so1704044pga.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yb9yuGXl93jA+r4r8J4NpNyfEbIYopOSDI5mea++BXA=;
        b=fylJFEz8bK0PHffKlC5yh2HwrtfoPT4Vs6IO+tpq7kux6YyjhOBdxm4PY8llDiYfbe
         EzVWYJxO26pPIW0HpBw1jsGzMd6hTL9EBNVkRHv9Ngc8K5qNmlWqpHZdJGSD59tqxvzu
         ljDNdouQ6SQo2Np8l38dZZewXqvc3WWat8wlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yb9yuGXl93jA+r4r8J4NpNyfEbIYopOSDI5mea++BXA=;
        b=Sk13nKEJNoyQV770kCcQ5lRB7AHtreB4GYSRAjtBzFbrVC28M001gidJ6J/Yn0Frx1
         WpeaTOBIEfevefB7Xf16ICWGzBgseTjPBR+DZvd3ZfPQny75Pg66eICaiD0zpxrnHHyy
         ImVQrl1FLu1KVYpVBnHP2H0pN33mw5zOi9bd2eMhX0+STTbFVLAsQGKLocLFYZoFqoDZ
         K6Q6shcejrbSvOHZ3XZoLJEfhFTQZ2Gy0wXyrIoj6+25u96ULGCq1RYb5/L9qvUI98AR
         ZyRkxOBWT1w2GdniO6vYgsCokz1TNdgzrC1Y6wcWbtdY8B3jb6l31ahRTq+dy9EwwIZI
         knIA==
X-Gm-Message-State: AOAM531kB0owIM9VscpXaQwYDOgqH6ZpJZBDZ9BGNaeGHeBfelzqy9q1
        k16Wo12rX/9N0OEkXhIhyFeUjg==
X-Google-Smtp-Source: ABdhPJxAU61y3bf4qItCJFeadYoy9Gw0mNjr5YdvJAnRRRSIiEcEU4Qb6jgdClz7yF0VMfDq7iG70A==
X-Received: by 2002:a05:6a00:b86:b029:205:c773:5c69 with SMTP id g6-20020a056a000b86b0290205c7735c69mr4708373pfj.60.1616082708430;
        Thu, 18 Mar 2021 08:51:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7sm2860717pfv.93.2021.03.18.08.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:51:47 -0700 (PDT)
Date:   Thu, 18 Mar 2021 08:51:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <202103180847.53EB96C@keescook>
References: <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
 <YFIFY7mj65sStba1@kroah.com>
 <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
 <YFIYrMVTC42boZ/Z@kroah.com>
 <YFIeVLDsfBMa7fHW@dhcp22.suse.cz>
 <YFIikaNixD57o3pk@kroah.com>
 <202103171425.CB0F4619A8@keescook>
 <YFMKUZ5p1QbqkabY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMKUZ5p1QbqkabY@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:07:45AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 17, 2021 at 02:30:47PM -0700, Kees Cook wrote:
> > On Wed, Mar 17, 2021 at 04:38:57PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 17, 2021 at 04:20:52PM +0100, Michal Hocko wrote:
> > > > On Wed 17-03-21 15:56:44, Greg KH wrote:
> > > > > On Wed, Mar 17, 2021 at 03:44:16PM +0100, Michal Hocko wrote:
> > > > > > On Wed 17-03-21 14:34:27, Greg KH wrote:
> > > > > > > On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> > > > > > > > Btw. I still have problems with the approach. seq_file is intended to
> > > > > > > > provide safe way to dump values to the userspace. Sacrificing
> > > > > > > > performance just because of some abuser seems like a wrong way to go as
> > > > > > > > Al pointed out earlier. Can we simply stop the abuse and disallow to
> > > > > > > > manipulate the buffer directly? I do realize this might be more tricky
> > > > > > > > for reasons mentioned in other emails but this is definitely worth
> > > > > > > > doing.
> > > > > > > 
> > > > > > > We have to provide a buffer to "write into" somehow, so what is the best
> > > > > > > way to stop "abuse" like this?
> > > > > > 
> > > > > > What is wrong about using seq_* interface directly?
> > > > > 
> > > > > Right now every show() callback of sysfs would have to be changed :(
> > > > 
> > > > Is this really the case? Would it be too ugly to have an intermediate
> > > > buffer and then seq_puts it into the seq file inside sysfs_kf_seq_show.
> > > 
> > > Oh, good idea.
> > > 
> > > > Sure one copy more than necessary but it this shouldn't be a hot path or
> > > > even visible on small strings. So that might be worth destroying an
> > > > inherently dangerous seq API (seq_get_buf).
> > > 
> > > I'm all for that, let me see if I can carve out some time tomorrow to
> > > try this out.
> > 
> > The trouble has been that C string APIs are just so impossibly fragile.
> > We just get too many bugs with it, so we really do need to rewrite the
> > callbacks to use seq_file, since it has a safe API.
> > 
> > I've been trying to write coccinelle scripts to do some of this
> > refactoring, but I have not found a silver bullet. (This is why I've
> > suggested adding the temporary "seq_show" and "seq_store" functions, so
> > we can transition all the callbacks without a flag day.)
> > 
> > > But, you don't get rid of the "ability" to have a driver write more than
> > > a PAGE_SIZE into the buffer passed to it.  I guess I could be paranoid
> > > and do some internal checks (allocate a bunch of memory and check for
> > > overflow by hand), if this is something to really be concerned about...
> > 
> > Besides the CFI prototype enforcement changes (which I can build into
> > the new seq_show/seq_store callbacks), the buffer management is the
> > primary issue: we just can't hand drivers a string (even with a length)
> > because the C functions are terrible. e.g. just look at the snprintf vs
> > scnprintf -- we constantly have to just build completely new API when
> > what we need is a safe way (i.e. obfuscated away from the caller) to
> > build a string. Luckily seq_file does this already, so leaning into that
> > is good here.
> 
> But, is it really worth the churn here?
> 
> Yes, strings in C is "hard", but this _should_ be a simple thing for any
> driver to handle:
> 	return sysfs_emit(buffer, "%d\n", my_dev->value);
> 
> To change that to:
> 	return seq_printf(seq, "%d\n", my_dev->value);
> feels very much "don't we have other more valuable things we could be
> doing?"
> 
> So far we have found 1 driver that messed up and overflowed the buffer
> that I know of.  While reworking apis to make it "hard to get wrong" is
> a great goal, the work involved here vs. any "protection" feels very
> low.

I haven't been keeping a list, but it's not the only one. The _other_
reason we need seq_file is so we can perform checks against f_cred for
things like %p obfuscation (as was needed for modules that I hacked
around) and is needed a proper bug fix for the kernel pointer exposure
bug from the same batch. So now I'm up to 3 distinct reasons that the
sysfs API is lacking -- I think it's worth the churn and time.

> How about moving everyone to sysfs_emit() first?  That way it becomes
> much more "obvious" when drivers are doing stupid things with their
> sysfs buffer.  But even then, it would not have caught the iscsi issue
> as that was printing a user-provided string so maybe I'm just feeling
> grumpy about the potential churn here...

I need to fix the prototypes for CFI sanity too. Switching to seq_file
solves 2 problems, and if we have to change the prototype once for that,
we can include the prototype fixes for CFI at the same time to avoid
double the churn.

-- 
Kees Cook
