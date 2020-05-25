Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E531E0F73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbgEYN0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390609AbgEYN0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 09:26:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C9C061A0E;
        Mon, 25 May 2020 06:26:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j16so4629611wrb.7;
        Mon, 25 May 2020 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MP6DRNEuCMRyiUZleYcforgbKGB3a+zep0oAe43tg2I=;
        b=fvrBvY4ibEdQQM5pF6/IquSIewV5ZavHaNrfE1JSOhz1kwkuaWt5LjmZc8u4KzkR0O
         ccXuCuaUZHp3sPZM/3LCQMlxk0RCjGSpgBMsBx1i/rYSc8/OHkTul3XcBYnPwxkv8Pg5
         64xnojveJsctzcQQzoCNIYbVF5+Vy5DvN8rtlL92/HgCVAQ11A+wP5WyvfFzRne5eHNJ
         q1uQzJ5UpG4k72AodRlyhlpsyiaP9fB4vCl1dTUnGv2vlDl1BKLYP1tp9nUw7V2yBjCM
         uRt51NuJUfFTu+whDAMZ7GUe5UAfvO1aiSuNw6uQcjyBhyK1aPTHn+Ea+uyUZQhviM3W
         j1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MP6DRNEuCMRyiUZleYcforgbKGB3a+zep0oAe43tg2I=;
        b=l1pf+RKJb3k8g/YLXflX21KGmXl+aFRlZOxbwhAMbOaIOElliSES5Er+3KZqAxCFa+
         dype1zpcY2nu5vuvgMXwbMMS2JkdR2pgXSnB+D1QAyJNwt7KtoNrsswu5CKFVkm0QJyc
         FCp6s3u1jEYDZg9Ltemq41SJRK6m+wseJI2lUhJAMPMuzWHqldVbIMXd2ts4DB4b+l6P
         UxdXgt5BvBSGbKNc6nJ4USh3INH/2JANXWLufO/a8GETkbESQmpuR5648h6PTM0NC25r
         dK1MrkbSWsa4/kT14lHk1BlzKl+WGRAR6F2lbDzJ/2iKmVRMNca9mKb51XHEXCC3SAG1
         /XMQ==
X-Gm-Message-State: AOAM530ue/S/WaHJrHrg95TQ1A7IkRsrD7V2VXmFxjqDfEqTxuX6ZfNm
        t3kI0es3VHEZJdqEfweF4Nk=
X-Google-Smtp-Source: ABdhPJwYR19qizr+nnGBgvRXxEom4sWziXWEWb5qxZbh+w1tAiIwUp6ASTljA50PM/sQpOkzPSr/WA==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr15962530wrp.338.1590413169128;
        Mon, 25 May 2020 06:26:09 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r6sm20363405wmh.1.2020.05.25.06.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 06:26:08 -0700 (PDT)
Date:   Mon, 25 May 2020 15:26:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] radix-tree: Use local_lock for protection
Message-ID: <20200525132606.GB3066456@gmail.com>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-3-bigeasy@linutronix.de>
 <20200525062954.GA3180782@gmail.com>
 <20200525111114.GB17206@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525111114.GB17206@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, May 25, 2020 at 08:29:54AM +0200, Ingo Molnar wrote:
> > > +void radix_tree_preload_end(void)
> > > +{
> > > +	local_unlock(&radix_tree_preloads.lock);
> > > +}
> > > +EXPORT_SYMBOL(radix_tree_preload_end);
> > 
> > Since upstream we are still mapping the local_lock primitives to
> > preempt_disable()/preempt_enable(), I believe these uninlining changes should not be done
> > in this patch, i.e. idr_preload_end() and radix_tree_preload_end() should stay inline.
> 
> But radix_tree_preloads is static, and I wouldn't be terribly happy to
> see that exported to modules.

Well, it seems a bit silly to make radix_tree_preload_end() a 
standalone function, on most distro kernels that don't have 
CONFIG_PREEMPT=y, preempt_enable() is a NOP:

 0000000000002bf0 <radix_tree_preload_end>:
     2bf0:       c3                      retq   

I.e. we'd be introducing a separate function call for no good reason.

Thanks,

	Ingo
