Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8561D5577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgEOQD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOQD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:03:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272ADC05BD09
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 09:03:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so1050222plr.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=26j6mugXkifv9OznhflnKDPN13EyIMvO85x9VYvrewo=;
        b=a5R1okyD9SFHDeV6TRe3Q1g8xfttKurC2131F6oXd1cQCRJMD0PBZMryKaAvh45Qsc
         MHCs7/nEwKuluYb0EN1/fobj0my8160DZrEA86vvP4TU4pzej/2dHr/GdGEchi1cE5uU
         NeewMmWWBkR4M5H0i8e5VvdwYtSpr3f+RIvhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26j6mugXkifv9OznhflnKDPN13EyIMvO85x9VYvrewo=;
        b=ud709L2JYzC6U0VeorRqE3mQNlPxSC9QzPIKgUZMLcg/YxnWfXu3OQMkmLNUZ5KbcT
         PR5Bsk0/8DFQfxqq6q37WjxnQ8zlo7M8ZhhxBkbIyl55IFuqcA+XlYZIbegJwrUT0bzU
         vbFcw3uAlHrh1XjA1YGAlwD4JF1FhoDXN6kktxiHLPQ/kxPW9X/6OyYBur0s1Qc9qAwV
         TR4WTZ+BLi8gFuYS+RJnpMB4riixiCdma+IQc1PTNgDCj8xj9g6M7CuZqDtviTWYhwHa
         47qzktxzW9JbiEASGEu4yW6NLDLLS3+gsNK3PHy/smSUYb8BVEhl73Mo5151tXCruROY
         dcIA==
X-Gm-Message-State: AOAM532zxYMJG/U0JM6zmQWli95VtN8QiftpAAS0sb6MC9sk9SL6cCnO
        DZwoNCwAI1ymk/zWia2mb/vspg==
X-Google-Smtp-Source: ABdhPJyziM+jU2CP/scXclsOHRPb3/N2euGeSuQyyVzMYnEcr7sfXfrF3dKUwXlkXO8UJjb7A1j1Lw==
X-Received: by 2002:a17:90b:41d5:: with SMTP id jm21mr3919360pjb.96.1589558636642;
        Fri, 15 May 2020 09:03:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lj12sm1913431pjb.21.2020.05.15.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:03:55 -0700 (PDT)
Date:   Fri, 15 May 2020 09:03:54 -0700
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
Subject: Re: [PATCH 1/4] hung_task: Move hung_task sysctl interface to
 hung_task_sysctl.c
Message-ID: <202005150902.9293E99B8@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
 <202005150103.6DD6F07@keescook>
 <b72e0721-d08a-0fef-f55d-eb854483d04f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72e0721-d08a-0fef-f55d-eb854483d04f@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 04:56:34PM +0800, Xiaoming Ni wrote:
> On 2020/5/15 16:04, Kees Cook wrote:
> > On Fri, May 15, 2020 at 12:33:41PM +0800, Xiaoming Ni wrote:
> > > Move hung_task sysctl interface to hung_task_sysctl.c.
> > > Use register_sysctl() to register the sysctl interface to avoid
> > > merge conflicts when different features modify sysctl.c at the same time.
> > > 
> > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > ---
> > >   include/linux/sched/sysctl.h |  8 +----
> > >   kernel/Makefile              |  4 ++-
> > >   kernel/hung_task.c           |  6 ++--
> > >   kernel/hung_task.h           | 21 ++++++++++++
> > >   kernel/hung_task_sysctl.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++
> > 
> > Why a separate file? That ends up needing changes to Makefile, the
> > creation of a new header file, etc. Why not just put it all into
> > hung_task.c directly?
> > 
> > -Kees
> > 
> But Luis Chamberlain's suggestion is to put the hung_task sysctl code in a
> separate file. Details are in https://lkml.org/lkml/2020/5/13/762.
> I am a little confused, not sure which way is better.

Ah, yes, I see now. Luis, I disagree with your recommendation here -- I
think complicating the Makefile is much less intuitive than just
wrapping this code in an #ifdef block in the existing .c file.

-- 
Kees Cook
