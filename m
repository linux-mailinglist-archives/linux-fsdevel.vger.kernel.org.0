Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30BE12A7EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLYMyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 07:54:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37261 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfLYMyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 07:54:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so9126238wru.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2019 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jIham/EaCFEKkl8fK1a+ksAmrlxt3rRnwMRIAl1SXmI=;
        b=c8Zo8NEkJAvJVAWWv5++cFMFFPdQeZL0z/4iuG82ihnv+eFKk7q7quHsPKpqN6wGkK
         Dh1LzXFczxl7GD2iDyWdUx9BegFuBu1KkVBX5AiU7EsZLDk3+Aiq2OT5L3+bmCvb7Asa
         QMuwcpCubHeTZzkJe3UvMWtGkNigXRJh8J6Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jIham/EaCFEKkl8fK1a+ksAmrlxt3rRnwMRIAl1SXmI=;
        b=sKFJmbf/a7sr5SMwkXjhw+cSYayzyME+MQGcviIbYYh7DYtnRptDSwtjL1JMLaeMBO
         MwmmnvlqEQpx8XpZKQVyx+d7sYuX66OB/+oFs1hvTxEyv7jbXRlfdj/IJ4OXk2Y1bxR0
         vPfnrx/ZECoPW/OFmccDRDTnFxvNkF1XWZD5TdV7Qj0Ranle8BgE+DuXkJnRJ/S6rTMC
         Qc1gav0LgFESsSEntEz+XkTxySa+4rO4nlrGLm3rHDaUlSAiShf7al3nCOBFxTkdl9Bg
         PxoNauEnLjp8licVuYiIblUjmi20fAZBwMeDr4k1koTKfG845TZ2x0qhzHFBlsvRZycj
         ImIA==
X-Gm-Message-State: APjAAAX/dsXfOblL2BS6RlWgCDFSipniRSb3J5aWhiL9jy/We/rzQqcG
        g7liItmAHGiCf1e+ff5AMArrPA==
X-Google-Smtp-Source: APXvYqwp/mzSu8ZKoccwp/On7rTa48JnGRUaw5JCWV7XKfHi+/dOSDBDwJKdUU5R8dYXI5jJdjXsfA==
X-Received: by 2002:adf:c145:: with SMTP id w5mr40394878wre.205.1577278490981;
        Wed, 25 Dec 2019 04:54:50 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id v83sm5590825wmg.16.2019.12.25.04.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 04:54:50 -0800 (PST)
Date:   Wed, 25 Dec 2019 12:54:48 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "zhengbin (A)" <zhengbin13@huawei.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191225125448.GA309148@chrisdown.name>
References: <20191220024936.GA380394@chrisdown.name>
 <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name>
 <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
 <20191220164632.GA26902@bombadil.infradead.org>
 <CAOQ4uxhYY9Ep1ncpU+E3bWg4ZpR8pjvLJMA5vj+7frEJ2KTwsg@mail.gmail.com>
 <20191220195025.GA9469@bombadil.infradead.org>
 <20191223204551.GA272672@chrisdown.name>
 <CAOQ4uxjm5JMvfbi4xa3yaDwuM+XpNOSDrbVsHvJtkms00ZBnAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjm5JMvfbi4xa3yaDwuM+XpNOSDrbVsHvJtkms00ZBnAg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein writes:
>> The slab i_ino recycling approach works somewhat, but is unfortunately neutered
>> quite a lot by the fact that slab recycling is per-memcg. That is, replacing
>> with recycle_or_get_next_ino(old_ino)[0] for shmfs and a few other trivial
>> callsites only leads to about 10% slab reuse, which doesn't really stem the
>> bleeding of 32-bit inums on an affected workload:
>>
>>      # tail -5000 /sys/kernel/debug/tracing/trace | grep -o 'recycle_or_get_next_ino:.*' | sort | uniq -c
>>          4454 recycle_or_get_next_ino: not recycled
>>           546 recycle_or_get_next_ino: recycled
>>
>
>Too bad..
>Maybe recycled ino should be implemented all the same because it is simple
>and may improve workloads that are not so MEMCG intensive.

Yeah, I agree. I'll send the full patch over separately (ie. not as v2 for 
this) since it's not a total solution for the problem, but still helps somewhat 
and we all seem to agree that it's overall an uncontroversial improvement.

>> Roman (who I've just added to cc) tells me that currently we only have
>> per-memcg slab reuse instead of global when using CONFIG_MEMCG. This
>> contributes fairly significantly here since there are multiple tasks across
>> multiple cgroups which are contributing to the get_next_ino() thrash.
>>
>> I think this is a good start, but we need something of a different magnitude in
>> order to actually solve this problem with the current slab infrastructure. How
>> about something like the following?
>>
>> 1. Add get_next_ino_full, which uses whatever the full width of ino_t is
>> 2. Use get_next_ino_full in tmpfs (et al.)
>
>I would prefer that filesystems making heavy use of get_next_ino, be converted
>to use a private ino pool per sb:
>
>ino_pool_create()
>ino_pool_get_next()
>
>flags to ino_pool_create() can determine the desired ino range.
>Does the Facebook use case involve a single large tmpfs or many
>small ones? I would guess the latter and therefore we are trying to solve
>a problem that nobody really needs to solve (i.e. global efficient ino pool).

Unfortunately in the case under discussion, it's all in one large tmpfs in 
/dev/shm. I can empathise with that -- application owners often prefer to use 
the mounts provided to them rather than having to set up their own. For this 
one case we can change that, but I think it seems reasonable to support this 
case since using a single tmpfs can be a reasonable decision as an application 
developer, especially if you only have unprivileged access to the system.

>> 3. Add a mount option to tmpfs (et al.), say `32bit-inums`, which people can
>>     pass if they want the 32-bit inode numbers back. This would still allow
>>     people who want to make this tradeoff to use xino.
>
>inode32|inode64 (see man xfs(5)).

Ah great, thanks! I'll reuse precedent from those.

>> 4. (If you like) Also add a CONFIG option to disable this at compile time.
>>
>
>I Don't know about disable, but the default mode for tmpfs (inode32|inode64)
>might me best determined by CONFIG option, so distro builders could decide
>if they want to take the risk of breaking applications on tmpfs.

Sounds good.

>But if you implement per sb ino pool, maybe inode64 will no longer be
>required for your use case?

In this case I think per-sb ino pool will help a bit, but unfortunately not by 
an order of magnitude. As with the recycling patch this will help reduce thrash 
a bit but not conclusively prevent the problem from happening long-term. To fix 
that, I think we really do need the option to use ino_t-sized get_next_ino_full 
(or per-sb equivalent).

Happy holidays, and thanks for your feedback!

Chris
