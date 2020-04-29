Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE21BD241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2C1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgD2C1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:27:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501EDC035493
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 19:27:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o10so679235qtr.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 19:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j2BqRPlqFlKV+qbCocfSi2x/JssbK9MFgCKLqYpp14M=;
        b=yIS7iHAsJKIugA/8A/w12xYgJlTB3URYy1+zVBuG/07z9SfuYhVCBj5PiJkT0Sl+ji
         cXf8c1c1kahDA3yAOtTmKXArjKHd14VfmKaMdkMTPmYUTGT9rsh59FKalKFxHpPk83j/
         6h5k65Ipm/JdoKcB0TayOyf566CF1TYMAnhztvxsSe+BwiBqA3qd2wd4dPDUqUbXZhpF
         uHbegIniPpIGde6atAbSiqkWT/YfgXbyfmFXEoZf/A4Dbl49g/JVdbycBygXIQdXrWsS
         7yHAyDqE2Kg2ihWZShc7QF2VtZtp/xOzHOrit4A75A9vYuKtIEkgUrnHDttEgHdPRgAE
         B1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2BqRPlqFlKV+qbCocfSi2x/JssbK9MFgCKLqYpp14M=;
        b=PLsn5VWSLAcPlNMK9c8vLPcTGCEy3jKgMTXxZJOtJS/5Mi1FPugp4wUtz5zTFmlnR4
         v0abgz0+KPu4FBIljDtrnUfykxqoscCHM8rURTAaT+1gTzSuF5HB5R4QKDRcilvmAcTW
         pJvu93x2PyL8Pnc2WFMM0R94bN/apENIaBDhCasuN7C58CKGUop9ri2VEcYFkmMbjtAN
         onEGewdCVRlUmyvLjgXGu0DmHxaba6VQpDl1qsuFlnzZYIDpYbxt5CW5d89ueOI0BEJr
         OlhZIcdRINyhes1BRy6gJ62QxFUzos5oRenff+ao0NUrtPtGccSOYqM49JDT+lpoXR4g
         w+Lg==
X-Gm-Message-State: AGi0PuaGOKDuEVkb97WOrBCTFzC6djGt2OTEw2/L41mb1XzIM5s2jr/I
        0uIdHmY+oHMezKT8QDlWo5ENow==
X-Google-Smtp-Source: APiQypLsEKenWN4WzB6ddMhGOd0xHUK1mWQIdZD+RG622mVERdaN6cZAXO8dAWWRsrXwQyIKvlFoGA==
X-Received: by 2002:ac8:4ccc:: with SMTP id l12mr31941572qtv.129.1588127263372;
        Tue, 28 Apr 2020 19:27:43 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s190sm5345219qkh.23.2020.04.28.19.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 19:27:42 -0700 (PDT)
Date:   Tue, 28 Apr 2020 22:27:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200429022732.GA401038@cmpxchg.org>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428214653.GD2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:47:34AM +1000, Dave Chinner wrote:
> On Tue, Apr 28, 2020 at 12:13:46PM -0400, Dan Schatzberg wrote:
> > This patch series does some
> > minor modification to the loop driver so that each cgroup can make
> > forward progress independently to avoid this inversion.
> > 
> > With this patch series applied, the above script triggers OOM kills
> > when writing through the loop device as expected.
> 
> NACK!
> 
> The IO that is disallowed should fail with ENOMEM or some similar
> error, not trigger an OOM kill that shoots some innocent bystander
> in the head. That's worse than using BUG() to report errors...

Did you actually read the script?

It's OOMing because it's creating 256M worth of tmpfs pages inside a
64M cgroup. It's not killing an innocent bystander, it's killing in
the cgroup that is allocating all that memory - after Dan makes sure
that memory is accounted to its rightful owner.

As opposed to before this series, where all this memory isn't
accounted properly and goes to the root cgroup - where, ironically, it
could cause OOM and kill an actually innocent bystander.
