Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7731D655C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 04:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgEQCiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 22:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgEQCiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 22:38:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F2C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:38:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f23so2989498pgj.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mfO04lVnt7IYPAWled0FL/Qi9c3JqESZey18DKMQFr4=;
        b=jO2sZobl8FN0z739PXrPTzOWzGtM2j6pSWOxDORnMqRSl3aROaMeJk6a6FVacG6rbQ
         MQeJCLHQkleMPSX7/qr/CQVX27F9LMjQPFe+fPMBMf5C2fZes5q0+5V/6y4EV2j47ZFM
         B3ocmI7AJ3YCrMrlLYuW15XSTtcHAscFXCEMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfO04lVnt7IYPAWled0FL/Qi9c3JqESZey18DKMQFr4=;
        b=e0QqeTizMjt44levAyV89dUuVOsLHho7IYNO7ghW3iaoFIe3uyr7oiSXw2LWWwmyEE
         dLwnuLnzRN7GP5aRN0hkPHRsHsDQpeDX5ex0T2TrUXfco4wuO0L3ttsRtNjpbpGBfY1c
         tETP55qllmvzIk7A3Mt/rVZ0M9EkStjHQ4MDGOGIJ2bFYWAFRYQuPrLHC2Jn4jWfSPG5
         yzQ0ZsTPnLOF2BMyY7nOoRNiQAPK31j6u5CjTlfumPR6KxDO3HR5yz6HcItj+OUZddxO
         EimhluBSIcQiBIrlJH1HNSrYacuZpo5qTM3e76llVQbp07c77biGrNGgX78Mk9N7k9jD
         nhFg==
X-Gm-Message-State: AOAM531uOOcp2IZ9PFFSdfPB2AnzftqWFftQGS05TspotmdnjGgZ7yxi
        BUFoZ/8ju/uhdQ/+2oHq0wWNJg==
X-Google-Smtp-Source: ABdhPJxBn435AARzlLe+Tpbhq9aqJT+PbN4M9ODsGXZ+AeAEH2+YVTBrB9N6hMXYxXDJcIMl1t9fSg==
X-Received: by 2002:a65:4487:: with SMTP id l7mr2923380pgq.221.1589683087859;
        Sat, 16 May 2020 19:38:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14sm696144pgn.83.2020.05.16.19.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:38:05 -0700 (PDT)
Date:   Sat, 16 May 2020 19:38:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
Message-ID: <202005161937.214F9A6@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
 <202005150105.33CAEEA6C5@keescook>
 <88f3078b-9419-b9c6-e789-7d6e50ca2cef@huawei.com>
 <202005150904.743BB3E52@keescook>
 <ab5f75d4-4d69-7b95-e6bd-ba8fd9792d94@huawei.com>
 <202005151946.C6335E92@keescook>
 <2656ae51-5348-0b37-d76d-1460b8eb3f10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2656ae51-5348-0b37-d76d-1460b8eb3f10@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 11:05:53AM +0800, Xiaoming Ni wrote:
> On 2020/5/16 10:47, Kees Cook wrote:
> > On Sat, May 16, 2020 at 10:32:19AM +0800, Xiaoming Ni wrote:
> > > On 2020/5/16 0:05, Kees Cook wrote:
> > > > On Fri, May 15, 2020 at 05:06:28PM +0800, Xiaoming Ni wrote:
> > > > > On 2020/5/15 16:06, Kees Cook wrote:
> > > > > > On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
> > > > > > > Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
> > > > > > > used in both sysctl_writes_strict and hung_task_warnings.
> > > > > > > 
> > > > > > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > > > > > ---
> > > > > > >     fs/proc/proc_sysctl.c     | 2 +-
> > > > > > >     include/linux/sysctl.h    | 1 +
> > > > > > >     kernel/hung_task_sysctl.c | 3 +--
> > > > > > >     kernel/sysctl.c           | 3 +--
> > > > > > 
> > > > > > How about doing this refactoring in advance of the extraction patch?
> > > > > Before  advance of the extraction patch, neg_one is only used in one file,
> > > > > does it seem to have no value for refactoring?
> > > > 
> > > > I guess it doesn't matter much, but I think it's easier to review in the
> > > > sense that neg_one is first extracted and then later everything else is
> > > > moved.
> > > > 
> > > Later, when more features sysctl interface is moved to the code file, there
> > > will be more variables that need to be extracted.
> > > So should I only extract the neg_one variable here, or should I extract all
> > > the variables used by multiple features?
> > 
> > Hmm -- if you're going to do a consolidation pass, then nevermind, I
> > don't think order will matter then.
> > 
> > Thank you for the cleanup! Sorry we're giving you back-and-forth advice!
> > 
> > -Kees
> > 
> 
> Sorry, I don't fully understand.
> Does this mean that there is no need to adjust the patch order or the order
> of variables in sysctl_vals?
> Should I extract only SYSCTL_NEG_ONE or should I extract all variables?

I think either order is fine -- I though you were only doing 1 variable.
If you're don't a bunch, then I don't think order is important.

-- 
Kees Cook
