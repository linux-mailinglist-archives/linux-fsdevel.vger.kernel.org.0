Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8763F250548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHXRNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgHXRNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:13:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A77C061573;
        Mon, 24 Aug 2020 10:13:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o12so3433971qki.13;
        Mon, 24 Aug 2020 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GaHc2bZckrs8e79oDtFVB7aLWMuGUzPJWwj4xMv5ZQ0=;
        b=sACWAqxr/VwqSbPYqQIyY1frS1wWBS77a9KLyRsBUtLvjhHrsnouo257CI/pZAU3NE
         HUToM7TEMwjOrJ5fQ8PE7xoK3iL68yjtoax+Fn1Bz/MIMoK1Pmdg1aWH2M5Zx5gbc5Nj
         vHMMGR6V44/vv023nXAYwemwySEZ1tzxw8Iu9QY/xZQ03pWZPdrL1LZGRv6aMAHv8dY8
         cWv9WjHc10HWc9Rjgfnt8zBZcMgIUFhQRNTFt/LqcqxFq3Anq8QSqkS+FSrTGsYc6/1J
         n438QmKE/gclk0V8c6ow5eP7xWRsU4Ldw1v/6UpgJvn//xaVZG2cTGULug7GOI42Ee+l
         bBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GaHc2bZckrs8e79oDtFVB7aLWMuGUzPJWwj4xMv5ZQ0=;
        b=nssSjNSsugSR5DIcYKKGA49UO2GzPm8rqFM7qjPdz090Zc3qry6CvZkj0IONAZ3PHn
         YLpDZEuQeQK2Ri1BfyaceDcTghTlah6Cg0waxJ5S6V+d/d8GUBMZjLl3zMrVIlFeulij
         IBqC34ow7ck+FheEqdhvWuT4P90Ch241JIwf3/qM7cVFQFHidTZtzy1jg8TPZDbQeoyO
         pvKsu2CPg+kOoyiCxT3kuyOtYqGdReyn4S3Mm1JsTRr9ccQcK1kArRXEgKs0psByEB/3
         GOTcFArpsl9Q/h8i5LO4j44ad3qMu5sSCW8WvSyjHPYIqH34ithfQz56LEbyUqaFvhs9
         0IFg==
X-Gm-Message-State: AOAM532FReTpB97lsv2LWi9wVhIK+eOt4YvPfeow/gMvX7vHv0vbb12g
        4XA3lxcoyPVUiMbHPQxLE5M=
X-Google-Smtp-Source: ABdhPJxc+U0rwjsBE0g1+LJf3/921SQAlSClVRIUiNYJqVYKUNV6pzhfvMBdGRGx2YYHZo6QUvCcrQ==
X-Received: by 2002:a37:8301:: with SMTP id f1mr5473168qkd.86.1598289197871;
        Mon, 24 Aug 2020 10:13:17 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:dd21])
        by smtp.gmail.com with ESMTPSA id f189sm9839624qke.15.2020.08.24.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:13:17 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:13:14 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] mm: support nesting memalloc_use_memcg()
Message-ID: <20200824171314.GA17113@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20200824153607.6595-1-schatzberg.dan@gmail.com>
 <20200824153607.6595-3-schatzberg.dan@gmail.com>
 <20200824161901.GA2401952@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824161901.GA2401952@carbon.lan>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:19:01AM -0700, Roman Gushchin wrote:
> Hi Dan,
> 
> JFYI: I need a similar patch for the bpf memory accounting rework,
> so I ended up sending it separately (with some modifications including
> different naming): https://lkml.org/lkml/2020/8/21/1464 .
> 
> Can you please, rebase your patchset using this patch?
> 
> I hope Andrew can pull this standalone patch into 5.9-rc*,
> as Shakeel suggested. It will help us to avoid merge conflicts
> during the 5.10 merge window.
> 
> Thanks!

Yeah I mentioned it in the cover letter and linked to your patch. I
had not realized the naming change, so I can rebase on top of that -
I'll wait to see if there's other feedback first.
