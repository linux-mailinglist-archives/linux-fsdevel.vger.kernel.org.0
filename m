Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F237412A92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 03:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhIUBoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhIUBkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:40:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8160C0818CE;
        Mon, 20 Sep 2021 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D26fSnJLbC9XZDfSrbIUPFGxJqUcYaE49d48YeAtGx8=; b=NBcRJuW96wCs2L5yciBjnu4F4c
        Rn9oYNN1r/1pdLA61JWi8mSh2jw4C197H6PxcOg2RORNnVp0NHy3B2/mVwzXnkDgC9Bnt9SFoFpZq
        E4HHHEzgLP5+gHSOKUS4bEvDYdobZ6BKb8IOsWWpInVAuyr0pBgxnJp8SXIHvvLfeLKukmB80eL+B
        HOWdqQdII79WYdIrZ/4XgmeMgjaGc0llYrEViO4WDCrlrjRY4sBOgcW6IYtgGedGJUZuTpyw49ERA
        cKp1wpEFy0klyQ3ztACi2tVfmneinCUyDoVWNGLeZRw814u7MRUpuq5zDgDHzlfmHeRjcjSf8u/Nl
        pMB4G/bw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSR4j-003CEI-VS; Mon, 20 Sep 2021 21:43:45 +0000
Date:   Mon, 20 Sep 2021 14:43:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, rdunlap@infradead.org, rafael@kernel.org,
        masahiroy@kernel.org, ndesaulniers@google.com, yzaikin@google.com,
        nathan@kernel.org, ojeda@kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, vitor@massaru.org,
        elver@google.com, jarkko@kernel.org, glider@google.com,
        rf@opensource.cirrus.com, stephen@networkplumber.org,
        David.Laight@aculab.com, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, daniel.vetter@ffwll.ch, bhelgaas@google.com,
        kw@linux.com, dan.j.williams@intel.com, senozhatsky@chromium.org,
        hch@lst.de, joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YUkAkSUQtUZvNvTu@bombadil.infradead.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-10-mcgrof@kernel.org>
 <6db06c27-e3af-b0aa-6f38-9c31dd8194fa@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db06c27-e3af-b0aa-6f38-9c31dd8194fa@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:36:38PM -0700, Bart Van Assche wrote:
> On 9/17/21 10:04 PM, Luis Chamberlain wrote:
> > A sketch of how this can happen follows:
> > 
> > CPU A                              CPU B
> >                                     whatever_store()
> > module_unload
> >    mutex_lock(foo)
> >                                     mutex_lock(foo)
> >     del_gendisk(zram->disk);
> >       device_del()
> >         device_remove_groups()
> > 
> > In this situation whatever_store() is waiting for the mutex foo to
> > become unlocked, but that won't happen until module removal is complete.
> > But module removal won't complete until the sysfs file being poked
> > completes which is waiting for a lock already held.
> 
> If I remember correctly I encountered the deadlock scenario described
> above for the first time about ten years ago while working on the SCST
> project. We solved this deadlock by removing the sysfs attributes from
> the module unload code before grabbing mutex_lock(foo), e.g. by calling
> sysfs_remove_file().

Well the sysfs attributes in zram do tons of funky mucking around so
unfortunately no. It's not the only driver where this can happen. It is
why I decided to work on a generic solution instead.

> This works because calling sysfs_remove_file()
> multiple times in a row is safe. Is that solution good enough for the
> zram driver?

The sysfs attributes are group attributes part of the block, and so are
removed for the driver on a del_gendisk(). So unfortunately no, this
would not be a good solution in this case.

  Luis
