Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495837BC2B1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 00:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjJFW7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 18:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJFW7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:59:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E793;
        Fri,  6 Oct 2023 15:59:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so25802475e9.0;
        Fri, 06 Oct 2023 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696633174; x=1697237974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4kjcUaoav85BgSvtv1BA6kawwG45pQg/poo37oA9DU=;
        b=CHVUJKD0Dl4dwKYGau1J7VJHj+JNgOwkvDdJdUkdCh6ae55I7zFJfgl7ph6eqti17C
         FlPP2OHgW3bvS42i984ScLtdwO7LgRdbBUXHMsKGssVx7EF/OmJxFAurHe8ZPjqbmLRG
         4/un+IvaCreSb9LEI4WDOlbkaQMQY63xfoeYjKFd4kF+UAL0n+11XquHO604JSm8vanr
         xbd2rKJ0U0+AeYWf9DLiG52kGWYlJRneMM32mOn+qdd5AuZw9VOooEGkVCAMZZ18u+Gw
         ur80dd5DZtelXbPeUyGm6OnzfEu6bRJKNWTPwWHktGXODR6/xlu871jFWtSAFdR6ZiCc
         NypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696633174; x=1697237974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4kjcUaoav85BgSvtv1BA6kawwG45pQg/poo37oA9DU=;
        b=uMcETZlpobCE2BS4bSNXp2k38bQmQAw4hpnn0zI5GxjL08KTCXkqjOPXOAcvyQNdxg
         POMwydIasQl9RAlcgW44gCGehzShyD2lrItdHf8ZD4yXZbhSxPmnerA4I+ON8IonnTkI
         mez8wqek9cYo/AO2PiOynQYek35QSdFWF1lIMEvpE2AYJ7D88dTIO12mk9r0KEZnct7T
         mp1q4V9LJCz+RQmAKHQNnCLvC5xw2/2rTzrAEbE2q/G+2ignJ3YLyMsLiel6B5C28QS1
         JKKkGMGVxfko+O0ctbYMzdbQSGsmC+FJ9cP0eypDZAa78uIoNu8yx8p76AxEMg5/00nI
         ioTA==
X-Gm-Message-State: AOJu0YzBZn2nlUmLtmOgXkKfqWL57beL+uBH+9W+X+4/fF3OLWPS0qsi
        SPdHa4y8tEOQTtK/uSqh1ZbSt6sGVrVnFTUxFMQ=
X-Google-Smtp-Source: AGHT+IGGwAEzUi1vGrqfSHucnhnxYAKWrFPtL6Ez8wKd/cxxlGuXqAv5ZREH5fqYGsW8nA600wYPxQ==
X-Received: by 2002:adf:f9cc:0:b0:320:1c7:fd30 with SMTP id w12-20020adff9cc000000b0032001c7fd30mr8011763wrr.17.1696633173942;
        Fri, 06 Oct 2023 15:59:33 -0700 (PDT)
Received: from snowbird (host86-164-181-115.range86-164.btcentralplus.com. [86.164.181.115])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm2565811wrp.116.2023.10.06.15.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:59:33 -0700 (PDT)
Date:   Fri, 6 Oct 2023 15:59:31 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Chen, Tim C" <tim.c.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
Message-ID: <ZSCRU/e1dwMftYLC@snowbird>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
 <DM6PR11MB4107F132CC1203486A91A4DEDCCAA@DM6PR11MB4107.namprd11.prod.outlook.com>
 <17877ef1-8aac-378b-94-af5afa2793ae@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17877ef1-8aac-378b-94-af5afa2793ae@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, Oct 05, 2023 at 10:42:17PM -0700, Hugh Dickins wrote:
> On Thu, 5 Oct 2023, Chen, Tim C wrote:
> 
> > >--- a/lib/percpu_counter.c
> > >+++ b/lib/percpu_counter.c
> > >@@ -278,6 +278,59 @@ int __percpu_counter_compare(struct
> > >percpu_counter *fbc, s64 rhs, s32 batch)  }
> > >EXPORT_SYMBOL(__percpu_counter_compare);
> > >
> > >+/*
> > >+ * Compare counter, and add amount if the total is within limit.
> > >+ * Return true if amount was added, false if it would exceed limit.
> > >+ */
> > >+bool __percpu_counter_limited_add(struct percpu_counter *fbc,
> > >+				  s64 limit, s64 amount, s32 batch) {
> > >+	s64 count;
> > >+	s64 unknown;
> > >+	unsigned long flags;
> > >+	bool good;
> > >+
> > >+	if (amount > limit)
> > >+		return false;
> > >+
> > >+	local_irq_save(flags);
> > >+	unknown = batch * num_online_cpus();
> > >+	count = __this_cpu_read(*fbc->counters);
> > >+
> > >+	/* Skip taking the lock when safe */
> > >+	if (abs(count + amount) <= batch &&
> > >+	    fbc->count + unknown <= limit) {
> > >+		this_cpu_add(*fbc->counters, amount);
> > >+		local_irq_restore(flags);
> > >+		return true;
> > >+	}
> > >+
> > >+	raw_spin_lock(&fbc->lock);
> > >+	count = fbc->count + amount;
> > >+
> > 
> > Perhaps we can fast path the case where for sure
> > we will exceed limit? 
> > 
> > if (fbc->count + amount - unknown > limit)
> > 	return false;
> 
> Thanks, that sounds reasonable: I'll try to add something like that -
> but haven't thought about it carefully enough yet (too easy for me
> to overlook some negative case which messes everything up).
> 
> Hugh
>

Sorry for the late chime in. I'm traveling right now.

I haven't been super happy lately with percpu_counter as it has had a
few corner cases such as the cpu_dying_mask fiasco which I thought we
fixed with a series from tglx [1]. If not I can resurrect it and pull
it.

I feel like percpu_counter is deviating from its original intended
usecase which, from my perspective, was a thin wrapper around a percpu
variable. At this point we seem to be bolting onto percpu_counter
instead of giving it a clear focus for what it's supposed to do well.
I think I understand the use case, and ultimately it's kind of the
duality where I think it was xfs is using percpu_counters where it must
be > 0 for the value to make sense and there was a race condition with
cpu dying [2].

At this point, I think it's probably better to wholy think about the
lower bound and upper bound problem of percpu_counter wrt the # of
online cpus.

Thanks,
Dennis

[1] https://lore.kernel.org/lkml/20230414162755.281993820@linutronix.de/
[2] https://lore.kernel.org/lkml/20230406015629.1804722-1-yebin@huaweicloud.com/
